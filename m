Return-Path: <linux-kernel+bounces-177597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4377E8C4146
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E53B216B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30A1509A3;
	Mon, 13 May 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JA7wIwTr"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCC14C5A3
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605141; cv=none; b=Mdk4OLSJ5Lff7SRsmT1kECZs72qHPXCCLKHucVffjUdbtwiZtkvSrh6vUDO3qLtJC95OMO6ZhDZBaikdmM30Ka+1f7CBf6BcucTHtJWHqhtDwRNOXzc4MLy8J6ae9+tD8NDxvGNTVHaT58suZ56GSCCozi+hGsqBNJQsOVxWOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605141; c=relaxed/simple;
	bh=QwEueKRKRRQmdEt4MPVWyq59oFXImtpq6ZU4/rug9MM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=YY41vz94ToICr3i9kK6lj29I9pAS80EpbM0VF8CxE9zN78PQQjC8aODs8wFCy5I0oyFRLomz6tAh7Ues7frtoPyNRSINSvL/KkpYS78gmPx4hsHp5+JqyQkCmmZ3CwMwrvxAY2KoMW5dgcQMSTkrCxk4tEzrv/fKMWe6wCEEFdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JA7wIwTr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34e667905d2so2929642f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715605136; x=1716209936; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+KHY/va/UiG2Na9MP8nc/w2XW81daquGbqT+2NhsgSg=;
        b=JA7wIwTrB7/6moUKCC9J7mLc3TEA6KAZ1N611K17biVi/dE6zs++HtVcLH8pFu6bzI
         GGYOuhp4UIp9QGGeMEMVBn2QlHDK/FV0Khf5p6oeJv1aWpHoTTNBMm+m9FpiVGEaSL9d
         vRJb90WTWckBTd1ZzYuztJRGDBogqtrB5+6ldK3KsAAfAsqrd3FKLGEeAvUJOVHhK0wv
         TpUE74gJpnrGbrD0IJmr2+VN2tZRhahP+9hvYs8LUEM20KarnClo0SZwYHj1tS1E/S0n
         pczzLh3ydFHvhCtAr6In98Kn6hc0OA7BS1OScoPJ7xPSUgNutZQqrE0/jRhyet+or/pE
         cNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715605136; x=1716209936;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KHY/va/UiG2Na9MP8nc/w2XW81daquGbqT+2NhsgSg=;
        b=UpeSostTOrE+061tPz3EaAZ1sAJpG0ZMr2FB6AZSmveYu4CgYb3ZE5hmsYx3Oh8a4w
         um4NX/Ajbu19HZuvDayTZOOtlJX5UOK4WqsvcMqA67ud6BacO17C5B+i0KxKYORtfvb8
         c2SbJI6Ad85z+8ySoV223BYbenZZAV6zZPDg69YR6GnmikcyKEIUhSYKzRSvORjQIccT
         wggQzms/eYo3EAbXUmCtvFONc3IzDFGJ+daorgePnXLb3s4O9ydMh5/t8/SZhpD7PsEy
         ZLOLKSiiCASly0P6eJNLn8RAs7i+U39hI6iKc6pEodxzqf2LsxF+StowE8NIh/4VQ0Uu
         kAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXILCgut/+izTJAw0RuEBdpevzB3lSfi3CYxKdaYUpTVg3616/4Fam/dqnq4P3x9zBEnMevwVgSGQQf6XWBOO8EtbGL5BBurIB7vjMk
X-Gm-Message-State: AOJu0YwzVVLjgHrhbAEAH7+QLpTDAnRF/YzgW9PK0Ccb/cffnaNYfW7U
	kweckwy3F74JVmpLWXxq/SZIlzK/ZRaZB03NrOs0ud93ZMKY86uCaH/wb5+9Ps8=
X-Google-Smtp-Source: AGHT+IHeRnTDN4SH3gn7w7eJ7nzHsxhbKa6Pl2AcPY9SrajcE/+4MjtBKCpMvS1sSqhDwJN1TAPHXQ==
X-Received: by 2002:adf:fe04:0:b0:34f:f540:bdc9 with SMTP id ffacd0b85a97d-3504a63300amr6183580f8f.9.1715605136359;
        Mon, 13 May 2024 05:58:56 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:5b77:3e5a:a808:339a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8969fbsm11019601f8f.37.2024.05.13.05.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 05:58:55 -0700 (PDT)
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-4-ddrokosov@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com,
 mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
 kernel@sberdevices.ru, rockosov@gmail.com,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/7] clk: meson: a1: pll: support 'syspll'
 general-purpose PLL for CPU clock
Date: Mon, 13 May 2024 14:48:58 +0200
In-reply-to: <20240510090933.19464-4-ddrokosov@salutedevices.com>
Message-ID: <1jbk59zx4g.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 10 May 2024 at 12:08, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> The 'syspll' PLL, also known as the system PLL, is a general and
> essential PLL responsible for generating the CPU clock frequency.
> With its wide-ranging capabilities, it is designed to accommodate
> frequencies within the range of 768MHz to 1536MHz.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  drivers/clk/meson/a1-pll.c | 79 ++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/a1-pll.h |  6 +++
>  2 files changed, 85 insertions(+)
>
> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> index 60b2e53e7e51..af47ba308bbe 100644
> --- a/drivers/clk/meson/a1-pll.c
> +++ b/drivers/clk/meson/a1-pll.c
> @@ -138,6 +138,82 @@ static struct clk_regmap hifi_pll = {
>  	},
>  };
>  
> +static const struct pll_mult_range sys_pll_mult_range = {
> +	.min = 32,
> +	.max = 64,
> +};
> +
> +static const struct reg_sequence sys_pll_init_regs[] = {
> +	{ .reg = ANACTRL_SYSPLL_CTRL1, .def = 0x01800000 },
> +	{ .reg = ANACTRL_SYSPLL_CTRL2, .def = 0x00001100 },
> +	{ .reg = ANACTRL_SYSPLL_CTRL3, .def = 0x10022300 },
> +	{ .reg = ANACTRL_SYSPLL_CTRL4, .def = 0x00300000 },
> +	{ .reg = ANACTRL_SYSPLL_CTRL0, .def = 0x01f18432 },
> +};
> +
> +static struct clk_regmap sys_pll = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 19,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_SYSPLL_STS,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.current_en = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL0,
> +			.shift   = 26,
> +			.width   = 1,
> +		},
> +		.l_detect = {
> +			.reg_off = ANACTRL_SYSPLL_CTRL2,
> +			.shift   = 6,
> +			.width   = 1,
> +		},
> +		.range = &sys_pll_mult_range,
> +		.init_regs = sys_pll_init_regs,
> +		.init_count = ARRAY_SIZE(sys_pll_init_regs),

Like other 'fishy' flags, I would like a clear comment why this flag is
required so, 2y from now, we will know why it was put there and how we
can deal with it.

> +		.flags = CLK_MESON_PLL_INIT_ONCE,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sys_pll",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_names = (const char *[]){ "syspll_in" },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor sys_pll_div16 = {
> +	.mult = 1,
> +	.div = 16,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sys_pll_div16",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sys_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};

Unlike the fdivs, this fixed divider is not part of the diagram
describing the syspll clock.

IMO, it could as well be in peripheral controller because it exists
(from what I can see) just testing purposes, to make the sys pll
observable through tst_out or gen_clk.

It also looks less awkward in the bindings.

> +
>  static struct clk_fixed_factor fclk_div2_div = {
>  	.mult = 1,
>  	.div = 2,
> @@ -283,6 +359,8 @@ static struct clk_hw *a1_pll_hw_clks[] = {
>  	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
>  	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
>  	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
> +	[CLKID_SYS_PLL]		= &sys_pll.hw,
> +	[CLKID_SYS_PLL_DIV16]	= &sys_pll_div16.hw,
>  };
>  
>  static struct clk_regmap *const a1_pll_regmaps[] = {
> @@ -293,6 +371,7 @@ static struct clk_regmap *const a1_pll_regmaps[] = {
>  	&fclk_div5,
>  	&fclk_div7,
>  	&hifi_pll,
> +	&sys_pll,
>  };
>  
>  static struct regmap_config a1_pll_regmap_cfg = {
> diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
> index 4be17b2bf383..666d9b2137e9 100644
> --- a/drivers/clk/meson/a1-pll.h
> +++ b/drivers/clk/meson/a1-pll.h
> @@ -18,6 +18,12 @@
>  #define ANACTRL_FIXPLL_CTRL0	0x0
>  #define ANACTRL_FIXPLL_CTRL1	0x4
>  #define ANACTRL_FIXPLL_STS	0x14
> +#define ANACTRL_SYSPLL_CTRL0	0x80
> +#define ANACTRL_SYSPLL_CTRL1	0x84
> +#define ANACTRL_SYSPLL_CTRL2	0x88
> +#define ANACTRL_SYSPLL_CTRL3	0x8c
> +#define ANACTRL_SYSPLL_CTRL4	0x90
> +#define ANACTRL_SYSPLL_STS	0x94
>  #define ANACTRL_HIFIPLL_CTRL0	0xc0
>  #define ANACTRL_HIFIPLL_CTRL1	0xc4
>  #define ANACTRL_HIFIPLL_CTRL2	0xc8


-- 
Jerome

