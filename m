Return-Path: <linux-kernel+bounces-377803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC079AC712
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BDA1F21FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B20D19E804;
	Wed, 23 Oct 2024 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7+RKXA1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDAF19DF53
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677210; cv=none; b=iERYrKbSRH72CqQ5eBMaW6lX3YOxcalj9kg5DKKxbW2dzwDA7Ou/CY9MqdsDQFeKl921BWmZrWoH/WXrBwuCjbzuYpcbNRhj1+ZMc6F3RHHpmilPyrFLPD35yMWdVW0LR052l3nOKUVhzPpmJl9AztSKJ58avrzFiQw+i8QpRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677210; c=relaxed/simple;
	bh=/BLIfQAtKqmhZEOcNIfrYKY9JpZSW1SIDoen9NMxzhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfQP6QrCzBbjkxQi5+LuGgCmbZUTNBRXA+a8C+I+itUb5TovUr9e2KTStFtKDgfNlSR+/0EEYQrUrM9WJI+9Ck9iZB0xF1Cx0auOkF9/vL7UTmlhznm0MlzmSaku7dpbAe1bskZdNYvIiLOo9AmgOB0hVfnepXMrN+786ie4D5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m7+RKXA1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0f198d38so913777266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729677207; x=1730282007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gInd/ZT940rkLW7Hy40LZDK1j6KO9dt/iHtLEkODb20=;
        b=m7+RKXA13OdLOVF4Fr7api5O4MK71Bf1FSevtucwLJ54dFa9S/AWuLNeLysbY7/0Ty
         FJE0srPSZA/UZ+QMPrbCT7mqJNaYxo8KaH6nregEl5vqVPBtDSd+DEFCeYF8/AXxw/Xl
         xr94obUZw9okcI92F0nv4Rqut4tPJIFe76OjKWhdefMeu2+iPaIiSqTIhfWtcEfIaCfS
         KDK6B34C+Gpcyb9J/UkmIo7P51XoEqQt84uoCn8dV8ahXP37B+wxZGbkpqZsH4awebAj
         RU53aFo2pBe5g46/nSE3eiSTGCMsCjG6GXUBNZLWFzsHr6qXnvz42/203olHCDOW6mhh
         bqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677207; x=1730282007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gInd/ZT940rkLW7Hy40LZDK1j6KO9dt/iHtLEkODb20=;
        b=HhAW7iImKolTeobOTC5VIr5H057g1I8DrzmiY8b02VgHCgfLF833xpne0aKjNe0Wo6
         PZsN2wvukXbmtc7yhGwY6y4swWNqugsFMzYOO+klOoNwvZOQB0ylRCDabpaKiufJkpam
         +Ayqw4MCL8cjDt3LR3njd3YBQbM65yqu6TTHh40UD6f8Ugreu3XqlDgorsa/IBYBDQfU
         l3Vd5ziQf3ezoraNyNf2LvSXThONVgOgqh/C999o5lLKCSWo+z0YrNecOCTXZ3GiE1KN
         kwho3/dk0xg4niCxQkc5vP7WJxUnfCTBnW+DONSgOeHFbG9K/uuYlsqa5MN06nwxFELJ
         5o/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWy8rJvwk/bp5o5JfipQ8GJYrU/QuQmYv3BpVakjmTuwBMESVpUonNE9ZSzyT7YGYhP/lDsHwBG4MseCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZ+P/tl86PuKSNzYCQPB2YSNv9UVK3JYZwpUalJHjWKI4mNEZ
	ygxbdMfon0XmF9hDiz6GYa/eOoxi94VZ1YPYzeOqo3UcOIJ/nuzYM23/gCFfR2A=
X-Google-Smtp-Source: AGHT+IGnIcL4a6Oer+hli449mELxDsnl6sHLLPt8fFrKySfMkHOlwqZ5FX2E1aHNIaTA/KyOnahWYQ==
X-Received: by 2002:a17:907:9411:b0:a99:762f:b298 with SMTP id a640c23a62f3a-a9abf94de80mr193476066b.41.1729677207496;
        Wed, 23 Oct 2024 02:53:27 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d62b8sm453063466b.25.2024.10.23.02.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:53:27 -0700 (PDT)
Message-ID: <2941d65e-8fb4-4d5a-be4b-283de2cb3274@linaro.org>
Date: Wed, 23 Oct 2024 10:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] firmware: add exynos acpm driver
To: Krzysztof Kozlowski <krzk@kernel.org>, jassisinghbrar@gmail.com
Cc: alim.akhtar@samsung.com, mst@redhat.com, javierm@redhat.com,
 tzimmermann@suse.de, bartosz.golaszewski@linaro.org,
 luzmaximilian@gmail.com, sudeep.holla@arm.com, conor.dooley@microchip.com,
 bjorn@rivosinc.com, ulf.hansson@linaro.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marcan@marcan.st, neal@gompa.dev,
 alyssa@rosenzweig.io, broonie@kernel.org, andre.draszik@linaro.org,
 willmcvicker@google.com, peter.griffin@linaro.org, kernel-team@android.com,
 vincent.guittot@linaro.org, daniel.lezcano@linaro.org
References: <20241017163649.3007062-1-tudor.ambarus@linaro.org>
 <20241017163649.3007062-3-tudor.ambarus@linaro.org>
 <955530a5-ef88-4ed1-94cf-fcd48fd248b2@kernel.org>
 <d41ee8f6-9a2c-4e33-844a-e71224692133@linaro.org>
 <1ece02e6-bf78-443a-8143-a54e94dd744c@kernel.org>
 <d91109a1-532a-4b95-ad4c-3b9cf8e3dbbb@linaro.org>
 <1e76bc70-21a6-4ac7-99ea-30a7ccf387bb@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <1e76bc70-21a6-4ac7-99ea-30a7ccf387bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/23/24 10:00 AM, Krzysztof Kozlowski wrote:
>>>>> I also cannot find any piece of code setting several of above, e.g. tx_base
>>>> I'm not writing any SRAM configuration fields, these fields are used to
>>>> read/retrive the channel parameters from SRAM.
>>> I meany tx_base is always 0. Where is this property set? Ever?
>> It's not zero. My assumption is it is set in the acpm firmware, but I
> Where is any assignment to this member?

In probe() you'll see that exynos_acpm->shmem is a pointer in SRAM to a
struct exynos_acpm_shmem __iomem *shmem;

Then in:

static int exynos_acpm_chans_init()
{
	struct exynos_acpm_shmem_chan __iomem *shmem_chans, *shmem_chan;
	struct exynos_acpm_shmem __iomem *shmem = exynos_acpm->shmem;
	...

	shmem_chans = exynos_acpm_get_iomem_addr(exynos_acpm->sram_base,
						 &shmem->chans);
	...
}

shmem->chans is not initialized (or tx_base). I'm using its address in
SRAM (&shmem->chans) which I then read it with readl_relaxed().

I guess one can do the same using offsetof:
shmem_chans = readl_realaxed(shmem + offsetof(struct exynos_acpm_shmem,
					      chans));

Thanks,
ta

