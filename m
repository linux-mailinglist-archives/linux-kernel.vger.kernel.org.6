Return-Path: <linux-kernel+bounces-204366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97458FE7C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37431C217A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F748195993;
	Thu,  6 Jun 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCT7TnNt"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B8A194A7B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680590; cv=none; b=e9dTxOkU4Qssd25Btl2ywM2G5GKdkMeFxNQ202/ABnHFI/00iyRd/gWAAFygHCDHrwpsz1Bx31OmdugUAoW1quAoTl6smDC4Swnqo0PN5JXcp7FqrM/gfOkcMpZTUQw9ImizK5bf0PVCaSW1Q5kucrhaoS88lyuHmxl0cefKlOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680590; c=relaxed/simple;
	bh=NE20dT+lcw0pNbAHGCzUoAXK+4hWDrC9dITxkRSXHjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBKYLH2QRBTbjPANF0ruY2zT5Qdz3UW7STKoDtJmTz1ExLwAIW5uG6I4y08MNCraq1xeqxlFdea0Bvd9tlizFP/4MtAxBo1uO7gI9vj00uv83vBuDHbbFIb6fxSYF5mr0bYyrL4fEVRY+jkfG2aEkWgmVJqpnhlpp9md6xX4vgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCT7TnNt; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso12073191fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717680587; x=1718285387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Xez4WR8DSU7fKFNpGE2JQFyauplFotDS49TAIDs+7Q=;
        b=MCT7TnNtxt/Z8ktVJmh/N1F9EdOHup9QOWad/lGR6ImM55PXp3+pyOu4IUk+I/T269
         Y+iC5Y1XuBLgyM62Rmm/D5HOAECa6Qj8nRHFzCuvSEOpgWCVInFPvE3HbUg2F8ZHG9CE
         FZPf27kokxe78YTrYY+b196citwAKls/4fJAFi2j2x60y40VafKR/DOP+eXBdIOgDVoF
         lYGE3kCLNWQ7WmQsWTT4ray25MaN3XEwdwogJWScpjCZ5hqJdyR9JCbOhBLsQFhVeYbm
         TPkSXQAh+18bBKS8yTPoEfk/4co3vcOO4RQI/B0ivKmHQBl7yfU8bBpDWGB90KdcPyK2
         GgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680587; x=1718285387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xez4WR8DSU7fKFNpGE2JQFyauplFotDS49TAIDs+7Q=;
        b=OP8gPUuBq+CO117fhovB046rpNHZnRj/U8wQHFMatIxb42RVDPVCFuZ+fR1X++VtPG
         QG3470D1Ik+nwp+kCNq3RQR/QNa3IfAR9MuUF8av4TzE3x7rCsfEl/KB6k0KFZ0jdNmb
         wueTxPkuiPorxlza8rlDwUYnRVGhZiCKIuQEc9pnnDwkTOLdktjv23yRj8QA3M7/9m/I
         r4SqE6WdlVOi5wXwKP3Xy0iy+rl/mIE06rPpbzXB6vJiUHUrWSkvithk6ADIOk20DVIn
         UZqyURBV2uP4jkUix6MqmSnY4i7q7PYV8rF5HNDRgdF3v0Q3q3lGR+mxEYzWJ9IlU1/4
         fokw==
X-Forwarded-Encrypted: i=1; AJvYcCVLDe/hL8MlbOe12TiNNeatFGxHKEzNfKCz0pJnQQyc/viVpKjARIrxZul4MSQHsUqpPpMie9bgYMX6AXF6+xvoQQvvVcwp99iNz0Qt
X-Gm-Message-State: AOJu0YxE14dqOojciZmMC9AbQ6lzphuZp5O1aTglh3uGguQQZ79c6R0Q
	LMR1Z7fciDw9FOeY4DFFSvZe5rJHBQvuTTQv0aiymcy9cap9RfMxGycWAyaOXdw=
X-Google-Smtp-Source: AGHT+IH779I+q/2lL0Z3owDZLr52mPo7b8egVqaVc+zBUGqtFPugx5nSBFwHLKZflsecvuFvG9bqgw==
X-Received: by 2002:a2e:7d0f:0:b0:2e1:cb22:a4d with SMTP id 38308e7fff4ca-2eac7a4c6bemr34468601fa.36.1717680586617;
        Thu, 06 Jun 2024 06:29:46 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0e9f2asm1085624a12.36.2024.06.06.06.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 06:29:46 -0700 (PDT)
Message-ID: <8513a828-6669-4bf3-91d3-799771866f32@linaro.org>
Date: Thu, 6 Jun 2024 14:29:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: macronix: workaround for device id re-use
To: Michael Walle <mwalle@kernel.org>, Esben Haabendal <esben@geanix.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com>
 <D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/24 08:25, Michael Walle wrote:
> Hi,
> 
> On Fri May 24, 2024 at 12:48 PM CEST, Esben Haabendal wrote:
>> Macronix engineers apparantly do not understand the purpose of having
>> an ID actually identify the chip and its capabilities. Sigh.
>>
>> The original Macronix SPI NOR flash that identifies itself as 0xC22016
>> with RDID was MX25L3205D. This chip does not support SFDP, but does
>> support the 2READ command (1-2-2).

and it lacks support for 1-1-2?
>>
>> When Macronix announced EoL for MX25L3205D, the recommended
>> replacement part was MX25L3206E, which conveniently also identifies
>> itself as 0xC22016. It does not support 2READ, but supports DREAD
>> (1-1-2) instead, and supports SFDP for discovering this.
>>
>> When Macronix announced EoL for MX25L3206E, the recommended
>> replacement part was MX25L3233F, which also identifies itself as
>> 0xC22016. It supports DREAD, 2READ, and the quad modes QREAD (1-1-4)
>> and 4READ (1-4-4). This also support SFDP.
> 
> Thanks for collecting all this info!
> 
>> So far, all of these chips have been handled the same way by the Linux
>> driver. The SFDP information have not been read, and no dual and quad
>> read modes have been enabled.
>>
>> The trouble begins when we want to enable the faster read modes. The
>> RDID command only return the same 3 bytes for all 3 chips, so that
>> doesn't really help.
>>
>> But we can take advantage of the fact that only the old MX25L3205D
>> chip does not support SFDP, so by triggering the old initialization
>> mechanism where we try to read and parse SFDP, but has a fall-back
>> configuration in place, we can configure all 3 chips to their optimal
>> configurations.
> 
> You are (mis)using the quad info bits to trigger an sfdp read,

right, not ideal.

> correct? In that case, I'd rather see a new flag in .no_sfdp_flags
> to explicitly trigger the SFDP read. Then your new flash would only

I hate to update the core for vendor's madness.

> need this flag and doesn't require the shenanigans with the fixup,
> right?
> 
>> With this, MX25L3205D will get the faster 2READ command enabled,
>> speading up reads. This should be safe.
>>
>> MX25L3206E will get the faster DREAD command enabled. This should also
>> be safe.
>>
>> MX25L3233F will get all of DREAD, 2READ, QREAD and 4READ enabled. In
>> order for this to actually work, the WP#/SIO2 and HOLD#/SIO3 pins must
>> be correctly wired to the SPI controller.
> 
don't add superfluous info. we already know how quad works.

> That should already be taken care of with the spi-{tx,rx}-bus-width.
> 
> -michael
> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>> I only have access to boards with MX25L3233F flashes, so haven't been
>> able to test the backwards compatibility. If anybody has boards with
>> MX25L3205D and/or MX25L3206E, please help test this patch. Keep an eye
>> for read performance regression.
>>
>> It is worth nothing that both MX25L3205D and MX25L3206E are
>> end-of-life, and is unavailable from Macronix, so any new boards
>> featuring a Macronix flash with this ID will likely be using
>> MX25L3233F.
>> ---
>>  drivers/mtd/spi-nor/macronix.c | 60 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
>> index ea6be95e75a5..c1e64ee3baa3 100644
>> --- a/drivers/mtd/spi-nor/macronix.c
>> +++ b/drivers/mtd/spi-nor/macronix.c
>> @@ -8,6 +8,63 @@
>>  
>>  #include "core.h"
>>  
>> +/*
>> + * There is a whole sequence of chips from Macronix that uses the same device
>> + * id. These are recommended as EoL replacement parts by Macronix, although they
>> + * are only partly software compatible.
>> + *
>> + * Recommended replacement for MX25L3205D was MX25L3206E.
>> + * Recommended replacement for MX25L3206E was MX25L3233F.
>> + *
>> + * MX25L3205D does not support RDSFDP. The other two does.
>> + *
>> + * MX25L3205D supports 1-2-2 (2READ) command.
>> + * MX25L3206E supports 1-1-2 (DREAD) command.
>> + * MX25L3233F supports 1-1-2 (DREAD), 1-2-2 (2READ), 1-1-4 (QREAD), and 1-4-4
>> + * (4READ) commands.
>> + *
>> + * In order to trigger reading optional SFDP configuration, the
>> + * SPI_NOR_DUAL_READ|SPI_NOR_QUAD_READ flags are set, seemingly enabling 1-1-2
>> + * and 1-1-4 for MX25L3205D. The other chips supporting RDSFDP will have the
>> + * correct read commands configured based on SFDP information.
>> + *
>> + * As none of the other will enable 1-1-4 and NOT 1-4-4, so we identify
>> + * MX25L3205D when we see that.

I find this description more clear than the commit message. I've written
some questions for the commit message, then I removed them once I read
this description.

>> + */
>> +static int
>> +mx25l3205d_late_init(struct spi_nor *nor)
>> +{
>> +	struct spi_nor_flash_parameter *params = nor->params;
>> +
>> +	/*                          DREAD  2READ  QREAD  4READ
>> +	 *                          1-1-2  1-2-2  1-1-4  1-4-4
>> +	 * Before SFDP parse          1      0      1      0
>> +	 * 3206e after SFDP parse     1      0      0      0
>> +	 * 3233f after SFDP parse     1      1      1      1
>> +	 * 3205d after this func      0      1      0      0
>> +	 */
>> +	if ((params->hwcaps.mask & SNOR_HWCAPS_READ_1_1_4) &&
>> +	    !(params->hwcaps.mask & SNOR_HWCAPS_READ_1_4_4)) {
>> +		/* Should be MX25L3205D */
>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
>> +					  0, 0, 0, 0);
>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
>> +					  0, 0, 0, 0);
>> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_2_2],
>> +					  0, 4, SPINOR_OP_READ_1_2_2,
>> +					  SNOR_PROTO_1_2_2);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct spi_nor_fixups mx25l3205d_fixups = {
>> +	.late_init = mx25l3205d_late_init,
>> +};
>> +
>>  static int
>>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>>  			    const struct sfdp_parameter_header *bfpt_header,
>> @@ -61,7 +118,8 @@ static const struct flash_info macronix_nor_parts[] = {
>>  		.id = SNOR_ID(0xc2, 0x20, 0x16),
>>  		.name = "mx25l3205d",
>>  		.size = SZ_4M,
>> -		.no_sfdp_flags = SECT_4K,
>> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>> +		.fixups = &mx25l3205d_fixups
>>  	}, {
>>  		.id = SNOR_ID(0xc2, 0x20, 0x17),
>>  		.name = "mx25l6405d",
>>

If all support 1-1-2, (seems MX25L3205D doesn't), then we may have a
change to don't update the core.

Frankly I don't care too much about what happens in the manufacturer
drivers, but I do care about the core and to not extend it with . This
patch is not too heavy to be unmaintainable and shows clear where the
problem is, we can keep this as well.

Other option that I'd like you to consider is whether we just remove
support for MX25L3205D, thus the entry altogether, and instead rely on
SFDP to set everything.

Cheers,
ta

