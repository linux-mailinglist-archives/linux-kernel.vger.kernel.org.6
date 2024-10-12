Return-Path: <linux-kernel+bounces-362243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B300A99B297
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A031C21C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61CB14BF8D;
	Sat, 12 Oct 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgwsmDhJ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4E14A084
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728725797; cv=none; b=R7xLWj8Bb0HfaUU3zKODnlGUr5C3T/fMAJ/1sv4ddgTGx97kS698XRWhqKYeKm050QBLgHqkrObVYBpZL+A+snR/7qWHkWyJH1OlJ1WBIqOZ7vAts3t2boAKr5QijPCZylXHcfzwtmfizT5Xx7Z0yt5wcRuhyNO0zK5lO2vlHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728725797; c=relaxed/simple;
	bh=janv9MHGJVI3uz5Xn+FgbA4lrGoAWtp/YnP9pXSPnIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7x5ywYBAid2LZtqwgGR+x0AzLFlWi0nZxF7uoF5OLpi8EAWZjjtewU8zCUd+hcBM/v56p/5oiy3HLv3oKWv/5EA2+CSn/wtv+2/4Mq2OHxFq4KmRZR2fSACM5tnbpcOQhe4mzWlJKnSHhHbQdfZZQ+Ju8q8n8sK2ANVm0MCnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgwsmDhJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so588973b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728725795; x=1729330595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5cwB/aWBfa6USfIH9/8FnrEtKdu0wai7R1BOG1zdxvA=;
        b=TgwsmDhJRdqxN7mq3BkbavZEsnJ2Y6Nz7O9kzkF77K7RFua2gEO+dLwf55gUSHhyUN
         VYOwuZ0O21228CmQoIYXtDnMEAoZ8zCRLC0MH/Qo5zk2UmohX1+lBPPu1dcHe8c54HXU
         BqylumDaT+27C1u6DrAlroyswJ+t7WBOn8YkbUu85I2yfaEDLNFFqSYtUseoGfJUfWVa
         8dy7WTM54AXlwld2j03f0u0+kS0tQnyErWlFXltU5B+kEjiVQ+gAsfplQr6mTcNXHhtI
         9ZHNoChl1ETtaW2dom7IUoHDk+icRyp+4jppoGSRpdAdmq9o6VExO9h8RzfBl4OmxZlR
         H+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728725795; x=1729330595;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cwB/aWBfa6USfIH9/8FnrEtKdu0wai7R1BOG1zdxvA=;
        b=swqAmTxfoShwSvIMDko1W1RmM8ecl4Bd5fC1gcubS+9FJXDhZvPgJWkEN4x1E6FfcU
         rcIg5CBQ7RTk78/j9LpRI8ip5corvpRNmvTxrzHHliaDmBl8iSuuozfBD2rY3ZYGBwjZ
         LwMxzDSRQe7XxCpFn5dnVVJIk5H2revdsJFkkTqyv9Gm6nbaAp3xbYslNf2hY8jazmYP
         WQSWXEgelsJhG8lAGTTz9dLCz09CEjqf+E2ZR7czLdQpDkbXzCutLP5b6pfNh8PD1Xpz
         SWtGxqk2cYhAIvBYSGNvTHzecMXBAJejbszaUiCITXLpDHsFcFnTv4yksn5L6CGT9C6a
         H6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVNrUu/AqRboj/RONGRHO/XLETcCCNHtYlNfAqW6HfnGV4MoD4Hhn9fbwn0dJ8ZdWjhOFjzXRiQx5/NAY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqrMy0ShtIqdNI8kBGcorCaGpKZ/QS9SvdvsJWoqYd8Vck+M+
	WgT0d8EG1JhyMnvlrhOp7bBdXV155DTaYXAMuJDybc3e0oeXi+xx+c3FQA==
X-Google-Smtp-Source: AGHT+IF8K+mVfLNP79KmnaZGnnKjJ3NfSEBigSRj1KzCGVo4vECWTqb683p+nIb6ILpEruDm0AeHaQ==
X-Received: by 2002:a05:6a00:ac7:b0:71e:4fe4:282e with SMTP id d2e1a72fcca58-71e4fe430e2mr1903674b3a.28.1728725794356;
        Sat, 12 Oct 2024 02:36:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e988asm3841180b3a.33.2024.10.12.02.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 02:36:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1f7eb380-08bb-4af9-b5cb-652538fdb215@roeck-us.net>
Date: Sat, 12 Oct 2024 02:36:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240922225041.603186-1-linux@roeck-us.net>
 <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
 <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
 <87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0247886e-595e-4774-b515-ff628966f2be@roeck-us.net>
 <878quwbgv0.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <21eae385-ba7e-417c-b2c5-2071c3c7d8f5@roeck-us.net>
 <87ikty7zpp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87ikty7zpp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 20:43, Huang, Ying wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
>> On 10/9/24 23:40, Huang, Ying wrote:
>>> Hi, Guenter,
>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>
>>>> On 9/23/24 18:21, Huang, Ying wrote:
>>>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>>>
>>>>>> On 9/23/24 05:58, Geert Uytterhoeven wrote:
>>>>>>> Hi Günter,
>>>>>>> On Mon, Sep 23, 2024 at 12:50 AM Guenter Roeck <linux@roeck-us.net>
>>>>>>> wrote:
>>>>>>>> Building allmodconfig images on systems with SPARSEMEM=n results in
>>>>>>>> the following message.
>>>>>>>>
>>>>>>>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>>>>>>>>       Depends on [n]: SPARSEMEM [=n]
>>>>>>>>       Selected by [m]:
>>>>>>>>       - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]
>>>>>>>>
>>>>>>>> and the build ultimately fails.
>>>>>>> Really? What's the build error?
>>>>>>
>>>>>> I saw it on hexagon, and I didn't bother writing down the actual build error
>>>>>> message. But it turns out you are correct, the m68k machine does build with
>>>>>> CONFIG_RESOURCE_KUNIT_TEST=y even though SPARSEMEM and with it GET_FREE_REGION
>>>>>> are not set. Never mind, I don't really want or have time to argue. I'll just
>>>>>> disable CONFIG_RESOURCE_KUNIT_TEST when building hexagon images and wherever
>>>>>> else I see the problem.
>>>>>>
>>>>>>> It does build for me on m68k, after fixing:
>>>>>>>         --- a/include/linux/mm.h
>>>>>>>         +++ b/include/linux/mm.h
>>>>>>>         @@ -101,7 +101,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
>>>>>>>          # ifdef MAX_PHYSMEM_BITS
>>>>>>>          # define PHYSMEM_END   ((1ULL << MAX_PHYSMEM_BITS) - 1)
>>>>>>>          # else
>>>>>>>         -# define PHYSMEM_END   (-1ULL)
>>>>>>>        +# define PHYSMEM_END   ((phys_addr_t)-1)
>>>>>>>          # endif
>>>>>>>          #endif
>>>>> After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to
>>>>> depend
>>>>> on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
>>>>> you check whether the following patch work for you on top of latest
>>>>> upstream kernel (with Linus' fix).
>>>>>
>>>>
>>>> It works for m68k. I'll run a complete test on all architectures/platforms
>>>> tonight.
>>> Does it work in the complete test?
>>>
>>
>> Sorry, I dropped that one. Yes, it does.
>>
> 
> Thanks a lot!  Can I add your Tested-by in the formal version?
> 

Sure, go ahead.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter



