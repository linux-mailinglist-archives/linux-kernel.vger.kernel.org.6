Return-Path: <linux-kernel+bounces-337733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0720B984E18
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0901284620
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC8178362;
	Tue, 24 Sep 2024 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YasrFEI8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1C176AA5;
	Tue, 24 Sep 2024 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218131; cv=none; b=l2zM2mZnYVM5xz6m1QHPqNWM+4fmID4Xjcv/qUtiGbt1I9gcbeKWG0+AdR/YyYH4kNuHZfGisc1LQF/tkKjMdCnCgAc289Vcuj2udBoAXBBxosf3Vm7EXAg7RGtxCHj+ebP9NTeBmDRY0xCS6YJnhjklrG8Umshrrpy9GmrBg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218131; c=relaxed/simple;
	bh=YFLT7lvUmLlcX+KeUeORCwsDU3A3sva3+huIQHw5Sp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV9itl7C4quSXqqs6DaYIMldMRRIC/5QRCsR9fAo9bpjbG2a8BzZIub/Y7FFItT9bTLwjhosk1WXz21G9sENkdz8icv99Vnlq6wMTlyiqndRW360tKW8u218OlJpoYTKNWoJnnD6L9WVbDbo9KPYRHzI4iTGYjywYea9/2GXahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YasrFEI8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727218130; x=1758754130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YFLT7lvUmLlcX+KeUeORCwsDU3A3sva3+huIQHw5Sp0=;
  b=YasrFEI8pm4K3Ge7VTfKJ0T/Tv6i0R3azLGESU7kLoDgGY2dsMwD15nD
   gfW7yCfnEcXA1uw8D5L8X20DGw1znC1F+i9gOsk+JWBifL3MI+fWWdjrO
   oHVkF/EzZnR9G8phgSncgmdGnlUPvB0W442gGdNGE3PWS8sWhblbZdI3F
   a3qVNnsVBQFGU2wWCBvneHg1rruTotG3rGXfkTBoESdXNgfk1VJGBMSdV
   Hc349tKxqmTItpMUdudADg7ealfSWALCnu1sdW9nj/+OzmNclKAxCObls
   DByJwXV77um/M8HFNmL7Zduuex84kfV7lfbVP3MSCMq2t8tK6DtV0/sdq
   g==;
X-CSE-ConnectionGUID: kjc8xQoKRVqyENB2/IJuRg==
X-CSE-MsgGUID: DGXezTjdRkmsGF9OTi5xfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36909569"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36909569"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:48:49 -0700
X-CSE-ConnectionGUID: VewxNWtFTjy2y+neNWv/nQ==
X-CSE-MsgGUID: w14Jr1cfTmGEMvrzgefZ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="102389047"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Sep 2024 15:48:46 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stEKp-000Iun-1x;
	Tue, 24 Sep 2024 22:48:43 +0000
Date: Wed, 25 Sep 2024 06:48:14 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	Yann Sionneau <ysionneau@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>
Subject: Re: [PATCH v5 1/5] Consolidate __memcpy_{to,from}io and __memset_io
 into iomap_copy.c
Message-ID: <202409250603.okc57309-lkp@intel.com>
References: <20240924121432.798655-2-jvetter@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924121432.798655-2-jvetter@kalrayinc.com>

Hi Julian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on soc/for-next akpm-mm/mm-nonmm-unstable arm64/for-next/core linus/master v6.11 next-20240924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Vetter/Consolidate-__memcpy_-to-from-io-and-__memset_io-into-iomap_copy-c/20240924-202154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20240924121432.798655-2-jvetter%40kalrayinc.com
patch subject: [PATCH v5 1/5] Consolidate __memcpy_{to,from}io and __memset_io into iomap_copy.c
config: arm-mxs_defconfig (https://download.01.org/0day-ci/archive/20240925/202409250603.okc57309-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250603.okc57309-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250603.okc57309-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/iomap_copy.c:89:19: error: call to undeclared function 'IS_ALIGNED'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      89 |         while (count && !IS_ALIGNED((unsigned long)from, NATIVE_STORE_SIZE)) {
         |                          ^
   lib/iomap_copy.c:121:19: error: call to undeclared function 'IS_ALIGNED'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     121 |         while (count && !IS_ALIGNED((unsigned long)to, NATIVE_STORE_SIZE)) {
         |                          ^
   lib/iomap_copy.c:161:19: error: call to undeclared function 'IS_ALIGNED'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     161 |         while (count && !IS_ALIGNED((unsigned long)dst, NATIVE_STORE_SIZE)) {
         |                          ^
>> lib/iomap_copy.c:159:12: warning: shift count >= width of type [-Wshift-count-overflow]
     159 |                 qc |= qc << 32;
         |                          ^  ~~
   1 warning and 3 errors generated.


vim +159 lib/iomap_copy.c

    84	
    85	
    86	#ifndef __memcpy_fromio
    87	void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
    88	{
  > 89		while (count && !IS_ALIGNED((unsigned long)from, NATIVE_STORE_SIZE)) {
    90			*(u8 *)to = __raw_readb(from);
    91			from++;
    92			to++;
    93			count--;
    94		}
    95	
    96		while (count >= NATIVE_STORE_SIZE) {
    97	#ifdef CONFIG_64BIT
    98				put_unaligned(__raw_readq(from), (uintptr_t *)to);
    99	#else
   100				put_unaligned(__raw_readl(from), (uintptr_t *)to);
   101	#endif
   102	
   103			from += NATIVE_STORE_SIZE;
   104			to += NATIVE_STORE_SIZE;
   105			count -= NATIVE_STORE_SIZE;
   106		}
   107	
   108		while (count) {
   109			*(u8 *)to = __raw_readb(from);
   110			from++;
   111			to++;
   112			count--;
   113		}
   114	}
   115	EXPORT_SYMBOL(__memcpy_fromio);
   116	#endif
   117	
   118	#ifndef __memcpy_toio
   119	void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
   120	{
   121		while (count && !IS_ALIGNED((unsigned long)to, NATIVE_STORE_SIZE)) {
   122			__raw_writeb(*(u8 *)from, to);
   123			from++;
   124			to++;
   125			count--;
   126		}
   127	
   128		while (count >= NATIVE_STORE_SIZE) {
   129	#ifdef CONFIG_64BIT
   130				__raw_writeq(get_unaligned((uintptr_t *)from), to);
   131	#else
   132				__raw_writel(get_unaligned((uintptr_t *)from), to);
   133	#endif
   134	
   135			from += NATIVE_STORE_SIZE;
   136			to += NATIVE_STORE_SIZE;
   137			count -= NATIVE_STORE_SIZE;
   138		}
   139	
   140		while (count) {
   141			__raw_writeb(*(u8 *)from, to);
   142			from++;
   143			to++;
   144			count--;
   145		}
   146	}
   147	EXPORT_SYMBOL(__memcpy_toio);
   148	#endif
   149	
   150	#ifndef __memset_io
   151	void __memset_io(volatile void __iomem *dst, int c, size_t count)
   152	{
   153		uintptr_t qc = (u8)c;
   154	
   155		qc |= qc << 8;
   156		qc |= qc << 16;
   157	
   158		if (IS_ENABLED(CONFIG_64BIT))
 > 159			qc |= qc << 32;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

