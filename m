Return-Path: <linux-kernel+bounces-249842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B9B92F09D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C2E281CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CF419EEBB;
	Thu, 11 Jul 2024 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgSLHfyJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4394D2836A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731798; cv=none; b=LwxNlWCZ60rMwspryODvNxAxFlhqba/GM6UlNij7kHR17ZM/WsLF/Hmq8tK/xqr6hQuV8GglrxxV1EWjP3pBb8WFUIZrf+lQE0N1frWFo/he0gBwlJncOrw0W3HJQt4O+CURWHoSnUjYqayAmI5YT6wCH5mtqc5xhjnsUOcvY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731798; c=relaxed/simple;
	bh=g/ng/jsFNIZgK4gqfDCFRnWHGfL4PjnfR7bZYcUGYgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uU5aiYEp7Fw2ixRRSNrrxY9tBUEns0TNyC5+lNn7Vg4AwBImJ3zlGJo3LIRQ947vdEeQbmgzAZCmrx1wmpfG4ABcviHSply/qzT4xAHs/xzt/rEepVrolffnnHSv0omJBGr69K/uuZ1LO+YlzvwZ9JSvbyMiK6QZIKwdJd01Eu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgSLHfyJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720731796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QvGqQZLWXt9s2ZifTFpe/SJ61Oy0u4wSaDQQFK1SI7E=;
	b=WgSLHfyJLlf7OWl3HAbSuBAtfDze9kigpGpNGdym69oryztubRKPwfyKV4FmZDmaTfg06P
	oN6/3ubAFhPvkH6onkgy8K5Ag/Sy3WmG6EA69HKxNpecH46Po/leFieiuEc9n2rsmF+9pI
	L6SaA9e6Rf3IOIYBWdPVm5SIhKKPIYM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-C-ySzhFSNIKuRkeHzwHvZA-1; Thu, 11 Jul 2024 17:03:14 -0400
X-MC-Unique: C-ySzhFSNIKuRkeHzwHvZA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70b05300627so1441582b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731794; x=1721336594;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QvGqQZLWXt9s2ZifTFpe/SJ61Oy0u4wSaDQQFK1SI7E=;
        b=tV2t4fS1iE6Da3tYKyqP/aL+Zz0ekqMlnVE2hM5JT90Y72x2XPPLrSfEuIjDR2auB+
         EUCU1/n+ThQJqFW1R69ZyxHEFnKivyO8YUajjz4LUmCsUcdykbT/S0UGuN0bLTjOiYDD
         NetCBHaTb3kCV9DJeXfd0DT5nwO5TauC16mYeOeXmy/GU4A9FZGT/U5fQNGr2C1xHbbn
         ijDG967XokCiWCp5BQQ1O5BAlS+zM3jimyoOxEZLpncYvnqxr7S3mZiqPOEicx/+DlzD
         46S6atf122v4Ougq5ybqSgXc2R/h4Zfduu/9O9R9nHsiTsBxzxsFvPG4QKUTz5w1BdA1
         Z0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiCgHYRKZNAn9CAxp6ylkrSHKxYJZ7JTGr5kT6PKqSzXacw0gnK9W/BHtFPKzR2F9wYvYxXHJmWAAGOsXoKYQQTBIG2l4u1fk8hBOX
X-Gm-Message-State: AOJu0YwXnbUor+MtC8JAR5E+079xd2MvIPbJ1TIYoSPL1eP9AqgOyvA9
	qIH6iANzHfOX2f8afJeltEgl2I5rnApby1fdpMk25x6mZocCV6S5T3V3/o51vT3D6JHX1RNQAAO
	EhbCOvsUyPkJnWlwSLl+umPy7C1KTGRhYGe4mnjVTHMiTyNDSd1TVgLz1g+z5OusTBsUjKmi9
X-Received: by 2002:a05:6a00:130f:b0:705:951e:ed84 with SMTP id d2e1a72fcca58-70b43565d94mr11526783b3a.15.1720731793630;
        Thu, 11 Jul 2024 14:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwr+qp1AHeckqgEWrojjQvAUB0M3ica14m5+kWqP0N+BKqw+dyJH0w0Sc2RCDeuPaWaf/pFA==
X-Received: by 2002:a05:6a00:130f:b0:705:951e:ed84 with SMTP id d2e1a72fcca58-70b43565d94mr11526748b3a.15.1720731793132;
        Thu, 11 Jul 2024 14:03:13 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b5382b622sm3794125b3a.124.2024.07.11.14.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:03:12 -0700 (PDT)
Message-ID: <f58433ee-7217-4f9e-91ba-c29f95cd56b0@redhat.com>
Date: Thu, 11 Jul 2024 23:03:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: Avoid PMD-size page cache if needed
To: Matthew Wilcox <willy@infradead.org>, Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, william.kucharski@oracle.com,
 ryan.roberts@arm.com, shan.gavin@gmail.com
References: <20240711104840.200573-1-gshan@redhat.com>
 <ZpBEwEn3swH7IFbI@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZpBEwEn3swH7IFbI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 22:46, Matthew Wilcox wrote:
> On Thu, Jul 11, 2024 at 08:48:40PM +1000, Gavin Shan wrote:
>> +++ b/mm/huge_memory.c
>> @@ -136,7 +136,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>   
>>   		while (orders) {
>>   			addr = vma->vm_end - (PAGE_SIZE << order);
>> -			if (thp_vma_suitable_order(vma, addr, order))
>> +			if (!(vma->vm_file && order > MAX_PAGECACHE_ORDER) &&
>> +			    thp_vma_suitable_order(vma, addr, order))
>>   				break;
> 
> Why does 'orders' even contain potential orders that are larger than
> MAX_PAGECACHE_ORDER?
> 
> We do this at the top:
> 
>          orders &= vma_is_anonymous(vma) ?
>                          THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
> 
> include/linux/huge_mm.h:#define THP_ORDERS_ALL_FILE     (BIT(PMD_ORDER) | BIT(PUD_ORDER))
> 
> ... and that seems very wrong.  We support all kinds of orders for
> files, not just PMD order.  We don't support PUD order at all.
> 
> What the hell is going on here?

yes, that's just absolutely confusing. I mentioned it to Ryan lately 
that we should clean that up (I wanted to look into that, but am happy 
if someone else can help).

There should likely be different defines for

DAX (PMD|PUD)

SHMEM (PMD) -- but soon more. Not sure if we want separate ANON_SHMEM 
for the time being. Hm. But shmem is already handles separately, so 
maybe we can just ignore shmem here.

PAGECACHE (1 .. MAX_PAGECACHE_ORDER)

? But it's still unclear to me.

At least DAX must stay special I think, and PAGECACHE should be capped 
at MAX_PAGECACHE_ORDER.

-- 
Cheers,

David / dhildenb


