Return-Path: <linux-kernel+bounces-175481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3D8C2049
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05C51C21AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FFC1635A0;
	Fri, 10 May 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="a83TjLka"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3415FA87;
	Fri, 10 May 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332194; cv=none; b=sluVcPXJOyroml6h+kMkBdXKRRFD+cVPvySK5FpYrVsc40OHRude99oaC9eJDKSjCJsMjOaUXxzDaDkxTrvSaW7gq07eagTDL/HImF0NjykAeFHC9jsywroN/MclOkBrM72E6YrLH2eRr7jUAoBmFBjxnU73JStUKzReqyNzLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332194; c=relaxed/simple;
	bh=R/flUDjC7E45Ro1CLhuh7HLFvXuauotSCCK43gootl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0vRCepROKZcESSp1crqvYVjSak0CDV0YPPHEF4YF05GVb0e/0X7HXIfLYsKHAluEWSF8oLHHrpD00kzI5ITknIYgkBcgbdkqC1kriCjFIyg02KX9u+9twcNQlNsUClvfVeg4eMe8rwV0MF2fgweItv+2bjc7DoUdc6lylBF/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=a83TjLka; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7E08A100007;
	Fri, 10 May 2024 12:09:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7E08A100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332183;
	bh=4LAsdWdLoSRoUuNtF2xx6rhDpJfhCRjC9Ooyt36Hl4E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=a83TjLkaZb+KyKIRUnbjAb073bX0NvqCZ0eZx/EoWJ9iVdnqeYV3yyPDaTkV9KMQL
	 Tj756QY1ziPxQefJr4yL+/owW3IXH6XjSR0212QJZx9lxtbgI+u8RKG/9tnEY9yf8+
	 i4Set7Hs++qZi9XMJck9nZdWSquEvTMuCakWwHODNk9lv1hcSBmhMVkCfkKU/VulRB
	 WH4DVLKDByr/NLB0FvZih6C1o47hBMvc8ctsEpSIoB9lIq5yBfhXBsXsbu3rgei/x9
	 QjXyaA9Ecgus9UvVPQdyXNqwnd06GF1O37fzGytsxruaa4WZTAhDVdCQkatN2+mtG6
	 ssJRWWR/vfmLg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:09:43 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 10 May 2024 12:09:42 +0300
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
Subject: [PATCH v2 2/7] dt-bindings: clock: meson: a1: pll: introduce new syspll bindings
Date: Fri, 10 May 2024 12:08:54 +0300
Message-ID: <20240510090933.19464-3-ddrokosov@salutedevices.com>
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

The 'syspll' PLL is a general-purpose PLL designed specifically for the
CPU clock. It is capable of producing output frequencies within the
range of 768MHz to 1536MHz.

The clock source sys_pll_div16, being one of the GEN clock parents,
plays a crucial role and cannot be tagged as "optional". Unfortunately,
it was not implemented earlier due to the cpu clock ctrl driver's
pending status on the TODO list.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml     | 7 +++++--
 include/dt-bindings/clock/amlogic,a1-pll-clkc.h            | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
index a59b188a8bf5..fbba57031278 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
@@ -26,11 +26,13 @@ properties:
     items:
       - description: input fixpll_in
       - description: input hifipll_in
+      - description: input syspll_in
 
   clock-names:
     items:
       - const: fixpll_in
       - const: hifipll_in
+      - const: syspll_in
 
 required:
   - compatible
@@ -53,7 +55,8 @@ examples:
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
index 2b660c0f2c9f..a702d610589c 100644
--- a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
+++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
@@ -21,5 +21,7 @@
 #define CLKID_FCLK_DIV5		8
 #define CLKID_FCLK_DIV7		9
 #define CLKID_HIFI_PLL		10
+#define CLKID_SYS_PLL		11
+#define CLKID_SYS_PLL_DIV16	12
 
 #endif /* __A1_PLL_CLKC_H */
-- 
2.43.0


