Return-Path: <linux-kernel+bounces-511752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99DA32F38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720423A75C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A7261369;
	Wed, 12 Feb 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZP9s4RH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA97253B4B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387273; cv=none; b=kvXfwBVG3LdrhwlnWbjHat8uXdGTsI3o41HF1H4EKCkaczuU9OBZopxG8aT/7IA0DsNRXskcHD5rknWG7wJSXsp0zQulZu6E0/RkP0b6TBDyCP+djhlhz6eat4BTvl0QvlC4pMp5xAf5MM/o5wWBX5i9bUm1sEHKV1D0cDJqHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387273; c=relaxed/simple;
	bh=uHysvwfy0YOcXr4Xow8BhFVHFTTibAfWz89EgwgT+6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gsV+Q+TMN/Bry4z11rotTTlzWcAvih5ttsuw8bdG5Pkihk3Zch8QaG+bEEfzgmaZhnRxqR0IQAYbSp5SHHT6/SQ64IFR+3s6I2cdjHdg7zgb4f7CVnjW9/PMelQ/SO7YUzJABmNa0q+df0fXXMiON4mv72YFWZl+aSQVdrO2Qn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZP9s4RH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739387271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kjYE41T9eH6sBeVON8mdbKg+vcLjv+QgGNIcmpOCleo=;
	b=ZZP9s4RHaCsFvEB5OkYYwdTBRTZg9iArxCQENk7fE0D9fNJFvyscpGCOLmzU7virsTfvWu
	xuzl2GUxpJYyX4tkeuaAabaNjlyk0rq9QGRai3xf1YabsEpmjAMtEKIRDjynwQP6EoAShN
	C+DctCSPUZEa8UjBagURMMMvJ0eJRYQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-rcrN4_EHPh-zmyYkCPeXuQ-1; Wed, 12 Feb 2025 14:07:50 -0500
X-MC-Unique: rcrN4_EHPh-zmyYkCPeXuQ-1
X-Mimecast-MFC-AGG-ID: rcrN4_EHPh-zmyYkCPeXuQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c747c72so337525e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387269; x=1739992069;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjYE41T9eH6sBeVON8mdbKg+vcLjv+QgGNIcmpOCleo=;
        b=HvPHbBANu0IsG6N0RVBnwqfGvXjESuY82sFguns6W/Zq1j/FdE7kQJnZzmDfNfjswM
         oSyJG4+e5xRf8ThIhmWTKbIXwKgDsKnb+7NSmcePPZYbruuEv8GB3JMcf8rqAfA80UAU
         Tu6V05etWCV4re4Tvuhmb5I0OqieRjkfdkRKaWw44hafmWoQTN4IDpqoYHnKua6Z0uXi
         VAeHZ/MEL25CL1lQMoPNY7z8YDqpUJj9PTvJ8iwetm+d2zG7RGVfLQjxKck3L7rUthKj
         2VDxJqcNmQBvtk5DmpoSBle3tHoRbhRmMUL12JGqNPytu/yVmqIzZrqv/iq5ZVBS7of7
         znJw==
X-Forwarded-Encrypted: i=1; AJvYcCXgy3FcvqY9Nrl5YE3UcvK9aIxKZRRgllw+S49M0ndSojYIKGAQZifaOFbNmsYvKFRPaimzc9ipBKTsnxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bB9lmc1KtJ9+xqXSbaNoZ88zuee/2FAhyKaOdwekXYFNct4Z
	+Id2Y8IiH7eR7J7LyoravU5ZH5bhsAKwACXEcIRmmHRoQp5eq4P8xoxcRjbBPkhWBjkCUm4xOrk
	5xZdFnTHEOdRY1whOa4WPSiUhrob9Q+JNywksNKAAHtgIfTjjE1w2qy5WHekrjg==
X-Gm-Gg: ASbGnctAkW95fEb3rURhOfwqoMsEy9VLSCPb3zL7FazqNN3gAyKLoWcVNdJ2Ba3mvCz
	1MNo4yvxZ2bvqQBaPIEsEbZ3q5nsmoHPz5h/oBY/Wr7byYZZVs/n4aG9V7FDzSpu+eG8OPoARMI
	wh0KjpbnlWdjcEdX5WoJ8pdONNF/FlnCJxq20LjVGRkQ7D2FmUw05BdcfeTum0vhr1yj06PEjVV
	K/bfZq8wlz4Xq+4+g1lFA83daaZAGgSiVl/4hv6zMmplhich6T0OjZo80IDE/3FYOk9Q/6dfsZ9
	7bwC7wEO5ZG2+3TflnioENPnfhvBnF4UEB0kXuneBhCkGmzgNW5QLpLZEG6+ayViGJmRMYqSsCd
	8ft8nhCCurBZP8R3CVb9vi2gWuNTF5g==
X-Received: by 2002:a05:600c:3ba7:b0:439:4696:c063 with SMTP id 5b1f17b1804b1-43959a8401cmr34041505e9.19.1739387268742;
        Wed, 12 Feb 2025 11:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqTIsCjYY4j8RDJFO1zTxybX0Qjo8xFUOB2V/U5twoI9Bd2ixKNNFZ9vuxKiE+nOJ2cIpEMA==
X-Received: by 2002:a05:600c:3ba7:b0:439:4696:c063 with SMTP id 5b1f17b1804b1-43959a8401cmr34041135e9.19.1739387268298;
        Wed, 12 Feb 2025 11:07:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:a600:1e3e:c75:d269:867a? (p200300cbc70ca6001e3e0c75d269867a.dip0.t-ipconnect.de. [2003:cb:c70c:a600:1e3e:c75:d269:867a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06e309sm28144855e9.24.2025.02.12.11.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 11:07:47 -0800 (PST)
Message-ID: <e7f45603-17f4-4ff7-9d84-1331f0f1b447@redhat.com>
Date: Wed, 12 Feb 2025 20:07:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] rust: page: Support borrowing `struct page` and
 physaddr conversion
To: Asahi Lina <lina@asahilina.net>, Zi Yan <ziy@nvidia.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Jann Horn <jannh@google.com>,
 Matthew Wilcox <willy@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 airlied@redhat.com, Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
 Muchun Song <muchun.song@linux.dev>
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
 <Z6CTLB2NggwYafi9@phenom.ffwll.local>
 <41ca3445-80cd-43c1-8f9e-634c195c9187@asahilina.net>
 <37A0729B-A711-4D45-B9F0-328FDB9ADD28@nvidia.com>
 <0e19e1c3-293b-4740-93f3-2c410893288b@redhat.com>
 <82047858-480a-45e3-b826-3a46fbebe842@asahilina.net>
 <f1498b22-0bc1-489a-8c2c-35aa48c7fe7d@redhat.com>
 <1e9ae833-4293-4e48-83b2-c0af36cb3fdc@asahilina.net>
 <026c1a0c-e53a-4a5e-92da-6e4f18ce0fee@redhat.com>
 <Z6MV_Y9WRdlBYeRs@phenom.ffwll.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z6MV_Y9WRdlBYeRs@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.02.25 08:40, Simona Vetter wrote:
> On Tue, Feb 04, 2025 at 03:38:17PM +0100, David Hildenbrand wrote:
>>>> It can still race with memory offlining, and it refuses ZONE_DEVICE
>>>> pages. For the latter, we have a different way to check validity. See
>>>> memory_failure() that first calls pfn_to_online_page() to then check
>>>> get_dev_pagemap().
>>>
>>> I'll give it a shot with these functions. If they work for my use case,
>>> then it's good to have extra checks and I'll add them for v2. Thanks!
>>
>> Let me know if you run into any issues.
>>
>>>
>>>>
>>>>>
>>>>> If the answer is "no" then that's fine. It's still an unsafe function
>>>>> and we need to document in the safety section that it should only be
>>>>> used for memory that is either known to be allocated and pinned and will
>>>>> not be freed while the `struct page` is borrowed, or memory that is
>>>>> reserved and not owned by the buddy allocator, so in practice correct
>>>>> use would not be racy with memory hot-remove anyway.
>>>>>
>>>>> This is already the case for the drm/asahi use case, where the pfns
>>>>> looked up will only ever be one of:
>>>>>
>>>>> - GEM objects that are mapped to the GPU and whose physical pages are
>>>>> therefore pinned (and the VM is locked while this happens so the objects
>>>>> cannot become unpinned out from under the running code),
>>>>
>>>> How exactly are these pages pinned/obtained?
>>>
>>> Under the hood it's shmem. For pinning, it winds up at
>>> `drm_gem_get_pages()`, which I think does a `shmem_read_folio_gfp()` on
>>> a mapping set as unevictable.
>>
>> Thanks. So we grab another folio reference via
>> shmem_read_folio_gfp()->shmem_get_folio_gfp().
>>
>> Hm, I wonder if we might end up holding folios residing in
>> ZONE_MOVABLE/MIGRATE_CMA longer than we should.
>>
>> Compared to memfd_pin_folios(), which simulates FOLL_LONGTERM and makes sure
>> to migrate pages out of ZONE_MOVABLE/MIGRATE_CMA.
>>
>> But that's a different discussion, just pointing it out, maybe I'm missing
>> something :)
> 
> Good GPU Drivers (tm) are supposed to have a shrinker so we can at least
> nuke some of them again. Some folks even looked into hooking up a migrate
> callback through the address_space (or wherever that hook was, this is
> from memory) so we can make this somewhat reliable. So yeah we're hogging
> ZONE_MOVEABLE unduly still.

Hmmm, so we should really be migrating pages out of 
ZONE_MOVABLE/MIGRATE_CMA here, just like we now properly do in 
memfd_pin_folios().

> 
> The other side is that there's about 2-3 good drivers (msm, i915, xe
> should have a shrinker now too but I didn't check). The others all fall
> various levels of short, or still have 3 times cargo-culted versions of
> i915's pin-as-a-lock design and get it completely wrong.

:(

> 
> So yeah I'm aware this isn't great, and we're at least glacially slowly
> moving towards a common shrinker infrastructure that maybe in a glorious
> future gets all this right. I mean it took us 15+ years to get to a
> cgroups controller after all too, and that was also a well known issue of
> just being able to hog memory with no controls and potentially cause
> havoc.

I guess that means job security for us, haha :)

-- 
Cheers,

David / dhildenb


