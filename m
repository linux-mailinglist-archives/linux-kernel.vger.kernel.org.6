Return-Path: <linux-kernel+bounces-256647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A647D935178
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E4C1C229D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE70A145A08;
	Thu, 18 Jul 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1CxCrZK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410641459FB;
	Thu, 18 Jul 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325894; cv=none; b=f4T54n88OqQHIdImT9n+0Qj9fUZVgHn2QBm5C+q9uGPL1eRlUnBH4+sg/k6+7OwMtH46L4x7Sm6dDeMPKJpRvQO70HocjUwphE/K+u4p0Tv75tS0B1lRt1PT5+daTk7Kpey2z+vbeP1/Hz8dNtVhS0FoLqv6jSEv1YIsVp+JgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325894; c=relaxed/simple;
	bh=HMcEiL85QIpDgR55RY/AUkCj+r3L9aAc6hf/4mw/umM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDvQbzRHqf9qrAGkmsoreaeSULrzxI64LRo4A0K8Qq/rKaSKf2ndBwDDbGpQii4jcABYsbBHVAqMA5uEc9gruX1E873DQEw0xGZhhQng1OJRCVbklVHVUPNa/uvW9XDobw5h8RJ+NywV5ALRGFGv/b8aOxFMvicoiDETun2SeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1CxCrZK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721325892; x=1752861892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HMcEiL85QIpDgR55RY/AUkCj+r3L9aAc6hf/4mw/umM=;
  b=j1CxCrZKEUaPzQIulDIfhN6HvuQ0H4nyFoEhXpv25hcX44w24JuAe3Zl
   iKHWf7QjTZxj07Njrn0Ckfxqyx1AxsNHqQcDUm4Ng4ZbN3Wd9fa94MmxK
   qluu1JyMc0sCztvcP51QJnGqzVl7x5nxcG9ruimHyn1S1oUCuDQfcnKvT
   ACH4AfLsCXBdyog6/wi5hM5LY0PByKY7Rh2H0WuAGwJV8iMn5m4fDsHWA
   cS2ZlgNlTAPwSP9lriHp2lOP7Wv3q56++RUTxhRATILjkAt3ITs+SmMQD
   EyEmV/UYlwq3M1FKbRqFrhV0omNhH8JBe/Tx1uUsSiDwdtCt+kdu/CmEw
   g==;
X-CSE-ConnectionGUID: r1LnUjwgQdihhnlv25iQ3g==
X-CSE-MsgGUID: 7MPU7S2CRruVdu3kB6dlag==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="22718988"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="22718988"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 11:04:51 -0700
X-CSE-ConnectionGUID: PkXV4fQ2TvKoW9NgCDXuyA==
X-CSE-MsgGUID: TTq7uPu4SUuvh0VA+uoqXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="55142933"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Jul 2024 11:04:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUVUk-000hUk-2E;
	Thu, 18 Jul 2024 18:04:46 +0000
Date: Fri, 19 Jul 2024 02:04:41 +0800
From: kernel test robot <lkp@intel.com>
To: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Cryolitia PukNgae <Cryolitia@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>, Yao Zi <ziyao@disroot.org>,
	Marcin =?utf-8?Q?Str=C4=85gowski?= <marcin@stragowski.com>
Subject: Re: [PATCH v4 1/2] hwmon: add GPD devices sensor driver
Message-ID: <202407190105.hnZaypzI-lkp@intel.com>
References: <20240718-gpd_fan-v4-1-116e5431a9fe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718-gpd_fan-v4-1-116e5431a9fe@gmail.com>

Hi Cryolitia,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d67978318827d06f1c0fa4c31343a279e9df6fde]

url:    https://github.com/intel-lab-lkp/linux/commits/Cryolitia-PukNgae-via-B4-Relay/hwmon-add-GPD-devices-sensor-driver/20240718-104420
base:   d67978318827d06f1c0fa4c31343a279e9df6fde
patch link:    https://lore.kernel.org/r/20240718-gpd_fan-v4-1-116e5431a9fe%40gmail.com
patch subject: [PATCH v4 1/2] hwmon: add GPD devices sensor driver
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240719/202407190105.hnZaypzI-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407190105.hnZaypzI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407190105.hnZaypzI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/gpd-fan.c:153:35: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     153 |                 .driver_data    = &gpd_win_mini_quirk,
         |                                   ^
   drivers/hwmon/gpd-fan.c:162:35: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     162 |                 .driver_data    = &gpd_win4_quirk,
         |                                   ^
   drivers/hwmon/gpd-fan.c:171:35: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     171 |                 .driver_data    = &gpd_wm2_quirk,
         |                                   ^
   drivers/hwmon/gpd-fan.c:181:35: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     181 |                 .driver_data    = &gpd_wm2_quirk,
         |                                   ^


vim +/const +153 drivers/hwmon/gpd-fan.c

   144	
   145	static const struct dmi_system_id gpd_devices[] = {
   146		{
   147			// GPD Win Mini
   148			// GPD Win Mini with AMD Ryzen 8840U
   149			.matches	= {
   150						DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
   151						DMI_MATCH(DMI_PRODUCT_NAME, "G1617-01")
   152					},
 > 153			.driver_data	= &gpd_win_mini_quirk,
   154		},
   155		{
   156			// GPD Win 4 with AMD Ryzen 6800U
   157			.matches	= {
   158						DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
   159						DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
   160						DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
   161					},
   162			.driver_data	= &gpd_win4_quirk,
   163		},
   164		{
   165			// GPD Win 4 with Ryzen 7840U
   166			.matches	= {
   167						DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
   168						DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
   169						DMI_MATCH(DMI_BOARD_VERSION, "Ver. 1.0"),
   170					},
   171			.driver_data	= &gpd_wm2_quirk,
   172		},
   173		{
   174			// GPD Win Max 2 with Ryzen 6800U
   175			// GPD Win Max 2 2023 with Ryzen 7840U
   176			// GPD Win Max 2 2024 with Ryzen 8840U
   177			.matches	= {
   178						DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
   179						DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
   180					},
   181			.driver_data	= &gpd_wm2_quirk,
   182		},
   183		{}
   184	};
   185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

