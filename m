Return-Path: <linux-kernel+bounces-250201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102D92F51B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1EB1C224F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDDA1803E;
	Fri, 12 Jul 2024 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBvNMIy8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C71B969
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720762774; cv=none; b=AXJoUdFcbn9LsDGTESFiWM9vLOGh3KOJUxDhlddXjueVMS9Jy//uG2uxS5e7i8urFfVblIbFQZ10RrqMM+By/n4bJdi5oHOgknfdF6sq4RmHmyFvljRj+QSn4KIYXzBmS6ztu7P9PJVivbH8DuJ8Mr3onKbSgA4213qJ/4yrgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720762774; c=relaxed/simple;
	bh=EaiqQv1CXRmEOwGPKyZ1gEREXMoGVvsMHHaWcTl/5N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfVbgdh5QAiluiRJmhIHDmwugL6qJKeoKTXUIn5rHpvw8mGdnXZLP6cTLXKId2ztQ7Xfo1er3jqgb5KmECwcI/u61FDdQyPaAYxOPZWNhFYJaXH6PqS9oivZqXllnB6jKbNihuASXjQ3Q5vNEtsSav4vOcbQRsJN0D/NBO8/lVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBvNMIy8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720762770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Juf3XDq2EUxzBjQ9N3/IKdm2gpCkJR3uxHfLLmp+JKA=;
	b=KBvNMIy8thlO405vxXerJXxEAMzp+mrYNQpIoJOKhAJjlG7YzZxTzA5V6mZyLPQUqygxTq
	ClIdd8HYyslF+ucPx9kmy3X0Yf9xgeHBeDCRnWVe8OUvYDzK5tiz5OHRtFGRVeeF/BQoWb
	2YP0e7XgaT8RkSJavyHVinADU00FabU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-HA8_Q2RgN7GRaBwq_O3tUQ-1; Fri, 12 Jul 2024 01:39:28 -0400
X-MC-Unique: HA8_Q2RgN7GRaBwq_O3tUQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fb05b9e222so13302945ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720762766; x=1721367566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Juf3XDq2EUxzBjQ9N3/IKdm2gpCkJR3uxHfLLmp+JKA=;
        b=Zceg2tBrXWXZ4BND0ofzfo2OcioeBvOwuE7AT7R6zxLH+SgL8cS3wQwyjrt/2ZyGw2
         YS0NaljDMsPif8HepWcpNO+fsnJYG1pafGEi1AswoLycXajz9yrwVj44RhkmGRp/JFHA
         6Kg2hi341YpAirNn3Tl/Fg45Y2HXQCJnjlCuccDG8zSQExWu5ZehpD3ma8AL1LH0C/Hp
         fn+PZC7jf0oS5hNc0jgEtVMkKPHnB/dL669awFjymoTw19+OZWgRVggCSkKtj3DAAu8x
         lLHTEKk4h01HbLBsU0FaLBxzJhfXDkHomy1wFpMcZSloUyrhKVoj9Ye6NRkcXtml+xza
         4mCA==
X-Forwarded-Encrypted: i=1; AJvYcCVI3tDH6s7J6nWxHjSaIRSVI8052ovFu1JE83dI2aPeV2arrX790WyR9nv4rLjIwFo1spCHYIFxks/rnYzLzbGYLxrGgS1SASMPzz6L
X-Gm-Message-State: AOJu0YxSMbgUvEjcuzGl7zzORP2ia0rrq1xaFLkbGCRR5494/dsWfFkr
	PBPNnxJZIHBzMdWzxnkzu6fXIeDmas7KPbcDkXk/hf8k1Sy7v6lWSJuRCpEeBS+dsjr8x6YbWLG
	/vLE3ufDXArorLjIddckGud9LxXK7h+mxyxYWpMTfcZ13PRLJ9U4FFcOR7JRbkyhl65hCSg==
X-Received: by 2002:a17:903:2342:b0:1fb:4194:5b78 with SMTP id d9443c01a7336-1fbb6ec24cbmr90896725ad.47.1720762766483;
        Thu, 11 Jul 2024 22:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfj/Ar1/TbsQ4S4E1sIRhO+MyKu2ikCKwAAuxpNfHr8daVGBu9FDekV4bt2He3KUzw0zdWRA==
X-Received: by 2002:a17:903:2342:b0:1fb:4194:5b78 with SMTP id d9443c01a7336-1fbb6ec24cbmr90896565ad.47.1720762766058;
        Thu, 11 Jul 2024 22:39:26 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2b2b0sm59174105ad.84.2024.07.11.22.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 22:39:25 -0700 (PDT)
Message-ID: <63a0364b-a2e0-48c2-b255-e976112deeb1@redhat.com>
Date: Fri, 12 Jul 2024 15:39:20 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <f58433ee-7217-4f9e-91ba-c29f95cd56b0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/12/24 7:03 AM, David Hildenbrand wrote:
> On 11.07.24 22:46, Matthew Wilcox wrote:
>> On Thu, Jul 11, 2024 at 08:48:40PM +1000, Gavin Shan wrote:
>>> +++ b/mm/huge_memory.c
>>> @@ -136,7 +136,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>           while (orders) {
>>>               addr = vma->vm_end - (PAGE_SIZE << order);
>>> -            if (thp_vma_suitable_order(vma, addr, order))
>>> +            if (!(vma->vm_file && order > MAX_PAGECACHE_ORDER) &&
>>> +                thp_vma_suitable_order(vma, addr, order))
>>>                   break;
>>
>> Why does 'orders' even contain potential orders that are larger than
>> MAX_PAGECACHE_ORDER?
>>
>> We do this at the top:
>>
>>          orders &= vma_is_anonymous(vma) ?
>>                          THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
>>
>> include/linux/huge_mm.h:#define THP_ORDERS_ALL_FILE     (BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>
>> ... and that seems very wrong.  We support all kinds of orders for
>> files, not just PMD order.  We don't support PUD order at all.
>>
>> What the hell is going on here?
> 
> yes, that's just absolutely confusing. I mentioned it to Ryan lately that we should clean that up (I wanted to look into that, but am happy if someone else can help).
> 
> There should likely be different defines for
> 
> DAX (PMD|PUD)
> 
> SHMEM (PMD) -- but soon more. Not sure if we want separate ANON_SHMEM for the time being. Hm. But shmem is already handles separately, so maybe we can just ignore shmem here.
> 
> PAGECACHE (1 .. MAX_PAGECACHE_ORDER)
> 
> ? But it's still unclear to me.
> 
> At least DAX must stay special I think, and PAGECACHE should be capped at MAX_PAGECACHE_ORDER.
> 

David, I can help to clean it up. Could you please help to confirm the following
changes are exactly what you're suggesting? Hopefully, there are nothing I've missed.
The original issue can be fixed by the changes. With the changes applied, madvise(MADV_COLLAPSE)
returns with errno -22 in the test program.

The fix tag needs to adjusted either.

Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2aa986a5cd1b..45909efb0ef0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -74,7 +74,12 @@ extern struct kobj_attribute shmem_enabled_attr;
  /*
   * Mask of all large folio orders supported for file THP.
   */
-#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
+#define THP_ORDERS_ALL_FILE_DAX                \
+       ((BIT(PMD_ORDER) | BIT(PUD_ORDER)) & (BIT(MAX_PAGECACHE_ORDER + 1) - 1))
+#define THP_ORDERS_ALL_FILE_DEFAULT    \
+       ((BIT(MAX_PAGECACHE_ORDER + 1) - 1) & ~BIT(0))
+#define THP_ORDERS_ALL_FILE            \
+       (THP_ORDERS_ALL_FILE_DAX | THP_ORDERS_ALL_FILE_DEFAULT)
  
  /*
   * Mask of all large folio orders supported for THP.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2120f7478e55..4690f33afaa6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -88,9 +88,17 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
         bool smaps = tva_flags & TVA_SMAPS;
         bool in_pf = tva_flags & TVA_IN_PF;
         bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
+       unsigned long supported_orders;
+
         /* Check the intersection of requested and supported orders. */
-       orders &= vma_is_anonymous(vma) ?
-                       THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
+       if (vma_is_anonymous(vma))
+               supported_orders = THP_ORDERS_ALL_ANON;
+       else if (vma_is_dax(vma))
+               supported_orders = THP_ORDERS_ALL_FILE_DAX;
+       else
+               supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
+
+       orders &= supported_orders;
         if (!orders)
                 return 0;

Thanks,
Gavin


