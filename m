Return-Path: <linux-kernel+bounces-448832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2289F4630
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5169D1884B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59721DD872;
	Tue, 17 Dec 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnSWrHaQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447D1DB52D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424715; cv=none; b=aQqQhdIX8CKu332oqA1Br+qGM3SDlDjj1tB/OGXzi1gM2r2UVJ8G+5Fn11GxSis15TBNy3OZgbJCIYR57yVsofwxh9CL57K+GG0HVefNWM2f1tOihFnksntaC3l0ESU2rOnSu3sw4bSXmus2gSWzNTO4lMhGMM66Ei7315wbvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424715; c=relaxed/simple;
	bh=QsxB+FcvHkxYn5Z6wPrrZeML8ztRrKsQibnLZJ59yf8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GCGV7SWxTJXnHt+HLbQamYk3uZQq54qYw5trH3dhvT9JFV7lvHxqlcYn7jOPNiC77ap7vPQqp14quRJf6litL3jGkTpq6rHczyuzOz5D6gGbEFj0MvsaHzndmrSrju0GbgExCasV2KoolIV8JGtMz34ZO5xE/U+EW/3FAAzkAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jnSWrHaQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so54727865e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734424711; x=1735029511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwKLcx3qWGZ0J4OB9gBZAl+ma98QJfj1A73XswW/D2s=;
        b=jnSWrHaQL+3QaWFglq3oInfvSme4/Ez8Qe9BWQ8Stmqxyr1s2dH5bjIr1rnWoNY3Wh
         ehYgxrLhFvhgJCGq9t/lg9s/MgbyRdOfW+4J6NghpFj2G3slbpaOCbbf20N6ODBqsB6d
         Fh1sYneNougEAX7EQMXY+1IoLP1hZjv3TzN6t2An9iy8C90eHBGEeHd0EAR0sQ3s0sLy
         102mR99+a4fFERFBneb2pkbF77T36Zl+wky00ON2rQ9zxfATIukXyZsTX+xUh16ESZoZ
         Ipt/eFuAm2e0xNbxnyCg2n6JLGaSuiQwqsBwHveujCneEgiT0A8S4p6z1NVkHihaExmb
         ZdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734424711; x=1735029511;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwKLcx3qWGZ0J4OB9gBZAl+ma98QJfj1A73XswW/D2s=;
        b=NX8BYNaU3bq64Oq0QiNNFQwb9lCHv1DKjMNn+hPyiHSGE2ymInqCEFVtm8n7YvWyjA
         H08pA7yfun/dunMeZEdovaOvzUYKlzK348npj/wRDLYXijxYLCEQmu86i1KB3WLW9M6F
         m3HH8+boRVhGJs0ch+G/nAEBuNXEU2eLwa+uL8S7+4hUswYLt+rEB1cgtLFysLljPqaj
         +cEvmBIl1S+l1YFsp+ajU5GDs1STcvVPaX3Nk6UUVA1cFMoeqOwZC6q0AchLBbJMF6wk
         wK2dd0fi/5+FC/jeP2JHiroNwqS/Umhepysrw7vYsVpVbFZTC7sTCjFhydhYRhXI1lnI
         IW8g==
X-Forwarded-Encrypted: i=1; AJvYcCWdUp54x2KgwK5Fqf+0QC/uXYuFcwRl4VfkM+wpycL+G+Si34hXET55x/7AMHU4aCZeXCQ6IQ1SuBJGLco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpHUjsJVoFQJ4QLb84+xpx8x5zOZpUX9NMNMAcxuiaJtRJndGQ
	KYTWo11HqAFVgA4Y9nuhk9eibUDub3acoMmUYtLpjB77l9LJO2Js+jRsQrhwyWw=
X-Gm-Gg: ASbGncuQdtCY7nT7CJs/zyPOLrDW7Gb6IYaDlGohvUG19UA02jYmTUp3DwElSlSZ/1O
	leTGG9BxkONlz5Ap48vguN7pWAn+KtEaU1GubLOEmeG6+g9hNC/QB8JuwhWm/1bUyEpiOj2uxhn
	AG1YMrX+/qK72GcxfDk+HvOgR7RmQgfaI22wudyowYkCu0oZwl/Kw5kOt4+qXTw7tEY6pemsSfk
	51dGdnIXZfBhvKsIRKUVELoIsYVdQ5IcsUlCLniM8Ss4U7vLpK3Ff8zI7ue/E2a
X-Google-Smtp-Source: AGHT+IG1ScKF9S6YLpA0VEyZm9yVfmIx7vyc5/iav7Ktgk6AaGAJ4fl38EJ0MOFcy/fDQp5fgbPrhQ==
X-Received: by 2002:a5d:6c63:0:b0:385:ee59:4510 with SMTP id ffacd0b85a97d-38880ac1cc1mr14557623f8f.9.1734424711437;
        Tue, 17 Dec 2024 00:38:31 -0800 (PST)
Received: from [192.168.0.14] ([188.26.61.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060592sm10298741f8f.98.2024.12.17.00.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 00:38:30 -0800 (PST)
Message-ID: <4e8936e0-ac69-49e8-919f-b2776dd88779@linaro.org>
Date: Tue, 17 Dec 2024 08:38:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: exynos: gs101: add ACPM protocol node
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: William McVicker <willmcvicker@google.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, kernel-team@android.com,
 daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
 ulf.hansson@linaro.org, arnd@arndb.de
References: <20241212-b4-acpm-v4-upstream-dts-v2-0-91b7a6f6d0b0@linaro.org>
 <20241212-b4-acpm-v4-upstream-dts-v2-3-91b7a6f6d0b0@linaro.org>
 <Z2B3V78k2ibIdLYh@google.com>
 <45a54924-226e-4a94-b1ae-b0f1f703f854@linaro.org>
Content-Language: en-US
In-Reply-To: <45a54924-226e-4a94-b1ae-b0f1f703f854@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/17/24 7:20 AM, Tudor Ambarus wrote:
> 
> 
> On 12/16/24 6:54 PM, William McVicker wrote:
>> Hi Tudor,
> 
> Hi, William!
> 
>>
>> On 12/12/2024, Tudor Ambarus wrote:
>>> Add the ACPM protocol node. ACPM protocol provides interface for all
>>> the client drivers making use of the features offered by the
>>> Active Power Management (APM) module.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>> index 04561e15b96c..8c3f07371912 100644
>>> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>> @@ -277,6 +277,28 @@ apm_sram: sram@2039000 {
>>>  		ranges = <0x0 0x0 0x2039000 0x40000>;
>>>  	};
>>>  
>>> +	firmware {
>>> +		acpm_ipc: power-management {
>>> +			compatible = "google,gs101-acpm-ipc";
>>> +			mboxes = <&ap2apm_mailbox 0 0
>>> +				  &ap2apm_mailbox 0 1
>>> +				  &ap2apm_mailbox 0 2
>>> +				  &ap2apm_mailbox 0 3
>>> +				  &ap2apm_mailbox 0 4
>>> +				  &ap2apm_mailbox 0 5
>>> +				  &ap2apm_mailbox 0 6
>>> +				  &ap2apm_mailbox 0 7
>>> +				  &ap2apm_mailbox 0 8
>>> +				  &ap2apm_mailbox 0 9
>>> +				  &ap2apm_mailbox 0 10
>>> +				  &ap2apm_mailbox 0 11
>>> +				  &ap2apm_mailbox 0 12
>>> +				  &ap2apm_mailbox 0 13
>>> +				  &ap2apm_mailbox 0 14>;
>>> +			shmem = <&apm_sram>;
>>> +		};
>>> +	};
>>
>> You mentioned in the previous patch that "GS101 has 14 mailbox controllers",
> 
> Right, I got the number from the GS101 memory map.
> 
>> but here you have 15 mailboxes. I looked at the downstream driver and see the
> 
> Here we have a single mailbox controller, ap2apm_mailbox, with 15 channels.
> 
>> number of mailboxes is defined by the ACPM framework (firmware) which is read
> 
> s/mailboxes/mailbox channels that ACPM uses/
> 
>> from SRAM initdata. Dumping that, I see there are 15 ACPM channels. Have you
> 
> Correct.
> 
>> looked into into extracting the data from the initdata SRAM address?
>>
> 
> Yes, that's the reason why I defined the 15 channels from above for the
> ap2apm_mailbox controller.
> 

Haven't explicitly mentioned in the commit message: the ACPM protocol is
a mailbox client for the ap2apm_mailbox controller. The ACPM protocol
uses 15 mailbox channels of a total of 16 channels that ap2apm_mailbox
controller provides.

Let me know if you think I shall update the commit message.
Thanks,
ta

