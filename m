Return-Path: <linux-kernel+bounces-393665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CB9BA3C9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FF21F215BF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 03:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF670832;
	Sun,  3 Nov 2024 03:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beYobYYD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F61535DC;
	Sun,  3 Nov 2024 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730605336; cv=none; b=St8VpDSO5o0pAU0OySMgOirBiFX5dDJhzIUOnXe1bXtsKPBpAQ4H84vHNhaN76fvJ6OdNVHk2fsr+bCdQk82ymkgni8lwRd92F6lhvNcH9hBDBOZQ7Kr9S6TY1sP0a3lM4afanTxFEd5mTX90KjYuoN7hYUix7xdDby0A1hsSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730605336; c=relaxed/simple;
	bh=V0/eOxl40RDDf32RGsY9aYQHQUntmDfjqmV8lPkvwlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDkDHeT1HqXbAK7IUpv19rR5IlKNeScOycqLbA5ss9WRVuegvc3JzZDBICrD056DnuTbobiVErSporNm6BED9usYzamVf988wUuo0PZQM+PR95UsafIj11hySJwawA9ELWUl2h/F+GwF1HkXJO5wP8AIBi1oHBYk+VghUUJYyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beYobYYD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730605334; x=1762141334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V0/eOxl40RDDf32RGsY9aYQHQUntmDfjqmV8lPkvwlk=;
  b=beYobYYDpdyRepQtFhhUFrHTsED4Up7ab7agk1jjnAQxpIjBd4aZMtA+
   Fo1k1tws4x1Du7mk5Wej4q+5YTty17beYqHXW/5qMzxH2crvNRdPS01xz
   VB/t6QcL4Ow42Sqjcf1cxWyCdvfiFFAmf4GpqQeY1Z+KZN190kWgR0IW4
   Q3t9+GXhkOdvLRwBVjX+XhI8/64wiKoJMERJSfNwIYeQXAy0ZRUcxuOz/
   Nwh5+ddv7H2Cc16sJ60Wv20iLOllH+7cbKUuaLa2OCZeNFhhdYw03yCXe
   +PGNeSMf7holphHXWUebHfm2Ram69DMhSpxDVZyAInbrdpLn1N/IMqivm
   A==;
X-CSE-ConnectionGUID: U4qFD/euT96AVi/dtC6Ezg==
X-CSE-MsgGUID: F5cue0BYSYS1OPVroKMVhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="17947773"
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="17947773"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 20:42:14 -0700
X-CSE-ConnectionGUID: 8IiP82YTQnSyoSqruIbLPQ==
X-CSE-MsgGUID: HEWP8l6rT8eOwHx6hyAhfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="88463046"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 02 Nov 2024 20:42:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7RVA-000jeb-0x;
	Sun, 03 Nov 2024 03:42:08 +0000
Date: Sun, 3 Nov 2024 11:41:18 +0800
From: kernel test robot <lkp@intel.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel.almeida@collabora.com,
	a.hindborg@kernel.org, linux-kernel@vger.kernel.org,
	dakr@redhat.com, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v2 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <202411031138.gvA1f2D7-lkp@intel.com>
References: <20241101113422.2615566-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101113422.2615566-3-abdiel.janulgue@gmail.com>

Hi Abdiel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 718c4069896cabba5c39b637cbb7205927f16ae0]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdiel-Janulgue/rust-error-Add-EOVERFLOW/20241101-193708
base:   718c4069896cabba5c39b637cbb7205927f16ae0
patch link:    https://lore.kernel.org/r/20241101113422.2615566-3-abdiel.janulgue%40gmail.com
patch subject: [PATCH v2 2/2] rust: add dma coherent allocator abstraction.
config: um-randconfig-r071-20241103 (https://download.01.org/0day-ci/archive/20241103/202411031138.gvA1f2D7-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241103/202411031138.gvA1f2D7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411031138.gvA1f2D7-lkp@intel.com/

All errors (new ones prefixed by >>):

   |                                                   ^
   In file included from rust/helpers/helpers.c:10:
   In file included from rust/helpers/blk.c:3:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
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
   In file included from rust/helpers/helpers.c:10:
   In file included from rust/helpers/blk.c:3:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
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
   13 warnings generated.
   clang diag: include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>> error[E0425]: cannot find function `dma_alloc_attrs` in crate `bindings`
   --> rust/kernel/dma.rs:58:23
   |
   58    |               bindings::dma_alloc_attrs(
   |                         ^^^^^^^^^^^^^^^ help: a function with a similar name exists: `dma_alloc_pages`
   |
   ::: rust/bindings/bindings_generated.rs:42989:5
   |
   42989 | /     pub fn dma_alloc_pages(
   42990 | |         dev: *mut device,
   42991 | |         size: usize,
   42992 | |         dma_handle: *mut dma_addr_t,
   42993 | |         dir: dma_data_direction,
   42994 | |         gfp: gfp_t,
   42995 | |     ) -> *mut page;
   | |__________________- similarly named function `dma_alloc_pages` defined here
--
>> error[E0425]: cannot find function `dma_free_attrs` in crate `bindings`
   --> rust/kernel/dma.rs:161:28
   |
   161   |           unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
   |                              ^^^^^^^^^^^^^^ help: a function with a similar name exists: `dma_free_pages`
   |
   ::: rust/bindings/bindings_generated.rs:42998:5
   |
   42998 | /     pub fn dma_free_pages(
   42999 | |         dev: *mut device,
   43000 | |         size: usize,
   43001 | |         page: *mut page,
   43002 | |         dma_handle: dma_addr_t,
   43003 | |         dir: dma_data_direction,
   43004 | |     );
   | |_____- similarly named function `dma_free_pages` defined here

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

