Return-Path: <linux-kernel+bounces-533565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFD1A45C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330673A87C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858120CCEB;
	Wed, 26 Feb 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wxbtssf4"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1E42A9D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566934; cv=none; b=mHFqAy7hyvFDlTPpHSth1deGJ/XxT9oklctPc91PgNwjqNzaZP6lQyvgArNuiRvszPou16cN26DVbjwttLFVJL4jvEfX1v83swBn5YQCGjG08QB9AtbEfhxOCgbLYPXovIRoXNTa3eehu7JBz4kEm0rda3e9sTT/QXZqv8OMr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566934; c=relaxed/simple;
	bh=iZSURv8naKjbpZanU/bYA6npX1Qr4KscMJElBD89bZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTbm67DulybDF3Q/NWK9Y/9IJ4Hk5o6tZwn594hv9Dy+f3uR33QhUe3NfYdIwzXXGVEGGb1HmakcQ462HFax1FT0Uzx+FhsG/DXRJSUFebYAPJJHWym+5pFty13jEHAjTs3UY3pcfFkFNRQe4KxpeE6FHW29ijyoXhwdnlQt5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wxbtssf4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7098af6fdso86762966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740566930; x=1741171730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h1AUDkIYHFTiZDH2tacRrFnFij+C4loBMjOCLBHx+n0=;
        b=Wxbtssf4mZMzM9nEfMY/5lfpnTtcYWAmCwBmNDDvwbSts10G6lguwRMYhijGYQItPy
         uUTPT6pgy+yzBijspioMG/bwBZRICxPza0OCj/yrIfPhTEPdJLMqUxvAZLBp0pjJToU9
         N3ijiuUx5FE/ZmFvqGW14xdFpEy4N7RWbaf/cNntBUkyd1/R0xp2avxrNYxTJTA4B92O
         r3gKw3mW0798n8go6f/FYpQ0NErWxVCUkIEWpPEl6s5HSArAzTsCGx//9pzPfG4rK3tN
         GoLJJ0aRyv/226Z8wlVYUry+dA87tFuEWoOcjcW5rETqpEo3D0AMX0ZybPhiwnARzAnZ
         ThvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566930; x=1741171730;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1AUDkIYHFTiZDH2tacRrFnFij+C4loBMjOCLBHx+n0=;
        b=S4XhW9kV/3XG7MgdodsYOfmvVq6o6PaqEfB95+AeUK8MrDQbrJSwRMPS1a0vl7SSI7
         3WdcXo4+7nxTB0cQlIQILVIbSCd6c1Swl4jEfhFqjx3rfXYQNkIsvXnDpxYAGT/2jv42
         bHlA74jxoWUveUg/RE68YXi6Xi3wbTApCPC7eUrrcpBzx9IKIy9X4YBsb/Sw3BzZ9GSE
         GxRDZ1oBSFPdxEInzNfUkl/v11puksiVuwSopsKWPRVPmnFcP1x3gmjX8sDt9uXqjxdG
         dc+4xga1HGKKBscwePLf2dngmW5oU35v37gFGENxsTZ7WLIoy0Ezmlic9tcO5Jus1xHc
         YVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUGyxwaP3yDgjtKKrOXfzI322f1dclQ25eXys7zvMQLRohfltkBxNo99qyYD+yDdI1UAzcTcMTqHofl3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/2QA0Umz3ssRz+P8/uhmYaZPoR6OaS1yidBJ+HVlU28CeJ3i
	4zHNGxIeKdL9c5v18GQvsh3cpl0vRFcfD3Gw5PK4JipDeJx5WRbyhfZwjr1Lfik=
X-Gm-Gg: ASbGnctWEp9J3omqHfeVaBsAa4JYxmjmuzLnaw/KnACtfwY8g4ncsJ2G0fnmdMaRtka
	mKugjF4uOtB+H5iIWJjcxfS5DQ7XpsiiX793wTX8YAM3lB1ciNww0pKofd1JeAuKdO7iCLId/1e
	qI2yry/UF8+YpTwH5Vf/Awdt2sGCRmlTKdI6kBO099AA33v+CHgCT0AgkNfcPdp4TF823w7mCQv
	66jpsu2B8VzqPfywlZEVcEwN0I20QcT3TJ8MgrSPRWEUsxU6JzlHI5Xc2PPMNKzyCjJLnY2b6hx
	pPgzW6ZmKgrazYHI1v7jZ0eir1RqSdGDbFOC4Ffgowv0/cYPWVaIHuYSppMruG2NQfdF9bHOcd3
	GbsPnEA==
X-Google-Smtp-Source: AGHT+IF28ykvCmrGea/BULemib8daK1hgEdFIdJ/Ik+aL+jlH5A0UxcJcpvI1m83PeEUpmPWVXPeuQ==
X-Received: by 2002:a17:907:a089:b0:aa6:ab00:7b9d with SMTP id a640c23a62f3a-abc09a43223mr851814466b.4.1740566930545;
        Wed, 26 Feb 2025 02:48:50 -0800 (PST)
Received: from [192.168.0.104] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2013348sm300626366b.89.2025.02.26.02.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 02:48:50 -0800 (PST)
Message-ID: <6081917c-9c20-48fc-baaf-7ac9a9679a72@linaro.org>
Date: Wed, 26 Feb 2025 11:48:48 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0d33dea6-c021-4f2a-bb3f-92efd6eebd18@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2025 11:44, Malladi, Meghana wrote:
> 
> 
> On 2/26/2025 1:35 PM, Krzysztof Kozlowski wrote:
>> On 26/02/2025 07: 18, Malladi, Meghana wrote: > Hi all, > > Apologies in 
>> case you are receiving this email for the second time. > Any reason why 
>> this patch hasn't been merged yet. Other than re-basing > this to the 
>> tip, anything
>> ZjQcmQRYFpfptBannerStart
>> This message was sent from outside of Texas Instruments.
>> Do not click links or open attachments unless you recognize the source 
>> of this email and know the content is safe.
>> Report Suspicious
>> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
>> updgnZav1ue7gKXOnHOpH5hg8gLmw9Osqsqh- 
>> KTLRTnBEurV_VetrG7mzU898vB_5xFrYgbRkkuuFMBobM-uhFAmUgccRSk$>
>> ZjQcmQRYFpfptBannerEnd
>>
>> On 26/02/2025 07:18, Malladi, Meghana wrote:
>>> Hi all,
>>>
>>> Apologies in case you are receiving this email for the second time.

BTW, Arnd when responded with Ack described the process.

>>> Any reason why this patch hasn't been merged yet. Other than re-basing 
>>> this to the tip, anything else which needs to be addressed to get this 
>>> merged?
>>
>> I don't think you sent it to your platform maintainers, so no one would
>> apply it. Usually people ignore emails they did not receive, although I
>> am here an exception tracking missing-DT-patchwork things... :)
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hello Arnd/Krzysztof,
> 
> Thank you for the replies :)
> Was having ambiguity since this is not TI specific change. Wanted to 
> confirm before re-posting. Will post v2 patch including TI platform 
> maintainers.

It is not TI specific? Then which upstream boards benefit from this if
not TI?



Best regards,
Krzysztof

