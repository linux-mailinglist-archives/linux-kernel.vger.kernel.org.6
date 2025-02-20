Return-Path: <linux-kernel+bounces-524819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE7A3E77F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FE94224EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D41F1506;
	Thu, 20 Feb 2025 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtECpldb"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA891B4247
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090423; cv=none; b=B3ksnVMGo/fcGSSvpcPCZpd2UWnG9Tk8KLnUu1whQOweZJPRWferZrPH83Ih/1GIivAHarFbruz2+htIEFI3TB3EJIxRwKlaEgAlxk3zPMEJPr5bYJhDqRTi9Rf30Jllyt46VhL+/gOF4qgSPDeqcl/VBVecio1I6MHKNgMwdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090423; c=relaxed/simple;
	bh=cgOcqdzfSO7xxLyI6gE8DwylJlQLTZXBuBiblhYf0Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anSLwU9U+61qu3vpmjoEypPOQZ6MIMfRwv4pK+fj4T3laipqu3XhTtAzDuBGIu17F2rf/JO4uRjBMCeUYQa5WzIlLn2a4h7WEgMz5QfF3I927miAwjF9jqpVMZmRv/W0i+TyxMuwKyVb9l/jJfMydvRqDg1gtULKLmFHv5jjCSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtECpldb; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5209437e773so473709e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740090420; x=1740695220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b06tAmUcXvCZtKVTHlvnbA0DpWBlTQgSfoCU6Ueia4=;
        b=LtECpldbhcWrzzCvk/hn+1VcUmYcFkvuRuRQbsIGsY9TXgCwPiQNtqZLyrrUqKKbHg
         Nlj0URDR/SqJQJTA87l0pF74nmalBwVDdqRMBDxBb9Mc1X2V51wBjCjWwI/GDja0J6Su
         ZBPdSjqT6QJW2ry/DLN9C5xX2+238+97ClbO0nMo4ES2B1bshEUij8kqD+/Cez8o2+F1
         szYhtirI1R5dNp9htlj7yrrw2HJ4df1giPOLFp4lpsTqoBqVwGtumF0U2S8GPRrwjY/B
         oPbGAE71rcevG5zeu2fm+uRTEst7ThQvqDGv7RDL2RJplQ/fxlY+2m9QFcq3GHx/lpNZ
         X2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090420; x=1740695220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2b06tAmUcXvCZtKVTHlvnbA0DpWBlTQgSfoCU6Ueia4=;
        b=TsAxVHzkatjBO3gyTYOona2mkibY18iJu+YCbstKZyrHUTnamMzDFKML9iauLarJel
         KEXXs2zFYH/Rz23OwS1rgA03pDspF7DnhcBYB2DPPWGyZaC8MtVd/5deZ5BfEpLhNcGS
         KkGRsRV40lbASfI7DaS3IxamrvCW6pcpa0j9vz4sPID8bj+c95puIEDhjBC3ZpNbVC+V
         9cWbwerWACLqSP7lCCdTcm3OQkHHQzHpQTqdI/gnIfkLFRr9EtNWJUcung3jEWApT7rK
         i8NzYSAYxfqUoAEviH1XjMu8sqRDcuYzdDT+qVmhqMpcCJV365VSQ1FjDgi0XsinnQrY
         ldfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8e0eIf95mtG48/MHCp8jfovGf2cdr9lCxclTZoIutA6sK1cKQQ1ZweIxH1CyNAj2dHTdKWWOMT5lUhPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSUGlWxXAFVWQ9Y7uXK7m8F21qQL6aIWrc63+jxZjB1DarlFH
	SsmsGJhZsMXaRCQco1Rpf8n8MQKrtrDfdybMjcnCGLLzMscjW6JE7BBg7/JjroBqPAPtFAQi4W3
	214jFRytJskwbz+ZmbzDJuAectzQ=
X-Gm-Gg: ASbGnctKM8kbQwNOuEEbFhBagjLyNRKdt/ZjCRClA+avRljkvnLf3fBTj1Q9nDR+PXj
	wwNXmOjgsSAcuvmafPUyp6UGGBsipukPj54A/ShoJjg3Y6satrneEZaI6+W7+thEIGpKv/l+X
X-Google-Smtp-Source: AGHT+IG6LRHquL1WD7tlxov6r4L1TU4ZCsDKVhqQwWTxjuH55hjKQUwHCMxO9tq7ZWzcp3WZM9BzjVmaYhKiwBrOnFY=
X-Received: by 2002:a05:6122:2a46:b0:518:7ab7:afbb with SMTP id
 71dfb90a1353d-521ee4740d0mr589281e0c.8.1740090420272; Thu, 20 Feb 2025
 14:27:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
 <50566d42-7754-4017-b290-f29d92e69231@redhat.com> <CAGsJ_4zNounCe-N=BpqSLsk27FOJBJ9=eRbOE8CzOKF=H7kE0Q@mail.gmail.com>
 <d198e62d-4c3a-44ae-a93f-7964e4f05fc8@redhat.com> <CAGsJ_4zPTvnD3oai3HpurURvUeBRX+BKBr0cy0=mCyCOFyNBZA@mail.gmail.com>
 <CA+EESO7WbXnVEFMnywxUNjbCeNLLhhrKyba7MW+DC-nivgouzA@mail.gmail.com>
In-Reply-To: <CA+EESO7WbXnVEFMnywxUNjbCeNLLhhrKyba7MW+DC-nivgouzA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 21 Feb 2025 11:26:49 +1300
X-Gm-Features: AWEUYZlpkAy_6a99Z9APnto80XBCZ2lVT7Tsq0ik0LI99ZUegmXArED92ZqvKEs
Message-ID: <CAGsJ_4x8r5begRvU9tjGU+gk42=fFF53zbKXB8=Eyv1AebtkSA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: David Hildenbrand <david@redhat.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Axel Rasmussen <axelrasmussen@google.com>, Brian Geffon <bgeffon@google.com>, 
	Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>, 
	ZhangPeng <zhangpeng362@huawei.com>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:20=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Thu, Feb 20, 2025 at 1:45=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Thu, Feb 20, 2025 at 10:36=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> > >
> > > On 20.02.25 10:31, Barry Song wrote:
> > > > On Thu, Feb 20, 2025 at 9:51=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> > > >>
> > > >> On 19.02.25 21:37, Barry Song wrote:
> > > >>> On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasaryan <suren=
b@google.com> wrote:
> > > >>>>
> > > >>>> On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmai=
l.com> wrote:
> > > >>>>>
> > > >>>>> From: Barry Song <v-songbaohua@oppo.com>
> > > >>>>>
> > > >>>>> userfaultfd_move() checks whether the PTE entry is present or a
> > > >>>>> swap entry.
> > > >>>>>
> > > >>>>> - If the PTE entry is present, move_present_pte() handles folio
> > > >>>>>     migration by setting:
> > > >>>>>
> > > >>>>>     src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> > > >>>>>
> > > >>>>> - If the PTE entry is a swap entry, move_swap_pte() simply copi=
es
> > > >>>>>     the PTE to the new dst_addr.
> > > >>>>>
> > > >>>>> This approach is incorrect because even if the PTE is a swap
> > > >>>>> entry, it can still reference a folio that remains in the swap
> > > >>>>> cache.
> > > >>>>>
> > > >>>>> If do_swap_page() is triggered, it may locate the folio in the
> > > >>>>> swap cache. However, during add_rmap operations, a kernel panic
> > > >>>>> can occur due to:
> > > >>>>>    page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> > > >>>>
> > > >>>> Thanks for the report and reproducer!
> > > >>>>
> > > >>>>>
> > > >>>>> $./a.out > /dev/null
> > > >>>>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43d=
b19c index:0xffffaf150 pfn:0x4667c
> > > >>>>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pa=
ges_mapped:1 pincount:0
> > > >>>>> [   13.337716] memcg:ffff00000405f000
> > > >>>>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|di=
rty|owner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > > >>>>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008=
507b538 ffff000006260361
> > > >>>>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 000000060=
0000000 ffff00000405f000
> > > >>>>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff8000=
8507b538 ffff000006260361
> > > >>>>> [   13.339204] head: 0000000ffffaf150 0000000000004000 00000006=
00000000 ffff00000405f000
> > > >>>>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff=
00000000 0000000000000001
> > > >>>>> [   13.339546] head: 0000000000000004 0000000000000000 00000000=
ffffffff 0000000000000000
> > > >>>>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(f=
olio, page) !=3D linear_page_index(vma, address))
> > > >>>>> [   13.340190] ------------[ cut here ]------------
> > > >>>>> [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > >>>>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1=
] PREEMPT SMP
> > > >>>>> [   13.340969] Modules linked in:
> > > >>>>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6=
.14.0-rc3-gcf42737e247a-dirty #299
> > > >>>>> [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > >>>>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT =
-SSBS BTYPE=3D--)
> > > >>>>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > >>>>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > >>>>> [   13.342018] sp : ffff80008752bb20
> > > >>>>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27:=
 0000000000000001
> > > >>>>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24:=
 0000000000000001
> > > >>>>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21:=
 fffffdffc0199f00
> > > >>>>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18:=
 00000000ffffffff
> > > >>>>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15:=
 662866666f67705f
> > > >>>>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12:=
 ffff800083728ab0
> > > >>>>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 :=
 ffff80008011bc40
> > > >>>>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 :=
 ffff8000829eebf8
> > > >>>>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 :=
 0000000000000000
> > > >>>>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 :=
 000000000000005f
> > > >>>>> [   13.343876] Call trace:
> > > >>>>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > >>>>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > >>>>> [   13.344333]  do_swap_page+0x1060/0x1400
> > > >>>>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > >>>>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > >>>>> [   13.344586]  do_page_fault+0x20c/0x770
> > > >>>>> [   13.344673]  do_translation_fault+0xb4/0xf0
> > > >>>>> [   13.344759]  do_mem_abort+0x48/0xa0
> > > >>>>> [   13.344842]  el0_da+0x58/0x130
> > > >>>>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > >>>>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > >>>>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210=
000)
> > > >>>>> [   13.345504] ---[ end trace 0000000000000000 ]---
> > > >>>>> [   13.345715] note: a.out[107] exited with irqs disabled
> > > >>>>> [   13.345954] note: a.out[107] exited with preempt_count 2
> > > >>>>>
> > > >>>>> Fully fixing it would be quite complex, requiring similar handl=
ing
> > > >>>>> of folios as done in move_present_pte.
> > > >>>>
> > > >>>> How complex would that be? Is it a matter of adding
> > > >>>> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() an=
d
> > > >>>> folio->index =3D linear_page_index like in move_present_pte() or
> > > >>>> something more?
> > > >>>
> > > >>> My main concern is still with large folios that require a split_f=
olio()
> > > >>> during move_pages(), as the entire folio shares the same index an=
d
> > > >>> anon_vma. However, userfaultfd_move() moves pages individually,
> > > >>> making a split necessary.
> > > >>>
> > > >>> However, in split_huge_page_to_list_to_order(), there is a:
> > > >>>
> > > >>>           if (folio_test_writeback(folio))
> > > >>>                   return -EBUSY;
> > > >>>
> > > >>> This is likely true for swapcache, right? However, even for move_=
present_pte(),
> > > >>> it simply returns -EBUSY:
> > > >>>
> > > >>> move_pages_pte()
> > > >>> {
> > > >>>                   /* at this point we have src_folio locked */
> > > >>>                   if (folio_test_large(src_folio)) {
> > > >>>                           /* split_folio() can block */
> > > >>>                           pte_unmap(&orig_src_pte);
> > > >>>                           pte_unmap(&orig_dst_pte);
> > > >>>                           src_pte =3D dst_pte =3D NULL;
> > > >>>                           err =3D split_folio(src_folio);
> > > >>>                           if (err)
> > > >>>                                   goto out;
> > > >>>
> > > >>>                           /* have to reacquire the folio after it=
 got split */
> > > >>>                           folio_unlock(src_folio);
> > > >>>                           folio_put(src_folio);
> > > >>>                           src_folio =3D NULL;
> > > >>>                           goto retry;
> > > >>>                   }
> > > >>> }
> > > >>>
> > > >>> Do we need a folio_wait_writeback() before calling split_folio()?
> > > >>>
> > > >>> By the way, I have also reported that userfaultfd_move() has a fu=
ndamental
> > > >>> conflict with TAO (Cc'ed Yu Zhao), which has been part of the And=
roid common
> > > >>> kernel. In this scenario, folios in the virtual zone won=E2=80=99=
t be split in
> > > >>> split_folio(). Instead, the large folio migrates into nr_pages sm=
all folios.
> > > >>   > > Thus, the best-case scenario would be:
> > > >>>
> > > >>> mTHP -> migrate to small folios in split_folio() -> move small fo=
lios to
> > > >>> dst_addr
> > > >>>
> > > >>> While this works, it negates the performance benefits of
> > > >>> userfaultfd_move(), as it introduces two PTE operations (migratio=
n in
> > > >>> split_folio() and move in userfaultfd_move() while retry), nr_pag=
es memory
> > > >>> allocations, and still requires one memcpy(). This could end up
> > > >>> performing even worse than userfaultfd_copy(), I guess.
> > > >>   > > The worst-case scenario would be failing to allocate small f=
olios in
> > > >>> split_folio(), then userfaultfd_move() might return -ENOMEM?
> > > >>
> > > >> Although that's an Android problem and not an upstream problem, I'=
ll
> > > >> note that there are other reasons why the split / move might fail,=
 and
> > > >> user space either must retry or fallback to a COPY.
> > > >>
> > > >> Regarding mTHP, we could move the whole folio if the user space-pr=
ovided
> > > >> range allows for batching over multiple PTEs (nr_ptes), they are i=
n a
> > > >> single VMA, and folio_mapcount() =3D=3D nr_ptes.
> > > >>
> > > >> There are corner cases to handle, such as moving mTHPs such that t=
hey
> > > >> suddenly cross two page tables I assume, that are harder to handle=
 when
> > > >> not moving individual PTEs where that cannot happen.
> > > >
> > > > This is a useful suggestion. I=E2=80=99ve heard that Lokesh is also=
 interested in
> > > > modifying ART to perform moves at the mTHP granularity, which would=
 require
> > > > kernel modifications as well. It=E2=80=99s likely the direction we=
=E2=80=99ll take after
> > > > fixing the current urgent bugs. The current split_folio() really is=
n=E2=80=99t ideal.
> > > >
> > > > The corner cases you mentioned are definitely worth considering. Ho=
wever,
> > > > once we can perform batch UFFDIO_MOVE, I believe that in most cases=
,
> > > > the conflict between userfaultfd_move() and TAO will be resolved ?
> > >
> > > Well, as soon as you would have varying mTHP sizes, you'd still run i=
nto
> > > the split with TAO. Maybe that doesn't apply with Android today, but =
I
> > > can just guess that performing sub-mTHP moving would still be require=
d
> > > for GC at some point.
> >
> > With patch v2[1], as discussed in my previous email, I have observed th=
at
> > small folios consistently succeed without crashing. Similarly, mTHP no
> > longer crashes; however, it still returns -EBUSY during the raced time
> > window, even after adding folio_wait_writeback. While I previously
> > mentioned that folio_writeback prevents mTHP from splitting, this is no=
t
> > the only factor. The split_folio() function still returns -EBUSY becaus=
e
> > folio_get_anon_vma(folio) returns NULL when the folio is not mapped.
> >
> > int split_huge_page_to_list_to_order(struct page *page, struct list_hea=
d *list,
> >                                      unsigned int new_order)
> > {
> >                 anon_vma =3D folio_get_anon_vma(folio);
> >                 if (!anon_vma) {
> >                         ret =3D -EBUSY;
> >                         goto out;
> >                 }
> >
> >                 end =3D -1;
> >                 mapping =3D NULL;
> >                 anon_vma_lock_write(anon_vma);
> > }
> >
> > Even if mTHP is not from TAO's virtual zone, userfaultfd_move() will st=
ill
> > fail when performing sub-mTHP moving in the swap cache case due to:
>
> Just to clarify my doubt. What do you mean by sub-mTHP? Also when you
> say 'small folio' above,  do you mean single-page folios?

This means any moving size smaller than the size of mTHP, or moving
a partial mTHP.

>
> Am I understanding correctly that your patch correctly handles moving
> single swap-cache page case?

Yes, the crash is fixed for both small and large folios, and for small
folios, moving is consistently successful(even for the swapcache case).
The only issue is that sub-mTHP moving constantly fails for the swapcache
case because split_folio() fails, even after waiting for writeback as
split_folio()
can only split mapped folios - which is false for swapcache since
try_to_unmap_one() has been done.

So I'd say for mTHP, returning -EBUSY as early as possible is the
better choice to avoid wasting much time and eventually returning
-EBUSY anyway unless we want to modify split_folio() things.

> >
> > struct anon_vma *folio_get_anon_vma(const struct folio *folio)
> > {
> >         ...
> >         if (!folio_mapped(folio))
> >                 goto out;
> >          ...
> > }
> >
> > We likely need to modify split_folio() to support splitting unmapped an=
on
> > folios within the swap cache or introduce a new function like
> > split_unmapped_anon_folio()? Otherwise, userspace will have to fall bac=
k
> > to UFFDIO_COPY or retry.
> >
> > As it stands, I see no way for sub-mTHP to survive moving with the curr=
ent
> > code and within the existing raced window. For mTHP, there is essential=
ly
> > no difference between returning -EBUSY immediately upon detecting that =
it
> > is within the swap cache, as proposed in v1.
> >
> > [1] https://lore.kernel.org/linux-mm/20250220092101.71966-1-21cnbao@gma=
il.com/
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> >
Thanks
Barry

