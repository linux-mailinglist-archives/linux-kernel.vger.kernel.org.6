Return-Path: <linux-kernel+bounces-544326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD99A4E020
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EDD189DFA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1C204874;
	Tue,  4 Mar 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwf1I0gH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A61487DD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096936; cv=none; b=UgDa3R/QkOiEshAGDVivqYNnlofak5vzc593sMobe4lbTLbq6GiPAgGDBlriouWhQKZYKQ2SkLmEaTHE+6D+ZWtILFCOUuHZMQQa5NrrNoUDdSPiVc8Je3GnWPCi4/YbYfhzFAVpeKF8wppvXtg6x86m4ItDSoqqHTMh9RNmNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096936; c=relaxed/simple;
	bh=X3wVSbPdGLiyAWBYqUq06EAyrsnlLLs1nOsCTzAax4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sUV7+mBzx5oHvLKTeKTpXSqyQ64Zp6nKa+dWDwdbMuypS099Cw8dy8JDlwlSdnOH98Iiu5aZGpmuFrx6hvxBOR0Tm6KcExb7lCNITmsA0xBI4ZJQR1bqVVXjspBM/05Ow1WGfYYV4BlcPmpEZjyn6oa09mV6fdsu24Wex6GMqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwf1I0gH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741096933; x=1772632933;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X3wVSbPdGLiyAWBYqUq06EAyrsnlLLs1nOsCTzAax4g=;
  b=lwf1I0gHetN9SnjsVN4jUHBcAkMWFTbVCW2vnxDLbyLUJdsH7OaQWyTz
   7smaxuY0omLRJMAts7Pow6LTPGBgMtLjteDalIixyr4zJKoIOdSyjeUsT
   xliliRwGvbknQMfdjxszKNV8UyFqquLfTmSUHBA9iJdcvn+YobTGcqgn/
   UlpGMKcnTsPL12IbI4Ol+SKqI1+9jPIzhXtc2PaXYmDWfIoTbBr6mGRMP
   jiuTOQeRmVVw+mwkON2brAw9hB3ko6y3iPztKm6+qDK+/f+zVt59rYhzB
   zk/hYguk3DpCN3NHGIEAL3/goBID4+NieuYoTNNTShbwmYh0bGD6HvHRf
   A==;
X-CSE-ConnectionGUID: 4ZkbKpe/SOy8/ceMdPfnCA==
X-CSE-MsgGUID: vJc76ej5TTqzmUWsOUgybA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45940290"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="45940290"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:02:11 -0800
X-CSE-ConnectionGUID: hoxkgx5WT8ShuT5jLp3JcA==
X-CSE-MsgGUID: eBQYa5DQRTOQGm5p+NKFCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="122995077"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 04 Mar 2025 06:02:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpSqH-000JqT-1v;
	Tue, 04 Mar 2025 14:01:57 +0000
Date: Tue, 4 Mar 2025 21:59:51 +0800
From: kernel test robot <lkp@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: rust/helpers/io.c:12:10: error: passing 'volatile void *' to
 parameter of type 'void *' discards qualifiers
Message-ID: <202503042137.LYjq6GwD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Danilo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99fa936e8e4f117d62f229003c9799686f74cebc
commit: ce30d94e6855a4f6dc687f658e63c225fcc1d690 rust: add `io::{Io, IoRaw}` base types
date:   2 months ago
config: um-randconfig-r121-20250304 (https://download.01.org/0day-ci/archive/20250304/202503042137.LYjq6GwD-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503042137.LYjq6GwD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503042137.LYjq6GwD-lkp@intel.com/

All errors (new ones prefixed by >>):

   ***
   *** Rust bindings generator 'bindgen' < 0.69.5 together with libclang >= 19.1
   *** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),
   *** unless patched (like Debian's).
   ***   Your bindgen version:  0.65.1
   ***   Your libclang version: 21.0.0
   ***
   ***
   *** Please see Documentation/rust/quick-start.rst for details
   *** on how to set up the Rust support.
   ***
   In file included from rust/helpers/helpers.c:10:
   In file included from rust/helpers/blk.c:3:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/um/include/asm/cacheflush.h:4:
   In file included from arch/um/include/asm/tlbflush.h:9:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from rust/helpers/helpers.c:17:
>> rust/helpers/io.c:12:10: error: passing 'volatile void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
      12 |         iounmap(addr);
         |                 ^~~~
   arch/um/include/asm/io.h:19:42: note: passing argument to parameter 'addr' here
      19 | static inline void iounmap(void __iomem *addr)
         |                                          ^
   1 warning and 1 error generated.
   make[3]: *** [scripts/Makefile.build:194: rust/helpers/helpers.o] Error 1
   clang diag: include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>> rust/helpers/io.c:12:10: error: passing 'volatile void *' to parameter of type 'void *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
   arch/um/include/asm/io.h:19:42: note: passing argument to parameter 'addr' here
   clang diag: include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   make[3]: *** [rust/Makefile:330: rust/bindings/bindings_helpers_generated.rs] Error 101
   make[3]: *** Deleting file 'rust/bindings/bindings_helpers_generated.rs'
   clang diag: include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   make[3]: Target 'rust/' not remade because of errors.
   make[2]: *** [Makefile:1269: prepare] Error 2
   make[1]: *** [Makefile:251: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +12 rust/helpers/io.c

     9	
    10	void rust_helper_iounmap(volatile void __iomem *addr)
    11	{
  > 12		iounmap(addr);
    13	}
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

