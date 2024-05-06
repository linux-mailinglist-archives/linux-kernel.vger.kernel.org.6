Return-Path: <linux-kernel+bounces-169870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02BE8BCEBC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030421C232D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8AF763F0;
	Mon,  6 May 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKd4qEEm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FDB1E4AE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001213; cv=none; b=W/cezmnd2EQiWZ8EjnrN8ylS1oOoQZdBAlJ1TA3esGOZXejOvxsWSIqFJJKkiPnDS+MRwq2ZSukJpiDJVeqX7Qv6RakOLxSeXOGTxNGNEwQYAe+FpRZTu95rhz1tEWM3t9iFJApjo8BgCZdsboz7zfaFS2UiVrV3/qGv/4+ebvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001213; c=relaxed/simple;
	bh=HyLdIy5f9/EBvRuI0GTtSPfaqq7n1U6/buN3znQZ3Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C84o8gnK0KDUDWFKX5hYSHJOKVxqNGd6oXo2F4reJmWMnuQKq4zD3FmglXRpE2J9fWMgEeNIjRHOWLlWUtf0wtQlrtlf6oyn35IIUlcSFdsgfnDNxaQdsD45zt+SuA4iN5B54SLlM8DTzZK/889x7JI0QEE2rDiJNLzJ/Pfm1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKd4qEEm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715001212; x=1746537212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HyLdIy5f9/EBvRuI0GTtSPfaqq7n1U6/buN3znQZ3Io=;
  b=PKd4qEEmq9CZN2SsRTKF44+6Np1cfJX1Cn4RfXcXwBp6WSkuWl1DMHcz
   nJkmJ5H5YXMp1L2PsBhnOMRliTmLt/zW1kdGy7JEkRF5pOKqleOkrZ4+C
   phn2dsiN48N+6jHrbuIt5PH/WKtEs9LAQOTtDwGIejzl+U9c0ylw+z/Dq
   6XFNG04TJw4G8lWxL1JRnn8jzTnmWA6r+ZAzA97zbhaF1QvUd5uMRzNK0
   aKgn/BdNRH0C2J8dz6Uq5Wk3ACdBBI+gpLKv49Cbiz17KN38ocmSzBX9R
   Q54noECcABExhjdJL+uAkFOvwTBagD5b6/axC0/gextUCmzlH6yCCV4hY
   w==;
X-CSE-ConnectionGUID: WHoJgrSARdeLSBNWkZC/vw==
X-CSE-MsgGUID: hvM0b2gdTJacd+UMbdB45A==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21296157"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="21296157"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 06:13:32 -0700
X-CSE-ConnectionGUID: YpuMv00uSNmVbCEvdrZxkg==
X-CSE-MsgGUID: DVFmBwS7RByM34XvkpThXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28256666"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 May 2024 06:13:26 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3y9k-0000gh-07;
	Mon, 06 May 2024 13:13:24 +0000
Date: Mon, 6 May 2024 21:12:45 +0800
From: kernel test robot <lkp@intel.com>
To: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	kevin-lu@ti.com, shenghao-ding@ti.com, navada@ti.com,
	13916275206@139.com, v-po@ti.com, niranjan.hy@ti.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	baojun.xu@ti.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v4 2/3] ALSA: hda/tas2781: Tas2781 hda driver for SPI
Message-ID: <202405062037.6HgeMiih-lkp@intel.com>
References: <20240430072544.1877-3-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430072544.1877-3-baojun.xu@ti.com>

Hi Baojun,

kernel test robot noticed the following build errors:

[auto build test ERROR on tiwai-sound/for-linus]
[also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.9-rc7 next-20240506]
[cannot apply to tiwai-sound/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baojun-Xu/ALSA-hda-tas2781-Add-tas2781-hda-driver-based-on-SPI/20240430-153305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-linus
patch link:    https://lore.kernel.org/r/20240430072544.1877-3-baojun.xu%40ti.com
patch subject: [PATCH v4 2/3] ALSA: hda/tas2781: Tas2781 hda driver for SPI
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240506/202405062037.6HgeMiih-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240506/202405062037.6HgeMiih-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405062037.6HgeMiih-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from sound/pci/hda/tas2781_hda_spi.c:15:
   In file included from include/linux/efi.h:20:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
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
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/hda/tas2781_hda_spi.c:466:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     466 |                 guard(mutex)(&tas_hda->priv->codec_lock);
         |                 ^
   include/linux/cleanup.h:164:2: note: expanded from macro 'guard'
     164 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:119:2: note: expanded from macro 'CLASS'
     119 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^
   <scratch space>:107:1: note: expanded from here
     107 | class_mutex_t
         | ^
>> sound/pci/hda/tas2781_hda_spi.c:471:2: error: cannot jump from switch statement to this case label
     471 |         default:
         |         ^
   sound/pci/hda/tas2781_hda_spi.c:466:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     466 |                 guard(mutex)(&tas_hda->priv->codec_lock);
         |                 ^
   include/linux/cleanup.h:164:15: note: expanded from macro 'guard'
     164 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:105:1: note: expanded from here
     105 | __UNIQUE_ID_guard511
         | ^
   sound/pci/hda/tas2781_hda_spi.c:462:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     462 |                 guard(mutex)(&tas_hda->priv->codec_lock);
         |                 ^
   include/linux/cleanup.h:164:15: note: expanded from macro 'guard'
     164 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:96:1: note: expanded from here
      96 | __UNIQUE_ID_guard510
         | ^
   sound/pci/hda/tas2781_hda_spi.c:465:2: error: cannot jump from switch statement to this case label
     465 |         case HDA_GEN_PCM_ACT_CLOSE:
         |         ^
   sound/pci/hda/tas2781_hda_spi.c:462:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     462 |                 guard(mutex)(&tas_hda->priv->codec_lock);
         |                 ^
   include/linux/cleanup.h:164:15: note: expanded from macro 'guard'
     164 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:96:1: note: expanded from here
      96 | __UNIQUE_ID_guard510
         | ^
   6 warnings and 2 errors generated.


vim +471 sound/pci/hda/tas2781_hda_spi.c

   454	
   455	static void tas2781_hda_playback_hook(struct device *dev, int action)
   456	{
   457		struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
   458	
   459		switch (action) {
   460		case HDA_GEN_PCM_ACT_OPEN:
   461			pm_runtime_get_sync(dev);
   462			guard(mutex)(&tas_hda->priv->codec_lock);
   463			tasdevice_spi_tuning_switch(tas_hda->priv, 0);
   464			break;
   465		case HDA_GEN_PCM_ACT_CLOSE:
   466			guard(mutex)(&tas_hda->priv->codec_lock);
   467			tasdevice_spi_tuning_switch(tas_hda->priv, 1);
   468			pm_runtime_mark_last_busy(dev);
   469			pm_runtime_put_autosuspend(dev);
   470			break;
 > 471		default:
   472			dev_dbg(tas_hda->priv->dev,
   473				"Playback action not supported: %d\n", action);
   474			break;
   475		}
   476	}
   477	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

