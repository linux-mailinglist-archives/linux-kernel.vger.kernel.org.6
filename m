Return-Path: <linux-kernel+bounces-180305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A608C6CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE661F220CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A44415B139;
	Wed, 15 May 2024 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Or96sAyO"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F1159216;
	Wed, 15 May 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800458; cv=none; b=uZ3LPHafnkbKE1UEjghS7y1+uyeMuAeX1DQsmnbUzYBWtZ8iYVAyfwgLV2G4dN/qCe+SD1wqH5tYbj7ifgqPgE7Uwu608cGuCpOTWJHISdgwi2HaNazmnPJ9BJLPtocp0kDCzWmtwEzM8WHJE22MBkok+tlPF//bMZSTWkFXao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800458; c=relaxed/simple;
	bh=EnWEGAIo9yWtRFNYkzSF4xXqtDKWIE3eqOPGZU9koBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCSfjMHkn3fc6XJ5eBNg4i1exsCvpgpBDxNt/VJbTEZep0FwnSXLippofp8dYBAwHvbBL6t7xqPLFjgCYICWjzPTurMa+D/SVnQfWr9IQ24wZ5+FAbz/aAUNANnWsKO1R0Opsoubpa0mbp8vcfovO0AxcIxZWufgAxj3S2N8diI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Or96sAyO; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 27141100030;
	Wed, 15 May 2024 22:14:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 27141100030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715800455;
	bh=NHE/cyJ4hjdoSsX5f+ngui3aX6kFyg54YIAFYbwdUE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Or96sAyOomR5tn99oXKtH2xYKJ04NsC5JjCzE/OqcsjPDg80e1ElekhD3SwtvWCBd
	 lXZqBMam5qENYy+D1jDTZ4hMwLzEiZYiM0p+S9ERVbnGuDJI7yg/GOqP4l3nJ+eTH4
	 BCQgsfcLHhyaFh6WFJeH0Is9RRs0wUX/sQdTfWpzNbHAOuttZt2rgBmd0dvRVhRNl6
	 TlbbhKlIlyOFPCuVj+1DGzRSQ8V/s5IT7ssUXqi/hMl9aeKXV3teIsZ6P1Cnwr1PwB
	 083epMQi4zvyeNCDG1tH/la8ZrHIEgJ0ndEWmyueYaItNusZRjQsMs1UAZznyU/8eD
	 VRmnMdZCUpOxA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 15 May 2024 22:14:14 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 15 May 2024 22:14:14 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v3 4/4] arm64: dts: amlogic: a1: setup CPU power management
Date: Wed, 15 May 2024 22:13:53 +0300
Message-ID: <20240515191405.25395-5-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515191405.25395-1-ddrokosov@salutedevices.com>
References: <20240515191405.25395-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185260 [May 15 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/15 13:12:00 #25231738
X-KSMG-AntiVirus-Status: Clean, skipped

The Amlogic A1 SoC family utilizes static operating points and a
PWM-controlled core voltage regulator, which is specific to the board.
As the main CPU clock input, the SoC uses CLKID_CPU_CLK from the CPU
clock controller, which can be inherited from the system PLL (syspll) or
a fixed CPU clock.

Currently, the stable operating points at all frequencies are set to
800mV. This value is obtained from the vendor setup of several A1
boards.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index f73bb7d1f381..5746c6a5b07b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -33,6 +33,13 @@ cpu0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&clkc_cpu CLKID_CPU_CLK>;
+			clock-names = "core_clk";
+			operating-points-v2 = <&cpu_opp_table0>;
+			voltage-tolerance = <0>;
+			clock-latency = <50000>;
+			capacity-dmips-mhz = <400>;
+			dynamic-power-coefficient = <80>;
 			#cooling-cells = <2>;
 		};
 
@@ -42,6 +49,13 @@ cpu1: cpu@1 {
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&clkc_cpu CLKID_CPU_CLK>;
+			clock-names = "core_clk";
+			operating-points-v2 = <&cpu_opp_table0>;
+			voltage-tolerance = <0>;
+			clock-latency = <50000>;
+			capacity-dmips-mhz = <400>;
+			dynamic-power-coefficient = <80>;
 			#cooling-cells = <2>;
 		};
 
@@ -52,6 +66,36 @@ l2: l2-cache0 {
 		};
 	};
 
+	cpu_opp_table0: cpu_opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <128000000>;
+			opp-microvolt = <800000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <256000000>;
+			opp-microvolt = <800000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <512000000>;
+			opp-microvolt = <800000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <768000000>;
+			opp-microvolt = <800000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <800000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <800000>;
+		};
+	};
+
 	efuse: efuse {
 		compatible = "amlogic,meson-gxbb-efuse";
 		clocks = <&clkc_periphs CLKID_OTP>;
-- 
2.43.0


