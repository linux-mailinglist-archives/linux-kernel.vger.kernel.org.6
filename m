Return-Path: <linux-kernel+bounces-522520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA04A3CB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813FB189BB08
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E1A257433;
	Wed, 19 Feb 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duFtBYLN"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F921B87EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000412; cv=none; b=PEtFpAiplVB4g+GKcxlNLAK3g099CMkhwitmkXtAw0qJq75eF7z5wzmVC5tLdCumv/EN1OcF7cy9iiLC03poB2x70L+s0N9J4liZpHU7ugWXgRgYdnO/NfEyqib8OcUVJEyHXInVJrqKKlOXmKUT/5yYFmFMQtrgubHljQjdcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000412; c=relaxed/simple;
	bh=gPsf0PiWERkYfgq8nP/WmCGmcxtUTZTmwL6NnDzt/to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaRNKLb9rywz8WTsEjgDJjoLTncm/3twhVa7Ep27Vq6Zzb2m142/RrPJ7gqGJtYIGCd5V+VnexBpnCAJVe2exxZ3v7xHayD9lRv922aOBMWs4mJHb2fh0CE4MXyCkt0wseB+mRuFMK6UG4ELJXc3ZqrnMSKiaXtwf0iJjR2csms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duFtBYLN; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4be66ac7685so97138137.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740000408; x=1740605208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJOQ6lceG9Ck3uIraRnLbRatOw1m52Vf/oVnWKVAOlk=;
        b=duFtBYLN/R0qvt/VDNrlcw5N+0tGafuLES0LFBZi8tdo3KwF0gbMe4KQuZy5pZFYFB
         yuN6OISEtidIR7qq52mom0PwmfU+pE2WmaDcMPezGQs9GBWsGey8ZgRo7Q81G/eDUGys
         uGWg+awG1d+1aG3aRXrl+x95N0tq4tN+jtM5u1RnwiizfLrPtoTnDKGCd4h6Z+OX3X4L
         scN+RTRmfFCgXJU052xajeuZem/O0OSO+zIqu6aW2C+GvlRKOmqSmmJbqjFnAhHGoOKd
         0YLektoDDk9keblRl4AN01i88iT5w2LxBG4CcCw4PsZnw7d8Wdb1zkDCol/5A3njtPDS
         IlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740000408; x=1740605208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJOQ6lceG9Ck3uIraRnLbRatOw1m52Vf/oVnWKVAOlk=;
        b=csdfuqWJfkr80WwsicbgIP16MfRJqOGS4ZpWc+sVfp5m6GCzX/FYxMDEBlA+Qy20i+
         F15GZeM8p23Ixb4b1+0RjEevgjyxVEpihtlKiC0P/u6yBCYP8xdJP3hsedFN1tCOr4dL
         SFq7pqd1YBrK2456qweVNwo1s14iADy30ZSu0aMVEaQo70ltf38yvPHx0DOrBPE9Kefo
         EbSOHSH8Lo5bCbFPEO/csei3TOeggxOzzQgkBItvheyrhwFghTppZugPuigw8GRFhLh2
         g4OqB4fN6Rl5Y65zkiLwiF3NlufCQzBZOzyn50/bB7w8T4s01u8PccUOhhn9Wqp57BfO
         QLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSjQk5unJChBywBSublm5YnGxit0L4yX9nYZ3GNT7zZZhbA3mN9qWZAUcnH9IZPPzRQgcfmdN9lDvYJdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYoN/yGvhHqx1T29r73PJSNR3YeT7BHsWJh6VRVF5gHnX53dm
	TlWdJ1dI6zufvbpkDdXvvjd0n5kQpu7643hqklFisZr3Uxeww9jUfi0FIG439d+FGF+lxepdmz/
	HCxOJaA6X+rGBPreAfON3NCMs27I=
X-Gm-Gg: ASbGnctCLw1GKbCKsrngF2hwYc/bQu9nhEEGU901npvan2QfIoRs/5C7kSoAf+9pNSC
	5987d6d2/jYFnFEO2ijvAwrttx7QtWLmseq79QteSfrQiihxnN6C4bRANosTX3HvW9dAu6l6R
X-Google-Smtp-Source: AGHT+IEZIcVsMAGJSqghR6Ngu88YOIUbUgsvmqiWCNTGHhBLkotmzTl5o8Rcf0DhpME0+fJ1I6P/QXM7UNpTR7WtzOs=
X-Received: by 2002:a67:e7c3:0:b0:4bd:3c41:7f6c with SMTP id
 ada2fe7eead31-4bd3fcd1db0mr12642728137.10.1740000408512; Wed, 19 Feb 2025
 13:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com> <CA+EESO651xc=jR7DyX9XhEtyxFe_Cys8XwT8WDr4phC97ssW-w@mail.gmail.com>
In-Reply-To: <CA+EESO651xc=jR7DyX9XhEtyxFe_Cys8XwT8WDr4phC97ssW-w@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Feb 2025 10:26:36 +1300
X-Gm-Features: AWEUYZk4zFdI6kWz6qPPz0pkPQXtDjpS4BYItskL3T285fQe3jrRm2cSy5r55Uw
Message-ID: <CAGsJ_4xzaTYcJuP+a=NqPX6-75YcSsdvTr_uxxYzpe0QwP08xg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, zhengtangquan@oppo.com, 
	Barry Song <v-songbaohua@oppo.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Axel Rasmussen <axelrasmussen@google.com>, 
	Brian Geffon <bgeffon@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>, 
	ZhangPeng <zhangpeng362@huawei.com>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:03=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Wed, Feb 19, 2025 at 12:38=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> >
> > On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > userfaultfd_move() checks whether the PTE entry is present or a
> > > > swap entry.
> > > >
> > > > - If the PTE entry is present, move_present_pte() handles folio
> > > >   migration by setting:
> > > >
> > > >   src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> > > >
> > > > - If the PTE entry is a swap entry, move_swap_pte() simply copies
> > > >   the PTE to the new dst_addr.
> > > >
> > > > This approach is incorrect because even if the PTE is a swap
> > > > entry, it can still reference a folio that remains in the swap
> > > > cache.
> > > >
> > > > If do_swap_page() is triggered, it may locate the folio in the
> > > > swap cache. However, during add_rmap operations, a kernel panic
> > > > can occur due to:
> > > >  page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> > >
> > > Thanks for the report and reproducer!
> > >
> > > >
> > > > $./a.out > /dev/null
> > > > [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c=
 index:0xffffaf150 pfn:0x4667c
> > > > [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_=
mapped:1 pincount:0
> > > > [   13.337716] memcg:ffff00000405f000
> > > > [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|=
owner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > > > [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b=
538 ffff000006260361
> > > > [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000=
000 ffff00000405f000
> > > > [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507=
b538 ffff000006260361
> > > > [   13.339204] head: 0000000ffffaf150 0000000000004000 000000060000=
0000 ffff00000405f000
> > > > [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff0000=
0000 0000000000000001
> > > > [   13.339546] head: 0000000000000004 0000000000000000 00000000ffff=
ffff 0000000000000000
> > > > [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio=
, page) !=3D linear_page_index(vma, address))
> > > > [   13.340190] ------------[ cut here ]------------
> > > > [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > > [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PR=
EEMPT SMP
> > > > [   13.340969] Modules linked in:
> > > > [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.=
0-rc3-gcf42737e247a-dirty #299
> > > > [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > > [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
> > > > [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > > [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > > [   13.342018] sp : ffff80008752bb20
> > > > [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 000=
0000000000001
> > > > [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 000=
0000000000001
> > > > [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fff=
ffdffc0199f00
> > > > [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 000=
00000ffffffff
> > > > [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662=
866666f67705f
> > > > [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: fff=
f800083728ab0
> > > > [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : fff=
f80008011bc40
> > > > [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : fff=
f8000829eebf8
> > > > [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 000=
0000000000000
> > > > [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000=
000000000005f
> > > > [   13.343876] Call trace:
> > > > [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > > [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > > [   13.344333]  do_swap_page+0x1060/0x1400
> > > > [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > > [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > > [   13.344586]  do_page_fault+0x20c/0x770
> > > > [   13.344673]  do_translation_fault+0xb4/0xf0
> > > > [   13.344759]  do_mem_abort+0x48/0xa0
> > > > [   13.344842]  el0_da+0x58/0x130
> > > > [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > > [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > > [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> > > > [   13.345504] ---[ end trace 0000000000000000 ]---
> > > > [   13.345715] note: a.out[107] exited with irqs disabled
> > > > [   13.345954] note: a.out[107] exited with preempt_count 2
> > > >
> > > > Fully fixing it would be quite complex, requiring similar handling
> > > > of folios as done in move_present_pte.
> > >
> > > How complex would that be? Is it a matter of adding
> > > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > > folio->index =3D linear_page_index like in move_present_pte() or
> > > something more?
> >
> > My main concern is still with large folios that require a split_folio()
> > during move_pages(), as the entire folio shares the same index and
> > anon_vma. However, userfaultfd_move() moves pages individually,
> > making a split necessary.
> >
> > However, in split_huge_page_to_list_to_order(), there is a:
> >
> >         if (folio_test_writeback(folio))
> >                 return -EBUSY;
> >
> > This is likely true for swapcache, right? However, even for move_presen=
t_pte(),
> > it simply returns -EBUSY:
> >
> > move_pages_pte()
> > {
> >                 /* at this point we have src_folio locked */
> >                 if (folio_test_large(src_folio)) {
> >                         /* split_folio() can block */
> >                         pte_unmap(&orig_src_pte);
> >                         pte_unmap(&orig_dst_pte);
> >                         src_pte =3D dst_pte =3D NULL;
> >                         err =3D split_folio(src_folio);
> >                         if (err)
> >                                 goto out;
> >
> >                         /* have to reacquire the folio after it got spl=
it */
> >                         folio_unlock(src_folio);
> >                         folio_put(src_folio);
> >                         src_folio =3D NULL;
> >                         goto retry;
> >                 }
> > }
> >
> > Do we need a folio_wait_writeback() before calling split_folio()?
> >
> > By the way, I have also reported that userfaultfd_move() has a fundamen=
tal
> > conflict with TAO (Cc'ed Yu Zhao), which has been part of the Android c=
ommon
> > kernel. In this scenario, folios in the virtual zone won=E2=80=99t be s=
plit in
> > split_folio(). Instead, the large folio migrates into nr_pages small fo=
lios.
> >
> > Thus, the best-case scenario would be:
> >
> > mTHP -> migrate to small folios in split_folio() -> move small folios t=
o
> > dst_addr
> >
> > While this works, it negates the performance benefits of
> > userfaultfd_move(), as it introduces two PTE operations (migration in
> > split_folio() and move in userfaultfd_move() while retry), nr_pages mem=
ory
> > allocations, and still requires one memcpy(). This could end up
> > performing even worse than userfaultfd_copy(), I guess.
> >
> > The worst-case scenario would be failing to allocate small folios in
> > split_folio(), then userfaultfd_move() might return -ENOMEM?
> >
> > Given these issues, I strongly recommend that ART hold off on upgrading
> > to userfaultfd_move() until these problems are fully understood and
> > resolved. Otherwise, we=E2=80=99re in for a rough ride!
>
> At the moment, ART GC doesn't work taking mTHP into consideration. We
> don't try to be careful in userspace to be large-page aligned or
> anything. Also, the MOVE ioctl implementation works either on
> huge-pages or on normal pages. IIUC, it can't handle mTHP large pages
> as a whole. But that's true for other userfaultfd ioctls as well. If
> we were to continue using COPY, it's not that it's in any way more
> friendly to mTHP than MOVE. In fact, that's one of the reasons I'm
> considering making the ART heap NO_HUGEPAGE to avoid the need for
> folio-split entirely.

Disabling mTHP is one way to avoid potential bugs. However, as long as
UFFDIO_MOVE is available, we can=E2=80=99t prevent others, aside from ART G=
C,
from using it, right? So, we still need to address these issues with mTHP.

If a trend-following Android app discovers the UFFDIO_MOVE API, it might
use it, and it may not necessarily know to disable hugepages. Doesn=E2=80=
=99t that
pose a risk?

>
> Furthermore, there are few cases in which COPY ioctl's overhead just
> doesn't make sense for ART GC. So starting to use MOVE ioctl is the
> right thing to do.
>
> What we need eventually to gain mTHP benefits is both MOVE ioctl to
> support large-page migration as well as GC code in userspace to work
> with mTHP in mind.
> >
> > >
> > > > For now, a quick solution
> > > > is to return -EBUSY.
> > > > I'd like to see others' opinions on whether a full fix is worth
> > > > pursuing.
> > > >
> > > > For anyone interested in reproducing it, the a.out test program is
> > > > as below,
> > > >
> > > >  #define _GNU_SOURCE
> > > >  #include <stdio.h>
> > > >  #include <stdlib.h>
> > > >  #include <string.h>
> > > >  #include <sys/mman.h>
> > > >  #include <sys/ioctl.h>
> > > >  #include <sys/syscall.h>
> > > >  #include <linux/userfaultfd.h>
> > > >  #include <fcntl.h>
> > > >  #include <pthread.h>
> > > >  #include <unistd.h>
> > > >  #include <poll.h>
> > > >  #include <errno.h>
> > > >
> > > >  #define PAGE_SIZE 4096
> > > >  #define REGION_SIZE (512 * 1024)
> > > >
> > > >  #ifndef UFFDIO_MOVE
> > > >  struct uffdio_move {
> > > >      __u64 dst;
> > > >      __u64 src;
> > > >      __u64 len;
> > > >      #define UFFDIO_MOVE_MODE_DONTWAKE        ((__u64)1<<0)
> > > >      #define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES ((__u64)1<<1)
> > > >      __u64 mode;
> > > >      __s64 move;
> > > >  };
> > > >  #define _UFFDIO_MOVE  (0x05)
> > > >  #define UFFDIO_MOVE   _IOWR(UFFDIO, _UFFDIO_MOVE, struct uffdio_mo=
ve)
> > > >  #endif
> > > >
> > > >  void *src, *dst;
> > > >  int uffd;
> > > >
> > > >  void *madvise_thread(void *arg) {
> > > >      if (madvise(src, REGION_SIZE, MADV_PAGEOUT) =3D=3D -1) {
> > > >          perror("madvise MADV_PAGEOUT");
> > > >      }
> > > >      return NULL;
> > > >  }
> > > >
> > > >  void *fault_handler_thread(void *arg) {
> > > >      struct uffd_msg msg;
> > > >      struct uffdio_move move;
> > > >      struct pollfd pollfd =3D { .fd =3D uffd, .events =3D POLLIN };
> > > >
> > > >      pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > > >      pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
> > > >
> > > >      while (1) {
> > > >          if (poll(&pollfd, 1, -1) =3D=3D -1) {
> > > >              perror("poll");
> > > >              exit(EXIT_FAILURE);
> > > >          }
> > > >
> > > >          if (read(uffd, &msg, sizeof(msg)) <=3D 0) {
> > > >              perror("read");
> > > >              exit(EXIT_FAILURE);
> > > >          }
> > > >
> > > >          if (msg.event !=3D UFFD_EVENT_PAGEFAULT) {
> > > >              fprintf(stderr, "Unexpected event\n");
> > > >              exit(EXIT_FAILURE);
> > > >          }
> > > >
> > > >          move.src =3D (unsigned long)src + (msg.arg.pagefault.addre=
ss - (unsigned long)dst);
> > > >          move.dst =3D msg.arg.pagefault.address & ~(PAGE_SIZE - 1);
> > > >          move.len =3D PAGE_SIZE;
> > > >          move.mode =3D 0;
> > > >
> > > >          if (ioctl(uffd, UFFDIO_MOVE, &move) =3D=3D -1) {
> > > >              perror("UFFDIO_MOVE");
> > > >              exit(EXIT_FAILURE);
> > > >          }
> > > >      }
> > > >      return NULL;
> > > >  }
> > > >
> > > >  int main() {
> > > >  again:
> > > >      pthread_t thr, madv_thr;
> > > >      struct uffdio_api uffdio_api =3D { .api =3D UFFD_API, .feature=
s =3D 0 };
> > > >      struct uffdio_register uffdio_register;
> > > >
> > > >      src =3D mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PR=
IVATE | MAP_ANONYMOUS, -1, 0);
> > > >      if (src =3D=3D MAP_FAILED) {
> > > >          perror("mmap src");
> > > >          exit(EXIT_FAILURE);
> > > >      }
> > > >      memset(src, 1, REGION_SIZE);
> > > >
> > > >      dst =3D mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PR=
IVATE | MAP_ANONYMOUS, -1, 0);
> > > >      if (dst =3D=3D MAP_FAILED) {
> > > >          perror("mmap dst");
> > > >          exit(EXIT_FAILURE);
> > > >      }
> > > >
> > > >      uffd =3D syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> > > >      if (uffd =3D=3D -1) {
> > > >          perror("userfaultfd");
> > > >          exit(EXIT_FAILURE);
> > > >      }
> > > >
> > > >      if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D -1) {
> > > >          perror("UFFDIO_API");
> > > >          exit(EXIT_FAILURE);
> > > >      }
> > > >
> > > >      uffdio_register.range.start =3D (unsigned long)dst;
> > > >      uffdio_register.range.len =3D REGION_SIZE;
> > > >      uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> > > >
> > > >      if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) =3D=3D -1) =
{
> > > >          perror("UFFDIO_REGISTER");
> > > >          exit(EXIT_FAILURE);
> > > >      }
> > > >
> > > >      if (pthread_create(&madv_thr, NULL, madvise_thread, NULL) !=3D=
 0) {
> > > >          perror("pthread_create madvise_thread");
> > > >          exit(EXIT_FAILURE);
> > > >      }
> > > >
> > > >      if (pthread_create(&thr, NULL, fault_handler_thread, NULL) !=
=3D 0) {
> > > >          perror("pthread_create fault_handler_thread");
> > > >          exit(EXIT_FAILURE);
> > > >      }
> > > >
> > > >      for (size_t i =3D 0; i < REGION_SIZE; i +=3D PAGE_SIZE) {
> > > >          char val =3D ((char *)dst)[i];
> > > >          printf("Accessing dst at offset %zu, value: %d\n", i, val)=
;
> > > >      }
> > > >
> > > >      pthread_join(madv_thr, NULL);
> > > >      pthread_cancel(thr);
> > > >      pthread_join(thr, NULL);
> > > >
> > > >      munmap(src, REGION_SIZE);
> > > >      munmap(dst, REGION_SIZE);
> > > >      close(uffd);
> > > >      goto again;
> > > >      return 0;
> > > >  }
> > > >
> > > > As long as you enable mTHP (which likely increases the residency
> > > > time of swapcache), you can reproduce the issue within a few
> > > > seconds. But I guess the same race condition also exists with
> > > > small folios.
> > > >
> > > > Fixes: adef440691bab ("userfaultfd: UFFDIO_MOVE uABI")
> > > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Axel Rasmussen <axelrasmussen@google.com>
> > > > Cc: Brian Geffon <bgeffon@google.com>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: David Hildenbrand <david@redhat.com>
> > > > Cc: Hugh Dickins <hughd@google.com>
> > > > Cc: Jann Horn <jannh@google.com>
> > > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > Cc: Lokesh Gidra <lokeshgidra@google.com>
> > > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > > > Cc: Nicolas Geoffray <ngeoffray@google.com>
> > > > Cc: Peter Xu <peterx@redhat.com>
> > > > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > > Cc: Shuah Khan <shuah@kernel.org>
> > > > Cc: ZhangPeng <zhangpeng362@huawei.com>
> > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > ---
> > > >  mm/userfaultfd.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index 867898c4e30b..34cf1c8c725d 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -18,6 +18,7 @@
> > > >  #include <asm/tlbflush.h>
> > > >  #include <asm/tlb.h>
> > > >  #include "internal.h"
> > > > +#include "swap.h"
> > > >
> > > >  static __always_inline
> > > >  bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned lon=
g dst_end)
> > > > @@ -1079,9 +1080,19 @@ static int move_swap_pte(struct mm_struct *m=
m,
> > > >                          pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > >                          spinlock_t *dst_ptl, spinlock_t *src_ptl)
> > > >  {
> > > > +       struct folio *folio;
> > > > +       swp_entry_t entry;
> > > > +
> > > >         if (!pte_swp_exclusive(orig_src_pte))
> > > >                 return -EBUSY;
> > > >
> > >
> > > Would be helpful to add a comment explaining that this is the case
> > > when the folio is in the swap cache.
> > >
> > > > +       entry =3D pte_to_swp_entry(orig_src_pte);
> > > > +       folio =3D filemap_get_folio(swap_address_space(entry), swap=
_cache_index(entry));
> > > > +       if (!IS_ERR(folio)) {
> > > > +               folio_put(folio);
> > > > +               return -EBUSY;
> > > > +       }
> > > > +
> > > >         double_pt_lock(dst_ptl, src_ptl);
> > > >
> > > >         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, or=
ig_src_pte,
> > > > --
> > > > 2.39.3 (Apple Git-146)
> > > >
> >

Thanks
Barry

