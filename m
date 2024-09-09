Return-Path: <linux-kernel+bounces-321177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7CD971589
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D90B25370
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060C1B4C4A;
	Mon,  9 Sep 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkAgdMAf"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41431B3735
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878470; cv=none; b=EwojjP8M+qP0qLT/J0wn/Nhc54z/8CQl+XSZedoyz7k1KDfU5AifCjQZUQ78x3TYwuV6FGiHV6szumM0WVJs+Kn6VBRkzbjgrucYJ56zu7+JW2Bcl7QsY0H2uqglGLd2k31D4grajN8KrgY9QRGU6+dbwyin2xKHWyHSCfSdPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878470; c=relaxed/simple;
	bh=yvpm7oLrXSYbjztfjdKKc/ml7NEo9FpcwijeaQwnLZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwiUi5GqUAbVP67uQAVIZij258f9yX3Sv2Fv4RPPgqh7LDYknMvjn+mqgr3ej3LutHiGIweBwyMLT6TatFQeKFDgzYwLk13Mf+J2t8R64uQZlQkglmSxFGt8m4eU2gW/mXl/0rHYtCGomny1MzwaNjvEaOf2m5figjWw5GWbfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkAgdMAf; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8b96c18f0so3269695a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725878468; x=1726483268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg+a9nkxAendxU2JTg4zlQAG8wk22rpVaVjtWTZo5WI=;
        b=LkAgdMAf7SOb2IQiXC6EfrogIDIPEHUhqHKjf4L89vNCAUgE81DAibJ1OUom4vPJT1
         jwmH8FNkZPdHMqSEYKcOHy8lrlmxiUz+5qeerw/cBDX1owlwt5pY3Sr6Vo+tl9JhorHL
         gfIdpgZkuicv7/40vtuQVXYZutJKo/3NdlupuW55prIkB9y+uR/YVr44q0yC2IxUXHwo
         bpNuvFFLu/geiUIRzAmpjeBHtqxYbjtVVVj/fzmbb2H6H48uQY7k3O2A7wtlLSq+xKn6
         /Hrut3qg/sMZ2KnGpdfh7AkJ3hPJ13nPTSVboDJCLXSQkBs054wbiNDSYDyr72ujysUt
         OFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725878468; x=1726483268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg+a9nkxAendxU2JTg4zlQAG8wk22rpVaVjtWTZo5WI=;
        b=ef2jkH5SORmHJOL61DUE64Ura8q4xi5czKmCnoJnN10IqhJfPIBgNvc6NX0pqapI0I
         Q0aVJfNhj8QaG/n/SlkD6btOFVlbfpaCRiAdFmQx4oP+Cq1riY27b3lCiGfzqmNlQydS
         GHQLFIZ0b5h+OIyGZaXGR99uWIaQiu6vjLGUBZ0d6hpUTPiC48gML0NzkVt57SpDIlKq
         ZPjGezahLmRddUaN+EirIHSLB9RdttKgqDnWXLvutjR7vzfNSq3+720oqLG8T4z1Qn/F
         hb0nxyKtf4LzDa5YzUsk9iawikftf/5zVrmyUfQ7GMPCoTbCp8tHuaKNKOiQPi0fZs5I
         QL6A==
X-Forwarded-Encrypted: i=1; AJvYcCVX/teDfSH8JdkcVX8F8gs3hez//s4AEsyASxCP0S0nR5bCaLfpKXotmjVVzPkE9VtV4YLVHbkaTdOltuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEL1vJM/ONmdhnlouBKwc4wVRCOvLk6jJvBaQ+yoqqWV/Bw1/
	0CzuGqgNDP3jzpvEHzSCRM613ZfgG9FMTLulUrSuJjcmxwAQmzgy4TBMLUSGmkJ6q83JZ8+2mQV
	/Uhw3O0MfL7aEIXEI1CtBfkaMjhM=
X-Google-Smtp-Source: AGHT+IG0QUD6m+AiJizTzfk7sjDUU6+Uj47dDxnNESvgtQR7HJ29HcD8i2Nk3eMqKuLCMZV3QNCkIKa3wkqzmCrt0SM=
X-Received: by 2002:a17:90b:4b89:b0:2da:61e1:1597 with SMTP id
 98e67ed59e1d1-2dad50f9f56mr12721352a91.36.1725878468069; Mon, 09 Sep 2024
 03:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908135209.15159-1-aha310510@gmail.com> <Zt3yoaLmrII_gypa@V92F7Y9K0C.attlocal.net>
In-Reply-To: <Zt3yoaLmrII_gypa@V92F7Y9K0C.attlocal.net>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 9 Sep 2024 19:40:54 +0900
Message-ID: <CAO9qdTGvKMLLiRcJygGaydj+wimkU8N1W=+6Jd3h8Gn+7UJQOA@mail.gmail.com>
Subject: Re: [PATCH] percpu: fix data race in pcpu_alloc_noprof() and extend
 spinlock protection area
To: Dennis Zhou <dennis@kernel.org>
Cc: tj@kernel.org, cl@linux.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 9=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 3:53, De=
nnis Zhou <dennis@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hello,
>
> On Sun, Sep 08, 2024 at 10:52:10PM +0900, Jeongjun Park wrote:
> > I got the following KCSAN report during syzbot testing:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in pcpu_alloc_noprof / pcpu_free_area
> >
> > read-write to 0xffffffff883f872c of 4 bytes by task 3378 on cpu 0:
> >  pcpu_update_empty_pages mm/percpu.c:602 [inline]
> >  pcpu_block_update_hint_free mm/percpu.c:1044 [inline]
> >  pcpu_free_area+0x4dc/0x570 mm/percpu.c:1302
> >  free_percpu+0x1c6/0xb30 mm/percpu.c:2277
> >  xt_percpu_counter_free+0x63/0x80 net/netfilter/x_tables.c:1951
> >  cleanup_entry+0x195/0x1c0 net/ipv6/netfilter/ip6_tables.c:671
> >  __do_replace+0x470/0x580 net/ipv6/netfilter/ip6_tables.c:1099
> >  do_replace net/ipv6/netfilter/ip6_tables.c:1158 [inline]
> >  do_ip6t_set_ctl+0x820/0x8c0 net/ipv6/netfilter/ip6_tables.c:1644
> >  nf_setsockopt+0x195/0x1b0 net/netfilter/nf_sockopt.c:101
> >  ipv6_setsockopt+0x126/0x140 net/ipv6/ipv6_sockglue.c:998
> >  tcp_setsockopt+0x93/0xb0 net/ipv4/tcp.c:3768
> >  sock_common_setsockopt+0x64/0x80 net/core/sock.c:3735
> >  do_sock_setsockopt net/socket.c:2324 [inline]
> >  __sys_setsockopt+0x1d8/0x250 net/socket.c:2347
> >  __do_sys_setsockopt net/socket.c:2356 [inline]
> >  __se_sys_setsockopt net/socket.c:2353 [inline]
> >  __x64_sys_setsockopt+0x66/0x80 net/socket.c:2353
> >  x64_sys_call+0x278d/0x2d60 arch/x86/include/generated/asm/syscalls_64.=
h:55
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > read to 0xffffffff883f872c of 4 bytes by task 3374 on cpu 1:
> >  pcpu_alloc_noprof+0x9a5/0x10c0 mm/percpu.c:1894
> >  xt_percpu_counter_alloc+0x79/0x110 net/netfilter/x_tables.c:1931
> >  find_check_entry net/ipv4/netfilter/ip_tables.c:526 [inline]
> >  translate_table+0x921/0xf70 net/ipv4/netfilter/ip_tables.c:716
> >  do_replace net/ipv4/netfilter/ip_tables.c:1137 [inline]
> >  do_ipt_set_ctl+0x7bd/0x8b0 net/ipv4/netfilter/ip_tables.c:1635
> >  nf_setsockopt+0x195/0x1b0 net/netfilter/nf_sockopt.c:101
> >  ip_setsockopt+0xea/0x100 net/ipv4/ip_sockglue.c:1424
> >  tcp_setsockopt+0x93/0xb0 net/ipv4/tcp.c:3768
> >  sock_common_setsockopt+0x64/0x80 net/core/sock.c:3735
> >  do_sock_setsockopt net/socket.c:2324 [inline]
> >  __sys_setsockopt+0x1d8/0x250 net/socket.c:2347
> >  __do_sys_setsockopt net/socket.c:2356 [inline]
> >  __se_sys_setsockopt net/socket.c:2353 [inline]
> >  __x64_sys_setsockopt+0x66/0x80 net/socket.c:2353
> >  x64_sys_call+0x278d/0x2d60 arch/x86/include/generated/asm/syscalls_64.=
h:55
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > value changed: 0x00000005 -> 0x00000006
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 UID: 0 PID: 3374 Comm: syz-executor.3 Not tainted 6.11.0-rc6-syz=
kaller-00326-gd1f2d51b711a-dirty #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/06/2024
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The global variable pcpu_nr_empty_pop_pages can be protected by pcpu_lo=
ck,
> > but since pcpu_alloc_noprof reads outside the spinlock protection secti=
on,
> > a data race may occur and the branch of the conditional statement may c=
hange.
> > Therefore, the reading of pcpu_nr_empty_pop_pages should be modified to=
 be
> > performed within the spinlock protection section.
> >
> > However, the for_each_clear_bitrange_from loop requires and uses a spin=
lock,
> > but it repeatedly locks and unlocks the spinlock unnecessarily.
> >
> > Therefore, I think it is appropriate to remove the repeated spin_lock a=
nd
> > spin_unlock in for_each_clear_bitrange_from and perform the operation o=
f
> > reading pcpu_nr_empty_pop_pages and then perform spin_unlock to postpon=
e
> > the point in time when the spin_unlock is performed.
> >
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Fixes: e04d320838f5 ("percpu: indent the population block in pcpu_alloc=
()")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  mm/percpu.c |  5 ++---
> >  1 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 20d91af8c033..5c958a54da51 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1864,7 +1864,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, siz=
e_t align, bool reserved,
> >
> >  area_found:
> >       pcpu_stats_area_alloc(chunk, size);
> > -     spin_unlock_irqrestore(&pcpu_lock, flags);
> >
> >       /* populate if not all pages are already there */
> >       if (!is_atomic) {
> > @@ -1878,14 +1877,12 @@ void __percpu *pcpu_alloc_noprof(size_t size, s=
ize_t align, bool reserved,
> >
> >                       ret =3D pcpu_populate_chunk(chunk, rs, re, pcpu_g=
fp);
> >
> > -                     spin_lock_irqsave(&pcpu_lock, flags);
> >                       if (ret) {
> >                               pcpu_free_area(chunk, off);
> >                               err =3D "failed to populate";
> >                               goto fail_unlock;
> >                       }
> >                       pcpu_chunk_populated(chunk, rs, re);
> > -                     spin_unlock_irqrestore(&pcpu_lock, flags);
> >               }
>
> We don't want to do this because pcpu_populate_chunk() calls
> alloc_pages_node() which can block.
> >
> >               mutex_unlock(&pcpu_alloc_mutex);
> > @@ -1894,6 +1891,8 @@ void __percpu *pcpu_alloc_noprof(size_t size, siz=
e_t align, bool reserved,
> >       if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> >               pcpu_schedule_balance_work();
> >
> > +     spin_unlock_irqrestore(&pcpu_lock, flags);
> > +
> >       /* clear the areas and return address relative to base address */
> >       for_each_possible_cpu(cpu)
> >               memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, s=
ize);
> > --
>
> I sent out [1] which is a more appropriate fix. I'll merge it later
> today.
>
> Thanks,
> Dennis
>
> [1] https://lore.kernel.org/lkml/20240906031151.80719-1-dennis@kernel.org=
/
>

Oh, you already patched that bug a few days ago.
Sorry for taking up your time.

Regards,
Jeongjun Park

