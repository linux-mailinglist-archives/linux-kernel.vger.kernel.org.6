Return-Path: <linux-kernel+bounces-569845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A84A6A836
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2624C8A7700
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57F22157F;
	Thu, 20 Mar 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIZ82fuy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADB22259C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480205; cv=none; b=ioF0k+sEdj+zxr3viEqsXeExvTvWgekvjiXkqFmR7/GO5T5a5CMJ88q20pAUPuOHS9WGWES8XSDov9NYkVhEOBLzf0UEhmwRK7rd9fOYB/5AYThcxLbbX3lTVKeNRgmjg/+xWiCyOUSEWDsogX1/83p18uw+riLgLtUZDw/utXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480205; c=relaxed/simple;
	bh=J8LnsHeJmO0fVH7avVIr14dMWf0HIdoxRIKRn5jvHL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvJbCRv+gyiemPtSlvP3HHmwjSqdI0IUjj7rxj6A/3Cr7x1pLVLDwogepmPBQxs4gXIgjqwl4seV8hvvMLw9cTINR4P48kKwLWsv6A9TPHEcxsyfDVlu6pjp3I0x0Lhf3Zbrjl4x7O3G2zQ6M3qCAw2w91YoOkWdffpiSaCyumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIZ82fuy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742480204; x=1774016204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J8LnsHeJmO0fVH7avVIr14dMWf0HIdoxRIKRn5jvHL8=;
  b=WIZ82fuyLFuYw5K1JPBiuBHE23OthkK0Zq6J+6oga77OYU1oDsUhu1OE
   8ZXCqQvP7ros5RI/xMm+ABVzyhGurOClOPwaYG+d4+YIz+sVcthaNSYDx
   ePlxKv4qaEZDqYNKF02Rclv8hBFNls7OM/y0woCmHRKduo11dTZNrnn8U
   9Horq+CyXbS9wrqmgHO9+9fWFVpovTG4jlU0N3MEUFRje9ukr+dg5d2qF
   y4osLnW0xyO3x8Fty6XgBOccW8dhi5Szm1M0cC6rTKlOMbMrVfq8wE9UC
   8f1gVsP5ri320YyQQub3L6PMs9ktpC375ve5vA5Xn1PcQexhQCrBjr6j0
   Q==;
X-CSE-ConnectionGUID: cLmJeSvgSDeFdCm4CtJB4A==
X-CSE-MsgGUID: IMcebxQHQVSBx5DADtEN4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="61104402"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="61104402"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 07:16:43 -0700
X-CSE-ConnectionGUID: IBkT1U8LS3GJrfbOkn8yJw==
X-CSE-MsgGUID: QsazBzbgTKyjCXEAhTHS4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="127942854"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 20 Mar 2025 07:16:37 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvGhF-0000UR-2H;
	Thu, 20 Mar 2025 14:16:33 +0000
Date: Thu, 20 Mar 2025 22:15:24 +0800
From: kernel test robot <lkp@intel.com>
To: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, graf@amazon.com,
	akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, rppt@kernel.org,
	mark.rutland@arm.com, pbonzini@redhat.com,
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org,
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de
Subject: Re: [PATCH v5 01/16] kexec: define functions to map and unmap
 segments
Message-ID: <202503202151.vHOV0UKU-lkp@intel.com>
References: <20250320015551.2157511-2-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320015551.2157511-2-changyuanl@google.com>

Hi Changyuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47]

url:    https://github.com/intel-lab-lkp/linux/commits/Changyuan-Lyu/kexec-define-functions-to-map-and-unmap-segments/20250320-095900
base:   a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
patch link:    https://lore.kernel.org/r/20250320015551.2157511-2-changyuanl%40google.com
patch subject: [PATCH v5 01/16] kexec: define functions to map and unmap segments
config: i386-buildonly-randconfig-002-20250320 (https://download.01.org/0day-ci/archive/20250320/202503202151.vHOV0UKU-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503202151.vHOV0UKU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503202151.vHOV0UKU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/reboot.c:13:
>> include/linux/kexec.h:479:47: warning: declaration of 'struct kimage' will not be visible outside of this function [-Wvisibility]
     479 | static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
         |                                               ^
   1 warning generated.


vim +479 include/linux/kexec.h

   466	
   467	#define kexec_dprintk(fmt, arg...) \
   468	        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
   469	
   470	void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
   471	void kimage_unmap_segment(void *buffer);
   472	#else /* !CONFIG_KEXEC_CORE */
   473	struct pt_regs;
   474	struct task_struct;
   475	static inline void __crash_kexec(struct pt_regs *regs) { }
   476	static inline void crash_kexec(struct pt_regs *regs) { }
   477	static inline int kexec_should_crash(struct task_struct *p) { return 0; }
   478	static inline int kexec_crash_loaded(void) { return 0; }
 > 479	static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
   480	{ return NULL; }
   481	static inline void kimage_unmap_segment(void *buffer) { }
   482	#define kexec_in_progress false
   483	#endif /* CONFIG_KEXEC_CORE */
   484	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

