Return-Path: <linux-kernel+bounces-288846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC2E953F69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9BDCB24C86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DD550A80;
	Fri, 16 Aug 2024 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKhehXGI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8A405C9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774303; cv=none; b=JcGDJvCsVSt3mxI7tY7ks0dHYHF8zOPaRjRg66hxbDN3WwCk/GeVK4xRggCHingRL2Saa+tdkT1YU8Rihx56fmLKRdAGezDou6lzUeGE1jM3IqojYi1KZB7LNPPsDkK/7+sLfcrEuPorpymf+OcvNfqAn0eLMNH1ikGRFUg9MCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774303; c=relaxed/simple;
	bh=OOX2cGxCVM34YKQyi56frg88mnAg+Wq/NAETYLvmLkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQzzIm3V70LwLQXmrV5eVcVL81xoO4A2uA7iuXm7IfRdDOnz4BnaGYL5WP4etPQHFsPr6+KzRdc9Dh29iAnKSXSI1VZkS+TOPi6wlVlsOAk5f48zUn7s+lg1qz6AzAYPZyzoi605K82KuxQa7+cOMtOVlBdcTmWzfaK+IUiNf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKhehXGI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723774301; x=1755310301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OOX2cGxCVM34YKQyi56frg88mnAg+Wq/NAETYLvmLkY=;
  b=NKhehXGI7RHr50k2eqWhzhqYv8/pMzQ0EMPHS7Is/Ohni78c0F33lR6/
   qDVcX+9YRBwCmOEyU2I7lf8w1gZ/EkEU5LuCKoJPust82bcsryK+DS30y
   7sfUSKImqfp6hcrJMVV0rCCiJPzKAcsCm9OojgDevsQG08A4VKkZ6CxXz
   dlZTXMrCFF/jgQ2+G9maWnPLXqJ0bKNi4xd4e/w+ocQ5aAb3AuqSh6A+t
   gH2lSgzDXsSHyowjuTC9pRtzq6uPebtBMQhirxdHmbdC6U6kijQHfvCa3
   ZqXFH2rtUi9WSJ51rDAxkYNFYY9Tgu3kfYzaE5ZSKwwk0+8RrYL+rD52k
   w==;
X-CSE-ConnectionGUID: APhUDLPcQhKnSHIOdFIwlQ==
X-CSE-MsgGUID: yYlm5dTTR62Mv4/sMgkgyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="32636682"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="32636682"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:11:40 -0700
X-CSE-ConnectionGUID: WwZsS+P0TomZpW046Balqg==
X-CSE-MsgGUID: axJ7B6N6Skal0/Hc4Tm5rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59821404"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Aug 2024 19:11:36 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1semRB-0005rE-1y;
	Fri, 16 Aug 2024 02:11:33 +0000
Date: Fri, 16 Aug 2024 10:10:59 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Andryuk <jason.andryuk@amd.com>, Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Brian Gerst <brgerst@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, Jason Andryuk <jason.andryuk@amd.com>
Subject: Re: [PATCH v2 5/5] x86/pvh: Add 64bit relocation page tables
Message-ID: <202408160915.PcKFvj8w-lkp@intel.com>
References: <20240814195053.5564-6-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814195053.5564-6-jason.andryuk@amd.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on xen-tip/linux-next tip/master linus/master v6.11-rc3 next-20240815]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Andryuk/xen-sync-elfnote-h-from-xen-tree/20240815-035238
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240814195053.5564-6-jason.andryuk%40amd.com
patch subject: [PATCH v2 5/5] x86/pvh: Add 64bit relocation page tables
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240816/202408160915.PcKFvj8w-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160915.PcKFvj8w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408160915.PcKFvj8w-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/pgtable_64.h:6,
                    from arch/x86/platform/pvh/head.S:19:
>> arch/x86/include/asm/pgtable_64_types.h:49: warning: "SHARED_KERNEL_PMD" redefined
      49 | #define SHARED_KERNEL_PMD       0
         | 
   In file included from arch/x86/include/asm/pgtable_32_types.h:11,
                    from arch/x86/include/asm/pgtable_types.h:275,
                    from arch/x86/include/asm/boot.h:6,
                    from arch/x86/platform/pvh/head.S:18:
   arch/x86/include/asm/pgtable-3level_types.h:30: note: this is the location of the previous definition
      30 | #define SHARED_KERNEL_PMD       (!static_cpu_has(X86_FEATURE_PTI))
         | 
   arch/x86/include/asm/pgtable_64_types.h:75: warning: "PGDIR_SHIFT" redefined
      75 | #define PGDIR_SHIFT             39
         | 
   arch/x86/include/asm/pgtable-3level_types.h:37: note: this is the location of the previous definition
      37 | #define PGDIR_SHIFT     30
         | 
>> arch/x86/include/asm/pgtable_64_types.h:76: warning: "PTRS_PER_PGD" redefined
      76 | #define PTRS_PER_PGD            512
         | 
   arch/x86/include/asm/pgtable-3level_types.h:38: note: this is the location of the previous definition
      38 | #define PTRS_PER_PGD    4
         | 
   arch/x86/include/asm/pgtable_64_types.h:99: warning: "PMD_SIZE" redefined
      99 | #define PMD_SIZE        (_AC(1, UL) << PMD_SHIFT)
         | 
   arch/x86/include/asm/pgtable_32_types.h:12: note: this is the location of the previous definition
      12 | # define PMD_SIZE       (1UL << PMD_SHIFT)
         | 
   arch/x86/include/asm/pgtable_64_types.h:103: warning: "PGDIR_SIZE" redefined
     103 | #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
         | 
   arch/x86/include/asm/pgtable_32_types.h:20: note: this is the location of the previous definition
      20 | #define PGDIR_SIZE      (1UL << PGDIR_SHIFT)
         | 
>> arch/x86/include/asm/pgtable_64_types.h:210: warning: "PGD_KERNEL_START" redefined
     210 | #define PGD_KERNEL_START        ((PAGE_SIZE / 2) / sizeof(pgd_t))
         | 
   arch/x86/include/asm/pgtable-3level_types.h:53: note: this is the location of the previous definition
      53 | #define PGD_KERNEL_START        (CONFIG_PAGE_OFFSET >> PGDIR_SHIFT)
         | 
   arch/x86/include/asm/pgtable_64.h: Assembler messages:
>> arch/x86/include/asm/pgtable_64.h:279: Error: invalid operands (*UND* and *ABS* sections) for `>>'


vim +279 arch/x86/include/asm/pgtable_64.h

09ef8f8e864fcb Jason Andryuk 2024-08-14  278  
09ef8f8e864fcb Jason Andryuk 2024-08-14 @279  L4_PAGE_OFFSET = l4_index(__PAGE_OFFSET_BASE_L4)
09ef8f8e864fcb Jason Andryuk 2024-08-14  280  L4_START_KERNEL = l4_index(__START_KERNEL_map)
09ef8f8e864fcb Jason Andryuk 2024-08-14  281  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

