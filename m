Return-Path: <linux-kernel+bounces-515345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E882CA3637D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7014F7A2A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F20267B9B;
	Fri, 14 Feb 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F7wEv5iI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889C267727;
	Fri, 14 Feb 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551639; cv=none; b=OUV4w+s+0UEFipLfeT7Fm9gScDp4Jgn8oufAThqgSIK+ocUpO69td9bY+sIHfVW6bI+GRklLslXFHE1zy/nmXp+Zt54qO21P/57WoMo3Z4MHWqgbtFnlDNTeNiAEyW3nvYiM/kOqvtuqvDuNhkCLCdjG3PUBia53yiZ821qVZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551639; c=relaxed/simple;
	bh=SrFZdZudr7RArsBjh8BhpE0G7d7aPvrz97c6D+4TCUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOyYLRJbZMygZSm0ppx6MXNvneK8j/dZTViXjNwDlRdFd41Bgv2aaYIAHjlrjPpuCg1k5w8cxeE+0XiDifoa3htN/uX4vYb5Sz6ewQi+4A/xriSjmmemePtw7AxYGrGW/T4D9sJk/UjdhiniR2CU0Ai4hQLux7rDlula45D5P6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F7wEv5iI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739551635;
	bh=SrFZdZudr7RArsBjh8BhpE0G7d7aPvrz97c6D+4TCUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7wEv5iIWcQpuhRifPwkGwnbfl8wruNabVEmDdQCoHSuC0KvnNTVygl8AsOq87wK3
	 8hyfaGFgzXMsvmZ577HHmNYrbijTecCApgQQOpXXQimv6jj3AoIr/96B5z96iJMKDB
	 cDjpFuaZVOUeW04qX1kvFnRCUPLIUwHPUn81rL+BPgIiM8CHJh2aTRI0rxjD1V3iH8
	 XndAyODRyDpOUzJV6z+xTm81SYnkI/Mt/fWcGoQrwipNdXnsVImh3iKluUIzWdZz5g
	 zr2RjG5XhixXpMmvxf9AZfgODjfH3OG6zRBoO+H3YVz6/VoV2TXbPdSYcBhAQKoTsD
	 mlBZs7rx9R7Nw==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D4C717E0B59;
	Fri, 14 Feb 2025 17:47:12 +0100 (CET)
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
Subject: [PATCH RESEND v6 2/3] arm64: dts: rockchip: Add HDMI0 audio output for rk3588 SoC
Date: Fri, 14 Feb 2025 11:44:01 -0500
Message-ID: <20250214164528.534278-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214164528.534278-1-detlev.casanova@collabora.com>
References: <20250214164528.534278-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the simple-audio-card driver with the hdmi0 QP node as CODEC and
the i2s5 device as CPU.

The simple-audio-card,mclk-fs value is set to 128 as it is done in
the downstream driver.

The #sound-dai-cells value is set to 0 in the hdmi0 node so that it can be
used as an audio codec node.

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger Haikou
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

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
-- 
2.48.1


