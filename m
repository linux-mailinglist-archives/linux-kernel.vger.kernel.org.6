Return-Path: <linux-kernel+bounces-415110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE3C9D31A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6790AB234C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97741D555;
	Wed, 20 Nov 2024 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHYgohk7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B760EAF9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065091; cv=none; b=c8AeCyDX7uwPrfzHb5dFAitD5OqMiHwFah/0lw32mPIovb1pn63wmJVy74LrtrIoekUt9Z/AagdQtmRbHxjjBgHbPNvj3lS/JW0PpvvjCVwoLEt3zPajcl/p/+aRxKFvy1ojbFMCEHeKR+BurJCGTnBKyxghWFWB5gjAiBeIMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065091; c=relaxed/simple;
	bh=s1AtK4isWjlSgEFpaZddFlWdZBx350egqJuh9YFfBzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M/QBVs2MA10BJVSM262otJo9py3ZclSuncwbbaBCC9au39Sjy0vCEW4eFHt3OSA8Qn7GIG/i62F0VMUWWFUKwgp3cWDovoGLQg+8S7gnXhDVe0LrlVhS7LuraBbxdHyXJJJiD1hkrz9p7wrUj4v7jpElttr1OIvkZ2ghRQnlpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHYgohk7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065089; x=1763601089;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s1AtK4isWjlSgEFpaZddFlWdZBx350egqJuh9YFfBzA=;
  b=IHYgohk7WAp3oGS/7LD4AF4dt/+wCVbYgMOiLoNSkjJIWgTE8YGfYSZP
   LyhgLOtgHtMpZEtJoR3SpFygKVtI6lNDzCDDu+RMs+y8495uRdq6wXFzh
   eYuTOEB81tCGdTy10j4Pa75wYUKwb0wLC0F+HXrSexb9IYNg0yAFmTJs5
   plYQm9k6HjGm8A3MWVsfk86F1XlKnDkVfc8ZN2CTB1g0L8DElu2bAUlr6
   7SCKMcbWjbSfq9q7bjwl3+I37qG8ezu/c0EZPBISWxBQMz8T3KrH0vYfD
   gcg51n9N1W1br3vUdRHBZ/goYpfzowRf5L1sht9eypryvaLuPMeaazPGq
   g==;
X-CSE-ConnectionGUID: qcjkulluRGeH1zJLlpO98w==
X-CSE-MsgGUID: TmoSKDDLSw+Ks7+h6De1Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42612939"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42612939"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:29 -0800
X-CSE-ConnectionGUID: 5OKavTQkQ6mopYXMGYv/Jw==
X-CSE-MsgGUID: 00UrJlEZQ+ikrM1mK0GFUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813508"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Nov 2024 17:11:28 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDZFd-0000OH-1v;
	Wed, 20 Nov 2024 01:11:25 +0000
Date: Wed, 20 Nov 2024 09:11:06 +0800
From: kernel test robot <lkp@intel.com>
To: Ville =?unknown-8bit?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/sti/sti_plane.h:32:28: error: bitwise operation
 between different enumeration types ('enum sti_plane_type' and 'enum
 sti_plane_id_of_type')
Message-ID: <202411191605.CQmfnKj1-lkp@intel.com>
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
head:   158f238aa69d91ad74e535c73f552bd4b025109c
commit: 74bde7581df3e18061119e1b27b63d0a9ea57b7a drm/sti: Allow build with COMPILE_TEST=y
date:   6 months ago
config: arm64-randconfig-r112-20241119 (https://download.01.org/0day-ci/archive/20241119/202411191605.CQmfnKj1-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241119/202411191605.CQmfnKj1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411191605.CQmfnKj1-lkp@intel.com/

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

