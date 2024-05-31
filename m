Return-Path: <linux-kernel+bounces-196495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA2E8D5D00
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1491C24845
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DE153BEF;
	Fri, 31 May 2024 08:43:33 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913D152E0C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145012; cv=none; b=TEDUSswaSmtRdZ70cjjH3Dx0slD1DDTkU5+SVTnd1t4w5Gi7El0T1vMgZWGoeWrKRpI0YSu8koUT6KgBuIMrvyS+1L0xv6Iy/n2ZPuQd/aiLas2kRvUV9Ks7TaffaC0VAkbAdD/dz3yiQ7058EwqWx3YE2KfLF+dhn9h1Hg2u2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145012; c=relaxed/simple;
	bh=agPUhxW6soqUMyXYvSibS2RxfpN3ujFQ4lqCBq9F3Vw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M48yxAXrzCOcxDhWHummahkaVlLBzGWjQHFUBErZ+QdRW2b2yDjbAMq6re3E3NTTIBpvcJbfXT6NADaEiWJ7OXrxHYaHzxThKNT5KFcGKvRxxkrO1ZAnxqEemTxSEE6Q7suEqovQTj1XQ7IBJf3Dl+ZsI9swksbvrb8/ukvAjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eafdb25dbbso129908739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717145010; x=1717749810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmkQm0PNehAJCURi9HNibb8suumwIfxlJyp9F3gc+1M=;
        b=O4u3ptZ1Hi8V1HdYKsd2sqLf96ZAokMnCmcvi7olE7jgJpnd3mTE0PPgdGJWqKjs1u
         QzDqMG/+BWL0Ei6zz9Apx0zWLXsrGLMhxt1kI5PGTye4djoDP4EDCuTT4K31pr2u7YSn
         GCyuD6ttdKZPiTSPLuKVezW39Qgr2CAei9PODU+nXTkngcSuBl28Oq5HGAjq1kkFlsB7
         y0u732dUrPFP3TIfdeqISqFW6UAHN5jVCCEaBzfww68F/Ph7k1A4rcAG6HYgowxxWGaS
         CaffDWDiDhNeeExe6ZoYqySSpQgN0DBrdt4vXG8+iO+k7qrdKd61PFG1oPLSL32on+hD
         tl3w==
X-Forwarded-Encrypted: i=1; AJvYcCWHyvG3jkiRGFk4SF3Xe+20/xM27GPEV53g2swsHlW1rX8E2tGdj01sPopf4xmzb4bW442ObyzZZrlxv8XOf07lEwHaoSmu7xQovszN
X-Gm-Message-State: AOJu0YxipCjbh/z9hIpkLr5GS8tGcaIzyOGei92AABDVKBiXconae/IK
	zlJ6oDA2QtEM2CcaBIeVVyyQLZCr0sQH4FfHrhjChOGwi23lanx9/HgHunNtlE698jukPBFnBox
	WQePcjT8lA2s6vv3eXqo01AZrTYmRwQCNVYH9Yvkj7Zx4ErdFLBJlF9g=
X-Google-Smtp-Source: AGHT+IEJ9W64so0BiCi3IrDjDGCcdUZETq7z0/a+2bklaRdKRU4svmNce05UUA5GcBSsTAGZHheySetDtKVRJyMzKD33tuSVXlQq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e03:b0:36c:4c5b:ce1 with SMTP id
 e9e14a558f8ab-3748ba0b74dmr953845ab.5.1717145010631; Fri, 31 May 2024
 01:43:30 -0700 (PDT)
Date: Fri, 31 May 2024 01:43:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006304400619bbfae2@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in bch2_copygc_stop
From: syzbot <syzbot+c6fd966ebbdea1e8ff08@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e0cce98fe279 Merge tag 'tpmdd-next-6.10-rc2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1783e2fc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=c6fd966ebbdea1e8ff08
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/830865207351/disk-e0cce98f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b2afbee0859/vmlinux-e0cce98f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2eaac9c0eb1/bzImage-e0cce98f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6fd966ebbdea1e8ff08@syzkaller.appspotmail.com

INFO: task syz-executor.0:28112 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:20592 pid:28112 tgid:28112 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 kthread_stop+0x19e/0x630 kernel/kthread.c:710
 bch2_copygc_stop+0x4f/0x150 fs/bcachefs/movinggc.c:399
 __bch2_fs_read_only+0x47/0x430 fs/bcachefs/super.c:266
 bch2_fs_read_only+0xb52/0x1210 fs/bcachefs/super.c:356
 __bch2_fs_stop+0x105/0x540 fs/bcachefs/super.c:613
 generic_shutdown_super+0x136/0x2d0 fs/super.c:642
 bch2_kill_sb+0x41/0x50 fs/bcachefs/fs.c:2026
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89


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

