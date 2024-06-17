Return-Path: <linux-kernel+bounces-217701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A093790B321
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB391C21226
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955D13A250;
	Mon, 17 Jun 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSl1+QeL"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87867139CF6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633268; cv=none; b=c65Yt8NjURPzfENGIeNBcZoEgDe5uxmtmn/4gJXSxiuPTYBnojy7oLdE2WkeE+NGA8avRbhi6kTGqp7L3lrx4Rmxt20eZfPUnVrrHCAQTG0US+XLa0Q+l3f2ikWQFMQaM4M/Pv/cg+dhLKcUQPRKoQFAPlI+UBqPeXNVI6aovko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633268; c=relaxed/simple;
	bh=gTaVRInUM5Dk+G0y4kJvxr34Ay3xC6qugD0PHbnJD6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=owgLH7tNglCI9JtE1n3ldQO4CghkA1unS7zNPtvIR6InGBeLrks21LOljTNFiKiBaZJ/zEhd2rjDsBV/BMJl4QKdQDGYHXm0WtTbIHKRa//j0Zv/GbKv9rYz2lfmrZncaurUpdYJ6wRGVj1nTK6zQdyBwn7L/jF1YpGZGcMsCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vSl1+QeL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec1620a956so39819441fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718633264; x=1719238064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exNmLeQ/1saUICwG+i10ZbiGFu61QQGdsTZZy7V7AmA=;
        b=vSl1+QeLmXxICiZ68G/dl9zWRbYd3IPB+tKMulXcWTRZjyeUEMLitMUmTgzHT0IopK
         rHdls6Ce/NOFUAd4kYB6dzn+bUgTWv5yNKxMQ3HozAjb5eZZ7y0+qWhWUQaika1E8BwA
         V94LTzqPUJPEOz7OLMOyavta4angbxvn02h6CM/gM26J9UGV72em+KX1rOMjXYN9udL3
         TDx5zjM3lImyPe3ZjmZJhS4HRcawTLJvguzQrYdT367EGneizMeHEa8zevhxaplFI6b2
         d/VS8XjF5gYL5jngvT9WnAlbuGM4oHijEPmXI4pMHAMxORqAHPuZAaxgqGvoRTt7k97P
         tKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633264; x=1719238064;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exNmLeQ/1saUICwG+i10ZbiGFu61QQGdsTZZy7V7AmA=;
        b=r8qr7K3PjsehM5e8cWkjAGEB8tBTm4cJ7LdAgwbX7VjWCJ7scfKFUWxkO7szmTBEJs
         FbrIccv4rxm3hPfpiODObyrtyE9awgE5pqd90DDwCaD3JhHgMglvXT9OHGTCkV4KOd9e
         +eS6TuiooTCyHjogcv2EeVTp1Uuf7cIkmurP3DIr+T6maqJKk75kCTdSE9bjV3ffKHhL
         W5+N39g6641Xrr6kcvCp8BVn1/E3fNwashlJ4ZojdlN+RhV1XqKFYQ+o9YKvMVvN8aUo
         quXKDu0Yp4QgKZZIQInn09/9yuH4x5bh9GQSGOko6NOEXi89YTrxfDqtYktSyay1ZPNH
         3QKA==
X-Forwarded-Encrypted: i=1; AJvYcCVSxRvg6bkWWsSd/3iobweXX98f4+rHPWGlfceGFD8P4fHRnmen6l2e2s5KTAMZtAxX6gdBZpZwbNvgq6VlxBNkw7lcf4danuBXgVPX
X-Gm-Message-State: AOJu0YzMT/yrMIX3poz+v65acInj1b4FZAl7HMUViDXS18cMCq+u3h5O
	54A6tDzjFLhu0a3DXa3svzgJEUYKmieO4Cud1FWAcLGkwHTLDK3CIhZFLMqkYxQ=
X-Google-Smtp-Source: AGHT+IFQsaa8hu5ihcOpX77WzFDdvfqH0xHmzhwYvaZnRHLXsr04EN96LjycixPt/HX3eDQag2dJ6g==
X-Received: by 2002:a05:651c:1a1e:b0:2ec:eee:f19e with SMTP id 38308e7fff4ca-2ec0eeef77fmr74104111fa.37.1718633263311;
        Mon, 17 Jun 2024 07:07:43 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c70sm159742255e9.30.2024.06.17.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:07:43 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:07:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: add support for MAX1720x
 standalone fuel gauge
Message-ID: <f37587e6-bed8-4d91-889f-983bef03cde8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615203352.164234-3-dima.fedrau@gmail.com>

Hi Dimitri,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Fedrau/dt-bindings-power-supply-add-support-for-MAX17201-MAX17205-fuel-gauge/20240616-043602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240615203352.164234-3-dima.fedrau%40gmail.com
patch subject: [PATCH v3 2/2] power: supply: add support for MAX1720x standalone fuel gauge
config: nios2-randconfig-r081-20240616 (https://download.01.org/0day-ci/archive/20240617/202406170040.gxB0dYxg-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406170040.gxB0dYxg-lkp@intel.com/

smatch warnings:
drivers/power/supply/max1720x_battery.c:285 max1720x_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +285 drivers/power/supply/max1720x_battery.c

134a669e205435 Dimitri Fedrau 2024-06-15  251  static int max1720x_probe(struct i2c_client *client)
134a669e205435 Dimitri Fedrau 2024-06-15  252  {
134a669e205435 Dimitri Fedrau 2024-06-15  253  	struct power_supply_config psy_cfg = {};
134a669e205435 Dimitri Fedrau 2024-06-15  254  	struct device *dev = &client->dev;
134a669e205435 Dimitri Fedrau 2024-06-15  255  	struct max1720x_device_info *info;
134a669e205435 Dimitri Fedrau 2024-06-15  256  	int ret;
134a669e205435 Dimitri Fedrau 2024-06-15  257  
134a669e205435 Dimitri Fedrau 2024-06-15  258  	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
134a669e205435 Dimitri Fedrau 2024-06-15  259  	if (!info)
134a669e205435 Dimitri Fedrau 2024-06-15  260  		return -ENOMEM;
134a669e205435 Dimitri Fedrau 2024-06-15  261  
134a669e205435 Dimitri Fedrau 2024-06-15  262  	i2c_set_clientdata(client, info);
134a669e205435 Dimitri Fedrau 2024-06-15  263  	info->bat_desc.name = "max1720x";
134a669e205435 Dimitri Fedrau 2024-06-15  264  	info->bat_desc.no_thermal = true;
134a669e205435 Dimitri Fedrau 2024-06-15  265  	info->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
134a669e205435 Dimitri Fedrau 2024-06-15  266  	info->bat_desc.properties = max1720x_battery_props;
134a669e205435 Dimitri Fedrau 2024-06-15  267  	info->bat_desc.num_properties = ARRAY_SIZE(max1720x_battery_props);
134a669e205435 Dimitri Fedrau 2024-06-15  268  	info->bat_desc.get_property = max1720x_battery_get_property;
134a669e205435 Dimitri Fedrau 2024-06-15  269  	psy_cfg.drv_data = info;
134a669e205435 Dimitri Fedrau 2024-06-15  270  
134a669e205435 Dimitri Fedrau 2024-06-15  271  	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
134a669e205435 Dimitri Fedrau 2024-06-15  272  	if (IS_ERR(info->regmap))
134a669e205435 Dimitri Fedrau 2024-06-15  273  		return dev_err_probe(dev, PTR_ERR(info->regmap),
134a669e205435 Dimitri Fedrau 2024-06-15  274  				     "regmap initialization failed\n");
134a669e205435 Dimitri Fedrau 2024-06-15  275  
134a669e205435 Dimitri Fedrau 2024-06-15  276  	info->ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
134a669e205435 Dimitri Fedrau 2024-06-15  277  	if (IS_ERR(info->ancillary))
134a669e205435 Dimitri Fedrau 2024-06-15  278  		return dev_err_probe(dev, PTR_ERR(info->ancillary),
134a669e205435 Dimitri Fedrau 2024-06-15  279  				     "Failed to initialize ancillary i2c device\n");
134a669e205435 Dimitri Fedrau 2024-06-15  280  
134a669e205435 Dimitri Fedrau 2024-06-15  281  	i2c_set_clientdata(info->ancillary, info);
134a669e205435 Dimitri Fedrau 2024-06-15  282  	ret = max1720x_probe_sense_resistor(info);
134a669e205435 Dimitri Fedrau 2024-06-15  283  	if (ret) {
134a669e205435 Dimitri Fedrau 2024-06-15  284  		i2c_unregister_device(info->ancillary);
134a669e205435 Dimitri Fedrau 2024-06-15 @285  		return dev_err_probe(dev, PTR_ERR(info->bat),

s/PTR_ERR(info->bat)/ret/

134a669e205435 Dimitri Fedrau 2024-06-15  286  				     "Failed to read sense resistor value\n");
134a669e205435 Dimitri Fedrau 2024-06-15  287  	}
134a669e205435 Dimitri Fedrau 2024-06-15  288  
134a669e205435 Dimitri Fedrau 2024-06-15  289  	info->bat = devm_power_supply_register(dev, &info->bat_desc, &psy_cfg);
134a669e205435 Dimitri Fedrau 2024-06-15  290  	if (IS_ERR(info->bat)) {
134a669e205435 Dimitri Fedrau 2024-06-15  291  		i2c_unregister_device(info->ancillary);
134a669e205435 Dimitri Fedrau 2024-06-15  292  		return dev_err_probe(dev, PTR_ERR(info->bat),
134a669e205435 Dimitri Fedrau 2024-06-15  293  				     "Failed to register power supply\n");
134a669e205435 Dimitri Fedrau 2024-06-15  294  	}
134a669e205435 Dimitri Fedrau 2024-06-15  295  
134a669e205435 Dimitri Fedrau 2024-06-15  296  	return 0;
134a669e205435 Dimitri Fedrau 2024-06-15  297  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


