Return-Path: <linux-kernel+bounces-299955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE37495DCDD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383821F220E9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E896155315;
	Sat, 24 Aug 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HI5TDGrd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB133062;
	Sat, 24 Aug 2024 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724486702; cv=none; b=VzI0eVVXm/Q0L2tSMFibC/+yvvPABXMmEGZtqIxwjoV3ahO5SMeRCn/PMsAe8uEcngzppti1/n1e0uHN3ku6E/enTHnZTsvU19/ewHG+acjiEmeA3BHcUMzWsvC/1hd8k+VOQFoWR3tVNLewO8DtKUlTdokN32rwMvpUEcFODng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724486702; c=relaxed/simple;
	bh=foS8KQkUxVxkulvd5nUBkVF0PXcyoL+M3U6ZzApzLw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Krj4sEKG0Mu0QysOC8jviAPGaX4Q/9gQGLJllyGAzTHugHiWS01XRmPJrc9hle3N9drENf9uGBbUBpV91CPKWxBx7XaptdnNCTm2Ju7piXdcU4Q9bE8svJtoArs96h7BPF5vHoeav1tiaJHfVM9sB16fSpSjH1m71qhY/N1LthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HI5TDGrd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724486700; x=1756022700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=foS8KQkUxVxkulvd5nUBkVF0PXcyoL+M3U6ZzApzLw8=;
  b=HI5TDGrdGKPYD5z3vdNmzEcTvbmRxhWAPdV/62jxNz/QA9Q+SD0mbtXq
   jtS38QVkVvzgoN5+1bMK1jBnarPhXmF8rYAv7XuExQBgU47Rcf/Ei+ad1
   w/OtsybBLhAXs3eAg6znzCiTTDYB2nmei2FsvTYQei3zWL/IcRQoZ+Ek9
   qr9RadIk2bQ6zBdktgV9KG9BFras9fSE0FbsOEw7L1uGHmrp2pQMINeu6
   86WVr93SKybCjH6db26fzq8MsuNwMQ6BJwdQ51K6ZYyGukXe6OM58fMg2
   HFRE8r6v/KTpnB9/EUlVblnk8HSulpJ3mJw1/noMJkYi5RwD1VbuDeCDa
   Q==;
X-CSE-ConnectionGUID: fdjLyhAMQ3yrp0VPelTDSA==
X-CSE-MsgGUID: cF16ebplReKkj1w8oNiZag==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22489983"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="22489983"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 01:05:00 -0700
X-CSE-ConnectionGUID: tj1nqfCfRZaaoIrsX3mpdw==
X-CSE-MsgGUID: ZmcisiiRSQeizrFvnZT1zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="61717198"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Aug 2024 01:04:57 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shllX-000ELb-0a;
	Sat, 24 Aug 2024 08:04:55 +0000
Date: Sat, 24 Aug 2024 16:04:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, chenhuacai@kernel.org,
	Kevin Wheatfox <enkerewpo@hotmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] of_reserved_mem: Save region name string into struct
 reserved_mem
Message-ID: <202408241510.Rk14q8Rg-lkp@intel.com>
References: <20240821-save_resv_name-v1-1-b9c17f103ffb@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821-save_resv_name-v1-1-b9c17f103ffb@flygoat.com>

Hi Jiaxun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bb1b0acdcd66e0d8eedee3570d249e076b89ab32]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaxun-Yang/of_reserved_mem-Save-region-name-string-into-struct-reserved_mem/20240821-215235
base:   bb1b0acdcd66e0d8eedee3570d249e076b89ab32
patch link:    https://lore.kernel.org/r/20240821-save_resv_name-v1-1-b9c17f103ffb%40flygoat.com
patch subject: [PATCH] of_reserved_mem: Save region name string into struct reserved_mem
config: i386-buildonly-randconfig-002-20240824 (https://download.01.org/0day-ci/archive/20240824/202408241510.Rk14q8Rg-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240824/202408241510.Rk14q8Rg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408241510.Rk14q8Rg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/of_reserved_mem.c:467:12: warning: address of array 'rmem->name' will always evaluate to 'true' [-Wpointer-bool-conversion]
     467 |                                         rmem->name ? rmem->name : "unknown");
         |                                         ~~~~~~^~~~ ~
   include/linux/printk.h:538:34: note: expanded from macro 'pr_info'
     538 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                                         ^~~~~~~~~~~
   include/linux/printk.h:465:60: note: expanded from macro 'printk'
     465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:437:19: note: expanded from macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   1 warning generated.


vim +467 drivers/of/of_reserved_mem.c

ae1add247bf8c2 Mitchel Humpherys  2015-09-15  426  
3f0c8206644836 Marek Szyprowski   2014-02-28  427  /**
c8813f7ec01c67 chenqiwu           2020-05-11  428   * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
3f0c8206644836 Marek Szyprowski   2014-02-28  429   */
3f0c8206644836 Marek Szyprowski   2014-02-28  430  void __init fdt_init_reserved_mem(void)
3f0c8206644836 Marek Szyprowski   2014-02-28  431  {
3f0c8206644836 Marek Szyprowski   2014-02-28  432  	int i;
ae1add247bf8c2 Mitchel Humpherys  2015-09-15  433  
ae1add247bf8c2 Mitchel Humpherys  2015-09-15  434  	/* check for overlapping reserved regions */
ae1add247bf8c2 Mitchel Humpherys  2015-09-15  435  	__rmem_check_for_overlap();
ae1add247bf8c2 Mitchel Humpherys  2015-09-15  436  
3f0c8206644836 Marek Szyprowski   2014-02-28  437  	for (i = 0; i < reserved_mem_count; i++) {
3f0c8206644836 Marek Szyprowski   2014-02-28  438  		struct reserved_mem *rmem = &reserved_mem[i];
3f0c8206644836 Marek Szyprowski   2014-02-28  439  		unsigned long node = rmem->fdt_node;
3f0c8206644836 Marek Szyprowski   2014-02-28  440  		int err = 0;
6f1188b4ac7577 Yue Hu             2020-07-30  441  		bool nomap;
3f0c8206644836 Marek Szyprowski   2014-02-28  442  
d0b8ed47e83a22 pierre Kuo         2019-02-19  443  		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
9dcfee01930e6c Marek Szyprowski   2014-07-14  444  
3f0c8206644836 Marek Szyprowski   2014-02-28  445  		if (rmem->size == 0)
3f0c8206644836 Marek Szyprowski   2014-02-28  446  			err = __reserved_mem_alloc_size(node, rmem->name,
3f0c8206644836 Marek Szyprowski   2014-02-28  447  						 &rmem->base, &rmem->size);
d0b8ed47e83a22 pierre Kuo         2019-02-19  448  		if (err == 0) {
d0b8ed47e83a22 pierre Kuo         2019-02-19  449  			err = __reserved_mem_init_node(rmem);
d0b8ed47e83a22 pierre Kuo         2019-02-19  450  			if (err != 0 && err != -ENOENT) {
d0b8ed47e83a22 pierre Kuo         2019-02-19  451  				pr_info("node %s compatible matching fail\n",
d0b8ed47e83a22 pierre Kuo         2019-02-19  452  					rmem->name);
d0b8ed47e83a22 pierre Kuo         2019-02-19  453  				if (nomap)
7b25995f5319ad Dong Aisheng       2021-06-11  454  					memblock_clear_nomap(rmem->base, rmem->size);
3c6867a12a224d Dong Aisheng       2021-06-11  455  				else
3ecc68349bbab6 Mike Rapoport      2021-11-05  456  					memblock_phys_free(rmem->base,
3ecc68349bbab6 Mike Rapoport      2021-11-05  457  							   rmem->size);
aeb9267eb6b1df Martin Liu         2023-02-10  458  			} else {
aeb9267eb6b1df Martin Liu         2023-02-10  459  				phys_addr_t end = rmem->base + rmem->size - 1;
aeb9267eb6b1df Martin Liu         2023-02-10  460  				bool reusable =
aeb9267eb6b1df Martin Liu         2023-02-10  461  					(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
aeb9267eb6b1df Martin Liu         2023-02-10  462  
6ee7afbabcee4d Geert Uytterhoeven 2023-02-16  463  				pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
aeb9267eb6b1df Martin Liu         2023-02-10  464  					&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
aeb9267eb6b1df Martin Liu         2023-02-10  465  					nomap ? "nomap" : "map",
aeb9267eb6b1df Martin Liu         2023-02-10  466  					reusable ? "reusable" : "non-reusable",
aeb9267eb6b1df Martin Liu         2023-02-10 @467  					rmem->name ? rmem->name : "unknown");
d0b8ed47e83a22 pierre Kuo         2019-02-19  468  			}
d0b8ed47e83a22 pierre Kuo         2019-02-19  469  		}
3f0c8206644836 Marek Szyprowski   2014-02-28  470  	}
3f0c8206644836 Marek Szyprowski   2014-02-28  471  }
9dcfee01930e6c Marek Szyprowski   2014-07-14  472  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

