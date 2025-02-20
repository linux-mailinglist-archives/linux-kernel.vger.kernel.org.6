Return-Path: <linux-kernel+bounces-523517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41D1A3D7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078B53A66D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DF11F1534;
	Thu, 20 Feb 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ifwgbz7K"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C651DE3A7;
	Thu, 20 Feb 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049803; cv=none; b=Q3cMBR2yC7zryN5lUvAiUbUV9rMpXq0XGV4o5M+LCUkxo+Ydo71nLKNtZjmZKN2psYYJ2bPXqj3Kx4eTHlGQAddeMoCL/KWP6+sYikRk9ydw2ofnVXXoEtj7IZI7XQ1EDtOAf3e0mUbFPHcEbfvYFvY1jSNzTV8Ve2O2Ey4qHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049803; c=relaxed/simple;
	bh=8LNTiqSD2cUqBlyQLegc+6Iq0xpmH5Hud+BUPCQFmjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbru4lNGFzOKSsfiYzNprQdWB/OThaJ9py/WY8dVu+PxnVTltwTYNQsd4Vx8hHPuUUlhllOY0qC+GoYF2gAttUClBDxYOsmRK0q0JbeNS6D4Nmrrb8xXx/JQRPRbXP1euCGQwZXrTwK+4osmeCAu2cgewflRR6VpLw/wyANnKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ifwgbz7K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740049799;
	bh=8LNTiqSD2cUqBlyQLegc+6Iq0xpmH5Hud+BUPCQFmjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ifwgbz7KWQ+c256kIkLH5zet6OyfL3vCqXsjY7VC1a+CmOZhqZHBoUZhgRSlYbmxZ
	 mDyvvboR/QIgVfAUZcJvypv1eHuHcqXlKPH7giEPp5jq+//9Srhituev8GHiOxDS69
	 mjErXX7ke0fn44r10ggwas3KZeKjN5U9cBGUHa7rclGp08iktVNtnC6lUGCUGMUjRR
	 CKkKl474My2esQqnXZioKjD3aqL/DjsTX3NYt/sIoJlUqOO/R9oUYEdJcP65vPhZ/m
	 R3rVxF5ODGxCU2zlwT4hpvAh599e9Ox5KL/fKjmfdZGHGrBDqOsTXTKTeGkjLFJcLa
	 /3MWoz9EdCyPA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EAC017E1560;
	Thu, 20 Feb 2025 12:09:58 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v1 1/4] arm64: dts: mediatek: mt8188: Add base display controller graph
Date: Thu, 20 Feb 2025 12:09:45 +0100
Message-ID: <20250220110948.45596-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com>
References: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The display related IPs in MT8188 are flexible and support being
interconnected with different instances of DDP IPs and/or with
different DDP IPs, forming a full Display Data Path that ends
with an actual display output, which is board specific.

Add a common graph in the main mt8188.dtsi devicetree, which is
shared between all of the currently supported boards.
All boards featuring any display functionality will extend this
common graph to hook the display controller of the SoC to their
specific output port(s).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 140 +++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index c226998b7e47..4437b1820f26 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -2868,6 +2868,23 @@ ovl0: ovl@1c000000 {
 			iommus = <&vdo_iommu M4U_PORT_L0_DISP_OVL0_RDMA0>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x0000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					ovl0_in: endpoint { };
+				};
+
+				port@1 {
+					reg = <1>;
+					ovl0_out: endpoint {
+						remote-endpoint = <&rdma0_in>;
+					};
+				};
+			};
 		};
 
 		rdma0: rdma@1c002000 {
@@ -2878,6 +2895,25 @@ rdma0: rdma@1c002000 {
 			iommus = <&vdo_iommu M4U_PORT_L1_DISP_RDMA0>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x2000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					rdma0_in: endpoint {
+						remote-endpoint = <&ovl0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					rdma0_out: endpoint {
+						remote-endpoint = <&color0_in>;
+					};
+				};
+			};
 		};
 
 		color0: color@1c003000 {
@@ -2887,6 +2923,25 @@ color0: color@1c003000 {
 			interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x3000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					color0_in: endpoint {
+						remote-endpoint = <&rdma0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					color0_out: endpoint {
+						remote-endpoint = <&ccorr0_in>;
+					};
+				};
+			};
 		};
 
 		ccorr0: ccorr@1c004000 {
@@ -2896,6 +2951,25 @@ ccorr0: ccorr@1c004000 {
 			interrupts = <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x4000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					ccorr0_in: endpoint {
+						remote-endpoint = <&color0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ccorr0_out: endpoint {
+						remote-endpoint = <&aal0_in>;
+					};
+				};
+			};
 		};
 
 		aal0: aal@1c005000 {
@@ -2905,6 +2979,25 @@ aal0: aal@1c005000 {
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x5000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					aal0_in: endpoint {
+						remote-endpoint = <&ccorr0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					aal0_out: endpoint {
+						remote-endpoint = <&gamma0_in>;
+					};
+				};
+			};
 		};
 
 		gamma0: gamma@1c006000 {
@@ -2914,6 +3007,23 @@ gamma0: gamma@1c006000 {
 			interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x6000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					gamma0_in: endpoint {
+						remote-endpoint = <&aal0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					gamma0_out: endpoint { };
+				};
+			};
 		};
 
 		dither0: dither@1c007000 {
@@ -2923,6 +3033,21 @@ dither0: dither@1c007000 {
 			interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x7000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dither0_in: endpoint { };
+				};
+
+				port@1 {
+					reg = <1>;
+					dither0_out: endpoint { };
+				};
+			};
 		};
 
 		disp_dsi0: dsi@1c008000 {
@@ -3005,6 +3130,21 @@ postmask0: postmask@1c01a000 {
 			interrupts = <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0xa000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					postmask0_in: endpoint { };
+				};
+
+				port@1 {
+					reg = <1>;
+					postmask0_out: endpoint { };
+				};
+			};
 		};
 
 		vdosys0: syscon@1c01d000 {
-- 
2.48.1


