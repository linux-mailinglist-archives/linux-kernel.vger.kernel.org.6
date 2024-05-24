Return-Path: <linux-kernel+bounces-188173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9188CDED8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4923287C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98F3839C;
	Fri, 24 May 2024 00:16:34 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765C812
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716509794; cv=none; b=B0aVtPhnt1OHBrZp0QNpvS3ohmRXvHfreRBZVpt5GP33gn4p5Z8jKsVXSDZJZ1s48k8GguRAHCFG+uuuViTkGE3P69D9OARxMs2RyqZu4P6p2uHZwtOJFcC/RbW9caoCMP9fc2KPCD8h7FU1CG+KD5qqLhtB6DqoNoXpQzlbCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716509794; c=relaxed/simple;
	bh=KDUWPHmhznFXO+SNxVv+uHTf7vceVStCVrFWJa39AEk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ex7YfOKmTIRApnjT55HT53NXlS9evM0ItJqraejMf08TJRcnxXTREzfQaNYOLXd+3I88diYLFygJhYFUdtefHkW9Ot5GE/fgUzrz8OgLyAwJ0iBFBlQtFM5MCCgJr4GzTyOJ+rwnr/hRbd8Hfv7I9kfp1P8IUZeklqvXKvkxYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1d807cfbaso236064139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716509790; x=1717114590;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBNAgDjfQRvTsgfYZhDYhGGrl7saGwo7uOhhqFql94Q=;
        b=GBUhJyO9JBIHtU92ZRgYbhmm940bErL6nSh7V4cwIjQFm2zikgkayQq4vhALk3UW+j
         zHIATcL45F8uhlXTqw7v+orpbFhDRNJpjmUizcOSKw/HKXCSyOtkmqCV4+srFF+Gf4V0
         +5RFy5kfmT2vUWZObMt8pFm7UXJWzjC7IwIuc71/DGH1UUe5AYtlJDkut08HJy8vGrYk
         4zvMpYtNH/XTK/1WKSzOLb9A2YxL2+7S8JpfpwLZnl8m3YnJ0qyHSlw1hpVVfgYrYPuE
         7JwgYHFJ5Vx9dX2BLgzJ5jlpq/ENuzwv/YM7gJ6TkUjz5XhW//J3fzZmAWepCPQlj7bJ
         lOvQ==
X-Gm-Message-State: AOJu0Yx9vnaJPERJDA16jqgXk3WcZfDrLMzy2lhHZPJxlslNGgmW6S15
	LIK313q1iTph+wpJqiQT+XvurN1SrbnwCCNzzj/f24uFDliN3WH9L8vvqzWv6MMRDzRbkYdd3ra
	ZK1QWgYKZ2i92v1ARiEUR/Un8sQ6vQ1IXRqEvZwTD8AydONNb2BA0ZLwnCg==
X-Google-Smtp-Source: AGHT+IGCOjrUt8HO5X5AMJhG8O7DXFtK4P3mruf/kGHuVb3wVn4ZEw16iU6nA/eTZK02b2gaDoJ1XJSgAw/fyBaKm743gtKBAux9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f94:b0:7cc:cc9:4332 with SMTP id
 ca18e2360f4ac-7e8c75d37d9mr2367339f.4.1716509790724; Thu, 23 May 2024
 17:16:30 -0700 (PDT)
Date: Thu, 23 May 2024 17:16:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054792c06192814ef@google.com>
Subject: [syzbot] [kernel?] WARNING in sched_mm_cid_remote_clear
From: syzbot <syzbot+6023ff8646f73b21d232@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb6a9339efeb Merge tag 'mm-nonmm-stable-2024-05-19-11-56' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1614ddf0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fc7a1e1592b58da
dashboard link: https://syzkaller.appspot.com/bug?extid=6023ff8646f73b21d232
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05cdbeb43be5/disk-eb6a9339.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a6ad79005c1f/vmlinux-eb6a9339.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efe14da16779/bzImage-eb6a9339.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6023ff8646f73b21d232@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 22535 at include/linux/cpumask.h:144 cpu_max_bits_warn include/linux/cpumask.h:144 [inline]
WARNING: CPU: 1 PID: 22535 at include/linux/cpumask.h:144 cpumask_check include/linux/cpumask.h:151 [inline]
WARNING: CPU: 1 PID: 22535 at include/linux/cpumask.h:144 cpumask_clear_cpu include/linux/cpumask.h:528 [inline]
WARNING: CPU: 1 PID: 22535 at include/linux/cpumask.h:144 __mm_cid_put kernel/sched/sched.h:3256 [inline]
WARNING: CPU: 1 PID: 22535 at include/linux/cpumask.h:144 sched_mm_cid_remote_clear+0x518/0x680 kernel/sched/core.c:11874
Modules linked in:
CPU: 1 PID: 22535 Comm: udevadm Not tainted 6.9.0-syzkaller-09699-geb6a9339efeb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:144 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:151 [inline]
RIP: 0010:cpumask_clear_cpu include/linux/cpumask.h:528 [inline]
RIP: 0010:__mm_cid_put kernel/sched/sched.h:3256 [inline]
RIP: 0010:sched_mm_cid_remote_clear+0x518/0x680 kernel/sched/core.c:11874
Code: 0f 85 3c 01 00 00 89 9c 24 90 00 00 00 e9 98 fe ff ff e8 5b e7 14 0a 41 f7 c4 00 02 00 00 0f 85 e4 fe ff ff e9 7c ff ff ff 90 <0f> 0b 90 e9 5e fe ff ff 48 89 cb 44 89 f9 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc900044f7c00 EFLAGS: 00010002
RAX: 0000000000000004 RBX: 000000000000000a RCX: ffffc900044f7c03
RDX: 1ffff9200089ef92 RSI: 0000000000000004 RDI: ffffc900044f7c90
RBP: ffffc900044f7cf0 R08: 0000000000000003 R09: fffff5200089ef92
R10: dffffc0000000000 R11: fffff5200089ef92 R12: 0000000000000246
R13: 1ffff9200089ef84 R14: dffffc0000000000 R15: ffff88805f05b848
FS:  00007faff05ebc80(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559bfef5ec28 CR3: 0000000061162000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sched_mm_cid_remote_clear_old kernel/sched/core.c:11907 [inline]
 task_mm_cid_work+0x535/0x7c0 kernel/sched/core.c:11957
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faff07165f4
Code: 64 c7 00 09 00 00 00 83 c8 ff c3 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 00 00 00 00 41 89 ca b8 06 01 00 00 0f 05 <45> 31 c0 3d 00 f0 ff ff 76 10 48 8b 15 03 a8 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffda79a8098 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: 0000000000000000 RBX: 0000559bfef4a930 RCX: 00007faff07165f4
RDX: 00007ffda79a80a8 RSI: 00007ffda79a8538 RDI: 00000000ffffff9c
RBP: 00007ffda79a8138 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffda79a8538
R13: 00007ffda79a80a8 R14: 0000559bfef4a910 R15: 0000559bfef4aa60
 </TASK>


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

