Return-Path: <linux-kernel+bounces-192099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12718D185E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF481F23F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186F16C691;
	Tue, 28 May 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eTYE/3jd"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58916B72D;
	Tue, 28 May 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891637; cv=none; b=If2ACMpu5ziaeTqZHjWelRMf3GxMz8ibP9/kWvrgnE9GWvX6lDyY7YrpmvDIS12yeXUR2cnpdgztDKH07KRvYw6xuqb2BCvByT09yn6sQrXVn2l6+V0MghCPNH37tFVMAKCDW1J+C5/ey1W86aW9ZprHfqzp6yDm/JyzKEA2SNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891637; c=relaxed/simple;
	bh=lMCM/A3Z7snAmnLzSGIr7jM7SrSUs1WYwlorRMK6qr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRCmAOXLQ1j4TJb3ruORDeWyrKxlmRqoiGeRjyadpI3QvqefQXdZjpJioi/V+7IP0Qo1eSiEK06gD009qzD/2LMCP63RR/WsOfSYCojADev76tB+Qgr2stU5d/F5pXamGV5jLuUJTqOv2C4hzrpn8Q44BTXHl0+CA/S+XgrUgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eTYE/3jd; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B72CF240006;
	Tue, 28 May 2024 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716891634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsG4a+QexdrWaD9z2b31NrWRE7fUVEl7ydWLvlxj0hU=;
	b=eTYE/3jdhGs5GEmTPLjC0zOErFPdwpIx6cL82ctXvsH22SFUCPeUB17Hsoo6/SHf3kkiGV
	xdIxWufJv5otteYpxjkhpbOtucCY8cv0tNs9Sh8y7dYGQ3dbK8ZNbqcGdieCedb9ahbkvd
	aDpqUPn5El7xZnIcCjS9tP7Eu+ggm2v68DEssTyT8Qd9DkmQOnSzfixwG8faZ8q9Lo6ttz
	BH+PPK/KQu5/mI1pXUnZSdZaiMfhPJRXQlJZndR1ekCy8Gsbvl9KRbq5J6kxE9oXCIhouS
	5AeZZ1ekOh28JdrPbzkQdZwA253A0j3QMDjQkZsmHwSRkRNyga/HxfCMAJOMeQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 4/4] usb: musb: da8xx: Implement BABBLE recovery
Date: Tue, 28 May 2024 12:20:26 +0200
Message-ID: <20240528102026.40136-5-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528102026.40136-1-bastien.curutchet@bootlin.com>
References: <20240528102026.40136-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

There is no specific behaviour implemented to recover from a babble
error. When a BABBLE error happens, recovery fails as connected sticks
are no longer detected by the USB controller.

Implement the recover callback of the MUSB operation to reset the USB
controller when a BABBLE happens.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/usb/musb/da8xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index c5cf733673a2..fcf06dcf2d61 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -220,6 +220,13 @@ static void __maybe_unused da8xx_musb_try_idle(struct musb *musb, unsigned long
 	mod_timer(&musb->dev_timer, timeout);
 }
 
+static int da8xx_babble_recover(struct musb *musb)
+{
+	dev_dbg(musb->controller, "resetting controller to recover from babble\n");
+	musb_writel(musb->ctrl_base, DA8XX_USB_CTRL_REG, DA8XX_SOFT_RESET_MASK);
+	return 0;
+}
+
 static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
 {
 	struct musb		*musb = hci;
@@ -480,6 +487,7 @@ static const struct musb_platform_ops da8xx_ops = {
 #ifndef CONFIG_USB_MUSB_HOST
 	.try_idle	= da8xx_musb_try_idle,
 #endif
+	.recover	= da8xx_babble_recover,
 
 	.set_vbus	= da8xx_musb_set_vbus,
 };
-- 
2.44.0


