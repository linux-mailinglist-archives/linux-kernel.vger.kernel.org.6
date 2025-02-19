Return-Path: <linux-kernel+bounces-522272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBCEA3C830
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044E118960C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FFD215053;
	Wed, 19 Feb 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S++yQm0r"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E921E4AB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991531; cv=none; b=Sk8jS256CYXwCHprR7D0cO91npZ/Og8Nb0tZgtvxOJdZo2ZCFCdeN53ccT8KDEqFY8Ze2ULqQoAu4RbAWLpupYQRewiI1tf3QG7rIPiGHY2Zg8SK1W8f5qq6aT85j/dOf3uDDC1Tzyh2ySdDW8aOPwYl6ir/Jqzk82kCCBi9ZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991531; c=relaxed/simple;
	bh=B0vNj4r7hAsd3L8j2V6619/OjfQ9J7Fc+tZx7sdyO8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAsLfLoIB7q9cmTC/tKt4z0eJooKsxnYY1+MBVJvCfKg+0pY2/UXzgu3CSEVCDdCGtyPAVXsflxyuLsRMcB59r1IAzXbUgvGfoT7Wd6wbbtNDAHw0L/cS5a+FHny+ky2FLjCPL5p1zUprr/8c0B5qgTMDREnhefn/QykGEcg6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S++yQm0r; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471fbfe8b89so42991cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739991529; x=1740596329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV6Dp9R0UqZgfUejgg99jyvJGgh21w1gRN9FOQxaLog=;
        b=S++yQm0rxwZVsmviw22vaeJkIp7V0x7BAu+1aFKDywJoF4GA8IAqbaXuwrQaoOOs2+
         /4h6GDM1NkL8tsAfPOtgxAjXXbfNidVB3vrILWxSmjxKaEWfqeS+ZZ3pFtP6lv8U4/JM
         ij+iCgZnJjp9B47q+gmGMAMq9Nv5Jjo6tOuGiNNT2EI1EKXYJ42zPJTenZ4N2/RUCJ4h
         giDxMDkYHwb8/UTBIP8cgy52q03Eg0rGrdUwGn6yOs6YoJUkHZvSvbk0djAzDUDNOOVW
         yKZFl2M0KhYUIc55+SfUmcyWny8UC5fF3S5TTxYO9MaSrtBgygoyZgZstDLLNQ42j3p+
         kbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739991529; x=1740596329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV6Dp9R0UqZgfUejgg99jyvJGgh21w1gRN9FOQxaLog=;
        b=xAkPMfelj/B3ZB+X/Ha+sYXs/CZVnG4j0fPXQBuyfxh1GzgGxUeEvlOK0iGtsg92tR
         uhjWrG14AWXp4/NRCqRTIaNdPJ9uEuEf7Y7WkLuFu3Q+srLmIAFjmwOCNlzeaqL6CMo3
         psqOGM9z2mvFhn3V1hEqhCXEjbDD7ZRCJmHgfrjS2tXyl9TSqV+yNFDhytTsh4Q9WT4Q
         E3ptr749zM9J9EObl03Njgm0cfuhA+knSdEF2u9qC8PQmrkSHLjpMk8GgtjKe7WGJJAe
         +KH0YwnGqelK+s/qhKGKHQF6jQGfYKn3GQ+E86owt9cd9rkteRowtW7Wh9hS04yICk2h
         5TEw==
X-Forwarded-Encrypted: i=1; AJvYcCUExjCuM2kQY15i8G+eIThNO0fAK8Oi05P7LNJtuWuk301j7gTJZ5Omg8UzLpW94zXU8YEKsVROU/VAYSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5+waCNSlAkI3TQNqBf9DSmYlLtTnfQrh8uSYvG6MYoPeF6wi
	B50td/ZR40txK/bAJ7Dp2LuIDDvKaGTMVGnIcc9bSj+EC2PrfxMz3p431PP4SCNOfuh5CWjbVMn
	HQZPzVrEQvDvY65azSlCx9on8JvJinIy+8VxM
X-Gm-Gg: ASbGnctWf/NA9F/prm0IrPYNUv5y6p4c23W/W2xBqhPoCeLkeT0OjngobvrQby5IROD
	Fj2eswO8zJqg7ze207TVNH3TqHOprJpPM23n+I+hQruQbVJskGldjqo9ujtbsQwoEFq/IDVRW
X-Google-Smtp-Source: AGHT+IEEAB0BHyuUOz64t5FnXCl3xFBOJJY0di2gbvVDhueCJHmMq/ttstvjIkoUnNhv36OqJuezAhfxTDhMjz8xXGc=
X-Received: by 2002:a05:622a:15c1:b0:472:7e8:a788 with SMTP id
 d75a77b69052e-47215bdb313mr68301cf.12.1739991528492; Wed, 19 Feb 2025
 10:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <b9f194e0-b20b-47ff-8c75-e15d34496292@redhat.com>
In-Reply-To: <b9f194e0-b20b-47ff-8c75-e15d34496292@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 19 Feb 2025 10:58:36 -0800
X-Gm-Features: AWEUYZns0E6GpI5_bmin95J6es9s90FSblqZWapaJGWbPq3gylXB90Dy1g5muLk
Message-ID: <CAJuCfpG9h3m4w6GWO7xUTxDD-SGyfP21iWPcjaVe6gviZ6UtpA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, zhengtangquan@oppo.com, 
	Barry Song <v-songbaohua@oppo.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Axel Rasmussen <axelrasmussen@google.com>, 
	Brian Geffon <bgeffon@google.com>, Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>, 
	ZhangPeng <zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:30=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 19.02.25 19:26, Suren Baghdasaryan wrote:
> > On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> userfaultfd_move() checks whether the PTE entry is present or a
> >> swap entry.
> >>
> >> - If the PTE entry is present, move_present_pte() handles folio
> >>    migration by setting:
> >>
> >>    src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> >>
> >> - If the PTE entry is a swap entry, move_swap_pte() simply copies
> >>    the PTE to the new dst_addr.
> >>
> >> This approach is incorrect because even if the PTE is a swap
> >> entry, it can still reference a folio that remains in the swap
> >> cache.
> >>
> >> If do_swap_page() is triggered, it may locate the folio in the
> >> swap cache. However, during add_rmap operations, a kernel panic
> >> can occur due to:
> >>   page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> >
> > Thanks for the report and reproducer!
> >
> >>
> >> $./a.out > /dev/null
> >> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c in=
dex:0xffffaf150 pfn:0x4667c
> >> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_map=
ped:1 pincount:0
> >> [   13.337716] memcg:ffff00000405f000
> >> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|own=
er_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> >> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538=
 ffff000006260361
> >> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000=
 ffff00000405f000
> >> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b53=
8 ffff000006260361
> >> [   13.339204] head: 0000000ffffaf150 0000000000004000 000000060000000=
0 ffff00000405f000
> >> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff0000000=
0 0000000000000001
> >> [   13.339546] head: 0000000000000004 0000000000000000 00000000fffffff=
f 0000000000000000
> >> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, p=
age) !=3D linear_page_index(vma, address))
> >> [   13.340190] ------------[ cut here ]------------
> >> [   13.340316] kernel BUG at mm/rmap.c:1380!
> >> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEM=
PT SMP
> >> [   13.340969] Modules linked in:
> >> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-r=
c3-gcf42737e247a-dirty #299
> >> [   13.341470] Hardware name: linux,dummy-virt (DT)
> >> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS B=
TYPE=3D--)
> >> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> >> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> >> [   13.342018] sp : ffff80008752bb20
> >> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 000000=
0000000001
> >> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 000000=
0000000001
> >> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffd=
ffc0199f00
> >> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 000000=
00ffffffff
> >> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866=
666f67705f
> >> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff80=
0083728ab0
> >> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80=
008011bc40
> >> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff80=
00829eebf8
> >> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 000000=
0000000000
> >> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000=
000000005f
> >> [   13.343876] Call trace:
> >> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> >> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> >> [   13.344333]  do_swap_page+0x1060/0x1400
> >> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> >> [   13.344504]  handle_mm_fault+0xd8/0x2e8
> >> [   13.344586]  do_page_fault+0x20c/0x770
> >> [   13.344673]  do_translation_fault+0xb4/0xf0
> >> [   13.344759]  do_mem_abort+0x48/0xa0
> >> [   13.344842]  el0_da+0x58/0x130
> >> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> >> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> >> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> >> [   13.345504] ---[ end trace 0000000000000000 ]---
> >> [   13.345715] note: a.out[107] exited with irqs disabled
> >> [   13.345954] note: a.out[107] exited with preempt_count 2
> >>
> >> Fully fixing it would be quite complex, requiring similar handling
> >> of folios as done in move_present_pte.
> >
> > How complex would that be? Is it a matter of adding
> > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > folio->index =3D linear_page_index like in move_present_pte() or
> > something more?
>
> If the entry is pte_swp_exclusive(), and the folio is order-0, it cannot
> be pinned and we may be able to move it I think.
>
> So all that's required is to check pte_swp_exclusive() and the folio size=
.
>
> ... in theory :) Not sure about the swap details.

Looking some more into it, I think we would have to perform all the
folio and anon_vma locking and pinning that we do for present pages in
move_pages_pte(). If that's correct then maybe treating swapcache
pages like a present page inside move_pages_pte() would be simpler?

>
> --
> Cheers,
>
> David / dhildenb
>

