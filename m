Return-Path: <linux-kernel+bounces-522760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0422A3CE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3FE175D64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1533985;
	Thu, 20 Feb 2025 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4n8E6Qj"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93929A29
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012578; cv=none; b=dCC52p5wQs3bDhJE0wkRUBxIoSfSlEmwJVL6hLL/NatqC39j1WevXrmXwVzcijAZqAFYkMNtys7cLwap0BGw2+xx4L0azGjSeTLsb62pOAd3xUflO3UwF4uqUmUBdxaLnGl6eT2fXueNTXhiRO02JaWlzBnD3Dy2sfCuR8KTHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012578; c=relaxed/simple;
	bh=KS9xSeJOZ+5ltsWhX476OoAgrslgOC8wfRLEOr8r0i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Csx0p3LKBD1WwvBbBtEY/F2NPWGqdV5ORzISgsbeBHfIFN9s/8vznJbcH23op5ayRjgDGY+f6VVrIomLqlTwHuZe/ZrUh9OAIUuLgFb9K2IVy4TfgCa0qx2/soOzXJv6kO57mKE/G5tfppy1jefvISOBbo0K2ClbqFqjYqfWl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4n8E6Qj; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4bfb4853a5dso372137.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740012575; x=1740617375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfNL7c7U2t56lw1fFLt/3GTAGwDZ6wCtNRc8hUbebIo=;
        b=i4n8E6QjFaX7BbLSEIF3vT/oPFYcVNK2SYyLH2sVh5BHSggbCGHvB8WwkbZUheKkQA
         oWm+ufrGFYgwhqhsoXwQ5z0cE5QlhiFBqfXVkB6YQ/nbVjWm/iG4x22W0EfCHgyRfPRB
         DeJXoRxMaAa8gIkg3pdGpyCK3pS0xSG+aOgaN48N9u1AfgMVCeQvVheHtaIBYJKmTaCr
         Y7aA/XGtaNJwc0uVkESwY+U8ConunnGqognNrl8MV7/nJDYuMYD3zfy+BDd2fE1a/v/X
         N9dk+RmeduRB3j3xxZoOY4mVk/Zjr+K1+CxDRr4TW5Qqym3N8OgAJ4avoYj/isIGP+ze
         T9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740012575; x=1740617375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfNL7c7U2t56lw1fFLt/3GTAGwDZ6wCtNRc8hUbebIo=;
        b=BAKXJnGk4L2GS3VlqHRJEAFdNobNiOeSafrfYlHwoNg/qgvHyxdrfQbPb6S2gEChPN
         u81gxe9JTEm1iCdnGSPZQngtO6uMoKVNkV4CjvFnwb3kY7LIYA45KPtPvSWoIKlmj+WH
         XUt0pAZBChkS20eebIY6ryrn/XEQR/8B0+nOP/PXCmgNrqJdV+3W0UjwGKLDEfiTSItO
         qifvw9rLZpgdT51Xnp7BSjjlAMfPcW5MO27GsF8wA1APoW3WMU2w4QRtGTphp+IgiTqh
         R2Y8/cCi69V7xMhy4HFMvmnIZ+T0T8nwo8NzQAFFMDdphxDE1Es13A2JE5S/z97JLtBo
         AzKw==
X-Forwarded-Encrypted: i=1; AJvYcCUzAPhOnuCKDH/Okm4lAZI3c5BGzMTJcQKcXJSxTvaLwPdbtKnvCHz8M7b/ALpVQgdIZ54zB9xCwMgfUvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SaFBgVYZoQt0d7u0atJ71JjtwHd+I5MMN/W2EPEI8kDnIjrZ
	+WLgBwQhnINJWuiXCgryy2m7gRtPhAdlt6xIyA8dxUetSy/cY1NKxYtdeUYIcCxldEn+wXhGMT8
	sn7t0Z5arQsFDqHDZMVk+rAyn+YHdcFX6sQ4=
X-Gm-Gg: ASbGnctEnWPkW0w84U8Te6+kaHxagjhx/uIC98yASg4quk58Z/WT0oeV4nE0bI5INyH
	1pz49S1EoZXLT/vLWSI0s20lvw3BQsDNpDS3EMM3ikA4wKZEHLrsaQIBfclKhzdHthw1Uu4n9
X-Google-Smtp-Source: AGHT+IE+DeW4FAWGYKbe62H0bYUYypDQeyaLnwZL1hvomSwU7SMvCmXWFbRxG542EwfT9Kwr+nHOnYKfdRwj4zDHqpc=
X-Received: by 2002:a05:6102:3592:b0:4bb:d7f0:6e7d with SMTP id
 ada2fe7eead31-4be85ce5084mr3878917137.25.1740012575247; Wed, 19 Feb 2025
 16:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
 <Z7ZX28XARM7seknO@x1.local> <CAGsJ_4wptMn8HX6Uam7AQpWeE=nOUDHE-Vr81SQJq_oSjmTFHg@mail.gmail.com>
 <CA+EESO4v-aRMGNy5ZNV8c8-CqqEGa_CkjB2znibSQ=r1zqXz3g@mail.gmail.com>
In-Reply-To: <CA+EESO4v-aRMGNy5ZNV8c8-CqqEGa_CkjB2znibSQ=r1zqXz3g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Feb 2025 13:49:24 +1300
X-Gm-Features: AWEUYZlSNZ_rn1r4QH5a9UT9GHos2aaViRar0322BOr_WPgv_gXhJqRVPBFQnek
Message-ID: <CAGsJ_4w6CTURcB0N2+zZJ37G5q1+Qq1jW-+zhR1VPr38fiE1+A@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
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

On Thu, Feb 20, 2025 at 12:19=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Wed, Feb 19, 2025 at 3:04=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
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
> >
> > The issue happens between steps 2 and 4, where the PTE is not present, =
but
> > the folio is still in swapcache - the current code does move_swap_pte()=
 but does
> > not fixup folio->index within swapcache.
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
> Fixing for the non-mTHP case first sounds good to me. For a large
> folio in swap cache maybe you can return EBUSY for now?
>
> But for that, I believe the cleanest and simplest would be to
> restructure move_pages_pte() such that folio is retrieved from
> vm_normal_foliio() if src_pte is present, otherwise, from
> filemap_get_folio() and then incorporate the check you have in this
> FRC in there. This way the entire locking dance logic in there can be
> reused for swap-cache case as well.

Yep, let me give it a try in v2.

> >
> > >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> >
> > Thanks
> > Barry

