Return-Path: <linux-kernel+bounces-354503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4063993E62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF7D1C21E82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4C13D2B2;
	Tue,  8 Oct 2024 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3fMCfHo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68C41A80
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365860; cv=none; b=BAy6MtVj7TY9o//vMmfXvY1+tvK6mMEG4RuzdNtpAJEK/bwNfCDZXabIo/fTvPHkupPBZaRE9Xtczc4m//AWwnXgAU0DGMmjyC4LBQ+c2aemDm/5YrURuFqsJq6Pz9Nrq+CpCDALX1yOp4dK3ALMK2+OGgSFsB6/UUgzAOaNS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365860; c=relaxed/simple;
	bh=5bGqT5cG+g0suqPMvIhI/iPquao/pCryXnCeO9M5BUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDuWZQMevWrByufA5wwI+6L5KiutwdR6+7o4XE4soU5iddBMU97FlgRUUDPS2p0o0Rx82m8VNXuGFbBe5zCn49nIRkbg5LAflGyriZ/Xx+HNRY24OXhe7P5kMAcCkX9e9Is5HPcJgE27lZ3OydsS3dFVDuebq6Segt/4zrY3i9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3fMCfHo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728365859; x=1759901859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5bGqT5cG+g0suqPMvIhI/iPquao/pCryXnCeO9M5BUQ=;
  b=M3fMCfHoQiS3/gX12w8UeEVfdZqNQHomJGIrk7k06/TCSK3xYe/1O5Q3
   eYllR1uAb2XRqby+MVW2Ik71maeyXVYFA1G8EaMS8elUVtogAICVsUMav
   9aXllmS8QPku4afQihFMrzQVdltHYe+OnrYSZ8iN0zMlWQo9/SWCPCQkk
   8g+oB+xU1Vg+BW+Q3PCi9cjHGck2RRVKwN7mtG9aCHc9k6LPS4nFHTHeQ
   DVyQ2YyfZ/itoYeebc7goO9nxOCI6DGthodwCyo5CbqbR1NWWMcJPI+TV
   pCvhu7Xb8jewyDDz7V1mDE70Sf7T4e5X1tgJxwqajr4m6wxwSGJUQFxIX
   g==;
X-CSE-ConnectionGUID: wUhiT28+S72GDKFfMlHarw==
X-CSE-MsgGUID: IsYeMrUyT/WcuwwWl+awdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="52943720"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="52943720"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 22:37:38 -0700
X-CSE-ConnectionGUID: q1I5LljeSRWJnBqG7AjxNw==
X-CSE-MsgGUID: 83/VUB4bRMGUhI0pqGi5tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="75955281"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Oct 2024 22:37:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy2ub-0005wS-19;
	Tue, 08 Oct 2024 05:37:33 +0000
Date: Tue, 8 Oct 2024 13:37:25 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v4 9/9] mm: Consolidate common checks in
 hugetlb_get_unmapped_area
Message-ID: <202410081210.uNLbf3Jk-lkp@intel.com>
References: <20241007075037.267650-10-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007075037.267650-10-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on s390/features]
[also build test WARNING on brauner-vfs/vfs.all akpm-mm/mm-everything linus/master v6.12-rc2 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/mm-mmap-Teach-generic_get_unmapped_area-_topdown-to-handle-hugetlb-mappings/20241007-155328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20241007075037.267650-10-osalvador%40suse.de
patch subject: [PATCH v4 9/9] mm: Consolidate common checks in hugetlb_get_unmapped_area
config: mips-cavium_octeon_defconfig (https://download.01.org/0day-ci/archive/20241008/202410081210.uNLbf3Jk-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410081210.uNLbf3Jk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081210.uNLbf3Jk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/hugetlb.h:789,
                    from kernel/fork.c:53:
   arch/mips/include/asm/hugetlb.h: In function 'prepare_hugepage_range':
>> arch/mips/include/asm/hugetlb.h:20:24: warning: unused variable 'h' [-Wunused-variable]
      20 |         struct hstate *h = hstate_file(file);
         |                        ^


vim +/h +20 arch/mips/include/asm/hugetlb.h

50a41ff292fafe David Daney     2009-05-27  13  
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  14  #define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
50a41ff292fafe David Daney     2009-05-27  15  static inline int prepare_hugepage_range(struct file *file,
50a41ff292fafe David Daney     2009-05-27  16  					 unsigned long addr,
50a41ff292fafe David Daney     2009-05-27  17  					 unsigned long len)
50a41ff292fafe David Daney     2009-05-27  18  {
50a41ff292fafe David Daney     2009-05-27  19  	unsigned long task_size = STACK_TOP;
50a41ff292fafe David Daney     2009-05-27 @20  	struct hstate *h = hstate_file(file);
50a41ff292fafe David Daney     2009-05-27  21  
50a41ff292fafe David Daney     2009-05-27  22  	if (len > task_size)
50a41ff292fafe David Daney     2009-05-27  23  		return -ENOMEM;
50a41ff292fafe David Daney     2009-05-27  24  	if (task_size - len < addr)
50a41ff292fafe David Daney     2009-05-27  25  		return -EINVAL;
50a41ff292fafe David Daney     2009-05-27  26  	return 0;
50a41ff292fafe David Daney     2009-05-27  27  }
50a41ff292fafe David Daney     2009-05-27  28  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

