Return-Path: <linux-kernel+bounces-533776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF83A45E67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AF01884FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB60218ADF;
	Wed, 26 Feb 2025 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or7JLWhJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCD218AC4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571582; cv=none; b=pr6e+mwmZg03EfI+DKtSvYDGsS5PymteE3b9DQ6I4F2ODuTJWReMoEH5LQtknKawNHRcEYLRH85M7IMG7caH8nWYmp5gGeGQ6ofTr9dbw4u6GZjLPsxhpeks8awPimsvGq0wwSV5NkEc6jcuXWQX5Az7Nf2cj1Qgcufx8RVse60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571582; c=relaxed/simple;
	bh=Ts6789W1ZvMBMtUOpTZ8PO/Ji0rQKX0d7WJqNr3CEgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNArfjUu+UqmDKu8qm4vyMik5ksqaW+kYiGt4jhUIaLQJiMiZx0gxItVSxsV7JyxjShHcKbR1h0q5HGNX8wzGeKvjBzRrCmz/5XUdeKhOAoLHPjUaGGdAZ2nkd5g9QWSNNyb5p2hGoeO9uh7/9+AFIZCiiDOoCcU7vteWDGCD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Or7JLWhJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5decbcd16d2so1277508a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740571579; x=1741176379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HNXNzVmrOgaR+bECtlN/olDKqfbUj02dZv1R9QJQ0Hw=;
        b=Or7JLWhJ/wtogXJhwYZzPL1Hczi4ZuAKUtzBFTjndCBRwdm7QMvKqMVcCc2ifyDBwP
         cX7Fpfc3o7hWsCdsKQHEtnTN3t0fw01sBq1jNZEL+/KUFMQY6RrqqckuFFdE3Sl3qjAm
         GaChzvKVZSS9A+fuohRUy40af3cMuJ/YTg+2U4BoYpvSEJUVBjpVphOBVOPu6zfRr9uA
         rixOxvY8JlpL2SkzmBY3gez0wmW7Fp5QmqZtfvP3WaDupzVtKT6kA48xXm7JpEi0KxAw
         QtwAJUdxxRIG8nD2OoHc6QykxvPswVf7X1jH+y7750lGDZVKJKrc42+Nk4rXlJA/kulV
         q90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571579; x=1741176379;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNXNzVmrOgaR+bECtlN/olDKqfbUj02dZv1R9QJQ0Hw=;
        b=bmFa88AVMada/RkrZmm9+Y+OrgW+xoRAizxjf00ea1teMpWO3jItp9fcZ7G0RAy52W
         SRWCncfjb5Lu3P3PX8tFODeBRgSslqf7Jwnr4OP0j7uDF2TgH3OCMIbYgNJn4KRcIlFc
         /MeNN858LEll6EzBaAvED2Vg199IH27eJ2+tm0SgHzGFFSqKce4UC3jyFyBdETgb9JkX
         2dDfeexA6hn4riH6QeSyDAeuq7H1Pliop7lX+d799eob4M3CFppJICvhENNR8qIT1r0p
         ddjhW433pvxiEspy+DzIpzCeBi4oUJIYZ2eYJjR3oZwzOU9Cpy0FUUYE3lHr306HOdNb
         SGOg==
X-Forwarded-Encrypted: i=1; AJvYcCXf7DVB5TdaWaCBYK5knfJA2UeikrDRr6UVQ10x7+Sh4/tjNs9f/uSLHhv4eSgQ2ai6UpUUzIet0Sb+9ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrusjjUEsF4PI3e4A5pSRW9DXEC0nKpgJaRpblOw7RykqIqhe7
	1h6HkCNYbOktWLbklvBvtMVjK+Kf5Qia64j32staahWX8ZOwgN/PSfYbzayZQsw=
X-Gm-Gg: ASbGncuQvEcEjhumszxNhA5ZlC/lrEXfVEc1n2cu0Pk2zzsoLshhroAF6VhJH5R7Evt
	hEa03in+GjJ5LiqglMb4ml0A2gnGPCxBlaY6eWZfB9RYKabSohCDn0DoqKnqMcqCGjGIEsFTPmq
	RurvmnH4m31rjj6nJtCLW6xyZWvJaRiWphAFOm9RWhjIVDAc4Ng/U0Z5HrE8isWvsFJx0uV48Gk
	aqqj4xM66pEtcbYFaRIfXGVfoxj/uv0PnSdSWTwu0/W/2mw8m4nbgebg+KtKpU1Zy7wpdVBBrDr
	PRrMTxCQsm0LZxGMOLtUqoBBl/nhLRcCyf/RP40X4drMeCEtC/nx6+O61QKNEo1cuIAnAy896ib
	xfD7Y5Q==
X-Google-Smtp-Source: AGHT+IH+7jstz2VlJvmNcVTmHSTGS7gvGZ/ZCQgLWkgUNLHbPoENhiPRMVQwEoVSMCIWUmWee4AFzQ==
X-Received: by 2002:a05:6402:3584:b0:5dc:cea7:4e2 with SMTP id 4fb4d7f45d1cf-5e0b70ee34emr7031925a12.4.1740571578816;
        Wed, 26 Feb 2025 04:06:18 -0800 (PST)
Received: from [192.168.0.104] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e492120418sm2294952a12.14.2025.02.26.04.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 04:06:18 -0800 (PST)
Message-ID: <a3fc706c-3825-49fc-beea-3fea7d9c0038@linaro.org>
Date: Wed, 26 Feb 2025 13:06:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: Enable HSR driver
To: "Malladi, Meghana" <m-malladi@ti.com>, Arnd Bergmann <arnd@arndb.de>
Cc: quic_bjorande@quicinc.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, srk@ti.com,
 "Anwar, Md Danish" <danishanwar@ti.com>, catalin.marinas@arm.com,
 will@kernel.org
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
 <686f583d-6bf4-4486-b9e4-20c1e268eda6@ti.com>
 <d4954e5e-e51f-41c0-bca5-6e14b4640022@linaro.org>
 <0d33dea6-c021-4f2a-bb3f-92efd6eebd18@ti.com>
 <6081917c-9c20-48fc-baaf-7ac9a9679a72@linaro.org>
 <1982291f-4a02-4ed2-b4bf-778a2fe0ad9e@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1982291f-4a02-4ed2-b4bf-778a2fe0ad9e@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2025 12:54, Malladi, Meghana wrote:
> Hi Krzysztof,
> 
> On 2/26/2025 4:18 PM, Krzysztof Kozlowski wrote:
>> On 26/02/2025 11: 44, Malladi, Meghana wrote: > > > On 2/26/2025 1: 35 
>> PM, Krzysztof Kozlowski wrote: >> On 26/02/2025 07: 18, Malladi, Meghana 
>> wrote: > Hi all, > > Apologies in >> case you are receiving this email
>> ZjQcmQRYFpfptBannerStart
>> This message was sent from outside of Texas Instruments.
>> Do not click links or open attachments unless you recognize the source 
>> of this email and know the content is safe.
>> Report Suspicious
>> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
>> updq3RaPV007wGXFFrPD30z5a3GGYjpJweyhUcIfUTTaUs-8q0QpC4Yk9azBiFp7cBAf2Knk6fnVs4Fs-zRjTMEn8kmpiGo$>
>> ZjQcmQRYFpfptBannerEnd
>>
>> On 26/02/2025 11:44, Malladi, Meghana wrote:
>>>
>>>
>>> On 2/26/2025 1:35 PM, Krzysztof Kozlowski wrote:
>>>> On 26/02/2025 07: 18, Malladi, Meghana wrote: > Hi all, > > Apologies in 
>>>> case you are receiving this email for the second time. > Any reason why 
>>>> this patch hasn't been merged yet. Other than re-basing > this to the 
>>>> tip, anything
>>>> ZjQcmQRYFpfptBannerStart
>>>> This message was sent from outside of Texas Instruments.
>>>> Do not click links or open attachments unless you recognize the source 
>>>> of this email and know the content is safe.
>>>> Report Suspicious
>>>> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
>>>> updgnZav1ue7gKXOnHOpH5hg8gLmw9Osqsqh- 
>>>> KTLRTnBEurV_VetrG7mzU898vB_5xFrYgbRkkuuFMBobM-uhFAmUgccRSk$>
>>>> ZjQcmQRYFpfptBannerEnd
>>>>
>>>> On 26/02/2025 07:18, Malladi, Meghana wrote:
>>>>> Hi all,
>>>>>
>>>>> Apologies in case you are receiving this email for the second time.
>>
>> BTW, Arnd when responded with Ack described the process.
>>
> 
> Yes, I wanted to re-confirm before posting it again (just in case).
> 
>>>>> Any reason why this patch hasn't been merged yet. Other than re-basing 
>>>>> this to the tip, anything else which needs to be addressed to get this 
>>>>> merged?
>>>>
>>>> I don't think you sent it to your platform maintainers, so no one would
>>>> apply it. Usually people ignore emails they did not receive, although I
>>>> am here an exception tracking missing-DT-patchwork things... :)
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Hello Arnd/Krzysztof,
>>>
>>> Thank you for the replies :)
>>> Was having ambiguity since this is not TI specific change. Wanted to 
>>> confirm before re-posting. Will post v2 patch including TI platform 
>>> maintainers.
>>
>> It is not TI specific? Then which upstream boards benefit from this if
>> not TI?
>>
> 
> This change enables generic HSR protocol support in the kernel which is 
> required for HSR driver support in TI boards. When I said "not TI 
> specific" - I meant this change is not internal to TI driver. Hope this 
> clarifies the miscommunication from my earlier mail.

Yes, sure, but this defconfig change benefits and is sent for certain TI
upstream boards, so it is TI upstream maintainers field. It still fits
the "Submitting Patches for Given SoC" in SoC maintainer profile.

Best regards,
Krzysztof

