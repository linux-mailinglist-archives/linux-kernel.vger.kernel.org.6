Return-Path: <linux-kernel+bounces-201509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD59F8FBF42
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21781C21D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4237F14D2B4;
	Tue,  4 Jun 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZAwvL8n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8814D2B5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541130; cv=none; b=ZAcAp7ghLZm7srEJyx1rtpkBGMI31ql5IxtoPFfLENVN1SV6p2BbgUx0uMIZh1Wzfeg6ufSif5g3c+ZFj9wCCxxGuHlfKxFitO0GvLawFGUeov/oBLt6ai7ltGi3xvqkKWf8rRVjAhkhvVUYPynY/+1v53FLPm0FMYEX6rHKZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541130; c=relaxed/simple;
	bh=mXAGe3YINODB6h+MbBkIPYf536ptCXDV0Tp3NMe+dO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHD3eThsbyDYFXhyayGIBNWWkDrnhFBAQxKz07f8yiKFopCeuF6BvMhjge430Dbdvn7xGrDe/q6R1Tft8XOIMDBFcYJ+2DqNv3B0uImjVnEqcj393g2dsnkiFj89WiwLVFbaDm9SPXl67KzC2CAx+L54tFa0+Yhhz9beu8WYr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZAwvL8n; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717541128; x=1749077128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mXAGe3YINODB6h+MbBkIPYf536ptCXDV0Tp3NMe+dO8=;
  b=hZAwvL8nbl4FjLTP3iqtEQvJq4AsHJWvlx4wHpwZs2bvbdcy3zafDvKX
   I7sEuVOqrrpgkL4g4GRh2Raan1sScHqF+viuTUo2walQKvOPJQmQYyQH3
   qbWit0JLhXKgIRpAcTl47hhlFeCp3RMggXubrF45Z7DLRHr0uD2K/S97K
   +oEbHBFRwW+GnDhFNBFmNXUqZ4szxDcFHpStqKKdUuYrHoOXVIQCzOyrb
   cV+5pZUUgnLKFMpwKPHF+AwkgZ6T8puIeb+OHyeKlKyLVN72CAkXtVdLQ
   X2zkY6mktASSwUOcONpW+QS4lH8mS58szYywOvZhT1fx6ugJnp1+IGDhE
   Q==;
X-CSE-ConnectionGUID: jWdyBp1bToyN5varlVOirQ==
X-CSE-MsgGUID: lZWO96EbRI6y0YTA/cq4sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14253163"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="14253163"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:45:28 -0700
X-CSE-ConnectionGUID: 31zVMKuHSCKIFD6pq35g3A==
X-CSE-MsgGUID: cYrlB2C1T329o8h4VgUFIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="60576089"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 04 Jun 2024 15:45:24 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEcuA-0000dH-12;
	Tue, 04 Jun 2024 22:45:22 +0000
Date: Wed, 5 Jun 2024 06:44:54 +0800
From: kernel test robot <lkp@intel.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	akpm@linux-foundation.org, liam.howlett@oracle.com,
	zhangpeng.00@bytedance.com, willy@infradead.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH 12/18] maple_tree: convert mas_insert() to preallocate
 nodes
Message-ID: <202406050614.NwHTjXFD-lkp@intel.com>
References: <20240604174145.563900-13-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604174145.563900-13-sidhartha.kumar@oracle.com>

Hi Sidhartha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/maple_tree-introduce-store_type-enum/20240605-014633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240604174145.563900-13-sidhartha.kumar%40oracle.com
patch subject: [PATCH 12/18] maple_tree: convert mas_insert() to preallocate nodes
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240605/202406050614.NwHTjXFD-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050614.NwHTjXFD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406050614.NwHTjXFD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/maple_tree.c:4304: warning: Function parameter or struct member 'entry' not described in 'mas_prealloc_calc'
>> lib/maple_tree.c:4449: warning: Function parameter or struct member 'gfp' not described in 'mas_insert'


vim +4449 lib/maple_tree.c

e0c5446b52f6a9 Sidhartha Kumar 2024-06-04  4439  
54a611b605901c Liam R. Howlett 2022-09-06  4440  /**
54a611b605901c Liam R. Howlett 2022-09-06  4441   * mas_insert() - Internal call to insert a value
54a611b605901c Liam R. Howlett 2022-09-06  4442   * @mas: The maple state
54a611b605901c Liam R. Howlett 2022-09-06  4443   * @entry: The entry to store
54a611b605901c Liam R. Howlett 2022-09-06  4444   *
54a611b605901c Liam R. Howlett 2022-09-06  4445   * Return: %NULL or the contents that already exists at the requested index
54a611b605901c Liam R. Howlett 2022-09-06  4446   * otherwise.  The maple state needs to be checked for error conditions.
54a611b605901c Liam R. Howlett 2022-09-06  4447   */
9d36d13535c7c8 Sidhartha Kumar 2024-06-04  4448  static inline void *mas_insert(struct ma_state *mas, void *entry, gfp_t gfp)
54a611b605901c Liam R. Howlett 2022-09-06 @4449  {
54a611b605901c Liam R. Howlett 2022-09-06  4450  	MA_WR_STATE(wr_mas, mas, entry);
54a611b605901c Liam R. Howlett 2022-09-06  4451  
54a611b605901c Liam R. Howlett 2022-09-06  4452  	/*
54a611b605901c Liam R. Howlett 2022-09-06  4453  	 * Inserting a new range inserts either 0, 1, or 2 pivots within the
54a611b605901c Liam R. Howlett 2022-09-06  4454  	 * tree.  If the insert fits exactly into an existing gap with a value
54a611b605901c Liam R. Howlett 2022-09-06  4455  	 * of NULL, then the slot only needs to be written with the new value.
54a611b605901c Liam R. Howlett 2022-09-06  4456  	 * If the range being inserted is adjacent to another range, then only a
54a611b605901c Liam R. Howlett 2022-09-06  4457  	 * single pivot needs to be inserted (as well as writing the entry).  If
54a611b605901c Liam R. Howlett 2022-09-06  4458  	 * the new range is within a gap but does not touch any other ranges,
54a611b605901c Liam R. Howlett 2022-09-06  4459  	 * then two pivots need to be inserted: the start - 1, and the end.  As
54a611b605901c Liam R. Howlett 2022-09-06  4460  	 * usual, the entry must be written.  Most operations require a new node
54a611b605901c Liam R. Howlett 2022-09-06  4461  	 * to be allocated and replace an existing node to ensure RCU safety,
54a611b605901c Liam R. Howlett 2022-09-06  4462  	 * when in RCU mode.  The exception to requiring a newly allocated node
54a611b605901c Liam R. Howlett 2022-09-06  4463  	 * is when inserting at the end of a node (appending).  When done
54a611b605901c Liam R. Howlett 2022-09-06  4464  	 * carefully, appending can reuse the node in place.
54a611b605901c Liam R. Howlett 2022-09-06  4465  	 */
54a611b605901c Liam R. Howlett 2022-09-06  4466  	wr_mas.content = mas_start(mas);
54a611b605901c Liam R. Howlett 2022-09-06  4467  	if (wr_mas.content)
54a611b605901c Liam R. Howlett 2022-09-06  4468  		goto exists;
54a611b605901c Liam R. Howlett 2022-09-06  4469  
9d36d13535c7c8 Sidhartha Kumar 2024-06-04  4470  	mas_wr_preallocate(&wr_mas, entry, gfp);
9d36d13535c7c8 Sidhartha Kumar 2024-06-04  4471  	if (mas_is_err(mas))
54a611b605901c Liam R. Howlett 2022-09-06  4472  		return NULL;
54a611b605901c Liam R. Howlett 2022-09-06  4473  
54a611b605901c Liam R. Howlett 2022-09-06  4474  	/* spanning writes always overwrite something */
9d36d13535c7c8 Sidhartha Kumar 2024-06-04  4475  	if (mas->store_type == wr_spanning_store)
54a611b605901c Liam R. Howlett 2022-09-06  4476  		goto exists;
54a611b605901c Liam R. Howlett 2022-09-06  4477  
54a611b605901c Liam R. Howlett 2022-09-06  4478  	/* At this point, we are at the leaf node that needs to be altered. */
9d36d13535c7c8 Sidhartha Kumar 2024-06-04  4479  	if (mas->store_type != wr_new_root && mas->store_type != wr_store_root) {
54a611b605901c Liam R. Howlett 2022-09-06  4480  		wr_mas.offset_end = mas->offset;
54a611b605901c Liam R. Howlett 2022-09-06  4481  		wr_mas.end_piv = wr_mas.r_max;
54a611b605901c Liam R. Howlett 2022-09-06  4482  
54a611b605901c Liam R. Howlett 2022-09-06  4483  		if (wr_mas.content || (mas->last > wr_mas.r_max))
54a611b605901c Liam R. Howlett 2022-09-06  4484  			goto exists;
9d36d13535c7c8 Sidhartha Kumar 2024-06-04  4485  	}
54a611b605901c Liam R. Howlett 2022-09-06  4486  
9d36d13535c7c8 Sidhartha Kumar 2024-06-04  4487  	mas_wr_store_entry(&wr_mas);
54a611b605901c Liam R. Howlett 2022-09-06  4488  	return wr_mas.content;
54a611b605901c Liam R. Howlett 2022-09-06  4489  
54a611b605901c Liam R. Howlett 2022-09-06  4490  exists:
54a611b605901c Liam R. Howlett 2022-09-06  4491  	mas_set_err(mas, -EEXIST);
54a611b605901c Liam R. Howlett 2022-09-06  4492  	return wr_mas.content;
54a611b605901c Liam R. Howlett 2022-09-06  4493  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

