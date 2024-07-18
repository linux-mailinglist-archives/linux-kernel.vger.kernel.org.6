Return-Path: <linux-kernel+bounces-256805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60086937095
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCDA1F22874
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E4145356;
	Thu, 18 Jul 2024 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL8YgOOp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0012CD96
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341381; cv=none; b=EUYxANm7V9dCdAQ0jzODrWMDt8Tvoip58pm7e3yvWU1SNmkvEIU40JROCDucP1x+XuQTkhssL5kr2ldUg0Sftd+OOVK7rCHWRit24tdiIhNSmnotCFmDMqTlFGUD1x7wD/Srp/fUp/hR01Md7uSAle/2fi3agFc4u04SfKrXSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341381; c=relaxed/simple;
	bh=Ig/Q3nC7lv0caDrDuLbp6u7AxC6DLNVhOorHAYQrHz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4+dW2xJ2YUwLaCayDTHK68f0FsrSWfiW+xfUygyToha2bkdNq/0LfxXrKCJq3X6+UfWSUmjHcs2QMtArouC7cVNTihgEL6OAoSpAlQNV/gIYauMlN9Txawt0pNCqt9wrL8vrQ4axL6ww69qRxwwsxGCEkL7CjzMYz6TJ8Y3Ab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL8YgOOp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721341378; x=1752877378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ig/Q3nC7lv0caDrDuLbp6u7AxC6DLNVhOorHAYQrHz4=;
  b=FL8YgOOpQvVy+U/gYpGQ9IoDJq0O8LhfyuLXugHtwWlwxiQ9KH90+AsK
   IirvP3jJZJKgF4gwdHS6QNxgToo8SfoaIrcgtp7dAt2G3+MjlH5gIXORL
   B5PmVSlv2PRtwd1DMo53Hs/XZwduH6dgbwmAKBIahzBANONLYi3Sv79/w
   xt2olDjt+e6NLOv464MIzfvrqzJZoYXvwPKeeZHlaXdqVv8Vsf5Z91DUg
   h6RK7dC90X/2iTd6zxPPUUELw8Osd7T2zYKaiURD7S6G/ttCN3J20zOMQ
   rFq41ySk0TQijfq7aBW4qczYvnOMeyJRAhq7+IMZPTDK2DHRpyyR7cpcJ
   Q==;
X-CSE-ConnectionGUID: 3zEbtHlDRvyg75jlv6udNA==
X-CSE-MsgGUID: 9fLsd1ENSb6WL5eoNZ395Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="30323009"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="30323009"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 15:22:58 -0700
X-CSE-ConnectionGUID: BOLf5UILSbuSa0ewlQSssQ==
X-CSE-MsgGUID: 8c9y4aRRRbq/dYCvgvw1lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="51201732"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2024 15:22:54 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUZWV-000hcs-2l;
	Thu, 18 Jul 2024 22:22:51 +0000
Date: Fri, 19 Jul 2024 06:22:50 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 4/9] arch/sparc: Teach arch_get_unmapped_area{_topdown}
 to handle hugetlb mappings
Message-ID: <202407190616.9AIcabfU-lkp@intel.com>
References: <20240718105903.19617-5-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718105903.19617-5-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build errors:

[auto build test ERROR on s390/features]
[also build test ERROR on akpm-mm/mm-everything powerpc/next powerpc/fixes deller-parisc/for-next arnd-asm-generic/master linus/master v6.10 next-20240718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/mm-mmap-Teach-generic_get_unmapped_area-_topdown-to-handle-hugetlb-mappings/20240718-191208
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20240718105903.19617-5-osalvador%40suse.de
patch subject: [PATCH 4/9] arch/sparc: Teach arch_get_unmapped_area{_topdown} to handle hugetlb mappings
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20240719/202407190616.9AIcabfU-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407190616.9AIcabfU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407190616.9AIcabfU-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/kernel/sys_sparc_64.c: In function 'get_align_mask':
>> arch/sparc/kernel/sys_sparc_64.c:92:21: error: implicit declaration of function 'is_file_hugepages' [-Wimplicit-function-declaration]
      92 |         if (filp && is_file_hugepages(filp))
         |                     ^~~~~~~~~~~~~~~~~
>> arch/sparc/kernel/sys_sparc_64.c:93:24: error: implicit declaration of function 'huge_page_mask_align' [-Wimplicit-function-declaration]
      93 |                 return huge_page_mask_align(filp);
         |                        ^~~~~~~~~~~~~~~~~~~~
   In file included from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from arch/sparc/kernel/sys_sparc_64.c:11:
   arch/sparc/kernel/sys_sparc_64.c: In function 'arch_get_unmapped_area_topdown':
>> include/asm-generic/bug.h:71:27: error: expected ',' or ';' before 'do'
      71 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                           ^~
   arch/sparc/kernel/sys_sparc_64.c:175:9: note: in expansion of macro 'BUG_ON'
     175 |         BUG_ON(!test_thread_flag(TIF_32BIT));
         |         ^~~~~~


vim +/is_file_hugepages +92 arch/sparc/kernel/sys_sparc_64.c

    89	
    90	static unsigned long get_align_mask(struct file *filp, unsigned long flags)
    91	{
  > 92		if (filp && is_file_hugepages(filp))
  > 93			return huge_page_mask_align(filp);
    94		if (filp || (flags & MAP_SHARED))
    95			return PAGE_MASK & (SHMLBA - 1);
    96	
    97		return 0;
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

