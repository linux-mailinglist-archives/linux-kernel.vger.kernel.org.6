Return-Path: <linux-kernel+bounces-218997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A981790C895
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF991C20ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3E209753;
	Tue, 18 Jun 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WPclG+mj"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688D209749
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704527; cv=none; b=YUl7cDAEAD4clFUMwEWc5qtd4ou4QlYHgcsBJD/gSAj50rxZHyzCpBgwaHvy3/JdacyANGm7GaQKmBf9A4Gj8Pj8UlPsJMgsDH66QLrTZ5qnHV7noKTRCMBarRZVRwTGvFs69xFToGvUfN9MWo5FsjbX0QUB4Zw/IWIKrxgV5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704527; c=relaxed/simple;
	bh=Ob1SpUggzHjihLh4xfrbw8v/w7IcgAc6tay5rWycp2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/CzOyMLwEh6bwIKv2OXaehDQK3wMTPqt3ar/2Ho2gvrRI+0hfnF4E1GiNGNKqS9Rt66wmqZQ5VRTuabfEJaXcqZkEo+IZTCpS7r4/oABWbnoYXWJynuHn03unQ+vajM36tl2XOeYw/5Uo4L2QLBu1iIDqL60YOH0BZWfwv5YPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WPclG+mj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2c1473f73so771758a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718704525; x=1719309325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZ8RZeQveT0C05v/nnaLgtXSgkTqWPEtT0u+88t9MxE=;
        b=WPclG+mjlPV7PwzKd2psIfK4OOaDWq+76DKjPNnWHx1G3JvSZ8ZdYBuSD3yDokjbfK
         spDZvq3fFvr3N/ZGZDZR5AWfp2arWXM6kd093iA+pogUKF6THdCo/bYhFCAvLzfSWHRc
         xSkWexuVO9PBOyaW3WMtQKD8GUXFxbEqfrl+db3HfM0CaQ4nRZj8IC2hvpqElzMkmzlO
         gEHy/kCc89C3lsn8cmp9GiMXvIuKYYDLJf3rTHqGz1J7VZsc//w5WB8UDZMytDvtugy/
         7gIwVI9mkQQnczv+NV5oUKVnyk8lFNumgbg/+tbXopcQTHkObmnRoXoHUxuXD8cLHh0k
         D4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704525; x=1719309325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ8RZeQveT0C05v/nnaLgtXSgkTqWPEtT0u+88t9MxE=;
        b=KCTVGZzR3kpjrNuTdJYQkgQAhJYg4xlvWRPB2/mgF6m8YUuhX7f+lkJbT+SYm4PuOL
         1aIdhcXvtusnTx3nPocdiRrrgcsiOVWZWttSTyW73Mwi4UXSyNKpXlBR9GDyswXW06Nn
         cbSPe049HKWAAZ/WBVwqkFSVtoagFdgagG3UOJUTymdmSlZKgJvtx9nu9G9Cv4v6nigk
         /IJgWnPpDvtoVsQC64uKi6UBrejJjQ39Yk4DkMCZcm4FGa9FkMWhPIZ9Eahsh94a1jIs
         aDBkNiWDvH1m/WDvplzYQ05Q+SprnGOXj6YEkmetVLSCxGYo0UqhGGKh4WkX0A+pzizT
         Cf1w==
X-Forwarded-Encrypted: i=1; AJvYcCXB23NLWbqqsyTD1/U6t4sALyDY46ljOdBJz/k6aE2BMQ+UzutY0KrVuy1ow0/ElLRTy6uj+6Mikcaex0K9HIYzJ2IqQjR2ah0GUZXh
X-Gm-Message-State: AOJu0YyPAINuraDc/KLtDfWBrPz0DJC1VELys0eKeEqxeg53ePvbVzZ1
	qeHy55HuBBaKzRGHGA2fWBSRdW+8cbCp+4V3Zf+IlSiPw16asfzPdJPGNnQ9wTCdDa9p7f3NtEs
	a
X-Google-Smtp-Source: AGHT+IHIINglfbS2m/QmOZ8rWnN7gWOjRheG64W8rq9oepAfCZre/sufl9Wv4Rjm611rEoiK7Dutnw==
X-Received: by 2002:a05:6a21:339f:b0:1af:96e7:2be6 with SMTP id adf61e73a8af0-1bae7b543camr14703140637.0.1718704525163;
        Tue, 18 Jun 2024 02:55:25 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45ab210sm10534022a91.4.2024.06.18.02.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 02:55:24 -0700 (PDT)
Message-ID: <0317efd5-f7f8-4fd2-8892-befe9fe97f33@bytedance.com>
Date: Tue, 18 Jun 2024 17:55:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
 <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
 <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
 <2cda0af6-8fde-4093-b615-7979744d6898@redhat.com>
 <aadae460-3797-4d10-a380-5d4fe8189e20@bytedance.com>
 <aaf9a7d7-647f-41bf-91b4-e362ff5df6b0@redhat.com>
 <f2fbf466-f722-4fd3-9883-189145e599f4@bytedance.com>
 <86b29391-ad2a-4c4b-b9a8-974d1876632c@redhat.com>
 <025ea89a-bb94-4f60-b6ad-d8b88d3cfc60@bytedance.com>
 <4f56d1e9-2c23-42e5-9aef-6b29d072138e@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <4f56d1e9-2c23-42e5-9aef-6b29d072138e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/18 17:40, David Hildenbrand wrote:
> On 18.06.24 09:51, Qi Zheng wrote:
>> Hi David,
>>
>> On 2024/6/18 01:49, David Hildenbrand wrote:
>>>
>>>>>
>>>>> No strong opinion, something synchronous sounds to me like the
>>>>> low-hanging fruit, that could add the infrastructure to be used by
>>>>> something more advanced/synchronously :)
>>>>
>>>> Got it, I will try to do the following in the next version.
>>>>
>>>> a. for MADV_DONTNEED case, try synchronous reclaim as you said
>>>>
>>>
>>> I think that really is the low hanging fruit that would cover quite some
>>> cases already: (1) reclaim when MADV_DONTNEED spans the complete page
>>> table.
>>
>> I will check and free the PTE page in the zap_pte_range() if the
>> (end - addr >= PMD_SIZE) condition is met.
>>
>>>
>>> Then, there is (2) reclaim when MADV_DONTNEED spans only part of the
>>> page table (e.g., single PTE), but my best guess is that it's better to
>>> scan for that asynchronously than making possibly each MADV_DONTNEED
>>> sycall invocation slower.
>>
>> Maybe just mark the vma, and then scan it in the system reclaim path.
>>
>> I also plan to do this in the MADV_FREE case, instead of adding an
>> asynchronous madvise option first.
>>
>>>
>>> (1) would already help a lot and showcase how the locking/machinery
>>> would work.
>>>
>>>
>>>> b. for MADV_FREE case:
>>>>
>>>>      - add a madvise option for synchronous reclaim
>>>>
>>>>      - add another madvise option to mark the vma, then add its
>>>>              corresponding mm to a global list, and then traverse
>>>>              the list and reclaim it when the memory is tight and
>>>>              enters the system reclaim path.
>>>>              (maybe there is an option to unmark)
>>>>
>>>> c. for s390 case you mentioned, create a CONFIG_FREE_PT first, and
>>>>       then s390 will not select this config until the problem is 
>>>> solved.
>>>>
>>>> d. for lockless scan, try using disabling IRQ or (mmap read lock +
>>>> pte_offset_map_nolock).
>>>
>>> Although d) really only is desired when scanning asynchronously I think.
>>> During (1) above, we know that the table will be very likely empty
>>> (unless weird race).
>>
>> Agree.
> 
> Again, thanks for working on this. Let me know (can also do privately) 
> if you run into any issues or think I can be of help. :)

That's great, thank you very much!

> 

