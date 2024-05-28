Return-Path: <linux-kernel+bounces-192713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197A58D2114
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455E4B22C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D49B171E72;
	Tue, 28 May 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abhkWOWA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3016C688;
	Tue, 28 May 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912173; cv=none; b=lNbW+5LXZLXcV82mUkDJgicDFLsKQ/r7xN3GWT6b9GqBl/AFlXUssYySlrOpw4jb9yCkX9OfhMfgDIa5jQOUGkQnT0DMO49E+jhDd22ya6DF5kgLCDits7DxRKOh2heTIaa6tz2TwzbL71R3ZuKi5VaVicAs5Ps5+r87oXB5IXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912173; c=relaxed/simple;
	bh=pTd9+3ADyKSsLJxka8UR2Fi7CwtGAZ/fPYypqOBGFKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs20/vT9OFW8PsXXROHrjIkOd2oKvqzJgyqjHJgkavnEOFm9mKa6/a/sNFv6jM7CAm2hTghOj2qr4xb/tQRfSKPefUko6EL/CipOXW5cB1jZUQH91ZE2Quj42e8QIEfQrzDj51hgHWZI8CYXkG1qNw7d8gost+131d/bRKT0+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abhkWOWA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716912172; x=1748448172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTd9+3ADyKSsLJxka8UR2Fi7CwtGAZ/fPYypqOBGFKc=;
  b=abhkWOWAD1lxiykExf0AanWLAg6TFaYNyCFc9FvvApP3icMM+bOUapEu
   Rr0FfW4Iemc+tSIGEWjBEb4S3O+2xdAhehDOISt2m81q0gaWL7W2mqeZN
   aXR7diHg/Y0L96ZTalbtGwA0Kd+KUqqX55H0zmKxxcxr/pt9K2w5/allY
   fcf58jEE1a7mAdQnBaNTVEzqY71gZumR8lYrjMZ7BB7jWxIxONxhKf5DU
   pTQGw5fld0uP/ioxYMz/8XzUwvMWtykED5yCh7YgTmNluUsPGBf+pu/5H
   qxYL07epgZO6NQpnXGd/Vr4Jhyvfi3WooM/taYLYQxFDxiGhDA9jBOMOg
   A==;
X-CSE-ConnectionGUID: 4prBDivWRuWg9mOrDuWOYA==
X-CSE-MsgGUID: Ia+WtwlaQGOGpMUjfFaSRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24685042"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="24685042"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 09:02:51 -0700
X-CSE-ConnectionGUID: QSrT1CW1R4GH1zOmD3LUKQ==
X-CSE-MsgGUID: BcsEDqCiSmGGBf/FMWktww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35208558"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 28 May 2024 09:02:50 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBzHj-000CQD-0P;
	Tue, 28 May 2024 16:02:47 +0000
Date: Wed, 29 May 2024 00:02:05 +0800
From: kernel test robot <lkp@intel.com>
To: Naresh Solanki <naresh.solanki@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (max6639) : Update hwmon init using info
Message-ID: <202405282323.3IOCxxpg-lkp@intel.com>
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
config: arm64-randconfig-002-20240528 (https://download.01.org/0day-ci/archive/20240528/202405282323.3IOCxxpg-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240528/202405282323.3IOCxxpg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405282323.3IOCxxpg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/max6639.c:291:3: error: expected expression
                   u8 x;
                   ^
>> drivers/hwmon/max6639.c:296:3: error: use of undeclared identifier 'x'
                   x = val & MAX6639_FAN_CONFIG3_FREQ_MASK;
                   ^
   drivers/hwmon/max6639.c:303:4: error: use of undeclared identifier 'x'
                           x |= 0x4;
                           ^
   drivers/hwmon/max6639.c:304:3: error: use of undeclared identifier 'x'
                   x &= 0x7;
                   ^
   drivers/hwmon/max6639.c:305:25: error: use of undeclared identifier 'x'
                   *pwm_val = freq_table[x];
                                         ^
   drivers/hwmon/max6639.c:328:3: error: expected expression
                   u8 x;
                   ^
   drivers/hwmon/max6639.c:332:8: error: use of undeclared identifier 'x'
                   for (x = 0; x < sizeof(freq_table); x++)
                        ^
   drivers/hwmon/max6639.c:332:15: error: use of undeclared identifier 'x'
                   for (x = 0; x < sizeof(freq_table); x++)
                               ^
   drivers/hwmon/max6639.c:332:39: error: use of undeclared identifier 'x'
                   for (x = 0; x < sizeof(freq_table); x++)
                                                       ^
   drivers/hwmon/max6639.c:333:26: error: use of undeclared identifier 'x'
                           if (val <= freq_table[x])
                                                 ^
   drivers/hwmon/max6639.c:337:38: error: use of undeclared identifier 'x'
                                            MAX6639_FAN_CONFIG3_FREQ_MASK, x);
                                                                           ^
   drivers/hwmon/max6639.c:341:7: error: use of undeclared identifier 'x'
                   if (x >> 2)
                       ^
   12 errors generated.


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
 > 296			x = val & MAX6639_FAN_CONFIG3_FREQ_MASK;
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

