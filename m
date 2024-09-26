Return-Path: <linux-kernel+bounces-340286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767B987105
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E95A1C24C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5F61AB6E8;
	Thu, 26 Sep 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ou1apy47"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56718E760
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345313; cv=none; b=tm4uENPXfrYWsXWY0AnNqu5VFxGgqPkC750TzUEHGOmpDUZZEN4wf2oFQOLATUIYjEvsZjZJ0Yjr7bg//qGktvhpmdYhXT/5lT7733l7QU2RvdVJ6gHJbf23UlKHOqoJ800kZK7jB3JmT9HUfHZ2lNA9a6i0esfNqdBHabphSW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345313; c=relaxed/simple;
	bh=DWqfZehaI2IGJLBBQmmfzOOW6w9yR1hvYHjts0zH1V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tELV8zZSBVDbwlGj1ZWjFXXxZfe1+5OFBmXOvv+K4Q9J5/7iyR879qmKzCnX/iRtYABdxr044rN5GJQCsIT0msAsHsYyg4B6k5b6bf7yy2a35C/All58VlXYIyxzaP/0ukpOcl1HiGepdH4r2FkCoVkUTo31o9zJM9ULzy81i98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ou1apy47; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c5cc65a8abso687873a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727345309; x=1727950109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPI1wSnI2Xvwc1fBKmkQJN8RFgbR0lhO6jzNyKbT6Jk=;
        b=Ou1apy47A32+4HiIA9YYQB87qk0cXGigosXlloORKCd8ExmSKlitJ9yQVZSMVMN3KE
         G3GRXSkhVopgOFqfPg/nhH+rNd1DfPvCnftkXEKqN5JYE6w9TQ+0skSR+UNwbG9lqral
         MNRPlElRSWwo3peTi/UigYwxXsPlsb5X2eeL6BW1ADuzhYiD7nnIEMktIOVE4SWWbkap
         kFk/sygK/Vsq5ed0VOXSBxa1UHK8MUxL+DRaZ75PGnvnJJJehgOVIClnlC3GU4PNxdko
         r1Xd4hfrE06Z+ti32m1kdrhVXIn5BjbrLsnR+xuF/JlZiIKauYd/iL3IsHqC+TGu+VjD
         sWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727345309; x=1727950109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPI1wSnI2Xvwc1fBKmkQJN8RFgbR0lhO6jzNyKbT6Jk=;
        b=OUXza63B1PS4Vkor8UjDZMGww+t+UYwp2Q1HptGluDWwKilrT5ZXlT8WSHOyo9L5y0
         02Kx1X+JDkdcgmHYg9ZEIB+SF/faeNGRDF/6gczbQ+BJvqL/H6q5rRrh++kRojwGEZ1C
         y5tyXL6NxmaGPfVhJsMOhnLQbVEkUdnV6kZWIMROwgyya91+gvc4ByVsvt8t4N+bI+1j
         d17m9KRQ/Q89cs7mhfWVmv593UV1n3Nrnp7bC2IXCudE0q9XvS2nsl73dfb+WQtwtQR5
         8lX3PA8egxJOu+K0HO6IqSQn+oY8yaHMLDV066IFZCm7fu3mCM7BPajda9ytQrFqrmHA
         wUZw==
X-Forwarded-Encrypted: i=1; AJvYcCU0TGq63vv5ZRKUDWvmUmxIi25O9AYGu9c/oemQ6BqZZGFbTQNci0iLr5virjnMyOyO07GoHZR600SG2wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdiqgrpyjjGkz7uwQY6y8mHMNCaEp5LpOM2gqAESFGnU1fTD0t
	Wk1E7jZruyWzO1SMH0nSHjffMDNGASg0dCc5yoP1je6Xp1EKN18dU3rCDh/eLVM=
X-Google-Smtp-Source: AGHT+IEpzY+Q0d5RmuZcmwykEo9QrY6zdyd7ykAY1XjzcXyllboJtQ0PWSli0HLW0FqQOORYQgzsZw==
X-Received: by 2002:a05:6402:50d2:b0:5c8:7a46:2c9 with SMTP id 4fb4d7f45d1cf-5c87a460575mr631170a12.20.1727345308828;
        Thu, 26 Sep 2024 03:08:28 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf49d8a0sm2947655a12.46.2024.09.26.03.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 03:08:28 -0700 (PDT)
Message-ID: <e079751d-e775-4dec-9959-c9c3fdcc8ecf@linaro.org>
Date: Thu, 26 Sep 2024 11:08:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] mtd: spi-nor: macronix: workaround for device id
 re-use
To: Esben Haabendal <esben@geanix.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 linux-arm-kernel@lists.infradead.org
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hiya, Esben,

On 7/11/24 2:00 PM, Esben Haabendal wrote:
> Following up to various discussions, this series have now been
> modified so that it gets rid of the old deprecated approach
> for detecting when to do optional SFDP parsing.
> 
> Before these changes, spi-nor flashes were handled in 4 different
> ways:
> 

I'm adding a bit of extra context on each point you made. All your
points contain static init, you missed spi_nor_init_default_params()

There's a 0/ case where we have indeed just SFDP initialized flashes,
and that is the generic flash driver.

0/ SFDP only, generic flash driver

> (1) SFDP only [size==0]

1/ static + SFDP

spi_nor_init_default_params(nor);
spi_nor_parse_sfdp();

> 
> (2a) static config only [size!=0 && no_sfdp_flags & SPI_NOR_SKIP_SFDP]

2a/ is
spi_nor_init_default_params(nor);
spi_nor_no_sfdp_init_params(nor);

> 
> (2b) static config only
>        [size!=0 &&
>         !(no_sfdp_flags & (SPI_NOR_SKIP_SFDP | 
>            SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>            SPI_NOR_OCTAL_READ | SPI_NOR_OCTAL_DTR_READ))]

2b/ is
spi_nor_init_default_params(nor);
spi_nor_init_params_deprecated(nor); //where parse SFDP is not called
	spi_nor_no_sfdp_init_params(nor);
	spi_nor_manufacturer_init_params(nor);>
> (3) SFDP with fallback to static config
>        [size!=0 &&
>         !(no_sfdp_flags & SPI_NOR_SKIP_SFDP) &&
>         (no_sfdp_flags & SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>            SPI_NOR_OCTAL_READ | SPI_NOR_OCTAL_DTR_READ))]
> 

3/ is 2b/ with parse SFDP called and rollback mechanism
spi_nor_init_default_params(nor);
spi_nor_init_params_deprecated(nor);
	spi_nor_no_sfdp_init_params(nor);
	spi_nor_manufacturer_init_params(nor);
	spi_nor_sfdp_init_params_deprecated(nor);

All cases from above are followed by a call to spi_nor_late_init_params().

> Cases (2a) and (2b) have been handled slightly different, with
> manufacturer and flash_info ->default_init() hooks being called in
> case (2b) but not in case (2a).

default_init() was a mistake and we shall remove it and replace it with
late_init(). The challenge is to do that without affecting backwards
compatibility. But let's move this aside for the moment
> 
> With this series, that is changed to this simpler approach instead:
> 
> (1) SFDP only [size==0]
> 
> (2) static config only
>       [size!=0 && !(no_sfdp_flags & SPI_NOR_TRY_SFDP)]
> 
> (3) SFDP with fallback to static config
>       [size!=0 && (no_sfdp_flags & SPI_NOR_TRY_SFDP)]
> 
> Existing struct flash_info entries are modified, so that all those
> that was case (2a) or (2b) are now case (2), and those that were (1)
> and (3) are still (1) and (3).

We indeed want 2a/ and 2b/ to be squashed, ideally by removing the
default_init() hook.

And if we really want SFDP-only init, we shall not call
spi_nor_init_default_params() in this case.

Your patches do not apply on latest SPI NOR, I tried locally. Can you
point me to a branch of yours where I can see them? No need to resend.

Thanks,
ta

