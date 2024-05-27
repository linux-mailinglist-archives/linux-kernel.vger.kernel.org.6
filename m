Return-Path: <linux-kernel+bounces-190189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A128CFAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE91B211BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719523C482;
	Mon, 27 May 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1NETUD6n"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD63B1A2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797148; cv=none; b=BM6CfViv62sfdkjPN5Iuw1xAFvliIdvV6cM1sD6d9+JD89iKOogSVfwKVoj3TSQdo/Df1IQXa7qci2GVMBMQf6O7KAu4zeMpkiIG0RtkMf6TMCF9+Z7KnJj8jyz/lZBZHi0kqwM3flDBubQDHGuNEDHzROv3aOPSbOifjNAp4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797148; c=relaxed/simple;
	bh=0PSvznaULgAMyci1Cuzw0gj53Rvyogvjy4WMf8Yb64Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gna4SyA8KwGJx3q8dgeqEiK1sNFuhVo2fAPNrqF9jwfgfW/8ibA7x6cNkHmy6SWDI8krSlcCq3JQTDZpgLLMvqufYcml4bQVF+0cyvsARrIKHloZWcv7AcpX3/li56KWzeOSuVRnwFxpfHz30x3+53SxHf9h4vttNht5SL2p878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1NETUD6n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso44599145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716797145; x=1717401945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BtQhzjdT5QYL2ZvPWoXdnXVCwFUxuBDZKoHrk+bMdg=;
        b=1NETUD6naPz+cm+clSHXrAARVs9MXyfCKMrWBmAvzY8iMbyf1P+RrcLugx0jLIWpc8
         262PkgGfwhvUifY3QwwK6hwt+Xfx9Jyr9KHDChCZIvx+GDeuWLCB59/X0gGH4Lgq27UD
         Wn8H/le4eXPv5L5jzuxLr+nLpzQcp/3jrfG3zKMDn13U3128vYu/RmsaAgovMSy79gJb
         M2jc4vEgAb8/dhdzol1zWd/5LVxNVjIFwbug5zTmjRl+URVJCa4+98flheRlJA1OApMU
         ztkSUUnz8fnL2XNkO0xapkAodxi8c8Z9cR5a5s4lxGaukThRGNmIch3eeLPhZko2UsB/
         5gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797145; x=1717401945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BtQhzjdT5QYL2ZvPWoXdnXVCwFUxuBDZKoHrk+bMdg=;
        b=M1gSCKK6Vj6lhSMHnkq1Qs6R/rLeoLmk2VqGmD951j8VpsCU1zAotNezo8pR+Z6Gld
         95pR0BKnv2rY4LBVvrQu5nlRGMInileuom25ueoNTli8fPcwTFT7kSR6wnFVrWTiI5J/
         +HOH115IKVnE75JLJ84/w5//ntacW/Oby5dkt67T32FcKv8EgdWuA7Vmi3I1Jmqa9z5N
         1un0MXBTPal+KaudNjEUXXsV7zYElwEfve+WQZmHzsB9NK39+iZ6265mwYcA1hOHWLpB
         FG9QpZwcUPQWjwtEdC9FOKje0u/XRV6cq+KVjT+eEretLsJ73MDJ80DxLNsB1xIeGfyW
         eJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7ROPtTZOF0fRlIfgqgHiyqWEiwT49d2vaj6SpKm5Gn8BKlVKaUZg+e6SJ0LDG0Q3+twbIdub7QOqEKJxhWJZ+2goEgSr0vqngn/yS
X-Gm-Message-State: AOJu0YwRSpox/1c7ikr1TJ5aed9h0tKGicLQd5gjmNZjLhB+ZdkskGXX
	rFq+5ONWWODg+wFX0ccTko2ROJRWA75CG0VZcdBybWQUyFPhy9p+nGWkqqwMVz0=
X-Google-Smtp-Source: AGHT+IFjTh3sALivWS8cyiG3P2VqGfa6WZ9uRwNWd0jWYgzVAeeUnrCZ0dIfl1hzkqKwPke1T7cB2w==
X-Received: by 2002:a05:600c:56d6:b0:41f:f144:5623 with SMTP id 5b1f17b1804b1-421089cd2a7mr57708205e9.14.1716797144380;
        Mon, 27 May 2024 01:05:44 -0700 (PDT)
Received: from [192.168.0.2] (host-87-9-236-85.retail.telecomitalia.it. [87.9.236.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089cc504sm100277335e9.40.2024.05.27.01.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:05:43 -0700 (PDT)
Message-ID: <fe9d08e4-fc47-461f-8715-98aed484535d@baylibre.com>
Date: Mon, 27 May 2024 10:05:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] minor fixes and improvements
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522150141.1776196-1-adureghello@baylibre.org>
 <751faef385f81f8a2dd0dcc2acd2d4519bebebe5.camel@gmail.com>
 <20240525180631.13446abc@jic23-huawei>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240525180631.13446abc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 25/05/24 7:06 PM, Jonathan Cameron wrote:
> On Thu, 23 May 2024 14:45:01 +0200
> Nuno Sá <noname.nuno@gmail.com> wrote:
>
>> On Wed, 2024-05-22 at 17:01 +0200, Angelo Dureghello wrote:
>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>
>>> After testing this driver, add some minor fixes and improvements,
>>> as adding single channel variants support (ad3541r, ad3551r), also as a
>>> preparatory step to bigger future improvements related to fast-rate mode
>>> for this DAC family.
>>>
>>> Previous patches (v1, 3/3)
>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-1-adureghello@baylibre.org
>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-2-adureghello@baylibre.org/
>>> https://lore.kernel.org/linux-iio/20240510141836.1624009-3-adureghello@baylibre.org/
>>>
>>> Angelo Dureghello (6):
>>>    dt-bindings: iio: dac: fix ad3552r gain parameter names
>>>    dt-bindings: iio: dac: add ad35xxr single output variants
>>>    iio: dac: ad3552r: add model data structure
>>>    iio: dac: ad3552r: add support for ad3541r and ad3551r
>>>    iio: dac: ad3552r: change AD3552R_NUM_CH define name
>>>    iio: dac: ad3552r: uniform structure names
>>>
>>>   .../bindings/iio/dac/adi,ad3552r.yaml         |  43 ++++--
>>>   drivers/iio/dac/ad3552r.c                     | 140 ++++++++++++------
>>>   2 files changed, 128 insertions(+), 55 deletions(-)
>>>    
>> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>>
> This series crossed with a series using
> device_for_each_child_node_scoped()
>
> I've rebased on top of that. Was moderately straightforwards but
> given last week I messed a similar change up completely please
> check the testing branch of iio.git!
>
> The mess was all it the patch adding model_data

Thanks for this, sure, will check.


> Thanks,
>
> Jonathan

Regards,
angelo


