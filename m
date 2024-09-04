Return-Path: <linux-kernel+bounces-315189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E9696BF13
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E785DB29C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3AC1DAC4A;
	Wed,  4 Sep 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieQb6ozF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ABD1D58B9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457658; cv=none; b=WHjdzzpX9AE+so9Ttk2xo7dsv+Wt26tSatcx5h5IstKl+1bS2rygngK3NkGSvVaDoZinaRcVzqP4KJ8f9CirlxBKv8cUlRybiTkDcvAO6QmubA+hQsgXhMbJKuWeBaWUoa0vSFalqVGFZQAP1PL/VCVwmEJwfCKfygJft78Riig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457658; c=relaxed/simple;
	bh=XCAOq/l6EbmsFCNrhSb2wJECm2H2yhnH1yuOLkQLcdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIcfHodJV+BPH0p9m9MTf6Yera+UUj8zt/6sFwiTpw/4reNPT8ppJO7O/VfHstelukUYN9kHzhcC/EKgiVZHSRYXg5AwJ+Go1KpQRiB0L1qiN4TnhBl0ZzNSttkrk9q5V69AQg3I30G9QJ2c2SakrzeTwDCfLTeYWztNjujPDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieQb6ozF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725457654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y9slNLNgLUTr4FnRCMWzdGYRhtuezAhdzeTe1nXDfqE=;
	b=ieQb6ozF9ZiIY5X+Zr9FWOrLsgq7krt0RmKxf/zKMTa/6/VTFrpzwJhxRsf72yU4EdorLh
	I93q4Pfu28LjQHcrm6siKQDbOZURfVGXdm7hkfDUD58M6AovXKk0FDlWnwYD2NZHh3CT9I
	KS30Sj2ZDmOH6uIuuIfQnYzXZPCG+ws=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-NfYKWH2ZM3SPmCLBba2pKQ-1; Wed, 04 Sep 2024 09:47:33 -0400
X-MC-Unique: NfYKWH2ZM3SPmCLBba2pKQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb5950d1aso73639235e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457652; x=1726062452;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9slNLNgLUTr4FnRCMWzdGYRhtuezAhdzeTe1nXDfqE=;
        b=YoF7GpttYuTghGSfOWJC0dr1cQb7qcnVAyc8WMkauC15ZgPJ1dMeQQRORV7dJAy49G
         wZY8I1RyzDDRpfOrsXnR3O5KMbgupTyeaYBaM+hYf2SgsGXDY7lb7Sx5vequ7v9T9VRs
         msfDswHfHFYbgJim5T42YoTHcved8X3BFrmwwflrBHtu8Tyw1vUzxyhE1kEsHn/3aEJx
         AV06xK3St88DMokJwouqkVSD/EYqFJFok0K5S7qwQ8+QU50DEJ2HjJVz+wvtk2BM/6Np
         rpdvT4BYCtFPOx0ag60C8VjvKPInJcgAvO8tSRpdXJ0y0lNknpdx8GB9UwHNhJ/wucXa
         fmEA==
X-Forwarded-Encrypted: i=1; AJvYcCVKHZ/erQXmeRc2ff0ANZDrh4C+4Gx20lIdnnuyd4W9zLf8LlgaTPJhfiYAfo6nzZnNfnho0Irf4tpPGt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeJN4w5LwGNrVrzZOJliBvpJsugu9qA7lS/Rch7wIO1OEei0b
	Wof0gCdVpkIQZ0+8+bM0BB+aNK/PX2w8wjT6NmivkXfdfYSKEIFCYkuJqSAb0Ie2diRNegcXd6N
	Dp9CUpSHKNuPPw/y8HEsIDGPAKy4Gv8AWoFD5gJ/p+T+m1exeSdcfJK/+dZFgig==
X-Received: by 2002:a05:600c:354b:b0:426:545b:ec00 with SMTP id 5b1f17b1804b1-42bb01c1c17mr185662425e9.19.1725457652577;
        Wed, 04 Sep 2024 06:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKGb6UWCFw8UtEEyWXWthdR1NRQcUe29HLfSY0gAMmZHGri5k23RGtfh+Y+NOdYo+YOXvcpg==
X-Received: by 2002:a05:600c:354b:b0:426:545b:ec00 with SMTP id 5b1f17b1804b1-42bb01c1c17mr185661815e9.19.1725457651419;
        Wed, 04 Sep 2024 06:47:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:d00:e9a5:ae4b:9bdb:d992? (p200300cbc7150d00e9a5ae4b9bdbd992.dip0.t-ipconnect.de. [2003:cb:c715:d00:e9a5:ae4b:9bdb:d992])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb37f7849sm211160325e9.7.2024.09.04.06.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:47:31 -0700 (PDT)
Message-ID: <273ee480-76b4-4b57-a95b-2849fe394bc0@redhat.com>
Date: Wed, 4 Sep 2024 15:47:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential Regression in futex Performance from v6.9 to v6.10-rc1
 and v6.11-rc4
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
References: <CADYN=9JBw6kq4E9aA=Pr1rFy-6tY-j-XOthQVYVw6ptmj11=HA@mail.gmail.com>
 <f3fe6be4-723e-45b8-baa6-5c285cc5c150@redhat.com>
 <CADYN=9+xONPg=UrApM9xsKs2Um3VDMCi5X0684k0idJv-th82w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CADYN=9+xONPg=UrApM9xsKs2Um3VDMCi5X0684k0idJv-th82w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.09.24 12:05, Anders Roxell wrote:
> On Tue, 3 Sept 2024 at 14:37, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 03.09.24 14:21, Anders Roxell wrote:
>>> Hi,
>>>
>>> I've noticed that the futex01-thread-* tests in will-it-scale-sys-threads
>>> are running about 2% slower on v6.10-rc1 compared to v6.9, and this
>>> slowdown continues with v6.11-rc4. I am focused on identifying any
>>> performance regressions greater than 2% that occur in automated
>>> testing on arm64 HW.
>>>
>>> Using git bisect, I traced the issue to commit
>>> f002882ca369 ("mm: merge folio_is_secretmem() and
>>> folio_fast_pin_allowed() into gup_fast_folio_allowed()").
>>
>> Thanks for analyzing the (slight) regression!
>>
>>>
>>> My tests were performed on m7g.large and m7g.metal instances:
>>>
>>> * The slowdown is consistent regardless of the number of threads;
>>>      futex1-threads-128 performs similarly to futex1-threads-2, indicating
>>>      there is no scalability issue, just a minor performance overhead.
>>> * The test doesn’t involve actual futex operations, just dummy wake/wait
>>>      on a variable that isn’t accessed by other threads, so the results might
>>>      not be very significant.
>>>
>>> Given that this seems to be a minor increase in code path length rather
>>> than a scalability issue, would this be considered a genuine regression?
>>
>> Likely not, I've seen these kinds of regressions (for example in my fork
>> micro-benchmarks) simply because the compiler slightly changes the code
>> layout, or suddenly decides to not inline a functions.
>>
>> Still it is rather unexpected, so let's find out what's happening.
>>
>> My first intuition would have been that the compiler now decides to not
>> inline gup_fast_folio_allowed() anymore, adding a function call.
>>
>> LLVM seems to inline it for me. GCC not.
>>
>> Would this return the original behavior for you?
> 
> David thank you for quick patch for me to try.
> 
> This patch helped the original regression on v6.10-rc1, but on current mainline
> v6.11-rc6 the patch does nothing and the performance is as expeced.

Just so I understand this correctly:

It fixed itself after v6.11-rc4, but v6.11-rc4 was fixed with my patch?

If that's the case, then it's really the compiler deciding whether to 
inline or not, and on v6.11-rc6 it decides to inline again.

-- 
Cheers,

David / dhildenb


