Return-Path: <linux-kernel+bounces-256764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E878936F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC451B20C25
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A278C9D;
	Thu, 18 Jul 2024 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfX9vhSh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FE29A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337597; cv=none; b=p+X5+z+Mfft8oGrj7Kf25XfDKy1GmgZJWs5BI8DzH8XDwrjxOq+fzZiLflqHPFjJafYgjkNwmRdNOhrzDPzJOTRWYmwlnwWhkhMc2jFz1PHUrdkFb51e03oRqiNSKdEzgXgqz0hfNLnPsoUc4cDU8DT63tczCfj5LQ+rUfrlX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337597; c=relaxed/simple;
	bh=OWjeDT1CUoZslbm2hfXTV9kevdi0HjHne75ivJe4fdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsWk46nxY+Q3bTd7H/g8UMgqhcPUia9r4CAj+fmsjtB/wptawKEWFjQNi/Kh6lTad/m59T1sShZ1bHdisUC0PrIsrwQPSH4x4pzLw98B7/Iu5vaxJEAj5TUVZDEW/LNQACQ3OnX8H4LeFHd3NPvTLE97BSfGwaFVnhgX+tpZtKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfX9vhSh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721337596; x=1752873596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OWjeDT1CUoZslbm2hfXTV9kevdi0HjHne75ivJe4fdQ=;
  b=UfX9vhShLhzy+4uQBIPXrFdhozWh1Shl9PhvDj0C1i7zdlox4hqun0FP
   fEFrEuWoNzdPmeHEOtgeI7JiRnrnBvVbi7Dp1WWVYVBpb7nZdw/DwlC2I
   2WNhCVl8NBib/EvvrSDHMeI11dqVHKjnsBexKkwrij+jOjvq2lDtuElt0
   qT+V9L4wAHHrcII+hg/ECRQ6bcApW1zKP7IR0QgP9Eev+mQovMSbOnR6t
   hoM+iO8UHsuyWWSBppeJldeT9ZOX3dsrz/2i3P0rLg363q3j3Al4MR25Z
   +/JW1XIaaEUZtmsdXc+OUbIc0YMnHde1dwTbn9Ia9k0iRz4GjKxTW4mrB
   w==;
X-CSE-ConnectionGUID: PCoPUoYERTOzcYcYOy4arQ==
X-CSE-MsgGUID: Uxq9kGgtRLa3KwNkZrvClQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="44354670"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="44354670"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 14:19:55 -0700
X-CSE-ConnectionGUID: vKOopiF9QjiLE2Nj4/jK6g==
X-CSE-MsgGUID: HbXYYIM/QQi2VISfs8GtEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="88389982"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Jul 2024 14:19:52 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUYXW-000haU-0k;
	Thu, 18 Jul 2024 21:19:50 +0000
Date: Fri, 19 Jul 2024 05:19:40 +0800
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
Message-ID: <202407190525.rqkFKslD-lkp@intel.com>
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
config: sparc-allnoconfig (https://download.01.org/0day-ci/archive/20240719/202407190525.rqkFKslD-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407190525.rqkFKslD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407190525.rqkFKslD-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/kernel/sys_sparc_32.c: In function 'arch_get_unmapped_area':
>> arch/sparc/kernel/sys_sparc_32.c:47:21: error: implicit declaration of function 'is_file_hugepages' [-Wimplicit-function-declaration]
      47 |         if (filp && is_file_hugepages(filp))
         |                     ^~~~~~~~~~~~~~~~~
>> arch/sparc/kernel/sys_sparc_32.c:74:35: error: implicit declaration of function 'huge_page_mask_align' [-Wimplicit-function-declaration]
      74 |                 info.align_mask = huge_page_mask_align(filp);
         |                                   ^~~~~~~~~~~~~~~~~~~~


vim +/is_file_hugepages +47 arch/sparc/kernel/sys_sparc_32.c

    41	
    42	unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
    43	{
    44		struct vm_unmapped_area_info info = {};
    45		bool file_hugepage = false;
    46	
  > 47		if (filp && is_file_hugepages(filp))
    48			file_hugepage = true;
    49	
    50		if (flags & MAP_FIXED) {
    51			/* We do not accept a shared mapping if it would violate
    52			 * cache aliasing constraints.
    53			 */
    54			if (!file_hugepage && (flags & MAP_SHARED) &&
    55			    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
    56				return -EINVAL;
    57			return addr;
    58		}
    59	
    60		/* See asm-sparc/uaccess.h */
    61		if (len > TASK_SIZE - PAGE_SIZE)
    62			return -ENOMEM;
    63		if (!addr)
    64			addr = TASK_UNMAPPED_BASE;
    65	
    66		info.length = len;
    67		info.low_limit = addr;
    68		info.high_limit = TASK_SIZE;
    69		if (!file_hugepage) {
    70			info.align_mask = (flags & MAP_SHARED) ?
    71				(PAGE_MASK & (SHMLBA - 1)) : 0;
    72			info.align_offset = pgoff << PAGE_SHIFT;
    73		} else {
  > 74			info.align_mask = huge_page_mask_align(filp);
    75		}
    76		return vm_unmapped_area(&info);
    77	}
    78	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

