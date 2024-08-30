Return-Path: <linux-kernel+bounces-309349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732E196693A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FD72846BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313111BCA03;
	Fri, 30 Aug 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNH1DZq0"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72CC1DA22
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044300; cv=none; b=m/L7i2BzU45A0uZwtX8xcLMmBm10wqhgeBpsOv1Iz4esmRTV0VrkSLnHjIoZbHlj9LSaMpAH9WgpBCxWdMJDinmJz0qaeduAqjTYv+YhpJ4RvwgT0tEWdOSj0bxjXNqmHA96hs3yEIV26870Taojad/sYr4HjuxoVNsI2c4cr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044300; c=relaxed/simple;
	bh=xRoBQ/oq+gT5YpsAkNHTlvl9LLh8kHrX89dUdo46+2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DC/5U1LBWiTp3cEZ1wNiDwoxfMoy1NWczrYbr+wSWy6OyzFzb5L+QeKucOFIUXoQ3JL+SdWuGmSlqxhp83ubPFV2wXxhvvULyVl06DoYPejIFyodoKDaouZYru09o5F3uq+hXwWq7MZhegh7NdBGz3OYL1JkTjvxh3QtsNY9de0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNH1DZq0; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-498d7ab8fefso812717137.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725044297; x=1725649097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZnolaJe4rajFezTVdnx4rNTF9qWiAa95B6Y1PiHIzA=;
        b=CNH1DZq0kjDPRs8fZCsXsKZTsK8BikDe3NfuFvDLtBJ+lFB+B1HHquMmsMumTi2y65
         /H0MZ0qVEM/kT8ak4lLgGZYshjgyutaqttYhA9oRb9mcjgqiyrB92NS7DfwfXD+aqEd3
         iFOpGBpyMRfgS2DS+q0ILs267RjyJ0oD1m3s3Pwsnp8txey2KJoyA8sgv/zWXpf6WLCX
         zd5yIp6ojVD4ItFvobBklmwGek/39J8VBwUOx0aiq1PCQy6j2nTizSPOuxSn8Emwct/m
         P4/H0/jkqDK8ebbWIABGmGoiPWNRyeGKVNOsbCIFEAcuTXY/hUY15Vt9cU01FSqVMOwP
         2Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725044297; x=1725649097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZnolaJe4rajFezTVdnx4rNTF9qWiAa95B6Y1PiHIzA=;
        b=GXmZ9tIeJSbL2jVtoYICi/6gx54JOdvCA7dvgo2Z4IOYUAaCvAvGModFJfXxRwBY3x
         AI4Pcx9YM9GVz6YgAa9G4mUlyGlOl1Ri3Cw2NTfhjUPLMRlGE6JMoZ6eF60sKDJM++Vu
         WEl4WEP8zsiPbd4+Tp9Ah3bbQCAnz/ZGgOOf+sZ5q+xGmn7NfV5sLyJLcRclrJh56HRL
         U7Y2KPzFCjZHGjdbVfliGDpLmvgMl1eSTUtJ5i0jQyOemNzAANQGBVFSAhDbnycym2iQ
         342tneRw9YKKmsyGSWxbkfiIa9oKhqHzur+vLLy5SDr7MEGwlb1L2q0y8w9nhM11wxku
         TfYw==
X-Forwarded-Encrypted: i=1; AJvYcCXdLgu5eMX+quF5U5n4T72187jIpc8leZ78w54huuSWTLnio/it8wC7WcqN81V8cOwl+2K143oKz2W64dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vNCRa2Pqh2ZApScxrPzUtd546jjtPNjt/TmqNLoSWKQNdKe4
	koxnj877wRj6OdXM7cf+xqRHVG6rv4fX2sZ+f4a7jxb9ox6KSwgzgHw8yVkEtTQllYbiIIbAdui
	qSO+Pj/1lNY/bsg/umjnf6d3qE4wO8pA+sIRL
X-Google-Smtp-Source: AGHT+IGVFNnng9wGBLPpCd921vapxG6IB+z9LW8W57dvIrFD/XNsZVHaAdv3h9rBeqTdJxQYrdHGR3zH4uSABjy1MVc=
X-Received: by 2002:a05:6102:370e:b0:493:c3b2:b5ba with SMTP id
 ada2fe7eead31-49a7773522cmr415968137.6.1725044297205; Fri, 30 Aug 2024
 11:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000817cf10620e20d33@google.com>
In-Reply-To: <000000000000817cf10620e20d33@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 30 Aug 2024 12:57:38 -0600
Message-ID: <CAOUHufZ_GFPfq_Nx=4oBWOs+gRDdpe7gdSbdYPNQk+uLx9Nv8g@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] KCSAN: data-race in mem_cgroup_iter / mem_cgroup_iter
To: syzbot <syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 2:05=E2=80=AFAM syzbot
<syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://=
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D107a846398000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fafac02e339c=
c84
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De099d407346c452=
75ce9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4a8763df1c20/dis=
k-20371ba1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f9678a905383/vmlinu=
x-20371ba1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ef6e49adc393/b=
zImage-20371ba1.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e099d407346c45275ce9@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in mem_cgroup_iter / mem_cgroup_iter
>
> read-write to 0xffff888114b82668 of 4 bytes by task 5527 on cpu 1:
>  mem_cgroup_iter+0x28e/0x380 mm/memcontrol.c:1080
>  shrink_node_memcgs mm/vmscan.c:5924 [inline]
>  shrink_node+0x74a/0x1d40 mm/vmscan.c:5948
>  shrink_zones mm/vmscan.c:6192 [inline]
>  do_try_to_free_pages+0x3c6/0xc50 mm/vmscan.c:6254
>  try_to_free_mem_cgroup_pages+0x1f3/0x4f0 mm/vmscan.c:6586
>  try_charge_memcg+0x2bc/0x810 mm/memcontrol.c:2210
>  try_charge mm/memcontrol-v1.h:20 [inline]
>  charge_memcg mm/memcontrol.c:4439 [inline]
>  mem_cgroup_swapin_charge_folio+0x107/0x1a0 mm/memcontrol.c:4524
>  __read_swap_cache_async+0x2b7/0x520 mm/swap_state.c:516
>  swap_cluster_readahead+0x276/0x3f0 mm/swap_state.c:680
>  swapin_readahead+0xe4/0x760 mm/swap_state.c:882
>  do_swap_page+0x3da/0x1ef0 mm/memory.c:4119
>  handle_pte_fault mm/memory.c:5524 [inline]
>  __handle_mm_fault mm/memory.c:5664 [inline]
>  handle_mm_fault+0x8cb/0x2a30 mm/memory.c:5832
>  do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>  exc_page_fault+0x3b9/0x650 arch/x86/mm/fault.c:1539
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>
> read to 0xffff888114b82668 of 4 bytes by task 5528 on cpu 0:
>  mem_cgroup_iter+0xba/0x380 mm/memcontrol.c:1018
>  shrink_node_memcgs mm/vmscan.c:5869 [inline]
>  shrink_node+0x458/0x1d40 mm/vmscan.c:5948
>  shrink_zones mm/vmscan.c:6192 [inline]
>  do_try_to_free_pages+0x3c6/0xc50 mm/vmscan.c:6254
>  try_to_free_mem_cgroup_pages+0x1f3/0x4f0 mm/vmscan.c:6586
>  try_charge_memcg+0x2bc/0x810 mm/memcontrol.c:2210
>  try_charge mm/memcontrol-v1.h:20 [inline]
>  charge_memcg mm/memcontrol.c:4439 [inline]
>  mem_cgroup_swapin_charge_folio+0x107/0x1a0 mm/memcontrol.c:4524
>  __read_swap_cache_async+0x2b7/0x520 mm/swap_state.c:516
>  swap_cluster_readahead+0x276/0x3f0 mm/swap_state.c:680
>  swapin_readahead+0xe4/0x760 mm/swap_state.c:882
>  do_swap_page+0x3da/0x1ef0 mm/memory.c:4119
>  handle_pte_fault mm/memory.c:5524 [inline]
>  __handle_mm_fault mm/memory.c:5664 [inline]
>  handle_mm_fault+0x8cb/0x2a30 mm/memory.c:5832
>  do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>  exc_page_fault+0x296/0x650 arch/x86/mm/fault.c:1539
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>  __get_user_8+0x11/0x20 arch/x86/lib/getuser.S:94
>  fetch_robust_entry kernel/futex/core.c:783 [inline]
>  exit_robust_list+0x31/0x280 kernel/futex/core.c:811
>  futex_cleanup kernel/futex/core.c:1043 [inline]
>  futex_exit_release+0xe3/0x130 kernel/futex/core.c:1144
>  exit_mm_release+0x1a/0x30 kernel/fork.c:1637
>  exit_mm+0x38/0x190 kernel/exit.c:544
>  do_exit+0x55e/0x1720 kernel/exit.c:869
>  do_group_exit+0x102/0x150 kernel/exit.c:1031
>  get_signal+0xf2f/0x1080 kernel/signal.c:2917
>  arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x00000522 -> 0x00000528
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 5528 Comm: syz.3.488 Not tainted 6.11.0-rc5-syzkaller-=
00176-g20371ba12063 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> syz.3.488 (5528) used greatest stack depth: 9096 bytes left
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz fix: mm: restart if multiple traversals raced

