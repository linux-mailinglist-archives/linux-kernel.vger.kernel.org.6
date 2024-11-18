Return-Path: <linux-kernel+bounces-412793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC7B9D0F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9001F222C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA10194C9D;
	Mon, 18 Nov 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JmlbfaDg"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12655145B0F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927372; cv=none; b=UfvoEPIiV04JhTL23i8Zp0Bx/iLroH01L4LLTlWXSzkClS7tF3XXRY+uM99RHC+9WR7a70+5n7GS/UM9wObdZnK21jEMucMua8mT1FT7weLp8Y36okYwqIRU2o1OBBSeWWtAHhJOHVRbvLxCHORBFh11Ddkg2FY+jdSy6jlidiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927372; c=relaxed/simple;
	bh=OCKm0K9j838rU+iIfco2B8r0j5BQIrbvGb8oTIvf89o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWqNz3gqEkVUc9hcx/OamC8KgrRQV2q4rj5XqE6bL5LvHKorbEk+armhRU+QXwS6RBO2/8UmvX8dwrcZTI/wPJC37FJNFuiTyJcwqBVXWPDXnZPjRsgFwdh9SKp0MmHqA2amWix+Cor5cHx+V9l4dCVf18D8B10xnYP8vIuk9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JmlbfaDg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72410cc7be9so3040726b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731927369; x=1732532169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTnRV92NpOoxrbTXghMbwPsAR3AFhh0yFJWxh/9FjeY=;
        b=JmlbfaDglVhLRfl0/d+Gy2FiSKSI3dMj/FUSfznL7cWWx9/P+3NtsSSrPgOISVHzSK
         mDEsfGCD3quIr1/Ue1BYzHTCgUtRm/17Q5WM5DtdHOkNLSGaHFcVznHY9mydKNvRINsZ
         E6zYiJgZXfdkWLpYXoFYjHdQDa7BowTZbk+qDGU8Ocf9bbMvYA+fOy48DlfQz1mgjVgP
         OlKS84T8HRLhMar0ggVwgsUSmsKJI+9Z5StyWeo1BAVjg5OF86QcgEGqgcwEhHNGJYuF
         yOfkF0Z4U39sKEhgZEb33iBfxBe7rtO7j+9q4W2jA5KkGF4ugBqE5gRQuDvqG5dMt61+
         a+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731927369; x=1732532169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTnRV92NpOoxrbTXghMbwPsAR3AFhh0yFJWxh/9FjeY=;
        b=jToUVu5tyZuexBCQmXPMYm1u5hF9sd3j4bkWBebeOkx0+I0OEeyK52DTZ+Kgy0s5RO
         TAXQ1yNVUFTxoJpMJwKAkyJMlgJPkI0NZS3B54MAJHyR0ERQRjU5mu77xIljobtatigX
         C/hRww2EGTGGokkwf++ypy06ds28jvFd3GjO5H5UgbvQ8IGm4iihq8Hq0lTkZ3+0DcWk
         RUlsQd8lryhGLLK7k1q9OJdGWzL37N+1N4dqdmU+ZBYZAej5STji35rBSiHkUTW+b06/
         Ti+jg8J26BopPrHoY+djO1us14cYfMzU2sQtTxhope98vBc2rQ+i7sHzemymVoOSZixw
         MgNA==
X-Forwarded-Encrypted: i=1; AJvYcCU9XiByLNwhCaKM7PsnUUCYcQkj/BlCrLj1GeHyOcDUrSSZ00C1qe6g+wk/RohyyAGsWSyPDqHGzOb6EQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQunUr0SQ0ppRaGE70bUEGYiBhj0FO0y6Vc+QGMtSidSD3ViU
	58tqNfAhqXrxxqQXEofQ2r1zp1RGY4bhR68k9SwV/QZ8urcxdgz6pMkTztEF+8A=
X-Google-Smtp-Source: AGHT+IGP7j7Gjezn6MlPl8Z4Tzdv2xRpZ/rO6XtYluNhpj6WYZn1dAnYACGijsS/pWVgxe2DdkR2WQ==
X-Received: by 2002:a05:6a00:2309:b0:71e:7745:85b8 with SMTP id d2e1a72fcca58-72476b721d1mr15486017b3a.1.1731927369236;
        Mon, 18 Nov 2024 02:56:09 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247720bb56sm5891069b3a.198.2024.11.18.02.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:56:08 -0800 (PST)
Message-ID: <e2870a81-840a-4b33-b65b-318a4a526c26@bytedance.com>
Date: Mon, 18 Nov 2024 18:56:00 +0800
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
 <2b48d313-4f66-47c8-98d8-8aa78db62b1b@bytedance.com>
 <995804f4-b658-44b2-bb40-c84b8a322616@redhat.com>
 <f3adf382-d252-4007-b8ca-c557814cb5c8@bytedance.com>
 <4ee60b7b-a81e-4b94-96c9-52b1bd9d5061@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <4ee60b7b-a81e-4b94-96c9-52b1bd9d5061@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/18 18:41, David Hildenbrand wrote:
> On 18.11.24 11:34, Qi Zheng wrote:
>>
>>
>> On 2024/11/18 17:29, David Hildenbrand wrote:
>>> On 18.11.24 04:35, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2024/11/15 22:59, David Hildenbrand wrote:
>>>>> On 15.11.24 15:41, Qi Zheng wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/11/15 18:22, David Hildenbrand wrote:
>>>>>>>>>> *nr_skip = nr;
>>>>>>>>>>
>>>>>>>>>> and then:
>>>>>>>>>>
>>>>>>>>>> zap_pte_range
>>>>>>>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
>>>>>>>>>> &skip_nr,
>>>>>>>>>>                              rss, &force_flush, &force_break);
>>>>>>>>>>           if (can_reclaim_pt) {
>>>>>>>>>>               none_nr += count_pte_none(pte, nr);
>>>>>>>>>>               none_nr += nr_skip;
>>>>>>>>>>           }
>>>>>>>>>>
>>>>>>>>>> Right?
>>>>>>>>>
>>>>>>>>> Yes. I did not look closely at the patch that adds the counting of
>>>>>>>>
>>>>>>>> Got it.
>>>>>>>>
>>>>>>>>> pte_none though (to digest why it is required :) ).
>>>>>>>>
>>>>>>>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>>>>>>>> empty PTE page.
>>>>>>>
>>>>>>> Okay, so the problem is that "nr" would be "all processed 
>>>>>>> entries" but
>>>>>>> there are cases where we "process an entry but not zap it".
>>>>>>>
>>>>>>> What you really only want to know is "was any entry not zapped", 
>>>>>>> which
>>>>>>> could be a simple input boolean variable passed into 
>>>>>>> do_zap_pte_range?
>>>>>>>
>>>>>>> Because as soon as any entry was processed but  no zapped, you can
>>>>>>> immediately give up on reclaiming that table.
>>>>>>
>>>>>> Yes, we can set can_reclaim_pt to false when a !pte_none() entry is
>>>>>> found in count_pte_none().
>>>>>
>>>>> I'm not sure if well need cont_pte_none(), but I'll have to take a 
>>>>> look
>>>>> at your new patch to see how this fits together with doing the 
>>>>> pte_none
>>>>> detection+skipping in do_zap_pte_range().
>>>>>
>>>>> I was wondering if you cannot simply avoid the additional scanning and
>>>>> simply set "can_reclaim_pt" if you skip a zap.
>>>>
>>>> Maybe we can return the information whether the zap was skipped from
>>>> zap_present_ptes() and zap_nonpresent_ptes() through parameters like I
>>>> did in [PATCH v1 3/7] and [PATCH v1 4/7].
>>>>
>>>> In theory, we can detect empty PTE pages in the following two ways:
>>>>
>>>> 1) If no zap is skipped, it means that all pte entries have been
>>>>       zap, and the PTE page must be empty.
>>>> 2) If all pte entries are detected to be none, then the PTE page is
>>>>       empty.
>>>>
>>>> In the error case, 1) may cause non-empty PTE pages to be reclaimed
>>>> (which is unacceptable), while the 2) will at most cause empty PTE 
>>>> pages
>>>> to not be reclaimed.
>>>>
>>>> So the most reliable and efficient method may be:
>>>>
>>>> a. If there is a zap that is skipped, stop scanning and do not reclaim
>>>>       the PTE page;
>>>> b. Otherwise, as now, detect the empty PTE page through 
>>>> count_pte_none()
>>>
>>> Is there a need for count_pte_none() that I am missing?
>>
>> When any_skipped == false, at least add VM_BUG_ON() to recheck none ptes.
>>
>>>
>>> Assume we have
>>>
>>> nr = do_zap_pte_range(&any_skipped)
>>>
>>>
>>> If "nr" is the number of processed entries (including pte_none()), and
>>> "any_skipped" is set whenever we skipped to zap a !pte_none entry, we
>>> can detect what we need, no?
>>>
>>> If any_skipped == false after the call, we now have "nr" pte_none()
>>> entries. -> We can continue trying to reclaim
>>
>> I prefer that "nr" should not include pte_none().
>>
> 
> Why? do_zap_pte_range() should tell you how far to advance, nothing 
> less, nothing more.
> 
> Let's just keep it simple and avoid count_pte_none().
> 
> I'm probably missing something important?

As we discussed before, we should skip all consecutive none ptes,
pte and addr are already incremented before returning.

> 

