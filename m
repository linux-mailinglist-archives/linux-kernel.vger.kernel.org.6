Return-Path: <linux-kernel+bounces-372971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C799A501D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E131F27D68
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69F18EFD8;
	Sat, 19 Oct 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liNMkBxu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF918D629
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729358994; cv=none; b=S7Q26LiC5FN/UqON26+0juC/enfWoFWlioRrBh+pbLuG6vquXgIQ5R5/jUFVkebXUruRumiekRokXJlTTxBPGFbN86l4bNCzK80QS3kuDrXtutQx0JWOliM2EImiSAtdSWIwx67MyacSWJ6gtYAAhdb3u48V88u5Hn4CZhnw+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729358994; c=relaxed/simple;
	bh=MFhNPISShuBCTSvLSqLqLUm7Mu6JuRwmhaAZNqzQcBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIOIcZIECMW9qtBBTbMuy1FVB55egm+lFyqK+cdUh3cuoM0m16l07h3RcdQfeth9zeHwcpO1uYagQ0YS2T+boge+jTpoYrgVJnH4aX4so7azXAA0/vIuTl9IcxfdMn+l4HcNUjysu3VTBtR1bj9WuRC2gazHRIUGURi7d32wdmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liNMkBxu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729358992; x=1760894992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MFhNPISShuBCTSvLSqLqLUm7Mu6JuRwmhaAZNqzQcBY=;
  b=liNMkBxuUQN5lSfD66NFwNu5fWFrIgnKkd1hKnSzxOH2XrBwkSHDlZVv
   9pgC/Qbw8dm7tVwHGj2UCAZqb2s88A20LxZuF28gyiPQdr/2wpAKeokUt
   lwMYsTCZdzNKUvzZeCQ4yPIFfBW4JYK9jMQZ9yFsUG2lNXh9cWf9oiWNI
   pQZylYffxzT4YN0OmnMBOC21SUMPD2cHD0QBXE7O6UAnwzIZdDq+bXfaJ
   iCOUXteuhqiuRct7V0uBv5PoiknMtJeHNE77R+GXcuADAEmv8ZQSbdbZc
   QlhHLHDL/Vnnf8lTWAX+I6gH3BTFYVJtQZ890IRJyYTx8Q+ctzU0GFbEA
   Q==;
X-CSE-ConnectionGUID: 7SL2BhWKRz+CgonrmjUkfA==
X-CSE-MsgGUID: TUA7kHJKS3C4OSVRrl9bAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="16495177"
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="16495177"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 10:29:51 -0700
X-CSE-ConnectionGUID: bqOwgFENTIm0tJ3lJKJ5Hw==
X-CSE-MsgGUID: VcT2kwryQNe84o/CsNutQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="79290935"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Oct 2024 10:29:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2DGo-000PHe-0H;
	Sat, 19 Oct 2024 17:29:42 +0000
Date: Sun, 20 Oct 2024 01:28:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Chan <ericchancf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Huang <kai.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Russell King <linux@armlinux.org.uk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <202410200112.Ut6HtXKD-lkp@intel.com>
References: <20241017155642.1942514-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017155642.1942514-3-kirill.shutemov@linux.intel.com>

Hi Kirill,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on tip/x86/mm linus/master tip/auto-latest tip/x86/core v6.12-rc3 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-A-Shutemov/memremap-Pass-down-MEMREMAP_-flags-to-arch_memremap_wb/20241018-001138
base:   tip/master
patch link:    https://lore.kernel.org/r/20241017155642.1942514-3-kirill.shutemov%40linux.intel.com
patch subject: [PATCH 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
config: i386-randconfig-061-20241019 (https://download.01.org/0day-ci/archive/20241020/202410200112.Ut6HtXKD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410200112.Ut6HtXKD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410200112.Ut6HtXKD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/mm/ioremap.c:509:37: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/x86/mm/ioremap.c:509:37: sparse:     expected void *
   arch/x86/mm/ioremap.c:509:37: sparse:     got void [noderef] __iomem *
   arch/x86/mm/ioremap.c:511:33: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/x86/mm/ioremap.c:511:33: sparse:     expected void *
   arch/x86/mm/ioremap.c:511:33: sparse:     got void [noderef] __iomem *

vim +509 arch/x86/mm/ioremap.c

   505	
   506	void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
   507	{
   508		if (flags & MEMREMAP_DEC)
 > 509			return ioremap_cache(phys_addr, size);
   510	
   511		return ioremap_encrypted(phys_addr, size);
   512	}
   513	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

