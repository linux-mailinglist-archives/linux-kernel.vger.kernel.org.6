Return-Path: <linux-kernel+bounces-287566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D1952968
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BC0285376
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C1617799F;
	Thu, 15 Aug 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJEobKs5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99816BE20
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703584; cv=none; b=WaakhdqTT8wFs74MVMwDt2kioKJeNEAlOHVk/cs+zqPF+f732CvARgNgv+9xeZtbnhJdNHqVe9Ohm2229Zgt+5M3QLrd/UD88rbZhomzDNNmokETkxiTUCTn+R7LJLUbUSh8FkEacwO3wuItnmliY72wcrOyPEFHUF0ZY+53oXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703584; c=relaxed/simple;
	bh=yO1SsaA7ssKmMYudVi/X8+y3TfCMCAKj4YXZ23DRNbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDJJovRjz1dtu0sDttFF8jEzXjARKZ+mqIe4xVSUJcFth4LjK5R35GVHVEFumWDiQcYTgojCN8zKQbs4ncLV9/cn1+LxKgvt2F3NNtDyEFjsZIwXZgSvLRhN3tNz6SVFuld5zIP+yJ++HYV6NzjzBeRQR0rMAdffXeyqjXOukF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJEobKs5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723703582; x=1755239582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yO1SsaA7ssKmMYudVi/X8+y3TfCMCAKj4YXZ23DRNbA=;
  b=PJEobKs5G56mVLMZzhuOx05/KXewKLZXdJpofoYhOh19iGsDGgUHXSbD
   79fxrkSkeuI1peEZZYEkOJEJ5R92PbMyBG9R+9FPjAp4FnUtuC0CHd80E
   90yur0VUgLivXnOVbO4XfvtP8G/arIZssii35kwVtQbQBV8SjpN8OkHZm
   WTr8K9ENTygJ+3LpcpJO0crOUZhtQQXJOJLfKzXZAFYLSuSCDq6O6QQyl
   5KnUYC7+tglqQO/myxTNaC7r/RMZmr+xfXd/8Z+ZkVK0eJrA8wwerrvGa
   h9GlqBHHV3N4B969rjkvgpqL+LmF1SohSvRpDRJ8oAiup5xz2q2pb2kVb
   Q==;
X-CSE-ConnectionGUID: sZKpkCCvTZK4oTMfg2KemQ==
X-CSE-MsgGUID: Hfhd5QFuQu6UigWeRuesrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22091653"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22091653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:33:01 -0700
X-CSE-ConnectionGUID: ZZ3YxEliRuyEHINGzY2dsw==
X-CSE-MsgGUID: OLMW0IQaSXOO0wea07UIQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="90051116"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Aug 2024 23:32:59 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seU2b-0003Gv-07;
	Thu, 15 Aug 2024 06:32:57 +0000
Date: Thu, 15 Aug 2024 14:32:18 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH] maple_tree: clean up kernel doc
Message-ID: <202408151439.qPdTNqUy-lkp@intel.com>
References: <20240814022509.3806-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814022509.3806-1-richard.weiyang@gmail.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on linus/master v6.11-rc3 next-20240815]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Yang/maple_tree-clean-up-kernel-doc/20240814-222531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240814022509.3806-1-richard.weiyang%40gmail.com
patch subject: [PATCH] maple_tree: clean up kernel doc
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240815/202408151439.qPdTNqUy-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151439.qPdTNqUy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151439.qPdTNqUy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/maple_tree.c:1854: warning: Function parameter or struct member 'min' not described in 'mab_calc_split'
>> lib/maple_tree.c:1991: warning: Function parameter or struct member 'new_max' not described in 'mab_mas_cp'
>> lib/maple_tree.c:2369: warning: Function parameter or struct member 'min' not described in 'mas_mab_to_node'
>> lib/maple_tree.c:2479: warning: Function parameter or struct member 'middle' not described in 'mast_set_split_parents'
>> lib/maple_tree.c:2479: warning: Function parameter or struct member 'mid_split' not described in 'mast_set_split_parents'
>> lib/maple_tree.c:2511: warning: Function parameter or struct member 'tmp_mas' not described in 'mas_topiary_node'
>> lib/maple_tree.c:3881: warning: Function parameter or struct member 'new_end' not described in 'mas_wr_node_store'
>> lib/maple_tree.c:4734: warning: Function parameter or struct member 'gap_min' not described in 'mas_rev_awalk'
>> lib/maple_tree.c:4734: warning: Function parameter or struct member 'gap_max' not described in 'mas_rev_awalk'


vim +1854 lib/maple_tree.c

54a611b605901c Liam R. Howlett 2022-09-06  1842  
cc3310ebae35d2 Wei Yang        2024-08-14  1843  /**
54a611b605901c Liam R. Howlett 2022-09-06  1844   * mab_calc_split() - Calculate the split location and if there needs to be two
54a611b605901c Liam R. Howlett 2022-09-06  1845   * splits.
cc3310ebae35d2 Wei Yang        2024-08-14  1846   * @mas: The maple state
54a611b605901c Liam R. Howlett 2022-09-06  1847   * @bn: The maple_big_node with the data
54a611b605901c Liam R. Howlett 2022-09-06  1848   * @mid_split: The second split, if required.  0 otherwise.
54a611b605901c Liam R. Howlett 2022-09-06  1849   *
54a611b605901c Liam R. Howlett 2022-09-06  1850   * Return: The first split location.  The middle split is set in @mid_split.
54a611b605901c Liam R. Howlett 2022-09-06  1851   */
54a611b605901c Liam R. Howlett 2022-09-06  1852  static inline int mab_calc_split(struct ma_state *mas,
54a611b605901c Liam R. Howlett 2022-09-06  1853  	 struct maple_big_node *bn, unsigned char *mid_split, unsigned long min)
54a611b605901c Liam R. Howlett 2022-09-06 @1854  {
54a611b605901c Liam R. Howlett 2022-09-06  1855  	unsigned char b_end = bn->b_end;
54a611b605901c Liam R. Howlett 2022-09-06  1856  	int split = b_end / 2; /* Assume equal split. */
54a611b605901c Liam R. Howlett 2022-09-06  1857  	unsigned char slot_min, slot_count = mt_slots[bn->type];
54a611b605901c Liam R. Howlett 2022-09-06  1858  
54a611b605901c Liam R. Howlett 2022-09-06  1859  	/*
54a611b605901c Liam R. Howlett 2022-09-06  1860  	 * To support gap tracking, all NULL entries are kept together and a node cannot
54a611b605901c Liam R. Howlett 2022-09-06  1861  	 * end on a NULL entry, with the exception of the left-most leaf.  The
54a611b605901c Liam R. Howlett 2022-09-06  1862  	 * limitation means that the split of a node must be checked for this condition
54a611b605901c Liam R. Howlett 2022-09-06  1863  	 * and be able to put more data in one direction or the other.
54a611b605901c Liam R. Howlett 2022-09-06  1864  	 */
54a611b605901c Liam R. Howlett 2022-09-06  1865  	if (unlikely((mas->mas_flags & MA_STATE_BULK))) {
54a611b605901c Liam R. Howlett 2022-09-06  1866  		*mid_split = 0;
54a611b605901c Liam R. Howlett 2022-09-06  1867  		split = b_end - mt_min_slots[bn->type];
54a611b605901c Liam R. Howlett 2022-09-06  1868  
54a611b605901c Liam R. Howlett 2022-09-06  1869  		if (!ma_is_leaf(bn->type))
54a611b605901c Liam R. Howlett 2022-09-06  1870  			return split;
54a611b605901c Liam R. Howlett 2022-09-06  1871  
54a611b605901c Liam R. Howlett 2022-09-06  1872  		mas->mas_flags |= MA_STATE_REBALANCE;
54a611b605901c Liam R. Howlett 2022-09-06  1873  		if (!bn->slot[split])
54a611b605901c Liam R. Howlett 2022-09-06  1874  			split--;
54a611b605901c Liam R. Howlett 2022-09-06  1875  		return split;
54a611b605901c Liam R. Howlett 2022-09-06  1876  	}
54a611b605901c Liam R. Howlett 2022-09-06  1877  
54a611b605901c Liam R. Howlett 2022-09-06  1878  	/*
54a611b605901c Liam R. Howlett 2022-09-06  1879  	 * Although extremely rare, it is possible to enter what is known as the 3-way
54a611b605901c Liam R. Howlett 2022-09-06  1880  	 * split scenario.  The 3-way split comes about by means of a store of a range
54a611b605901c Liam R. Howlett 2022-09-06  1881  	 * that overwrites the end and beginning of two full nodes.  The result is a set
54a611b605901c Liam R. Howlett 2022-09-06  1882  	 * of entries that cannot be stored in 2 nodes.  Sometimes, these two nodes can
54a611b605901c Liam R. Howlett 2022-09-06  1883  	 * also be located in different parent nodes which are also full.  This can
54a611b605901c Liam R. Howlett 2022-09-06  1884  	 * carry upwards all the way to the root in the worst case.
54a611b605901c Liam R. Howlett 2022-09-06  1885  	 */
54a611b605901c Liam R. Howlett 2022-09-06  1886  	if (unlikely(mab_middle_node(bn, split, slot_count))) {
54a611b605901c Liam R. Howlett 2022-09-06  1887  		split = b_end / 3;
54a611b605901c Liam R. Howlett 2022-09-06  1888  		*mid_split = split * 2;
54a611b605901c Liam R. Howlett 2022-09-06  1889  	} else {
54a611b605901c Liam R. Howlett 2022-09-06  1890  		slot_min = mt_min_slots[bn->type];
54a611b605901c Liam R. Howlett 2022-09-06  1891  
54a611b605901c Liam R. Howlett 2022-09-06  1892  		*mid_split = 0;
54a611b605901c Liam R. Howlett 2022-09-06  1893  		/*
54a611b605901c Liam R. Howlett 2022-09-06  1894  		 * Avoid having a range less than the slot count unless it
54a611b605901c Liam R. Howlett 2022-09-06  1895  		 * causes one node to be deficient.
54a611b605901c Liam R. Howlett 2022-09-06  1896  		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
54a611b605901c Liam R. Howlett 2022-09-06  1897  		 */
5729e06c819184 Liam R. Howlett 2023-05-18  1898  		while ((split < slot_count - 1) &&
5729e06c819184 Liam R. Howlett 2023-05-18  1899  		       ((bn->pivot[split] - min) < slot_count - 1) &&
5729e06c819184 Liam R. Howlett 2023-05-18  1900  		       (b_end - split > slot_min))
54a611b605901c Liam R. Howlett 2022-09-06  1901  			split++;
54a611b605901c Liam R. Howlett 2022-09-06  1902  	}
54a611b605901c Liam R. Howlett 2022-09-06  1903  
54a611b605901c Liam R. Howlett 2022-09-06  1904  	/* Avoid ending a node on a NULL entry */
54a611b605901c Liam R. Howlett 2022-09-06  1905  	split = mab_no_null_split(bn, split, slot_count);
54a611b605901c Liam R. Howlett 2022-09-06  1906  
e11cb683b2ebc6 Vernon Yang     2022-12-21  1907  	if (unlikely(*mid_split))
54a611b605901c Liam R. Howlett 2022-09-06  1908  		*mid_split = mab_no_null_split(bn, *mid_split, slot_count);
54a611b605901c Liam R. Howlett 2022-09-06  1909  
54a611b605901c Liam R. Howlett 2022-09-06  1910  	return split;
54a611b605901c Liam R. Howlett 2022-09-06  1911  }
54a611b605901c Liam R. Howlett 2022-09-06  1912  
cc3310ebae35d2 Wei Yang        2024-08-14  1913  /**
54a611b605901c Liam R. Howlett 2022-09-06  1914   * mas_mab_cp() - Copy data from a maple state inclusively to a maple_big_node
54a611b605901c Liam R. Howlett 2022-09-06  1915   * and set @b_node->b_end to the next free slot.
54a611b605901c Liam R. Howlett 2022-09-06  1916   * @mas: The maple state
54a611b605901c Liam R. Howlett 2022-09-06  1917   * @mas_start: The starting slot to copy
54a611b605901c Liam R. Howlett 2022-09-06  1918   * @mas_end: The end slot to copy (inclusively)
54a611b605901c Liam R. Howlett 2022-09-06  1919   * @b_node: The maple_big_node to place the data
54a611b605901c Liam R. Howlett 2022-09-06  1920   * @mab_start: The starting location in maple_big_node to store the data.
54a611b605901c Liam R. Howlett 2022-09-06  1921   */
54a611b605901c Liam R. Howlett 2022-09-06  1922  static inline void mas_mab_cp(struct ma_state *mas, unsigned char mas_start,
54a611b605901c Liam R. Howlett 2022-09-06  1923  			unsigned char mas_end, struct maple_big_node *b_node,
54a611b605901c Liam R. Howlett 2022-09-06  1924  			unsigned char mab_start)
54a611b605901c Liam R. Howlett 2022-09-06  1925  {
54a611b605901c Liam R. Howlett 2022-09-06  1926  	enum maple_type mt;
54a611b605901c Liam R. Howlett 2022-09-06  1927  	struct maple_node *node;
54a611b605901c Liam R. Howlett 2022-09-06  1928  	void __rcu **slots;
54a611b605901c Liam R. Howlett 2022-09-06  1929  	unsigned long *pivots, *gaps;
54a611b605901c Liam R. Howlett 2022-09-06  1930  	int i = mas_start, j = mab_start;
54a611b605901c Liam R. Howlett 2022-09-06  1931  	unsigned char piv_end;
54a611b605901c Liam R. Howlett 2022-09-06  1932  
54a611b605901c Liam R. Howlett 2022-09-06  1933  	node = mas_mn(mas);
54a611b605901c Liam R. Howlett 2022-09-06  1934  	mt = mte_node_type(mas->node);
54a611b605901c Liam R. Howlett 2022-09-06  1935  	pivots = ma_pivots(node, mt);
54a611b605901c Liam R. Howlett 2022-09-06  1936  	if (!i) {
54a611b605901c Liam R. Howlett 2022-09-06  1937  		b_node->pivot[j] = pivots[i++];
54a611b605901c Liam R. Howlett 2022-09-06  1938  		if (unlikely(i > mas_end))
54a611b605901c Liam R. Howlett 2022-09-06  1939  			goto complete;
54a611b605901c Liam R. Howlett 2022-09-06  1940  		j++;
54a611b605901c Liam R. Howlett 2022-09-06  1941  	}
54a611b605901c Liam R. Howlett 2022-09-06  1942  
54a611b605901c Liam R. Howlett 2022-09-06  1943  	piv_end = min(mas_end, mt_pivots[mt]);
54a611b605901c Liam R. Howlett 2022-09-06  1944  	for (; i < piv_end; i++, j++) {
54a611b605901c Liam R. Howlett 2022-09-06  1945  		b_node->pivot[j] = pivots[i];
54a611b605901c Liam R. Howlett 2022-09-06  1946  		if (unlikely(!b_node->pivot[j]))
54a611b605901c Liam R. Howlett 2022-09-06  1947  			break;
54a611b605901c Liam R. Howlett 2022-09-06  1948  
54a611b605901c Liam R. Howlett 2022-09-06  1949  		if (unlikely(mas->max == b_node->pivot[j]))
54a611b605901c Liam R. Howlett 2022-09-06  1950  			goto complete;
54a611b605901c Liam R. Howlett 2022-09-06  1951  	}
54a611b605901c Liam R. Howlett 2022-09-06  1952  
54a611b605901c Liam R. Howlett 2022-09-06  1953  	if (likely(i <= mas_end))
54a611b605901c Liam R. Howlett 2022-09-06  1954  		b_node->pivot[j] = mas_safe_pivot(mas, pivots, i, mt);
54a611b605901c Liam R. Howlett 2022-09-06  1955  
54a611b605901c Liam R. Howlett 2022-09-06  1956  complete:
54a611b605901c Liam R. Howlett 2022-09-06  1957  	b_node->b_end = ++j;
54a611b605901c Liam R. Howlett 2022-09-06  1958  	j -= mab_start;
54a611b605901c Liam R. Howlett 2022-09-06  1959  	slots = ma_slots(node, mt);
54a611b605901c Liam R. Howlett 2022-09-06  1960  	memcpy(b_node->slot + mab_start, slots + mas_start, sizeof(void *) * j);
54a611b605901c Liam R. Howlett 2022-09-06  1961  	if (!ma_is_leaf(mt) && mt_is_alloc(mas->tree)) {
54a611b605901c Liam R. Howlett 2022-09-06  1962  		gaps = ma_gaps(node, mt);
54a611b605901c Liam R. Howlett 2022-09-06  1963  		memcpy(b_node->gap + mab_start, gaps + mas_start,
54a611b605901c Liam R. Howlett 2022-09-06  1964  		       sizeof(unsigned long) * j);
54a611b605901c Liam R. Howlett 2022-09-06  1965  	}
54a611b605901c Liam R. Howlett 2022-09-06  1966  }
54a611b605901c Liam R. Howlett 2022-09-06  1967  
cc3310ebae35d2 Wei Yang        2024-08-14  1968  /**
54a611b605901c Liam R. Howlett 2022-09-06  1969   * mas_leaf_set_meta() - Set the metadata of a leaf if possible.
54a611b605901c Liam R. Howlett 2022-09-06  1970   * @node: The maple node
54a611b605901c Liam R. Howlett 2022-09-06  1971   * @mt: The maple type
330018fe69c663 Peng Zhang      2023-11-20  1972   * @end: The node end
54a611b605901c Liam R. Howlett 2022-09-06  1973   */
330018fe69c663 Peng Zhang      2023-11-20  1974  static inline void mas_leaf_set_meta(struct maple_node *node,
54a611b605901c Liam R. Howlett 2022-09-06  1975  		enum maple_type mt, unsigned char end)
54a611b605901c Liam R. Howlett 2022-09-06  1976  {
54a611b605901c Liam R. Howlett 2022-09-06  1977  	if (end < mt_slots[mt] - 1)
54a611b605901c Liam R. Howlett 2022-09-06  1978  		ma_set_meta(node, mt, 0, end);
54a611b605901c Liam R. Howlett 2022-09-06  1979  }
54a611b605901c Liam R. Howlett 2022-09-06  1980  
cc3310ebae35d2 Wei Yang        2024-08-14  1981  /**
54a611b605901c Liam R. Howlett 2022-09-06  1982   * mab_mas_cp() - Copy data from maple_big_node to a maple encoded node.
54a611b605901c Liam R. Howlett 2022-09-06  1983   * @b_node: the maple_big_node that has the data
54a611b605901c Liam R. Howlett 2022-09-06  1984   * @mab_start: the start location in @b_node.
54a611b605901c Liam R. Howlett 2022-09-06  1985   * @mab_end: The end location in @b_node (inclusively)
54a611b605901c Liam R. Howlett 2022-09-06  1986   * @mas: The maple state with the maple encoded node.
54a611b605901c Liam R. Howlett 2022-09-06  1987   */
54a611b605901c Liam R. Howlett 2022-09-06  1988  static inline void mab_mas_cp(struct maple_big_node *b_node,
54a611b605901c Liam R. Howlett 2022-09-06  1989  			      unsigned char mab_start, unsigned char mab_end,
54a611b605901c Liam R. Howlett 2022-09-06  1990  			      struct ma_state *mas, bool new_max)
54a611b605901c Liam R. Howlett 2022-09-06 @1991  {
54a611b605901c Liam R. Howlett 2022-09-06  1992  	int i, j = 0;
54a611b605901c Liam R. Howlett 2022-09-06  1993  	enum maple_type mt = mte_node_type(mas->node);
54a611b605901c Liam R. Howlett 2022-09-06  1994  	struct maple_node *node = mte_to_node(mas->node);
54a611b605901c Liam R. Howlett 2022-09-06  1995  	void __rcu **slots = ma_slots(node, mt);
54a611b605901c Liam R. Howlett 2022-09-06  1996  	unsigned long *pivots = ma_pivots(node, mt);
54a611b605901c Liam R. Howlett 2022-09-06  1997  	unsigned long *gaps = NULL;
54a611b605901c Liam R. Howlett 2022-09-06  1998  	unsigned char end;
54a611b605901c Liam R. Howlett 2022-09-06  1999  
54a611b605901c Liam R. Howlett 2022-09-06  2000  	if (mab_end - mab_start > mt_pivots[mt])
54a611b605901c Liam R. Howlett 2022-09-06  2001  		mab_end--;
54a611b605901c Liam R. Howlett 2022-09-06  2002  
54a611b605901c Liam R. Howlett 2022-09-06  2003  	if (!pivots[mt_pivots[mt] - 1])
54a611b605901c Liam R. Howlett 2022-09-06  2004  		slots[mt_pivots[mt]] = NULL;
54a611b605901c Liam R. Howlett 2022-09-06  2005  
54a611b605901c Liam R. Howlett 2022-09-06  2006  	i = mab_start;
54a611b605901c Liam R. Howlett 2022-09-06  2007  	do {
54a611b605901c Liam R. Howlett 2022-09-06  2008  		pivots[j++] = b_node->pivot[i++];
54a611b605901c Liam R. Howlett 2022-09-06  2009  	} while (i <= mab_end && likely(b_node->pivot[i]));
54a611b605901c Liam R. Howlett 2022-09-06  2010  
54a611b605901c Liam R. Howlett 2022-09-06  2011  	memcpy(slots, b_node->slot + mab_start,
54a611b605901c Liam R. Howlett 2022-09-06  2012  	       sizeof(void *) * (i - mab_start));
54a611b605901c Liam R. Howlett 2022-09-06  2013  
54a611b605901c Liam R. Howlett 2022-09-06  2014  	if (new_max)
54a611b605901c Liam R. Howlett 2022-09-06  2015  		mas->max = b_node->pivot[i - 1];
54a611b605901c Liam R. Howlett 2022-09-06  2016  
54a611b605901c Liam R. Howlett 2022-09-06  2017  	end = j - 1;
54a611b605901c Liam R. Howlett 2022-09-06  2018  	if (likely(!ma_is_leaf(mt) && mt_is_alloc(mas->tree))) {
54a611b605901c Liam R. Howlett 2022-09-06  2019  		unsigned long max_gap = 0;
d695c30a8ca07a Peng Zhang      2023-07-11  2020  		unsigned char offset = 0;
54a611b605901c Liam R. Howlett 2022-09-06  2021  
54a611b605901c Liam R. Howlett 2022-09-06  2022  		gaps = ma_gaps(node, mt);
54a611b605901c Liam R. Howlett 2022-09-06  2023  		do {
54a611b605901c Liam R. Howlett 2022-09-06  2024  			gaps[--j] = b_node->gap[--i];
54a611b605901c Liam R. Howlett 2022-09-06  2025  			if (gaps[j] > max_gap) {
54a611b605901c Liam R. Howlett 2022-09-06  2026  				offset = j;
54a611b605901c Liam R. Howlett 2022-09-06  2027  				max_gap = gaps[j];
54a611b605901c Liam R. Howlett 2022-09-06  2028  			}
54a611b605901c Liam R. Howlett 2022-09-06  2029  		} while (j);
54a611b605901c Liam R. Howlett 2022-09-06  2030  
54a611b605901c Liam R. Howlett 2022-09-06  2031  		ma_set_meta(node, mt, offset, end);
54a611b605901c Liam R. Howlett 2022-09-06  2032  	} else {
330018fe69c663 Peng Zhang      2023-11-20  2033  		mas_leaf_set_meta(node, mt, end);
54a611b605901c Liam R. Howlett 2022-09-06  2034  	}
54a611b605901c Liam R. Howlett 2022-09-06  2035  }
54a611b605901c Liam R. Howlett 2022-09-06  2036  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

