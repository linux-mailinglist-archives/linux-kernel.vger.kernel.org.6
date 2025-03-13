Return-Path: <linux-kernel+bounces-560379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F41A60352
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48A83B7C05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B11F417E;
	Thu, 13 Mar 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1b5+Vrpv"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481801F3B91
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900673; cv=none; b=aRzWF8kBxayCvoSPeBKqaUPa0g6UQcK9HRWC8GiBj3wiuMzjaY7wxcHOuwzkeqphSp8P9bexsZSMr/pAh5TawcBp1Wu3lrfsCPmkF+wBxn2QP1xYuDCaIrGnbxXNKqMKZG3EvZ0CDuoaE6JJ/GXFd4+iRafiS3LPLO3F74EWAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900673; c=relaxed/simple;
	bh=G4ASBTtqtknhUvwbdVnJBrEV71JuUUm2tjJwlnY30mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVzsBKC4L2XOiuYwytvylOLmnol36+JhD1oCY+WRPDZ1yrzmTD5GNCetO40qJrPviIGzr/fVb8LFEUQrKdl/OCVY9CWSNLw6kqPTsmaPdyOb97jMXKq8OI2urXvkRzpO+27dwZLfCXv+kxutRBOL6VrATaROMAeSWCraunOy9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1b5+Vrpv; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72bb9725de4so62812a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741900669; x=1742505469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBuMvSWKrj6vDaWbSVnQynse1bN77KOct+TmAZuqGnQ=;
        b=1b5+VrpvHqle+jGwoBog35dtLkyaADU48hdP9PmyAkH1oXHcxN3y43Vtw1+YiLu6x9
         OEBQOuppdZWd9JY2vJDxolTkWokSRHU/bdBrZZE7wohgVjOsUml436z5OZL3wq2BnLa3
         h9BMLp/YfUU0LQBueNSDEw8OwWHRKcsUYCm/+0PopaTtG0d5xceIF1uFs/XKPFwkqDU3
         7LIqHtPeZOvOo/OIvuZWJ8L4xR5JpspPFap9iLd81kFXX7FyIFmYJnDG7ic9T6yf7Ljw
         i2cB4EqadZnpH/PSgnQ3Pyxmbf6QvtccSKpFfD/fnEkJDvpAPkeZ95+Z5B0PqIcJh9cQ
         xUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900669; x=1742505469;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBuMvSWKrj6vDaWbSVnQynse1bN77KOct+TmAZuqGnQ=;
        b=TbOUlCWEN6RiGVP+tRjI/8zy1oEuT4fQiCaE4FDr+VTQZCAs0AUGEul9nWM1RUmEOJ
         9uG+AZqh2NUzA0lZ790eRYqwOZMTM6tGXhZ/MC7KcGy6YjElRv57Sk4JgbJ5JbU6Eu4H
         +8sVBRIOIUi386dTBvk4YxRWv/VULSD/rR+jhsAdPbxeriiO6528eOJ8074LrMbI9JWJ
         kGLHS805qpmVcCoEV3GjbrKYU38XkRPPtvQnwhQT5kuf8+oDj4moRcaUUoVVJvKamyvV
         tfQFYgnbebE8BJLI8xihzZt/zlXfLP2t55NAhPPHFnSJu/azNZ4Ojftf3bgEdWdqN3td
         OKZg==
X-Forwarded-Encrypted: i=1; AJvYcCVSUtYHgGtGfP7DzA3egtyUazVKRpnHowxaqdoZYjX8g6XljCCPS32JgcbcGzE/nh6KWQSmnSdqLzhL8t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCDWmiVU8Uuk3/1pm4n6qgJMMxj+1yUxAK8WWIGLyyr/hDGFp
	+FQpY4wAwO1ThN+M2IVUMaWsvbW+cu4CyD8dxbYhuCZEMKb9y3CTUxqDv/tQYN7VXIIzTv6L5Ab
	dvcE=
X-Gm-Gg: ASbGncsvuKzDuh23zReZzp8QIslqbZXKw2PcaPykbYlO6mbrecpHvY/+he5pamDk17d
	VgyRK+fT3ua3LqOEMBcIZp7DU5bdpbDWqhm8jA/oSFAfjRzovNo0PW1wv5yKO/C9OIjj/5AfSr/
	JmKyCtr7a1C4ZYxoQ5Z+aKB8KIyIro88mrS3DCz+mW13aMeEeWAk+Yx5Kzjz/Pio9B3WtKztQBx
	ItRHK/Bljc3+VOKsTf7m9xplOwv7JgzVdxLox1SJq2x/thb2qNhJqJVn6j329f+TScH2mvEjZ19
	VWPkSJ0SegZgSaRjLC0voTjL3dqKoJRAo8liRLbmf2/841P9kPhQRkpFMN4aVen3eSt1UGismSO
	Li103ZQ==
X-Google-Smtp-Source: AGHT+IFXmac6Zno1e8gIT1+e4oFU8bsJfG4bD93al3kFBt3DuzLabzwqDobbA9nezeqb4ONGDiWQcA==
X-Received: by 2002:a05:6830:64c7:b0:72a:1ecc:d23a with SMTP id 46e09a7af769-72bb95ef063mr821303a34.15.1741900668987;
        Thu, 13 Mar 2025 14:17:48 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c670f77a5bsm479504fac.9.2025.03.13.14.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 14:17:47 -0700 (PDT)
Message-ID: <4866908a-2e93-4d19-aef3-5203e002a8cf@baylibre.com>
Date: Thu, 13 Mar 2025 16:17:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: davinci: da850: fix selecting ARCH_DAVINCI_DA8XX
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240401-da850-fix-select-da8xx-v1-1-a348ab91448f@baylibre.com>
 <CAMRc=Mc7Xa58J55_kenkr2OA=ho6YH_gENOFEvAiA+q+p54dDQ@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAMRc=Mc7Xa58J55_kenkr2OA=ho6YH_gENOFEvAiA+q+p54dDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/2/24 3:47 AM, Bartosz Golaszewski wrote:
> On Mon, Apr 1, 2024 at 5:10 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Chips in the DA850 family need to have ARCH_DAVINCI_DA8XX to be selected
>> in order to enable some peripheral drivers.
>>
>> This was accidentally removed in a previous commit.
>>
>> Fixes: dec85a95167a ("ARM: davinci: clean up platform support")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
>> index 2a8a9fe46586..3fa15f342240 100644
>> --- a/arch/arm/mach-davinci/Kconfig
>> +++ b/arch/arm/mach-davinci/Kconfig
>> @@ -27,6 +27,7 @@ config ARCH_DAVINCI_DA830
>>
>>  config ARCH_DAVINCI_DA850
>>         bool "DA850/OMAP-L138/AM18x based system"
>> +       select ARCH_DAVINCI_DA8XX
>>         select DAVINCI_CP_INTC
>>
>>  config ARCH_DAVINCI_DA8XX
>>
>> ---
>> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
>> change-id: 20240401-da850-fix-select-da8xx-989725eec11f
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi Bartosz, here's an old one that never got picked up and I never got around
to resending. Can you pick it up along with the other davinci stuff you are
doing this cycle?

