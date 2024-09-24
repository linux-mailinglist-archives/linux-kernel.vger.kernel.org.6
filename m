Return-Path: <linux-kernel+bounces-337455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7E984A53
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7FC1C22EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F511AC43F;
	Tue, 24 Sep 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDfi09G6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04738DD1;
	Tue, 24 Sep 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199175; cv=none; b=KAzXLXehOhKuqsAfn4diMfekwz65fsDo7H2HkeGbPp4HR518Z0gi92geuxqg/UECqAqw0zHzRi2/SNAinPuSgvi8QmHibi5ctjjtOuHr8APqbV0SZluVCbh/OGw7uoGIQ4sEePt1CKRBa0pP0zTALRtPMteFIMro+zUtqiDKP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199175; c=relaxed/simple;
	bh=Gt1HROd9lweyB6BQxVDnNfBWnthleBvPyX5KcGtEsG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx8rQOBCaGkp7+ed5uIar39cZNUdNtAA6D6KWaD/yVCZpiWihPltra/ePKI59UQkFhHtAGp2nlUgnA3c0QznU0aTAu5vxAfLghBQotg/JOvdQPuxps+SPGPpD930C8u8k9lkTR+ay9n/DXcrzBxI2O0mMqiw5Yr5JcV4EAkro9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDfi09G6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727199173; x=1758735173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gt1HROd9lweyB6BQxVDnNfBWnthleBvPyX5KcGtEsG4=;
  b=gDfi09G6w+hFdt6XJKX8+bs+qiE2lccxyuw1Achnd4iG0JDwU+0IZ/1r
   DSikvAxcdT9PQnsfHQfl7xm5KMuxa+C2bOB79ojlwcZKVw+Jzm6CmX6L/
   TtsYy+b+l04ccP++fGea7UdkCQzYIVvHSjdyoBfybTMplJpg0LFI7RQ2c
   Tt77BRo0vHYQ0Bqhpp8H/XVu3/pI0pOWH/Uz5CO0fIYu0Z3VQToDmn6e8
   VPs7inLcnpmTE8DJ4EDIBuNYXlVuNynk/ViYrvKklxiNCYydahXc85l9R
   7egsx4ECuvdVfSklbyNDQMEds99BdemQ5+2hXERyG+EneNueicvvdlQNx
   A==;
X-CSE-ConnectionGUID: CswqCBYAQv66KG4BXFlBfg==
X-CSE-MsgGUID: vmaBkvDySs+2icQC0XzK8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="25724944"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="25724944"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 10:31:51 -0700
X-CSE-ConnectionGUID: 479xL8McT02pA0V2pkKr3Q==
X-CSE-MsgGUID: Wk29OdQsR9+zTSqezIg+LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76011417"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Sep 2024 10:31:32 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1st9Np-000Ie5-2L;
	Tue, 24 Sep 2024 17:31:29 +0000
Date: Wed, 25 Sep 2024 01:31:03 +0800
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
Subject: Re: [PATCH v4 2/5] Replace generic memcpy and memset by IO memcpy
 functions
Message-ID: <202409250049.WzbuwMDw-lkp@intel.com>
References: <20240924092223.534040-3-jvetter@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924092223.534040-3-jvetter@kalrayinc.com>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on arm64/for-next/core soc/for-next linus/master v6.11 next-20240924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Vetter/Consolidate-__memcpy_-to-from-io-and-__memset_io-into-a-single-lib/20240924-172751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240924092223.534040-3-jvetter%40kalrayinc.com
patch subject: [PATCH v4 2/5] Replace generic memcpy and memset by IO memcpy functions
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240925/202409250049.WzbuwMDw-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250049.WzbuwMDw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250049.WzbuwMDw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/openrisc/include/asm/io.h:37,
                    from include/linux/io.h:14,
                    from arch/openrisc/kernel/asm-offsets.c:31:
   include/asm-generic/io.h: In function 'memset_io':
>> include/asm-generic/io.h:1166:9: error: implicit declaration of function '__memset_io'; did you mean 'memset_io'? [-Wimplicit-function-declaration]
    1166 |         __memset_io(__io_virt(addr), value, size);
         |         ^~~~~~~~~~~
         |         memset_io
   include/asm-generic/io.h: In function 'memcpy_fromio':
>> include/asm-generic/io.h:1184:9: error: implicit declaration of function '__memcpy_fromio'; did you mean 'memcpy_fromio'? [-Wimplicit-function-declaration]
    1184 |         __memcpy_fromio(buffer, __io_virt(addr), size);
         |         ^~~~~~~~~~~~~~~
         |         memcpy_fromio
   include/asm-generic/io.h: In function 'memcpy_toio':
>> include/asm-generic/io.h:1201:9: error: implicit declaration of function '__memcpy_toio'; did you mean 'memcpy_toio'? [-Wimplicit-function-declaration]
    1201 |         __memcpy_toio(__io_virt(addr), buffer, size);
         |         ^~~~~~~~~~~~~
         |         memcpy_toio
   make[3]: *** [scripts/Makefile.build:117: arch/openrisc/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1193: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1166 include/asm-generic/io.h

  1152	
  1153	#ifndef memset_io
  1154	#define memset_io memset_io
  1155	/**
  1156	 * memset_io	Set a range of I/O memory to a constant value
  1157	 * @addr:	The beginning of the I/O-memory range to set
  1158	 * @val:	The value to set the memory to
  1159	 * @count:	The number of bytes to set
  1160	 *
  1161	 * Set a range of I/O memory to a given value.
  1162	 */
  1163	static inline void memset_io(volatile void __iomem *addr, int value,
  1164				     size_t size)
  1165	{
> 1166		__memset_io(__io_virt(addr), value, size);
  1167	}
  1168	#endif
  1169	
  1170	#ifndef memcpy_fromio
  1171	#define memcpy_fromio memcpy_fromio
  1172	/**
  1173	 * memcpy_fromio	Copy a block of data from I/O memory
  1174	 * @dst:		The (RAM) destination for the copy
  1175	 * @src:		The (I/O memory) source for the data
  1176	 * @count:		The number of bytes to copy
  1177	 *
  1178	 * Copy a block of data from I/O memory.
  1179	 */
  1180	static inline void memcpy_fromio(void *buffer,
  1181					 const volatile void __iomem *addr,
  1182					 size_t size)
  1183	{
> 1184		__memcpy_fromio(buffer, __io_virt(addr), size);
  1185	}
  1186	#endif
  1187	
  1188	#ifndef memcpy_toio
  1189	#define memcpy_toio memcpy_toio
  1190	/**
  1191	 * memcpy_toio		Copy a block of data into I/O memory
  1192	 * @dst:		The (I/O memory) destination for the copy
  1193	 * @src:		The (RAM) source for the data
  1194	 * @count:		The number of bytes to copy
  1195	 *
  1196	 * Copy a block of data to I/O memory.
  1197	 */
  1198	static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
  1199				       size_t size)
  1200	{
> 1201		__memcpy_toio(__io_virt(addr), buffer, size);
  1202	}
  1203	#endif
  1204	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

