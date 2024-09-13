Return-Path: <linux-kernel+bounces-327825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27636977BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B6CB24E28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1B91D58B2;
	Fri, 13 Sep 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAudq56I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843501D6DA8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217570; cv=none; b=uVWSlHhtsI300CwCpVygJCEhaeBFFRO87QgBkVgmPdHJ85NPQ5YrP1nGFAFZvWgdxtGzQc19WPLx8EnZ0wTkSSn0PdKVV+vEbWgQJxX8gNhQ4LMWl4EaX/RAtDDxEwML7hojvTIN224gaCBV9nOF8cyKHiI/j9P/2JfAMM5rRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217570; c=relaxed/simple;
	bh=Jyot/u39dSozHDfoZZzljqaPH7FKv6fUrFVFE36uz3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APBvvuKbwTA0Mvq1bOTxse5fzSMP304NxC18t554zsyi5mSty1zLghBydflsrOPDQ/SSq2muoT1LqhY4qYlUEOVRQJ69QVRktLFDpE8dPUnMpp+YgMvn8TlolbUAL7ORnes26VJPV6kjCqc9+WBKhRayBfkXxF3QT5+6hz/ya4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAudq56I; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726217569; x=1757753569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jyot/u39dSozHDfoZZzljqaPH7FKv6fUrFVFE36uz3w=;
  b=QAudq56I1xVq+OayuMwfRfS60/nj1iwGC0J8NbVgfcdpMr/d0U+qXDpV
   ctwuBGT2jYdhMbp09P3ZxXVQgV7qiIixM67cRPgVh4DQkal7603jCGztz
   E22Tb5fly3vXPfdOvSGYCtt9+zOm7qPIBXfzeG4uxWKKzmy4QdHBNUM1/
   2Qg9icXr+EZgcc/JH6rxJiS38iWMLdCzpfOFUuP3+cIqn59M99J5QhFi4
   FXNI09NajRtDmOfI+MW2Qa9LP3w531/XxSNAKNlDL3oDtF7VlNgQCQvpa
   FOyQTDuivb8pd1qGZXJyngPPSaylh9WmDO9fzVYdTsDHVs/eWhDSr82cS
   A==;
X-CSE-ConnectionGUID: WXKk5MiZRTKLcB6SF6FNcg==
X-CSE-MsgGUID: jK0osxlWTomOCu0dANtH5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25263083"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25263083"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:52:47 -0700
X-CSE-ConnectionGUID: sy5rpTygQ32+DLl+U7K2AQ==
X-CSE-MsgGUID: dey+tiFIR1SXIQNLvwWjgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68073182"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Sep 2024 01:52:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp22j-0006G6-2D;
	Fri, 13 Sep 2024 08:52:41 +0000
Date: Fri, 13 Sep 2024 16:51:44 +0800
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
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 9/9] mm: Consolidate common checks in
 hugetlb_get_unmapped_area
Message-ID: <202409131650.lUO7EoXP-lkp@intel.com>
References: <20240910080030.1272373-10-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910080030.1272373-10-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20240912]
[cannot apply to s390/features powerpc/next powerpc/fixes deller-parisc/for-next arnd-asm-generic/master linus/master v6.11-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/mm-mmap-Teach-generic_get_unmapped_area-_topdown-to-handle-hugetlb-mappings/20240910-160312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240910080030.1272373-10-osalvador%40suse.de
patch subject: [PATCH v3 9/9] mm: Consolidate common checks in hugetlb_get_unmapped_area
config: loongarch-randconfig-002-20240913 (https://download.01.org/0day-ci/archive/20240913/202409131650.lUO7EoXP-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131650.lUO7EoXP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131650.lUO7EoXP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/hugetlb.h:792,
                    from include/linux/migrate.h:8,
                    from fs/aio.c:40:
   arch/loongarch/include/asm/hugetlb.h: In function 'prepare_hugepage_range':
>> arch/loongarch/include/asm/hugetlb.h:19:24: warning: unused variable 'h' [-Wunused-variable]
      19 |         struct hstate *h = hstate_file(file);
         |                        ^


vim +/h +19 arch/loongarch/include/asm/hugetlb.h

09cfefb7fa70c3 Huacai Chen 2022-05-31  12  
09cfefb7fa70c3 Huacai Chen 2022-05-31  13  #define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
09cfefb7fa70c3 Huacai Chen 2022-05-31  14  static inline int prepare_hugepage_range(struct file *file,
09cfefb7fa70c3 Huacai Chen 2022-05-31  15  					 unsigned long addr,
09cfefb7fa70c3 Huacai Chen 2022-05-31  16  					 unsigned long len)
09cfefb7fa70c3 Huacai Chen 2022-05-31  17  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  18  	unsigned long task_size = STACK_TOP;
09cfefb7fa70c3 Huacai Chen 2022-05-31 @19  	struct hstate *h = hstate_file(file);
09cfefb7fa70c3 Huacai Chen 2022-05-31  20  
09cfefb7fa70c3 Huacai Chen 2022-05-31  21  	if (len > task_size)
09cfefb7fa70c3 Huacai Chen 2022-05-31  22  		return -ENOMEM;
09cfefb7fa70c3 Huacai Chen 2022-05-31  23  	if (task_size - len < addr)
09cfefb7fa70c3 Huacai Chen 2022-05-31  24  		return -EINVAL;
09cfefb7fa70c3 Huacai Chen 2022-05-31  25  	return 0;
09cfefb7fa70c3 Huacai Chen 2022-05-31  26  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  27  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

