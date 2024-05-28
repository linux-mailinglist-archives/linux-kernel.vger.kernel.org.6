Return-Path: <linux-kernel+bounces-192337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DCE8D1BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726A7285448
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F37F16D9D1;
	Tue, 28 May 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkmElAN3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E416D4E1;
	Tue, 28 May 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900870; cv=none; b=asNBoRVPSYm4OXIRhwLWpsg/aBHzUzXo8ZdVHeR4qTQFzt/0EyVWB3jdJAgdwDSJcDd4k9QFE91g7AjEPmkj4sVMG4LD/EQ14LtQDEeCIaEw7nnYyOshK5v1rR0UsVDxgXOMMjdLho6eD6tkNIfEl2hmp4Dq65L6LpYWutu1yVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900870; c=relaxed/simple;
	bh=zhjmPwGF/MUJ8NPPpqQPbAB7QBimAAKgje5xk8TXdTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDt9OCjOCJSSOMFcrT5ajrPUPLRPQraTv0DEnQOiGTpzhuikMA5o4i9T+Ri1jmtdZpVWEgDgQghLoYkNuRwBuPsY5bOmF7Zn44CCik9sCV4uxvzfD3ZrH/Cwqa7VkDbe4NjKC+sGzYo1Xzd7GqDpOIbLp3QLYCGaCruWuMhBC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkmElAN3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716900868; x=1748436868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zhjmPwGF/MUJ8NPPpqQPbAB7QBimAAKgje5xk8TXdTc=;
  b=DkmElAN3Nm1lYTMx9PSrokKnmoIp46AXMDKJDeG19P3cp04zlPJHAfa2
   ECUOuM7MFpRVePWFYgNV0tXpePSsUKKit7RBao1bZQ26DUZWu+pwymCvD
   FyO+IZzjSB9YxrNnC0gOtxVMXF4xZVq7C4DxauDFuIL8WFommnVgDOrst
   +tJXxLuP7Qx0yDmICIs0zAsr3p3BGvROG2HZQvqzrD/BMvi0B1Q85swo3
   koFRTNpxXLTsR4dcR3oZU84ZrrUgs5PfL83kCHKAD0UKQ1oqpPd+iaX6A
   GTUNYlZDSRw7Ec9AEG2WoavcK3pUy29gcCbbYtjxD8cOSfFme1gwtA0E1
   g==;
X-CSE-ConnectionGUID: vfV8GPkGQAi9R3iJlm5B1Q==
X-CSE-MsgGUID: gC3uA4/qSpKqIuC8ioO4UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="38624677"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="38624677"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 05:54:23 -0700
X-CSE-ConnectionGUID: e4TLYlnHQJ+cnQSAui0hEA==
X-CSE-MsgGUID: vFAolv0hRqCm6fOxmKrqnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35085290"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 28 May 2024 05:54:21 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBwLL-000CCR-1P;
	Tue, 28 May 2024 12:54:19 +0000
Date: Tue, 28 May 2024 20:53:26 +0800
From: kernel test robot <lkp@intel.com>
To: Naresh Solanki <naresh.solanki@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (max6639) : Update hwmon init using info
Message-ID: <202405282012.UaQ1329z-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5fbf8734fb36cf67339f599f0e51747a6aff690c]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/hwmon-max6639-Update-hwmon-init-using-info/20240528-172245
base:   5fbf8734fb36cf67339f599f0e51747a6aff690c
patch link:    https://lore.kernel.org/r/20240528091808.863702-1-naresh.solanki%409elements.com
patch subject: [PATCH v2] hwmon: (max6639) : Update hwmon init using info
config: i386-buildonly-randconfig-003-20240528 (https://download.01.org/0day-ci/archive/20240528/202405282012.UaQ1329z-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240528/202405282012.UaQ1329z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405282012.UaQ1329z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/max6639.c:291:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     291 |                 u8 x;
         |                 ^
   drivers/hwmon/max6639.c:328:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     328 |                 u8 x;
         |                 ^
   2 warnings generated.


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

