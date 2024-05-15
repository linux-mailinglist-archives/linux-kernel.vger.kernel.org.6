Return-Path: <linux-kernel+bounces-180280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998228C6C63
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE21B228DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F116715AD90;
	Wed, 15 May 2024 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="t4v5tbr5"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF1158DBC;
	Wed, 15 May 2024 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799084; cv=none; b=hRIeCYtCUeCni5ZX3Bh0Oj8oWJPL7uh2+P97O7PaIpFshy5/KWoCTZduat2C7xjq5ZO4LZm8gRwrx3EOuoUtE0xlFD7ivBk7oTerM0Ndsn6fLSyKOkqCOyWjfAO2VylnFjpXYhG9V4tkIzGH1yvA1nx9kpFVALbHK1CHmSDehVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799084; c=relaxed/simple;
	bh=5AJ9Az0jH6thLKSUMJAMaGVEa07l9Uyn4Cv5T2FSOb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRDAPBLWhJ2A1m8V97hXJRSs+zUPJd6bhRm9aHIxK8L5smX0fkIZ8aXe9sSrXm+6smYYBgGuT+lKGPwBVl3niRgdAPQ0O239jmP6PuNAk2zOShgcYRrr69ewU20dCY3wBrapHszt/cNXV+HsKScVbRyrJowysGT8E295BXDVPGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=t4v5tbr5; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id EDF2F12002A;
	Wed, 15 May 2024 21:51:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EDF2F12002A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715799073;
	bh=QMAt1ZjzhOa+8fsvoVbTc9wPD8ylKr2Pv+Hu9aMn9q8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=t4v5tbr54qe2OwX475AN7ahXxy0TnC3bb5p8iCnctvxdKFwGyjdq/AT5FlIpA/7bM
	 F6ba+fuDekQozD8Dqq02Ta3+umyqi3Z6ou9L1BLWMsmLCSF84iUNTZa8ZWNdkcVwu1
	 CH2KS7knzhP1Lh2UHaQr0SYsr322I+elPgSIfTymeJUzSuxLSWHTrTC+UNt+xYVmt/
	 p3TsiIKDct37hMdEfW0YgW9nKJibc+Nl8mQjkoJ62O48mK4B9/m2W5CCfOaJ7e4TKE
	 lQ86fcKTIGFYO7oWCCNbNvdvVriBXMD1KV9XPRR9OdHqDDxNzrP8TTeMopmmSeNOBV
	 e9CXnrPqOe7Pw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 15 May 2024 21:51:13 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 15 May 2024 21:51:13 +0300
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
Subject: [PATCH v3 2/7] dt-bindings: clock: meson: a1: pll: introduce new syspll bindings
Date: Wed, 15 May 2024 21:47:25 +0300
Message-ID: <20240515185103.20256-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515185103.20256-1-ddrokosov@salutedevices.com>
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 185260 [May 15 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/15 13:12:00 #25231738
X-KSMG-AntiVirus-Status: Clean, skipped

The 'syspll' PLL is a general-purpose PLL designed specifically for the
CPU clock. It is capable of producing output frequencies within the
range of 768MHz to 1536MHz.

The 'syspll_in' source clock is an optional parent connection from the
peripherals clock controller.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml   | 9 +++++++--
 include/dt-bindings/clock/amlogic,a1-pll-clkc.h          | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
index a59b188a8bf5..c99274d2a9bd 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
@@ -26,11 +26,15 @@ properties:
     items:
       - description: input fixpll_in
       - description: input hifipll_in
+      - description: input syspll_in
+    minItems: 2 # syspll_in is optional
 
   clock-names:
     items:
       - const: fixpll_in
       - const: hifipll_in
+      - const: syspll_in
+    minItems: 2 # syspll_in is optional
 
 required:
   - compatible
@@ -53,7 +57,8 @@ examples:
             reg = <0 0x7c80 0 0x18c>;
             #clock-cells = <1>;
             clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
-                     <&clkc_periphs CLKID_HIFIPLL_IN>;
-            clock-names = "fixpll_in", "hifipll_in";
+                     <&clkc_periphs CLKID_HIFIPLL_IN>,
+                     <&clkc_periphs CLKID_SYSPLL_IN>;
+            clock-names = "fixpll_in", "hifipll_in", "syspll_in";
         };
     };
diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
index 2b660c0f2c9f..0dfc5e78a2d5 100644
--- a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
+++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
@@ -21,5 +21,6 @@
 #define CLKID_FCLK_DIV5		8
 #define CLKID_FCLK_DIV7		9
 #define CLKID_HIFI_PLL		10
+#define CLKID_SYS_PLL		11
 
 #endif /* __A1_PLL_CLKC_H */
-- 
2.43.0


