Return-Path: <linux-kernel+bounces-535260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD6A470AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27B81888EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8E1758B;
	Thu, 27 Feb 2025 01:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRDBJWO5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B952F36
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618262; cv=none; b=FVxQQBvxYYcDKHfWJzfrEzBd36gvSaRNBmdTGoUyqOolh4K09qG1CzkysGlG4DRFldTn1syQ5HKdfuLr5iY3tL0UqpPZ46PtNyj8aGrugLPYsYmNHkFgqGa9UFZFIHZcmH0r3Atc2ouyxre+xV9usKT7X25zEY2P3D0GA1BwbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618262; c=relaxed/simple;
	bh=GVLya1KRbaZlDYEQbloHz/I5Zrz6IR2bESbtDWMxjn0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LPF2nP/l+65X5dibvQkgu0E2ojhbM7c0Jlp0zbmyZ18ksiciCKV4olgxcq3sX2SJo20ZAnzTWGnwA+/AlCnWPjBQjFD+XPpjltyqnWN3W/FIP3wdXX5jyruyhc/6SaMVBFE7VlPXYczwX37r0tD9PlXd9QOA2sWEJ4eay6y9l04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRDBJWO5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740618261; x=1772154261;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GVLya1KRbaZlDYEQbloHz/I5Zrz6IR2bESbtDWMxjn0=;
  b=GRDBJWO5JFBjvUK+mMJs70MAJnA/w5WrRU5ubLu3dggeTPom1fOJvxYp
   tTLNhwdU6lkWDmB5AzZgKpJVXRhOcLZbQEApVMdMFNXuVn9PGhqxdA2E3
   sAB8aZBDmqDX9DONg2Dx0+LwZFX00EwwNhK5x0tdMydcVj874MJzU5f/V
   yzMRu3ZBSUAdROo2yZ1GrWPHc5QzvqfnBZNnQ4m+5VKYgUGdtUGnCcUqW
   Dq/gd6GsieGyEWJL18F8SyLPohnchKFRenHNH6GRv1VhF25/mDdC5XGYH
   7d4+nU1YQX0LsH5em/dr9xWECSpnO+uBMF6As70cgHck6Iq7azCgB42NG
   A==;
X-CSE-ConnectionGUID: Mg8FTtlnT5+YWPj3ob8VWQ==
X-CSE-MsgGUID: EpbuTashS1yCMUf8xkAITg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41623534"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41623534"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:04:20 -0800
X-CSE-ConnectionGUID: Bg2xI4FrRPGCpSyTRIf4IQ==
X-CSE-MsgGUID: 8lzcF1azSVSDSzSioLbhQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117788882"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2025 17:04:18 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnSJz-000Cfs-2h;
	Thu, 27 Feb 2025 01:04:15 +0000
Date: Thu, 27 Feb 2025 09:03:52 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>
Subject: [tip:x86/core 16/17] vmlinux.o: warning: objtool: do_jit+0x597:
 relocation to !ENDBR: memcpy_orig+0x0
Message-ID: <202502270859.WfFkfHBC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
head:   dfebe7362f6f461d771cdb9ac2c5172a4721f064
commit: 0c92385dc05ee9637c04372ea95a11bbf6e010ff [16/17] x86/ibt: Implement FineIBT-BHI mitigation
config: x86_64-buildonly-randconfig-002-20250227 (https://download.01.org/0day-ci/archive/20250227/202502270859.WfFkfHBC-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502270859.WfFkfHBC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502270859.WfFkfHBC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: ___bpf_prog_run+0xcb: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: do_jit+0x597: relocation to !ENDBR: memcpy_orig+0x0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

