Return-Path: <linux-kernel+bounces-331586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED6497AE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494ED1F22944
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F375161914;
	Tue, 17 Sep 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pQfdFyYR"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185B1662F1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568106; cv=none; b=iAbSpUNWMuJ2ji3p2dRyD6fAPtFyZhhCwX+EsD3qUvkoKPgU0LCMZKu8/iAnOzOHvyYoRzZ2ttmY1FwljVWyvnrugmdVrqAkCUUe9R8MP2bzNMZ9B8hkj+5/PuG0dUajGtMvMCVf/tZec3wXktmGgm/950U3NJ4RLclx6Oz0xOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568106; c=relaxed/simple;
	bh=6FI4ELZfkt+Ly2lRc6Jl0jBDQ2IVkUnDhbQCrpwwT8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8s4aIoBWt+4sTYQZSecuYXOJXKTVRfAZ0A93gsCbO3aCxb3yI6kFKx27wnr/3fQ36FjVsPCXcX5An8HFlU8lFGtFHoRF/YkNyeMNOvuDzGT+r7iIPAzie8HQZ7A+Xexqm6EX9UPrvXmECtHqNdXDsuO5L3EJ/LVxOmaCpxG7iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pQfdFyYR; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1726568096;
	bh=6z33IIKt4FbUhsPdsPA+iW/KHxWmVjzuOsPQKjuX3Bg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pQfdFyYRqD3GP+dT9JuVbNyP3UQ6cRptsW7wK7bPUNbOVY4cnHho6cZD+Ie1XrAG/
	 vyCKfd0bQKOKe5qju9CT7se0ow8CXDB3a5Zezyi7GKup5gg8fBu5UILilnK9P95REM
	 vPIGTaqZPSkfrYd4nsbalSJFKu4+vxd5W073HSyc=
Received: from [198.18.0.1] ([171.223.88.248])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 3B4A38E0; Tue, 17 Sep 2024 18:14:52 +0800
X-QQ-mid: xmsmtpt1726568092tonmzfhgm
Message-ID: <tencent_56E242E79B56D8242E5853B3FD35A849AA07@qq.com>
X-QQ-XMAILINFO: NkDBiFrpY1d6gKYthOMwghg3UJfKWOcyqzGOMCHHmj5wmnlz8fGTshl045Bydu
	 sn61/A2UJ6eHCS1EZIrlqyRWB6GT6JI/QybvtyJ4/3/unuHt/+ycTO515eYK15UUYpppfWcybg1R
	 ipYaT8eIkTtCLIsmZ1dL1lUZXrFeU+AbOkNzajznaScV9Rm5S9ZIHPR7awT8Rc0+aPGcmXkHsoaS
	 /j0FF0tZu8R8i0WfK8N08j6BdK7wUcdsZ27QuCQmAViLiwRjwuQLXqZcSec7azG0zwhtM8BDDhId
	 Aodkjl9igEVIYdw76Gal8oT9MpNe8YXdozVOBbqLJepjjsUDxF8nW3WzT1/iD+Ob653B02GlsE+S
	 sVZUvem57wxdhll+8AZP+QwEz6EOddo4PGFmdo2g6ny4XaSxs8vh7SjoXZXEKoDb61PQvUmDUuRa
	 4xq0XTFnlFzo390Aazbtm2NN1nXz6n24aiZzfINxdimSMY5gykUrW0m5/kkxU1MrUHBGAaA79X/u
	 +z5o6POQMusNYtnrGtQDEiVmbcg1y0BDTY5AeyRZCJVT0/7YW5aXn48ZidPfHYd6BuOxoFFQApWU
	 3Nt29DRJvZNG3mmB/OCixB/6DkEKeOAv79iEvXiSv4/YtGqitcYS+F/N5Hu98ftMNejenh2vVv0f
	 MekZkY1IYZbAJSrpWLURw9e8mIgPtU35WOfr71JBE6dgRJo1/1dHIrXc8pvcbJd+oGnwkskvWs1T
	 gcsH8oR6vnDNsAxR4ul1hsXhWKfvijGdk2auRIyCDhiwvcByVVdIkmpy+1t+JH8NDNgNA+tuq/d4
	 qanxisyvnrGOEi+aDD/aNkTi1pgoiCmTlxj6KWpyXjgjOahWvU+fnGXGQDxSFwb1oyD2OxIOZ21i
	 VMns0hayHEeHvAjtYbUF3SAHIBB1UW7q36+9ZexfCmA1uiZiyL8F5X18kIfBxKgG42oT3j/88A2M
	 a++801mk5uxax5Xywye4QTzeoR9MtQHEGWN5YHkluqZihdH8nxpKsec9XK7entwFFpYXx1O6sIKn
	 BEdXEFxvY+F13eGCpzuHted52mwo+rikaJ9p61NAB5iXm4TWApixmIRqCbb/QuPCq+L/D+ILFQVy
	 CsFAmMYfG2tICLK7Eku29KkKf/t9sYmmiWEcHVLoL5AhftpLU=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <ec2ff7dc-82b0-416c-bb4e-d6f4115b5c15@foxmail.com>
Date: Tue, 17 Sep 2024 18:14:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Add support for gd25 and gd55 series chips.
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 tudor.ambarus@linaro.org, pratyush@kernel.org, mwalle@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_983A0FB4662661C03E98E1AC214E32179F0A@qq.com>
 <47e0745c-e7a4-4201-b1bf-bb8e44e5911d@wanadoo.fr>
Content-Language: en-US
From: Renjun Wang <renjunw0@foxmail.com>
In-Reply-To: <47e0745c-e7a4-4201-b1bf-bb8e44e5911d@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/7/24 15:04, Christophe JAILLET wrote:
> Le 07/09/2024 à 08:32, Renjun Wang a écrit :
>> Add support for gd25lq255, gd25lb256, gd25lb512m, gd25b512m, gd55b01ge
>> and gd55lb01ge. All these chips are tested on Rockchip boards[1].
>>
>> [1]https://github.com/rockchip-linux/kernel/blob/develop-5.10/drivers/mtd/spi-nor/gigadevice.c 
>>
>>
>> Signed-off-by: Renjun Wang <renjunw0@foxmail.com>
>> ---
>>   drivers/mtd/spi-nor/gigadevice.c | 43 ++++++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/gigadevice.c 
>> b/drivers/mtd/spi-nor/gigadevice.c
>> index ef1edd0add70..f0069a4adbbf 100644
>> --- a/drivers/mtd/spi-nor/gigadevice.c
>> +++ b/drivers/mtd/spi-nor/gigadevice.c
>> @@ -61,6 +61,7 @@ static const struct flash_info 
>> gigadevice_nor_parts[] = {
>>       }, {
>>           .id = SNOR_ID(0xc8, 0x40, 0x19),
>>           .name = "gd25q256",
>> +        .size = SZ_32M,
>
> Hi, just for my understanding, why this change?
>
> If it is a fix, should it be done a separate patch?
> Or should it be mentioned in the commit description?
>
> CJ
>
>>           .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | 
>> SPI_NOR_TB_SR_BIT6,
>>           .fixups = &gd25q256_fixups,
>>           .fixup_flags = SPI_NOR_4B_OPCODES,
>> @@ -82,6 +83,48 @@ static const struct flash_info 
>> gigadevice_nor_parts[] = {
>>           .size = SZ_16M,
>>           .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>>           .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ,
>> +    }, {
>> +        .id = SNOR_ID(0xc8, 0x60, 0x19),
>> +        .name = "gd25lq255",
>> +        .size = SZ_32M,
>> +        .flags = SPI_NOR_HAS_LOCK,
>> +        .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ,
>> +        .fixup_flags = SPI_NOR_4B_OPCODES,
>> +    }, {
>> +        .id = SNOR_ID(0xc8, 0x67, 0x19),
>> +        .name = "gd25lb256",
>> +        .size = SZ_32M,
>> +        .flags = SPI_NOR_HAS_LOCK,
>> +        .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ,
>> +        .fixup_flags = SPI_NOR_4B_OPCODES,
>> +    }, {
>> +        .id = SNOR_ID(0xc8, 0x67, 0x1a),
>> +        .name = "gd25lb512m",
>> +        .size = SZ_64M,
>> +        .flags = SPI_NOR_HAS_LOCK,
>> +        .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ,
>> +        .fixup_flags = SPI_NOR_4B_OPCODES,
>> +    }, {
>> +        .id = SNOR_ID(0xc8, 0x47, 0x1a),
>> +        .name = "gd25b512m",
>> +        .size = SZ_64M,
>> +        .flags = SPI_NOR_HAS_LOCK,
>> +        .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ,
>> +        .fixup_flags = SPI_NOR_4B_OPCODES,
>> +    }, {
>> +        .id = SNOR_ID(0xc8, 0x47, 0x1b),
>> +        .name = "gd55b01ge",
>> +        .size = SZ_128M,
>> +        .flags = SPI_NOR_HAS_LOCK,
>> +        .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ,
>> +        .fixup_flags = SPI_NOR_4B_OPCODES,
>> +    }, {
>> +        .id = SNOR_ID(0xc8, 0x67, 0x1b),
>> +        .name = "gd55lb01ge",
>> +        .size = SZ_128M,
>> +        .flags = SPI_NOR_HAS_LOCK,
>> +        .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ,
>> +        .fixup_flags = SPI_NOR_4B_OPCODES,
>>       },
>>   };
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

Hi Christophe,
It definitely miss the .size field for gd25q256, I will send one 
separated patch for this.

Best Regards,




