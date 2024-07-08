Return-Path: <linux-kernel+bounces-244296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C41392A24A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008321F22889
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0DD84FA5;
	Mon,  8 Jul 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="L6kmbK+3"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00F84E1F;
	Mon,  8 Jul 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440594; cv=none; b=dGfv4dwtH0D+3gVa0bHwUdQw+cF1ZDhgwInh2ykfNuIPJcxPzGyaZ3tmfXFLD2scqu2UZ+Zd1CF80eNKF4pjqbGAXbpJl++mdx30C9wm3E4fZseKqxlPPPID6vkXtkGQJrW/Fujecl8ggbl2JlBglpAku+xM7q5JTr26tXmFaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440594; c=relaxed/simple;
	bh=nmcue+x2Xg45a6s/x0ugPR6Jgu4A/v+oknSpz5Ymk30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMBaqj+otTco7+2GUCoJHbT1UYrnyPf/I6ZNh1otFa6+S8UAYM1mAZVE/9q24HXlwAwSo4or5LpdZMlQXfRBZOtphOdUjAM1Q0Kq+ZRaTd2ND5fHvbas8p2CnHqNzFlili+cZtdFqWd3iOiX1txY81Mj2uaq/x+tGSIUa+z8lCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=L6kmbK+3; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 687F944D58;
	Mon,  8 Jul 2024 14:09:50 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r-v2oQzEaTSq; Mon,  8 Jul 2024 14:09:49 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720440584; bh=nmcue+x2Xg45a6s/x0ugPR6Jgu4A/v+oknSpz5Ymk30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6kmbK+35yIfkShOgt6FQzazv/R/hhn81mv2D+9Y8vNV8HLAEpIEZOJml4iLEYCSv
	 CPEkrm5219QvhFsyJlZGloUWAGH2OG2BDiG/UuRk7af7Wxw3xyBBKMIExlxoOEJjtv
	 quLEbcTiYHgJ1H1Qwy35htW2scBnTxVJUpG44/rPJPoRUhhQW55rfUK/lxoTTsJhfo
	 uqnFTUQeAvF2tKFbJlb7rNLQV0APZ2CFFIeyjKY6W3eyf9qX4Ro0pbETCrhEJBNwIv
	 OGwBE++0h7QpcYviRpKjF5F2PnI9KnPkMOVjalOUUMBfGUqkMyf+TzIjPLFGRaarhv
	 u+qEcBNnAszWw==
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/3] riscv: dts: sophgo: add nodes for USB phy and controller
Date: Mon,  8 Jul 2024 12:08:29 +0000
Message-ID: <20240708120830.5785-3-ziyao@disroot.org>
In-Reply-To: <20240708120830.5785-1-ziyao@disroot.org>
References: <20240708120830.5785-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CV1800/SG200x SoCs integrate a USB 2.0 phy and a USB controller based
on dwc2 IP. Add device tree nodes for these peripherals.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae470f..06461f1f1986 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -61,6 +61,18 @@ clk: clock-controller@3002000 {
 			#clock-cells = <1>;
 		};
 
+		usb_phy: usb-phy@3006000 {
+			compatible = "sophgo,cv1800-usb-phy";
+			reg = <0x3006000 0x60>, <0x3000048 0x4>;
+			reg-names = "phy", "pin";
+			clocks = <&clk CLK_APB_USB>,
+				 <&clk CLK_USB_125M>,
+				 <&clk CLK_USB_33K>,
+				 <&clk CLK_USB_12M>;
+			clock-names = "apb", "125m", "33k", "12m";
+			#phy-cells = <0>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
@@ -297,6 +309,17 @@ sdhci0: mmc@4310000 {
 			status = "disabled";
 		};
 
+		usb_otg: usb@4340000 {
+			compatible = "sophgo,cv1800-usb";
+			reg = <0x4340000 0x10000>;
+			clocks = <&clk CLK_AXI4_USB>;
+			clock-names = "otg";
+			dr_mode = "otg";
+			interrupts = <30 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb_phy>;
+			phy-names = "usb2-phy";
+		};
+
 		plic: interrupt-controller@70000000 {
 			reg = <0x70000000 0x4000000>;
 			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
-- 
2.45.2


