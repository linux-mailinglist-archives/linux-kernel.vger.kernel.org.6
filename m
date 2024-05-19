Return-Path: <linux-kernel+bounces-183184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A73D8C95B1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 19:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F15281EBD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD650A93;
	Sun, 19 May 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiz3AkC2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612F1F5FD
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716141482; cv=none; b=LOPSKwLkC2X/eWiJTDAegO6IhyBFwsG9/jqEial42EwSjGBJzfayh5wqKUQaZnmeWOPB6J+xYA9AC9rnAVWl4WgYtEJz5xpDMUhBGUEFKfaMU5oMyHggOQJivmWXIJZ0VpRh3zGrOjy9gBl78ET0HZUT66JUbLySgWNT6w1Dvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716141482; c=relaxed/simple;
	bh=ZqfuvKtxoWyUPyoUyQdKOfjpNUI+NCOUWwVaQ/3kZ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+x2xtCFrdVhRcJOfncMwb05QDOgJL0sl/7cHQAkkdK4+6pfoR7IPUUw42sXL6JbbGLfSsitu3C/HZojHhbliBQklt7Wfx0yGE/Zgb0PCmWxItJfLhrF2Z/hSVNYfNuKX4vi+zbyX5VaUppvP5RAeBoomwuuC2CWDCP13n5MlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiz3AkC2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716141480; x=1747677480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZqfuvKtxoWyUPyoUyQdKOfjpNUI+NCOUWwVaQ/3kZ/E=;
  b=aiz3AkC2NqAYyg9bFmZuQQ8gleCf/j2L7rGpLqdOsdtiQSS8ARo94png
   ouTAtJfthtTCWDC0UvEwp2xa6wszUYHdHqhyUPKIyTGSXxTqpHCijJGLZ
   Pih+0ltq+Z7oSgXpQa0KgmLCvZ7n+uvVkfYzdE/k0N8/fDP8smyt+C0sh
   WDMvI7MDcbjBvKKRBSE+pPTTJYzhdXWdk1zvUWmuSY7ZwNo+XGw59bhH8
   Ffy2kUOi3Ffm+uzKrcRjRV0a4qMgIGW2usFUsg523YZYwuGEbZsYNyeZ0
   ildII+wSzGJfEO25FPH2xyNRnJL685w95VGhH2etXGgTisYB1VlIUDXdL
   Q==;
X-CSE-ConnectionGUID: JjTIajLHRuyxD0yZO16QFA==
X-CSE-MsgGUID: SUJa3253SEuII77Dtn2C5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="22936247"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="22936247"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 10:58:00 -0700
X-CSE-ConnectionGUID: 6jNpzaQFR5uhukJ9AM/VoQ==
X-CSE-MsgGUID: zeNWjm6OQtKgrlPiiTlzcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="36723411"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 19 May 2024 10:57:55 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8knB-00044O-1E;
	Sun, 19 May 2024 17:57:53 +0000
Date: Mon, 20 May 2024 01:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de
Cc: oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	kevin-lu@ti.com, shenghao-ding@ti.com, navada@ti.com,
	13916275206@139.com, v-po@ti.com, niranjan.hy@ti.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	baojun.xu@ti.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v5 1/1] ALSA: hda/tas2781: Add tas2781 hda driver based
 on SPI
Message-ID: <202405200105.BWxmtco7-lkp@intel.com>
References: <20240519150433.760-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519150433.760-2-baojun.xu@ti.com>

Hi Baojun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.9 next-20240517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baojun-Xu/ALSA-hda-tas2781-Add-tas2781-hda-driver-based-on-SPI/20240519-230843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240519150433.760-2-baojun.xu%40ti.com
patch subject: [PATCH v5 1/1] ALSA: hda/tas2781: Add tas2781 hda driver based on SPI
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240520/202405200105.BWxmtco7-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405200105.BWxmtco7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405200105.BWxmtco7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/pci/hda/tas2781_hda_spi.c: In function 'tas2781_runtime_suspend':
>> sound/pci/hda/tas2781_hda_spi.c:1124:16: warning: unused variable 'ret' [-Wunused-variable]
    1124 |         int i, ret;
         |                ^~~
>> sound/pci/hda/tas2781_hda_spi.c:1124:13: warning: unused variable 'i' [-Wunused-variable]
    1124 |         int i, ret;
         |             ^
   sound/pci/hda/tas2781_hda_spi.c: In function 'tas2781_runtime_resume':
   sound/pci/hda/tas2781_hda_spi.c:1143:16: warning: unused variable 'ret' [-Wunused-variable]
    1143 |         int i, ret;
         |                ^~~
   sound/pci/hda/tas2781_hda_spi.c:1143:13: warning: unused variable 'i' [-Wunused-variable]
    1143 |         int i, ret;
         |             ^


vim +/ret +1124 sound/pci/hda/tas2781_hda_spi.c

  1120	
  1121	static int tas2781_runtime_suspend(struct device *dev)
  1122	{
  1123		struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
> 1124		int i, ret;
  1125	
  1126		guard(mutex)(&tas_hda->priv->codec_lock);
  1127	
  1128		if (tas_hda->priv->playback_started) {
  1129			tasdevice_spi_tuning_switch(tas_hda->priv, 1);
  1130			tas_hda->priv->playback_started = false;
  1131		}
  1132	
  1133		tas_hda->priv->cur_book = -1;
  1134		tas_hda->priv->cur_prog = -1;
  1135		tas_hda->priv->cur_conf = -1;
  1136	
  1137		return 0;
  1138	}
  1139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

