Return-Path: <linux-kernel+bounces-342773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABE59892DF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4591C213C4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 03:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADFE1E493;
	Sun, 29 Sep 2024 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjcdGGa9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D718651
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727579593; cv=none; b=DXMR+zZmGzONEMf0F+Jwcu1sPXknK0zQomB8+AbgYbz7BkIken3u9UJ51hcfKlBbbLV1CVOmDj8S40nGf20j/qQL7m1C4/uQwVpnohBEqgVjzZ+kzjcNt3mienhnHGdejEQ0xsaqTFI/wnNc7o383JUJBjF/b9uDm4Uial/BbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727579593; c=relaxed/simple;
	bh=UQ9Qe/CzDyO1SontmUU7wl1QCMoAghIkBPS0nHIhF3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eBF25NkCvn7FlrCd3jKwxnQB9RcZO7fojH2mIIKuhCzqt3qAxNJEzxThvBZLWYBb1rGpqN+0/dBBCckoE8wOEVrnETCzwErM1DTKwlXK+WNhYa3VwLProlwH/BuW+N8g9b/K4u2GQc1w9HdmgSGaXJp0774LryB3M6M29HDnLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjcdGGa9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727579592; x=1759115592;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UQ9Qe/CzDyO1SontmUU7wl1QCMoAghIkBPS0nHIhF3Q=;
  b=gjcdGGa9lr0qw6usXJbQ/IBb9Uf7guICJ5akdqbx8mJM3mlMLA3y23nH
   9D/WXw6WYndljHDggmwJPO12ZvtZUvfPTDEIJiR2bqsXNgZpVQPkZIxxw
   UcoKa++Mq0Pj+Bp7YY6PV+dTB7ek+GC/RM1NW4AM1jdL8GSmMfZwpmbSG
   ELmhfFuwYa7yAyRi47OCfQrP/o0HfYBsqQDkyUoOwMX2RpNGCTzAXO3sC
   oM2/GHG2Niz1XYwfjqXNEtCcR+bsRL6nrpqN2FKL/13UhjZEfsIjAgxo2
   F3w6nTR6O8pfPlV8ltnZ7GiNjY2sJezNl5nSz3U+dbkRy3G/x82qoWPK1
   A==;
X-CSE-ConnectionGUID: t+5fDXRDRDG2GDjX8hXnFA==
X-CSE-MsgGUID: L9g90E/rSJag6dt4qxBwzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26198796"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="26198796"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 20:13:11 -0700
X-CSE-ConnectionGUID: rYlfLtHHR861IkJyrzj7aw==
X-CSE-MsgGUID: GbJjAM1hQr6W2+WnjXewQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="72505130"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Sep 2024 20:13:10 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sukMt-000NrD-2q;
	Sun, 29 Sep 2024 03:13:07 +0000
Date: Sun, 29 Sep 2024 11:12:29 +0800
From: kernel test robot <lkp@intel.com>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Erez Shitrit <erezsh@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c:708:17:
 warning: large atomic operation may incur significant performance penalty;
 the access size (4 bytes) exceeds the max lock-free size (0  bytes)
Message-ID: <202409291101.6NdtMFVC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yevgeny,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3efc57369a0ce8f76bf0804f7e673982384e4ac9
commit: 510f9f61a1121a296a45962760d5e2824277fa37 net/mlx5: HWS, added API and enabled HWS support
date:   3 weeks ago
config: arm-randconfig-r052-20240929 (https://download.01.org/0day-ci/archive/20240929/202409291101.6NdtMFVC-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409291101.6NdtMFVC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409291101.6NdtMFVC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c:4:
   In file included from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_internal.h:7:
   In file included from include/linux/mlx5/transobj.h:36:
   In file included from include/linux/mlx5/driver.h:38:
   In file included from include/linux/pci.h:1646:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c:708:17: warning: large atomic operation may incur significant performance penalty; the access size (4 bytes) exceeds the max lock-free size (0  bytes) [-Watomic-alignment]
     708 |         num_of_rules = __atomic_load_n(&bwc_matcher->num_of_rules, __ATOMIC_RELAXED);
         |                        ^
   2 warnings generated.


vim +708 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c

2111bb970c787b Yevgeny Kliteynik 2024-06-20  690  
2111bb970c787b Yevgeny Kliteynik 2024-06-20  691  static int
2111bb970c787b Yevgeny Kliteynik 2024-06-20  692  hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
2111bb970c787b Yevgeny Kliteynik 2024-06-20  693  {
2111bb970c787b Yevgeny Kliteynik 2024-06-20  694  	u32 num_of_rules;
2111bb970c787b Yevgeny Kliteynik 2024-06-20  695  	int ret;
2111bb970c787b Yevgeny Kliteynik 2024-06-20  696  
2111bb970c787b Yevgeny Kliteynik 2024-06-20  697  	/* If the current matcher size is already at its max size, we can't
2111bb970c787b Yevgeny Kliteynik 2024-06-20  698  	 * do the rehash. Skip it and try adding the rule again - perhaps
2111bb970c787b Yevgeny Kliteynik 2024-06-20  699  	 * there was some change.
2111bb970c787b Yevgeny Kliteynik 2024-06-20  700  	 */
2111bb970c787b Yevgeny Kliteynik 2024-06-20  701  	if (hws_bwc_matcher_size_maxed_out(bwc_matcher))
2111bb970c787b Yevgeny Kliteynik 2024-06-20  702  		return 0;
2111bb970c787b Yevgeny Kliteynik 2024-06-20  703  
2111bb970c787b Yevgeny Kliteynik 2024-06-20  704  	/* It is possible that other rule has already performed rehash.
2111bb970c787b Yevgeny Kliteynik 2024-06-20  705  	 * Need to check again if we really need rehash.
2111bb970c787b Yevgeny Kliteynik 2024-06-20  706  	 * If the reason for rehash was size, but not any more - skip rehash.
2111bb970c787b Yevgeny Kliteynik 2024-06-20  707  	 */
2111bb970c787b Yevgeny Kliteynik 2024-06-20 @708  	num_of_rules = __atomic_load_n(&bwc_matcher->num_of_rules, __ATOMIC_RELAXED);
2111bb970c787b Yevgeny Kliteynik 2024-06-20  709  	if (!hws_bwc_matcher_rehash_size_needed(bwc_matcher, num_of_rules))
2111bb970c787b Yevgeny Kliteynik 2024-06-20  710  		return 0;
2111bb970c787b Yevgeny Kliteynik 2024-06-20  711  
2111bb970c787b Yevgeny Kliteynik 2024-06-20  712  	/* Now we're done all the checking - do the rehash:
2111bb970c787b Yevgeny Kliteynik 2024-06-20  713  	 *  - extend match RTC size
2111bb970c787b Yevgeny Kliteynik 2024-06-20  714  	 *  - create new matcher
2111bb970c787b Yevgeny Kliteynik 2024-06-20  715  	 *  - move all the rules to the new matcher
2111bb970c787b Yevgeny Kliteynik 2024-06-20  716  	 *  - destroy the old matcher
2111bb970c787b Yevgeny Kliteynik 2024-06-20  717  	 */
2111bb970c787b Yevgeny Kliteynik 2024-06-20  718  
2111bb970c787b Yevgeny Kliteynik 2024-06-20  719  	ret = hws_bwc_matcher_extend_size(bwc_matcher);
2111bb970c787b Yevgeny Kliteynik 2024-06-20  720  	if (ret)
2111bb970c787b Yevgeny Kliteynik 2024-06-20  721  		return ret;
2111bb970c787b Yevgeny Kliteynik 2024-06-20  722  
2111bb970c787b Yevgeny Kliteynik 2024-06-20  723  	return hws_bwc_matcher_move(bwc_matcher);
2111bb970c787b Yevgeny Kliteynik 2024-06-20  724  }
2111bb970c787b Yevgeny Kliteynik 2024-06-20  725  

:::::: The code at line 708 was first introduced by commit
:::::: 2111bb970c787b16b002dc726c1d296ce87a00fb net/mlx5: HWS, added backward-compatible API handling

:::::: TO: Yevgeny Kliteynik <kliteyn@nvidia.com>
:::::: CC: Saeed Mahameed <saeedm@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

