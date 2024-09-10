Return-Path: <linux-kernel+bounces-322714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81678972CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0C11C2118F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76918787C;
	Tue, 10 Sep 2024 09:00:26 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B3016A957;
	Tue, 10 Sep 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958826; cv=none; b=AQtyz8xoNLqMpF+W4rQQUFHZnx6Jz3bWWUsm5lrnR0y57TxGl34YGnY7nZyvgQPOSLmslSkNlAEPcDaxLqC6nuhXV4hP+a3vXNxGf7mKkavi5XJ8zdQgRC/6u3tZER5WwvFV/be5BeIoAsG5Bh6YXKGhtKvEGmtiB/LuDUMp98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958826; c=relaxed/simple;
	bh=R/6lvEGnan2GdVeJmJT9ipw0THIFlDnuJcz377UswX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hInACrg4L7JMRbBebanvVFceQIqUyFPX++q8dLXYKwjAEGGTmS11lRj063CNZYFQII9kXik9qqsvtlEF/XAVokubWgIgeYnZM91WL3hlCBaw7K2N9CyLPC1+RrquOqc0m5LcWTRwt3zKkiIecbC8iqNndtzz3up2QKfQW0nxY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266e00aa18f1-4a8f9;
	Tue, 10 Sep 2024 17:00:17 +0800 (CST)
X-RM-TRANSID:2ee266e00aa18f1-4a8f9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee466e00aa00da-843b0;
	Tue, 10 Sep 2024 17:00:17 +0800 (CST)
X-RM-TRANSID:2ee466e00aa00da-843b0
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: rui.silva@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] usb: isp1760: Use devm_kcalloc
Date: Tue, 10 Sep 2024 15:26:42 +0800
Message-Id: <20240910072642.39396-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Use devm_kcalloc to simplify code.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/usb/isp1760/isp1760-hcd.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 0e5e4cb74c87..593ce841ae53 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -2572,18 +2572,18 @@ int isp1760_hcd_register(struct isp1760_hcd *priv, struct resource *mem,
 
 	priv->hcd = hcd;
 
-	priv->atl_slots = kcalloc(mem_layout->slot_num,
+	priv->atl_slots = devm_kcalloc(dev, mem_layout->slot_num,
 				  sizeof(struct isp1760_slotinfo), GFP_KERNEL);
 	if (!priv->atl_slots) {
 		ret = -ENOMEM;
 		goto put_hcd;
 	}
 
-	priv->int_slots = kcalloc(mem_layout->slot_num,
+	priv->int_slots = devm_kcalloc(dev, mem_layout->slot_num,
 				  sizeof(struct isp1760_slotinfo), GFP_KERNEL);
 	if (!priv->int_slots) {
 		ret = -ENOMEM;
-		goto free_atl_slots;
+		goto put_hcd;
 	}
 
 	init_memory(priv);
@@ -2597,16 +2597,12 @@ int isp1760_hcd_register(struct isp1760_hcd *priv, struct resource *mem,
 
 	ret = usb_add_hcd(hcd, irq, irqflags);
 	if (ret)
-		goto free_int_slots;
+		goto put_hcd;
 
 	device_wakeup_enable(hcd->self.controller);
 
 	return 0;
 
-free_int_slots:
-	kfree(priv->int_slots);
-free_atl_slots:
-	kfree(priv->atl_slots);
 put_hcd:
 	usb_put_hcd(hcd);
 	return ret;
@@ -2619,6 +2615,4 @@ void isp1760_hcd_unregister(struct isp1760_hcd *priv)
 
 	usb_remove_hcd(priv->hcd);
 	usb_put_hcd(priv->hcd);
-	kfree(priv->atl_slots);
-	kfree(priv->int_slots);
 }
-- 
2.33.0




