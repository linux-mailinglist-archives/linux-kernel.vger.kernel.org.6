Return-Path: <linux-kernel+bounces-301068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A28D95EC00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525BA280DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30A51465A4;
	Mon, 26 Aug 2024 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwAMOlfY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA6146018;
	Mon, 26 Aug 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660929; cv=none; b=C9c3D/kVWEd51zG8yfZ6jZBgvXyzGTbtia787TCIRmYEE2sRKXOHsNI9pwczyC0icOyLTI5IbNy8ahZCASWWzt0ZB86Re+bnQkT+0L5kmladLFMCtPVtWdpM7QPLhmuNY5XzmvbEh9um5C97MuRef0Jg3uDi24kqFJkK6vLP3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660929; c=relaxed/simple;
	bh=CW+5hKUdRYfKL28YTTCoc4w1TLEiEKoAB4PnZpQqhbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKe4HH29wR9mp3WDS1vNKIiMrEOF4xS6eNnnjczFtEdAFWWEVcgr/aIBSIFJSTxGsSaWYkFvcRpXSU8wk0IBCcT4F37KNTd+tp2JnMaNlex0q9BidT7yB05zPPDt+LXcMXTxi1PO9/ZOSyjvazu0EsPNirUMLoJO/0lIL2SS5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwAMOlfY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724660927; x=1756196927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CW+5hKUdRYfKL28YTTCoc4w1TLEiEKoAB4PnZpQqhbk=;
  b=YwAMOlfYko/CJe3neliBI7wbsA4iHZjK+aoeaPiXSkOopIosHle9LmfZ
   vXWkW1JFmn2TOK0HgzGhhJnKaEyEVfOoeH4G8/fAvlHdiYFDQNy/H71g/
   oglle/LiZ4mh+vD32G+1zD7p4okG5aoZcOVe6LS90d5CLgQ/LOQmLgVth
   fx6GR6zVLq/rch8NLjj8P+qplIkzzxiVHmrrwgx12pOGcSKeEiIcUouE+
   0AfybL+r4oQC96IcqhVba8rbPTRUYjmgKyq4YXx7mcc/r6pVE6qQ1t9FP
   ZGXpFgkLcs7wbCPVplsWCf43fpoeW4ArEG2Gtuy6PYj8C9Z3t+1hYDlcW
   Q==;
X-CSE-ConnectionGUID: 238lqN7VQUCbXwniwUuS/g==
X-CSE-MsgGUID: z6lKXFYJRiO9Twy6zFBZMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="26863114"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="26863114"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 01:28:47 -0700
X-CSE-ConnectionGUID: qzDAa/RzQuqTqBcMmesRyg==
X-CSE-MsgGUID: D/7I0FJIQVO3Zp7Qcviwrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="67337166"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Aug 2024 01:28:45 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siV5e-000Gfd-1f;
	Mon, 26 Aug 2024 08:28:42 +0000
Date: Mon, 26 Aug 2024 16:28:36 +0800
From: kernel test robot <lkp@intel.com>
To: Wenliang <wenliang202407@163.com>, linux@roeck-us.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wenliang <wenliang202407@163.com>
Subject: Re: [PATCH linux dev 6.11] hwmon:add new hwmon driver sq52205
Message-ID: <202408261627.lm2xKacD-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240826/202408261627.lm2xKacD-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261627.lm2xKacD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408261627.lm2xKacD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/sq52205.c:493:37: error: cannot assign to variable 'sq522xx_regmap_config' with const-qualified type 'const struct regmap_config'
     493 |         sq522xx_regmap_config.max_register = data->config->registers;
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/hwmon/sq52205.c:67:35: note: variable 'sq522xx_regmap_config' declared const here
      67 | static const struct regmap_config sq522xx_regmap_config = {
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
      68 |         .reg_bits = 8,
         |         ~~~~~~~~~~~~~~
      69 |         .val_bits = 16,
         |         ~~~~~~~~~~~~~~~
      70 | };
         | ~
   1 error generated.


vim +493 drivers/hwmon/sq52205.c

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

