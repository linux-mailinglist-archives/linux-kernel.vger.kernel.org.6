Return-Path: <linux-kernel+bounces-523201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059DA3D377
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9F5189ED3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CABA1EBA08;
	Thu, 20 Feb 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8KpYDMU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B641EB189
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040838; cv=none; b=PaqOdgZRPKDL0/eTwItaD3lPBQOJsJkTk3pPuqarJsNPIYfSoaUmcoIKaO3dHzTEd3YpIWv9/WhdV2DUk/RUHAbm51okXLviSLQk08owbGa6NygX5o4xxNhM9uHYN1mT5ts0tKrAyy/jw+zBf8VjdE9BeKLh79PfaqRupu7drOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040838; c=relaxed/simple;
	bh=9VpzO8UKjjIt0r6tRVNaMHW+N5FQECfM0a4IQSZ8aDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttYHoId/GLQMlVMGR2d/IXUHr/nPR19e3zFjvHc7Tcvl+D/7XCqeWkPv+OFKJHBAWtey3N6cbymclNBr9pxL6W+M21FWjeLLirmmsxLgRuLjbhmHZD0x820p/uVhC1yiZTpzL01qjKhMHSiOmkwmxy6wymsigcAi8fVbEscVyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8KpYDMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740040832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=snAnlaGb4UxUlqBrs9Q+hpZ6pGKfyIsXlmGGPLrciMw=;
	b=F8KpYDMU6Lkf1bJUGgOuMhLUYwP+Gae0N9k0BrRKwGVMwR7q1oWyZnJR3U5xVO3prxx3VZ
	iZmZjm8LZbB6KceblJ2Zpoc2C/N4D087NQ/IdtxzWjUEyfHLge/PqC/nlAmAzv1rrRIs+o
	HnaYSc198c6YIYA7MgP4bHa0lYd5tQU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-jOpLP9wnPVO-Gv1AsuuDpQ-1; Thu, 20 Feb 2025 03:40:29 -0500
X-MC-Unique: jOpLP9wnPVO-Gv1AsuuDpQ-1
X-Mimecast-MFC-AGG-ID: jOpLP9wnPVO-Gv1AsuuDpQ_1740040829
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab39f65dc10so96254066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040829; x=1740645629;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snAnlaGb4UxUlqBrs9Q+hpZ6pGKfyIsXlmGGPLrciMw=;
        b=oc8PxDfM6BQBghwUWhixKRebVZYLzbYw2Vs5Q88ccKSi46glVc0VmLsTNu1IOUT1v/
         xiHChCTpDvqKGzbFIkwwRqa70sQIPK+58/7I7rZ3405akiYNk9NhGproqNOa7pjnj4mj
         ksQ+ES8hbOnu3uMDPOlnobysdmRDCXr4qPiyZ3XFjbX7DKho2B/ItLFrnwMq3fxooafs
         UJSEwsTEPkaNfekCwKvWK3u+MpmzBxPh8HxmyJEqu8lPIObTYIWcHDqGA7CYPQkWTdCC
         WJdwz/2UXxqXNwkEG7E6HhW+BC2cji736bJpkWfJdMvH2xfoeExTT5nzbu6JsSa+xMEd
         ypeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJs0mPw8W1zk5St3+5QwFPLaD+Rmtl8Va0RrdpTpchKo1iJPq3yiJg7JpS2Y6i0ILhB3fI0SPHnal0FtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBGn1lLFOmMhlGyiuzL7hf1NwQm7baThmPZPIpdd0+V9WIyla
	XqU/cizmhr1V313mnRPKPsdlr9TzdCDKB/VO+d6lUjJTfAZ6QIdhONQ72I72G2xhlS09BolH5Mx
	reZaXK1EunT0f3XfoeiNQtZkAAKGmttq/XTtU8P1n1lQ0zv5aaLrkAvOFwREb7g==
X-Gm-Gg: ASbGncvNul34SkoVS/8xxfNJE5USOA7k8vAsH3BOvsjbKb8M/jzq9L0FSDWtHWFVsaV
	SXfLJBPipoDrw54fVfMmOjPv8pwPnNXr4HdKeHDgMpr9ANEm8hX/Rn4TkITIETz4OMz3LFiSHl7
	UTlOH+59onKiKhLAHifkQC0UKZXIrgN3yJwJPQxnY9YUvJ1Arj1IUk0qZ7IMYCvUwlJzTBk8vpF
	mm2l4a6qBwpNps3LLSW5M4Z9ujwwdVeMB7uV/8iYDinVgCCdWyNPuzc2SAPP39zY0MtYSQLfuOn
	D+Sm6X9kkJxDRK6AjREMgSk2G876b6k0AQ==
X-Received: by 2002:a17:906:3117:b0:ab7:b356:62e0 with SMTP id a640c23a62f3a-abb711c3ef2mr1825981266b.53.1740040828542;
        Thu, 20 Feb 2025 00:40:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/UuWOyoYorUEp3PhRHLs5slq2K3fhrCJB18lX+r+6GVGMRqoVml+2cOOJh3DEqi3JmzZSbg==
X-Received: by 2002:a17:906:3117:b0:ab7:b356:62e0 with SMTP id a640c23a62f3a-abb711c3ef2mr1825976966b.53.1740040828050;
        Thu, 20 Feb 2025 00:40:28 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6195.dip0.t-ipconnect.de. [91.12.97.149])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb945da4a1sm807258166b.132.2025.02.20.00.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 00:40:26 -0800 (PST)
Message-ID: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
Date: Thu, 20 Feb 2025 09:40:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
To: Suren Baghdasaryan <surenb@google.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Axel Rasmussen <axelrasmussen@google.com>, Brian Geffon
 <bgeffon@google.com>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
 Kalesh Singh <kaleshsingh@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Lokesh Gidra <lokeshgidra@google.com>, Matthew Wilcox <willy@infradead.org>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Nicolas Geoffray <ngeoffray@google.com>, Peter Xu <peterx@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
 ZhangPeng <zhangpeng362@huawei.com>
References: <20250219112519.92853-1-21cnbao@gmail.com>
 <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <b9f194e0-b20b-47ff-8c75-e15d34496292@redhat.com>
 <CAJuCfpG9h3m4w6GWO7xUTxDD-SGyfP21iWPcjaVe6gviZ6UtpA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpG9h3m4w6GWO7xUTxDD-SGyfP21iWPcjaVe6gviZ6UtpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.02.25 19:58, Suren Baghdasaryan wrote:
> On Wed, Feb 19, 2025 at 10:30 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 19.02.25 19:26, Suren Baghdasaryan wrote:
>>> On Wed, Feb 19, 2025 at 3:25 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> userfaultfd_move() checks whether the PTE entry is present or a
>>>> swap entry.
>>>>
>>>> - If the PTE entry is present, move_present_pte() handles folio
>>>>     migration by setting:
>>>>
>>>>     src_folio->index = linear_page_index(dst_vma, dst_addr);
>>>>
>>>> - If the PTE entry is a swap entry, move_swap_pte() simply copies
>>>>     the PTE to the new dst_addr.
>>>>
>>>> This approach is incorrect because even if the PTE is a swap
>>>> entry, it can still reference a folio that remains in the swap
>>>> cache.
>>>>
>>>> If do_swap_page() is triggered, it may locate the folio in the
>>>> swap cache. However, during add_rmap operations, a kernel panic
>>>> can occur due to:
>>>>    page_pgoff(folio, page) != linear_page_index(vma, address)
>>>
>>> Thanks for the report and reproducer!
>>>
>>>>
>>>> $./a.out > /dev/null
>>>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
>>>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
>>>> [   13.337716] memcg:ffff00000405f000
>>>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
>>>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
>>>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
>>>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
>>>> [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
>>>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
>>>> [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
>>>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
>>>> [   13.340190] ------------[ cut here ]------------
>>>> [   13.340316] kernel BUG at mm/rmap.c:1380!
>>>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>>>> [   13.340969] Modules linked in:
>>>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
>>>> [   13.341470] Hardware name: linux,dummy-virt (DT)
>>>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
>>>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
>>>> [   13.342018] sp : ffff80008752bb20
>>>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
>>>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
>>>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
>>>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
>>>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
>>>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
>>>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
>>>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
>>>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
>>>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
>>>> [   13.343876] Call trace:
>>>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
>>>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
>>>> [   13.344333]  do_swap_page+0x1060/0x1400
>>>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
>>>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
>>>> [   13.344586]  do_page_fault+0x20c/0x770
>>>> [   13.344673]  do_translation_fault+0xb4/0xf0
>>>> [   13.344759]  do_mem_abort+0x48/0xa0
>>>> [   13.344842]  el0_da+0x58/0x130
>>>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
>>>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
>>>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
>>>> [   13.345504] ---[ end trace 0000000000000000 ]---
>>>> [   13.345715] note: a.out[107] exited with irqs disabled
>>>> [   13.345954] note: a.out[107] exited with preempt_count 2
>>>>
>>>> Fully fixing it would be quite complex, requiring similar handling
>>>> of folios as done in move_present_pte.
>>>
>>> How complex would that be? Is it a matter of adding
>>> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
>>> folio->index = linear_page_index like in move_present_pte() or
>>> something more?
>>
>> If the entry is pte_swp_exclusive(), and the folio is order-0, it cannot
>> be pinned and we may be able to move it I think.
>>
>> So all that's required is to check pte_swp_exclusive() and the folio size.
>>
>> ... in theory :) Not sure about the swap details.
> 
> Looking some more into it, I think we would have to perform all the
> folio and anon_vma locking and pinning that we do for present pages in
> move_pages_pte(). If that's correct then maybe treating swapcache
> pages like a present page inside move_pages_pte() would be simpler?

I'd be more in favor of not doing that. Maybe there are parts we can 
move out into helper functions instead, so we can reuse them?

-- 
Cheers,

David / dhildenb


