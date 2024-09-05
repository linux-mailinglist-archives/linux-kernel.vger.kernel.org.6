Return-Path: <linux-kernel+bounces-316149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4BF96CBCE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D051F27569
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354804A33;
	Thu,  5 Sep 2024 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjEfXjly"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940184C6E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496378; cv=none; b=SuZ+7QFpHNFoEcbWjTGmTOxBaTx43yKEquxrs00ClMZeEgX9GJDFRVj/WcKOS4J5YwOyPQ3wdYfLxtkEht8Tn90Ro/cHNS59bASuNeHVrMnR2+ORh0dU9t7C/pTgCm4WmdURN1+Xcrt+Ph9Gb7Bh7k13VYMbyeQK2AjHXnXXo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496378; c=relaxed/simple;
	bh=crazjdg71klOd1OiBadjY6+WBPbLnAkc9ES/WcRTk1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ctNRg9j3zJakpFa2Ui3U6WiL3LigCPVA8RezS/L+3yG2VkOFSkInz35KWvrtxS9+/wnH8Jkc3ZmS655bXfoa4JMiHJXZyYcIPzYYmMPMMhWFi1Wn6TDcmcC7C+vH6FHLjYdvo5kcE9hBn7VFHJuqjQg88Ek87Spv7YbmUMH7CoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjEfXjly; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725496376; x=1757032376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=crazjdg71klOd1OiBadjY6+WBPbLnAkc9ES/WcRTk1Q=;
  b=NjEfXjly+gwMdMhH/nqr7gsEdMzmewnqge1/MIsDF/G/9DSkUscABRU2
   +q6EtGLS9aOfrrxV8AuHZkAngDv1+siTIjDUMU20hBS9ZGkISqFDq5J/N
   6GQ00KuaeLA/7IN+6RHHQRr6dhADHjoWaAsFFCCX0mKTGhNeyvE81o0ld
   jjCxncchNUtEHEgd2CHzEItrVwfAslmfTTepFh6JeJPfhWPwSCwk9c6yc
   hJHW1RAwHhyozXpV6tcD1/rL+LRDrQYXU6BA3Zd8PXgLoBgoTDvRSIT7V
   vgzSFfO3UitCCq1y8nZP3kRrI0MoLpfl+o3oK5DHWFOrib6BpMbY1sRQp
   Q==;
X-CSE-ConnectionGUID: u8H8HGLgR8W2eslofGwymA==
X-CSE-MsgGUID: R28fmUmrTRq6vb/s40jDNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24140925"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="24140925"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 17:32:56 -0700
X-CSE-ConnectionGUID: G6CR/n1CQMm/dwrYVsNtYA==
X-CSE-MsgGUID: ETX3xN9XTNyeIDOFyhBrmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65434829"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 04 Sep 2024 17:32:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sm0Qc-0008jT-22;
	Thu, 05 Sep 2024 00:32:50 +0000
Date: Thu, 5 Sep 2024 08:32:46 +0800
From: kernel test robot <lkp@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/sti/sti_plane.h:32:28: error: bitwise operation
 between different enumeration types ('enum sti_plane_type' and 'enum
 sti_plane_id_of_type')
Message-ID: <202409050827.ygmp05pG-lkp@intel.com>
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
head:   c763c43396883456ef57e5e78b64d3c259c4babc
commit: 74bde7581df3e18061119e1b27b63d0a9ea57b7a drm/sti: Allow build with COMPILE_TEST=y
date:   3 months ago
config: powerpc-randconfig-002-20240905 (https://download.01.org/0day-ci/archive/20240905/202409050827.ygmp05pG-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409050827.ygmp05pG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409050827.ygmp05pG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/sti/sti_compositor.c:10:
   In file included from include/linux/io.h:14:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/sti/sti_compositor.c:20:
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
   6 errors generated.


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

