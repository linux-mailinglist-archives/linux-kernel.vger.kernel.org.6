Return-Path: <linux-kernel+bounces-311032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C319C968427
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8025D28125F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B13D13CF8E;
	Mon,  2 Sep 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMwQPQQ9"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7013AD37;
	Mon,  2 Sep 2024 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271766; cv=none; b=dmAhYDwRe5QQkbW230BHMzCuGD8fgE3cK056EJZdjYTwCEbbBVj7LcIoSEHCK+RuohoqovhU/0QBJK2Zf9kITYiMcxHYpTxKLspELjZjpIAHbuKrAIZUI7WAfphqC2ywRi9wgg5sSVCjffeC1lM3fxjn8atTn27p6G6sxLUKJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271766; c=relaxed/simple;
	bh=lzYfpfpRNSnHHYs5OJpvSysvCEO7Y8rYtnLM91szTBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJxM9PbXzKyRgRxpXklYd1dxegExpD2T9EoNfwm07WmnZE+hAO5QiWtQvWymLQxUgAMP7ZemkFOCJPA/xiRRdKFpIhCHDyu56t0jStU00daQiu7U+CwfzuX8qNF+tWRpRa5PFuOM7xNWtv8bC3A25Q1VpsFr6Y/KuUR+unsPIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMwQPQQ9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso439969766b.2;
        Mon, 02 Sep 2024 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725271762; x=1725876562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4qeT7o4ULHWCXxvL6tnTmiF2kCLEXZf1Gydy/0gqfY=;
        b=CMwQPQQ9gK64SI8JFA22KXY3i2W5QssnKGubRbVaYSMtkCsqkKmFIrJIhr9DQPWCbD
         JLvZUxvG2tObTy8NNxk3KeEQHNl19jO987JHMcWw1dWOy1gPsYZk+dq7sq43+6uGVrmq
         asxxOEo18W33RfY78Sj4M2nYaZftbb/jyNGof6rmFL6DGF+yVX79zTtaK4RVLsti6y3O
         WfIvAYm/trEeYmjJfchQiLGJZjlVF8CWM7wMFcJOiJlpyYV4QsFCUej4kW3sRkB19g17
         1LoE2hBflvBDhHOqIQG0lPzXbHs76o4DHT64eICMVWAci1+A5+cBSsndRl9UVU8fVj/S
         XZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271762; x=1725876562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4qeT7o4ULHWCXxvL6tnTmiF2kCLEXZf1Gydy/0gqfY=;
        b=CKTZ/lD/4aWcfFVI/UvIMbYTCkQHfjd/5kWYAzecWDZ6sY9wEUXPJfRKYagAFM4p1B
         162v5KS0Rrg+a2wa0ZRuBH1lfRowZ4U4W5/cZfndtJ7+ULrqpdMTmB6WHRLeUkDtJfRW
         lwBiv60JPDUVkeHoLkw1npzksfNf0aaJEayK2DOlEpGpTQZMj1T/u91GYwDAnxKWjK+z
         TF9Sjo0AoGTpRFLt/8b6jydMcfV5OhatIApQcZ4NK2lEi7shE/H8cVKaRD+pwBQGh+N3
         EnWqeqDrrsYBMM2Al1BYEvi8EI+sLPjvMXVcZZkrtibUlQQJAMrlzfQpV+DrWxX43oay
         GB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTCK358uE3qUQiLO+y1qz0o+H7vCGRDKU+zHYBX+Dhy7G9msaFlTVeYq302Fn3qsVf/hP6mSUajllq6CxV@vger.kernel.org, AJvYcCXjUbnr5xUEmSHupPK56O71CGomKnqr/gwCE2Bg+gQ3O1l6K2MdvthU/JCx3juRCl1sLbBCPf1vTsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHeh7o5NBYuQol+HvbY3NGqrkbp7MOM27Knybg2ZnagOxOah43
	ZBP8Zm9XSpzaNvnot0k/OJkysaLY/pX8OGJRJ98ig5wRGbPErg2l
X-Google-Smtp-Source: AGHT+IEknuOqL3uHFMqy/8uXTo23Npaz4MEm2YU7/Kccsr2LMVU8Oh04k1tsDqje10i2pJc+cTU1gw==
X-Received: by 2002:a17:907:7f1e:b0:a77:b052:877e with SMTP id a640c23a62f3a-a897f84d4d0mr894471266b.19.1725271761663;
        Mon, 02 Sep 2024 03:09:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:76e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f26asm541443366b.58.2024.09.02.03.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:09:21 -0700 (PDT)
Message-ID: <3b910105-591c-45d4-b9c8-8b70f20f283b@gmail.com>
Date: Mon, 2 Sep 2024 11:09:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Bang Li <libang.linux@gmail.com>, Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, libang.li@antgroup.com,
 Lance Yang <ioworker0@gmail.com>
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
 <20240819023145.2415299-5-usamaarif642@gmail.com>
 <CAGsJ_4yKuvMSazWABXqaeRr84hLEubET0nCUhPFYHQnfR4Tm8w@mail.gmail.com>
 <a09b6af0-4fdb-4ac1-9cbe-9b422ebc3308@gmail.com>
 <CAGsJ_4xeWt9n3zX3-DknE=NftkWS0fe2vKTJT9tLuJPM4EaEwg@mail.gmail.com>
 <9a58e794-2156-4a9f-a383-1cdfc07eee5e@gmail.com>
 <CAGsJ_4xiG+oGkjt3nf0Zh2rdztz8h_AaahZWs4N3UARhw7DcgQ@mail.gmail.com>
 <CAGsJ_4z2YL01wvVgsFsbzGAQ5KowXgxLcj=Y7DSX7ODOF5MUvw@mail.gmail.com>
 <953d398d-58be-41c6-bf30-4c9df597de77@gmail.com>
 <CAGsJ_4y49c8-hDgjNuqMZnNWfUT-ktxeqkfX0EQz4-Pu3x9-Dg@mail.gmail.com>
 <5ed479c9-21eb-4bc8-8c17-79e1b6081355@gmail.com>
 <9eb5af0d-730c-459d-9c2e-5ad7b78f30d7@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <9eb5af0d-730c-459d-9c2e-5ad7b78f30d7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/09/2024 08:48, Bang Li wrote:
> hi, Usama
> 
> On 2024/8/22 3:04, Usama Arif wrote:
> 
>>
>> On 20/08/2024 17:30, Barry Song wrote:
>>
>>> Hi Usama,
>>> thanks! I can't judge if we need this partially_mapped flag. but if we
>>> need, the code
>>> looks correct to me. I'd like to leave this to David and other experts to ack.
>>>
>> Thanks for the reviews!
>>
>>> an alternative approach might be two lists? one for entirely_mapped,
>>> the other one
>>> for split_deferred. also seems ugly ?
>>>
>> That was my very first prototype! I shifted to using a bool which I sent in v1, and then a bit in _flags_1 as David suggested. I believe a bit in _flags_1 is the best way forward, as it leaves the most space in folio for future work.
>>
>>> On the other hand, when we want to extend your patchset to mTHP other than PMD-
>>> order, will the only deferred_list create huge lock contention while
>>> adding or removing
>>> folios from it?
>>>
>> Yes, I would imagine so. the deferred_split_queue is per memcg/node, so that helps.
>>
>> Also, this work is tied to khugepaged. So would need some thought when doing it for mTHP.
>>
>> I would imagine doing underused shrinker for mTHP would be less beneficial compared to doing it for 2M THP. But probably needs experimentation.
>>
>> Thanks
> 
> Below is the core code snippet to support "split underused mTHP". Can we extend the
> khugepaged_max_ptes_none value to mthp and keep its semantics unchanged? With a small
> modification, Only folios with page numbers greater than khugepaged_max_ptes_none - 1
> can be added to the deferred_split list and can be split. What do you think?
> 

hmm, so I believe its not as simple as that.

First mTHP support would need to be added to khugepaged. The entire khugepaged code needs
to be audited for it and significantly tested. If you just look at all the instances of
HPAGE_PMD_NR in khugepaged.c, you will see it will be a significant change and needs to
be a series of its own.

Also, different values of max_ptes_none can have different significance for mTHP sizes.
max_ptes_none of 200 does not mean anything for 512K and below, it means 78% of a 1M mTHP
and 39% of a 2M THP. We might want different max_ptes_none for each mTHP if we were to do
this.

The benefit of splitting underused mTHPs of lower order might not be worth the work
needed to split. Someone needs to experiment with different workloads and see some
improvement for these lower orders.

So probably a lot more than the below diff is needed for mTHP support!


> diff --git a/mm/memory.c b/mm/memory.c
> index b95fce7d190f..ef503958d6a0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4789,6 +4789,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>         }
> 
>         folio_ref_add(folio, nr_pages - 1);
> +       if (nr_pages > 1 && nr_pages > khugepaged_max_ptes_none - 1)
> +               deferred_split_folio(folio, false);
>         add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>         count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
>         folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
> 
> shmem THP has the same memory expansion problem when the shmem_enabled configuration is
> set to always. In my opinion, it is necessary to support "split underused shmem THP",
> but I am not sure if there is any gap in the implementation?
> 
> Bang
> Thanks
> 


