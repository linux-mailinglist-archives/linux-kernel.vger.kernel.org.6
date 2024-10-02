Return-Path: <linux-kernel+bounces-347082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45FD98CD95
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511991F2463A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A6F13D886;
	Wed,  2 Oct 2024 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va9Apfsi"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F347C6D4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727852642; cv=none; b=SY7ba4mR9vB1q3Eq14Ugv9MO1yey9JcAbOyWlLKR0uR1vY9CkdaCi2yp9J/lS9uS/K7bOtSAucogxs+HSNIFtEiX++CWG8XbE1B0ejTPWW5zHylJzuIUHd/2u21LhKyzwiFdY8YnsF0mi5eUpDYhe/Jn6vLmpC6Zi17WR9QV9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727852642; c=relaxed/simple;
	bh=Uj0IAM89efPEHzNKPafDKvOZwknsbqlnkFUHf+1/toc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JNzPQwCECoHcqmEEiRhDs5pUaJMna2wNLXyXIiJYUga4jo3fbt6H8L4PtcMyjcFBqhCvdLysAkxunz7XQsn6ZJEDVpcwkkIkiRjc0twDJA/iJO8wuOMSOHgIQFzQtlGCwKgvJDP5va4304Z8jmVFoUoWQKaGlYMPZOAjFK1FuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va9Apfsi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so1044003866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727852639; x=1728457439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MfLgbZ0lerkvVmlCA7Ez4P7ScBhB9oBdGhXV/eW+jqc=;
        b=Va9ApfsiXnO+4gp4Nk3E2CDQM27pIFzPvx84GvplQ3MVpu54alW7ARClhbhRnz+qlG
         IOt2hY4QLIKuVxXQn9i9/l4otcbOihBajTKq0qhEEgsFhdvOSii+/ryXrdD+1nBtIZVg
         jGUub4Rf1Q2iPHwZFcPZC/mQo2HRqFLDFj7a1rHn5iYVfno16I1CLhvYu6AJX8iBAtGp
         svu6ZgmtUahXvh3HLzs196wl53tYgIoRmd4ikgrbC3iXhTgRbSP0AwZKLiAWro2bhYXn
         2XTNPBu3/zCuAFCSzKO3cbgP2IBRNzKuRZAY2sjD0hq8lSWHWqw3qaThTW/xWPUU+qGZ
         HnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727852639; x=1728457439;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfLgbZ0lerkvVmlCA7Ez4P7ScBhB9oBdGhXV/eW+jqc=;
        b=Sdwit5vrGphV0tmVKrJZ20Umm5/b3S+M9JSa3R/YfAeYRNcZeLSaEFVNd+7T1K5W/I
         jR25o0bp1Gkrz2Zu2ObB+PNENlx7FzHZqu+V6+zUQS2yatcDdvMGKMKcWFzq3Wo58PGh
         umNhv+qm1BBliXBdbg3dqqV5xfL9r8SfRdPOhya4KpNzPugtNw8Bia7gTweJKh5w571V
         zrpANDy8sj5uJDT8qbWFQXvcTJLyCgvX3pCELzMFxIV2xKtMROkjxfTyHAsvkTEYMb++
         R8RAHCYglZFA5iYiG7GDRdDPK1QNhDYMksmNZP5vbjDUEzZdWL3bNUeMRGVydoyYKOhD
         31pg==
X-Forwarded-Encrypted: i=1; AJvYcCXL/QwQshALdZlGMhIZTfvOxf+9WohIEPHlLx44TlKN1WXW6XNxw3Iy3+6hpYP1LOq9FETrIMQxW8ejsgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUCyJWf3JXi0LL3K7pgQbDAs81U/4gvyov2+wp1bRaXfofhgA
	cwWxZU7j4Wb3YwaXEfjo0eez3Nk6g6WHGBi+I9NDqIRiuSnoAaLJ
X-Google-Smtp-Source: AGHT+IG3SGDzcIWyBeu3ujrWa6jXxaLSF/GLQwv451kIIZCTw28o7u8cx1bH9cADQ2tZx/vxEgSo2A==
X-Received: by 2002:a17:906:dac3:b0:a86:6a26:fec7 with SMTP id a640c23a62f3a-a98f827a28amr177189466b.30.1727852638606;
        Wed, 02 Oct 2024 00:03:58 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70dfsm825384466b.52.2024.10.02.00.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 00:03:57 -0700 (PDT)
Message-ID: <1941443e-7685-48b7-8201-7700877d9ec7@gmail.com>
Date: Wed, 2 Oct 2024 09:03:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct
 regmap_bus' has no member named 'read'
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <202410021111.LknEX9ne-lkp@intel.com>
 <6e935f30-6dc5-4422-842d-068c08d31333@gmail.com>
Content-Language: en-US, de-AT
In-Reply-To: <6e935f30-6dc5-4422-842d-068c08d31333@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/10/2024 09:01, Javier Carrasco wrote:
> On 02/10/2024 05:21, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
>> commit: c922c634bd926d84967275efbb7275b8645aa343 iio: accel: adxl367: Constify struct regmap_bus
>> date:   9 weeks ago
>> config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/config)
>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202410021111.LknEX9ne-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>    In file included from include/linux/sched.h:38,
>>                     from include/linux/percpu.h:12,
>>                     from arch/x86/include/asm/msr.h:15,
>>                     from arch/x86/include/asm/tsc.h:10,
>>                     from arch/x86/include/asm/timex.h:6,
>>                     from include/linux/timex.h:67,
>>                     from include/linux/time32.h:13,
>>                     from include/linux/time.h:60,
>>                     from include/linux/stat.h:19,
>>                     from include/linux/module.h:13,
>>                     from drivers/iio/accel/adxl367_spi.c:8:
>>    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
>>       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
>>          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/mm.h:2888:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
>>     2888 | #if USE_SPLIT_PTE_PTLOCKS
>>          |     ^~~~~~~~~~~~~~~~~~~~~
>>    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
>>       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
>>          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
>>       20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
>>          |                                  ^~~~~~~~~~~~~~~~~~~~~
>>    include/linux/mm.h:3010:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
>>     3010 | #if USE_SPLIT_PMD_PTLOCKS
>>          |     ^~~~~~~~~~~~~~~~~~~~~
>>    drivers/iio/accel/adxl367_spi.c:75:21: error: variable 'adxl367_spi_regmap_bus' has initializer but incomplete type
>>       75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
>>          |                     ^~~~~~~~~~
>>>> drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct regmap_bus' has no member named 'read'
>>       76 |         .read = adxl367_read,
>>          |          ^~~~
>>    drivers/iio/accel/adxl367_spi.c:76:17: warning: excess elements in struct initializer
>>       76 |         .read = adxl367_read,
>>          |                 ^~~~~~~~~~~~
>>    drivers/iio/accel/adxl367_spi.c:76:17: note: (near initialization for 'adxl367_spi_regmap_bus')
>>>> drivers/iio/accel/adxl367_spi.c:77:10: error: 'const struct regmap_bus' has no member named 'write'
>>       77 |         .write = adxl367_write,
>>          |          ^~~~~
>>    drivers/iio/accel/adxl367_spi.c:77:18: warning: excess elements in struct initializer
>>       77 |         .write = adxl367_write,
>>          |                  ^~~~~~~~~~~~~
>>    drivers/iio/accel/adxl367_spi.c:77:18: note: (near initialization for 'adxl367_spi_regmap_bus')
>>    drivers/iio/accel/adxl367_spi.c:80:21: error: variable 'adxl367_spi_regmap_config' has initializer but incomplete type
>>       80 | static const struct regmap_config adxl367_spi_regmap_config = {
>>          |                     ^~~~~~~~~~~~~
>>    drivers/iio/accel/adxl367_spi.c:81:10: error: 'const struct regmap_config' has no member named 'reg_bits'
>>       81 |         .reg_bits = 8,
>>          |          ^~~~~~~~
>>    drivers/iio/accel/adxl367_spi.c:81:21: warning: excess elements in struct initializer
>>       81 |         .reg_bits = 8,
>>          |                     ^
>>    drivers/iio/accel/adxl367_spi.c:81:21: note: (near initialization for 'adxl367_spi_regmap_config')
>>    drivers/iio/accel/adxl367_spi.c:82:10: error: 'const struct regmap_config' has no member named 'val_bits'
>>       82 |         .val_bits = 8,
>>          |          ^~~~~~~~
>>    drivers/iio/accel/adxl367_spi.c:82:21: warning: excess elements in struct initializer
>>       82 |         .val_bits = 8,
>>          |                     ^
>>    drivers/iio/accel/adxl367_spi.c:82:21: note: (near initialization for 'adxl367_spi_regmap_config')
>>    drivers/iio/accel/adxl367_spi.c: In function 'adxl367_spi_probe':
>>    drivers/iio/accel/adxl367_spi.c:132:18: error: implicit declaration of function 'devm_regmap_init' [-Werror=implicit-function-declaration]
>>      132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
>>          |                  ^~~~~~~~~~~~~~~~
>>    drivers/iio/accel/adxl367_spi.c:132:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>>      132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
>>          |                ^
>>    drivers/iio/accel/adxl367_spi.c: At top level:
>>    drivers/iio/accel/adxl367_spi.c:75:32: error: storage size of 'adxl367_spi_regmap_bus' isn't known
>>       75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
>>          |                                ^~~~~~~~~~~~~~~~~~~~~~
>>    drivers/iio/accel/adxl367_spi.c:80:35: error: storage size of 'adxl367_spi_regmap_config' isn't known
>>       80 | static const struct regmap_config adxl367_spi_regmap_config = {
>>          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>>    cc1: some warnings being treated as errors
>>
>>
>> vim +76 drivers/iio/accel/adxl367_spi.c
>>
>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14  74  
>> c922c634bd926d Javier Carrasco 2024-07-03  75  static const struct regmap_bus adxl367_spi_regmap_bus = {
>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @76  	.read = adxl367_read,
>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @77  	.write = adxl367_write,
>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14  78  };
>> cbab791c5e2a58 Cosmin Tanislav 2022-02-14  79  
>>
>> :::::: The code at line 76 was first introduced by commit
>> :::::: cbab791c5e2a58c123d84bd9202c054e5449bc96 iio: accel: add ADXL367 driver
>>
>> :::::: TO: Cosmin Tanislav <demonsingur@gmail.com>
>> :::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
> 
> Strange. I followed the "how to reproduce" guide step by step, but it
> compiled just fine (gcc-12.3.0 instead of 12.2.0, though).
> 
> On the other hand, there has been a similar bug in hwmon[1] and it had
> nothing to do with making the struct const, which actually uncovered a
> missing select (in that case REGMAP_I2C).
> 
> In this particular case, 'select REGMAP_SPI' is present in the Kconfig
> entry for the driver, and the header is included in adxl367_spi.c. The
> only thing is that the driver uses devm_regmap_init() instead of
> devm_regmap_init_spi(), and other drivers that include REGMAP_SPI use
> that one. Does that make sense?
> 
> Best regards,
> Javier Carrasco

Link:
https://lore.kernel.org/oe-kbuild-all/202410020246.2cTDDx0X-lkp@intel.com/
[1]

