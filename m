Return-Path: <linux-kernel+bounces-283229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE68C94EEE1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBAD1C20EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4791862B8;
	Mon, 12 Aug 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aD2bCG63"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACB17E455;
	Mon, 12 Aug 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470779; cv=none; b=OHdGTn3nsp7ArqGSkSPX9OTy5RVhGxnPv5xHd5zupplXmEIEQbRomxxcxwwWhN1FeSrTrCcrqwCStyB7zvo/g/T+70oz0CjZ/3iZ+38VTj7cCn6b1l4tM1tyvda/yz3YxdfFf/F4K+Vp4hMmggEhK9m02fxfuSwQTPEOzHJ+4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470779; c=relaxed/simple;
	bh=7lLOec+tqWuWDgqhm72rbF2753MUbVsfUoEJ4mRWITo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1/LXR+yeWNxLq5ASYlBgMGvgor69C1MVvUzZikr8a4N+OxxhmdkJ2Fe3SgqHx18K7Ncu/J0+tC5ezuzG9oqYHxHE2cIBiMOBKlDgDv8TtA3515BVnwLKFfm4COQqAzD+DgWohRFRxliwg/kkMljbfmlm0I44gst6zKQGsfBixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aD2bCG63; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470777; x=1755006777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7lLOec+tqWuWDgqhm72rbF2753MUbVsfUoEJ4mRWITo=;
  b=aD2bCG63aPaUv2FAQD0glQS4+7TB/ubZ11H5oJTHkQefia7fWaHQR/GI
   VKtKNZKBB1EU2hLAn/BTaQn/wDr4kZWRzAeqf2zOyhrhyuiDDPH8lpHXU
   PtuCNhSWTPRrFt5Mh7EmZ2dfZKcpGwJeJSnMtHAGUtze2pMIP9cBU938V
   PXyh4vH5W/sNsZ+G4Lg2de6RgMkNNQ1jNrBvE7okVCid3q+NBErelmJWg
   YcewXmomI78d7nxprceOjpjNq4/4g+axu+MW1+vNo8sP/qh8F+2XADp7j
   45jAChlyBLjU7X6AmWcZCiYnaGSFQzrbI01iPWJAtpHadXG9iOvr1tAaT
   g==;
X-CSE-ConnectionGUID: s4TBmy++Rr+nQ8F2ugpKvw==
X-CSE-MsgGUID: hCfoJXzYQq21LoapNbJ71Q==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="261298076"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:52:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:52:49 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:52:46 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 4/7] ARM: dts: microchip: at91-sama7g54_curiosity: Add reg_5v to supply PMIC nodes
Date: Mon, 12 Aug 2024 16:52:28 +0300
Message-ID: <20240812135231.43744-5-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812135231.43744-1-andrei.simion@microchip.com>
References: <20240812135231.43744-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Align with the datasheet by adding regulator-5v which
supplies each node from the regulator using phandle to
regulator-5v through pvin[1-4]-supply and lvin-supply.

Co-developed-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- drop (lvin|pvin[1-4])-supply from each regulators sub-node
- add lvin-supply, pvin[1-4]-supply to PMIC node
---
 .../boot/dts/microchip/at91-sama7g54_curiosity.dts  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
index 009d2c832421..645e49fdb7fe 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
@@ -72,6 +72,14 @@ memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x10000000>; /* 256 MiB DDR3L-1066 16-bit */
 	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_MAIN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
 
 &adc {
@@ -189,6 +197,11 @@ eeprom@51 {
 		pmic@5b {
 			compatible = "microchip,mcp16502";
 			reg = <0x5b>;
+			lvin-supply = <&reg_5v>;
+			pvin1-supply = <&reg_5v>;
+			pvin2-supply = <&reg_5v>;
+			pvin3-supply = <&reg_5v>;
+			pvin4-supply = <&reg_5v>;
 
 			regulators {
 				vdd_3v3: VDD_IO {
-- 
2.34.1


