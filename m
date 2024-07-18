Return-Path: <linux-kernel+bounces-256085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 291769348C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA871B219CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399ED7710C;
	Thu, 18 Jul 2024 07:28:04 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526D5FB8A;
	Thu, 18 Jul 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287683; cv=none; b=aq/WzETaQ4L/dYzQt7agGi1conL+n61VdqG/AlpgFUT0KllqLeEf7tD356oseXCtzKZsKbLosao/g3sonFYjphsq+v9Xfr38MQnXvVO6WrNAU+iC3GKtfWlFYV2To94wro84dtjYgNXtKzjkLGJLkObsVAdbud+AbLdi7okkLJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287683; c=relaxed/simple;
	bh=AJElxP8fjMCAdCMtp0yqPsSdcYRXjuvYHRviUsC6dDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B/2BMMrySHd+VMF3b8jOCjd4sdBcKDYYv3qLWAHOvHVdysj9QLiPxONGbDLJpxncaL4xUPdIKMZttRC9zbVQSiPnjhRUSGjLn4MsgZ+g3+lzEpedETgHC7AI2lb8xDIbRvWa4DG4u0QpDnR+mUlrgQ88pf6cPY1yoVzAQltganY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.. (netacc-gpn-104-115-214.pool.yettel.hu [::ffff:91.104.115.214])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072DBB.000000006698C3FF.00180BA6; Thu, 18 Jul 2024 09:27:58 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 1/4] platform/x86: ideapad-laptop: introduce a generic notification chain
Date: Thu, 18 Jul 2024 09:27:13 +0200
Message-ID: <81d9772bd9093c8d22e492dc68ded2847a0cbf64.1721258854.git.soyer@irl.hu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721258854.git.soyer@irl.hu>
References: <cover.1721258854.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

There are several cases where a notification chain can simplify Lenovo
WMI drivers.

Add a generic notification chain into ideapad-laptop.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 37 +++++++++++++++++++++++++++
 drivers/platform/x86/ideapad-laptop.h |  5 ++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 88eefccb6ed2..e4d32a788339 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1498,6 +1498,39 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
 	priv->r_touchpad_val = value;
 }
 
+static int ideapad_laptop_nb_notify(struct notifier_block *nb,
+				    unsigned long action, void *data)
+{
+	switch (action) {
+	}
+
+	return 0;
+}
+
+static struct notifier_block ideapad_laptop_notifier = {
+	.notifier_call = ideapad_laptop_nb_notify,
+};
+
+static BLOCKING_NOTIFIER_HEAD(ideapad_laptop_chain_head);
+
+int ideapad_laptop_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&ideapad_laptop_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(ideapad_laptop_register_notifier, IDEAPAD_LAPTOP);
+
+int ideapad_laptop_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&ideapad_laptop_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(ideapad_laptop_unregister_notifier, IDEAPAD_LAPTOP);
+
+void ideapad_laptop_call_notifier(unsigned long action, void *data)
+{
+	blocking_notifier_call_chain(&ideapad_laptop_chain_head, action, data);
+}
+EXPORT_SYMBOL_NS_GPL(ideapad_laptop_call_notifier, IDEAPAD_LAPTOP);
+
 static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ideapad_private *priv = data;
@@ -1869,6 +1902,8 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	if (err)
 		goto shared_init_failed;
 
+	ideapad_laptop_register_notifier(&ideapad_laptop_notifier);
+
 	return 0;
 
 shared_init_failed:
@@ -1900,6 +1935,8 @@ static void ideapad_acpi_remove(struct platform_device *pdev)
 	struct ideapad_private *priv = dev_get_drvdata(&pdev->dev);
 	int i;
 
+	ideapad_laptop_unregister_notifier(&ideapad_laptop_notifier);
+
 	ideapad_shared_exit(priv);
 
 	acpi_remove_notify_handler(priv->adev->handle,
diff --git a/drivers/platform/x86/ideapad-laptop.h b/drivers/platform/x86/ideapad-laptop.h
index 4498a96de597..3eb0dcd6bf7b 100644
--- a/drivers/platform/x86/ideapad-laptop.h
+++ b/drivers/platform/x86/ideapad-laptop.h
@@ -12,6 +12,11 @@
 #include <linux/acpi.h>
 #include <linux/jiffies.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
+
+int ideapad_laptop_register_notifier(struct notifier_block *nb);
+int ideapad_laptop_unregister_notifier(struct notifier_block *nb);
+void ideapad_laptop_call_notifier(unsigned long action, void *data);
 
 enum {
 	VPCCMD_R_VPC1 = 0x10,
-- 
2.45.2


