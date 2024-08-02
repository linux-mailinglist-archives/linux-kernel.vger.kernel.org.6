Return-Path: <linux-kernel+bounces-272098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0284945704
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721EF1F24592
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716541760;
	Fri,  2 Aug 2024 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WGjeRAxh"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0718EA8;
	Fri,  2 Aug 2024 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572768; cv=none; b=IyLPK2Lx9e0xet7WSLCalMeMw6+Oo7fFPJB01hl9pwLTXzBZXm2aMtLCBoT8FjbpPkhOQc8JfTU1pz7rrRW7Iwx5drlYVwtW36I3Bs7um4LpP5l0NnGsr3nODJCgtGw7SCyWhEf2jpgP8Ne5Th9oxttzptXTCNi85xQe1jlNi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572768; c=relaxed/simple;
	bh=4AhIPKFkrTlmSmYXXy3e+gVWOrubXSPECy85jykb9NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPyd6dhZT/usIm2IOKhr427QYOPklhq5GZeWvVAyzu28qNf9VV2JmYrhG0AsBNBgWgUcktPsuHHIL9D9e4HFCaSs13B8lp2rlXoukAfWmeaKbTmGrlrJ5Maavlnr3xov+8mocHbo86nxelDn0vmmnGHFIA9FOCDK0+U7cJwt5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WGjeRAxh; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722572764;
	bh=gOD27zMo3lrmJRup4wbY8/orYsPs9hUczeDsWtve624=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WGjeRAxhOWRkakDv48zAWW9fOHaQoA3q0EWGVRKyXRtAPjGYpuknhV4cWUXHpLEOm
	 Mo/uiCeGGi3FtcA2lyKZwcTjrhtSyhtsrDYUpPjwqlapRe4bjDJLNXhApncwZBfAUw
	 1jBia6zN2TO8cB0SKSoEQ8kY+m6DbMHD++MBRrshpwwdg95TNY/Ne4Ww730qXFdCyq
	 bnvfmTAZhUVrh6oC3bcgMITbw59r3Ap5CR5bppDrAU8WGMdCRMvo5ocj7KkPsjUkpw
	 MdpFDPkE4w4OHIprbWQ9fW9Z/e3yMuv+mN0y6cq1vVbQHl4Znupc8uNV3tUK9Y41/T
	 xO7PI6nF4IWLw==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 461F166E09;
	Fri,  2 Aug 2024 12:26:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:20 +0930
Subject: [PATCH 3/7] ARM: dts: aspeed: Specify required properties for sram
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dt-warnings-bmc-dts-cleanups-v1-3-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eddie James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1

Squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: sram@1e720000: '#address-cells' is a required property
        from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: sram@1e720000: '#size-cells' is a required property
        from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: sram@1e720000: 'ranges' is a required property
        from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
```

Fixes: d44a1138cd82 ("arm/dts: Add Aspeed ast2400 device tree")
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 3 +++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index ec9563c629df..78c967812492 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -230,6 +230,9 @@ adc: adc@1e6e9000 {
 			sram: sram@1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x8000>;	// 32K
+				ranges;
+				#address-cells = <1>;
+				#size-cells = <1>;
 			};
 
 			video: video@1e700000 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index a846df1a65ff..100380417f99 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -314,6 +314,9 @@ video: video@1e700000 {
 			sram: sram@1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x9000>;	// 36K
+				ranges;
+				#address-cells = <1>;
+				#size-cells = <1>;
 			};
 
 			sdmmc: sd-controller@1e740000 {

-- 
2.39.2


