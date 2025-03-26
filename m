Return-Path: <linux-kernel+bounces-576629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D26A7120B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64553A5EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0293919D884;
	Wed, 26 Mar 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v77mN38t"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF61885B4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976399; cv=none; b=uMdS0yJx8a6qIhgKCUyfY4/JC+WTdTAjg/kLIjEU5npcobSbmJLiKRZgKeVkJcH/qcaV5ZJp4G5m9Wk4JGUQZ0Bb72q9QdfU0GlRGRvY2Gx0StHlZnsC+OAOybOSqDn9T4QVwBiguwn/H9vfQL69KbaZH8GJyJRa5hh9os6V93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976399; c=relaxed/simple;
	bh=4nDeNoSkBzCg+C5J6mBD5H7nyKcHzG81NqlE7tcPgvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMapHGv9j6elkAFOwwMCO22Y0k2AP8f9Tp9CulO7LuZGFmqHr2lRTwXy0BNnxRllLPVFlHhVjQwuO3PZyUp1HBAocuOMC/dXKtbAwGKushXWKV5CPz2lSqbymHpeHIVqQWFrwrzhku0Bqn8XElQ4PGGRNB/qcPRJdGSFpADLKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v77mN38t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso43826965e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742976395; x=1743581195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gqMtStm44sDN1iRrEG5qA3sdLqKE4ejLrbFQPQv/y0=;
        b=v77mN38tdYftr27nkaRVvz+FJG2PKvlRe54bnoeINhPjlvH/gMXqIyUitmycOb3FnA
         rpZU2TxvyOHN7UDjmq0TFUsPCYf7fzih9p9gtYb4Yygpyy53OUGewNUQNdE4aRDxeJNB
         ANlJW9G1++sO2H/84sLWcSYtcRrgjZW1VQE5y/NvrI9P9sUngXa6SmH43aZYe87ZRD2o
         j7Bt8WVEK1+mHgQGsnvVDCU9iCrFJGHjZ279d2KyUZQnUoJOtSp4hpIUAuVeebmZL8eU
         +lytSzvWUT0ZL6tSPoz9Oov97QcekEUiWO4vC7mfbAAdWRu6m8qKFHoc6iBXsNmco5EQ
         /rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742976395; x=1743581195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gqMtStm44sDN1iRrEG5qA3sdLqKE4ejLrbFQPQv/y0=;
        b=u0nq0nzn+7Mb1ld6mMq7O4JZdHIV3pe+JiqpFqqFFN1rbZnhUHLPOsGm6WKYrPciDF
         f5TxbajhbLe4HLJyvrs+mAGwzaSM7YtuoAl+HyhoTTHC8ijVPcT8WI3L+lVv+UyhfnH6
         sQIyZ1JvJpIdrIHJOr/86/dJnR5RWWR2zq+BEgnGd2SX3sP8gWytCWJAOBDXLV0ucZyt
         QOFxjnCfkIENTSJYCLIm/+hdRk+MLVQeaCKgQkqS4OpZRpjqwyXfUA0LvbDpjzWJHAu/
         15kMm/gTlySZMOYtMUr8q79oapEM4qA7jay+30LrwKxGsrQReMqnT3XGUblkX0NZof/K
         NFVA==
X-Gm-Message-State: AOJu0Yy0fEduAiAPkwNtkkHZwWV8vXcy0MCNg2MLgPCIB/mHEAOmbA29
	4mBb8YB6vLgTgcniRqr2D8ycbthsu2pDl2jl66nOXLKGL9HE3cvUf+BdSMN2PeU=
X-Gm-Gg: ASbGncsaMZ0HCItISdc3V62cE7gIBbplhRsYPTi2cqAyNdl4QzSWt4zRvC7361xaLjL
	95mLu9t57+8liWHqfaCpLG23lWhrcIM1831+dI4UfHsZblR+FmIs6dwNCoD3Rr+u3ykx5sBjsTt
	rSKTykG2PDwem4bLDTLF0ZWTd6pj3I++jK8VLG8P2Yry11iGzisOjZns91A040BUdJ2lPMAELHU
	YsglhIFR5Jz0bJoAG6veyu1doJVJlCxLIMFeDYFRzVDRFms0Dsi1BovS5aXlIk/+xAFFmfGvSMW
	DWtW5z4+YJpUXt+jSrKhnnx644aEAnEtejM1buhe3HpW7KgrEgTZYUj3iNvCzp2g3TxtIW81nAm
	L6Pvunlp1
X-Google-Smtp-Source: AGHT+IGLoLRqgi6MSpyHe+/8p9iRPVFA3lPXpq3HIaDfSybdmPunM7GvMPFLrX3oQG6d+ZPluBW1Uw==
X-Received: by 2002:a05:600c:4e12:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-43d509e654fmr199464555e9.5.1742976395544;
        Wed, 26 Mar 2025 01:06:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d43fdeb79sm225846615e9.25.2025.03.26.01.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 01:06:35 -0700 (PDT)
Message-ID: <84ed89d5-91af-445b-96e6-2c1e41d65294@linaro.org>
Date: Wed, 26 Mar 2025 09:06:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP S32 Linux Team <s32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
 <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
 <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
 <098c5de8-9291-4f3e-a276-500825cac7c5@linaro.org>
 <068713cb-47ca-ae26-e113-9f5026be9196@oss.nxp.com>
 <cc2dd75c-e279-4e55-ab88-75498e93146a@linaro.org>
 <50d2c651-746e-4ddd-4036-f72742a622f8@oss.nxp.com>
 <e8054f85-2a23-4ceb-8e1c-7cdfe7c87628@linaro.org>
 <a31a575b-8f6d-6317-f172-b4f8b1a5cda7@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a31a575b-8f6d-6317-f172-b4f8b1a5cda7@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/2025 08:44, Ghennadi Procopciuc wrote:
> On 3/25/2025 3:54 PM, Daniel Lezcano wrote:
>> On 25/03/2025 14:21, Ghennadi Procopciuc wrote:
>>> On 3/25/2025 2:51 PM, Daniel Lezcano wrote:

[ ... ]

>>>>>
>>>>> This wouldn't be the case if the STM is kept running/counting during
>>>>> the
>>>>> clock event setup, with only the clock event interrupt being disabled
>>>>> (CCR.CEN).
>>>>
>>>> Are you asking to use two different channels for the same STM instance,
>>>> one for the clocksource and one for the clockevent ?
>>>>
>>>
>>> I suggested using the CNT register to obtain the count for the clock
>>> source, while using one of the STM channels for the clock event.
>>
>> Ah, ok.
>>
>> I think it is preferable to keep them separated to keep the code
>> modular. Given the number of STM on the platform, it does not hurt
>>
> 
> The S32G2 and S32G3 are SoCs featuring a diverse set of cores. Linux is
> expected to run on Cortex-A53 cores, while other software stacks will
> operate on Cortex-M cores. The number of STM instances has been sized to
> include at most one instance per core. Allocating six instances (1 clock
> source, 1 broadcast clock event, and 4 clock events for all A53 cores)
> to Linux on the S32G2 leaves the M7 software stacks without adequate STM
> coverage.

Mmh, right. From this perspective it makes sense.

> Additionally, the proposed implementation uses only one STM channel out
> of four, which is not optimal hardware usage. I suggest using all STM
> channels instead of limiting it to a single channel per instance, given
> that the driver already uses a global structure to pair STM instances
> with cores. This approach will optimize the number of instances required
> by Linux and leverage the capabilities of each STM.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

