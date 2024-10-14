Return-Path: <linux-kernel+bounces-363263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7299BFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800C3280F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269913FD83;
	Mon, 14 Oct 2024 06:09:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6313D53F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886169; cv=none; b=qpDrga43d2EGV/0XPdP2EeUbTvCPMmACKQwg7CwBOhOBZ6QufiYmRv2zJS7jH2/bp7w64Vtit7scga1amTlUIYY2iVobeXZWeFu8aRwarnBvNHSsH0MkXSUi1rrbbl7OPVNI56osBvNnuCZVd/0yUYF401wFceReB2CarN209qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886169; c=relaxed/simple;
	bh=nv8qLXjacwOGsNr3ILmZF8qwOncQUaBG2RFwEAkUrbk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bwFYss8/M0lrvN4tedryjluat8jaa93LIHkGDBk7c5zgNHx/INY5+kAPKsuvJ9MtNbYQl4qjJgCoR3R98oZpjejyiFjgKfJYl92XKUjRZaJ+TbZ2saf2puWReV+wGzJlYuVV08Bbg7sxeBTJ1++ZKj+5Abxq/VfrXI8mfY09AYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so24772055ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728886165; x=1729490965;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKiXsArvGra0VX5VVktVVDzHkecq7lDHEZLHLanAM8Y=;
        b=rpJT/grzbuzEVb/ANHuQPIjrYFubi4rsDTIOYVIS46dQXwTI2a9AmxMhe3pNE+Lg9+
         bBdp4odZ/LctcODGkhwXNuFrPJ0a8QYz92yz/S2jj8Gm0FKNk6qCiUBF0VO+d4R7qsqC
         P+fwFsuzPxm1HiYdDgnJ2BYB6PPjTz5fm1oWy5I8aOWfdBKahZBEs3SIDl5IaUQ5nmpW
         3VJbTY6OzMnVlIwn7wOLY5e4R7bSjUaaoO0GSDkoPVne+5FPWPPxvgY6qqzwxEaRnwTy
         b+aS2dWYZWyCE1onBh7SjxLtseOJFXZ2B8IRpbgPXLB2u0ln6dsBmdb2pSUH8I/sj0Wx
         7phg==
X-Forwarded-Encrypted: i=1; AJvYcCWz06mTkFpYJJe6s2weAq+ParUevPFtmW9XXBkMuq2FZYgaNd663l/jVlKkcQf7B4y5GJb8+YBdgA8to2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgU93clRCRafioUi/GnYJgvrhwt1NgTeqzWjE6vEs+YKEWUN2
	FA/3fY8lC3ZdpzbnsQohoA8lehxJcUKc0WrXnmaN0Dsdpjrr6egWr/AG4Wv8i/uDw71MJuzZF5U
	VD9xNuJIqL4VhY3veGvhefE2clb7ulbEufOX2B9QozYTPbFMOy8GmDQw=
X-Google-Smtp-Source: AGHT+IFcI7LD8MU0anBfXZfOQmjNnGHnPHe7/s0l+xyckvvJ88KkptyJzhS7CWyLdpeQhOBwZlFZIfN63SadvrKBXZy5YDOhnwpQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:3a3:9471:8967 with SMTP id
 e9e14a558f8ab-3a3b5f9fca7mr84667255ab.11.1728886165034; Sun, 13 Oct 2024
 23:09:25 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:09:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb595.050a0220.4cbc0.0043.GAE@google.com>
Subject: [syzbot] [perf?] KCSAN: data-race in _free_event / perf_pending_task (2)
From: syzbot <syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10104f9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f7ae2f221e9eae
dashboard link: https://syzkaller.appspot.com/bug?extid=e75157f5b04f8ff40e17
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cce40536bdc3/disk-87d6aab2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/479edc06c8d8/vmlinux-87d6aab2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d377c65ffca/bzImage-87d6aab2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in _free_event / perf_pending_task

write to 0xffff8881155361e8 of 4 bytes by task 9574 on cpu 1:
 perf_pending_task+0xe8/0x220 kernel/events/core.c:6976
 task_work_run+0x13a/0x1a0 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881155361e8 of 4 bytes by task 9573 on cpu 0:
 perf_pending_task_sync kernel/events/core.c:5302 [inline]
 _free_event+0x3d/0xa10 kernel/events/core.c:5326
 put_event kernel/events/core.c:5454 [inline]
 perf_event_release_kernel+0x61a/0x670 kernel/events/core.c:5579
 perf_release+0x1f/0x30 kernel/events/core.c:5589
 __fput+0x17a/0x6d0 fs/file_table.c:431
 ____fput+0x1c/0x30 fs/file_table.c:459
 task_work_run+0x13a/0x1a0 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x7ad100bf -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 9573 Comm: syz.3.2265 Tainted: G        W          6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

