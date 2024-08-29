Return-Path: <linux-kernel+bounces-307340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A3964C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D95A1C2373D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9411B5823;
	Thu, 29 Aug 2024 16:53:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE581B1405
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950402; cv=none; b=F/pu55hZDFhdwRkGiWhLiZfZxFAnoMD2fhwFB0IkPhtlquT/9aQvyTiqy0Ryxa5rUJOUN3lgUjqFVGPKphaNhWjU3j3TrgFrYWzn5EaW95Kx6w1sDMiHlGO0F5s1hFqPTDkYmV3Hr9uBxNszB93lMiQCmZIEBw2Tqe+gmVj0UWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950402; c=relaxed/simple;
	bh=0oKOG1inFNenjW3THv8ilJlWnxV5ZD2iXnnNpWukEBk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vEuSRfxLrt2GdBYYtb5WrmMipkePCkvqOQy5TDRgzXAw6gFxG/yNPkv/y7sNZp9U+zyxpLYJtUIXI2j7DNiUQJjx0XYwwVT7C9TuyACxqFwsxFe70TIE0ntLuEqk91DyGHjkINqPDVddOyt3iXPmIJBx2+jjJSFwDRM9rOW/k1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-824c925d120so92613439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724950400; x=1725555200;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BvFh4ndpSTJeKsROL2z+JLa5B9vKHfCjmHGQdFDneA=;
        b=VCqt9Exr5VHUeIsXZlfIYV1EQ9brCP1/KD5awWXGJRTsEm7LDHC7qxU36kASuYg5Rm
         lUVgOzsGHloVS21G41iH6+1G9PC3bPwAV0SPdTNCRuB3L7Hsvw5sTyaVGOxEagXCFm3Y
         TjgO+NjjJ3s/o/Gfq3UVMsPKUWVS02roCv5i3Q+t/lxPE7GKQveiDsIJRoPRH+I+JmR6
         rNPHH6nqWlgoZ7U9x1oJmmOBuVgNx1aJYSaRIvBE0QXkrm9ZRLnsEPoRqQTLEjhIzzh6
         Hpn4Uvqbo13PdPK5O5tfc+v1FI0i4jbDEBATrj/XZMaCipxeNC4FAmCfkpSoTdlWHS6W
         VJgg==
X-Forwarded-Encrypted: i=1; AJvYcCU630dDHbiZT5KcbK0azOetXb3iwE47Yxj/c4BXGvqx5pN8xHU7/Ziw+n+qSxrK/LHL69oam+NiCUn3lSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2bD4WrvBdUXCQV3wg1+vzTX20sEqtBkWcIQ3SCpmY3gwXOSy
	qK4Va4zCHeV1VV+cbAh8edU1axlPTDM6yIwPrU78x48r9wUmtj2xCe7KrxKeS4Y0RayKbPB2qfn
	y+YqOGbZRr+bx2Tebvt4/BqhpZO/tZ23SJFQsWDi+A22LUWxeeFdj2RY=
X-Google-Smtp-Source: AGHT+IHF04MiPKHvS0qCkvfitYymrc11DsbiSg2cSsiR8bXwNGg5PRs4wUJNvgMlI+cUgd5L7sdOrnNc0/WmenJieWjiwwzV/vIE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a8:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4cecff9b544mr112344173.2.1724950399706; Thu, 29 Aug 2024
 09:53:19 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:53:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d47d440620d54f15@google.com>
Subject: [syzbot] [kernel?] KCSAN: data-race in pcpu_alloc_noprof /
 pcpu_balance_workfn (2)
From: syzbot <syzbot+6d392a44667baa45bb5a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d5d547aa7b51 Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164c067b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fafac02e339cc84
dashboard link: https://syzkaller.appspot.com/bug?extid=6d392a44667baa45bb5a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e636aa58c364/disk-d5d547aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5ecd0d96afa/vmlinux-d5d547aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe7d474f148f/bzImage-d5d547aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d392a44667baa45bb5a@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in pcpu_alloc_noprof / pcpu_balance_workfn

read-write to 0xffffffff88bb27ac of 4 bytes by task 3354 on cpu 0:
 pcpu_update_empty_pages mm/percpu.c:602 [inline]
 pcpu_chunk_populated mm/percpu.c:1531 [inline]
 pcpu_balance_populated mm/percpu.c:2062 [inline]
 pcpu_balance_workfn+0x94e/0xa60 mm/percpu.c:2212
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3312
 worker_thread+0x526/0x6e0 kernel/workqueue.c:3389
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read to 0xffffffff88bb27ac of 4 bytes by task 6821 on cpu 1:
 pcpu_alloc_noprof+0x9a7/0x10c0 mm/percpu.c:1894
 bpf_map_alloc_percpu+0xad/0x210 kernel/bpf/syscall.c:466
 prealloc_init+0x19f/0x470 kernel/bpf/hashtab.c:341
 htab_map_alloc+0x630/0x8e0 kernel/bpf/hashtab.c:576
 map_create+0x83c/0xb90 kernel/bpf/syscall.c:1333
 __sys_bpf+0x667/0x7a0 kernel/bpf/syscall.c:5692
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5815
 x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000001 -> 0x00000004

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 6821 Comm: syz.4.1651 Not tainted 6.11.0-rc5-syzkaller-00081-gd5d547aa7b51 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


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

