Return-Path: <linux-kernel+bounces-414990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F79D302F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277AF1F233D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42D21D2F5F;
	Tue, 19 Nov 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5u3H59d"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFE1482F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732053463; cv=none; b=WLf4uAbtES4kK6LfIXHLWQG1Xg3CFJUfBx08SbrkhdozqiClW/X+AbXPWuTGdCQSR+8mnTMc0ZY54h2prCphTDioZZUvmCm+tJsh0RDSRUD2iYqQqaG25FL3sA2BvLa3FENPJFO3tx8feb7MLPlJy+wwOgQ0DllesZx2aUt1+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732053463; c=relaxed/simple;
	bh=rezHVCrzEMBfyz/hCPFv04FRT1g49m7qy9LMZhcGy2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlWtU/TdGY7wuuIQCJF+jlDvuaQNbVZvoggY1k7n56eeI7Pg21QJ3nIu7l4SODxRe+3E0ZBdEjJwMXzugUkUg0/mv45x6IjW0rcp9bdjk9PD4A7V9SSIMYGfBr4N8TnjOQ4u09bwwecCUmrz9CSMTJ7u33gGhRRoEDcXkEr1MCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5u3H59d; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea752c0555so1990494a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732053461; x=1732658261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U4/kKkoWW419TQ9iQGRgliF5sesWQbwnUChSBHe7YQA=;
        b=T5u3H59dISTnlvIm67DJ750JEhazIsdAhFGU7OWqRNxbZeqEygYiBAa+38nLxVMkUL
         jzIQKThH1aWAJNN/IfJlJnjg1GarZeKNdmN0X+oZ50xlBe1gtoCb5F/Mqd9LEsNh3TDg
         nDN7sf1ZUJ3BnUJNmLc/+g7dAskUd98E0I6WmHYrcXxlBfZ4lfI3C2TDTboLD0FmzHVa
         jtH8reCPO1tD1Ff7hol5f6alDoPeBBfW6JWUeKnhQ3OkU/eoM9SyJjQicHQx500EpjO5
         wpAEHYmwDPuJEQK+paTKSK4yrYExCsNyInM6pRpAWTEdbmPBTWWvngRmvOQtwvNv75RP
         ovlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732053461; x=1732658261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4/kKkoWW419TQ9iQGRgliF5sesWQbwnUChSBHe7YQA=;
        b=QLhcD5t2O5lz3wJzQwrRvqwqT34YP2/GtjF4TdDCYovVnpQHg8gzpW4wovrqVLnJy0
         p6LY0oUL1D6QO/GOuil0LYKqE/VaymT/iL7RTiuhpfKofpXLONI9ixBtU5C9RggtQsOc
         +9gTvUNlvKKedFTX/Sh3ml3nBaunf/b5OPHK9Z10tEG8P3ut6r46iM6Q3d/3DHFsNDvV
         mOp6WgTQPie+XGAo6VQ0VJoWj0C9Piqoi2UE9iRNpnOoAjM3W4nsH1ZErX+tZQhPA6py
         PBKLEsWRRR462rhjl+C9QK899ErlBH8/yQOIG7asglBaQ8eXRHDUY7r26AUlKaN+dxjm
         Redg==
X-Forwarded-Encrypted: i=1; AJvYcCVFMgwEwjHbmYM+FmL2pS+27OFTDNtsBf8aBOrkECMQXuXi4pgs17P+2Y+roRRF3Pn5iPFvF6Tpg+cOE3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcb5B6yrNR6GcrJfW0PMi/mlWeK6cIFHEDmoMZimvCvyhFKEBg
	3tlI9qKy1+GLAyyD1cQviKc8c2CItxuT2epMz58hQY4iORLKtTMV
X-Google-Smtp-Source: AGHT+IE7frJiiWlM7zborbmenKyNNB8oO9p8+b+t1BVuGU5Wsqo93L+MsC7ckN80alcGGdY0InT8jA==
X-Received: by 2002:a17:90b:3147:b0:2ea:356f:51b4 with SMTP id 98e67ed59e1d1-2eaca703693mr378918a91.13.1732053460773;
        Tue, 19 Nov 2024 13:57:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea41550839sm6392202a91.17.2024.11.19.13.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 13:57:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0779827f-c51c-4407-8544-c87ca6d76500@roeck-us.net>
Date: Tue, 19 Nov 2024 13:57:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regmap I3C support
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
 <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
 <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
 <f904ed54-da90-4746-8230-0ae5dd0ca276@roeck-us.net>
 <49526254-546e-41e8-afb1-14aadeaa391b@sirena.org.uk>
 <dd02b307-f8e9-4b5d-9a4d-d429c0dff051@roeck-us.net>
 <ZzznQknCF7VVHyDK@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZzznQknCF7VVHyDK@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/24 11:30, Frank Li wrote:
> On Tue, Nov 19, 2024 at 10:41:05AM -0800, Guenter Roeck wrote:
>> On 11/19/24 09:46, Mark Brown wrote:
>>> On Fri, Nov 15, 2024 at 08:35:04PM -0800, Guenter Roeck wrote:
>>>> On 11/14/24 09:26, Mark Brown wrote:
>>>
>>>>> Right, so the fact that I3C depends on I2C deals with a lot of the
>>>>> problems that plague the I2C/SPI combination.  Ugh.  I guess the helper
>>>>> should be OK and there's not much doing for I2C/SPI.
>>>
>>>> It looks like we can use
>>>
>>>>          if (IS_ENABLED(CONFIG_REGMAP_I3C)) {
>>>>                  regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
>>>>                  if (IS_ERR(regmap))
>>>>                          return dev_err_probe(dev, PTR_ERR(regmap),
>>>>                                               "Failed to register i3c regmap\n");
>>>> 		...
>>>> 	}
>>>
>>>> even if a stub function is not available as long as there is an external
>>>> declaration.
>>>
>>>> I don't really like it, but it turns out that this kind of code is already used
>>>> elsewhere in the kernel. It looks like dead code elimination can now assumed
>>>> to be available when building kernel code. We live and learn.
>>>
>>> Ah, that solves that problem then I guess?
>>
>>
>> Yes. It actually goes a step further - the IS_ENABLED(CONFIG_REGMAP_I3C)) in the
>> probe function isn't needed either because the entire i3c probe function is
>> optimized away if CONFIG_I3C=n.
>>
>> I'll send a patch dropping the #ifdef in the tmp108 driver after the commit
>> window closes.
> 
> Already tried this at v3
> https://lore.kernel.org/imx/7bdd2db8-41c8-43d8-ae73-84a221d2d004@roeck-us.net/
> 

Yes, I know. Sorry for that. We live and learn. I didn't think this works,
but it does.

> but I am not sure if it is good on rely on the compiler. Maybe some option
> like some debug option or -O0 cause problem.
> 

Yes, I thought so too, but it turns out that the kernel doesn't build anymore
with -O0 anyway, and other code already _does_ depend on dead code elimination.

Guenter


