Return-Path: <linux-kernel+bounces-352586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3874A992113
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB0C281C44
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F39F189F3E;
	Sun,  6 Oct 2024 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoUxOK/S"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F02EAD8
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728245757; cv=none; b=PHcSlUQPVCGzG6GJeI2Bv2NmG4qJX8m6yE17bAnXvpFDslP6yLxEg+9OBmsWrc4RVlbMVNHlthZZNV51Yv3hp/YY9CPu9rzQfnWgn7qU/0xYMLL623pWV59lxFpTdMc43EMgAN8kdqZgfpqFibfByekQ4RRQwWdy2PEH46Hvkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728245757; c=relaxed/simple;
	bh=y1njcVstQVycFLxlcxV4jBl7XZdPqA6YNAwugnvp1U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEMFTfGIPCF5CfnV2dvYJPqepIaatbrnUe8XapdBbNdwotdPbUXgZQL93r4lKGVc+3Yk+L5Oq/NfE+UHLCp/HykrQoI75EMZd7Iwq9oLMzBvbPl5ZttZqg5MtACVNGvuMBL29UPT2+ydKFEZKKQOn7+OYDMV08w5F3YGCdQ6578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoUxOK/S; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2facf48166bso42508451fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728245754; x=1728850554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ41D6YpHw3mMfa3ZeJYQeO4Vo/r+hrFXgDDtjGd1J4=;
        b=SoUxOK/StJvyXBrLTOgAXTqhqB6V+/8/s4WICxSO71AGAcCbmtN70V5H8mNIh/ahUN
         k9vf3ulwBshP+6YNiwNhiosMQHYYFF12gkP+SJClCdNoko+8Fq2s7vSmkBf3abQ7gPeo
         rDJWm6mrWB5yjA31qrUpay1jEKM86cF6lGs1j31xP/viYT5JN4dsNGF4KcPWp5SHcXxn
         nYiE2J1nKePf6CBK7f5hhe/ZmxKW+e5JxYuB01NI2nYy1OBUTTzeocTQB/7PATFasUPs
         hNhRx2LdfbZcKWnkhjQfp7EUve3gaaDTywF8f8FI5tWR7Nl987igNr7wYoUR8Kjti16m
         gCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728245754; x=1728850554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ41D6YpHw3mMfa3ZeJYQeO4Vo/r+hrFXgDDtjGd1J4=;
        b=j0OlHeS6cGaZq1IvIn7Y/YPaUl6cI+P0aE4o/7K4PrChn0ppbvDK2szYbdQRuzD4bh
         Xq5OhDyv809cA0Ya2cZdzIjJgj8vh34l49LIpSizVDCKVyEctsChytQiLa9jOeVqVYYW
         n9WfMBhclJbBujdcmRWWVDXLG42h0BkF4pDvPuWwHyMjIz9bBxwNuEuGL0maZW0S4rvl
         S6LDCIPuPoj4TuljBKpsiTIDTS8bMY6kZ9t4cV9JhGPnU58y3sNNgTPXPg4qop5GQJss
         WXUtj6BaBKMhLh7lQQM1AlICFaULU26Hon7Hc9lhcpAm5Gt9vuUyx+gvHxlrPI8xb+VC
         r8qA==
X-Forwarded-Encrypted: i=1; AJvYcCWYDiBpRgVXrtUZ3PEDNbQgN7U0SHjDz3Z0YTMI0klbZoW2I4ycfHtkRqVJpdhVJ2+MW6TUAYM+zU82Az0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbsypAkjsjkkfjMcHXfJzbcTqcI9mOPtShKYoIj3hz26j3GUjB
	RJCE5UDTLro8c47/yvBdAImTM2ZqiN5RCciYnN/8d0aekhKCODFkpN+gj+DmWQORFm6pc5Xe0/B
	PeNX6twvdlDlwCpMyM4hULg71k7c=
X-Google-Smtp-Source: AGHT+IG9R8rYIz8urcx8DXoB6WpkYs7kTrkH0lAgse4E1WzTnVT5mQBqoMEDNEQWj+dF3rkBsrnefTBwl1ynCBfxAf8=
X-Received: by 2002:a2e:be84:0:b0:2ef:2b38:879c with SMTP id
 38308e7fff4ca-2faf3c0169cmr43054081fa.3.1728245753618; Sun, 06 Oct 2024
 13:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004142504.4379-1-aha310510@gmail.com>
In-Reply-To: <20241004142504.4379-1-aha310510@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 7 Oct 2024 04:15:37 +0800
Message-ID: <CAMgjq7A4O=Yruznhxd+hqBE=XohWwHx=UyJVNPENHA+Mx3kLtQ@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: prevent possible data-race in __try_to_reclaim_swap
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 10:26=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> A report [1] was uploaded from syzbot.
>
> In the previous commit 862590ac3708 ("mm: swap: allow cache reclaim to sk=
ip
> slot cache"), the __try_to_reclaim_swap() function reads offset and nr_pa=
ges
> from folio without folio_lock protection.
>
> In the currently reported KCSAN log, it is assumed that the actual data-r=
ace
> will not occur because the calltrace that does WRITE already obtains the
> folio_lock and then writes.
>
> However, the existing __try_to_reclaim_swap() function was already implem=
ented
> to perform reads under folio_lock protection [1], and there is a risk of =
a
> data-race occurring through a function other than the one shown in the KC=
SAN
> log.
>
> Therefore, I think it is appropriate to change all read operations for
> folio to be performed under folio_lock.
>
> [1]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in __delete_from_swap_cache / __try_to_reclaim_swap
>
> write to 0xffffea0004c90328 of 8 bytes by task 5186 on cpu 0:
>  __delete_from_swap_cache+0x1f0/0x290 mm/swap_state.c:163
>  delete_from_swap_cache+0x72/0xe0 mm/swap_state.c:243
>  folio_free_swap+0x1d8/0x1f0 mm/swapfile.c:1850
>  free_swap_cache mm/swap_state.c:293 [inline]
>  free_pages_and_swap_cache+0x1fc/0x410 mm/swap_state.c:325
>  __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
>  tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
>  tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:373
>  zap_pte_range mm/memory.c:1700 [inline]
>  zap_pmd_range mm/memory.c:1739 [inline]
>  zap_pud_range mm/memory.c:1768 [inline]
>  zap_p4d_range mm/memory.c:1789 [inline]
>  unmap_page_range+0x1f3c/0x22d0 mm/memory.c:1810
>  unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
>  unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
>  exit_mmap+0x18a/0x690 mm/mmap.c:1864
>  __mmput+0x28/0x1b0 kernel/fork.c:1347
>  mmput+0x4c/0x60 kernel/fork.c:1369
>  exit_mm+0xe4/0x190 kernel/exit.c:571
>  do_exit+0x55e/0x17f0 kernel/exit.c:926
>  do_group_exit+0x102/0x150 kernel/exit.c:1088
>  get_signal+0xf2a/0x1070 kernel/signal.c:2917
>  arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffffea0004c90328 of 8 bytes by task 5189 on cpu 1:
>  __try_to_reclaim_swap+0x9d/0x510 mm/swapfile.c:198
>  free_swap_and_cache_nr+0x45d/0x8a0 mm/swapfile.c:1915
>  zap_pte_range mm/memory.c:1656 [inline]
>  zap_pmd_range mm/memory.c:1739 [inline]
>  zap_pud_range mm/memory.c:1768 [inline]
>  zap_p4d_range mm/memory.c:1789 [inline]
>  unmap_page_range+0xcf8/0x22d0 mm/memory.c:1810
>  unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
>  unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
>  exit_mmap+0x18a/0x690 mm/mmap.c:1864
>  __mmput+0x28/0x1b0 kernel/fork.c:1347
>  mmput+0x4c/0x60 kernel/fork.c:1369
>  exit_mm+0xe4/0x190 kernel/exit.c:571
>  do_exit+0x55e/0x17f0 kernel/exit.c:926
>  __do_sys_exit kernel/exit.c:1055 [inline]
>  __se_sys_exit kernel/exit.c:1053 [inline]
>  __x64_sys_exit+0x1f/0x20 kernel/exit.c:1053
>  x64_sys_call+0x2d46/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:=
61
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x0000000000000242 -> 0x0000000000000000
>
> Reported-by: syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
> Fixes: 862590ac3708 ("mm: swap: allow cache reclaim to skip slot cache")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  mm/swapfile.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0cded32414a1..904c21256fc2 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -193,13 +193,6 @@ static int __try_to_reclaim_swap(struct swap_info_st=
ruct *si,
>         folio =3D filemap_get_folio(address_space, swap_cache_index(entry=
));
>         if (IS_ERR(folio))
>                 return 0;
> -
> -       /* offset could point to the middle of a large folio */
> -       entry =3D folio->swap;
> -       offset =3D swp_offset(entry);
> -       nr_pages =3D folio_nr_pages(folio);
> -       ret =3D -nr_pages;
> -
>         /*
>          * When this function is called from scan_swap_map_slots() and it=
's
>          * called by vmscan.c at reclaiming folios. So we hold a folio lo=
ck
> @@ -210,6 +203,12 @@ static int __try_to_reclaim_swap(struct swap_info_st=
ruct *si,
>         if (!folio_trylock(folio))
>                 goto out;
>
> +       /* offset could point to the middle of a large folio */
> +       entry =3D folio->swap;
> +       offset =3D swp_offset(entry);
> +       nr_pages =3D folio_nr_pages(folio);
> +       ret =3D -nr_pages;
> +
>         need_reclaim =3D ((flags & TTRS_ANYWAY) ||
>                         ((flags & TTRS_UNMAPPED) && !folio_mapped(folio))=
 ||
>                         ((flags & TTRS_FULL) && mem_cgroup_swap_full(foli=
o)));
> --
>

Thanks for catching this!

This could lead to real problems, holding reference is not enough for
protecting folio->swap. There are several BUG_ONs later that will be
triggered if it changed.

But you still have to keep `nr_pages ` and `ret` before the
`folio_trylock `, or `ret` will be uninitialized if folio_trylock
fails, this function should always return the page number even if the
try lock failed. And as WIlly said, `folio_nr_pages` doesn't require
folio lock.

