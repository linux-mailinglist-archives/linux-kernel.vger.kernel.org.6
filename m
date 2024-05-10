Return-Path: <linux-kernel+bounces-175484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F138C204F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FA81F22CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA81635DD;
	Fri, 10 May 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="KZV+H0G3"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90E38396;
	Fri, 10 May 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332195; cv=none; b=VqgnmAr8AvJ+jcamZ/D1BUH5CikHghtCi1QLtbs/DxIJUaq8BmrZ3hk4j3XwkrPmlKgRyAb0V0Gp52T4YTaUEQ0qfRjyWCc2qhg+BZgbhqkPAyl2SaRi825jNVrDf0D26mnHK/ydzVpWJW8hqQrQ4TGP0dALWWl3RhEQwtmGNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332195; c=relaxed/simple;
	bh=E+1p+LGkUfmN1bsy9rTBuhcNL3tQCxaxUPkvKPTk/l4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uI7X8T1g5AMFaXuYx1JWFtt0sEueMnwzeTNfFxhNXrGUzUBdMNFzSvCRSyFvTPTiq5i8eWO6Q2e7QwqegC1zcSlv594FOVydrYk00yAMzEWZGi8phEvAFDE1gycBK1ctV1KuSDzmoCJ0Qt0elok8EujBiSj5QD/AwN240A23RYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=KZV+H0G3; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BB218100008;
	Fri, 10 May 2024 12:09:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BB218100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332184;
	bh=DYdJx4qVoqJXoc9CWf41h3URDnGHF1yW+XqV/nDou90=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=KZV+H0G3f4p2XgZ3BDEC6sivxAmuTsSXaBPaF/Pb31NRyMeAb9tT/UNQ3xs+BKnIw
	 xeu9QKWezqV0sS6RkaZ9TQgJe2JYeNdypX8YKHCGJ7XZg2Xf2NlD/8ZBEdal9X9k+A
	 oJGXw8UM3JgK7mZBJEWobcL5KA9QKyOHuuGu0hRjImTlogrNoxxBbrBUM5eJcP2Wwt
	 MzBRmOL8t/yGgT63YRGsagcOuhJCBeaHMVH1Jq12lYI3cvm/OBdqk2/hAnAoDPNAJj
	 oeDj+fWjedHus7ELnYCaWL6eduHdKyRuQ6P2VXzVaoZaQ7ycPcE+8To/AlurrbNoqP
	 aorTqgY7XosJw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:09:44 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 10 May 2024 12:09:44 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <jian.hu@amlogic.com>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v2 4/7] dt-bindings: clock: meson: a1: peripherals: support sys_pll_div16 input
Date: Fri, 10 May 2024 12:08:56 +0300
Message-ID: <20240510090933.19464-5-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510090933.19464-1-ddrokosov@salutedevices.com>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 185158 [May 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/10 07:36:00 #25144647
X-KSMG-AntiVirus-Status: Clean, skipped

The 'sys_pll_div16' input clock is used as one of the sources for the
GEN clock.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../bindings/clock/amlogic,a1-peripherals-clkc.yaml        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
index 6d84cee1bd75..11862746ba44 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
@@ -30,6 +30,7 @@ properties:
       - description: input fixed pll div7
       - description: input hifi pll
       - description: input oscillator (usually at 24MHz)
+      - description: input sys pll div16
 
   clock-names:
     items:
@@ -39,6 +40,7 @@ properties:
       - const: fclk_div7
       - const: hifi_pll
       - const: xtal
+      - const: sys_pll_div16
 
 required:
   - compatible
@@ -65,9 +67,10 @@ examples:
                      <&clkc_pll CLKID_FCLK_DIV5>,
                      <&clkc_pll CLKID_FCLK_DIV7>,
                      <&clkc_pll CLKID_HIFI_PLL>,
-                     <&xtal>;
+                     <&xtal>,
+                     <&clkc_pll CLKID_SYS_PLL_DIV16>;
             clock-names = "fclk_div2", "fclk_div3",
                           "fclk_div5", "fclk_div7",
-                          "hifi_pll", "xtal";
+                          "hifi_pll", "xtal", "sys_pll_div16";
         };
     };
-- 
2.43.0


