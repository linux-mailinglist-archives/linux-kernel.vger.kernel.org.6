Return-Path: <linux-kernel+bounces-292243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFDA956CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2121B1F24E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F316CD11;
	Mon, 19 Aug 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJp9ySGQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D0515CD75
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077010; cv=none; b=q2paamrTyXfPFfqBTdib2Xthgypim5WtHIzgY3erIw82nSZgsgFMSJoyZlXYLSNVIO4qSRvpZr86a8VHvRC7uSfePLWlTkupHGSD6dSntgxcKjsTdUEzqeihxgZDQui8PEM0RwUCJB3GLFh68GxZw4lgZ4s4bdJ0HDXUxDRxMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077010; c=relaxed/simple;
	bh=mnwLF0TnfXq7cg3jN8iAwtQabXlrEGSW/K+U3HM0F9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MEpc0K3kbDOZOQNFstY4RIZYWyHC/XVFZzyBn7HSJzrikp4ty6EIoO63FmPDP6CVUMGo+Ykkmwz+8CkfVlQZzm2iRtG8hvGq6gXjrJGhg8zA2FN2OK0T8L8DtHe/iepVHFa014dF4VhrK7Wta8Jrvptyk/QTM1QyEa5zIb7Wfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJp9ySGQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724077009; x=1755613009;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mnwLF0TnfXq7cg3jN8iAwtQabXlrEGSW/K+U3HM0F9k=;
  b=PJp9ySGQxXR+FF7nym5dke/Tn48urmWzmtsnfIdtg5TawLQFFdZkwiZJ
   Dj/kqkXzCTuzL6cDXdicSsEfhaqVCEQPKk5WguSBuWQk35Z8qqjcare52
   s8xJwImcyi4mGVFqmQ/C/N3KdJKms/JeTbxqi0rZICw/ityu6Y9OIYkF4
   ZkG6mr/xC1UIArY3MtWmDNp0PAzHVzjpM+YoWZAoyyHRpTqvfp6V2r/xF
   1Dp1CLxKEKqgWdUgjH4zHlyUCMpR0Tv67dPv/QFPNlwUzoEcth/kcEVv9
   rLbGvQaAlhqVRHzB0rk14qy1Nl0JkrqkkMCjJa54RkB0UjBc84kST0nmg
   g==;
X-CSE-ConnectionGUID: 3iyFqjbAQnq2S74aXbs74A==
X-CSE-MsgGUID: NCAJ46OHSZuE6ZNOfxODPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22501756"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22501756"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:16:46 -0700
X-CSE-ConnectionGUID: 7gSz4SjKTgedV7xcjeEQqg==
X-CSE-MsgGUID: +sDyYt4vSX+a5ea0pr+0DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60365345"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Aug 2024 07:16:44 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg3Ba-000936-36;
	Mon, 19 Aug 2024 14:16:42 +0000
Date: Mon, 19 Aug 2024 22:16:04 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol
 'tlb_flush_all_threshold'; recompile with -fPIC
Message-ID: <202408192214.Wywi5bOd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   47ac09b91befbb6a235ab620c32af719f8208399
commit: f0c83a23fcbb424fdff5b38fbcdda3c04003a210 Bluetooth: btmtk: Fix btmtk.c undefined reference build error
date:   3 weeks ago
config: riscv-randconfig-001-20240819 (https://download.01.org/0day-ci/archive/20240819/202408192214.Wywi5bOd-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408192214.Wywi5bOd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408192214.Wywi5bOd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'tlb_flush_all_threshold'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/mm/tlbflush.o)
   >>> referenced by errata.c:70 (arch/riscv/errata/sifive/errata.c:70)
   >>>               arch/riscv/errata/sifive/errata.o:(errata_cip_1200_check_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_S cannot be used against symbol 'tlb_flush_all_threshold'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/mm/tlbflush.o)
   >>> referenced by errata.c:70 (arch/riscv/errata/sifive/errata.c:70)
   >>>               arch/riscv/errata/sifive/errata.o:(errata_cip_1200_check_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'riscv_cbom_block_size'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
   >>> referenced by errata.c:113 (arch/riscv/errata/thead/errata.c:113)
   >>>               arch/riscv/errata/thead/errata.o:(thead_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_S cannot be used against symbol 'riscv_cbom_block_size'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
   >>> referenced by errata.c:120 (arch/riscv/errata/thead/errata.c:120)
   >>>               arch/riscv/errata/thead/errata.o:(thead_errata_patch_func) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

