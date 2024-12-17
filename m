Return-Path: <linux-kernel+bounces-448902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E9C9F4700
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A68516E262
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D191E283C;
	Tue, 17 Dec 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="AAoYX28F"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718A71E0490;
	Tue, 17 Dec 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426781; cv=none; b=mnRKcgNX5wTajKQURo0t31ud3m7rjLNTjP6R7iym09RQ8uLLvakpkJ7HebjVnvp8qno/BjqE+w0o5Xs3ZyuGb5P9zWvsrcOcKCWBruA7ga5nh738CnW8hq9nFmQ0+AGFOhh4dZGrAWLTD+esO4CGNMk9tZQgIyL10vF7BVpexBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426781; c=relaxed/simple;
	bh=9T1XiRsPFOf+04PcA3UV9kCphnwgEzycixrUmgfsibU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDbnfdRpECLv65k5KQqFH20OHDGCVuywL9nz6q3wusrTKSQJp1CEzRuCjAVyEHKX6cAu1kKMRy2eSZyib58GU1abxMr5cXLAZwny1qGAj+aCbuLsWxr5krIWnFqSt486W/AURLB1SF5+So+/hSGb6W3Yv2tW8BsHD84hC+fhnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=AAoYX28F; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id DF765100935;
	Tue, 17 Dec 2024 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qpq2TeKtX83y0CQ6eBnXEfc924KW6SAf81KBp6Mvvw=;
	b=AAoYX28FYmVngTAnmC3WEsgtfHvP43zk7Dye+lPLvLPcrTgD0Tb2sv6lWeNelJJvfG3FFm
	lfSlRUqL4CGTsMwUwH21l3PWW85+79SSx0zvVj+CVd16BZwKWnylJyk6Q0NJvEET0FL14u
	FTp03/Bp9/Pfmw7AvANQvjcN3Apa7i8=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 3311D1004DD;
	Tue, 17 Dec 2024 09:12:57 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 09/22] arm64: dts: mediatek: mt7988: Add t-phy for ssusb1
Date: Tue, 17 Dec 2024 10:12:23 +0100
Message-ID: <20241217091238.16032-10-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217091238.16032-1-linux@fw-web.de>
References: <20241217091238.16032-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 4829692c-2fa9-453d-9b7f-c32d2c4d92c7

From: Frank Wunderlich <frank-w@public-files.de>

USB controller needs phys for working properly.
On mt7988 ssusb0 uses a xs-phy, ssusb uses t-phy.
For now add the t-phy for ssusb1. We can reuse the mt7986 compatible
here.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index f8b01f3fff32..209d170bce7f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -349,6 +349,8 @@ usb@11200000 {
 				 <&infracfg CLK_INFRA_133M_USB_HCK_CK_P1>,
 				 <&infracfg CLK_INFRA_USB_XHCI_CK_P1>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
+			phys = <&tphyu2port0 PHY_TYPE_USB2>,
+			       <&tphyu3port0 PHY_TYPE_USB3>;
 			status = "disabled";
 		};
 
@@ -371,6 +373,29 @@ mmc0: mmc@11230000 {
 			status = "disabled";
 		};
 
+		t-phy@11c50000 {
+			compatible = "mediatek,mt7986-tphy",
+				     "mediatek,generic-tphy-v2";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			tphyu2port0: usb-phy@11c50000 {
+				reg = <0 0x11c50000 0 0x700>;
+				clocks = <&infracfg CLK_INFRA_USB_UTMI_CK_P1>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+
+			tphyu3port0: usb-phy@11c50700 {
+				reg = <0 0x11c50700 0 0x900>;
+				clocks = <&infracfg CLK_INFRA_USB_PIPE_CK_P1>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
 		clock-controller@11f40000 {
 			compatible = "mediatek,mt7988-xfi-pll";
 			reg = <0 0x11f40000 0 0x1000>;
-- 
2.43.0


