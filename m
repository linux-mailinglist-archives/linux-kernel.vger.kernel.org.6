Return-Path: <linux-kernel+bounces-188420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BCE8CE1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742551C20D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47063128830;
	Fri, 24 May 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlmS29hD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601733D0
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537129; cv=none; b=j0bPWxOwNfVGgG4RydkdMIqi3kP9tc4Vz90de8QSC3qMfTAoYS5qykIU8x+OX/sVakzuHKy5xCKNsFRp9EQReXPdrJne3fANDwnsYmoM/36l+eZMVVIllebJ/9SDQYXSxj+kxK6X3UWGB+Llhe/mCzQHIE08fpJEuAd/9a8ed2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537129; c=relaxed/simple;
	bh=QzrD8AGvf6pS5eLjMki7qBduZKDx+ISB2uKzJL0Jp4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N7P/HAbYyUsD2SJxgSRz1vkOxvYjtngd4JRghToapi6nzv/bn9z+uJkZzq2q/Fkpv6nrwWdDROzIz6WVedIdiEcqEyF+uR7Kt1iJ2U7f12MfMD31uOiya65kzMB3D65nFoFkTRPmFHOF8ext5/D/sn+MwGtEhqwXyozWRiTd838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlmS29hD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716537127; x=1748073127;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QzrD8AGvf6pS5eLjMki7qBduZKDx+ISB2uKzJL0Jp4E=;
  b=AlmS29hDNyD9QYoQh6u8PVMTq/h/95DuTBbBCVCsNoIRZE4EymRJt3pg
   t3QXg+3z9hEMYwTuPAPu7isQ93NByS/x6I/dB2+j9wlDqMA/NkWKJGX2A
   hdMulWRUs028CTJlAlOzgi4JGhCoxFOJ2Tt1hHRKS+1DTf9Vl6hMmUknP
   xyaR5c2t1zg6cFsxVq5DgoRBsUyM90cI4MAV9l4vcSLbShlJhvqctXdML
   Ts+mpRil+ZWNxUJDMkcPcPONCC1Wrsh/jJsWm4hVFahaHMW+SC1YKDqi2
   +lDkP307Oy1oAYL7VbLmLwrCJg88+MACLodz2+EhpYqgLaEU85FbHI6YX
   A==;
X-CSE-ConnectionGUID: XkGh8Z84QBmXSyFS/saaSA==
X-CSE-MsgGUID: 3rUyxamqR9iSk1dX0Wl1pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="15845825"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="15845825"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:52:06 -0700
X-CSE-ConnectionGUID: HjkGpbXxRrmw39LR9e9miw==
X-CSE-MsgGUID: kpPSukdHSUq5tGcx6vTgsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="38356747"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 24 May 2024 00:52:05 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAPia-00046p-0i;
	Fri, 24 May 2024 07:52:02 +0000
Date: Fri, 24 May 2024 15:49:24 +0800
From: kernel test robot <lkp@intel.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/uapi/linux/swab.h:51:(.xiptext+0x3f0): dangerous relocation:
 windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
Message-ID: <202405241543.eSlEcuSy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d69b6c12fce479fde7bc06f686212451688a102
commit: 03ce34cf8f50e4c62f9a4b62caffdba1165ca977 xtensa: add XIP-aware MTD support
date:   9 months ago
config: xtensa-randconfig-r023-20230807 (https://download.01.org/0day-ci/archive/20240524/202405241543.eSlEcuSy-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241543.eSlEcuSy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405241543.eSlEcuSy-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x8d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x95): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0xa3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0xb9): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1ec)
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0xd1): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0xee): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0xfa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x10b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x118): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x12a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x137): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x14b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x158): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x16a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x176): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x186): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x195): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x1a6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memset
   drivers/mtd/chips/cfi_probe.o:drivers/mtd/chips/cfi_probe.c:197:(.xiptext+0x1af): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:198:(.xiptext+0x1bf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_probe.c:200:(.xiptext+0x1dc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:204:(.xiptext+0x1ec): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1ec)
   drivers/mtd/chips/cfi_probe.c:204:(.xiptext+0x1f8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_probe.c:204:(.xiptext+0x210): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:208:(.xiptext+0x21e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:208:(.xiptext+0x230): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x18)
   drivers/mtd/chips/cfi_probe.c:208:(.xiptext+0x23f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.c:211:(.xiptext+0x254): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `kmalloc':
   include/linux/slab.h:575:(.xiptext+0x262): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   include/linux/slab.h:586:(.xiptext+0x274): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x18)
   include/linux/slab.h:586:(.xiptext+0x283): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:212:(.xiptext+0x298): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:212:(.xiptext+0x2a6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:212:(.xiptext+0x2b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x18)
   drivers/mtd/chips/cfi_probe.c:212:(.xiptext+0x2c7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.c:215:(.xiptext+0x2dc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:219:(.xiptext+0x2ea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:222:(.xiptext+0x2fc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x18)
   drivers/mtd/chips/cfi_probe.c:223:(.xiptext+0x30b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.c:224:(.xiptext+0x31e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:224:(.xiptext+0x32f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:223:(.xiptext+0x341): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x18)
   drivers/mtd/chips/cfi_probe.c:227:(.xiptext+0x34e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.c:227:(.xiptext+0x35f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:227:(.xiptext+0x372): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:227:(.xiptext+0x384): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x18)
   drivers/mtd/chips/cfi_probe.c:229:(.xiptext+0x392): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.c:229:(.xiptext+0x3b6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.c:230:(.xiptext+0x3e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: .text
   drivers/mtd/chips/cfi_probe.o: in function `__fswab16':
>> include/uapi/linux/swab.h:51:(.xiptext+0x3f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:231:(.xiptext+0x414): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:231:(.xiptext+0x41f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_probe.o: in function `__fswab16':
>> include/uapi/linux/swab.h:51:(.xiptext+0x432): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read_range
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:232:(.xiptext+0x452): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:232:(.xiptext+0x45e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o: in function `__fswab16':
   include/uapi/linux/swab.h:51:(.xiptext+0x47a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:232:(.xiptext+0x486): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:233:(.xiptext+0x498): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:233:(.xiptext+0x4af): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.o: in function `__fswab16':
   include/uapi/linux/swab.h:51:(.xiptext+0x4b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:233:(.xiptext+0x4cc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.c:233:(.xiptext+0x4d4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x4e8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x4f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x508): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_probe.o: in function `__fswab32':
   include/uapi/linux/swab.h:60:(.xiptext+0x512): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xc4)
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x51f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x52b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xc4)
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x53a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:241:(.xiptext+0x544): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:240:(.xiptext+0x55e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x56b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x57a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1ec)
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x58a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x1ec)
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x597): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x5aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:250:(.xiptext+0x5b6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:263:(.xiptext+0x5c9): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:263:(.xiptext+0x5e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read2
   drivers/mtd/chips/cfi_probe.c:264:(.xiptext+0x5fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read2
   drivers/mtd/chips/cfi_probe.c:265:(.xiptext+0x610): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:266:(.xiptext+0x623): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:266:(.xiptext+0x630): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:267:(.xiptext+0x642): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:267:(.xiptext+0x652): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:268:(.xiptext+0x65e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:268:(.xiptext+0x66a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:276:(.xiptext+0x6fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_probe.c:277:(.xiptext+0x704): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_early_fixup':
   drivers/mtd/chips/cfi_probe.c:84:(.xiptext+0x71b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:84:(.xiptext+0x726): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:84:(.xiptext+0x740): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:84:(.xiptext+0x74c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:84:(.xiptext+0x75f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:84:(.xiptext+0x76c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:84:(.xiptext+0x78b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:84:(.xiptext+0x795): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
   drivers/mtd/chips/cfi_probe.c:286:(.xiptext+0x7b0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:286:(.xiptext+0x7ba): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:286:(.xiptext+0x7cc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:286:(.xiptext+0x7de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:286:(.xiptext+0x7e8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:286:(.xiptext+0x806): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:286:(.xiptext+0x812): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x82f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x846): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x853): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x86a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x87b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x896): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x8a5): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:98:(.xiptext+0x8cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.o: in function `cfi_probe_chip':
   drivers/mtd/chips/cfi_probe.c:101:(.xiptext+0x8e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:101:(.xiptext+0x8f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:101:(.xiptext+0x8fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:107:(.xiptext+0x917): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:107:(.xiptext+0x926): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:107:(.xiptext+0x94f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:115:(.xiptext+0x95c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:115:(.xiptext+0x968): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:116:(.xiptext+0x98e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kcsan_check_access
   drivers/mtd/chips/cfi_probe.c:120:(.xiptext+0x9b6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_probe.c:120:(.xiptext+0x9c0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_probe.c:120:(.xiptext+0x9d7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x4e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x56): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x60): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x73): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x83): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x93): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o:drivers/mtd/chips/cfi_util.c:221:(.xiptext+0xa2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_present':
   drivers/mtd/chips/cfi_util.c:221:(.xiptext+0xbc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:222:(.xiptext+0xd3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:227:(.xiptext+0xf6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:221:(.xiptext+0x102): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_util.c:230:(.xiptext+0x114): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:230:(.xiptext+0x123): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_util.c:231:(.xiptext+0x132): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:231:(.xiptext+0x13e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_util.c:234:(.xiptext+0x156): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.c:234:(.xiptext+0x162): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_util.c:234:(.xiptext+0x16f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4


vim +51 include/uapi/linux/swab.h

607ca46e97a1b6 David Howells 2012-10-13   9  
607ca46e97a1b6 David Howells 2012-10-13  10  /*
607ca46e97a1b6 David Howells 2012-10-13  11   * casts are necessary for constants, because we never know how for sure
607ca46e97a1b6 David Howells 2012-10-13  12   * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
607ca46e97a1b6 David Howells 2012-10-13  13   */
607ca46e97a1b6 David Howells 2012-10-13  14  #define ___constant_swab16(x) ((__u16)(				\
607ca46e97a1b6 David Howells 2012-10-13  15  	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
607ca46e97a1b6 David Howells 2012-10-13  16  	(((__u16)(x) & (__u16)0xff00U) >> 8)))
607ca46e97a1b6 David Howells 2012-10-13  17  
607ca46e97a1b6 David Howells 2012-10-13  18  #define ___constant_swab32(x) ((__u32)(				\
607ca46e97a1b6 David Howells 2012-10-13  19  	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
607ca46e97a1b6 David Howells 2012-10-13  20  	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
607ca46e97a1b6 David Howells 2012-10-13  21  	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
607ca46e97a1b6 David Howells 2012-10-13  22  	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
607ca46e97a1b6 David Howells 2012-10-13  23  
607ca46e97a1b6 David Howells 2012-10-13  24  #define ___constant_swab64(x) ((__u64)(				\
607ca46e97a1b6 David Howells 2012-10-13  25  	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
607ca46e97a1b6 David Howells 2012-10-13  26  	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
607ca46e97a1b6 David Howells 2012-10-13  27  	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
607ca46e97a1b6 David Howells 2012-10-13  28  	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
607ca46e97a1b6 David Howells 2012-10-13  29  	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
607ca46e97a1b6 David Howells 2012-10-13  30  	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
607ca46e97a1b6 David Howells 2012-10-13  31  	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
607ca46e97a1b6 David Howells 2012-10-13  32  	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
607ca46e97a1b6 David Howells 2012-10-13  33  
607ca46e97a1b6 David Howells 2012-10-13  34  #define ___constant_swahw32(x) ((__u32)(			\
607ca46e97a1b6 David Howells 2012-10-13  35  	(((__u32)(x) & (__u32)0x0000ffffUL) << 16) |		\
607ca46e97a1b6 David Howells 2012-10-13  36  	(((__u32)(x) & (__u32)0xffff0000UL) >> 16)))
607ca46e97a1b6 David Howells 2012-10-13  37  
607ca46e97a1b6 David Howells 2012-10-13  38  #define ___constant_swahb32(x) ((__u32)(			\
607ca46e97a1b6 David Howells 2012-10-13  39  	(((__u32)(x) & (__u32)0x00ff00ffUL) << 8) |		\
607ca46e97a1b6 David Howells 2012-10-13  40  	(((__u32)(x) & (__u32)0xff00ff00UL) >> 8)))
607ca46e97a1b6 David Howells 2012-10-13  41  
607ca46e97a1b6 David Howells 2012-10-13  42  /*
607ca46e97a1b6 David Howells 2012-10-13  43   * Implement the following as inlines, but define the interface using
607ca46e97a1b6 David Howells 2012-10-13  44   * macros to allow constant folding when possible:
607ca46e97a1b6 David Howells 2012-10-13  45   * ___swab16, ___swab32, ___swab64, ___swahw32, ___swahb32
607ca46e97a1b6 David Howells 2012-10-13  46   */
607ca46e97a1b6 David Howells 2012-10-13  47  
607ca46e97a1b6 David Howells 2012-10-13  48  static inline __attribute_const__ __u16 __fswab16(__u16 val)
607ca46e97a1b6 David Howells 2012-10-13  49  {
7322dd755e7dd3 Arnd Bergmann 2016-05-05  50  #if defined (__arch_swab16)
607ca46e97a1b6 David Howells 2012-10-13 @51  	return __arch_swab16(val);
607ca46e97a1b6 David Howells 2012-10-13  52  #else
607ca46e97a1b6 David Howells 2012-10-13  53  	return ___constant_swab16(val);
607ca46e97a1b6 David Howells 2012-10-13  54  #endif
607ca46e97a1b6 David Howells 2012-10-13  55  }
607ca46e97a1b6 David Howells 2012-10-13  56  

:::::: The code at line 51 was first introduced by commit
:::::: 607ca46e97a1b6594b29647d98a32d545c24bdff UAPI: (Scripted) Disintegrate include/linux

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

