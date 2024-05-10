Return-Path: <linux-kernel+bounces-175597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA8C8C2237
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9976283528
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E5C1311A9;
	Fri, 10 May 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZ5A5NmG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206C55C3B;
	Fri, 10 May 2024 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337247; cv=none; b=ZQfsEwDtmhlArChx+HGGqPEuwoA7NKsmGqbbJZZnU+HLkQ3lJyrpgeX0oqfCz19v4xAGW7xPT/fAwNlkz0MXs4aOeKO+xI6Acj1dl6tT9HykmIS9jKHJh617EzM1gDOmr0ccq1mkt570JyuxlzSmROjtAQrk2Gy3dXfBqYyGqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337247; c=relaxed/simple;
	bh=X0ZOJpUlqcwr+U8LRJn7Zd0g5ybOZZdwIG5yRD8/Ono=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw4EWhW/74Lv6BAhrr9mVMG1dIRom0LosaqTPPihDD1Xtys9/9/opbVDdkuuwgc5HgF6gmhKLndfPEEkDJWp3RsG++bKQB+VuCEdkzKnCjilDh7a3mETNy5uKQ22XMRw0o2UIs5lq7lTrBEyVF6307Wotx23o28ZDtPageoMbtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZ5A5NmG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715337246; x=1746873246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0ZOJpUlqcwr+U8LRJn7Zd0g5ybOZZdwIG5yRD8/Ono=;
  b=MZ5A5NmGI1EbTYICWcaUGpzeh2FN+heAwEVJySkjlUqDiw/ApsFSGtbX
   DSe2jw4QqLYE4PbeM6bUgcFZS3LEIWggactF/Yq6eaCqgmsS/hSxDW8Om
   mPCrc6N12ZJCQlZReFPjl8Oe4jByEYe5HFFaC+qU9szJgy0beilFDX+Jn
   VSaUhyWNd1WFugVYjp8y8hCw4PR74lEF/lIv31axv3y2IUw6/fJyfK3PW
   FtDKVOwX8qQXzJlq9oS2OuiDDORXKSiVI99N/8+MkYEZbHBvpvruU+L/e
   rtlArU4M8KwnnYv39DaJjPCeeQabQ85ko7bQcURWllu74b7OIBUj/j2nt
   w==;
X-CSE-ConnectionGUID: YmV3jzuOS9uXLNxbiJAGWA==
X-CSE-MsgGUID: D15JaaiFSRWx668yDGB5Og==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22709432"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="22709432"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:34:05 -0700
X-CSE-ConnectionGUID: yXrnVpWQRJ22BfscS7ipVg==
X-CSE-MsgGUID: n46WO3hYSjiRU/eZffXjfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="52779431"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 May 2024 03:34:01 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5NZe-0005zz-2e;
	Fri, 10 May 2024 10:33:58 +0000
Date: Fri, 10 May 2024 18:33:43 +0800
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
Message-ID: <202405101852.gDDWbzsx-lkp@intel.com>
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
config: arm-wpcm450_defconfig (https://download.01.org/0day-ci/archive/20240510/202405101852.gDDWbzsx-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101852.gDDWbzsx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101852.gDDWbzsx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/reset/reset-npcm.c: In function 'npcm_clock_adev_release':
   drivers/reset/reset-npcm.c:391:9: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
     391 |         kfree(rdev);
         |         ^~~~~
         |         vfree
   drivers/reset/reset-npcm.c: In function 'npcm_clock_adev_alloc':
   drivers/reset/reset-npcm.c:400:16: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
     400 |         rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
         |                ^~~~~~~
         |                vzalloc
>> drivers/reset/reset-npcm.c:400:14: warning: assignment to 'struct npcm_clock_adev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     400 |         rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
         |              ^
   cc1: some warnings being treated as errors


vim +400 drivers/reset/reset-npcm.c

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

