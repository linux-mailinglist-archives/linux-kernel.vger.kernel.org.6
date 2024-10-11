Return-Path: <linux-kernel+bounces-360810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC711999FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF7FB23CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF7E210C1C;
	Fri, 11 Oct 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTgrPyss"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0620CCF0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638338; cv=none; b=On/rVj5q6SEdtozhD1YR9so6+NP9z3P8aRsQ9IUTrHc41XKH5i2UmW0t+7CCFKIuh1wEZioy3c0sw6fyPy3ea3T9FP7OeCfesOb0NqZhmePQOWiQwpQDNaFitCpj5lhLE42Oej2uqs/SbL23PUJ6C/kc/f5diFArLOd28YHevSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638338; c=relaxed/simple;
	bh=Hf2BEb+aTnWrhzS7AV21jvEt3Y+M8Q+yzuyPe3gL0/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEATOSBq3FXrgohQfFL4qsuEGJZX73buKkNi3vKjllSXv6MQ49tZkxBzwI7v0x8u1oQXecmsUkYvYf61tDmCkrVi6FY60wF2gG6AcmpsW+xRk8pwwR2jBkIM8jc60qD2gn/0TDbvxWebYEU9aApqM9KKqjr67CIXIrjcyLvW0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTgrPyss; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2facf48157dso20142851fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728638334; x=1729243134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0nrUr+aiNj2OQCZ7zRWQKQm3B92jXyHTBnxg12YOzg=;
        b=cTgrPyss9Cw4OtwqUBPTHjaaUd/oncBnzsjJB6OS9iU8WfxxsRSJ9wAv5gJ7vuifNo
         vfaRxxuai9kyubSTpPl7PQtU/Jw/k6pcrqaH6VZQuwcND25A1/Avqo6IV0h7PxliL+eP
         nJC+fJVxufFjQcjC+jj5tsFkIGz2g0JFwlnMDBP53BF5+mzAjOjOnzpFjbUWi9ZtfQ+l
         Hv+qUGIPMFiABOpfRKZAQrDu5aVf0rLHVCOsrWjObKrdkx0r5475pWcqkEFoL9epS8if
         znKZOwsXXlM+KiIrKdYUTtnTl+4/euTyJUtQv/3lnX9lmiD0yarjA2QV1yDeAPZ4ZXIU
         s9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728638334; x=1729243134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0nrUr+aiNj2OQCZ7zRWQKQm3B92jXyHTBnxg12YOzg=;
        b=XjZqaVwpPrgabjtoGPcda7SMnFgVdgqQqjo56Lk6EAfXzW68gpKY94VDbwt+Z8zv8M
         ShzHZ05YfUWrmKBM3M24QeSiD8ny0pdu1/1IY/WzAqLvuI3lG7633JiB1PFARxVSJKpQ
         TtmB3/sM+DXXe0HtRg/0cBhR9lT+K00S1ZrtE1oTG3sCg/0bFjJFxXjVTfbYFFnXEzQa
         hryFs0oImZ28VmtGYRFK8w3jPvFqhi6SkTlPI5i2crlqfmACAwZ+C0gD6u1AV6+SAQzA
         /4v8IayVd3x4Xx0GY3/TZVjiS8oFreFltfzb/CVjxgrbWr3CBiehvCp6OvjjqjgxIIrE
         QKPg==
X-Forwarded-Encrypted: i=1; AJvYcCVC/RFuNOfoDqz1sahvGIhWO3UoHVYb3eOkA6lA9UR2cwkS4h+1tmpZE8Nmgx+Dxi+Roxf8TnCCX25aRV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygx92OFyH8aDIf8T6UqeXJJPX2b4qdvpmQu2eikOKXoFFQxyMe
	0JbtnDIGuKNLPpYr2hoFFFtX4r0SmzilzzMDTv5FL1GQjimzv2o3groVi+oGma5geTPsepGr/ko
	zu4TyKhUvoNKHChl8hkr7QzplhU0=
X-Google-Smtp-Source: AGHT+IGmEQeczSX76ZiirfkBiuNPHVeK8l6y0WDNdTZShHIezN2dyb5SHrpNBcGIypKWlyLCAuPGUEaitHaAvaT0j6o=
X-Received: by 2002:a2e:bea3:0:b0:2ef:c281:54f7 with SMTP id
 38308e7fff4ca-2fb329ebb60mr9170951fa.37.1728638334213; Fri, 11 Oct 2024
 02:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007070623.23340-1-aha310510@gmail.com>
In-Reply-To: <20241007070623.23340-1-aha310510@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 11 Oct 2024 17:18:37 +0800
Message-ID: <CAMgjq7BdaUe6YweW03MHEOmunXm7tJz=nMOCWTvq_jDoVGAL+Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: swap: prevent possible data-race in __try_to_reclaim_swap
To: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:06=E2=80=AFPM Jeongjun Park <aha310510@gmail.com> =
wrote:
>
> A report [1] was uploaded from syzbot.
>
> In the previous commit 862590ac3708 ("mm: swap: allow cache reclaim to sk=
ip
> slot cache"), the __try_to_reclaim_swap() function reads offset and folio=
->entry
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
> Therefore, I think it is appropriate to change read operations for
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
>  mm/swapfile.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0cded32414a1..eb782fcd5627 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -194,9 +194,6 @@ static int __try_to_reclaim_swap(struct swap_info_str=
uct *si,
>         if (IS_ERR(folio))
>                 return 0;
>
> -       /* offset could point to the middle of a large folio */
> -       entry =3D folio->swap;
> -       offset =3D swp_offset(entry);
>         nr_pages =3D folio_nr_pages(folio);
>         ret =3D -nr_pages;
>
> @@ -210,6 +207,10 @@ static int __try_to_reclaim_swap(struct swap_info_st=
ruct *si,
>         if (!folio_trylock(folio))
>                 goto out;
>
> +       /* offset could point to the middle of a large folio */
> +       entry =3D folio->swap;
> +       offset =3D swp_offset(entry);
> +
>         need_reclaim =3D ((flags & TTRS_ANYWAY) ||
>                         ((flags & TTRS_UNMAPPED) && !folio_mapped(folio))=
 ||
>                         ((flags & TTRS_FULL) && mem_cgroup_swap_full(foli=
o)));
> --

Reviewed-by: Kairui Song <kasong@tencent.com>

Hi Andrew,

Will this be added to stable and 6.12? 862590ac3708 is already in 6.12
and this fixes a potential issue of it.

