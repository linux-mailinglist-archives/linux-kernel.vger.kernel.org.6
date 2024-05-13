Return-Path: <linux-kernel+bounces-178108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA4A8C48D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0CC1F22F83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23583A01;
	Mon, 13 May 2024 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="I0ZW+RNp"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD978286D;
	Mon, 13 May 2024 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635543; cv=none; b=kCz7vmaasdda0mtPQqiHGTuheM6puTICV0ykxgZ072DedSBj+VjnMEaVKxnG10T3venpTF2rVTsrHwOxgVxzSC02feZgo6nUrWeVq0c0UwvNam3g239V3pZaYaQQo+rUV9+tAUXUKswi3YC2KED14rp0jlNVNrHT2tnTZIdzKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635543; c=relaxed/simple;
	bh=MzhTbprSQLqOI+laf2qD+RvVg0d6t/v5yVZZpJ5h5/M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP0Ws0SovJXCWQu4u44RgGQPJEc7yNR9SsW/IY/yDEKzSOCq1m4SJz2C2Lov4NYXVjNM+CorwFHFy7LbOPoRmH5S0RS5X0VN03SjoHOWVaps7pJlo7B5tnxaKxj1M3/XjW/f/4/tjvLSSKgth2W44uYbBC86VQoiT0VFgYCLhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=I0ZW+RNp; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 57F4B100011;
	Tue, 14 May 2024 00:25:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 57F4B100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715635536;
	bh=r7SrJKEdQaaLZ05rUgArc6iICQjCjkK9+wcS/jo51HY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=I0ZW+RNpOUgCHib9lsfv9K0l8cDHtIVVHW3wYar+df68uIjJRogr+Gvu7sv/mmHd3
	 nhgXfqORX1AuwdZiTKcg5A6ApvJjOePH6c8r6csQyQiJTvc05tif/+Xz2GSCm4ZkL/
	 RKAXQqbxc7b5J4lT+0Ook9EblY06AcIwvQK/C+pCyvnVEBIDhND8VPHe4OlPoUtuHU
	 9ZgQC/bitP0GgmejwSfXRv0c3ZBkNUxnxDubNprWRhFNJ2CseN7xQT5seiWO1RDWmZ
	 O+9JVF0AEcWh/Ew6DZDFYu+nhsIu1aXb5uzGepAWdVNdStsKlLikEsY++kvDJzqmap
	 OrDCL9g7v5CGA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 14 May 2024 00:25:36 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 14 May
 2024 00:25:35 +0300
Date: Tue, 14 May 2024 00:25:35 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/7] clk: meson: a1: pll: support 'syspll'
 general-purpose PLL for CPU clock
Message-ID: <20240513212535.rql55fdrvy2mdsrl@CAB-WSD-L081021>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-4-ddrokosov@salutedevices.com>
 <1jbk59zx4g.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jbk59zx4g.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185198 [May 13 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/13 16:04:00 #25186646
X-KSMG-AntiVirus-Status: Clean, skipped

On Mon, May 13, 2024 at 02:48:58PM +0200, Jerome Brunet wrote:
> 
> On Fri 10 May 2024 at 12:08, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > The 'syspll' PLL, also known as the system PLL, is a general and
> > essential PLL responsible for generating the CPU clock frequency.
> > With its wide-ranging capabilities, it is designed to accommodate
> > frequencies within the range of 768MHz to 1536MHz.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  drivers/clk/meson/a1-pll.c | 79 ++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/meson/a1-pll.h |  6 +++
> >  2 files changed, 85 insertions(+)
> >
> > diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> > index 60b2e53e7e51..af47ba308bbe 100644
> > --- a/drivers/clk/meson/a1-pll.c
> > +++ b/drivers/clk/meson/a1-pll.c
> > @@ -138,6 +138,82 @@ static struct clk_regmap hifi_pll = {
> >  	},
> >  };
> >  
> > +static const struct pll_mult_range sys_pll_mult_range = {
> > +	.min = 32,
> > +	.max = 64,
> > +};
> > +
> > +static const struct reg_sequence sys_pll_init_regs[] = {
> > +	{ .reg = ANACTRL_SYSPLL_CTRL1, .def = 0x01800000 },
> > +	{ .reg = ANACTRL_SYSPLL_CTRL2, .def = 0x00001100 },
> > +	{ .reg = ANACTRL_SYSPLL_CTRL3, .def = 0x10022300 },
> > +	{ .reg = ANACTRL_SYSPLL_CTRL4, .def = 0x00300000 },
> > +	{ .reg = ANACTRL_SYSPLL_CTRL0, .def = 0x01f18432 },
> > +};
> > +
> > +static struct clk_regmap sys_pll = {
> > +	.data = &(struct meson_clk_pll_data){
> > +		.en = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 28,
> > +			.width   = 1,
> > +		},
> > +		.m = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 0,
> > +			.width   = 8,
> > +		},
> > +		.n = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 10,
> > +			.width   = 5,
> > +		},
> > +		.frac = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL1,
> > +			.shift   = 0,
> > +			.width   = 19,
> > +		},
> > +		.l = {
> > +			.reg_off = ANACTRL_SYSPLL_STS,
> > +			.shift   = 31,
> > +			.width   = 1,
> > +		},
> > +		.current_en = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> > +			.shift   = 26,
> > +			.width   = 1,
> > +		},
> > +		.l_detect = {
> > +			.reg_off = ANACTRL_SYSPLL_CTRL2,
> > +			.shift   = 6,
> > +			.width   = 1,
> > +		},
> > +		.range = &sys_pll_mult_range,
> > +		.init_regs = sys_pll_init_regs,
> > +		.init_count = ARRAY_SIZE(sys_pll_init_regs),
> 
> Like other 'fishy' flags, I would like a clear comment why this flag is
> required so, 2y from now, we will know why it was put there and how we
> can deal with it.
> 

Yep, you are totally correct. The proper comment is required for that.

> > +		.flags = CLK_MESON_PLL_INIT_ONCE,
> > +	},
> > +	.hw.init = &(struct clk_init_data){
> > +		.name = "sys_pll",
> > +		.ops = &meson_clk_pll_ops,
> > +		.parent_names = (const char *[]){ "syspll_in" },
> > +		.num_parents = 1,
> > +	},
> > +};
> > +
> > +static struct clk_fixed_factor sys_pll_div16 = {
> > +	.mult = 1,
> > +	.div = 16,
> > +	.hw.init = &(struct clk_init_data){
> > +		.name = "sys_pll_div16",
> > +		.ops = &clk_fixed_factor_ops,
> > +		.parent_hws = (const struct clk_hw *[]) {
> > +			&sys_pll.hw
> > +		},
> > +		.num_parents = 1,
> > +	},
> > +};
> 
> Unlike the fdivs, this fixed divider is not part of the diagram
> describing the syspll clock.
> 
> IMO, it could as well be in peripheral controller because it exists
> (from what I can see) just testing purposes, to make the sys pll
> observable through tst_out or gen_clk.
> 
> It also looks less awkward in the bindings.
> 

In any case, it is necessary to introduce a new connection. Instead of
using 'sys_pll_div16', it will now be called 'sys_pll'. I agree with you
that this change will make the code more elegant.

> > +
> >  static struct clk_fixed_factor fclk_div2_div = {
> >  	.mult = 1,
> >  	.div = 2,
> > @@ -283,6 +359,8 @@ static struct clk_hw *a1_pll_hw_clks[] = {
> >  	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
> >  	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
> >  	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
> > +	[CLKID_SYS_PLL]		= &sys_pll.hw,
> > +	[CLKID_SYS_PLL_DIV16]	= &sys_pll_div16.hw,
> >  };
> >  
> >  static struct clk_regmap *const a1_pll_regmaps[] = {
> > @@ -293,6 +371,7 @@ static struct clk_regmap *const a1_pll_regmaps[] = {
> >  	&fclk_div5,
> >  	&fclk_div7,
> >  	&hifi_pll,
> > +	&sys_pll,
> >  };
> >  
> >  static struct regmap_config a1_pll_regmap_cfg = {
> > diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
> > index 4be17b2bf383..666d9b2137e9 100644
> > --- a/drivers/clk/meson/a1-pll.h
> > +++ b/drivers/clk/meson/a1-pll.h
> > @@ -18,6 +18,12 @@
> >  #define ANACTRL_FIXPLL_CTRL0	0x0
> >  #define ANACTRL_FIXPLL_CTRL1	0x4
> >  #define ANACTRL_FIXPLL_STS	0x14
> > +#define ANACTRL_SYSPLL_CTRL0	0x80
> > +#define ANACTRL_SYSPLL_CTRL1	0x84
> > +#define ANACTRL_SYSPLL_CTRL2	0x88
> > +#define ANACTRL_SYSPLL_CTRL3	0x8c
> > +#define ANACTRL_SYSPLL_CTRL4	0x90
> > +#define ANACTRL_SYSPLL_STS	0x94
> >  #define ANACTRL_HIFIPLL_CTRL0	0xc0
> >  #define ANACTRL_HIFIPLL_CTRL1	0xc4
> >  #define ANACTRL_HIFIPLL_CTRL2	0xc8
> 
> 
> -- 
> Jerome

-- 
Thank you,
Dmitry

