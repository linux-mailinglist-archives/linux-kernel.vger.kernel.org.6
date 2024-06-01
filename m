Return-Path: <linux-kernel+bounces-197748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054848D6EA2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18662861E9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95C17BD9;
	Sat,  1 Jun 2024 07:08:28 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05917999
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717225708; cv=none; b=QItUU3jbhCZecERVwbiUAkntz+RPFuvlsU0NVUMOG4xHH5DYKqsPjz6GWlD8G3LaV4fxLkkXjG8Qu3N37+E0RnPWnkZW4sphj3EiLcGjX0z6P1N3Caf6Oj9uZOXZXxjMxobsFM3l0RcvSpKftHVfxSEg0UWsf1TImtdoqx1T73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717225708; c=relaxed/simple;
	bh=34tv86AuFm9Fi84FgLoPriZZP6Ufm1uj/GvDuDdjYIA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZreV+fBz0yfdtkHAdpn4fERYTVJzSX6Mq2ujECslHNLheGS4ciDIdmFrKV3HWR+wzYxOjZr1lW3hzAXKXUGz0WwS3CsqA60Wwt3Nx/ID9vw3K7GVSVg7XH7lgcybVGf1/AzwPEQcDUpU3WekdEdY/QuKao0nd8G/YVGCJRuH/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e8e558d366so354058439f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 00:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717225706; x=1717830506;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lpo20nmgX1ePVKGpkRVJfKGnsTe36G/WfmEPHh0DGKU=;
        b=B9t/jT0xnoerdbevhs/pGZHbaz2fEJbPCt+n1hDoWQ+n1ZXKowRW8mkRftVGoPtsYL
         jG10J6RJp5AGovw8/IGbzsWzf1C/nsZ/SrlONhyNjkvDidHlYoc309THua1PrBs4QIoZ
         CL/m3N5iKxgZmWeHKCsgVbXzoxc2LpTh/YL6PgMbooR7kIskjx8g9sJF5Lzc152ahcHd
         J6KHP8vJ8GwK+1ywpSDCM3q1Ccmh/KoU7HrF2eTmNnqg8Lk6kLlNU80lGqQoEJyq4Ttu
         SPozyPP3hHeX+0GJKBKIq/DyF2VXgRnJ6H0YdFVV++aVrMmZrmfsga1gf+XC/6Quz/UJ
         oCBA==
X-Forwarded-Encrypted: i=1; AJvYcCWgiWTHwt6tjLk6/44ABdYnBT5MBDKfa11wlx20AgfjSm2aT0VFvF8JGSUJ1gU39ahTqa7r3pR9/i+hTAMHP+sEcUUBpFiG8JJ043Zz
X-Gm-Message-State: AOJu0Ywh0Oi/+MvfWSlfk0ItaXOD0IGezAbDsvwDuE6r2JVu5TWnJBVf
	drUaks2Zf/djEue6t2dmnuV+dKRRbNTfJBqPCGa5+7UY5WLSZKLM64zyKzgDWHu/gLREccFzB9b
	0ZozLmhSgB3ptCQkx4YRqY3s/Bi09JSHe/8ZAW5qHMoCK1I1PAv4CATs=
X-Google-Smtp-Source: AGHT+IGbnOusA/sRzmBEZgMZXktsUrEFwyyUHNxCI8q1BoLpxJCwejtMvOEm2qQSFECEBV/y+LrJXMAOj+FwllM+mG+l692vuC/a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:831a:b0:4b0:ae06:24c1 with SMTP id
 8926c6da1cb9f-4b545ac8208mr133856173.6.1717225705717; Sat, 01 Jun 2024
 00:08:25 -0700 (PDT)
Date: Sat, 01 Jun 2024 00:08:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003051770619cec4f8@google.com>
Subject: [syzbot] [mm?] UBSAN: shift-out-of-bounds in do_shrink_slab
From: syzbot <syzbot+981b8efffb3d71c46bef@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@fromorbit.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6dc544b66971 Add linux-next specific files for 20240528
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c7f806980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a363b35598e573d
dashboard link: https://syzkaller.appspot.com/bug?extid=981b8efffb3d71c46bef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/334699ab67f8/disk-6dc544b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ca32b2218ce/vmlinux-6dc544b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/400bc5f019b3/bzImage-6dc544b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+981b8efffb3d71c46bef@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in mm/shrinker.c:406:18
shift exponent -1 is negative
CPU: 0 PID: 5278 Comm: syz-executor.1 Not tainted 6.10.0-rc1-next-20240528-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 do_shrink_slab+0xe26/0x1160 mm/shrinker.c:406
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0x87c/0x14d0 mm/shrinker.c:626
 shrink_node_memcgs mm/vmscan.c:5923 [inline]
 shrink_node+0xb82/0x4150 mm/vmscan.c:5961
 shrink_zones mm/vmscan.c:6205 [inline]
 do_try_to_free_pages+0x789/0x1cb0 mm/vmscan.c:6267
 try_to_free_mem_cgroup_pages+0x48f/0xb10 mm/vmscan.c:6598
 try_charge_memcg+0x704/0x1850 mm/memcontrol.c:2946
 obj_cgroup_charge_pages mm/memcontrol.c:3420 [inline]
 __memcg_kmem_charge_page+0xe2/0x250 mm/memcontrol.c:3446
 __alloc_pages_noprof+0x28c/0x6c0 mm/page_alloc.c:4712
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 bpf_ringbuf_area_alloc kernel/bpf/ringbuf.c:122 [inline]
 bpf_ringbuf_alloc+0xcb/0x420 kernel/bpf/ringbuf.c:170
 ringbuf_map_alloc+0x1d7/0x2f0 kernel/bpf/ringbuf.c:204
 map_create+0x90c/0x1200 kernel/bpf/syscall.c:1333
 __sys_bpf+0x6d1/0x810 kernel/bpf/syscall.c:5669
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efea107cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efea1de60c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007efea11b3fa0 RCX: 00007efea107cee9
RDX: 0000000000000048 RSI: 00000000200002c0 RDI: 0000000000000000
RBP: 00007efea10c947f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efea11b3fa0 R15: 00007fff6651b5d8
 </TASK>
---[ end trace ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

