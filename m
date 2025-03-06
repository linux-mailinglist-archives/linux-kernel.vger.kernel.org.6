Return-Path: <linux-kernel+bounces-549595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE0A5544C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED72317A085
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB032702C5;
	Thu,  6 Mar 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qfJrvxPJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640A2702C7;
	Thu,  6 Mar 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284472; cv=none; b=RirEnHTL/x7e5QsMjgtHp9QbL8kGtDDiNyypKO4HirQBqMYwp5mZeCA3drrGEohK7bzUXunbn5LAHivCCAYg547njmag719AXe+XZHtbE6fz/mC14VVFjez/afHDq9QFMjFUMM9CEKpgeZyBlYnoQU6QdcwXjihgET85ntfoUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284472; c=relaxed/simple;
	bh=d6BibUDSE0mb5iLcPsRSauFGpJaMOrregbvVx9t9eLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLOmdCXp5zqVrArBS0w0ZMWIQNrV6RAzbH3nmq/Ck9JAR3YIKoqvPpCY4cDvvHaj2Pls7ERSf9u6TP8jxnEaxemgOpAgX8meUiUhebfMUm7yghOUdueIEec3sbvzYa1unK42rCXNUJbhDRYrQ0H/McLvec3jisdbNd7BMHjcJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qfJrvxPJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741284467;
	bh=d6BibUDSE0mb5iLcPsRSauFGpJaMOrregbvVx9t9eLI=;
	h=From:To:Cc:Subject:Date:From;
	b=qfJrvxPJBnSS3+4O9YX/cwRugyGiSpPEnXVe6T0GDC9kMgyrOMVzacjEXHRWcI7Cy
	 QJ4e3qo4gBS0LGaylCmHDRH4IuY264npknx/poMLGcmFUNGmiFC+dpsNorkX0p7u6U
	 n0WpBuTNcyZE67Unweiks+vFmF9N44m7zAf+aDWxBl0SYHfQI9He6wr1Y006jokVig
	 qbvDuW7eJe0Upq6EzlxX1F7hwcsQX+arQOmbTsEwTIs7IEaFBzfFHO1a7a3dsO7Vtv
	 M7dIAPBUI1qTquK4mYb4diuxvVjGTCQcwK2njdrmu/gObOGTrljyrrt5d1AvScIsVp
	 i2+vfypFI4B4Q==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3596617E088C;
	Thu,  6 Mar 2025 19:07:45 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Stephen Chen <stephen@radxa.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2] arm64: dts: rockchip: Add HDMI support for rock-4d
Date: Thu,  6 Mar 2025 13:06:31 -0500
Message-ID: <20250306180737.127726-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable HDMI and VOP nodes for the rock-4d board.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---

Changes since v1:
 - Remove extra blank line

 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 5dc1c18a3b211..bccd77c3a906f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -26,6 +26,17 @@ chosen {
 		stdout-path = "serial0:1500000n8";
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds: leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -238,6 +249,26 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdptxphy {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -687,3 +718,18 @@ &usb_drd1_dwc3 {
 	dr_mode = "host";
 	status = "okay";
 };
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.48.1


