Return-Path: <linux-kernel+bounces-252995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A77931AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70250283308
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAB613AA46;
	Mon, 15 Jul 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtXmA/F6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457613A3F7;
	Mon, 15 Jul 2024 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071641; cv=none; b=mtQAb4ZnZLQa9L/mgRLY0BAgK/xteZ1UT999y7jbHRgkTEjFAuj61NXxa213cv5bUsm0Io2HaNf5gO8gPPXflThZSiAa6O/EhL9ThkGX4Y6SBGabLFfnQKiUEs7cKJuO9cVU7H+a8g+F8TDrM5cLTo0I8jDAw7LLe8hgNX5xHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071641; c=relaxed/simple;
	bh=scvD8E1Th0WQEDOblbw8afBg6ubsAWbPK3/2sSh0+fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8U/x1nU5/M8qDzYs6/22xdN1aEpaFy8As+tuaVxgJn720jwj3ArrvpdfLaAQiVyWOet+GHaFKlCU8ocTcKgofDEJhQu6jyNI+A7DeH/zfOCfyOjLs0lsa3+ot1hr08l14Mu0JMI3M/XZ/nefynbCEoXbQYS8Gbmawrc0mEGqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtXmA/F6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721071639; x=1752607639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=scvD8E1Th0WQEDOblbw8afBg6ubsAWbPK3/2sSh0+fU=;
  b=HtXmA/F6/KE2CMFkbPzZNMEa46dmYLgUq3aKvtZwf1D5iCxb8OOQW4TD
   MEie7xahjkY25LpcCsY25wSBHzebFxGdN1O3oayoHwghBKnXHBLom0DaP
   LYzCdMOTnfB94l7f7ag1q1IEgK6u+vH0DKF3WVuP8mr8h7yXw04W0gKfJ
   zyRuC3yt1glqApmAl9Mu2s/ungdkqGTvf1Z1/6UmHyBBX5X4ExadgsNSi
   ZcklIrIpP8qOcqvB1ex0KFAwvCJOmg/kjzRMMFL9cejujUDYDuLXe6ejn
   i7qFLs757lVnePUITbRqk3QHG9sRS+tG8czAn0jYMB9S3g3WlpHpqxzvl
   A==;
X-CSE-ConnectionGUID: Sxq8eHrwSYO1cWImrQ8CMQ==
X-CSE-MsgGUID: 9AmPuoaUSrCOCQ0lH6Oekg==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18342895"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18342895"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 12:27:19 -0700
X-CSE-ConnectionGUID: 2Tdnb+rbRk+Wk2mkoCoccg==
X-CSE-MsgGUID: 1KBBHSXLTp670BMn/kdLJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="72960660"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jul 2024 12:27:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTRLt-000eWK-35;
	Mon, 15 Jul 2024 19:27:13 +0000
Date: Tue, 16 Jul 2024 03:26:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH RESEND v12 4/6] clk: wpcm450: Add Nuvoton WPCM450
 clock/reset controller driver
Message-ID: <202407160235.JYThNv91-lkp@intel.com>
References: <20240708-wpcm-clk-v12-4-1afac539c37d@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708-wpcm-clk-v12-4-1afac539c37d@gmx.net>

Hi Jonathan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4cece764965020c22cff7665b18a012006359095]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Neusch-fer/dt-bindings-clock-Add-Nuvoton-WPCM450-clock-reset-controller/20240708-073926
base:   4cece764965020c22cff7665b18a012006359095
patch link:    https://lore.kernel.org/r/20240708-wpcm-clk-v12-4-1afac539c37d%40gmx.net
patch subject: [PATCH RESEND v12 4/6] clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
config: arm-randconfig-r064-20240715 (https://download.01.org/0day-ci/archive/20240716/202407160235.JYThNv91-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407160235.JYThNv91-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/clk/nuvoton/clk-wpcm450.c:55:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.

vim +55 drivers/clk/nuvoton/clk-wpcm450.c

    36	
    37	static unsigned long wpcm450_clk_pll_recalc_rate(struct clk_hw *hw,
    38							 unsigned long parent_rate)
    39	{
    40		struct wpcm450_clk_pll *pll = to_wpcm450_clk_pll(hw);
    41		unsigned long fbdv, indv, otdv;
    42		u64 rate;
    43		u32 pllcon;
    44	
    45		if (parent_rate == 0)
    46			return 0;
    47	
    48		pllcon = readl_relaxed(pll->pllcon);
    49	
    50		indv = FIELD_GET(PLLCON_INDV, pllcon) + 1;
    51		fbdv = FIELD_GET(PLLCON_FBDV, pllcon) + 1;
    52		otdv = FIELD_GET(PLLCON_OTDV, pllcon) + 1;
    53	
    54		rate = (u64)parent_rate * fbdv;
  > 55		do_div(rate, indv * otdv);
    56	
    57		return rate;
    58	}
    59	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

