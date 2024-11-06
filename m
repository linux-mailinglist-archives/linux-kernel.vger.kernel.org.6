Return-Path: <linux-kernel+bounces-398946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6319BF859
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22A1B2202F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331020CCD8;
	Wed,  6 Nov 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcB9DYIK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F620C489;
	Wed,  6 Nov 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927525; cv=none; b=e9xDyxtRmAqkgd8I2g4ctnF3cIG0p/jVfMTmQHdxkZCAWAoxrnjQ00PHWv7WXax0zqNYrVwy0jjlvuSMvv8yImsoX2BreIHujE1TGnucWwblMD7hwDbpVLfjZjH6+m/I2LLGD2V4Bb15c8hcY3nOKYuWdht2QB5Dk5BBMgsZpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927525; c=relaxed/simple;
	bh=zrZe+fid+09uUIx8uhiwUTZMog/OC/hedzszsms8RNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfjAEGTstGS6UjRQdZj3M9KCEdSRRdz5gEZEVxzPpviS7osr4lG43beYcp/9qJfl5vGOMYZKsNYWjKR6Q3cG29fM1FEPycUrIalGGdDMGOeA1SWoCuopMnlhPN4YlcFSRB9bl7na5ylQHg33+pQGf6+MFsOt/WBE6v76FS25Vm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XcB9DYIK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730927524; x=1762463524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zrZe+fid+09uUIx8uhiwUTZMog/OC/hedzszsms8RNM=;
  b=XcB9DYIKAyuZ9r2RqnoGIRxj1dQc5tYn+oDIUGhUPILDj76NhK+n15fQ
   GscdiBZ5QtKmypXtq+GxpJQV5QMEussbGAut7NpI2SghSzt7+96b64n4g
   3uH0vx6p3F4uSnjGky5rhaN+EWbqC0hpzMuxqRuj2ekOBl/1gqPVswrIC
   y/WDbS96/dlKqHNj8OveZY3vehsuXGalUOUbYY6CdKWTsGKwpJexo/sTr
   iUaLE5Nixuh4EC02S1OZo7PblwOHpXJrNDQfPH0m07YKmCmVeafUCDrEX
   wOv63pINiipoZ+O3KaGAvwq3EUdnImTgoGIER4Rpnl2aI5q/IYmTnxx1V
   A==;
X-CSE-ConnectionGUID: ttlMVc9qQCu69eCGbHmtDQ==
X-CSE-MsgGUID: 02ZSY2EJT4akO8jndmVQ/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="33588540"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="33588540"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 13:12:03 -0800
X-CSE-ConnectionGUID: eoL8m8VYSUWZwLMM2UAn4Q==
X-CSE-MsgGUID: IjKBEYDHQBO/Utx6NyVuPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="84925348"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Nov 2024 13:11:36 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8nJO-000pQo-29;
	Wed, 06 Nov 2024 21:11:34 +0000
Date: Thu, 7 Nov 2024 05:11:30 +0800
From: kernel test robot <lkp@intel.com>
To: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Radu Sabau <radu.sabau@analog.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexis Cezar Torreno <alexisczezar.torreno@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Message-ID: <202411070427.lkz6nVFX-lkp@intel.com>
References: <20241106090311.17536-3-alexisczezar.torreno@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106090311.17536-3-alexisczezar.torreno@analog.com>

Hi Alexis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aa8cbc0898902070f1ad093a6e036cf57f0d47bc]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexis-Cezar-Torreno/dt-bindings-hwmon-pmbus-adp1050-Support-adp1051-and-adp1055-add-bindings/20241106-170853
base:   aa8cbc0898902070f1ad093a6e036cf57f0d47bc
patch link:    https://lore.kernel.org/r/20241106090311.17536-3-alexisczezar.torreno%40analog.com
patch subject: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
config: x86_64-randconfig-r123-20241106 (https://download.01.org/0day-ci/archive/20241107/202411070427.lkz6nVFX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070427.lkz6nVFX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070427.lkz6nVFX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hwmon/pmbus/adp1050.c:59:39: sparse: sparse: incorrect type in argument 2 (different modifiers) @@     expected struct pmbus_driver_info *info @@     got struct pmbus_driver_info const *[assigned] info @@
   drivers/hwmon/pmbus/adp1050.c:59:39: sparse:     expected struct pmbus_driver_info *info
   drivers/hwmon/pmbus/adp1050.c:59:39: sparse:     got struct pmbus_driver_info const *[assigned] info

vim +59 drivers/hwmon/pmbus/adp1050.c

    50	
    51	static int adp1050_probe(struct i2c_client *client)
    52	{
    53		const struct pmbus_driver_info *info;
    54	
    55		info = device_get_match_data(&client->dev);
    56		if (!info)
    57			return -ENODEV;
    58	
  > 59		return pmbus_do_probe(client, info);
    60	}
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

