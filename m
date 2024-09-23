Return-Path: <linux-kernel+bounces-336306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F0897F1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBBF28288B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605F9839F4;
	Mon, 23 Sep 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mV2K/QH1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE28289E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727125788; cv=none; b=nxNDxcfABv1VJfJZ7Ce2S0lnvFrrfM3AvpwiZQtJaDRdgDTgK3hhpQMLbqSU4gWFuXL/NXIX9pDOttzAAMnQsZAwsf5Ze9CogNqfyv9didF8gHL2IgFC/QhIqwZxe173wejDMfuYEvvov3ApxGWs/PqVQUp+tTeo8v7QgdMTG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727125788; c=relaxed/simple;
	bh=XbrbC+djHzCZ8E1AnEyM1KYGDKp2eznBOrLxWP+FKxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO0yIdCuHGDGlUvCtIBqTRDVj8G7oidPgV2e2VunLf32YcQcubygYsTcgR3AaiMh/ZBGQ3V7/8BtaegBQVbre3x5xD+f0QyQJ1/EPAX26KCsEEHsjfPzQNfxvhnNSmGWaqeplaOla7pHxnk3yueoYl7/3KfinOiWpGf5EfuH7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mV2K/QH1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727125787; x=1758661787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XbrbC+djHzCZ8E1AnEyM1KYGDKp2eznBOrLxWP+FKxc=;
  b=mV2K/QH1scM0Tkjcpcew5tyXsV5OcqXnHkIF42YwlaviOXAuSi8bs4X3
   aUNovUR910HoMIBx3mJo2v1lzPJ9bckRY/LcuNsKSANigigxHnZwWSyc4
   XEJ8YodXyLOA3oabqLCNmFBrCl7e5YXSAfN+b2ry4/YioZ/q1VTBLCa6m
   ijhHKgDGwzZ6ZNlC75A4JW4t4raa95RkI7WblRnPf+3ckmOSFHAKB/n4i
   /2KvvQ8REX6ZQdk0JEgTEgns9hViRf1v52A6f+bFq0d4XpBJ/0M33wWVo
   xu4tMsB/AeLkP4UooQzVztAegzXbqZpB+1jWJfloZNxru8ssZH8o6RALd
   A==;
X-CSE-ConnectionGUID: T6T4MKUNSFmjcpLDyCcWVQ==
X-CSE-MsgGUID: CzChNXWUQd2opflX/r02Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26211826"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="26211826"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:09:47 -0700
X-CSE-ConnectionGUID: dS+FwGadSEWiRC1AIb0MEA==
X-CSE-MsgGUID: xcwUQRJ9TsSbfCco+/6yjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="70777792"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2024 14:09:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssqJS-000Hbr-0a;
	Mon, 23 Sep 2024 21:09:42 +0000
Date: Tue, 24 Sep 2024 05:09:22 +0800
From: kernel test robot <lkp@intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	David Hildenbrand <david@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mm: Make SPLIT_PTE_PTLOCKS depend on the existence of
 NR_CPUS
Message-ID: <202409240416.eEfELHN9-lkp@intel.com>
References: <20240923142533.1197982-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923142533.1197982-1-linux@roeck-us.net>

Hi Guenter,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Guenter-Roeck/mm-Make-SPLIT_PTE_PTLOCKS-depend-on-the-existence-of-NR_CPUS/20240923-222628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240923142533.1197982-1-linux%40roeck-us.net
patch subject: [PATCH] mm: Make SPLIT_PTE_PTLOCKS depend on the existence of NR_CPUS
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240924/202409240416.eEfELHN9-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240416.eEfELHN9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240416.eEfELHN9-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/s390/mm/gmap.c: In function '__gmap_segment_gaddr':
>> arch/s390/mm/gmap.c:357:16: error: implicit declaration of function 'pmd_pgtable_page'; did you mean 'pmd_pgtable'? [-Wimplicit-function-declaration]
     357 |         page = pmd_pgtable_page((pmd_t *) entry);
         |                ^~~~~~~~~~~~~~~~
         |                pmd_pgtable
>> arch/s390/mm/gmap.c:357:14: error: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     357 |         page = pmd_pgtable_page((pmd_t *) entry);
         |              ^


vim +357 arch/s390/mm/gmap.c

1e133ab296f3ff Martin Schwidefsky 2016-03-08  343  
1e133ab296f3ff Martin Schwidefsky 2016-03-08  344  /**
1e133ab296f3ff Martin Schwidefsky 2016-03-08  345   * __gmap_segment_gaddr - find virtual address from segment pointer
1e133ab296f3ff Martin Schwidefsky 2016-03-08  346   * @entry: pointer to a segment table entry in the guest address space
1e133ab296f3ff Martin Schwidefsky 2016-03-08  347   *
1e133ab296f3ff Martin Schwidefsky 2016-03-08  348   * Returns the virtual address in the guest address space for the segment
1e133ab296f3ff Martin Schwidefsky 2016-03-08  349   */
1e133ab296f3ff Martin Schwidefsky 2016-03-08  350  static unsigned long __gmap_segment_gaddr(unsigned long *entry)
1e133ab296f3ff Martin Schwidefsky 2016-03-08  351  {
1e133ab296f3ff Martin Schwidefsky 2016-03-08  352  	struct page *page;
7e25de77bc5ea5 Anshuman Khandual  2022-11-25  353  	unsigned long offset;
1e133ab296f3ff Martin Schwidefsky 2016-03-08  354  
1e133ab296f3ff Martin Schwidefsky 2016-03-08  355  	offset = (unsigned long) entry / sizeof(unsigned long);
1e133ab296f3ff Martin Schwidefsky 2016-03-08  356  	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
7e25de77bc5ea5 Anshuman Khandual  2022-11-25 @357  	page = pmd_pgtable_page((pmd_t *) entry);
1e133ab296f3ff Martin Schwidefsky 2016-03-08  358  	return page->index + offset;
1e133ab296f3ff Martin Schwidefsky 2016-03-08  359  }
1e133ab296f3ff Martin Schwidefsky 2016-03-08  360  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

