Return-Path: <linux-kernel+bounces-550179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8845EA55C46
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B39F1709EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DA61E868;
	Fri,  7 Mar 2025 00:51:59 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB751494C9;
	Fri,  7 Mar 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308718; cv=none; b=nEova1P4XGN3ceUrMcQk/jBD1ZDVICEonZw1hrANJGNCAziz8HiqzzUvf+akvE5pl0dbWuH1yDzlEkZaroCiLoCWRo5Gr/jWjeyzQkm/U3QD/3ROOgiproVaAdhMKK8+MGH5eQAcLCyI067vJY0ahZ9Qa23f3uWWI+GhlajPrOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308718; c=relaxed/simple;
	bh=YCG7HHviiTj01ryCVYyYVMM9/+/pJYQxzXcOwo+r0Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj5WlFMJRUOETGov/NAd/KkSekszDbN7mEZRe6fFZ0DD6dDE/RKU7ykt4eUwL94dkMIwKwrGqPUK1CxLWQ+GNmln7320sfjMIoxAEdkGHa6azkAFBgYPApi4KY4Q7cA97DFCHqXqUks69fMznoHC2xS4cqOz419OS0rQHxS+zNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E2A93341465;
	Fri, 07 Mar 2025 00:51:53 +0000 (UTC)
Date: Fri, 7 Mar 2025 00:51:49 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Haylen Chu <heylenay@4d2.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 3/5] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <20250307005149-GYA66361@gentoo>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-5-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306175750.22480-5-heylenay@4d2.org>

On 17:57 Thu 06 Mar     , Haylen Chu wrote:
> The clock tree of K1 SoC contains three main types of clock hardware
> (PLL/DDN/MIX) and has control registers split into several multifunction
> devices: APBS (PLLs), MPMU, APBC and APMU.
> 
> All register operations are done through regmap to ensure atomiciy
> between concurrent operations of clock driver and reset,
> power-domain driver that will be introduced in the future.
> 
> Signed-off-by: Haylen Chu <heylenay@4d2.org>
> ---
>  drivers/clk/Kconfig               |    1 +
>  drivers/clk/Makefile              |    1 +
>  drivers/clk/spacemit/Kconfig      |   20 +
>  drivers/clk/spacemit/Makefile     |    5 +
>  drivers/clk/spacemit/ccu-k1.c     | 1714 +++++++++++++++++++++++++++++
>  drivers/clk/spacemit/ccu_common.h |   47 +
>  drivers/clk/spacemit/ccu_ddn.c    |   80 ++
>  drivers/clk/spacemit/ccu_ddn.h    |   48 +
>  drivers/clk/spacemit/ccu_mix.c    |  284 +++++
>  drivers/clk/spacemit/ccu_mix.h    |  246 +++++
>  drivers/clk/spacemit/ccu_pll.c    |  146 +++
>  drivers/clk/spacemit/ccu_pll.h    |   76 ++
>  12 files changed, 2668 insertions(+)
>  create mode 100644 drivers/clk/spacemit/Kconfig
>  create mode 100644 drivers/clk/spacemit/Makefile
>  create mode 100644 drivers/clk/spacemit/ccu-k1.c
>  create mode 100644 drivers/clk/spacemit/ccu_common.h
>  create mode 100644 drivers/clk/spacemit/ccu_ddn.c
>  create mode 100644 drivers/clk/spacemit/ccu_ddn.h
>  create mode 100644 drivers/clk/spacemit/ccu_mix.c
>  create mode 100644 drivers/clk/spacemit/ccu_mix.h
>  create mode 100644 drivers/clk/spacemit/ccu_pll.c
>  create mode 100644 drivers/clk/spacemit/ccu_pll.h
> 
..
> +static int k1_ccu_probe(struct platform_device *pdev)
> +{
> +	struct regmap *base_regmap, *lock_regmap = NULL;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	base_regmap = device_node_to_regmap(dev->of_node);
> +	if (IS_ERR(base_regmap))
> +		return dev_err_probe(dev, PTR_ERR(base_regmap),
> +				     "failed to get regmap\n");
> +
> +	if (of_device_is_compatible(dev->of_node, "spacemit,k1-pll")) {
..
> +		struct device_node *mpmu = of_parse_phandle(dev->of_node,
> +							    "spacemit,mpmu", 0);
> +		if (!mpmu)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "Cannot parse MPMU region\n");
> +
> +		lock_regmap = device_node_to_regmap(mpmu);
> +		of_node_put(mpmu);
> +
you can simplify above with syscon_regmap_lookup_by_phandle(), which
would save a few lines

or further, just call syscon_regmap_lookup_by_compatible()? then
won't be necessary to introduce the "spacemit,mpmu" property..

> +		if (IS_ERR(lock_regmap))
> +			return dev_err_probe(dev, PTR_ERR(lock_regmap),
> +					     "failed to get lock regmap\n");
> +	}
> +
> +	ret = spacemit_ccu_register(dev, base_regmap, lock_regmap,
> +				    of_device_get_match_data(dev));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register clocks\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_k1_ccu_match[] = {
> +	{
> +		.compatible	= "spacemit,k1-pll",
> +		.data		= k1_ccu_apbs_clks,
> +	},
> +	{
> +		.compatible	= "spacemit,k1-syscon-mpmu",
> +		.data		= k1_ccu_mpmu_clks,
> +	},
> +	{
> +		.compatible	= "spacemit,k1-syscon-apbc",
> +		.data		= k1_ccu_apbc_clks,
> +	},
> +	{
> +		.compatible	= "spacemit,k1-syscon-apmu",
> +		.data		= k1_ccu_apmu_clks,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, of_k1_ccu_match);
> +
> +static struct platform_driver k1_ccu_driver = {
> +	.driver = {
> +		.name		= "spacemit,k1-ccu",
> +		.of_match_table = of_k1_ccu_match,
> +	},
> +	.probe	= k1_ccu_probe,
> +};
> +module_platform_driver(k1_ccu_driver);
> +
> +MODULE_DESCRIPTION("Spacemit K1 CCU driver");
> +MODULE_AUTHOR("Haylen Chu <heylenay@4d2.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/spacemit/ccu_common.h b/drivers/clk/spacemit/ccu_common.h
> new file mode 100644
> index 000000000000..494cde96fe3c
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_common.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#ifndef _CCU_COMMON_H_
> +#define _CCU_COMMON_H_
> +
> +#include <linux/regmap.h>
> +
> +struct ccu_common {
> +	struct regmap *regmap;
> +	struct regmap *lock_regmap;
> +
> +	union {
> +		/* For DDN and MIX */
> +		struct {
> +			u32 reg_ctrl;
> +			u32 reg_fc;
> +			u32 fc;
> +		};
> +
> +		/* For PLL */
> +		struct {
> +			u32 reg_swcr1;
> +			u32 reg_swcr2;
> +			u32 reg_swcr3;
> +		};
> +	};
> +
> +	struct clk_hw hw;
> +};
> +
> +static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct ccu_common, hw);
> +}
> +
> +#define ccu_read(reg, c, val)	regmap_read((c)->regmap, (c)->reg_##reg, val)
> +#define ccu_update(reg, c, mask, val) \
> +	regmap_update_bits((c)->regmap, (c)->reg_##reg, mask, val)
> +#define ccu_poll(reg, c, tmp, cond, sleep, timeout) \
> +	regmap_read_poll_timeout_atomic((c)->regmap, (c)->reg_##reg,	\
> +					tmp, cond, sleep, timeout)
> +
> +#endif /* _CCU_COMMON_H_ */
> diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
> new file mode 100644
> index 000000000000..ee187687d0c4
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_ddn.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit clock type ddn
> + *
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/rational.h>
> +
> +#include "ccu_ddn.h"
> +
> +/*
> + * DDN stands for "Divider Denominator Numerator", it's M/N clock with a
> + * constant x2 factor. This clock hardware follows the equation below,
> + *
> + *	      numerator       Fin
> + *	2 * ------------- = -------
> + *	     denominator      Fout
> + *
> + * Thus, Fout could be calculated with,
> + *
> + *		Fin	denominator
> + *	Fout = ----- * -------------
> + *		 2	 numerator
> + */
> +
> +static unsigned long clk_ddn_calc_best_rate(struct ccu_ddn *ddn,
> +					    unsigned long rate, unsigned long prate,
> +					    unsigned long *num, unsigned long *den)
> +{
> +	rational_best_approximation(rate, prate / 2,
> +				    ddn->den_mask, ddn->num_mask,
> +				    den, num);
> +	return prate / 2 * *den / *num;
> +}
> +
> +static long clk_ddn_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *prate)
> +{
> +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> +	unsigned long num = 0, den = 0;
> +
> +	return clk_ddn_calc_best_rate(ddn, rate, *prate, &num, &den);
> +}
> +
> +static unsigned long clk_ddn_recalc_rate(struct clk_hw *hw, unsigned long prate)
> +{
> +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> +	unsigned int val, num, den;
> +
> +	ccu_read(ctrl, &ddn->common, &val);
> +
> +	num = (val & ddn->num_mask) >> ddn->num_shift;
> +	den = (val & ddn->den_mask) >> ddn->den_shift;
> +
> +	return prate / 2 * den / num;
> +}
> +
> +static int clk_ddn_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long prate)
> +{
> +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> +	unsigned long num, den;
> +
> +	clk_ddn_calc_best_rate(ddn, rate, prate, &num, &den);
> +
> +	ccu_update(ctrl, &ddn->common,
> +		   ddn->num_mask | ddn->den_mask,
> +		   (num << ddn->num_shift) | (den << ddn->den_shift));
> +
> +	return 0;
> +}
> +
> +const struct clk_ops spacemit_ccu_ddn_ops = {
> +	.recalc_rate	= clk_ddn_recalc_rate,
> +	.round_rate	= clk_ddn_round_rate,
> +	.set_rate	= clk_ddn_set_rate,
> +};
> diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
> new file mode 100644
> index 000000000000..3746d084e1e7
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_ddn.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#ifndef _CCU_DDN_H_
> +#define _CCU_DDN_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +
> +struct ccu_ddn {
> +	struct ccu_common common;
> +	unsigned int num_mask;
> +	unsigned int num_shift;
> +	unsigned int den_mask;
> +	unsigned int den_shift;
> +};
> +
> +#define CCU_DDN_INIT(_name, _parent, _flags) \
> +	CLK_HW_INIT_HW(#_name, &_parent.common.hw, &spacemit_ccu_ddn_ops, _flags)
> +
> +#define CCU_DDN_DEFINE(_name, _parent, _reg_ctrl,				\
> +		       _num_mask, _num_shift, _den_mask, _den_shift,		\
> +		       _flags)							\
> +	struct ccu_ddn _name = {						\
> +		.common = {							\
> +			.reg_ctrl = _reg_ctrl,					\
> +			.hw.init  = CCU_DDN_INIT(_name, _parent, _flags),	\
> +		},								\
> +		.num_mask = _num_mask,						\
> +		.num_shift = _num_shift,					\
> +		.den_mask = _den_mask,						\
> +		.den_shift = _den_shift,					\
> +	}
> +
> +static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
> +{
> +	struct ccu_common *common = hw_to_ccu_common(hw);
> +
> +	return container_of(common, struct ccu_ddn, common);
> +}
> +
> +extern const struct clk_ops spacemit_ccu_ddn_ops;
> +
> +#endif
> diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
> new file mode 100644
> index 000000000000..a5c13000e062
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_mix.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit clock type mix(div/mux/gate/factor)
> + *
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_mix.h"
> +
> +#define MIX_TIMEOUT	10000
> +
> +static void ccu_gate_disable(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +
> +	ccu_update(ctrl, common, mix->gate.mask, 0);
> +}
> +
> +static int ccu_gate_enable(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_gate_config *gate = &mix->gate;
> +
> +	ccu_update(ctrl, common, gate->mask, gate->mask);
> +
> +	return 0;
> +}
> +
> +static int ccu_gate_is_enabled(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	u32 tmp;
> +
> +	ccu_read(ctrl, common, &tmp);
> +
> +	return !!(tmp & mix->gate.mask);
> +}
> +
> +static unsigned long ccu_factor_recalc_rate(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +
> +	return parent_rate * mix->factor.mul / mix->factor.div;
> +}
> +
> +static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_div_config *div = &mix->div;
> +	unsigned long val;
> +	u32 reg;
> +
> +	ccu_read(ctrl, common, &reg);
> +
> +	val = reg >> div->shift;
> +	val &= (1 << div->width) - 1;
> +
> +	val = divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width);
> +
> +	return val;
> +}
> +
> +static int ccu_mix_trigger_fc(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	unsigned int val = 0;
> +
> +	ccu_update(fc, common, common->fc, common->fc);
> +
> +	return ccu_poll(fc, common, val, !(val & common->fc),
> +			5, MIX_TIMEOUT);
> +}
> +
> +static long ccu_factor_round_rate(struct clk_hw *hw, unsigned long rate,
> +				  unsigned long *prate)
> +{
> +	return ccu_factor_recalc_rate(hw, *prate);
> +}
> +
> +static int ccu_factor_set_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long parent_rate)
> +{
> +	return 0;
> +}
> +
> +static unsigned long
> +ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate,
> +		       struct clk_hw **best_parent,
> +		       unsigned long *best_parent_rate,
> +		       u32 *div_val)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	unsigned int parent_num = clk_hw_get_num_parents(hw);
> +	struct ccu_div_config *div = &mix->div;
> +	u32 div_max = 1 << div->width;
> +	unsigned long best_rate = 0;
> +
> +	for (int i = 0; i < parent_num; i++) {
> +		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> +		unsigned long parent_rate;
> +
> +		if (!parent)
> +			continue;
> +
> +		parent_rate = clk_hw_get_rate(parent);
> +
> +		for (int j = 1; j <= div_max; j++) {
> +			unsigned long tmp = DIV_ROUND_UP_ULL(parent_rate, j);
> +
> +			if (abs(tmp - rate) < abs(best_rate - rate)) {
> +				best_rate = tmp;
> +
> +				if (div_val)
> +					*div_val = j - 1;
> +
> +				if (best_parent) {
> +					*best_parent      = parent;
> +					*best_parent_rate = parent_rate;
> +				}
> +			}
> +		}
> +	}
> +
> +	return best_rate;
> +}
> +
> +static int ccu_mix_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
> +{
> +	req->rate = ccu_mix_calc_best_rate(hw, req->rate,
> +					   &req->best_parent_hw,
> +					   &req->best_parent_rate,
> +					   NULL);
> +	return 0;
> +}
> +
> +static int ccu_mix_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_div_config *div = &mix->div;
> +	int ret = 0, tmp = 0;
> +	u32 current_div, target_div;
> +
> +	ccu_mix_calc_best_rate(hw, rate, NULL, NULL, &target_div);
> +
> +	ccu_read(ctrl, common, &tmp);
> +
> +	current_div = tmp >> div->shift;
> +	current_div &= (1 << div->width) - 1;
> +
> +	if (current_div == target_div)
> +		return 0;
> +
> +	tmp = GENMASK(div->width + div->shift - 1, div->shift);
> +
> +	ccu_update(ctrl, common, tmp, target_div << div->shift);
> +
> +	if (common->reg_fc)
> +		ret = ccu_mix_trigger_fc(hw);
> +
> +	return ret;
> +}
> +
> +static u8 ccu_mux_get_parent(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_mux_config *mux = &mix->mux;
> +	u32 reg;
> +	u8 parent;
> +
> +	ccu_read(ctrl, common, &reg);
> +
> +	parent = reg >> mux->shift;
> +	parent &= (1 << mux->width) - 1;
> +
> +	return parent;
> +}
> +
> +static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_mux_config *mux = &mix->mux;
> +	int ret = 0;
> +	u32 mask;
> +
> +	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> +
> +	ccu_update(ctrl, common, mask, index << mux->shift);
> +
> +	if (common->reg_fc)
> +		ret = ccu_mix_trigger_fc(hw);
> +
> +	return ret;
> +}
> +
> +const struct clk_ops spacemit_ccu_gate_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +};
> +
> +const struct clk_ops spacemit_ccu_factor_ops = {
> +	.round_rate	= ccu_factor_round_rate,
> +	.recalc_rate	= ccu_factor_recalc_rate,
> +	.set_rate	= ccu_factor_set_rate,
> +};
> +
> +const struct clk_ops spacemit_ccu_mux_ops = {
> +	.determine_rate = ccu_mix_determine_rate,
> +	.get_parent	= ccu_mux_get_parent,
> +	.set_parent	= ccu_mux_set_parent,
> +};
> +
> +const struct clk_ops spacemit_ccu_div_ops = {
> +	.determine_rate = ccu_mix_determine_rate,
> +	.recalc_rate	= ccu_div_recalc_rate,
> +	.set_rate	= ccu_mix_set_rate,
> +};
> +
> +const struct clk_ops spacemit_ccu_gate_factor_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +
> +	.round_rate	= ccu_factor_round_rate,
> +	.recalc_rate	= ccu_factor_recalc_rate,
> +	.set_rate	= ccu_factor_set_rate,
> +};
> +
> +const struct clk_ops spacemit_ccu_mux_gate_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +
> +	.determine_rate = ccu_mix_determine_rate,
> +	.get_parent	= ccu_mux_get_parent,
> +	.set_parent	= ccu_mux_set_parent,
> +};
> +
> +const struct clk_ops spacemit_ccu_div_gate_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +
> +	.determine_rate = ccu_mix_determine_rate,
> +	.recalc_rate	= ccu_div_recalc_rate,
> +	.set_rate	= ccu_mix_set_rate,
> +};
> +
> +const struct clk_ops spacemit_ccu_div_mux_gate_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +
> +	.get_parent	= ccu_mux_get_parent,
> +	.set_parent	= ccu_mux_set_parent,
> +
> +	.determine_rate = ccu_mix_determine_rate,
> +	.recalc_rate	= ccu_div_recalc_rate,
> +	.set_rate	= ccu_mix_set_rate,
> +};
> +
> +const struct clk_ops spacemit_ccu_div_mux_ops = {
> +	.get_parent	= ccu_mux_get_parent,
> +	.set_parent	= ccu_mux_set_parent,
> +
> +	.determine_rate = ccu_mix_determine_rate,
> +	.recalc_rate	= ccu_div_recalc_rate,
> +	.set_rate	= ccu_mix_set_rate,
> +};
> diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> new file mode 100644
> index 000000000000..a3aa292d073d
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_mix.h
> @@ -0,0 +1,246 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#ifndef _CCU_MIX_H_
> +#define _CCU_MIX_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +
> +struct ccu_gate_config {
> +	u32 mask;
> +};
> +
> +struct ccu_factor_config {
> +	u32 div;
> +	u32 mul;
> +};
> +
> +struct ccu_mux_config {
> +	u8 shift;
> +	u8 width;
> +};
> +
> +struct ccu_div_config {
> +	u8 shift;
> +	u8 width;
> +};
> +
> +struct ccu_mix {
> +	struct ccu_factor_config factor;
> +	struct ccu_gate_config gate;
> +	struct ccu_div_config div;
> +	struct ccu_mux_config mux;
> +	struct ccu_common common;
> +};
> +
> +#define CCU_GATE_INIT(_mask) { .mask = _mask }
> +#define CCU_FACTOR_INIT(_div, _mul) { .div = _div, .mul = _mul }
> +#define CCU_MUX_INIT(_shift, _width) { .shift = _shift, .width = _width }
> +#define CCU_DIV_INIT(_shift, _width) { .shift = _shift, .width = _width }
> +
> +#define CCU_PARENT_HW(_parent)		{ .hw = &_parent.common.hw }
> +#define CCU_PARENT_NAME(_name)		{ .fw_name = #_name }
> +
> +#define CCU_MIX_INITHW(_name, _parent, _ops, _flags)			\
> +	(&(struct clk_init_data) {					\
> +		.flags		= _flags,				\
> +		.name		= #_name,				\
> +		.parent_data	= (const struct clk_parent_data[])	\
> +					{ _parent },			\
> +		.num_parents	= 1,					\
> +		.ops		= &_ops,				\
> +	})
> +
> +#define CCU_MIX_INITHW_PARENTS(_name, _parents, _ops, _flags)		\
> +	CLK_HW_INIT_PARENTS_DATA(#_name, _parents, &_ops, _flags)
> +
> +#define CCU_GATE_DEFINE(_name, _parent, _reg, _gate_mask, _flags)		\
> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.common	= {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_gate_ops, _flags),	\
> +	}									\
> +}
> +
> +#define CCU_FACTOR_DEFINE(_name, _parent, _div, _mul)				\
> +struct ccu_mix _name = {							\
> +	.factor	= CCU_FACTOR_INIT(_div, _mul),					\
> +	.common = {								\
> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_factor_ops, 0),		\
> +	}									\
> +}
> +
> +#define CCU_MUX_DEFINE(_name, _parents, _reg, _shift, _width, _flags)		\
> +struct ccu_mix _name = {							\
> +	.mux	= CCU_MUX_INIT(_shift, _width),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_mux_ops,	_flags),\
> +	}									\
> +}
> +
> +#define CCU_DIV_DEFINE(_name, _parent, _reg, _shift, _width, _flags)		\
> +struct ccu_mix _name = {							\
> +	.div	= CCU_DIV_INIT(_shift, _width),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_div_ops, _flags)		\
> +	}									\
> +}
> +
> +#define CCU_GATE_FACTOR_DEFINE(_name, _parent,					\
> +			       _reg,						\
> +			       _gate_mask,					\
> +			       _div, _mul,					\
> +			       _flags)						\
> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.factor	= CCU_FACTOR_INIT(_div, _mul),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_gate_factor_ops, _flags)	\
> +	}									\
> +}
> +
> +#define CCU_MUX_GATE_DEFINE(_name, _parents,					\
> +			    _reg,						\
> +			    _shift, _width,					\
> +			    _gate_mask,						\
> +			    _flags)						\
> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.mux	= CCU_MUX_INIT(_shift, _width),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_mux_gate_ops,	\
> +						  _flags),			\
> +	}									\
> +}
> +
> +#define CCU_DIV_GATE_DEFINE(_name, _parent,					\
> +			    _reg,						\
> +			    _shift, _width,					\
> +			    _gate_mask,						\
> +			    _flags)						\
> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.div	= CCU_DIV_INIT(_shift, _width),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_div_gate_ops, _flags),	\
> +	}									\
> +}
> +
> +#define CCU_DIV_MUX_GATE_DEFINE(_name, _parents,				\
> +				_reg_ctrl,					\
> +				_mshift, _mwidth, _muxshift, _muxwidth,		\
> +				_gate_mask,					\
> +				_flags)						\
> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.div	= CCU_DIV_INIT(_mshift, _mwidth),				\
> +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
> +	.common	= {								\
> +		.reg_ctrl	= _reg_ctrl,					\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_div_mux_gate_ops,\
> +						  _flags),			\
> +	},									\
> +}
> +
> +#define CCU_DIV_SPLIT_FC_MUX_GATE_DEFINE(_name, _parents,			\
> +					 _reg_ctrl, _reg_fc,			\
> +					 _mshift, _mwidth,			\
> +					 _fc,					\
> +					 _muxshift, _muxwidth,			\
> +					 _gate_mask,				\
> +					 _flags)				\
> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.div	= CCU_DIV_INIT(_mshift, _mwidth),				\
> +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
> +	.common = {								\
> +		.reg_ctrl	= _reg_ctrl,					\
> +		.reg_fc		= _reg_fc,					\
> +		.fc		= _fc,						\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_div_mux_gate_ops,\
> +						  _flags),			\
> +	},									\
> +}
> +
> +#define CCU_DIV_FC_MUX_GATE_DEFINE(_name, _parents,				\
> +				   _reg_ctrl,					\
> +				   _mshift, _mwidth,				\
> +				   _fc,						\
> +				   _muxshift, _muxwidth,			\
> +				   _gate_mask, _flags)		\
> +CCU_DIV_SPLIT_FC_MUX_GATE_DEFINE(_name, _parents, _reg_ctrl, _reg_ctrl,		\
> +				 _mshift, _mwidth, _fc, _muxshift, _muxwidth,		\
> +				 _gate_mask, _flags)
> +
> +#define CCU_DIV_FC_MUX_DEFINE(_name, _parents,					\
> +			      _reg_ctrl,					\
> +			      _mshift, _mwidth,					\
> +			      _fc,						\
> +			      _muxshift, _muxwidth,				\
> +			      _flags)						\
> +struct ccu_mix _name = {							\
> +	.div	= CCU_DIV_INIT(_mshift, _mwidth),				\
> +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
> +	.common = {								\
> +		.reg_ctrl	= _reg_ctrl,					\
> +		.reg_fc		= _reg_ctrl,					\
> +		.fc		= _fc,						\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_div_mux_ops,	\
> +						  _flags),			\
> +	},									\
> +}
> +
> +#define CCU_MUX_FC_DEFINE(_name, _parents,					\
> +			  _reg_ctrl,						\
> +			  _fc,							\
> +			  _muxshift, _muxwidth,					\
> +			  _flags)						\
> +struct ccu_mix _name = {							\
> +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
> +	.common = {								\
> +		.reg_ctrl	= _reg_ctrl,					\
> +		.reg_fc		= _reg_ctrl,					\
> +		.fc		= _fc,						\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_mux_ops,	_flags)	\
> +	},									\
> +}
> +
> +static inline struct ccu_mix *hw_to_ccu_mix(struct clk_hw *hw)
> +{
> +	struct ccu_common *common = hw_to_ccu_common(hw);
> +
> +	return container_of(common, struct ccu_mix, common);
> +}
> +
> +extern const struct clk_ops spacemit_ccu_gate_ops, spacemit_ccu_factor_ops;
> +extern const struct clk_ops spacemit_ccu_mux_ops, spacemit_ccu_div_ops;
> +
> +extern const struct clk_ops spacemit_ccu_gate_factor_ops;
> +extern const struct clk_ops spacemit_ccu_div_gate_ops;
> +extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> +extern const struct clk_ops spacemit_ccu_div_mux_ops;
> +
> +extern const struct clk_ops spacemit_ccu_div_mux_gate_ops;
> +#endif /* _CCU_DIV_H_ */
> diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
> new file mode 100644
> index 000000000000..9df2149f6c98
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_pll.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit clock type pll
> + *
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_pll.h"
> +
> +#define PLL_DELAY_TIME	3000
> +
> +#define PLL_SWCR3_EN	BIT(31)
> +
> +static int ccu_pll_is_enabled(struct clk_hw *hw)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	u32 tmp;
> +
> +	ccu_read(swcr3, &p->common, &tmp);
> +
> +	return tmp & PLL_SWCR3_EN;
> +}
> +
> +/* frequency unit Mhz, return pll vco freq */
> +static unsigned long ccu_pll_get_vco_freq(struct clk_hw *hw)
> +{
> +	const struct ccu_pll_rate_tbl *pll_rate_table;
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_common *common = &p->common;
> +	u32 swcr1, swcr3, size;
> +	int i;
> +
> +	ccu_read(swcr1, common, &swcr1);
> +	ccu_read(swcr3, common, &swcr3);
> +	swcr3 &= ~PLL_SWCR3_EN;
> +
> +	pll_rate_table = p->pll.rate_tbl;
> +	size = p->pll.tbl_size;
> +
> +	for (i = 0; i < size; i++) {
> +		if (pll_rate_table[i].swcr1 == swcr1 &&
> +		    pll_rate_table[i].swcr3 == swcr3)
> +			return pll_rate_table[i].rate;
> +	}
> +
> +	WARN_ON_ONCE(1);
> +
> +	return 0;
> +}
> +
> +static int ccu_pll_enable(struct clk_hw *hw)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_common *common = &p->common;
> +	unsigned int tmp;
> +	int ret;
> +
> +	if (ccu_pll_is_enabled(hw))
> +		return 0;
> +
> +	ccu_update(swcr3, common, PLL_SWCR3_EN, PLL_SWCR3_EN);
> +
> +	/* check lock status */
> +	ret = regmap_read_poll_timeout_atomic(common->lock_regmap,
> +					      p->pll.reg_lock,
> +					      tmp,
> +					      tmp & p->pll.lock_enable_bit,
> +					      5, PLL_DELAY_TIME);
> +
> +	return ret;
> +}
> +
> +static void ccu_pll_disable(struct clk_hw *hw)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_common *common = &p->common;
> +
> +	ccu_update(swcr3, common, PLL_SWCR3_EN, 0);
> +}
> +
> +/*
> + * PLLs must be gated before changing rate, which is ensured by
> + * flag CLK_SET_RATE_GATE.
> + */
> +static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_common *common = &p->common;
> +	struct ccu_pll_config *params = &p->pll;
> +	const struct ccu_pll_rate_tbl *entry = NULL;
> +	int i;
> +
> +	for (i = 0; i < params->tbl_size; i++) {
> +		if (rate == params->rate_tbl[i].rate) {
> +			entry = &params->rate_tbl[i];
> +			break;
> +		}
> +	}
> +
> +	if (WARN_ON_ONCE(!entry))
> +		return -EINVAL;
> +
> +	ccu_update(swcr1, common, entry->swcr1, entry->swcr1);
> +	ccu_update(swcr3, common, (u32)~PLL_SWCR3_EN, entry->swcr3);
> +
> +	return 0;
> +}
> +
> +static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	return ccu_pll_get_vco_freq(hw);
> +}
> +
> +static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *prate)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_pll_config *params = &p->pll;
> +	unsigned int i;
> +
> +	for (i = 0; i < params->tbl_size; i++) {
> +		if (params->rate_tbl[i].rate > rate) {
> +			i--;
> +			break;
> +		}
> +	}
> +
> +	return rate;
> +}
> +
> +const struct clk_ops spacemit_ccu_pll_ops = {
> +	.enable		= ccu_pll_enable,
> +	.disable	= ccu_pll_disable,
> +	.set_rate	= ccu_pll_set_rate,
> +	.recalc_rate	= ccu_pll_recalc_rate,
> +	.round_rate	= ccu_pll_round_rate,
> +	.is_enabled	= ccu_pll_is_enabled,
> +};
> +
> diff --git a/drivers/clk/spacemit/ccu_pll.h b/drivers/clk/spacemit/ccu_pll.h
> new file mode 100644
> index 000000000000..c6a3a5cce995
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_pll.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#ifndef _CCU_PLL_H_
> +#define _CCU_PLL_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +
> +struct ccu_pll_rate_tbl {
> +	unsigned long rate;
> +	u32 swcr1;
> +	u32 swcr3;
> +};
> +
> +struct ccu_pll_config {
> +	const struct ccu_pll_rate_tbl *rate_tbl;
> +	u32 tbl_size;
> +	u32 reg_lock;
> +	u32 lock_enable_bit;
> +};
> +
> +#define CCU_PLL_RATE(_rate, _swcr1, _swcr3) \
> +	{									\
> +		.rate	= _rate,							\
> +		.swcr1	= _swcr1,						\
> +		.swcr3	= _swcr3,						\
> +	}
> +
> +struct ccu_pll {
> +	struct ccu_pll_config	pll;
> +	struct ccu_common	common;
> +};
> +
> +#define CCU_PLL_CONFIG(_table, _reg_lock, _lock_enable_bit) \
> +	{									\
> +		.rate_tbl	 = _table,					\
> +		.tbl_size	 = ARRAY_SIZE(_table),				\
> +		.reg_lock	 = (_reg_lock),					\
> +		.lock_enable_bit = (_lock_enable_bit),				\
> +	}
> +
> +#define CCU_PLL_HWINIT(_name, _flags)						\
> +	(&(struct clk_init_data) {						\
> +		.name		= #_name,					\
> +		.ops		= &spacemit_ccu_pll_ops,			\
> +		.parent_data	= &(struct clk_parent_data) { .index = 0 },	\
> +		.num_parents	= 1,						\
> +		.flags		= _flags,					\
> +	})
> +
> +#define CCU_PLL_DEFINE(_name, _table, _reg_swcr1, _reg_swcr3,			\
> +		       _reg_lock, _lock_enable_bit, _flags)			\
> +	struct ccu_pll _name = {						\
> +		.pll	= CCU_PLL_CONFIG(_table, _reg_lock, _lock_enable_bit),	\
> +		.common = {							\
> +			.reg_swcr1	= _reg_swcr1,				\
> +			.reg_swcr3	= _reg_swcr3,				\
> +			.hw.init	= CCU_PLL_HWINIT(_name, _flags)		\
> +		}								\
> +	}
> +
> +static inline struct ccu_pll *hw_to_ccu_pll(struct clk_hw *hw)
> +{
> +	struct ccu_common *common = hw_to_ccu_common(hw);
> +
> +	return container_of(common, struct ccu_pll, common);
> +}
> +
> +extern const struct clk_ops spacemit_ccu_pll_ops;
> +
> +#endif
> -- 
> 2.48.1
> 
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

