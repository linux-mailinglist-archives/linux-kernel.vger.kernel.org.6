Return-Path: <linux-kernel+bounces-322552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E7972AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA011F25128
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27CC17CA17;
	Tue, 10 Sep 2024 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSSeH4UW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB517BB3F;
	Tue, 10 Sep 2024 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953337; cv=none; b=ZhLf2f1YOM7rRBYl+uXe/rgr95WogQiHL34kQL9CRjU1vQ4XX2oVAbhJ4oMBkWllgpinvNyDNaG5UxhX0YAZ/PB9c1CQexl6glGUceIoFST0No4XAJ+aHtnBw4ZqoyxRM3mHGh2go5n65NMcw16h1zsPZ0SV1/K+hoqZ8onCpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953337; c=relaxed/simple;
	bh=oHfOiuXeROeapZx5nV1VqUqUHQVGGiRVnhF4ET0GNEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZLail5Cwe+tnkZB/FyfiH2EerzVoinNJj6f9qNhltm/4M0O0ZlhOvD2d0i98PnuyxiGKJYnV5OVh7hu1DQP/earbbFx83I1h0WZuzS5u2UOER8HWHqjZmI8K/rI0ZMw58gHKLA19N/UcvZ7eoQCDNCuFNMz117w04kN36rdFQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSSeH4UW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725953336; x=1757489336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oHfOiuXeROeapZx5nV1VqUqUHQVGGiRVnhF4ET0GNEs=;
  b=KSSeH4UWLLD5BO5sShuGX4XvGITxobiVsMMkheV2mSwGqdqXmRXTBOHd
   8hF6lwlU60GAPYwYt3NCWBajLdKukJGrMKH/0YYCQZftJjx6aaw1wV/Im
   R8lneb+zn27KVGzeq2zxYVwplIAE9RadCVJrsUp98EHbhtsivi9rBfmTZ
   V3sU8AJHTBNZzzUqFWErcS9vVeQ6hAO8NPuwUcIfhMDxOSXrMwnpYDEdB
   1mKmgjd8+KI/81XdGwgOxZpeLRBr+ocNfqBECh5N6v8RwB9cmMXD4jUDT
   y4VU01eLXFZQj8O29AWRa2CE28k6/PNDZyvmjOn+830R1Gjj6DKN4+GFX
   A==;
X-CSE-ConnectionGUID: 2fFTsUEWTzyypf9UWxDbig==
X-CSE-MsgGUID: JjFczBwyRCSXUbVjLNYL2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35822078"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="35822078"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 00:28:09 -0700
X-CSE-ConnectionGUID: ku3WCRXqRQGfm8cvnjYRrA==
X-CSE-MsgGUID: tvhMKvAkT4+uKOGx3IKQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="71539619"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Sep 2024 00:27:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snvI0-0000E6-0U;
	Tue, 10 Sep 2024 07:27:52 +0000
Date: Tue, 10 Sep 2024 15:27:01 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	Yann Sionneau <ysionneau@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>
Subject: Re: [PATCH v2 3/4] Use generic io memcpy functions on the csky
 architecture
Message-ID: <202409101549.CyV0mJ2S-lkp@intel.com>
References: <20240909133159.2024688-4-jvetter@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909133159.2024688-4-jvetter@kalrayinc.com>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on arm64/for-next/core soc/for-next linus/master v6.11-rc7 next-20240909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Vetter/Consolidate-__memcpy_-to-from-io-and-__memset_io-into-a-single-lib/20240909-213659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240909133159.2024688-4-jvetter%40kalrayinc.com
patch subject: [PATCH v2 3/4] Use generic io memcpy functions on the csky architecture
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20240910/202409101549.CyV0mJ2S-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409101549.CyV0mJ2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101549.CyV0mJ2S-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from ./arch/csky/include/generated/asm/unaligned.h:1,
                    from lib/io_copy.c:9:
   lib/io_copy.c: In function '__memcpy_fromio':
>> lib/io_copy.c:28:39: error: implicit declaration of function '__raw_readq'; did you mean '__raw_readl'? [-Wimplicit-function-declaration]
      28 |                         put_unaligned(__raw_readq(from), (uintptr_t *)to);
         |                                       ^~~~~~~~~~~
   include/asm-generic/unaligned.h:19:22: note: in definition of macro '__put_unaligned_t'
      19 |         __pptr->x = (val);                                                      \
         |                      ^~~
   lib/io_copy.c:28:25: note: in expansion of macro 'put_unaligned'
      28 |                         put_unaligned(__raw_readq(from), (uintptr_t *)to);
         |                         ^~~~~~~~~~~~~
   lib/io_copy.c: In function '__memcpy_toio':
>> lib/io_copy.c:57:25: error: implicit declaration of function '__raw_writeq'; did you mean '__raw_writel'? [-Wimplicit-function-declaration]
      57 |                         __raw_writeq(get_unaligned((uintptr_t *)from), to);
         |                         ^~~~~~~~~~~~
         |                         __raw_writel
   lib/io_copy.c: In function '__memset_io':
>> lib/io_copy.c:83:26: warning: left shift count >= width of type [-Wshift-count-overflow]
      83 |                 qc |= qc << 32;
         |                          ^~


vim +28 lib/io_copy.c

6a9bfa83709a84e Julian Vetter 2024-09-09  16  
6a9bfa83709a84e Julian Vetter 2024-09-09  17  void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
6a9bfa83709a84e Julian Vetter 2024-09-09  18  {
6a9bfa83709a84e Julian Vetter 2024-09-09  19  	while (count && !IS_ALIGNED((unsigned long)from, NATIVE_STORE_SIZE)) {
6a9bfa83709a84e Julian Vetter 2024-09-09  20  		*(u8 *)to = __raw_readb(from);
6a9bfa83709a84e Julian Vetter 2024-09-09  21  		from++;
6a9bfa83709a84e Julian Vetter 2024-09-09  22  		to++;
6a9bfa83709a84e Julian Vetter 2024-09-09  23  		count--;
6a9bfa83709a84e Julian Vetter 2024-09-09  24  	}
6a9bfa83709a84e Julian Vetter 2024-09-09  25  
6a9bfa83709a84e Julian Vetter 2024-09-09  26  	while (count >= NATIVE_STORE_SIZE) {
6a9bfa83709a84e Julian Vetter 2024-09-09  27  		if (IS_ENABLED(CONFIG_64BIT))
6a9bfa83709a84e Julian Vetter 2024-09-09 @28  			put_unaligned(__raw_readq(from), (uintptr_t *)to);
6a9bfa83709a84e Julian Vetter 2024-09-09  29  		else
6a9bfa83709a84e Julian Vetter 2024-09-09  30  			put_unaligned(__raw_readl(from), (uintptr_t *)to);
6a9bfa83709a84e Julian Vetter 2024-09-09  31  
6a9bfa83709a84e Julian Vetter 2024-09-09  32  		from += NATIVE_STORE_SIZE;
6a9bfa83709a84e Julian Vetter 2024-09-09  33  		to += NATIVE_STORE_SIZE;
6a9bfa83709a84e Julian Vetter 2024-09-09  34  		count -= NATIVE_STORE_SIZE;
6a9bfa83709a84e Julian Vetter 2024-09-09  35  	}
6a9bfa83709a84e Julian Vetter 2024-09-09  36  
6a9bfa83709a84e Julian Vetter 2024-09-09  37  	while (count) {
6a9bfa83709a84e Julian Vetter 2024-09-09  38  		*(u8 *)to = __raw_readb(from);
6a9bfa83709a84e Julian Vetter 2024-09-09  39  		from++;
6a9bfa83709a84e Julian Vetter 2024-09-09  40  		to++;
6a9bfa83709a84e Julian Vetter 2024-09-09  41  		count--;
6a9bfa83709a84e Julian Vetter 2024-09-09  42  	}
6a9bfa83709a84e Julian Vetter 2024-09-09  43  }
6a9bfa83709a84e Julian Vetter 2024-09-09  44  EXPORT_SYMBOL(__memcpy_fromio);
6a9bfa83709a84e Julian Vetter 2024-09-09  45  
6a9bfa83709a84e Julian Vetter 2024-09-09  46  void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
6a9bfa83709a84e Julian Vetter 2024-09-09  47  {
6a9bfa83709a84e Julian Vetter 2024-09-09  48  	while (count && !IS_ALIGNED((unsigned long)to, NATIVE_STORE_SIZE)) {
6a9bfa83709a84e Julian Vetter 2024-09-09  49  		__raw_writeb(*(u8 *)from, to);
6a9bfa83709a84e Julian Vetter 2024-09-09  50  		from++;
6a9bfa83709a84e Julian Vetter 2024-09-09  51  		to++;
6a9bfa83709a84e Julian Vetter 2024-09-09  52  		count--;
6a9bfa83709a84e Julian Vetter 2024-09-09  53  	}
6a9bfa83709a84e Julian Vetter 2024-09-09  54  
6a9bfa83709a84e Julian Vetter 2024-09-09  55  	while (count >= NATIVE_STORE_SIZE) {
6a9bfa83709a84e Julian Vetter 2024-09-09  56  		if (IS_ENABLED(CONFIG_64BIT))
6a9bfa83709a84e Julian Vetter 2024-09-09 @57  			__raw_writeq(get_unaligned((uintptr_t *)from), to);
6a9bfa83709a84e Julian Vetter 2024-09-09  58  		else
6a9bfa83709a84e Julian Vetter 2024-09-09  59  			__raw_writel(get_unaligned((uintptr_t *)from), to);
6a9bfa83709a84e Julian Vetter 2024-09-09  60  
6a9bfa83709a84e Julian Vetter 2024-09-09  61  		from += NATIVE_STORE_SIZE;
6a9bfa83709a84e Julian Vetter 2024-09-09  62  		to += NATIVE_STORE_SIZE;
6a9bfa83709a84e Julian Vetter 2024-09-09  63  		count -= NATIVE_STORE_SIZE;
6a9bfa83709a84e Julian Vetter 2024-09-09  64  	}
6a9bfa83709a84e Julian Vetter 2024-09-09  65  
6a9bfa83709a84e Julian Vetter 2024-09-09  66  	while (count) {
6a9bfa83709a84e Julian Vetter 2024-09-09  67  		__raw_writeb(*(u8 *)from, to);
6a9bfa83709a84e Julian Vetter 2024-09-09  68  		from++;
6a9bfa83709a84e Julian Vetter 2024-09-09  69  		to++;
6a9bfa83709a84e Julian Vetter 2024-09-09  70  		count--;
6a9bfa83709a84e Julian Vetter 2024-09-09  71  	}
6a9bfa83709a84e Julian Vetter 2024-09-09  72  }
6a9bfa83709a84e Julian Vetter 2024-09-09  73  EXPORT_SYMBOL(__memcpy_toio);
6a9bfa83709a84e Julian Vetter 2024-09-09  74  
6a9bfa83709a84e Julian Vetter 2024-09-09  75  void __memset_io(volatile void __iomem *dst, int c, size_t count)
6a9bfa83709a84e Julian Vetter 2024-09-09  76  {
6a9bfa83709a84e Julian Vetter 2024-09-09  77  	uintptr_t qc = (u8)c;
6a9bfa83709a84e Julian Vetter 2024-09-09  78  
6a9bfa83709a84e Julian Vetter 2024-09-09  79  	qc |= qc << 8;
6a9bfa83709a84e Julian Vetter 2024-09-09  80  	qc |= qc << 16;
6a9bfa83709a84e Julian Vetter 2024-09-09  81  
6a9bfa83709a84e Julian Vetter 2024-09-09  82  	if (IS_ENABLED(CONFIG_64BIT))
6a9bfa83709a84e Julian Vetter 2024-09-09 @83  		qc |= qc << 32;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

