Return-Path: <linux-kernel+bounces-204470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F367F8FEF92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C3B2BA5F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8981197A96;
	Thu,  6 Jun 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caaUIcMX"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44523197A93
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684060; cv=none; b=XR+ilXGHVXF92BK8NoT2twffJLHjaFH+pIZWR5T0BA8HjYCW7zAzLASYGnw8MvBrqwnxzSBkuF0UMvl1QUHNmOj77+EEcvu9aa1xVUJhyw+CSQuQuEBfSMRICoP8YXO28KPr+C82pL0800cevEFHR8JbW/32C8MQreUNxL4K9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684060; c=relaxed/simple;
	bh=kBCPNlDnaF5A/j93fXd8C0p9oaSwJeDVY9kAHOruRoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf0nzYMKm8VtxmxLYE705msWEJlYJBQcqW4rBw2EIrQHsRoPGYL3HHthS0+7EImeFhaAwFifSb5vSgbZqSnDHrCua4MX7O4+57fO0dPLuNZK0nNG4f1fjX+57JtLOiMkAaTm0jAm5J9oRfTZh3o+as0ekQ+mNthsX+K9kL+cbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=caaUIcMX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so4078438a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684057; x=1718288857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hLEV7cEhYqs364TwznzdmQhJORPUoZ782mB7mIsyO8=;
        b=caaUIcMXoZ9RcFH9Uzv8B4l7JixqMj57w71tCNMjNEDLqgzWrJ/cAiE+vmauPvp6ui
         nDLa/y5Raue+ci9JBbpZNLyQLr1AlDrYn5osbB+5eLdwZR5z2fe3EFk7q2ROwtZ11TYg
         XaqkeHq8AFl90OAwfxBXOfMaaWGkQwitmA5hCAqGi/kUtfW7mP53FnuqZJlFFLTIR6HE
         GesSJp6VUqfi6ITL6Cp+2eZ8PdPrVAzoGOuwA5be9tN83MjaJoEo6kbIEpy96xBiIiXU
         3cMk/hDSwK4TAp8qAxtAp2rwsjemtINBdE8BKECxQmGxUpJDvQeCUErW4Clsxdt2RMm4
         n2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684057; x=1718288857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hLEV7cEhYqs364TwznzdmQhJORPUoZ782mB7mIsyO8=;
        b=hqsILIXL2WzUTF9V+NnHaeFLbH26tE6Cupid3+u2tN7mBNCKtEtdqiDY47PUUBTQxN
         vRgcMtk3HXDiPwwUjaYWrwtDSO2f7ZCKQabeslcUvETV+O/I84ZLZDT0hpXvee2S5TpH
         EijKc6IfP/kyq2SWHzdOCB3/DhMuZvjWNZh6SHPPtEzYxA2A47Inm33DqfpEN7V1IAQr
         nB6likStAPJzLeDAXj4gqxJhX3P8aSbnj4g0qqyNHxtfcYwDLLfQEm0rW727NtGhv8TK
         aTqXP/Xr5cEQzr7DoXFTfO3v8+NaQyKubH1Vay4TklItjpFTsr5lNZ1qd9kj72zWnYDO
         jEMw==
X-Forwarded-Encrypted: i=1; AJvYcCVieiTJzQzyqTzJLYuM30rrCe23OomlXcp6dCGkaP7UP1SiRCWwsC3jPjyrnpuf07C+laKAhdF/RFCpEKiXIXnMHu4db5rjKKynQ/2b
X-Gm-Message-State: AOJu0YymwO+6p8WEXELrtoEKEyLYT/LJA/0aofLpAzTeln5aoxG20t3X
	0kBuOQZmQ1j6EvJ91jHvyfPy/6LQs9V8uini+PGqSBRQqkI6u8ooFChgAA9Xo3s=
X-Google-Smtp-Source: AGHT+IHsP59EudlMYpMNXIptWO+FeQmE0ifFlSNcVw/Ot9lSWaCM41xaUl8Qj6EICFDnAC/IPJ3ITg==
X-Received: by 2002:a17:906:5ac8:b0:a68:88a3:3645 with SMTP id a640c23a62f3a-a6c7650ae43mr235613366b.27.1717684056579;
        Thu, 06 Jun 2024 07:27:36 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e1c1sm102862566b.168.2024.06.06.07.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 07:27:35 -0700 (PDT)
Message-ID: <9e304860-b4e9-4193-9bb3-ebcc3611032f@linaro.org>
Date: Thu, 6 Jun 2024 15:27:34 +0100
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
 <8513a828-6669-4bf3-91d3-799771866f32@linaro.org>
 <D1SZA4ZDM06P.CJC0EQ9ULA04@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <D1SZA4ZDM06P.CJC0EQ9ULA04@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/24 14:45, Michael Walle wrote:
>>>> + */
>>>> +static int
>>>> +mx25l3205d_late_init(struct spi_nor *nor)
>>>> +{
>>>> +	struct spi_nor_flash_parameter *params = nor->params;
>>>> +
>>>> +	/*                          DREAD  2READ  QREAD  4READ
>>>> +	 *                          1-1-2  1-2-2  1-1-4  1-4-4
>>>> +	 * Before SFDP parse          1      0      1      0
>>>> +	 * 3206e after SFDP parse     1      0      0      0
>>>> +	 * 3233f after SFDP parse     1      1      1      1
>>>> +	 * 3205d after this func      0      1      0      0
>>>> +	 */
>>>> +	if ((params->hwcaps.mask & SNOR_HWCAPS_READ_1_1_4) &&
>>>> +	    !(params->hwcaps.mask & SNOR_HWCAPS_READ_1_4_4)) {
>>>> +		/* Should be MX25L3205D */
>>>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
>>>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
>>>> +					  0, 0, 0, 0);
>>>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
>>>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
>>>> +					  0, 0, 0, 0);
>>>> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>>>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_2_2],
>>>> +					  0, 4, SPINOR_OP_READ_1_2_2,
>>>> +					  SNOR_PROTO_1_2_2);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct spi_nor_fixups mx25l3205d_fixups = {
>>>> +	.late_init = mx25l3205d_late_init,
>>>> +};
>>>> +
>>>>  static int
>>>>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>>>>  			    const struct sfdp_parameter_header *bfpt_header,
>>>> @@ -61,7 +118,8 @@ static const struct flash_info macronix_nor_parts[] = {
>>>>  		.id = SNOR_ID(0xc2, 0x20, 0x16),
>>>>  		.name = "mx25l3205d",
>>>>  		.size = SZ_4M,
>>>> -		.no_sfdp_flags = SECT_4K,
>>>> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>>>> +		.fixups = &mx25l3205d_fixups
>>>>  	}, {
>>>>  		.id = SNOR_ID(0xc2, 0x20, 0x17),
>>>>  		.name = "mx25l6405d",
>>>>
>>
>> If all support 1-1-2, (seems MX25L3205D doesn't), then we may have a
>> change to don't update the core.
>>
>> Frankly I don't care too much about what happens in the manufacturer
>> drivers, but I do care about the core and to not extend it with . This
>> patch is not too heavy to be unmaintainable and shows clear where the
>> problem is, we can keep this as well.
> 
> It's a horrible hack. For example I'm working on a patch to clean up
> the spi_nor_set_read_settings() handling. So just throwing any code
> into vendor drivers doesn't make it any better in terms of
> maintainability. I'd need to touch all the code anyway. In fact it
> makes it even worse, because it looks like the manufacturer drivers
> are just a dumping ground for bad things. Thus, I'd really have it
> handled in a correct way inside the core.
> 
> Also, this is not device specific. Let there be two different
> flashes with the same ID, but one support SFDP and one doesn't.
> Right now, you have to have any of the magic flags (dual, quad,
> etc) set to trigger an SFDP parsing. If the flash without SFDP
> doesn't support any of these, like in this case, we are screwed.
> Hence we might need such a flag also for other flashes.

maybe. How many such flashes have you seen in the last 3 years?
> 
>> Other option that I'd like you to consider is whether we just remove
>> support for MX25L3205D, thus the entry altogether, and instead rely on
>> SFDP to set everything.
> 
> Well, this will break boards with this flash :) And we don't know if
> there are any.

The flash (MX25L3205D) was already deprecated in two iterations by the
manufacturer. First migration being done in 2011 [1]. Having to maintain
all flavors is a pain, thus let's remove support for the old flash. If
anyone complains we can bring it back to life, but let's not complicate
our existence yet.

[1]
https://www.mxic.com.tw/Lists/ApplicationNote/Attachments/1858/AN058-Migrating%20from%20MX25L3205D%20to%20MX25L3206E-1.2.pdf

