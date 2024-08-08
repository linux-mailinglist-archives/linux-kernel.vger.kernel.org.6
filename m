Return-Path: <linux-kernel+bounces-279802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B375094C208
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E7D2884CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077FE1DA21;
	Thu,  8 Aug 2024 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nepA1VBI"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830FB183CCB;
	Thu,  8 Aug 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132403; cv=none; b=ECpOKdNVlU/jPcs0BBQJ6wiRB/PPLAYyZ/z6nYD+KzTlfRsVyn8ZjWGzCF5KjNvtyuhqekgi0vJWOakYt5lyTHWO9S3Ydz9CK0PrURWhXTmszndm+k2MQPEONwvdu3B9GEfnU98Ub1d10fJ0mjRwCMPO6stEgkhY9HbNyG6P5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132403; c=relaxed/simple;
	bh=Yg1rBHLyxNvXVOxP3DixBoCmq2Z35VUXS9eEmM2C2lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGaAUIBRpEuT4EBvYLrDeWHPKVOPhT3o+eR410iKM5vI1bRW41zd19YDdh10tG4LZDcpSaGzVbVVy18QLTNaeb+HwXMvHF0J6AbtTGyiOMUJjd2O2ixSzkJRqVWIWxyS1cDwfHWJJAfd8or4e4fxB8dcYWU1xeXDCg4Gj4du3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nepA1VBI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01afa11cso1386227e87.0;
        Thu, 08 Aug 2024 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723132400; x=1723737200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51dq0wRW2rs5lnuCjGuAZAaXy1j0jgODrri2jr15rSM=;
        b=nepA1VBIhMqhAqMn3KO6sWIDU+nWxZmB5Yq+OLxGcZMd71jbSzeJf96kCK5mZlEc6S
         ZyxXh5IaIHCbGzfoQmExLdIKp96COG7xvcXLQYUyY2hsSJBlwgbZaX0QW4BkweaKHfdi
         ABCcl3m4e71Tr5R6Ft31EVBjl6/bCXe4Ef5mv8SFtsz7432NIN6t0JQ3gwy4zVjRtuMS
         Z1oBNGe7RWWkzmMjhYBgV9n2JZOwPS0fr6c/tC906DoxrzvsMG/l8hZWfpx5oA2/iWlv
         IsCcvG+dM4Ky3AWJS9lO+hO15eNT3+xPYlPxF7mIWmjh8HROX7M9tz9LrU1jsKJfJ7O6
         XS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132400; x=1723737200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51dq0wRW2rs5lnuCjGuAZAaXy1j0jgODrri2jr15rSM=;
        b=EyZga9JC8vaYw4lPgvCbs12wdaoWHxE5Iu4tTJXJm+ri5rAwKiW/8iOwnTI2C5zTbh
         F66c4HPS9dQcKdn5VJYOkYDYbYN5abvMGhwAei85Pq46acgTz+LlGcpi53TsNkLVZWEL
         8zKijrWjCV2YGknuAbxqjbTpisauwfQqr4Pif/dFjbiIkHW8936HHmPDYA9RqUWBU65l
         IPjRknptO51MoFcdAx/Aaac5Ye0SUAH6Xpmq6ELoVZuRygUP09+FGEl/unchBSwbVrYb
         8YES3vXqBf1dvRNpJCpvky51DQ5jNAc5wB5F8zKd2SWuHh3fhh2wuWDEHyumaIh0rcaI
         0LOA==
X-Forwarded-Encrypted: i=1; AJvYcCUtrVOuLDspXVrseoU7DlGhimmbh4JwqCKs6KL4LFO6snIOunOhGRj2roNMzzCqDdoAa+LoAghdWBDC9B51@vger.kernel.org, AJvYcCXV7FZj5FvHl88gDv4TF9UuwiN/0dvAwzvsOijvIZFHZHPWzffoZwZtZ9HdERBzoo3aePdwLOrgRxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxrJQ0+ZnJ2+hwXGSwZXgSQiJ70FG3Svq1p9dkxsGnkwbOeQv
	sMnGaGgxxTwkkLVBkGMzpXVv7jKdXXcJEYvp1ylaiA6Pb95Pawl5
X-Google-Smtp-Source: AGHT+IGMvMp6bsbitUSvC1TIav7dPktFrA56GyoSe/1Oc/aPmuMZPEl5BC5pS0CEbSGU64aOna+aEQ==
X-Received: by 2002:a05:6512:4019:b0:52c:db75:9640 with SMTP id 2adb3069b0e04-530e5891ed5mr1662762e87.48.1723132399099;
        Thu, 08 Aug 2024 08:53:19 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:3531])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c3c991sm756035a12.35.2024.08.08.08.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 08:53:18 -0700 (PDT)
Message-ID: <c6673e99-5e84-474e-8447-3f41a66bf634@gmail.com>
Date: Thu, 8 Aug 2024 16:53:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, riel@surriel.com,
 shakeel.butt@linux.dev, roman.gushchin@linux.dev, yuzhao@google.com,
 david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Shuang Zhai <zhais@google.com>
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
 <20240807134732.3292797-3-usamaarif642@gmail.com>
 <20240807200241.GB1828817@cmpxchg.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240807200241.GB1828817@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/08/2024 21:02, Johannes Weiner wrote:
> On Wed, Aug 07, 2024 at 02:46:47PM +0100, Usama Arif wrote:
>> @@ -177,13 +177,56 @@ void putback_movable_pages(struct list_head *l)
>>  	}
>>  }
>>  
>> +static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>> +					  struct folio *folio,
>> +					  unsigned long idx)
>> +{
>> +	struct page *page = folio_page(folio, idx);
>> +	bool contains_data;
>> +	pte_t newpte;
>> +	void *addr;
>> +
>> +	VM_BUG_ON_PAGE(PageCompound(page), page);
>> +	VM_BUG_ON_PAGE(!PageAnon(page), page);
>> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
>> +	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
>> +
>> +	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED))
>> +		return false;
>> +
>> +	/*
>> +	 * The pmd entry mapping the old thp was flushed and the pte mapping
>> +	 * this subpage has been non present. If the subpage is only zero-filled
>> +	 * then map it to the shared zeropage.
>> +	 */
>> +	addr = kmap_local_page(page);
>> +	contains_data = memchr_inv(addr, 0, PAGE_SIZE);
>> +	kunmap_local(addr);
>> +
>> +	if (contains_data || mm_forbids_zeropage(pvmw->vma->vm_mm))
>> +		return false;
>> +
>> +	newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
>> +					pvmw->vma->vm_page_prot));
> 
> Why not use my_zero_pfn() here? On many configurations this just
> returns zero_pfn and avoids the indirection through mem_map.
> 
>> @@ -904,7 +958,7 @@ static int writeout(struct address_space *mapping, struct folio *folio)
>>  	 * At this point we know that the migration attempt cannot
>>  	 * be successful.
>>  	 */
>> -	remove_migration_ptes(folio, folio, false);
>> +	remove_migration_ptes(folio, folio, false, false);
> 
> bool params are not great for callsite readability.
> 
> How about a flags parameter and using names?
> 
> enum rmp_flags {
> 	RMP_LOCKED	= 1 << 0,
> 	RMP_ZEROPAGES	= 1 << 1,
> }

Thanks! Will include both of the above changes in the next revision.

