Return-Path: <linux-kernel+bounces-279465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B442C94BD9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79DE1C22B62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C52518CBEA;
	Thu,  8 Aug 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEox0RC2"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829818C90E;
	Thu,  8 Aug 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120532; cv=none; b=hO8iBs8N0SXoO1BoM1RXRc/jb+L/olyLK1NGeG5lbfaOgJGwspM0haZdcq0uKQ2+Vc71Fqn8IflxuPfleMWIGwneits/r2Aji1cn+M2ETdS6pk0pcvzflust6eCQo0qIDtJMR+FKwFjKjE3tIudGoCGaq1y1Lt+ufagA/Wh5ZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120532; c=relaxed/simple;
	bh=KRaxaspBfdZ4ydPEPhxojrZLB7/ogPE8bcFDVQWzI/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIkKOCs1/TRyTEZqhnJX5IFUa/zIOiEZkHdphH7nlAn3VvBxSXpyrXJ4uEWjOhQxgIqydmFRCRl7VLmMDzUv2YGcaGm6oWLlYVrRc+1tyX6nSKxjgctmicnom5hed+JXxr2yNIb69OSPFziZn8eZYxu0jmO45AFFvz7SPzY3Hi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEox0RC2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f189a2a841so8385801fa.3;
        Thu, 08 Aug 2024 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120529; x=1723725329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o51ApZXd06V2AF7Cj1cTcf7Njt4h2SYssNskn2mHgBo=;
        b=cEox0RC25Ar8hIk36vXO1Qcym9HHPKL/MU0Rgat3Blj7RZ/LCe3Etfzu5Sn3gbPfuT
         e38Ydc07gqvbcuk9lVTVLSWvW3VeKYox+Ip2y9wXYhh9ItvC3znZByfmD1qAjkVSg3Id
         Rj9GBox9AHuwhbMK+51HzLI218d5KuwLShBDJRJ8S5SLL8hWqUObSK47ZSbl8l++AdPN
         HHUhKR0faiVGg1iU9qn38MJ5WcduEgGB6K8RmMfNEXCJTj35+/2AhreRyNG25VlDSGmi
         W2hdQDh9sz8Uz1LQLATCZLMsMF2JGwGgZhip95pKIuigYgpXinWTwldwIhSci/S5NQp9
         dqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120529; x=1723725329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o51ApZXd06V2AF7Cj1cTcf7Njt4h2SYssNskn2mHgBo=;
        b=wewsxryYLDuI+Ho94ixfBdl4NAOCJieabJvta/0keOv9e4sjoLp+rO06eX5PdtG2Nr
         hTniew3XQ2TAMMstqpbqWKnU1DrB2JXbIyNizcNq2JHjBVVSZvZgrmHWn1qxI1RQ9CL6
         DLfxOspzCPaoPXOHwZuB/FC/y1YbENKSI45JrgZjkLSez8DzHI3SejCCDjz6gCAS/T1j
         CdBA1VM8IPlV1xK6arq7HHGEedlV5WcwSvS5niFC1sxfBE1vQpV8O72RDPaoc9th0rRB
         3+rC7PY+Hodk7oz3zoW6FJqvcmPr824iWGrtl/88o1yeJW8GVVvOdBRaVYJ3Z7fZWeyH
         CadA==
X-Forwarded-Encrypted: i=1; AJvYcCVl/8Yj6IpjJmEQc1Q1CJmEAa9j5QtDfuRkGbpwNqPgRO6VDsfGxYUPKV8lOHHb0fT11rsbKwxSecuAwJ60pusM/oRC1JXlPvmpRi/y
X-Gm-Message-State: AOJu0YzKngxqKwkQoVsuwk8GRwqfIGe+qhZOynpK0EIgzVTB10Cxr/HN
	dwhwyBt/lntz7tQkq9juh95w28dbdzw9JiVEk30JRqaxMCvcBe9Ds1/v9w==
X-Google-Smtp-Source: AGHT+IHuJ1mXFaao+RTtKGJI076Uc/J+w7qZ8G+7L6MJuDnrylCAZ8V6ZvnmJwYgJRvBofjiysqXFw==
X-Received: by 2002:a2e:b887:0:b0:2ef:2eb9:5e55 with SMTP id 38308e7fff4ca-2f19de332e6mr13382161fa.13.1723120528722;
        Thu, 08 Aug 2024 05:35:28 -0700 (PDT)
Received: from yoga-710.tas.nnz-ipc.net ([178.218.200.115])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e17e835sm21072261fa.21.2024.08.08.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:35:28 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: add USB-C port 0 to OK3588-C
Date: Thu,  8 Aug 2024 17:33:53 +0500
Message-ID: <20240808123354.260797-2-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808123354.260797-1-dmt.yashin@gmail.com>
References: <20240808123354.260797-1-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TypeC0 found on Forlinx OK3588-C. Powering the board
using this port is not supported, so set power-role to source.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 .../boot/dts/rockchip/rk3588-ok3588-c.dts     | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
index c2a08bdf09e8..1b6bfa2b1a69 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 /dts-v1/;
+#include <dt-bindings/usb/pd.h>
 #include "rk3588-fet3588-c.dtsi"
 
 / {
@@ -100,6 +101,18 @@ masterdai: simple-audio-card,codec {
 		};
 	};
 
+	vbus5v0_typec0: vbus5v0-typec0-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus5v0_typec0";
+		enable-active-high;
+		gpio = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&typec5v_0_pwren>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -206,6 +219,51 @@ &gpu {
 &i2c2 {
 	status = "okay";
 
+	usbc0: usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc0_int>;
+		vbus-supply = <&vbus5v0_typec0>;
+
+		usb_con0: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "source";
+			source-pdos =
+				<PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					usbc0_hs: endpoint {
+						remote-endpoint = <&usb_host0_xhci_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					usbc0_ss: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					usbc0_sbu: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_sbu>;
+					};
+				};
+			};
+		};
+	};
+
 	tca6424a: gpio@23 {
 		compatible = "ti,tca6424";
 		reg = <0x23>;
@@ -349,6 +407,16 @@ tca6424a_int: tca6424a-int {
 			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	usb-typec {
+		typec5v_0_pwren: typec5v-0-pwren {
+			rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		usbc0_int: usbc0-int {
+			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
 };
 
 &pwm2 {
@@ -378,6 +446,14 @@ &tsadc {
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -394,6 +470,29 @@ &u2phy3_host {
 	status = "okay";
 };
 
+&usbdp_phy0 {
+	mode-switch;
+	orientation-switch;
+	sbu1-dc-gpios = <&gpio4 RK_PA0 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy0_typec_ss: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_ss>;
+		};
+
+		usbdp_phy0_typec_sbu: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usbc0_sbu>;
+		};
+	};
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
@@ -402,6 +501,17 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb_host0_xhci_drd_sw: endpoint {
+			remote-endpoint = <&usbc0_hs>;
+		};
+	};
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
-- 
2.39.2


