Return-Path: <linux-kernel+bounces-432493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15FD9E4C1D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A97C28621A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F7130A7D;
	Thu,  5 Dec 2024 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QY2lPp7H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689E4C96
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733364381; cv=none; b=hQ+v/p4Ik0dwKo3I6GDRLXz5RN7l+/mrXvan2g32x5OeLtjNmAkDGqSCg3TuJjisjft97qXoJAzHi0D0LZtwJApNWagMZDSD5vs/bp5YKwMOcss2fAYElhzdv2lK4BZrHJ2uW4pYncs+x799/XK2T4Epd10Fv8H0sZPzphIQ+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733364381; c=relaxed/simple;
	bh=bBY4+YZT8ykO/aVTUVMWrYWcrY+HmAwOx3LiCluiIkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv2CWQRLVJRIvElU9E3tcfyM/sNSfRYP6k9xj9PsiN9N0sPzbtGa9T+DjWlpwY1zK4EeCeTvsoR+KEA83rzN08kSzZJklBj3c3x6tWteZ+7scv2tLBktOKVe1tidj2tqBqnUvhWP+VO+DZaw5oN6g47/m4xlWtKwpeicbE3L5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QY2lPp7H; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733364380; x=1764900380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bBY4+YZT8ykO/aVTUVMWrYWcrY+HmAwOx3LiCluiIkI=;
  b=QY2lPp7Huj2e3eYqf46YJexckE605E+xKPX/tIvBgf5vql7yhod6qiNf
   XoVj1k12BUOBOhYL/9BAi0DtDCKV1/90okp6Ukj6NanndS6DPIsofc42I
   NpQnHAo978+vLkziaaPmgZ4KCAE57yjavuexkKmLCwjD3+9U+EkzCk1RX
   kfxh+HY0AcjGFMnCRMakqE6IkAsdpOjQD4W32MA4jJsLIL6u2Uwc1mOLT
   7vhGXDEkGSjR9SJvNiWEOsHQvjzjCxFE7+ybbuAe8bJUHZuD0fOGhjfDq
   XfNJNAHFUu8fZ6DKbHTPZMilJLDewl00AAwNAAr/GDhW+3VH36OE+4WUS
   Q==;
X-CSE-ConnectionGUID: 51xiXSTfRleshEuECvW1uQ==
X-CSE-MsgGUID: BNk5aX3KTGSGsQP3FM7f8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37595885"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="37595885"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 18:06:19 -0800
X-CSE-ConnectionGUID: GMx1CLYlQ/6HEfeM3/7vdA==
X-CSE-MsgGUID: B52RsMKzTAOeoBgAyJJMXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="93818258"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2024 18:06:16 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJ1FY-0003fl-0y;
	Thu, 05 Dec 2024 02:05:55 +0000
Date: Thu, 5 Dec 2024 10:05:16 +0800
From: kernel test robot <lkp@intel.com>
To: Guillaume Morin <guillaume@morinfr.org>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	guillaume@morinfr.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH v1] hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <202412050943.6b8BLXfY-lkp@intel.com>
References: <Z1Ce6j5WiBE3kaGf@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1Ce6j5WiBE3kaGf@bender.morinfr.org>

Hi Guillaume,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.13-rc1 next-20241204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guillaume-Morin/hugetlb-support-FOLL_FORCE-FOLL_WRITE/20241205-022843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/Z1Ce6j5WiBE3kaGf%40bender.morinfr.org
patch subject: [PATCH v1] hugetlb: support FOLL_FORCE|FOLL_WRITE
config: i386-buildonly-randconfig-002 (https://download.01.org/0day-ci/archive/20241205/202412050943.6b8BLXfY-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050943.6b8BLXfY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050943.6b8BLXfY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/gup.c:7:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/gup.c:20:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/gup.c:665:41: error: call to undeclared function 'pud_soft_dirty'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     665 |         return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
         |                                                ^
   mm/gup.c:665:41: note: did you mean 'pmd_soft_dirty'?
   include/linux/pgtable.h:1427:19: note: 'pmd_soft_dirty' declared here
    1427 | static inline int pmd_soft_dirty(pmd_t pmd)
         |                   ^
   3 warnings and 1 error generated.


vim +/pud_soft_dirty +665 mm/gup.c

   650	
   651	#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
   652	/* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
   653	static inline bool can_follow_write_pud(pud_t pud, struct page *page,
   654						struct vm_area_struct *vma,
   655						unsigned int flags)
   656	{
   657		/* If the pud is writable, we can write to the page. */
   658		if (pud_write(pud))
   659			return true;
   660	
   661		if (!can_follow_write_common(page, vma, flags))
   662			return false;
   663	
   664		/* ... and a write-fault isn't required for other reasons. */
 > 665		return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
   666	}
   667	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

