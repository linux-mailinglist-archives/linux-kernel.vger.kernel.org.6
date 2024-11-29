Return-Path: <linux-kernel+bounces-425708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E369DE973
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D57282519
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6014A098;
	Fri, 29 Nov 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYfJWagc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C30647;
	Fri, 29 Nov 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894341; cv=none; b=uX/wT90OK5FF7ihOq84AJYt/YZbGIGvegCjJPoaCcwHGNPXC74RuhWgbwv8MSbbVYByyXnm581Pn5rCRZNwYTvo/tSqml5pV4X5rdo7Fc8aahdxElQdhIcMzQL2rVqfllnPLy1qox5Ug4AndUThP3MvUAtkUilOeJN0f9dNcExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894341; c=relaxed/simple;
	bh=VORdR2oTefI9Q07TPIcBdkIpcos+5okYlhQ1JFze8e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtN55ri9ajKFFEn+XIgAIDyqEbpUAIZCtblGjpDeCqxIDOuVcELKcHmoVBVJQiSR89eqsznsY15VZ8bcwocnvY3/Uu1Sgi64be2pDcM5J5xxwhs+pqvaSAalf/ULmKY8oEfEjbuX5Q6zHUCRHX2PrgumFgGPRdFJ+DwvlEcIYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYfJWagc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732894340; x=1764430340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VORdR2oTefI9Q07TPIcBdkIpcos+5okYlhQ1JFze8e4=;
  b=KYfJWagcyoeP7w7hiFrIYWhcmmGTfCjMN2CvkZBv5fSkHFb0SZloGfCN
   zWxa5w5MjjeJ25qeMDkuWK6xCKbBYJIzNLo7mThehbeSff+k14m9b7kBg
   fFgyyNaUbxbQ1xOAqZN+BBWEuN0FqmZrZYOMN+bOAyPUlbZi45aMIK00Q
   Qny9Xax+IkrOyDam3rJ9UH48Jo4uyXmiHNQRTRJbRkOibefkdyu8Tex8R
   CY0FMiI4DCSU/5vqzLXVisNbVTiz0zk8ljQFsjKEXSHpCrm/MmALY/KEC
   wlBhXNWZxzacOjmfkCPKkwntFF6h4MbD8tKlL430YejS0hXEIQYh++kkb
   w==;
X-CSE-ConnectionGUID: AbFpxLqrRkqL/+KoInmQPg==
X-CSE-MsgGUID: NOtW8f+STB+n+kwLKV0Exw==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="37066646"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="37066646"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 07:32:19 -0800
X-CSE-ConnectionGUID: PihCXGuDQu6h1LwuDv3v0A==
X-CSE-MsgGUID: MmX9NisoSsWTwkpO78HDdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="123379883"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Nov 2024 07:32:16 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tH2yb-0000SV-12;
	Fri, 29 Nov 2024 15:32:13 +0000
Date: Fri, 29 Nov 2024 23:31:50 +0800
From: kernel test robot <lkp@intel.com>
To: Haylen Chu <heylenay@4d2.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v3 3/3] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <202411292351.6EVdr1rF-lkp@intel.com>
References: <20241126143125.9980-7-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126143125.9980-7-heylenay@4d2.org>

Hi Haylen,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2d5404caa8c7bb5c4e0435f94b28834ae5456623]

url:    https://github.com/intel-lab-lkp/linux/commits/Haylen-Chu/dt-bindings-clock-spacemit-Add-clock-controllers-of-Spacemit-K1-SoC/20241128-101248
base:   2d5404caa8c7bb5c4e0435f94b28834ae5456623
patch link:    https://lore.kernel.org/r/20241126143125.9980-7-heylenay%404d2.org
patch subject: [PATCH v3 3/3] clk: spacemit: Add clock support for Spacemit K1 SoC
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20241129/202411292351.6EVdr1rF-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411292351.6EVdr1rF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411292351.6EVdr1rF-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/spacemit/ccu_pll.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/spacemit/ccu_pll.o
ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/spacemit/ccu_mix.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/spacemit/ccu_mix.o
ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/spacemit/ccu_ddn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/spacemit/ccu_ddn.o
>> ERROR: modpost: "spacemit_ccu_mix_ops" [drivers/clk/spacemit/ccu-k1.ko] undefined!
>> ERROR: modpost: "spacemit_ccu_ddn_ops" [drivers/clk/spacemit/ccu-k1.ko] undefined!
>> ERROR: modpost: "spacemit_ccu_pll_ops" [drivers/clk/spacemit/ccu-k1.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

