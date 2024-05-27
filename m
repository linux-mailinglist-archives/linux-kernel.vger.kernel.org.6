Return-Path: <linux-kernel+bounces-190794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E7B8D02C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A687299210
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D79E15F323;
	Mon, 27 May 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2+2f/4d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A81315ECE7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818452; cv=none; b=cuv8GdEyvyeLBSFEyqXJ9GH+KRES40nmHcFD94JeSob5fcJo2+UV91tv4ZHhh0Q1jopZzw4/xoo8oReg93c/ezRoE5kmXGe0KuKp948lDAvWuGlkSn8+JA3vwqc5VAgWRGNMFUPrsqqzdi5tpzwpf66RXnhFfEAwb5ev2Is7E0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818452; c=relaxed/simple;
	bh=0OMm8/z7GftneNWUSl3kPvSGTuazST1mZ9KF0uZCUIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cQDXenzk7APQg0GLaZod+gM+YMpsdjoCP9Rr/+ZsP7oB0HNh9inYxxq2gst1fNbrm0xdAtth6WXupgX4MqTN9NuWzYMS10eWportbwhhbpbOC0GLXzCreDXIdSyu3sl1G83GhQDSaNIJifamqziJeSSgApdwHTALrxu+lGMgEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2+2f/4d; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716818450; x=1748354450;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0OMm8/z7GftneNWUSl3kPvSGTuazST1mZ9KF0uZCUIQ=;
  b=S2+2f/4dhtFnWzJdOzLAX6zBDp7ysncUtyOgUKzS4GOvY2U/8BqI4lX/
   Rck0oEclOXqoY715Xs4Lk6LkiJbkNsMP7mfiGbPTbfdspC6p5CIraDyuk
   86DF0fXOrLHFvlE/I05LgxcXBKrL3CLAaWU4g65hWvI35fZKzwe+Vu0+U
   Jqi+Iv7WdbTFB1LeJY/2Xs64J+pKtEBNK9VakURrjozng/s66tKIUc62V
   Eto2ZaTzvtxUXapMyu9Jch2es7xHTvnJXhCPHHsCt7Z0CUTce/0vh1Mdk
   7h66qYnhbZCqmFrac6Tmt9EOw20LGrZFOg2akt9Qn334aU5R9k4ZLdQvy
   Q==;
X-CSE-ConnectionGUID: Yk3jCM8kRYe/nq9WSYXD7Q==
X-CSE-MsgGUID: OKxVEfJfQ6GVrpZoCN1ezA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16972888"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="16972888"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:00:49 -0700
X-CSE-ConnectionGUID: 2SHFR3+FSXafli5I2OCxXA==
X-CSE-MsgGUID: quyMVAsYRB+gBhFFPnHJ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34847800"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 27 May 2024 07:00:42 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBatz-000APt-2u;
	Mon, 27 May 2024 14:00:39 +0000
Date: Mon, 27 May 2024 22:00:39 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: drivers/gpu/drm/radeon/pptable.h:442:5: warning: 'counted_by' should
 not be applied to an array with element of unknown size because
 'ATOM_PPLIB_STATE_V2' (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type
 with a flexible array member. This will be an e...
Message-ID: <202405272123.cPznVWDF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
commit: 781d41fed19caf900c8405064676813dc9921d32 drm/radeon: silence UBSAN warning (v3)
date:   6 weeks ago
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240527/202405272123.cPznVWDF-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405272123.cPznVWDF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405272123.cPznVWDF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/radeon/radeon_device.c:30:
   In file included from include/linux/efi.h:20:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/radeon/radeon_device.c:48:
   In file included from drivers/gpu/drm/radeon/atom.h:165:
   In file included from drivers/gpu/drm/radeon/atombios.h:7980:
>> drivers/gpu/drm/radeon/pptable.h:442:5: warning: 'counted_by' should not be applied to an array with element of unknown size because 'ATOM_PPLIB_STATE_V2' (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type with a flexible array member. This will be an error in a future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]
     442 |     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.
--
   In file included from drivers/gpu/drm/radeon/r100.c:31:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/radeon/r100.c:42:
   In file included from drivers/gpu/drm/radeon/atom.h:165:
   In file included from drivers/gpu/drm/radeon/atombios.h:7980:
>> drivers/gpu/drm/radeon/pptable.h:442:5: warning: 'counted_by' should not be applied to an array with element of unknown size because 'ATOM_PPLIB_STATE_V2' (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type with a flexible array member. This will be an error in a future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]
     442 |     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/r100.c:43:10: fatal error: 'r100_reg_safe.h' file not found
      43 | #include "r100_reg_safe.h"
         |          ^~~~~~~~~~~~~~~~~
   2 warnings and 1 error generated.
--
   In file included from drivers/gpu/drm/radeon/r420.c:29:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/radeon/r420.c:36:
   In file included from drivers/gpu/drm/radeon/atom.h:165:
   In file included from drivers/gpu/drm/radeon/atombios.h:7980:
>> drivers/gpu/drm/radeon/pptable.h:442:5: warning: 'counted_by' should not be applied to an array with element of unknown size because 'ATOM_PPLIB_STATE_V2' (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type with a flexible array member. This will be an error in a future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]
     442 |     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/r420.c:38:10: fatal error: 'r420_reg_safe.h' file not found
      38 | #include "r420_reg_safe.h"
         |          ^~~~~~~~~~~~~~~~~
   2 warnings and 1 error generated.
--
   In file included from drivers/gpu/drm/radeon/rs600.c:40:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/radeon/rs600.c:47:
   In file included from drivers/gpu/drm/radeon/atom.h:165:
   In file included from drivers/gpu/drm/radeon/atombios.h:7980:
>> drivers/gpu/drm/radeon/pptable.h:442:5: warning: 'counted_by' should not be applied to an array with element of unknown size because 'ATOM_PPLIB_STATE_V2' (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type with a flexible array member. This will be an error in a future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]
     442 |     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/rs600.c:51:10: fatal error: 'rs600_reg_safe.h' file not found
      51 | #include "rs600_reg_safe.h"
         |          ^~~~~~~~~~~~~~~~~~
   2 warnings and 1 error generated.
--
   In file included from drivers/gpu/drm/radeon/rv515.c:33:
   In file included from include/drm/drm_file.h:39:
   In file included from include/drm/drm_prime.h:37:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/radeon/rv515.c:35:
   In file included from drivers/gpu/drm/radeon/atom.h:165:
   In file included from drivers/gpu/drm/radeon/atombios.h:7980:
>> drivers/gpu/drm/radeon/pptable.h:442:5: warning: 'counted_by' should not be applied to an array with element of unknown size because 'ATOM_PPLIB_STATE_V2' (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type with a flexible array member. This will be an error in a future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]
     442 |     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/rv515.c:38:10: fatal error: 'rv515_reg_safe.h' file not found
      38 | #include "rv515_reg_safe.h"
         |          ^~~~~~~~~~~~~~~~~~
   2 warnings and 1 error generated.


vim +442 drivers/gpu/drm/radeon/pptable.h

   437	
   438	typedef struct _StateArray{
   439	    //how many states we have 
   440	    UCHAR ucNumEntries;
   441	    
 > 442	    ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
   443	}StateArray;
   444	
   445	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

