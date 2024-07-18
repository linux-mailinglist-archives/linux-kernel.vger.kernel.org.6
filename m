Return-Path: <linux-kernel+bounces-256778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D65F93701C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841B52809C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197427D07F;
	Thu, 18 Jul 2024 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJJt0OWK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3007C6DF;
	Thu, 18 Jul 2024 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338258; cv=none; b=DihhCQxVZzDuBnyC6dzlG1CWCf1368ZKVydZsNT4Q2VP2RBfS37sLJlLfcm5KgKsZuSbiqZReKjWScAn4eyDwwMhCinfbi740O5YxGKSZw8UM+5d2wR+zwAYvLGVUpN6sEfZKCnlhF+w3fHDefr8iq/VciFCJH90YBrXycKjXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338258; c=relaxed/simple;
	bh=Tx3vbFhrmR74Mo+yVO1RuPytyxQt0qEc8MWkHFogyzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oobfiO/w7+d7NhtYMMhcY/UdEMcAvOc2zikqWCoUoFIRV1n/OawrQLUlDbt4S5XRS0W4HVAZXZ5PRSsctBJt+9ITeaDQhhmpwhQOU1LNV4S2IJ5CovpVIotIcwcO3ozxs7niC7e+7lTPvlRBbjqY/qTtB2GcKU5KdZwHyUWrwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJJt0OWK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721338257; x=1752874257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tx3vbFhrmR74Mo+yVO1RuPytyxQt0qEc8MWkHFogyzk=;
  b=AJJt0OWK237JPBjGpYlRQ9zTjj+QsPW6tQAS3beBzVDEwUIbQqCOAbwv
   oZKdaLAIyjsvXbhqbvQUPXaM4CBxccbiJLNdTroMjXsGT/sLF8TJ1BEoD
   UAXs6dt7/k+zOPu7OnXxy3XHTD6S8nNf+Q5ayiVnVK3UUQNWViUswkE0E
   x8vzYszOJ4vWQ9YrTIg7MR5aYZAeNUUvjeT4MXpGbP2sGaA81sDH8LKN5
   qzbCpe787PmAzonTfSqWcUJ+EDyYcD0d67d+SDRBmkLLKCyq6dqDH2hGl
   4/HHiM46mSX2scqNZBdyuALnVyo1ctuzIaCIUoVU/1B6kb2dUyfUS6tn7
   w==;
X-CSE-ConnectionGUID: DSviN4NiQTuyHHH4/jcb/Q==
X-CSE-MsgGUID: 19BCX9NERHaQsYaTcicL3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="30317532"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="30317532"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 14:30:57 -0700
X-CSE-ConnectionGUID: i3QYZPFzSxOhjfU8cU0hIQ==
X-CSE-MsgGUID: 65iEtUY1QtKyed0c/P1rOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="74130488"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Jul 2024 14:30:53 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUYiA-000has-2H;
	Thu, 18 Jul 2024 21:30:50 +0000
Date: Fri, 19 Jul 2024 05:30:22 +0800
From: kernel test robot <lkp@intel.com>
To: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Cryolitia PukNgae <Cryolitia@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	Marcin =?utf-8?Q?Str=C4=85gowski?= <marcin@stragowski.com>
Subject: Re: [PATCH v4 1/2] hwmon: add GPD devices sensor driver
Message-ID: <202407190547.V7oIPiBV-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on d67978318827d06f1c0fa4c31343a279e9df6fde]

url:    https://github.com/intel-lab-lkp/linux/commits/Cryolitia-PukNgae-via-B4-Relay/hwmon-add-GPD-devices-sensor-driver/20240718-104420
base:   d67978318827d06f1c0fa4c31343a279e9df6fde
patch link:    https://lore.kernel.org/r/20240718-gpd_fan-v4-1-116e5431a9fe%40gmail.com
patch subject: [PATCH v4 1/2] hwmon: add GPD devices sensor driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240719/202407190547.V7oIPiBV-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407190547.V7oIPiBV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407190547.V7oIPiBV-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/hwmon/gpd-fan.c:153:18: error: initializing 'void *' with an expression of type 'const struct gpd_model_quirk *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     153 |                 .driver_data    = &gpd_win_mini_quirk,
         |                                   ^~~~~~~~~~~~~~~~~~~
   drivers/hwmon/gpd-fan.c:162:18: error: initializing 'void *' with an expression of type 'const struct gpd_model_quirk *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     162 |                 .driver_data    = &gpd_win4_quirk,
         |                                   ^~~~~~~~~~~~~~~
   drivers/hwmon/gpd-fan.c:171:18: error: initializing 'void *' with an expression of type 'const struct gpd_model_quirk *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     171 |                 .driver_data    = &gpd_wm2_quirk,
         |                                   ^~~~~~~~~~~~~~
   drivers/hwmon/gpd-fan.c:181:18: error: initializing 'void *' with an expression of type 'const struct gpd_model_quirk *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     181 |                 .driver_data    = &gpd_wm2_quirk,
         |                                   ^~~~~~~~~~~~~~
>> drivers/hwmon/gpd-fan.c:496:4: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     496 |                         s32 ret = data->quirk->read_rpm(data);
         |                         ^
   drivers/hwmon/gpd-fan.c:513:4: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     513 |                         s16 ret = data->quirk->read_pwm(data);
         |                         ^
   drivers/hwmon/gpd-fan.c:541:4: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     541 |                         u8 var = clamp_val(val, 0, 255);
         |                         ^
   3 warnings and 4 errors generated.


vim +153 drivers/hwmon/gpd-fan.c

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
 > 162			.driver_data	= &gpd_win4_quirk,
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

