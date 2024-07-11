Return-Path: <linux-kernel+bounces-249877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A692F108
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873E01F22D80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1B19F469;
	Thu, 11 Jul 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWcYVCkO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1203A19EECC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732809; cv=none; b=ezcTP9/oW0yhP5FwHGhZrhiQQw5lNYksMzpvyZQLCDdE3TBIavMJoacti7ewfpIekt7eB4lgDc/VPBKEGI1paJ5MoxlWSj1bkGlbh/hki/eqDUciscrasqhBeaZyTmYzOOu9GTd+S5ot7vDF//9JIvNBQ8doH7jXKGFw+Xj1AG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732809; c=relaxed/simple;
	bh=xUVnp9wRA9d2E/HYG68qFcM/8AolZY1eNetp+T7paJo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jIyFEBqfW/WgNG4D2YYJlbHX1yd7HRSKFWzDU77UZDb9Qpz3v0xphRIJOZ1lPKKcCL7UFua1377TPQyaqF4fcVDWzAsuQqHDxvZfLCgBFrxPQI3oM9V6cNbMFChE2TiC3Q/PNj8VbQPlICjHgYzGvGrqup1qs/ZJnLdcM1IMI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWcYVCkO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720732806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1R1yPcxt1cOr41pbNJOBUSwJcEM1dnUiizIjVJ/tHtc=;
	b=LWcYVCkOdbjbj4SGeJOPPbs/5FgskaPRWvF4Rsb5EqZ4BUomt+rFJAq6UhA15HogzEdK9L
	BiOE9ATI36Cov6xsVWQqhRsB7Fm8v0bAZKooepKKDkofdf+8zuIp/q/4kmp8JmHaEpVNZE
	hE0eAnpeUY8UAhYvHGxtgZouPwcM3Rw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Ik5m1DNaNUipgqgZShip7A-1; Thu, 11 Jul 2024 17:20:04 -0400
X-MC-Unique: Ik5m1DNaNUipgqgZShip7A-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fb1c206242so10301505ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732803; x=1721337603;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1R1yPcxt1cOr41pbNJOBUSwJcEM1dnUiizIjVJ/tHtc=;
        b=hZ5oJaIoyIGiCcbya+NE2jXuyaboykBcWq4Z4E3NifybPqS878FFNLo1NsY7e1XLZt
         qxq3cc909EZyA4ktIK+xzXeBcFlspe84P5quAQtqspwFyDRKWkDRx1mbIxAWfk2QboPH
         ER4NvCsjJMKMENt1DXFnujj9zYkznaJ1BH30ouhpRjNU2/R6mv1eXF+Q8N5rnCPq5Glj
         h4q5aOfSjIVfAGZstmgU2VQdxiMVSa3M2BqtcZIhtQM6g60LXhbXhnJbjJqSDPxJaTgv
         lPcYey8gWhb/6dWvb4HpGQnyGF7A63kwg0Z4s1qI1Hl4Mgtk4owmTWJweZ2+FtHsv0MV
         xm+g==
X-Forwarded-Encrypted: i=1; AJvYcCVwQSJIokLcMvWZzNgqDIHOmNgoP2uh7rhLSzoV9Y0Gro7t6BOtJTFZLt3h7skZ4j/M2YsPXzv3jTB9Bug9PtjztHGrtYcLiBN8xaWt
X-Gm-Message-State: AOJu0YyQZK2K4RMUG4GUewHGxERtupCZ/eqo8xYWXQVVkfNXkrYxnouN
	n0ld/jSza8w/KHuc7g/89mT0U1/3Qou0/RVixKgz/gcYjTINy9O4pyPtotwQVWqCfq4aTQ3Lp2n
	1wnq0EyQcCwmCwRaWBM5P+C38HIqiRg4SiE6EPYl55chgWZsC77zPMRvfLF+5kg==
X-Received: by 2002:a17:902:f543:b0:1fb:8245:fdeb with SMTP id d9443c01a7336-1fbb6edcf36mr83893985ad.64.1720732803634;
        Thu, 11 Jul 2024 14:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqmBNbu5MxW663zusr5c2lW+jBsdXH71L3llH4HJXdtPO6lN6NnF6rpCsuyh9LpD31gVZ7pw==
X-Received: by 2002:a17:902:f543:b0:1fb:8245:fdeb with SMTP id d9443c01a7336-1fbb6edcf36mr83893805ad.64.1720732803173;
        Thu, 11 Jul 2024 14:20:03 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a0fc62sm55034285ad.40.2024.07.11.14.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:20:02 -0700 (PDT)
Message-ID: <d5b186a3-e45c-4bbc-8c3e-3a37d1a935c0@redhat.com>
Date: Thu, 11 Jul 2024 23:20:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: Avoid PMD-size page cache if needed
From: David Hildenbrand <david@redhat.com>
To: Matthew Wilcox <willy@infradead.org>, Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, william.kucharski@oracle.com,
 ryan.roberts@arm.com, shan.gavin@gmail.com
References: <20240711104840.200573-1-gshan@redhat.com>
 <ZpBEwEn3swH7IFbI@casper.infradead.org>
 <f58433ee-7217-4f9e-91ba-c29f95cd56b0@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f58433ee-7217-4f9e-91ba-c29f95cd56b0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 23:03, David Hildenbrand wrote:
> On 11.07.24 22:46, Matthew Wilcox wrote:
>> On Thu, Jul 11, 2024 at 08:48:40PM +1000, Gavin Shan wrote:
>>> +++ b/mm/huge_memory.c
>>> @@ -136,7 +136,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>    
>>>    		while (orders) {
>>>    			addr = vma->vm_end - (PAGE_SIZE << order);
>>> -			if (thp_vma_suitable_order(vma, addr, order))
>>> +			if (!(vma->vm_file && order > MAX_PAGECACHE_ORDER) &&
>>> +			    thp_vma_suitable_order(vma, addr, order))
>>>    				break;
>>
>> Why does 'orders' even contain potential orders that are larger than
>> MAX_PAGECACHE_ORDER?
>>
>> We do this at the top:
>>
>>           orders &= vma_is_anonymous(vma) ?
>>                           THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
>>
>> include/linux/huge_mm.h:#define THP_ORDERS_ALL_FILE     (BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>
>> ... and that seems very wrong.  We support all kinds of orders for
>> files, not just PMD order.  We don't support PUD order at all.
>>
>> What the hell is going on here?
> 
> yes, that's just absolutely confusing. I mentioned it to Ryan lately
> that we should clean that up (I wanted to look into that, but am happy
> if someone else can help).
> 
> There should likely be different defines for
> 
> DAX (PMD|PUD)
> 
> SHMEM (PMD) -- but soon more. Not sure if we want separate ANON_SHMEM
> for the time being. Hm. But shmem is already handles separately, so
> maybe we can just ignore shmem here.

Correction: of course <= MAX_PAGECACHE_ORDER

But yeah, this needs cleanups

-- 
Cheers,

David / dhildenb


