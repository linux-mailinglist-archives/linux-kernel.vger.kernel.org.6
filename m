Return-Path: <linux-kernel+bounces-301069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196695EC01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E3B280DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9013C9A7;
	Mon, 26 Aug 2024 08:29:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205413C909
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660963; cv=none; b=GkU6MSnHrk52Ajn/5iBDvZmT145xwwnDu6GM1wmm+95pN0IFbCzBl8qbaSMJZY3Wlt82D48wyB/SNJk5xIF3acwC+lMhqb5HMeXfRKGokku2Uh4RntuP+K9nLD2IFIS0VeGm2t9WBZklxTZss7O5qBZswZZNO1VfdFFWeiA7Zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660963; c=relaxed/simple;
	bh=GxeICCnQog2U7QP+joprzw/Iwt91UG1yFNXA7a/BVTg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FaL9wP/69TleYcx2foLZI0luNwulo8W7RjzmHaVEwS3sRoZ07tbDOEjwX7QBGLDvnFa8cvRMq+Mw+6KiOeYbKdPuhw13pLFRRRFsHYU3HFyF0DLjK6pkBvZ0k1klxmixOnqUIbQMiaUAPEyktbm2OFMcwkdFOT/4+hJD8w8Fa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d4c656946so50223435ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724660961; x=1725265761;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ts38uJV2SvecHBjmtyHRBQAHY81+ZGhboLnJyyhOJas=;
        b=hQ8F9zYbBl+qxyk0dNnvPC6P9zpYdhFc+eZgZGzBRNM7oqTwT/67Ih45OEh8Aw3wgt
         wR+m5/KzC8nsILcbOn2udI47I3oJ4b+0Z6JAd+Qf1udVUty7gOuibDkIET/9zz8YiXe8
         2crIWa8PL3LD1EfmDd/i/u6dY8DM9tY/SKW0JO3T9+oWSJpsw5KQsvbSDUdE6EKfCKQs
         UVuNScD3Mz4XeuAWOJQQcctUzhDPD9hi8xlrsQ1cKhNpSRQ1EXF4ay93DMc+Y5lEBMmJ
         jilOj6En3o1L87Rc7+NVf5ktyk0e7EIyFb5A8Ctttg7jJmz8cPUuvSmXbCCslHVcZYUm
         xrSg==
X-Gm-Message-State: AOJu0Yxx2XKbT4PcS+IS4SRbh3ZgInoxCijTGlB+WwJWOAiTWGXKuMP0
	cWIuODodSIMIq2Vze87LzEyX2+Dy/wtRDHBw5Ffb+jMrQFOhkWYT5Ijuo8atA9Vr49WWX0/6LiG
	oXI3dIUPhcFHylFAUiVVLAddWntuuidOExGk8pt1gaJyH2gAnZjMRZs8=
X-Google-Smtp-Source: AGHT+IEjN6iHrWhyCm4NdKY2YYbsGwgT1UBJhhqCI8X8A3cjmpQkz+89qvWsVgYMPFXzjQmRFIORJeAsi0mQ7BsVAF3fb18bOcne
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a1:b0:39a:ea21:1202 with SMTP id
 e9e14a558f8ab-39e3ca01fc6mr9071135ab.5.1724660961052; Mon, 26 Aug 2024
 01:29:21 -0700 (PDT)
Date: Mon, 26 Aug 2024 01:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f11da7062091eb85@google.com>
Subject: [syzbot] [kernel?] WARNING in audit_log_start
From: syzbot <syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a7917c89f21 Add linux-next specific files for 20240822
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c8680b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=897bd7c53a10fcfc
dashboard link: https://syzkaller.appspot.com/bug?extid=4576eaa688ef747b8d6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47820545bc51/disk-6a7917c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e300f3a38860/vmlinux-6a7917c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9146afef58aa/bzImage-6a7917c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4576eaa688ef747b8d6c@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 8527 at kernel/sched/core.c:8556 __might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
Modules linked in:
CPU: 1 UID: 0 PID: 8527 Comm: syz.4.642 Not tainted 6.11.0-rc4-next-20240822-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
Code: a1 0e 01 90 42 80 3c 23 00 74 08 48 89 ef e8 ce e6 97 00 48 8b 4d 00 48 c7 c7 c0 60 0a 8c 44 89 ee 48 89 ca e8 f8 02 f1 ff 90 <0f> 0b 90 90 eb b5 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff
RSP: 0018:ffffc90009ab7a20 EFLAGS: 00010246
RAX: a60a1ffb5c104900 RBX: 1ffff11004257a6c RCX: 0000000000040000
RDX: ffffc90003e59000 RSI: 000000000001b727 RDI: 000000000001b728
RBP: ffff8880212bd360 R08: ffffffff8155a632 R09: fffffbfff1cfa364
R10: dffffc0000000000 R11: fffffbfff1cfa364 R12: dffffc0000000000
R13: 0000000000000002 R14: 0000000000000151 R15: ffffffff8e0a492c
FS:  00007f4cf5b6a6c0(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7e0f003000 CR3: 000000001feec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 might_alloc include/linux/sched/mm.h:337 [inline]
 slab_pre_alloc_hook mm/slub.c:3987 [inline]
 slab_alloc_node mm/slub.c:4065 [inline]
 kmem_cache_alloc_noprof+0x5d/0x2a0 mm/slub.c:4092
 audit_buffer_alloc kernel/audit.c:1790 [inline]
 audit_log_start+0x15e/0xa30 kernel/audit.c:1912
 audit_seccomp+0x63/0x1f0 kernel/auditsc.c:3007
 seccomp_log kernel/seccomp.c:1016 [inline]
 __seccomp_filter+0xb38/0x1fe0 kernel/seccomp.c:1305
 syscall_trace_enter+0xa8/0x150 kernel/entry/common.c:52
 syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
 do_syscall_64+0xcc/0x230 arch/x86/entry/common.c:79
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4cf4d157e9
Code: 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 c7 c0 0f 00 00 00 0f 05 <0f> 1f 80 00 00 00 00 48 81 ec 48 01 00 00 49 89 d0 64 48 8b 04 25
RSP: 002b:00007f4cf5b69b40 EFLAGS: 00000206 ORIG_RAX: 000000000000000f
RAX: ffffffffffffffda RBX: 00007f4cf4f15f88 RCX: 00007f4cf4d157e9
RDX: 00007f4cf5b69b40 RSI: 00007f4cf5b69c70 RDI: 0000000000000021
RBP: 00007f4cf4f15f80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 00007f4cf4f15f8c
R13: 0000000000000000 R14: 00007fffe8828e10 R15: 00007fffe8828ef8
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

