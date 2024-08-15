Return-Path: <linux-kernel+bounces-288434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E8953A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24BA1C255F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3669959;
	Thu, 15 Aug 2024 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALq1RqNM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CFB64CEC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746554; cv=none; b=pNcc5sHsRHLYUuezQ+Ati09bf3I5sEt7EV42vLyudWQIBBKcyj1WReL+bKGw9b1Xnk5jEkF6sk6Ud922cA/IEkfI30paI9m7QTSdFkZr+lDVkXGrH4wBnJKK1m6iAkyC69MuSsPKhWdUkDbVvkZzUrvzleVP2PqEsh+Z9eK2gPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746554; c=relaxed/simple;
	bh=h31zZOjFDlK55Fqr0SJYQuM0oWmJH9bcjbwnWnmM13w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeLGNLJsoh9yLkzB3OpBg8LmaqbOJ0j2W7Gk5zmUlocE2sUlkIX47cfWYyv+FA0EmNyN1LS3JarkQXsqh06D287HeupBfxn8hsd5pJyYrEui0UDS3E3xTy9nGscHDPmhYHRu5zREmQhVPFbIVcEzXfkeh6yXjVJC1u+eBOFLbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALq1RqNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A8FC4AF11
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723746554;
	bh=h31zZOjFDlK55Fqr0SJYQuM0oWmJH9bcjbwnWnmM13w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ALq1RqNMn/XMhCL4dce8UuioBNT1CeNsbgNCGPKQqBu+YoTf+kiQ1+9P01R/YMsLU
	 0gOVhz7/39zk1Kj40IXb6AITrARQ7fSUqgki1erJKUZ1kxHmUmGQxvLL/Ls+PBGHqP
	 piZniysUdBQYpYoztCtM8YJb/H+oEwyq/DgshUnePLKi1n5q7kT6qxNl5PrNVppOja
	 s8C0C5uyDE0NSGEE5v6DZvAP9v6ebwzjdbvbBwAQtN/zuWY5zK7tofY/M/FGgBMC1V
	 u3j1w3GZImszHEhHbRgKdsWaAVyk/cw2ku8EUrxD8+W4BdTv4VA584Hm1wXxm0TEtF
	 RDu+I5SXBz0vg==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-651da7c1531so11881017b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:29:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWSdo3621hNnNsCKgiOQA/MhOGJ9b7T4tWyrAiSS6/PZ1RVY8XNQVFHFsIvzri5s93aBoq5xKOGTUpcOZ094isyuBP6jtONCXHfVhD
X-Gm-Message-State: AOJu0YyeMEumBCf/6/R4kZCTXirzC7mfMoxsTOFgXoivlHvhEJF40hrD
	AK5jVRMzApREkMc1seufvmppFZHRF0uQAG7hVys1RSS6D+BuJ74iyAeUq7ViYDk2iC0mD/omh8f
	x2O2IF25xbbOv4bVNjUrWyLiq0EBNCJOg6TxNbQ==
X-Google-Smtp-Source: AGHT+IE9yHMXcrs2p2OFSk4mZ0uKUmCDuQP0kBih3PHrirKmSu4uSNJw5528bUEA6aRcIKVPHAoBbvJnEYRuifUsgSY=
X-Received: by 2002:a05:690c:2c8d:b0:6b0:8f62:bc77 with SMTP id
 00721157ae682-6b1bc5e461bmr4933687b3.41.1723746553605; Thu, 15 Aug 2024
 11:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807215859.57491-1-21cnbao@gmail.com> <20240807215859.57491-3-21cnbao@gmail.com>
In-Reply-To: <20240807215859.57491-3-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 15 Aug 2024 11:29:02 -0700
X-Gmail-Original-Message-ID: <CACePvbUOgPLyCPzQMvH8sNZj_=FayR9Y7A4sGBEyk4ubW1Uo_w@mail.gmail.com>
Message-ID: <CACePvbUOgPLyCPzQMvH8sNZj_=FayR9Y7A4sGBEyk4ubW1Uo_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: attempt to batch free swap entries for zap_pte_range()
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@redhat.com, 
	hughd@google.com, justinjiang@vivo.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com, 
	v-songbaohua@oppo.com, ying.huang@intel.com, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barry,

We got a crash report from syzbot that has been bisect into this change.

Please see the comment below.

------------[ cut here ]------------
 kernel BUG at mm/swap_cgroup.c:141 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5371 Comm: syz.0.15 Not tainted
6.11.0-rc3-next-20240812-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 06/27/2024
 RIP: 0010:swap_cgroup_record+0x2cd/0x2d0 mm/swap_cgroup.c:141
Code: e7 e8 a7 c9 f6 ff e9 64 fe ff ff e8 cd 41 8e ff 48 c7 c7 c0 db
a5 8e 48 89 de e8 2e 8c e8 02 e9 7a fd ff ff e8 b4 41 8e ff 90 <0f> 0b
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f
RSP: 0018:ffffc90003e172f8 EFLAGS: 00010093
RAX: ffffffff82054c9c RBX: 000000000000000b RCX: ffff88802298bc00
RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff82054b43 R09: fffff520007c2e3c
R10: dffffc0000000000 R11: fffff520007c2e3c R12: ffff88801cf0f014
R13: 0000000000000000 R14: 000000000000000a R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9100000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9332107a8c CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  __mem_cgroup_uncharge_swap+0x84/0x2e0 mm/memcontrol.c:5118
  mem_cgroup_uncharge_swap include/linux/swap.h:668 [inline]
  swap_entry_range_free+0x45f/0x1120 mm/swapfile.c:1556
  __swap_entries_free mm/swapfile.c:1518 [inline]
  free_swap_and_cache_nr+0xa65/0xae0 mm/swapfile.c:1876
  zap_pte_range mm/memory.c:1653 [inline]
  zap_pmd_range mm/memory.c:1736 [inline]
  zap_pud_range mm/memory.c:1765 [inline]
  zap_p4d_range mm/memory.c:1786 [inline]
  unmap_page_range+0x1924/0x42c0 mm/memory.c:1807
  unmap_vmas+0x3cc/0x5f0 mm/memory.c:1897
  exit_mmap+0x267/0xc20 mm/mmap.c:1923
  __mmput+0x115/0x390 kernel/fork.c:1347
  exit_mm+0x220/0x310 kernel/exit.c:571
  do_exit+0x9b2/0x28e0 kernel/exit.c:926
  do_group_exit+0x207/0x2c0 kernel/exit.c:1088
  __do_sys_exit_group kernel/exit.c:1099 [inline]
  __se_sys_exit_group kernel/exit.c:1097 [inline]
  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:2=
32
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

On Wed, Aug 7, 2024 at 2:59=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Zhiguo reported that swap release could be a serious bottleneck
> during process exits[1]. With mTHP, we have the opportunity to
> batch free swaps.
> Thanks to the work of Chris and Kairui[2], I was able to achieve
> this optimization with minimal code changes by building on their
> efforts.
> If swap_count is 1, which is likely true as most anon memory are
> private, we can free all contiguous swap slots all together.
>
> Ran the below test program for measuring the bandwidth of munmap
> using zRAM and 64KiB mTHP:
>
>  #include <sys/mman.h>
>  #include <sys/time.h>
>  #include <stdlib.h>
>
>  unsigned long long tv_to_ms(struct timeval tv)
>  {
>         return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>  }
>
>  main()
>  {
>         struct timeval tv_b, tv_e;
>         int i;
>  #define SIZE 1024*1024*1024
>         void *p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         if (!p) {
>                 perror("fail to get memory");
>                 exit(-1);
>         }
>
>         madvise(p, SIZE, MADV_HUGEPAGE);
>         memset(p, 0x11, SIZE); /* write to get mem */
>
>         madvise(p, SIZE, MADV_PAGEOUT);
>
>         gettimeofday(&tv_b, NULL);
>         munmap(p, SIZE);
>         gettimeofday(&tv_e, NULL);
>
>         printf("munmap in bandwidth: %ld bytes/ms\n",
>                         SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
>  }
>
> The result is as below (munmap bandwidth):
>                 mm-unstable  mm-unstable-with-patch
>    round1       21053761      63161283
>    round2       21053761      63161283
>    round3       21053761      63161283
>    round4       20648881      67108864
>    round5       20648881      67108864
>
> munmap bandwidth becomes 3X faster.
>
> [1] https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@viv=
o.com/
> [2] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148=
b9297@kernel.org/
>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/swapfile.c | 76 +++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 11 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 35cb58373493..52e941b6d626 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struc=
t *si,
>         return true;
>  }
>
> +static bool swap_is_last_map(struct swap_info_struct *si,
> +               unsigned long offset, int nr_pages, bool *has_cache)
> +{
> +       unsigned char *map =3D si->swap_map + offset;
> +       unsigned char *map_end =3D map + nr_pages;
> +       unsigned char count =3D *map;
> +
> +       if (swap_count(count) !=3D 1)
> +               return false;
> +
> +       while (++map < map_end) {
> +               if (*map !=3D count)
> +                       return false;
> +       }
> +
> +       *has_cache =3D !!(count & SWAP_HAS_CACHE);
> +       return true;
> +}
> +
>  /*
>   * returns number of pages in the folio that backs the swap entry. If po=
sitive,
>   * the folio was reclaimed. If negative, the folio was not reclaimed. If=
 0, no
> @@ -1469,6 +1488,51 @@ static unsigned char __swap_entry_free(struct swap=
_info_struct *si,
>         return usage;
>  }
>
> +static bool __swap_entries_free(struct swap_info_struct *si,
> +               swp_entry_t entry, int nr)
> +{
> +       unsigned long offset =3D swp_offset(entry);
> +       unsigned int type =3D swp_type(entry);
> +       struct swap_cluster_info *ci;
> +       bool has_cache =3D false;
> +       unsigned char count;
> +       int i;
> +
> +       if (nr <=3D 1 || swap_count(data_race(si->swap_map[offset])) !=3D=
 1)
> +               goto fallback;
> +       /* cross into another cluster */
> +       if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
> +               goto fallback;
> +
> +       ci =3D lock_cluster_or_swap_info(si, offset);
> +       if (!swap_is_last_map(si, offset, nr, &has_cache)) {
> +               unlock_cluster_or_swap_info(si, ci);
> +               goto fallback;
> +       }
> +       for (i =3D 0; i < nr; i++)
> +               WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
> +       unlock_cluster_or_swap_info(si, ci);
> +
> +       if (!has_cache) {
> +               spin_lock(&si->lock);
> +               swap_entry_range_free(si, entry, nr);

Here it calls swap_entry_range_free() to free a range of the swap
entry. However the swap_entry_range_free() has the assumption that all
entries belong to the same folio and charge to the same memcg.
It eventually pass down to swap_cgroup_record(), which BUG on this line:

VM_BUG_ON(sc->id !=3D old);

The root cause is that the swap entries are not from the same memcg.
Thankos Yosry for finding the root cause.

> +               spin_unlock(&si->lock);
> +       }
> +       return has_cache;
> +
> +fallback:
> +       for (i =3D 0; i < nr; i++) {
> +               if (data_race(si->swap_map[offset + i])) {
> +                       count =3D __swap_entry_free(si, swp_entry(type, o=
ffset + i));
> +                       if (count =3D=3D SWAP_HAS_CACHE)
> +                               has_cache =3D true;
> +               } else {
> +                       WARN_ON_ONCE(1);
> +               }
> +       }
> +       return has_cache;
> +}
> +
>  /*
>   * Drop the last HAS_CACHE flag of swap entries, caller have to
>   * ensure all entries belong to the same cgroup.
> @@ -1792,11 +1856,9 @@ void free_swap_and_cache_nr(swp_entry_t entry, int=
 nr)
>  {
>         const unsigned long start_offset =3D swp_offset(entry);
>         const unsigned long end_offset =3D start_offset + nr;
> -       unsigned int type =3D swp_type(entry);
>         struct swap_info_struct *si;
>         bool any_only_cache =3D false;
>         unsigned long offset;
> -       unsigned char count;
>
>         if (non_swap_entry(entry))
>                 return;
> @@ -1811,15 +1873,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int=
 nr)
>         /*
>          * First free all entries in the range.
>          */
> -       for (offset =3D start_offset; offset < end_offset; offset++) {
> -               if (data_race(si->swap_map[offset])) {
> -                       count =3D __swap_entry_free(si, swp_entry(type, o=
ffset));
> -                       if (count =3D=3D SWAP_HAS_CACHE)
> -                               any_only_cache =3D true;
> -               } else {
> -                       WARN_ON_ONCE(1);
> -               }
> -       }
> +       any_only_cache =3D __swap_entries_free(si, entry, nr);

Here we are just doing a page table walk, there is no guarantee the
'nr' number of swap entries came from the same folio and previously
charged to the same memcg. The swap_pte_batch() only checks they are
the same swap type, does not check they charge to the same memcg.

Chris

>
>         /*
>          * Short-circuit the below loop if none of the entries had their
> --
> 2.34.1
>

