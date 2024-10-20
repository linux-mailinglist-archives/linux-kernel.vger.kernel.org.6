Return-Path: <linux-kernel+bounces-373222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD69A53EE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9511C20AC2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF6191F7C;
	Sun, 20 Oct 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlVGDAFe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF519259B
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729425464; cv=none; b=VN72RNU29E/3RMbZB1VtjIAaxdrdXqR+tk0Wfk0EAP7RZF0iQPwGYxjp0wGIuU9o1mq8dNKcF/jUqdrn8p6t8+WfoNVXDi2z6+rjlq2st3E8gCaq2JcyLtfU132mV4buCH7yZPQIApKOkNxGWv8LuaY43zdEz/smkOuADfUFTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729425464; c=relaxed/simple;
	bh=NusKdUyvj/EWpbxU2J1ZIMoe76mgSStPu5zFOKCDzTo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OymEJBXpkhMwHVR4zalxVv5RaAOo4Evb+7jz9Qu+Qyt2wRDcF6SdhYDWkaDTTXtLMF9icRdYYo05u3m9oCnYl9KiqwVotQR36A5XqHMzzlwxtBBjQZYL4JiKV3K91YP45FWwByobNusnHizERPQrb34rVgKhuLwxDjsc9ykuVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlVGDAFe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729425462; x=1760961462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NusKdUyvj/EWpbxU2J1ZIMoe76mgSStPu5zFOKCDzTo=;
  b=PlVGDAFeoU4PS6qHktlsij82dO5aizryxJV4hUh/bIaN7XmLBHdsx8Tg
   aqSKdgd53R8to/OBjO6I0uBOKC4+TmVUCaon1x4W84tha1tAnfTsBgJ29
   QFoZy8z3zp8ajvmBAxIe5E7fQy4xfBZGR6mf4/2PjbG+hcmjrcp6Lr2am
   sqodv7HqJJdoQKd7Qgmmxdu9tUnvNs/UjWvqyHkTT8Ak5Dt4dmzyZGxbK
   PYKqhICRYLjHRVhD/tGTtnMvVdXslj5vmQlJ0fjHiFP6CSHO1FxFDvSX6
   WbkW6U3DY84XRXvbH8VRZvQ3PNA9RUpVQtiiutlbdI1Ex5SkRJJvZfJUh
   Q==;
X-CSE-ConnectionGUID: uAchxeA8QduYglFofK8yWA==
X-CSE-MsgGUID: msUKs5MPQiKvwVIdJF0ZSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40037177"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40037177"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 04:57:42 -0700
X-CSE-ConnectionGUID: v6NiQ6sBQ+qqRS+IjZIsrQ==
X-CSE-MsgGUID: pdnp1tNOT0Wiu3T4XRR+kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84091136"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 20 Oct 2024 04:57:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2UZ0-000QGD-2U;
	Sun, 20 Oct 2024 11:57:38 +0000
Date: Sun, 20 Oct 2024 19:56:49 +0800
From: kernel test robot <lkp@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/sti/sti_plane.h:32:28: error: bitwise operation
 between different enumeration types ('enum sti_plane_type' and 'enum
 sti_plane_id_of_type')
Message-ID: <202410201951.B9q3AL5V-lkp@intel.com>
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
head:   f9e4825524aaf28af6b2097776616f27c31d6847
commit: 74bde7581df3e18061119e1b27b63d0a9ea57b7a drm/sti: Allow build with COMPILE_TEST=y
date:   5 months ago
config: powerpc64-randconfig-001-20241019 (https://download.01.org/0day-ci/archive/20241020/202410201951.B9q3AL5V-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201951.B9q3AL5V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201951.B9q3AL5V-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/sti/sti_vid.c:8:
   In file included from include/drm/drm_debugfs.h:38:
   In file included from include/drm/drm_gpuvm.h:34:
   In file included from include/drm/drm_gem.h:42:
   In file included from include/drm/drm_vma_manager.h:27:
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
   In file included from drivers/gpu/drm/sti/sti_vid.c:12:
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
   9 errors generated.


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

