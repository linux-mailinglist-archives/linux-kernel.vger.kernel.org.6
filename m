Return-Path: <linux-kernel+bounces-333141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E097C474
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD352B22400
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A854118E77C;
	Thu, 19 Sep 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAeoCY00"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAC18E763
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728602; cv=none; b=Rz2zBgQRBn0jFb3dMKu/UlK3Oo/R07EnY9Cl82nWgor1KeqdA59VZwSJx5MAOdxIP5oQ6tYxwXe1lQTBm4s0GGdNdN+kbdVrvkeGGLV67oeT2HRbESrEdf171u7H7dwtXbsAFfoOlzHhkmB2U3N7Bg+J700xMJlJHvUwbzU+los=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728602; c=relaxed/simple;
	bh=pqGvSqI8y7nHPfuiivCjh5i8iO5fCHQsxlKUrl7kYes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/vNx0wcrjnOgbro/KmCERSCRc6w2ZBV0QYFg+PShSn84tB45pHQG0xR/qXJ1QCyk8BkvsbDfHMi8VCPu1WQhFQIhqgDvkmNo+UpuMBpYfJNnWSD8wpe3YEwnv0N31oK9IAAuz4sqP5uXPzvMnL7iLfBWoEwerkzo+MIoae5XdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAeoCY00; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726728599; x=1758264599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pqGvSqI8y7nHPfuiivCjh5i8iO5fCHQsxlKUrl7kYes=;
  b=LAeoCY00qZYvHdNl2oAYgL0HKDoZytZDtyyLlnjQOe5mmiRw0qGpQMe8
   EY5twkgIyacx7WusTmvoCwXDxkWOP5oYujlde2j54jThV4QuIhH1IZWoL
   ZnWDqTRn2FLF63jA4erHIoBRuTXQ3FT1GlUMxpoqNFatiuKsjhVZGyWxZ
   tGMLLsXuoFCGX0e6ruoFzypMKhJNq5nmvCvmUJgLlR3yJU/LpAHIMhGED
   ZR4P1FgTiH6Jq6cs442hoh9lIivlWEk27/Q1/7hROcl+EZymDYabV4lON
   pZd7SxLJAmRU+xflHM/f3Qv4+tRLU8P4fEwpUSVawu/r3WHHcl7jHzJGy
   w==;
X-CSE-ConnectionGUID: e7TaFuxnS32iQh5q3RLwDw==
X-CSE-MsgGUID: R9BPglvYRsK3regcFgnj1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="36244851"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="36244851"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 23:49:58 -0700
X-CSE-ConnectionGUID: 2Kww1MV+QwaTXCTwPAbZ+Q==
X-CSE-MsgGUID: PCw4xIUmTZixykvk6/w5dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="93107178"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Sep 2024 23:49:52 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srAz7-000D12-26;
	Thu, 19 Sep 2024 06:49:49 +0000
Date: Thu, 19 Sep 2024 14:49:14 +0800
From: kernel test robot <lkp@intel.com>
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
	david@redhat.com, willy@infradead.org,
	kirill.shutemov@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
	jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
	peterx@redhat.com, ioworker0@gmail.com, jglisse@google.com,
	wangkefeng.wang@huawei.com, ziy@nvidia.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH v4 1/2] mm: Abstract THP allocation
Message-ID: <202409191416.9etlfugV-lkp@intel.com>
References: <20240916094309.1226908-2-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916094309.1226908-2-dev.jain@arm.com>

Hi Dev,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.11 next-20240918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dev-Jain/mm-Abstract-THP-allocation/20240916-174543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240916094309.1226908-2-dev.jain%40arm.com
patch subject: [PATCH v4 1/2] mm: Abstract THP allocation
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240919/202409191416.9etlfugV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240919/202409191416.9etlfugV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409191416.9etlfugV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/huge_memory.c: In function 'vma_alloc_anon_folio_pmd':
>> mm/huge_memory.c:1152:23: warning: unused variable 'haddr' [-Wunused-variable]
    1152 |         unsigned long haddr = addr & HPAGE_PMD_MASK;
         |                       ^~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/haddr +1152 mm/huge_memory.c

  1148	
  1149	static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
  1150						      unsigned long addr)
  1151	{
> 1152		unsigned long haddr = addr & HPAGE_PMD_MASK;
  1153		gfp_t gfp = vma_thp_gfp_mask(vma);
  1154		const int order = HPAGE_PMD_ORDER;
  1155		struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
  1156	
  1157		if (unlikely(!folio)) {
  1158			count_vm_event(THP_FAULT_FALLBACK);
  1159			count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
  1160			goto out;
  1161		}
  1162	
  1163		VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
  1164		if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
  1165			folio_put(folio);
  1166			count_vm_event(THP_FAULT_FALLBACK);
  1167			count_vm_event(THP_FAULT_FALLBACK_CHARGE);
  1168			count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
  1169			count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
  1170			return NULL;
  1171		}
  1172		folio_throttle_swaprate(folio, gfp);
  1173	
  1174		folio_zero_user(folio, addr);
  1175		/*
  1176		 * The memory barrier inside __folio_mark_uptodate makes sure that
  1177		 * folio_zero_user writes become visible before the set_pmd_at()
  1178		 * write.
  1179		 */
  1180		__folio_mark_uptodate(folio);
  1181	out:
  1182		return folio;
  1183	}
  1184	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

