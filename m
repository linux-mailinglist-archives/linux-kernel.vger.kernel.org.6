Return-Path: <linux-kernel+bounces-200425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2FD8FAFDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7BF283BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9651414375E;
	Tue,  4 Jun 2024 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF4zU6tr"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D12566
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497094; cv=none; b=frmBwSKCxnVcmomSwFtthxULgfAbWzCm1EwRqVg3jIDO7tt7d6lG9MSmJKeoIVRYMuR7Psr4MWo7MNZ7+vS7PKOH8cjp/0p+rFVdvdIETs+gEYYzNk4rMQSqB7d7Gaxyp1QNWCIPz7a0tre3ULZGu//odxiFIDQcgKZCt7oB9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497094; c=relaxed/simple;
	bh=4ZFWuLkfEROoObxLLtyIJt4y9uveIxyQ0SP67J622Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lq9D0kcuNWPwsxuqZH0h17QJps93RNNJn0B6B65vPfYcGcpf9OhdeIYWrmQguqnMUfPjrXPoXqRRUVLMuWq8UuTVYL7TrVgXv0hfbW1bd9tNV107xrdiiGu2mb5mZt2H7HI+U+GHkp7AV3s3OvGLdcllEEJOuKIw9UfhH5CGn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF4zU6tr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f62a628b4cso34816725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717497093; x=1718101893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhic3HtJ2UNaR17Z3aku+b+QmxLzUCgN7xFJkw5yb18=;
        b=LF4zU6trdlrZ8ubRZkIPWAU8kKEcUUgQBG8QcpYk0iuKbSJDZoZW3BXHfved0635TH
         0cYhdBXUd/YqHT4GDQIYmvIRFEX8cWEUZrszI0UMcleVqySPX60k9V1sUt71GW8kFJjm
         j3RbmNbGXkNvWtJmwQ3BzpgA3j4Gp0rGLKiiZULJ6a9nH45YC9oA9UreFBlyVep1yKVW
         VSLdc8vYgLni4gw1yMK00Dw5eNBVFgLAMtxV3HLRzV+5yMUkTEoooVEu4kD0GGp/UW/n
         JtF/j5Jss5tTOTEIl1VJW204cHyitC3nW95GIAn+6iQ0Z1UrBXFzxc9miOmlW4D7m3qb
         jfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717497093; x=1718101893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhic3HtJ2UNaR17Z3aku+b+QmxLzUCgN7xFJkw5yb18=;
        b=WMUqj154JQ0wEhEvndl00M0rqx+ZkKoWQqCMbj8CJv4tCox6A76jV098OZFlNoQtt7
         M/kgc8rIQy+ca0zD4T5wm3Kb06cnFG09xan/yk/FthlEeoGoNfPEPQu1KxfAxtYnJvgw
         k0LcrNpLcJiN9fWmyWf1vJPvtuPgCzFw792uqcpXiUtPd+2ObvQMnxi+hT5pXW1ZfIrd
         tHuaPSprhVLMuC6ne0XUU3VffMpFj2nk0XglFac3SBw63JAZNaHvtFaE8971Z86Bv58B
         plVM2KQWS/KjAQFm0VhXFQnBohjQpTqkc1+NQK9YBl7uTTL963/QcuksPNONsvUw8M7/
         h0RA==
X-Forwarded-Encrypted: i=1; AJvYcCXAJEUue1fehsRAqbTBKUeKi7R4/miNxvj2uEeRfH124nbABYpZ/VgDvSygEJq3O0cisvmpnHCQaypqdUd2V3OOu3OyzA0xLWWQpfWv
X-Gm-Message-State: AOJu0Yxwr6+/f3yz9OZcQlg3LvpCJ65atw/bkAR1wPYoymbH3F7O2F8v
	mZJBd4t8RVqFSOzEBW2Cu5IzGVFmuoncrxA99nWN4N6WoMLctgOa
X-Google-Smtp-Source: AGHT+IEyEF2qx6KiB7jfx5Q2Rcfo98TYnuL8yFs5VQUtlZ85ugMPbdQUWHYLqlOH+Df8DgPE2WtXwA==
X-Received: by 2002:a17:903:32cf:b0:1e4:9c2f:d343 with SMTP id d9443c01a7336-1f636fe87b4mr125241805ad.7.1717497092662;
        Tue, 04 Jun 2024 03:31:32 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63237ae1dsm80754145ad.119.2024.06.04.03.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 03:31:32 -0700 (PDT)
Message-ID: <b3e242b5-c589-47fd-9a02-1e488bed9d15@gmail.com>
Date: Tue, 4 Jun 2024 18:31:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
 <8d3a60d5-06c5-4df4-aeda-2fbec45a8ae0@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <8d3a60d5-06c5-4df4-aeda-2fbec45a8ae0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/24 4:12 PM, David Hildenbrand wrote:
> On 04.06.24 06:24, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> When a folio isn't fit for KSM, the subpages are unlikely to be good,
>> So let's skip the rest page checking to save some actions.
>>
>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>> ---
>>   mm/ksm.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 97e5b41f8c4b..e2fdb9dd98e2 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -2644,6 +2644,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>           goto no_vmas;
>>         for_each_vma(vmi, vma) {
>> +        int nr = 1;
>> +
>>           if (!(vma->vm_flags & VM_MERGEABLE))
>>               continue;
>>           if (ksm_scan.address < vma->vm_start)
>> @@ -2660,6 +2662,9 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>                   cond_resched();
>>                   continue;
>>               }
>> +
>> +            VM_WARN_ON(PageTail(*page));
>> +            nr = compound_nr(*page);
>>               if (is_zone_device_page(*page))
>>                   goto next_page;
>>               if (PageAnon(*page)) {
>> @@ -2672,7 +2677,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>                       if (should_skip_rmap_item(*page, rmap_item))
>>                           goto next_page;
>>   -                    ksm_scan.address += PAGE_SIZE;
>> +                    ksm_scan.address += nr * PAGE_SIZE;
>>                   } else
>>                       put_page(*page);
>>                   mmap_read_unlock(mm);
>> @@ -2680,7 +2685,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>               }
>>   next_page:
>>               put_page(*page);
>> -            ksm_scan.address += PAGE_SIZE;
>> +            ksm_scan.address += nr * PAGE_SIZE;
>>               cond_resched();
>>           }
>>       }
> 
> You might be jumping over pages that don't belong to that folio. What you would actually want to do is somehow use folio_pte_batch() to really know the PTEs point at the same folio, so you can skip them. But that's not that easy when using follow_page() ...
> 
> So I suggest dropping this change for now.
> 

Hi David,

Forgive my stupidity, where I jump over normal page that not to belong to the folio?

Thanks
Alex

