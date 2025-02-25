Return-Path: <linux-kernel+bounces-531762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29BA44480
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A6E18837B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4183F14387B;
	Tue, 25 Feb 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXwU/SjO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7F21ABAF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497681; cv=none; b=aic6p/TmPelrCu/7z+GuOhNRDtLgXUqpT/CU2ZlxnRNCbMG8TzM3iO7OrIF3Mg1vu2+u96N0PXWaLYRBjQNvLOFNDAg3EZ/PqP+Wo8sT5/uSZJzX5v7kqYD4nj9+WHS18AUQgQIB78CoWnx2JDt1pE4Vk6xFGLkMbEOW1kVomEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497681; c=relaxed/simple;
	bh=CToYEpw8Ls2S86flammWgasMjZ1kI5Wq2hyKMsV7s5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqII4cgqaN9skTBzSoOD2KdfB2FnAegeRCAupesT3RMidHrXn6AO6Q3kcAGrehVJgDdBIGCNoKPL+j4TCdyN3zM+xUow0e0ypqS2+9n7bJ54iBqMO+A+8/393NPlQvCa0Ujt1FuIbklte9wcKRTNTOg0AwI2zXn/cYD1bMk9+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXwU/SjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740497677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRhMdnUzqWlegD/AxqDcLfYFOiyEmJsZkhYPwFjfi64=;
	b=AXwU/SjOKY9xfY5a7Iw9g8is3ZUEqLmrih5S4JMbtHc85cuD3PqNeZVgegBRqpdluvyzDr
	XAWR0AwkNIhth/Ch9fDIribbT+tDaE9MqyFtHKOej/xbPKLRZS2t8GOu9Cqy1nrQZsJYCy
	58lRrVryjil8UQeVER8+hEW7MvGHghE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-QDGSBHR_NUudVmxAy4-7Qw-1; Tue, 25 Feb 2025 10:34:35 -0500
X-MC-Unique: QDGSBHR_NUudVmxAy4-7Qw-1
X-Mimecast-MFC-AGG-ID: QDGSBHR_NUudVmxAy4-7Qw_1740497674
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7272acdfc39so5275650a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497674; x=1741102474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRhMdnUzqWlegD/AxqDcLfYFOiyEmJsZkhYPwFjfi64=;
        b=lxNqktrYRAK7XomNFLomGKJt/XqKViimR/5GC5AnSR3aoX0Z2sSPDyW6iYEKTvwMub
         SmQOQmC7QY6AoL+JE0VFSvnpKgSQHYOb/NJwtpHACivrRKPgSSV9ysFuDtwKHQFicvIH
         4ohSaWMnIMeSTovSd7x3x1Mjz7rB5S6/Ldj3U3+plCO7ze+VMQEchcN1MpdEAeHvIOez
         qsIGrH334peTT5HH5kv0pTMntNtQJQS27vQNUZ51P4AehKHRfDi26Dzpf4GlzuEHmeVm
         vfvxrxxC7xOFjsv6pMMDCGgp525JOaOjWp6UG/ZdexIKAbcx6FE52WC0GnkZX2CwTcDC
         0n4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLfFviiRURBh525FYIOXn7jLmHclB1QTwT3F/37cMmQcbk730ilqnzpcUCZazhS4O2Zs2/k1xVjLxUaWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweV3RH2U8POGavttDuvvIfBkqIVkqCbIIyQH1I46f7SgPAHqG0
	oOSb+OCJa6hbWrQlCKTI/FvE9QCQFNV/ZNwCqQBG1CGj7iD1HSF5PpDZtDgK9vvopF8azNm+cqZ
	xYa5mDrGErDouSTOyPjOlqZqTjjD+bED8BvYKT3P/Xd3AEKhUsuOVoH/D9/3vaQ==
X-Gm-Gg: ASbGncsWe62/E+2Cv1Zp2LXQJEjNlIjAd+EqR3JIxrfqzNv0qmwHo/l/XmTAnk5e3GQ
	s4rYkR+VdajXHA2yiuOFmVMgJzuhcrkagcMPd4CmiQ1gwnssrvq34sBaTHRDkyEXlyingXMbXcI
	vMV+ofYOlhJRShnktI+XK0Yx/EwePNhTSodXyu2tujQv+TOUusnZiGzydfFw9ReDfAycJb2ztyx
	VfZ5xGQV7GPq8R7fPneflUXS3AMGdiDFX5jM58mW3bY3vX9SYS8ZJ3E2ijxiOXAbA4fSQ==
X-Received: by 2002:a05:6830:488c:b0:727:2f0c:916a with SMTP id 46e09a7af769-7274c1e2876mr13305772a34.16.1740497674215;
        Tue, 25 Feb 2025 07:34:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbMcm+vXdAzJTYon6zBTCbwNNo7iLyCqaKKzChzEKHzoLL2wRRpT+N55nRj3Wf6bE/BOWkyQ==
X-Received: by 2002:a05:6830:488c:b0:727:2f0c:916a with SMTP id 46e09a7af769-7274c1e2876mr13305738a34.16.1740497673722;
        Tue, 25 Feb 2025 07:34:33 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289df4eb9esm327787a34.42.2025.02.25.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:34:33 -0800 (PST)
Date: Tue, 25 Feb 2025 10:34:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: surenb@google.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	bgeffon@google.com, brauner@kernel.org, david@redhat.com,
	hughd@google.com, jannh@google.com, kaleshsingh@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com,
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org,
	v-songbaohua@oppo.com, viro@zeniv.linux.org.uk, willy@infradead.org,
	yuzhao@google.com, zhangpeng362@huawei.com, zhengtangquan@oppo.com
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z73jBI7Caxd4jR0n@x1.local>
References: <CAJuCfpEeEbdE2ycEQ+3zSbCE3NJsG1vTbqMtZyzry6FRFZB61w@mail.gmail.com>
 <20250225110525.26732-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225110525.26732-1-21cnbao@gmail.com>

On Wed, Feb 26, 2025 at 12:05:25AM +1300, Barry Song wrote:
> On Fri, Feb 21, 2025 at 1:36 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 3:52 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 3:47 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 2:59 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Thu, Feb 20, 2025 at 12:04:40PM +1300, Barry Song wrote:
> > > > > > On Thu, Feb 20, 2025 at 11:15 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> > > > > > > > On Thu, Feb 20, 2025 at 7:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Feb 19, 2025 at 3:25 AM Barry Song <21cnbao@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > > > > > >
> > > > > > > > > > userfaultfd_move() checks whether the PTE entry is present or a
> > > > > > > > > > swap entry.
> > > > > > > > > >
> > > > > > > > > > - If the PTE entry is present, move_present_pte() handles folio
> > > > > > > > > >   migration by setting:
> > > > > > > > > >
> > > > > > > > > >   src_folio->index = linear_page_index(dst_vma, dst_addr);
> > > > > > > > > >
> > > > > > > > > > - If the PTE entry is a swap entry, move_swap_pte() simply copies
> > > > > > > > > >   the PTE to the new dst_addr.
> > > > > > > > > >
> > > > > > > > > > This approach is incorrect because even if the PTE is a swap
> > > > > > > > > > entry, it can still reference a folio that remains in the swap
> > > > > > > > > > cache.
> > > > > > > > > >
> > > > > > > > > > If do_swap_page() is triggered, it may locate the folio in the
> > > > > > > > > > swap cache. However, during add_rmap operations, a kernel panic
> > > > > > > > > > can occur due to:
> > > > > > > > > >  page_pgoff(folio, page) != linear_page_index(vma, address)
> > > > > > > > >
> > > > > > > > > Thanks for the report and reproducer!
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > $./a.out > /dev/null
> > > > > > > > > > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
> > > > > > > > > > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
> > > > > > > > > > [   13.337716] memcg:ffff00000405f000
> > > > > > > > > > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
> > > > > > > > > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> > > > > > > > > > [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> > > > > > > > > > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> > > > > > > > > > [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> > > > > > > > > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
> > > > > > > > > > [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
> > > > > > > > > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
> > > > > > > > > > [   13.340190] ------------[ cut here ]------------
> > > > > > > > > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > > > > > > > > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > > > > > > > > > [   13.340969] Modules linked in:
> > > > > > > > > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
> > > > > > > > > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > > > > > > > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > > > > > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > > > > > > > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > > > > > > > > [   13.342018] sp : ffff80008752bb20
> > > > > > > > > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
> > > > > > > > > > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
> > > > > > > > > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
> > > > > > > > > > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
> > > > > > > > > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
> > > > > > > > > > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
> > > > > > > > > > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
> > > > > > > > > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
> > > > > > > > > > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
> > > > > > > > > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
> > > > > > > > > > [   13.343876] Call trace:
> > > > > > > > > > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > > > > > > > > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > > > > > > > > [   13.344333]  do_swap_page+0x1060/0x1400
> > > > > > > > > > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > > > > > > > > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > > > > > > > > [   13.344586]  do_page_fault+0x20c/0x770
> > > > > > > > > > [   13.344673]  do_translation_fault+0xb4/0xf0
> > > > > > > > > > [   13.344759]  do_mem_abort+0x48/0xa0
> > > > > > > > > > [   13.344842]  el0_da+0x58/0x130
> > > > > > > > > > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > > > > > > > > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > > > > > > > > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> > > > > > > > > > [   13.345504] ---[ end trace 0000000000000000 ]---
> > > > > > > > > > [   13.345715] note: a.out[107] exited with irqs disabled
> > > > > > > > > > [   13.345954] note: a.out[107] exited with preempt_count 2
> > > > > > > > > >
> > > > > > > > > > Fully fixing it would be quite complex, requiring similar handling
> > > > > > > > > > of folios as done in move_present_pte.
> > > > > > > > >
> > > > > > > > > How complex would that be? Is it a matter of adding
> > > > > > > > > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > > > > > > > > folio->index = linear_page_index like in move_present_pte() or
> > > > > > > > > something more?
> > > > > > > >
> > > > > > > > My main concern is still with large folios that require a split_folio()
> > > > > > > > during move_pages(), as the entire folio shares the same index and
> > > > > > > > anon_vma. However, userfaultfd_move() moves pages individually,
> > > > > > > > making a split necessary.
> > > > > > > >
> > > > > > > > However, in split_huge_page_to_list_to_order(), there is a:
> > > > > > > >
> > > > > > > >         if (folio_test_writeback(folio))
> > > > > > > >                 return -EBUSY;
> > > > > > > >
> > > > > > > > This is likely true for swapcache, right? However, even for move_present_pte(),
> > > > > > > > it simply returns -EBUSY:
> > > > > > > >
> > > > > > > > move_pages_pte()
> > > > > > > > {
> > > > > > > >                 /* at this point we have src_folio locked */
> > > > > > > >                 if (folio_test_large(src_folio)) {
> > > > > > > >                         /* split_folio() can block */
> > > > > > > >                         pte_unmap(&orig_src_pte);
> > > > > > > >                         pte_unmap(&orig_dst_pte);
> > > > > > > >                         src_pte = dst_pte = NULL;
> > > > > > > >                         err = split_folio(src_folio);
> > > > > > > >                         if (err)
> > > > > > > >                                 goto out;
> > > > > > > >
> > > > > > > >                         /* have to reacquire the folio after it got split */
> > > > > > > >                         folio_unlock(src_folio);
> > > > > > > >                         folio_put(src_folio);
> > > > > > > >                         src_folio = NULL;
> > > > > > > >                         goto retry;
> > > > > > > >                 }
> > > > > > > > }
> > > > > > > >
> > > > > > > > Do we need a folio_wait_writeback() before calling split_folio()?
> > > > > > >
> > > > > > > Maybe no need in the first version to fix the immediate bug?
> > > > > > >
> > > > > > > It's also not always the case to hit writeback here. IIUC, writeback only
> > > > > > > happens for a short window when the folio was just added into swapcache.
> > > > > > > MOVE can happen much later after that anytime before a swapin.  My
> > > > > > > understanding is that's also what Matthew wanted to point out.  It may be
> > > > > > > better justified of that in a separate change with some performance
> > > > > > > measurements.
> > > > > >
> > > > > > The bug we’re discussing occurs precisely within the short window you
> > > > > > mentioned.
> > > > > >
> > > > > > 1. add_to_swap: The folio is added to swapcache.
> > > > > > 2. try_to_unmap: PTEs are converted to swap entries.
> > > > > > 3. pageout
> > > > > > 4. Swapcache is cleared.
> > > > >
> > > > > Hmm, I see. I was expecting step 4 to be "writeback is cleared".. or at
> > > > > least that should be step 3.5, as IIUC "writeback" needs to be cleared
> > > > > before "swapcache" bit being cleared.
> > > > >
> > > > > >
> > > > > > The issue happens between steps 2 and 4, where the PTE is not present, but
> > > > > > the folio is still in swapcache - the current code does move_swap_pte() but does
> > > > > > not fixup folio->index within swapcache.
> > > > >
> > > > > One thing I'm still not clear here is why it's a race condition, rather
> > > > > than more severe than that.  I mean, folio->index is definitely wrong, then
> > > > > as long as the page still in swapcache, we should be able to move the swp
> > > > > entry over to dest addr of UFFDIO_MOVE, read on dest addr, then it'll see
> > > > > the page in swapcache with the wrong folio->index already and trigger.
> > > > >
> > > > > I wrote a quick test like that, it actually won't trigger..
> > > > >
> > > > > I had a closer look in the code, I think it's because do_swap_page() has
> > > > > the logic to detect folio->index matching first, and allocate a new folio
> > > > > if it doesn't match in ksm_might_need_to_copy().  IIUC that was for
> > > > > ksm.. but it looks like it's functioning too here.
> > > > >
> > > > > ksm_might_need_to_copy:
> > > > >         if (folio_test_ksm(folio)) {
> > > > >                 if (folio_stable_node(folio) &&
> > > > >                     !(ksm_run & KSM_RUN_UNMERGE))
> > > > >                         return folio;   /* no need to copy it */
> > > > >         } else if (!anon_vma) {
> > > > >                 return folio;           /* no need to copy it */
> > > > >         } else if (folio->index == linear_page_index(vma, addr) && <---------- [1]
> > > > >                         anon_vma->root == vma->anon_vma->root) {
> > > > >                 return folio;           /* still no need to copy it */
> > > > >         }
> > > > >         ...
> > > > >
> > > > >         new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, addr); <---- [2]
> > > > >         ...
> > > > >
> > > > > So I believe what I hit is at [1] it sees index doesn't match, then it
> > > > > decided to allocate a new folio.  In this case, it won't hit your BUG
> > > > > because it'll be "folio != swapcache" later, so it'll setup the
> > > > > folio->index for the new one, rather than the sanity check.
> > > > >
> > > > > Do you know how your case got triggered, being able to bypass the above [1]
> > > > > which should check folio->index already?
> > > >
> > > > To understand the change I tried applying the proposed patch to both
> > > > mm-unstable and Linus' ToT and got conflicts for both trees. Barry,
> > > > which baseline are you using?
> > >
> > > Oops, never mind. My mistake. Copying from the email messed up tabs...
> > > It applies cleanly.
> >
> > Overall the code seems correct to me, however the new code has quite
> > complex logical structure IMO. Original simplified code structure is
> > like this:
> >
> > if (pte_present(orig_src_pte)) {
> >         if (is_zero_pfn) {
> >                 move_zeropage_pte()
> >                 return
> >         }
> >         // pin and lock src_folio
> >         spin_lock(src_ptl)
> >         folio_get(folio)
> >         folio_trylock(folio)
> >         if (folio_test_large(src_folio))
> >                 split_folio(src_folio)
> >         anon_vma_trylock_write(src_anon_vma)
> >         move_present_pte()
> > } else {
> >         if (non_swap_entry(entry))
> >                 if (is_migration_entry(entry))
> >                         handle migration entry
> >         else
> >                 move_swap_pte()
> > }
> >
> > The new structure looks like this:
> >
> > if (!pte_present(orig_src_pte)) {
> >         if (is_migration_entry(entry)) {
> >                 handle migration entry
> >                 return
> >        }
> >         if (!non_swap_entry() ||  !pte_swp_exclusive())
> >                 return
> >         si = get_swap_device(entry);
> > }
> > if (pte_present(orig_src_pte) && is_zero_pfn(pte_pfn(orig_src_pte)))
> >         move_zeropage_pte()
> >         return
> > }
> > pin and lock src_folio
> >         spin_lock(src_ptl)
> >         if (pte_present(orig_src_pte))
> >                 folio_get(folio)
> >         else {
> >                 folio = filemap_get_folio(swap_entry)
> >                 if (IS_ERR(folio))
> >                         move_swap_pte()
> >                         return
> >                 }
> >         }
> >         folio_trylock(folio)
> > if (folio_test_large(src_folio))
> >         split_folio(src_folio)
> > if (pte_present(orig_src_pte))
> >         anon_vma_trylock_write(src_anon_vma)
> > move_pte_and_folio()
> >
> > This looks more complex and harder to follow. Might be the reason
> > David was not in favour of treating swapcache and present pages in the
> > same path. And now I would agree that refactoring some common parts
> > and not breaking the original structure might be cleaner.
> 
> Exactly, that’s the cost we’re facing in trying to share the code path
> for swap and present PTEs.
> 
> I tried to extract some common functions for present PTE and swap entries,
> but I found too many detailed differences and variants. This made the common
> function overly complex, turning it into a real "monster." As a result, I
> don't think this approach would make the code any more readable or cleaner.
> 
> After trying a couple of times, I feel the following is somehow more
> readable:
> (Lokesh is eager for the small folios fixes to be merged without further
> delay. So, I'd prefer to return -EBUSY for large folios in the hotfixes
> and handle the mTHP -EBUSY issue in a separate patch later.)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 867898c4e30b..eed9286ec1f3 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -18,6 +18,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
>  #include "internal.h"
> +#include "swap.h"
>  
>  static __always_inline
>  bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
> @@ -1072,15 +1073,15 @@ static int move_present_pte(struct mm_struct *mm,
>  	return err;
>  }
>  
> -static int move_swap_pte(struct mm_struct *mm,
> +static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
>  			 unsigned long dst_addr, unsigned long src_addr,
>  			 pte_t *dst_pte, pte_t *src_pte,
>  			 pte_t orig_dst_pte, pte_t orig_src_pte,
>  			 pmd_t *dst_pmd, pmd_t dst_pmdval,
> -			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
> +			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
> +			 struct folio *src_folio)
>  {
> -	if (!pte_swp_exclusive(orig_src_pte))
> -		return -EBUSY;
> +	int err = 0;
>  
>  	double_pt_lock(dst_ptl, src_ptl);
>  
> @@ -1090,11 +1091,22 @@ static int move_swap_pte(struct mm_struct *mm,
>  		return -EAGAIN;
>  	}
>  
> +	if (src_folio) {

We'd better add a comment here explaining src_folio in this case is a swap
cache folio, and we're updating index to make sure if the folio can be
reused later in a swapin, the rmap info will match, or something like that.

> +		/* Folio got pinned from under us. Put it back and fail the move. */
> +		if (folio_maybe_dma_pinned(src_folio)) {
> +			err = -EBUSY;
> +			goto out;
> +		}

If the swap entry is guaranteed exclusive (which I think will hold true), I
think we can drop this and the "out" label, as it can't happen.

> +		folio_move_anon_rmap(src_folio, dst_vma);
> +		src_folio->index = linear_page_index(dst_vma, dst_addr);
> +	}
> +
>  	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
>  	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
> -	double_pt_unlock(dst_ptl, src_ptl);
>  
> -	return 0;
> +out:
> +	double_pt_unlock(dst_ptl, src_ptl);
> +	return err;
>  }
>  
>  static int move_zeropage_pte(struct mm_struct *mm,
> @@ -1137,6 +1149,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  			  __u64 mode)
>  {
>  	swp_entry_t entry;
> +	struct swap_info_struct *si = NULL;
>  	pte_t orig_src_pte, orig_dst_pte;
>  	pte_t src_folio_pte;
>  	spinlock_t *src_ptl, *dst_ptl;
> @@ -1318,6 +1331,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  				       orig_dst_pte, orig_src_pte, dst_pmd,
>  				       dst_pmdval, dst_ptl, src_ptl, src_folio);
>  	} else {
> +		struct folio *folio = NULL;
> +
>  		entry = pte_to_swp_entry(orig_src_pte);
>  		if (non_swap_entry(entry)) {
>  			if (is_migration_entry(entry)) {
> @@ -1331,9 +1346,47 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  			goto out;
>  		}
>  
> -		err = move_swap_pte(mm, dst_addr, src_addr, dst_pte, src_pte,
> -				    orig_dst_pte, orig_src_pte, dst_pmd,
> -				    dst_pmdval, dst_ptl, src_ptl);
> +		if (!pte_swp_exclusive(orig_src_pte)) {
> +			err = -EBUSY;
> +			goto out;
> +		}
> +
> +		si = get_swap_device(entry);
> +		if (unlikely(!si)) {
> +			err = -EAGAIN;
> +			goto out;
> +		}
> +                /*
> +                 * Check if swapcache exists. If it does, the folio must be
> +                 * moved even if the PTE is a swap entry. For large folios,
> +                 * we directly return -EBUSY, as split_folio() currently
> +                 * also returns -EBUSY when attempting to split unmapped
> +                 * large folios in the swapcache. This needs to be fixed
> +                 * to allow proper handling.
> +                 */

Some alignment issue on comments...

We could also add something on the decision on why not taking anon_vma.
IIUC mention that no possible rmap walker when exclusive and unmapped
should be ok as of now..

> +		if (!src_folio)
> +			folio = filemap_get_folio(swap_address_space(entry),
> +					swap_cache_index(entry));
> +		if (!IS_ERR_OR_NULL(folio)) {
> +			if (folio_test_large(folio)) {
> +				err = -EBUSY;
> +				folio_put(folio);
> +				goto out;
> +			}
> +			src_folio = folio;

We need to update src_folio_pte here, or later it might access
uninitialized stack var when a retry needed:

	if (src_folio && unlikely(!pte_same(src_folio_pte, orig_src_pte))) {
		err = -EAGAIN;
		goto out;
	}

> +			if (!folio_trylock(src_folio)) {
> +				pte_unmap(&orig_src_pte);
> +				pte_unmap(&orig_dst_pte);
> +				src_pte = dst_pte = NULL;
> +				/* now we can block and wait */
> +				folio_lock(src_folio);
> +				si = NULL;

Swap device ref leak?

Thanks,

> +				goto retry;
> +			}
> +		}
> +		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
> +				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
> +				dst_ptl, src_ptl, src_folio);
>  	}
>  
>  out:
> @@ -1350,6 +1403,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  	if (src_pte)
>  		pte_unmap(src_pte);
>  	mmu_notifier_invalidate_range_end(&range);
> +	if (si)
> +		put_swap_device(si);
>  
>  	return err;
>  }
> 
> If there are no objections, I'll send v2 tomorrow with the above code.
> 12:04 AM, Time to get some sleep now! :-)
> 
> 
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > My point is that if we want a proper fix for mTHP, we'd better handle writeback.
> > > > > > Otherwise, this isn’t much different from directly returning -EBUSY as proposed
> > > > > > in this RFC.
> > > > > >
> > > > > > For small folios, there’s no split_folio issue, making it relatively
> > > > > > simpler. Lokesh
> > > > > > mentioned plans to madvise NOHUGEPAGE in ART, so fixing small folios is likely
> > > > > > the first priority.
> > > > >
> > > > > Agreed.
> > > > >
> > > > > --
> > > > > Peter Xu
> > > > >
> 
> Thanks
> Barry
> 
> 

-- 
Peter Xu


