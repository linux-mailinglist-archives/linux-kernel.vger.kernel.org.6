Return-Path: <linux-kernel+bounces-242707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A782928BF6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5461C220D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625FE148FFB;
	Fri,  5 Jul 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfM3A8Or"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB32B9B9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720194536; cv=none; b=OjTJ/KiUOI0Zc/JcVlsM1Zv4aoVB31kZS0VrmQdj1MvH7vtTCqAikAaE29RJmZmNcyZ8QJZVRJVOPihAUh+08bd+mW55s74nHIwd6WVc9GLp7YW57dsyvS0GGjhRNT7Osj9NxCL3HwkMh9LnWaXwnyFWJ+JZ4pABQEQ+q3HDKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720194536; c=relaxed/simple;
	bh=pPiSmqh4N42c0fqxhIfJbWHM2fvtIXWjI7CELLI5CBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot83NKEQszvLBePAStYnuxKDIijiuCkKkhYgDbtidHfWQkr/qCsk6oeQZB1oVFT5BXGSDLGdD3jjBHNhZ6froUuVWEycRU4Z7MvWignffnKWWxQuirSp397xbfsvbwKACsDotFqk7A3s8QBpmveXqlgydPygUaNbBu/LeugLL3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfM3A8Or; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720194535; x=1751730535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pPiSmqh4N42c0fqxhIfJbWHM2fvtIXWjI7CELLI5CBw=;
  b=lfM3A8OrnEI4vfgASBpOjsJ75nIqMtyYnyEfVjSX5Mj0cHNSMnPSwM3N
   RzxUjZhrVnAMNyUlcVYfhUFzXUqjp0oJoKn3EeUiMR6N4RKgmbh2A3LOV
   rMyt5peYMtqEO4J+HL5rIkSolC6ndEj9nuhfGZ6EhyQilFVlD7bym7Dul
   KY+XD7F4xGE3osvJrPhkO/aUhbHQ91QX+MMNpoSK45LhTHOq5tmWyWMuk
   QLym1lXkjv0jJCqUY+GG59eLlZTvh4GlOg9VL0NHt8FWty2HKQNv8jxTz
   e6mosMy5H26+3j62ASg/Xg0VJyaPd0TZgi/Hcv5OPYBRAIKUd9RZz58/r
   w==;
X-CSE-ConnectionGUID: uaKJcZGUR5Si7vbzD6XVqA==
X-CSE-MsgGUID: jHUMbvv5TsOj++SOxr3Ycg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17632990"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="17632990"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 08:48:54 -0700
X-CSE-ConnectionGUID: En01POq/QkahHad64bUyMA==
X-CSE-MsgGUID: d3sW6ClkTy2ZKtluhE5t6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="51751275"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Jul 2024 08:48:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPlB3-000SXc-06;
	Fri, 05 Jul 2024 15:48:49 +0000
Date: Fri, 5 Jul 2024 23:48:15 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 13/45] mm: Implement pud-version uffd functions
Message-ID: <202407052337.jk13ShDm-lkp@intel.com>
References: <20240704043132.28501-14-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704043132.28501-14-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on sj/damon/next next-20240703]
[cannot apply to powerpc/next powerpc/fixes linus/master v6.10-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/arch-x86-Drop-own-definition-of-pgd-p4d_leaf/20240705-042640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240704043132.28501-14-osalvador%40suse.de
patch subject: [PATCH 13/45] mm: Implement pud-version uffd functions
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240705/202407052337.jk13ShDm-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407052337.jk13ShDm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407052337.jk13ShDm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/pgtable.h:17,
                    from include/linux/mm.h:30,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/openrisc/kernel/asm-offsets.c:28:
   include/asm-generic/pgtable_uffd.h: In function 'pud_mkuffd_wp':
>> include/asm-generic/pgtable_uffd.h:32:16: error: 'pmd' undeclared (first use in this function); did you mean 'pud'?
      32 |         return pmd;
         |                ^~~
         |                pud
   include/asm-generic/pgtable_uffd.h:32:16: note: each undeclared identifier is reported only once for each function it appears in
   include/asm-generic/pgtable_uffd.h: In function 'pud_clear_uffd_wp':
   include/asm-generic/pgtable_uffd.h:47:16: error: 'pmd' undeclared (first use in this function); did you mean 'pud'?
      47 |         return pmd;
         |                ^~~
         |                pud
   make[3]: *** [scripts/Makefile.build:117: arch/openrisc/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +32 include/asm-generic/pgtable_uffd.h

    29	
    30	static __always_inline pud_t pud_mkuffd_wp(pud_t pud)
    31	{
  > 32		return pmd;
    33	}
    34	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

