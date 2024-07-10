Return-Path: <linux-kernel+bounces-248384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A80492DC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4CE2840E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A97154BFE;
	Wed, 10 Jul 2024 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2haqyCc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2991527A7;
	Wed, 10 Jul 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653435; cv=none; b=sY+kDCI8oYhjV0HqZvsLGd1Q1dtWqVg4sgmnGhJTZ7otYJHUW7Duaa/Qe7IWKW2FFw0dHpsk8Lz0WPzZPRP88xyOdCDsF3LqvMZnuGoMHLG7D2ZhVtPV/QA9zxR2s5+OkMHxIRd+wPTCMVKEEwAi3Xgw7HmuZVlIo94G6zn1YxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653435; c=relaxed/simple;
	bh=Jd3wkWpGIxjVE8bZuw1tGBEUQpwx9hG4gsdHuzurtTM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=INrFtldTCpPaz0e4n48DOVqUH2/M6A2NH3IcrZL+yU2X1Bd2BsnpLJVce+y2mcH69Dqf3sH0Blz71DbZtk8gmRabp5LsvLW07FsTUg7uDbcyzaxw8GgVjPamXXx5xD3skFl+wA9JJbqnF/SsZzTDm0cI9421s7AWDa+5Mu7cl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2haqyCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECB6C4AF07;
	Wed, 10 Jul 2024 23:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720653435;
	bh=Jd3wkWpGIxjVE8bZuw1tGBEUQpwx9hG4gsdHuzurtTM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=t2haqyCcJw9sr2yZK5l1zj+YhLnEb/FRj6I69HzdAMOqFUg0ApMQesfJ95wG4i6N2
	 pzDekhpOYN6r9sbty0qVx9g1Jvx+Y/8jCTEw/iL6sXgDvJn88FkIrR4croxZMHbl10
	 /j4QO0CQWqxaSbmE2cZCtCT2nkwcuKFildztLjt3FSpqhyAEFVG+rFlsPpSlTGoPY2
	 kKCZxDLLPKKkmaQ8mN4IgCNuSNq8d986tEHFVUvTszT9ipKROy0yGZbtXTe01fp0Ii
	 jko+aFhjpzgeBBc3agNERAjpSmj6Qo7rP6ghntuTvWG1I59tup4bkc18Sq7acJ1ih3
	 EqJtmZ46F9miw==
Message-ID: <d36ff27b56b3e9c8ef490bfd9d24761d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240623-th1520-clk-v2-2-ad8d6432d9fb@tenstorrent.com>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com> <20240623-th1520-clk-v2-2-ad8d6432d9fb@tenstorrent.com>
Subject: Re: [PATCH v2 2/7] clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
To: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Drew Fustini <dfustini@tenstorrent.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Yangtao Li <frank.li@vivo.com>
Date: Wed, 10 Jul 2024 16:17:12 -0700
User-Agent: alot/0.10

Quoting Drew Fustini (2024-06-23 19:12:32)
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th=
1520-ap.c
> new file mode 100644
> index 000000000000..982d4d40f783
> --- /dev/null
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -0,0 +1,1086 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
> + *  Authors: Yangtao Li <frank.li@vivo.com>
> + */
> +
> +#include <dt-bindings/clock/thead,th1520-clk-ap.h>

Preferably include dt-bindings after linux includes.

> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define TH1520_PLL_POSTDIV2    GENMASK(26, 24)
> +#define TH1520_PLL_POSTDIV1    GENMASK(22, 20)
> +#define TH1520_PLL_FBDIV       GENMASK(19, 8)
> +#define TH1520_PLL_REFDIV      GENMASK(5, 0)
> +#define TH1520_PLL_BYPASS      BIT(30)
> +#define TH1520_PLL_DSMPD       BIT(24)
> +#define TH1520_PLL_FRAC                GENMASK(23, 0)
> +#define TH1520_PLL_FRAC_BITS    24
[...]
> +
> +static unsigned long th1520_pll_vco_recalc_rate(struct clk_hw *hw,
> +                                               unsigned long parent_rate)
> +{
> +       struct ccu_pll *pll =3D hw_to_ccu_pll(hw);
> +       unsigned long div, mul, frac, rate =3D parent_rate;
> +       unsigned int cfg0, cfg1;
> +
> +       regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
> +       regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
> +
> +       mul =3D FIELD_GET(TH1520_PLL_FBDIV, cfg0);
> +       div =3D FIELD_GET(TH1520_PLL_REFDIV, cfg0);
> +       if (!(cfg1 & TH1520_PLL_DSMPD)) {
> +               mul <<=3D TH1520_PLL_FRAC_BITS;
> +               frac =3D FIELD_GET(TH1520_PLL_FRAC, cfg1);
> +               mul +=3D frac;
> +               div <<=3D TH1520_PLL_FRAC_BITS;
> +       }
> +       rate =3D parent_rate * mul;
> +       do_div(rate, div);

'rate' is only unsigned long, so do_div() isn't needed here. Perhaps if
'parent_rate * mul' can overflow 32-bits then 'rate' should be
u64.

> +       return rate;
> +}
> +
> +static unsigned long th1520_pll_postdiv_recalc_rate(struct clk_hw *hw,
> +                                                   unsigned long parent_=
rate)
> +{
> +       struct ccu_pll *pll =3D hw_to_ccu_pll(hw);
> +       unsigned long rate =3D parent_rate;
> +       unsigned int cfg0, cfg1;
> +
> +       regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
> +       regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
> +
> +       if (cfg1 & TH1520_PLL_BYPASS)
> +               return rate;
> +
> +       do_div(rate, FIELD_GET(TH1520_PLL_POSTDIV1, cfg0) *

Same, 'rate' is unsigned long. Did you get some compilation error
without this? How big is the divisor going to be? The fields are only
3-bits wide, so the multiplication would fit into a u32 just fine. Given
that 'rate' is unsigned long though I think you can just put the
multiplication result into a local variable that's also unsigned long
and then just write the divide with unsigned longs

	div =3D FIELD_GET(...) * FIELD_GET(...);

	return rate / div;

> +                    FIELD_GET(TH1520_PLL_POSTDIV2, cfg0));
> +
> +       return rate;
> +}
> +
> +static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       unsigned long rate =3D parent_rate;
> +
> +       rate =3D th1520_pll_vco_recalc_rate(hw, rate);
> +       rate =3D th1520_pll_postdiv_recalc_rate(hw, rate);
> +
> +       return rate;
> +}

Please fold this in

----8<---
diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th15=
20-ap.c
index 982d4d40f783..0c3821d50765 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -411,7 +411,7 @@ static const struct clk_parent_data c910_i0_parents[] =
=3D {
 	{ .index =3D 0 }
 };
=20
-struct ccu_mux c910_i0_clk =3D {
+static struct ccu_mux c910_i0_clk =3D {
 	.mux	=3D TH_CCU_ARG(1, 1),
 	.common	=3D {
 		.clkid		=3D CLK_C910_I0,
@@ -428,7 +428,7 @@ static const struct clk_parent_data c910_parents[] =3D {
 	{ .hw =3D &cpu_pll1_clk.common.hw }
 };
=20
-struct ccu_mux c910_clk =3D {
+static struct ccu_mux c910_clk =3D {
 	.mux	=3D TH_CCU_ARG(0, 1),
 	.common	=3D {
 		.clkid		=3D CLK_C910,
@@ -845,7 +845,7 @@ static const struct clk_parent_data uart_sclk_parents[]=
 =3D {
 	{ .index =3D 0 },
 };
=20
-struct ccu_mux uart_sclk =3D {
+static struct ccu_mux uart_sclk =3D {
 	.mux	=3D TH_CCU_ARG(0, 1),
 	.common	=3D {
 		.clkid          =3D CLK_UART_SCLK,

