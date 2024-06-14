Return-Path: <linux-kernel+bounces-215449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA329092DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD8E2855A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97D819E7C1;
	Fri, 14 Jun 2024 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hg4RADWB"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F871487C7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392698; cv=none; b=RqWVGr78LtywLkgsovFrQhs+3XsuCtysu7220dzKeVSshgU9cNc2/+xgj/P8UO8Uv2xOb3FBGqHvQS4GzmO1NJmvT6W61w1e3TnrppQ54T9lSBuNh64nzp/D+J+b2DW2bIqrnk/Yf3eBGy8EK202kp6pGuG/dYmxOADPi4kX9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392698; c=relaxed/simple;
	bh=tdDbH+Puela8GcjBir2w1hVjGJFIMP0Q6vxjuEJvfxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/UqzvNZlku0ie0/YVB3l+G19ClkmulboCWf3GrOtRrTXGxGhRNu2nR9RhEBiPWeibbCn/HM1yJ/rD8Aly89gZHf8jlVTi0eyHgmDFVLMUauQ6Ph+NhGjfnrqqcWVJYcf0QSN0fMeVgZ61Eaa8lOm4LC0r5TTgShhamtPLPFc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hg4RADWB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b065d12dc6so12709236d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718392695; x=1718997495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdDbH+Puela8GcjBir2w1hVjGJFIMP0Q6vxjuEJvfxg=;
        b=hg4RADWBkSVtzEatCC7JWekyKE1GVDldNOVPw9YTUm3FLrpH4bEDe8Faj23ojMHpH8
         bC8krjbBDbpxN39g0YHjAqAyy3xsCAL2bqNV0Y/zJT+I6BX/xu70ZgZwc/JnwHAn+Ndt
         F42BF6tYMmAnDLK2xijo4ydA6ibh8GcfcE5rKiaIA9ZQ0XEG7jincTOxwBsLPoltzGGf
         TYdj8fW1qoSP89yaTC7fWlwt7HHONRToq1D0dp/zrr0FY5NGyCux813CwgcDlWmRIusD
         XHzl38sm8fNFaupFaVtJBUQgXLOc1Nh4dpQyhQpmznhwx3XJPpJqgyrYfLho2R/NheN1
         9KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392695; x=1718997495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdDbH+Puela8GcjBir2w1hVjGJFIMP0Q6vxjuEJvfxg=;
        b=PkC1xr6aCeCt/62My8w1SbY/8wXmdhR9oVq0laPmAbw4w7Ui7cVyhxM8nGUfEM20UJ
         D3HhSyUH6Y+MFv8BX7lZEn/wq0ODzLB6uyoKoMdRbg0fbUWA4q748x3zk6UwxsqIzUK+
         gR56KFMPP4hkh7aM7E21UNQvvIPw32O+CeKXP/qFUH4/39zqb4KCOWKLaHAM2ihTPMve
         ERhJ5Op9V7twkpZNA1SD9g8zvGqGOI0/X/dqLif+k7M7r1PkDOL1e9mJnmBMu46MW6Se
         IeoUWHxSuplK5KdMeErC14Bac08Hw2NP1DdspHaeNpd8Sqvd9MhAAcmkRe9IyQJkAa8V
         lXmA==
X-Forwarded-Encrypted: i=1; AJvYcCVIhF6s2ZUvSIHR4zYXazHosnhufqjIL0zdskQDQjFRQqzDUH/0Y5to0buKfjjDEQOTzODZboG2J8UCijEf2TUK8DYLz0FCzihMFl60
X-Gm-Message-State: AOJu0Yw6YAk4KWDiPg5jhSqMXGGnzvPHfPKaBguMRAAy9/uJ35oU3ipx
	oCr/GxngCKuaqnWbT8WlbI4e/yCBbgAJrsaaNBdP+n2KnScMRjiVfryv63s/9LI=
X-Google-Smtp-Source: AGHT+IESVCS+ALD38NVdIUc0A9n3fVnIRuJrt6B5Nfu3A/Str0yGuf4a0V+N4cgl4VIb5bHvl5yXhw==
X-Received: by 2002:a0c:9cce:0:b0:6b2:b2c4:90f5 with SMTP id 6a1803df08f44-6b2b2c49289mr29705686d6.4.1718392694328;
        Fri, 14 Jun 2024 12:18:14 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4a23sm21545956d6.75.2024.06.14.12.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 12:18:14 -0700 (PDT)
Message-ID: <964821b3-dcbb-42b8-9062-2366a4d30a76@baylibre.com>
Date: Fri, 14 Jun 2024 15:18:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: adi-axi-adc: improve probe() error messaging
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613163407.2147884-1-tgamblin@baylibre.com>
 <57d4659a5abb63d7c085865059b9d71c40371edd.camel@gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <57d4659a5abb63d7c085865059b9d71c40371edd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-06-14 5:11 a.m., Nuno Sá wrote:
> On Thu, 2024-06-13 at 12:34 -0400, Trevor Gamblin wrote:
>> The current error handling for calls such as devm_clk_get_enabled() in
>> the adi-axi-adc probe() function means that, if a property such as
>> 'clocks' (for example) is not present in the devicetree when booting a
>> kernel with the driver enabled, the resulting error message will be
>> vague, e.g.:
>>
>>> adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with error -2
>> Change the devm_clk_get_enabled(), devm_regmap_init_mmio(), and
>> devm_iio_backend_register() checks to use dev_err_probe() with some
>> context for easier debugging.
>>
>> After the fix:
>>
>>> adi_axi_adc 44a00000.backend: error -ENOENT: failed to get clock
>>> adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with error -2
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
> Somehow feel that in these cases the error log should come from the functions we're
> calling but bah... likely not going happen/change:
>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
> (As a suggestion, you may do similar work in the axi-dac driver)

Thanks. I'll send that early next week after a quick test on a board.

Trevor

>
> - Nuno Sá
>
>

