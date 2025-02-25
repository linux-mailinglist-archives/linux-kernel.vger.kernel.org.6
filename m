Return-Path: <linux-kernel+bounces-531979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E0AA44774
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41277A918E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231A5154449;
	Tue, 25 Feb 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXb0T+AZ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9EC158520
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502971; cv=none; b=iVgkjvrE9xFBy21AOIOvEzo/YUg+GJ4FZA1QbQ5S3pjaMjq9eoiwYTBvRL0AMnn+7mknrcn20YdrKSalSsTgfBMPVk8SXt7T6MygAHDoIXSA1S68LCNrToEsh3IcTWVYathzMz6+BwZn3IgCzdYmYWLAVROU0yYrCkId94o1ap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502971; c=relaxed/simple;
	bh=SkFG7jbh4sZ1Hhr/lirAJj6lsLFj3YfkDYM6mN2hmTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tX8buzsHi62i8BQroSNc90tRNYD2pP/rLNS9v4a2DjOf5S0LaSlKNM5DuJpVdCEu7guuAd+5OFf1ucwa3P65xa3qOzuvX7R0y4YDxnrNjnvWDb86qo0hMmNIwhAY7sQMoqDFmS+f2VPnKcmwceQwgn4ycv0o6El357DLrooFR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LXb0T+AZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-472098e6e75so374981cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740502968; x=1741107768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFlvzy5MlROQrAEfjkrWxFOVsVqFB4jhR5ycbT0zPr8=;
        b=LXb0T+AZ1wyjK+oejo7/8qJOPWvo9PqdFRk4T1mslN0ICH/qC9z9zuQN2M7ZSRm+9t
         +N3AAZQcDrksBVVoBPFLGxrFJNcgoNx2nq9mgEIOP32CLr5ke2C7Z3kn4NT3LofFHXcN
         awUy3xG8xBhpX4TehdcWtREgxBA1GF4TOc+Wkbby2zySQZn1T4A1qTK1oip1Kk2VREcQ
         Ff200zKDfQBLYT5huBVwpqQbVvNBMOm8PyRcFOjdS1C60ALhmOqzIRYTJvfIyexKXAtW
         Eg/moypUpGeufYcquW6K3XOqTZTdgyP6DfVmEwUMzzmQ5JJzXm5CSjbFQrLdQmAQjZOs
         RfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502968; x=1741107768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFlvzy5MlROQrAEfjkrWxFOVsVqFB4jhR5ycbT0zPr8=;
        b=H7wd8CMH266FdIPNcnDx/21F7KxQacL/C6JO95AApONlh4Pvod8dpa1PiM2GHII1IV
         JjdIaiLpe/l8TUYoLxWMYGIzm7wsaf3bdhMPMeSNkxvRtH4HSsn+yEnkfoWGA/KR2O7c
         c088+TvfnUrZO2wHsKB2b3L8oLOvpXVeuQjBSZrszCo4IvFV7GobeL/7vzuwhO+AmWVS
         G89/jL+bBh5aUUkdCZIj7U9yXV3YJs+IkiECRH7FYxepvufKZ33XCrjmCsgThubRAwM2
         UaZN8W+N5Jm+cCuG+NmVp+sleEvtEKsbTmsxXMbLJ7jtWK4lm1a5+1bDYT4LkHESX8qg
         Z+PA==
X-Forwarded-Encrypted: i=1; AJvYcCWn2l8vi7FZatWRABpVyLN2a1xV4A27Y8Dp2HGs/Qlz/zEXAuJqPAOmZEReCRkAC4HMNhUFocCvKDyM5Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwH3QaRSaDzDl9YrQ4qNhjy7hHsKmQRitDUBODGFWifduJ+dA
	G+tIjwduC+QK61Y/f1+ZKU4JK4GUL6pgnitq3JZw2zv2r2O2uBJBPBuoMQvsQ43CQRqSqM+AIrs
	1f6UNN4Tt7SDXv7j+OTl7A2PAvOinfEDUucic
X-Gm-Gg: ASbGncvQmsJNCPS2yJ+B/m/kdsLTH+9/lcef5WtB6vbQyO0aEYxZma6WoDJPv9XcfGj
	EG1PotLlNQPsr040cTFU7SeUxMzcGvdvtxw5HTy0GZPcwmwK+zpB6fZbz3Y5cZpNR/IbHHV11OG
	VVcuKmsUA=
X-Google-Smtp-Source: AGHT+IGfZoydOPbzChKno0IgijhTP/lntU/5d7TQ/cYmx5FO/mGg9Yt2l61INuKodZ8dIVTTLVvYi51ees46MJMOkYA=
X-Received: by 2002:a05:622a:24f:b0:472:796:9ea6 with SMTP id
 d75a77b69052e-47376e8faf1mr4697511cf.17.1740502967850; Tue, 25 Feb 2025
 09:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpEeEbdE2ycEQ+3zSbCE3NJsG1vTbqMtZyzry6FRFZB61w@mail.gmail.com>
 <20250225110525.26732-1-21cnbao@gmail.com> <Z73jBI7Caxd4jR0n@x1.local>
In-Reply-To: <Z73jBI7Caxd4jR0n@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 25 Feb 2025 09:02:35 -0800
X-Gm-Features: AWEUYZkV01cVQhPz2VcatiMKz9-_P9bQisDfhrwc_BjMe77z5mBkffDUdqe8knA
Message-ID: <CAJuCfpHBJK-ycWPEREs3XJpLQSxBiZxGsogwtPyZ9r5R8THXPw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Peter Xu <peterx@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, Liam.Howlett@oracle.com, aarcange@redhat.com, 
	akpm@linux-foundation.org, axelrasmussen@google.com, bgeffon@google.com, 
	brauner@kernel.org, david@redhat.com, hughd@google.com, jannh@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com, 
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org, 
	v-songbaohua@oppo.com, viro@zeniv.linux.org.uk, willy@infradead.org, 
	yuzhao@google.com, zhangpeng362@huawei.com, zhengtangquan@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:34=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Feb 26, 2025 at 12:05:25AM +1300, Barry Song wrote:
> > On Fri, Feb 21, 2025 at 1:36=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 3:52=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 3:47=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > >
> > > > > On Thu, Feb 20, 2025 at 2:59=E2=80=AFPM Peter Xu <peterx@redhat.c=
om> wrote:
> > > > > >
> > > > > > On Thu, Feb 20, 2025 at 12:04:40PM +1300, Barry Song wrote:
> > > > > > > On Thu, Feb 20, 2025 at 11:15=E2=80=AFAM Peter Xu <peterx@red=
hat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> > > > > > > > > On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasarya=
n <surenb@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21c=
nbao@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > > > > > > >
> > > > > > > > > > > userfaultfd_move() checks whether the PTE entry is pr=
esent or a
> > > > > > > > > > > swap entry.
> > > > > > > > > > >
> > > > > > > > > > > - If the PTE entry is present, move_present_pte() han=
dles folio
> > > > > > > > > > >   migration by setting:
> > > > > > > > > > >
> > > > > > > > > > >   src_folio->index =3D linear_page_index(dst_vma, dst=
_addr);
> > > > > > > > > > >
> > > > > > > > > > > - If the PTE entry is a swap entry, move_swap_pte() s=
imply copies
> > > > > > > > > > >   the PTE to the new dst_addr.
> > > > > > > > > > >
> > > > > > > > > > > This approach is incorrect because even if the PTE is=
 a swap
> > > > > > > > > > > entry, it can still reference a folio that remains in=
 the swap
> > > > > > > > > > > cache.
> > > > > > > > > > >
> > > > > > > > > > > If do_swap_page() is triggered, it may locate the fol=
io in the
> > > > > > > > > > > swap cache. However, during add_rmap operations, a ke=
rnel panic
> > > > > > > > > > > can occur due to:
> > > > > > > > > > >  page_pgoff(folio, page) !=3D linear_page_index(vma, =
address)
> > > > > > > > > >
> > > > > > > > > > Thanks for the report and reproducer!
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > $./a.out > /dev/null
> > > > > > > > > > > [   13.336953] page: refcount:6 mapcount:1 mapping:00=
000000f43db19c index:0xffffaf150 pfn:0x4667c
> > > > > > > > > > > [   13.337520] head: order:2 mapcount:1 entire_mapcou=
nt:0 nr_pages_mapped:1 pincount:0
> > > > > > > > > > > [   13.337716] memcg:ffff00000405f000
> > > > > > > > > > > [   13.337849] anon flags: 0x3fffc0000020459(locked|u=
ptodate|dirty|owner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0=
xffff)
> > > > > > > > > > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538=
 ffff80008507b538 ffff000006260361
> > > > > > > > > > > [   13.338831] raw: 0000000ffffaf150 0000000000004000=
 0000000600000000 ffff00000405f000
> > > > > > > > > > > [   13.339031] head: 03fffc0000020459 ffff80008507b53=
8 ffff80008507b538 ffff000006260361
> > > > > > > > > > > [   13.339204] head: 0000000ffffaf150 000000000000400=
0 0000000600000000 ffff00000405f000
> > > > > > > > > > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f0=
1 ffffffff00000000 0000000000000001
> > > > > > > > > > > [   13.339546] head: 0000000000000004 000000000000000=
0 00000000ffffffff 0000000000000000
> > > > > > > > > > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(pa=
ge_pgoff(folio, page) !=3D linear_page_index(vma, address))
> > > > > > > > > > > [   13.340190] ------------[ cut here ]------------
> > > > > > > > > > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > > > > > > > > > [   13.340683] Internal error: Oops - BUG: 00000000f2=
000800 [#1] PREEMPT SMP
> > > > > > > > > > > [   13.340969] Modules linked in:
> > > > > > > > > > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not=
 tainted 6.14.0-rc3-gcf42737e247a-dirty #299
> > > > > > > > > > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > > > > > > > > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO =
-TCO -DIT -SSBS BTYPE=3D--)
> > > > > > > > > > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > > > > > > > > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > > > > > > > > > [   13.342018] sp : ffff80008752bb20
> > > > > > > > > > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc01=
99f00 x27: 0000000000000001
> > > > > > > > > > > [   13.342404] x26: 0000000000000000 x25: 00000000000=
00001 x24: 0000000000000001
> > > > > > > > > > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0=
d0000 x21: fffffdffc0199f00
> > > > > > > > > > > [   13.342731] x20: fffffdffc0199f00 x19: ffff0000062=
10700 x18: 00000000ffffffff
> > > > > > > > > > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f6=
96c6f x15: 662866666f67705f
> > > > > > > > > > > [   13.343033] x14: 6567617028454741 x13: 29297373657=
26464 x12: ffff800083728ab0
> > > > > > > > > > > [   13.343183] x11: ffff800082996bf8 x10: 00000000000=
00fd7 x9 : ffff80008011bc40
> > > > > > > > > > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fff=
ff000 x6 : ffff8000829eebf8
> > > > > > > > > > > [   13.343498] x5 : c0000000fffff000 x4 : 00000000000=
00000 x3 : 0000000000000000
> > > > > > > > > > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062=
db980 x0 : 000000000000005f
> > > > > > > > > > > [   13.343876] Call trace:
> > > > > > > > > > > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > > > > > > > > > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > > > > > > > > > [   13.344333]  do_swap_page+0x1060/0x1400
> > > > > > > > > > > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > > > > > > > > > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > > > > > > > > > [   13.344586]  do_page_fault+0x20c/0x770
> > > > > > > > > > > [   13.344673]  do_translation_fault+0xb4/0xf0
> > > > > > > > > > > [   13.344759]  do_mem_abort+0x48/0xa0
> > > > > > > > > > > [   13.344842]  el0_da+0x58/0x130
> > > > > > > > > > > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > > > > > > > > > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > > > > > > > > > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5=
779 (d4210000)
> > > > > > > > > > > [   13.345504] ---[ end trace 0000000000000000 ]---
> > > > > > > > > > > [   13.345715] note: a.out[107] exited with irqs disa=
bled
> > > > > > > > > > > [   13.345954] note: a.out[107] exited with preempt_c=
ount 2
> > > > > > > > > > >
> > > > > > > > > > > Fully fixing it would be quite complex, requiring sim=
ilar handling
> > > > > > > > > > > of folios as done in move_present_pte.
> > > > > > > > > >
> > > > > > > > > > How complex would that be? Is it a matter of adding
> > > > > > > > > > folio_maybe_dma_pinned() checks, doing folio_move_anon_=
rmap() and
> > > > > > > > > > folio->index =3D linear_page_index like in move_present=
_pte() or
> > > > > > > > > > something more?
> > > > > > > > >
> > > > > > > > > My main concern is still with large folios that require a=
 split_folio()
> > > > > > > > > during move_pages(), as the entire folio shares the same =
index and
> > > > > > > > > anon_vma. However, userfaultfd_move() moves pages individ=
ually,
> > > > > > > > > making a split necessary.
> > > > > > > > >
> > > > > > > > > However, in split_huge_page_to_list_to_order(), there is =
a:
> > > > > > > > >
> > > > > > > > >         if (folio_test_writeback(folio))
> > > > > > > > >                 return -EBUSY;
> > > > > > > > >
> > > > > > > > > This is likely true for swapcache, right? However, even f=
or move_present_pte(),
> > > > > > > > > it simply returns -EBUSY:
> > > > > > > > >
> > > > > > > > > move_pages_pte()
> > > > > > > > > {
> > > > > > > > >                 /* at this point we have src_folio locked=
 */
> > > > > > > > >                 if (folio_test_large(src_folio)) {
> > > > > > > > >                         /* split_folio() can block */
> > > > > > > > >                         pte_unmap(&orig_src_pte);
> > > > > > > > >                         pte_unmap(&orig_dst_pte);
> > > > > > > > >                         src_pte =3D dst_pte =3D NULL;
> > > > > > > > >                         err =3D split_folio(src_folio);
> > > > > > > > >                         if (err)
> > > > > > > > >                                 goto out;
> > > > > > > > >
> > > > > > > > >                         /* have to reacquire the folio af=
ter it got split */
> > > > > > > > >                         folio_unlock(src_folio);
> > > > > > > > >                         folio_put(src_folio);
> > > > > > > > >                         src_folio =3D NULL;
> > > > > > > > >                         goto retry;
> > > > > > > > >                 }
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > > Do we need a folio_wait_writeback() before calling split_=
folio()?
> > > > > > > >
> > > > > > > > Maybe no need in the first version to fix the immediate bug=
?
> > > > > > > >
> > > > > > > > It's also not always the case to hit writeback here. IIUC, =
writeback only
> > > > > > > > happens for a short window when the folio was just added in=
to swapcache.
> > > > > > > > MOVE can happen much later after that anytime before a swap=
in.  My
> > > > > > > > understanding is that's also what Matthew wanted to point o=
ut.  It may be
> > > > > > > > better justified of that in a separate change with some per=
formance
> > > > > > > > measurements.
> > > > > > >
> > > > > > > The bug we=E2=80=99re discussing occurs precisely within the =
short window you
> > > > > > > mentioned.
> > > > > > >
> > > > > > > 1. add_to_swap: The folio is added to swapcache.
> > > > > > > 2. try_to_unmap: PTEs are converted to swap entries.
> > > > > > > 3. pageout
> > > > > > > 4. Swapcache is cleared.
> > > > > >
> > > > > > Hmm, I see. I was expecting step 4 to be "writeback is cleared"=
.. or at
> > > > > > least that should be step 3.5, as IIUC "writeback" needs to be =
cleared
> > > > > > before "swapcache" bit being cleared.
> > > > > >
> > > > > > >
> > > > > > > The issue happens between steps 2 and 4, where the PTE is not=
 present, but
> > > > > > > the folio is still in swapcache - the current code does move_=
swap_pte() but does
> > > > > > > not fixup folio->index within swapcache.
> > > > > >
> > > > > > One thing I'm still not clear here is why it's a race condition=
, rather
> > > > > > than more severe than that.  I mean, folio->index is definitely=
 wrong, then
> > > > > > as long as the page still in swapcache, we should be able to mo=
ve the swp
> > > > > > entry over to dest addr of UFFDIO_MOVE, read on dest addr, then=
 it'll see
> > > > > > the page in swapcache with the wrong folio->index already and t=
rigger.
> > > > > >
> > > > > > I wrote a quick test like that, it actually won't trigger..
> > > > > >
> > > > > > I had a closer look in the code, I think it's because do_swap_p=
age() has
> > > > > > the logic to detect folio->index matching first, and allocate a=
 new folio
> > > > > > if it doesn't match in ksm_might_need_to_copy().  IIUC that was=
 for
> > > > > > ksm.. but it looks like it's functioning too here.
> > > > > >
> > > > > > ksm_might_need_to_copy:
> > > > > >         if (folio_test_ksm(folio)) {
> > > > > >                 if (folio_stable_node(folio) &&
> > > > > >                     !(ksm_run & KSM_RUN_UNMERGE))
> > > > > >                         return folio;   /* no need to copy it *=
/
> > > > > >         } else if (!anon_vma) {
> > > > > >                 return folio;           /* no need to copy it *=
/
> > > > > >         } else if (folio->index =3D=3D linear_page_index(vma, a=
ddr) && <---------- [1]
> > > > > >                         anon_vma->root =3D=3D vma->anon_vma->ro=
ot) {
> > > > > >                 return folio;           /* still no need to cop=
y it */
> > > > > >         }
> > > > > >         ...
> > > > > >
> > > > > >         new_folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, =
vma, addr); <---- [2]
> > > > > >         ...
> > > > > >
> > > > > > So I believe what I hit is at [1] it sees index doesn't match, =
then it
> > > > > > decided to allocate a new folio.  In this case, it won't hit yo=
ur BUG
> > > > > > because it'll be "folio !=3D swapcache" later, so it'll setup t=
he
> > > > > > folio->index for the new one, rather than the sanity check.
> > > > > >
> > > > > > Do you know how your case got triggered, being able to bypass t=
he above [1]
> > > > > > which should check folio->index already?
> > > > >
> > > > > To understand the change I tried applying the proposed patch to b=
oth
> > > > > mm-unstable and Linus' ToT and got conflicts for both trees. Barr=
y,
> > > > > which baseline are you using?
> > > >
> > > > Oops, never mind. My mistake. Copying from the email messed up tabs=
...
> > > > It applies cleanly.
> > >
> > > Overall the code seems correct to me, however the new code has quite
> > > complex logical structure IMO. Original simplified code structure is
> > > like this:
> > >
> > > if (pte_present(orig_src_pte)) {
> > >         if (is_zero_pfn) {
> > >                 move_zeropage_pte()
> > >                 return
> > >         }
> > >         // pin and lock src_folio
> > >         spin_lock(src_ptl)
> > >         folio_get(folio)
> > >         folio_trylock(folio)
> > >         if (folio_test_large(src_folio))
> > >                 split_folio(src_folio)
> > >         anon_vma_trylock_write(src_anon_vma)
> > >         move_present_pte()
> > > } else {
> > >         if (non_swap_entry(entry))
> > >                 if (is_migration_entry(entry))
> > >                         handle migration entry
> > >         else
> > >                 move_swap_pte()
> > > }
> > >
> > > The new structure looks like this:
> > >
> > > if (!pte_present(orig_src_pte)) {
> > >         if (is_migration_entry(entry)) {
> > >                 handle migration entry
> > >                 return
> > >        }
> > >         if (!non_swap_entry() ||  !pte_swp_exclusive())
> > >                 return
> > >         si =3D get_swap_device(entry);
> > > }
> > > if (pte_present(orig_src_pte) && is_zero_pfn(pte_pfn(orig_src_pte)))
> > >         move_zeropage_pte()
> > >         return
> > > }
> > > pin and lock src_folio
> > >         spin_lock(src_ptl)
> > >         if (pte_present(orig_src_pte))
> > >                 folio_get(folio)
> > >         else {
> > >                 folio =3D filemap_get_folio(swap_entry)
> > >                 if (IS_ERR(folio))
> > >                         move_swap_pte()
> > >                         return
> > >                 }
> > >         }
> > >         folio_trylock(folio)
> > > if (folio_test_large(src_folio))
> > >         split_folio(src_folio)
> > > if (pte_present(orig_src_pte))
> > >         anon_vma_trylock_write(src_anon_vma)
> > > move_pte_and_folio()
> > >
> > > This looks more complex and harder to follow. Might be the reason
> > > David was not in favour of treating swapcache and present pages in th=
e
> > > same path. And now I would agree that refactoring some common parts
> > > and not breaking the original structure might be cleaner.
> >
> > Exactly, that=E2=80=99s the cost we=E2=80=99re facing in trying to shar=
e the code path
> > for swap and present PTEs.
> >
> > I tried to extract some common functions for present PTE and swap entri=
es,
> > but I found too many detailed differences and variants. This made the c=
ommon
> > function overly complex, turning it into a real "monster." As a result,=
 I
> > don't think this approach would make the code any more readable or clea=
ner.
> >
> > After trying a couple of times, I feel the following is somehow more
> > readable:
> > (Lokesh is eager for the small folios fixes to be merged without furthe=
r
> > delay. So, I'd prefer to return -EBUSY for large folios in the hotfixes
> > and handle the mTHP -EBUSY issue in a separate patch later.)

Hi Barry,
This is much more readable, thank you! With Peter's comments addressed
I think this is ready to be posted as an official fix.
Thanks,
Suren.

> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 867898c4e30b..eed9286ec1f3 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -18,6 +18,7 @@
> >  #include <asm/tlbflush.h>
> >  #include <asm/tlb.h>
> >  #include "internal.h"
> > +#include "swap.h"
> >
> >  static __always_inline
> >  bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long ds=
t_end)
> > @@ -1072,15 +1073,15 @@ static int move_present_pte(struct mm_struct *m=
m,
> >       return err;
> >  }
> >
> > -static int move_swap_pte(struct mm_struct *mm,
> > +static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *=
dst_vma,
> >                        unsigned long dst_addr, unsigned long src_addr,
> >                        pte_t *dst_pte, pte_t *src_pte,
> >                        pte_t orig_dst_pte, pte_t orig_src_pte,
> >                        pmd_t *dst_pmd, pmd_t dst_pmdval,
> > -                      spinlock_t *dst_ptl, spinlock_t *src_ptl)
> > +                      spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > +                      struct folio *src_folio)
> >  {
> > -     if (!pte_swp_exclusive(orig_src_pte))
> > -             return -EBUSY;
> > +     int err =3D 0;
> >
> >       double_pt_lock(dst_ptl, src_ptl);
> >
> > @@ -1090,11 +1091,22 @@ static int move_swap_pte(struct mm_struct *mm,
> >               return -EAGAIN;
> >       }
> >
> > +     if (src_folio) {
>
> We'd better add a comment here explaining src_folio in this case is a swa=
p
> cache folio, and we're updating index to make sure if the folio can be
> reused later in a swapin, the rmap info will match, or something like tha=
t.
>
> > +             /* Folio got pinned from under us. Put it back and fail t=
he move. */
> > +             if (folio_maybe_dma_pinned(src_folio)) {
> > +                     err =3D -EBUSY;
> > +                     goto out;
> > +             }
>
> If the swap entry is guaranteed exclusive (which I think will hold true),=
 I
> think we can drop this and the "out" label, as it can't happen.
>
> > +             folio_move_anon_rmap(src_folio, dst_vma);
> > +             src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> > +     }
> > +
> >       orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> >       set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
> > -     double_pt_unlock(dst_ptl, src_ptl);
> >
> > -     return 0;
> > +out:
> > +     double_pt_unlock(dst_ptl, src_ptl);
> > +     return err;
> >  }
> >
> >  static int move_zeropage_pte(struct mm_struct *mm,
> > @@ -1137,6 +1149,7 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >                         __u64 mode)
> >  {
> >       swp_entry_t entry;
> > +     struct swap_info_struct *si =3D NULL;
> >       pte_t orig_src_pte, orig_dst_pte;
> >       pte_t src_folio_pte;
> >       spinlock_t *src_ptl, *dst_ptl;
> > @@ -1318,6 +1331,8 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >                                      orig_dst_pte, orig_src_pte, dst_pm=
d,
> >                                      dst_pmdval, dst_ptl, src_ptl, src_=
folio);
> >       } else {
> > +             struct folio *folio =3D NULL;
> > +
> >               entry =3D pte_to_swp_entry(orig_src_pte);
> >               if (non_swap_entry(entry)) {
> >                       if (is_migration_entry(entry)) {
> > @@ -1331,9 +1346,47 @@ static int move_pages_pte(struct mm_struct *mm, =
pmd_t *dst_pmd, pmd_t *src_pmd,
> >                       goto out;
> >               }
> >
> > -             err =3D move_swap_pte(mm, dst_addr, src_addr, dst_pte, sr=
c_pte,
> > -                                 orig_dst_pte, orig_src_pte, dst_pmd,
> > -                                 dst_pmdval, dst_ptl, src_ptl);
> > +             if (!pte_swp_exclusive(orig_src_pte)) {
> > +                     err =3D -EBUSY;
> > +                     goto out;
> > +             }
> > +
> > +             si =3D get_swap_device(entry);
> > +             if (unlikely(!si)) {
> > +                     err =3D -EAGAIN;
> > +                     goto out;
> > +             }
> > +                /*
> > +                 * Check if swapcache exists. If it does, the folio mu=
st be
> > +                 * moved even if the PTE is a swap entry. For large fo=
lios,
> > +                 * we directly return -EBUSY, as split_folio() current=
ly
> > +                 * also returns -EBUSY when attempting to split unmapp=
ed
> > +                 * large folios in the swapcache. This needs to be fix=
ed
> > +                 * to allow proper handling.
> > +                 */
>
> Some alignment issue on comments...
>
> We could also add something on the decision on why not taking anon_vma.
> IIUC mention that no possible rmap walker when exclusive and unmapped
> should be ok as of now..
>
> > +             if (!src_folio)
> > +                     folio =3D filemap_get_folio(swap_address_space(en=
try),
> > +                                     swap_cache_index(entry));
> > +             if (!IS_ERR_OR_NULL(folio)) {
> > +                     if (folio_test_large(folio)) {
> > +                             err =3D -EBUSY;
> > +                             folio_put(folio);
> > +                             goto out;
> > +                     }
> > +                     src_folio =3D folio;
>
> We need to update src_folio_pte here, or later it might access
> uninitialized stack var when a retry needed:
>
>         if (src_folio && unlikely(!pte_same(src_folio_pte, orig_src_pte))=
) {
>                 err =3D -EAGAIN;
>                 goto out;
>         }
>
> > +                     if (!folio_trylock(src_folio)) {
> > +                             pte_unmap(&orig_src_pte);
> > +                             pte_unmap(&orig_dst_pte);
> > +                             src_pte =3D dst_pte =3D NULL;
> > +                             /* now we can block and wait */
> > +                             folio_lock(src_folio);
> > +                             si =3D NULL;
>
> Swap device ref leak?
>
> Thanks,
>
> > +                             goto retry;
> > +                     }
> > +             }
> > +             err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, ds=
t_pte, src_pte,
> > +                             orig_dst_pte, orig_src_pte, dst_pmd, dst_=
pmdval,
> > +                             dst_ptl, src_ptl, src_folio);
> >       }
> >
> >  out:
> > @@ -1350,6 +1403,8 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >       if (src_pte)
> >               pte_unmap(src_pte);
> >       mmu_notifier_invalidate_range_end(&range);
> > +     if (si)
> > +             put_swap_device(si);
> >
> >       return err;
> >  }
> >
> > If there are no objections, I'll send v2 tomorrow with the above code.
> > 12:04 AM, Time to get some sleep now! :-)
> >
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > My point is that if we want a proper fix for mTHP, we'd bette=
r handle writeback.
> > > > > > > Otherwise, this isn=E2=80=99t much different from directly re=
turning -EBUSY as proposed
> > > > > > > in this RFC.
> > > > > > >
> > > > > > > For small folios, there=E2=80=99s no split_folio issue, makin=
g it relatively
> > > > > > > simpler. Lokesh
> > > > > > > mentioned plans to madvise NOHUGEPAGE in ART, so fixing small=
 folios is likely
> > > > > > > the first priority.
> > > > > >
> > > > > > Agreed.
> > > > > >
> > > > > > --
> > > > > > Peter Xu
> > > > > >
> >
> > Thanks
> > Barry
> >
> >
>
> --
> Peter Xu
>

