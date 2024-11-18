Return-Path: <linux-kernel+bounces-412759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08839D0F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A75B316DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D91195F28;
	Mon, 18 Nov 2024 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X3Sl0RGP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C0194C8D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926087; cv=none; b=e4sFIVeW4VDi1N2iXncfc/AVQt0hWoQdBFAjvnzQzBNhgogwt461NJVhFUqF5gSApyS96s3nZY79hKKyA3I/EocooTF0vCjuDq9cFQ/madSReM2mVHmM32R9qVpcWLWCp5WNh25vAHkoy/9zzwRF2sc7WFOUYgZwpu4zzu5Row8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926087; c=relaxed/simple;
	bh=8hRNBjSZxlkJYdmRNlYz2jkmTfXS9COPoeUE5t6WgfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS9IDC5WYtHiiKrAAQqHdWxj3sEtKaUKyJG8e+9uJREB9XcuGXAD8JAPpW1E8rn2l6dq7gzza0nApHqGXy/RmKi9hMcXk4QEGqpIjA+VqhBm40n/5suVSrAXUG3WVd6NRxtW2LSauGKHmOS+73zLbz1BJaS2y9OOTJh/pEOvmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X3Sl0RGP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7246c8b89b4so2631240b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731926085; x=1732530885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7NJZpL44XrHkZSOw9e4NN537XnAGj8dyCP7vgNWoao=;
        b=X3Sl0RGPG/Q4A+A4HZWslbJj4oLt2RflR6JHpiffsjouObTtTKwt8tprpBslEtVr70
         ReaDAYkCZFnskmucQc4wgo6FPQ/TI0tTCGlp4FeC+0Xd2Vl3H7PeTNKzDg/8gbfx7GYu
         qKRlPihD2cNXbRV4ypUN/VOFm75P9mkX3KQOK5natCefO4ukSDCNb+pvTrs6gn05nwso
         WjcQp1WDdjz7jy/pcNg+i0+HNtXS/RgbFbqjTVbT/2I5Jjjil0iPhuCc0BOBK8HwMvAD
         WFWNB1AKkVTz646ZNhSGFlZ3r5EBAgek8z2nMW3R4gS6Ueyd2mefV1iMZfmO0uK7wvJa
         /ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926085; x=1732530885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7NJZpL44XrHkZSOw9e4NN537XnAGj8dyCP7vgNWoao=;
        b=kBk1883QqIs68JdhYMTjUMUWgSal0Kz779vwRfn7V6NhwOZlqAs+Od6Os4DOW3y/Xm
         POAqMiawM/C9tiTdbD7zjAHJB5pGlSQVhtsSonkh3b+zok5x9EmGWIFE71BfKQM8fb7l
         rf4XoTWzRFDjeDSqnvi7rQR5QmX6T/UOTrhPv4NDyAAIcuaAlZHFTMTHyCkZdU4cWYjT
         rd6h4fJomi9yRwpLPouwvJztjo0cTG1EuA74p8WQi7vng88Zzg1c0orezwJWnv+0SCNW
         Qiyq8jVj7KPr++4vWcUDpC5JmFv1ZuOCtylUbg8rTPAqqL7srSAzwuyeuZOVIpeYOqTc
         xdVg==
X-Forwarded-Encrypted: i=1; AJvYcCUJe7liOzeTq2SAJ+Eg8FM99qIFCY44BuRDZ1p7Ao133ombUWbnbjzyFCTLTBG/yNCJ5A3xyCFZiYm3D1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbhWF3+9YUzVKF/7nbIFc/AnHh41SrwrzQkcoMs0CzuJJUZhz
	XOg8igXpOEktrxFSwZcccdVyWZwy7EZZ3mAQJYZ4wDHAJe3CTXMNc/iY9P5p5jQ=
X-Google-Smtp-Source: AGHT+IE165UDd+h18HvNTIyftKKGivChWKJqvr5wgEJincZc7sMTuaJPkw2TegD+dAqUcLpJhMYIFw==
X-Received: by 2002:a05:6a00:179e:b0:724:6c21:f0c with SMTP id d2e1a72fcca58-72475fbc463mr19968229b3a.4.1731926085331;
        Mon, 18 Nov 2024 02:34:45 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770f9d0asm6075778b3a.26.2024.11.18.02.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:34:44 -0800 (PST)
Message-ID: <f3adf382-d252-4007-b8ca-c557814cb5c8@bytedance.com>
Date: Mon, 18 Nov 2024 18:34:36 +0800
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
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <995804f4-b658-44b2-bb40-c84b8a322616@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/18 17:29, David Hildenbrand wrote:
> On 18.11.24 04:35, Qi Zheng wrote:
>>
>>
>> On 2024/11/15 22:59, David Hildenbrand wrote:
>>> On 15.11.24 15:41, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2024/11/15 18:22, David Hildenbrand wrote:
>>>>>>>> *nr_skip = nr;
>>>>>>>>
>>>>>>>> and then:
>>>>>>>>
>>>>>>>> zap_pte_range
>>>>>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
>>>>>>>> &skip_nr,
>>>>>>>>                             rss, &force_flush, &force_break);
>>>>>>>>          if (can_reclaim_pt) {
>>>>>>>>              none_nr += count_pte_none(pte, nr);
>>>>>>>>              none_nr += nr_skip;
>>>>>>>>          }
>>>>>>>>
>>>>>>>> Right?
>>>>>>>
>>>>>>> Yes. I did not look closely at the patch that adds the counting of
>>>>>>
>>>>>> Got it.
>>>>>>
>>>>>>> pte_none though (to digest why it is required :) ).
>>>>>>
>>>>>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>>>>>> empty PTE page.
>>>>>
>>>>> Okay, so the problem is that "nr" would be "all processed entries" but
>>>>> there are cases where we "process an entry but not zap it".
>>>>>
>>>>> What you really only want to know is "was any entry not zapped", which
>>>>> could be a simple input boolean variable passed into do_zap_pte_range?
>>>>>
>>>>> Because as soon as any entry was processed but  no zapped, you can
>>>>> immediately give up on reclaiming that table.
>>>>
>>>> Yes, we can set can_reclaim_pt to false when a !pte_none() entry is
>>>> found in count_pte_none().
>>>
>>> I'm not sure if well need cont_pte_none(), but I'll have to take a look
>>> at your new patch to see how this fits together with doing the pte_none
>>> detection+skipping in do_zap_pte_range().
>>>
>>> I was wondering if you cannot simply avoid the additional scanning and
>>> simply set "can_reclaim_pt" if you skip a zap.
>>
>> Maybe we can return the information whether the zap was skipped from
>> zap_present_ptes() and zap_nonpresent_ptes() through parameters like I
>> did in [PATCH v1 3/7] and [PATCH v1 4/7].
>>
>> In theory, we can detect empty PTE pages in the following two ways:
>>
>> 1) If no zap is skipped, it means that all pte entries have been
>>      zap, and the PTE page must be empty.
>> 2) If all pte entries are detected to be none, then the PTE page is
>>      empty.
>>
>> In the error case, 1) may cause non-empty PTE pages to be reclaimed
>> (which is unacceptable), while the 2) will at most cause empty PTE pages
>> to not be reclaimed.
>>
>> So the most reliable and efficient method may be:
>>
>> a. If there is a zap that is skipped, stop scanning and do not reclaim
>>      the PTE page;
>> b. Otherwise, as now, detect the empty PTE page through count_pte_none()
> 
> Is there a need for count_pte_none() that I am missing?

When any_skipped == false, at least add VM_BUG_ON() to recheck none ptes.

> 
> Assume we have
> 
> nr = do_zap_pte_range(&any_skipped)
> 
> 
> If "nr" is the number of processed entries (including pte_none()), and
> "any_skipped" is set whenever we skipped to zap a !pte_none entry, we 
> can detect what we need, no?
> 
> If any_skipped == false after the call, we now have "nr" pte_none() 
> entries. -> We can continue trying to reclaim

I prefer that "nr" should not include pte_none().

Something like this:

nr = do_zap_pte_range(&any_skipped);
if (can_reclaim_pt) {
	VM_BUG_ON(!any_skipped && count_pte_none(nr) == nr);
	if (any_skipped)
		can_reclaim_pt = false;
}

nr: the number of processed entries (excluding pte_none())
any_skipped: set whenever we skipped to zap a !pte_none entry


```
do_zap_pte_range
-->     pte_t ptent = ptep_get(pte);
	int max_nr = (end - addr) / PAGE_SIZE;

	/* Skip all consecutive pte_none(). */
	if (pte_none(ptent)) {
		int nr;

		for (nr = 1; nr < max_nr; nr++) {
			ptent = ptep_get(pte + nr);
			if (!pte_none(ptent))
				break;
		}
		max_nr -= nr;
		if (!max_nr)
			return 0;
		pte += nr;
		addr += nr * PAGE_SIZE;
	}

	if (pte_present(ptent))
		return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
					addr, details, rss, force_flush,
					force_break, any_skipped);

	return zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
					 details, rss, any_skipped);
```

> 
> If any_skipped == true, we have at least one !pte_none() entry among the 
> "nr" entries. -> We cannot and must not reclaim.

> 

