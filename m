Return-Path: <linux-kernel+bounces-335675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C1B97E8FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CC92821E0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77021953BD;
	Mon, 23 Sep 2024 09:43:51 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0D194C73;
	Mon, 23 Sep 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084631; cv=none; b=tM//J6yUKUfUAmCj0kfL9L6QXMCKcYVcVGW1zhSgC208BT8w2rL26eYVpS5bnqY58MIIJ0VqSjXr/4JiioG8mJru3ZIofByLL9ELjtPgCc5DgtIl6ZuLFxFnM9WNkOkWK70yceWnGcNlolzv8DiO0QUDMnUQGzbw+nGZQymEyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084631; c=relaxed/simple;
	bh=S1RDW8E+jrGemHwlIllDHHXmo3oFL16UuyspS6mKUGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqHl60w1pOZflVtYFP/exB71lXsjP+XODNWOhHRAOg9xCqplrYnW3t4530vdIX8kmh5syWEzLg60PHYtNrLVa3dlFV/WtJTHQCYq6V5uAZDdReoZm9YyjPsfE8pWHybzzmcVAWJCEtJBkSXh3nVwVDt+u7EyIJn77Pqen0RyXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 51592c42799011efa216b1d71e6e1362-20240923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:71b1cabe-2475-479f-9c9a-4f4f42837c3d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:81c1c7032e608bb5b35a8c6f26bfef55,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 51592c42799011efa216b1d71e6e1362-20240923
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1570017647; Mon, 23 Sep 2024 17:43:41 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B284CE0080FF;
	Mon, 23 Sep 2024 17:43:41 +0800 (CST)
X-ns-mid: postfix-66F1384D-6238841212
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id 04CFFE0080FF;
	Mon, 23 Sep 2024 17:43:40 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: linux@armlinux.org.uk,
	robh@kernel.org,
	saravanak@google.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] amba: Add dev_is_amba() function and export it for modules
Date: Mon, 23 Sep 2024 17:42:47 +0800
Message-ID: <20240923094249.80399-2-chentao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923094249.80399-1-chentao@kylinos.cn>
References: <20240923094249.80399-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add dev_is_amba() function to determine
whether the device is a AMBA device.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/amba/bus.c       | 6 ++++++
 include/linux/amba/bus.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 0230c43377c1..8ef259b4d037 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -449,6 +449,12 @@ const struct bus_type amba_bustype =3D {
 };
 EXPORT_SYMBOL_GPL(amba_bustype);
=20
+bool dev_is_amba(const struct device *dev)
+{
+	return dev->bus =3D=3D &amba_bustype;
+}
+EXPORT_SYMBOL_GPL(dev_is_amba);
+
 static int __init amba_init(void)
 {
 	return bus_register(&amba_bustype);
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index dda2f3ea89cb..9946276aff73 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -121,6 +121,7 @@ extern const struct bus_type amba_bustype;
 #ifdef CONFIG_ARM_AMBA
 int __amba_driver_register(struct amba_driver *, struct module *);
 void amba_driver_unregister(struct amba_driver *);
+bool dev_is_amba(const struct device *dev);
 #else
 static inline int __amba_driver_register(struct amba_driver *drv,
 					 struct module *owner)
@@ -130,6 +131,10 @@ static inline int __amba_driver_register(struct amba=
_driver *drv,
 static inline void amba_driver_unregister(struct amba_driver *drv)
 {
 }
+static inline bool dev_is_amba(const struct device *dev)
+{
+	return false;
+}
 #endif
=20
 struct amba_device *amba_device_alloc(const char *, resource_size_t, siz=
e_t);
--=20
2.43.0


