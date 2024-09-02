Return-Path: <linux-kernel+bounces-311710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F37968C97
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2DE283C69
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680D51AB6ED;
	Mon,  2 Sep 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiG/j3gm"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7C1A263D;
	Mon,  2 Sep 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296497; cv=none; b=uXihmO3imvZxWjVpwBPRWUyxeeDLg1LUbm8Rb8kR9kxMSRt98m7RS/guz6dlDzak1DwIxt2W4hFow2RR+fSilvSvqD+F+Jo5sBBH8zfYU0Yf6bPxMgGRJ4rOaJoFvDXrpNJHYHTinyehpRpnH8Ku1iOpvta2KnEIlWJrSHvP/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296497; c=relaxed/simple;
	bh=JSQ3YXFCrD47UlSUCLspR5KS7M792sav3MlqtzSimjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b60In6R1/gT+tufl67Oj+Qh45EXep79hEO/3CHQhqPJFTZ/iWeOhc0h2t3jaKrknROA3WtEdA4RwA57NDIsglI5hbQiFZRvfHMWSfg4Xgm1JWSoWJo/JDCt5/N7lnI/b+E7Q8/1ZeBeMY3YaJnjpsbD78X5E/I2IYYajqZTbpsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiG/j3gm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso1495117a91.2;
        Mon, 02 Sep 2024 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725296495; x=1725901295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Zyn2iiPSxrhbrGHeCDATXgQU8zH9RJ6AF+TzWc/gSJw=;
        b=XiG/j3gm580fopG7RRTvBHlTbXwKtGPNDMqbIfA495/7Y5E4cKzYmaRBM+PML3ZCzV
         TQihtndVEs5WOwnt2fH2B7IWUSbaV1AwvoFDK5z0hnvbFaGRPppAFmNFraJElikkx0cN
         E27yJ8G211XOBR3lgNBnfPGkC+L7aXb6Zlu5kUQrajK3s0wK4RUZGvBxc0BB/U7c8Kkr
         NRnuq1AacZQBHZ/99MDloeVdlwGQ7Ez416G+NIol5Di49O85KConaAGd3x6OMj13Zoe4
         Yoyw85QoxxnmhL7/PomEFhqnn+KKDuyWG8UjI7TKUy9DaEbh2+L2JKlorqNmPKqhsVDH
         ObCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296495; x=1725901295;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyn2iiPSxrhbrGHeCDATXgQU8zH9RJ6AF+TzWc/gSJw=;
        b=hU8lT8jvlG0lzWqTflAFl0UGzJRZ4WOvYnXmKuJOEIgJM1OpQdOwgQnSvev/v0npJc
         XyuEkKdEfxxEwjoB/qyBV9oZwVCuO0arcyk+CXsJh+ljQyCF+02XJqlPMfdBSxOk/U0t
         th81XmeoVAonmtZtHtIG1+YAIUxCm6CyVfozSPKxxy/H4/8ORANSWOOcJWB5j/BL9KUH
         jCMS5T8HuiGa3jNAOw+zut9hApEVf8u1fbYkAKkveFlyFUXFAfhmEH0c2xAwhN8vxlIT
         1CfgLDMbcFMsLJS4maKmyApuKnzXAP2ORQRo71NcWCcTqtB60OwDTSHBq2Z30K2qL7F+
         Bz6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsYBaNVjtEOgoFwLjll5bAVNCojMmkavZLsjiryQ+nTPQqdYgCLVYY74ru/PFAEwN5utpcKRrkLyHf@vger.kernel.org, AJvYcCWgNyfhgkN2S8SlczZxXXWj/EZ2yTC/IJj+nX2d8TYXsb/11wK5nT1RMkMhtyoGU2FmKhdoGSrkOofmBHE=@vger.kernel.org, AJvYcCXpax187D7tJqAEUlJDV5PW/LWunN64GZojA3EoGRM9x5uyE8kpI5wJRnguB89V+SCAzHySWaRC2QrB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/6GpdfEO4UQVMv8o6bHkN25dyH8NDMppH+rxcaRNn4KchM8O
	9yGoZ6GWrODhxkc5KUknP+gtWHnJpUlHL2ViQsqAG3zMkOsRnNGH
X-Google-Smtp-Source: AGHT+IEU9goOKVcu7h3CLKqwdv9zjKFFG7e253KgvQfn3PeX9xaRu3gzgXGkCpOPPKXlastHe+IwuA==
X-Received: by 2002:a17:90b:17cd:b0:2d8:d081:e8ee with SMTP id 98e67ed59e1d1-2da5597b1ddmr536355a91.20.1725296495024;
        Mon, 02 Sep 2024 10:01:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b39ced8sm9400290a91.46.2024.09.02.10.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 10:01:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <513a6fd6-9985-4b4b-a501-47d331d71224@roeck-us.net>
Date: Mon, 2 Sep 2024 10:01:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "Sperling, Tobias" <Tobias.Sperling@Softing.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <ypez4vjmasehqflgi4ylylpicldabf2dc6wwjco34qr2zmkdvx@enejrjjyaulf>
 <BE1P281MB24208DE67DB0B1E9A75823ECEF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <45037518-41b7-4cc1-a7f4-c4a0c9873950@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <45037518-41b7-4cc1-a7f4-c4a0c9873950@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 09:02, Krzysztof Kozlowski wrote:
> On 02/09/2024 15:48, Sperling, Tobias wrote:
>>> On Fri, Aug 30, 2024 at 11:49:53AM +0000, Sperling, Tobias wrote:
>>>> >From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00
>>> 2001
>>>
>>> Some junk ^^^ above. Please investigate how you send patches.
>>
>> Yeah also saw this line, but of course tried to apply the patch again after sending it
>> as mail and that worked fine. But just checked again and seems like this line can be
>> dropped.
>> And yes, I sent the patches manually, as we likely have some restrictions for smtp,
>> but as I was able to apply them again it's fine I guess.
>>
>>>> From: Tobias Sperling <tobias.sperling@softing.com>
>>>> Date: Fri, 23 Aug 2024 12:08:33 +0200
>>>> Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
>>>
>>> And all this suggests malformed patch.
>>
>> Why? If I drop this I'm not able to apply the patch, so I think this should be fine.
> 
> OK, it works with b4, but seeing duplicated subject is not expected and
> might not work with all tools.
> 
>>
>>>>
>>>> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
>>>> analog-to-digital converters. These ADCs have a wide operating range and
>>>> a wide feature set. Communication is based on an I2C interface.
>>>> The driver provides the functionality of manually reading single channels
>>>> or sequentially reading all channels automatically.
>>>>
>>>> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
>>>> ---
>>>>   .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++
>>>>   Documentation/hwmon/ads71x8.rst               | 140 ++++++++++++++++++
>>>>   Documentation/hwmon/index.rst                 |   1 +
>>>
>>> Please run scripts/checkpatch.pl and fix reported warnings. Then please
>>> run  and (probably) fix more warnings.
>>> Some warnings can be ignored, especially from --strict run, but the code
>>> here looks like it needs a fix. Feel free to get in touch if the warning
>>> is not clear.
>>
>> Had done this already before submitting the patches (at least without --strict),
>> but only reports a warning about splitting the patch (which I got wrong here)
>> and updating the maintainers.
>> I guess you were about suggesting a second script to run. Which one is that?
> 
> Please split the patches.
> 

I suspect you may have to be more specific. There need to be two patches
in Documentation/, one with the bindings and another one with the driver
documentation.

Thanks,
Guenter


