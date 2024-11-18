Return-Path: <linux-kernel+bounces-412371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB09D082E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A1FB21289
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90841C71;
	Mon, 18 Nov 2024 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jZr/8t/s"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80623A9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731900927; cv=none; b=QkZmNGw9Z8um4FGpQ0N5h3JmSxCXktNzPFhf9lQs78Nq8S9UfpB7ff3vsZwE3/zD+S6XC8KRcKto+okwhvPkVRYKs9tZ3O5NmviNowKnEP6JlCWq2h5hxTtCgQe3sgF2sfiVSgep1qWTspZosflLF8OrbafDRiwzgoY5c2p36VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731900927; c=relaxed/simple;
	bh=fhvX3QTdwfl7Lm8jj/QIJ84KIQGJIQSQzSe3OZZ3Xno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+ivqGpSeBbSFvGiol8EuGdNfknpVQrKu6ZR6mjnphvnwPpWR7A/UxnSBk+Uo34g/ZWwiCpqgrgVdHZtvvKXNeaiQKs42ly1nrLxObEC3n8sKmtnvjyNCbHWeh2mV229OrwDfRshHcnznwIKmwDa8eauSGg/QwCq9ySQHWl4tiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jZr/8t/s; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21145812538so28618895ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 19:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731900924; x=1732505724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAYOV2IOUo6rjS8pTIiOgTq2N/PP28lI20oMJdYXwLY=;
        b=jZr/8t/s4TX1zNaxz+b2erx8a26EWZjot2GbYTXK0eXSwlbe/kL4AsyR91LcGL6Nmj
         RTecbeHAfJ4Y3oJPnVpZJoEcxXDZVJUywkLVU+OWMIOQJwJ/rXFecfpsxSymqF/qLeJ6
         ZEZlJFXRafO+aceCR1HD2GBYgZkSrAcIYwYzb7YrfrruTdvoCNxEVI0dnsEloScddEor
         UYQY7QvJAmtctxrmqWouJLJfxF5MHgcSJYRePtSA/tZ6GINxnL2N+A6IfX9Kn3RNZh/Z
         IgXR7h7GUh4IhVDQacOtEvJJuXYDUv4h4sMfiBnF5z0HTIsjSY3YGqswa687pwL+CsFh
         hRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731900924; x=1732505724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAYOV2IOUo6rjS8pTIiOgTq2N/PP28lI20oMJdYXwLY=;
        b=icSqe6P1SrMnyUqQoCYyqnZaAH27KefrF7xCB2QYnMdy/F/FIaa8QyRPGZr3ypFDfH
         HOCesc8/ZEJEYH3di0NU6IqvruM1wFIzdJf30rbMV1cEh2Wv34AjwrN0jxJzPjTvX3Fn
         IcFEEqkrgHbGr1A1znRUo1f16hl/9iutGy5phAtLc3XDj2VlOaooDNva5HNl3xa9szx9
         5n/+j6mdVlIF86fBGbEC/HblWaur+NhJ3WW7HOp/oz+jYtmxWZ+NmQjCCKkx44VQOgT1
         uPvp7hR43wKZeRM6Yf/SRTEGyQILX6+fWpbl7131UCNlcGwx+RpqUJUEaGW4FeoWruOw
         3zNg==
X-Forwarded-Encrypted: i=1; AJvYcCUCi6CIvWsJek/o8FflH7A08RSjeNQak6+lPtsaasfUQW5+hVfmX/aW2nSf1niZ/M3JNmdpy4JxsZ1Uk34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYU5MWvP63sMmXlVPV04kzB3ghUlyy8H8KW8hJmR9A3QmBjHdc
	jpt7ZkchArBQFthG6NLLEmKYeE0iUYfFUVE8Gde8MqDGiZC1Ip7dzXrSiJKS0ew=
X-Google-Smtp-Source: AGHT+IGJ9PVwE31jWWhuyYcnhq9nPi2dLbhq/ndM6SWBSnO7O3ZT02MQhTcQjxiDQC20nehdJUqHhg==
X-Received: by 2002:a17:902:8603:b0:20c:7409:bd00 with SMTP id d9443c01a7336-211d0d4c24amr115112385ad.5.1731900924349;
        Sun, 17 Nov 2024 19:35:24 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e9d0c389sm33367775ad.161.2024.11.17.19.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 19:35:23 -0800 (PST)
Message-ID: <2b48d313-4f66-47c8-98d8-8aa78db62b1b@bytedance.com>
Date: Mon, 18 Nov 2024 11:35:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zokeefe@google.com,
 rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
 <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
 <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
 <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
 <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
 <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
 <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
 <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
 <5a3428bd-743a-4d51-8b75-163ab560bca7@bytedance.com>
 <4edccc1a-2761-4a5a-89a6-7869c1b6b08a@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <4edccc1a-2761-4a5a-89a6-7869c1b6b08a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/15 22:59, David Hildenbrand wrote:
> On 15.11.24 15:41, Qi Zheng wrote:
>>
>>
>> On 2024/11/15 18:22, David Hildenbrand wrote:
>>>>>> *nr_skip = nr;
>>>>>>
>>>>>> and then:
>>>>>>
>>>>>> zap_pte_range
>>>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, 
>>>>>> &skip_nr,
>>>>>>                            rss, &force_flush, &force_break);
>>>>>>         if (can_reclaim_pt) {
>>>>>>             none_nr += count_pte_none(pte, nr);
>>>>>>             none_nr += nr_skip;
>>>>>>         }
>>>>>>
>>>>>> Right?
>>>>>
>>>>> Yes. I did not look closely at the patch that adds the counting of
>>>>
>>>> Got it.
>>>>
>>>>> pte_none though (to digest why it is required :) ).
>>>>
>>>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>>>> empty PTE page.
>>>
>>> Okay, so the problem is that "nr" would be "all processed entries" but
>>> there are cases where we "process an entry but not zap it".
>>>
>>> What you really only want to know is "was any entry not zapped", which
>>> could be a simple input boolean variable passed into do_zap_pte_range?
>>>
>>> Because as soon as any entry was processed but  no zapped, you can
>>> immediately give up on reclaiming that table.
>>
>> Yes, we can set can_reclaim_pt to false when a !pte_none() entry is
>> found in count_pte_none().
> 
> I'm not sure if well need cont_pte_none(), but I'll have to take a look 
> at your new patch to see how this fits together with doing the pte_none 
> detection+skipping in do_zap_pte_range().
> 
> I was wondering if you cannot simply avoid the additional scanning and 
> simply set "can_reclaim_pt" if you skip a zap.

Maybe we can return the information whether the zap was skipped from
zap_present_ptes() and zap_nonpresent_ptes() through parameters like I
did in [PATCH v1 3/7] and [PATCH v1 4/7].

In theory, we can detect empty PTE pages in the following two ways:

1) If no zap is skipped, it means that all pte entries have been
    zap, and the PTE page must be empty.
2) If all pte entries are detected to be none, then the PTE page is
    empty.

In the error case, 1) may cause non-empty PTE pages to be reclaimed
(which is unacceptable), while the 2) will at most cause empty PTE pages
to not be reclaimed.

So the most reliable and efficient method may be:

a. If there is a zap that is skipped, stop scanning and do not reclaim
    the PTE page;
b. Otherwise, as now, detect the empty PTE page through count_pte_none()


> 

