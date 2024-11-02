Return-Path: <linux-kernel+bounces-393492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A19BA147
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51711F21AF9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812A71A2C0E;
	Sat,  2 Nov 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHNslWD1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AEF1A0B07
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561986; cv=none; b=PShMWxT7ReWkTEdhPFMBYUbaAWOXW18hSmCCFrne7T0Edlgs85b2lgXd0c9Bba4t76DIPN4qidtE8MsjGtv/0yvfBAOt76D70d1RFyT3EqQaIKbsJev6SKqeQn/dc4fLxdZ1A35xPYwfEBn4pme5tnYlUmeTCgHyrxZ39EXUtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561986; c=relaxed/simple;
	bh=mRaCTm5rSkwc4AB6hWx/xeooe3mrvvh3KxWrRQGYVmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aAlt74osxUjVqZx0cF7A/OnUQZ8BC8e393L74SF6ugSkV6Q7VcFfZJlRJR/jmqwc4BjUppIg+Q858sHDshp7Cj0BN9ZM7C3YkoTWKmzve8c/VIkTMeAV9y28f8Qw/oKvpkOrrl6Ef9HoNWwxIxTcfyNiSl+KQ7uTEAXIc+g3TRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHNslWD1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730561985; x=1762097985;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mRaCTm5rSkwc4AB6hWx/xeooe3mrvvh3KxWrRQGYVmw=;
  b=EHNslWD1G3EnNFcHMj3whoNnB9Dezw2epGs+EGe6IAt0I+4e9BFMMmri
   QmI7wB6MYWHLMLhY00/B6TFmhJu4b4APxS+7T+0HRD5XHU9ulosJcCJzm
   R2ddBJEqRhi59WGPDSxySOJvqRfh2BVXeMVqWaIHD13ZoAVaN1jb1joNs
   rDz64Q8XPVhVsh0VYzG8mY5lWuwXEhERKE7TmtgroPMtORPxP49NZbdP5
   CYzGMUQWjLjgnkX/fErFvmvwZUW2eWOloBN0ZoPSVGlRzIf3nBdBiY7pN
   EsOpggko/h1du2lDJXCznkiydU0uAafd81PZaedvFO/yUbKzGctr9UlI4
   w==;
X-CSE-ConnectionGUID: dxxCEu4uRlKZn7s25nlo5w==
X-CSE-MsgGUID: 9k8KoDB8QViDbm8H0LnZ8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="30188253"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="30188253"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 08:39:44 -0700
X-CSE-ConnectionGUID: tiR5NsnGTGWQ1dOEkXCGDA==
X-CSE-MsgGUID: jasOPJ6ERfSnbNJdfy3oGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="84058113"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Nov 2024 08:39:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7GE0-000j7t-14;
	Sat, 02 Nov 2024 15:39:40 +0000
Date: Sat, 2 Nov 2024 23:39:02 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:timers/vdso 33/41] arch/x86/entry/vdso/vma.c:199:3: warning:
 label followed by a declaration is a C23 extension
Message-ID: <202411022359.fBPFTg2T-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
head:   a812eee0b68645e2916d4a4399280fe5471cac67
commit: e93d2521b27f0439872dfa4e4b92a9be6d73496f [33/41] x86/vdso: Split virtual clock pages into dedicated mapping
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241102/202411022359.fBPFTg2T-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411022359.fBPFTg2T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411022359.fBPFTg2T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/entry/vdso/vma.c:7:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/entry/vdso/vma.c:199:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     199 |                 struct pvclock_vsyscall_time_info *pvti =
         |                 ^
   arch/x86/entry/vdso/vma.c:209:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     209 |                 unsigned long pfn = hv_get_tsc_pfn();
         |                 ^
   6 warnings generated.


vim +199 arch/x86/entry/vdso/vma.c

   192	
   193	static vm_fault_t vvar_vclock_fault(const struct vm_special_mapping *sm,
   194					    struct vm_area_struct *vma, struct vm_fault *vmf)
   195	{
   196		switch (vmf->pgoff) {
   197	#ifdef CONFIG_PARAVIRT_CLOCK
   198		case VDSO_PAGE_PVCLOCK_OFFSET:
 > 199			struct pvclock_vsyscall_time_info *pvti =
   200				pvclock_get_pvti_cpu0_va();
   201			if (pvti && vclock_was_used(VDSO_CLOCKMODE_PVCLOCK))
   202				return vmf_insert_pfn_prot(vma, vmf->address,
   203						__pa(pvti) >> PAGE_SHIFT,
   204						pgprot_decrypted(vma->vm_page_prot));
   205			break;
   206	#endif /* CONFIG_PARAVIRT_CLOCK */
   207	#ifdef CONFIG_HYPERV_TIMER
   208		case VDSO_PAGE_HVCLOCK_OFFSET:
   209			unsigned long pfn = hv_get_tsc_pfn();
   210	
   211			if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
   212				return vmf_insert_pfn(vma, vmf->address, pfn);
   213			break;
   214	#endif /* CONFIG_HYPERV_TIMER */
   215		}
   216	
   217		return VM_FAULT_SIGBUS;
   218	}
   219	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

