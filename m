Return-Path: <linux-kernel+bounces-439120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA79EAB04
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D042824C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B7230D02;
	Tue, 10 Dec 2024 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY4/fzUW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427512DD88;
	Tue, 10 Dec 2024 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820663; cv=none; b=tBA2bqzdf4Fm8u0g7r5NULv/fISqSw+yQGqxzBvT0W5Gzd3ZxS8iqF61Hp1uDfKZwUtxmLM54UvAQjOz2cUzIOTeZ+2ufMR/rDQtPd0S5TAMcoNbK3U8fNmiZ/bkU/FBg8Za1CdTaj8deYmXPa++HfptSUGnF28Lh8A1EE+i36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820663; c=relaxed/simple;
	bh=RBwUyiJQatXq2bXHGIrBTBqeIDjRTnMdRDACMW7Aabk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yw4tp/RNI/TcSFX9sn4DVQ6StXFx6pWFPJMmdqXTuMp2LTsgv2VEJt2tyXUMPT3lkJoRJ5oOf14GkJMHVBMhy8xqJgEyBjDodsjVty46PcZUEBz/2q15ZKfaW6wzT0XiqmHRUEu8Dgy8CdbTr1Spv1ItfkTJvGkRuvWK0DPIJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY4/fzUW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166db59927so1346795ad.0;
        Tue, 10 Dec 2024 00:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733820661; x=1734425461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lvmAl49q0nOo+CXHprDwYdHIdAg6MStjLB57aFHcjK0=;
        b=YY4/fzUWTrbBf9DDHquRWV5zTsHNLslI1fDYL+zgkQq8TRJu1GN6G7hQ4AI/BLvJcg
         bCqrhmQWdEqgaJWfaebmbd6xb338k3XDgKwlfYDZxy/+HG9ACOtP+ljitXbHxLSHMjII
         exPJSFyaQQyUJAD4n7oCY8zgkQ8MSfm6aZF3bwP2TLRR4fSC0rssI0rUhwGoP1m8GTqI
         QaYKz9gZsGuOtsYA0HoCmWR4vRXKORr5Tx5FPLW2iG65u8QUyXI14CbKgBDlHqmp0C+I
         Yqr99xIH9tKpbmfV1AIlhKFHTRLvY4Jvwn3wOTn/WDsi7fcF5jRBw5v+7AkSrqNLdaGO
         dErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820661; x=1734425461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvmAl49q0nOo+CXHprDwYdHIdAg6MStjLB57aFHcjK0=;
        b=fDL/XMpaxZTcOc4Vy6G7eI6sD/wQEeDswSAbIBe1IRJSmaB4dmfd3+O1/g/jhI1MTr
         nd5/fIxpeBiGb0ZCUSoM9puFK67Yq5909gv/808WrXOhh3iI9ocaAsMrYynhiEJcVKaX
         HkxHuIXPTpPJ7IqRTRG7ZaNAR2dPoYKn95I4LRCv4KafxLBynh1gJsLFwyXo4li1cHRl
         gpRfgXP2zp4XJ12jdhsZT6ioADYoaVTVC5QCxtlsW0SPrXRaKgrdXO8SGwmhzYhkbjzR
         ZNRIiliOaUr/pZaxP1zoBn0ZFB2cvfhOTWvwW8pOpWl9s14A/Fs10g/JQxTbwHdFfxpg
         dJYw==
X-Forwarded-Encrypted: i=1; AJvYcCUIGx+8ezB7AiNPlWocd0iLjRCjNhut4IvBeSsjQK8MD9o6ytlLiIkI/CtskstQsqV3dqoHwNsd6ALNFBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguGj24b+GuKsvLdMzsDOv073ADxL4xhB2jBHwaKD08X8DISPW
	CstMgr421uQ88Obm5U1+MJEGQCYQ0RbmRdmVb3gtcuPOxQuqu22A
X-Gm-Gg: ASbGnctn44plMmErqXVxXwTUPa8D1pY1gzwGH+aZ8uiXzNJZc/mra1Sn4RmiYArhSMS
	0yjiRs9mp136kRu5Iau04Mzo54qEEgbp9h1sRVxpM8eVMs4XfBkmgOexTm51KI+ifmrhTgEUvz1
	3eMOrqNGtcVZTaNx1Mye76oXBCL9ugolP9Y+/9/flNaodNY5MQqMsXJU+Zkpkk+q8CXh9IJGJt1
	lZ+fO9CRg9qHOG6y3XKhZGp2FHp/U9NsRT3ht86XdULhDAzKmxDrH/cI3jgE6EG59c=
X-Google-Smtp-Source: AGHT+IHuUD4OQIvKVC68Jcb0WI5maZSwAo50mG73GT8qwADzaNvcHaD5/ggUoORwSEiUbK0S9nZB/A==
X-Received: by 2002:a17:903:2451:b0:215:a97a:c6bc with SMTP id d9443c01a7336-2166fb9ca4fmr14413735ad.0.1733820660864;
        Tue, 10 Dec 2024 00:51:00 -0800 (PST)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e807sm85046915ad.57.2024.12.10.00.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:51:00 -0800 (PST)
From: Frank Wang <frawang.cn@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	william.wu@rock-chips.com,
	yubing.zhang@rock-chips.com,
	tim.chen@rock-chips.com,
	kever.yang@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH] arm64: dts: rockchip: add usb related nodes for rk3576
Date: Tue, 10 Dec 2024 16:50:53 +0800
Message-Id: <20241210085053.64294-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

This adds USB and USB-PHY related nodes for RK3576 SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
The compatible string "rockchip,rk3576-naneng-combphy" in the patch
depends on the following commit which has not merged into this branch.
 - https://patchwork.kernel.org/project/linux-phy/patch/20241106021357.19782-1-frawang.cn@gmail.com/

 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 169 +++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 436232ffe4d1..70cfa099089a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -445,6 +445,58 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		usb_drd0_dwc3: usb@23000000 {
+			compatible = "rockchip,rk3576-dwc3", "snps,dwc3";
+			reg = <0x0 0x23000000 0x0 0x400000>;
+			clocks = <&cru CLK_REF_USB3OTG0>,
+				 <&cru CLK_SUSPEND_USB3OTG0>,
+				 <&cru ACLK_USB3OTG0>;
+			clock-names = "ref_clk", "suspend_clk", "bus_clk";
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3576_PD_USB>;
+			resets = <&cru SRST_A_USB3OTG0>;
+			dr_mode = "otg";
+			phys = <&u2phy0_otg>, <&usbdp_phy PHY_TYPE_USB3>;
+			phy-names = "usb2-phy", "usb3-phy";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
+			snps,parkmode-disable-hs-quirk;
+			snps,parkmode-disable-ss-quirk;
+			status = "disabled";
+		};
+
+		usb_drd1_dwc3: usb@23400000 {
+			compatible = "rockchip,rk3576-dwc3", "snps,dwc3";
+			reg = <0x0 0x23400000 0x0 0x400000>;
+			clocks = <&cru CLK_REF_USB3OTG1>,
+				 <&cru CLK_SUSPEND_USB3OTG1>,
+				 <&cru ACLK_USB3OTG1>;
+			clock-names = "ref_clk", "suspend_clk", "bus_clk";
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3576_PD_PHP>;
+			resets = <&cru SRST_A_USB3OTG1>;
+			dr_mode = "otg";
+			phys = <&u2phy1_otg>, <&combphy1_psu PHY_TYPE_USB3>;
+			phy-names = "usb2-phy", "usb3-phy";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
+			snps,dis_rxdet_inp3_quirk;
+			snps,parkmode-disable-hs-quirk;
+			snps,parkmode-disable-ss-quirk;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		sys_grf: syscon@2600a000 {
 			compatible = "rockchip,rk3576-sys-grf", "syscon";
 			reg = <0x0 0x2600a000 0x0 0x2000>;
@@ -515,6 +567,65 @@ usbdpphy_grf: syscon@2602c000 {
 			reg = <0x0 0x2602c000 0x0 0x2000>;
 		};
 
+		usb2phy_grf: syscon@2602e000 {
+			compatible = "rockchip,rk3576-usb2phy-grf", "syscon", "simple-mfd";
+			reg = <0x0 0x2602e000 0x0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			u2phy0: usb2-phy@0 {
+				compatible = "rockchip,rk3576-usb2phy";
+				reg = <0x0 0x10>;
+				resets = <&cru SRST_OTGPHY_0>, <&cru SRST_P_USBPHY_GRF_0>;
+				reset-names = "phy", "apb";
+				clocks = <&cru CLK_PHY_REF_SRC>,
+					 <&cru ACLK_MMU2>,
+					 <&cru ACLK_SLV_MMU2>;
+				clock-names = "phyclk", "aclk", "aclk_slv";
+				clock-output-names = "usb480m_phy0";
+				#clock-cells = <0>;
+				status = "disabled";
+
+				u2phy0_otg: otg-port {
+					#phy-cells = <0>;
+					interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "otg-bvalid", "otg-id", "linestate";
+					status = "disabled";
+				};
+			};
+
+			u2phy1: usb2-phy@2000 {
+				compatible = "rockchip,rk3576-usb2phy";
+				reg = <0x2000 0x10>;
+				resets = <&cru SRST_OTGPHY_1>, <&cru SRST_P_USBPHY_GRF_1>;
+				reset-names = "phy", "apb";
+				clocks = <&cru CLK_PHY_REF_SRC>,
+					 <&cru ACLK_MMU1>,
+					 <&cru ACLK_SLV_MMU1>;
+				clock-names = "phyclk", "aclk", "aclk_slv";
+				clock-output-names = "usb480m_phy1";
+				#clock-cells = <0>;
+				status = "disabled";
+
+				u2phy1_otg: otg-port {
+					#phy-cells = <0>;
+					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "otg-bvalid", "otg-id", "linestate";
+					status = "disabled";
+				};
+			};
+		};
+
+		vo1_grf: syscon@26036000 {
+			compatible = "rockchip,rk3576-vo1-grf", "syscon";
+			reg = <0x0 0x26036000 0x0 0x100>;
+			clocks = <&cru PCLK_VO1_ROOT>;
+		};
+
 		sdgmac_grf: syscon@26038000 {
 			compatible = "rockchip,rk3576-sdgmac-grf", "syscon";
 			reg = <0x0 0x26038000 0x0 0x1000>;
@@ -1587,6 +1698,64 @@ uart11: serial@2afd0000 {
 			status = "disabled";
 		};
 
+		usbdp_phy: phy@2b010000 {
+			compatible = "rockchip,rk3576-usbdp-phy";
+			reg = <0x0 0x2b010000 0x0 0x10000>;
+			#phy-cells = <1>;
+			clocks = <&cru CLK_PHY_REF_SRC >,
+				 <&cru CLK_USBDP_COMBO_PHY_IMMORTAL>,
+				 <&cru PCLK_USBDPPHY>,
+				 <&u2phy0>;
+			clock-names = "refclk", "immortal", "pclk", "utmi";
+			resets = <&cru SRST_USBDP_COMBO_PHY_INIT>,
+				 <&cru SRST_USBDP_COMBO_PHY_CMN>,
+				 <&cru SRST_USBDP_COMBO_PHY_LANE>,
+				 <&cru SRST_USBDP_COMBO_PHY_PCS>,
+				 <&cru SRST_P_USBDPPHY>;
+			reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
+			rockchip,u2phy-grf = <&usb2phy_grf>;
+			rockchip,usb-grf = <&usb_grf>;
+			rockchip,usbdpphy-grf = <&usbdpphy_grf>;
+			rockchip,vo-grf = <&vo1_grf>;
+			status = "disabled";
+		};
+
+		combphy0_ps: phy@2b050000 {
+			compatible = "rockchip,rk3576-naneng-combphy";
+			reg = <0x0 0x2b050000 0x0 0x100>;
+			#phy-cells = <1>;
+			clocks = <&cru CLK_REF_PCIE0_PHY>,
+				 <&cru PCLK_PCIE2_COMBOPHY0>,
+				 <&cru PCLK_PCIE0>;
+			clock-names = "ref", "apb", "pipe";
+			assigned-clocks = <&cru CLK_REF_PCIE0_PHY>;
+			assigned-clock-rates = <100000000>;
+			resets = <&cru SRST_PCIE0_PIPE_PHY>,
+				 <&cru SRST_P_PCIE2_COMBOPHY0>;
+			reset-names = "phy", "apb";
+			rockchip,pipe-grf = <&php_grf>;
+			rockchip,pipe-phy-grf = <&pipe_phy0_grf>;
+			status = "disabled";
+		};
+
+		combphy1_psu: phy@2b060000 {
+			compatible = "rockchip,rk3576-naneng-combphy";
+			reg = <0x0 0x2b060000 0x0 0x100>;
+			#phy-cells = <1>;
+			clocks = <&cru CLK_REF_PCIE1_PHY>,
+				 <&cru PCLK_PCIE2_COMBOPHY1>,
+				 <&cru PCLK_PCIE1>;
+			clock-names = "ref", "apb", "pipe";
+			assigned-clocks = <&cru CLK_REF_PCIE1_PHY>;
+			assigned-clock-rates = <100000000>;
+			resets = <&cru SRST_PCIE1_PIPE_PHY>,
+				 <&cru SRST_P_PCIE2_COMBOPHY1>;
+			reset-names = "phy", "apb";
+			rockchip,pipe-grf = <&php_grf>;
+			rockchip,pipe-phy-grf = <&pipe_phy1_grf>;
+			status = "disabled";
+		};
+
 		sram: sram@3ff88000 {
 			compatible = "mmio-sram";
 			reg = <0x0 0x3ff88000 0x0 0x78000>;
-- 
2.25.1


