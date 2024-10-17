Return-Path: <linux-kernel+bounces-370643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE09A2FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC692876B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD721D618A;
	Thu, 17 Oct 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6aKEOyH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC691386B4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201666; cv=none; b=LbPInTT3IjiShlwaagKF4usCQG1gskSu/DDAikxf/GXFX3PIDbHyH78HzwRn/EZvXMHEiKgtPcte8KtbcKVb51bZlqW4AThhom8OJNelOpLsFmRa6I0bsEHnAFxkLNKgO5nVVix2fqnhf8MpqVDi5bKKjbALbkTPDcDJ2awCKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201666; c=relaxed/simple;
	bh=B+ko9HBfxEiTp9wpTAF/w99QrVe8GdZFDPZu1LgZy/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoJkL1wC41zpFkBn3WCHloXR8HkpvZVJ8PCSnvoYQ5+ohMNv6Jb3SsLpXH8pb3NrvAeEnR80YpzIGi7wX4DZkBs8W9uE11XlbDKrK5OwioumS3vVLk3Np8npg9rWQMgZivd15il6rKJH9PoXpjmDPwC6UFfxkZK0g7TKTq+SGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6aKEOyH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729201660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D1Ja5BIT74x8QhM7jluVk+G+4+UNajnO9Km/LU5HLRY=;
	b=Y6aKEOyHsrzh2DoiOgW8fKtgZzFJUfODbOyM9sIsWfw9xItQoG2c7ngy0Zx+sTK6ljTbHt
	4kPqzEK2uFmiQ+VXyl0+ByD25bcIDRdP2wuced7MyqjS3fg3DxzNZHTJ16RLpAfh+lZiro
	OK75dYkTuFlBiwxXyiwvI+Zi8pgh4zo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457--dOvsKhLNBa7Q3a_PHBxfQ-1; Thu, 17 Oct 2024 17:47:39 -0400
X-MC-Unique: -dOvsKhLNBa7Q3a_PHBxfQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso10757275e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201658; x=1729806458;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1Ja5BIT74x8QhM7jluVk+G+4+UNajnO9Km/LU5HLRY=;
        b=Yk4822BclwbviqxItMfEa17wL9f+LsdKprXjYtVlSJDBsENHjPY9dOqjx4/b+TpP/o
         uAjGV32pPHCGgB3j/Hm6vQXh8Fvx0k9Gsh1iX0x82Z6fovWOuobeRerCNTTNx0jEDM/q
         ccDerHNn5OKVZedfdB2ns+Ul9RFhG18OGJn5BMSwHTmqrnFHGDvttPn3+xpeCeiv43ZH
         yJTzR7EJDxkrkDcGoBclhS8QtQqUYY5vIHtnT3XVzZNCCZKimSN7tvCPZj306VFayl7M
         exooSvdL16jgE0hWyppXhaTdDQtL/QeNpYc60YhoK3zTqWqBb3jbX+jnjYAO1eU+qKYE
         rS7A==
X-Forwarded-Encrypted: i=1; AJvYcCVcImsLSyMOQTpnTaAHGYw2W3svzOozbKrhVC+WCzuO/vxQb0Y3tgCFPYalAsUpDqWz1Uen+VxZPdqxBNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCt+dQ06xgqf3ePtJP1rSGr7HA/XN7kYubpSCvbnBlIGYXB7f4
	8q9HhxhcLCYZboGhDNB//wjSZNgw2eh5pRpz+n3qIaV1nZclqOEJeSPxVq6VLfe1HUIoYATkFMD
	a+kmwMCy8mILxBMzuqfA6yQK/bepzGTpNkW1iqHShcwTe2j24UgC1+UonzLh/PUHftGE2kqS5
X-Received: by 2002:a05:600c:474e:b0:42c:baf9:bee7 with SMTP id 5b1f17b1804b1-4316164bfeemr882085e9.12.1729201657786;
        Thu, 17 Oct 2024 14:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVAs0TY2vaba7UV5yPhhZwK25Ny+SjMWQOhABZJY8GuSHRKL/AqoV9Ir//pqwvSO5MatSlLA==
X-Received: by 2002:a05:600c:474e:b0:42c:baf9:bee7 with SMTP id 5b1f17b1804b1-4316164bfeemr881995e9.12.1729201657328;
        Thu, 17 Oct 2024 14:47:37 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23f4a.dip0.t-ipconnect.de. [79.242.63.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431606c5a4bsm8047665e9.29.2024.10.17.14.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 14:47:36 -0700 (PDT)
Message-ID: <52bd4862-d6ce-48f6-9bc2-0f7376a56115@redhat.com>
Date: Thu, 17 Oct 2024 23:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
To: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Shigeru Yoshida <syoshida@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Minchan Kim <minchan@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
 <87v7xqmmxt.fsf@nvdebian.thelocal>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87v7xqmmxt.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.24 23:28, Alistair Popple wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 16.10.24 22:22, John Hubbard wrote:
>>> If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
>>> family of functions, and requests "too many" pages, then the call will
>>> erroneously leave pages pinned. This is visible in user space as an
>>> actual memory leak.
>>> Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM)
>>> calls
>>> to exhaust memory.
>>> The root cause of the problem is this sequence, within
>>> __gup_longterm_locked():
>>>       __get_user_pages_locked()
>>>       rc = check_and_migrate_movable_pages()
>>> ...which gets retried in a loop. The loop error handling is
>>> incomplete,
>>> clearly due to a somewhat unusual and complicated tri-state error API.
>>> But anyway, if -ENOMEM, or in fact, any unexpected error is returned
>>> from check_and_migrate_movable_pages(), then __gup_longterm_locked()
>>> happily returns the error, while leaving the pages pinned.
>>> In the failed case, which is an app that requests (via a device
>>> driver)
>>> 30720000000 bytes to be pinned, and then exits, I see this:
>>>       $ grep foll /proc/vmstat
>>>           nr_foll_pin_acquired 7502048
>>>           nr_foll_pin_released 2048
>>> And after applying this patch, it returns to balanced pins:
>>>       $ grep foll /proc/vmstat
>>>           nr_foll_pin_acquired 7502048
>>>           nr_foll_pin_released 7502048
>>> Fix this by unpinning the pages that __get_user_pages_locked() has
>>> pinned, in such error cases.
>>> Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix
>>> check_and_migrate_movable_pages() return codes")
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: Shigeru Yoshida <syoshida@redhat.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>>    mm/gup.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index a82890b46a36..24acf53c8294 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -2492,6 +2492,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>>>      		/* FOLL_LONGTERM implies FOLL_PIN */
>>>    		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
>>> +
>>> +		/*
>>> +		 * The __get_user_pages_locked() call happens before we know
>>> +		 * that whether it's possible to successfully complete the whole
>>> +		 * operation. To compensate for this, if we get an unexpected
>>> +		 * error (such as -ENOMEM) then we must unpin everything, before
>>> +		 * erroring out.
>>> +		 */
>>> +		if (rc != -EAGAIN && rc != 0)
>>> +			unpin_user_pages(pages, nr_pinned_pages);
>>> +
>>>    	} while (rc == -EAGAIN);
>>
>> Wouldn't it be cleaner to simply have here after the loop (possibly
>> even after the memalloc_pin_restore())
>>
>> if (rc)
>> 	unpin_user_pages(pages, nr_pinned_pages);
>>
>> But maybe I am missing something.
> 
> I initially thought the same thing but I'm not sure it is
> correct. Consider what happens when __get_user_pages_locked() fails
> earlier in the loop. In this case it will have bailed out of the loop
> with rc <= 0 but we shouldn't call unpin_user_pages().

Ah, I see what you mean, I primarily only stared at the diff.

We should likely avoid using nr_pinned_pages as a temporary variable that
can hold an error value.

-- 
Cheers,

David / dhildenb


