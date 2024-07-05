Return-Path: <linux-kernel+bounces-242740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F4928C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A62B24761
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5213A88B;
	Fri,  5 Jul 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1bygSiH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D41C2AF;
	Fri,  5 Jul 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720197927; cv=none; b=S5VSHc5vnxBNch/xltwmb6UMv4T1/oansCdOcXgqNX0y60e/ajxTJf5fSCBG0jH81AoSyC6AZSvZudOdt8S43y8Um8mdsuQ7mKfE2Cu2o8OzbWgZVuvYhWBU5lYSce9wBhLiSjOHUK87qqN0Z6SC9PompWxYAsQW2hyVbfQTCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720197927; c=relaxed/simple;
	bh=OD8+iNTIFkahsNCwhbTydhgfhD6SOrrUCh7L173p4eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPCWXhzS7QJIzYmr6s1GWzBdT0LQ2f4gM0pnT5I8KRmTzeaceRBm1aCjrEqnKsK+IXXdCbrxjbQKxlaxNmW25LbTXSVoMRL17EhpUtqGmFH5Aj1JieRpAV8ZVjNaofhmCmN6Z4wfQhdfFhM4mmZNUspiFC5fRq5ECESEKAQuKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1bygSiH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720197925; x=1751733925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OD8+iNTIFkahsNCwhbTydhgfhD6SOrrUCh7L173p4eg=;
  b=e1bygSiHht/X7DFeE+mvArqhZ7DUOs7hLCGBcn3/vtONWU548qQHagHm
   mNf3NpdrsDennhBR1W6rdJVyBqwxeDhBc/mkCABjZ8/LGRxUSPYMDsCc7
   xHizE0PZDNRh6FxaRXzM4b84iGxnzvrJwNXh93Hy7jNpNPN6nVeIKh+9m
   cwqeOsCNX94jhadDNOUmotd1QDK9Z5120hvDBDSnlJMA1UQsB72AhhpiQ
   V+PwkyWRagFSz5/Hss2gDXZXb8xnX65VhB33VnLE4ScgVocLhVm83DqXH
   8bzuK8BdL5jgPvETUEUvJPJ9UgKjshEwQBY/9T0zhOYi2UYPh0xAxzZxy
   w==;
X-CSE-ConnectionGUID: NYCpU5puQdW+RcvOTffzMQ==
X-CSE-MsgGUID: hc5719fpSl2NGODBO1S6ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="40005223"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="40005223"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 09:45:25 -0700
X-CSE-ConnectionGUID: DwxpxFj6TXSvrIiAJrIqXA==
X-CSE-MsgGUID: EhoeIemwQLuww1Tva0dPaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="77663354"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Jul 2024 09:45:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPm3j-000ScG-1L;
	Fri, 05 Jul 2024 16:45:19 +0000
Date: Sat, 6 Jul 2024 00:41:53 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 4/4] clk: eyeq: add driver
Message-ID: <202407060044.YQzDGVPu-lkp@intel.com>
References: <20240703-mbly-clk-v2-4-fe8c6199a579@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703-mbly-clk-v2-4-fe8c6199a579@bootlin.com>

Hi Théo,

kernel test robot noticed the following build errors:

[auto build test ERROR on f2661062f16b2de5d7b6a5c42a9a5c96326b8454]

url:    https://github.com/intel-lab-lkp/linux/commits/Th-o-Lebrun/Revert-dt-bindings-clock-mobileye-eyeq5-clk-add-bindings/20240704-211515
base:   f2661062f16b2de5d7b6a5c42a9a5c96326b8454
patch link:    https://lore.kernel.org/r/20240703-mbly-clk-v2-4-fe8c6199a579%40bootlin.com
patch subject: [PATCH v2 4/4] clk: eyeq: add driver
config: s390-randconfig-r132-20240705 (https://download.01.org/0day-ci/archive/20240706/202407060044.YQzDGVPu-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240706/202407060044.YQzDGVPu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407060044.YQzDGVPu-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/clk/clk-eyeq.c: In function 'eqc_init':
>> drivers/clk/clk-eyeq.c:679:62: warning: dereferencing 'void *' pointer
     679 |         early_data = of_match_node(eqc_early_match_table, np)->data;
         |                                                              ^~
>> drivers/clk/clk-eyeq.c:679:62: error: request for member 'data' in something not a structure or union
   drivers/clk/clk-eyeq.c: At top level:
>> drivers/clk/clk-eyeq.c:653:34: warning: 'eqc_early_match_table' defined but not used [-Wunused-const-variable=]
     653 | static const struct of_device_id eqc_early_match_table[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~


vim +/data +679 drivers/clk/clk-eyeq.c

   652	
 > 653	static const struct of_device_id eqc_early_match_table[] = {
   654		{
   655			.compatible = "mobileye,eyeq5-olb",
   656			.data = &eqc_eyeq5_early_match_data,
   657		},
   658		{
   659			.compatible = "mobileye,eyeq6h-central-olb",
   660			.data = &eqc_eyeq6h_central_early_match_data,
   661		},
   662		{
   663			.compatible = "mobileye,eyeq6h-west-olb",
   664			.data = &eqc_eyeq6h_west_early_match_data,
   665		},
   666		{}
   667	};
   668	MODULE_DEVICE_TABLE(of, eqc_early_match_table);
   669	
   670	static void __init eqc_init(struct device_node *np)
   671	{
   672		const struct eqc_early_match_data *early_data;
   673		unsigned int nb_clks = 0;
   674		struct eqc_priv *priv;
   675		void __iomem *base;
   676		unsigned int i;
   677		int ret;
   678	
 > 679		early_data = of_match_node(eqc_early_match_table, np)->data;
   680	
   681		/* No reason to early init this clock provider. Delay until probe. */
   682		if (!early_data || early_data->early_pll_count == 0)
   683			return;
   684	
   685		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
   686		if (!priv) {
   687			ret = -ENOMEM;
   688			goto err;
   689		}
   690	
   691		priv->np = np;
   692		priv->early_data = early_data;
   693	
   694		nb_clks = early_data->early_pll_count + early_data->nb_late_clks;
   695		priv->cells = kzalloc(struct_size(priv->cells, hws, nb_clks), GFP_KERNEL);
   696		if (!priv->cells) {
   697			ret = -ENOMEM;
   698			goto err;
   699		}
   700	
   701		priv->cells->num = nb_clks;
   702	
   703		/*
   704		 * Mark all clocks as deferred; some are registered here, the rest at
   705		 * platform device probe.
   706		 */
   707		for (i = 0; i < nb_clks; i++)
   708			priv->cells->hws[i] = ERR_PTR(-EPROBE_DEFER);
   709	
   710		/* Offsets (reg64) of early PLLs are relative to OLB block. */
   711		base = of_iomap(np, 0);
   712		if (!base) {
   713			ret = -ENODEV;
   714			goto err;
   715		}
   716	
   717		for (i = 0; i < early_data->early_pll_count; i++) {
   718			const struct eqc_pll *pll = &early_data->early_plls[i];
   719			unsigned long mult, div, acc;
   720			struct clk_hw *hw;
   721			u32 r0, r1;
   722			u64 val;
   723	
   724			val = readq(base + pll->reg64);
   725			r0 = val;
   726			r1 = val >> 32;
   727	
   728			ret = eqc_pll_parse_registers(r0, r1, &mult, &div, &acc);
   729			if (ret) {
   730				pr_err("failed parsing state of %s\n", pll->name);
   731				goto err;
   732			}
   733	
   734			hw = clk_hw_register_fixed_factor_with_accuracy_fwname(NULL,
   735					np, pll->name, "ref", 0, mult, div, acc);
   736			priv->cells->hws[pll->index] = hw;
   737			if (IS_ERR(hw)) {
   738				pr_err("failed registering %s: %pe\n", pll->name, hw);
   739				ret = PTR_ERR(hw);
   740				goto err;
   741			}
   742		}
   743	
   744		/* When providing a single clock, require no cell. */
   745		if (nb_clks == 1)
   746			ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, priv->cells->hws[0]);
   747		else
   748			ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, priv->cells);
   749		if (ret) {
   750			pr_err("failed registering clk provider: %d\n", ret);
   751			goto err;
   752		}
   753	
   754		spin_lock(&eqc_list_slock);
   755		list_add_tail(&priv->list, &eqc_list);
   756		spin_unlock(&eqc_list_slock);
   757	
   758		return;
   759	
   760	err:
   761		/*
   762		 * We are doomed. The system will not be able to boot.
   763		 *
   764		 * Let's still try to be good citizens by freeing resources and print
   765		 * a last error message that might help debugging.
   766		 */
   767	
   768		if (priv && priv->cells) {
   769			of_clk_del_provider(np);
   770	
   771			for (i = 0; i < early_data->early_pll_count; i++) {
   772				const struct eqc_pll *pll = &early_data->early_plls[i];
   773				struct clk_hw *hw = priv->cells->hws[pll->index];
   774	
   775				if (!IS_ERR_OR_NULL(hw))
   776					clk_hw_unregister_fixed_factor(hw);
   777			}
   778	
   779			kfree(priv->cells);
   780		}
   781	
   782		kfree(priv);
   783	
   784		pr_err("failed clk init: %d\n", ret);
   785	}
   786	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

