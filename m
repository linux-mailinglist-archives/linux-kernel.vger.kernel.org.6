Return-Path: <linux-kernel+bounces-194397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB98D3B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3EA1C2390C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C58D181D0A;
	Wed, 29 May 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnDnBXua"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9B181BB3
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998292; cv=none; b=c/Tx2Bg0fXpAO2tvnldw7FfUizWvgpjDeGlYxreAh5Q9u9B6K6jftqnw1UkG+hZ+CmgsNtCKajUZAJ7GCcgFlCvV5fpglaFlt+1hEIfvSlBm8R8OMkz5dREzBSktA4p6Lngp9fEZem1rtwjTKQBWFhuv7BLVqgI+dfk4VmP6LQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998292; c=relaxed/simple;
	bh=R92ajvyWu45q7BAjRXI19+IfBLdL74HaFB7Rr85QzmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdWx0lMZ1N0JQfHUXpuhuD9IVTdxwzbUjC7+ltRQGXpXNHX8D3jj8sBLaCSt8L6LxgpFW6hSFl0KmeTO6D/LKLX+8v4HDFdOEgzaX6QuQ/3cfcwDlHQTfOAiv2hm6vvJ37zMDXQ44MkfMS52A/t9zkfpvRl+QFdidrJLuvx36eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnDnBXua; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716998289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6/SdcQ0+AoHTDaztZQNAQRkneocAU/NCMB2jyU527Ps=;
	b=SnDnBXuaakSFqTjBSXUgg4UQ4UzAwmcMI2GGbs2FtjWV1HOg/Og+H0npNpMFCXzNS4qVPF
	ZjPv7wXyMbHHOI7ZLXPraNQZlcMR/mOCk0jUvjN0B9f35SXWXrAqlPZ+GGaMMpyuyExGGI
	r+k+CV1IqYykIWvxagXChbydw7uKUgk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-RsE8WZoXOPOIyXQ430XhQQ-1; Wed, 29 May 2024 11:58:07 -0400
X-MC-Unique: RsE8WZoXOPOIyXQ430XhQQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4210ea66b7dso15042035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716998286; x=1717603086;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/SdcQ0+AoHTDaztZQNAQRkneocAU/NCMB2jyU527Ps=;
        b=DuSGL1Lz8BJSMDLoFTLGojwGoz+hNcTdMZPlezL7c1yNvyk5N3E8vzxKgwsPbvQ+vZ
         1hI4rY2oDHTpIcvS9oCBxdCefdyYRHeOYnj3aiQKr802Oids5aEA5qg2ORkxFWFnC0Jt
         3vw4xRJux4jjwawTjMdPwmOVg5UpYyqPqEgWg+lOmLXTzQwgeKkB2xWHLrsvhMy6Fqex
         M8pkr7wicZV9mW3GWAdB1DU0OsCfkad1raRQAijFEDcCuY0a7+pS1dncZNDHELzSACW1
         cizsofFLQQqDJ63itU+LD+V2zycCNO+E/Z3inKspZmDU+474cVOMfN5NMp7L7/sjAZYF
         scyw==
X-Forwarded-Encrypted: i=1; AJvYcCWx1iFrRli+swmYk+v0IpHLaKQL3wydIPowbwxvZncqL9xlAD189sfuJiO2i2weklw2S+hu2y6ejRz4sX3IzD87crpl1DuPCmv+2Uwq
X-Gm-Message-State: AOJu0YwwZU6zC+I0gswdhdNjczLX1mjuRf3v73ONnf0lc+4OpHcamIs4
	RSdyb9c1qB00e0UpfuPLOL+F1KF+fXxadRIM7GDW2fUD0zWStfROKgQHiyBTJdW5lJ0DrtkamdB
	SBk2BhKcISFue30JRbRNvapxhG8MGnWZ+meaGNQWXX5J4jom4G/BbUOZSEMRauQ==
X-Received: by 2002:a05:600c:46c4:b0:41a:e995:b924 with SMTP id 5b1f17b1804b1-42108a0b91dmr101306055e9.33.1716998286458;
        Wed, 29 May 2024 08:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFLlocvqnqU+y+7MJYLF2Eo7Q1oJz2x26IVIGJuwG5md9PvywQLWhyspHxOG8/o9WfGfmHqg==
X-Received: by 2002:a05:600c:46c4:b0:41a:e995:b924 with SMTP id 5b1f17b1804b1-42108a0b91dmr101305745e9.33.1716998285811;
        Wed, 29 May 2024 08:58:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:3c00:686e:317c:3ed4:d7b8? (p200300cbc70c3c00686e317c3ed4d7b8.dip0.t-ipconnect.de. [2003:cb:c70c:3c00:686e:317c:3ed4:d7b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fb8f4asm216961205e9.41.2024.05.29.08.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 08:58:05 -0700 (PDT)
Message-ID: <3771cb2d-932f-49ee-aac2-e67206b94ebe@redhat.com>
Date: Wed, 29 May 2024 17:58:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 26] mm allow reuse of the lower 16 bit of the page type
 with an actual type
To: wang wei <a929244872@163.com>
Cc: 42.hyeyoo@gmail.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 rppt@kernel.org, senozhatsky@chromium.org, willy@infradead.org
References: <20240527141454.113132-3-david@redhat.com>
 <20240529155520.33161-1-a929244872@163.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240529155520.33161-1-a929244872@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.05.24 17:55, wang wei wrote:
> ---
>> As long as the owner sets a page type first, we can allow reuse of the
>> lower 18 bit: sufficient to store an offset into a 64 KiB page, which
>> is the maximum base page size in *common* configurations (ignoring the
>> 256 KiB variant). Restrict it to the head page.
>>
>> We'll use that for zsmalloc next, to set a proper type while still
>> reusing that field to store information (offset into a base page) that
>> cannot go elsewhere for now.
>>
>> Fear of running out of bits for storing the actual type? Actually, we
>> don't need one bit per type, we could store a single value instead.
>> Further, we could likely limit PAGE_TYPE_BASE to a single (highest) bit.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/mm_types.h   |  5 +++++
>>   include/linux/page-flags.h | 20 ++++++++++++--------
>>   2 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 6b2aeba792c4..598cfedbbfa0 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -157,6 +157,11 @@ struct page {
>>   		 *
>>   		 * See page-flags.h for a list of page types which are currently
>>   		 * stored here.
>> +		 *
>> +		 * Owners of typed folios may reuse the lower 16 bit of the
>> +		 * head page page_type field after setting the page type,
>> +		 * but must reset these 16 bit to -1 before clearing the
>> +		 * page type.
>>   		 */
>>   		unsigned int page_type;
>>   
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 104078afe0b1..b43e380ffa0b 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -945,14 +945,18 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
>>    */
>>   
>>   #define PAGE_TYPE_BASE	0xf0000000
>> -/* Reserve		0x0000007f to catch underflows of _mapcount */
>> -#define PAGE_MAPCOUNT_RESERVE	-128
>> -#define PG_buddy	0x00000080
>> -#define PG_offline	0x00000100
>> -#define PG_table	0x00000200
>> -#define PG_guard	0x00000400
>> -#define PG_hugetlb	0x00000800
>> -#define PG_slab		0x00001000
>> +/*
>> + * Reserve		0x0000ffff to catch underflows of _mapcount and
>> + * allow owners that set a type to reuse the lower 16 bit for their own
>> + * purposes.
>> + */
>> +#define PAGE_MAPCOUNT_RESERVE	-65536
>> +#define PG_buddy	0x00010000
>> +#define PG_offline	0x00020000
>> +#define PG_table	0x00040000
>> +#define PG_guard	0x00080000
>> +#define PG_hugetlb	0x00100800
> 
> Every PG_XX occupies one bit in my understanding.   But why PG_hugetlb occupies two bits?

Because it's wrong (although not harmful). Same issue in v2, fat fingers.

Thanks for pointing that out!

-- 
Cheers,

David / dhildenb


