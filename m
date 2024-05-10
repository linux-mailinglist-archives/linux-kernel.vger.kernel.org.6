Return-Path: <linux-kernel+bounces-175482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172478C204C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D9D1C219D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486471635B6;
	Fri, 10 May 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="mThEhfuJ"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560CD15FA9E;
	Fri, 10 May 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332194; cv=none; b=ibTyTQ+bJcRlnX5uUVX9f+YbxRIeh8OvSoN2KCssQuNjSAj0gbCPvYCJZGgXvaQgXG7yY2qNDo9AW1Vk2VYk594izHi1poI9ZPaX5K6PonlJdr6pfURUjqjENVFzyLx9zea4hsGjQpRbiCaXRZaFSoAwBOBfRNrlQW/ZKSA9pSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332194; c=relaxed/simple;
	bh=OYod/8QZPu6lEa1SO6w93X1ktdbo8T9IzAiCI3Gn+ts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQpjbUomYdckFWjueB/qGzY8cllk3dNvmO4wTcJc47AAsPyrAm5lyX9qy5djpgejjR6HSbtKKocm5Jsqir2Ln7Xt4scOCLHEo8dZh1FCP+ZRYlLf/NBh43WK+L+aAAhWKYuk/Douh6PpwLk77TdqjATh8iLkwaPO7kgIWqzrzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=mThEhfuJ; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 29605120004;
	Fri, 10 May 2024 12:09:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 29605120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332184;
	bh=ysqlKZDJk6khsAfPYCMd+pkQw00jRSjn6P2lL1u8bvs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mThEhfuJtwBprPovby/y2gJJGATkU+wAYzrQsFo4AWvOQReUZvtMwgbuw+ZlHwe7i
	 XeQr1ufuSYJ/KpK1H/tQ9gbhVP0zr0C59/GgHGh1WDFIkwggWEHYVgeNTDajxud7Vr
	 m64WaUm5L9/YH+sGKMYjP3lYh3xA1I8gGKZ8fWO5rqyCe9zhlYZ0Q4Y396Y9MAMLGk
	 AmKiXrnbwk0gifPuHCEj8BFB4xzgDQ+xgwlEM/RwC1Kk7HJ+n/s8GsY/yXp/GM65kA
	 e5olw+0KBAkX2r9gA4dLs00onSyjyl3zEDUd05xKQRI7U5BFhU0MH1MaU21ZFVJIL3
	 yI8dvOv+QAdQA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:09:44 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 10 May 2024 12:09:43 +0300
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
Subject: [PATCH v2 3/7] clk: meson: a1: pll: support 'syspll' general-purpose PLL for CPU clock
Date: Fri, 10 May 2024 12:08:55 +0300
Message-ID: <20240510090933.19464-4-ddrokosov@salutedevices.com>
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

The 'syspll' PLL, also known as the system PLL, is a general and
essential PLL responsible for generating the CPU clock frequency.
With its wide-ranging capabilities, it is designed to accommodate
frequencies within the range of 768MHz to 1536MHz.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/clk/meson/a1-pll.c | 79 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/a1-pll.h |  6 +++
 2 files changed, 85 insertions(+)

diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
index 60b2e53e7e51..af47ba308bbe 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -138,6 +138,82 @@ static struct clk_regmap hifi_pll = {
 	},
 };
 
+static const struct pll_mult_range sys_pll_mult_range = {
+	.min = 32,
+	.max = 64,
+};
+
+static const struct reg_sequence sys_pll_init_regs[] = {
+	{ .reg = ANACTRL_SYSPLL_CTRL1, .def = 0x01800000 },
+	{ .reg = ANACTRL_SYSPLL_CTRL2, .def = 0x00001100 },
+	{ .reg = ANACTRL_SYSPLL_CTRL3, .def = 0x10022300 },
+	{ .reg = ANACTRL_SYSPLL_CTRL4, .def = 0x00300000 },
+	{ .reg = ANACTRL_SYSPLL_CTRL0, .def = 0x01f18432 },
+};
+
+static struct clk_regmap sys_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = ANACTRL_SYSPLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = ANACTRL_SYSPLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = ANACTRL_SYSPLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = ANACTRL_SYSPLL_CTRL1,
+			.shift   = 0,
+			.width   = 19,
+		},
+		.l = {
+			.reg_off = ANACTRL_SYSPLL_STS,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.current_en = {
+			.reg_off = ANACTRL_SYSPLL_CTRL0,
+			.shift   = 26,
+			.width   = 1,
+		},
+		.l_detect = {
+			.reg_off = ANACTRL_SYSPLL_CTRL2,
+			.shift   = 6,
+			.width   = 1,
+		},
+		.range = &sys_pll_mult_range,
+		.init_regs = sys_pll_init_regs,
+		.init_count = ARRAY_SIZE(sys_pll_init_regs),
+		.flags = CLK_MESON_PLL_INIT_ONCE,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_pll",
+		.ops = &meson_clk_pll_ops,
+		.parent_names = (const char *[]){ "syspll_in" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor sys_pll_div16 = {
+	.mult = 1,
+	.div = 16,
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_pll_div16",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sys_pll.hw
+		},
+		.num_parents = 1,
+	},
+};
+
 static struct clk_fixed_factor fclk_div2_div = {
 	.mult = 1,
 	.div = 2,
@@ -283,6 +359,8 @@ static struct clk_hw *a1_pll_hw_clks[] = {
 	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
 	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
 	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
+	[CLKID_SYS_PLL]		= &sys_pll.hw,
+	[CLKID_SYS_PLL_DIV16]	= &sys_pll_div16.hw,
 };
 
 static struct clk_regmap *const a1_pll_regmaps[] = {
@@ -293,6 +371,7 @@ static struct clk_regmap *const a1_pll_regmaps[] = {
 	&fclk_div5,
 	&fclk_div7,
 	&hifi_pll,
+	&sys_pll,
 };
 
 static struct regmap_config a1_pll_regmap_cfg = {
diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
index 4be17b2bf383..666d9b2137e9 100644
--- a/drivers/clk/meson/a1-pll.h
+++ b/drivers/clk/meson/a1-pll.h
@@ -18,6 +18,12 @@
 #define ANACTRL_FIXPLL_CTRL0	0x0
 #define ANACTRL_FIXPLL_CTRL1	0x4
 #define ANACTRL_FIXPLL_STS	0x14
+#define ANACTRL_SYSPLL_CTRL0	0x80
+#define ANACTRL_SYSPLL_CTRL1	0x84
+#define ANACTRL_SYSPLL_CTRL2	0x88
+#define ANACTRL_SYSPLL_CTRL3	0x8c
+#define ANACTRL_SYSPLL_CTRL4	0x90
+#define ANACTRL_SYSPLL_STS	0x94
 #define ANACTRL_HIFIPLL_CTRL0	0xc0
 #define ANACTRL_HIFIPLL_CTRL1	0xc4
 #define ANACTRL_HIFIPLL_CTRL2	0xc8
-- 
2.43.0


