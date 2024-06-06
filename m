Return-Path: <linux-kernel+bounces-203827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273358FE0F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19E21F222B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95573477;
	Thu,  6 Jun 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVR1Hcmc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BFC282FE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662632; cv=none; b=lJM1sgC+t3hHTRgwqSjaj6GItVz9EmPio4zkE4vARcvefjQ0DpUc6VjV53H4DunCozrXLISWopj25OT/58hmxl/1Q0v+OKDQSerO+cU5P9VHRTVAQjGW4ksy4jxDZnIK4VYXlqv8+C61OFCNDR7urke8Ox4ZeTjK4pM863Cd0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662632; c=relaxed/simple;
	bh=2XvdTb/gEDNTaX0zm75lWwl9b3VWTLnpEBk+g9saNJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExWxz4s/srp2lmZZrlPD7tgu2FH88c9TlfLVz+wzbVAfXT619Pq8eMKGm3sA/q8tHuK+kdJLu5uiZ+hGTfiTk2rwFOClkHWPujDoWyAruXVXJb5TlExYFqo+nDkc4+qnzyFlLL/aH7Dnetmgqi0JOgZqRgzEhZEPEVCQwceSx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVR1Hcmc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717662629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Cz1uU2NyZQqvmRwUEa7bRb467YlxBktFO04VlGLtzA=;
	b=GVR1HcmcgW0ddUjlR1J6E27Fj/X06FNsfaylRjoTKCKEUhkBhBTazcpK6vXRuY21T4Nion
	B7eBDa5l+XHxIV6ZW7T8n8Vc2Lfz+ZEaY+pQ2fb2xlYMBkQ8To9iCTmQ3qnv4RULkShssT
	Vxaxnn3R+2Cz8wBxcO2rBG6CNS1Zfyo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-MB30AbQFMIS9QsyPPnenFA-1; Thu, 06 Jun 2024 04:30:26 -0400
X-MC-Unique: MB30AbQFMIS9QsyPPnenFA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35e0f8bcc3cso507799f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662625; x=1718267425;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Cz1uU2NyZQqvmRwUEa7bRb467YlxBktFO04VlGLtzA=;
        b=eBydWAhCEkkz/GkXQIfLd0kGG5b4ubqIErvOEHvxA3iLM2X8q0M+hoDJU7h2QpYoQT
         iO/U0Var5tTm1LYFG/MgIlRwUvHQIZcU6Ra9yKAo0ae+bER4HuaNdKtSsotgRdGrm4Y8
         4uLGgb/dIbqZSq0CBomXAeeldgJ3PlnxTo+/ISdahHysF3HcNsbK7My9J1ni1O+q4Np/
         uqt/7fvvw3l9maKpMm7izHdWjSPJlamLVKtCJEE8iGH7s6c9FAGEof5ENQnnJlM3TLcj
         678uomq1xXU+9066lVcbiUZ9pPH/tdrbOg2Wyf2NLtoIa1hrriKJ2WZeveXrHYeJW9Cl
         9McA==
X-Forwarded-Encrypted: i=1; AJvYcCXiWIevNczBmsFvBsHpBwu8JfC6P4IdQvVCp7q5Q4SRz5PaqyKeZusMp5d5vNwfZ0CmaVFzhXBbiwwMfTr1xahLXJ7tz26EJ3y9eOTx
X-Gm-Message-State: AOJu0YwV5R2IeUwzY64YxNdrNkaEX75C7C/SSgmLJ6jXSKmhrL1VkWSh
	sNz8GU3rPXdJblIbxSBSRO5mxWCQHipMr3K0rJCwzctJiD/eU8uvjNvdG0P5+h4kqTdBn0oupQD
	TgHpHxp28UwomHKDIFuWyUyl2tgAAg0LgowpLc48nV63qsUdnS1dQkPLnjhilZw==
X-Received: by 2002:adf:e8d0:0:b0:356:2afb:7a62 with SMTP id ffacd0b85a97d-35e84068ab4mr4114527f8f.6.1717662625300;
        Thu, 06 Jun 2024 01:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqMP6fUFyuO3Pdl6y6nz9tj+3ZkFKr+W+nlwDJvBrDwLUKlZM2oPDBMP2k9VSxD6eAyklg+Q==
X-Received: by 2002:adf:e8d0:0:b0:356:2afb:7a62 with SMTP id ffacd0b85a97d-35e84068ab4mr4114504f8f.6.1717662624830;
        Thu, 06 Jun 2024 01:30:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc0ccasm910536f8f.103.2024.06.06.01.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:30:24 -0700 (PDT)
Message-ID: <be130a96-a27e-4240-ad78-776802f57cad@redhat.com>
Date: Thu, 6 Jun 2024 10:30:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Yu Zhao <yuzhao@google.com>, Muchun Song <muchun.song@linux.dev>,
 Frank van der Linden <fvdl@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jane Chu <jane.chu@oracle.com>,
 Will Deacon <will@kernel.org>, Nanyong Sun <sunnanyong@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, wangkefeng.wang@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <20240207121125.GA22234@willie-the-truck>
 <ZcOQ-0pzA16AEbct@casper.infradead.org>
 <908066c7-b749-4f95-b006-ce9b5bd1a909@oracle.com>
 <ZcT4DH7VE1XLBvVc@casper.infradead.org>
 <917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.dev>
 <CAOUHufYF2E-hM-u8eZc+APZAsMX3pOAmto7kB3orH5_MRgvSkA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAOUHufYF2E-hM-u8eZc+APZAsMX3pOAmto7kB3orH5_MRgvSkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Additionally, we also should alter RO permission of those 7 tail pages
>> to RW to avoid panic().
> 
> We can use RCU, which IMO is a better choice, as the following:
> 
> get_page_unless_zero()
> {
>    int rc = false;
> 
>    rcu_read_lock();
> 
>    if (page_is_fake_head(page) || !page_ref_count(page)) {
>          smp_mb(); // implied by atomic_add_unless()
>          goto unlock;
>    }
> 
>    rc = page_ref_add_unless();
> 
> unlock:
>    rcu_read_unlock();
> 
>    return rc;
> }
> 
> And on the HVO/de-HOV sides:
> 
>    folio_ref_unfreeze();
>    synchronize_rcu();
>    HVO/de-HVO;
> 
> I think this is a lot better than making tail page metadata RW because:
> 1. it helps debug, IMO, a lot;
> 2. I don't think HVO is the only one that needs this.
> 
> David (we missed you in today's THP meeting),

Sorry, I had a private meeting conflict :)

> 
> Please correct me if I'm wrong -- I think virtio-mem also suffers from
> the same problem when freeing offlined struct page, since I wasn't
> able to find anything that would prevent a **speculative** struct page
> walker from trying to access struct pages belonging to pages being
> concurrently offlined.

virtio-mem does currently not yet optimize fake-offlined memory like HVO 
would. So the only way we really remove "struct page" metadata is by 
actually offlining+removing a complete Linux memory block, like ordinary 
memory hotunplug would.

It might be an interesting project to optimize "struct page" metadata 
consumption for fake-offlined memory chunks within an online Linux 
memory block.

The biggest challenge might be interaction with memory hotplug, which 
requires all "struct page" metadata to be allocated. So that would make 
cases where virtio-mem hot-plugs a Linux memory block but keeps parts of 
it fake-offline a bit more problematic to handle .

In a world with memdesc this might all be nicer to handle I think :)


There is one possible interaction between virtio-mem and speculative 
page references: all fake-offline chunks in a Linux memory block do have 
on each page a refcount of 1 and PageOffline() set. When actually 
offlining the Linux memory block to remove it, virtio-mem will drop that 
reference during MEM_GOING_OFFLINE, such that memory offlining can 
proceed (seeing refcount==0 and PageOffline()).

In virtio_mem_fake_offline_going_offline() we have:

if (WARN_ON(!page_ref_dec_and_test(page)))
	dump_page(page, "fake-offline page referenced");

which would trigger on a speculative reference.

We never saw that trigger so far because quite a long time must have 
passed ever since a page might have been part of the page cache / page 
tables, before virtio-mem fake-offlined it (using alloc_contig_range()) 
and the Linux memory block actually gets offlined.

But yes, RCU (e.g., on the memory offlining path) would likely be the 
right approach to make sure GUP-fast and the pagecache will no longer 
grab this page by accident.

> 
> If this is true, we might want to map a "zero struct page" rather than
> leave a hole in vmemmap when offlining pages. And the logic on the hot
> removal side would be similar to that of HVO.

Once virtio-mem would do something like HVO, yes. Right now virtio-mem 
only removes struct-page metadata by removing/unplugging its owned Linux 
memory blocks once they are fully "logically offline".

-- 
Cheers,

David / dhildenb


