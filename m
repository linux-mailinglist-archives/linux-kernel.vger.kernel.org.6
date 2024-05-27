Return-Path: <linux-kernel+bounces-191350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C2D8D0A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D83282700
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D827B15FA68;
	Mon, 27 May 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hk+MU0ud"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA626AD7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835777; cv=none; b=Mcp212wSKgh0iynXokNGYDZtp1eXNd/fqkWiWrksCETKRPmx2jjKCdW9f7qsnsCoi9PIOhQOoMt0+5LhSt5sAYZBDBSzOJy+BtYlumMGsvWlIsh0wm/6mBNIKXK//YZesSrbHJeG6FzyYicSutrfAkN+GM3/+gSwUgJTLfS6Ttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835777; c=relaxed/simple;
	bh=RV9sRnDDHhotfIfV02JE6OLot8Q0FP7qvqbKBZju/0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzXKAQ3vBY7l11Y8ZwEDhCkZdZKJHhfuWS1JP2fRyhaO/QDBqEebm1/EKajQxliKg0LPIewJ5mlwm0LJBad0zW0cvv3YDxhCMLG5Do/HjKewzxvmywmEczNIlbhJnM+xj7Bj8/ZEwLsVVfJrk2xrvtjpzHBFbon+IwV30IqL6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hk+MU0ud; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716835774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=er9zpPdeV49PUDKJxQuU67Pcm6GfUTc6DyJ/Kh2n3Ps=;
	b=hk+MU0udtr0HNChCNQLJcx3cTkWPHUFGSke4cqDnMaAinZCfeglVkoXFrCkgHKIPcj/vS8
	5+suSvrGX/yBUQkJAYhpM9bZzfxk+BXKmwN6+x1fzE9loFKa+NCep4SzGeX6ZDPeDjPoVD
	nJPNl3W/6vLpHus+aEwdoiNWkiXGr7Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-WduY7cVbMhqgpZNhrAhrsw-1; Mon, 27 May 2024 14:49:32 -0400
X-MC-Unique: WduY7cVbMhqgpZNhrAhrsw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-354fc1122baso35510f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835771; x=1717440571;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er9zpPdeV49PUDKJxQuU67Pcm6GfUTc6DyJ/Kh2n3Ps=;
        b=acSjkYgx4/jKmWJXm5hxsrPwsXonA1i5/DtpBCGydsD5w3V9gP93lCahTP0XMYiG3L
         S51y5Goubi9vh9BGHOcpMbhEFRNPny1PpJGiiJflKwRBADPAhQwEy4Oc+x0275WINXIz
         7zEEGZohuEEa2ZV8vElUnnfk8rgXW2RVfal6rmDd2/WBjnBfHOuWqCJAPeb7XRpCYJkR
         RqLifB0SdTMD0Czr7nazyzUOhsh7Y8J0HJnTtgZ8dK2jnlZ1bmUw5XVd6RC5ZMzOO2pr
         ErbmpTWQmCKjjp8q6O64AOCAV1Mzfp40wzD3j5l9LvkHX/BWdNLS0KA4IEkKW2BlqYKC
         BqGA==
X-Gm-Message-State: AOJu0Yz/lGTSavKGlZuDdjHTQLNtBhzhiXgtQgU+PS8BDVQzNKHQvPuC
	tCRTbAcn1dhKir+KqUQl7heamdzbdv52mxV9roPwcmAr8idg8dIWA3ffjaYX+GKqudu5aD0q6Ur
	byOVYQ5d9rrroMrpagHKdIfz7NTD3GgVs9rw+DqYh6zHDpQ2EoiYLMdEW0oBzyQ==
X-Received: by 2002:a5d:498a:0:b0:354:f57f:7bdd with SMTP id ffacd0b85a97d-3552fe0292fmr6791882f8f.45.1716835771319;
        Mon, 27 May 2024 11:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnQ45GrmOD8w4iBJnqvAdq3EeerBIwdqkHXyVUjWg4x+oSG0Q4szUswefeawEbDqXjYy0Dsw==
X-Received: by 2002:a5d:498a:0:b0:354:f57f:7bdd with SMTP id ffacd0b85a97d-3552fe0292fmr6791871f8f.45.1716835770904;
        Mon, 27 May 2024 11:49:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817c81sm516319366b.28.2024.05.27.11.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 11:49:30 -0700 (PDT)
Message-ID: <00ba1dff-7c05-46e8-b0d9-a78ac1cfc198@redhat.com>
Date: Mon, 27 May 2024 20:49:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] mm: allow reuse of the lower 16 bit of the page
 type with an actual type
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20240527141454.113132-1-david@redhat.com>
 <20240527141454.113132-3-david@redhat.com>
 <ZlSmNzgkeYaCrPWc@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <ZlSmNzgkeYaCrPWc@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.05.24 um 17:26 schrieb Matthew Wilcox:
> On Mon, May 27, 2024 at 04:14:50PM +0200, David Hildenbrand wrote:
>> As long as the owner sets a page type first, we can allow reuse of the
>> lower 18 bit: sufficient to store an offset into a 64 KiB page, which
> 
> You say 18 here and 16 below.

Thanks, missed to fixup one instance after going back and forth.

> 
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
> 
> We could, but it's more instructions to check.

Maybe, and maybe not sufficient more that we care.

I was thinking of something like the following (probably broken but you should 
get the idea):

/*
  * If the _mapcount is negative, we might store a page type. The
  * page_type field corresponds to the most significant byte of the
  * _mapcount field. As the mapcount is initialized to -1, we have no
  * type as defaults. We have plenty of room to underflow the mapcount
  * before we would end up indicating a valid page_type.
  */
#define PAGE_TYPE_BASE	0x80
enum page_type {
	PT_buddy = PAGE_TYPE_BASE,
	PT_offline,
	PT_table,
	PT_guard,
	PT_hugetlb,
	PT_slab,
	/* we must forbid page_type == -1 */
	PT_unusable = 0xff
};

In struct page:

union {
	atomic_t _mapcount;

#if __BYTE_ORDER == __BIG_ENDIAN
	struct {
		uint16_t page_type_data;
		uint8_t page_type_reserved;
		uint8_t page_type;
	};
#else
	struct {
		uint8_t page_type;
		uint8_t page_type_reserved;
		uint16_t page_type_data;
	};
#end
};

#define PageType(page, type) (page->page_type == type)

Once could maybe also change page_has_type to simply work on the
fact that the highest bit must be set and any other bit of the type must be clear:

static inline int page_has_type(const struct page *page)
{
	return (page->page_type & PAGE_TYPE_BASE) &&
		page->page_type != 0xffff;
}

But just some thought.

> 
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
> 
> I think my original comment was misleading.  This should be:
> 
>   * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflow.

Makes sense.

> 
> How about we start at the top end and let people extend down?  ie:
> 
> #define PAGE_TYPE_BASE	0x80000000
> #define PG_buddy	0x40000000
> #define PG_offline	0x20000000
> #define PG_table	0x10000000
> #define PG_guard	0x08000000
> #define PG_hugetlb	0x04000000
> #define PG_slab		0x02000000
> #define PAGE_MAPCOUNT_RESERVE	(~0x0000ffff)
> 
> Now we can see that we have 9 flags remaining, which should last until
> we can have proper memdesc typing.

Also works for me.

Thanks!

-- 
Thanks,

David / dhildenb


