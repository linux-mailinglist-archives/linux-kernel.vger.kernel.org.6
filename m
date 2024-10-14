Return-Path: <linux-kernel+bounces-363093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E185999BDC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CE81C21641
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6E73B1A2;
	Mon, 14 Oct 2024 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZEyVxK+"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2A288DB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872917; cv=none; b=V4sjubdI/eo7tCYLxtOo8frYUnmtumwXyTTbHvjirPL9yCrkB0wzSCyUME+AAdpoFRdha72xbXCeyvs7a+qu6KkVOOYj+LWVVqyiFmCuf3iI7Ka/+2W/Ktzz/6xL644trxbxsa4SmBoMjDwaKv9DBa88hKps2mm3CWzAtpbuUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872917; c=relaxed/simple;
	bh=tlwBh2Z/1brQAzCt4ns0piA9/+qrNxBD2K/8CFQn9M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgMTDJWh1/8SHyxzRthNESuQzbmAyB7A6gOPmrc+VxzHEa18KVSh7JaIdmXbmfugWtJo+jZLrhzabGatPVhq3RfcjPRGMTzxfv3Hnv2PhT5bwCQiSZ1PDSrvBHD8/31P3d2FU2pQzdaI+EVVG2u2hX3NmXOGXNKkAGG8fdqOlKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZEyVxK+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5111747cso3348131fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 19:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728872914; x=1729477714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfmcJnsg9hPSgI4ciMyHW2uknZSwabtGxD0Ci3TDCIM=;
        b=EZEyVxK+yG89zJ43BHzdaPZsWru5LbCYDaoeA3vnxhJev6BOHmK7+Ox+QTtbqjd/4h
         tsJSCKdRstQ2dhJwT7vtBSpGvynskrDcnAfXtNWWCS9gWHk/9tLpv557vtrz9lOMmiQg
         fdhZFjPBD35QGgdbiv9YbQ/uYvvfGRL4k37z/zxbmg6nCt6SzPvHxXVwGjK972ApsmUD
         C+jLtxaL0ZsjAfRVuHDIVOOEtl7v4gVBTyEsw55ZGekz4E62DrLx/EJlm9SD1r4ClG44
         /46kqjo+9aqiJ3E37x8oHUeYaSVHzqGUZlwzUpMLhPhAT4c0K75EolMrVx8RdqPNJSBF
         x00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728872914; x=1729477714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfmcJnsg9hPSgI4ciMyHW2uknZSwabtGxD0Ci3TDCIM=;
        b=NrRy9uwKq/CWQK830c0hB6Ead4gkAQ4NgAjjJ1ZUNB7QgZBVGMl06H2HeCCMC/2hLw
         MVw4pR6QTidYuL19PTQ0dgeEu0udeuAHYHtIOl+fk+w5WN4nEksigAOGBMVcYs6pvtHx
         uBfq1FoksX4wVsLclicHDpSEg/9/Bb3a6uUF13+OC778Op46oIozG9rc56xpoioPD2CX
         mUYMRMgKCkPZnvyvyPzig9MAlPmt10GTDAOp2ECfZrSnRhNdfI1LHBF7aWR6Fmhl4OFU
         us7BtmA+N0TzFJer0EtdSdhRBtdAjDxh6ySJ0CPIT3JQC7J8goIDSgSOAquxtsw36f/F
         zYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXlZvbAAsw5szNOHjHdq5jxdpQSfijKJwcLVhF7LZK4g2w1TI9tpj/4zdlRgv4gF0FoNCFhX+0vEUJTpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUFkAOUOL4pOu8Pv3J5uiFTOvTAqRmdsYA5xmN6kvUWwdTWo/
	By1eUMmOhF1kUesWia0pTZi5FzLQJ3TzXx9XUDfAjlopwOND2Szs63K+efVrMloG+TTmir5FI07
	Slpk/SFy6OKtpzmGY5jE1x4Bkhe8=
X-Google-Smtp-Source: AGHT+IHdK5gACj8fFgR2azBikKqVFWqp+99/BKao1nw8XxstHHQnUNZkLUJ31fKhz6PfYzNyZp/rh8BEm6YYD3UBC0w=
X-Received: by 2002:a2e:4a01:0:b0:2fb:4bee:47ec with SMTP id
 38308e7fff4ca-2fb4bee4870mr6767741fa.33.1728872913443; Sun, 13 Oct 2024
 19:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgjq7BdaUe6YweW03MHEOmunXm7tJz=nMOCWTvq_jDoVGAL+Q@mail.gmail.com>
 <EF64B02C-05B4-4E51-91E1-9C3CD6FDF220@gmail.com>
In-Reply-To: <EF64B02C-05B4-4E51-91E1-9C3CD6FDF220@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 14 Oct 2024 10:28:16 +0800
Message-ID: <CAMgjq7Ah6PjeQuR3PRyRgCpH1ybj=76cmpMfvV50D1prjZpH+w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: swap: prevent possible data-race in __try_to_reclaim_swap
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:17=E2=80=AFAM Jeongjun Park <aha310510@gmail.com=
> wrote:
> > Kairui Song <ryncsn@gmail.com> wrote:
> >
> > =EF=BB=BFOn Mon, Oct 7, 2024 at 3:06=E2=80=AFPM Jeongjun Park <aha31051=
0@gmail.com> wrote:
> >>
> >> A report [1] was uploaded from syzbot.
> >>
> >> In the previous commit 862590ac3708 ("mm: swap: allow cache reclaim to=
 skip
> >> slot cache"), the __try_to_reclaim_swap() function reads offset and fo=
lio->entry
> >> from folio without folio_lock protection.
> >>
> >> In the currently reported KCSAN log, it is assumed that the actual dat=
a-race
> >> will not occur because the calltrace that does WRITE already obtains t=
he
> >> folio_lock and then writes.
> >>
> >> However, the existing __try_to_reclaim_swap() function was already imp=
lemented
> >> to perform reads under folio_lock protection [1], and there is a risk =
of a
> >> data-race occurring through a function other than the one shown in the=
 KCSAN
> >> log.
> >>
> >> Therefore, I think it is appropriate to change read operations for
> >> folio to be performed under folio_lock.
> >>
> >> [1]
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> BUG: KCSAN: data-race in __delete_from_swap_cache / __try_to_reclaim_s=
wap
> >>
> >> write to 0xffffea0004c90328 of 8 bytes by task 5186 on cpu 0:
> >> __delete_from_swap_cache+0x1f0/0x290 mm/swap_state.c:163
> >> delete_from_swap_cache+0x72/0xe0 mm/swap_state.c:243
> >> folio_free_swap+0x1d8/0x1f0 mm/swapfile.c:1850
> >> free_swap_cache mm/swap_state.c:293 [inline]
> >> free_pages_and_swap_cache+0x1fc/0x410 mm/swap_state.c:325
> >> __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
> >> tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
> >> tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
> >> tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:373
> >> zap_pte_range mm/memory.c:1700 [inline]
> >> zap_pmd_range mm/memory.c:1739 [inline]
> >> zap_pud_range mm/memory.c:1768 [inline]
> >> zap_p4d_range mm/memory.c:1789 [inline]
> >> unmap_page_range+0x1f3c/0x22d0 mm/memory.c:1810
> >> unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
> >> unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
> >> exit_mmap+0x18a/0x690 mm/mmap.c:1864
> >> __mmput+0x28/0x1b0 kernel/fork.c:1347
> >> mmput+0x4c/0x60 kernel/fork.c:1369
> >> exit_mm+0xe4/0x190 kernel/exit.c:571
> >> do_exit+0x55e/0x17f0 kernel/exit.c:926
> >> do_group_exit+0x102/0x150 kernel/exit.c:1088
> >> get_signal+0xf2a/0x1070 kernel/signal.c:2917
> >> arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
> >> exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
> >> exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >> __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >> syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
> >> do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
> >> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>
> >> read to 0xffffea0004c90328 of 8 bytes by task 5189 on cpu 1:
> >> __try_to_reclaim_swap+0x9d/0x510 mm/swapfile.c:198
> >> free_swap_and_cache_nr+0x45d/0x8a0 mm/swapfile.c:1915
> >> zap_pte_range mm/memory.c:1656 [inline]
> >> zap_pmd_range mm/memory.c:1739 [inline]
> >> zap_pud_range mm/memory.c:1768 [inline]
> >> zap_p4d_range mm/memory.c:1789 [inline]
> >> unmap_page_range+0xcf8/0x22d0 mm/memory.c:1810
> >> unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
> >> unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
> >> exit_mmap+0x18a/0x690 mm/mmap.c:1864
> >> __mmput+0x28/0x1b0 kernel/fork.c:1347
> >> mmput+0x4c/0x60 kernel/fork.c:1369
> >> exit_mm+0xe4/0x190 kernel/exit.c:571
> >> do_exit+0x55e/0x17f0 kernel/exit.c:926
> >> __do_sys_exit kernel/exit.c:1055 [inline]
> >> __se_sys_exit kernel/exit.c:1053 [inline]
> >> __x64_sys_exit+0x1f/0x20 kernel/exit.c:1053
> >> x64_sys_call+0x2d46/0x2d60 arch/x86/include/generated/asm/syscalls_64.=
h:61
> >> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >> do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>
> >> value changed: 0x0000000000000242 -> 0x0000000000000000
> >>
> >> Reported-by: syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
> >> Fixes: 862590ac3708 ("mm: swap: allow cache reclaim to skip slot cache=
")
> >> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> >> ---
> >> mm/swapfile.c | 7 ++++---
> >> 1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index 0cded32414a1..eb782fcd5627 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -194,9 +194,6 @@ static int __try_to_reclaim_swap(struct swap_info_=
struct *si,
> >>        if (IS_ERR(folio))
> >>                return 0;
> >>
> >> -       /* offset could point to the middle of a large folio */
> >> -       entry =3D folio->swap;
> >> -       offset =3D swp_offset(entry);
> >>        nr_pages =3D folio_nr_pages(folio);
> >>        ret =3D -nr_pages;
> >>
> >> @@ -210,6 +207,10 @@ static int __try_to_reclaim_swap(struct swap_info=
_struct *si,
> >>        if (!folio_trylock(folio))
> >>                goto out;
> >>
> >> +       /* offset could point to the middle of a large folio */
> >> +       entry =3D folio->swap;
> >> +       offset =3D swp_offset(entry);
> >> +
> >>        need_reclaim =3D ((flags & TTRS_ANYWAY) ||
> >>                        ((flags & TTRS_UNMAPPED) && !folio_mapped(folio=
)) ||
> >>                        ((flags & TTRS_FULL) && mem_cgroup_swap_full(fo=
lio)));
> >> --
> >
> > Reviewed-by: Kairui Song <kasong@tencent.com>
> >
> > Hi Andrew,
> >
> > Will this be added to stable and 6.12? 862590ac3708 is already in 6.12
> > and this fixes a potential issue of it.
>
> As far as I can see, commit 862590ac3708 was applied starting
> from 6.12-rc1, so it looks like no additional commits are needed
> for the stable version.

Hi, sorry for the confusion, I meant mm-stable, not the stable branch.
It's better to merge this in 6.12.

> Regards,
>
> Jeongjun Park

