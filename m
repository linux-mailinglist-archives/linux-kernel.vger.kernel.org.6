Return-Path: <linux-kernel+bounces-511746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE5A32F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420CF7A33B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F1260A5D;
	Wed, 12 Feb 2025 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWAl1IO6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9A257AC7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386898; cv=none; b=FqRJuNJUDS39eago+arL8fGwKx2pzD9bTasSmuP1zKzIl0vxfjkwAAsijrsJJPLdyA6EOElWYJ7/FkuIVb+XVelQtXVPJkMJtJ6H0SBnRzYReesj0B85Io3SjcjPVjKFi9gJV/m0B9meCnwg+5BNwDe6dTMrpQ/D2HzwdJMSjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386898; c=relaxed/simple;
	bh=LqMoC5utCrT4bUaFZZWRG9lEJQPLZdCaPqVj0HZKTJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKN7MXUCdJmJoJ3JEoHEMZ4ue7DKUm6abfeOYvVcTE9egKAQch8Ov1ZOITjCzdSaaSs3hSXI9PVuLcb6sh/PeT4FeKPXxTSH/TXvMDJd0EGFlq4q1fdAGxKQSxUaQkF1mIYibjuQlHrnIHrKJdgzVg4C5Mkk3voeuAVqkOUyNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWAl1IO6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739386894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VnpKOCL9F8DbCzuG0WiiawmSIQd7cJlByrW6DA7MXYI=;
	b=BWAl1IO6sYnJG85BDtKf16wJGhGAlrnFDLTtnaikMCkF5odIK3yI2odOKbRF5s8K/PP9ty
	MHQH1TiCCqSZmqTXYd/PU17VUfHPrS90OYDxGhUwT5ATqERpeRsMj9tsZZ+IXgtO4Q6U5E
	EE/c/K2eRKwsTcB1hf2wsA9YPwuuoJ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-3HehlkzaMEOwsIGpxDdN2g-1; Wed, 12 Feb 2025 14:01:32 -0500
X-MC-Unique: 3HehlkzaMEOwsIGpxDdN2g-1
X-Mimecast-MFC-AGG-ID: 3HehlkzaMEOwsIGpxDdN2g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dd8d11139so19119f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739386891; x=1739991691;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VnpKOCL9F8DbCzuG0WiiawmSIQd7cJlByrW6DA7MXYI=;
        b=c2adpjJ2bvBlh7njIMwYLozH+xmBMhb/IEMNM866Id8Pu7rrA8EkYkvW7TtHni89tx
         vsozJfTin9fU39VP/ldpUCvphgTP/Q8dbebUOTkilbaTlp4EVMkx2/yNY2hmyaCQTFVl
         Xi/waiT+aiSAgIgr2oFzmiMh0Sz7HKH+LHGVWwaHRy/JltkL0Kz87m937Fmna2TAHoZq
         EUbq+/NjI2ANTYp8Weuq8sGXxlfWhU6A5s/ez+5TAEgviXf9RZgo5OJplb1/Hsw1DbWZ
         SobycZDEjV9mI0dnerb06DPojw0eFMnaGybTALOX8oaHQPyur7xoFoWpalgIFebrbjcS
         nRlA==
X-Forwarded-Encrypted: i=1; AJvYcCVA+JKH14zzGVC0X92b4qCCj3TgppyAVY+ryQAd/UKU7uo49xJdC/oysg+saRohHKoFKubuncnv3g7ZqaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwS/0VuE+iJhnEHulIF48adSSP6q8ztTyN0bRf03qNaJVO5Pmg
	YDA2V3Qsg83a9BbQi/eNI+htzE82gvorzWngdTqX4I4GCGMtROMj3TY0rmZgdcwYItJioPkTMeY
	JYo9p67upra/PBRQp5h/eOBpb0juedfkUO4hKP0nCeo9riOj38ntl6NY1p/onrw==
X-Gm-Gg: ASbGnctvJ3q94wv8V/Vn+/2ZbJN5ERX4SKevinWyGkpa7gm5SDVMIasnZ9NyuSwtHb1
	LOLbCo+51uiWy2glMpH7LLl2xD+ismrtMoG5bGeW+tDIq8F3gfk0tYD+AyrC5n3wzMFx0ExcHqI
	xJAu+dsvDSYllmh/TmlknOVbhrHdtCx5LqHLMc337SbLoThO58Ij6YYC01GZUORE9GK44FI2omR
	aVVTf2TC4reNI6br+u4Akdr/STauxZ5nADf/xIiWJg1AjPekX9cyCHaUDmkRHh4DFzm7YVMjewo
	QzTqCtb7Xa+0A+2bEzHoWl7+foNJw9nGQ0fhkY33EJkPmBIiLkre5w08bHx+tjeJrqXQ6vn6u8R
	DLhCYS++v7k2Sj7K5ns0UAHht/70PLw==
X-Received: by 2002:a05:6000:1fac:b0:38d:e584:81ea with SMTP id ffacd0b85a97d-38dea2f9ab6mr3331394f8f.45.1739386891465;
        Wed, 12 Feb 2025 11:01:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMQEuHs2ARaifFarl1hlb7XuIU2Uf3rWR3SR85DWiFYlcoHcyJgYvPwxFa9XALu3tB9xPEVQ==
X-Received: by 2002:a05:6000:1fac:b0:38d:e584:81ea with SMTP id ffacd0b85a97d-38dea2f9ab6mr3331310f8f.45.1739386890296;
        Wed, 12 Feb 2025 11:01:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:a600:1e3e:c75:d269:867a? (p200300cbc70ca6001e3e0c75d269867a.dip0.t-ipconnect.de. [2003:cb:c70c:a600:1e3e:c75:d269:867a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc2f6aeafsm17010526f8f.20.2025.02.12.11.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 11:01:29 -0800 (PST)
Message-ID: <c0373279-a257-454f-98d6-9825700831f6@redhat.com>
Date: Wed, 12 Feb 2025 20:01:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] rust: page: Support borrowing `struct page` and
 physaddr conversion
To: Asahi Lina <lina@asahilina.net>, Zi Yan <ziy@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
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
 <cc1cd991-1871-4929-851e-d9672a45dcf0@asahilina.net>
 <6bcd3315-a0f9-463c-ab97-a43736f9b4f4@redhat.com>
 <2a513c3e-818c-4040-b3d3-7835861bab4f@asahilina.net>
 <0dffaa7d-340f-4ce1-9a2e-54cfd9079266@redhat.com>
 <bfc81fb0-917a-4518-851b-c7fcf3a91c5b@asahilina.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bfc81fb0-917a-4518-851b-c7fcf3a91c5b@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.02.25 20:18, Asahi Lina wrote:
> 
> 
> On 2/7/25 2:58 AM, David Hildenbrand wrote:
>> On 04.02.25 22:06, Asahi Lina wrote:
>>>
>>>
>>> On 2/5/25 5:10 AM, David Hildenbrand wrote:
>>>> On 04.02.25 18:59, Asahi Lina wrote:
>>>>> On 2/4/25 11:38 PM, David Hildenbrand wrote:
>>>>>>>>> If the answer is "no" then that's fine. It's still an unsafe
>>>>>>>>> function
>>>>>>>>> and we need to document in the safety section that it should
>>>>>>>>> only be
>>>>>>>>> used for memory that is either known to be allocated and pinned and
>>>>>>>>> will
>>>>>>>>> not be freed while the `struct page` is borrowed, or memory that is
>>>>>>>>> reserved and not owned by the buddy allocator, so in practice
>>>>>>>>> correct
>>>>>>>>> use would not be racy with memory hot-remove anyway.
>>>>>>>>>
>>>>>>>>> This is already the case for the drm/asahi use case, where the pfns
>>>>>>>>> looked up will only ever be one of:
>>>>>>>>>
>>>>>>>>> - GEM objects that are mapped to the GPU and whose physical
>>>>>>>>> pages are
>>>>>>>>> therefore pinned (and the VM is locked while this happens so the
>>>>>>>>> objects
>>>>>>>>> cannot become unpinned out from under the running code),
>>>>>>>>
>>>>>>>> How exactly are these pages pinned/obtained?
>>>>>>>
>>>>>>> Under the hood it's shmem. For pinning, it winds up at
>>>>>>> `drm_gem_get_pages()`, which I think does a
>>>>>>> `shmem_read_folio_gfp()` on
>>>>>>> a mapping set as unevictable.
>>>>>>
>>>>>> Thanks. So we grab another folio reference via shmem_read_folio_gfp()-
>>>>>>> shmem_get_folio_gfp().
>>>>>>
>>>>>> Hm, I wonder if we might end up holding folios residing in
>>>>>> ZONE_MOVABLE/
>>>>>> MIGRATE_CMA longer than we should.
>>>>>>
>>>>>> Compared to memfd_pin_folios(), which simulates FOLL_LONGTERM and
>>>>>> makes
>>>>>> sure to migrate pages out of ZONE_MOVABLE/MIGRATE_CMA.
>>>>>>
>>>>>> But that's a different discussion, just pointing it out, maybe I'm
>>>>>> missing something :)
>>>>>
>>>>> I think this is a little over my head. Though I only just realized that
>>>>> we seem to be keeping the GEM objects pinned forever, even after unmap,
>>>>> in the drm-shmem core API (I see no drm-shmem entry point that would
>>>>> allow the sgt to be freed and its corresponding pages ref to be
>>>>> dropped,
>>>>> other than a purge of purgeable objects or final destruction of the
>>>>> object). I'll poke around since this feels wrong, I thought we were
>>>>> supposed to be able to have shrinker support for swapping out whole GPU
>>>>> VMs in the modern GPU MM model, but I guess there's no
>>>>> implementation of
>>>>> that for gem-shmem drivers yet...?
>>>>
>>>> I recall that shrinker as well, ... or at least a discussion around it.
>>>>
>>>> [...]
>>>>
>>>>>>
>>>>>> If it's only for crash dumps etc. that might even be opt-in, it makes
>>>>>> the whole thing a lot less scary. Maybe this could be opt-in
>>>>>> somewhere,
>>>>>> to "unlock" this interface? Just an idea.
>>>>>
>>>>> Just to make sure we're on the same page, I don't think there's
>>>>> anything
>>>>> to unlock in the Rust abstraction side (this series). At the end of the
>>>>> day, if nothing else, the unchecked interface (which the regular
>>>>> non-crash page table management code uses for performance) will let you
>>>>> use any pfn you want, it's up to documentation and human review to
>>>>> specify how it should be used by drivers. What Rust gives us here is
>>>>> the
>>>>> mandatory `unsafe {}`, so any attempts to use this API will necessarily
>>>>> stick out during review as potentially dangerous code that needs extra
>>>>> scrutiny.
>>>>>
>>>>> For the client driver itself, I could gate the devcoredump stuff behind
>>>>> a module parameter or something... but I don't think it's really worth
>>>>> it. We don't have a way to reboot the firmware or recover from this
>>>>> condition (platform limitations), so end users are stuck rebooting to
>>>>> get back a usable machine anyway. If something goes wrong in the
>>>>> crashdump code and the machine oopses or locks up worse... it doesn't
>>>>> really make much of a difference for normal end users. I don't think
>>>>> this will ever really happen given the constraints I described, but if
>>>>> somehow it does (some other bug somewhere?), well... the machine was
>>>>> already in an unrecoverable state anyway.
>>>>>
>>>>> It would be nice to have userspace tooling deployed by default that
>>>>> saves off the devcoredump somewhere, so we can have a chance at
>>>>> debugging hard-to-hit firmware crashes... if it's opt-in, it would only
>>>>> really be useful for developers and CI machines.
>>>>
>>>> Is this something that possibly kdump can save or analyze? Because that
>>>> is our default "oops, kernel crashed, let's dump the old content so we
>>>> can dump it" mechanism on production systems.
>>>
>>> kdump does not work on Apple ARM systems because kexec is broken and
>>> cannot be fully fixed, due to multiple platform/firmware limitations. A
>>> very limited version of kexec might work well enough for kdump, but I
>>> don't think anyone has looked into making that work yet...
>>>
>>>> but ... I am not familiar with devcoredump. So I don't know when/how it
>>>> runs, and if the source system is still alive (and remains alive --  in
>>>> contrast to a kernel crash).
>>>
>>> Devcoredump just makes the dump available via /sys so it can be
>>> collected by the user. The system is still alive, the GPU is just dead
>>> and all future GPU job submissions fail. You can still SSH in or (at
>>> least in theory, if enough moving parts are graceful about it) VT-switch
>>> to a TTY. The display controller is not part of the GPU, it is separate
>>> hardware.
>>
>>
>> Thanks for all the details (and sorry for the delay, I'm on PTO until
>> Monday ... :)
>>
>> (regarding the other mail) Adding that stuff to rust just so we have a
>> devcoredump that ideally wouldn't exist is a bit unfortunate.
>>
>> So I'm curious: we do have /proc/kcore, where we do all of the required
>> filtering, only allowing for reading memory that is online, not
>> hwpoisoned etc.
>>
>> makedumpfile already supports /proc/kcore.
>>
>> Would it be possible to avoid Devcoredump completely either by dumping /
>> proc/kcore directly or by having a user-space script that walks the page
>> tables to dump the content purely based on /proc/kcore?
>>
>> If relevant memory ranges are inaccessible from /proc/kcore, we could
>> look into exposing them.
> 
> I'm not sure that's a good idea... the dump code runs when the GPU
> crashes, and makes copies of all the memory pages into newly allocated
> pages (this is around 16MB for a typical dump, and if allocation fails
> we just bail and clean up). Then userspace can read the coredump at its
> leisure. AIUI, this is exactly the intended use case of devcoredump. It
> also means that anyone can grab a core dump with just a `cp`, without
> needing any bespoke tools.
> 
> After the snapshot is taken, the kernel will complete (fail) all GPU
> jobs, which means much of the shared memory will be freed and some
> structures will change contents.

Ah, okay, that's an issue.

> If we defer the coredump to userspace,
> then it would not be able to capture the state of all relevant memory
> exactly at the crash time, which could be very confusing.
> 
> In theory I could change the allocators to not free or touch anything
> after a crash, and add guards to any mutations in the driver to avoid
> any changes after a crash... but that feels a lot more brittle and
> error-prone than just taking the core dump at the right time.

Agreed.

-- 
Cheers,

David / dhildenb


