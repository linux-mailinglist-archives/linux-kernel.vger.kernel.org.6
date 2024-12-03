Return-Path: <linux-kernel+bounces-428594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6042F9E110A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FA4B226FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3038277F11;
	Tue,  3 Dec 2024 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYij3DdI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B7219E4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191480; cv=none; b=aCPi/54wSHnhVpA2yIxbM8XMLb3XVOS9zZdNObWAHWJIs1lkOypZVJWto5//b4tCOwD44SDJ+dppHf1rcbsyipNLTm7kSNni1xUx5SbE+bggvbg6tdqA7QleorU/v+gPz+hTXI4WbleAa7OWx/csvVEGP5DnVQyB10caMalU4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191480; c=relaxed/simple;
	bh=xr/4Fwe3ocV4wZZiAFhod7Jm8urk9+EfI8yGAVuF37g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSfRAAlBKQHZFPm4fuNpXjWXtkC63R6/NB0wAWhhjhs29na+qIRlXthXcmi7SzZOkf4Dbt8QMfmJLTwm4MdHxo5f3q5k9o4DpGeqVGPxr9fDlZqoTUmPBTb6eW8RA/BhP3Ld35fNwQN9t7wHTg/uqSX1U7c5tRt6mxe9IIeygZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYij3DdI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733191478; x=1764727478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xr/4Fwe3ocV4wZZiAFhod7Jm8urk9+EfI8yGAVuF37g=;
  b=WYij3DdIfoLhRG1lcyCjxeWJYOz/9U8foPpjgKewjY1WY73BS8oLnerT
   B4NWe83v9oERLGrIiuDAMp+rR4X3Dvu/4iO6OSiwlxVXzhPbMo/M9AeLf
   MS8udL1hRDxmlUY2RXxM1aL35wi2NuA6pdF9FKEAELPF0FgBCyxzEQUeT
   NkHy/+v0ilVQaG5YoXT2jro6d6v5Dr2NyCruTKWFGvIaONKtai60luX2F
   IhRllDzHPBcuHtaIE8vGxXde4VJbCwdJ7J1NAFxEZWyuiceBNPgOaRjhq
   SNEGv367OZD+jKc8cRy3kPn+4Sq8XGB5GDVEdBJ8301+iAJ21pUgVVCUj
   Q==;
X-CSE-ConnectionGUID: 3frsZddwT92lnpwsQIOOOQ==
X-CSE-MsgGUID: drD8jNomSkyVnDTnQsQWnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="37322922"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="37322922"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:04:36 -0800
X-CSE-ConnectionGUID: aScvZaJLTd+RglbCgCMfZQ==
X-CSE-MsgGUID: hRGf8/VbQPCFJUIqz3AgLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="98057774"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 02 Dec 2024 18:04:33 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIIGw-00039h-1H;
	Tue, 03 Dec 2024 02:04:23 +0000
Date: Tue, 3 Dec 2024 10:03:57 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
Message-ID: <202412030915.jyKBIDck-lkp@intel.com>
References: <20241202184154.19321-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202184154.19321-2-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-memcontrol-avoid-duplicated-memcg-enable-check/20241203-024957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241202184154.19321-2-ryncsn%40gmail.com
patch subject: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
config: arm-randconfig-002-20241203 (https://download.01.org/0day-ci/archive/20241203/202412030915.jyKBIDck-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030915.jyKBIDck-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030915.jyKBIDck-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/memcontrol.c: In function 'mem_cgroup_swapin_uncharge_swap':
>> mm/memcontrol.c:4618:17: error: implicit declaration of function '__mem_cgroup_uncharge_swap'; did you mean 'mem_cgroup_uncharge_swap'? [-Wimplicit-function-declaration]
    4618 |                 __mem_cgroup_uncharge_swap(entry, nr_pages);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 mem_cgroup_uncharge_swap


vim +4618 mm/memcontrol.c

  4587	
  4588	/*
  4589	 * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
  4590	 * @entry: the first swap entry for which the pages are charged
  4591	 * @nr_pages: number of pages which will be uncharged
  4592	 *
  4593	 * Call this function after successfully adding the charged page to swapcache.
  4594	 *
  4595	 * Note: This function assumes the page for which swap slot is being uncharged
  4596	 * is order 0 page.
  4597	 */
  4598	void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
  4599	{
  4600		/*
  4601		 * Cgroup1's unified memory+swap counter has been charged with the
  4602		 * new swapcache page, finish the transfer by uncharging the swap
  4603		 * slot. The swap slot would also get uncharged when it dies, but
  4604		 * it can stick around indefinitely and we'd count the page twice
  4605		 * the entire time.
  4606		 *
  4607		 * Cgroup2 has separate resource counters for memory and swap,
  4608		 * so this is a non-issue here. Memory and swap charge lifetimes
  4609		 * correspond 1:1 to page and swap slot lifetimes: we charge the
  4610		 * page to memory here, and uncharge swap when the slot is freed.
  4611		 */
  4612		if (!mem_cgroup_disabled() && do_memsw_account()) {
  4613			/*
  4614			 * The swap entry might not get freed for a long time,
  4615			 * let's not wait for it.  The page already received a
  4616			 * memory+swap charge, drop the swap entry duplicate.
  4617			 */
> 4618			__mem_cgroup_uncharge_swap(entry, nr_pages);
  4619		}
  4620	}
  4621	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

