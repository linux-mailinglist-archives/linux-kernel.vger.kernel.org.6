Return-Path: <linux-kernel+bounces-245534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C892B406
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715441F23291
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFFE155759;
	Tue,  9 Jul 2024 09:38:34 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F32155399;
	Tue,  9 Jul 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517913; cv=none; b=UTh2+8TTPStJYIjQkjZRqofdD2z4r/NKyBT0dmOusuZ/h5ybe0BBKXhuV40cVN8dSplJRey6qNMIM7j1CsvwvWe/2iG3BWPLECIUJ/Sq4uNz6673emdKBR6a0BPjm+ebeMvdYzNBV1UbapK4CcJwev/eGiQw2IHCd387xevTuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517913; c=relaxed/simple;
	bh=IvpU8Pn6r0Sfompii+NMy87uGHYacO5fWxcaFnlZ7Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dmPCeXpfwuECv8zReCtXPRQ+NGtluqozNhsn1oDzsK1LqhZ/DvEaxWLGpnsjNt14IUJTdIXLyps22UnU9iwerFJanDxFqu4XcnwpByiu28qNhJNEhF+KhTiiaTAo54bPcOEl1XX0HcwSUIV8Q/jVB3EsQloqmxsNexWhGxPHGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693a1.dsl.pool.telekom.hu [::ffff:81.182.147.161])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007142C.00000000668D03E4.0016EC73; Tue, 09 Jul 2024 11:33:19 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 1/4] platform/x86: ideapad-laptop: use cleanup.h
Date: Tue,  9 Jul 2024 11:33:05 +0200
Message-ID: <851d4180f1df5a10ca6e2feaf429611f1c0ccc88.1720515666.git.soyer@irl.hu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720515666.git.soyer@irl.hu>
References: <cover.1720515666.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Use cleanup.h helpers to simplify some code paths.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 71 ++++++++++++---------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index fcf13d88fd6e..1ace711f7442 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -13,6 +13,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
@@ -204,7 +205,7 @@ static int ideapad_shared_init(struct ideapad_private *priv)
 {
 	int ret;
 
-	mutex_lock(&ideapad_shared_mutex);
+	guard(mutex)(&ideapad_shared_mutex);
 
 	if (!ideapad_shared) {
 		ideapad_shared = priv;
@@ -214,19 +215,15 @@ static int ideapad_shared_init(struct ideapad_private *priv)
 		ret = -EINVAL;
 	}
 
-	mutex_unlock(&ideapad_shared_mutex);
-
 	return ret;
 }
 
 static void ideapad_shared_exit(struct ideapad_private *priv)
 {
-	mutex_lock(&ideapad_shared_mutex);
+	guard(mutex)(&ideapad_shared_mutex);
 
 	if (ideapad_shared == priv)
 		ideapad_shared = NULL;
-
-	mutex_unlock(&ideapad_shared_mutex);
 }
 
 /*
@@ -840,36 +837,33 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 	unsigned long output;
 	int err;
 
-	err = mutex_lock_interruptible(&dytc->mutex);
-	if (err)
-		return err;
-
-	if (profile == PLATFORM_PROFILE_BALANCED) {
-		/* To get back to balanced mode we just issue a reset command */
-		err = eval_dytc(priv->adev->handle, DYTC_CMD_RESET, NULL);
-		if (err)
-			goto unlock;
-	} else {
-		int perfmode;
-
-		err = convert_profile_to_dytc(profile, &perfmode);
-		if (err)
-			goto unlock;
+	scoped_guard(mutex_intr, &dytc->mutex) {
+		if (profile == PLATFORM_PROFILE_BALANCED) {
+			/* To get back to balanced mode we just issue a reset command */
+			err = eval_dytc(priv->adev->handle, DYTC_CMD_RESET, NULL);
+			if (err)
+				return err;
+		} else {
+			int perfmode;
+
+			err = convert_profile_to_dytc(profile, &perfmode);
+			if (err)
+				return err;
+
+			/* Determine if we are in CQL mode. This alters the commands we do */
+			err = dytc_cql_command(priv,
+					       DYTC_SET_COMMAND(DYTC_FUNCTION_MMC, perfmode, 1),
+					       &output);
+			if (err)
+				return err;
+		}
 
-		/* Determine if we are in CQL mode. This alters the commands we do */
-		err = dytc_cql_command(priv, DYTC_SET_COMMAND(DYTC_FUNCTION_MMC, perfmode, 1),
-				       &output);
-		if (err)
-			goto unlock;
+		/* Success - update current profile */
+		dytc->current_profile = profile;
+		return 0;
 	}
 
-	/* Success - update current profile */
-	dytc->current_profile = profile;
-
-unlock:
-	mutex_unlock(&dytc->mutex);
-
-	return err;
+	return -EINTR;
 }
 
 static void dytc_profile_refresh(struct ideapad_private *priv)
@@ -878,9 +872,8 @@ static void dytc_profile_refresh(struct ideapad_private *priv)
 	unsigned long output;
 	int err, perfmode;
 
-	mutex_lock(&priv->dytc->mutex);
-	err = dytc_cql_command(priv, DYTC_CMD_GET, &output);
-	mutex_unlock(&priv->dytc->mutex);
+	scoped_guard(mutex, &priv->dytc->mutex)
+		err = dytc_cql_command(priv, DYTC_CMD_GET, &output);
 	if (err)
 		return;
 
@@ -1809,11 +1802,11 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
 	struct ideapad_wmi_private *wpriv = dev_get_drvdata(&wdev->dev);
 	struct ideapad_private *priv;
 
-	mutex_lock(&ideapad_shared_mutex);
+	guard(mutex)(&ideapad_shared_mutex);
 
 	priv = ideapad_shared;
 	if (!priv)
-		goto unlock;
+		return;
 
 	switch (wpriv->event) {
 	case IDEAPAD_WMI_EVENT_ESC:
@@ -1847,8 +1840,6 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
 
 		break;
 	}
-unlock:
-	mutex_unlock(&ideapad_shared_mutex);
 }
 
 static const struct ideapad_wmi_private ideapad_wmi_context_esc = {
-- 
2.45.2


