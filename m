Return-Path: <linux-kernel+bounces-305765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF1F9633F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2371F2309A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D21AC45C;
	Wed, 28 Aug 2024 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUUo7r1K"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5815A85A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880882; cv=none; b=swQy5VFi70CeuiqOCeMG9uDHRwt2i8Vae3jjnCl/+Smhd8HZlzSCuhjWsAyiWQkTceZAbJDTCKWU9skNr9Trujn4fInmSUpdyzCNavuforAspvjgJEm6TMxsWDLPech3BgbG/62xW5W9dtYlREofVQB40eQD6wV8Ozs5RlkK60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880882; c=relaxed/simple;
	bh=fcerxRoXwxW0shvchrteonn+/iKMsN7xAwIsxhNPucc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TiNDOSGQAGjvrP3MuMzp4VT7idq0cXe+KSOdMVt1FLEd4wyqqCCPrPWwBriQwsWBOIdrSVBGrDYIqiKX7xikCs7wOILK81HmJeGvTxjDL4lfFaJudywTlR3yQz6UHlR02FaNhB3mciFwoFlzLNbx0KSKYh7L31EJv/bC9Pq15NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUUo7r1K; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6bce380eb96so4026072a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724880880; x=1725485680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WoCoJVTVwu650QBIibLpLCVpAhZfTglhrS1nWqnmQi0=;
        b=mUUo7r1KTLxFaI5F2RPB2AOtw1bxrlsQMLIWmwpb07r1eHSxMVRJAplm8WBv6WuxEk
         l5VM0Yzyw17FYwW6CZrI3mSsSIqddhG8FzrCybg3MmodVdm1gVmHF8WqkD6oF8FAEy1u
         Ii9LD6yLav1QyQ7AKjuzCgnxBwFhcrREnOtLnhb4HLTCDrLJP8/UoobHSEII5QZZcBKt
         j10+EDcrsev6sECwuBZraobw3pDcMcFR1wwYgepKWS7FI7ddnfBqkVxgPx6CVUqb/84w
         TANMpap/F3DTUmlUV4TR8tGsLbnns5gU2z+mzEnjHstujZWGIFNTgHqQSYrLv0taEbP/
         ZBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880880; x=1725485680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoCoJVTVwu650QBIibLpLCVpAhZfTglhrS1nWqnmQi0=;
        b=bOMMN+wsgBpbDD0oaURMCow1BXss9XpA0y4ta3tP1AxLmM5llzrGCorgrvdR5LzVLf
         GAlP3o9TmDakRs/HXK6/KQ8ldfzmIqR8MJGlyIYWluSydeirK3DZhLJowsRvxX61ncWJ
         yPkNuaDQaFS3qeJ7M0UWAd9hZB0vUn15nwFy3INMkSm4Huls0q7Cj4ogQqGWQI2sfglK
         6caNi07VypVXJTqpliSM+Rl/ImuYC8VaEyGfHkof86GemZ9CWoPEsbdluO3kFr0u3jIr
         6+7GueGSWMzccZqZmRk/JjXXyp2hVl1wGGBFksJbFD1tv6P8+zase+z/Pg1yozVPokRu
         TA4w==
X-Forwarded-Encrypted: i=1; AJvYcCWM4hl5XFTICdzr7ZOuzuqqq+9ZbKcgls0rizkfOKVjXf1IEh8mPUxqW9i4JRStxG/BHA4971O7ADgLZrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1jBeqvx1f+vdeGA2AsExvjXDnoSTsz/ONzgJA8IrxGr9KYQr
	7pf7j0c+rDnQmIHdQKQ1UYbYlcBZT592AhkFm49rJKhkgvV9e7F07OwMtBHy+HQ=
X-Google-Smtp-Source: AGHT+IFp0jxYN1jb/qPGb4pEaRO+zB8kKpCSNIKKQyEmk5tTtyhQmK8O+RWoOsLngC08rXL2dW7/1w==
X-Received: by 2002:a17:90b:364b:b0:2ca:7636:2217 with SMTP id 98e67ed59e1d1-2d85617e3e4mr621991a91.2.1724880879732;
        Wed, 28 Aug 2024 14:34:39 -0700 (PDT)
Received: from [192.168.79.27] ([49.207.54.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445f8dabsm2457513a91.13.2024.08.28.14.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 14:34:39 -0700 (PDT)
Message-ID: <7423460a-ff73-44c1-864e-2dafe31b1c7c@gmail.com>
Date: Thu, 29 Aug 2024 03:04:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] staging: rtl8712: Fix style issues in rtl871x_io.c
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240828204552.26790-2-masingh.linux@gmail.com>
 <607b86cd-d89a-4072-af36-ce2ce5c1f7fe@gmail.com>
Content-Language: en-US
From: Manisha Singh <masingh.linux@gmail.com>
In-Reply-To: <607b86cd-d89a-4072-af36-ce2ce5c1f7fe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/29/24 02:38, Philipp Hortmann wrote:
> On 8/28/24 22:45, Manisha Singh wrote:
>> Remove multiple assignments from a line
>>
>> CHECK: multiple assignments should be avoided
>> +    pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct 
>> intf_priv),
>>
>
> Hi Manisha,
> please remove the 4 upper lines of the description. They are not 
> required.
Sure.
>> Refactor the _init_intf_hdl() function to avoid multiple
>> assignments in a single statement. This change improves code readability
>> and adheres to kernel coding style guidelines.
>>
>> Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
>> ---
>> Changes Since V1:
>>     Broke the patch into 2 different fixes
>>
>>   drivers/staging/rtl8712/rtl871x_io.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8712/rtl871x_io.c 
>> b/drivers/staging/rtl8712/rtl871x_io.c
>> index 6789a4c98564..6311ac15c581 100644
>> --- a/drivers/staging/rtl8712/rtl871x_io.c
>> +++ b/drivers/staging/rtl8712/rtl871x_io.c
>> @@ -48,10 +48,10 @@ static uint _init_intf_hdl(struct _adapter 
>> *padapter,
>>       set_intf_funs = &(r8712_usb_set_intf_funs);
>>       set_intf_ops = &r8712_usb_set_intf_ops;
>>       init_intf_priv = &r8712_usb_init_intf_priv;
>> -    pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct 
>> intf_priv),
>> -                            GFP_ATOMIC);
>> +    pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
>>       if (!pintf_priv)
>>           goto _init_intf_hdl_fail;
>
> By pushing the below statement after the "if (!pintf_priv)" you change 
> the logic. Is this really wanted? Why do you think it is better? I 
> would avoid this and it would be a separate patch anyhow.
>
>> +    pintf_hdl->pintfpriv = pintf_priv;
>
> Thanks for your support.
>
> Bye Philipp

Yeah, I shouldn't have changed the logic. I don't have hardware to test 
it, Let's move the assignment before the condition.

Thanks,
Manisha


>
>>       pintf_hdl->adapter = (u8 *)padapter;
>>       set_intf_option(&pintf_hdl->intf_option);
>>       set_intf_funs(pintf_hdl);
>

