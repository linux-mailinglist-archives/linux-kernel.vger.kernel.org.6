Return-Path: <linux-kernel+bounces-192101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3028D1862
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC9D1C226C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AD816C6B6;
	Tue, 28 May 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="evJjvDLs"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84215E96;
	Tue, 28 May 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891637; cv=none; b=NfKTf+VxNnOhGLe6XidrT3QveavZOo8z2/YjEVq8QhXyhF9DaasgKY5oQSz9ReHd22/kKLmsA86Vnj3RaTXd/YWVmlD4kUyYyDmbfAQNm2k2s6vkq2Tgk8R6XdWOoSa2ql/Z2K0H47A+HY6AdewtinhwpFKI0lrqOJHPwD3cMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891637; c=relaxed/simple;
	bh=3dxmjc0gq9Z1RscHVzOk2xvMOJ97HgvGI8PshdBRcow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTAkGV4v3P0ZlIPic26bYlLTBxy30auCd0tGaBMMP72L1CKpIQlaA/V2dy2d09pfgVVpvIQ2oSb6WSAlil6EF5RIubWiokCjv6m8lltdU0W+T68maDRyMXdpEsJT3/0nCO/K65XskCSSCRtym4vM/H41NZ++oNfBIdhvUJII5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=evJjvDLs; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7156F24000D;
	Tue, 28 May 2024 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716891632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTwcLrJlkxUwGcPOIejW240WhGdaw9D79sS7IYE/LmE=;
	b=evJjvDLsjaOsXLEPIROckcqKHLfMvST0zu/ozGJRnQ200CWCKNLpgPEt6wTC18UUEV30Mg
	Ot0zq+pucWx4rB4J/ejdlfGgU+0pH90LXn4CgL6NmTzKnE00aK28RxPmikOMLG66GvVGWB
	yfMfAXI/nVD/TVhXTPXpk9ONwNSvyRIef0T6FgHwr2VHcf2GfjvkIijtstXL0Thq3jNiQ/
	ydCAZHkL2GN2Ur55tpFEmPCHMqV27jt8nXsG7tbeAzju4fAOx3IijPxlV+YcCiMACu+bLA
	jydYKNs7qkSs/QPbrrz15AXz6INa9AnVKFUpUTaWqwoJpKeZx7ArZVB2xjJ11w==
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
Subject: [PATCH 2/4] Revert "usb: musb: da8xx: Set phy in OTG mode by default"
Date: Tue, 28 May 2024 12:20:24 +0200
Message-ID: <20240528102026.40136-3-bastien.curutchet@bootlin.com>
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

This reverts commit 7ccf62941a38701ec9a42b4a0fa2868af456e96a.

da8xx_musb_set_mode() forces OTG mode regardless the selected mode even
if the property 'dr_mode = "host"' is present in device-tree. This
causes an unrecoverable error when VBUS supply is shut down : plugged
gadgets are no longer detected once VBUS supply is back.

Reverting it allows to have a selected mode coherent with device-tree's
description. IMO, this shouldn't cause regression because OTG mode is
the default selection when 'dr_mode' property is not set.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/usb/musb/da8xx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 8abf3a567e30..1681f9fba3da 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -328,13 +328,6 @@ static int da8xx_musb_set_mode(struct musb *musb, u8 musb_mode)
 	struct da8xx_glue *glue = dev_get_drvdata(musb->controller->parent);
 	enum phy_mode phy_mode;
 
-	/*
-	 * The PHY has some issues when it is forced in device or host mode.
-	 * Unless the user request another mode, configure the PHY in OTG mode.
-	 */
-	if (!musb->is_initialized)
-		return phy_set_mode(glue->phy, PHY_MODE_USB_OTG);
-
 	switch (musb_mode) {
 	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
 		phy_mode = PHY_MODE_USB_HOST;
-- 
2.44.0


