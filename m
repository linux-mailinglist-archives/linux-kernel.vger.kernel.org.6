Return-Path: <linux-kernel+bounces-346543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D498C5B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2311C22932
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B571CCB58;
	Tue,  1 Oct 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVOKYb9s"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1381CB520
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808795; cv=none; b=QglesUYoVw4Nq6Jcy/WeGzv7ndr9u08XZ3+F1kU/8UtrVvFYQPMNhxV93oLZArTFH0utKPzNNlrBcFwOCOe7rLz+Wk0eGxhy45sID7zhLfOkwD94GnLZMhUPB+mMqJWQ0Qa+omL153yaFs6lwO/u6/mmiG7A5d39wfmtU0ozf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808795; c=relaxed/simple;
	bh=RKVTxXmu0mJ8vpYz7Lre6M7553GOPvI1y27xIzgs4U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7Tlri7Lt+4vp4dKPrJRkGOgqw84JkknBzPL4/EHi5aOXRkvZI6+SlDmNGnqpWTCj3fyHjpKyBWvpylM8RFaTo5jQqV89syKAmr8Ads4qgEs82leX14BRA+XyXM7xvBb3iYBI71Dsy5IoKIvVwF5kEZwyP3BQeQvByU1+sPiJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVOKYb9s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso71807425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808790; x=1728413590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFldLmOGhmvEKr3Li539baXXwtjlZVpyKg0aS8EMUXc=;
        b=jVOKYb9sbwVOWOt4pcQGV/JcaWJLeFl8i/sLIR/fcwXAh2wQVz5e+gecM9xj+fWCVL
         vqZ3sEIx6+CA/6uZzWTt3D+z5eblGPSApmr9MzT/CLkyn8ltHvNXu2LirrDmDqdtI6EA
         cUbRtr4cioABgeuUR5cnLj2MUjUHmRYCsPG7L4e7jlR0sw97S9QsUsVtJPXCTw0zbxbt
         tMkZ8FRgGMIfOJgjvc3Y0w3hR/qWC0lIwonHnRuXWLrdcZkIoatdn9IstSiy9+bi2dZ2
         1uGpR/9A1PwPGtjrwYoSsiIdk/97U7MEZM9R48qiG2PeYkMSsxsgzbFJFALvAdAvef0n
         cqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808790; x=1728413590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFldLmOGhmvEKr3Li539baXXwtjlZVpyKg0aS8EMUXc=;
        b=GpCN56qrsL8Q/yev06k6Rjm/UITvjNIi/Bzek92jPniU8TDq63TFZShbMFms6SPZo+
         CBo6IMNdoLdXSvlNRGv5MnHrEeQ5MdaDihPd7FMNTgLP8oaQf5+WaN2ehQ24H7ZQFUEE
         fcIkpe+HRR6aXTKeuEucaYopeVS3HMYmtwn4VtpO6dowYzUohv7r3V3UmtbO1tQqLCfp
         kXtN3Y6dvkbjSpWoF4i8uVQkz/xM8P0pzjFyQ1gX4UjGVsO9lHuOgdaxD7f8X0S2WV5c
         0r+Jm6zJtlGhw3wLlY1CJCZLuOL4UMQzwj4dkHxFgL59QmBIbBFrcu24PHHYWF3EtmuR
         1p3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbpBu2w/tJaPfSotQPR5IpUCZHCwSu/1O9GdBIMq4OywqYKCDVtlQjBlxQszxkWmAPYj7WNykMOLhg8E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwseE1aY6lHwDykTrGl8kw6UJQEo2mLRD3ONS8+ISaW3yoF2zx
	6fqmlSykYe+fr9KKlZsV2F5ngdbDd8oXe/w6zb7hwLxyGNiRgkkq
X-Google-Smtp-Source: AGHT+IHfCKC+eeWDq9dZKwzlvtokeIHGAIt79ChWu7WdCD0TyKSo7jV3jlQUVHIkKBaBtAO3y4DaBw==
X-Received: by 2002:a05:600c:4ed4:b0:42c:de34:34d8 with SMTP id 5b1f17b1804b1-42f777ef18emr3763995e9.27.1727808790146;
        Tue, 01 Oct 2024 11:53:10 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:41f4:a392:1d5:d74d? (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e13944sm141818675e9.30.2024.10.01.11.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 11:53:09 -0700 (PDT)
Message-ID: <dc59e32d-ed4a-43c8-a6f3-e4263d97c95f@gmail.com>
Date: Tue, 1 Oct 2024 20:53:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/hwmon/tmp513.c:163:10: error: 'const struct
 regmap_config' has no member named 'reg_bits'
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
References: <202410020246.2cTDDx0X-lkp@intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <202410020246.2cTDDx0X-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2024 20:19, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> commit: 4bc82dd20be09fa133bf3116be6afc933497f860 hwmon: (tmp513) Constify struct regmap_config
> date:   3 months ago
> config: x86_64-randconfig-r133-20240215 (https://download.01.org/0day-ci/archive/20241002/202410020246.2cTDDx0X-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020246.2cTDDx0X-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410020246.2cTDDx0X-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/hwmon/tmp513.c:162:21: error: variable 'tmp51x_regmap_config' has initializer but incomplete type
>      162 | static const struct regmap_config tmp51x_regmap_config = {
>          |                     ^~~~~~~~~~~~~
>>> drivers/hwmon/tmp513.c:163:10: error: 'const struct regmap_config' has no member named 'reg_bits'
>      163 |         .reg_bits = 8,
>          |          ^~~~~~~~
>    drivers/hwmon/tmp513.c:163:21: warning: excess elements in struct initializer
>      163 |         .reg_bits = 8,
>          |                     ^
>    drivers/hwmon/tmp513.c:163:21: note: (near initialization for 'tmp51x_regmap_config')
>>> drivers/hwmon/tmp513.c:164:10: error: 'const struct regmap_config' has no member named 'val_bits'
>      164 |         .val_bits = 16,
>          |          ^~~~~~~~
>    drivers/hwmon/tmp513.c:164:21: warning: excess elements in struct initializer
>      164 |         .val_bits = 16,
>          |                     ^~
>    drivers/hwmon/tmp513.c:164:21: note: (near initialization for 'tmp51x_regmap_config')
>>> drivers/hwmon/tmp513.c:165:10: error: 'const struct regmap_config' has no member named 'max_register'
>      165 |         .max_register = TMP51X_MAX_REGISTER_ADDR,
>          |          ^~~~~~~~~~~~
>    drivers/hwmon/tmp513.c:79:41: warning: excess elements in struct initializer
>       79 | #define TMP51X_MAX_REGISTER_ADDR        0xFF
>          |                                         ^~~~
>    drivers/hwmon/tmp513.c:165:25: note: in expansion of macro 'TMP51X_MAX_REGISTER_ADDR'
>      165 |         .max_register = TMP51X_MAX_REGISTER_ADDR,
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/hwmon/tmp513.c:79:41: note: (near initialization for 'tmp51x_regmap_config')
>       79 | #define TMP51X_MAX_REGISTER_ADDR        0xFF
>          |                                         ^~~~
>    drivers/hwmon/tmp513.c:165:25: note: in expansion of macro 'TMP51X_MAX_REGISTER_ADDR'
>      165 |         .max_register = TMP51X_MAX_REGISTER_ADDR,
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/hwmon/tmp513.c: In function 'tmp51x_probe':
>    drivers/hwmon/tmp513.c:726:24: error: implicit declaration of function 'devm_regmap_init_i2c' [-Werror=implicit-function-declaration]
>      726 |         data->regmap = devm_regmap_init_i2c(client, &tmp51x_regmap_config);
>          |                        ^~~~~~~~~~~~~~~~~~~~
>    drivers/hwmon/tmp513.c:726:22: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      726 |         data->regmap = devm_regmap_init_i2c(client, &tmp51x_regmap_config);
>          |                      ^
>    drivers/hwmon/tmp513.c: At top level:
>    drivers/hwmon/tmp513.c:756:1: warning: data definition has no type or storage class
>      756 | module_i2c_driver(tmp51x_driver);
>          | ^~~~~~~~~~~~~~~~~
>    drivers/hwmon/tmp513.c:756:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
>    drivers/hwmon/tmp513.c:756:1: warning: parameter names (without types) in function declaration
>    drivers/hwmon/tmp513.c:162:35: error: storage size of 'tmp51x_regmap_config' isn't known
>      162 | static const struct regmap_config tmp51x_regmap_config = {
>          |                                   ^~~~~~~~~~~~~~~~~~~~
>    drivers/hwmon/tmp513.c:747:26: warning: 'tmp51x_driver' defined but not used [-Wunused-variable]
>      747 | static struct i2c_driver tmp51x_driver = {
>          |                          ^~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +163 drivers/hwmon/tmp513.c
> 
> 59dfa75e5d82a1 Eric Tremblay   2019-11-12  161  
> 4bc82dd20be09f Javier Carrasco 2024-07-02  162  static const struct regmap_config tmp51x_regmap_config = {
> 59dfa75e5d82a1 Eric Tremblay   2019-11-12 @163  	.reg_bits = 8,
> 59dfa75e5d82a1 Eric Tremblay   2019-11-12 @164  	.val_bits = 16,
> 59dfa75e5d82a1 Eric Tremblay   2019-11-12 @165  	.max_register = TMP51X_MAX_REGISTER_ADDR,
> 59dfa75e5d82a1 Eric Tremblay   2019-11-12  166  };
> 59dfa75e5d82a1 Eric Tremblay   2019-11-12  167  
> 
> :::::: The code at line 163 was first introduced by commit
> :::::: 59dfa75e5d82a1e1b3d090a1d51fc14f66844576 hwmon: Add driver for Texas Instruments TMP512/513 sensor chips.
> 
> :::::: TO: Eric Tremblay <etremblay@distech-controls.com>
> :::::: CC: Guenter Roeck <linux@roeck-us.net>
> 


The bug is not in that commit, the Kconfig entry for this driver is
missing a 'select REGMAP_I2C'. I just tested it and then it builds
without any issues.

I can send a patch to fix that, but I would like to know what commit it
really fixes: the one that introduced the driver as it already used
regmap and did not include the required select? Or the one from this
report because it triggered, even though it is not the real source of
the issue?

Thanks and best regards,
Javier Carrasco

