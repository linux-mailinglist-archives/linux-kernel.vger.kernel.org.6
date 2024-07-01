Return-Path: <linux-kernel+bounces-235755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17491D948
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7DC1C21459
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3881AC1;
	Mon,  1 Jul 2024 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXw5164T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391880035
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819903; cv=none; b=b+xKa0esxHYTyShTXt/r0UHTWOjbb+R2ZgYvtmHIUMO+oKUErIf+8xfM7QIt+vF1o9iCG9VEYcId4j/hkSFbtHAAv7ezFRYNXYXLtOo5S5mRghoFuexrcemvhGvfdkcKqfOVtwZyTRD3UXpcI29lOErD7wBgrCRTrxbhn981ohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819903; c=relaxed/simple;
	bh=FipbC4WzIk4G0H5IFw9rp7PRcNolD3RWSIlzUCRbp5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llXiOzOZkNeQKuqTP9wmJ7PMSVvVjAjIA3RwcTnr5oZAu+DCzHRzho6yUuWshrWCmtFD4G4miMGZSZZVs90ThZa9ZoGe70JlKP3yvWroJPlYXDRN9TcTvt315/WCS/EVgL+4nB48Jh2HYmIJp+mxaySHtYQoRll+/HwPfpI7eK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXw5164T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719819900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GGM3vQiSuwTd+L9CIz0uOM3+T+62Z6Dfca/f49fCbFI=;
	b=ZXw5164ToIMUa9NGm9L73C/Gg5Ee2ILekRo2tqgUuaHrjPuzWqB/cn+ZWgu1prGz6xbzqW
	THgzcVR1qUbMq/sDRgeWWKxfL/9rTS1F0x1BR5+cP1ZKniJzZ0dLV4kCc66OlNMUHeeIim
	4dTIDNa22882NSGfKzFvZFf55yvPPmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-j4X7WM-hOdSsPYIsxEArWQ-1; Mon, 01 Jul 2024 03:44:59 -0400
X-MC-Unique: j4X7WM-hOdSsPYIsxEArWQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4258675a6easo2275985e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719819898; x=1720424698;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GGM3vQiSuwTd+L9CIz0uOM3+T+62Z6Dfca/f49fCbFI=;
        b=peTwseO9uG5yyr5Xem/s6V7VC/rNnVFG38yym9uhyvcKWIicBQslLNAxgMxU4/bSoM
         ZXoR1qwIVIfvdsGKjehmS5ic7hkGzbYnxBCboJ5zucKp4PqGanKMvKCcVZV8pkf/U42r
         jTS/JAwB05nUpxOOhsc0zK4netmwADXIELKy4PdzqpTsBRrO1YC/JihESdp/K7YlhJ38
         gNZ2ZwJJLxezJEdsWBEHUuqw3hcuq7ktbhsS1exJa7uTYrhTLnSCE3aL8MeSu1zfH3RP
         Pf7DbHqF+UrGns5yPXDCGBGcBAQrbRuY8IFvZ4AS04Dr8Yp1XlZ0W148HOj+smQT3dlh
         2jtQ==
X-Gm-Message-State: AOJu0Yw1UUMgIiKhcuC+UfxNZ0aDKOiQWRkp/OgTxPzbokvMcXMowLrS
	Zs19dIs8o9aIhUSa55RQSbu/93u+yiaCNLmMUhHATN064ORZkuPXigTrhvp8xVjgW0BRL3Lh2r0
	EUR3XCqkvns80u3jwAxY0y1ZULuERYwEnftJBDJz6o8zeZsR38al+kLvDdAe5sggE5Hy8bg==
X-Received: by 2002:a5d:4805:0:b0:362:69f1:a08 with SMTP id ffacd0b85a97d-367756b717bmr2495390f8f.19.1719819898098;
        Mon, 01 Jul 2024 00:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZIt4hjANV6ESgyRZYZvuGFUaifusIzspwpAM+3Iw3eKEizXH9wVKTPRPhMMIrWEXyM+GZAg==
X-Received: by 2002:a5d:4805:0:b0:362:69f1:a08 with SMTP id ffacd0b85a97d-367756b717bmr2495381f8f.19.1719819897657;
        Mon, 01 Jul 2024 00:44:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72e:2200:7ed7:c239:d423:3b31? (p200300cbc72e22007ed7c239d4233b31.dip0.t-ipconnect.de. [2003:cb:c72e:2200:7ed7:c239:d423:3b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a1030dfsm9238745f8f.100.2024.07.01.00.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:44:57 -0700 (PDT)
Message-ID: <0d7158fb-2e75-4358-936d-eb7d4ffc8a53@redhat.com>
Date: Mon, 1 Jul 2024 09:44:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/migrate: make migrate_misplaced_folio() return
 0 on success
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-2-david@redhat.com>
 <87plrxo96w.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87plrxo96w.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.24 09:36, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> Let's just return 0 on success, which is less confusing.
>>
>> ... especially because we got it wrong in the migrate.h stub where we
>> have "return -EAGAIN; /* can't migrate now */" instead of "return 0;".
>> Likely this wrong return value doesn't currently matter, but it
>> certainly adds confusion.
>>
>> We'll add migrate_misplaced_folio_prepare() next, where we want to use
>> the same "return 0 on success" approach, so let's just clean this up.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/huge_memory.c | 5 ++---
>>   mm/memory.c      | 2 +-
>>   mm/migrate.c     | 4 ++--
>>   3 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0fffaa58a47a..fc27dabcd8e3 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1652,7 +1652,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>   	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>   	int nid = NUMA_NO_NODE;
>>   	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
>> -	bool migrated = false, writable = false;
>> +	bool writable = false;
>>   	int flags = 0;
>>   
>>   	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>> @@ -1696,8 +1696,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>   	spin_unlock(vmf->ptl);
>>   	writable = false;
>>   
>> -	migrated = migrate_misplaced_folio(folio, vma, target_nid);
>> -	if (migrated) {
>> +	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>   		flags |= TNF_MIGRATED;
>>   		nid = target_nid;
>>   	} else {
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 00728ea95583..118660de5bcc 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5354,7 +5354,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   	ignore_writable = true;
>>   
>>   	/* Migrate to the requested node */
>> -	if (migrate_misplaced_folio(folio, vma, target_nid)) {
>> +	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>   		nid = target_nid;
>>   		flags |= TNF_MIGRATED;
>>   	} else {
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 781979567f64..0307b54879a0 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2629,11 +2629,11 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>   					    nr_succeeded);
>>   	}
>>   	BUG_ON(!list_empty(&migratepages));
>> -	return isolated;
>> +	return isolated ? 0 : -EAGAIN;
> 
> Is it good to use -EAGAIN as error code always?  At least if
> nr_remaining < 0, we can use that?

Thanks for the review. I kept it simple for now, because the 
migrate_misplaced_folio_prepare() stub has:

	return -EAGAIN; /* can't migrate now */

and it doesn't really make a difference right now which exact return 
value we use.

(maybe some cases, like the stub, should return -EINVAL or -EOPNOTSUPP 
once we start caring about the exact value)

-- 
Cheers,

David / dhildenb


