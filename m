Return-Path: <linux-kernel+bounces-301897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C600F95F701
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8009828249F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64586194AEB;
	Mon, 26 Aug 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eG074/rT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC85476B;
	Mon, 26 Aug 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690842; cv=none; b=fGfYS0d4X34YFh6Bt146o0oFXls93cfbdS2fQ+pOOuxH40531XPz246z9mxcs5gLoxA3HbphUJSh1VgjJlWgl9vAnOcuWM7UCpBrA476S4LUNpkfBndIvyV8auu16Z7kgC18Iw6eamNsyV0VpqL+B7nsMPiXGLMRUXIuSVPmJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690842; c=relaxed/simple;
	bh=LZ7q7pyQoiWYUS7iWGjaAiScjjop2VZjk4ASSdGKcKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/5F7NcuYX7QcIlkoT1bU6h6VFK3op3eRwE7T3N42Se2oHcpuV8ADzgwBU3tVbkobRMir4lL9ScOTWsn5nCV0810XKKk5oQ4ktK+ls03/F0mNIRsm9Y1VERREaqS13Z5rd37yNEOCb7YhXdicWOX1sYvANLrSav3V2Wdi8ydLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eG074/rT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724690840; x=1756226840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LZ7q7pyQoiWYUS7iWGjaAiScjjop2VZjk4ASSdGKcKw=;
  b=eG074/rTzBKTQ2dcAhOkJJqbvbPBEl0ItSRMb4ak2HLUUqTTkMXs9RpE
   /vYWo8BPNNOoqXxgAZg194pNaCzkQWUjXv7NykX5UJxRfhgKg5q8Oyjho
   mqq4sM96s3dUzULXOP6E+2wYjxQIRoMfLOlIODrYvglzAxl1pxSrhGqQS
   Zp3VmXPHncjbmnYrI7W0Jy1tZKbBVKxKk/NfGebKqLA/XnzYo2wsBUE7k
   W+WGI/7JQdu8zk9cXsuyVb6eyVI4Vs78g54Uv3SqZL8KR8rbfThr4+Ach
   V6hv+G2YijdIM0Lil8o61i3y8Srkh2JSCnCydpWQUdQdM1iCGHc3xQvj/
   A==;
X-CSE-ConnectionGUID: PTzp3CnCSyePHhxPPWabwQ==
X-CSE-MsgGUID: YKMcewjMQw6POp5Bw+68EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22993963"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="22993963"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 09:47:19 -0700
X-CSE-ConnectionGUID: UAIBIfMdT7SWl1IDLOJtyA==
X-CSE-MsgGUID: 1guBxUyYQx2c0TZiAwv4bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66903943"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Aug 2024 09:47:19 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sics7-000HMG-1r;
	Mon, 26 Aug 2024 16:47:15 +0000
Date: Tue, 27 Aug 2024 00:46:24 +0800
From: kernel test robot <lkp@intel.com>
To: Wenliang <wenliang202407@163.com>, linux@roeck-us.net
Cc: oe-kbuild-all@lists.linux.dev, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wenliang <wenliang202407@163.com>
Subject: Re: [PATCH linux dev 6.11] hwmon:add new hwmon driver sq52205
Message-ID: <202408270025.5A0Q5KZO-lkp@intel.com>
References: <20240822074426.7241-1-wenliang202407@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822074426.7241-1-wenliang202407@163.com>

Hi Wenliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenliang/hwmon-add-new-hwmon-driver-sq52205/20240826-103932
base:   linux/master
patch link:    https://lore.kernel.org/r/20240822074426.7241-1-wenliang202407%40163.com
patch subject: [PATCH linux dev 6.11] hwmon:add new hwmon driver sq52205
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240827/202408270025.5A0Q5KZO-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270025.5A0Q5KZO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270025.5A0Q5KZO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/sq52205.c: In function 'sq522xx_probe':
>> drivers/hwmon/sq52205.c:493:44: error: assignment of member 'max_register' in read-only object
     493 |         sq522xx_regmap_config.max_register = data->config->registers;
         |                                            ^


vim +/max_register +493 drivers/hwmon/sq52205.c

   460	
   461	static int sq522xx_probe(struct i2c_client *client)
   462	{
   463		struct device *dev = &client->dev;
   464		struct sq522xx_data *data;
   465		struct device *hwmon_dev;
   466		u32 val;
   467		int ret, group = 0;
   468		enum sq522xx_ids chip;
   469	
   470		if (client->dev.of_node)
   471			chip = (uintptr_t)of_device_get_match_data(&client->dev);
   472		else
   473			chip = i2c_match_id(sq522xx_id, client)->driver_data;
   474	
   475		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
   476		if (!data)
   477			return -ENOMEM;
   478	
   479		/* set the device type */
   480		data->client = client;
   481		data->config = &sq522xx_config[chip];
   482		mutex_init(&data->config_lock);
   483	
   484		if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0)
   485			val = SQ522XX_RSHUNT_DEFAULT;
   486	
   487	
   488		if (val <= 0 || val > data->config->calibration_factor)
   489			return -ENODEV;
   490	
   491		data->rshunt = val;
   492	
 > 493		sq522xx_regmap_config.max_register = data->config->registers;
   494	
   495		data->regmap = devm_regmap_init_i2c(client, &sq522xx_regmap_config);
   496		if (IS_ERR(data->regmap)) {
   497			dev_err(dev, "failed to allocate register map\n");
   498			return PTR_ERR(data->regmap);
   499		}
   500	
   501	
   502		ret = sq522xx_init(data);
   503		if (ret < 0) {
   504			dev_err(dev, "error configuring the device: %d\n", ret);
   505			return -ENODEV;
   506		}
   507		if (chip == sq52205) {
   508			ret = sq52205_init(data);
   509			if (ret < 0) {
   510				dev_err(dev, "error configuring the device cal: %d\n", ret);
   511				return -ENODEV;
   512			}
   513		}
   514	
   515		data->groups[group++] = &sq522xx_group;
   516		if (chip == sq52205)
   517			data->groups[group++] = &sq52205_group;
   518	
   519		hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
   520									data, data->groups);
   521		if (IS_ERR(hwmon_dev))
   522			return PTR_ERR(hwmon_dev);
   523	
   524		dev_info(dev, "power monitor %s (Rshunt = %li uOhm)\n",
   525			 client->name, data->rshunt);
   526	
   527		return 0;
   528	}
   529	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

