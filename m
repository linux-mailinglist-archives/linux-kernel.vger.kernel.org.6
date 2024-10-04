Return-Path: <linux-kernel+bounces-350014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D071D98FEB0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACD21F2599A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A4C140E50;
	Fri,  4 Oct 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NAjYK6iV"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF213D2A9
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029573; cv=none; b=hJEqnEaIV3j2Pu8+vs5Cb1+wzrK8isrpfxfx2JQkBCuPsClxFbdJsv0ivais8vkfBoaqRrAACH6FB6WqmfK5jhu19qWZiz4fUDcI/zVZjjaVJBzR1rRPJOtUQKGkOS0mah6IOt0WGNgUABo6XJ/j6bB6yesBTX4+abH2itYS4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029573; c=relaxed/simple;
	bh=H1VJkOfMZE2T04HxxlpkY8dN0P5tJJDnmZJxfggidqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCn+/juhHS2PzMniQsWhCNdULmRYgp6Cnbs2+Vai+7dydpop9+fW9qbx1b33gRcEUI0IwGnoIbA9hwJsVEUwUakW1aQNlOY1VVMJTwmmHTyh7gVOxLKAQNE2hLaU+uQABsnCfzEB9e6jUcYajxLPTrY/15vxK7voeRrRLGzzo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NAjYK6iV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b9b35c7c3so18595745ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728029571; x=1728634371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51XTVsZzEt4mq71MSs0yqggO8rkXWZxGhVvPUO2dS4I=;
        b=NAjYK6iVVLFEQ4gGSZ9IYFzUOj4/F7KzKd/FOz6DRBbckLpVyEzjhUvh+NIYOnd7Gh
         lIy/95EJYhFornWJrNMo2tvzE5r/hPUUKw+ZmDeBEviAewUcXtPzgqQAR8yUoMN4wide
         YdJY3v5sUk1B8JJnm9TD+xTbZEL3jbTcXqpiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029571; x=1728634371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51XTVsZzEt4mq71MSs0yqggO8rkXWZxGhVvPUO2dS4I=;
        b=rDCKELiS2XdSeqnQVuIE2Lp/bgB46JYiVEr3WsF6YjMLRfsPOV9q7C0D9VvdumQKn7
         a9YYrZQ0Q8EWdq+YnhbTNcWBArfzf9OGHiqyAqPQfl4bbeOWjThxsX7vq3nctrIAT0hv
         OxQHj+GGl/FkM6hs6YsWpW4nPrWEtGd9invHezsp88qSYPVSgPaQHmLPkQGONDEbr1Ai
         LwBVYwqONBkDn4k92Rq/Y+31OFWCA6htcDt4n3Idkxzlv36BuF3DjDvDEmqL53HRnQY+
         2wlOnO5589jURJApMRLy/w8tChZ6mPh7JMhSFBCYt1pPhulgzfbgrte/A5fRStRsH2Z7
         e4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnve1JTIw6d4li8LrfDkBGrZ3pzIUf81x7a/+55qOBO1QDrRMtKsGAGrPpKiR2oZ9LpAdJT21u4L1haMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznPGswci2yByqZacuRmGi3HyOLQ9FZ+cYAkodIDLUT6ElPee9q
	mAIR0qWqsvEZvYKP0/5PzKx4mQZuaU7YfFv+Xfx1Ylznp9i9K6ZRFP4qY9V8Jg==
X-Google-Smtp-Source: AGHT+IFyMA3M/DNWq/zKUz0UfhJqSPFA7wlM693F6oloupjh2iNEoH5dRNi6WQAnKOnmbqg42ucsIA==
X-Received: by 2002:a17:903:32cc:b0:20b:a9f3:7996 with SMTP id d9443c01a7336-20bff17b269mr28842715ad.51.1728029571249;
        Fri, 04 Oct 2024 01:12:51 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:73bb:cecf:e651:2ce6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefad264sm19401305ad.205.2024.10.04.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:12:50 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/9] arm64: dts: mediatek: mt8188: Add PCIe nodes
Date: Fri,  4 Oct 2024 16:11:54 +0800
Message-ID: <20241004081218.55962-3-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241004081218.55962-1-fshao@chromium.org>
References: <20241004081218.55962-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PCIe node and the associated PHY node.
Individual board device tree should enable the nodes as needed.

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v2)

Changes in v2:
- add linux,pci-domain to PCIe node
- add power domain to PCIe PHY node
  The binding patch:
  https://lore.kernel.org/all/20240926101804.22471-1-macpaul.lin@mediatek.com/

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index e216a0b40b9e..3cc00a898cc9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1766,6 +1766,54 @@ xhci0: usb@112b0000 {
 			status = "disabled";
 		};
 
+		pcie: pcie@112f0000 {
+			compatible = "mediatek,mt8188-pcie", "mediatek,mt8192-pcie";
+			reg = <0 0x112f0000 0 0x2000>;
+			reg-names = "pcie-mac";
+			ranges = <0x82000000 0 0x20000000 0 0x20000000 0 0x4000000>;
+			bus-range = <0 0xff>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P0>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_26M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_32K>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
+				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_FMEM>;
+			clock-names = "pl_250m", "tl_26m", "tl_96m", "tl_32k",
+				      "peri_26m", "peri_mem";
+
+			#interrupt-cells = <1>;
+			interrupts = <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			interrupt-map-mask = <0 0 0 7>;
+
+			iommu-map = <0 &infra_iommu IFR_IOMMU_PORT_PCIE_0 0xffff>;
+			iommu-map-mask = <0>;
+
+			phys = <&pcieport PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+
+			power-domains = <&spm MT8188_POWER_DOMAIN_PEXTP_MAC_P0>;
+
+			resets = <&watchdog MT8188_TOPRGU_PCIE_SW_RST>;
+			reset-names = "mac";
+
+			status = "disabled";
+
+			pcie_intc: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
 		nor_flash: spi@1132c000 {
 			compatible = "mediatek,mt8188-nor", "mediatek,mt8186-nor";
 			reg = <0 0x1132c000 0 0x1000>;
@@ -1780,6 +1828,22 @@ nor_flash: spi@1132c000 {
 			status = "disabled";
 		};
 
+		pciephy: t-phy@11c20700 {
+			compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3";
+			ranges = <0 0 0x11c20700 0x700>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_PEXTP_PHY_TOP>;
+			status = "disabled";
+
+			pcieport: pcie-phy@0 {
+				reg = <0 0x700>;
+				clocks = <&topckgen CLK_TOP_CFGREG_F_PCIE_PHY_REF>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
 		i2c1: i2c@11e00000 {
 			compatible = "mediatek,mt8188-i2c";
 			reg = <0 0x11e00000 0 0x1000>,
-- 
2.47.0.rc0.187.ge670bccf7e-goog


