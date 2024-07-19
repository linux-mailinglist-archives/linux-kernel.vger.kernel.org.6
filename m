Return-Path: <linux-kernel+bounces-257193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD3D937677
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B81FB22E97
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE784A22;
	Fri, 19 Jul 2024 10:08:26 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A617E76F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383706; cv=none; b=dZYciWc+USuy3431jBztqATfR5+WGoWt+MckgnDNO+FXzcdkrDfYFEn837xIAwTeeXjpOKEa7TrQVjuVnYiskRUFp3//9VMRJIbKUIwJvcu/bo6WjAkgcFnCp34NuUyPJW8Dg3+XJuQz6+NknVJiX2WK0+wNN1b/G/eacqINXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383706; c=relaxed/simple;
	bh=FhKNfukBE/pSbQV3cgjwp8Qn3uTtqXwLrxdjG4Uj65A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H4DGrqIziZdUTGci2qT7CmevXa5T2IJ2j2+vIns84Le02NoSA/JnUsk8TSqTUHt4F/HR7C0AtGuAylL9HLOkBvJxmqAG4Gx+C24Tepxu3G1lCFUydDKKNItjQu8sbahZ/wkifSoMB5ChKpG1uNlOJGAObfyZBL9he3zJMAmK6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-804888d4610so361550839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383703; x=1721988503;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfmNVPjGxy5MSzYTL9vKwCzc+vRoDpDRSTp6krR1EgY=;
        b=q+wqYgofCy6MTN6ZVnb1lFVYMhBHusYHdykapGk7Wqp6LsW2jZqZee8Af+y93UI3Ij
         +LV8LZTGX03DacAfTpheGmxJt17TTvvmZxNofvsR2jezKOy0JcaR+XBEeVw+TeMN0TfJ
         Qukr0Y76vPw7X4YYQdWOOlLZ65xLZByRC29B/WUWu9DNf9cvyreKLgWRHzUB5GQ14RxO
         f0WOmxB0XNHWw8zC+xuJ0DqRAWfu+AUOA5noKn5CNYmH8u3JcmfUBhstD1j24yKLYXaK
         mVr+32LCygrhnVE7fWCyLB3RLN6Z0R3TWxZUiiT5XkdTYPxoKUuQ80Cbf4H6f0HsmtpV
         gHXA==
X-Forwarded-Encrypted: i=1; AJvYcCWIdbCewbCENFQumvo5yD5rH/6CXhYaPyGUi5GQn3J77ndL4yBoG/yiVxpfV4rxJpUieOLmgzSLDBBu5+kV7EJBfQ3ZWuw8th1/6ndy
X-Gm-Message-State: AOJu0YwhWPJut3S/aDAyrM1lzaxr5pgqFRxl3xr0XAPiCu8HUmZISMZO
	zcyrdD5B3t8J2ZZAurHDROLTnerz9r8APlLzTzaXLstOvC2hOlvSwqnWCNMziJ87+TPzmayW5xW
	xV4NHYpWsYUCyHgHs3wfsLjYmdJ1f9DPdUEYxzsYs3O6toGAcM21SwPA=
X-Google-Smtp-Source: AGHT+IH9Myk9sIYPOOOOzjBZplA1xAA2ZpHXKVtEhhTnD2z3crGHkjXG6MH1l2Fhnmj9A15Y+cdcNqTp/nsw/qdjpR8+6h3/6yFK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13cd:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4c21fb88eaemr183873173.3.1721383703655; Fri, 19 Jul 2024
 03:08:23 -0700 (PDT)
Date: Fri, 19 Jul 2024 03:08:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002dcf3e061d96e0ac@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in qd_put (3)
From: syzbot <syzbot+0423714c06c369318794@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c9152d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=0423714c06c369318794
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15989efd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119e6b9e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/60f4ea8cd0cc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0423714c06c369318794@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/gfs2/quota.c:333!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5093 Comm: syz-executor256 Not tainted 6.10.0-rc7-next-20240712-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:qd_put+0x192/0x1a0 fs/gfs2/quota.c:333
Code: ef e8 62 f6 17 fe e9 f2 fe ff ff 89 e9 80 e1 07 80 c1 03 38 c1 7c 82 48 89 ef e8 39 f7 17 fe e9 75 ff ff ff e8 2f 70 b0 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900035dfc08 EFLAGS: 00010293
RAX: ffffffff83e35ac1 RBX: 00000000ffffff80 RCX: ffff88801a358000
RDX: 0000000000000000 RSI: 00000000ffffff80 RDI: 0000000000000000
RBP: ffff88807f3f25b0 R08: ffffffff83e359a1 R09: fffff520006bbf6c
R10: dffffc0000000000 R11: fffff520006bbf6c R12: ffff88807f3f2540
R13: ffff88802a2eb800 R14: ffff88807f3f2570 R15: 1ffff1100fe7e4b6
FS:  0000555576e86380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffed6b8af98 CR3: 000000007942a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_quota_sync+0x41b/0x4a0 fs/gfs2/quota.c:1363
 gfs2_sync_fs+0x4d/0xc0 fs/gfs2/super.c:670
 sync_filesystem+0xed/0x230 fs/sync.c:56
 generic_shutdown_super+0x72/0x2d0 fs/super.c:621
 kill_block_super+0x44/0x90 fs/super.c:1685
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1372
 task_work_run+0x24f/0x310 kernel/task_work.c:222
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb2335fb597
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffed6b8b1f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb2335fb597
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffed6b8b2b0
RBP: 00007ffed6b8b2b0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffed6b8c320
R13: 0000555576e876c0 R14: 431bde82d7b634db R15: 00007ffed6b8c340
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:qd_put+0x192/0x1a0 fs/gfs2/quota.c:333
Code: ef e8 62 f6 17 fe e9 f2 fe ff ff 89 e9 80 e1 07 80 c1 03 38 c1 7c 82 48 89 ef e8 39 f7 17 fe e9 75 ff ff ff e8 2f 70 b0 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900035dfc08 EFLAGS: 00010293

RAX: ffffffff83e35ac1 RBX: 00000000ffffff80 RCX: ffff88801a358000
RDX: 0000000000000000 RSI: 00000000ffffff80 RDI: 0000000000000000
RBP: ffff88807f3f25b0 R08: ffffffff83e359a1 R09: fffff520006bbf6c
R10: dffffc0000000000 R11: fffff520006bbf6c R12: ffff88807f3f2540
R13: ffff88802a2eb800 R14: ffff88807f3f2570 R15: 1ffff1100fe7e4b6
FS:  0000555576e86380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffed6b8af98 CR3: 000000007942a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

