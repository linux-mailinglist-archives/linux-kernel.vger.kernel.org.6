Return-Path: <linux-kernel+bounces-550619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E36A56213
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A38B7AA432
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C091A9B52;
	Fri,  7 Mar 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irS0WXDg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6D1A8F95
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334100; cv=none; b=bErUaUknrKoQqLe5UJzOCMLftxcw1jw3z87BVLm8QD3QHVpZIc7qiRkEiOFQa9e0FeTknJIzvalMGAxi2tnk8Ur7HhfRAiKbAt45+hNJY0z8xMAY3umEj4WDTEU5mPp2R2H7oPEpVvup5lYILmJdLBdNKSTfb6/3l/7OlUxkqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334100; c=relaxed/simple;
	bh=Th5hIPziHcOiMnhSQ1ehwx4jc2j35d04Ew87lt0uSKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S1cqYUhFtkI2ERfAHjqbvxM5Cxwb3L1FbjIEIsv1exRbQca1RunevLdF4kaQGjioPgI28qVtGq0uy/peJLc4++d5TFEz0gUiIGb1kGJ1DW41T1CXZzNfUdp1l7M/T1Mz4L8W/cFdPMw5clnNXLcGNPbp9aQIRVuEKda4SKrAaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irS0WXDg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741334097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XjSBrzgKarSUxwTUTP4kt/kMcpFKwcJA5tHsYp7Puk=;
	b=irS0WXDg/AGbatsAGuVNipYkhYfktaD/Dzzc7/wYnmPk59ylk6Ud6Hkq0FovfqApdWuWSt
	YtdD7A5DfKVElpFRGkmzTJRJPG+kFmJy0vL0upjgoF7fQ8j6AZOKyNTkAkJjVv9qkdmTGx
	lCrpL8NDXFwUTG0159ChDtqOCXRhCl0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-1sxgOaHDN4GdQiL7JAJ1vQ-1; Fri, 07 Mar 2025 02:54:56 -0500
X-MC-Unique: 1sxgOaHDN4GdQiL7JAJ1vQ-1
X-Mimecast-MFC-AGG-ID: 1sxgOaHDN4GdQiL7JAJ1vQ_1741334095
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-438da39bb69so10866035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741334095; x=1741938895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XjSBrzgKarSUxwTUTP4kt/kMcpFKwcJA5tHsYp7Puk=;
        b=ZDP0kWahqmJFySMjSl7eaDjzdEAHy+KLWrLICka2MsxlwCBD0uCix9t4FkShVJvKsE
         Jy3h8x3YylW9Z3Bk/38UHkxPwL8rwXqiqrnUBv327m7Fq/MFYT2KiFCm2R0Vaixdb214
         3UxMEVla1NR77NVtu4V4yjfL5QgHRiDxslSr2zsOZM3YCzONh0nDxjOf6oklpG6Ry0uc
         N4zvjpqDpvsJDUST4StoJFKewENV17hw5hzR3ANmZYo/i0V8qubkV2V20adGR8SzJGXt
         V0eD3T7NAPYjrZu3KfWb3cgSZ+NCrA9S2FEMRD8D++VRzejNV+zt3T19AA6AmrRe+ad2
         U30A==
X-Forwarded-Encrypted: i=1; AJvYcCWYFknlotDF0F6Q5xstfUgsUi41yi2fOy+cm6OLUuLLIlx9NZyZotDUQ7PF1bDTzlSQeUNOU9z6VIq6xN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Vl3i+xWn9UYNW0YTjzj4K0QmmHmIsvxO0JkPJ1uzKZnwPxLu
	SIpHwBkiL4TSvmN0Xvr9vLbPcGPqky1IKTsh7YKEts8/hdob1lZgJBltp9S5dFafQMe4OIV1wR9
	uvJjQZ64ySW5nP7a04jH702B1ym3Kzxm4prOBVYqpghqf7n20sT0au58I6oI52A==
X-Gm-Gg: ASbGnctdbRiva4Avi2+7XZNp+ZX+a9GLGFVQfNXl/YSkU/rKCoXkvgGTPlA4WYbWXd8
	0bL6o4aiEdE4GBHudJBwWY/nVkfX/MPCUvTV1KgFQkC6ofDKJHqzeoPRjAz1Av7M8YkFWY2uS6+
	lvFeMsS5fWVL2EzgtXMu80wIr3Tur+4OlT1a3/FQM4vYzyQ1VaKfIqGvJHHktR+SfWuHxst/aR0
	0jVweylJ+8YsH8gH113tAXyI+fF2xHt8HjI0uOUuKEgHX/3fPxden2SXqQDxkUWnu6hfS5FL0AI
	AdcGUIXe8jp7ki1AgrbIUrvyUzHtRNsrbc8hHkTY0cOxm420cp+LlTA=
X-Received: by 2002:a05:600c:3553:b0:439:8bc3:a698 with SMTP id 5b1f17b1804b1-43c601cdc45mr16230375e9.6.1741334094993;
        Thu, 06 Mar 2025 23:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5GpnS4MDn/K1MDh6DvplMjCwTGNqRWUJiQpcKLuEIKeIoa5hrBZx50YeG7edtD/K149h+Ww==
X-Received: by 2002:a05:600c:3553:b0:439:8bc3:a698 with SMTP id 5b1f17b1804b1-43c601cdc45mr16230285e9.6.1741334094550;
        Thu, 06 Mar 2025 23:54:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352fa3sm72985885e9.30.2025.03.06.23.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 23:54:54 -0800 (PST)
Message-ID: <51c11147-4927-4ebc-9737-fd1eebe4e0bd@redhat.com>
Date: Fri, 7 Mar 2025 08:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
To: Matthew Wilcox <willy@infradead.org>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>, maarten.lankhorst@linux.intel.com,
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
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <Z8nEqDQhjU-Ly8Js@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2025 16:52, Simona Vetter wrote:
> On Thu, Mar 06, 2025 at 02:24:51PM +0100, Jocelyn Falempe wrote:
>> On 06/03/2025 05:52, Matthew Wilcox wrote:
>>> On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
>>>> Some drivers can use vmap in drm_panic, however, vmap is sleepable and
>>>> takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
>>>> requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
>>>
>>> In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
>>> is this supposed to work?
>>>
>>>> +	vn = addr_to_node(va->va_start);
>>>> +
>>>> +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
>>>
>>> If someone else is holding the vn->busy.lock because they're modifying the
>>> busy tree, you'll corrupt the tree.  You can't just say "I can't take a
>>> lock here, so I won't bother".  You need to figure out how to do something
>>> safe without taking the lock.  For example, you could preallocate the
>>> page tables and reserve a vmap area when the driver loads that would
>>> then be usable for the panic situation.  I don't know that we have APIs
>>> to let you do that today, but it's something that could be added.
>>>
>> Regarding the lock, it should be possible to use the trylock() variant, and
>> fail if the lock is already taken. (In the panic handler, only 1 CPU remain
>> active, so it's unlikely the lock would be released anyway).
>>
>> If we need to pre-allocate the page table and reserve the vmap area, maybe
>> it would be easier to just always vmap() the primary framebuffer, so it can
>> be used in the panic handler?
> 
> Yeah I really don't like the idea of creating some really brittle one-off
> core mm code just so we don't have to vmap a buffer unconditionally. I
> think even better would be if drm_panic can cope with non-linear buffers,
> it's entirely fine if the drawing function absolutely crawls and sets each
> individual byte ...

It already supports some non-linear buffer, like Nvidia block-linear:
https://elixir.bootlin.com/linux/v6.13.5/source/drivers/gpu/drm/nouveau/dispnv50/wndw.c#L606

And I've also sent some patches to support Intel's 4-tile and Y-tile format:
https://patchwork.freedesktop.org/patch/637200/?series=141936&rev=5
https://patchwork.freedesktop.org/patch/637202/?series=141936&rev=5

Hopefully Color Compression can be disabled on intel's GPU, otherwise 
that would be a bit harder to implement than tiling.

> 
> The only thing you're allowed to do in panic is try_lock on a raw spinlock
> (plus some really scare lockless tricks), imposing that on core mm sounds
> like a non-starter to me.
> 
> Cheers, Sima


