Return-Path: <linux-kernel+bounces-336626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C40983D36
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1201C1F23CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AAD1EB44;
	Tue, 24 Sep 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wekq3CxY"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D223D7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159778; cv=none; b=Yk929crKLwtTOH2m8/gzpQNPa0VfN+/P/54evzA21jnfoVBbmecEIfpWEKbwT1uEOaa3p2Ghrrc5yioCBhdndo5H3OjdzQcySlMzQrxeZxxmCY1xPl/N02n2B55WqeK8qO/YLCpz+tO+hhUXSycgNiUUKmJLzo02oW6t41Ij+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159778; c=relaxed/simple;
	bh=0yaVP4jAEOdfCuKEmNDzhPvKU2bMPvbasd5+pyVnSSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EH9knczgJn+MugKTx9aeVnWT3cPwEhfMj5iESpeUoTchBNjv8v5xvX7H9QRer0URd7OyqPv6t3xcqkmPauMAW6euic9Hx8j5CK9cmyyJaNV40PklwsGCiQ8yAYWPfB2vxD/pcP1newsIV7lBoysamkeOIwim/I0uawLLSxCpXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wekq3CxY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so49209335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727159774; x=1727764574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s5O9hi7/yXg+YxoIrnEDuOK7KeUqbocdowl5jauyzj8=;
        b=Wekq3CxYB6jHm/0ZPMGfPlRP1xPqVBG4/+MzPcMyFD7R/Kb3qeJkIdzOqcbmlVOWrL
         BH7V7Nogg0MQUZOARS2av6m4r6YRjFpg/pxnwUKMvv1UXoEz4SIOVqtwWBmlEt5nX30s
         nU/dxmtSu2gM4wtARazBb0LDZ6hwixmLtWv/vZpwmsswnyAH2FvT20NifCUam7KWMgXL
         iJY9fd5WHprWhF80IxnSXJ++W64aIMprfNAkCXRnAc/3Cssa8+tKXqociqIKrN4RhRGD
         endSot6ZT7ncjAHO76+HNrJ4Z9xQBlSsYfLk6SSya10MAC0v7F8mbWpS7Auo76muD9di
         qE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727159774; x=1727764574;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5O9hi7/yXg+YxoIrnEDuOK7KeUqbocdowl5jauyzj8=;
        b=i05H0TiCtvXFoVSOjYpMn7onyNyo0l0/Ce0C2DCku1GZV2P1DCFB0mvT1LALeIyb3o
         iTegG1QjIWdaIHklJZg9hm+zl3q+gAQPjdU/Qe5YTlkXBhSYe8srg06mz+rl91afEvOk
         vU5KKDRbqwB38B42v1K4zQwq6oZ0HHSnJ0Qy6jz50bTZA0CVJB3B8jTzsCwyNpM20vXf
         CEGXs0P/hJI/4M+VUsS6vA1F1LRN7yW915IkMYi9kYLhaapwBvRF+c8lCpyvYqLQpI4Y
         Qr/OY0i50RMI1Pbqwwrg/PFb+A26cleI4VpYdIv+h++kHTD32HZoyLDriC0eDKu4M0Jy
         B3tA==
X-Forwarded-Encrypted: i=1; AJvYcCVNg5CuGXvjW7kwSl/7+NjubXKIKKWgQAYk2C565LbyLrzSg7Ca8y9auT8n/yyDpE+snszUqM6AKxFjRIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzwnGGHFNeOOC6c0NLHNHv0YNSLQEAMgRUqsbIhnfhWQRUX3j
	8EeVdseUWsH7geahED9wnb/zTPhVWTM5o32PbhCWukPgDlucqLTIDd6Qs95q6is=
X-Google-Smtp-Source: AGHT+IH5FhoHbJ9IDBbAUP30tScNk63Y9tGAEtEwCMUDmUad60Ilu2dLIg4b9hx0dvztT+6CqWGaog==
X-Received: by 2002:a05:600c:1ca2:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-42e7abf43c3mr102426065e9.10.1727159774479;
        Mon, 23 Sep 2024 23:36:14 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f9811sm710709f8f.86.2024.09.23.23.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 23:36:13 -0700 (PDT)
Message-ID: <618e4514-791b-4a73-a1ba-45170a21e453@linaro.org>
Date: Tue, 24 Sep 2024 07:36:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] mtd: spi-nor: add support for Macronix Octal flash
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Alvin Zhou <alvinzhou.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, pratyush@kernel.org, mwalle@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 broonie@kernel.org, chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>,
 Bough Chen <haibo.chen@nxp.com>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-7-alvinzhou.tw@gmail.com>
 <97134efb-398d-4c21-a915-87a5b4f1b29a@linaro.org>
 <CAPhrvRR3U9=0DuG_FQ81ZJq+RLe6Bn9YO831Mx2n3NkeV3MCdA@mail.gmail.com>
 <368cd6fb-cab1-44ad-af46-651d9323bc19@linaro.org>
Content-Language: en-US
In-Reply-To: <368cd6fb-cab1-44ad-af46-651d9323bc19@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/24/24 7:26 AM, Tudor Ambarus wrote:
> 
> 
> On 9/24/24 4:25 AM, Alvin Zhou wrote:
>> Hi Tudor,
>>
>> Tudor Ambarus <tudor.ambarus@linaro.org> 於 2024年9月23日 週一 下午2:54寫道：
>>>
>>> Hi, Alvin,
>>>
>>> I quickly skimmed over the previous 5 patches and they are looking fine.
>>>
>>> I don't get this patch however.
>>>
>>> On 7/18/24 4:46 AM, AlvinZhou wrote:
>>>> From: AlvinZhou <alvinzhou@mxic.com.tw>
>>>>
>>>> Adding Manufacture ID 0xC2 in last of ID table because of
>>>> Octal Flash need manufacturer fixup for enabling/disabling
>>>> Octal DTR mode.
>>>>
>>>> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
>>>> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
>>>> ---
>>>>  drivers/mtd/spi-nor/macronix.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
>>>> index f039819a5252..1a8ccebdfe0e 100644
>>>> --- a/drivers/mtd/spi-nor/macronix.c
>>>> +++ b/drivers/mtd/spi-nor/macronix.c
>>>> @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[] = {
>>>>               .name = "mx25l3255e",
>>>>               .size = SZ_4M,
>>>>               .no_sfdp_flags = SECT_4K,
>>>> -     }
>>>> +     },
>>>> +     /* Need the manufacturer fixups, Keep this last */
>>>> +     { .id = SNOR_ID(0xc2) }
>>>>  };
>>>>
>>>
>>> Could you please elaborate why you need just the manufacturer id here? I
>>> would have expected to see a specific flash entry instead.
>>
>> Grateful to Michael for the valuable suggestion. This addition of the
>> Macronix manufacturer ID enables the fixup functions such as
>> macronix_nor_set_octal_dtr to be executed without the need to
>> create separate ID entries for each Octal DTR NOR Flash in the
>> flash_info.
>>
> 
> Ah, nice. Okay then. I'm going to review the rest of the patches. They
> look promising ;).

ah, but then you'll always have a matched ID, so you break the generic
flash probing for macronix. Is that correct?

