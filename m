Return-Path: <linux-kernel+bounces-522687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC3A3CD4F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E303A9276
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6D1214A7C;
	Wed, 19 Feb 2025 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtKYsmQ0"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765A1DE883
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007199; cv=none; b=SV7ofJHtrslGeicvGPEqzrLPhjAMbIAzX2e+hSJdkHnHFfC8sheVYW9ZXqF1bhshNsIQtChimop52auuGePYWPplmt34+lTIkFC36CrwhMcrWVDoEU/8YudC6q1YYo7IL+zw5396XKRsvmk5gfLH1A2TpVpYT5+g0wUIW9T6mwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007199; c=relaxed/simple;
	bh=Iprrm2B02Tsi0w7Xb9f7XboqsUplP294+Tusv+k+h6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZLwaW2Y3ZGVKw8MzbpqkEm5xKVSKxMfBJvb7QY8N6XtGtg/hTwuHgOOnfZIbTNVsfLwYYkGY69HkR/8AFMdfMkxzRPN3DvbGCZPbnnTNntmMJP5ahiJ5c3xWPr3XlS8NiAi3Mwh1pJeL39eXMCU+G9w9e7snKjIrJ2AuVmCMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtKYsmQ0; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471fa3b19bcso101261cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740007196; x=1740611996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTn7IdANd5+OwuUDOviJNPx8fYljpy+W7Qh0TY3l+ak=;
        b=jtKYsmQ0mRTtfRYvm4/fzYOyVsWRQh1q1eXRyoPwvR3vyZLFAGIo1X0pMhHJBnFSBB
         IR7PiGRXy1ILDHEZsCSsQm9cKR0N3k9Dw8agz5VQwlbL9e6ImH4s8PnMZUUGE4aM6AiZ
         xLd/gTH+8+4j9WPlef5A6m0iOtqPskMql4S/0bH2Nm6uv38IuWBpxnCUx5c0dcpYizJG
         lKZ9AEBcc8+UPyt+wJbdJVZ18Tdw+mErJK38r/45Y5Z3h8aDa+oFRHz2t5lePmqKr8gn
         fFUVJbosAf2PCLygQUg5my8OcxpPHmKfUoGWRC7d1PAnBaT/8ccoissc4+zAQGjs4uoH
         0pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007196; x=1740611996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTn7IdANd5+OwuUDOviJNPx8fYljpy+W7Qh0TY3l+ak=;
        b=NQGfyp9px4UK/rmtSkA0Vql2LJroqklOCHPqvYrmfDdpAIqCAat3H7CI3DoUtyDljK
         M8HaySQc/aEp2oj+9V38+ihKkboinqlHqNVTDLuHyq88l+kcR8oFUfJcwbUJCUG9GBq4
         csfjEtI0TrAbVBdrOQkzRi3FFgg6G+LfBU4MPZv+/m6XVpv6RjZcUS1YTgz95sYHOvDC
         7nLaoIyc/ydx5FZg4O9iwn76LorDXTmVw/UgTfkwvJ7uVeP6WGv5TXwmStoeIljGWiGE
         BnJJ0ben6xw55NeEdhOIYTtiC6ZVvQ5ZTcxAWgbSn6/+Z9qHwlyFejEdz4FkllP7oSRJ
         UOcA==
X-Forwarded-Encrypted: i=1; AJvYcCXLlUI5iSwodY7mJJDvM7jzLBsjRxJ2otxB/DrcMx4+dwvEl+xUg/a68qth+SNqbSIXONxAjb8CSbjoFB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygEz9KIaMP3JCOuIDVgQIkrQDRz9Vh1UaxG81Btgx8laCKrVCf
	/QXWEOxvv9KYBdNn5NvfayRpYPk75xKaeJKvSUYqVZF7JCmHA2QaAaYkWoT6N2bBWY8waBtcapu
	59Q8Zk4gpgU4NX0GgSPYWWPIZrv2dksYxypdz
X-Gm-Gg: ASbGnctG5QoFpPycXQPqszSzU5K/TxrKB7x2qIqLAwl1FcWyHyEgBQGYtXe+Zi0TzrK
	8rzK9tIjGKw8Y51d4PKydjpKPk+uLmf/JCKOuSdl4p3PzwpNdZJQ83Y6V0P3IuGH2kB1NoqmOYS
	Hzt5gGQQUMCVNHMyxDVZpn0WzUFbw=
X-Google-Smtp-Source: AGHT+IFBWCOfY9p2hyvzuE8mPmDo3MHHI8DXClAaf7zZEESZemzzeXvyk5i9ZgTxZc+jzdXP6eg5vppYtADxCCT9Bok=
X-Received: by 2002:a05:622a:1a88:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-4721708fbf4mr524581cf.1.1740007195890; Wed, 19 Feb 2025
 15:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
 <Z7ZX28XARM7seknO@x1.local> <CAGsJ_4wptMn8HX6Uam7AQpWeE=nOUDHE-Vr81SQJq_oSjmTFHg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wptMn8HX6Uam7AQpWeE=nOUDHE-Vr81SQJq_oSjmTFHg@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 19 Feb 2025 15:19:44 -0800
X-Gm-Features: AWEUYZkT8naKVFNVw2UCSAtbNHnmFbAusmnE6kcuNKIOLd5HOCSM2iGaSKUXSAA
Message-ID: <CA+EESO4v-aRMGNy5ZNV8c8-CqqEGa_CkjB2znibSQ=r1zqXz3g@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Barry Song <21cnbao@gmail.com>
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

On Wed, Feb 19, 2025 at 3:04=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Feb 20, 2025 at 11:15=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> >
> > On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> > > On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail.c=
om> wrote:
> > > > >
> > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > >
> > > > > userfaultfd_move() checks whether the PTE entry is present or a
> > > > > swap entry.
> > > > >
> > > > > - If the PTE entry is present, move_present_pte() handles folio
> > > > >   migration by setting:
> > > > >
> > > > >   src_folio->index =3D linear_page_index(dst_vma, dst_addr);
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
> > > > >  page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> > > >
> > > > Thanks for the report and reproducer!
> > > >
> > > > >
> > > > > $./a.out > /dev/null
> > > > > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db1=
9c index:0xffffaf150 pfn:0x4667c
> > > > > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_page=
s_mapped:1 pincount:0
> > > > > [   13.337716] memcg:ffff00000405f000
> > > > > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirt=
y|owner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > > > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff8000850=
7b538 ffff000006260361
> > > > > [   13.338831] raw: 0000000ffffaf150 0000000000004000 00000006000=
00000 ffff00000405f000
> > > > > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff800085=
07b538 ffff000006260361
> > > > > [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600=
000000 ffff00000405f000
> > > > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00=
000000 0000000000000001
> > > > > [   13.339546] head: 0000000000000004 0000000000000000 00000000ff=
ffffff 0000000000000000
> > > > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(fol=
io, page) !=3D linear_page_index(vma, address))
> > > > > [   13.340190] ------------[ cut here ]------------
> > > > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > > > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] =
PREEMPT SMP
> > > > > [   13.340969] Modules linked in:
> > > > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.1=
4.0-rc3-gcf42737e247a-dirty #299
> > > > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -S=
SBS BTYPE=3D--)
> > > > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > > > [   13.342018] sp : ffff80008752bb20
> > > > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0=
000000000000001
> > > > > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0=
000000000000001
> > > > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: f=
ffffdffc0199f00
> > > > > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 0=
0000000ffffffff
> > > > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 6=
62866666f67705f
> > > > > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: f=
fff800083728ab0
> > > > > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : f=
fff80008011bc40
> > > > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : f=
fff8000829eebf8
> > > > > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0=
000000000000000
> > > > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 0=
00000000000005f
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
> > > > > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d421000=
0)
> > > > > [   13.345504] ---[ end trace 0000000000000000 ]---
> > > > > [   13.345715] note: a.out[107] exited with irqs disabled
> > > > > [   13.345954] note: a.out[107] exited with preempt_count 2
> > > > >
> > > > > Fully fixing it would be quite complex, requiring similar handlin=
g
> > > > > of folios as done in move_present_pte.
> > > >
> > > > How complex would that be? Is it a matter of adding
> > > > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > > > folio->index =3D linear_page_index like in move_present_pte() or
> > > > something more?
> > >
> > > My main concern is still with large folios that require a split_folio=
()
> > > during move_pages(), as the entire folio shares the same index and
> > > anon_vma. However, userfaultfd_move() moves pages individually,
> > > making a split necessary.
> > >
> > > However, in split_huge_page_to_list_to_order(), there is a:
> > >
> > >         if (folio_test_writeback(folio))
> > >                 return -EBUSY;
> > >
> > > This is likely true for swapcache, right? However, even for move_pres=
ent_pte(),
> > > it simply returns -EBUSY:
> > >
> > > move_pages_pte()
> > > {
> > >                 /* at this point we have src_folio locked */
> > >                 if (folio_test_large(src_folio)) {
> > >                         /* split_folio() can block */
> > >                         pte_unmap(&orig_src_pte);
> > >                         pte_unmap(&orig_dst_pte);
> > >                         src_pte =3D dst_pte =3D NULL;
> > >                         err =3D split_folio(src_folio);
> > >                         if (err)
> > >                                 goto out;
> > >
> > >                         /* have to reacquire the folio after it got s=
plit */
> > >                         folio_unlock(src_folio);
> > >                         folio_put(src_folio);
> > >                         src_folio =3D NULL;
> > >                         goto retry;
> > >                 }
> > > }
> > >
> > > Do we need a folio_wait_writeback() before calling split_folio()?
> >
> > Maybe no need in the first version to fix the immediate bug?
> >
> > It's also not always the case to hit writeback here. IIUC, writeback on=
ly
> > happens for a short window when the folio was just added into swapcache=
.
> > MOVE can happen much later after that anytime before a swapin.  My
> > understanding is that's also what Matthew wanted to point out.  It may =
be
> > better justified of that in a separate change with some performance
> > measurements.
>
> The bug we=E2=80=99re discussing occurs precisely within the short window=
 you
> mentioned.
>
> 1. add_to_swap: The folio is added to swapcache.
> 2. try_to_unmap: PTEs are converted to swap entries.
> 3. pageout
> 4. Swapcache is cleared.
>
> The issue happens between steps 2 and 4, where the PTE is not present, bu=
t
> the folio is still in swapcache - the current code does move_swap_pte() b=
ut does
> not fixup folio->index within swapcache.
>
> My point is that if we want a proper fix for mTHP, we'd better handle wri=
teback.
> Otherwise, this isn=E2=80=99t much different from directly returning -EBU=
SY as proposed
> in this RFC.
>
> For small folios, there=E2=80=99s no split_folio issue, making it relativ=
ely
> simpler. Lokesh
> mentioned plans to madvise NOHUGEPAGE in ART, so fixing small folios is l=
ikely
> the first priority.

Fixing for the non-mTHP case first sounds good to me. For a large
folio in swap cache maybe you can return EBUSY for now?

But for that, I believe the cleanest and simplest would be to
restructure move_pages_pte() such that folio is retrieved from
vm_normal_foliio() if src_pte is present, otherwise, from
filemap_get_folio() and then incorporate the check you have in this
FRC in there. This way the entire locking dance logic in there can be
reused for swap-cache case as well.
>
> >
> > Thanks,
> >
> > --
> > Peter Xu
>
> Thanks
> Barry

