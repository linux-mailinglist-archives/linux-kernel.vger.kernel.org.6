Return-Path: <linux-kernel+bounces-525045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7BCA3EA22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219E83AFF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5368F225D6;
	Fri, 21 Feb 2025 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goix/GuN"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2D8821
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101802; cv=none; b=odJthfqcNSISyBVUmmlD492sIkVFHDNk0nt5JJ/Meguulm3yN8BXmFEBjOyGSGjHfFDpyZRfUD30HOXyv/dU461LVLhGZ2Se1Wr+HBDkCz+hpIl+vTipzxOLq6Xp+E2KTh3pYUpAKZaL73mUoUmT/Rc270gBoILhMmuIx7I7440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101802; c=relaxed/simple;
	bh=oRXHS6L+qjZJF6T3xFs1t/bi39sC/M6fUgnNKwEE8k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWqfpPLyLSWFMr7Ee3CYfoKJgW9WgXsumRJa3VFD1+nZZJbeVv+dJ19tM0eGXgdgW+9IQ491jbgOuWI5idToGMlKpLhIETsis3fog0T/HEvjTuEXv2AICt20N2LNAHeAFpNTgcZcyHewaCe78TH4DL5qSuCYvFMkvXAi7k2Q9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goix/GuN; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-521b84da5e9so328937e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740101799; x=1740706599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQel4KqqxYlgH/qOSl9x/DKFeBn1B6rTaFzOVEKZD8s=;
        b=goix/GuNKUAweNk1xSCfYdJRC/m68dTW+P9WWO1DBQxmaCqu9wYFcF2IldoDPQGmd5
         UPVy+DzM8UUxCMGLqDCY6xa+bsiHpGcnWTdvg8y8N3dmmGXuMHXqqIK87hMf2YFVYlVh
         AKqJHP+2nfLGKPgK+W57k2km1RPXa2H+gf+skU/CIfzMbus5+noD80K4ayDYlsHaa4oy
         3eX6IQTYpDOfKHVFHwx+NnLhxmtpwpNZ/cbAvWs7+tMq18j+adYFzMMq4opg7VF42c0y
         2erYhlYFusf1TJUZ5cd/RdDgHq91PRCFYQtkyqiK8bnPE7ZcrTbYv1G8n+sf5Vep9HM3
         0D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740101799; x=1740706599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQel4KqqxYlgH/qOSl9x/DKFeBn1B6rTaFzOVEKZD8s=;
        b=gr6mkoCsbI1cIEtjVcr7OxellE7cYtWkfcyuBOu+ixsJ06N+GQ3ZToDQZ74QTfy4Ek
         rm5Xfp0Qf6L9vU/+F3iX7/ONquMBKyKuKoOajBUroIePisKtt23LmZiiIlN+d84yQAUP
         1IJZ+m9Pzh1t8d0EhKVFXyEXJMSTrDke6uD5JNmQSqtUJsV6fn6FY0ZjEqnFm3k6JLWm
         Bsp/8L/T4kM7QzcyzMy6bNGOWQnFxxAUEggPl3DsIgLAVBykTg4vpJYrZZ3xF3CK0/3b
         2Sz/ASSFBSaWuVpLs6B3zGNzbylnug2AjZ+Qxw3QKMOaNyfrFrc6qI2CY6FIZ0HtEQ7A
         bibQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9fT5LiVeq2103j5WlFy+7YKs4wvmdKvM9vcaN/Hi5kYxs4WHucHX1Ih3zL5fS5XEVKBecmK3udNhYBww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhrj1RrGMzzUK9y1k1zzXsESXzuPBrSzH+B7A18TOesVG5IRqe
	RnmTAk2nPS0E9vpO3mNSvhAAzWHbWqC7f8zVRVHwZEArXPfouhyIMhx3EMPpeEwVKTt84WOlALv
	VtINru3mHByet7mrFotPb83iVyVw=
X-Gm-Gg: ASbGncsgq0QgVBQcd+O2tOupKJo6MEdz83yK83pRukuwPwTDT6QPBR1Pdc5qRVNje9W
	IsvfPRJNTZBA9hKxRSdn3oXVpOyJrr+0RPwuq/2HwOdEaQ+FffG5IRgL/EAHjUfv11wjnFShkct
	JsaN+a6FA=
X-Google-Smtp-Source: AGHT+IESbiHNBvWRKj5VOcEqyBOl1nbmv9qSww9gb73Mfq0ZldpuXTpQ99EDbEjIcwIJywwUpS0bxprbp5SRbWE4yuc=
X-Received: by 2002:a05:6102:f9a:b0:4bb:eb4a:fa03 with SMTP id
 ada2fe7eead31-4bfc01cf2d4mr1291866137.23.1740101799117; Thu, 20 Feb 2025
 17:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
 <Z7ZX28XARM7seknO@x1.local> <CAGsJ_4wptMn8HX6Uam7AQpWeE=nOUDHE-Vr81SQJq_oSjmTFHg@mail.gmail.com>
 <Z7ez2Vl8Sa_bRb4e@x1.local>
In-Reply-To: <Z7ez2Vl8Sa_bRb4e@x1.local>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 21 Feb 2025 14:36:27 +1300
X-Gm-Features: AWEUYZkSW--msgIBLeqZTKMnk-eQVBhr1ZP2UygfjAv_hWP4COZlYOEfhbkdifE
Message-ID: <CAGsJ_4yb0AURkm4rP3ecgsPdnhfjg-hwJ8=RQjC1wcwwUdBH5g@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Axel Rasmussen <axelrasmussen@google.com>, Brian Geffon <bgeffon@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Shuah Khan <shuah@kernel.org>, ZhangPeng <zhangpeng362@huawei.com>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:59=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, Feb 20, 2025 at 12:04:40PM +1300, Barry Song wrote:
> > On Thu, Feb 20, 2025 at 11:15=E2=80=AFAM Peter Xu <peterx@redhat.com> w=
rote:
> > >
> > > On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> > > > On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > >
> > > > > On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail=
.com> wrote:
> > > > > >
> > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > >
> > > > > > userfaultfd_move() checks whether the PTE entry is present or a
> > > > > > swap entry.
> > > > > >
> > > > > > - If the PTE entry is present, move_present_pte() handles folio
> > > > > >   migration by setting:
> > > > > >
> > > > > >   src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> > > > > >
> > > > > > - If the PTE entry is a swap entry, move_swap_pte() simply copi=
es
> > > > > >   the PTE to the new dst_addr.
> > > > > >
> > > > > > This approach is incorrect because even if the PTE is a swap
> > > > > > entry, it can still reference a folio that remains in the swap
> > > > > > cache.
> > > > > >
> > > > > > If do_swap_page() is triggered, it may locate the folio in the
> > > > > > swap cache. However, during add_rmap operations, a kernel panic
> > > > > > can occur due to:
> > > > > >  page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> > > > >
> > > > > Thanks for the report and reproducer!
> > > > >
> > > > > >
> > > > > > $./a.out > /dev/null
> > > > > > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43d=
b19c index:0xffffaf150 pfn:0x4667c
> > > > > > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pa=
ges_mapped:1 pincount:0
> > > > > > [   13.337716] memcg:ffff00000405f000
> > > > > > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|di=
rty|owner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > > > > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008=
507b538 ffff000006260361
> > > > > > [   13.338831] raw: 0000000ffffaf150 0000000000004000 000000060=
0000000 ffff00000405f000
> > > > > > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff8000=
8507b538 ffff000006260361
> > > > > > [   13.339204] head: 0000000ffffaf150 0000000000004000 00000006=
00000000 ffff00000405f000
> > > > > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff=
00000000 0000000000000001
> > > > > > [   13.339546] head: 0000000000000004 0000000000000000 00000000=
ffffffff 0000000000000000
> > > > > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(f=
olio, page) !=3D linear_page_index(vma, address))
> > > > > > [   13.340190] ------------[ cut here ]------------
> > > > > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > > > > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1=
] PREEMPT SMP
> > > > > > [   13.340969] Modules linked in:
> > > > > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6=
.14.0-rc3-gcf42737e247a-dirty #299
> > > > > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > > > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT =
-SSBS BTYPE=3D--)
> > > > > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > > > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > > > > [   13.342018] sp : ffff80008752bb20
> > > > > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27:=
 0000000000000001
> > > > > > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24:=
 0000000000000001
> > > > > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21:=
 fffffdffc0199f00
> > > > > > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18:=
 00000000ffffffff
> > > > > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15:=
 662866666f67705f
> > > > > > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12:=
 ffff800083728ab0
> > > > > > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 :=
 ffff80008011bc40
> > > > > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 :=
 ffff8000829eebf8
> > > > > > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 :=
 0000000000000000
> > > > > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 :=
 000000000000005f
> > > > > > [   13.343876] Call trace:
> > > > > > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > > > > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > > > > [   13.344333]  do_swap_page+0x1060/0x1400
> > > > > > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > > > > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > > > > [   13.344586]  do_page_fault+0x20c/0x770
> > > > > > [   13.344673]  do_translation_fault+0xb4/0xf0
> > > > > > [   13.344759]  do_mem_abort+0x48/0xa0
> > > > > > [   13.344842]  el0_da+0x58/0x130
> > > > > > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > > > > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > > > > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210=
000)
> > > > > > [   13.345504] ---[ end trace 0000000000000000 ]---
> > > > > > [   13.345715] note: a.out[107] exited with irqs disabled
> > > > > > [   13.345954] note: a.out[107] exited with preempt_count 2
> > > > > >
> > > > > > Fully fixing it would be quite complex, requiring similar handl=
ing
> > > > > > of folios as done in move_present_pte.
> > > > >
> > > > > How complex would that be? Is it a matter of adding
> > > > > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > > > > folio->index =3D linear_page_index like in move_present_pte() or
> > > > > something more?
> > > >
> > > > My main concern is still with large folios that require a split_fol=
io()
> > > > during move_pages(), as the entire folio shares the same index and
> > > > anon_vma. However, userfaultfd_move() moves pages individually,
> > > > making a split necessary.
> > > >
> > > > However, in split_huge_page_to_list_to_order(), there is a:
> > > >
> > > >         if (folio_test_writeback(folio))
> > > >                 return -EBUSY;
> > > >
> > > > This is likely true for swapcache, right? However, even for move_pr=
esent_pte(),
> > > > it simply returns -EBUSY:
> > > >
> > > > move_pages_pte()
> > > > {
> > > >                 /* at this point we have src_folio locked */
> > > >                 if (folio_test_large(src_folio)) {
> > > >                         /* split_folio() can block */
> > > >                         pte_unmap(&orig_src_pte);
> > > >                         pte_unmap(&orig_dst_pte);
> > > >                         src_pte =3D dst_pte =3D NULL;
> > > >                         err =3D split_folio(src_folio);
> > > >                         if (err)
> > > >                                 goto out;
> > > >
> > > >                         /* have to reacquire the folio after it got=
 split */
> > > >                         folio_unlock(src_folio);
> > > >                         folio_put(src_folio);
> > > >                         src_folio =3D NULL;
> > > >                         goto retry;
> > > >                 }
> > > > }
> > > >
> > > > Do we need a folio_wait_writeback() before calling split_folio()?
> > >
> > > Maybe no need in the first version to fix the immediate bug?
> > >
> > > It's also not always the case to hit writeback here. IIUC, writeback =
only
> > > happens for a short window when the folio was just added into swapcac=
he.
> > > MOVE can happen much later after that anytime before a swapin.  My
> > > understanding is that's also what Matthew wanted to point out.  It ma=
y be
> > > better justified of that in a separate change with some performance
> > > measurements.
> >
> > The bug we=E2=80=99re discussing occurs precisely within the short wind=
ow you
> > mentioned.
> >
> > 1. add_to_swap: The folio is added to swapcache.
> > 2. try_to_unmap: PTEs are converted to swap entries.
> > 3. pageout
> > 4. Swapcache is cleared.
>
> Hmm, I see. I was expecting step 4 to be "writeback is cleared".. or at
> least that should be step 3.5, as IIUC "writeback" needs to be cleared
> before "swapcache" bit being cleared.
>
> >
> > The issue happens between steps 2 and 4, where the PTE is not present, =
but
> > the folio is still in swapcache - the current code does move_swap_pte()=
 but does
> > not fixup folio->index within swapcache.
>
> One thing I'm still not clear here is why it's a race condition, rather
> than more severe than that.  I mean, folio->index is definitely wrong, th=
en
> as long as the page still in swapcache, we should be able to move the swp
> entry over to dest addr of UFFDIO_MOVE, read on dest addr, then it'll see
> the page in swapcache with the wrong folio->index already and trigger.
>
> I wrote a quick test like that, it actually won't trigger..
>
> I had a closer look in the code, I think it's because do_swap_page() has
> the logic to detect folio->index matching first, and allocate a new folio
> if it doesn't match in ksm_might_need_to_copy().  IIUC that was for
> ksm.. but it looks like it's functioning too here.
>
> ksm_might_need_to_copy:
>         if (folio_test_ksm(folio)) {
>                 if (folio_stable_node(folio) &&
>                     !(ksm_run & KSM_RUN_UNMERGE))
>                         return folio;   /* no need to copy it */
>         } else if (!anon_vma) {
>                 return folio;           /* no need to copy it */
>         } else if (folio->index =3D=3D linear_page_index(vma, addr) && <-=
--------- [1]
>                         anon_vma->root =3D=3D vma->anon_vma->root) {
>                 return folio;           /* still no need to copy it */
>         }
>         ...
>
>         new_folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, addr)=
; <---- [2]
>         ...
>
> So I believe what I hit is at [1] it sees index doesn't match, then it
> decided to allocate a new folio.  In this case, it won't hit your BUG
> because it'll be "folio !=3D swapcache" later, so it'll setup the
> folio->index for the new one, rather than the sanity check.

You're absolutely right.  The problem goes beyond just crashes; we're
also dealing with CoW when KSM is enabled. As long as we disable
KSM(which is true for Android), or when we are dealing with a large folio,
ksm_might_need_to_copy() will not allocate a new copy:

struct folio *ksm_might_need_to_copy(struct folio *folio,
                        struct vm_area_struct *vma, unsigned long addr)
{

        struct page *page =3D folio_page(folio, 0);
        struct anon_vma *anon_vma =3D folio_anon_vma(folio);
        struct folio *new_folio;

        if (folio_test_large(folio))
                return folio;
         ....
}

Thanks for your great findings! For the KSM-enabled and small folio case,
it's pretty funny how UFFDIO_MOVE finally turns into a new allocation and
copy=E2=80=94 somehow automatically falling back to "UFFDIO_COPY" :-)
It's amusing, but debugging it is fun.

I'll add your findings to the changelog when I formally send v2, after gath=
ering
all the code refinement suggestions and implementing the improvements.

>
> Do you know how your case got triggered, being able to bypass the above [=
1]
> which should check folio->index already?
>
> >
> > My point is that if we want a proper fix for mTHP, we'd better handle w=
riteback.
> > Otherwise, this isn=E2=80=99t much different from directly returning -E=
BUSY as proposed
> > in this RFC.
> >
> > For small folios, there=E2=80=99s no split_folio issue, making it relat=
ively
> > simpler. Lokesh
> > mentioned plans to madvise NOHUGEPAGE in ART, so fixing small folios is=
 likely
> > the first priority.
>
> Agreed.
>
> --
> Peter Xu
>

Thanks
Barry

