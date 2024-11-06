Return-Path: <linux-kernel+bounces-398264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E39BED2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F441C23F38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3641F81AD;
	Wed,  6 Nov 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UThJZYRW"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1B1F4705;
	Wed,  6 Nov 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898213; cv=none; b=XG93l3yZmN+HQVudPCbpUoCyugaOpzZZUYndckAhvGcG8kdB0paD80qGPC0r844FzmM3WlYlnOnjffarfq6oCms+p6j/yojx37aQmLScFZK4YmpEcj1zFZ06QqIAwfmwLGD7N9no33/FnCAIS9GBXQe+lvJdV0GObMTb038ssC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898213; c=relaxed/simple;
	bh=7giponiOuQq1rzvl3AEox8TcdeVJ+n6H0wGGzfIDkAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LFkRlQwx0yOenPoLVraASdshLHmz1ItKjtGMDBm1MQuvpLyLoLy+/gzx31NuxaZ+PcTeLqnsvhcq4jIOWPURCkzwWs9O69oA8nWFE3aohf+GOqaFHyC27jcB73+2287lBBrzRSZ8IQZn2DqKhW9fQFtJA/D9skS2Hk0kasyDWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UThJZYRW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9ec86a67feso119065366b.1;
        Wed, 06 Nov 2024 05:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730898210; x=1731503010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkhTqMAEy+wfKt4c1zlkHxKZoS9y22psXlk3N9SJC2I=;
        b=UThJZYRWKYvwK7MzM8Ja1d0U4Cy6oqVIPdmDNsh7BfCt6HC3c9iQ3zqpY+gby2keMs
         woqv1XedHUguHOwIdtmpO6a5Vcne2Cl+jU8tEnFsITnJPzq5xgukHIFjurZM6f68ghuh
         pP729198EG+uPquhUwrMR79oQQ6+J8Cc6QIN13g2mWo7ynmBa/LkZ+LeZ+Y0Wur8jIyy
         Tk/8yFPNKSE3giUVGLpdrXHY32798Dn16+YW9vrOlbflL2cvztnDHOzTdzyrAjsod9yQ
         K5Pk/+q1RNrQCzQyzuITqDwnImRqjQMO7Sv3m2Lf05ncUC1ByE8sfdq1b75+b3sdXtjn
         M1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730898210; x=1731503010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkhTqMAEy+wfKt4c1zlkHxKZoS9y22psXlk3N9SJC2I=;
        b=vGcMeNhTW/UARAL6578WzQPKCpWixomsobFgyEIAKoJDu0AON7NfTagWU4P1u2Y5wl
         naz2seV/BQDdnoJiYhzo1ilQShsjnroE9GvepqJ8/E3fpHZ0ao3x2FxxhxmjYSA0ps07
         qqJCDxOymKMQOFv3w2eC8gso8oMo100JkkAj+lHzvQszd8ae06muA4cVv9sednmLVGi2
         asCBGUwo+PCLd4lUvz/qg/JszdEJJC3Do8a+alQNW7BZ+Bh4lrBm4VSvPe+EWOTTgwjS
         0ZzX7Owdy16MvBA7LFYksbmsqadNous5HLAYqNkep18lTXn92toOiVNnlcFMN5lRr1Hk
         KcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBP1v2S2DDI2q2OHHYRGCyJOhG6GfxDyFAWLYXSc0Sn0tii+ynAz3p1+IFZRPcYlEtNyY//01uhSF+@vger.kernel.org, AJvYcCWbWCtlqdzEsM04ZjjmtKkpHTzHpnbEGpQKOQR0kz0NEzfXXA6ngvq8g4z/kYOt0+d95M8ITNXHSdFrag7I@vger.kernel.org
X-Gm-Message-State: AOJu0YycxQHCIm7i3LMYKGllzoUEBKvmD8yf8tWsCGqUxB395kTFDH2a
	NL5BD95lzrDUK83HMT74Rflzyn3xmaZBWUQCVPJwFYJ+2Dp1s8r0
X-Google-Smtp-Source: AGHT+IEqBTEWgsrzkfZOna1FwJf1E2BQ8X3eInejzxvLIxEo2OwtK5vRIp0mlLmeUW8b3wBaksf0Kg==
X-Received: by 2002:a17:906:db0d:b0:a9a:129a:1862 with SMTP id a640c23a62f3a-a9de61a17cemr4108748466b.60.1730898209309;
        Wed, 06 Nov 2024 05:03:29 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a4836sm279603666b.11.2024.11.06.05.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 05:03:28 -0800 (PST)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
	John Clark <inindev@gmail.com>,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: enable USB3 on NanoPC-T6
Date: Wed,  6 Nov 2024 14:03:13 +0100
Message-Id: <20241106130314.1289055-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the USB3 port on FriendlyELEC NanoPC-T6.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index bf8e1f1116d1..b93c2590feb5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -171,6 +171,20 @@ vbus5v0_typec: vbus5v0-typec-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	vbus5v0_usb: vbus5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb5v_pwren>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "vbus5v0_usb";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -607,6 +621,10 @@ typec5v_pwren: typec5v-pwren {
 			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
+		usb5v_pwren: usb5v_pwren {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		usbc0_int: usbc0-int {
 			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
@@ -1005,6 +1023,14 @@ &u2phy0_otg {
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
 &u2phy2_host {
 	status = "okay";
 };
@@ -1044,6 +1070,11 @@ usbdp_phy0_typec_sbu: endpoint@1 {
 	};
 };
 
+&usbdp_phy1 {
+	phy-supply = <&vbus5v0_usb>;
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
@@ -1064,6 +1095,11 @@ usb_host0_xhci_drd_sw: endpoint {
 	};
 };
 
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
-- 
2.25.1


