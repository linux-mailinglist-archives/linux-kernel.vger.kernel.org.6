Return-Path: <linux-kernel+bounces-295268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99895992F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0701F24897
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD8120098E;
	Wed, 21 Aug 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLX9V2jl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6320096D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233409; cv=none; b=vDf2jbolsIyY+FK56LYZRyAAoWO3DWS9kfRIQuPXA9uTvQ4RTKCL9ABrXVCpaiLOtozFEvcCE08x6R3q3jkAdxh2HS5IgTtqrsechhHAYQuKj+BQLdzcbusLjx+4wlMq34K1tc7y7yklMgidOihZRwUFuNTVLmWbyJ7MSkG7lqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233409; c=relaxed/simple;
	bh=VtLhwjfdoBt6Izefq6nC7rSkdwaapeADWgGxeh/MnKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpSjVAMCezdl0ijV5ge+SOM6eQ4QY7+iVlYLS14sCa7PJJwvwcYU8LdKgxksrK/4q06dFoC9+Z6+FDlDID5hn6tStpWAapt9CibzsmzwAWRTfScqrZKYD4ph7cU8jrXZW21UKeJ/GiAvQkEg17RtUX2EboyGZW9Ruj7Qxx7mowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLX9V2jl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724233407; x=1755769407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VtLhwjfdoBt6Izefq6nC7rSkdwaapeADWgGxeh/MnKE=;
  b=iLX9V2jl5wrpQZHW465yRNDXLHcarlLvyp5bSUhMqhKj2jFpCRBuQ+EI
   j3u6TLwDUMxNAXd7yK6Tz76XSrSamigmpkdOPczKvRxGNy2TBFw2lFAA/
   3Wh0fFCkWHjJpEKVIte/DSTHy1GLUfg16ZzfDDc5pTXGJyCzH+9fbHdUj
   R30nrmmHhCRbnFHDYdvY43k2S2+28XpYGuFxmVcNmGSydmDp8cz7GRffe
   +ayBZK78dSg9SrDhoBARUQQ23uLb9dn8si0It/qOvUL5JLK5HdGLoXgjH
   3FKX7Qjr/fKq+K3t1rPD3JoeXitUlvpxCj0Aom+Xx+fDVlovHvgiXAeLh
   A==;
X-CSE-ConnectionGUID: iKWuNcNDTdutnNbqgKBcIw==
X-CSE-MsgGUID: 5Ywq/YHMQRaZkkFfExg4nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22195860"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22195860"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 02:43:26 -0700
X-CSE-ConnectionGUID: SCQfpT+4ReKeYb+B1BYMYg==
X-CSE-MsgGUID: kCUYSb9tRkipB9Te8HIPQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65388153"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2024 02:43:23 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sghs9-000BAc-0x;
	Wed, 21 Aug 2024 09:43:21 +0000
Date: Wed, 21 Aug 2024 17:43:13 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	tdavies@darkphysics.net, philipp.g.hortmann@gmail.com,
	garyrookard@fastmail.org, linux-staging@lists.linux.dev,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Replace strcpy with strscpy in
 rtl819x_translate_scan
Message-ID: <202408211709.E9iGxQa8-lkp@intel.com>
References: <20240820184216.45390-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820184216.45390-1-abhishektamboli9@gmail.com>

Hi Abhishek,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Tamboli/staging-rtl8192e-Replace-strcpy-with-strscpy-in-rtl819x_translate_scan/20240821-024358
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240820184216.45390-1-abhishektamboli9%40gmail.com
patch subject: [PATCH] staging: rtl8192e: Replace strcpy with strscpy in rtl819x_translate_scan
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20240821/202408211709.E9iGxQa8-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408211709.E9iGxQa8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408211709.E9iGxQa8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/um/include/asm/cacheflush.h:4:
   In file included from arch/um/include/asm/tlbflush.h:9:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/staging/rtl8192e/rtllib_wx.c:18:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/staging/rtl8192e/rtllib_wx.c:18:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/staging/rtl8192e/rtllib_wx.c:18:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/staging/rtl8192e/rtllib_wx.c:15:
   In file included from include/linux/wireless.h:13:
   In file included from include/uapi/linux/wireless.h:74:
   In file included from include/linux/socket.h:8:
   In file included from include/linux/uio.h:10:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:13:
   In file included from include/linux/string.h:374:
>> include/linux/fortify-string.h:293:3: error: call to '__write_overflow' declared with 'error' attribute: detected write beyond size of object (1st parameter)
     293 |                 __write_overflow();
         |                 ^
   13 warnings and 1 error generated.


vim +293 include/linux/fortify-string.h

a28a6e860c6cf23 Francis Laniel 2021-02-25  274  
03699f271de1f4d Kees Cook      2022-09-02  275  /* Defined after fortified strnlen() to reuse it. */
e6584c3964f2ff7 Kees Cook      2023-09-20  276  extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(sized_strscpy);
e6584c3964f2ff7 Kees Cook      2023-09-20  277  __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
a28a6e860c6cf23 Francis Laniel 2021-02-25  278  {
a28a6e860c6cf23 Francis Laniel 2021-02-25  279  	/* Use string size rather than possible enclosing struct size. */
21a2c74b0a2a784 Kees Cook      2023-04-07  280  	const size_t p_size = __member_size(p);
21a2c74b0a2a784 Kees Cook      2023-04-07  281  	const size_t q_size = __member_size(q);
21a2c74b0a2a784 Kees Cook      2023-04-07  282  	size_t len;
a28a6e860c6cf23 Francis Laniel 2021-02-25  283  
a28a6e860c6cf23 Francis Laniel 2021-02-25  284  	/* If we cannot get size of p and q default to call strscpy. */
311fb40aa0569ab Kees Cook      2022-09-02  285  	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
a28a6e860c6cf23 Francis Laniel 2021-02-25  286  		return __real_strscpy(p, q, size);
a28a6e860c6cf23 Francis Laniel 2021-02-25  287  
a28a6e860c6cf23 Francis Laniel 2021-02-25  288  	/*
a28a6e860c6cf23 Francis Laniel 2021-02-25  289  	 * If size can be known at compile time and is greater than
a28a6e860c6cf23 Francis Laniel 2021-02-25  290  	 * p_size, generate a compile time write overflow error.
a28a6e860c6cf23 Francis Laniel 2021-02-25  291  	 */
fa35198f39571bb Kees Cook      2022-09-19  292  	if (__compiletime_lessthan(p_size, size))
a28a6e860c6cf23 Francis Laniel 2021-02-25 @293  		__write_overflow();
a28a6e860c6cf23 Francis Laniel 2021-02-25  294  
62e1cbfc5d79538 Kees Cook      2022-10-02  295  	/* Short-circuit for compile-time known-safe lengths. */
62e1cbfc5d79538 Kees Cook      2022-10-02  296  	if (__compiletime_lessthan(p_size, SIZE_MAX)) {
62e1cbfc5d79538 Kees Cook      2022-10-02  297  		len = __compiletime_strlen(q);
62e1cbfc5d79538 Kees Cook      2022-10-02  298  
62e1cbfc5d79538 Kees Cook      2022-10-02  299  		if (len < SIZE_MAX && __compiletime_lessthan(len, size)) {
62e1cbfc5d79538 Kees Cook      2022-10-02  300  			__underlying_memcpy(p, q, len + 1);
62e1cbfc5d79538 Kees Cook      2022-10-02  301  			return len;
62e1cbfc5d79538 Kees Cook      2022-10-02  302  		}
62e1cbfc5d79538 Kees Cook      2022-10-02  303  	}
62e1cbfc5d79538 Kees Cook      2022-10-02  304  
a28a6e860c6cf23 Francis Laniel 2021-02-25  305  	/*
a28a6e860c6cf23 Francis Laniel 2021-02-25  306  	 * This call protects from read overflow, because len will default to q
a28a6e860c6cf23 Francis Laniel 2021-02-25  307  	 * length if it smaller than size.
a28a6e860c6cf23 Francis Laniel 2021-02-25  308  	 */
a28a6e860c6cf23 Francis Laniel 2021-02-25  309  	len = strnlen(q, size);
a28a6e860c6cf23 Francis Laniel 2021-02-25  310  	/*
a28a6e860c6cf23 Francis Laniel 2021-02-25  311  	 * If len equals size, we will copy only size bytes which leads to
a28a6e860c6cf23 Francis Laniel 2021-02-25  312  	 * -E2BIG being returned.
a28a6e860c6cf23 Francis Laniel 2021-02-25  313  	 * Otherwise we will copy len + 1 because of the final '\O'.
a28a6e860c6cf23 Francis Laniel 2021-02-25  314  	 */
a28a6e860c6cf23 Francis Laniel 2021-02-25  315  	len = len == size ? size : len + 1;
a28a6e860c6cf23 Francis Laniel 2021-02-25  316  
a28a6e860c6cf23 Francis Laniel 2021-02-25  317  	/*
a28a6e860c6cf23 Francis Laniel 2021-02-25  318  	 * Generate a runtime write overflow error if len is greater than
a28a6e860c6cf23 Francis Laniel 2021-02-25  319  	 * p_size.
a28a6e860c6cf23 Francis Laniel 2021-02-25  320  	 */
3d965b33e40d973 Kees Cook      2023-04-07  321  	if (p_size < len)
3d965b33e40d973 Kees Cook      2023-04-07  322  		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, p_size, len, -E2BIG);
a28a6e860c6cf23 Francis Laniel 2021-02-25  323  
a28a6e860c6cf23 Francis Laniel 2021-02-25  324  	/*
a28a6e860c6cf23 Francis Laniel 2021-02-25  325  	 * We can now safely call vanilla strscpy because we are protected from:
a28a6e860c6cf23 Francis Laniel 2021-02-25  326  	 * 1. Read overflow thanks to call to strnlen().
a28a6e860c6cf23 Francis Laniel 2021-02-25  327  	 * 2. Write overflow thanks to above ifs.
a28a6e860c6cf23 Francis Laniel 2021-02-25  328  	 */
a28a6e860c6cf23 Francis Laniel 2021-02-25  329  	return __real_strscpy(p, q, len);
a28a6e860c6cf23 Francis Laniel 2021-02-25  330  }
a28a6e860c6cf23 Francis Laniel 2021-02-25  331  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

