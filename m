Return-Path: <linux-kernel+bounces-224076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA18E911CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474AEB25D55
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40916D322;
	Fri, 21 Jun 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxlRLtlN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CAD16D31E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955185; cv=none; b=FsLpib50qZiBN104MqzYTFJWEaJrBGh8JfCTGYEkl99D00SkdXA2BLAkUDJQST+E+h9MI6ozZI2WhGFl6YeFhlZ9FNqcq7WlwYB0S+7+Th5WE/U3FBkWL+aY8AYg9QS5F2VGKY28Qc+redH6adVXdVzK7BDZax05wCwjmOGR0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955185; c=relaxed/simple;
	bh=Va6v3YEpzUmPvw+ReyEn5zElKOToXBS/1Iwyr8pwvpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejXKnCPvtQ7JwkdVmd8STyJ/zckpopuXwv3ingwtcfG+dEgQHgfLu6rCQ9UuB6O7ukb0TZmTYJYrBi8ziC8NQTbw4edp+R50BSA2Diq9B9I/vXXI8yQ9B7UNBrYPCpQB5kyTCpYpg9lK9YIYtR/E73JX3CJUcaDT70QgYvPMYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxlRLtlN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718955182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bqd2pgnOZP6fdE4BQRa2Va/7Qsx+b1mw8cKvo7/G0Rg=;
	b=XxlRLtlNxlHrEdEDd+i2MQczaEGOBSsdQnD8ZLvqtv6+Xya3kAmCbCJcfQnJILh0er1Lll
	CJQJLPhj/RIPkcXJYpZzN/Ya65oQt3xo99fMQ+/B0GiLajXgqfB8VTcL29O80q/z0ZOUxi
	Hzb6y/UewTyaroLaatASIALx6UTZZ8o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-nCNfm5OTNtuv1DzybWO7Sw-1; Fri, 21 Jun 2024 03:33:00 -0400
X-MC-Unique: nCNfm5OTNtuv1DzybWO7Sw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4217b3d2044so15821155e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955179; x=1719559979;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bqd2pgnOZP6fdE4BQRa2Va/7Qsx+b1mw8cKvo7/G0Rg=;
        b=Fk8EAVtSSh07crSArU/cVcBZsxn4EXtKPPJBoGeYsH+3wyCV5VcsGUYi03t3jmGTV1
         FkfwnLxUK8Dg0++mOqAnmpX2ffgYs82PWviKHUEZpZroaHSOAp4uHKHTIR+2eaKpu7Hc
         mP6/+kYYCm0CwjFIIKBxF+xDqUVnpcnJCYRxNIvETptkJoJf1LZHm85eCxjKSdV2RebB
         lYPEzP6+CP4L7AG9ipFlGgTdeNvMcbxp57yn0op96VEPkvZ1Jmv1aQgu/jcP7hotWT+Y
         pu99OTFld2/P61SpKkiSPV7yMwqoC8xvnlngW0xgVwvxn2W45xFTydx9LfUC3BNuub48
         H4JQ==
X-Gm-Message-State: AOJu0YxRMTl/ceK2qDvlEpuQYGRR+peZ5HcxKdnE2cd06RyU8MGAgoak
	LaHOB60dKtnZGQt/D8PwWbnJT4sJf/lC5eVFV8szDO5Bv/8EcMuzDt0imuO9Weqf76oTqrUJBD0
	judW55Oi2pwUu/Jh0//0b7OhNtx3pf69i5kzlqdykh5LGtDRqXkKCPDd/K8DWtwdHhiMR2g==
X-Received: by 2002:adf:fd08:0:b0:362:4d2a:7bea with SMTP id ffacd0b85a97d-3631998f66fmr5462828f8f.62.1718955179289;
        Fri, 21 Jun 2024 00:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEprnZY7FnMxYF076ylYvUMCQtBhU6btjzD9tXYDUwp7sAA8hBINMtavaNjLa6GVaXRTEUeBw==
X-Received: by 2002:adf:fd08:0:b0:362:4d2a:7bea with SMTP id ffacd0b85a97d-3631998f66fmr5462810f8f.62.1718955178810;
        Fri, 21 Jun 2024 00:32:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:e600:4063:2059:fd18:9d65? (p200300cbc725e60040632059fd189d65.dip0.t-ipconnect.de. [2003:cb:c725:e600:4063:2059:fd18:9d65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f8268sm908751f8f.79.2024.06.21.00.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:32:58 -0700 (PDT)
Message-ID: <dce3adb5-5fce-451a-a50a-09499fcbf8ec@redhat.com>
Date: Fri, 21 Jun 2024 09:32:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <3F1DAB9F-2CC0-4FED-AD5E-D013E19EB998@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3F1DAB9F-2CC0-4FED-AD5E-D013E19EB998@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.06.24 04:05, Zi Yan wrote:
> On 20 Jun 2024, at 17:29, David Hildenbrand wrote:
> 
>> Currently we always take a folio reference even if migration will not
>> even be tried or isolation failed, requiring us to grab+drop an additional
>> reference.
>>
>> Further, we end up calling folio_likely_mapped_shared() while the folio
>> might have already been unmapped, because after we dropped the PTL, that
>> can easily happen. We want to stop touching mapcounts and friends from
>> such context, and only call folio_likely_mapped_shared() while the folio
>> is still mapped: mapcount information is pretty much stale and unreliable
>> otherwise.
>>
>> So let's move checks into numamigrate_isolate_folio(), rename that
>> function to migrate_misplaced_folio_prepare(), and call that function
>> from callsites where we call migrate_misplaced_folio(), but still with
>> the PTL held.
>>
>> We can now stop taking temporary folio references, and really only take
>> a reference if folio isolation succeeded. Doing the
>> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
>> to how we handle MADV_PAGEOUT.
>>
>> While at it, combine the folio_is_file_lru() checks.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/migrate.h |  7 ++++
>>   mm/huge_memory.c        |  8 ++--
>>   mm/memory.c             |  9 +++--
>>   mm/migrate.c            | 81 +++++++++++++++++++----------------------
>>   4 files changed, 55 insertions(+), 50 deletions(-)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index f9d92482d117..644be30b69c8 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -139,9 +139,16 @@ const struct movable_operations *page_movable_ops(struct page *page)
>>   }
>>
>>   #ifdef CONFIG_NUMA_BALANCING
>> +int migrate_misplaced_folio_prepare(struct folio *folio,
>> +		struct vm_area_struct *vma, int node);
>>   int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>   			   int node);
>>   #else
>> +static inline int migrate_misplaced_folio_prepare(struct folio *folio,
>> +		struct vm_area_struct *vma, int node)
>> +{
>> +	return -EAGAIN; /* can't migrate now */
>> +}
>>   static inline int migrate_misplaced_folio(struct folio *folio,
>>   					 struct vm_area_struct *vma, int node)
>>   {
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index fc27dabcd8e3..4b2817bb2c7d 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>   	if (node_is_toptier(nid))
>>   		last_cpupid = folio_last_cpupid(folio);
>>   	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>> -	if (target_nid == NUMA_NO_NODE) {
>> -		folio_put(folio);
>> +	if (target_nid == NUMA_NO_NODE)
>> +		goto out_map;
>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> +		flags |= TNF_MIGRATE_FAIL;
>>   		goto out_map;
>>   	}
>> -
>> +	/* The folio is isolated and isolation code holds a folio reference. */
>>   	spin_unlock(vmf->ptl);
>>   	writable = false;
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 118660de5bcc..4fd1ecfced4d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5207,8 +5207,6 @@ int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>>   {
>>   	struct vm_area_struct *vma = vmf->vma;
>>
>> -	folio_get(folio);
>> -
>>   	/* Record the current PID acceesing VMA */
>>   	vma_set_access_pid_bit(vma);
> 
> Without taking a reference here, is it safe to call mpol_misplaced() on the folio
> at the return? Can this folio be freed?

As long as we are holding the PTL, the folio cannot get unmapped and 
consequently not freed.

Note that if that would be the case (being able to get freed 
concurrently), even the folio_get() would have been wrong: if it could 
get freed concurrently, we would have to use folio_try_get*().

Thanks!

-- 
Cheers,

David / dhildenb


