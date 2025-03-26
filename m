Return-Path: <linux-kernel+bounces-576577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C848EA71155
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4863AC7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA781953AD;
	Wed, 26 Mar 2025 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5enOoIX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2050198A1A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973868; cv=none; b=rfjNjiSXMV1kG2As2W1pmu45Un/pjDXEEZfk8kD56/9qMY8F1/A7zSM+jYZE5wHHmsTTXBHIXlII5QbHBmU+hEx7KSNrVjXI1XbMh0SUTa46EQPOT3EZIwoMCcGErR1lOW/KYjZbIalM8/TiN3ukONqFVtuxej6nhHsJAYBDTT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973868; c=relaxed/simple;
	bh=54cd63a34vf2HcC+TZzb0ZdkVJCZUFfzB+6Lus/qZbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/gQ5KAd5nc5tzwMdyMKfTGkBBmv0wfjNcyMNnKsnSUS9NZo5USRn87LX2fvoV1QJdVuVBZu0K1754RYTXsEu1MMpNVmpLoPaUTzkjQVTx8P0pONGuBnhsrF3tu9k60JfVqDRopTX0XsZeeJlAlo0NSt3M9q4usqdAH2YMwARa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q5enOoIX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394036c0efso40904585e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742973865; x=1743578665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WjwjGLl32A3KiDt34QpamT6Oni1xHmFU/Px0IbQnoY=;
        b=q5enOoIX3ClvgYIOx7oHhP6r8eJZs2dy7CqCLCuNXBhvXkua6ccO42b/rjvc3SoNFK
         ELMUZk8jVHNpUZjkrXLTqBBstf6KX7COGkV8+pYhexBS/1R2X/WKb56OlRQd5Cd5p9hP
         SNqehENewhuJh3wt8rwqQ2iTMSY3bmb1423enMaObtX/SviCD5szvmq5UgFsfIMv3lkc
         ccFb7UPWLSXpTBz6DQS4i56RYXRQkO6BD8nTIUtZhtpTqZcwJB1ZijU/HSn6mVpP3kLQ
         74+e5pPkdrK/nimqJMdNxggXzXYDMH4ZYpyI78qoqphP/hbwT1X1p2keEvi36bZ/rCbE
         O+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742973865; x=1743578665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WjwjGLl32A3KiDt34QpamT6Oni1xHmFU/Px0IbQnoY=;
        b=WFe6HJucldTCC4c520VatjtFajbtydJRYT/NOs5LJHk8qDPFUX3fo1dw1z63YhdQO1
         kzEESkJjAtwIgFFTKNBCiv+elYouLKlv1NNRl/0PLHt0lRm8SxndCDVxH7H6eGSxO9v/
         RLtXAjwbTzXWy8RVv56epeyLLoS62I3eJUD0TVL7s9gVHmKx1q4htF2ImW3gcfzdZtxm
         x+KXdHCgA+zgSa1I5ZFZk+wRcc2o30DCd2BKKptB6/KV0rUWeIKrX8T8DYqkDUPyh/FZ
         /fF9Abb8XdJpCnUqaS2L4fwq8urRCsaLhHJlmzwuLvyvD6GIXM8TxVu7knz9Yc4eJGRM
         pMtw==
X-Forwarded-Encrypted: i=1; AJvYcCXKe2E35SsyDNUsdX7S3xltFOhe/NVJCVjHR+t98EVg/0g4GASKJgdKml2fQ9OoAOOeFpfCfFHyH2bnyMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9KOMxpod/B0xYs1Sk9meiNTEP3lG7KPWGyQY/SBVNq+6WvrtF
	X4K/2T7wEGZ7ZhuXHTdLQkxyFM/Q9XcdvkxZbNUgjfrqeXSTTMlnhwYzeKYISws=
X-Gm-Gg: ASbGncsUk96yFqjsVPAtq8Rsnrxm/P1CCdQ8tFDLLhNgFCcJy2QiELGnXHWLwPxd0d0
	B94UFJiWSeq6c7uE8qoh/kglVLWprvcGYk56vHeX3dSQIVIE9N2BrQQ0vTa+G22rYfX5Jj33Qha
	muxrMSFx6W1/EumLESHW4y4R9rkNuIg3fGe5h0EnvalhHVO61glTAU92eaJyug2KwMfTbWh6/m3
	DiNwAR01IZ6+UlZ5Gd1Yyvr1yIbHXmQAU3Ag1kTvkCny/CJO8WA17JLu57zMCw6+JA4jB1T7Rng
	IfPpPJeo1rYEx8qfAOGx5A2Svhem+lNIRuIT6D6k5/010q7376vrjWM=
X-Google-Smtp-Source: AGHT+IFV7fd+M/H9BFgJClv0I0A4YnOUCaUBe1bBC0ZrrT9wb1YxMcUrftw6F8ycCV7VPua/wYkfPw==
X-Received: by 2002:a05:600c:4747:b0:43d:2313:7b4a with SMTP id 5b1f17b1804b1-43d509e43e3mr184235705e9.3.1742973864876;
        Wed, 26 Mar 2025 00:24:24 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f33242sm225247215e9.5.2025.03.26.00.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 00:24:23 -0700 (PDT)
Message-ID: <42905f72-100b-432a-becb-7e1f835e518e@linaro.org>
Date: Wed, 26 Mar 2025 07:24:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] firmware: exynos-acpm: allow use during system
 shutdown
To: Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250324-acpm-atomic-v2-0-7d87746e1765@linaro.org>
 <20250324-acpm-atomic-v2-2-7d87746e1765@linaro.org>
 <be580155-372f-445b-b9d1-2dc4fbf1c3a1@kernel.org>
 <974ddabee5a2a43b9d32f382ec4b13afab066f1a.camel@linaro.org>
 <60732c52-7774-48c6-8ec8-44ae82d86267@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <60732c52-7774-48c6-8ec8-44ae82d86267@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/25/25 8:07 AM, Krzysztof Kozlowski wrote:
> On 25/03/2025 09:01, André Draszik wrote:
>> Hi Krzysztof,
>>
>> On Tue, 2025-03-25 at 08:57 +0100, Krzysztof Kozlowski wrote:
>>> On 24/03/2025 16:34, André Draszik wrote:
>>>> +static bool acpm_may_sleep(void)
>>>> +{
>>>> +	return system_state <= SYSTEM_RUNNING ||
>>>> +		(IS_ENABLED(CONFIG_PREEMPT_COUNT) ? preemptible() : !irqs_disabled());
>>>> +}
>>>> +
>>>>  /**
>>>>   * acpm_dequeue_by_polling() - RX dequeue by polling.
>>>>   * @achan:	ACPM channel info.
>>>> @@ -300,7 +314,10 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
>>>>  			return 0;
>>>>  
>>>>  		/* Determined experimentally. */
>>>> -		usleep_range(20, 30);
>>>> +		if (!acpm_may_sleep())
>>>> +			udelay(10);
>>>> +		else
>>>
>>> ... and what do you do if IRQs get disabled exactly in this moment? This
>>> is just racy. You cannot check for a condition and assume it will be
>>> valid for whatever time you want it to be valid.
>>>
>>> What happens if system_state is changed to shutdown in this particular
>>> moment? How did you prevent this from happening?
>>
>> Yes, and that's also what the I2C subsystem is doing, AFAICS, see
>> i2c_in_atomic_xfer_mode() and its use. This is to make a very
>> specific corner case work, similar to I2C which has to deal with
>> the same issue during shutdown.
> 
> But they don't have a choice so they try to do the best to avoid
> sleeping. And it is a subsystem, not a driver, which means their
> patterns are sometimes special. Drivers should not replicate subsystem
> workarounds.
> 
>>
>> Would you have a better suggestion?
> 
> Yes, you have a choice, you can always use udelay. Driver code is
> supposed to be always correct.

Using udelay() is good enough for now. I see that downstream uses a
usleep_range(50, 100) and I'm concerned that we're going to waste lots
of cpu cyles once more and more clients get added.

If there's no concurrency on the ACPM queue mutexes at late system
shutdown, would it work to pass the don't sleep requirement from the
client to ACPM and use udelay only then?

Cheers,
ta

