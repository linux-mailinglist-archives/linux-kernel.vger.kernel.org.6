Return-Path: <linux-kernel+bounces-279466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FFF94BD9C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F19B23C07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1018D18C327;
	Thu,  8 Aug 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFMsK8qV"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390E18CBEB;
	Thu,  8 Aug 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120535; cv=none; b=oc7QF2OVzZl6z0dwNrIw0OjUuFJwwIdbkYR5so1cMrjtTS5XtxkzK6L2EivmuVnaAc+hX4y9pBOIfJ0S97ycjL6vDgepMY5X5IWkM41eZdm+DLjrtoBkl5ABgPVOInh2y240lp/TIm1WKykW0UWyXjZVUNTUyQIR+Hw0oj2DqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120535; c=relaxed/simple;
	bh=NtHW0DWgDPWkvsCBc3ZSxcmIVuZUoDEhgm4EUJaymK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe+fYSLTODEdf6tC6OwRnbA7pFpSUvyacVPxAudjXI1bBVxEXuZUhsBZEnrV25YtCbsKNYSu+l8kkM0lA2n2ey8Ga7OHZgsx1s9lGVxNBcte3F9D7Kx5+AHcPkySiG9FzvQJ6cYab1iAfcy9h5T2ibYraDvCJiykjPzgC7qoN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFMsK8qV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso9303791fa.1;
        Thu, 08 Aug 2024 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120532; x=1723725332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL2NFbu/GDcNXSp9bTUdpTQcWr52zC29uyev+697YWk=;
        b=IFMsK8qVhO+gCjbhYgPe0hR+xL9Ql7hdeG6r1b/QkZv10xpF8EpJ2i9M6mUEbgb1sL
         64QVsZ4bDLiLxapgtDnGU8pECaFZTjYu1PAozEWBIZlDnKmqg5kNeR1JhyBj8NHkipk7
         onpWcImmD9whuvj1bIhFrcUtw91mMHQ8SFWLpIG7NOMETVWHLOPbeLoAcGVp/55QCogi
         Pwqvsv6WDvhQE/xubxICoaa2YxJNGn4pAglmi3r4vshj2AjzQCon6maudysRRYyaY76D
         ejbZJhZ72mNcGiRFqYO4HPg8euuMNZF1sI3UJhv4bFJw/7Ve7PJTu33Sz0fyWGeD3mU2
         pHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120532; x=1723725332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL2NFbu/GDcNXSp9bTUdpTQcWr52zC29uyev+697YWk=;
        b=irPVmEnVVcef5YeI1HcYZt39OzjH0jeTC5MttqpvBy4nkiDHH85xFHUJdjXXcp47Ze
         K9tQ0m08Jc0vmp5HcoQ78xtkM7hW1+exLAV73uqcT+Uzl5Pq76uEz2czK82blJmpr/1/
         5iEupONDisEJJ+SCaAPy/IRPMd9Az9uRu1SWu+IqCtsS4MISRlu/AUCV/yrMacMsRwbo
         1F3Zj8zo3TnwwaBh6zdzhfZOgq/gKKadtx43+3A3zPETGyTZwPDnokjtO4pTtYp5Njuz
         0gGABaX9cDhlg+Zg6tgp92SRZm7iVhLlzS4e7RRXMpa3wROjxeOWLpaP2Fs5F5bx7Wh7
         K+kA==
X-Forwarded-Encrypted: i=1; AJvYcCWgBAwgiv8XoqQETphpqEajSiRvpeic0nQtR0T4qoRbw6DZuQbDkK14DuTL1ufKnzuL4pf3OytN0Hdv6q16p3zviKvzXhRZuz13BCSj
X-Gm-Message-State: AOJu0YwWtJEHcNx6R1Tf+xMzj9yG5ZzkURDf2IXeKEsM2uwvMzXRpUdk
	kc4ejN4+bVaoCXRtSAB3bGLWb4jn8lAbPy0Nzt9R+k/3AxG64xhX
X-Google-Smtp-Source: AGHT+IGaS2HuBJ5tJ5zsvNq9z1ORbE0V9h5qcKUy5D8gSxJO2JMzcc2RtMCmFeyAhyrRiqvrqVvpvQ==
X-Received: by 2002:a05:651c:507:b0:2ef:1f51:c4f2 with SMTP id 38308e7fff4ca-2f19de2a220mr13859381fa.14.1723120531131;
        Thu, 08 Aug 2024 05:35:31 -0700 (PDT)
Received: from yoga-710.tas.nnz-ipc.net ([178.218.200.115])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e17e835sm21072261fa.21.2024.08.08.05.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:35:30 -0700 (PDT)
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
Subject: [PATCH 2/2] arm64: dts: rockchip: add USB-C port 1 to OK3588-C
Date: Thu,  8 Aug 2024 17:33:54 +0500
Message-ID: <20240808123354.260797-3-dmt.yashin@gmail.com>
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

Add support for TypeC1 found on Forlinx OK3588-C. Powering the board
using this port is not supported, so set power-role to source.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 .../boot/dts/rockchip/rk3588-ok3588-c.dts     | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
index 1b6bfa2b1a69..c71fbf3562b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
@@ -113,6 +113,18 @@ vbus5v0_typec0: vbus5v0-typec0-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	vbus5v0_typec1: vbus5v0-typec1-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus5v0_typec1";
+		enable-active-high;
+		gpio = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&typec5v_1_pwren>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -286,6 +298,51 @@ &i2c5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c5m2_xfer>;
 
+	usbc1: usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PB3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc1_int>;
+		vbus-supply = <&vbus5v0_typec1>;
+
+		usb_con1: connector {
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
+					usbc1_hs: endpoint {
+						remote-endpoint = <&usb_host1_xhci_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					usbc1_ss: endpoint {
+						remote-endpoint = <&usbdp_phy1_typec_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					usbc1_sbu: endpoint {
+						remote-endpoint = <&usbdp_phy1_typec_sbu>;
+					};
+				};
+			};
+		};
+	};
+
 	pcf8563: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
@@ -413,9 +470,17 @@ typec5v_0_pwren: typec5v-0-pwren {
 			rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
+		typec5v_1_pwren: typec5v-1-pwren {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		usbc0_int: usbc0-int {
 			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
+
+		usbc1_int: usbc1-int {
+			rockchip,pins = <1 RK_PB3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
 	};
 };
 
@@ -454,6 +519,14 @@ &u2phy0_otg {
 	status = "okay";
 };
 
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -493,6 +566,29 @@ usbdp_phy0_typec_sbu: endpoint@1 {
 	};
 };
 
+&usbdp_phy1 {
+	mode-switch;
+	orientation-switch;
+	sbu1-dc-gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy1_typec_ss: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc1_ss>;
+		};
+
+		usbdp_phy1_typec_sbu: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usbc1_sbu>;
+		};
+	};
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
@@ -519,3 +615,14 @@ &usb_host1_ehci {
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&usb_host1_xhci {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb_host1_xhci_drd_sw: endpoint {
+			remote-endpoint = <&usbc1_hs>;
+		};
+	};
+};
-- 
2.39.2


