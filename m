Return-Path: <linux-kernel+bounces-258542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066DD93896F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09C22832CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75228DCB;
	Mon, 22 Jul 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ3+fgru"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8FD2E634
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631302; cv=none; b=PuZDga0BTxrRa8qxY+RMwUtvj8GtGIH0HvChk3UkfnzZRBnM56oirspUM0PFficJbBOYs1qQZSdy6EPE6/f1DtxcUORsbSaLyxZtGu3nDOQCyapVb2Hj8bhcSDmxniLhYfA9dG6Drtbs/EarIDwbW+sPnhfjtVCWzp29txxx2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631302; c=relaxed/simple;
	bh=TadHWprxeqczU1omBo9k71lvvzibr/Y/qG/e6fX2EoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KV2dfEdVyfmXmfwU1rwBb87BU8vGZUQoIrMwxTZZIyIJAv/z0nU7UuHysmlQtw+hd3tVAVTn+2FENtUc8BHfkG4pwEwSGMOWeC14neX1etMIRoxbsZ40rHeIh4e+y8fH148OPQtTwe2vrIBKs+ylUM5x0BGOrC1hNObJ04YC4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ3+fgru; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so1111039e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721631298; x=1722236098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKkrJoqiwDwF/CbmpCh8eKLwjKgRH/Uyc7GjdOmHdxA=;
        b=CJ3+fgru+BXSOr7Bz1IHmdxp7R23iBqQkRw8b1JoZnfwnbLUQ6EuMRGos/eDa8Rayr
         U07++P1CjG2qAso/8zzxEwqQoWhAY/YHBke/ptzImKnP1+aGhLWWVavIk8Y30zbTWafQ
         YTS/w/eCndi5RvBA+ybrEwHLpjgKFmuGDhKw7QeWmpKFsDhAwzWQ7Wyc82YcPwhKNjX8
         y0dxY0pAvj/n02iB8GJ6wYEcP3KUN6nMTHzFHyqlhJoRiQnUQAiywc/mOd9QGI/DxPax
         1Dk/eSa5R6pmwzUpZZBfE0+EpbbaXsklgexVLKFIj3vbVN00+YGlOTgVIrCx3IDwRgLN
         1g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721631298; x=1722236098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKkrJoqiwDwF/CbmpCh8eKLwjKgRH/Uyc7GjdOmHdxA=;
        b=npHRG2Mc8iLJPiaPDCL/1ReeFR1E3noy/RIaccX/BimV7b+TctAJPxKk97Bkf1Fddc
         j1WRkW3UWJ5K0cEPTw30YEYsGQjDZnuB/O+170Timr/Ws9/qeD9FAh/isZHXRUDiZNV+
         db2557AD5fPBsgqRa4oQCpdLgyUbW9rNYTIQo+HSR6cqcJ2rWpwMw7lFuCKbyghL/36+
         dzM3/l00GdHoHxEl6uaAtKHdp2huldewvoMnp791kwwgxywZcH3vIY7B1mOKmkIgxipA
         O0FXiZ3VAbqbYdlbGGxr5IZKb6k9/vmgZr4FMbfPYDDi2XG/oFfzZxhKVqs/pxv1YEKQ
         uc/w==
X-Forwarded-Encrypted: i=1; AJvYcCW2kb+ur73xHd/uJla0Nt4W1VOXdQ7jjx4FdzIsNpRjhKDGkJp2zmNeyHOPt3qa0oYOJgixGQT7hFRMzdDN20+crVYcPuGnPj6mkTqv
X-Gm-Message-State: AOJu0Yxf1nLXpQ7rG4feJb01+mxKicNQ0uS5YCRny47k0trP/Cyoa3ZA
	cKGZizn6qNumLxjSUMoRyDnJDSj+mjofgfEulgM6D8SwoCoC6FHX
X-Google-Smtp-Source: AGHT+IGi8uLJ/vnTH9E1IJnO6DF3D8fv+A1mIxNCOIDTWYyo4pAbjfrFIDrYGsOkCoUDil7pSQjztQ==
X-Received: by 2002:a05:6512:2341:b0:52e:8b15:7c55 with SMTP id 2adb3069b0e04-52ef8d9cc74mr3284547e87.27.1721631297812;
        Sun, 21 Jul 2024 23:54:57 -0700 (PDT)
Received: from [192.168.0.2] (40.37.82.80.dsl-dynamic.vsi.ru. [80.82.37.40])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52efdf47f0csm639564e87.90.2024.07.21.23.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 23:54:57 -0700 (PDT)
Message-ID: <3d14b0c8-3c25-4a9a-b84a-192f071fa919@gmail.com>
Date: Mon, 22 Jul 2024 09:54:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: Add support for HeYangTek HYF1GQ4UDACAE
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240624061246.5292-1-maxim.anisimov.ua@gmail.com>
 <20240701095906.2bc4a0d2@xps-13>
Content-Language: en-US
From: Maxim Anisimov <maxim.anisimov.ua@gmail.com>
In-Reply-To: <20240701095906.2bc4a0d2@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miquel,

Sorry for late answer. I was on vocation. To be honest, I don't 
understand very well how this works. One of the OpenWrt developers asked 
me to send this patch to Linux upstream. Related OpenWrt pull request is 
here https://github.com/openwrt/openwrt/pull/15551 . Originally this 
patch code was taken from the device manufacturer's repository 
https://github.com/keenetic/kernel-49/commit/bacade569fb12bc0ad31ba09bca9b890118fbca7 
. I pointed to this in the source code. From my side I only adapted the 
code for successful compilation on the Linux upstream. It's difficult 
for me to answer your questions because I don't understand how the spi 
nand framework works. I can make corrections in the patch but with 
outside help. Thanks!

> Hi Maxim,
>
> maxim.anisimov.ua@gmail.com wrote on Mon, 24 Jun 2024 09:12:17 +0300:
>
>> Add Support HeYangTek HYF1GQ4UDACAE SPI NAND.
>>
>> Datasheet Link:
>> - https://www.heyangtek.cn/previewfile.jsp?file=ABUIABA9GAAgwsvRnwYo-eDpsgc
> Thanks for the patch! Few comments below.
>
>> Signed-off-by: Maxim Anisimov <maxim.anisimov.ua@gmail.com>
>> ---
>>   drivers/mtd/nand/spi/Makefile    |   4 +-
>>   drivers/mtd/nand/spi/core.c      |   1 +
>>   drivers/mtd/nand/spi/heyangtek.c | 112 +++++++++++++++++++++++++++++++
>>   include/linux/mtd/spinand.h      |   1 +
>>   4 files changed, 116 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/mtd/nand/spi/heyangtek.c
>>
>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
>> index 19cc77288ebb..69d95fbdd0ce 100644
>> --- a/drivers/mtd/nand/spi/Makefile
>> +++ b/drivers/mtd/nand/spi/Makefile
>> @@ -1,4 +1,4 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
>> -spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
>> +spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o heyangtek.o
>> +spinand-objs += macronix.o micron.o paragon.o toshiba.o winbond.o xtx.o
>>   obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index e0b6715e5dfe..45795e5f1e49 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -942,6 +942,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>>   	&esmt_c8_spinand_manufacturer,
>>   	&foresee_spinand_manufacturer,
>>   	&gigadevice_spinand_manufacturer,
>> +	&heyangtek_spinand_manufacturer,
>>   	&macronix_spinand_manufacturer,
>>   	&micron_spinand_manufacturer,
>>   	&paragon_spinand_manufacturer,
>> diff --git a/drivers/mtd/nand/spi/heyangtek.c b/drivers/mtd/nand/spi/heyangtek.c
>> new file mode 100644
>> index 000000000000..d4a5dbca40fb
>> --- /dev/null
>> +++ b/drivers/mtd/nand/spi/heyangtek.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Author:
>> + *      Andrey Zolotarev <andrey.zolotarev@keenetic.com> - the main driver logic
>> + *      Maxim Anisimov <maxim.anisimov.ua@gmail.com> - adaptation to mainline linux kernel
>> + *
>> + * Based on:
>> + *      https://github.com/keenetic/kernel-49/commit/bacade569fb12bc0ad31ba09bca9b890118fbca7
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mtd/spinand.h>
>> +
>> +#define SPINAND_MFR_HEYANGTEK		0xC9
>> +
>> +#define STATUS_ECC_LIMIT_BITFLIPS	(3 << 4)
>> +
>> +static SPINAND_OP_VARIANTS(read_cache_variants,
>> +		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
>> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
>> +
>> +static SPINAND_OP_VARIANTS(write_cache_variants,
>> +		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
>> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
>> +
>> +static SPINAND_OP_VARIANTS(update_cache_variants,
>> +		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>> +
>> +static int hyfxgq4uda_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +				   struct mtd_oob_region *region)
>> +{
>> +	if (section > 3)
>> +		return -ERANGE;
>> +
>> +	region->offset = section * 16 + 8;
>> +	region->length = 8;
> This is: 8-15, 24-31, 40-47, 56-62
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int hyfxgq4uda_ooblayout_free(struct mtd_info *mtd, int section,
>> +				   struct mtd_oob_region *region)
>> +{
>> +	if (section > 3)
>> +		return -ERANGE;
>> +
>> +	/* ECC-protected user meta-data */
>> +	region->offset = section * 16 + 4;
>> +	region->length = 4;
> This is: 4-7, 20-23, 32-35, 48-51
>
> So what about 2-4, 16-19, 36-39, 52-55, 63-64 ?
>
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mtd_ooblayout_ops hyfxgq4uda_ooblayout = {
>> +	.ecc = hyfxgq4uda_ooblayout_ecc,
>> +	.free = hyfxgq4uda_ooblayout_free,
>> +};
>> +
>> +static int hyfxgq4uda_ecc_get_status(struct spinand_device *spinand,
>> +				     u8 status)
>> +{
>> +	struct nand_device *nand = spinand_to_nand(spinand);
>> +
>> +	switch (status & STATUS_ECC_MASK) {
>> +	case STATUS_ECC_NO_BITFLIPS:
>> +		return 0;
>> +
>> +	case STATUS_ECC_UNCOR_ERROR:
>> +		return -EBADMSG;
>> +
>> +	case STATUS_ECC_HAS_BITFLIPS:
>> +		return nanddev_get_ecc_conf(nand)->strength >> 1;
> Maybe an explanation of this line is needed. Is this just guessing or
> is this defined in the datasheet?
>
> Also please do not use shifts when you want to divide. Just use / 2
> which is easier to understand. Compilers know how to optimize that.
>
>> +
>> +	case STATUS_ECC_LIMIT_BITFLIPS:
>> +		return nanddev_get_ecc_conf(nand)->strength;
>> +
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct spinand_info heyangtek_spinand_table[] = {
>> +	SPINAND_INFO("HYF1GQ4UDACAE",
>> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x21),
>> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>> +		     NAND_ECCREQ(4, 512),
>> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +					      &write_cache_variants,
>> +					      &update_cache_variants),
>> +		     SPINAND_HAS_QE_BIT,
>> +		     SPINAND_ECCINFO(&hyfxgq4uda_ooblayout,
>> +				     hyfxgq4uda_ecc_get_status)),
>> +};
>> +
>> +static const struct spinand_manufacturer_ops heyangtek_spinand_manuf_ops = {
>> +};
>> +
>> +const struct spinand_manufacturer heyangtek_spinand_manufacturer = {
>> +	.id = SPINAND_MFR_HEYANGTEK,
>> +	.name = "HeYangTek",
>> +	.chips = heyangtek_spinand_table,
>> +	.nchips = ARRAY_SIZE(heyangtek_spinand_table),
>> +	.ops = &heyangtek_spinand_manuf_ops,
>> +};
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index 5c19ead60499..06ee35a27e3b 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -265,6 +265,7 @@ extern const struct spinand_manufacturer ato_spinand_manufacturer;
>>   extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
>>   extern const struct spinand_manufacturer foresee_spinand_manufacturer;
>>   extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
>> +extern const struct spinand_manufacturer heyangtek_spinand_manufacturer;
>>   extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>>   extern const struct spinand_manufacturer micron_spinand_manufacturer;
>>   extern const struct spinand_manufacturer paragon_spinand_manufacturer;
>
> Thanks,
> Miquèl

Thanks,

Maxim


