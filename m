Return-Path: <linux-kernel+bounces-272319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA65945A3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D07D1C20C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8091C3F18;
	Fri,  2 Aug 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RF+T/9Qf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E71C379B;
	Fri,  2 Aug 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588336; cv=none; b=ZTsxzUGw1cw6/+Y06aMRS7ZL9BGilFqQ6eZcZRAFYabo2oSTLXwislVFNfTcvdW3AJQhaSaBkAeBSglsUATljJMKob+INH7ANbpxwbVoFkmOiz++/o0k0g6zf6RXWQH7AaF1+bTVMwSUk/GQ26SKSvR69IAaP2WMcw0R+tx645M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588336; c=relaxed/simple;
	bh=gbJKuHhR/KahO1qpKw2thlztzGIJzCMfBEoQ+GU4n5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhYo67dFZbb2ncfJf/+mnO+MGbaSfV+u89nXfV0dNO7msizMtusu78T4SG+DaJU2TuizcAl3lJq7LTAOWe/nVAs/2oZlF27P6aIdBFKZNuOcgrvboSBNTkeIGACh4xaBcLROWJiyAP/kXUnV3N/myOavJ9VssWTCUEm873vtbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RF+T/9Qf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722588335; x=1754124335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gbJKuHhR/KahO1qpKw2thlztzGIJzCMfBEoQ+GU4n5A=;
  b=RF+T/9QfZLcfVceATYgJPKTqlSa1ZT+UGyToOh0mvdbFU63+ro1C+P8i
   /hmSOa0ffSfC1tvNvM/NtPOehuNsMK8tQN7HV9jbfpctKBYXG2lgCte4R
   8+3O7XCU0P0pC5gW7rZbWhHELbiWhCGm4ASKx3432vM5DA5aeztwL11ag
   VAkWA3kwql3kSIPXJUBraDmu4JcS4F78yridL5tD7fQBNY/W2o0N9FQ9J
   iPIlmQnfbc8/inJUk6VYofJtCrOd0waUb3gJEv9UFT3CO2VvouYqZgWWb
   L3L0nU3NnBKAnf8YfCX9xiqZcZwsmcc+ACXUI299FLGYcdi1Vr8evF7jS
   g==;
X-CSE-ConnectionGUID: LYEUG+dsQgOZlljD5sjyvQ==
X-CSE-MsgGUID: Kd6pJT2eShWo7n3tzbH+yg==
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="30020952"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2024 01:45:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Aug 2024 01:44:55 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Aug 2024 01:44:52 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 3/6] ARM: dts: microchip: at91-sama7g54_curiosity: Add reg_5v to supply PMIC nodes
Date: Fri, 2 Aug 2024 11:44:30 +0300
Message-ID: <20240802084433.20958-4-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802084433.20958-1-andrei.simion@microchip.com>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Align with the datasheet by adding regulator-5v which supplies
each node from the regulator using phandle to regulator-5v through
pvin[1-4]-supply and lvin-supply.

Co-developed-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 .../boot/dts/microchip/at91-sama7g54_curiosity.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
index 009d2c832421..b1bdfc67aa6e 100644
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
@@ -193,6 +201,7 @@ pmic@5b {
 			regulators {
 				vdd_3v3: VDD_IO {
 					regulator-name = "VDD_IO";
+					pvin1-supply = <&reg_5v>;
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-initial-mode = <2>;
@@ -213,6 +222,7 @@ regulator-state-mem {
 
 				vddioddr: VDD_DDR {
 					regulator-name = "VDD_DDR";
+					pvin2-supply = <&reg_5v>;
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
 					regulator-initial-mode = <2>;
@@ -234,6 +244,7 @@ regulator-state-mem {
 
 				vddcore: VDD_CORE {
 					regulator-name = "VDD_CORE";
+					pvin3-supply = <&reg_5v>;
 					regulator-min-microvolt = <1150000>;
 					regulator-max-microvolt = <1150000>;
 					regulator-initial-mode = <2>;
@@ -254,6 +265,7 @@ regulator-state-mem {
 
 				vddcpu: VDD_OTHER {
 					regulator-name = "VDD_OTHER";
+					pvin4-supply = <&reg_5v>;
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1250000>;
 					regulator-initial-mode = <2>;
@@ -275,6 +287,7 @@ regulator-state-mem {
 
 				vldo1: LDO1 {
 					regulator-name = "LDO1";
+					lvin-supply = <&reg_5v>;
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					regulator-always-on;
@@ -291,6 +304,7 @@ regulator-state-mem {
 
 				vldo2: LDO2 {
 					regulator-name = "LDO2";
+					lvin-supply = <&reg_5v>;
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
-- 
2.34.1


