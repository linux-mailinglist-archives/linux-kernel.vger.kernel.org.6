Return-Path: <linux-kernel+bounces-345101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6898B203
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C871F21E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1A26AC1;
	Tue,  1 Oct 2024 02:10:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D4E56E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727748608; cv=none; b=MPJSATFLRWRhPvmBKx6si2nJG4hC7mwc1VU0RFA4g6TtOgbZBxsotnIEKGdgvTbV3t0oCA7jIhc2biYSxRGTG4bSV0retSYidbmJStfyQkFBOQkffIaKqsm11/ww+ru9iGUecuxeXQthe5/u+nhAsA7pF2xWkJtY6giWrbqRkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727748608; c=relaxed/simple;
	bh=ruaHQCGXsjc5VXw5PYpTuYggqU9AiXCr5R26Q0TZTww=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HEmt9np6VjFaPx1U1Rk7PaTawX8ZtH7Dzo6/0Mv+c5T8rbzlAFiE5SJls+vDnnm3H1x29BUpORvXt+K5BCNlONITW1PdCvHzexpgasK8HRwACof5Dl3bJbKBdKGl9ZQG0RW8UQWmvQNSkEliUKyt3jC3FBWe8OXVoblLzUgxVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso52042275ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727748606; x=1728353406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btAbkw6f+Bc4dfQ33+sTkS8ppO38+HKoOwtSvmi2ZqE=;
        b=KPAj5pMyWzGotDxf5cYYVS+brB74icmS+/J+T0EhsZoGfk40OnlfJFrOcikOvNxGcM
         ue/ivX6AxHMo2+BcY7TnWqenN8rN6ZUJsiywRo7oXipSKWykFBc9Hy8NruwCo/bZVwmm
         yQ8Lnl+pQGM8Q387xvDmdvCT9DJ50u+BTzbbejhLwqA3+JllIwp0yIPqJ+koi7U2/xaE
         lhpJvUHnhfrJ6g8ufwSgvQxEEGLWY2k3zyTZX2y8Wx9ff0NBcJDmhqxt53WZSBavDxwa
         uCdSstM/Dw5u+F/UdAGMi/AMTx08GDTtxUhuBgDK0itX4/VEOa4zCayynVaHURsOzALP
         CjOw==
X-Forwarded-Encrypted: i=1; AJvYcCWkk9EOHlFg4ZogdFG6TKwSh1n1RYrZywqwGq38JA3I9FBkYNjWEdyeAhbt6PmlIgnftsSLo0M+w8zXkok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsprIEJa3qPgByD7mBQTwFGRyaB1GVD1jfy5wWaiH6VoDBjv3M
	hO2mdWy/PI9IjNUvI4lBV9w12KdTN7CqjrWhBF2eUnO/hzmzJnrfN7OoQbZRZ5spBnrGUHbqJCR
	nHEcAPzn2/NxlTvCFvdLaW6QnyhjaDj3W/bMIQdkvfz9gi2gPyTucea4=
X-Google-Smtp-Source: AGHT+IGflYZ015LTrV0Qd2psSyR7NKuJFJWhk0eLUh2f//nTWiH2zz8cemNukf8MRkP79/XIoRL2fLxbCKv+J3PQvwsqgBORfddn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c541:0:b0:3a0:ca91:2b4e with SMTP id
 e9e14a558f8ab-3a35eb01da8mr11395605ab.3.1727748606067; Mon, 30 Sep 2024
 19:10:06 -0700 (PDT)
Date: Mon, 30 Sep 2024 19:10:06 -0700
In-Reply-To: <20241001014939.1736-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb59fe.050a0220.aab67.003d.GAE@google.com>
Subject: Re: [syzbot] [kernel] WARNING: locking bug in try_to_wake_up
From: syzbot <syzbot+8aaf2df2ef0164ffe1fb@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in close_ctree

BTRFS info (device loop0): last unmount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
assertion failed: list_empty(&fs_info->delalloc_roots), in fs/btrfs/disk-io.c:4327
------------[ cut here ]------------
kernel BUG at fs/btrfs/disk-io.c:4327!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5820 Comm: syz-executor Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:close_ctree+0x912/0xd20 fs/btrfs/disk-io.c:4327
Code: ff ff 90 0f 0b e8 7e d1 da f5 48 c7 c7 40 30 4c 8c 48 c7 c6 80 60 4c 8c 48 c7 c2 c0 30 4c 8c b9 e7 10 00 00 e8 0f 9d ff ff 90 <0f> 0b e8 57 d1 da f5 48 c7 c7 40 30 4c 8c 48 c7 c6 20 7c 4c 8c 48
RSP: 0018:ffffc90002f6fb60 EFLAGS: 00010246
RAX: 0000000000000052 RBX: ffff888030de0f28 RCX: 618777cd44da3000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90002f6fd00 R08: ffffffff81749d9c R09: 1ffff920005edf08
R10: dffffc0000000000 R11: fffff520005edf09 R12: ffff888030de0000
R13: dffffc0000000000 R14: 1ffff110061bc272 R15: 0000000000000000
FS:  0000555562490500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00191d740 CR3: 000000007010e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_shutdown_super+0x139/0x2d0 fs/super.c:642
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2121
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9dd257f327
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd8c162128 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9dd257f327
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd8c1621e0
RBP: 00007ffd8c1621e0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd8c163260
R13: 00007f9dd25f0134 R14: 000000000001c212 R15: 00007ffd8c1632a0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:close_ctree+0x912/0xd20 fs/btrfs/disk-io.c:4327
Code: ff ff 90 0f 0b e8 7e d1 da f5 48 c7 c7 40 30 4c 8c 48 c7 c6 80 60 4c 8c 48 c7 c2 c0 30 4c 8c b9 e7 10 00 00 e8 0f 9d ff ff 90 <0f> 0b e8 57 d1 da f5 48 c7 c7 40 30 4c 8c 48 c7 c6 20 7c 4c 8c 48
RSP: 0018:ffffc90002f6fb60 EFLAGS: 00010246
RAX: 0000000000000052 RBX: ffff888030de0f28 RCX: 618777cd44da3000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90002f6fd00 R08: ffffffff81749d9c R09: 1ffff920005edf08
R10: dffffc0000000000 R11: fffff520005edf09 R12: ffff888030de0000
R13: dffffc0000000000 R14: 1ffff110061bc272 R15: 0000000000000000
FS:  0000555562490500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555624ab5c8 CR3: 000000007010e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1222ddd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f009dd80b3799c2
dashboard link: https://syzkaller.appspot.com/bug?extid=8aaf2df2ef0164ffe1fb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169d1980580000


