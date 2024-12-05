Return-Path: <linux-kernel+bounces-432535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C49E4C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD38282A42
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8B18C924;
	Thu,  5 Dec 2024 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TjSyQDBu"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294891865E3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733368993; cv=none; b=jyXNAw/5i5utxbPbT069Hcu74YZkWtjCFp/f7nwMwpNheyahyBLZ2g+ZnTrWp9jisRHdXCKMQyMll7oO6tlhuDhKLniwzVtvXTncCDgywOr1w6C+C8S5ZnY6X/oblBM6vCMn59iwkhT/C5gwV06PtZQACFp5+H7utenIpLSbCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733368993; c=relaxed/simple;
	bh=ZCvH+C5+WV3cOkyZIWGBHHjjbGFDYAyQQUIluP4nx14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqppeaAn8kYYMK72tNridPWwNjgxtFlCbagwPVb4MUWpFpjM4QrscxSLqU4CU+ZQFAaunp6DEV2RXOnkJ8d/GcVx0R7azXTg05LuOYxBsbGFBOnUvBpstyi32JVWKzwP+3WN0+LcoC1DWxyFHRCVQar8+FHCxWSzC8tQNagYupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TjSyQDBu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fd10cd5b1aso359651a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733368991; x=1733973791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHrI50pChK08//QUGItvS7g1V676Q3cWe2B2yU1N3lQ=;
        b=TjSyQDBuZLzoOlD7S4Jb7Q5/wWBEa0OVbmDwNSqAkfnaTLsM54sXu+HKS8CQNaW+2K
         FXzVGpiBaNS8ifNPMsHFOZOOLZ+ZtuFQK2I4cY8vsDb4mZu49DIQHGqSBwLgy+/rZHiG
         BImejKJ9p/F/R48jMoQ7/BKvFmee6BO6swT7RX6dpnlmKPNFNyycw44UoslYue1POCUR
         6NeBPyDRyaHFzI0H8bMx7/WB98B1PFL2263+cJMWRTIwpBZbNRYQ/DM6Qt0HIlJzSeH7
         jGm2d7pN6ki/VxLYQKV+zqRxcrmI6QRSDnkwtGzSPPydMR9egMV9TenY3TBtDHFJsUJB
         lpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733368991; x=1733973791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHrI50pChK08//QUGItvS7g1V676Q3cWe2B2yU1N3lQ=;
        b=TBQEMYjmkVr4g8N5ce9g6nsGL7ylh+Cwx0uc0dAwDnDwaJ8e34E4FgU0MjjY6oYWkV
         Ww1528m4tAvFZSx2NoL3buXn4MJ1ONvRSiFUAhSOIl+FuwI7v6FPF6MTagMtwOIMfC1i
         nlQCIziy7PeeZCR3oSwa86fngrrIz0liLv53BoRZZ563cltvgJroD/+kTGLZKEzIYept
         x7fF8a7/9qa1JLJrCLWT5XR6SblPxURq9VDEVOJiwcMZ6GZUj991YOtwUCEpwzv+puBR
         XH3bJaUMV6/ZLZNJ27HmzURS+BGcVaa0x6CNYM3W54KxesZhtVSEr9a5AVjcYGxGQ6w3
         pr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjDg27/LZyi4dISgfOfGms4C7wnOhnvLRC7yO2jQiypGuWfQq8QwjPwGtjEdpPYM1EjR4ZN8rP1A/8NHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTG2iiMQ+wkckurxjGVPCQxuZaeZP3zWKM/wVEs4CvMYO1/TM9
	c6wKBhlPu5m5aeJwiqHItOhruFTCdk1608GjwDQIWIZvXgD7pUIbZ8CCYmc5zEs=
X-Gm-Gg: ASbGnct3DAoSt/Ajfh8Nz3N2IRgibP+Et5Ro1ODx1jvOfljZt7NPPYE5EqtemgD30ik
	kp+lHL4iL17ZWvK/FMjrjmeGR14cHCXzk6/ae9W3a5hy+pqfdtAZ7/2vy2/7eCS6dMlYEvmeVhI
	LhJ0MrE1bGifUkXQcMH7WsSUHU5M7VlFntBB7k4M80Zvcwtx3BLXo5E0AHKryFscrAHCqhvcx66
	XjifyhXtdfrnPtIakcNsMjyEwgyoprQonbPA2UYeaQ0qMke18kDgVk2UXN6Sty5Lbd5o6GJ9A==
X-Google-Smtp-Source: AGHT+IEYy4QQRgT58e6SW8SXvDIyqjn2p6ZKKi35A4rwss2f55N7+9M1MkDoBVp5DXNjZ45LbR/YQQ==
X-Received: by 2002:a05:6a20:d50a:b0:1db:a33e:2c6 with SMTP id adf61e73a8af0-1e16be0d5admr11615405637.18.1733368991384;
        Wed, 04 Dec 2024 19:23:11 -0800 (PST)
Received: from [10.84.148.23] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1568de28sm242037a12.3.2024.12.04.19.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 19:23:10 -0800 (PST)
Message-ID: <03bd739f-cceb-4024-a2fb-5331ba258d36@bytedance.com>
Date: Thu, 5 Dec 2024 11:23:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] mm: pgtable: reclaim empty PTE page in
 madvise(MADV_DONTNEED)
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>, david@redhat.com, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
 <92aba2b319a734913f18ba41e7d86a265f0b84e2.1733305182.git.zhengqi.arch@bytedance.com>
 <20241204143625.a09c2b8376b2415b985cf50a@linux-foundation.org>
 <CAG48ez1HjoZiyk+_JOxcA5eM797vCmzvXaEVUgd6Mkze-aykbg@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez1HjoZiyk+_JOxcA5eM797vCmzvXaEVUgd6Mkze-aykbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/5 06:47, Jann Horn wrote:
> On Wed, Dec 4, 2024 at 11:36 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Wed,  4 Dec 2024 19:09:49 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>> As a first step, this commit aims to synchronously free the empty PTE
>>> pages in madvise(MADV_DONTNEED) case. We will detect and free empty PTE
>>> pages in zap_pte_range(), and will add zap_details.reclaim_pt to exclude
>>> cases other than madvise(MADV_DONTNEED).
>>>
>>> Once an empty PTE is detected, we first try to hold the pmd lock within
>>> the pte lock. If successful, we clear the pmd entry directly (fast path).
>>> Otherwise, we wait until the pte lock is released, then re-hold the pmd
>>> and pte locks and loop PTRS_PER_PTE times to check pte_none() to re-detect
>>> whether the PTE page is empty and free it (slow path).
>>
>> "wait until the pte lock is released" sounds nasty.  I'm not
>> immediately seeing the code which does this.  PLease provide more
>> description?
> 
> It's worded a bit confusingly, but it's fine; a better description
> might be "if try_get_and_clear_pmd() fails to trylock the PMD lock
> (against lock order), then later, after we have dropped the PTE lock,
> try_to_free_pte() takes the PMD and PTE locks in the proper lock
> order".
> 
> The "wait until the pte lock is released" part is just supposed to
> mean that the try_to_free_pte() call is placed after the point where
> the PTE lock has been dropped (which makes it possible to take the PMD
> lock). It does not refer to waiting for other threads.

Yes. Thanks for helping to clarify my vague statement!

> 
>>> +void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
>>> +                  struct mmu_gather *tlb)
>>> +{
>>> +     pmd_t pmdval;
>>> +     spinlock_t *pml, *ptl;
>>> +     pte_t *start_pte, *pte;
>>> +     int i;
>>> +
>>> +     pml = pmd_lock(mm, pmd);
>>> +     start_pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &ptl);
>>> +     if (!start_pte)
>>> +             goto out_ptl;
>>> +     if (ptl != pml)
>>> +             spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>> +
>>> +     /* Check if it is empty PTE page */
>>> +     for (i = 0, pte = start_pte; i < PTRS_PER_PTE; i++, pte++) {
>>> +             if (!pte_none(ptep_get(pte)))
>>> +                     goto out_ptl;
>>> +     }
>>
>> Are there any worst-case situations in which we'll spend uncceptable
>> mounts of time running this loop?
> 
> This loop is just over a single page table, that should be no more
> expensive than what we already do in other common paths like
> zap_pte_range().

Agree.


