Return-Path: <linux-kernel+bounces-434717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F089E6A1B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE3016A209
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404E1F4734;
	Fri,  6 Dec 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0CygbYQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCB1EF0A5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477379; cv=none; b=u4c/6++QeRU0EAUeKk5RDD+t0w5t7Qr/23MMOBs+AasPPZwzDdIJxIPbISphorb1rUvUdw4U0sauhXiB9kwIBmeVkhIZ6NOxlqucHxnZdAl76nU5cN59XsEg+0fK+Fr1zXJ2gB9Yr+lOOuDay28w8wwsml/oAcpiYVr3JtvJ8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477379; c=relaxed/simple;
	bh=4P3bXl+zXqlVCm5KX7YrScArn1Ic9UFjpwqtmEyN4QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqV3KFHg5g3O3KzoIc/hhMsmPhe0hzzmFRcCnJldHnbpzGVEZGH+y2nCkZePt7ZqwN9ECY5z9UVzfN28b4E3SvOx0j7CS/FBPH3FrPtkZ1N02onJxUcMaRHMnjRMtL2cKYWpWN4J6VqLF+qMQCDXXhC3Hp3+PwZUrJfZwOO2xlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0CygbYQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733477376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G3OdmW3ZTheF+C2xsg2Rq2qHZNGCYQVLBHUY/AWR+lE=;
	b=S0CygbYQCtIE+4YkVKy6p6qfNMXDqyjkKAwHbp7+rWwwVJMni3S69KU2jfEZ3USDQmMPtI
	R54st2fOiqMVZMpLACuu4lc9b00qCiIalqW3jOkpnaWFEpKEQVDxsaS8yYSUngeRFafGQp
	crg6+/JOE+/xLIPIw/bYYR3aFkPIeS4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-LVudIRAFMpOo6Is8J9eG_A-1; Fri, 06 Dec 2024 04:29:35 -0500
X-MC-Unique: LVudIRAFMpOo6Is8J9eG_A-1
X-Mimecast-MFC-AGG-ID: LVudIRAFMpOo6Is8J9eG_A
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434996c1aa7so15471895e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733477374; x=1734082174;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3OdmW3ZTheF+C2xsg2Rq2qHZNGCYQVLBHUY/AWR+lE=;
        b=IAks++VYqhrE8p5uxGZFVXTCrNNk4+I90SL5SjfluqXSbt5h/8tQiHGfUxK/CRgUjj
         ChJ3+Rf+WvoUC/BpGbeNE9NFLuUGo7KxzwHIHFhQ8mN6GoUB5d2wGCPALF+ycHZA0JDe
         tOtaoEt7bXWxd+T3j8NiTZdVb9cIrYm3SKyYV6FIJBzAfjRXukqMYREPWz59ktlVgNgl
         cVhWvegJM39LXhrkLvMT8/mPxOqNI49FS54GRmSiEJaQrohgzcFtq7h8D9KYNMwGC2yd
         3q5fb9OEb4v/5tEh3cLzdPCsA1TrBsCyHiWCEdeDeiGIozp9LuqXImBZ8DCiP4pvP9cW
         dVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQHUEhb7csRddXnyc8bvbv45cwx37oa0qb1uyt1zLVCrHfWa+JYBMIpCs4cYk8WjSo8/XmC/fpX5twLX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2RW4247XCp98J/6/voKqsTdVKEvBXtXlRRefPedWYb+bBvWOG
	ZYcMkyMXpfITLMKedz4oxxPnZ9TDvmxfDItPXX3N2LPK+fSsw4gzt9Na7eUAwq8hleg29RPBYKM
	xYZjAzPhffV18u5OUeEbjZWic2QDDIYVgYrvUORBYSZliNlJ7A4RfCfm5zdfQqA==
X-Gm-Gg: ASbGnct6Ua3w95smEGhYtHBTk51gWE4Cqo4OAHtZSkDXyvleC0OeO/S44hTTI0WPK3k
	XjQVga6BL0PCYJom86zVCE2lHAh3qaaQ4Sr3t54x8URUcQlqnSTRvFACtyMhyap6+3fRfUWqDld
	kJPp8xGvKkuDeOj8pN51T91tuqpq7V92dD9CLiptHnVpd75IYOWa6hbIRzkxbyYUwRtSLZOrtbF
	zHdHOU2YbrqxdrPczvh686BRT+fnXdxVQD0xCbtJRPPvFZe7H5Y5ow7vE3PBEmXVlglmie1LMSy
	JYlDTm4QYAOcuVerr+lMdgGQcwJt4sbF+8oJFUbLjUCVxpRpQYXCXR+g7oU623TwnK6Z/71/3dw
	X6A==
X-Received: by 2002:a05:600c:3155:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-434dded67b1mr17297535e9.20.1733477374206;
        Fri, 06 Dec 2024 01:29:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa6UcXKjzynFFC/lQ8L9mqcwdputm4E+oGdTLs9BXmx1zNYs9K7S3cOzK3DfM522J8C9LaUg==
X-Received: by 2002:a05:600c:3155:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-434dded67b1mr17297315e9.20.1733477373749;
        Fri, 06 Dec 2024 01:29:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7? (p200300cbc71bd0001d1f238eaeafdbf7.dip0.t-ipconnect.de. [2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0dab9esm50876125e9.22.2024.12.06.01.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:29:32 -0800 (PST)
Message-ID: <c43a3149-c84b-448b-be80-1e026740911c@redhat.com>
Date: Fri, 6 Dec 2024 10:29:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: support FOLL_FORCE|FOLL_WRITE
To: Heiko Carstens <hca@linux.ibm.com>,
 Guillaume Morin <guillaume@morinfr.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Eric Hagberg <ehagberg@janestreet.com>, linux-s390@vger.kernel.org
References: <Z1EJssqd93w2erMZ@bender.morinfr.org>
 <20241206045019.GA2215843@thelio-3990X> <Z1KLLXpzrDac-oqF@bender.morinfr.org>
 <20241206092453.9026-A-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241206092453.9026-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.12.24 10:24, Heiko Carstens wrote:
> On Fri, Dec 06, 2024 at 06:27:09AM +0100, Guillaume Morin wrote:
>> On 05 Dec 21:50, Nathan Chancellor wrote:
>>>>   #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
>>>> +/* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
>>>> +static inline bool can_follow_write_pud(pud_t pud, struct page *page,
>>>> +					struct vm_area_struct *vma,
>>>> +					unsigned int flags)
>>>> +{
>>>> +	/* If the pud is writable, we can write to the page. */
>>>> +	if (pud_write(pud))
>>>> +		return true;
>>>> +
>>>> +	if (!can_follow_write_common(page, vma, flags))
>>>> +		return false;
>>>> +
>>>> +	/* ... and a write-fault isn't required for other reasons. */
>>>> +	return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
>>>
>>> This looks to be one of the first uses of pud_soft_dirty() in a generic
>>> part of the tree from what I can tell, which shows that s390 is lacking
>>> it despite setting CONFIG_HAVE_ARCH_SOFT_DIRTY:
>>>
>>>    $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper defconfig mm/gup.o
>>>    mm/gup.c: In function 'can_follow_write_pud':
>>>    mm/gup.c:665:48: error: implicit declaration of function 'pud_soft_dirty'; did you mean 'pmd_soft_dirty'? [-Wimplicit-function-declaration]
>>>      665 |         return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
>>>          |                                                ^~~~~~~~~~~~~~
>>>          |                                                pmd_soft_dirty
>>>
>>> Is this expected?
>>
>> Yikes! It does look like an oversight in the s390 code since as you said
>> it has CONFIG_HAVE_ARCH_SOFT_DIRTY and pud_mkdirty seems to be setting
>> _REGION3_ENTRY_SOFT_DIRTY. But I'll let the s390 folks opine.
>>
>> I don't mind dropping the pud part of the change (even if that's a bit
>> of a shame) if it's causing too many issues.
> 
> It would be quite easy to add pud_soft_dirty() etc. helper functions
> for s390, but I think that would be the wrong answer to this problem.
> 
> s390 implements pud_mkdirty(), but it is only used in the context of
> HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD, which s390 doesn't support. So
> this function should probably be removed from s390's pgtable.h.
> 
> Similar the pud_soft_dirty() and friends helper functions should only
> be implemented if common code support for soft dirty would exist,
> which is currently not the case. Otherwise similar fallbacks like for
> pmd_soft_dirty() (-> include/linux/pgtable.h) would also need to be
> implemented.
> 
> So IMHO the right fix (at this time) seems to be to remove the above
> pud part of your patch, and in addition we should probably also drop
> the partially implemented pud level soft dirty bits in s390 code,
> since that is dead code and might cause even more confusion in future.
> 
> Does that make sense?

As hugetlb does not support softdirty, and PUDs are currently only 
possible (weird DAX thing put aside) with hugetlb, it makes sense to 
drop the pud softdirty thingy.

-- 
Cheers,

David / dhildenb


