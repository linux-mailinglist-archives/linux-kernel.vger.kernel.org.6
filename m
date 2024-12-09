Return-Path: <linux-kernel+bounces-436744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7E19E8A33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84862162D39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85B6155C87;
	Mon,  9 Dec 2024 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNLCe/zV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39228691
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717821; cv=none; b=EcLpL4b6KKI2/kntUnmQH0wtN5zzjerUSSFcRAII3uWBeZ8PkgNKK4UDSJFg5a8nguSZhbdXJrGeC6FrV8trvtVHkljr+IX2UCg6TZZlkhs8wXn0jnZzvWFBYOVEXry3zPpQAdg9Dud5NmEiSEFmonemkVsw2J8y2fipnf9AIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717821; c=relaxed/simple;
	bh=1fl27rwkrCIsSOR4yCaSqQ/1nF4/def69YvgohMztoE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ntFPxNg9qBpG2Ykh8HreMijAjBTTubOvj3SAoUvpxyiQqLndhjb+psioNM2IwpZUsqPp2NxIgzlugcspHXUOUeuAU4PSHuBkkPZRCO9JZe8bwNzistcGCSerTvWSD7LkpRnx1vNosL9yHx5X/N74OWM/G4h84iH3g3raVAk5hKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNLCe/zV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717820; x=1765253820;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1fl27rwkrCIsSOR4yCaSqQ/1nF4/def69YvgohMztoE=;
  b=cNLCe/zVmBndrlFoff531cnNM42ArkJCdwJy4YY7cb+44nvWpoJ8Q9GE
   W8WvlUF8BErc6HED8G5NYraC18a4w0x38nWS+XlfQPTks+MYNXai64yW8
   K1/AzCKM43lquCkbiDWCc6hnK1KWz8jRXwgDe45r5XqtcQMWLXRqVZLoy
   lbglR6Ok1z6QpNlw/oIqpxy7jUtGxvfxB+G+CJFje8FVHIaSuVM8qsVOz
   paS2S/oO/79B8cmWI6xqgxItR726o9BRuy8qUnVBDmaYuGU3YvCAtBf1v
   vehSX4laXVsUFnaWSq8N4ip46XgEAa2EaDyR9hpN8nYMh/0Df1fQO6/E0
   A==;
X-CSE-ConnectionGUID: knInoiVfQ9WcjVO6ujPw6A==
X-CSE-MsgGUID: fIIPqGGRTSq7kVlAwtRFxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34235965"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34235965"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:16:10 -0800
X-CSE-ConnectionGUID: nvHH4m1JRM2DNaau2QHTyw==
X-CSE-MsgGUID: +WROlKqnRIa+5PVSDs8kuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94823936"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Dec 2024 20:16:09 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVBm-0003p7-18;
	Mon, 09 Dec 2024 04:16:06 +0000
Date: Mon, 9 Dec 2024 12:15:11 +0800
From: kernel test robot <lkp@intel.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: arch/riscv/kernel/unaligned_access_speed.c:23:1: sparse: sparse:
 symbol '__pcpu_scope_vector_misaligned_access' was not declared. Should it
 be static?
Message-ID: <202412071930.fdm7QFW4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: d1703dc7bc8ec7adb91f5ceaf1556ff1ed212858 RISC-V: Detect unaligned vector accesses supported
date:   7 weeks ago
config: riscv-randconfig-r133-20241207 (https://download.01.org/0day-ci/archive/20241207/202412071930.fdm7QFW4-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241207/202412071930.fdm7QFW4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071930.fdm7QFW4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/unaligned_access_speed.c:23:1: sparse: sparse: symbol '__pcpu_scope_vector_misaligned_access' was not declared. Should it be static?

vim +/__pcpu_scope_vector_misaligned_access +23 arch/riscv/kernel/unaligned_access_speed.c

    21	
    22	DEFINE_PER_CPU(long, misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
  > 23	DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

