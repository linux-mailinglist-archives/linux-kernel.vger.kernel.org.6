Return-Path: <linux-kernel+bounces-368766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA79A14B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6429AB214FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE301D278B;
	Wed, 16 Oct 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ds4PaO53"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2C13B298
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729113534; cv=none; b=uTHGWvtq0E0OBDrm/JGej7yE8ds0CZqV1rf5ybiCegqJVmdDO8JEZHlDdLIfXOjRPaXTn6plqywkyXpzeGtd/tFnoE9pJfXngswQRRXEKc0jnlq++LaMwSdtkiitk5/F9Cvu+fYqMGVxlFJeviinSuuwI6m50TxPPkJ8J7JeIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729113534; c=relaxed/simple;
	bh=ND75IMi8HXF7zE29eqO2uOotYxf0XtXYHkR75NRS9d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhwMlps4OoXZMe7rOuCdju4JaYf7UEZOPOBhH7htvCeLd1/nCcxFTo27GejO3SZbDDLblRHpPBtrOGBOJNtBtYln7iUXmm+xRI3N8jojZEV+zKgMOD+5SNqzLire/ZdRY4/N8PdBqPnJ7D3o8Srt6hKNoG6PlYhAJreJsr7li2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ds4PaO53; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-37636c3872bso1302405ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729113531; x=1729718331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LQRC3L4VImH7cjZINRKtu/5qiGqUUYdnzfIGcfIZ6Y=;
        b=ds4PaO53MdxQIxstXbBVfOodvIlDyoAe9K3OeR3Hnkw6c/Ds1NbPwTUM7yTZBBidAR
         h4hBz4wNMv2RWHy6fKISBXw8jOuM/TJV0U8zavaoYpfCSJe21JmST3Wolof6DeC4fMNN
         OJ9/WAmfuspf8qR6yFpH4gY2q8Lg9O7ffuA10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729113531; x=1729718331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LQRC3L4VImH7cjZINRKtu/5qiGqUUYdnzfIGcfIZ6Y=;
        b=Rr9Lidnd5sXQQZoWmOujp+6Xsmvbf5XZL5/eCCvoRV0kBm8QNBeWjjDqav4IfB3ZGb
         JnXGtXekrxcIufUkhdvNjv2sSwrx6+0V6epcwLEPdp5mXBg1MB2E39kCEpRbquBKL+4v
         H40wmTqwLD5nELSeStwakP8UcH6WWjhsrcah24/HmKPquEH/5WjlT9vk4XgHKjoVheEF
         gSuWGstL4N2135h8VtQn60PLOa1Vejt4RqB/i3NGcw4JbaDHXT07EDM5ugXOybAYZdZh
         RChbgLdlzwdqytFkYF1AWmDDWUx+ZrpbxbYOUhpHgmRCkHFxFvKPmv+o9n1WKy3ZWTfM
         NUxw==
X-Forwarded-Encrypted: i=1; AJvYcCU109QMTMKayuA4Mj8XwQPnL0PDTw5jFE9LF3f/0WbCIiwWQxkGCySgL4+Kgew2kpxU/JUOBJwh2EcSZzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBi8F5k42CdPDc3Xp87YaPPSpJUWf/JI0HAhGszp+/vhtzkAgL
	t8g21uCaNudD9MmmYkFpp46m3H6NZIE6x2s7IO0aMQtMr5g3YAa2uMWffeiTGrrAfs1dLf+6AU+
	H
X-Google-Smtp-Source: AGHT+IHNNWqgTE+rKPnGzrXotlENnXWOncse8a66x7gtQCM2wmwkeTRorc0inLEtaivP8sjwfu5YZg==
X-Received: by 2002:a05:6e02:1caa:b0:3a0:bc39:2d8c with SMTP id e9e14a558f8ab-3a3bce0fc22mr139127825ab.25.1729113531546;
        Wed, 16 Oct 2024 14:18:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70aec8csm10271275ab.21.2024.10.16.14.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 14:18:50 -0700 (PDT)
Message-ID: <fbd102fc-32ef-432c-9ac0-c5581f632301@linuxfoundation.org>
Date: Wed, 16 Oct 2024 15:18:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/dev-tools: fix a typo
To: Jonathan Corbet <corbet@lwn.net>, Dan Carpenter
 <dan.carpenter@linaro.org>, Marco Elver <elver@google.com>
Cc: Dongliang Mu <mudongliangabcd@gmail.com>,
 Haoyang Liu <tttturtleruss@hust.edu.cn>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 hust-os-kernel-patches@googlegroups.com, kasan-dev@googlegroups.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015140159.8082-1-tttturtleruss@hust.edu.cn>
 <CAD-N9QWdqPaZSh=Xi_CWcKyNmxCS0WOteAtRvwHLZf16fab3eQ@mail.gmail.com>
 <CANpmjNOg=+Y-E0ozJbOoxOzOcayYnZkC0JGtuz4AOQQNmjSUuQ@mail.gmail.com>
 <c19c79ea-a535-48da-8f13-ae0ff135bbbe@stanley.mountain>
 <87msj45ccm.fsf@trenco.lwn.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87msj45ccm.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/24 08:52, Jonathan Corbet wrote:
> Dan Carpenter <dan.carpenter@linaro.org> writes:
> 
>> On Tue, Oct 15, 2024 at 04:32:27PM +0200, 'Marco Elver' via HUST OS Kernel Contribution wrote:
>>> On Tue, 15 Oct 2024 at 16:11, Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>>>>
>>>> On Tue, Oct 15, 2024 at 10:09 PM Haoyang Liu <tttturtleruss@hust.edu.cn> wrote:
>>>>>
>>>>> fix a typo in dev-tools/kmsan.rst
>>>>>
>>>>> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
>>>>> ---
>>>>>   Documentation/dev-tools/kmsan.rst | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
>>>>> index 6a48d96c5c85..0dc668b183f6 100644
>>>>> --- a/Documentation/dev-tools/kmsan.rst
>>>>> +++ b/Documentation/dev-tools/kmsan.rst
>>>>> @@ -133,7 +133,7 @@ KMSAN shadow memory
>>>>>   -------------------
>>>>>
>>>>>   KMSAN associates a metadata byte (also called shadow byte) with every byte of
>>>>> -kernel memory. A bit in the shadow byte is set iff the corresponding bit of the
>>>>> +kernel memory. A bit in the shadow byte is set if the corresponding bit of the
>>>>
>>>> This is not a typo. iff is if and only if
>>>
>>> +1
>>>
>>> https://en.wikipedia.org/wiki/If_and_only_if
>>>
>>
>> Does "iff" really add anything over regular "if"?  I would have thought the
>> "only if" could be assumed in this case.  Or if it's really necessary then we
>> could spell it out.
> 
> Somebody "fixing" occurrences of "iff" are a regular occurrence; it's an
> attractive nuisance for non-native speakers.  For that reason alone, I'm
> coming to the conclusion that we should just spell it out when that is
> the intended meaning.
> 

+1 on this. It would be too attractive for new developers.
It helps us not spend cycles on reviewing and applying the patches.

thanks,
-- Shuah


