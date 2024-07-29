Return-Path: <linux-kernel+bounces-265367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF293F017
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EB12835F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAD113D2A9;
	Mon, 29 Jul 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7/f0v5C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36C139568
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242773; cv=none; b=pkRhVSjXjoQ3OfyFnL7+ZjsyZ3jPfs8dZhZ6j6sL96pIhzn17+knCxFl1XbFvbFKovwQMkF4FWdq0QcQRv5jmRu9v4j6ThT5FxVNzHj9uRjSR/0YTjWxAHkPsiU6bSu2i6O2gJDBq/C1IQKmoxpjPqJGr5TjolZpQ5wFzOsNlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242773; c=relaxed/simple;
	bh=7EK4sLtY0dYJYpllYc9kui3YVl1jm60Szua+ClrxDaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hN6lmOUaYf91G2kgBRw7AjEozh+JNg/kbNONOeRDHK80HhML+TDM8NOohMPRytmhetxIIPm+nyCt9sO6Vcn5Fz7atgvL24HDMrX0w9iFCfarUaSzUfaC1H/EpfOJU8ctRC507sPGJGjJTvHRtffK494TeQQKBXvL4OLx4tQgMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7/f0v5C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722242769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0ifQWfBHs6t7KS7Ak1LmP5TZ23Jo9weKXdgN7TggxwE=;
	b=F7/f0v5CA30CHK04DXysI9kVFBhwthFs85MIy4QC0eLwJLzNGT50fnnlC9yvTsVSsnWtyM
	znseElK1Qzr7zDKj3eQFRp8dYt0P5lS4f4mznwuNHKyZYOdneqd7jl/+nBwkg2GRvWx3QE
	fP+RgTfXkNIXcMa5sIww7McnJ3MMC6Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-uW4wVONiM_6pKNEFeIgCSQ-1; Mon, 29 Jul 2024 04:46:07 -0400
X-MC-Unique: uW4wVONiM_6pKNEFeIgCSQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef23d3650fso27879991fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722242766; x=1722847566;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ifQWfBHs6t7KS7Ak1LmP5TZ23Jo9weKXdgN7TggxwE=;
        b=TGduo3kdBlvc5yRnovo3VyVzHSxvDM4OBRvyZT04f3zKot0qMP2BI+zzTpeflX+veW
         NLskziRMtNP9WUnJ3FG1bpErs9LjCGAxYNAbzUPLiRwMHeOAavUhXL8y1mKmOScYgLev
         m5rGGaykxglM2dKwgDYJcqDU2NItP9iesh+lPveLY75tJ8iZgKCfbats6/yFxVsb6N6a
         KpxjKZWuOj8jEN9hMG2u3VOaCly750IE6gc8wYsRHdmNq60hgMRoPhf4edO2SbOwEVrP
         osnSsB6vCJofhSghDjMNEeAIoVnWBE4Sco3+a5kvwyrmu94Br4F8vBteTsKHJ2HfFhSG
         PpLg==
X-Gm-Message-State: AOJu0YyjjZQThg8VXfF/5w6zIo17vsYb7yaySjphBNSXZzRLj+9HM0Pa
	G0f+Nm2AS5PJA4Ta1I2aVw8yEEbOYqCkgmlgh61fKIcR79aUqUVZu2eACILi7mg0BxtLRCmTf04
	kU2MJDEQgLNM/0MwE2pmQGQMSynCfwRlYMYQgl4yR2+c8ch4vYOBLYWYJb/twLA==
X-Received: by 2002:a2e:9687:0:b0:2ef:23ec:9357 with SMTP id 38308e7fff4ca-2f12ea9b35bmr45827141fa.0.1722242765985;
        Mon, 29 Jul 2024 01:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0+IZB9F1sG+TJj4QyrgCiOx7W+G9a0+hnyqt5lrt3NPU2GhWKDajEmsDPufdR9dVBVeinQQ==
X-Received: by 2002:a2e:9687:0:b0:2ef:23ec:9357 with SMTP id 38308e7fff4ca-2f12ea9b35bmr45826931fa.0.1722242765409;
        Mon, 29 Jul 2024 01:46:05 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057b645dsm169395925e9.43.2024.07.29.01.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 01:46:05 -0700 (PDT)
Message-ID: <498c936f-fa30-4670-9bbc-4cd8b7995091@redhat.com>
Date: Mon, 29 Jul 2024 10:46:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com>
 <100ecc66-c2ce-4dbb-8600-d782e75ab69c@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <100ecc66-c2ce-4dbb-8600-d782e75ab69c@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.07.24 09:48, Qi Zheng wrote:
> 
> 
> On 2024/7/26 02:39, David Hildenbrand wrote:
>> pte_lockptr() is the only *_lockptr() function that doesn't consume
>> what would be expected: it consumes a pmd_t pointer instead of a pte_t
>> pointer.
>>
>> Let's change that. The two callers in pgtable-generic.c are easily
>> adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
>> pte_offset_map_nolock() to obtain the lock, even though we won't actually
>> be traversing the page table.
>>
>> This makes the code more similar to the other variants and avoids other
>> hacks to make the new pte_lockptr() version happy. pte_lockptr() users
>> reside now only in  pgtable-generic.c.
>>
>> Maybe, using pte_offset_map_nolock() is the right thing to do because
>> the PTE table could have been removed in the meantime? At least it sounds
>> more future proof if we ever have other means of page table reclaim.
> 
> Agree, this helps us recheck the pmd entry.
> 
>>
>> It's not quite clear if holding the PTE table lock is really required:
>> what if someone else obtains the lock just after we unlock it? But we'll
>> leave that as is for now, maybe there are good reasons.
>>
>> This is a preparation for adapting hugetlb page table locking logic to
>> take the same locks as core-mm page table walkers would.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    include/linux/mm.h   |  7 ++++---
>>    mm/khugepaged.c      | 21 +++++++++++++++------
>>    mm/pgtable-generic.c |  4 ++--
>>    3 files changed, 21 insertions(+), 11 deletions(-)
> 
> Since pte_lockptr() no longer has a pmd parameter, it is best to modify
> the comments above __pte_offset_map_lock() as well:
> 
> ```
> This helps the caller to avoid a later pte_lockptr(mm, *pmd), which
> might by that time act on a changed *pmd ...
> ```

Right, thanks a lot for the review!

The following on top;


 From a46b16aa9bfa02ffb425d364d7f00129a8e803ad Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 29 Jul 2024 10:43:34 +0200
Subject: [PATCH] fixup: mm: let pte_lockptr() consume a pte_t pointer

Let's adjust the comment, passing a pte to pte_lockptr() and dropping
a detail about changed *pmd, which no longer applies.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/pgtable-generic.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 13a7705df3f87..f17465b43d344 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -350,11 +350,11 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
   * pte_offset_map_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_map();
   * but when successful, it also outputs a pointer to the spinlock in ptlp - as
   * pte_offset_map_lock() does, but in this case without locking it.  This helps
- * the caller to avoid a later pte_lockptr(mm, *pmd), which might by that time
- * act on a changed *pmd: pte_offset_map_nolock() provides the correct spinlock
- * pointer for the page table that it returns.  In principle, the caller should
- * recheck *pmd once the lock is taken; in practice, no callsite needs that -
- * either the mmap_lock for write, or pte_same() check on contents, is enough.
+ * the caller to avoid a later pte_lockptr(mm, pte): pte_offset_map_nolock()
+ * provides the correct spinlock pointer for the page table that it returns.
+ * In principle, the caller should recheck *pmd once the lock is taken; in
+ * practice, no callsite needs that - either the mmap_lock for write, or
+ * pte_same() check on contents, is enough.
   *
   * Note that free_pgtables(), used after unmapping detached vmas, or when
   * exiting the whole mm, does not take page table lock before freeing a page
-- 
2.45.2


-- 
Cheers,

David / dhildenb


