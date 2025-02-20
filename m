Return-Path: <linux-kernel+bounces-523225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4253FA3D3BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6933B5AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D3B1EB1A3;
	Thu, 20 Feb 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkZcnVam"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FA1B3927
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041515; cv=none; b=kUvUD2ergwcO4x8fshlQbfwG/t07h8Dkvq3KB5orud9++gSSLbE60NfcCvYFzYgy9bP3WmBTk+N/vtNROPyH+HQRnTw7lw5ftuHnRDhhiD6NDAcziAV7srBTnyC3YJa/s/QZGhavkCATbClgHxD2AIHDCrt5msKOu9BxGwC1mhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041515; c=relaxed/simple;
	bh=/v/WuAdZAvgXHM+0zKoHYJ+XRAxi0hcLZ1j+dyfZxAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNXuWQ/R6JqUnGqXDgKauFTK7i7BydaKAEFfQTop0MqpVAWoh1luse5g30aL6GudEtc44Te+aG3hB2Tedpxvy3kdyW/bzSg8VJl3r+444i54mMCiSPx3UZ4h7xOuWW/QRXq9YuR7pR38X2LqA3KNYaqtolvOhVVXE4Klnh0p46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VkZcnVam; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740041512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vQh5h5APnCkH7y3zMZMqkvhZGJpBI9p6ZY+Xi5t/JIE=;
	b=VkZcnVamzNewP+sR+AXEv3mMSILTfaxG1WD/LxcuxHK5whbBTyQzK8ck8cq/hvQxWQVpfy
	qawqYCG/L0L3SRI9fuKC/WXnIAfahgzoTmaiGropfjyB3hGvIAfy6LdWFI/17d4Q5FK7vN
	u74M7/y/QRLK80SA2dE8fXGrLSLzX3I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-MnmR3_mUPWC83yGa-RLqtg-1; Thu, 20 Feb 2025 03:51:50 -0500
X-MC-Unique: MnmR3_mUPWC83yGa-RLqtg-1
X-Mimecast-MFC-AGG-ID: MnmR3_mUPWC83yGa-RLqtg_1740041509
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4e47d0b2so262835f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041509; x=1740646309;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vQh5h5APnCkH7y3zMZMqkvhZGJpBI9p6ZY+Xi5t/JIE=;
        b=QeuewMDe7zPaUS81N7QbWazKFiNJ7Gr/+Dmb3weKAF/WJkNBSIJiNODjLjI/6Q8O6R
         VW/GJk2T6Ib1/wVY/U+1lZBHZ5rFzY/gmbIxs2GjjslQ1kHbaBvf8sOpZs1SFtmz/fpi
         gh70CD81bN8eeK22GfeQDA5BrSr7XeZGzA0XN9P+yAz3UvoYGl0PXd7GofchjYk7Qex5
         aCFZqMOABmgokYUqcY3qPRSUcn3Idw7nTWOFPurzSomdYTF9hPChy+WAcR22Fd0O10Wr
         Tn6HirNFTnPHVhcfCm+1xMYtB5dxMj6qEDMlYAUV+X1xJ6S2hjxtS8wNMKFiUR6knzGP
         KpLw==
X-Forwarded-Encrypted: i=1; AJvYcCV3f7PSq4vAhupxrISevtyMruJlcqDf2gdamRw/OgkOnDcQByZZsva4YWeJHTRq5Ezo8FcnRMYBeat0rac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFFQzV58Pl965KcplO9359IoEkja4PpLeI7axUXb6U824unjuy
	wt0utZzhCOS7k7uYPoap2qhohbLvBXVQK7fTK7203SEAObTYIfGr6DPTQfioYy414km0ZDx7Gxu
	MUkwdxLeqs9d9KagMnY86sOnhP43L7iYkuDvA//YBIBvv0FPWL0X3IK9noxJNHQ==
X-Gm-Gg: ASbGncuJ1efkd8Hh0XHHIBzNarVdfX33QbW/t7FkhaMV9N1P9nYVRjfYo7NfbOycaNG
	USGUDQANZVoZl12OS3V01MoU7nByD/vX/C0ZRjSkkmaUHHD7hKKgXZOkH+soH4eYb7aCiezCAQ+
	5narzJyhATeVZWPHuDPesl+hpWdTkfCyBGFluCzJ8HygViM7WFQv+JXswm0J5PHk861apdnnUW/
	QdiuQaMCWX14113q8k/Yssf6pq5r5sboQa69nKdfpn0yAa+sSeJqKL4LYkjeZyEwmFyKQ2ZiWrA
	pH3xi9xLx5LzM2zVlHphfceuLx3SJ5dtaQ==
X-Received: by 2002:a5d:64aa:0:b0:38f:2b54:874e with SMTP id ffacd0b85a97d-38f5878ca71mr5649160f8f.16.1740041509040;
        Thu, 20 Feb 2025 00:51:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETPx4hSIhabyNWzxQ+3JFg7ety/cByHrZcPuLr/fUjWSNXLLF6EjmWHQ9k9DPI2TEdCY1ETQ==
X-Received: by 2002:a5d:64aa:0:b0:38f:2b54:874e with SMTP id ffacd0b85a97d-38f5878ca71mr5649120f8f.16.1740041508613;
        Thu, 20 Feb 2025 00:51:48 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6195.dip0.t-ipconnect.de. [91.12.97.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7979sm19709544f8f.83.2025.02.20.00.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 00:51:47 -0800 (PST)
Message-ID: <50566d42-7754-4017-b290-f29d92e69231@redhat.com>
Date: Thu, 20 Feb 2025 09:51:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
To: Barry Song <21cnbao@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Lokesh Gidra <lokeshgidra@google.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, zhengtangquan@oppo.com,
 Barry Song <v-songbaohua@oppo.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Axel Rasmussen
 <axelrasmussen@google.com>, Brian Geffon <bgeffon@google.com>,
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>,
 Jann Horn <jannh@google.com>, Kalesh Singh <kaleshsingh@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicolas Geoffray <ngeoffray@google.com>,
 Peter Xu <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <shuah@kernel.org>, ZhangPeng <zhangpeng362@huawei.com>,
 Yu Zhao <yuzhao@google.com>
References: <20250219112519.92853-1-21cnbao@gmail.com>
 <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.02.25 21:37, Barry Song wrote:
> On Thu, Feb 20, 2025 at 7:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Wed, Feb 19, 2025 at 3:25 AM Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> userfaultfd_move() checks whether the PTE entry is present or a
>>> swap entry.
>>>
>>> - If the PTE entry is present, move_present_pte() handles folio
>>>    migration by setting:
>>>
>>>    src_folio->index = linear_page_index(dst_vma, dst_addr);
>>>
>>> - If the PTE entry is a swap entry, move_swap_pte() simply copies
>>>    the PTE to the new dst_addr.
>>>
>>> This approach is incorrect because even if the PTE is a swap
>>> entry, it can still reference a folio that remains in the swap
>>> cache.
>>>
>>> If do_swap_page() is triggered, it may locate the folio in the
>>> swap cache. However, during add_rmap operations, a kernel panic
>>> can occur due to:
>>>   page_pgoff(folio, page) != linear_page_index(vma, address)
>>
>> Thanks for the report and reproducer!
>>
>>>
>>> $./a.out > /dev/null
>>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
>>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
>>> [   13.337716] memcg:ffff00000405f000
>>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
>>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
>>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
>>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
>>> [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
>>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
>>> [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
>>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
>>> [   13.340190] ------------[ cut here ]------------
>>> [   13.340316] kernel BUG at mm/rmap.c:1380!
>>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>>> [   13.340969] Modules linked in:
>>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
>>> [   13.341470] Hardware name: linux,dummy-virt (DT)
>>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
>>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
>>> [   13.342018] sp : ffff80008752bb20
>>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
>>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
>>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
>>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
>>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
>>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
>>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
>>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
>>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
>>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
>>> [   13.343876] Call trace:
>>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
>>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
>>> [   13.344333]  do_swap_page+0x1060/0x1400
>>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
>>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
>>> [   13.344586]  do_page_fault+0x20c/0x770
>>> [   13.344673]  do_translation_fault+0xb4/0xf0
>>> [   13.344759]  do_mem_abort+0x48/0xa0
>>> [   13.344842]  el0_da+0x58/0x130
>>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
>>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
>>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
>>> [   13.345504] ---[ end trace 0000000000000000 ]---
>>> [   13.345715] note: a.out[107] exited with irqs disabled
>>> [   13.345954] note: a.out[107] exited with preempt_count 2
>>>
>>> Fully fixing it would be quite complex, requiring similar handling
>>> of folios as done in move_present_pte.
>>
>> How complex would that be? Is it a matter of adding
>> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
>> folio->index = linear_page_index like in move_present_pte() or
>> something more?
> 
> My main concern is still with large folios that require a split_folio()
> during move_pages(), as the entire folio shares the same index and
> anon_vma. However, userfaultfd_move() moves pages individually,
> making a split necessary.
> 
> However, in split_huge_page_to_list_to_order(), there is a:
> 
>          if (folio_test_writeback(folio))
>                  return -EBUSY;
> 
> This is likely true for swapcache, right? However, even for move_present_pte(),
> it simply returns -EBUSY:
> 
> move_pages_pte()
> {
>                  /* at this point we have src_folio locked */
>                  if (folio_test_large(src_folio)) {
>                          /* split_folio() can block */
>                          pte_unmap(&orig_src_pte);
>                          pte_unmap(&orig_dst_pte);
>                          src_pte = dst_pte = NULL;
>                          err = split_folio(src_folio);
>                          if (err)
>                                  goto out;
> 
>                          /* have to reacquire the folio after it got split */
>                          folio_unlock(src_folio);
>                          folio_put(src_folio);
>                          src_folio = NULL;
>                          goto retry;
>                  }
> }
> 
> Do we need a folio_wait_writeback() before calling split_folio()?
> 
> By the way, I have also reported that userfaultfd_move() has a fundamental
> conflict with TAO (Cc'ed Yu Zhao), which has been part of the Android common
> kernel. In this scenario, folios in the virtual zone won’t be split in
> split_folio(). Instead, the large folio migrates into nr_pages small folios.
 > > Thus, the best-case scenario would be:
> 
> mTHP -> migrate to small folios in split_folio() -> move small folios to
> dst_addr
> 
> While this works, it negates the performance benefits of
> userfaultfd_move(), as it introduces two PTE operations (migration in
> split_folio() and move in userfaultfd_move() while retry), nr_pages memory
> allocations, and still requires one memcpy(). This could end up
> performing even worse than userfaultfd_copy(), I guess.
 > > The worst-case scenario would be failing to allocate small folios in
> split_folio(), then userfaultfd_move() might return -ENOMEM?

Although that's an Android problem and not an upstream problem, I'll 
note that there are other reasons why the split / move might fail, and 
user space either must retry or fallback to a COPY.

Regarding mTHP, we could move the whole folio if the user space-provided 
range allows for batching over multiple PTEs (nr_ptes), they are in a 
single VMA, and folio_mapcount() == nr_ptes.

There are corner cases to handle, such as moving mTHPs such that they 
suddenly cross two page tables I assume, that are harder to handle when 
not moving individual PTEs where that cannot happen.

-- 
Cheers,

David / dhildenb


