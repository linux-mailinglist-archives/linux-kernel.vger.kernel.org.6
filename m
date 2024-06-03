Return-Path: <linux-kernel+bounces-198569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2A8D7A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C21F213DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52DAEAE6;
	Mon,  3 Jun 2024 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf3/oBjQ"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED6D271
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717385152; cv=none; b=ktgpgj2+HSHYrWBMOL9+xH7Lm6NIzB/fEY4EEZMm4fck360j6Q5BoLm8/HJAQ+v16plJCNZF3IFo5xUhnD4bM9a65ruDS5OxrS8c9nTZpQGUlX4MKr3J3/Pw3Slau05TC/c6C6qnnGZoYIk5HO8pnUqapnzAjJqdPUl+sY99vKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717385152; c=relaxed/simple;
	bh=cGSW8YQcHSpUaGYgNWc8mvqWtkqEYi4Syfs9Qn+5qXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=M5z5zTB+ArnAx6/lPGobi9g3R2+p50yowkodNBp2yVnObGHawShAOws8Qp+AixzcTjvkuuqjs60tgGG1bP5i7JtXP5xlUvPp1tEZiZ47QmlupoojEUonJoBtmfPZ/PbEONpHS2hP8OWDChRE27NDP0GoMLHyyAz17AKcjYasU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf3/oBjQ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1f4c7b022f8so35470925ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717385150; x=1717989950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oh/wbqjavokT5q9TMhnmKScz2Un4xULt+QTcj87qNHk=;
        b=Lf3/oBjQtgctTFYo/ZrUylMJ1HZvsoMagf/B967u8jrm1JWqF7wUtfMyGAs+Jgt97K
         woUJd1So5ggRFdN5mrxEASQnlONvWjRR1sPMBkoXcKdL2+gTRQem/NVLUO3NHBj0mIXQ
         mwy9ZayJX3wNf99YlAf9TvhHrvjmIFGdFgRJni8U3cfCtOh5mJoxrbuV+QDfVI/rwv2Y
         6yscmWHxaiAA3iA/3weOjPzk/mJAKIWfx+Oq1nW12hoNkxJ+mzEu+q9OmAwL6J4zAa9l
         vrtTsmCN6UV51FJ31pz2PAh4PZ4+0DCGlqZMqP6bEhLjy/56x6tK1i96yw83uUTwPstZ
         +bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717385150; x=1717989950;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh/wbqjavokT5q9TMhnmKScz2Un4xULt+QTcj87qNHk=;
        b=N5JrOuOEDXtSZvrtrFeI38g+CCxzKSoidB1uiHFCrUM7AkfJBBuCgoAHnMGwT5gDGS
         Pkivkz1/HOuvPOWeBBGFG1fHsrBaanBOghlTl6j5UWpi6zy0YM61YCa6iPYvqGjJxTvW
         lvkqGzvdkjae7+z66MEB9XAy9IWHG5WmqG/+MRMyoQcfDm92QFpqHaMwoR1WioKuCCjD
         ssV9N8CamtgPlMrvRd8Rw30ophyo9uuh1/XwWWBCElJ990vKaHL7bpuBx20hHwfJXCuQ
         Kf8Nn9C0DTwv1JAiYb00h/wpHqyQlwMgg4Ufh4QM4Aw8LGkDyRhklQVBbjzmav3cHkU2
         7WGA==
X-Forwarded-Encrypted: i=1; AJvYcCXqcSl2T+87M46ghO2As7nA6Ehl4oMMd2w8BSGUDnJM/cBLiqgl0eBYQXQ0HferqeqJKS0qu9F1I65k5TUrRu3hl1Zb9c5cUQlR7Wdr
X-Gm-Message-State: AOJu0Yz9xxctm3BLlV0m3JPGKtM2yNCixa/ig/RVTdRDAN0QnqQ/bja4
	DSry/T9GvVBOLmh3tHumbT3yFh+Jo/ddqIiISkOGwoWG7ZRFDxce
X-Google-Smtp-Source: AGHT+IHx4qyCgYgiCspBRYkpM2Ho/CSW/xj7B0auEDgtKDsVBoQZ7QmCPmGDMjnMdXbfLHYd20xEbw==
X-Received: by 2002:a17:903:120c:b0:1f6:70b7:2f85 with SMTP id d9443c01a7336-1f670b732a7mr31285545ad.64.1717385149589;
        Sun, 02 Jun 2024 20:25:49 -0700 (PDT)
Received: from [10.254.2.163] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241c317sm53665795ad.294.2024.06.02.20.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 20:25:48 -0700 (PDT)
Message-ID: <9a7718e0-e30b-4b87-a0ed-dfcea389eaed@gmail.com>
Date: Mon, 3 Jun 2024 11:25:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] UBSAN: shift-out-of-bounds in do_shrink_slab
Content-Language: en-US
To: syzbot <syzbot+981b8efffb3d71c46bef@syzkaller.appspotmail.com>
References: <0000000000003051770619cec4f8@google.com>
From: Qi Zheng <arch0.zheng@gmail.com>
Cc: akpm@linux-foundation.org, david@fromorbit.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev,
 roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com,
 zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 Johannes Weiner <hannes@cmpxchg.org>
In-Reply-To: <0000000000003051770619cec4f8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I think this bug was introduced by commit 6be5e186fd65
("mm: vmscan: restore incremental cgroup iteration"), and
can be fixed by commit 9c8805439853 ("mm: vmscan: reset sc->priority on 
retry").

Thanks,
Qi


On 2024/6/1 15:08, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6dc544b66971 Add linux-next specific files for 20240528
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c7f806980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6a363b35598e573d
> dashboard link: https://syzkaller.appspot.com/bug?extid=981b8efffb3d71c46bef
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/334699ab67f8/disk-6dc544b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4ca32b2218ce/vmlinux-6dc544b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/400bc5f019b3/bzImage-6dc544b6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+981b8efffb3d71c46bef@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in mm/shrinker.c:406:18
> shift exponent -1 is negative
> CPU: 0 PID: 5278 Comm: syz-executor.1 Not tainted 6.10.0-rc1-next-20240528-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   ubsan_epilogue lib/ubsan.c:231 [inline]
>   __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
>   do_shrink_slab+0xe26/0x1160 mm/shrinker.c:406
>   shrink_slab_memcg mm/shrinker.c:548 [inline]
>   shrink_slab+0x87c/0x14d0 mm/shrinker.c:626
>   shrink_node_memcgs mm/vmscan.c:5923 [inline]
>   shrink_node+0xb82/0x4150 mm/vmscan.c:5961
>   shrink_zones mm/vmscan.c:6205 [inline]
>   do_try_to_free_pages+0x789/0x1cb0 mm/vmscan.c:6267
>   try_to_free_mem_cgroup_pages+0x48f/0xb10 mm/vmscan.c:6598
>   try_charge_memcg+0x704/0x1850 mm/memcontrol.c:2946
>   obj_cgroup_charge_pages mm/memcontrol.c:3420 [inline]
>   __memcg_kmem_charge_page+0xe2/0x250 mm/memcontrol.c:3446
>   __alloc_pages_noprof+0x28c/0x6c0 mm/page_alloc.c:4712
>   __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>   alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>   bpf_ringbuf_area_alloc kernel/bpf/ringbuf.c:122 [inline]
>   bpf_ringbuf_alloc+0xcb/0x420 kernel/bpf/ringbuf.c:170
>   ringbuf_map_alloc+0x1d7/0x2f0 kernel/bpf/ringbuf.c:204
>   map_create+0x90c/0x1200 kernel/bpf/syscall.c:1333
>   __sys_bpf+0x6d1/0x810 kernel/bpf/syscall.c:5669
>   __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7efea107cee9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007efea1de60c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007efea11b3fa0 RCX: 00007efea107cee9
> RDX: 0000000000000048 RSI: 00000000200002c0 RDI: 0000000000000000
> RBP: 00007efea10c947f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007efea11b3fa0 R15: 00007fff6651b5d8
>   </TASK>
> ---[ end trace ]---
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
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

