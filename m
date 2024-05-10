Return-Path: <linux-kernel+bounces-175483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FC38C204E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C837283509
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B90161333;
	Fri, 10 May 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="bUKOe5kH"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71714901F;
	Fri, 10 May 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332194; cv=none; b=ca4j1/FOh4MmQisPP74wImuZK+Hu8vrw0/DqVmc0hdxVR2oGS6r8lN8seIxWV4J9ZL15iPv6L4hbAKqgBelSt8WzgdUiLAIVFF88IWUpgKiq4I32CAWOr5+C8V/fnDvkFjni+MWxaoJzYSH9JyvxN6tWMK01+sq6+cXswgKiSgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332194; c=relaxed/simple;
	bh=WxIHWt2At18iZIu85GEtNSbGyvOiKEBbJJHWEJIIdGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VT17Wh5hZRrWDegfG/TdEFNbq01Qpe0NXmwDJJA4JD+AP62TvSmTphvPzD31WN5YmiyqIJ7QZVYx/8sFbu0T0EKn2TMwmxBY9hBwKIyjBjmDC2+2jO2q1vG8FwSqawvU6BhisOCxgFc2So5m1sCNIYmf9aE3rx2ybULsyy2bT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=bUKOe5kH; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B1239120003;
	Fri, 10 May 2024 12:09:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B1239120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332182;
	bh=kenYwxHSLcsF+T4CqCh8V0qfGGxx4+VErvJtu5XBCjo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=bUKOe5kHnlYBn5qL6M/OelehJqJLVZ4tQgLy8jYLcrLHRiczSFJE4EJxL+BSfTpNR
	 2DFuw8tHlm8t+ojO7nvIEf4IaqirBnJqanzh6/nT29qlvLlHBRaUtn1jpK/ErIkFtp
	 njLDnV3Y2/TD0qOc67BZ7Bs9Cn5zq7yoYkY9kPjQwkfXRRHSgbshxkwNKX2kytqqPX
	 5lgDwqOz45bmSMqcKSebO0ua7ZKdagIIz9F5kMMNK0QnQHYL6vQfX2fj9g6cvgqf9i
	 AC+cDyEVmpCqqnSEimlasQaNBDzhLh8CHBYNbU13pj3df+IihijWKYN7hKaWflyYwT
	 PMsLEiUHcEuxw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:09:42 +0300 (MSK)
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
Subject: [PATCH v2 1/7] clk: meson: introduce 'INIT_ONCE' flag to eliminate init for enabled PLL
Date: Fri, 10 May 2024 12:08:53 +0300
Message-ID: <20240510090933.19464-2-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/10 07:36:00 #25144647
X-KSMG-AntiVirus-Status: Clean, skipped

When dealing with certain PLLs, it is necessary to avoid modifying them
if they have already been initialized by lower levels. For instance, in
the A1 SoC Family, the sys_pll is enabled as the parent for the cpuclk,
and it cannot be disabled during the initialization sequence. Therefore,
initialization phase must be skipped.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/clk/meson/clk-pll.c | 37 +++++++++++++++++++++----------------
 drivers/clk/meson/clk-pll.h |  1 +
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 78d17b2415af..47b22a6be2e4 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -289,11 +289,32 @@ static int meson_clk_pll_wait_lock(struct clk_hw *hw)
 	return -ETIMEDOUT;
 }
 
+static int meson_clk_pll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+
+	if (MESON_PARM_APPLICABLE(&pll->rst) &&
+	    meson_parm_read(clk->map, &pll->rst))
+		return 0;
+
+	if (!meson_parm_read(clk->map, &pll->en) ||
+	    !meson_parm_read(clk->map, &pll->l))
+		return 0;
+
+	return 1;
+}
+
 static int meson_clk_pll_init(struct clk_hw *hw)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
+	/* Do not init already enabled PLL which marked with 'init_once' */
+	if ((pll->flags & CLK_MESON_PLL_INIT_ONCE) &&
+	    meson_clk_pll_is_enabled(hw))
+		return 0;
+
 	if (pll->init_count) {
 		if (MESON_PARM_APPLICABLE(&pll->rst))
 			meson_parm_write(clk->map, &pll->rst, 1);
@@ -308,22 +329,6 @@ static int meson_clk_pll_init(struct clk_hw *hw)
 	return 0;
 }
 
-static int meson_clk_pll_is_enabled(struct clk_hw *hw)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-
-	if (MESON_PARM_APPLICABLE(&pll->rst) &&
-	    meson_parm_read(clk->map, &pll->rst))
-		return 0;
-
-	if (!meson_parm_read(clk->map, &pll->en) ||
-	    !meson_parm_read(clk->map, &pll->l))
-		return 0;
-
-	return 1;
-}
-
 static int meson_clk_pcie_pll_enable(struct clk_hw *hw)
 {
 	int retries = 10;
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index a2228c0fdce5..23195ea4eae1 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -28,6 +28,7 @@ struct pll_mult_range {
 	}
 
 #define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
+#define CLK_MESON_PLL_INIT_ONCE		BIT(1)
 
 struct meson_clk_pll_data {
 	struct parm en;
-- 
2.43.0


