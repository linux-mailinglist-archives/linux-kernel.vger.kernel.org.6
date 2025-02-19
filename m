Return-Path: <linux-kernel+bounces-522660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F2A3CD05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1CC3B6CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED313FD86;
	Wed, 19 Feb 2025 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAbjalVP"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6892144C8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006295; cv=none; b=RghgXSMbO128T1UqZ+2NC6oB6V21MztddsrdfhZm8MR2VDlkvRSeHBuu4KLv/9I6pyV+jZKPvFxsGAMUfV1HFiJ4QYp80swhllkwpYohTcs176RkIIJ1w1VcdoRdCv7kcUsl0fABFliOkfsRZBExZke5aPlKD5s7IzZdzb1yqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006295; c=relaxed/simple;
	bh=iPc99UFtppOsSvuszQqiSgBQ+SfhkB6es9dUSZE9Mu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4jI9pMNvOfxfenp/xmNpM7W/oboNd+CEibRlphia/AqUv9aYrcmlH2Dg1ROmN4fTzAzF971NyK/KodSl8ArIdEKJzhY+XkO0D4ItxE6m2Pg7+lVfMjKYLJBH1RDfQnXytDAnWdNj7UPkroSxmPCghf+Xb0NBMjkmp7BTNswq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAbjalVP; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4be707fffbcso122997137.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740006292; x=1740611092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uidLPg20wl1w97l7EABQcqabC1BxJ6CM2osXQnhShac=;
        b=mAbjalVPazRvHqBqbwscnHLBRvo3C3arJrLByW6qA787MQYZmKU246SsQdMMPn87Xg
         bJmyhyB7mKbHhohWA0WKtR8qdQ/j2oVdiYQsv07fiYHmifC65CciuNrR5xAiS5o5KvYD
         yMl8r0ga7EmkMxOLHeRA/nVM61hE/bTXqGGF7ZqHXyC60385WmsOM+LqL3Jw8LymkhEZ
         a2/FU6Wk2V/pddQ6BbTjcXb1y32lt2v1b9vBPeqpvT2HJcGeYgl0452XOVl29fpuvgnN
         MGbwt4cZgjLvmv4wcgVAXaQlr4FngDoYNs/s03KY8N2uo6uCsrXuklK41/Lb2AUFPy6P
         UIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740006292; x=1740611092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uidLPg20wl1w97l7EABQcqabC1BxJ6CM2osXQnhShac=;
        b=W9QG/7vSAvDzDqWdHL2XzTud3Wnend8sHqrjGjW39CVGmj+rZMx2iQvPAS6hm6YoqR
         nILjDiE9jbWEfTcZcxXqRTQYR8iK/7Gf1usaSe+8P8vtcgSru7JkPB2oAfwzfSF/RZxC
         MvR0shmU87mdjWdjjUVYZ1FlplXFrYMEWonDclmkwf9cIa857HMoElFlbUInyPUk9eW6
         pUWeqpse937fVwhgyZs4BbBP11BobvfvD92q56LMwIAR4ZoZ4fy8yrsx4IaCzQfQiPMW
         Wv9bPMhPAOy1uzvaQu7myl+w1783DivlfjXzNqlUB5X7mgj4p2mmQU3ukLeqja8fs+iX
         XSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5mIN/tKJoTLj8gEkq+WAKR2Ia7FcOAM7VQEBuGz4pwgS0JhZnfJSEl526YqhciAj2EFZ1VbpRbB03CLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsdR5PDtHn0qLAKQZX07egVkCQI3byRcjTHapIwVdrFite45C
	C4D9pZ0mu34Jl7mzFQfpKKtJfSfrdfeKWWb9+A+MmppIlRY9gjvE5fX18IHp52DVM4lixUXvp+H
	6HOnZILKOkkh6Ma1Hcbna3TB3R2A=
X-Gm-Gg: ASbGncsIv3gCOkf52SWEw/xUdqwE7fuNHqyUUjgspeqMd1ApiEe5KCvuXO5cCAF6cFS
	9huRSA2AYJZQQeTG83mija/NNcM3Ig9zqucCviCPaCu00565NFEzloNOAEozPKTAzSFbLExMb
X-Google-Smtp-Source: AGHT+IGrdkIY4lXGB+MUujv7Pnn0efdTUe09/ZnLHPuC85PpHDq5XcGi+qtNHxQsqy3GaZmVv/GgJadJnSWliOuj0L8=
X-Received: by 2002:a05:6122:1d14:b0:520:3e1c:500f with SMTP id
 71dfb90a1353d-521df8abda3mr140838e0c.8.1740006291798; Wed, 19 Feb 2025
 15:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com> <Z7ZX28XARM7seknO@x1.local>
In-Reply-To: <Z7ZX28XARM7seknO@x1.local>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Feb 2025 12:04:40 +1300
X-Gm-Features: AWEUYZleJHGLzpoDFFv-z8ffjhdATbzXIfb4efNN34LhW9ZfDLayMqbFjcrZKMg
Message-ID: <CAGsJ_4wptMn8HX6Uam7AQpWeE=nOUDHE-Vr81SQJq_oSjmTFHg@mail.gmail.com>
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

On Thu, Feb 20, 2025 at 11:15=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
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
>
> Maybe no need in the first version to fix the immediate bug?
>
> It's also not always the case to hit writeback here. IIUC, writeback only
> happens for a short window when the folio was just added into swapcache.
> MOVE can happen much later after that anytime before a swapin.  My
> understanding is that's also what Matthew wanted to point out.  It may be
> better justified of that in a separate change with some performance
> measurements.

The bug we=E2=80=99re discussing occurs precisely within the short window y=
ou
mentioned.

1. add_to_swap: The folio is added to swapcache.
2. try_to_unmap: PTEs are converted to swap entries.
3. pageout
4. Swapcache is cleared.

The issue happens between steps 2 and 4, where the PTE is not present, but
the folio is still in swapcache - the current code does move_swap_pte() but=
 does
not fixup folio->index within swapcache.

My point is that if we want a proper fix for mTHP, we'd better handle write=
back.
Otherwise, this isn=E2=80=99t much different from directly returning -EBUSY=
 as proposed
in this RFC.

For small folios, there=E2=80=99s no split_folio issue, making it relativel=
y
simpler. Lokesh
mentioned plans to madvise NOHUGEPAGE in ART, so fixing small folios is lik=
ely
the first priority.

>
> Thanks,
>
> --
> Peter Xu

Thanks
Barry

