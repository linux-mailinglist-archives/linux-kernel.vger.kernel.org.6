Return-Path: <linux-kernel+bounces-175662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D268C2353
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45655B23657
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE2A172BBC;
	Fri, 10 May 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXpj89kT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6E1649CF;
	Fri, 10 May 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340369; cv=none; b=g2YknDLfkQ8Cs2NhYQwMT97iNY4jEt4nADxkA6AjruXkBMd8ulcQMwHgudrkQzhurfYQ98aifEhJrgz04bL4DtRTWhAcgJqRWScAKOGnevZlEP4gc7PrOkPYCdacc7MWChiqlUPzbuwBNQFKs+/spuG/Tg7n/wJK4dz8BJrTbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340369; c=relaxed/simple;
	bh=X8Q8fkJcctofAMJGn3mjJGBdHGpHACK6lBQIiokJ8Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPXWfbLGF3jgRxHapPnzBlsD15U6nuevlZIXQM1b4fpYKO7wGkm1f9SfRbqvdxY3ToCMDXv2qzqW/xxUaaXuoeXtGjyAPPcidughAX4faH/lWq4pWItc3shlvcvhFVnYXM20E7g1r5x+h+N3S1gM9clln2FfktmmKLfvZv6u3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXpj89kT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340368; x=1746876368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X8Q8fkJcctofAMJGn3mjJGBdHGpHACK6lBQIiokJ8Hc=;
  b=HXpj89kTFdfhU83u7VCLaWI7N/WZZIa/TYEY3wdSE/E2LizW94kcVvZ7
   0Awx8d3lprB0lCD4maouDDDfxjkUOGudHryzeN6aREyM6f28rgwGM2jcx
   TqQfWWTBJwOsXa5rhyH1huRp7leaOlriqURBUwDvx5SYeqjEdDjMcuaJo
   fiPT88hat1PJPDauOVRd3AJNLeGa/1XJgvyufqQoNgexE7W7C9zbovUHR
   g+bbsp/m5UuV73zpXN1etqNbOzEGC7SsbeWbaq6sBgKR9zqVBNazS0wl/
   gw21WhEp6C+2OWZ9mOb9vJxNw9Osla3IP5gHTun75zS1Lnu9QIPqJPZSu
   A==;
X-CSE-ConnectionGUID: Tgm3llhMRHi78V4eo73Qfg==
X-CSE-MsgGUID: 4H/cnT10TOC1+uF4IZ9WZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11442912"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11442912"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:26:08 -0700
X-CSE-ConnectionGUID: 7lw1taQOQbGuQrWQRq9ZYg==
X-CSE-MsgGUID: CLH43sCVSzqVL1gLyg/3Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34235748"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 May 2024 04:26:04 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5OO1-00063V-0t;
	Fri, 10 May 2024 11:26:01 +0000
Date: Fri, 10 May 2024 19:25:56 +0800
From: kernel test robot <lkp@intel.com>
To: Tomer Maimon <tmaimon77@gmail.com>, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v24 2/4] reset: npcm: register npcm8xx clock auxiliary
 bus device
Message-ID: <202405101846.avdHTXi3-lkp@intel.com>
References: <20240509192411.2432066-3-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509192411.2432066-3-tmaimon77@gmail.com>

Hi Tomer,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on pza/reset/next linus/master v6.9-rc7 next-20240510]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/dt-bindings-reset-npcm-add-clock-properties/20240510-072622
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240509192411.2432066-3-tmaimon77%40gmail.com
patch subject: [PATCH v24 2/4] reset: npcm: register npcm8xx clock auxiliary bus device
config: i386-buildonly-randconfig-002-20240510 (https://download.01.org/0day-ci/archive/20240510/202405101846.avdHTXi3-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101846.avdHTXi3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101846.avdHTXi3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/reset/reset-npcm.c: In function 'npcm_clock_adev_release':
   drivers/reset/reset-npcm.c:391:2: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
     kfree(rdev);
     ^~~~~
     vfree
   drivers/reset/reset-npcm.c: In function 'npcm_clock_adev_alloc':
   drivers/reset/reset-npcm.c:400:9: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
     rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
            ^~~~~~~
            vzalloc
>> drivers/reset/reset-npcm.c:400:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
          ^
   cc1: some warnings being treated as errors


vim +400 drivers/reset/reset-npcm.c

   385	
   386	static void npcm_clock_adev_release(struct device *dev)
   387	{
   388		struct auxiliary_device *adev = to_auxiliary_dev(dev);
   389		struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
   390	
 > 391		kfree(rdev);
   392	}
   393	
   394	static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_data, char *clk_name)
   395	{
   396		struct npcm_clock_adev *rdev;
   397		struct auxiliary_device *adev;
   398		int ret;
   399	
 > 400		rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
   401		if (!rdev)
   402			return ERR_PTR(-ENOMEM);
   403	
   404		rdev->base = rst_data->base;
   405	
   406		adev = &rdev->adev;
   407		adev->name = clk_name;
   408		adev->dev.parent = rst_data->dev;
   409		adev->dev.release = npcm_clock_adev_release;
   410		adev->id = 555u;
   411	
   412		ret = auxiliary_device_init(adev);
   413		if (ret) {
   414			kfree(adev);
   415			return ERR_PTR(ret);
   416		}
   417	
   418		return adev;
   419	}
   420	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

