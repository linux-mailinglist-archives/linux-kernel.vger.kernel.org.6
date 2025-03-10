Return-Path: <linux-kernel+bounces-553950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0CBA5910D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F531888E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E38226870;
	Mon, 10 Mar 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGePVzJG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733D226529
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602233; cv=none; b=q7GlLjNRYcGANnbKydvuyx9Q73BQmsAl4/uC3tCfU5Q9tMPA98QA7hvGNX7t4tpuqKxYfKeY35OlEO13+/BbmnF0Fj3a1dXIV16KExx53vkvn078LpzaZ/v6T7PDbitTrhXR6gbkAZWZYsfStINIFwubvVKbg/3py8ybWiROxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602233; c=relaxed/simple;
	bh=KfKRHQ8QFUYVsqgaPCXNdrqSt2cCVkpxSjrd0RLuCLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wlkt2sa1gMyBJ9aZ2y94xlMxQ9qDGvSG+gJ7xDczuR9uxzvrZ5Zko/l71Shx8SKlBin2VOuw8AWP1bprqLqT3qEUOpRL2hyvRLXQu+T6fm6o4/vJj2AZielJdA3JIbQSitvyIzz3SoXg9mtrtrXWa1L6bKeaeQbFF/XQZxjOwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGePVzJG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741602230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/12pVfGrHfAC9KyGDgoRmy2bzHmGQuVzoa458sMOedg=;
	b=PGePVzJGA9AFXWShebGXObQLbomqOe73qMYQlo7e21WiszY5nnn/kOTFVQx4NUYmZjiE7f
	725LZV4IseSIMGgmWQSYep3zgZav6i9gEF2xUkUI6mKsWh8nuDGTOtOBK3E+ys000pM2cp
	oUZl8z4nUc+qME9N0nxU3dD/JMpo1Xw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-DI6YVjloMkqt61PY_4mfIw-1; Mon, 10 Mar 2025 06:23:49 -0400
X-MC-Unique: DI6YVjloMkqt61PY_4mfIw-1
X-Mimecast-MFC-AGG-ID: DI6YVjloMkqt61PY_4mfIw_1741602228
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso332260f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741602228; x=1742207028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/12pVfGrHfAC9KyGDgoRmy2bzHmGQuVzoa458sMOedg=;
        b=a03rvkui0b0mCd3r+TsG5DV2JXudbqLcK9LDFDsnQSUErj+cAIosIeUVtGJXPNuQ6G
         WqhKj1k9YfA/2xKkxc2JaAUyZKQ+WCSRXSIEHS+96JZvwUtg+EyQUu2jq7GK6vW352Z8
         gB6XRi86lGiq9MKZ4oZniatiAotBbaIKXZcTKQcrXDRMhxtH3/3E2Dphcqif2Lwj7UMI
         aklXc94rDsGnmn0sz2upHdbgmMUXTJ4vdchQl1o2MuFWhgQ9WPcxT2Z7X7Rmc+klJZxi
         Zk2AOdhK581VfOUqWoCjaBnD62LUdCOYn/kfw5cEXeX5oq8jfubQxxVR5dc0OwAuBaH1
         SZCw==
X-Forwarded-Encrypted: i=1; AJvYcCXcsbszL4JsKyb0X3yhZ4C6uIgVs6454yqWKQ3Kix4gVESEsN/sbCJnI+stYdtq0FrPckHHdamiQ8sJknQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWbSvGjPyAyvRYqL4XXSnYYl8hLu7tkGYMJHxw4/j+VjBNvfPL
	rmxPVbuTHbBH9Q86y202rAvQcqPHuyfTW/Iw3ZpD4sJMh/CX1UnIxdOr+JN2AG+OASn1TKOjPEt
	Iu0GF6iU0PZ+ZVtHHUO//B8zYL3XpBqF713eJuozuZXkOxfB0E+IpPp1mafggqw==
X-Gm-Gg: ASbGncs5FMfHK5QdYhYxx45WeIPmD7Qof+R5RTUM9WnRJHR3U4KeEn1rDwbqfjPQ8Gt
	pN/UsQfCQgOz6/a5Gxd7lc15MGm9Rond/muEJKSnbh4Hv/dekQr4mpiAJuD/T+G0LT0a7UD95a/
	KU1g+UIEiw6pM9sxdYP1Xd67VAzCmgMf40VnuX72O329NO6jppt4HcHT98Hn4gtwfILXbvCgpSY
	EQy+lpYPDKOBHNfP31y7/rDIcQV2FlOic/V5YMMK4EBgrcH5Kki+QzB4KA+k+5J9BwrmMNdIGEm
	s/VyII5lEwzoxfko1KGm2EUl8Vlirx8WOSwNDfMTIrk+FYBxameNxGo=
X-Received: by 2002:adf:e007:0:b0:390:f4f9:8396 with SMTP id ffacd0b85a97d-39132d7ff8bmr4952018f8f.28.1741602227909;
        Mon, 10 Mar 2025 03:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTlUKdfWg/n6nLhAEk75JdM460Sx5llLCeap2DgVS7ohzTSeVMGhEWCd6FidoOs3NkTtglMA==
X-Received: by 2002:adf:e007:0:b0:390:f4f9:8396 with SMTP id ffacd0b85a97d-39132d7ff8bmr4951998f8f.28.1741602227497;
        Mon, 10 Mar 2025 03:23:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdff72sm14634492f8f.36.2025.03.10.03.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 03:23:46 -0700 (PDT)
Message-ID: <de5b9722-905c-49e6-87dc-3fcdeb07fb09@redhat.com>
Date: Mon, 10 Mar 2025 11:23:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-mm@kvack.org
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
 <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
 <Z8nEqDQhjU-Ly8Js@phenom.ffwll.local>
 <51c11147-4927-4ebc-9737-fd1eebe4e0bd@redhat.com>
 <CAHpthZqn7ZZW1ekFQe7nN0+xfsNvMQMKhjMNcB3EyQ18yfQhiA@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CAHpthZqn7ZZW1ekFQe7nN0+xfsNvMQMKhjMNcB3EyQ18yfQhiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/03/2025 09:07, Ryosuke Yasuoka wrote:
> On Fri, Mar 7, 2025 at 4:55 PM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> On 06/03/2025 16:52, Simona Vetter wrote:
>>> On Thu, Mar 06, 2025 at 02:24:51PM +0100, Jocelyn Falempe wrote:
>>>> On 06/03/2025 05:52, Matthew Wilcox wrote:
>>>>> On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
>>>>>> Some drivers can use vmap in drm_panic, however, vmap is sleepable and
>>>>>> takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
>>>>>> requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
>>>>>
>>>>> In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
>>>>> is this supposed to work?
>>>>>
>>>>>> +  vn = addr_to_node(va->va_start);
>>>>>> +
>>>>>> +  insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
>>>>>
>>>>> If someone else is holding the vn->busy.lock because they're modifying the
>>>>> busy tree, you'll corrupt the tree.  You can't just say "I can't take a
>>>>> lock here, so I won't bother".  You need to figure out how to do something
>>>>> safe without taking the lock.  For example, you could preallocate the
>>>>> page tables and reserve a vmap area when the driver loads that would
>>>>> then be usable for the panic situation.  I don't know that we have APIs
>>>>> to let you do that today, but it's something that could be added.
>>>>>
>>>> Regarding the lock, it should be possible to use the trylock() variant, and
>>>> fail if the lock is already taken. (In the panic handler, only 1 CPU remain
>>>> active, so it's unlikely the lock would be released anyway).
>>>>
>>>> If we need to pre-allocate the page table and reserve the vmap area, maybe
>>>> it would be easier to just always vmap() the primary framebuffer, so it can
>>>> be used in the panic handler?
>>>
>>> Yeah I really don't like the idea of creating some really brittle one-off
>>> core mm code just so we don't have to vmap a buffer unconditionally. I
>>> think even better would be if drm_panic can cope with non-linear buffers,
>>> it's entirely fine if the drawing function absolutely crawls and sets each
>>> individual byte ...
>>
>> It already supports some non-linear buffer, like Nvidia block-linear:
>> https://elixir.bootlin.com/linux/v6.13.5/source/drivers/gpu/drm/nouveau/dispnv50/wndw.c#L606
>>
>> And I've also sent some patches to support Intel's 4-tile and Y-tile format:
>> https://patchwork.freedesktop.org/patch/637200/?series=141936&rev=5
>> https://patchwork.freedesktop.org/patch/637202/?series=141936&rev=5
>>
>> Hopefully Color Compression can be disabled on intel's GPU, otherwise
>> that would be a bit harder to implement than tiling.
>>
>>>
>>> The only thing you're allowed to do in panic is try_lock on a raw spinlock
>>> (plus some really scare lockless tricks), imposing that on core mm sounds
>>> like a non-starter to me.
>>>
>>> Cheers, Sima
>>
> 
> Thank you all for your comments.
> I understand adding atomic_vmap is not possible as vmalloc is not compatible
> with GFP_ATOMIC. I'll re-implement this by pre-allocating the page table and
> reserve the vmap area while the kernel is alive. It'll might be
> allocated in driver
> codes so maybe I don't need to add any features in core mm code.

Maybe another way to do that, would be to atomically kmap only one page 
at a time. And when drawing the panic screen, make sure that for each 
pixel the right page is mapped.
Would kmap_local_page() fit for this purpose?

Best regards,

-- 

Jocelyn


> 
> Best regards,
> Ryosuke
> 


