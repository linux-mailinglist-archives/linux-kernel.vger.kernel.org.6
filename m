Return-Path: <linux-kernel+bounces-432442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277D69E4B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7101285654
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61524F513;
	Thu,  5 Dec 2024 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldNIQCyF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F9E56C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359217; cv=none; b=Ep0g7kkaZNwuD3B7gBvJq5sGI1Sj/BqfMMmSRWB1ESKgZOSyQqAx4HuC2iybtd7+ar1BYZKCSXEqnTh6Sa3jGMlUiparpkqrBeQVCQ4BfG1CnniKY/UZnCB51fODUFsSAGEa+y//o9BUOfOKdE+b9qsypFULpOtp9fKS36ak/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359217; c=relaxed/simple;
	bh=mG2/zhGPqNVr78ILSZ3rJnbvaMCbLegracNoJbp/+m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQHFBHapXccw3jRPzImb9e+fDKeC4CkfiYkJeJs7irqpoN88RCofWvpAlvXvIS0A1IK/5f+Ggkf92MhboDBT20yJIFsiLpiNnPWV8R1XPXQXy8zkmPz7ajEmwBYzjriBALVagZsG8mdvtlAy3TqkLgj6L0MQoysAxrpE74ak5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldNIQCyF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733359215; x=1764895215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mG2/zhGPqNVr78ILSZ3rJnbvaMCbLegracNoJbp/+m4=;
  b=ldNIQCyF8VJHvqX2Aqz7vQ0hE+EL9XBkDGcxZvrFvtgXie4JTnhs6D4X
   Np1y5ZELehVr5i83CYvmLSOenSb5zmz2S2Y9k89qBQZ1zs7v69JKkRO9P
   EE2qVPMR/0iQKJvU8I0bbY5LZ/xg+aNt0vMavga97RG/yYaWwTC6uDvb5
   golZtve8tiZzgNtishLAQDQgWvqFymTHGSZ25ATL7KukH+MUdtlijXcAQ
   ngYG3g0pP/BYNNjDkJ9iPHlGOwVpwNTAFDId6StBQcwdcY70wJ8u8vZ72
   lzHsOVNbRJc0RLX9slgyLd/mhwS8dAHuME9G3BvwsfVzJd3DAMFzFQwU3
   Q==;
X-CSE-ConnectionGUID: ls+mu/L7T+ilUKv1rYfOTw==
X-CSE-MsgGUID: IFLRtYzuS/W2sxg5ZmBcDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33566622"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33566622"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 16:40:14 -0800
X-CSE-ConnectionGUID: JgIFkJ+OSA+hVohjdSZxBA==
X-CSE-MsgGUID: Z3Yx0UPpTFWgMyejkxZtxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="99003200"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 04 Dec 2024 16:40:12 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIzub-0003cX-2L;
	Thu, 05 Dec 2024 00:40:09 +0000
Date: Thu, 5 Dec 2024 08:39:25 +0800
From: kernel test robot <lkp@intel.com>
To: Guillaume Morin <guillaume@morinfr.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	guillaume@morinfr.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH v1] hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <202412050840.umPPa7cK-lkp@intel.com>
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
config: i386-buildonly-randconfig-004 (https://download.01.org/0day-ci/archive/20241205/202412050840.umPPa7cK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050840.umPPa7cK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050840.umPPa7cK-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/gup.c: In function 'can_follow_write_pud':
>> mm/gup.c:665:48: error: implicit declaration of function 'pud_soft_dirty'; did you mean 'pmd_soft_dirty'? [-Werror=implicit-function-declaration]
     665 |         return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
         |                                                ^~~~~~~~~~~~~~
         |                                                pmd_soft_dirty
   cc1: some warnings being treated as errors


vim +665 mm/gup.c

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

