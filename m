Return-Path: <linux-kernel+bounces-552250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49036A5778E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 02:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDCC1893186
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809B12CDA5;
	Sat,  8 Mar 2025 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beZ/ybo7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F74C9F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741398797; cv=none; b=bMS1iz0TyjDGp+D2PJMqEbvKo0q7RSxxxXsjpYLzExG34cNyuYRJDWv6offJVe0RubglAA6/AuccRfGvrUns6+xDWzNqOTA6uhO9RaC4qMytM/0z1ayoXA48TlWEyrWnOiTgYRM2jtRFZ7yN7uTZMJoojBnbLlrrvw//wN+Oows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741398797; c=relaxed/simple;
	bh=j9kwnFeKpGqZY7TWgppnlC/2G2kF5YU2Ca2Dt7U2oD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lloDqo2aho93kOLFiC1fmeI80mIWWgHjGuU9iYnEtJF8yDPqBxHddtwZiy0mx7Esp8Z1Rnb4G5nogOGugl4AvuRbFuvNkIBYBKEQSwFtnNLBy9EcXR3+NMIuTPP/lgQ7pSppEO/VLE3L8sR4O9WLVkNMOlcJzhrqsN/s7bRhZJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beZ/ybo7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741398795; x=1772934795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9kwnFeKpGqZY7TWgppnlC/2G2kF5YU2Ca2Dt7U2oD8=;
  b=beZ/ybo7cPZX+hgz1YKCflnejOYGkTvHwVFaX9xESTXekPlx1dSerXjs
   l/KHZdipAA5br+OhwPDWd3/tr9MMcXahgXrS9/jtOUYiLQss1SRt9F7Te
   PMmrtieSu3ulEcGat6A4JxvWE/s8V/gLi2oXGYex0O1ZABUR1h5K1m7HW
   RBaQHBmZ3jdTHbaotOz2q/K5ynwaWfdEyV+NrzSXT7u6vD+euSF5WLFKw
   TzM4hlAzXL0+yu8uADFSJ2kbqQo4yS+aYZw5FptZ+IMgRFaz1NF6CRVls
   wlD2ChgrZEzHDqEHt74FLh4LcfznX9w1yX5BSztVui3oN8bJWRk/RYMnF
   g==;
X-CSE-ConnectionGUID: 2wBpjJ/LTTekCzT8f1THQg==
X-CSE-MsgGUID: eKE/L29oT26C6t4bffml7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42376444"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42376444"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 17:53:14 -0800
X-CSE-ConnectionGUID: 0S3wscT1R/amxXwCI+LZ+w==
X-CSE-MsgGUID: TPjLzn4ZQ26Rld6kSI3owg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150430059"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 07 Mar 2025 17:53:12 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqjNF-0001Ku-2s;
	Sat, 08 Mar 2025 01:53:09 +0000
Date: Sat, 8 Mar 2025 09:53:05 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Shi <yang@os.amperecomputing.com>, ryan.roberts@arm.com,
	will@kernel.org, catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
	scott@os.amperecomputing.com, cl@gentwo.org
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 4/6] arm64: mm: support large block mapping when
 rodata=full
Message-ID: <202503080930.7ZetfmFz-lkp@intel.com>
References: <20250304222018.615808-5-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304222018.615808-5-yang@os.amperecomputing.com>

Hi Yang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/arm64-Add-BBM-Level-2-cpu-feature/20250305-062252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20250304222018.615808-5-yang%40os.amperecomputing.com
patch subject: [v3 PATCH 4/6] arm64: mm: support large block mapping when rodata=full
config: arm64-randconfig-002-20250308 (https://download.01.org/0day-ci/archive/20250308/202503080930.7ZetfmFz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250308/202503080930.7ZetfmFz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503080930.7ZetfmFz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm64/mm/mmu.c: In function 'alloc_init_pud':
>> arch/arm64/mm/mmu.c:511:35: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     511 |                 pud_clear_fixmap();
         |                                   ^
   arch/arm64/mm/mmu.c: In function 'alloc_init_p4d':
   arch/arm64/mm/mmu.c:570:35: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     570 |                 p4d_clear_fixmap();
         |                                   ^


vim +/if +511 arch/arm64/mm/mmu.c

d27cfa1fc823d3 Ard Biesheuvel    2017-03-09  428  
2451145c9a60e0 Yang Shi          2025-03-04  429  static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
da141706aea52c Laura Abbott      2015-01-21  430  			  phys_addr_t phys, pgprot_t prot,
90292aca9854a2 Yu Zhao           2019-03-11  431  			  phys_addr_t (*pgtable_alloc)(int),
c0951366d4b7e0 Ard Biesheuvel    2017-03-09  432  			  int flags)
c1cc1552616d0f Catalin Marinas   2012-03-05  433  {
c1cc1552616d0f Catalin Marinas   2012-03-05  434  	unsigned long next;
2451145c9a60e0 Yang Shi          2025-03-04  435  	int ret = 0;
e9f6376858b979 Mike Rapoport     2020-06-04  436  	p4d_t p4d = READ_ONCE(*p4dp);
6ed8a3a094b43a Ard Biesheuvel    2024-02-14  437  	pud_t *pudp;
6fad683b9a5c21 Yang Shi          2025-03-04  438  	bool split = flags & SPLIT_MAPPINGS;
6fad683b9a5c21 Yang Shi          2025-03-04  439  
6fad683b9a5c21 Yang Shi          2025-03-04  440  	if (split) {
6fad683b9a5c21 Yang Shi          2025-03-04  441  		BUG_ON(p4d_none(p4d));
6fad683b9a5c21 Yang Shi          2025-03-04  442  		pudp = pud_offset(p4dp, addr);
6fad683b9a5c21 Yang Shi          2025-03-04  443  		goto split_pgtable;
6fad683b9a5c21 Yang Shi          2025-03-04  444  	}
c1cc1552616d0f Catalin Marinas   2012-03-05  445  
e9f6376858b979 Mike Rapoport     2020-06-04  446  	if (p4d_none(p4d)) {
efe72541355d4d Yicong Yang       2024-11-02  447  		p4dval_t p4dval = P4D_TYPE_TABLE | P4D_TABLE_UXN | P4D_TABLE_AF;
132233a759580f Laura Abbott      2016-02-05  448  		phys_addr_t pud_phys;
87143f404f338d Ard Biesheuvel    2021-03-10  449  
87143f404f338d Ard Biesheuvel    2021-03-10  450  		if (flags & NO_EXEC_MAPPINGS)
87143f404f338d Ard Biesheuvel    2021-03-10  451  			p4dval |= P4D_TABLE_PXN;
132233a759580f Laura Abbott      2016-02-05  452  		BUG_ON(!pgtable_alloc);
90292aca9854a2 Yu Zhao           2019-03-11  453  		pud_phys = pgtable_alloc(PUD_SHIFT);
2451145c9a60e0 Yang Shi          2025-03-04  454  		if (!pud_phys)
2451145c9a60e0 Yang Shi          2025-03-04  455  			return -ENOMEM;
0e9df1c905d829 Ryan Roberts      2024-04-12  456  		pudp = pud_set_fixmap(pud_phys);
0e9df1c905d829 Ryan Roberts      2024-04-12  457  		init_clear_pgtable(pudp);
0e9df1c905d829 Ryan Roberts      2024-04-12  458  		pudp += pud_index(addr);
87143f404f338d Ard Biesheuvel    2021-03-10  459  		__p4d_populate(p4dp, pud_phys, p4dval);
0e9df1c905d829 Ryan Roberts      2024-04-12  460  	} else {
e9f6376858b979 Mike Rapoport     2020-06-04  461  		BUG_ON(p4d_bad(p4d));
e9f6376858b979 Mike Rapoport     2020-06-04  462  		pudp = pud_set_fixmap_offset(p4dp, addr);
0e9df1c905d829 Ryan Roberts      2024-04-12  463  	}
0e9df1c905d829 Ryan Roberts      2024-04-12  464  
6fad683b9a5c21 Yang Shi          2025-03-04  465  split_pgtable:
c1cc1552616d0f Catalin Marinas   2012-03-05  466  	do {
20a004e7b017cc Will Deacon       2018-02-15  467  		pud_t old_pud = READ_ONCE(*pudp);
e98216b52176ba Ard Biesheuvel    2016-10-21  468  
c1cc1552616d0f Catalin Marinas   2012-03-05  469  		next = pud_addr_end(addr, end);
206a2a73a62d37 Steve Capper      2014-05-06  470  
6fad683b9a5c21 Yang Shi          2025-03-04  471  		if (split) {
6fad683b9a5c21 Yang Shi          2025-03-04  472  			ret = split_pud(pudp, old_pud, pgtable_alloc);
6fad683b9a5c21 Yang Shi          2025-03-04  473  			if (ret)
6fad683b9a5c21 Yang Shi          2025-03-04  474  				break;
6fad683b9a5c21 Yang Shi          2025-03-04  475  
6fad683b9a5c21 Yang Shi          2025-03-04  476  			ret = alloc_init_cont_pmd(pudp, addr, next, phys, prot,
6fad683b9a5c21 Yang Shi          2025-03-04  477  						  pgtable_alloc, flags);
6fad683b9a5c21 Yang Shi          2025-03-04  478  			if (ret)
6fad683b9a5c21 Yang Shi          2025-03-04  479  				break;
6fad683b9a5c21 Yang Shi          2025-03-04  480  
6fad683b9a5c21 Yang Shi          2025-03-04  481  			continue;
6fad683b9a5c21 Yang Shi          2025-03-04  482  		}
6fad683b9a5c21 Yang Shi          2025-03-04  483  
206a2a73a62d37 Steve Capper      2014-05-06  484  		/*
206a2a73a62d37 Steve Capper      2014-05-06  485  		 * For 4K granule only, attempt to put down a 1GB block
206a2a73a62d37 Steve Capper      2014-05-06  486  		 */
1310222c276b79 Anshuman Khandual 2022-02-16  487  		if (pud_sect_supported() &&
1310222c276b79 Anshuman Khandual 2022-02-16  488  		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
c0951366d4b7e0 Ard Biesheuvel    2017-03-09  489  		    (flags & NO_BLOCK_MAPPINGS) == 0) {
20a004e7b017cc Will Deacon       2018-02-15  490  			pud_set_huge(pudp, phys, prot);
206a2a73a62d37 Steve Capper      2014-05-06  491  
206a2a73a62d37 Steve Capper      2014-05-06  492  			/*
e98216b52176ba Ard Biesheuvel    2016-10-21  493  			 * After the PUD entry has been populated once, we
e98216b52176ba Ard Biesheuvel    2016-10-21  494  			 * only allow updates to the permission attributes.
206a2a73a62d37 Steve Capper      2014-05-06  495  			 */
e98216b52176ba Ard Biesheuvel    2016-10-21  496  			BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
20a004e7b017cc Will Deacon       2018-02-15  497  						      READ_ONCE(pud_val(*pudp))));
206a2a73a62d37 Steve Capper      2014-05-06  498  		} else {
2451145c9a60e0 Yang Shi          2025-03-04  499  			ret = alloc_init_cont_pmd(pudp, addr, next, phys, prot,
c0951366d4b7e0 Ard Biesheuvel    2017-03-09  500  					    pgtable_alloc, flags);
2451145c9a60e0 Yang Shi          2025-03-04  501  			if (ret)
2451145c9a60e0 Yang Shi          2025-03-04  502  				break;
e98216b52176ba Ard Biesheuvel    2016-10-21  503  
e98216b52176ba Ard Biesheuvel    2016-10-21  504  			BUG_ON(pud_val(old_pud) != 0 &&
20a004e7b017cc Will Deacon       2018-02-15  505  			       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
206a2a73a62d37 Steve Capper      2014-05-06  506  		}
c1cc1552616d0f Catalin Marinas   2012-03-05  507  		phys += next - addr;
20a004e7b017cc Will Deacon       2018-02-15  508  	} while (pudp++, addr = next, addr != end);
f4710445458c0a Mark Rutland      2016-01-25  509  
6fad683b9a5c21 Yang Shi          2025-03-04  510  	if (!split)
f4710445458c0a Mark Rutland      2016-01-25 @511  		pud_clear_fixmap();
2451145c9a60e0 Yang Shi          2025-03-04  512  
2451145c9a60e0 Yang Shi          2025-03-04  513  	return ret;
c1cc1552616d0f Catalin Marinas   2012-03-05  514  }
c1cc1552616d0f Catalin Marinas   2012-03-05  515  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

