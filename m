Return-Path: <linux-kernel+bounces-354232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9006F993A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021111F22236
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161218CC13;
	Mon,  7 Oct 2024 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXEKFhPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E817279E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728340919; cv=none; b=lnsjfwdvXAg/2gPLUpL9FUAt9SU3vau/ZA5R4tTzrZIp8/Ot5QIbWdrROrZl7Q9+WQxJTtSuX383JBD5F8f8a8gqC+xFjLZmw8l29oUZlwxAu4P5J2zAZfMc429uSDe8n1+b93pATfY9r8zhQpn9nzPR3eMvrukXxUXvjgl5ldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728340919; c=relaxed/simple;
	bh=lqN667crBi3O2F9hVlunj0HOZNmZ/QKEjkUVJuSzS1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3cuZB6ZAX//9t53QZ7bxZYZ8Ro8EAWNiAcIiHWg7SFq4vcPkcbigse7y6GVNpLrHQ4t/NsvOhSF8o2xFuUFugfW+BNGVkuxtNKgDWcqE/Lkm134fnVqiux004B8FhCp4UsHk6DwK7vrYPsPkBt3e4S6uqSPN071jYtKCeF0aDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXEKFhPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B94C4CEC6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 22:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728340919;
	bh=lqN667crBi3O2F9hVlunj0HOZNmZ/QKEjkUVJuSzS1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QXEKFhPyXGkn9z4/GU9vnG/cXcOKzvJNZyRAej8gxberZ/ZLTAAAAjgOwlOkzd6qx
	 b4abfmpdvMeEcDo8YIlNrMA5z3eo3MMdqx3EMD8vQkAn5utW5xkWwA3j1f/hx2/W0L
	 NTnO6HMa8lzAGA+E1hjSTXPqrAvqSkhm7sfbNhgz7EBTCuHn5KoP6GjXfUQhB37N0H
	 AV0aUY4ZmqZAlRNB1O1iTCY4Yo5mOtzYzB7BwfVzjrn+MMu7jWpIdEWak/Nd/rvqo6
	 sk+qETB/iVh6WkIR4UOgLghfMVbQpFaQUfKxjeCKhKRZZblwahfCSFQwn3RoRzSMYf
	 JbealkpbTNN3g==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a1a662a633so42415ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 15:41:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTUijau7vIyZcEMALtoHQfXJSGfGXzJQeVjLP5qLi5vqFWEUnxofD14RcJ6MWTIdur2CfI27gM7LsiWC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfPoRY8M/knp4j0tYdZMa3GIk5E6byHCA3mOx6rOpAZyqDYHKG
	JM689bfUcyENDMss796nX5dED2hevTj4Khz3CcM8t8Gyp6yuJ6Qf2eX2Xj1Dua5wBizfk3eEGwG
	TuW8oszJAYGoxaZVJg63ZKX+gbqizB0Nu28in
X-Google-Smtp-Source: AGHT+IEAt2IrkbblTQNkyZXC0RWfgxSh29niwd3tIzyAY29WE2gsH2WVKbyx9rF68YLbqQzkueve+zVzpa17rtuztDk=
X-Received: by 2002:a92:cdac:0:b0:3a0:aa15:3491 with SMTP id
 e9e14a558f8ab-3a38ea193c3mr551555ab.23.1728340918675; Mon, 07 Oct 2024
 15:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007070623.23340-1-aha310510@gmail.com>
In-Reply-To: <20241007070623.23340-1-aha310510@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 7 Oct 2024 15:41:46 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNC3G1nw6Zjey_-mxAh-RKxUd8xf82X=1COpBaNQ-5DgQ@mail.gmail.com>
Message-ID: <CAF8kJuNC3G1nw6Zjey_-mxAh-RKxUd8xf82X=1COpBaNQ-5DgQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: swap: prevent possible data-race in __try_to_reclaim_swap
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, ryncsn@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:06=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
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

Looks good to me, we do need to get the folio->swap after the folio is lock=
ed.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

>         need_reclaim =3D ((flags & TTRS_ANYWAY) ||
>                         ((flags & TTRS_UNMAPPED) && !folio_mapped(folio))=
 ||
>                         ((flags & TTRS_FULL) && mem_cgroup_swap_full(foli=
o)));
> --
>

