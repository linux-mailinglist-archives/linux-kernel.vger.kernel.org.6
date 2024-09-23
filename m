Return-Path: <linux-kernel+bounces-335845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC7297EB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1061C2157D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E10198E6C;
	Mon, 23 Sep 2024 12:18:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4312940B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093904; cv=none; b=bOVqU15yGPKrVyVxwQ42pviYWvWa2F20+oJAlEFUbzhZ5vdv91HEXMx0dvy32k0O0mXvMr7TZjHPm0Prj271LZ7PQI3OTOsZRzxuNOSPHEh/bLtZZKELH960C9/4fh4KZTr7OpJ48zHT493+IIQxDgj2mVcEt2zTPWs8VvbBJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093904; c=relaxed/simple;
	bh=9qyiqxr+PjRRwDv4hMepi7uxrW+IGWLO+QEuml6RknI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sasxRikGGw402+FRyQ5sJFxP8CynTrpwEJ3MAC60XAK6sXvCDoKtqbvWDceSDvhW3533FKYEeuVZM3gE+0QCA6W99hmVwpU/vMsVLPSgpSBQi6ocnH/13/13aKcPVj1/UUB9V0D+Mn2i4XksfbQuJaAc0n/YGbwQiR0ZQpRQFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0a4db9807so72657685ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093902; x=1727698702;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UjINTKHvnLU/HrUQBNckQJuurMHjgVJt71SinSfQPU=;
        b=sbGNuqE031gjgVGR3B7qPqiWjhBIydxLxcWEnyeL7Hz1mQbNqDRICwwgoOEJIk/YAE
         siHpXn0OJUF7fhqVK/+yMAKtwGkBofm4WWDfqch8Tr5zTILE+ngMHvMsDhoHue9LB4dA
         iytTWQ91uejz5lwGLzKz/7BOYJM2EUht8EkLRjSiy7wuOG1acbu7sZONEQO+2FFv7R6j
         BBl+tqT9mnI/pi8tdwrws3/y8VmEtSbdhzR1puHk9IiLFxXuoEPd+sHOhcvmrrhIK4kZ
         THK5Vo+YIK87iqZgYYqfnac5PRw13xYssSLj1vb9ZtqSmCGTsbSGWq63RSqDaWgr55lc
         1sIg==
X-Forwarded-Encrypted: i=1; AJvYcCXEcogeNLIb3kwC6Bke+W33TFyo4FyctbKNaup1IKMTBdR8Dy/Q38zpSl30CMPV8gzFFu1OQY4UN+b/aDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNV8/e+WHVo52DVmnI3BCjbfIiSmevZCZtclPk3LrONUjoZYk8
	v55QoZsBqINstwgRNiUA/70cbbfVbNn2pMIUvJ2xY9Uqt9IUTWP2T1ZQtwUJkdB18dmAow9wW7K
	/ddqkL4sOUzLoDG1uvWDzq0EdvmsHP6gNBl9Uy+YBnFw6M0+wk8bXU4c=
X-Google-Smtp-Source: AGHT+IFuCaGV9H15O3p7ezOnDCmac0nkjy6fOZ9ZLkTTdQBbnS5cf7801HYimbadhSHWA7N80FumIcGauH1ud6fIxNYsPCxr0/jE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c01:b0:3a0:c7f9:29e2 with SMTP id
 e9e14a558f8ab-3a0c9d6ff9bmr101979975ab.19.1727093901761; Mon, 23 Sep 2024
 05:18:21 -0700 (PDT)
Date: Mon, 23 Sep 2024 05:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f15c8d.050a0220.c23dd.000f.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in copy_huge_pmd
From: syzbot <syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jgg@ziepe.ca, leitao@debian.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mingo@redhat.com, peterx@redhat.com, rppt@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c36c27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
dashboard link: https://syzkaller.appspot.com/bug?extid=bf2c35fa302ebe3c7471
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12773080580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed5e9f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0e011ac37c93/disk-88264981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5c65577e19e/vmlinux-88264981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/984d963c8ea1/bzImage-88264981.xz

The issue was bisected to:

commit 75182022a0439788415b2dd1db3086e07aa506f7
Author: Peter Xu <peterx@redhat.com>
Date:   Mon Aug 26 20:43:51 2024 +0000

    mm/x86: support large pfn mappings

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17df9c27980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=143f9c27980000
console output: https://syzkaller.appspot.com/x/log.txt?x=103f9c27980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
Fixes: 75182022a043 ("mm/x86: support large pfn mappings")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5508 at mm/huge_memory.c:1602 copy_huge_pmd+0x102c/0x1c60 mm/huge_memory.c:1602
Modules linked in:
CPU: 1 UID: 0 PID: 5508 Comm: syz-executor274 Not tainted 6.11.0-syzkaller-08481-g88264981f208 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:copy_huge_pmd+0x102c/0x1c60 mm/huge_memory.c:1602
Code: ff 90 0f 0b 90 e9 2e f5 ff ff e8 8f fc 92 ff 48 ff cb e9 0f f7 ff ff e8 82 fc 92 ff 48 ff cb e9 8a f7 ff ff e8 75 fc 92 ff 90 <0f> 0b 90 e9 11 fd ff ff 4c 8d ac 24 00 01 00 00 48 b8 06 fe ff ff
RSP: 0018:ffffc90003cdf0c0 EFLAGS: 00010293
RAX: ffffffff8201bd3b RBX: ffff88803090c118 RCX: ffff8880317a9e00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc90003cdf248 R08: ffffffff8201bc06 R09: 1ffffffff2038ef5
R10: dffffc0000000000 R11: fffffbfff2038ef6 R12: ffff88802fab89c0
R13: d7ffe7fff1cbfe02 R14: 0000000000000020 R15: ffff888031e5b780
FS:  00007f38182a06c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f381831d9f0 CR3: 000000007b18c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 copy_pmd_range+0x425/0x85f0 mm/memory.c:1245
 copy_pud_range mm/memory.c:1292 [inline]
 copy_p4d_range mm/memory.c:1316 [inline]
 copy_page_range+0x99f/0xe90 mm/memory.c:1414
 dup_mmap kernel/fork.c:750 [inline]
 dup_mm kernel/fork.c:1674 [inline]
 copy_mm+0x11fb/0x1f40 kernel/fork.c:1723
 copy_process+0x1845/0x3d50 kernel/fork.c:2375
 kernel_clone+0x226/0x8f0 kernel/fork.c:2787
 __do_sys_clone3 kernel/fork.c:3091 [inline]
 __se_sys_clone3+0x2cb/0x350 kernel/fork.c:3070
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3818306429
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f38182a0118 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f3818390318 RCX: 00007f3818306429
RDX: 00007f38182e2ab6 RSI: 0000000000000058 RDI: 00007f38182a0120
RBP: 00007f3818390310 R08: 00007fffb191b837 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f381835d074
R13: 00007f381839031c R14: 00007f38182a0120 R15: 000000080000000e
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

