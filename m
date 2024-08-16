Return-Path: <linux-kernel+bounces-290109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A182954F83
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8C11C21715
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD3B1BF307;
	Fri, 16 Aug 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0zjFfn+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572981C230B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827851; cv=none; b=T8Pd5nyGJNCovdPEG26nkVlW8Fu2OK/JhnYxEipRc/XA5PXGDyL+9VfuMWYk3+EylutHb+9ammfNEnlENHJWFvGPTfywMVh7wJ4G3iatbkSYE7+MhbFUaw9pe9wI9fqiyxp+kCcbjQgO4n1o7Y+dPQQeWOJPEJkQo3WMjnV4MZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827851; c=relaxed/simple;
	bh=P20DWhVVbXE78SrQLtmrGxDo+7IQpJR9AulDZ0zkIh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noMENAPSCKwL8m3b0mDKmToWa//OR0t3FgSQPC1U3rXoMXrMCUXRM3n1Rc5x1mo8N3s9q10Dy4HgJCKhYgBfZ36Jsvlnv1TGxdLyEb5QkA7lqndaE1DYyMLOw0zSJKmF/OoFtJoNRolIxO0ZH59euYif2Xrb4vwTRFOvGtfVgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0zjFfn+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723827849; x=1755363849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P20DWhVVbXE78SrQLtmrGxDo+7IQpJR9AulDZ0zkIh0=;
  b=T0zjFfn+e8FOBabPtWOJCXipgj8M8KjXqpuC0Ieg2JHapJ9kAzg3wDZy
   wlEJyZqQHASfzdresOISTIO0lP52mJFXZR4rxnCJ2KEzAsP1XNfIdCMnx
   BMlLY0MhiE+tJBkrM7T+WZXAziBsMHE/XXQI5tecBYSXaJGm4YO69m6by
   DH0x75ocmc7vVUNw37Y7OhqhFSK043L3kg6RQi7zdgL2RL06ud/223IDp
   qastAwPmczvmmsGedBSbIfCg2BSIPDOYvjPMZwxbcqzKFSsFhgMrBMOdY
   SCtP76POxTmPvsmeRcfipp8MqAJcRZUTZpHXYuSGpYjHuZLUDsg+02I8N
   w==;
X-CSE-ConnectionGUID: B+Sn7SUyTm6yu3SxwrFVtw==
X-CSE-MsgGUID: cSuOCfYFRTSlKTnZVqSiqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32766291"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32766291"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 10:04:08 -0700
X-CSE-ConnectionGUID: WCz2KdYTRTKhdlF/01b/uA==
X-CSE-MsgGUID: CzLW3HYTSy29BFDerxsfkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="59741002"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Aug 2024 10:04:05 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sf0Mt-0006fG-0j;
	Fri, 16 Aug 2024 17:04:03 +0000
Date: Sat, 17 Aug 2024 01:03:59 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com, kanchana.p.sridhar@intel.com
Subject: Re: [PATCH v2 4/4] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP stats.
Message-ID: <202408170059.sq8QoVWB-lkp@intel.com>
References: <20240816054805.5201-5-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816054805.5201-5-kanchana.p.sridhar@intel.com>

Hi Kanchana,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc3]
[cannot apply to akpm-mm/mm-everything next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchana-P-Sridhar/mm-zswap-zswap_is_folio_same_filled-takes-an-index-in-the-folio/20240816-134948
base:   linus/master
patch link:    https://lore.kernel.org/r/20240816054805.5201-5-kanchana.p.sridhar%40intel.com
patch subject: [PATCH v2 4/4] mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP stats.
config: arm-randconfig-002-20240816 (https://download.01.org/0day-ci/archive/20240817/202408170059.sq8QoVWB-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408170059.sq8QoVWB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408170059.sq8QoVWB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/page_io.c:14:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> mm/page_io.c:178:3: error: call to undeclared function 'count_mthp_stat'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     178 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
         |                 ^
>> mm/page_io.c:178:39: error: use of undeclared identifier 'MTHP_STAT_ZSWPOUT'
     178 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
         |                                                     ^
   1 warning and 2 errors generated.


vim +/count_mthp_stat +178 mm/page_io.c

   174	
   175	static inline void count_mthp_zswpout_vm_event(struct folio *folio)
   176	{
   177		if (IS_ENABLED(CONFIG_THP_SWAP))
 > 178			count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

