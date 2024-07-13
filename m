Return-Path: <linux-kernel+bounces-251422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99AA9304B6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D340282923
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B447A53;
	Sat, 13 Jul 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlC1SgzT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EE2F2A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720862747; cv=none; b=kmMmdYN4B8FljnRXiCKeFil4eoq8I9vHaZHcnVwGjvGZ4ag4tnwITY8ffBtUJwUyQNAt0oOnIyg2rXzyPb8PrkUf7YSJ1T0FwcvCUjHMFEwphOYSslezsjYdAdz6lYCGfeeVkqJlPCdvIwHf7xGHOkvWsWVwDD5jV+WX6KlOIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720862747; c=relaxed/simple;
	bh=9HfDtXcCSw01Ms6tVnsDNV2VUsPyKn5ZYkQexGcx1L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTFaz0si0GmvdYLV7qLX9auI2oazxYQ9L38pns9hBuyWQjYTFmYGOOz487tWWE+L5mLhcBVuhqEIR45aJ75hGRyGeXYPNhs1HakMVQ512eZqF6u0mVRjH51zsPXzK+Fm1La8v4K9JtwqUW6ljmjKObbG61ziipYEvdKzEzGVh/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlC1SgzT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720862744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcRixC2lx+d7TOqjLS/Bq0UJkIBiHu6hn/9edB9IbO8=;
	b=ZlC1SgzT2vnariWG8um8rAZT96kXk2Vpa+HGN5yUBd4hLTmB5J1WxNDdXVgexifhDLiJ/v
	9UqRgJ2oQyWdBjNQTdaI6jAIf+8Huqbj5v1q0V+JkUZlEeW0SmID5xRPt3ywFtmKv2Kg67
	Jjh/SngNT/b6//qQVBDWp6n6Xzf2OL4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-nX4Fi6d5OCShQu6annwCkA-1; Sat, 13 Jul 2024 05:25:42 -0400
X-MC-Unique: nX4Fi6d5OCShQu6annwCkA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so2230218a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 02:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720862740; x=1721467540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcRixC2lx+d7TOqjLS/Bq0UJkIBiHu6hn/9edB9IbO8=;
        b=IoU2S4vxavf+vCLODlsEsxX8RSU2qJdGgC3fDvIlxxCZeYFe92tRcKI1LQBG/dy1e/
         z/0LqqJ1XD8JpEZzDPfgh30cATdM67oyLBqLy58fc1sob0gg3dvo1N9oAS6idb3UeTJF
         ibFlAV1XLiD5rS8eoKyH2sHmnatiKoQpcH5SnB73j623nXJX7sXKVV11n9RaJHMAkuk1
         LZIaSFQuXOUglC08e+ImWac0gn/cF0PD5TIBBsLmkKTwVlhQApEDgjAGzOJM35fB0fZM
         gfko7eRhaidycQ4bXxGdsImOVmvac3IG2cxJDHHrr8R9CUn/Nfe41SYd9bVRHVVbuszg
         fVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8c2P5jtpmE50UGt6vntzzFMdOh3ujqqgP0wsBYWLItU6AWkmDGgnnbsnd3LNCedM1EgxbOr37ot+RAx/F/vVoE5VvEdH6xIMX4h/p
X-Gm-Message-State: AOJu0YzMt4GdUG+fbeugHcgrJuavuB0/+iXjAHGAUq+nk7065ycz57si
	59pszD84m6yeD6PuE5WghriVY7THne4PD7jAfS0zRqv6xp3BNZ6HiuodKOrQ1wN4eQRJVzvjXKA
	2NNoSr/VTT9vPahKqVksuKUJxecdIjmZ2/aorDVcJBkWvUmifmeVsnIDujK3KIG7J/8PVkw==
X-Received: by 2002:a05:6a20:394a:b0:1be:c43c:e1cc with SMTP id adf61e73a8af0-1c2980f9522mr16226572637.10.1720862740615;
        Sat, 13 Jul 2024 02:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEep5nCRORM9rbDk8yQvtZf8RFQzchFGR+rMgXtq0XU0SPUCCZHwDTSqxwRfdSOKgopRMqybg==
X-Received: by 2002:a05:6a20:394a:b0:1be:c43c:e1cc with SMTP id adf61e73a8af0-1c2980f9522mr16226553637.10.1720862740148;
        Sat, 13 Jul 2024 02:25:40 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fec6sm6940235ad.27.2024.07.13.02.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 02:25:39 -0700 (PDT)
Message-ID: <a168f908-3906-43e3-8676-360809ed5c8d@redhat.com>
Date: Sat, 13 Jul 2024 19:25:34 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: Avoid PMD-size page cache if needed
To: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, william.kucharski@oracle.com,
 ryan.roberts@arm.com, shan.gavin@gmail.com
References: <20240711104840.200573-1-gshan@redhat.com>
 <ZpBEwEn3swH7IFbI@casper.infradead.org>
 <f58433ee-7217-4f9e-91ba-c29f95cd56b0@redhat.com>
 <63a0364b-a2e0-48c2-b255-e976112deeb1@redhat.com>
 <df83a218-e2e5-496e-999a-e446a7d0b383@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <df83a218-e2e5-496e-999a-e446a7d0b383@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/13/24 11:03 AM, David Hildenbrand wrote:
> On 12.07.24 07:39, Gavin Shan wrote:
>>
>> David, I can help to clean it up. Could you please help to confirm the following
> 
> Thanks!
> 
>> changes are exactly what you're suggesting? Hopefully, there are nothing I've missed.
>> The original issue can be fixed by the changes. With the changes applied, madvise(MADV_COLLAPSE)
>> returns with errno -22 in the test program.
>>
>> The fix tag needs to adjusted either.
>>
>> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 2aa986a5cd1b..45909efb0ef0 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -74,7 +74,12 @@ extern struct kobj_attribute shmem_enabled_attr;
>>    /*
>>     * Mask of all large folio orders supported for file THP.
>>     */
>> -#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
> 
> DAX doesn't have any MAX_PAGECACHE_ORDER restrictions (like hugetlb). So this should be
> 
> /*
>   * FSDAX never splits folios, so the MAX_PAGECACHE_ORDER limit does not
>   * apply here.
>   */
> THP_ORDERS_ALL_FILE_DAX ((BIT(PMD_ORDER) | BIT(PUD_ORDER))
> 
> Something like that
> 

Ok. It will be corrected in v2.

>> +#define THP_ORDERS_ALL_FILE_DAX                \
>> +       ((BIT(PMD_ORDER) | BIT(PUD_ORDER)) & (BIT(MAX_PAGECACHE_ORDER + 1) - 1))
>> +#define THP_ORDERS_ALL_FILE_DEFAULT    \
>> +       ((BIT(MAX_PAGECACHE_ORDER + 1) - 1) & ~BIT(0))
>> +#define THP_ORDERS_ALL_FILE            \
>> +       (THP_ORDERS_ALL_FILE_DAX | THP_ORDERS_ALL_FILE_DEFAULT)
> 
> Maybe we can get rid of THP_ORDERS_ALL_FILE (to prevent abuse) and fixup
> THP_ORDERS_ALL instead.
> 

Sure, it will be removed in v2.

>>    /*
>>     * Mask of all large folio orders supported for THP.
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2120f7478e55..4690f33afaa6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -88,9 +88,17 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>           bool smaps = tva_flags & TVA_SMAPS;
>>           bool in_pf = tva_flags & TVA_IN_PF;
>>           bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
>> +       unsigned long supported_orders;
>> +
>>           /* Check the intersection of requested and supported orders. */
>> -       orders &= vma_is_anonymous(vma) ?
>> -                       THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
>> +       if (vma_is_anonymous(vma))
>> +               supported_orders = THP_ORDERS_ALL_ANON;
>> +       else if (vma_is_dax(vma))
>> +               supported_orders = THP_ORDERS_ALL_FILE_DAX;
>> +       else
>> +               supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
> 
> This is what I had in mind.
> 
> But, do we have to special-case shmem as well or will that be handled correctly?
> 

With previous fixes and this one, I don't see there is any missed cases
for shmem to have 512MB page cache, exceeding MAX_PAGECACHE_ORDER. Hopefully,
I don't miss anything from the code inspection.

- regular read/write paths: covered by the previous fixes
- synchronous readahead: covered by the previous fixes
- asynchronous readahead: page size granularity, no huge page
- page fault handling: covered by the previous fixes
- collapsing PTEs to PMD: to be covered by this patch
- swapin: shouldn't have 512MB huge page since we don't have such huge pages during swapout period
- other cases I missed (?)

Thanks,
Gavin


