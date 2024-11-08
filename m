Return-Path: <linux-kernel+bounces-401549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05D49C1C27
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA9F2859AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633901E3DFF;
	Fri,  8 Nov 2024 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2cThlHc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3E1E32CE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065170; cv=none; b=fn1uIvNvabz27F3lJDc/b2O/fFN/9ulClhydUgXtmzaHDmA8QIYyc0mHPGYwgGLBU9LJIXKs/wbg81pTJsaxBf48U1nlOyP943Im5+5pJ19GnzvpIyBv3JiRkw3+Mdwsx4ewr+vdJuAx7xxuInJUwYLuOLiu/7Un5UCfunZygio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065170; c=relaxed/simple;
	bh=0+ge+/Rcb9ZiQmSIKTsHdoYQ1uzdC64gDpNAib8hkwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAyxLfOGTsDSgx8LzFz/BNEpzTyc0PMNnzqYd89PMR/3lVnOoq+Ro6EpVbFroTfAZANSxCScpbvm4hVhDWH9xnEw1c+qwyvyxT9p/O/FGePvE7/FqVQByuCr9dM2VhDnv5879eoCSkUQsKCOnyhfEmh8YN8DPp5dRSoux/LI9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2cThlHc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731065169; x=1762601169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0+ge+/Rcb9ZiQmSIKTsHdoYQ1uzdC64gDpNAib8hkwQ=;
  b=f2cThlHcoJHB+JzffHfZ6s14AQXdOj4dOhvkE1E/H+xk7BGMsJTudpKU
   6gc1k0j6mtURV1kGoDkd3+7O+ALg+GU94AvR2v9QzKUJeAMpc5J7Q6bSe
   H6PMZamDsEFlfvbAU4LVnrbiWhgmRJsP7BSXQVCXqUDm9Edbej/hxs2Q6
   VNiEnScXn1wNs+aX4zHRMKonMcbKxbuva6lJGPzfMUXyTDadZFQ9EbmLO
   5uG1PqxBAF7nDCG4jRR4cvXpSjsoYFwOJzKMNiO7/2ua5QXsTcHiUgfN0
   2C76SYLTSAom2u11n1TRpdHNkdL8NCiw8SmhpSti8QB24Set4D1h94dJj
   w==;
X-CSE-ConnectionGUID: zhslKwrKTsGQHsmJF61wdQ==
X-CSE-MsgGUID: 4H47PeukSgyJtDecfDFXrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30799747"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30799747"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 03:26:08 -0800
X-CSE-ConnectionGUID: BoVfgHG/Sqi/BuIE1Z8Fmw==
X-CSE-MsgGUID: FZWxUu/5SAy/9TGBziW+lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="90652907"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Nov 2024 03:26:00 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9N7m-000rMS-1T;
	Fri, 08 Nov 2024 11:25:58 +0000
Date: Fri, 8 Nov 2024 19:25:07 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	hughd@google.com
Cc: oe-kbuild-all@lists.linux.dev, willy@infradead.org, david@redhat.com,
	wangkefeng.wang@huawei.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
	ioworker0@gmail.com, da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: shmem: add large folio support for tmpfs
Message-ID: <202411081926.LQ3wEK7l-lkp@intel.com>
References: <e2f4e483f75e54be0654fafb2147822faacac16d.1731038280.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f4e483f75e54be0654fafb2147822faacac16d.1731038280.git.baolin.wang@linux.alibaba.com>

Hi Baolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20241108]
[cannot apply to linus/master v6.12-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-factor-out-the-order-calculation-into-a-new-helper/20241108-121545
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/e2f4e483f75e54be0654fafb2147822faacac16d.1731038280.git.baolin.wang%40linux.alibaba.com
patch subject: [PATCH 3/4] mm: shmem: add large folio support for tmpfs
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241108/202411081926.LQ3wEK7l-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081926.LQ3wEK7l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411081926.LQ3wEK7l-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/shmem.c:567: warning: Function parameter or struct member 'write_end' not described in 'shmem_mapping_size_orders'
>> mm/shmem.c:567: warning: Excess function parameter 'size' description in 'shmem_mapping_size_orders'


vim +567 mm/shmem.c

   551	
   552	/**
   553	 * shmem_mapping_size_orders - Get allowable folio orders for the given file size.
   554	 * @mapping: Target address_space.
   555	 * @index: The page index.
   556	 * @size: The suggested size of the folio to create.
   557	 *
   558	 * This returns a high order for folios (when supported) based on the file size
   559	 * which the mapping currently allows at the given index. The index is relevant
   560	 * due to alignment considerations the mapping might have. The returned order
   561	 * may be less than the size passed.
   562	 *
   563	 * Return: The orders.
   564	 */
   565	static inline unsigned int
   566	shmem_mapping_size_orders(struct address_space *mapping, pgoff_t index, loff_t write_end)
 > 567	{
   568		unsigned int order;
   569		size_t size;
   570	
   571		if (!mapping_large_folio_support(mapping) || !write_end)
   572			return 0;
   573	
   574		/* Calculate the write size based on the write_end */
   575		size = write_end - (index << PAGE_SHIFT);
   576		order = filemap_get_order(size);
   577		if (!order)
   578			return 0;
   579	
   580		/* If we're not aligned, allocate a smaller folio */
   581		if (index & ((1UL << order) - 1))
   582			order = __ffs(index);
   583	
   584		order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
   585		return order > 0 ? BIT(order + 1) - 1 : 0;
   586	}
   587	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

