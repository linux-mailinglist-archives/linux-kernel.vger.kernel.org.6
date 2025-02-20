Return-Path: <linux-kernel+bounces-524772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A307A3E6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E5C3AF70B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA301EEA43;
	Thu, 20 Feb 2025 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1OjW8VJ"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E319CC20
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087937; cv=none; b=HjHgUz4M85QUGYB2CUpC2JChAdtk04MlzqsHKKxu5b5IW16tDro7isLk/pUE6of42bHQuJGwOZdRJNJZqlq9tT0S0eZ03dGt1+slUIAV5p8bVs7+Sgmhf1CG+2Yfo3WlxZDuRK8JaE0Y5ibUZsZYi4oWUZPD4gdocSLtBd87k/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087937; c=relaxed/simple;
	bh=Yy8HmqFvhuCLv3eLUGW+hjjTUfJGp1La8RH5ZO1T3jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aacYks51vXIvtlDRxZFA6EeFzHauZ+r2d5klkg4CoD65vqTrr2daDUijaFmjbazgRnohkvcFB+s9BQqD/aw5j6ETlzTcAGtiTzHFHFd9XLQ82LzekBT404DPwFpi2woh0tKkGx1X18ES4RLcfKK0lus9mVky7UcXgY+3cJilApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1OjW8VJ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4be5033a2cbso669992137.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740087934; x=1740692734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXIb836gWC4wBjuTjc53sh1pM42/PKXwk1AqfwdsvLg=;
        b=Y1OjW8VJpuINjoF7QygyOPoSDXTy28vNQUURtdilucBMlG/taC18UgjCSngjCnJTAx
         Yv8XmrvmksBUvUU7fsdMUqrBlBbat2C01Ab1jDtEZUz/JgS0a7mAQ4WOLpJ4kknjMMWj
         uW+rMN5fRq90yC0odQg7G8HUcLHpXZjpkdyrrBJHm5dX2dfzjsNcKsJSLnjepYtnPvil
         VIjsm7SQXB5Fr+d68vsDvGONnLyt5G5mJy9hU6Hc69vYD/yDslvUegZiwiJ/OWTQRATV
         sCZ8Mcw8HCVSwPcCBHzETvlaeYMVIBmKrHBSoi7PHnd7sh2TGPXbDTvqpYR+UX9yg95z
         Kl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087934; x=1740692734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXIb836gWC4wBjuTjc53sh1pM42/PKXwk1AqfwdsvLg=;
        b=gsHgGznNzeJ7/3+kw9+dCnGe5qTXd1zaZGoPXJbRwTojIez91AwbYVpbe1Ajf1Ct7u
         IlYrN9gpi/BzcvcmK6oYKlCCIBWQv8I71U8kMw030tBZjanit/FB1/51R8vylk6pDxn3
         aZNtrstvITu9C1PJr476xrttIz4AX00/sRPZZB+hoKOymGcB/jfVq/fCUeE9JP/MZb75
         rApxlRSbDf7j3GYGDUhuVOjsKYNisnFkQTm/cee799xODV7ZRtYxyduNKkmx+JIKcoHp
         eVd5bd1Odxy/c7pp7HTViECLcFSYfUsWUunX+gfoc5Zs6eKF/OStBeMrMRfBozprgXEE
         CWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn+mBhUu5K9vq/unUtGIPOOHRKs5JFrhLjFieY9hCv0NV/2yGsNRMJTUjEt7HGp73BsHZ6NRwOPZaFu1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7A09EMWIAKa47Kw3/oUgaIRgf+Wiahs5hsIsIqN9Nv/+ERNi
	c37t7SrwyiNQzrz4RR6kNosjgbNvXeQYGjPtesqsPAdvfquSKLQZcnVJJRd39d/5VEHW5K9o8Gy
	p8NFyAS21+kgZdRMdorNiJDbhXhI=
X-Gm-Gg: ASbGnctYVlaSX8QBvhfQODnz5yj/EQoDgWvCZP0gd3lJt2oR5hpcYnTqyTrDK2J5CI6
	yDZEhWIu+Aq6yRS7MELBGzzKR2KqRc0fsCogVbVNM6zD4CnMH7uV4o4AyvfCfDWwJt6IYo8gn
X-Google-Smtp-Source: AGHT+IGcOnNa+DhVZ9fnuKYxVe9VnnOAeXEBeS7020TvFrUeDtR9jy3zY8/SZoSI1tPQoL4f6Ad0iVxoyvUEXzmC1WQ=
X-Received: by 2002:a05:6102:442c:b0:4b2:9eeb:518f with SMTP id
 ada2fe7eead31-4bfc00c0415mr839015137.10.1740087934022; Thu, 20 Feb 2025
 13:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
 <50566d42-7754-4017-b290-f29d92e69231@redhat.com> <CAGsJ_4zNounCe-N=BpqSLsk27FOJBJ9=eRbOE8CzOKF=H7kE0Q@mail.gmail.com>
 <d198e62d-4c3a-44ae-a93f-7964e4f05fc8@redhat.com>
In-Reply-To: <d198e62d-4c3a-44ae-a93f-7964e4f05fc8@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 21 Feb 2025 10:45:23 +1300
X-Gm-Features: AWEUYZl4xe7HNDvo6UXTBDHLB73U9sPNHtCPSO3wp119NQEl1496IzjgrPxSD-A
Message-ID: <CAGsJ_4zPTvnD3oai3HpurURvUeBRX+BKBr0cy0=mCyCOFyNBZA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org, 
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

On Thu, Feb 20, 2025 at 10:36=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 20.02.25 10:31, Barry Song wrote:
> > On Thu, Feb 20, 2025 at 9:51=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 19.02.25 21:37, Barry Song wrote:
> >>> On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> >>>>
> >>>> On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail.co=
m> wrote:
> >>>>>
> >>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> userfaultfd_move() checks whether the PTE entry is present or a
> >>>>> swap entry.
> >>>>>
> >>>>> - If the PTE entry is present, move_present_pte() handles folio
> >>>>>     migration by setting:
> >>>>>
> >>>>>     src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> >>>>>
> >>>>> - If the PTE entry is a swap entry, move_swap_pte() simply copies
> >>>>>     the PTE to the new dst_addr.
> >>>>>
> >>>>> This approach is incorrect because even if the PTE is a swap
> >>>>> entry, it can still reference a folio that remains in the swap
> >>>>> cache.
> >>>>>
> >>>>> If do_swap_page() is triggered, it may locate the folio in the
> >>>>> swap cache. However, during add_rmap operations, a kernel panic
> >>>>> can occur due to:
> >>>>>    page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> >>>>
> >>>> Thanks for the report and reproducer!
> >>>>
> >>>>>
> >>>>> $./a.out > /dev/null
> >>>>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c=
 index:0xffffaf150 pfn:0x4667c
> >>>>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_=
mapped:1 pincount:0
> >>>>> [   13.337716] memcg:ffff00000405f000
> >>>>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|=
owner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> >>>>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b=
538 ffff000006260361
> >>>>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000=
000 ffff00000405f000
> >>>>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507=
b538 ffff000006260361
> >>>>> [   13.339204] head: 0000000ffffaf150 0000000000004000 000000060000=
0000 ffff00000405f000
> >>>>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff0000=
0000 0000000000000001
> >>>>> [   13.339546] head: 0000000000000004 0000000000000000 00000000ffff=
ffff 0000000000000000
> >>>>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio=
, page) !=3D linear_page_index(vma, address))
> >>>>> [   13.340190] ------------[ cut here ]------------
> >>>>> [   13.340316] kernel BUG at mm/rmap.c:1380!
> >>>>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PR=
EEMPT SMP
> >>>>> [   13.340969] Modules linked in:
> >>>>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.=
0-rc3-gcf42737e247a-dirty #299
> >>>>> [   13.341470] Hardware name: linux,dummy-virt (DT)
> >>>>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
> >>>>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> >>>>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> >>>>> [   13.342018] sp : ffff80008752bb20
> >>>>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 000=
0000000000001
> >>>>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 000=
0000000000001
> >>>>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fff=
ffdffc0199f00
> >>>>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 000=
00000ffffffff
> >>>>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662=
866666f67705f
> >>>>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: fff=
f800083728ab0
> >>>>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : fff=
f80008011bc40
> >>>>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : fff=
f8000829eebf8
> >>>>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 000=
0000000000000
> >>>>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000=
000000000005f
> >>>>> [   13.343876] Call trace:
> >>>>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> >>>>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> >>>>> [   13.344333]  do_swap_page+0x1060/0x1400
> >>>>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> >>>>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
> >>>>> [   13.344586]  do_page_fault+0x20c/0x770
> >>>>> [   13.344673]  do_translation_fault+0xb4/0xf0
> >>>>> [   13.344759]  do_mem_abort+0x48/0xa0
> >>>>> [   13.344842]  el0_da+0x58/0x130
> >>>>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> >>>>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> >>>>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> >>>>> [   13.345504] ---[ end trace 0000000000000000 ]---
> >>>>> [   13.345715] note: a.out[107] exited with irqs disabled
> >>>>> [   13.345954] note: a.out[107] exited with preempt_count 2
> >>>>>
> >>>>> Fully fixing it would be quite complex, requiring similar handling
> >>>>> of folios as done in move_present_pte.
> >>>>
> >>>> How complex would that be? Is it a matter of adding
> >>>> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> >>>> folio->index =3D linear_page_index like in move_present_pte() or
> >>>> something more?
> >>>
> >>> My main concern is still with large folios that require a split_folio=
()
> >>> during move_pages(), as the entire folio shares the same index and
> >>> anon_vma. However, userfaultfd_move() moves pages individually,
> >>> making a split necessary.
> >>>
> >>> However, in split_huge_page_to_list_to_order(), there is a:
> >>>
> >>>           if (folio_test_writeback(folio))
> >>>                   return -EBUSY;
> >>>
> >>> This is likely true for swapcache, right? However, even for move_pres=
ent_pte(),
> >>> it simply returns -EBUSY:
> >>>
> >>> move_pages_pte()
> >>> {
> >>>                   /* at this point we have src_folio locked */
> >>>                   if (folio_test_large(src_folio)) {
> >>>                           /* split_folio() can block */
> >>>                           pte_unmap(&orig_src_pte);
> >>>                           pte_unmap(&orig_dst_pte);
> >>>                           src_pte =3D dst_pte =3D NULL;
> >>>                           err =3D split_folio(src_folio);
> >>>                           if (err)
> >>>                                   goto out;
> >>>
> >>>                           /* have to reacquire the folio after it got=
 split */
> >>>                           folio_unlock(src_folio);
> >>>                           folio_put(src_folio);
> >>>                           src_folio =3D NULL;
> >>>                           goto retry;
> >>>                   }
> >>> }
> >>>
> >>> Do we need a folio_wait_writeback() before calling split_folio()?
> >>>
> >>> By the way, I have also reported that userfaultfd_move() has a fundam=
ental
> >>> conflict with TAO (Cc'ed Yu Zhao), which has been part of the Android=
 common
> >>> kernel. In this scenario, folios in the virtual zone won=E2=80=99t be=
 split in
> >>> split_folio(). Instead, the large folio migrates into nr_pages small =
folios.
> >>   > > Thus, the best-case scenario would be:
> >>>
> >>> mTHP -> migrate to small folios in split_folio() -> move small folios=
 to
> >>> dst_addr
> >>>
> >>> While this works, it negates the performance benefits of
> >>> userfaultfd_move(), as it introduces two PTE operations (migration in
> >>> split_folio() and move in userfaultfd_move() while retry), nr_pages m=
emory
> >>> allocations, and still requires one memcpy(). This could end up
> >>> performing even worse than userfaultfd_copy(), I guess.
> >>   > > The worst-case scenario would be failing to allocate small folio=
s in
> >>> split_folio(), then userfaultfd_move() might return -ENOMEM?
> >>
> >> Although that's an Android problem and not an upstream problem, I'll
> >> note that there are other reasons why the split / move might fail, and
> >> user space either must retry or fallback to a COPY.
> >>
> >> Regarding mTHP, we could move the whole folio if the user space-provid=
ed
> >> range allows for batching over multiple PTEs (nr_ptes), they are in a
> >> single VMA, and folio_mapcount() =3D=3D nr_ptes.
> >>
> >> There are corner cases to handle, such as moving mTHPs such that they
> >> suddenly cross two page tables I assume, that are harder to handle whe=
n
> >> not moving individual PTEs where that cannot happen.
> >
> > This is a useful suggestion. I=E2=80=99ve heard that Lokesh is also int=
erested in
> > modifying ART to perform moves at the mTHP granularity, which would req=
uire
> > kernel modifications as well. It=E2=80=99s likely the direction we=E2=
=80=99ll take after
> > fixing the current urgent bugs. The current split_folio() really isn=E2=
=80=99t ideal.
> >
> > The corner cases you mentioned are definitely worth considering. Howeve=
r,
> > once we can perform batch UFFDIO_MOVE, I believe that in most cases,
> > the conflict between userfaultfd_move() and TAO will be resolved ?
>
> Well, as soon as you would have varying mTHP sizes, you'd still run into
> the split with TAO. Maybe that doesn't apply with Android today, but I
> can just guess that performing sub-mTHP moving would still be required
> for GC at some point.

With patch v2[1], as discussed in my previous email, I have observed that
small folios consistently succeed without crashing. Similarly, mTHP no
longer crashes; however, it still returns -EBUSY during the raced time
window, even after adding folio_wait_writeback. While I previously
mentioned that folio_writeback prevents mTHP from splitting, this is not
the only factor. The split_folio() function still returns -EBUSY because
folio_get_anon_vma(folio) returns NULL when the folio is not mapped.

int split_huge_page_to_list_to_order(struct page *page, struct list_head *l=
ist,
                                     unsigned int new_order)
{
                anon_vma =3D folio_get_anon_vma(folio);
                if (!anon_vma) {
                        ret =3D -EBUSY;
                        goto out;
                }

                end =3D -1;
                mapping =3D NULL;
                anon_vma_lock_write(anon_vma);
}

Even if mTHP is not from TAO's virtual zone, userfaultfd_move() will still
fail when performing sub-mTHP moving in the swap cache case due to:

struct anon_vma *folio_get_anon_vma(const struct folio *folio)
{
        ...
        if (!folio_mapped(folio))
                goto out;
         ...
}

We likely need to modify split_folio() to support splitting unmapped anon
folios within the swap cache or introduce a new function like
split_unmapped_anon_folio()? Otherwise, userspace will have to fall back
to UFFDIO_COPY or retry.

As it stands, I see no way for sub-mTHP to survive moving with the current
code and within the existing raced window. For mTHP, there is essentially
no difference between returning -EBUSY immediately upon detecting that it
is within the swap cache, as proposed in v1.

[1] https://lore.kernel.org/linux-mm/20250220092101.71966-1-21cnbao@gmail.c=
om/

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

