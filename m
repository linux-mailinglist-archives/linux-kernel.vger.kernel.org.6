Return-Path: <linux-kernel+bounces-425254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E89DBF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5D2164893
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C694156872;
	Fri, 29 Nov 2024 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFpQYX/6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C741547FD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732861099; cv=none; b=A5YD5+hI/IjYHEuIUJRdYrvMODM4A2oZpxfrlNu0igG4vJq24zPdMlS29UbyKhYE89+Mx65kOE0RGHx0E0viX2VQmfAOzowUTqNEt9vTBuCPxb58nu1A2zalwMq44JW3iWDjaOh1P6Rt4QszoPNJS5krWJYiAMlSK0jC5V8UPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732861099; c=relaxed/simple;
	bh=iMPIfA9ANl+v7O0le/4bU24KPo8+fB8W/pxeB/6YJ68=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T8n7rIO1BCN4ngwjm+dhc1ySgU8+5iyx3hxj3QKNuZbuG01/nfRx9khLWrz+UtDQIKrYLfTbODft0v7wfJpeALS53czNdZQVXfJLQlHUprKvxojqXTCBSdPndpVAXh8LtHa/I9QMUuLFwYae6BzGzkFWGPuPvbJ2WYtE8+KW5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFpQYX/6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732861098; x=1764397098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iMPIfA9ANl+v7O0le/4bU24KPo8+fB8W/pxeB/6YJ68=;
  b=EFpQYX/6qLuNHVBkibzS5cpeTuGySa+3mDyhbh1Af6yRK6PmGke4CI6W
   djPM4pZflHfcoPbDvSHLz8ceJ6M+BApW6mAnj3LrpJCP9IljThcN7/I0B
   blBqkdm35j0Bnr+G5uBqR/fEuEFsJdR8xRr/cqN/jbKS5s+e07uxucU/4
   ojQ79wQWQp5UzTLFjgAX9RdryzWjo286i4/I13yJCnGP+fkqJqPK69oG1
   MeTTjmqfZVPGw3AP0gv/M6Ifumn+ALm49x1kl7afpzKlHuSNEXuQFXlVM
   okF/hf+O2uRCnVu5hRUsLSDwPxhUB5PNXlBU9ujaJSfkTMUqDgqVflhuJ
   Q==;
X-CSE-ConnectionGUID: D4G9WyReQIq4YSVe99zB8g==
X-CSE-MsgGUID: +aFDBgjLQBSVMFw6AN4tvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33033111"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="33033111"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 22:18:17 -0800
X-CSE-ConnectionGUID: 5rXlzFbITsuhfJlV/+cTbg==
X-CSE-MsgGUID: nacL33gWR/SOWFI9tlmPmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="96830665"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Nov 2024 22:18:16 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGuKT-00003l-22;
	Fri, 29 Nov 2024 06:18:13 +0000
Date: Fri, 29 Nov 2024 14:17:49 +0800
From: kernel test robot <lkp@intel.com>
To: Ville =?unknown-8bit?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/sti/sti_plane.h:32:28: error: bitwise operation
 between different enumeration types ('enum sti_plane_type' and 'enum
 sti_plane_id_of_type')
Message-ID: <202411291428.aed75DGC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ville,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7af08b57bcb9ebf78675c50069c54125c0a8b795
commit: 74bde7581df3e18061119e1b27b63d0a9ea57b7a drm/sti: Allow build with COMPILE_TEST=y
date:   6 months ago
config: arm64-randconfig-r112-20241119 (https://download.01.org/0day-ci/archive/20241129/202411291428.aed75DGC-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241129/202411291428.aed75DGC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411291428.aed75DGC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/sti/sti_mixer.c:14:
   In file included from drivers/gpu/drm/sti/sti_compositor.h:15:
   In file included from drivers/gpu/drm/sti/sti_mixer.h:12:
   In file included from include/drm/drm_crtc.h:32:
   In file included from include/drm/drm_modes.h:33:
   In file included from include/drm/drm_connector.h:32:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/sti/sti_mixer.c:14:
   In file included from drivers/gpu/drm/sti/sti_compositor.h:15:
   In file included from drivers/gpu/drm/sti/sti_mixer.h:17:
>> drivers/gpu/drm/sti/sti_plane.h:32:28: error: bitwise operation between different enumeration types ('enum sti_plane_type' and 'enum sti_plane_id_of_type') [-Werror,-Wenum-enum-conversion]
      32 |         STI_GDP_0       = STI_GDP | STI_ID_0,
         |                           ~~~~~~~ ^ ~~~~~~~~
   drivers/gpu/drm/sti/sti_plane.h:33:28: error: bitwise operation between different enumeration types ('enum sti_plane_type' and 'enum sti_plane_id_of_type') [-Werror,-Wenum-enum-conversion]
      33 |         STI_GDP_1       = STI_GDP | STI_ID_1,
         |                           ~~~~~~~ ^ ~~~~~~~~
   drivers/gpu/drm/sti/sti_plane.h:34:28: error: bitwise operation between different enumeration types ('enum sti_plane_type' and 'enum sti_plane_id_of_type') [-Werror,-Wenum-enum-conversion]
      34 |         STI_GDP_2       = STI_GDP | STI_ID_2,
         |                           ~~~~~~~ ^ ~~~~~~~~
   drivers/gpu/drm/sti/sti_plane.h:35:28: error: bitwise operation between different enumeration types ('enum sti_plane_type' and 'enum sti_plane_id_of_type') [-Werror,-Wenum-enum-conversion]
      35 |         STI_GDP_3       = STI_GDP | STI_ID_3,
         |                           ~~~~~~~ ^ ~~~~~~~~
   drivers/gpu/drm/sti/sti_plane.h:36:28: error: bitwise operation between different enumeration types ('enum sti_plane_type' and 'enum sti_plane_id_of_type') [-Werror,-Wenum-enum-conversion]
      36 |         STI_HQVDP_0     = STI_VDP | STI_ID_0,
         |                           ~~~~~~~ ^ ~~~~~~~~
   10 errors generated.


vim +32 drivers/gpu/drm/sti/sti_plane.h

871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  30  
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  31  enum sti_plane_desc {
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31 @32  	STI_GDP_0       = STI_GDP | STI_ID_0,
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  33  	STI_GDP_1       = STI_GDP | STI_ID_1,
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  34  	STI_GDP_2       = STI_GDP | STI_ID_2,
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  35  	STI_GDP_3       = STI_GDP | STI_ID_3,
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  36  	STI_HQVDP_0     = STI_VDP | STI_ID_0,
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  37  	STI_CURSOR      = STI_CUR,
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  38  	STI_BACK        = STI_BCK
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  39  };
871bcdfea68560 drivers/gpu/drm/sti/sti_drm_plane.h Vincent Abriou 2015-07-31  40  

:::::: The code at line 32 was first introduced by commit
:::::: 871bcdfea68560991bd650406e47a801ab9d635d drm/sti: code clean up

:::::: TO: Vincent Abriou <vincent.abriou@st.com>
:::::: CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

