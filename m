Return-Path: <linux-kernel+bounces-347077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5C98CD80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38648284C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1F92BB13;
	Wed,  2 Oct 2024 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0TswtUq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FB2E62B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727852518; cv=none; b=hCaXhOoZoRrbpJ8PQ7wD+dCdqdeXG5PSj+2qw7Rp3YtRNs+WskSnsCG3/+tXuQ9pQ2O8fCmp8fo6mwnyJcdogk9QgU/f608wzPAvngGrbRphIYCb5KLhzXpclP++ZYvhlmLCgMaWFfIwQoVgRFWzUaoLVK7VSR6z16PzM/O4eBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727852518; c=relaxed/simple;
	bh=w3ByWUGDacJz3hEad7dpzeV38OeTYdN4eIoj28LyCN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAPxXkvAhmYXKBGutWezwCJy8npS86Gbu6vyZV4bCweO7CMzO1F5CW5PDgTap2vujEG8BeKbGHlHxAKL75Y9Y2KKnyJol6pq2vwMVkfyQOf+nsiqMHVcyEw1MlC7ri/67tZXAFgVb5lvxPU9qAYycGkb7xLmoEgYOp9B8I9hGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0TswtUq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d3cde1103so876091766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727852515; x=1728457315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KkFrOyaNzR673lhHDlI7pjBT4UUSfE9CWZNwFPLT3cs=;
        b=I0TswtUqwSNJs6KyrhayUZav7MOslwAO6bTg5+xzYOBL6ZOsfKW5ORbcGOce9kc73u
         RkIRWhGDLL3NI8yEeHOYfNlUs6J3nFnhTYB3+I6YHyo5lxsKEefhtzN4YINdHMa0ARoS
         ERFp6w8bWN4UKfVkLG1+RURwEhJ5xlhX/Qd16uIcPJ3ZHllLl+hIOYoIfxfD4kqVq2D2
         zgYW7tBh954MpqoQo51ov4f1wgLoIG3GG5+Be7ibQD+K5tFILtGRTi/CH5hvwUC5IWju
         MUE2i/dUZq3T2vhShij7TLI4RMTi/DvVhoLkTMN5ncN8hGzZnadHorosYp2sHMMHvtyy
         GG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727852515; x=1728457315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkFrOyaNzR673lhHDlI7pjBT4UUSfE9CWZNwFPLT3cs=;
        b=d1yLmZt9chGm+uKYD34ODyXPES6DvEWXYTSsupdOP3UczSoupAOdxVO0yylqr6mvmU
         CkZ6RjHqE0RokKLirCrpOZ3pYw9AfY2aGC/fw/sp/3y+RspZBLl1Hm8QRdybjllgj3bS
         wOvddY3dWSbIYSd5QGsoxYK6998S/yUPfuPL+KYj8up2iEayv7EFObzXIS62rm9SWNlV
         x04uSC7MhSXVueKMKObufSZ6KCFcEzS7LyxqZVd2XMYunMqdIVDjNPe9JZx9UX3seTfN
         Fi1Gyo8nu74SXdtE0dI5umzZzuFItx0HnCKr7oWFTs0Z3UZ6H1K2xcnIWK/h9RlyCDlv
         PGLA==
X-Forwarded-Encrypted: i=1; AJvYcCXxQLz668tuc9zyx6/0gCO3QoPTqULx4hah1LQkua5wMfJTSnrrh6bSvMng1gGUpk6SrR5xTXQNNijyyr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs480jpbK82EWerRunVgD7cSxirAK6EQDZdKWE0+x2cfVftM6j
	2yiW+gJvHKieUcUTgDkhIhTKlw5i+ihJye8wlbkz0Gynh0vE98sP9M6eq+y/
X-Google-Smtp-Source: AGHT+IHXeadNk1exUsxe+i8UimN5GpS6n/TD3oJvptGfCZqDr6jkpDRf5wpqGjZNp/R6As23blyKsQ==
X-Received: by 2002:a17:907:7ba7:b0:a8a:43bd:a9e8 with SMTP id a640c23a62f3a-a98f838e0a4mr231333766b.65.1727852514542;
        Wed, 02 Oct 2024 00:01:54 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27d293asm819264566b.88.2024.10.02.00.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 00:01:52 -0700 (PDT)
Message-ID: <6e935f30-6dc5-4422-842d-068c08d31333@gmail.com>
Date: Wed, 2 Oct 2024 09:01:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct
 regmap_bus' has no member named 'read'
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <202410021111.LknEX9ne-lkp@intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <202410021111.LknEX9ne-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/10/2024 05:21, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> commit: c922c634bd926d84967275efbb7275b8645aa343 iio: accel: adxl367: Constify struct regmap_bus
> date:   9 weeks ago
> config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410021111.LknEX9ne-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/sched.h:38,
>                     from include/linux/percpu.h:12,
>                     from arch/x86/include/asm/msr.h:15,
>                     from arch/x86/include/asm/tsc.h:10,
>                     from arch/x86/include/asm/timex.h:6,
>                     from include/linux/timex.h:67,
>                     from include/linux/time32.h:13,
>                     from include/linux/time.h:60,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:13,
>                     from drivers/iio/accel/adxl367_spi.c:8:
>    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
>       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
>          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm.h:2888:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
>     2888 | #if USE_SPLIT_PTE_PTLOCKS
>          |     ^~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
>       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
>          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
>       20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
>          |                                  ^~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm.h:3010:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
>     3010 | #if USE_SPLIT_PMD_PTLOCKS
>          |     ^~~~~~~~~~~~~~~~~~~~~
>    drivers/iio/accel/adxl367_spi.c:75:21: error: variable 'adxl367_spi_regmap_bus' has initializer but incomplete type
>       75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
>          |                     ^~~~~~~~~~
>>> drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct regmap_bus' has no member named 'read'
>       76 |         .read = adxl367_read,
>          |          ^~~~
>    drivers/iio/accel/adxl367_spi.c:76:17: warning: excess elements in struct initializer
>       76 |         .read = adxl367_read,
>          |                 ^~~~~~~~~~~~
>    drivers/iio/accel/adxl367_spi.c:76:17: note: (near initialization for 'adxl367_spi_regmap_bus')
>>> drivers/iio/accel/adxl367_spi.c:77:10: error: 'const struct regmap_bus' has no member named 'write'
>       77 |         .write = adxl367_write,
>          |          ^~~~~
>    drivers/iio/accel/adxl367_spi.c:77:18: warning: excess elements in struct initializer
>       77 |         .write = adxl367_write,
>          |                  ^~~~~~~~~~~~~
>    drivers/iio/accel/adxl367_spi.c:77:18: note: (near initialization for 'adxl367_spi_regmap_bus')
>    drivers/iio/accel/adxl367_spi.c:80:21: error: variable 'adxl367_spi_regmap_config' has initializer but incomplete type
>       80 | static const struct regmap_config adxl367_spi_regmap_config = {
>          |                     ^~~~~~~~~~~~~
>    drivers/iio/accel/adxl367_spi.c:81:10: error: 'const struct regmap_config' has no member named 'reg_bits'
>       81 |         .reg_bits = 8,
>          |          ^~~~~~~~
>    drivers/iio/accel/adxl367_spi.c:81:21: warning: excess elements in struct initializer
>       81 |         .reg_bits = 8,
>          |                     ^
>    drivers/iio/accel/adxl367_spi.c:81:21: note: (near initialization for 'adxl367_spi_regmap_config')
>    drivers/iio/accel/adxl367_spi.c:82:10: error: 'const struct regmap_config' has no member named 'val_bits'
>       82 |         .val_bits = 8,
>          |          ^~~~~~~~
>    drivers/iio/accel/adxl367_spi.c:82:21: warning: excess elements in struct initializer
>       82 |         .val_bits = 8,
>          |                     ^
>    drivers/iio/accel/adxl367_spi.c:82:21: note: (near initialization for 'adxl367_spi_regmap_config')
>    drivers/iio/accel/adxl367_spi.c: In function 'adxl367_spi_probe':
>    drivers/iio/accel/adxl367_spi.c:132:18: error: implicit declaration of function 'devm_regmap_init' [-Werror=implicit-function-declaration]
>      132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
>          |                  ^~~~~~~~~~~~~~~~
>    drivers/iio/accel/adxl367_spi.c:132:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
>          |                ^
>    drivers/iio/accel/adxl367_spi.c: At top level:
>    drivers/iio/accel/adxl367_spi.c:75:32: error: storage size of 'adxl367_spi_regmap_bus' isn't known
>       75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
>          |                                ^~~~~~~~~~~~~~~~~~~~~~
>    drivers/iio/accel/adxl367_spi.c:80:35: error: storage size of 'adxl367_spi_regmap_config' isn't known
>       80 | static const struct regmap_config adxl367_spi_regmap_config = {
>          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +76 drivers/iio/accel/adxl367_spi.c
> 
> cbab791c5e2a58 Cosmin Tanislav 2022-02-14  74  
> c922c634bd926d Javier Carrasco 2024-07-03  75  static const struct regmap_bus adxl367_spi_regmap_bus = {
> cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @76  	.read = adxl367_read,
> cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @77  	.write = adxl367_write,
> cbab791c5e2a58 Cosmin Tanislav 2022-02-14  78  };
> cbab791c5e2a58 Cosmin Tanislav 2022-02-14  79  
> 
> :::::: The code at line 76 was first introduced by commit
> :::::: cbab791c5e2a58c123d84bd9202c054e5449bc96 iio: accel: add ADXL367 driver
> 
> :::::: TO: Cosmin Tanislav <demonsingur@gmail.com>
> :::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Strange. I followed the "how to reproduce" guide step by step, but it
compiled just fine (gcc-12.3.0 instead of 12.2.0, though).

On the other hand, there has been a similar bug in hwmon[1] and it had
nothing to do with making the struct const, which actually uncovered a
missing select (in that case REGMAP_I2C).

In this particular case, 'select REGMAP_SPI' is present in the Kconfig
entry for the driver, and the header is included in adxl367_spi.c. The
only thing is that the driver uses devm_regmap_init() instead of
devm_regmap_init_spi(), and other drivers that include REGMAP_SPI use
that one. Does that make sense?

Best regards,
Javier Carrasco

