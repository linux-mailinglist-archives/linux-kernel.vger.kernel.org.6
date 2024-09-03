Return-Path: <linux-kernel+bounces-312665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26906969989
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A731C233A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B971A3A9F;
	Tue,  3 Sep 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elrest.cz header.i=@elrest.cz header.b="B+zqkUzI"
Received: from smtp.cesky-hosting.cz (smtp.cesky-hosting.cz [91.239.200.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD181A0BC7;
	Tue,  3 Sep 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.200.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357157; cv=none; b=jHtxHfmjrN6gIVFwp8K1ou8R4HIPctOg0zZewzrCf5X4mlg9106XUJBt8FXwGSjrC004C4B+shJpdPFc945HL5T2GzTU7ZjTgD0Vxj8jl0BVP3nAAaBvDbMTO6XJEf65suTrpHmjNNoKQPL0XUpHhehwxGuNbU4CE96g+9H3dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357157; c=relaxed/simple;
	bh=ptodtkKagi9GVZPcHmohXhYM5PL23nadgiXtCIZaBWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UT77JCcLZiWO7l8qzsJFMK0KWO1AGYNdwgbktvzX0Y7BkHdx3DDCGvAlTEeC4KSyrpTvUmpCRBfBalMcjYH64fucgippP1C6e2c0rs7o+WwQrLcfkTQA/SRb5soWDyeNe98LK6+pW1EpNLq1rkbeioJAv/Ra88gdszqOPv9zSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elrest.cz; spf=pass smtp.mailfrom=elrest.cz; dkim=pass (2048-bit key) header.d=elrest.cz header.i=@elrest.cz header.b=B+zqkUzI; arc=none smtp.client-ip=91.239.200.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elrest.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elrest.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elrest.cz;
	s=rampa2-202408; t=1725356549;
	bh=ptodtkKagi9GVZPcHmohXhYM5PL23nadgiXtCIZaBWY=;
	h=From:To:Cc:Subject:Date:From;
	b=B+zqkUzIj4dl1sBQA6XLFQRTMSojYkiE3o54FVqroAyUpWC6lQw7pGC6oJKUnPS77
	 iWMV39Zwm6jty2zz6/nyn/pp32LtUyIzdQ4A3M1VGY/qrDqh7x6cLHkvkVaDI8IbXf
	 6BOVEbU2CXFAf7meLCjeruXzU1ebS+q0ISqcOiJ+D4H6vSo0u88SlgQ/jx2W0I4blc
	 T+6tOUxEBxJ3CcDv9DnIy/CHFIHj4Vy7NaDMruK4dNsShsRSTxnaFpE6f2MDCggtLM
	 ttTevh0+mIrd53tPDviAe/McPda81JsB8IGeSHlhGm5/wGeZbGkZYpb4ayrjb1uqAi
	 E1BgaL7Q++wRA==
X-Virus-Scanned: Debian amavis at smtp.cesky-hosting.cz
Received: from localhost.localdomain (unknown [185.63.98.16])
	(Authenticated sender: tomas.marek@elrest.cz)
	by smtp.cesky-hosting.cz (Postfix) with ESMTPSA id 4Wygdc3PS2z3Nw;
	Tue,  3 Sep 2024 11:42:28 +0200 (CEST)
From: Tomas Marek <tomas.marek@elrest.cz>
To: hminas@synopsys.com,
	gregkh@linuxfoundation.org
Cc: Arthur.Petrosyan@synopsys.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oleg.karfich@wago.com
Subject: [PATCH] usb: dwc2: drd: fix clock gating on USB role switch
Date: Tue,  3 Sep 2024 11:41:56 +0200
Message-Id: <20240903094156.6516-1-tomas.marek@elrest.cz>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dwc2_handle_usb_suspend_intr() function disables gadget clocks in USB
peripheral mode when no other power-down mode is available (introduced by
commit 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")).
However, the dwc2_drd_role_sw_set() USB role update handler attempts to
read DWC2 registers if the USB role has changed while the USB is in suspend
mode (when the clocks are gated). This causes the system to hang.

Release gadget clocks before handling the USB role update.

Fixes: 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")

Signed-off-by: Tomas Marek <tomas.marek@elrest.cz>
---
 drivers/usb/dwc2/drd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index a8605b02115b..ccb33cd1f04b 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -127,6 +127,18 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 			role = USB_ROLE_DEVICE;
 	}
 
+#if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
+	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
+	if (dwc2_is_device_mode(hsotg)) {
+		if (hsotg->lx_state == DWC2_L2) {
+			if (hsotg->params.power_down ==
+			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
+			    !hsotg->params.no_clock_gating)
+				dwc2_gadget_exit_clock_gating(hsotg, 0);
+		}
+	}
+#endif
+
 	if (role == USB_ROLE_HOST) {
 		already = dwc2_ovr_avalid(hsotg, true);
 	} else if (role == USB_ROLE_DEVICE) {
-- 
2.25.1


