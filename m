Return-Path: <linux-kernel+bounces-548885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF668A54A74
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F65E3AE4F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9D720AF9C;
	Thu,  6 Mar 2025 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6qcoxR5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47C204089
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263212; cv=none; b=ulL4sf0dNNveujph1Sx4/Y7ApEUvPQauNlsMNL7gNFrhxalj/ciherCcuuOj77+NqVaC0AjXlSHaUJHp+Hw2Sjv726bh+cdciY4tcoiHN/bbE5Z4mB1hHJaw7iPlO9VClgVGDTZKZN+mwUQWrJCb0BHIrdube9UT+bb8dia6ybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263212; c=relaxed/simple;
	bh=AQh5W4vHJ26cY53RfCQI/eRk7WaEm2c6Z5RiLXPoiMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Msh4qiqkgY7IXcZ4a0RqS6QchHiYpi6DmJukAQilS/0UpRK7zZyKdPiRzK05CawdNMzOiZAMs5aQB+da9K3ndgbpps7jdlZWBMSsjdyqO+Y3Bj7WD1TDWuhi295oiGmt6Jt5PLh4A+xljZdQG82JukezHfrns5Kn6UmVmbAgYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6qcoxR5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741263209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2+8h/Eq62RScYeYGQoF6tkHNuAECYos9WyJPbvjGdgo=;
	b=J6qcoxR5/gzDKN+c240axIPpRhsnQRgeJH+jxriLv3kkXtpwjFAD1rnh32iJVqmEugfqND
	IrbegwmFHnyQh0M7WcaeAPCzjBSymx8Gssn1iFO0+f/SBDJ9hxG43j3K8pxxXsmaAa2zXV
	xLL+ogcZWYWe3m+M5hZvkzWNd3OfIxU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-eSn5R7DVOZ2nbwipX-RSEQ-1; Thu, 06 Mar 2025 07:13:28 -0500
X-MC-Unique: eSn5R7DVOZ2nbwipX-RSEQ-1
X-Mimecast-MFC-AGG-ID: eSn5R7DVOZ2nbwipX-RSEQ_1741263207
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390f3652842so350600f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741263207; x=1741868007;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2+8h/Eq62RScYeYGQoF6tkHNuAECYos9WyJPbvjGdgo=;
        b=KEe/0k1xfUs4CUVr2kxV89hbGIKh6fAqDIjTdgRsDeHEF86iHswrDr363nx3sO3vLo
         to47GkT70yDdMvINV4nZDs4okXzR+YURcsyjKpCd3aM//j7dn1+3oNN+oUNcvtL1wETB
         M+M981IMzWUNvMn+E362Xy+E2HdNOLghxxmL/uk1WK21++IsXouSnTuKeH9x/9nnYTYA
         FuT4d6qVKXA8fz6a6f74SdUYJLstPYOKkaz9Q1c3kjhszHdTyOTMXnBJ3fBNHvyAo0bv
         qY/774g9EfKWFWDfHbpzWU0vYQu9mk07+t8gXcD2QOzaEgX4ECcX/cSE/IHOFq2rbqlh
         R16w==
X-Forwarded-Encrypted: i=1; AJvYcCUT+hSdEBRsqshNyM9fPaxe3zYNzl0tllX40e5FUoc4NskcLr17gIhDTJ8CJgUU0r2sWYtW5/tqMGJ3g3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVwyckXp7MUdpQkNSrauHsZg8rIeY3JFVgAc6bblFpbARC0J5
	l4V2hE8THa8/tf22tOwPhVoxtk/dPW0+e0cWc4t6KkNYg6DAD7ihaD/H3uf45lr2KoScrsBIGdV
	34BC/Hjqp9PTybI4w8dJoXPEWvCrrCMZT4CadT1pwpW46L4kCl5aasTQ9oVBHQg==
X-Gm-Gg: ASbGncsk+I3KnEWSUhs3HRlHdKpeQlBzeXaJD4C8KSAJBo/4znAHgB9550JFnJTrJZQ
	3U4UqvVVQiidsm090vTMK5ZXIuHXb8/8iJ3C/R1NFH+E6lN59gtreDVZEXBXGF+ZfVLG+NbsGFA
	J17264aiyKMVFYjtOHm34I8VCmMLjDVzF053L5B2X3LdtlsABKPJq6GFrnjeT1fvAYmzX4X99Iw
	fsyjBk8eJLlU/buAZRe9uJDnCjzxEm+CyrefQaH9RKqJwYSnIPdWbJQc+oH+8XzKAZE4fE0vkhB
	2x9AYlVhjBbV8hwZDkWsTzQhG4+BbvfaCYgiikRAEH/65FJZhn+qHIkbDWAMciiF7w+goVyxNfQ
	VETxUTktm+irw+OI8O9dJenI4YbpllQ23ImimzpJ0ogo=
X-Received: by 2002:a05:6000:1ace:b0:391:139f:61c2 with SMTP id ffacd0b85a97d-3911f77d850mr7083047f8f.31.1741263207164;
        Thu, 06 Mar 2025 04:13:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2IgzQTPT61vfFqvKediWrpttJwYfK46s+KkshpZbnLtIPHwe0UjkXJc+FT/m1rjzVy1di7g==
X-Received: by 2002:a05:6000:1ace:b0:391:139f:61c2 with SMTP id ffacd0b85a97d-3911f77d850mr7083017f8f.31.1741263206781;
        Thu, 06 Mar 2025 04:13:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:4400:2f98:9b35:6822:ce54? (p200300cbc74d44002f989b356822ce54.dip0.t-ipconnect.de. [2003:cb:c74d:4400:2f98:9b35:6822:ce54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7ae4sm1840309f8f.5.2025.03.06.04.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 04:13:26 -0800 (PST)
Message-ID: <2ad7973b-9d92-4b34-8534-73ed1164a1c8@redhat.com>
Date: Thu, 6 Mar 2025 13:13:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: migrate: Allow misplaced migration without
 VMA too
To: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, feng.tang@intel.com, gourry@gourry.net,
 hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 yuanchu@google.com, hyeonggon.yoo@sk.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-2-bharata@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250306054532.221138-2-bharata@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.03.25 06:45, Bharata B Rao wrote:
> migrate_misplaced_folio_prepare() can be called from a
> context where VMA isn't available. Allow the migration
> to work from such contexts too.

I was initially confused about "can be called", because it can't

Consider phrasing it as "We want to make use of 
alloc_misplaced_dst_folio() in context where we don't have VMA 
information available. To prepare for that ..."

> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>   mm/migrate.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fb19a18892c8..5b21856a0dd0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2639,7 +2639,8 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>   
>   /*
>    * Prepare for calling migrate_misplaced_folio() by isolating the folio if
> - * permitted. Must be called with the PTL still held.
> + * permitted. Must be called with the PTL still held if called with a non-NULL
> + * vma.
>    */
>   int migrate_misplaced_folio_prepare(struct folio *folio,
>   		struct vm_area_struct *vma, int node)
> @@ -2656,7 +2657,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
>   		 * See folio_likely_mapped_shared() on possible imprecision
>   		 * when we cannot easily detect if a folio is shared.
>   		 */
> -		if ((vma->vm_flags & VM_EXEC) &&
> +		if (vma && (vma->vm_flags & VM_EXEC) &&
>   		    folio_likely_mapped_shared(folio))
>   			return -EACCES;
>   


-- 
Cheers,

David / dhildenb


