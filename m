Return-Path: <linux-kernel+bounces-518393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02551A38E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E597B1891B06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224F1A4F2F;
	Mon, 17 Feb 2025 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qTeQeRFq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DFC1AA795;
	Mon, 17 Feb 2025 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829430; cv=none; b=u4IzPKilwsMnA0jj+Xbw51YnTHJJDpeDaG1D7rtqct6V32vuBsp2AnHVd6MqMrgm/tyYvXXqpkmxf+tJvISoDlkiB0PT0hjhy0WSgrFQL1A82m/PjZjSSuWhsx2ogsBN3NlIddJABs+zM+DdO+o2RMxA4/UvgEtydU38hECIrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829430; c=relaxed/simple;
	bh=KjsFAJNPsUpS9IOJmQDPTg0Dnewekb+T8H0LWKWYzdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzDseQdTRAsuCy7+gsRXEVteUiYJiFoN5Dp7Vb/qvd0MisgMf9M3B/u6YKddxkCstO1+VKFg/J3DvmMGvn3BS6gqB/gt7tsYNH2FI+RE5/WyO8bxpLOGjNQ7KlYWM846FAdGlLQ7msOjw40dM1elvvWbOfhgLE6q9aQFeSJ1sIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qTeQeRFq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739829426;
	bh=KjsFAJNPsUpS9IOJmQDPTg0Dnewekb+T8H0LWKWYzdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTeQeRFqenkD70Abt6ZUoS1IFNq1kRsHA9FXQReFb3wBNYMDjeFpxx7NJ4yiELak7
	 6ZGWdI/yJ4OgY8HEX5hWUmyjbR50XMvnFoJpaUEIAo+SKDHj//Au7YLjRkYwjzzWC9
	 cFt1N3codg3H3eC005vunw+ZC/rjFNl0abB5gasWq5UIgrhPVu8obs7MO7jRjylZNA
	 jnoUbhoZaw2gcWjfGVpvf7wbJ7JTRFUa5dE7qUu1uJe/lgZ+dVq+4VAbGHHmwhCeC4
	 ToIrYCa/MtGvFIw97JriTEIPvMfegPU08bfu8ZSrrCT79UYA8PIwjeEsjedvkoOobQ
	 NzUIxVVadGxmw==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA6FA17E02BE;
	Mon, 17 Feb 2025 22:56:59 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Niklas Cassel <cassel@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Algea Cao <algea.cao@rock-chips.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v7 2/3] arm64: dts: rockchip: Add HDMI audio outputs for rk3588 SoC
Date: Mon, 17 Feb 2025 16:47:41 -0500
Message-ID: <20250217215641.372723-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217215641.372723-1-detlev.casanova@collabora.com>
References: <20250217215641.372723-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For hdmi0_sound, use the simple-audio-card driver with the hdmi0 QP node
as CODEC and the i2s5 device as CPU.

Similarly for hdmi1_sound, the CODEC is the hdmi1 node and the CPU is
i2s6, but only added in the rk3588-extra.dtsi device tree as the second
TX HDMI port is not available on base versions of the SoC.

The simple-audio-card,mclk-fs value is set to 128 as it is done in
the downstream driver.

The #sound-dai-cells value is set to 0 in the hdmi0 and hdmi1 nodes so
that they can be used as audio codec nodes.

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger Haikou
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi  | 17 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 8cfa30837ce72..f9f888dedd8f0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -382,6 +382,22 @@ scmi_reset: protocol@16 {
 		};
 	};
 
+	hdmi0_sound: hdmi0-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,name = "hdmi0";
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi0>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s5_8ch>;
+		};
+	};
+
 	pmu-a55 {
 		compatible = "arm,cortex-a55-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_partition0>;
@@ -1394,6 +1410,7 @@ hdmi0: hdmi@fde80000 {
 		reset-names = "ref", "hdp";
 		rockchip,grf = <&sys_grf>;
 		rockchip,vo-grf = <&vo1_grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 567f8f74c7b3c..cf04847afd040 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -7,6 +7,22 @@
 #include "rk3588-extra-pinctrl.dtsi"
 
 / {
+	hdmi1_sound: hdmi1-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,name = "hdmi1";
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi1>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s6_8ch>;
+		};
+	};
+
 	usb_host1_xhci: usb@fc400000 {
 		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
 		reg = <0x0 0xfc400000 0x0 0x400000>;
@@ -165,6 +181,7 @@ hdmi1: hdmi@fdea0000 {
 		reset-names = "ref", "hdp";
 		rockchip,grf = <&sys_grf>;
 		rockchip,vo-grf = <&vo1_grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-- 
2.48.1


