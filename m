Return-Path: <linux-kernel+bounces-349347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C06F98F49B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B244B1C218AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4411A705F;
	Thu,  3 Oct 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g32ab7v8"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338791A704D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974430; cv=none; b=WOEj4etFE6c36z4HB9Jf8I/R3+RU4+7XP6zMeCUV2DLblshaoU+t2cNbhjAnZblnDSa5rKY2KryglApvTV1pbI2b44yJvjY9pHnPD7jhkPaTZKsUFmmZ9wXVAQw2Vjoc7OuY5W+Lr4d5G/8IHJp5W1k4wNuoWc1FeG2NkO4hnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974430; c=relaxed/simple;
	bh=LxF46EDoaznY4F1zahJAqtHW2kF9JxWtY6qntfvLWNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awXVnGP1c/aGa8IOoKKnp1lrwI8vi+c68TkfDxZ+s8LkaRamBG2jEL8AU4UMIed7Y3FojviNBcNkxxr7nN9NRIA0OIOFyWt2tC95T5tKhenaI0Ip7RV+22yE1+QXA8Km56PCEPYRUWPqWhD4pHSo/hRnDjKIDPqeHAG+0pnxyqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g32ab7v8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so11217965e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974425; x=1728579225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5HCKrPV5sNaAbW+wmhASj2RNr6HhB9DqF90Z83CNHQ=;
        b=g32ab7v8/vzZo8bblU+lotKVW3f0hI0ii/bgwkX7W2zMxIu7/1BIfqSnlLZMkfGq55
         pYarp30fiwrayQ+YSGH6CzVl/CTo+vpJeKGkpuuoC6KdOFYplSBNorMkEAI714QbVACi
         vOykLxXjI2Da0O09f8FEe8YoJdzuLF8L09fDan45nTiYj95UuhHVMcR0xbYH8d9oGfuz
         YLm/ooD4NJ3kPPapaiDBSg6YZPY33z6/ydipBCKhD+BwvSbOlJyOztdRP9f5wiIwTQba
         vyzs6adBPrMpqOyUAhIxx0rCrJFTlZvjYGVTnyOxQLOi6h1ufhjJwuOmcmw8e72bdQ6Y
         r8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974425; x=1728579225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5HCKrPV5sNaAbW+wmhASj2RNr6HhB9DqF90Z83CNHQ=;
        b=dAgqrmw05jBWpSPw7FcHt89WAxPPQAUXWDYurolqCDXowZy59UWk64naCYNsIa7aEC
         PiMHYxfmJwHujBzONN2ViR4UaMFKIixtDqI9X0yrZ499tFR5lVGYMv7REk3Q3ipLmHJj
         xkIjXFeIs4um/yRRsH+4d2JliQ8K+Jqq2VIyG9AnteEdUP1NHZ9fRU/2ySDnLt9g6Cpf
         ydENDRfUf+qZQrjssoiLREpRG041bd1oBcHw9SaG0wXK8o4GBiG5+E+lEZuDjxLfRwNk
         ijkUdK8fpEhKuZmLC38vdyGHkIvUhO1o3XuG0dlKaPe15chrE6jVoyOCY5zBsWmmfNZ9
         bEKg==
X-Forwarded-Encrypted: i=1; AJvYcCW7lfXPuCGNO2Uhgy1hlsiW0a235lSxRkVE9ugbJzrUeLJf/n6LqFR0UN+eTHfHrZyFNW3nArAK1D0BLxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOW+r03mvPctupUryI1iDzYen/h6cQZqqkTYQBEEAGFMg9xAFS
	qajjSiVxccqWIomWY4PtyUDdIqL3LS99L3v2ysP6Hc6MuY62Ab1/
X-Google-Smtp-Source: AGHT+IHBgIOzP/Suz1ksfCig2PKcbBrf7U15buBve6E9PK/UpBkTlfx0YdwrE2QARYX/dmtEPdvnmA==
X-Received: by 2002:a05:600c:1c04:b0:42b:a88f:f872 with SMTP id 5b1f17b1804b1-42f778f13d3mr56789095e9.32.1727974425421;
        Thu, 03 Oct 2024 09:53:45 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:3ec5:11f2:e453:20e3? (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6b75sm1660996f8f.81.2024.10.03.09.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:53:44 -0700 (PDT)
Message-ID: <5d666bc8-203f-44c7-b4e5-a5342b1bc38b@gmail.com>
Date: Thu, 3 Oct 2024 18:53:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct
 regmap_bus' has no member named 'read'
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <202410021111.LknEX9ne-lkp@intel.com>
 <6e935f30-6dc5-4422-842d-068c08d31333@gmail.com> <Zv60l6y4ij6C6U2J@rli9-mobl>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <Zv60l6y4ij6C6U2J@rli9-mobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/10/2024 17:13, Philip Li wrote:
> On Wed, Oct 02, 2024 at 09:01:50AM +0200, Javier Carrasco wrote:
>> On 02/10/2024 05:21, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
>>> commit: c922c634bd926d84967275efbb7275b8645aa343 iio: accel: adxl367: Constify struct regmap_bus
>>> date:   9 weeks ago
>>> config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/config)
>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202410021111.LknEX9ne-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    In file included from include/linux/sched.h:38,
>>>                     from include/linux/percpu.h:12,
>>>                     from arch/x86/include/asm/msr.h:15,
>>>                     from arch/x86/include/asm/tsc.h:10,
>>>                     from arch/x86/include/asm/timex.h:6,
>>>                     from include/linux/timex.h:67,
>>>                     from include/linux/time32.h:13,
>>>                     from include/linux/time.h:60,
>>>                     from include/linux/stat.h:19,
>>>                     from include/linux/module.h:13,
>>>                     from drivers/iio/accel/adxl367_spi.c:8:
>>>    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
>>>       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
>>>          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
>>>    include/linux/mm.h:2888:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
>>>     2888 | #if USE_SPLIT_PTE_PTLOCKS
>>>          |     ^~~~~~~~~~~~~~~~~~~~~
>>>    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
>>>       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
>>>          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
>>>    include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
>>>       20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
>>>          |                                  ^~~~~~~~~~~~~~~~~~~~~
>>>    include/linux/mm.h:3010:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
>>>     3010 | #if USE_SPLIT_PMD_PTLOCKS
>>>          |     ^~~~~~~~~~~~~~~~~~~~~
>>>    drivers/iio/accel/adxl367_spi.c:75:21: error: variable 'adxl367_spi_regmap_bus' has initializer but incomplete type
>>>       75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
>>>          |                     ^~~~~~~~~~
>>>>> drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct regmap_bus' has no member named 'read'
>>>       76 |         .read = adxl367_read,
>>>          |          ^~~~
>>>    drivers/iio/accel/adxl367_spi.c:76:17: warning: excess elements in struct initializer
>>>       76 |         .read = adxl367_read,
>>>          |                 ^~~~~~~~~~~~
>>>    drivers/iio/accel/adxl367_spi.c:76:17: note: (near initialization for 'adxl367_spi_regmap_bus')
>>>>> drivers/iio/accel/adxl367_spi.c:77:10: error: 'const struct regmap_bus' has no member named 'write'
>>>       77 |         .write = adxl367_write,
>>>          |          ^~~~~
>>>    drivers/iio/accel/adxl367_spi.c:77:18: warning: excess elements in struct initializer
>>>       77 |         .write = adxl367_write,
>>>          |                  ^~~~~~~~~~~~~
>>>    drivers/iio/accel/adxl367_spi.c:77:18: note: (near initialization for 'adxl367_spi_regmap_bus')
>>>    drivers/iio/accel/adxl367_spi.c:80:21: error: variable 'adxl367_spi_regmap_config' has initializer but incomplete type
>>>       80 | static const struct regmap_config adxl367_spi_regmap_config = {
>>>          |                     ^~~~~~~~~~~~~
>>>    drivers/iio/accel/adxl367_spi.c:81:10: error: 'const struct regmap_config' has no member named 'reg_bits'
>>>       81 |         .reg_bits = 8,
>>>          |          ^~~~~~~~
>>>    drivers/iio/accel/adxl367_spi.c:81:21: warning: excess elements in struct initializer
>>>       81 |         .reg_bits = 8,
>>>          |                     ^
>>>    drivers/iio/accel/adxl367_spi.c:81:21: note: (near initialization for 'adxl367_spi_regmap_config')
>>>    drivers/iio/accel/adxl367_spi.c:82:10: error: 'const struct regmap_config' has no member named 'val_bits'
>>>       82 |         .val_bits = 8,
>>>          |          ^~~~~~~~
>>>    drivers/iio/accel/adxl367_spi.c:82:21: warning: excess elements in struct initializer
>>>       82 |         .val_bits = 8,
>>>          |                     ^
>>>    drivers/iio/accel/adxl367_spi.c:82:21: note: (near initialization for 'adxl367_spi_regmap_config')
>>>    drivers/iio/accel/adxl367_spi.c: In function 'adxl367_spi_probe':
>>>    drivers/iio/accel/adxl367_spi.c:132:18: error: implicit declaration of function 'devm_regmap_init' [-Werror=implicit-function-declaration]
>>>      132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
>>>          |                  ^~~~~~~~~~~~~~~~
>>>    drivers/iio/accel/adxl367_spi.c:132:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>>>      132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
>>>          |                ^
>>>    drivers/iio/accel/adxl367_spi.c: At top level:
>>>    drivers/iio/accel/adxl367_spi.c:75:32: error: storage size of 'adxl367_spi_regmap_bus' isn't known
>>>       75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
>>>          |                                ^~~~~~~~~~~~~~~~~~~~~~
>>>    drivers/iio/accel/adxl367_spi.c:80:35: error: storage size of 'adxl367_spi_regmap_config' isn't known
>>>       80 | static const struct regmap_config adxl367_spi_regmap_config = {
>>>          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>    cc1: some warnings being treated as errors
>>>
>>>
>>> vim +76 drivers/iio/accel/adxl367_spi.c
>>>
>>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14  74  
>>> c922c634bd926d Javier Carrasco 2024-07-03  75  static const struct regmap_bus adxl367_spi_regmap_bus = {
>>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @76  	.read = adxl367_read,
>>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @77  	.write = adxl367_write,
>>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14  78  };
>>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14  79  
>>>
>>> :::::: The code at line 76 was first introduced by commit
>>> :::::: cbab791c5e2a58c123d84bd9202c054e5449bc96 iio: accel: add ADXL367 driver
>>>
>>> :::::: TO: Cosmin Tanislav <demonsingur@gmail.com>
>>> :::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>
>> Strange. I followed the "how to reproduce" guide step by step, but it
>> compiled just fine (gcc-12.3.0 instead of 12.2.0, though).
> 
> Sorry about false report, kindly ignore this. The bot side will look
> into the detail to resolve the issue asap.
> 

No worries. As I already mentioned, the bot has recently found cases
where the dependency was indeed missing, I am glad that it found those
even if it comes with a couple of false positives, which are easy to
verify anyway.

Best regards,
Javier Carrasco

