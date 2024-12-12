Return-Path: <linux-kernel+bounces-442927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52C89EE41E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F1A1640F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3394210190;
	Thu, 12 Dec 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcs51MSK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41B211268;
	Thu, 12 Dec 2024 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999416; cv=none; b=syrAi6KkA0ZRkaRIUIvPTjPG2rAHzPcYlTXFVUeF6595Pw9HhSQYEwy3hGiy8ctaz87NuXuRwetVe2i7Tk/vLQ50xsPuzCbIs6HpxhRodRS9yG5Tcv1YT3NXtgVWPSjBpFU9mkydHmRV7as2Iekn9mlvowrZ5nkcd54gXRqIu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999416; c=relaxed/simple;
	bh=Ouz85y7VJUQ/6A4vqNYaJ0A1bE03s9sF2ed0Hl/NBhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhxayaX2EqyEhIYZZGUczSnQPzp7PZ5ZIGS2kEs5YSNmldiqftetdtYRLytXzaXj4bMuClQodYWiE0ExNu1U85HDxfQIqkTlIou6tpc/aje0eT4lO3t7ZYARUvlA2DrD2waHIUBx5BsDOT4+YEIXMxPaWQ1OVlTA7dPBngrl1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcs51MSK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43618283dedso3933875e9.3;
        Thu, 12 Dec 2024 02:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733999412; x=1734604212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bg1k7318njybk9wkbNIQBx/yMTbq3YWKaT1a6X4wNM=;
        b=kcs51MSKIYNsPPu2rQ7jsMAO+xS8aH8YgryZZ6BFAreyfnzwSXzlFU4ByJKUChlrzi
         XLhqCF9+u8a1Xj6bPXvzJkFWF0THUnc6mMLjvCfMb1J4DKLD8xrqd0R+LT76WXe2XDeL
         1uGGNnXHx6UBP1/3dg4pjIAS3fb2d0HFYqSQ24FQsI7+9BFr9ATonL6W6DfcRuQT6fmm
         qRDAOtflevHi5qh4gZfwgbrWIrqrmkF3B0j771gCTY36sQEF27wM2M18VmA/kjXYQf9N
         wagy6Qi8Kmz6tE1+5t1wkhU/cAS9n0WBGVH847IOZMplZqyJ8Y9ECgor+O65mLM64DpQ
         EeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999412; x=1734604212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bg1k7318njybk9wkbNIQBx/yMTbq3YWKaT1a6X4wNM=;
        b=MVMU8ZTQf3CpewYgZzW5UJAn0gNurg+TePFOcHJmRWL/vYX1Dlv+FgVdHKK+X06GEI
         2ULhG2aIxdsrFpM13JDEj4NA0dlUX0RWe9qz8y1MrPHpbAjXMD2g/TIpguLbz0HMeqKZ
         5Tek2RR8XGbdlZwNh2O33O/k823Y94WFLgPggK7uvxZF+HFZxLuMYZphFHGehtkfGgJ1
         xOJjH8Q1tf9ZfwLmwAK1kCIUF0A5d8PjXtx4q45ll9048gpSgHsW8yQI1oe5rOFNp3Es
         46vneezqGj0N6pYFiKsTdEsY3gGIXUhXsxuI4F6bvaRrJy7kpM8Y39F1XxPlXfg3W6v6
         p0rA==
X-Forwarded-Encrypted: i=1; AJvYcCUWQ7c83LHKYsFAiDZnPDW9A7iHtDh/tqKzBYLiArOUbtpcGM/4fN5ex2UiAkuFQIs9oEzBIasbBsQVTCe5@vger.kernel.org, AJvYcCVxTKIMBBwZkAsZIlTn/x5vrEu7nD3dzZkOafgGwqL/ewPvKtTsfZJWusaCPQkpYbDa2lFoavYV5cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0XLN75mByt6Oid681nuy58eodROioewLlBGNV2++kb5cFcGR
	8NY7nHSUL2SLVoMARciWoB0oIZAmrh6o5Fm8D/+kP1Ao4ZADiYxu
X-Gm-Gg: ASbGncvMU5u3fUzIMeF+mjejCyL7LaZGLtgFwW8tDP/UT2c+/SpiRsniU3LBZDhgmzx
	MVfwC+s2aXG1KMX0wVvmZnxVWT3uwAQ5GFpuz80z1q7mAa47Fu0hTQrxW0+0wB++Am0wv3bcqKS
	q2Gg8smeJb/P8vdXq2tUV0+yPrkC0PP/zUqB8JFqBL5m3Mf63adKWG9MIpVBRJ2wzxbjZJ2bAgu
	36g0Wcd4uhtHrvqzOz+3QganGjMGBcL3/Cd+V96tlMuWB3nOPVz41obIWmkILWf43KkTLUfivdM
	yFlb3t7m008SGW4qx8Lweo4m/6cHbXrSO7p9apLcw3rcmbZVsA==
X-Google-Smtp-Source: AGHT+IEcWEgMPQkMvNLXcAO412zDfJYROlpv6v4QcXzBxDdKts3WRT/cTmsIt9VGSf0kgFFpJofa9g==
X-Received: by 2002:a5d:47a1:0:b0:385:fac7:89b9 with SMTP id ffacd0b85a97d-387877c8fedmr1938481f8f.59.1733999412253;
        Thu, 12 Dec 2024 02:30:12 -0800 (PST)
Received: from ?IPV6:2001:16a2:c8d4:e00:19:eba3:f7f0:1457? ([2001:16a2:c8d4:e00:19:eba3:f7f0:1457])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f533sm3684526f8f.3.2024.12.12.02.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:30:11 -0800 (PST)
Message-ID: <9d602b3f-878f-4f92-aade-f7fd7c1a626a@gmail.com>
Date: Thu, 12 Dec 2024 13:30:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <e53b04ad-1827-43a2-a1ab-864c7efecf6e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/12/2024 18:03, David Hildenbrand wrote:
> On 30.08.24 12:03, Usama Arif wrote:
>> Currently folio->_deferred_list is used to keep track of
>> partially_mapped folios that are going to be split under memory
>> pressure. In the next patch, all THPs that are faulted in and collapsed
>> by khugepaged are also going to be tracked using _deferred_list.
>>
>> This patch introduces a pageflag to be able to distinguish between
>> partially mapped folios and others in the deferred_list at split time in
>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
>> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
>> possible to distinguish between partially mapped folios and others in
>> deferred_split_scan.
>>
>> Eventhough it introduces an extra flag to track if the folio is
>> partially mapped, there is no functional change intended with this
>> patch and the flag is not useful in this patch itself, it will
>> become useful in the next patch when _deferred_list has non partially
>> mapped folios.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   include/linux/huge_mm.h    |  4 ++--
>>   include/linux/page-flags.h | 13 +++++++++++-
>>   mm/huge_memory.c           | 41 ++++++++++++++++++++++++++++----------
>>   mm/memcontrol.c            |  3 ++-
>>   mm/migrate.c               |  3 ++-
>>   mm/page_alloc.c            |  5 +++--
>>   mm/rmap.c                  |  5 +++--
>>   mm/vmscan.c                |  3 ++-
>>   8 files changed, 56 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 4da102b74a8c..0b0539f4ee1a 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -333,7 +333,7 @@ static inline int split_huge_page(struct page *page)
>>   {
>>       return split_huge_page_to_list_to_order(page, NULL, 0);
>>   }
>> -void deferred_split_folio(struct folio *folio);
>> +void deferred_split_folio(struct folio *folio, bool partially_mapped);
>>     void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>           unsigned long address, bool freeze, struct folio *folio);
>> @@ -502,7 +502,7 @@ static inline int split_huge_page(struct page *page)
>>   {
>>       return 0;
>>   }
>> -static inline void deferred_split_folio(struct folio *folio) {}
>> +static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>>   #define split_huge_pmd(__vma, __pmd, __address)    \
>>       do { } while (0)
>>   diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 2175ebceb41c..1b3a76710487 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -186,6 +186,7 @@ enum pageflags {
>>       /* At least one page in this folio has the hwpoison flag set */
>>       PG_has_hwpoisoned = PG_active,
>>       PG_large_rmappable = PG_workingset, /* anon or file-backed */
>> +    PG_partially_mapped = PG_reclaim, /* was identified to be partially mapped */
>>   };
>>     #define PAGEFLAGS_MASK        ((1UL << NR_PAGEFLAGS) - 1)
>> @@ -859,8 +860,18 @@ static inline void ClearPageCompound(struct page *page)
>>       ClearPageHead(page);
>>   }
>>   FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
>> +FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>> +/*
>> + * PG_partially_mapped is protected by deferred_split split_queue_lock,
>> + * so its safe to use non-atomic set/clear.
> 
> Just stumbled over that. In my understanding, this assumption is wrong.
> 
> I don't think anything prevents other PF_ANY (PG_anon_exclusive, PG_PG_hwpoison) / PF_SECOND (PF_has_hwpoisoned) flags from getting modified concurrently I'm afraid.
> 
Hi David,

Just to clear my understanding, what you are suggesting could happen in __folio_set/clear_partially_mapped is:
1) __folio_set/clear_partially_mapped reads the 2nd page flags (x) where one of the other 2nd page flags is lets say not set.
2) One of the other 2nd page flags are set atomically.
3) __folio_set/clear_partially_mapped writes x + changes to partially_mapped. However, the change in step 2 to one of the other 2nd page flag is lost.

Is that correct? But that would mean we shouldn't have any page flags (first or second page) as non atomic? although it would depend if they are being
changed at the same time point. If you encountered a particular instance of PG_anon_exclusive or PF_has_hwpoisoned being changed at the same point as
__folio_set/clear_partially_mapped, could you point to it?

I am happy to send a fix to change all set/clear_partially_mapped to atomic, but just want to understand this better.

Thanks!
Usama


