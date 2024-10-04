Return-Path: <linux-kernel+bounces-350794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026BB9909C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA0C2826B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C41CACE1;
	Fri,  4 Oct 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbwieQ1N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF44E1C82E6
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060994; cv=none; b=NyemHf7gJm1tKYPRnmZxNH0HXpbgWdHwDFeC6MgZU+rLXIqltDmm+x1lGWDlvDclveyUCokEVS7FRHusA8/ubKLhKvvJrScCTj+MgrOQdtm4JEMHTm+ro0n0oBhApVWyhR0alWk+qJ9JqbGvsQK6iAbjhSiMhxXMueCDvByoyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060994; c=relaxed/simple;
	bh=W2foUycNRegUi6spMmTGQXEEZSXuN8w/5HGDKJ6UwOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fobLz3OGYSGFQnoGLIZcORESAVITVzVfmLuzlP7Lx9ii2OvCwgJK11UAMh1ysp42WDbbBvVLD6fmAi7L937inhvPnBM3Tl6vUSnII3VfU8z8ViIXmOkjk0BGe3mIGaKz1jCFNiZRZn+KajDCUNL8d0ZVSzGxw9Fth/zvXersvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbwieQ1N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728060992; x=1759596992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W2foUycNRegUi6spMmTGQXEEZSXuN8w/5HGDKJ6UwOE=;
  b=EbwieQ1N7ULDGInvNr5NFlcr0Xg0kNPJqYwJBzOJN05FQr6fYr6eTl1u
   uYYpC7hld4Q6+LkAB/CLFgTW38+c9//lGqr3sjFY0yOOOVtURSzmPCuU/
   66KrXvr1HkHww5BRcvoNX8fR1zYicmbaGaVY/KhkQbbIUkZqgSgShfESS
   mFiZZH4gXbaTiePGvf679enSgLLaCFQg/joCorZ2LQY8UncApuwmukDxn
   oCGxJfklErByHodfBoKwVpd9LlsspFz5waeH3Al3XFjdy4D/Xu0L+lNSB
   DbjC4NJervIPZSTNi2bZYDdk9dAANGh3yXIBi7kbOnS2KvTyT4cRHvk/Q
   A==;
X-CSE-ConnectionGUID: 3etzbamLQeuPVDGBtR2tzg==
X-CSE-MsgGUID: DZabEbRdTF2gusvuSZvhSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37895139"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="37895139"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 09:56:32 -0700
X-CSE-ConnectionGUID: oUpoyzgSSZmNyDHRMHQocw==
X-CSE-MsgGUID: he5+mPppSDmKbwdts3O65A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="105613669"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Oct 2024 09:56:30 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swlbP-0001wa-0g;
	Fri, 04 Oct 2024 16:56:27 +0000
Date: Sat, 5 Oct 2024 00:56:19 +0800
From: kernel test robot <lkp@intel.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>, Gary Guo <gary@garyguo.net>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: clang diag: include/linux/vmstat.h:508:43: warning: arithmetic
 between different enumeration types ('enum zone_stat_item' and 'enum
 numa_stat_item')
Message-ID: <202410050057.hCdLpQvm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c559323bbaabee7346c12e74b497e283aaafef5
commit: 70a57b247251aabadd67795c3097c0fcc616e533 RISC-V: enable building 64-bit kernels with rust support
date:   5 months ago
config: riscv-randconfig-r132-20241004 (https://download.01.org/0day-ci/archive/20241005/202410050057.hCdLpQvm-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce: (https://download.01.org/0day-ci/archive/20241005/202410050057.hCdLpQvm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050057.hCdLpQvm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> clang diag: include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
--
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.
>> clang diag: include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>> clang diag: include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

