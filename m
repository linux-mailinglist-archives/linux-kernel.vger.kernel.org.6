Return-Path: <linux-kernel+bounces-531171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59390A43D28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5394B3BFED6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF026773B;
	Tue, 25 Feb 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfSZaQPO"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6A26772F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481541; cv=none; b=rcMhsn+A2RcDfQHf5TceJqN1lr4s8vZr5Reu/0PdQlpTo/+JqN+RTiB/2rWyT+2mNQYMP0sOmsZl8UDv2RG03wiL8ZfTrJs8xn05FwnVT7E9mRVILAMb+agNLHQdh5/91SQqlTeLmbszfQYQbmRLQf323eBCg4ajFz5Td7H7GnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481541; c=relaxed/simple;
	bh=u96XDXh57/6oOdueVMr3iJ8BXVnYOnndJdixJO0I4iU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXw+GRJY6ouhSWsFhV8OROePz53VlnKxnpLEnhziYP2x64XY7kCCjAyDwxGia3cZudlH+j63qiKTp1ppxxpBSr5WUQwWwWpo7PrPXAWsPN9mkbpz07Z3+1pCO44QX5Uz9et9pPfCRfLSR6mpehitKHMz/W/IU9IO5Ean9lHHiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfSZaQPO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc11834404so8432755a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740481538; x=1741086338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9fF+/KoEn4ybPiIaoVFg7y1oSf6VmVcoJLEARWll7E=;
        b=gfSZaQPOoXnDOwhQu6lNPFSG2c2kEs7nGZayajbJgthzD8MaV6S8u/4+QktVpXm4Qd
         vRN3toUbq7yu80VnrNpg4dX+T6y2yJwK1TmctOvAzSD7NtaGB+9nt+gv3l0C5EiTLd+8
         nC1MZaNq7LdY7EEH+q0fCnAV/vWvURI45PZVOf6KgogrAS30miEG74f54g8frWJ11Re7
         5y0wNuaOb85DNFUPB3+hGqkojExjYCIUnnXLgJLxglq5OGtHH0lM2+gmWli5KOd9iR2H
         QKPfZ3vQGo5FyMARCp2NO3asUv8bBAIQtUNK29o+iTJD9xHHlGz0UChdGjj9Ju0/FWwP
         QWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481538; x=1741086338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9fF+/KoEn4ybPiIaoVFg7y1oSf6VmVcoJLEARWll7E=;
        b=ExiTn+wvW+w2DUoApV/0dHZemiiODXgYoXs6f/53LJ+rDI7X02F0ObvRtDh0HHYfRX
         azVOf5eEs60ocBJ6e/89LzVIkk0IYJ9T8Wc/1n7tKUONk/Q3KAcM475/3PQ/yYYZo3d1
         CaSidTYVoN3Mjw4A1H784Gpf2GRPXO4HO9/YooUUMvB9JoBMgV4Rnf4qLZ0XUmlRiyns
         DlYkmN6TqYv5jlFOeGX7OU7v2y2WlZ85JHzQKBBsNoFF3eM4+Qr6kIPUFDONE+d+g2tQ
         RBeZWv9JLUWsiZBcNZ/bBb3xvNesIy9TfYS3ykT6cwHh2EpBr8j2FZ20t8eIT/Li6Ewk
         hnyw==
X-Forwarded-Encrypted: i=1; AJvYcCXTGgK4GZunYXsLJeLxVE+Vm8Lm1AlqoFTpntwmeeMprGrLUM9gMgh09DlkfV/BO87Mt4T9lAip3idnq4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZJ1lORjhdPz3lcUIvSl0NlFzjCHHTBe9hQf43QgC9EwOZgWv
	DIshTECnhtr2FrRCKCoPuem17UnoV1lr16EwxzVBNjP4oaRYmDAa
X-Gm-Gg: ASbGncvTiOO15OL4aDRcwNAr4yU9EtGsp1OWTxBTa5kfWwHtqHktVeN0CJNkEBok1Rm
	rajuqLyPWbIm3OIgZTk+WV9YsEgqE9GsLmFV05OXKxhM7z36jLQlCu2Dk6w9jOsS89Y4ksVfp7B
	2re/gSEquaDw2sGleGuUMY9afNBliNA9Un9Jj83ya/dcFGFgOwlgq1CB/xP4tNoqNEH9OOcKJIX
	ACM0xi0bCHxPrrgLe523Eqa9D1DlIThHueBt1WnUN9y0ynqfht82/UTXNM3d3CTpNPkZPxI5tKI
	yCJPDYBS0tlSQTx82G4q7Rf3hu1ANO86ahH6fzy4Q3E=
X-Google-Smtp-Source: AGHT+IGl2ocLgwialqvNRpX1MrXvsX7kP0KR/tqxx7vHEot1rp7p2VG5BaoJ1L2wN8Kd6tw9hDmDwA==
X-Received: by 2002:a17:90b:2710:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-2fce868c836mr25184882a91.5.1740481538277;
        Tue, 25 Feb 2025 03:05:38 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3f2121sm1257621a91.25.2025.02.25.03.05.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Feb 2025 03:05:37 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: surenb@google.com
Cc: 21cnbao@gmail.com,
	Liam.Howlett@oracle.com,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	bgeffon@google.com,
	brauner@kernel.org,
	david@redhat.com,
	hughd@google.com,
	jannh@google.com,
	kaleshsingh@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lokeshgidra@google.com,
	mhocko@suse.com,
	ngeoffray@google.com,
	peterx@redhat.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	v-songbaohua@oppo.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	yuzhao@google.com,
	zhangpeng362@huawei.com,
	zhengtangquan@oppo.com
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
Date: Wed, 26 Feb 2025 00:05:25 +1300
Message-Id: <20250225110525.26732-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAJuCfpEeEbdE2ycEQ+3zSbCE3NJsG1vTbqMtZyzry6FRFZB61w@mail.gmail.com>
References: <CAJuCfpEeEbdE2ycEQ+3zSbCE3NJsG1vTbqMtZyzry6FRFZB61w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Feb 21, 2025 at 1:36 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Feb 20, 2025 at 3:52 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 3:47 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 2:59 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 12:04:40PM +1300, Barry Song wrote:
> > > > > On Thu, Feb 20, 2025 at 11:15 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> > > > > > > On Thu, Feb 20, 2025 at 7:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Feb 19, 2025 at 3:25 AM Barry Song <21cnbao@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > > > > >
> > > > > > > > > userfaultfd_move() checks whether the PTE entry is present or a
> > > > > > > > > swap entry.
> > > > > > > > >
> > > > > > > > > - If the PTE entry is present, move_present_pte() handles folio
> > > > > > > > >   migration by setting:
> > > > > > > > >
> > > > > > > > >   src_folio->index = linear_page_index(dst_vma, dst_addr);
> > > > > > > > >
> > > > > > > > > - If the PTE entry is a swap entry, move_swap_pte() simply copies
> > > > > > > > >   the PTE to the new dst_addr.
> > > > > > > > >
> > > > > > > > > This approach is incorrect because even if the PTE is a swap
> > > > > > > > > entry, it can still reference a folio that remains in the swap
> > > > > > > > > cache.
> > > > > > > > >
> > > > > > > > > If do_swap_page() is triggered, it may locate the folio in the
> > > > > > > > > swap cache. However, during add_rmap operations, a kernel panic
> > > > > > > > > can occur due to:
> > > > > > > > >  page_pgoff(folio, page) != linear_page_index(vma, address)
> > > > > > > >
> > > > > > > > Thanks for the report and reproducer!
> > > > > > > >
> > > > > > > > >
> > > > > > > > > $./a.out > /dev/null
> > > > > > > > > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
> > > > > > > > > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
> > > > > > > > > [   13.337716] memcg:ffff00000405f000
> > > > > > > > > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
> > > > > > > > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> > > > > > > > > [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> > > > > > > > > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
> > > > > > > > > [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
> > > > > > > > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
> > > > > > > > > [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
> > > > > > > > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
> > > > > > > > > [   13.340190] ------------[ cut here ]------------
> > > > > > > > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > > > > > > > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > > > > > > > > [   13.340969] Modules linked in:
> > > > > > > > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
> > > > > > > > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > > > > > > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > > > > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > > > > > > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > > > > > > > [   13.342018] sp : ffff80008752bb20
> > > > > > > > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
> > > > > > > > > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
> > > > > > > > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
> > > > > > > > > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
> > > > > > > > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
> > > > > > > > > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
> > > > > > > > > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
> > > > > > > > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
> > > > > > > > > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
> > > > > > > > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
> > > > > > > > > [   13.343876] Call trace:
> > > > > > > > > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > > > > > > > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > > > > > > > [   13.344333]  do_swap_page+0x1060/0x1400
> > > > > > > > > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > > > > > > > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > > > > > > > [   13.344586]  do_page_fault+0x20c/0x770
> > > > > > > > > [   13.344673]  do_translation_fault+0xb4/0xf0
> > > > > > > > > [   13.344759]  do_mem_abort+0x48/0xa0
> > > > > > > > > [   13.344842]  el0_da+0x58/0x130
> > > > > > > > > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > > > > > > > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > > > > > > > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> > > > > > > > > [   13.345504] ---[ end trace 0000000000000000 ]---
> > > > > > > > > [   13.345715] note: a.out[107] exited with irqs disabled
> > > > > > > > > [   13.345954] note: a.out[107] exited with preempt_count 2
> > > > > > > > >
> > > > > > > > > Fully fixing it would be quite complex, requiring similar handling
> > > > > > > > > of folios as done in move_present_pte.
> > > > > > > >
> > > > > > > > How complex would that be? Is it a matter of adding
> > > > > > > > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > > > > > > > folio->index = linear_page_index like in move_present_pte() or
> > > > > > > > something more?
> > > > > > >
> > > > > > > My main concern is still with large folios that require a split_folio()
> > > > > > > during move_pages(), as the entire folio shares the same index and
> > > > > > > anon_vma. However, userfaultfd_move() moves pages individually,
> > > > > > > making a split necessary.
> > > > > > >
> > > > > > > However, in split_huge_page_to_list_to_order(), there is a:
> > > > > > >
> > > > > > >         if (folio_test_writeback(folio))
> > > > > > >                 return -EBUSY;
> > > > > > >
> > > > > > > This is likely true for swapcache, right? However, even for move_present_pte(),
> > > > > > > it simply returns -EBUSY:
> > > > > > >
> > > > > > > move_pages_pte()
> > > > > > > {
> > > > > > >                 /* at this point we have src_folio locked */
> > > > > > >                 if (folio_test_large(src_folio)) {
> > > > > > >                         /* split_folio() can block */
> > > > > > >                         pte_unmap(&orig_src_pte);
> > > > > > >                         pte_unmap(&orig_dst_pte);
> > > > > > >                         src_pte = dst_pte = NULL;
> > > > > > >                         err = split_folio(src_folio);
> > > > > > >                         if (err)
> > > > > > >                                 goto out;
> > > > > > >
> > > > > > >                         /* have to reacquire the folio after it got split */
> > > > > > >                         folio_unlock(src_folio);
> > > > > > >                         folio_put(src_folio);
> > > > > > >                         src_folio = NULL;
> > > > > > >                         goto retry;
> > > > > > >                 }
> > > > > > > }
> > > > > > >
> > > > > > > Do we need a folio_wait_writeback() before calling split_folio()?
> > > > > >
> > > > > > Maybe no need in the first version to fix the immediate bug?
> > > > > >
> > > > > > It's also not always the case to hit writeback here. IIUC, writeback only
> > > > > > happens for a short window when the folio was just added into swapcache.
> > > > > > MOVE can happen much later after that anytime before a swapin.  My
> > > > > > understanding is that's also what Matthew wanted to point out.  It may be
> > > > > > better justified of that in a separate change with some performance
> > > > > > measurements.
> > > > >
> > > > > The bug we’re discussing occurs precisely within the short window you
> > > > > mentioned.
> > > > >
> > > > > 1. add_to_swap: The folio is added to swapcache.
> > > > > 2. try_to_unmap: PTEs are converted to swap entries.
> > > > > 3. pageout
> > > > > 4. Swapcache is cleared.
> > > >
> > > > Hmm, I see. I was expecting step 4 to be "writeback is cleared".. or at
> > > > least that should be step 3.5, as IIUC "writeback" needs to be cleared
> > > > before "swapcache" bit being cleared.
> > > >
> > > > >
> > > > > The issue happens between steps 2 and 4, where the PTE is not present, but
> > > > > the folio is still in swapcache - the current code does move_swap_pte() but does
> > > > > not fixup folio->index within swapcache.
> > > >
> > > > One thing I'm still not clear here is why it's a race condition, rather
> > > > than more severe than that.  I mean, folio->index is definitely wrong, then
> > > > as long as the page still in swapcache, we should be able to move the swp
> > > > entry over to dest addr of UFFDIO_MOVE, read on dest addr, then it'll see
> > > > the page in swapcache with the wrong folio->index already and trigger.
> > > >
> > > > I wrote a quick test like that, it actually won't trigger..
> > > >
> > > > I had a closer look in the code, I think it's because do_swap_page() has
> > > > the logic to detect folio->index matching first, and allocate a new folio
> > > > if it doesn't match in ksm_might_need_to_copy().  IIUC that was for
> > > > ksm.. but it looks like it's functioning too here.
> > > >
> > > > ksm_might_need_to_copy:
> > > >         if (folio_test_ksm(folio)) {
> > > >                 if (folio_stable_node(folio) &&
> > > >                     !(ksm_run & KSM_RUN_UNMERGE))
> > > >                         return folio;   /* no need to copy it */
> > > >         } else if (!anon_vma) {
> > > >                 return folio;           /* no need to copy it */
> > > >         } else if (folio->index == linear_page_index(vma, addr) && <---------- [1]
> > > >                         anon_vma->root == vma->anon_vma->root) {
> > > >                 return folio;           /* still no need to copy it */
> > > >         }
> > > >         ...
> > > >
> > > >         new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, addr); <---- [2]
> > > >         ...
> > > >
> > > > So I believe what I hit is at [1] it sees index doesn't match, then it
> > > > decided to allocate a new folio.  In this case, it won't hit your BUG
> > > > because it'll be "folio != swapcache" later, so it'll setup the
> > > > folio->index for the new one, rather than the sanity check.
> > > >
> > > > Do you know how your case got triggered, being able to bypass the above [1]
> > > > which should check folio->index already?
> > >
> > > To understand the change I tried applying the proposed patch to both
> > > mm-unstable and Linus' ToT and got conflicts for both trees. Barry,
> > > which baseline are you using?
> >
> > Oops, never mind. My mistake. Copying from the email messed up tabs...
> > It applies cleanly.
>
> Overall the code seems correct to me, however the new code has quite
> complex logical structure IMO. Original simplified code structure is
> like this:
>
> if (pte_present(orig_src_pte)) {
>         if (is_zero_pfn) {
>                 move_zeropage_pte()
>                 return
>         }
>         // pin and lock src_folio
>         spin_lock(src_ptl)
>         folio_get(folio)
>         folio_trylock(folio)
>         if (folio_test_large(src_folio))
>                 split_folio(src_folio)
>         anon_vma_trylock_write(src_anon_vma)
>         move_present_pte()
> } else {
>         if (non_swap_entry(entry))
>                 if (is_migration_entry(entry))
>                         handle migration entry
>         else
>                 move_swap_pte()
> }
>
> The new structure looks like this:
>
> if (!pte_present(orig_src_pte)) {
>         if (is_migration_entry(entry)) {
>                 handle migration entry
>                 return
>        }
>         if (!non_swap_entry() ||  !pte_swp_exclusive())
>                 return
>         si = get_swap_device(entry);
> }
> if (pte_present(orig_src_pte) && is_zero_pfn(pte_pfn(orig_src_pte)))
>         move_zeropage_pte()
>         return
> }
> pin and lock src_folio
>         spin_lock(src_ptl)
>         if (pte_present(orig_src_pte))
>                 folio_get(folio)
>         else {
>                 folio = filemap_get_folio(swap_entry)
>                 if (IS_ERR(folio))
>                         move_swap_pte()
>                         return
>                 }
>         }
>         folio_trylock(folio)
> if (folio_test_large(src_folio))
>         split_folio(src_folio)
> if (pte_present(orig_src_pte))
>         anon_vma_trylock_write(src_anon_vma)
> move_pte_and_folio()
>
> This looks more complex and harder to follow. Might be the reason
> David was not in favour of treating swapcache and present pages in the
> same path. And now I would agree that refactoring some common parts
> and not breaking the original structure might be cleaner.

Exactly, that’s the cost we’re facing in trying to share the code path
for swap and present PTEs.

I tried to extract some common functions for present PTE and swap entries,
but I found too many detailed differences and variants. This made the common
function overly complex, turning it into a real "monster." As a result, I
don't think this approach would make the code any more readable or cleaner.

After trying a couple of times, I feel the following is somehow more
readable:
(Lokesh is eager for the small folios fixes to be merged without further
delay. So, I'd prefer to return -EBUSY for large folios in the hotfixes
and handle the mTHP -EBUSY issue in a separate patch later.)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 867898c4e30b..eed9286ec1f3 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -18,6 +18,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include "internal.h"
+#include "swap.h"
 
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
@@ -1072,15 +1073,15 @@ static int move_present_pte(struct mm_struct *mm,
 	return err;
 }
 
-static int move_swap_pte(struct mm_struct *mm,
+static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 			 unsigned long dst_addr, unsigned long src_addr,
 			 pte_t *dst_pte, pte_t *src_pte,
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
-			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
+			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
+			 struct folio *src_folio)
 {
-	if (!pte_swp_exclusive(orig_src_pte))
-		return -EBUSY;
+	int err = 0;
 
 	double_pt_lock(dst_ptl, src_ptl);
 
@@ -1090,11 +1091,22 @@ static int move_swap_pte(struct mm_struct *mm,
 		return -EAGAIN;
 	}
 
+	if (src_folio) {
+		/* Folio got pinned from under us. Put it back and fail the move. */
+		if (folio_maybe_dma_pinned(src_folio)) {
+			err = -EBUSY;
+			goto out;
+		}
+		folio_move_anon_rmap(src_folio, dst_vma);
+		src_folio->index = linear_page_index(dst_vma, dst_addr);
+	}
+
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
-	double_pt_unlock(dst_ptl, src_ptl);
 
-	return 0;
+out:
+	double_pt_unlock(dst_ptl, src_ptl);
+	return err;
 }
 
 static int move_zeropage_pte(struct mm_struct *mm,
@@ -1137,6 +1149,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			  __u64 mode)
 {
 	swp_entry_t entry;
+	struct swap_info_struct *si = NULL;
 	pte_t orig_src_pte, orig_dst_pte;
 	pte_t src_folio_pte;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -1318,6 +1331,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				       orig_dst_pte, orig_src_pte, dst_pmd,
 				       dst_pmdval, dst_ptl, src_ptl, src_folio);
 	} else {
+		struct folio *folio = NULL;
+
 		entry = pte_to_swp_entry(orig_src_pte);
 		if (non_swap_entry(entry)) {
 			if (is_migration_entry(entry)) {
@@ -1331,9 +1346,47 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			goto out;
 		}
 
-		err = move_swap_pte(mm, dst_addr, src_addr, dst_pte, src_pte,
-				    orig_dst_pte, orig_src_pte, dst_pmd,
-				    dst_pmdval, dst_ptl, src_ptl);
+		if (!pte_swp_exclusive(orig_src_pte)) {
+			err = -EBUSY;
+			goto out;
+		}
+
+		si = get_swap_device(entry);
+		if (unlikely(!si)) {
+			err = -EAGAIN;
+			goto out;
+		}
+                /*
+                 * Check if swapcache exists. If it does, the folio must be
+                 * moved even if the PTE is a swap entry. For large folios,
+                 * we directly return -EBUSY, as split_folio() currently
+                 * also returns -EBUSY when attempting to split unmapped
+                 * large folios in the swapcache. This needs to be fixed
+                 * to allow proper handling.
+                 */
+		if (!src_folio)
+			folio = filemap_get_folio(swap_address_space(entry),
+					swap_cache_index(entry));
+		if (!IS_ERR_OR_NULL(folio)) {
+			if (folio_test_large(folio)) {
+				err = -EBUSY;
+				folio_put(folio);
+				goto out;
+			}
+			src_folio = folio;
+			if (!folio_trylock(src_folio)) {
+				pte_unmap(&orig_src_pte);
+				pte_unmap(&orig_dst_pte);
+				src_pte = dst_pte = NULL;
+				/* now we can block and wait */
+				folio_lock(src_folio);
+				si = NULL;
+				goto retry;
+			}
+		}
+		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
+				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
+				dst_ptl, src_ptl, src_folio);
 	}
 
 out:
@@ -1350,6 +1403,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	if (src_pte)
 		pte_unmap(src_pte);
 	mmu_notifier_invalidate_range_end(&range);
+	if (si)
+		put_swap_device(si);
 
 	return err;
 }

If there are no objections, I'll send v2 tomorrow with the above code.
12:04 AM, Time to get some sleep now! :-)


>
> >
> > >
> > > >
> > > > >
> > > > > My point is that if we want a proper fix for mTHP, we'd better handle writeback.
> > > > > Otherwise, this isn’t much different from directly returning -EBUSY as proposed
> > > > > in this RFC.
> > > > >
> > > > > For small folios, there’s no split_folio issue, making it relatively
> > > > > simpler. Lokesh
> > > > > mentioned plans to madvise NOHUGEPAGE in ART, so fixing small folios is likely
> > > > > the first priority.
> > > >
> > > > Agreed.
> > > >
> > > > --
> > > > Peter Xu
> > > >

Thanks
Barry



