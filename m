Return-Path: <linux-kernel+bounces-538728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FC9A49C70
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB6A175101
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3B270EBF;
	Fri, 28 Feb 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C+oLPH4d"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04D26E642;
	Fri, 28 Feb 2025 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754401; cv=none; b=RVJxnYvmTaxPuniJow8HyYvUo4akbFdkVxWyj8UHnXtwW3nzX0QTB1a89TiN9ngQCgdRSIr1HmGvLOJ8mWr3gZEiAfK2W5VF4bApK5e3zOgvyBGgZUYIqKXgfY3c2sAnQJVeJGc41lroXhtDyBgeGdrBbj3g6G7A+kVTF8GC0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754401; c=relaxed/simple;
	bh=A+OjilsXusgmzLCL9Wv/h1+R9nNWJKHUhBgcxvTFFXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vce2YAdKzfBUh1m01ljfmb98Q0Q5a4rqQ+zMhmy8GHbqS8T9Ky3WKUuMWiMN3FeqJtoVP6clDYu1WLV7MJ1ODu1HJbHh/ShzlaxyuT36nt8AznwIhZaGBTeoU99JXFKIchHfwQMTCMAC/XlyMs+0dozU+qDxXzXtx67nD6wOOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C+oLPH4d; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740754397;
	bh=A+OjilsXusgmzLCL9Wv/h1+R9nNWJKHUhBgcxvTFFXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+oLPH4dgjkKoYCRr3GNEYn5OL95zVUY1cCvrY68xREqyQVL7Hil7Vb+qR9HOQYvx
	 WnnV4w89SmIY75Az/cAjt9m320+RcdbT9htkuOAxKzjWEFlPBo2BexErGv8y7p5nwX
	 ekWv1RG5DsPPnAQequ8hqicUWUzzm+YJ7YxDb9ZK60EmSRkV0VEGiKj732D7llAwD5
	 wxDiT75NdpbQUxJmSsr3aSwOSJ3qM60hRiifLCXSkTluxG1/h9B4/Thk60ZpC3CAFN
	 USJjQW8QU135NUTR6IXqrjGVEujK90Ra/pWySpzKyCGGDw6QDkDZ84P+IeOKkOFw1c
	 /Ozm7bxahVp/w==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BBF3A17E0B13;
	Fri, 28 Feb 2025 15:53:15 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Stephen Chen <stephen@radxa.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 1/2] arm64: dts: rockchip: Add SFC nodes for rk3576
Date: Fri, 28 Feb 2025 09:50:47 -0500
Message-ID: <20250228145304.581349-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228145304.581349-1-detlev.casanova@collabora.com>
References: <20250228145304.581349-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rk3576 SoC has 2 SFC cores that provide FSPI functions.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 4dde954043ef6..a9849003c8dd6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1221,6 +1221,17 @@ gmac1_mtl_tx_setup: tx-queues-config {
 			};
 		};
 
+		sfc1: spi@2a300000 {
+			compatible = "rockchip,sfc";
+			reg = <0x0 0x2a300000 0x0 0x4000>;
+			interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_FSPI1_X2>, <&cru HCLK_FSPI1>;
+			clock-names = "clk_sfc", "hclk_sfc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		sdmmc: mmc@2a310000 {
 			compatible = "rockchip,rk3576-dw-mshc";
 			reg = <0x0 0x2a310000 0x0 0x4000>;
@@ -1260,6 +1271,17 @@ sdhci: mmc@2a330000 {
 			status = "disabled";
 		};
 
+		sfc0: spi@2a340000 {
+			compatible = "rockchip,sfc";
+			reg = <0x0 0x2a340000 0x0 0x4000>;
+			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_FSPI_X2>, <&cru HCLK_FSPI>;
+			clock-names = "clk_sfc", "hclk_sfc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@2a701000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0x2a701000 0 0x10000>,
-- 
2.48.1


