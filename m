Return-Path: <linux-kernel+bounces-398602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B999BF370
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDDA1F20F33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7DF205E1F;
	Wed,  6 Nov 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9YOMynJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F612038BF;
	Wed,  6 Nov 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911231; cv=none; b=Cnjk3BTyirO2CDbcYEM84NgZVzFsSodIFCPInSc0eqF64eMq/dFWsv8sAvDP2WaxRan72zy/upKG2HZ2wCkT9Pc1ptmpYV2AqCSbuYAIRvVCM+nr6sLFIDQ/X3Rb0QwZePqea3kRd35zX1hNrlP+gh8A5CoFyYlRJSBwEYMONI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911231; c=relaxed/simple;
	bh=FwGjrB4Xov+J3GULSU5ZLeqm2acMIY8YeIdZeoVv4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEIhr4PwgtCjqNLiMdOjfsvPwrOij6ISQ6vwifVhYIL9JV/SD+Othrq2REOPo/7UGNb1M2QikE/7R1lUDDbSWEXzGBcvpm9M87ryemJG1Cz1ercRs1e+eJjsvTJrPZL3xFe8lbdUsa0RQ0z08AcPY/R2OFkIl9PX6YHfmw1gywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9YOMynJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730911229; x=1762447229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FwGjrB4Xov+J3GULSU5ZLeqm2acMIY8YeIdZeoVv4GA=;
  b=S9YOMynJHq4xtPkWFcX3hrO7DxAeat5KzKpAnwMZKoutCaLPdkFE3ITi
   e8xMysJ9ZaScdYhHt6n9XJwY+wIdpsp6vYeQsBJncLwvXaCa9lrXdCN3n
   T8myKofaABEDhS6dUzVkLNwQ6b982vRrZP+7qoYhvBbCXjzZ6+LTbCvcb
   /pWK3gC+f4sHFE0VICQSLpZXtnL8X2F7OTMJLVuLbXKTxQ1I8QRposlXa
   y9Lczvb4Du1shCrr2Cq/bjEKHGhCk+Pl7bk9u9ivqv8UKrZYuHnlklsg9
   5X0OGnpddI6v+qr4oQMPQf7RDtYv9D0rnBvVmwErp52d1nDcNGJ9BbUUd
   w==;
X-CSE-ConnectionGUID: ikdI60NYRKS7i1t+aa7EFA==
X-CSE-MsgGUID: EIDPG3wcRJuaBkwpgaryLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34418302"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34418302"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 08:40:28 -0800
X-CSE-ConnectionGUID: v/KZ/PUcRoyJxlpv5b/l4g==
X-CSE-MsgGUID: Ikuk+uEcQgGFd8F8gzv4NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="88602921"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Nov 2024 08:40:23 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8j4v-000p8e-0l;
	Wed, 06 Nov 2024 16:40:21 +0000
Date: Thu, 7 Nov 2024 00:40:04 +0800
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
Message-ID: <202411070008.3X7zgKXO-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on aa8cbc0898902070f1ad093a6e036cf57f0d47bc]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexis-Cezar-Torreno/dt-bindings-hwmon-pmbus-adp1050-Support-adp1051-and-adp1055-add-bindings/20241106-170853
base:   aa8cbc0898902070f1ad093a6e036cf57f0d47bc
patch link:    https://lore.kernel.org/r/20241106090311.17536-3-alexisczezar.torreno%40analog.com
patch subject: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
config: i386-randconfig-141-20241106 (https://download.01.org/0day-ci/archive/20241107/202411070008.3X7zgKXO-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070008.3X7zgKXO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070008.3X7zgKXO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/hwmon/pmbus/adp1050.c:8:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/hwmon/pmbus/adp1050.c:59:32: error: passing 'const struct pmbus_driver_info *' to parameter of type 'struct pmbus_driver_info *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
      59 |         return pmbus_do_probe(client, info);
         |                                       ^~~~
   drivers/hwmon/pmbus/pmbus.h:541:73: note: passing argument to parameter 'info' here
     541 | int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info);
         |                                                                         ^
   1 warning and 1 error generated.


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

