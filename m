Return-Path: <linux-kernel+bounces-337224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28586984734
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5CA1C22771
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4526E1A76A7;
	Tue, 24 Sep 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMybZksE"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C32154426
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186659; cv=none; b=tzosYQZ9c1pnAGLMGo0knn5CORHuRpPg/fkHydvUnxtvoCcquvw1Ut4Vua7sGYgyEzHW3hHgBdT2xzZosOZ9Np791zzowxnsWXCMzhbPQJ/xdvyds28spslyTqsRnhtcGGEJcDUtzsDCzTW9n7SaVymifGyh+NEPyegouhAXIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186659; c=relaxed/simple;
	bh=qFCR3UxfpkNGo19hPCP9KZ136KYB9fHiHMEy8QlD7g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLdDqD0AtSxYyrLR6iLJqP7c9kfQttVhXGk9XTYRFJgFRTY0idg3zKdABYoHXVKxn43Jq/f5oHqRoCFHptEKY1/AJtNBedl+IcnR0U4pLu/GIyKtnUWLhBj+6/eq+UcxsjS+Fwa1FMbG8YWZr+ZsHi+iJmKH4nxSgDp8byfjy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMybZksE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71781f42f75so5155722b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727186657; x=1727791457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HQUIrBee375DCFxMj2GyEDRKC5Ol49rT6e3wSpKAzjE=;
        b=iMybZksEcAuRMOAbW2FtoX7EI7BuabxwDp/K2IwoHWFVUumWW4KuxYVJ7NSl1GwT3S
         Rnx/j5OubEjaKxgPQMYFGnI6TnFWt/jMvHu08rPcpgjPf9iCvEkHj/0CyPqy3cwRSKWY
         Af6m6bFm4Mk5jT5gfs0UDegnuMehgRCgSfATo1rF5QSxflO+Mkefko9Uq5f49E99MPpy
         NpenTnSF1BKFlW36R4+wYxSHS/bwo3NSFYg28codJ551c3opFMdIwZzDxyrCZozQt8PL
         T+faYHz0Emcf5pLYcyaJe5hpZe5qSO4zRZlNYjlaEJwroemaCMU+d5Og4PyR2RRWT58k
         Esaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186657; x=1727791457;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQUIrBee375DCFxMj2GyEDRKC5Ol49rT6e3wSpKAzjE=;
        b=XMtdk6yQEeGfKx6lxqQn3YvU+KfvJr+JlbNt0pSEtz4tuPTdX7dr2Mn+intG1EH1I0
         Wa2D2C8L2BFrx0O2ixQgnXzO9RIBRfkb0HyziMFWkkAAYBnSlBcoCKRDwkPYDlUEFKUh
         pzrx3mpNV3v3z6LeVkl9yh2PAhzUg0qW2Lj7DBDYmJmyxc5HV2ilj6Lm4/50Mxqy7sk4
         7jXw4vQA3KWTCJNkb5fIMZM5V6dgPPzSdaA1Wg0ah/4TncdjskjAkuY8f4ROC+O9a0zY
         EeO9BJr5IXM8UXrzT2HAbEv/xqm1f13Ty1TV00+Zes31obYGmtLLkt2lGxQC7/pM3aWq
         1V1w==
X-Forwarded-Encrypted: i=1; AJvYcCWNlb8ZfjuGbOkJ4piQewVV9lHI//oUEpXxw1652La08YE3asjhwVuDePpQTszeKKav8Sa9Cj0Ct5kN9Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysFEiJD/G1+7fxcYdcIKbuUoeGK70rDH5g0qUBKq+JyRcU/TAZ
	dhfoorGYYmwOb5LbU3e4FPigCDVvqw6j5GyquZp7VSPxp/23LNsj
X-Google-Smtp-Source: AGHT+IGLNlpaoT+0CNXmx72HCBqed7ch4wexyZM6bv3QwaNd9deNPTwYdnzOslG8UIMYSoRBjMG41w==
X-Received: by 2002:a05:6a00:2314:b0:70b:176e:b3bc with SMTP id d2e1a72fcca58-7199ce48b01mr22234716b3a.28.1727186657200;
        Tue, 24 Sep 2024 07:04:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c6f26sm1233572b3a.193.2024.09.24.07.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:04:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bf98fa37-461f-47ce-8d4c-bcb69f225a9c@roeck-us.net>
Date: Tue, 24 Sep 2024 07:04:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: Define NR_CPUS
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 David Hildenbrand <david@redhat.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240923235617.1584056-1-linux@roeck-us.net>
 <aa23abe3-7236-4b9e-b237-3b822ac9d186@redhat.com>
 <CAMuHMdVEfPtwps0A29WvHcwgo3f+3nTBiGn1PFxoYy1dxPsUMA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdVEfPtwps0A29WvHcwgo3f+3nTBiGn1PFxoYy1dxPsUMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/24 00:48, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Tue, Sep 24, 2024 at 9:34 AM David Hildenbrand <david@redhat.com> wrote:
>> On 24.09.24 01:56, Guenter Roeck wrote:
>>> v2: Instead of trying to make SPLIT_PTE_PTLOCKS depend on the
>>>       existence of NR_CPUS, define NR_CPUS for m68k.
>>
>> Okay, looks like we're cleaning up CONFIG_NR_CPUS for good.
>>
>> I'm back from conference travel tomorrow; I'll then throw in the following
>> into cross compilers and fixup any other arch that needs attention:
>>
>>
>> diff --git a/include/linux/threads.h b/include/linux/threads.h
>> index 1674a471b0b4..e31715e6746b 100644
>> --- a/include/linux/threads.h
>> +++ b/include/linux/threads.h
>> @@ -13,8 +13,7 @@
>>     * bit of memory.  Use nr_cpu_ids instead of this except for static bitmaps.
>>     */
>>    #ifndef CONFIG_NR_CPUS
>> -/* FIXME: This should be fixed in the arch's Kconfig */
>> -#define CONFIG_NR_CPUS 1
>> +#error "CONFIG_NR_CPUS not defined"
>>    #endif
>>
>>    /* Places which use this should consider cpumask_var_t. */
> 
> This is gonna trigger on almost all architectures if CONFIG_SMP=n.
> 

Guess that means that my patch won't work either. Any better ideas ?

Guenter



