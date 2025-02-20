Return-Path: <linux-kernel+bounces-523288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B8A3D4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4608D176576
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570991EE032;
	Thu, 20 Feb 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2iEnE8w"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6B2AEFE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043912; cv=none; b=i7PJxWLBlKMgdJbWuEb7X7SOO7wkw/9QU0IqZikfdMX00yx6jAGTHykSbugpjuvG4xdewnnCoSWWkd/QN9tuWXLezl1dzqftLExfJpOnqc0/0ChkDQsIxnNm4/dSdzYLfjhiIeRhXlpsEjUkF12cGfDMASLBC4jYL7atjjbSCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043912; c=relaxed/simple;
	bh=LNVpLZGkeCjcbU0kj/VncfmZtbX69rP4wO8THFTpkfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwBZ5qqNp3U2KOFx7JFO2zq+lWmmpRbBa04ijZQ1U8QzgZfGvxuONvRCAt0CAwBjWA41JXiXH8Jf9J4+q6j36biT12CjFTG+8yg4oAFu7u4Qyx/TFHoBUV+VSwSqCGI9KR0nrjuZHRVG7W3joH+K3/9eQKCLDRMe1x5qFusQrYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2iEnE8w; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51e902b58c0so433653e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740043909; x=1740648709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdoNRWjXiW4/PpNlrCyffeatcs49XYxijvXWoaygBr4=;
        b=M2iEnE8wjNpj32OpRy0Ggp44CiKZovBxxVQ5xahWLFAkXnZo9QvoeXwpUSLr+Yerwm
         ucYs6YjVfJxisXab9mv4uDoEq+ivl+/Lqwu6VKvQzMtKqgcjW3b/dA29vhOFl697F/+7
         oc51K3gePLzYp1BJQ1WfrcUqVqYEJeL/tsSnmMGws/gJYC7M70lgpDi96rreFJE0Rg4n
         ihI+rbqH/ZP+a8mp9eUmNmzNpqzaOrWwoGdz0/BONjUpLy/WN/eufD0U8RMQRRj2/haq
         kZDbSJGP+a+u6tPpYZ/yKWzeTZ7TNS4HOKVFCD74gT1rbk6GMKS3PUD0SnGMfhiIug58
         RHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740043909; x=1740648709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdoNRWjXiW4/PpNlrCyffeatcs49XYxijvXWoaygBr4=;
        b=SsxENmmF9G4RrcKpzzEcZ+hJPeq48jgtdWhDFRFnlQptblJePMDky2j7Ye7DmqYRw+
         CrnDDt+LLG687yA8ZLGmdmuLsSMiv7iL/hPWphJWZywginlKtNm+Jh7OuTcx99AVZsFf
         M9IXcBVVY0MbiVNrAaJBhyexg0pkoGogj798BC3QWbGy7oHPXAx4kqDoeC4lMxZNNhcI
         iqt1mvAKHV2n3s+gVqyqDD3PyRC7M4kHeMffaQp2tL/Ezt5u/oraR3B+0STmqyVymd0z
         WNnZ7/P/1geUx49aCfxV1yZ/2XTkCADz2oo+SS4BmBGxPNCDMPaGpcY2sTx/bPUD+g55
         ItXA==
X-Forwarded-Encrypted: i=1; AJvYcCXLZc+vFIyDkIJzBKZ6wmSPSWiT90tYxGWot978enzs1XG0PZY4Jl3g6GuVSlCmz72TArO5Xcc77VFQB3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTDsFEG1Hz5SqOC+9es/m3VI4MfFDmZ1UUyqYtq5Jo1hRiw8J
	F/Xs92yKzVqVnNDcI9D+fIkChMWTeKNTUvBabyJO8+m2pUvHscDoS6HUYL79xPuxpRa35L28jT1
	KY+cNsJBC1s70ZUGvMLR1tPzVLmE=
X-Gm-Gg: ASbGncu93eSdQpd8pFHJMkFxZ0F54E6bEVVml+zVQk1CMNYAV/KQ8JTypT9HeLJrHiI
	esoEP1vZQ85OJKAMzvDepdD2l0KAdD30j+PnLtLYBkeksCWicuaEhJIjtsMxTv4AxEVHl0ukz
X-Google-Smtp-Source: AGHT+IFyCGv1PPsOvqhEJVbwoms8i4zSSY/RNt+XfvJakkAb76V2N5KSp9tyIzFz4OJoqvDNp6+qOYX6VoLvUBGtUPk=
X-Received: by 2002:a05:6122:d16:b0:51f:3fa3:d9af with SMTP id
 71dfb90a1353d-5209da76bc9mr11425943e0c.1.1740043909261; Thu, 20 Feb 2025
 01:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com> <50566d42-7754-4017-b290-f29d92e69231@redhat.com>
In-Reply-To: <50566d42-7754-4017-b290-f29d92e69231@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Feb 2025 22:31:38 +1300
X-Gm-Features: AWEUYZlBISKvK8miIhXC2jY7Ak_u4SVwcS83Dk9YQrVm3BCOJVFmjgt9l8uL66I
Message-ID: <CAGsJ_4zNounCe-N=BpqSLsk27FOJBJ9=eRbOE8CzOKF=H7kE0Q@mail.gmail.com>
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

On Thu, Feb 20, 2025 at 9:51=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.02.25 21:37, Barry Song wrote:
> > On Thu, Feb 20, 2025 at 7:27=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> On Wed, Feb 19, 2025 at 3:25=E2=80=AFAM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>>
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> userfaultfd_move() checks whether the PTE entry is present or a
> >>> swap entry.
> >>>
> >>> - If the PTE entry is present, move_present_pte() handles folio
> >>>    migration by setting:
> >>>
> >>>    src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> >>>
> >>> - If the PTE entry is a swap entry, move_swap_pte() simply copies
> >>>    the PTE to the new dst_addr.
> >>>
> >>> This approach is incorrect because even if the PTE is a swap
> >>> entry, it can still reference a folio that remains in the swap
> >>> cache.
> >>>
> >>> If do_swap_page() is triggered, it may locate the folio in the
> >>> swap cache. However, during add_rmap operations, a kernel panic
> >>> can occur due to:
> >>>   page_pgoff(folio, page) !=3D linear_page_index(vma, address)
> >>
> >> Thanks for the report and reproducer!
> >>
> >>>
> >>> $./a.out > /dev/null
> >>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c i=
ndex:0xffffaf150 pfn:0x4667c
> >>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_ma=
pped:1 pincount:0
> >>> [   13.337716] memcg:ffff00000405f000
> >>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|ow=
ner_priv_1|head|swapbacked|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> >>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b53=
8 ffff000006260361
> >>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 000000060000000=
0 ffff00000405f000
> >>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b5=
38 ffff000006260361
> >>> [   13.339204] head: 0000000ffffaf150 0000000000004000 00000006000000=
00 ffff00000405f000
> >>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff000000=
00 0000000000000001
> >>> [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffff=
ff 0000000000000000
> >>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, =
page) !=3D linear_page_index(vma, address))
> >>> [   13.340190] ------------[ cut here ]------------
> >>> [   13.340316] kernel BUG at mm/rmap.c:1380!
> >>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREE=
MPT SMP
> >>> [   13.340969] Modules linked in:
> >>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-=
rc3-gcf42737e247a-dirty #299
> >>> [   13.341470] Hardware name: linux,dummy-virt (DT)
> >>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> >>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
> >>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
> >>> [   13.342018] sp : ffff80008752bb20
> >>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 00000=
00000000001
> >>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 00000=
00000000001
> >>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffff=
dffc0199f00
> >>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000=
000ffffffff
> >>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 66286=
6666f67705f
> >>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff8=
00083728ab0
> >>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff8=
0008011bc40
> >>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8=
000829eebf8
> >>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 00000=
00000000000
> >>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 00000=
0000000005f
> >>> [   13.343876] Call trace:
> >>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
> >>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
> >>> [   13.344333]  do_swap_page+0x1060/0x1400
> >>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
> >>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
> >>> [   13.344586]  do_page_fault+0x20c/0x770
> >>> [   13.344673]  do_translation_fault+0xb4/0xf0
> >>> [   13.344759]  do_mem_abort+0x48/0xa0
> >>> [   13.344842]  el0_da+0x58/0x130
> >>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
> >>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
> >>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
> >>> [   13.345504] ---[ end trace 0000000000000000 ]---
> >>> [   13.345715] note: a.out[107] exited with irqs disabled
> >>> [   13.345954] note: a.out[107] exited with preempt_count 2
> >>>
> >>> Fully fixing it would be quite complex, requiring similar handling
> >>> of folios as done in move_present_pte.
> >>
> >> How complex would that be? Is it a matter of adding
> >> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> >> folio->index =3D linear_page_index like in move_present_pte() or
> >> something more?
> >
> > My main concern is still with large folios that require a split_folio()
> > during move_pages(), as the entire folio shares the same index and
> > anon_vma. However, userfaultfd_move() moves pages individually,
> > making a split necessary.
> >
> > However, in split_huge_page_to_list_to_order(), there is a:
> >
> >          if (folio_test_writeback(folio))
> >                  return -EBUSY;
> >
> > This is likely true for swapcache, right? However, even for move_presen=
t_pte(),
> > it simply returns -EBUSY:
> >
> > move_pages_pte()
> > {
> >                  /* at this point we have src_folio locked */
> >                  if (folio_test_large(src_folio)) {
> >                          /* split_folio() can block */
> >                          pte_unmap(&orig_src_pte);
> >                          pte_unmap(&orig_dst_pte);
> >                          src_pte =3D dst_pte =3D NULL;
> >                          err =3D split_folio(src_folio);
> >                          if (err)
> >                                  goto out;
> >
> >                          /* have to reacquire the folio after it got sp=
lit */
> >                          folio_unlock(src_folio);
> >                          folio_put(src_folio);
> >                          src_folio =3D NULL;
> >                          goto retry;
> >                  }
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
>  > > Thus, the best-case scenario would be:
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
>  > > The worst-case scenario would be failing to allocate small folios in
> > split_folio(), then userfaultfd_move() might return -ENOMEM?
>
> Although that's an Android problem and not an upstream problem, I'll
> note that there are other reasons why the split / move might fail, and
> user space either must retry or fallback to a COPY.
>
> Regarding mTHP, we could move the whole folio if the user space-provided
> range allows for batching over multiple PTEs (nr_ptes), they are in a
> single VMA, and folio_mapcount() =3D=3D nr_ptes.
>
> There are corner cases to handle, such as moving mTHPs such that they
> suddenly cross two page tables I assume, that are harder to handle when
> not moving individual PTEs where that cannot happen.

This is a useful suggestion. I=E2=80=99ve heard that Lokesh is also interes=
ted in
modifying ART to perform moves at the mTHP granularity, which would require
kernel modifications as well. It=E2=80=99s likely the direction we=E2=80=99=
ll take after
fixing the current urgent bugs. The current split_folio() really isn=E2=80=
=99t ideal.

The corner cases you mentioned are definitely worth considering. However,
once we can perform batch UFFDIO_MOVE, I believe that in most cases,
the conflict between userfaultfd_move() and TAO will be resolved ?

For those corner cases, ART will still need to be fully aware that falling
back to copy or retrying is necessary.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

