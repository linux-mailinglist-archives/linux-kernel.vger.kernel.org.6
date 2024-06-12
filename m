Return-Path: <linux-kernel+bounces-211914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED599058C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF10288D80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6F181B89;
	Wed, 12 Jun 2024 16:26:25 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C31180A9D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209585; cv=none; b=b3rz2SUaLQHnJYMrKZnIx9RNtVpRbxRd7P5yMEXBiVS7sOO5vPX7aItM/mmLYbuOYomxvaeRuEWdEeETbnrx/0BQnt/hMvcHl4mp9y4CxADy7u/D7vgRFDQHoqgJDS2+lUloZWGE+3g316c+5NHpQkYkS9bZBhUYn8CiXRkYWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209585; c=relaxed/simple;
	bh=v+4+a+HTHLTgO7hxv1jZ5OsOtxeDEq+Mt8tBAF0eHvU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WQe+h13H6HLnOI5GRTXnxksk554zHDM3jDu7kF6fwjW/kK5lvF5zNUhAJzPl6dqW45qvLuH9tyC0SCapBaewGhOEMU0QT0dtXZ0qqznOiDQIVmhyuUupngNbio21HwElXCwWNggJiVdTTnFvQtj6xphGZ4Q8QtzwSx7+BLvBkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ebd7c57a35so33391639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209583; x=1718814383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtsP29K0Q6706Qq7mLsa+x4VxRNJjog6MhC7GzgYXnQ=;
        b=wYVY0nUM+MOzwTLJWmDiPJZhMcXTRSXWMwByfNy4KEtrBGZTk1gDFXOaViJg1/OqDp
         Wed2x8Vnqfnt4ADJnuwTdZ3LitrxARvxRvMYxHZDcxrfUNZclESC5V+zpbe0wL6N/0Rx
         7OgG62VPz7wYSWrzDtXnPYLn6fmbMy21Dp28Y3bU/7DrgImIfNOTqqdwFrx/ksQ8kRvV
         KCxjZOOuXw3ADhxEP7nvj6TmCgsJPomiFlSow/nh8KlfQ76pfoTMlvCkKHu43XCWKM4l
         XUM5JDznLKwaLMbdrFDRNl57HYY9RniOkzY4sNqpCUq6tRqmgCYpUXs/wTMoh9wgKKjV
         orwg==
X-Forwarded-Encrypted: i=1; AJvYcCVeOVR6gJ0b/DUAh1Vq0qFr0/ekrCGFU+l//cbrN8ldKggIC5pRPDP+ggpr9gDKvyRSvnp/5dWDe1s+NRfvYSCrSZCkeA65w7+qqckh
X-Gm-Message-State: AOJu0YxYmK2JEJJOtHPFSGAl3tYn8V0Xpq14GlAr0fPw0EJ//7Wrapzr
	dV2RzeX8sSBF1p6s+AAEeSFSntBXMozgJDdYLjIpCinGXWRLBeUkhZFS5VurW1GmJwk+tmBj7Oo
	1WPSC/nUAN/3+YuvoKx7xMGE7irdU7QGrIAa3BUOHBnRdDMalIdHTR8g=
X-Google-Smtp-Source: AGHT+IGRlBTkVSTyJ4DKNMLBoLRFp9pg3qr1yC/6JFMdFq4kqH3Micx7Jxffp4WrGwBeEVTR1Fbj4fhseehd68UvOcSSxxKyU6Nd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25c3:b0:488:e34a:5f76 with SMTP id
 8926c6da1cb9f-4b93ec0ef35mr159485173.1.1718209583121; Wed, 12 Jun 2024
 09:26:23 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:26:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da1703061ab3d7cb@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in bstr_printf (2)
From: syzbot <syzbot+3d98610f9d9bdb4a57ce@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=133d9a36980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=3d98610f9d9bdb4a57ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1631e6f6980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160d3126980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d98610f9d9bdb4a57ce@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bstr_printf+0x19df/0x1b50 lib/vsprintf.c:3334
 bstr_printf+0x19df/0x1b50 lib/vsprintf.c:3334
 ____bpf_snprintf kernel/bpf/helpers.c:1064 [inline]
 bpf_snprintf+0x1c8/0x360 kernel/bpf/helpers.c:1044
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4269
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 bpf_bprintf_prepare+0x1393/0x23c0 kernel/bpf/helpers.c:1027
 ____bpf_snprintf kernel/bpf/helpers.c:1060 [inline]
 bpf_snprintf+0x141/0x360 kernel/bpf/helpers.c:1044
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4269
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run288+0x45/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425

CPU: 1 PID: 5042 Comm: syz-executor235 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

