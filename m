Return-Path: <linux-kernel+bounces-229601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E282917137
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84481F24165
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ACD17CA13;
	Tue, 25 Jun 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsF8XA+c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3871750
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344766; cv=none; b=CYpswhlLcNm1V2cDwM3WBtLJG70nqy2TzFICxI7jaMDPwDOs75WxypElwKjkEHtwAS5nI27yXMOIHWeMJppc3O3CfJjbJnIZ09njHrkHPqMf2xPQIcKjwihSnF9e3yt1DJTPux6Oj/P+C84JsySqoNbmjIfyWuYEcz6X0cDFeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344766; c=relaxed/simple;
	bh=VE1p5uOw87xdpQX+NEOWet6/RIIRacsXrFrQt/Dew3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iuvn1bQC7qhEjF7iYb6m6BotaNXfTV+WepuhYuftB1wXRm5YEFpW1LWcukVEdFRhHKvJaHtsEgIlsebQFxfw7N4YRSGj5skIJ+Wu98/FkXXUBUd5leQihVxETiF+0iP+IMILPpmy68ksAk9emkVbz0jM8SeJnXFG/tijJtIUZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsF8XA+c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719344764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x/ZIq6H41z+0KPANwshgUhICfWWXykTMzuw1eiwn7SM=;
	b=PsF8XA+cWhb+NBxyu6hvaZX1Cptvl/TMfEv+NmOQ+XrtT+3K+7NdRdwjWpbM7XXR1jm+nQ
	RQzOHNgtu7r8goULLRjFQ/f5pca3cRrPk0k3+9YmfKIQRl+RVlnQxg1+eeIEvHECc9X/dy
	D2cSgu5eOpdLtte2lNElrirFcMNNDSo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-WB7366QxPHSSw1U5lEq4AA-1; Tue, 25 Jun 2024 15:46:02 -0400
X-MC-Unique: WB7366QxPHSSw1U5lEq4AA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec72d14876so4335981fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719344761; x=1719949561;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x/ZIq6H41z+0KPANwshgUhICfWWXykTMzuw1eiwn7SM=;
        b=Nt/fHbnAA/WutlMV8UTAU7qvVLYYvfZy1WQ3YyoizubvLOoRoIBxiSkSSWxSH2Ypy2
         zZxjja1ssnBp9sbeyk9GaxwkZGmvDp8/5ayvHwgg1wwulW9Np5PErPssghqVRnXvarbi
         KhF/8iJp1EWER82/WPjL7Yl8EjWH/NfvpDqCjhdMD1pQo4DXgoAYTBmMYo6HjUuz2evT
         TPKK5qJMqF58/TaXWgS8gGl2/9RtcHI05yx3Ot42IeuzBejrfn3KDPPGDSe+Jc95DkAm
         oLLfRgTWhgvR8wigCpeWmKWaNJEDY9A1YqgI8O0y+XUZubOZ6l/eLMItXuQWI/9IAUXf
         xUrw==
X-Forwarded-Encrypted: i=1; AJvYcCUoUFqLTOAxjc6/VyakJwN5GNaKS/95rwBXWEyq0auzW3m6OBo2XOmI4gGUg5qf7a1mXVg8whSO1jIvc5Y/xRt731Q8wQU7W/wxj6ei
X-Gm-Message-State: AOJu0YyDKIvaHrnh6IM+DQ2focjDRZpXSM7/4YQxceooo7qy8Hf2JETy
	OJLlaWlFs52wCISLsYqxE8XIrWk2jyPc7kR83hBswkX3/wTg6d54OyJ25LgDBJRb81PH6eL66Kg
	YYEs5Sn69/iC6zMILyEyLE7gKVFkatQk6cMSieqZtcx79WAnoZScB+/ts/dvksg==
X-Received: by 2002:a05:651c:158:b0:2ec:55b5:ed51 with SMTP id 38308e7fff4ca-2ec5b269428mr48623011fa.9.1719344761152;
        Tue, 25 Jun 2024 12:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNMH2ZgxDMBcgc2gAa/xew7KQLMibjM4F7njBerSsoNVpXp3qRExeIx5lxvnfYGnM76UVg8w==
X-Received: by 2002:a05:651c:158:b0:2ec:55b5:ed51 with SMTP id 38308e7fff4ca-2ec5b269428mr48622831fa.9.1719344760659;
        Tue, 25 Jun 2024 12:46:00 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817b53f2sm189599165e9.25.2024.06.25.12.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 12:46:00 -0700 (PDT)
Message-ID: <9e8d71f4-69dc-4bf4-a40d-e1b89586f5c9@redhat.com>
Date: Tue, 25 Jun 2024 21:45:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable] mm: folio_add_new_anon_rmap() careful
 __folio_set_swapbacked()
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song
 <21cnbao@gmail.com>, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 ryan.roberts@arm.com, shy828301@gmail.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, ying.huang@intel.com,
 yosryahmed@google.com, yuanshuai@oppo.com, yuzhao@google.com
References: <f3599b1d-8323-0dc5-e9e0-fdb3cfc3dd5a@google.com>
 <0a41d5fc-d1a1-4b1b-873e-a701b20bbcb3@redhat.com>
 <f7c74073-f19a-0f59-3801-a20d319bc0ea@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f7c74073-f19a-0f59-3801-a20d319bc0ea@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.24 21:37, Hugh Dickins wrote:
> On Tue, 25 Jun 2024, David Hildenbrand wrote:
>> On 25.06.24 07:00, Hugh Dickins wrote:
>>> Commit "mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==
>>> false" has extended folio_add_new_anon_rmap() to use on non-exclusive
>>> folios, already visible to others in swap cache and on LRU.
>>>
>>> That renders its non-atomic __folio_set_swapbacked() unsafe: it risks
>>> overwriting concurrent atomic operations on folio->flags, losing bits
>>> added or restoring bits cleared.  Since it's only used in this risky
>>> way when folio_test_locked and !folio_test_anon, many such races are
>>> excluded; but, for example, isolations by folio_test_clear_lru() are
>>> vulnerable, and setting or clearing active.
>>>
>>> It could just use the atomic folio_set_swapbacked(); but this function
>>> does try to avoid atomics where it can, so use a branch instead: just
>>> avoid setting swapbacked when it is already set, that is good enough.
>>> (Swapbacked is normally stable once set: lazyfree can undo it, but
>>> only later, when found anon in a page table.)
>>>
>>> This fixes a lot of instability under compaction and swapping loads:
>>> assorted "Bad page"s, VM_BUG_ON_FOLIO()s, apparently even page double
>>> frees - though I've not worked out what races could lead to the latter.
>>>
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> ---
>>>    mm/rmap.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index df1a43295c85..5394c1178bf1 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1408,7 +1408,9 @@ void folio_add_new_anon_rmap(struct folio *folio,
>>> struct vm_area_struct *vma,
>>>     VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>>>     VM_BUG_ON_VMA(address < vma->vm_start ||
>>>    			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>> -	__folio_set_swapbacked(folio);
>>> +
>>> +	if (!folio_test_swapbacked(folio))
>>> +		__folio_set_swapbacked(folio);
>>>     __folio_set_anon(folio, vma, address, exclusive);
>>>    
>>>     if (likely(!folio_test_large(folio))) {
>>
>> LGTM.
>>
>> I'll point out that it's sufficient for a PFN walker to do a tryget + trylock
>> to cause trouble.
> 
> That surprises me.  I thought a racer's tryget was irrelevant (touching
> a different field) and its trylock not a problem, since "we" hold the
> folio lock throughout.  If my mental model is too naive there, please
> explain in more detail: we all need to understand this better.

Sorry, I was imprecise.

tryget+trylock should indeed not be a problem, tryget+lock would be, 
because IIRC folio_wait_bit_common()->folio_set_waiters() would be 
messing with folio flags.

-- 
Cheers,

David / dhildenb


