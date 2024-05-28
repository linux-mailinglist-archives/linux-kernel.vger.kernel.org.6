Return-Path: <linux-kernel+bounces-192540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC78D1EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3900D1F23232
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DBC16F900;
	Tue, 28 May 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INwONnkd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71B1DFDE;
	Tue, 28 May 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906524; cv=none; b=NSyqnHsBTiZMPzrUHOTn746I4+KvfYrfyAvjHlM1kfCJFE4rJxPbnOPMUPBUN1MG13s/StPafowPdd7nCKMGLABJedHkAjYvAqPN1+OGarI9akC+aIIhySZeR0y0E7AWuWKI6GtkDwtOZvo7UXHM2IuxoXNg3PApDM9buaxMRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906524; c=relaxed/simple;
	bh=T4Kx3IqZUgWvF813/1C1I0zDj6zFU361Bp5VV5nF/QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXaSzDfvd7oMC+OeWYssLcZHx218GuV4p7nTWm2nls4YtOKrJYua3QaG5O+rwW/QXkpKk06OU3LUiGhJfoM5TsaoK4iWjzjb/yn2IhGnBhJ4DNO801+y3REK75GkHjDOg1yHwEtjAFZ2cwhffqSSUHRlot4pIzllLgAH9xjDuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INwONnkd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716906522; x=1748442522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T4Kx3IqZUgWvF813/1C1I0zDj6zFU361Bp5VV5nF/QQ=;
  b=INwONnkdemPjHvPsLJ10ijsy/nFyUz/4SQCIGuMS2/ke/iPJWTxE4BqR
   ppqVtsFYS0m/nLFkgINv7niXjPA+ZOCXZTzU+EVAdaHoz6Q1mpbank171
   6pvvtGb80+rQpZm8hryZ3Qf2lc/+R/J2nvMEevMdfG2Z+dAxEFXBeOILc
   +u+78bMQtpVW9GuV4PquPTD6obVfoEQzRAGVjyxGR38eS54iM3oZ7CGiw
   k1W7kQRMzU2C0hSXrjstj+L7DlynF5Lc40Mf6xVHmZ388uLdIzq9zng/x
   hz1eJjzpSoHtiYlaVI54Bru6eMirnuehaDFFQ39XS3L7pqXLYDUOsz15a
   A==;
X-CSE-ConnectionGUID: VEKNaSaxSR6irgL0VT0J1Q==
X-CSE-MsgGUID: nFP2T1FhReqqgEk8/vPC5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13375802"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13375802"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 07:28:41 -0700
X-CSE-ConnectionGUID: ULG11BfDSfGTfEPhrbACzg==
X-CSE-MsgGUID: wb7VZNVLQPuTD86GSmidnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39904295"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 07:28:40 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBxoU-000CKV-0E;
	Tue, 28 May 2024 14:28:32 +0000
Date: Tue, 28 May 2024 22:28:18 +0800
From: kernel test robot <lkp@intel.com>
To: Naresh Solanki <naresh.solanki@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (max6639) : Update hwmon init using info
Message-ID: <202405282222.1d8A5KLv-lkp@intel.com>
References: <20240528091808.863702-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528091808.863702-1-naresh.solanki@9elements.com>

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5fbf8734fb36cf67339f599f0e51747a6aff690c]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/hwmon-max6639-Update-hwmon-init-using-info/20240528-172245
base:   5fbf8734fb36cf67339f599f0e51747a6aff690c
patch link:    https://lore.kernel.org/r/20240528091808.863702-1-naresh.solanki%409elements.com
patch subject: [PATCH v2] hwmon: (max6639) : Update hwmon init using info
config: i386-randconfig-015-20240528 (https://download.01.org/0day-ci/archive/20240528/202405282222.1d8A5KLv-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240528/202405282222.1d8A5KLv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405282222.1d8A5KLv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/max6639.c: In function 'max6639_read_pwm':
>> drivers/hwmon/max6639.c:291:3: error: a label can only be part of a statement and a declaration is not a statement
     291 |   u8 x;
         |   ^~
   drivers/hwmon/max6639.c: In function 'max6639_write_pwm':
   drivers/hwmon/max6639.c:328:3: error: a label can only be part of a statement and a declaration is not a statement
     328 |   u8 x;
         |   ^~


vim +291 drivers/hwmon/max6639.c

   275	
   276	static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
   277				    long *pwm_val)
   278	{
   279		struct max6639_data *data = dev_get_drvdata(dev);
   280		unsigned int val, res;
   281	
   282		if (IS_ERR(data))
   283			return PTR_ERR(data);
   284	
   285		switch (attr) {
   286		case hwmon_pwm_input:
   287			res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(channel), &val);
   288			*pwm_val = val * 255 / 120;
   289			return 0;
   290		case hwmon_pwm_freq:
 > 291			u8 x;
   292	
   293			res = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(channel), &val);
   294			if (res < 0)
   295				return res;
   296			x = val & MAX6639_FAN_CONFIG3_FREQ_MASK;
   297	
   298			res = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &val);
   299			if (res < 0)
   300				return res;
   301	
   302			if (val & MAX6639_GCONFIG_PWM_FREQ_HI)
   303				x |= 0x4;
   304			x &= 0x7;
   305			*pwm_val = freq_table[x];
   306			return res;
   307		default:
   308			return -EOPNOTSUPP;
   309		}
   310	}
   311	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

