Return-Path: <linux-kernel+bounces-337832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24713984F85
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932511F243EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5DA156CF;
	Wed, 25 Sep 2024 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1B/Bsvw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AE1171C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727224885; cv=none; b=dpkbzCGnA8LXiaIz+J7WSdPGI5Arn4ysTqBhTX7G1SIhbf4DwoRYte9PDuyS6BHTSCfpCK29LR8/sSDlh3ENkn1iCpQaIVe2meS3YwOjGCV5K0sEVDTySYDfWF21C7kQHi7oMrgqw8loiCGZzi0ApPNxeJ9GC+cFHQz1sia5N+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727224885; c=relaxed/simple;
	bh=/h4pPPqGvHA5N9dEvMNvNRbbwPUQEZ7pdzhUAMcxH6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAF+TT5zMJs0ulJdhlbWx7PQHOa4C8GNPmi0yLGvYwhrOa0GZE49N6feqHCn5RVqhulZK3thF2u2mM9v1ifnraoElBQpk0KUYr17PKuumQuf8osdiPfNx1X19XgHztJ7ZsGdOzkJc6caD/37BN91XPKBRWpeMOA/2rOOUFtzk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1B/Bsvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEC5C4CEC7
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727224884;
	bh=/h4pPPqGvHA5N9dEvMNvNRbbwPUQEZ7pdzhUAMcxH6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s1B/Bsvwx2om2RiupaUDqNiezARHgowa2WKHHAI4e9KjzLK5xnBDHkrXSCFVBaEY6
	 zUnkrirWO5qPfEQ3ICNeBeU8ZtHYcyDkJ0ShesU1jjtIw7/KawOJvGtZZaJAi9RvKd
	 xaY5fMju12dfTYrKkjS17OgvbmnFnPA/QzpL2ktlf1me0Qv4PGpIFL5y08U2ZdRpzR
	 xhuuSbx/W63RFsUFvu0HzsBF5xGaT1QDNgsQlnd5b6yT+np32dvdHxe4t5yvKFB3SA
	 UQOyZPZqjHPJ3fZysuSGeVjxrltyHfKLQ3xs19IFP4RsMWDZl2viv98ku9HM7GikHP
	 DorlutDW+h57w==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so94355ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:41:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOSZpW/NHprgGjjKI71s9x6OfIsF26pVZLqLWBi2eaFMjTuZBavGjgrg3qtyogy+xvJ7698T5IG28Xhb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvwrp2IXi45ciX5MrxZa6N8gkAseM5BPRniJzm1Z0/wbYGXyW
	9fyuCNTqNjZjln8E/gzwEebWBDSSHy37mkLHJhvZWDN6SnHQG4pNh3as/W/oIVsoxXYsStYwlwv
	nu2m95qGmLYEKfFH9d3SIG9WySlOZjYhVNdGx
X-Google-Smtp-Source: AGHT+IEHGhTkj9wkQONd9OQ7C64r6bHdc3IZgLyAsi7hSCLL2diWMDBp5LhHzHg3v8yUEn3EW9+hnP7VmHcv7y5Pv20=
X-Received: by 2002:a05:6e02:214e:b0:3a0:9ffd:2b7a with SMTP id
 e9e14a558f8ab-3a270347c6dmr843555ab.9.1727224883804; Tue, 24 Sep 2024
 17:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20240913084506.3606292-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20240913084506.3606292-1-jingxiangzeng.cas@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 24 Sep 2024 17:41:11 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNx4KtwWvy2F=rx5kcnqNrNDZvCJGuxWWFUXRe23e9aiA@mail.gmail.com>
Message-ID: <CAF8kJuNx4KtwWvy2F=rx5kcnqNrNDZvCJGuxWWFUXRe23e9aiA@mail.gmail.com>
Subject: Re: [PATCH V2] mm/vmscan: wake up flushers conditionally to avoid
 cgroup OOM
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, tjmercier@google.com, 
	weixugc@google.com, yuzhao@google.com, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jingxiang,

The mm-unstable is breaking my swap stress test again. I am able to
bisect it down to this change

efa7d80846115635db76b4a55b6de97fdb456549 ("mm/vmscan: wake up flushers
conditionally to avoid cgroup OOM").

$ git bisect log
# bad: [acfabf7e197f7a5bedf4749dac1f39551417b049] mm: optimization on
page allocation when CMA enabled
# good: [0885ef4705607936fc36a38fd74356e1c465b023] mm: vmscan.c: fix
OOM on swap stress test
git bisect start 'mm-unstable' 'mm-unstable-good'
# good: [38075679b5f157eeacd46c900e9cfc684bdbc167] mm/mremap: replace
can_modify_mm with can_modify_vma
git bisect good 38075679b5f157eeacd46c900e9cfc684bdbc167
# good: [6050df6d706f58b2240bfabece9f406170104d57] maple_tree: fix
comment typo on ma_flag of allocation tree
git bisect good 6050df6d706f58b2240bfabece9f406170104d57
# good: [ae3c99e650da4a8f4deb3670c29059de375a88be] mm/gup: detect huge
pfnmap entries in gup-fast
git bisect good ae3c99e650da4a8f4deb3670c29059de375a88be
# good: [ed8d5b0ce1d738e13c60d6b1a901a56d832e5070] Revert "uprobes:
use vm_special_mapping close() functionality"
git bisect good ed8d5b0ce1d738e13c60d6b1a901a56d832e5070
# good: [508bae239d4e41a34f88405720837030ea456db1] mm/hugetlb:
simplify refs in memfd_alloc_folio
git bisect good 508bae239d4e41a34f88405720837030ea456db1
# good: [bae3bf040ce9b0def345855fd13025c5a518d897] mm/vmstat: defer
the refresh_zone_stat_thresholds after all CPUs bringup
git bisect good bae3bf040ce9b0def345855fd13025c5a518d897
# good: [d675c821b65f0c496df1d33150619b7635827e89]
mm-memcontrol-add-per-memcg-pgpgin-pswpin-counter-v2
git bisect good d675c821b65f0c496df1d33150619b7635827e89
# bad: [a90a317691612f7681c58756762e895682068abb] mm/hugetlb_cgroup:
introduce peak and rsvd.peak to v2
git bisect bad a90a317691612f7681c58756762e895682068abb
# bad: [efa7d80846115635db76b4a55b6de97fdb456549] mm/vmscan: wake up
flushers conditionally to avoid cgroup OOM
git bisect bad efa7d80846115635db76b4a55b6de97fdb456549
# first bad commit: [efa7d80846115635db76b4a55b6de97fdb456549]
mm/vmscan: wake up flushers conditionally to avoid cgroup OOM

The kernel dmesg:

[   43.929971] zswap: loaded using pool lzo/zsmalloc
[   43.998722] zram0: detected capacity change from 16777216 to 0
[   44.012198] zram: Removed device: zram0
[   44.055409] zram: Added device: zram0
[   44.081232] zram: Added device: zram1
[   44.169864] zram0: detected capacity change from 0 to 6553600
[   44.231357] zram1: detected capacity change from 0 to 40960000
[   44.339063] Adding 3276796k swap on /dev/zram0.  Priority:100
extents:1 across:3276796k SS
[   44.368001] Adding 20479996k swap on /dev/zram1.  Priority:0
extents:1 across:20479996k SS
[   62.722642] ------------[ cut here ]------------
[   62.727234] kernel BUG at fs/buffer.c:95!
[   62.727506] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   62.727850] CPU: 13 UID: 1000 PID: 5617 Comm: cc1 Tainted: G S
           6.11.0-rc6+ #51
[   62.732770] Tainted: [S]=3DCPU_OUT_OF_SPEC
[   62.733001] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
Gen9, BIOS P89 09/21/2023
[   62.733465] RIP: 0010:buffer_check_dirty_writeback+0x51/0x60
[   62.738006] Code: 4c 89 c0 80 22 01 48 8b 08 83 e1 04 74 03 c6 02
01 48 8b 08 83 e1 02 74 03 c6 06 01 48 8b 40 08 4c 3
9 c0 75 e1 c3 cc cc cc cc <0f> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00
90 90 90 90 90 90 90 90
[   62.743232] RSP: 0000:ffff9fa76e6df5f0 EFLAGS: 00010046
[   62.743564] RAX: 0017ffffc8004030 RBX: 0000000000000001 RCX: 00000000000=
0003c
[   62.748182] RDX: ffff9fa76e6df69f RSI: ffff9fa76e6df69e RDI: ffffe921c50=
9cf40
[   62.752778] RBP: 0000000000000000 R08: ffffe921c517f608 R09: 00000000000=
00002
[   62.757558] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[   62.762190] R13: 0000000000000001 R14: ffffe921c509cf48 R15: ffff8cb18f8=
92040
[   62.766841] FS:  00007ff078918ac0(0000) GS:ffff8cd07f280000(0000)
knlGS:0000000000000000
[   62.767399] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.772154] CR2: 00007ff076e7ec54 CR3: 0000002087118004 CR4: 00000000001=
706f0
[   62.776774] Call Trace:
[   62.776976]  <TASK>
[   62.781292]  ? __die_body.cold+0x19/0x27
[   62.781546]  ? die+0x2e/0x50
[   62.785950]  ? do_trap+0xca/0x110
[   62.790393]  ? do_error_trap+0x6a/0x90
[   62.790660]  ? buffer_check_dirty_writeback+0x51/0x60
[   62.790959]  ? exc_invalid_op+0x50/0x70
[   62.791168]  ? buffer_check_dirty_writeback+0x51/0x60
[   62.791469]  ? asm_exc_invalid_op+0x1a/0x20
[   62.791691]  ? buffer_check_dirty_writeback+0x51/0x60
[   62.791982]  isolate_folios+0xa8a/0x14c0
[   62.792234]  evict_folios+0xbe/0x9a0
[   62.792454]  ? __mod_memcg_lruvec_state+0xd8/0x1d0
[   62.796999]  try_to_shrink_lruvec+0x2a8/0x3e0
[   62.801713]  ? __pfx_lru_activate+0x10/0x10
[   62.801957]  ? folio_batch_move_lru+0xe8/0x130
[   62.806410]  shrink_lruvec+0x122/0x12f0
[   62.806648]  ? list_lru_count_one+0x50/0x90
[   62.806897]  ? super_cache_count+0x75/0xf0
[   62.807190]  shrink_node+0x2d1/0xc80
[   62.807418]  ? post_alloc_hook+0xb0/0x130
[   62.807675]  ? get_page_from_freelist+0x3a6/0x1b80
[   62.812392]  do_try_to_free_pages+0xb3/0x5b0
[   62.816910]  try_to_free_mem_cgroup_pages+0x102/0x240
[   62.817299]  try_charge_memcg+0x1be/0x630
[   62.817528]  mem_cgroup_swapin_charge_folio+0x7a/0x170
[   62.817827]  do_swap_page+0xf8b/0x1720
[   62.818048]  ? set_ptes.isra.0+0x41/0x90
[   62.818296]  ? do_anonymous_page+0xfc/0x8e0
[   62.819135]  ? __pte_offset_map+0x1b/0x180
[   62.820017]  __handle_mm_fault+0x82e/0xfb0
[   62.820884]  handle_mm_fault+0xe2/0x2c0
[   62.821738]  do_user_addr_fault+0x2ca/0x7b0
[   62.822588]  exc_page_fault+0x7e/0x180
[   62.823427]  asm_exc_page_fault+0x26/0x30
[   62.824252] RIP: 0033:0x1406d76
[   62.829250] Code: 01 41 8d 4b ff 41 89 cc 45 21 ec 44 89 e0 49 8b
1c c2 48 85 db 0f 84 79 01 00 00 48 83 fb ff 0f 84 0
9 04 00 00 44 89 5c 24 08 <44> 39 6b 0c 0f 84 f0 00 00 00 45 89 ef 41
c1 e7 04 45 01 ef 41 21
[   62.835669] RSP: 002b:00007ffffb6a0730 EFLAGS: 00010213
[   62.836567] RAX: 000000000000153a RBX: 00007ff076e7ec48 RCX: 00000000000=
0ffff
[   62.841859] RDX: 000000000000000c RSI: 000000001ffd7c35 RDI: 000000001fd=
f30f0
[   62.847171] RBP: 000000001fdf30f0 R08: 0000000000000001 R09: 000000001ff=
d7c35
[   62.852424] R10: 00007ff076b7f010 R11: 0000000000010000 R12: 00000000000=
0153a
[   62.857655] R13: 0000000054d9153a R14: 000000000000000c R15: 000000001fd=
ee620
[   62.862887]  </TASK>
[   62.863653] Modules linked in:
[   62.868655] ---[ end trace 0000000000000000 ]---
[   62.880764] pstore: backend (erst) writing error (-28)
[   62.881675] RIP: 0010:buffer_check_dirty_writeback+0x51/0x60
[   62.886849] Code: 4c 89 c0 80 22 01 48 8b 08 83 e1 04 74 03 c6 02
01 48 8b 08 83 e1 02 74 03 c6 06 01 48 8b 40 08 4c 3
9 c0 75 e1 c3 cc cc cc cc <0f> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00
90 90 90 90 90 90 90 90
[   62.893380] RSP: 0000:ffff9fa76e6df5f0 EFLAGS: 00010046
[   62.894350] RAX: 0017ffffc8004030 RBX: 0000000000000001 RCX: 00000000000=
0003c
[   62.899583] RDX: ffff9fa76e6df69f RSI: ffff9fa76e6df69e RDI: ffffe921c50=
9cf40
[   62.904867] RBP: 0000000000000000 R08: ffffe921c517f608 R09: 00000000000=
00002
[   62.910095] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[   62.915340] R13: 0000000000000001 R14: ffffe921c509cf48 R15: ffff8cb18f8=
92040
[   62.920592] FS:  00007ff078918ac0(0000) GS:ffff8cd07f280000(0000)
knlGS:0000000000000000
[   62.921651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.926840] CR2: 00007ff076e7ec54 CR3: 0000002087118004 CR4: 00000000001=
706f0
[   62.932098] note: cc1[5617] exited with irqs disabled
[   62.933045] note: cc1[5617] exited with preempt_count 1
[   62.934010] ------------[ cut here ]------------
[   62.939102] WARNING: CPU: 13 PID: 5617 at kernel/exit.c:886
do_exit+0x8b1/0xab0
[   62.944305] Modules linked in:
[   62.949282] CPU: 13 UID: 1000 PID: 5617 Comm: cc1 Tainted: G S    D
           6.11.0-rc6+ #51
[   62.954634] Tainted: [S]=3DCPU_OUT_OF_SPEC, [D]=3DDIE
[   62.959761] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
Gen9, BIOS P89 09/21/2023
[   62.960841] RIP: 0010:do_exit+0x8b1/0xab0
[   62.961690] Code: f6 e8 a3 e2 ff ff e9 9b fd ff ff 4c 89 e6 bf 05
06 00 00 e8 a1 19 01 00 e9 69 f8 ff ff 48 89 df e8 5
4 ac 13 00 e9 55 f9 ff ff <0f> 0b e9 c3 f7 ff ff 0f 0b e9 80 f7 ff ff
4c 89 e6 48 89 df e8 76
[   62.968265] RSP: 0000:ffff9fa76e6dfed8 EFLAGS: 00010286
[   62.969296] RAX: 0000000400000000 RBX: ffff8cb18a95a8c0 RCX: 00000000000=
00000
[   62.974605] RDX: 0000000000000001 RSI: 0000000000002710 RDI: ffff8cb1901=
5b9c0
[   62.979927] RBP: ffff8cb18e5cba80 R08: 0000000000000000 R09: 00000000000=
00008
[   62.985270] R10: ffff8cd106481000 R11: ffff9fa74f1dd840 R12: 00000000000=
0000b
[   62.990621] R13: ffff8cb19015b9c0 R14: ffff9fa76e6df548 R15: ffffffffa95=
c2121
[   62.995941] FS:  00007ff078918ac0(0000) GS:ffff8cd07f280000(0000)
knlGS:0000000000000000
[   62.997154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.002432] CR2: 00007ff076e7ec54 CR3: 0000002087118004 CR4: 00000000001=
706f0
[   63.007760] Call Trace:
[   63.008607]  <TASK>
[   63.013649]  ? do_exit+0x8b1/0xab0
[   63.018759]  ? __warn.cold+0x8e/0xe8
[   63.019709]  ? do_exit+0x8b1/0xab0
[   63.024862]  ? report_bug+0xff/0x140
[   63.025803]  ? handle_bug+0x3c/0x80
[   63.030906]  ? exc_invalid_op+0x17/0x70
[   63.031879]  ? asm_exc_invalid_op+0x1a/0x20
[   63.032808]  ? buffer_check_dirty_writeback+0x51/0x60
[   63.033809]  ? do_exit+0x8b1/0xab0
[   63.038939]  ? do_exit+0x6d/0xab0
[   63.044028]  ? buffer_check_dirty_writeback+0x51/0x60
[   63.045029]  make_task_dead+0x90/0x90
[   63.046003]  rewind_stack_and_make_dead+0x16/0x20
[   63.051229] RIP: 0033:0x1406d76
[   63.056352] Code: 01 41 8d 4b ff 41 89 cc 45 21 ec 44 89 e0 49 8b
1c c2 48 85 db 0f 84 79 01 00 00 48 83 fb ff 0f 84 0
9 04 00 00 44 89 5c 24 08 <44> 39 6b 0c 0f 84 f0 00 00 00 45 89 ef 41
c1 e7 04 45 01 ef 41 21
[   63.063029] RSP: 002b:00007ffffb6a0730 EFLAGS: 00010213
[   63.064123] RAX: 000000000000153a RBX: 00007ff076e7ec48 RCX: 00000000000=
0ffff
[   63.069494] RDX: 000000000000000c RSI: 000000001ffd7c35 RDI: 000000001fd=
f30f0
[   63.074950] RBP: 000000001fdf30f0 R08: 0000000000000001 R09: 000000001ff=
d7c35
[   63.080336] R10: 00007ff076b7f010 R11: 0000000000010000 R12: 00000000000=
0153a
[   63.085714] R13: 0000000054d9153a R14: 000000000000000c R15: 000000001fd=
ee620
[   63.091358]  </TASK>
[   63.092278] ---[ end trace 0000000000000000 ]---
[   63.125554] Oops: general protection fault, probably for
non-canonical address 0x17ffffc0000008: 0000 [#2] PREEMPT SMP
 PTI
[   63.165649] CPU: 11 UID: 1000 PID: 5617 Comm: cc1 Tainted: G S    D
W          6.11.0-rc6+ #51
[   63.189553] Tainted: [S]=3DCPU_OUT_OF_SPEC, [D]=3DDIE, [W]=3DWARN
[   63.190579] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
Gen9, BIOS P89 09/21/2023
[   63.191724] RIP: 0010:__list_del_entry_valid_or_report+0x4f/0x80
[   63.197029] Code: ad de 48 39 c2 0f 84 2c 3e 9a 00 48 b8 22 01 00
00 00 00 ad de 48 39 c1 0f 84 05 3e 9a 00 48 8b 31 4
8 39 fe 0f 85 e5 3d 9a 00 <48> 8b 42 08 48 39 c6 0f 85 c4 3d 9a 00 b8
01 00 00 00 c3 cc cc cc
[   63.203751] RSP: 0018:ffff9fa76e6dfbb8 EFLAGS: 00010246
[   63.204810] RAX: dead000000000122 RBX: ffff9fa76e6dfbc8 RCX: ffff9fa76e6=
dfbc8
[   63.210158] RDX: 0017ffffc0000000 RSI: ffffe921c5042e40 RDI: ffffe921c50=
42e40
[   63.215545] RBP: 0000000000000001 R08: ffff8cb191d064c8 R09: 00000000804=
0003f
[   63.220934] R10: 000000008040003f R11: 0000000000000001 R12: dead0000000=
00122
[   63.226294] R13: dead000000000100 R14: ffff9fa76e6df988 R15: ffffe921c50=
42e40

Some notes on my bisecting process. I need to revert
684826f8271ad97580b138b9ffd462005e470b99 ("zram: free secondary
algorithms names")
during the bisect. That commit can cause my swap stress test to fail,
oom killed but there are no other kernel panics.

With 684826f8271ad97580b138b9ffd462005e470b99 reverted, the previous
commit d675c821b65f0c496df1d33150619b7635827e89 can pass the swap
stress test.

Chris



On Fri, Sep 13, 2024 at 1:45=E2=80=AFAM Jingxiang Zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> From: Zeng Jingxiang <linuszeng@tencent.com>
>
> Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> removed the opportunity to wake up flushers during the MGLRU page
> reclamation process can lead to an increased likelihood of triggering OOM
> when encountering many dirty pages during reclamation on MGLRU.
>
> This leads to premature OOM if there are too many dirty pages in cgroup:
> Killed
>
> dd invoked oom-killer: gfp_mask=3D0x101cca(GFP_HIGHUSER_MOVABLE|__GFP_WRI=
TE),
> order=3D0, oom_score_adj=3D0
>
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5f/0x80
>   dump_stack+0x14/0x20
>   dump_header+0x46/0x1b0
>   oom_kill_process+0x104/0x220
>   out_of_memory+0x112/0x5a0
>   mem_cgroup_out_of_memory+0x13b/0x150
>   try_charge_memcg+0x44f/0x5c0
>   charge_memcg+0x34/0x50
>   __mem_cgroup_charge+0x31/0x90
>   filemap_add_folio+0x4b/0xf0
>   __filemap_get_folio+0x1a4/0x5b0
>   ? srso_return_thunk+0x5/0x5f
>   ? __block_commit_write+0x82/0xb0
>   ext4_da_write_begin+0xe5/0x270
>   generic_perform_write+0x134/0x2b0
>   ext4_buffered_write_iter+0x57/0xd0
>   ext4_file_write_iter+0x76/0x7d0
>   ? selinux_file_permission+0x119/0x150
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   vfs_write+0x30c/0x440
>   ksys_write+0x65/0xe0
>   __x64_sys_write+0x1e/0x30
>   x64_sys_call+0x11c2/0x1d50
>   do_syscall_64+0x47/0x110
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>  memory: usage 308224kB, limit 308224kB, failcnt 2589
>  swap: usage 0kB, limit 9007199254740988kB, failcnt 0
>
>   ...
>   file_dirty 303247360
>   file_writeback 0
>   ...
>
> oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpuset=3Dtest,
> mems_allowed=3D0,oom_memcg=3D/test,task_memcg=3D/test,task=3Ddd,pid=3D440=
4,uid=3D0
> Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512kB,
> anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
> oom_score_adj:0
>
> The flusher wake up was removed to decrease SSD wearing, but if we are
> seeing all dirty folios at the tail of an LRU, not waking up the flusher
> could lead to thrashing easily. So wake it up when a mem cgroups is
> about to OOM due to dirty caches.
>
> Link: https://lkml.kernel.org/r/20240829102543.189453-1-jingxiangzeng.cas=
@gmail.com
> Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: T.J. Mercier <tjmercier@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmscan.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749cdc110c74..ce471d686a88 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4284,6 +4284,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>                        int tier_idx)
>  {
>         bool success;
> +       bool dirty, writeback;
>         int gen =3D folio_lru_gen(folio);
>         int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
> @@ -4332,6 +4333,9 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         /* waiting for writeback */
>         if (folio_test_locked(folio) || folio_test_writeback(folio) ||
>             (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> +               folio_check_dirty_writeback(folio, &dirty, &writeback);
> +               if (dirty && !writeback)
> +                       sc->nr.unqueued_dirty +=3D delta;
>                 gen =3D folio_inc_gen(lruvec, folio, true);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;
> @@ -4448,6 +4452,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>                                 scanned, skipped, isolated,
>                                 type ? LRU_INACTIVE_FILE : LRU_INACTIVE_A=
NON);
>
> +       sc->nr.taken +=3D isolated;
>         /*
>          * There might not be eligible folios due to reclaim_idx. Check t=
he
>          * remaining to prevent livelock if it's not making progress.
> @@ -4920,6 +4925,14 @@ static void lru_gen_shrink_lruvec(struct lruvec *l=
ruvec, struct scan_control *sc
>         if (try_to_shrink_lruvec(lruvec, sc))
>                 lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
>
> +       /*
> +        * If too many pages failed to evict due to page being dirty,
> +        * memory pressure have pushed dirty pages to oldest gen,
> +        * wake up flusher.
> +        */
> +       if (sc->nr.unqueued_dirty > sc->nr.taken)
> +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> +
>         clear_mm_walk();
>
>         blk_finish_plug(&plug);
> --
> 2.43.5
>
>

