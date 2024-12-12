Return-Path: <linux-kernel+bounces-442949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB99EE47D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90BB282DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A6F211471;
	Thu, 12 Dec 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoMduw06"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9F20E304
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000577; cv=none; b=n/fn67EqXNorJCRwVIJcOsnxs1PP6KoqR0NOwVpkgIL7Oa1Ud5Z2h8XAvzjQPCQpE/U/QVrbndu0jxSFgZ5BUYQYwp8SddKNGIpYiPSzNPm+JLfit9pkD77KQqCTfQhPWw34kUhIQtAFapoDFjWGTyfVpaVjxZKlhzk67lJ1UOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000577; c=relaxed/simple;
	bh=O0N3obawDdBbcMWE8AIe/TIIJuZymxnHczua83xk2lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaK0PHCMXEV2dCEEloko2qNUF1mMFerFwB2RfO1vB8K+k8TMPOLehKIWdoUI/vvJImD15tk3jUdZXQtfA1tnF569PYAnkLiw7MmanUQtwORgcyI+yn6CZ8eHrojlLCX7c6JJcLUHLzDJEZfQCjpJsYbNz/HzupXzub5J8gp9KUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoMduw06; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734000574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tBK0KiQih3VvNAWtJI6EEduwucaQagiGQdGSnvn0CB4=;
	b=KoMduw06odZOCou9WDHQiy2tvOKgNVfQhr2ForE05i+0pba17Ck4S2SjVIHTVps0VIeivN
	cU1q4z8Qt2qPD0ezn0mI9iu5vnLX+9YD1hM4PMgXUu/Yumlw3LTS7aOjUv0I1NqlMk3aq0
	bBMAh83lzgygfJpW4PU3UU+PIYfIUac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-gC9ETqPWPmmFLcCYZR5t5g-1; Thu, 12 Dec 2024 05:49:32 -0500
X-MC-Unique: gC9ETqPWPmmFLcCYZR5t5g-1
X-Mimecast-MFC-AGG-ID: gC9ETqPWPmmFLcCYZR5t5g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so4158115e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734000571; x=1734605371;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tBK0KiQih3VvNAWtJI6EEduwucaQagiGQdGSnvn0CB4=;
        b=YifCSOYlAdeGzx7gZ4XuBUr9aARFkPc+zl9wIVOsTLFFW+9v5Eg99ys4ZP3Op3yOx8
         Xoz7F9E2bsecsfApYCfZOvyqH8dyRxq5IVr9CdyHYV0MFLZaAdUyS/hyDlVS6XdQP4vX
         wH9c+vgONzcQ4eUX7OO0H1f0TbHidPXm3g5hTkWZJD38/2cu4xiIxTEq5hF22IuXgRdZ
         VdbLBEXglVX5yiK9b0RmnOj2ou7DQWk021iM5rbh2AhuKN4ixGe92vu3W74wVUsd3BuD
         JCYcP5rw/63feC/Q2q77FM9MZguPqD11pcepPMRaotAeoH/90yhwXU/TerdqYZJCoVBG
         y6hA==
X-Forwarded-Encrypted: i=1; AJvYcCW/5sD8stprx/ecXvabJvJYvQL9LX1vbgUWgJuvGujI76iS4QjuG94DAcWu5JFM+HOaFH8ril7N65aUexw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJ2NI4a6liMcX+CgFgacGdpOLlO7xhKnC3RyaWsrskbrwMFm6
	C9F6DS3h4092YdXT3S/Sckxhl+mEWVHkMqMxRzHU+UrP3IWnfvt9rcQ9m7Mqdg00l2j/4wk4WNv
	sE7eOkcrpl1xXH5vpUOJBr06SItV1QRrO5RkvCwZsiSqVfEi7jAanwbv0Iq+sMw==
X-Gm-Gg: ASbGnctvpdmbIh/GnufAmaaie2jE+G5S1e1fm2HdFYKWXZU5GuI6iVT2YZKSJy2U1s6
	sYBgB7417prdZCMcRaccvUYvMT5eeJWcm3po5OM/FSnzVgwOSfz9xfQo5PMN4XqOM6SN/w9Cgfm
	5NrvqWhxsy1X0DU820CBB0eld8WKUP8wEbjdjHJfeDrsqW0pUJ4oq+x9E5fHGp7ZsZuROGndjzP
	8D9v4kv2NrDbi5zAe5pRecrxAQkqkfSU5+S3FAEHEq4sGCtTp9cCbip7RDtq3ve9GRDBDGd+9wz
	NYs1dFJzfOWZXCdPQQL/xD+w4gj7CrHofs7A79KHUnal0u3RhLLr+Q2lK9OOmU+X6OmOqYb6cGn
	nlKPSOwX8
X-Received: by 2002:a05:600c:350a:b0:434:a684:9b1 with SMTP id 5b1f17b1804b1-4361c344cb7mr52707265e9.4.1734000571422;
        Thu, 12 Dec 2024 02:49:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD2vMl0Xskj/iyiXKgwQeARtnq5a6JlZEEEJ/wyJ8aKHUA0XfSXg1M2CjnkQlhVdbLCUL1fg==
X-Received: by 2002:a05:600c:350a:b0:434:a684:9b1 with SMTP id 5b1f17b1804b1-4361c344cb7mr52706945e9.4.1734000571060;
        Thu, 12 Dec 2024 02:49:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c716:2b00:720b:42a1:ba95:a3db? (p200300cbc7162b00720b42a1ba95a3db.dip0.t-ipconnect.de. [2003:cb:c716:2b00:720b:42a1:ba95:a3db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256e063asm12609325e9.42.2024.12.12.02.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:49:29 -0800 (PST)
Message-ID: <b328da08-595f-4044-ad32-5ed9660a4d62@redhat.com>
Date: Thu, 12 Dec 2024 11:49:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, npache@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-5-usamaarif642@gmail.com>
 <e53b04ad-1827-43a2-a1ab-864c7efecf6e@redhat.com>
 <9d602b3f-878f-4f92-aade-f7fd7c1a626a@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9d602b3f-878f-4f92-aade-f7fd7c1a626a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.12.24 11:30, Usama Arif wrote:
> 
> 
> On 11/12/2024 18:03, David Hildenbrand wrote:
>> On 30.08.24 12:03, Usama Arif wrote:
>>> Currently folio->_deferred_list is used to keep track of
>>> partially_mapped folios that are going to be split under memory
>>> pressure. In the next patch, all THPs that are faulted in and collapsed
>>> by khugepaged are also going to be tracked using _deferred_list.
>>>
>>> This patch introduces a pageflag to be able to distinguish between
>>> partially mapped folios and others in the deferred_list at split time in
>>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
>>> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
>>> possible to distinguish between partially mapped folios and others in
>>> deferred_split_scan.
>>>
>>> Eventhough it introduces an extra flag to track if the folio is
>>> partially mapped, there is no functional change intended with this
>>> patch and the flag is not useful in this patch itself, it will
>>> become useful in the next patch when _deferred_list has non partially
>>> mapped folios.
>>>
>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>> ---
>>>    include/linux/huge_mm.h    |  4 ++--
>>>    include/linux/page-flags.h | 13 +++++++++++-
>>>    mm/huge_memory.c           | 41 ++++++++++++++++++++++++++++----------
>>>    mm/memcontrol.c            |  3 ++-
>>>    mm/migrate.c               |  3 ++-
>>>    mm/page_alloc.c            |  5 +++--
>>>    mm/rmap.c                  |  5 +++--
>>>    mm/vmscan.c                |  3 ++-
>>>    8 files changed, 56 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 4da102b74a8c..0b0539f4ee1a 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -333,7 +333,7 @@ static inline int split_huge_page(struct page *page)
>>>    {
>>>        return split_huge_page_to_list_to_order(page, NULL, 0);
>>>    }
>>> -void deferred_split_folio(struct folio *folio);
>>> +void deferred_split_folio(struct folio *folio, bool partially_mapped);
>>>      void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>>            unsigned long address, bool freeze, struct folio *folio);
>>> @@ -502,7 +502,7 @@ static inline int split_huge_page(struct page *page)
>>>    {
>>>        return 0;
>>>    }
>>> -static inline void deferred_split_folio(struct folio *folio) {}
>>> +static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>>>    #define split_huge_pmd(__vma, __pmd, __address)    \
>>>        do { } while (0)
>>>    diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>> index 2175ebceb41c..1b3a76710487 100644
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -186,6 +186,7 @@ enum pageflags {
>>>        /* At least one page in this folio has the hwpoison flag set */
>>>        PG_has_hwpoisoned = PG_active,
>>>        PG_large_rmappable = PG_workingset, /* anon or file-backed */
>>> +    PG_partially_mapped = PG_reclaim, /* was identified to be partially mapped */
>>>    };
>>>      #define PAGEFLAGS_MASK        ((1UL << NR_PAGEFLAGS) - 1)
>>> @@ -859,8 +860,18 @@ static inline void ClearPageCompound(struct page *page)
>>>        ClearPageHead(page);
>>>    }
>>>    FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
>>> +FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>>> +/*
>>> + * PG_partially_mapped is protected by deferred_split split_queue_lock,
>>> + * so its safe to use non-atomic set/clear.
>>
>> Just stumbled over that. In my understanding, this assumption is wrong.
>>
>> I don't think anything prevents other PF_ANY (PG_anon_exclusive, PG_PG_hwpoison) / PF_SECOND (PF_has_hwpoisoned) flags from getting modified concurrently I'm afraid.
>>
> Hi David,
> 
> Just to clear my understanding, what you are suggesting could happen in __folio_set/clear_partially_mapped is:
> 1) __folio_set/clear_partially_mapped reads the 2nd page flags (x) where one of the other 2nd page flags is lets say not set.
> 2) One of the other 2nd page flags are set atomically.
> 3) __folio_set/clear_partially_mapped writes x + changes to partially_mapped. However, the change in step 2 to one of the other 2nd page flag is lost.
> 
> Is that correct?

That matches my understanding.

But that would mean we shouldn't have any page flags (first or second 
page) as non atomic?

Yes. We may only use non-atomic variants as long as we can guarantee 
that nobody can concurrently operate on the flags, for example on the 
early folio allocation path or on the folio freeing path.

Observe how the other SECOND users are atomic, PG_anon_exclusive is 
atomic (except on two page freeing paths) and PF_hwpoison is atomic.


> although it would depend if they are being
> changed at the same time point. If you encountered a particular instance of PG_anon_exclusive or PF_has_hwpoisoned being changed at the same point as
> __folio_set/clear_partially_mapped, could you point to it?

Regarding PG_hwpoison, observe how memory_failure() performs the 
TestSetPageHWPoison() + folio_set_has_hwpoisoned() before unmapping the 
pages, without any locking. This can race with pretty much any operation 
that triggers unmapping.

With PG_anon_exclusive it's a bit more complicated, but it's probably 
sufficient if MADV_DONTNEED (setting deferred) races with concurrent 
swapout/mgration (clearing PG_anon_exclusive), whereby both operations 
are not performed under the same PT lock. This can happen after partial 
mremap(), or after fork() when only parts of the large folio were shared 
with the child.

-- 
Cheers,

David / dhildenb


