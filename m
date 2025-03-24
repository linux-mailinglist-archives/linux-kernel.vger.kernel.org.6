Return-Path: <linux-kernel+bounces-574095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75909A6E07F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E93316ABD3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6D5264627;
	Mon, 24 Mar 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RCTRxrRt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC473263F40;
	Mon, 24 Mar 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835868; cv=none; b=l42lbfnKRgk+ADUHsPVaYM+nn7gYi4qfq66JKx2eu8yPlvxGnln/s6WKoIYQ7RPcXI2EnQi3nkz4hYBCefDramOreyQlLajuyr9nGeMCNcnA/ELZJRo2YKjGeFr7UryFKVg2m8j1mTP2oqo02AVafbu4SoGX7xgm3QAcuzbOBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835868; c=relaxed/simple;
	bh=Z1D9b/aDklkV/w1jDdHJ0QT0NlOJuOAq6fuu6adnAX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjHM6HSYZqXUDUir4Smf939Mv8UEVaC10b3dtTePmvO0tFG3xZKU/g1y90WoCrrwmpLX/yjOHIYwlBmZSwyCUUloBHOxaqoAvB4WCY+pVIh5hVfiw0Pw0V0VQX5qcZlSgEXKEuqRM4QcRXZ1kbiLoHViyOZfCGlxh4CKXFQ27io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RCTRxrRt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742835863;
	bh=Z1D9b/aDklkV/w1jDdHJ0QT0NlOJuOAq6fuu6adnAX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RCTRxrRtcqyjnzZbZJxyNPhS3zz0EDcj4dHkNReppdgRJmRS/TkTSpuITq+qifDQZ
	 21PMGBVLQ0N/yb30qqkzp1SALU5SkUUGr/GYptGL848tRW71dn38mk7sqZ2S1cYpwH
	 CrxDpa3C2iW+tGku0eESeVxQMiZVfycnPOtbaTYFdOT4+PywpshGOoIS8Y3RoXOhUb
	 4OrvzVRG3Sl6w/CTqWtPuHt6TGA30GxoxKijZKB/fb2r1swbCuTF4tYHUp9jJEZMZc
	 0Dg41JeLlk7NDE2Mbak+m+Qw98uMnp0Ikz4skvSCHPu9sna4hOodLeJ8THRK5fDqnu
	 QQPcFctnVxPSw==
Received: from jupiter.universe (dyndsl-091-248-188-184.ewe-ip-backbone.de [91.248.188.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B8A317E0B9D;
	Mon, 24 Mar 2025 18:04:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D779B480037; Mon, 24 Mar 2025 18:04:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 24 Mar 2025 18:04:23 +0100
Subject: [PATCH 2/5] arm64: dts: rockchip: move rock 5b to include file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-rock5bp-for-upstream-v1-2-6217edf15b19@kernel.org>
References: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
In-Reply-To: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3778; i=sre@kernel.org;
 h=from:subject:message-id; bh=Z1D9b/aDklkV/w1jDdHJ0QT0NlOJuOAq6fuu6adnAX4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGfhkJZwAq2N9fnfh21CieN/Jfy7/q5h02WRO
 qr7EplupgmG5okCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJn4ZCWAAoJENju1/PI
 O/qaSMoQAJ0Tn5Do38EbDJ08eAFM6r9GiVzR0ma0pIDj7kdnFcgEZDTNWEQfsZn2HVgD7bnKUAZ
 7U9j3odFs3HMmcc1HYHkx/iEUYvpc5sl+9i3YtivSEa0GK84dAJs1DrFlS+6hTvy3ATvAogGDp2
 gn/tf2cPvLj5ZI/Qx1FT5nY50efyQ6NstPilFeioZLn/rNWAFqCf/udl2rLe1m7ovBvSnFunW3i
 rjqabbRwcKMRy9QLM9qvBSmrKqvxJnwlJP2GiGpvofNvoaxcj3sLe/bqKCL4w76RI4FuF9bVy/U
 Jzj/BFU3OCsWhxQ/qJLLch8JT55nxGkY1J8yBrZhxX7rVG8ftCCHbSjO8v3W2gHWRYRAhCrVZ6q
 O7eejooYeqKr/spWlm6J4UZ7cUbi+2xzLva9eM2jAXnKgdj4ls/rX4IS+SKlguLT/tp8CWGvN1p
 qvwxubRWO+ABDn6Bte1FtfkGJuzTb1K/kV4tHWpRjvL5Vxg1B847OJZBPb9hJDvYeFB4AvLu8jJ
 QdK9fk7YrHgH90sAjh90qoDFTutQjbg/uK6+Fae0i/bckBvWDtx/t2SYDdTRxYPS71pG6QlJ2cV
 4uFMQ3OzlcYUTsFsAN7HSBh05F5Sc8fXcvZiaRgTnWpPow1xq2Nj9Tx/s87xz71B2g/Y2x0AEJ6
 rGHx379F4nLA26Ndl1PE2VA==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Radxa released some more boards, which are based on the original
Rock 5B. Move its board description into an include file to avoid
unnecessary duplication.

NOTE: this should be merged with the previous commit to ensure
bisectability. The rename happens in a separete commit during
development because git does not properly detect the rename when
the original filename is reused in the same commit. This means

1. it's a lot harder to review the changes
2. it's a lot harder to rebase the patch series

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts  | 52 ++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi | 34 ----------------
 2 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
new file mode 100644
index 0000000000000000000000000000000000000000..9407a7c9910ada1f6c803d2e15785a9cbd9bd655
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588-rock-5b.dtsi"
+
+/ {
+	model = "Radxa ROCK 5B";
+	compatible = "radxa,rock-5b", "rockchip,rk3588";
+};
+
+&sdio {
+	max-frequency = <200000000>;
+	no-sd;
+	no-mmc;
+	non-removable;
+	bus-width = <4>;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	wakeup-source;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_pcie2x1l0>;
+	vqmmc-supply = <&vcc_1v8_s3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdiom0_pins>;
+	status = "okay";
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart6m1_xfer &uart6m1_ctsn &uart6m1_rtsn>;
+	status = "okay";
+};
+
+&pinctrl {
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&vcc5v0_host {
+	enable-active-high;
+	gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc5v0_host_en>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi
index d22068475c5dc6cb885f878f3f527a66edf1ba70..dccb8492f9f0632abd96c3dafc723e01491abad5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi
@@ -8,9 +8,6 @@
 #include "rk3588.dtsi"
 
 / {
-	model = "Radxa ROCK 5B";
-	compatible = "radxa,rock-5b", "rockchip,rk3588";
-
 	aliases {
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
@@ -139,10 +136,6 @@ vcc5v0_host: regulator-vcc5v0-host {
 		regulator-always-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_host_en>;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
@@ -530,27 +523,6 @@ &sdmmc {
 	status = "okay";
 };
 
-&sdio {
-	max-frequency = <200000000>;
-	no-sd;
-	no-mmc;
-	non-removable;
-	bus-width = <4>;
-	cap-sdio-irq;
-	disable-wp;
-	keep-power-in-suspend;
-	wakeup-source;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	vmmc-supply = <&vcc3v3_pcie2x1l0>;
-	vqmmc-supply = <&vcc_1v8_s3>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdiom0_pins>;
-	status = "okay";
-};
-
 &sfc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim2_pins>;
@@ -565,12 +537,6 @@ flash@0 {
 	};
 };
 
-&uart6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart6m1_xfer &uart6m1_ctsn &uart6m1_rtsn>;
-	status = "okay";
-};
-
 &spi2 {
 	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;

-- 
2.47.2


