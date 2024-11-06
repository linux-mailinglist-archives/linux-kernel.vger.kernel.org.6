Return-Path: <linux-kernel+bounces-398613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A49BF39D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7373B1C233C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BC22064FF;
	Wed,  6 Nov 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4ey4KSA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8BE2038BF;
	Wed,  6 Nov 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911892; cv=none; b=peVqGJNznJKemcL73c/JnuSSOnu6AZWTZQnaQ8XkVnmjSnCiNtV6ST6MFuUMSGuySP0/zQOnu0RvUepqhRmbkMrD/j3HyVaHSK7M3Tq2Xa/Se7TmXmgNr4qdhFEEsQcdocMOhL2QhpWh5F7f4dW67W25d6xtLE6uaJQCPfKqsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911892; c=relaxed/simple;
	bh=wEQYqndqe0EDivTZfk23TQk9AB6AZMSLB7/LXyt85mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECnsucYESJPbZ/OwIVvF719X8HI/MOxnLETFEwxIftopdydRQGKXPoDbWF8GMLOixcrHik094Guwe4tp61eh4A828ujyBEGfgW6Z6oglh/QcAcQOJ7vEb3UDwKYzDwPgBkKrdO7dfeTYDzPFs4W88d7j7uwZm5kSqdhD1wCpiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4ey4KSA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730911891; x=1762447891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wEQYqndqe0EDivTZfk23TQk9AB6AZMSLB7/LXyt85mQ=;
  b=D4ey4KSAn4GUFTQPlOJfoauO6mR5iDND1AJjubLahfIZzbjeGGqZyowS
   nWHytHuB71vuwYnx1tFTj5hZ8yItxof9yqOwF2Vot8ywRVk0tJm6k1ETX
   g6n85QWTAGy5JFeJadKSxdl/7cGDApnt8tBBenG4xcxfl1pBdDDSZJ1If
   vZbVJ9QqPBc/Unw8Rb+W12w1V6iOIjbQ6PdVp93VKB7lNoxKBClPHFMQs
   IdZDsNM+JsVLcPB2X9142mY56EtU2jj7Qk7vqEU6HBHI/B1561AbW5tRQ
   eL2Pp1OTubdeJX2n2Iyg+1PCwtUwRScFnkturZvSu0868fkUbM30vQ7pF
   w==;
X-CSE-ConnectionGUID: s4zx+Z6bSMOMZVF4FthACA==
X-CSE-MsgGUID: uwMKEnkFQbiUI2dkYesQlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="34645426"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="34645426"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 08:51:30 -0800
X-CSE-ConnectionGUID: yvSH9epuQiyx8JFoa4TdRw==
X-CSE-MsgGUID: FT8IaTCrSNGP4tLhLWyt6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="89425399"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Nov 2024 08:51:26 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8jFc-000p9q-0f;
	Wed, 06 Nov 2024 16:51:24 +0000
Date: Thu, 7 Nov 2024 00:50:45 +0800
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
Message-ID: <202411070017.nDsv8lMO-lkp@intel.com>
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
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241107/202411070017.nDsv8lMO-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070017.nDsv8lMO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070017.nDsv8lMO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/pmbus/adp1050.c: In function 'adp1050_probe':
>> drivers/hwmon/pmbus/adp1050.c:59:39: warning: passing argument 2 of 'pmbus_do_probe' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      59 |         return pmbus_do_probe(client, info);
         |                                       ^~~~
   In file included from drivers/hwmon/pmbus/adp1050.c:12:
   drivers/hwmon/pmbus/pmbus.h:541:73: note: expected 'struct pmbus_driver_info *' but argument is of type 'const struct pmbus_driver_info *'
     541 | int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info);
         |                                               ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~


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

