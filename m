Return-Path: <linux-kernel+bounces-173438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09A8C006A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426311F2385D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B775112C47C;
	Wed,  8 May 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="kEUeKlv/"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE012AAE8;
	Wed,  8 May 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179420; cv=none; b=YYB/AXnGsJ4q1Mazmy6r8d9lBMUahx34xbW2MGj3T2IVUne86s0ztOlOp7EjhG+U5PVFsYJucZNvwQRgiwt7vhN/AQvGbO34x/dywa+mBHVnwfxlTILdbvfNQyyIxfPuTTlzCHEZ/7LOVo6orHtGihX9AEAzXukKJiOLMdghUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179420; c=relaxed/simple;
	bh=8fDEaHZkRK4IbIx+fYB1auelBe5XByxusmIoXmUAo0w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCsvd7/VpaH1q3hrZELkU9akyrUfbLmo2p28sq6BbQw3+YAcKaZ/rwwJBksTj9cTVYTrkamDns7UKh66YoidTRtmDFuQuU+MH3LEm0eY5ev2iQHP3gCaSxj5zQ8WQRRJxVtlRV6O8TYjJqQepGHylouHTarcwxqq/8N7cUo17wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=kEUeKlv/; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 48865120009;
	Wed,  8 May 2024 17:43:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 48865120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715179411;
	bh=dPTQ5jSK4GuvZkaC4CcDsLe0bIyiB7GSHolMaGJlw4o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kEUeKlv/yE2HEOyTPf0AVj8BR7EDRY/5Sah9zNduGC/k4g2zobGQT/Pqco29sEyuR
	 jkBuv7IqoMsxp3koePxkDiY5gXLz7w1jxiWyJamYh2piLlrXga/0O7+uzWIZ3Z/ADr
	 k6oU1J4BfIYHNOUzG3WCSe55fi1+1TO/bXr34UNxE/grVF9CJD7Ke6tSLic/c7bQkW
	 bZ+AcWdxo1PXUahN5ms4aVhO+/31AByXZjhIlpJjjpUKz1LCcVdgYiKnBI/TwoF6Bz
	 I9346z/qLO2QxMek1E5/ZP1tJdBYhHGVYm15Dq9j/6zYPSDgD7u/trNMYsmAoLJcAC
	 MoJvcyy20eX3Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  8 May 2024 17:43:31 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 8 May 2024 17:43:30 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: [APPROACH 2 1/2] arm64: dts: amlogic: list all slave clocks for audio clock controller
Date: Wed, 8 May 2024 17:42:58 +0300
Message-ID: <20240508144259.191843-3-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508144259.191843-1-jan.dakinevich@salutedevices.com>
References: <20240508144259.191843-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185143 [May 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_smtp_not_equal_from}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/08 09:52:00 #25122865
X-KSMG-AntiVirus-Status: Clean, skipped

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 27 ++++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi | 26 +++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 26 +++++++++++++++++++--
 3 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6d12b760b90f..28f4ec5f39b0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1342,7 +1342,9 @@ clkc_audio: clock-controller@0 {
 					 <&clkc CLKID_HIFI_PLL>,
 					 <&clkc CLKID_FCLK_DIV3>,
 					 <&clkc CLKID_FCLK_DIV4>,
-					 <&clkc CLKID_GP0_PLL>;
+					 <&clkc CLKID_GP0_PLL>,
+					 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>,
+					 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>;
 				clock-names = "pclk",
 					      "mst_in0",
 					      "mst_in1",
@@ -1351,7 +1353,28 @@ clkc_audio: clock-controller@0 {
 					      "mst_in4",
 					      "mst_in5",
 					      "mst_in6",
-					      "mst_in7";
+					      "mst_in7",
+					      "slv_sclk0",
+					      "slv_sclk1",
+					      "slv_sclk2",
+					      "slv_sclk3",
+					      "slv_sclk4",
+					      "slv_sclk5",
+					      "slv_sclk6",
+					      "slv_sclk7",
+					      "slv_sclk8",
+					      "slv_sclk9",
+					      "slv_lrclk0",
+					      "slv_lrclk1",
+					      "slv_lrclk2",
+					      "slv_lrclk3",
+					      "slv_lrclk4",
+					      "slv_lrclk5",
+					      "slv_lrclk6",
+					      "slv_lrclk7",
+					      "slv_lrclk8",
+					      "slv_lrclk9";
+
 
 				resets = <&reset RESET_AUDIO>;
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
index e732df3f3114..af99781f3c4e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
@@ -82,7 +82,9 @@ clkc_audio: clock-controller@0 {
 				 <&clkc CLKID_HIFI_PLL>,
 				 <&clkc CLKID_FCLK_DIV3>,
 				 <&clkc CLKID_FCLK_DIV4>,
-				 <&clkc CLKID_GP0_PLL>;
+				 <&clkc CLKID_GP0_PLL>,
+				 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>,
+				 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>;
 			clock-names = "pclk",
 				      "mst_in0",
 				      "mst_in1",
@@ -91,7 +93,27 @@ clkc_audio: clock-controller@0 {
 				      "mst_in4",
 				      "mst_in5",
 				      "mst_in6",
-				      "mst_in7";
+				      "mst_in7",
+				      "slv_sclk0",
+				      "slv_sclk1",
+				      "slv_sclk2",
+				      "slv_sclk3",
+				      "slv_sclk4",
+				      "slv_sclk5",
+				      "slv_sclk6",
+				      "slv_sclk7",
+				      "slv_sclk8",
+				      "slv_sclk9",
+				      "slv_lrclk0",
+				      "slv_lrclk1",
+				      "slv_lrclk2",
+				      "slv_lrclk3",
+				      "slv_lrclk4",
+				      "slv_lrclk5",
+				      "slv_lrclk6",
+				      "slv_lrclk7",
+				      "slv_lrclk8",
+				      "slv_lrclk9";
 
 			resets = <&reset RESET_AUDIO>;
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 643f94d9d08e..24e520c3e2a6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -162,7 +162,9 @@ clkc_audio: clock-controller@0 {
 				 <&clkc CLKID_HIFI_PLL>,
 				 <&clkc CLKID_FCLK_DIV3>,
 				 <&clkc CLKID_FCLK_DIV4>,
-				 <&clkc CLKID_FCLK_DIV5>;
+				 <&clkc CLKID_FCLK_DIV5>,
+				 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>,
+				 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>;
 			clock-names = "pclk",
 				      "mst_in0",
 				      "mst_in1",
@@ -171,7 +173,27 @@ clkc_audio: clock-controller@0 {
 				      "mst_in4",
 				      "mst_in5",
 				      "mst_in6",
-				      "mst_in7";
+				      "mst_in7",
+				      "slv_sclk0",
+				      "slv_sclk1",
+				      "slv_sclk2",
+				      "slv_sclk3",
+				      "slv_sclk4",
+				      "slv_sclk5",
+				      "slv_sclk6",
+				      "slv_sclk7",
+				      "slv_sclk8",
+				      "slv_sclk9",
+				      "slv_lrclk0",
+				      "slv_lrclk1",
+				      "slv_lrclk2",
+				      "slv_lrclk3",
+				      "slv_lrclk4",
+				      "slv_lrclk5",
+				      "slv_lrclk6",
+				      "slv_lrclk7",
+				      "slv_lrclk8",
+				      "slv_lrclk9";
 
 			resets = <&reset RESET_AUDIO>;
 		};
-- 
2.34.1


