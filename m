Return-Path: <linux-kernel+bounces-420330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A39D78F2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA0EB25EB9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A171714CF;
	Sun, 24 Nov 2024 22:47:19 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A6D17B425
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488439; cv=none; b=iu9Xfht6EfEHAYB7D/g0tgVK7ljZBFbBeQ9yDsl95vsR/V/m0eKFrssNY72DWwatkUdpXjFBqyxLfj13lp0ux+SNCdSlwZukXMvDxDgU7v3hSNvjWviIuQnhIc9iA9i1NF0CpZfSSDx0MLCCLiuHPs1pbierDPgxOrMsIyzoT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488439; c=relaxed/simple;
	bh=az88jjD+m/dEnUFPrByugEUvS7FeaRpZ53GW24UBV/k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YjYjx9BIwVmAG9DqcG/oKvINX4MhkwZSgCbvHNPccC17K++38TVQ6cVNweIdJUoaSGBPEcz/BPR76wwc7msA3UvIWqjPiiASWTJc2oBml9WCBUGJMsbtdyYlXYI0XxRauEjfOzl+jKISozf6Cq6Lc1EDmhaG6sv5P7/0RyEk+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a75c23283cso32597605ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732488437; x=1733093237;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLOpc2daBZkEJbZZavtr8q9boj2I4h/2gRE7M2e8GG4=;
        b=Gab5NmoA4UNPfYRehoOTjGWXWGKbi+6u7Di3tdMzuEX5Ek7UZGHC3h4PmAQY8Aw0uJ
         iw75B5GkPl6mvJbMx2DqNdbSTMzMddWZp2Ux+P+OZ6/UUeRYj0qkaMtSdTe9UmZ88yW0
         g04ZX8bDN0YqUpVBVcHCCGUJjb8zLhGCPbkHD7BdBU7F0pGNBAhiCjFn13QDrbssj2fR
         lrh0AmLRaHDYihFNBY4nTqTMpMU0v0N57IQXm8VxmR6+4CNg1JMPNRznJzAr8aRikXxb
         /GXY3eXCzguYFd8VsPEZBg6nAyyW13ffRCYNfoNOamYycCf+K1yLRQaIOB+9v4oifvE4
         bWew==
X-Forwarded-Encrypted: i=1; AJvYcCUDAtUAG7nVUU1YKWaspziMW4evTYgpy0jOf1nctIi67xmCUQ6MfdTWmRxPuqtwOH1yFngjS86uH7wHL6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8HSd2ix7leKpZjV7AGWt30x5rHF5WAFrrsr2/zCGuKQZQZ9O
	DMho2weu/p/PfZROtyfNknDaHYdI4inlrgaPVU2zEYAXpxpgFoctY3FgF/MfUArWE+GX1COSApI
	a8PZaAwSQJtLaep3qSjCb940gCE8fUuOESuDfvvWPb6mdc8jHEtpjB7A=
X-Google-Smtp-Source: AGHT+IFv+/Hsbpot+wYgw/bf602CIsYWhE/kuSjrU63CPedSRuAwAT3QwEsAvRh8usoiN3UXKl5Qfke0YWSRtdlnK4POUqaY1djS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c542:0:b0:3a7:ab88:8c0 with SMTP id
 e9e14a558f8ab-3a7ab88093bmr57589395ab.10.1732488436826; Sun, 24 Nov 2024
 14:47:16 -0800 (PST)
Date: Sun, 24 Nov 2024 14:47:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6743acf4.050a0220.1cc393.004d.GAE@google.com>
Subject: [syzbot] [perf?] [trace?] KCSAN: assert: race in srcu_gp_start_if_needed
From: syzbot <syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    42d9e8b7ccdd Merge tag 'powerpc-6.13-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a00778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d7fd5be0e73b8b
dashboard link: https://syzkaller.appspot.com/bug?extid=16a19b06125a2963eaee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef231513adc7/disk-42d9e8b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54caaac5960b/vmlinux-42d9e8b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/85b5a6566143/bzImage-42d9e8b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: assert: race in srcu_get_delay kernel/rcu/srcutree.c:658 [inline]
BUG: KCSAN: assert: race in srcu_funnel_gp_start kernel/rcu/srcutree.c:1089 [inline]
BUG: KCSAN: assert: race in srcu_gp_start_if_needed+0x808/0x9f0 kernel/rcu/srcutree.c:1339

race at unknown origin, with assert no writes to 0xffffffff8676ffc8 of 8 bytes by task 6285 on cpu 0:
 srcu_get_delay kernel/rcu/srcutree.c:658 [inline]
 srcu_funnel_gp_start kernel/rcu/srcutree.c:1089 [inline]
 srcu_gp_start_if_needed+0x808/0x9f0 kernel/rcu/srcutree.c:1339
 __call_srcu kernel/rcu/srcutree.c:1384 [inline]
 __synchronize_srcu+0x114/0x150 kernel/rcu/srcutree.c:1432
 synchronize_srcu+0x1ae/0x1d0
 uprobe_unregister_sync+0x1a/0x20 kernel/events/uprobes.c:1328
 __probe_event_disable kernel/trace/trace_uprobe.c:1138 [inline]
 probe_event_disable+0x1f5/0x240 kernel/trace/trace_uprobe.c:1222
 trace_uprobe_register+0xbb/0x3c0 kernel/trace/trace_uprobe.c:1512
 perf_trace_event_unreg+0x6c/0x1a0 kernel/trace/trace_event_perf.c:162
 perf_uprobe_destroy+0x6a/0xf0 kernel/trace/trace_event_perf.c:345
 _free_event+0x7ca/0xa10 kernel/events/core.c:5357
 put_event kernel/events/core.c:5454 [inline]
 perf_event_release_kernel+0x61a/0x670 kernel/events/core.c:5579
 perf_release+0x1f/0x30 kernel/events/core.c:5589
 __fput+0x17a/0x6d0 fs/file_table.c:450
 ____fput+0x1c/0x30 fs/file_table.c:478
 task_work_run+0x13a/0x1a0 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xa8/0x120 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000000 -> 0x0000000000000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 6285 Comm: syz.1.1056 Not tainted 6.12.0-syzkaller-08756-g42d9e8b7ccdd #0
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

