Return-Path: <linux-kernel+bounces-409934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4669C9392
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844431F21DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CC1AD3E0;
	Thu, 14 Nov 2024 20:57:03 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A2193408;
	Thu, 14 Nov 2024 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617822; cv=none; b=AzJC6oJ4QhVOe5B0DzyKvi3ffPdBGF6zAJh4U/Yvi5ZW8GdlDHWwFg5rBIqsgj95Lq9rSBAm7ruFzBiB8rap8eHjvRNu10mmm0zwzfiv4KhPVkiCRn8bgWDCgQBfEvsS5un/e74r7fUrXyExiZv3DMWHPk9e4yFZBp3quWBrOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617822; c=relaxed/simple;
	bh=pedqJ4BxQwOi8OPwa+rQY5eP/9OAFJSpgb4K4mDfl/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qy2p8jjaMk0K9A9GNce89yBMuJhhmYlwLuF7sYL4n/6kdokdqpD34T6J4GHGzHgcDqLhMZWi9eS8hFM4fm/Qh8MZ41L8KW2mcdzEYNL7Uz55cw8YMUkE6+nIT+eXtSSLKza5eNzQyK0peOzoUNuAtqkLvrW2Qh2yUT8pBWPS4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id CC025B2283B7;
	Thu, 14 Nov 2024 21:47:10 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: E Shattow <e@freeshell.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: starfive: jh7110-milkv-mars: set host mode and vbus pin for on-chip USB 2.0
Date: Thu, 14 Nov 2024 12:13:40 -0800
Message-ID: <20241114201805.24143-2-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable host mode USB for Milk-V Mars by setting host mode and connect vbus 
pinctrl.

Note that testing this functionality depends on two features:

1.  commit e10c52e7e064038d9bd67b20bf4ce92077d7d84e "phy: starfive: 
jh7110-usb: Fix link configuration to controller"

2. Setting the USB over-current register to disable. This is done at 
bootloader phase, for example U-Boot: 
https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/

If the over-current register is not prepared for us then the result is no 
change in functional outcome with this patch applied; there is an error 
visible to the user and usb configuration fails (same as it is now).

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 0d248b671d4b..bddfc7c6b00f 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -53,7 +53,23 @@ &spi0 {
 	status = "okay";
 };
 
+&sysgpio {
+	usb_pins: usb0-0 {
+		driver-vbus-pin {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+};
+
 &usb0 {
-	dr_mode = "peripheral";
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb_pins>;
 	status = "okay";
 };
-- 
2.45.2


