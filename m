Return-Path: <linux-kernel+bounces-524826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57442A3E78F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA72189F9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D671EEA5E;
	Thu, 20 Feb 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Q6K0oP6"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3720FAA0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090850; cv=none; b=Apqf3DacEII8VbUiJf80T+5k8pYJyejdjgg7nNfScQXjLazSq0insJrd4bLMf46z074BgXGLucUmeCnANYbx96MMAZvlWQKS0EGm6JVkJleHUYdq4RqZYLLMAtPsGFGhgrWMyCv9FDeUWH7+i3TiVXHWVwQwNKheIeCYDbAQsrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090850; c=relaxed/simple;
	bh=dSZQTqnVf0DIL1GeUhwIyl1JOyADGp+T8zrsLhiL6gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbg+F+Xr2v3o58otbyzqLd+iGSwXN4rfCU//kQ9/b0gY0G2V52hMfjSWaa3VRvVe3OsW4SU5zsxbtsssrcHfmev0g6rGoZWSSu5ceZyjVzyldajLcdNDXYDCo/B5EJ8AlIDMyl43QLgcLjE1vkQDF4JLtkubBvs6Y7ezitoPnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Q6K0oP6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-472098e6e75so38771cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740090847; x=1740695647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s18TDU7nLAfv+jAsAfwI6kFUd8CxlMfAA6zR3ESNg4M=;
        b=3Q6K0oP6MaR/nffNMEcs41Kj2oJV5ruDZTGc+GBBvxSnGSQN1NDScG+6Js/ZprtRdv
         5C2JNjxWOrHLRSqmm0a2v1njc0jUr4y6A3Xo5KkqT4E4Q0Z28OR2m8ewBzezdvwrUxrx
         HbuGg9Y2qAMDwWzJMQ8D5pmenLcr8t09rbEiu68iDaBWsKbnmbV8ZvHmE2y+/Mu+6Hm6
         xQUT9it3dwx97ud7yCJy/UfpZ8a2kyA/XvmyhqCNqBjdqr3dKUW+YIyc3G/nD/oLL7SK
         vdfv9XyCthFEtYV7G8XU9CGQGjiUbcQBg/eSIw7NQEj2OsuoafIasVFYqRs5As7L2Fe8
         /P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090847; x=1740695647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s18TDU7nLAfv+jAsAfwI6kFUd8CxlMfAA6zR3ESNg4M=;
        b=UHdjLYNBJdFpTsqz7ZKRJQRbBJ3OiMTxN+5HYPEaqpYVgLz3RkxEpmE0SawtlD92Vz
         W7pAYXg6+SDNGvrawyv4fY0qtbA/5PM2y2iiKzFPLuoV+WaX3ahtSMz8OxsQoORkwWRt
         sRuegAE6TV+bIArDWkyqH3BYVvpR43s3Pp7vGW/CRDRq5b6qpi4tg2NtnfgVzicjaIB8
         lsQkeMBVn8FnrWcQFqcQ47fiMD/TXl3tsT0mwK8L1/IoeSMr2S7ZsQqEpTzPHL32Ib7R
         b4m10wPo2auGaeI46I3IJIL+XBKZdJ3i73ZHM5zsxZOx6T9WprQKMu4ZnOXav+mwt8ur
         6vJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd+gh5DsGpNTNzcz1a7sZfWomEyU2hGorqpVpA9wamFHUFDBSEKZ0CfrUC2sO9Xc2WFUJJuwm1PXnOYQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH14yF2JBrf0180pYPtAznQagme28SS6YNDJ9Mon9SGepwLDEg
	0XakWtlaro5VIIVfROXPSww4kUp2fcxPzEXfVDkPIkTIl54rh4+F25JDQUtZI57r1dw3fYD4XDw
	Ocexu5wMqfxv0vmsKRnI5TF+azRv2BKsKyDjo
X-Gm-Gg: ASbGncur311Vct6uIqiQ3r3oHnvrgtP0hSVwh0mw90F6fjSl1d+HtgLFgn1+OVpvF35
	hFvIWoHHudRTLWewByy2iqQoD+hyeoMCVF33miMxTDk0wvzozYj9Hcpo3p+DuPABugs+4kkUIlF
	qMjxi6CEMllh4nFdHz4G4p35rLYr8upA==
X-Google-Smtp-Source: AGHT+IFaKfQaSxINmYWnKKwUQzBgAQJiTmGrBos4qB/CMRfs2osPM0yAqO1xAg04RkqtaFkf0ZBL3BKRmBWXRH9yA0s=
X-Received: by 2002:a05:622a:6084:b0:472:636:f614 with SMTP id
 d75a77b69052e-472238f26damr1239221cf.20.1740090846652; Thu, 20 Feb 2025
 14:34:06 -0800 (PST)
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
 <CA+EESO7WbXnVEFMnywxUNjbCeNLLhhrKyba7MW+DC-nivgouzA@mail.gmail.com> <CAGsJ_4x8r5begRvU9tjGU+gk42=fFF53zbKXB8=Eyv1AebtkSA@mail.gmail.com>
In-Reply-To: <CAGsJ_4x8r5begRvU9tjGU+gk42=fFF53zbKXB8=Eyv1AebtkSA@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 20 Feb 2025 14:33:55 -0800
X-Gm-Features: AWEUYZk-_BgvBJIYDchal1GgyBFXkQ69N3dx5i2RCijzL_0xnqI4iNpaSM4iTpQ
Message-ID: <CA+EESO7VFAGCgh0xu3W84Te0zGbL4QfWXYDcVA7Toy5qMrmcpA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Barry Song <21cnbao@gmail.com>
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

On Thu, Feb 20, 2025 at 2:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Feb 21, 2025 at 11:20=E2=80=AFAM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 1:45=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Thu, Feb 20, 2025 at 10:36=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> > > >
> > > > On 20.02.25 10:31, Barry Song wrote:
> > > > > On Thu, Feb 20, 2025 at 9:51=E2=80=AFPM David Hildenbrand <david@=
redhat.com> wrote:
> > > > >>
> > > > >> On 19.02.25 21:37, Barry Song wrote:
> > > > >>> On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasaryan <sur=
enb@google.com> wrote:
> > > > >>>>
> > > > >>>> On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gm=
ail.com> wrote:
> > > > >>>>>
> > > > >>>>> From: Barry Song <v-songbaohua@oppo.com>
> > > > >>>>>
> > > > >>>>> userfaultfd_move() checks whether the PTE entry is present or=
 a
> > > > >>>>> swap entry.
> > > > >>>>>
> > > > >>>>> - If the PTE entry is present, move_present_pte() handles fol=
io
> > > > >>>>>     migration by setting:
> > > > >>>>>
> > > > >>>>>     src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> > > > >>>>>
> > > > >>>>> - If the PTE entry is a swap entry, move_swap_pte() simply co=
pies
> > > > >>>>>     the PTE to the new dst_addr.
> > > > >>>>>
> > > > >>>>> This approach is incorrect because even if the PTE is a swap
> > > > >>>>> entry, it can still reference a folio that remains in the swa=
p
> > > > >>>>> cache.
> > > > >>>>>
> > > > >>>>> If do_swap_page() is triggered, it may locate the folio in th=
e
> > > > >>>>> swap cache. However, during add_rmap operations, a kernel pan=
ic
> > > > >>>>> can occur due to:
> > > > >>>>>    page_pgoff(folio, page) !=3D linear_page_index(vma, addres=
s)
> > > > >>>>
> > > > >>>> Thanks for the report and reproducer!
> > > > >>>>
> > > > >>>>>
> > > > >>>>> $./a.out > /dev/null
> > > > >>>>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f4=
3db19c index:0xffffaf150 pfn:0x4667c
> > > > >>>>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_=
pages_mapped:1 pincount:0
> > > > >>>>> [   13.337716] memcg:ffff00000405f000
> > > > >>>>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|=
dirty|owner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > > > >>>>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff800=
08507b538 ffff000006260361
> > > > >>>>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000=
600000000 ffff00000405f000
> > > > >>>>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80=
008507b538 ffff000006260361
> > > > >>>>> [   13.339204] head: 0000000ffffaf150 0000000000004000 000000=
0600000000 ffff00000405f000
> > > > >>>>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffff=
ff00000000 0000000000000001
> > > > >>>>> [   13.339546] head: 0000000000000004 0000000000000000 000000=
00ffffffff 0000000000000000
> > > > >>>>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff=
(folio, page) !=3D linear_page_index(vma, address))
> > > > >>>>> [   13.340190] ------------[ cut here ]------------
> > > > >>>>> [   13.340316] kernel BUG at mm/rmap.c:1380!
> > > > >>>>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [=
#1] PREEMPT SMP
> > > > >>>>> [   13.340969] Modules linked in:
> > > > >>>>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted=
 6.14.0-rc3-gcf42737e247a-dirty #299
> > > > >>>>> [   13.341470] Hardware name: linux,dummy-virt (DT)
> > > > >>>>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DI=
T -SSBS BTYPE=3D--)
> > > > >>>>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> > > > >>>>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> > > > >>>>> [   13.342018] sp : ffff80008752bb20
> > > > >>>>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x2=
7: 0000000000000001
> > > > >>>>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x2=
4: 0000000000000001
> > > > >>>>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x2=
1: fffffdffc0199f00
> > > > >>>>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x1=
8: 00000000ffffffff
> > > > >>>>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x1=
5: 662866666f67705f
> > > > >>>>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x1=
2: ffff800083728ab0
> > > > >>>>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9=
 : ffff80008011bc40
> > > > >>>>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6=
 : ffff8000829eebf8
> > > > >>>>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3=
 : 0000000000000000
> > > > >>>>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0=
 : 000000000000005f
> > > > >>>>> [   13.343876] Call trace:
> > > > >>>>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> > > > >>>>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> > > > >>>>> [   13.344333]  do_swap_page+0x1060/0x1400
> > > > >>>>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> > > > >>>>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
> > > > >>>>> [   13.344586]  do_page_fault+0x20c/0x770
> > > > >>>>> [   13.344673]  do_translation_fault+0xb4/0xf0
> > > > >>>>> [   13.344759]  do_mem_abort+0x48/0xa0
> > > > >>>>> [   13.344842]  el0_da+0x58/0x130
> > > > >>>>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> > > > >>>>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> > > > >>>>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d42=
10000)
> > > > >>>>> [   13.345504] ---[ end trace 0000000000000000 ]---
> > > > >>>>> [   13.345715] note: a.out[107] exited with irqs disabled
> > > > >>>>> [   13.345954] note: a.out[107] exited with preempt_count 2
> > > > >>>>>
> > > > >>>>> Fully fixing it would be quite complex, requiring similar han=
dling
> > > > >>>>> of folios as done in move_present_pte.
> > > > >>>>
> > > > >>>> How complex would that be? Is it a matter of adding
> > > > >>>> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() =
and
> > > > >>>> folio->index =3D linear_page_index like in move_present_pte() =
or
> > > > >>>> something more?
> > > > >>>
> > > > >>> My main concern is still with large folios that require a split=
_folio()
> > > > >>> during move_pages(), as the entire folio shares the same index =
and
> > > > >>> anon_vma. However, userfaultfd_move() moves pages individually,
> > > > >>> making a split necessary.
> > > > >>>
> > > > >>> However, in split_huge_page_to_list_to_order(), there is a:
> > > > >>>
> > > > >>>           if (folio_test_writeback(folio))
> > > > >>>                   return -EBUSY;
> > > > >>>
> > > > >>> This is likely true for swapcache, right? However, even for mov=
e_present_pte(),
> > > > >>> it simply returns -EBUSY:
> > > > >>>
> > > > >>> move_pages_pte()
> > > > >>> {
> > > > >>>                   /* at this point we have src_folio locked */
> > > > >>>                   if (folio_test_large(src_folio)) {
> > > > >>>                           /* split_folio() can block */
> > > > >>>                           pte_unmap(&orig_src_pte);
> > > > >>>                           pte_unmap(&orig_dst_pte);
> > > > >>>                           src_pte =3D dst_pte =3D NULL;
> > > > >>>                           err =3D split_folio(src_folio);
> > > > >>>                           if (err)
> > > > >>>                                   goto out;
> > > > >>>
> > > > >>>                           /* have to reacquire the folio after =
it got split */
> > > > >>>                           folio_unlock(src_folio);
> > > > >>>                           folio_put(src_folio);
> > > > >>>                           src_folio =3D NULL;
> > > > >>>                           goto retry;
> > > > >>>                   }
> > > > >>> }
> > > > >>>
> > > > >>> Do we need a folio_wait_writeback() before calling split_folio(=
)?
> > > > >>>
> > > > >>> By the way, I have also reported that userfaultfd_move() has a =
fundamental
> > > > >>> conflict with TAO (Cc'ed Yu Zhao), which has been part of the A=
ndroid common
> > > > >>> kernel. In this scenario, folios in the virtual zone won=E2=80=
=99t be split in
> > > > >>> split_folio(). Instead, the large folio migrates into nr_pages =
small folios.
> > > > >>   > > Thus, the best-case scenario would be:
> > > > >>>
> > > > >>> mTHP -> migrate to small folios in split_folio() -> move small =
folios to
> > > > >>> dst_addr
> > > > >>>
> > > > >>> While this works, it negates the performance benefits of
> > > > >>> userfaultfd_move(), as it introduces two PTE operations (migrat=
ion in
> > > > >>> split_folio() and move in userfaultfd_move() while retry), nr_p=
ages memory
> > > > >>> allocations, and still requires one memcpy(). This could end up
> > > > >>> performing even worse than userfaultfd_copy(), I guess.
> > > > >>   > > The worst-case scenario would be failing to allocate small=
 folios in
> > > > >>> split_folio(), then userfaultfd_move() might return -ENOMEM?
> > > > >>
> > > > >> Although that's an Android problem and not an upstream problem, =
I'll
> > > > >> note that there are other reasons why the split / move might fai=
l, and
> > > > >> user space either must retry or fallback to a COPY.
> > > > >>
> > > > >> Regarding mTHP, we could move the whole folio if the user space-=
provided
> > > > >> range allows for batching over multiple PTEs (nr_ptes), they are=
 in a
> > > > >> single VMA, and folio_mapcount() =3D=3D nr_ptes.
> > > > >>
> > > > >> There are corner cases to handle, such as moving mTHPs such that=
 they
> > > > >> suddenly cross two page tables I assume, that are harder to hand=
le when
> > > > >> not moving individual PTEs where that cannot happen.
> > > > >
> > > > > This is a useful suggestion. I=E2=80=99ve heard that Lokesh is al=
so interested in
> > > > > modifying ART to perform moves at the mTHP granularity, which wou=
ld require
> > > > > kernel modifications as well. It=E2=80=99s likely the direction w=
e=E2=80=99ll take after
> > > > > fixing the current urgent bugs. The current split_folio() really =
isn=E2=80=99t ideal.
> > > > >
> > > > > The corner cases you mentioned are definitely worth considering. =
However,
> > > > > once we can perform batch UFFDIO_MOVE, I believe that in most cas=
es,
> > > > > the conflict between userfaultfd_move() and TAO will be resolved =
?
> > > >
> > > > Well, as soon as you would have varying mTHP sizes, you'd still run=
 into
> > > > the split with TAO. Maybe that doesn't apply with Android today, bu=
t I
> > > > can just guess that performing sub-mTHP moving would still be requi=
red
> > > > for GC at some point.
> > >
> > > With patch v2[1], as discussed in my previous email, I have observed =
that
> > > small folios consistently succeed without crashing. Similarly, mTHP n=
o
> > > longer crashes; however, it still returns -EBUSY during the raced tim=
e
> > > window, even after adding folio_wait_writeback. While I previously
> > > mentioned that folio_writeback prevents mTHP from splitting, this is =
not
> > > the only factor. The split_folio() function still returns -EBUSY beca=
use
> > > folio_get_anon_vma(folio) returns NULL when the folio is not mapped.
> > >
> > > int split_huge_page_to_list_to_order(struct page *page, struct list_h=
ead *list,
> > >                                      unsigned int new_order)
> > > {
> > >                 anon_vma =3D folio_get_anon_vma(folio);
> > >                 if (!anon_vma) {
> > >                         ret =3D -EBUSY;
> > >                         goto out;
> > >                 }
> > >
> > >                 end =3D -1;
> > >                 mapping =3D NULL;
> > >                 anon_vma_lock_write(anon_vma);
> > > }
> > >
> > > Even if mTHP is not from TAO's virtual zone, userfaultfd_move() will =
still
> > > fail when performing sub-mTHP moving in the swap cache case due to:
> >
> > Just to clarify my doubt. What do you mean by sub-mTHP? Also when you
> > say 'small folio' above,  do you mean single-page folios?
>
> This means any moving size smaller than the size of mTHP, or moving
> a partial mTHP.
>
> >
> > Am I understanding correctly that your patch correctly handles moving
> > single swap-cache page case?
>
> Yes, the crash is fixed for both small and large folios, and for small
> folios, moving is consistently successful(even for the swapcache case).
> The only issue is that sub-mTHP moving constantly fails for the swapcache
> case because split_folio() fails, even after waiting for writeback as
> split_folio()
> can only split mapped folios - which is false for swapcache since
> try_to_unmap_one() has been done.
>
> So I'd say for mTHP, returning -EBUSY as early as possible is the
> better choice to avoid wasting much time and eventually returning
> -EBUSY anyway unless we want to modify split_folio() things.
>
Great! In this case, can we please fix the kernel panic bug as soon as
possible. Until that is fixed, the ioctl is practically unusable.
> > >
> > > struct anon_vma *folio_get_anon_vma(const struct folio *folio)
> > > {
> > >         ...
> > >         if (!folio_mapped(folio))
> > >                 goto out;
> > >          ...
> > > }
> > >
> > > We likely need to modify split_folio() to support splitting unmapped =
anon
> > > folios within the swap cache or introduce a new function like
> > > split_unmapped_anon_folio()? Otherwise, userspace will have to fall b=
ack
> > > to UFFDIO_COPY or retry.
> > >
> > > As it stands, I see no way for sub-mTHP to survive moving with the cu=
rrent
> > > code and within the existing raced window. For mTHP, there is essenti=
ally
> > > no difference between returning -EBUSY immediately upon detecting tha=
t it
> > > is within the swap cache, as proposed in v1.
> > >
> > > [1] https://lore.kernel.org/linux-mm/20250220092101.71966-1-21cnbao@g=
mail.com/
> > >
> > > >
> > > > --
> > > > Cheers,
> > > >
> > > > David / dhildenb
> > > >
> > >
> Thanks
> Barry

