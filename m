Return-Path: <linux-kernel+bounces-199882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3578FA72F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A342861D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B8A79F9;
	Tue,  4 Jun 2024 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUTZDh/s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E479CF;
	Tue,  4 Jun 2024 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462112; cv=none; b=U53fnN/P+l/dIYktjFP4XL7sWhTn/M3UJdW4MeM/u3xibQDoKRCySLAqfsLWVbh/DwmfCm/Ym1AgowsEK8GqkCcRpYfOih++qglcKrtQKmakD6RCmJJvFAKpko3XokyaKBLlShyZHOACetho/FTsq2Gnkc3lHktPQyAhDNWOGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462112; c=relaxed/simple;
	bh=TCno75d8Ppl09f7IQLV2u59jY/NFYpwMwbXoLjnTJHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhzD+T6+cdOLTvLI7h103QHccLUY3BO5k1tTYECuqyf5okuiFl3IphrXjEB4Myyi8EnZ3lA0tc4CxX7bShKcVYSHEsWIDnYrWOK9e2K8V7Ib42v8bEvBUh5pa34eVPzRbVh8DXR0pH5U+6XFiGeToBtb7I1CNUV51F6ljB8WDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUTZDh/s; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717462111; x=1748998111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TCno75d8Ppl09f7IQLV2u59jY/NFYpwMwbXoLjnTJHc=;
  b=MUTZDh/s+tbtjX4UVS+X9q4hDNCw85z1KQx4AcPOdLyGyjPkbMZAifFo
   bljodeHx1mjHKV6MyOpl+IUVoY+GVMO9XyyKogrJC/dHxPe7rH3XECWcN
   Y/Q3WrLcR95ZjIKO6bLVqdUAgNNUwBsg6TyDj1BM6fdgIouybedk1K5ud
   iqpF3ejkGdSQMy5CXMim4CAQuJ4getQwerGZR+svrG/SO18nGwT4WWHa7
   1TMyHviRN+zRZMf8RarecH62fQQfzae1SxsXGVzmm2pgLKS7AVBcAN9Ts
   Rzn0RRf6rUhVDOUH+HvoQbklaRTwHJj5pxYBeMfu+Que9XfpZsLv4m6xs
   A==;
X-CSE-ConnectionGUID: Qht2LyFFR4ehgEh6HGxI5g==
X-CSE-MsgGUID: vUtjaaweSQeuDfX+gvhWkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="11883817"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="11883817"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 17:48:26 -0700
X-CSE-ConnectionGUID: y9aJHqkhRyi163PigIM0hA==
X-CSE-MsgGUID: mBYnX1HGTomFi8mY7h8NZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37078615"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 03 Jun 2024 17:48:24 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEILd-000MMp-2t;
	Tue, 04 Jun 2024 00:48:21 +0000
Date: Tue, 4 Jun 2024 08:47:26 +0800
From: kernel test robot <lkp@intel.com>
To: Naresh Solanki <naresh.solanki@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: (max6639) : Update hwmon init using info
 structure
Message-ID: <202406040851.agdur2M1-lkp@intel.com>
References: <20240603103114.3263060-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603103114.3263060-1-naresh.solanki@9elements.com>

Hi Naresh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5fbf8734fb36cf67339f599f0e51747a6aff690c]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/hwmon-max6639-Add-hwmon-attributes-for-fan-and-pwm/20240603-185014
base:   5fbf8734fb36cf67339f599f0e51747a6aff690c
patch link:    https://lore.kernel.org/r/20240603103114.3263060-1-naresh.solanki%409elements.com
patch subject: [PATCH v3 1/2] hwmon: (max6639) : Update hwmon init using info structure
config: i386-randconfig-141-20240604 (https://download.01.org/0day-ci/archive/20240604/202406040851.agdur2M1-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406040851.agdur2M1-lkp@intel.com/

New smatch warnings:
drivers/hwmon/max6639.c:227 max6639_read_fan() warn: unsigned 'res' is never less than zero.
drivers/hwmon/max6639.c:235 max6639_read_fan() error: uninitialized symbol 'val'.
drivers/hwmon/max6639.c:253 max6639_fan_is_visible() warn: signedness bug returning '(-4095)'
drivers/hwmon/max6639.c:278 max6639_read_pwm() warn: unsigned 'res' is never less than zero.

Old smatch warnings:
drivers/hwmon/max6639.c:233 max6639_read_fan() warn: unsigned 'res' is never less than zero.

vim +/res +227 drivers/hwmon/max6639.c

   214	
   215	static int max6639_read_fan(struct device *dev, u32 attr, int channel,
   216				    long *fan_val)
   217	{
   218		struct max6639_data *data = dev_get_drvdata(dev);
   219		unsigned int val, res;
   220	
   221		if (IS_ERR(data))
   222			return PTR_ERR(data);
   223	
   224		switch (attr) {
   225		case hwmon_fan_input:
   226			res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(channel), &val);
 > 227			if (res < 0)
   228				return res;
   229			*fan_val = FAN_FROM_REG(val, data->rpm_range[channel]);
   230			return 0;
   231		case hwmon_fan_fault:
   232			res = max6639_get_status(dev, &val);
   233			if (res < 0)
   234				return res;
 > 235			*fan_val = !!(val & BIT(1 - channel));
   236			return 0;
   237		default:
   238			return -EOPNOTSUPP;
   239		}
   240	}
   241	
   242	static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
   243	{
   244		/* Decrement the PPR value and shift left by 6 to match the register format */
   245		return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
   246	}
   247	
   248	static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
   249	{
   250		struct max6639_data *data = (struct max6639_data *)_data;
   251	
   252		if (IS_ERR(data))
 > 253			return PTR_ERR(data);
   254	
   255		switch (attr) {
   256		case hwmon_fan_input:
   257		case hwmon_fan_fault:
   258			return 0444;
   259		case hwmon_fan_pulses:
   260			return 0644;
   261		default:
   262			return 0;
   263		}
   264	}
   265	
   266	static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
   267				    long *pwm_val)
   268	{
   269		struct max6639_data *data = dev_get_drvdata(dev);
   270		unsigned int val, res;
   271	
   272		if (IS_ERR(data))
   273			return PTR_ERR(data);
   274	
   275		switch (attr) {
   276		case hwmon_pwm_input:
   277			res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(channel), &val);
 > 278			if (res < 0)
   279				return res;
   280			*pwm_val = val * 255 / 120;
   281			return 0;
   282		default:
   283			return -EOPNOTSUPP;
   284		}
   285	}
   286	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

