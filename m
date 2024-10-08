Return-Path: <linux-kernel+bounces-354743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B9F9941FF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B123A1C214B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2D1E630C;
	Tue,  8 Oct 2024 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dog0Kn5Y"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B01E573D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374289; cv=none; b=ZVyeKOJYjupGJDjBKuvzUlyDL718ifq3BOa3g+GQJSBKQlCjvYFeWpt6NdIn5BXobn+6l23P2l6nZQSbqxnwWBK1SgBX6aqWRR7Fcl0KIY4c2KbcRhRaUWXTzP04UZ2QiHRYQaK5MNh0F7z5SIfIjQL3uLRqDphDyr125Mc+kts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374289; c=relaxed/simple;
	bh=wCCqfEz6DdFrWWciNOJjsQOLoAG1ndMV94GtscM3NLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkR6r7tOGQNRLOay65gMukAaq9vtkvkMacdWF/8yItmbZjwLF/dDbUEPRsNqq+D/phQdS+DmmGqkLu1fl8Nx+eEeMkgMdVixveNm1ccPkm/+o+pWHYqCYqhNeeUdC5FHUW5g7A4J/Wt1YvvmxD9XaPJiUX+KHxcKjZCcglFqB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dog0Kn5Y; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea1b850d5cso543536a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728374287; x=1728979087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilwU71p4JFHuhR5ku0P7wUYkTrTMS6pYXE6vb6DDuiw=;
        b=Dog0Kn5YkkVQQTyZVAak9Qd0OT8Zzfwg3+pCHRxSAdjxjnBsvn6Jvdk/0vt13j0pls
         Lp0bA4GHlSh8EPMNMPNyTfZ7RdNOJh/u6dAcpVgOtfoFNvituzCRHaXa0xMrQ9bE1qDW
         Yw4PTDfKd0j4Fuq+q/UlMxEHsMHyDV90jOuLz7++czaA3ZlaE4Po0jmZtGqgygsvO2iw
         6moioErt4kbu6L2tz+VAHW1a/J+1xqJ31aXsQvTdp++sdBIpyL+bwGaJSR45T5F3PJeN
         fuOW4++j+pD3itYy7So0bAzFWwLgye1OA2QKov7bBAzpJfTOAVeOmcyZmrw5sFgctClx
         s59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374287; x=1728979087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilwU71p4JFHuhR5ku0P7wUYkTrTMS6pYXE6vb6DDuiw=;
        b=Kv1fGAnGUjut72UxMYlNQY0ZUJbsOQd6+Qw7AVzBkxW3XHzC6Cz6jh4WYlKOdglMJJ
         0BJaWJ1KIZaPK+Pqb03+RiZAAO3k6hIRnboAHjx6+Ithxa7zILR2E1P8tNvrwnvCtBz3
         V4n8Lq4tBrl68pw8GP5xahpvwKvTvUeGQDWvol6kYJ2foTULuDgi1QHWqtUpFB/lP7bH
         p2H5vN966PSdjN2/ZzNC8PZGUdC+Yx53YWACgG8wyjgHHFMGO4oJ3rx3BCA1nq6gEWqM
         BYAkBmOd0mLguAnrvx6Tewu0Fd9Iy0I5Yxtk4Lqv34cHo22Z7QG90WMavkJcs6vrlO0E
         x0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVvS+av9O7mD9QXsgX8QaGeBIigxJ++b2dZiZ9McuG7knQLUsl3VJDiJ6vK+fJC+lXjB0A9Kk0syNlARl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTNOMKQY3wfM0GDtGMYxYAWd57v+KVD2K6vVBuwdOme4F9XGVn
	o1+P01OETIzmEU7Lc871RqNyufi7LttvymDoJg0YkOurysMDeRba/2UWvlDsKrU=
X-Google-Smtp-Source: AGHT+IHN1g2uzj5AhSKq4svLeyrNe2KgneEIeIGEQbArzd+een94HcwN+eGFkVCRRabnx0ftu/fetg==
X-Received: by 2002:a05:6a20:e18a:b0:1cf:658e:5107 with SMTP id adf61e73a8af0-1d6dfa44dd3mr22323407637.21.1728374286725;
        Tue, 08 Oct 2024 00:58:06 -0700 (PDT)
Received: from [10.68.125.128] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d67bc8sm5764221b3a.177.2024.10.08.00.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:58:06 -0700 (PDT)
Message-ID: <b989a811-f764-4b3d-b536-be4e68c0638e@bytedance.com>
Date: Tue, 8 Oct 2024 15:58:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, willy@infradead.org, hughd@google.com,
 lorenzo.stoakes@oracle.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
 <1c114925-9206-42b1-b24b-bb123853a359@bytedance.com>
 <75fac79a-0ff2-4ba0-bdd7-954efe2d9f41@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <75fac79a-0ff2-4ba0-bdd7-954efe2d9f41@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/8 15:52, David Hildenbrand wrote:
> On 08.10.24 05:53, Qi Zheng wrote:
>> Hi Jann,
>>
>> On 2024/10/8 05:42, Jann Horn wrote:
>>
>> [...]
>>
>>>
>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>> index 24712f8dbb6b..dda09e957a5d 100644
>>> --- a/mm/mremap.c
>>> +++ b/mm/mremap.c
>>> @@ -238,6 +238,7 @@ static bool move_normal_pmd(struct vm_area_struct 
>>> *vma, unsigned long old_addr,
>>>    {
>>>        spinlock_t *old_ptl, *new_ptl;
>>>        struct mm_struct *mm = vma->vm_mm;
>>> +    bool res = false;
>>>        pmd_t pmd;
>>>        if (!arch_supports_page_table_move())
>>> @@ -277,19 +278,25 @@ static bool move_normal_pmd(struct 
>>> vm_area_struct *vma, unsigned long old_addr,
>>>        if (new_ptl != old_ptl)
>>>            spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>>> -    /* Clear the pmd */
>>>        pmd = *old_pmd;
>>> +
>>> +    /* Racing with collapse? */
>>> +    if (unlikely(!pmd_present(pmd) || pmd_leaf(pmd)))
>>
>> Since we already hold the exclusive mmap lock, after a racing
>> with collapse occurs, the pmd entry cannot be refilled with
>> new content by page fault. So maybe we only need to recheck
>> pmd_none(pmd) here?
> 
> My thinking was that it is cheap and more future proof to check that we 
> really still have a page table here. For example, what if collapse code 
> is ever changed to replace the page table by the collapsed PMD?

Ah, make sense.

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

> 
> So unless there is a good reason not to have this check here, I would 
> keep it like that.
> 
> Thanks!
> 

