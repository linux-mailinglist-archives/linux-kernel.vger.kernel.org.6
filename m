Return-Path: <linux-kernel+bounces-211922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4799058E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00A61C211EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D876F181332;
	Wed, 12 Jun 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y4km6yrm"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256D181306
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210178; cv=none; b=PK++ooVWkzQ0YG7rSOVMJqPP2QnG6uWUkpC6qWyKZ7OHymWvXIpOQIGv6Mp/WTlXtW7ZeFxGy9RG2GanQvxGvzAt9tKnoMBNkEx0Q1AQh6LXmtTnP8CF2Ka6Ih7aIEk/W0yHkTf4kF2HwuzaVFAnQ1z2T27fL4WbAkEWnnWQk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210178; c=relaxed/simple;
	bh=7vprfaAy+/aNUKk+kDbOiywSxFojlqtspogVZkl4nTQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eF0WNcaRs/Fwhndr0AZpEg4KhC7AJMlqbM3+dlxKOUgW6OWUGWSR1+veDzvcWKDyTi3NorYvMz0n9Tl6nbTgK6OuSp9QfLwhO5N9OYeLCPxnpEKcKc/nR2J4QitE8A7hGZUetrfZ36wWuWxjQCdVEMjYu+7xIv8kAHBCN1GRObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y4km6yrm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebd95f136bso25883471fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718210174; x=1718814974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bKTobHHeGnkatIF6+SqsXuu/2VlIYkxSM06piFfY/sw=;
        b=Y4km6yrmH/MOurMmg3go4xS8PXGyFim7If77UWqmv+aFiusPGxRCkifzgL/147CHMC
         7KdSX262IniwTscqpqc2pTC7K+XgxGAlfvxAi99HQwyW8Z6vfPy74IbtYwvKf//aGYVd
         C7ygq5Jnqntsoacjr+EQGfCBDC/BYyMXhIB31X3ylMJTYL5vql0ZTX7lAMV6WnMczljk
         dwS+ZQ4hLNL3n8DYj7JJIQcuS08EN0W77kmqHPVuuitLqBjxOEO/H7vwDmHzaUpKrJyq
         Ort45qLZqoJ/pqUeL2/PzncC5gQGCburC4dlbxcNlURgmF6MhO6hbyxqljsZeUb0fwSZ
         Qr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718210174; x=1718814974;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKTobHHeGnkatIF6+SqsXuu/2VlIYkxSM06piFfY/sw=;
        b=gJTVYAP+Qo+EecuHTHo+7MiXWZSheL2rNGlxixkawWUiw1VJ5T1A42gRpMGDZeG8V+
         Tl+p8k9ubLqpexHPIHxNLp0gOrjSiWAf5lnhtV2mHw6NIsGxufMQ+CpzfRz/VbtgUK9T
         WDemALjry5ZAS7tyy9RpRA0AJarGSO4V7dTPRElBfAbm4bBAWJO9YQ5Oa5Z4KBlx3hyu
         HX8NBwThx2Q+ajJEZLEHtHvf828oqaXg/NhY7h37ZrXeG+NTEL6KhxgSNkuyDWekhmEF
         CbFGb84ZGWAAP/POJgCBzUYF9jXcEVu58AC5MwalRAz4wq/lJNYAM6i6QasbQd3nnpIw
         jXrw==
X-Forwarded-Encrypted: i=1; AJvYcCVA/G9M1hdjKtUCUyhL+hXthz+8805VD244EmEYq5FotWU24yH7jdsMzUC8A3fimuIyK3cUINvNT90Vpa/gge02wshnJChQcsSKIxYn
X-Gm-Message-State: AOJu0YxG2zEkDQ/82Edh3S5ILncAOzc2iKrWVqK4OrwcN04HC7wP6UWz
	A9qD3rWRmyVuhuDvpq1dGnJXutXxGd3JKPd6QkVNjvAtqnQd5CdwyEPrfMaaASS3+sn+v/gOR1M
	e
X-Google-Smtp-Source: AGHT+IFY910HY6EtcZZHlDUUywnpSePswjY4naCvy8H+e+Wer3wMJAZi0qBD5yz5ZV+/y/ANvtFMKQ==
X-Received: by 2002:a2e:87c5:0:b0:2e9:881b:5f02 with SMTP id 38308e7fff4ca-2ebfca6145fmr13444141fa.53.1718210173634;
        Wed, 12 Jun 2024 09:36:13 -0700 (PDT)
Received: from [192.168.0.2] (host-79-40-233-231.business.telecomitalia.it. [79.40.233.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eefa07sm32159465e9.8.2024.06.12.09.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:36:13 -0700 (PDT)
Message-ID: <9e21de1f-d0b1-4a00-a73d-9f35d8cedf1b@baylibre.com>
Date: Wed, 12 Jun 2024 18:35:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] minor fixes and improvements
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522150141.1776196-1-adureghello@baylibre.org>
 <751faef385f81f8a2dd0dcc2acd2d4519bebebe5.camel@gmail.com>
 <20240525180631.13446abc@jic23-huawei>
 <826c3185-74ca-423c-96f2-4fd4cf2481cb@baylibre.com>
Content-Language: en-US
In-Reply-To: <826c3185-74ca-423c-96f2-4fd4cf2481cb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan, Nuno,

just to be sure, is there something else needed from my side
for this patch-set ?


Thanks,
regards,
angelo

On 28/05/24 9:16 PM, Angelo Dureghello wrote:
> Hi Jonathan,
>
> On 25/05/24 7:06 PM, Jonathan Cameron wrote:
>> On Thu, 23 May 2024 14:45:01 +0200
>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>
>>> On Wed, 2024-05-22 at 17:01 +0200, Angelo Dureghello wrote:
>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>
>>>> After testing this driver, add some minor fixes and improvements,
>>>> as adding single channel variants support (ad3541r, ad3551r), also 
>>>> as a
>>>> preparatory step to bigger future improvements related to fast-rate 
>>>> mode
>>>> for this DAC family.
>>>>
>>>> Previous patches (v1, 3/3)
>>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-1-adureghello@baylibre.org 
>>>>
>>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-2-adureghello@baylibre.org/ 
>>>>
>>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-3-adureghello@baylibre.org/ 
>>>>
>>>>
>>>> Angelo Dureghello (6):
>>>>    dt-bindings: iio: dac: fix ad3552r gain parameter names
>>>>    dt-bindings: iio: dac: add ad35xxr single output variants
>>>>    iio: dac: ad3552r: add model data structure
>>>>    iio: dac: ad3552r: add support for ad3541r and ad3551r
>>>>    iio: dac: ad3552r: change AD3552R_NUM_CH define name
>>>>    iio: dac: ad3552r: uniform structure names
>>>>
>>>>   .../bindings/iio/dac/adi,ad3552r.yaml         |  43 ++++--
>>>>   drivers/iio/dac/ad3552r.c                     | 140 
>>>> ++++++++++++------
>>>>   2 files changed, 128 insertions(+), 55 deletions(-)
>>> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>>>
>> This series crossed with a series using
>> device_for_each_child_node_scoped()
>>
>> I've rebased on top of that. Was moderately straightforwards but
>> given last week I messed a similar change up completely please
>> check the testing branch of iio.git!
>>
>> The mess was all it the patch adding model_data
>
> i tested the driver from the iio testing beranch,
> it works as expected.
>
>> Thanks,
>>
>> Jonathan
>
> Thanks,
>
> Regards,
> angelo
>
>
-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


