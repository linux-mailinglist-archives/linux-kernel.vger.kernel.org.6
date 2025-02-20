Return-Path: <linux-kernel+bounces-524852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD74A3E7E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80093B9E57
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66255265612;
	Thu, 20 Feb 2025 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEagEasH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC8264F9A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092388; cv=none; b=dXEke+os5zXUZYEtg1MnmL7OY7tiCdVZ7j9351YcbRGUJPhFCqq/DuKyPh0arhIn8PSMHLstaOVoVF5Qxj58I1u02snfanZwXVszXRsk1BXtyfEBzZabd3CY59A/IOGGuybcUj6rxD4Lm1IVuKlQEjjcA7nJm0vNdSjQEKoBT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092388; c=relaxed/simple;
	bh=kEaz+LEDIgPzbQTXVd8pi8/2jGGfq2POPfbFY3Kjg1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVeMW+Uk+IrUD2v0Hpe7OeR0euRg71/GUs5iRU3aPhrUz7Sc4v/boZS4xA0V6ZcI6sUTTSFESP+EpqdjKg4p/2WWv7agsAoT39ZDnuTdM2utIxjFB9arznQ37nJCpbAl9wr/+O0KgN0a/thBIkeA8MofWGkhUIcoBsbC/8Pc94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEagEasH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740092385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ft7MYuAiF7ucpJ/h4patghw6zNTpuTLvautQ1QeFK4=;
	b=QEagEasHLieGQi1lt2dAbkT2outSCFcMZe/rgqFCuiqgtwxuZ4IuePLATrmr3s0NV4oc0o
	3DB3Y+o+gZTzm2Zh0P5poLzOcyx86raSTZy4A+j1+GXeKkxT5RARKCtr2VzS0d9H/5Uo01
	AabSAbjQAn3eXu7F+QwWzK2aUQRXLk4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-3wNq0goOOk6pgFAmkFGARw-1; Thu, 20 Feb 2025 17:59:44 -0500
X-MC-Unique: 3wNq0goOOk6pgFAmkFGARw-1
X-Mimecast-MFC-AGG-ID: 3wNq0goOOk6pgFAmkFGARw_1740092383
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e1b8065ed4so26256186d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740092383; x=1740697183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ft7MYuAiF7ucpJ/h4patghw6zNTpuTLvautQ1QeFK4=;
        b=paLK+tO3fPmzhokv1UpmNVvuQ1BraDyou7De+odx8B4A96h+IWxqoFoTLBW3da6iwN
         ZEy8J64xUeCkwq+R5L1uBmC5Vt/G0wM4Jd1RdiIHBDbosypOXhwxOf0+3oKixyMt5NbC
         EMn5lUMXqAcJhju3F83pJI2GmvAWsbY7P9BlY78lJtQO45v9iE0XqXdKA/6lmEnI260Y
         pQaprbA6nVPzECiKH+G3TA/d4XJFJekimuTjpL7lbwGFHrhVHzteX25WlXwQ13d29EUq
         MkySg3NsvAeAmA+xTileTf/vQslvvJUVMgv1XiCwYJ3OKqnqpTp83kEsLt4BMkjjB/N7
         Vqxg==
X-Forwarded-Encrypted: i=1; AJvYcCUVkbZx4X7VGVtDfi+QdTsneOQFNnzhZ9kv8S3CncGMulccsHiZAsqC9SQGKuFpcyPHWRNpC2hFI0+zYhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzemr0gNXLYSdb+GdV7eVWRdW3Fu9L4h1bgpiGLhe94IaUg5JjZ
	xvb2HmBPmKgK0K0j+szfokvvaJTpxW0KwY8unSUcZWF1atWydCyzBs9wSzf8p9BWKV9HmJF0Rqs
	Ul3F9RguNMRr6NQcPdr1X0zKxneSxB1y0lztQmHO8nFvCpox7NievBrdUByhpLw==
X-Gm-Gg: ASbGncsB/uD3NnLEFSHLlLVvMZwC+VtA2SRqSaWY2LWlmLYBtbohmI8zcBlSGHl35xc
	PrtfDOuFWkmB7BF/JaxD749Wd5Ur9z0SR3Gs/VkYDEpqcbxyz8HHVhJieZAU9cb1TyMAw8VB0Yv
	AmgJ3WsYvWBaLLkkfpxgKZszJqLKXU481H6NuuM9C3dKvCLLdf+Vsik02wSxKxFXeDae2WdWWyr
	u5o4n8VZ8CuvCj+5jG9XlvdfO7u8zfsP1i8vUPZSeQ5qufHljaoCXu2DlU=
X-Received: by 2002:a05:6214:2b09:b0:6e6:61a5:aa57 with SMTP id 6a1803df08f44-6e6ae7f7ec3mr14139756d6.14.1740092382680;
        Thu, 20 Feb 2025 14:59:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXgq3/bA7uunGoqMjvsTR3RBYpyOg5N/G+5jbfhKMyNwGiiZi3WD1sqEhuAJ1pBKsYMctcgA==
X-Received: by 2002:a05:6214:2b09:b0:6e6:61a5:aa57 with SMTP id 6a1803df08f44-6e6ae7f7ec3mr14139326d6.14.1740092382213;
        Thu, 20 Feb 2025 14:59:42 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e69c93e8d0sm19560186d6.108.2025.02.20.14.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:59:41 -0800 (PST)
Date: Thu, 20 Feb 2025 17:59:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	ZhangPeng <zhangpeng362@huawei.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z7ez2Vl8Sa_bRb4e@x1.local>
References: <20250219112519.92853-1-21cnbao@gmail.com>
 <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
 <Z7ZX28XARM7seknO@x1.local>
 <CAGsJ_4wptMn8HX6Uam7AQpWeE=nOUDHE-Vr81SQJq_oSjmTFHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wptMn8HX6Uam7AQpWeE=nOUDHE-Vr81SQJq_oSjmTFHg@mail.gmail.com>

On Thu, Feb 20, 2025 at 12:04:40PM +1300, Barry Song wrote:
> On Thu, Feb 20, 2025 at 11:15 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> > > On Thu, Feb 20, 2025 at 7:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Wed, Feb 19, 2025 at 3:25 AM Barry Song <21cnbao@gmail.com> wrote:
> > > > >
> > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > >
> > > > > userfaultfd_move() checks whether the PTE entry is present or a
> > > > > swap entry.
> > > > >
> > > > > - If the PTE entry is present, move_present_pte() handles folio
> > > > >   migration by setting:
> > > > >
> > > > >   src_folio->index = linear_page_index(dst_vma, dst_addr);
> > > > >
> > > > > - If the PTE entry is a swap entry, move_swap_pte() simply copies
> > > > >   the PTE to the new dst_addr.
> > > > >
> > > > > This approach is incorrect because even if the PTE is a swap
> > > > > entry, it can still reference a folio that remains in the swap
> > > > > cache.
> > > > >
> > > > > If do_swap_page() is triggered, it may locate the folio in the
> > > > > swap cache. However, during add_rmap operations, a kernel panic
> > > > > can occur due to:
> > > > >  page_pgoff(folio, page) != linear_page_index(vma, address)
> > > >
> > > > Thanks for the report and reproducer!
> > > >
> > > > >
> > > > > $./a.out > /dev/null
> > > > > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
> > > > > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
> > > > > [   13.337716] memcg:ffff00000405f000
> > > > > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
> > > > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> > > > > [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> > > > > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> > > > > [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> > > > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
> > > > > [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
> > > > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
> > > > > [   13.340190] ------------[ cut here ]------------
> > > > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > > > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > > > > [   13.340969] Modules linked in:
> > > > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
> > > > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > > > [   13.342018] sp : ffff80008752bb20
> > > > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
> > > > > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
> > > > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
> > > > > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
> > > > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
> > > > > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
> > > > > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
> > > > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
> > > > > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
> > > > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
> > > > > [   13.343876] Call trace:
> > > > > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > > > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > > > [   13.344333]  do_swap_page+0x1060/0x1400
> > > > > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > > > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > > > [   13.344586]  do_page_fault+0x20c/0x770
> > > > > [   13.344673]  do_translation_fault+0xb4/0xf0
> > > > > [   13.344759]  do_mem_abort+0x48/0xa0
> > > > > [   13.344842]  el0_da+0x58/0x130
> > > > > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > > > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > > > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> > > > > [   13.345504] ---[ end trace 0000000000000000 ]---
> > > > > [   13.345715] note: a.out[107] exited with irqs disabled
> > > > > [   13.345954] note: a.out[107] exited with preempt_count 2
> > > > >
> > > > > Fully fixing it would be quite complex, requiring similar handling
> > > > > of folios as done in move_present_pte.
> > > >
> > > > How complex would that be? Is it a matter of adding
> > > > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > > > folio->index = linear_page_index like in move_present_pte() or
> > > > something more?
> > >
> > > My main concern is still with large folios that require a split_folio()
> > > during move_pages(), as the entire folio shares the same index and
> > > anon_vma. However, userfaultfd_move() moves pages individually,
> > > making a split necessary.
> > >
> > > However, in split_huge_page_to_list_to_order(), there is a:
> > >
> > >         if (folio_test_writeback(folio))
> > >                 return -EBUSY;
> > >
> > > This is likely true for swapcache, right? However, even for move_present_pte(),
> > > it simply returns -EBUSY:
> > >
> > > move_pages_pte()
> > > {
> > >                 /* at this point we have src_folio locked */
> > >                 if (folio_test_large(src_folio)) {
> > >                         /* split_folio() can block */
> > >                         pte_unmap(&orig_src_pte);
> > >                         pte_unmap(&orig_dst_pte);
> > >                         src_pte = dst_pte = NULL;
> > >                         err = split_folio(src_folio);
> > >                         if (err)
> > >                                 goto out;
> > >
> > >                         /* have to reacquire the folio after it got split */
> > >                         folio_unlock(src_folio);
> > >                         folio_put(src_folio);
> > >                         src_folio = NULL;
> > >                         goto retry;
> > >                 }
> > > }
> > >
> > > Do we need a folio_wait_writeback() before calling split_folio()?
> >
> > Maybe no need in the first version to fix the immediate bug?
> >
> > It's also not always the case to hit writeback here. IIUC, writeback only
> > happens for a short window when the folio was just added into swapcache.
> > MOVE can happen much later after that anytime before a swapin.  My
> > understanding is that's also what Matthew wanted to point out.  It may be
> > better justified of that in a separate change with some performance
> > measurements.
> 
> The bug we’re discussing occurs precisely within the short window you
> mentioned.
> 
> 1. add_to_swap: The folio is added to swapcache.
> 2. try_to_unmap: PTEs are converted to swap entries.
> 3. pageout
> 4. Swapcache is cleared.

Hmm, I see. I was expecting step 4 to be "writeback is cleared".. or at
least that should be step 3.5, as IIUC "writeback" needs to be cleared
before "swapcache" bit being cleared.

> 
> The issue happens between steps 2 and 4, where the PTE is not present, but
> the folio is still in swapcache - the current code does move_swap_pte() but does
> not fixup folio->index within swapcache.

One thing I'm still not clear here is why it's a race condition, rather
than more severe than that.  I mean, folio->index is definitely wrong, then
as long as the page still in swapcache, we should be able to move the swp
entry over to dest addr of UFFDIO_MOVE, read on dest addr, then it'll see
the page in swapcache with the wrong folio->index already and trigger.

I wrote a quick test like that, it actually won't trigger..

I had a closer look in the code, I think it's because do_swap_page() has
the logic to detect folio->index matching first, and allocate a new folio
if it doesn't match in ksm_might_need_to_copy().  IIUC that was for
ksm.. but it looks like it's functioning too here.

ksm_might_need_to_copy:
	if (folio_test_ksm(folio)) {
		if (folio_stable_node(folio) &&
		    !(ksm_run & KSM_RUN_UNMERGE))
			return folio;	/* no need to copy it */
	} else if (!anon_vma) {
		return folio;		/* no need to copy it */
	} else if (folio->index == linear_page_index(vma, addr) && <---------- [1]
			anon_vma->root == vma->anon_vma->root) {
		return folio;		/* still no need to copy it */
	}
        ...
        
	new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, addr); <---- [2]
        ...

So I believe what I hit is at [1] it sees index doesn't match, then it
decided to allocate a new folio.  In this case, it won't hit your BUG
because it'll be "folio != swapcache" later, so it'll setup the
folio->index for the new one, rather than the sanity check.

Do you know how your case got triggered, being able to bypass the above [1]
which should check folio->index already?

> 
> My point is that if we want a proper fix for mTHP, we'd better handle writeback.
> Otherwise, this isn’t much different from directly returning -EBUSY as proposed
> in this RFC.
> 
> For small folios, there’s no split_folio issue, making it relatively
> simpler. Lokesh
> mentioned plans to madvise NOHUGEPAGE in ART, so fixing small folios is likely
> the first priority.

Agreed.

-- 
Peter Xu


