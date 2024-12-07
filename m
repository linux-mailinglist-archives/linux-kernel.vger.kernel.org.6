Return-Path: <linux-kernel+bounces-436145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2369E81C5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA9B2815DE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FDC14C5BF;
	Sat,  7 Dec 2024 19:15:25 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1171E529
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733598924; cv=none; b=I9ugBwxHkgjmP5f15SgWA1B6sjoDpSfmoFIXke9RXTN34A5un9mNxX2XyvfJsfgxcvbQgVDucClGcKgN8iwlI/WtieUbCmIoe0NWmXdkGWY9HUHbsq4i2zTXtUqYF1i/y3AiIe/stNIvk3IekV7c15UIbj5eL/u/Bt3G1G4bqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733598924; c=relaxed/simple;
	bh=Kd6c7MSvodC5L9WUJZfpUgLrXGjcly0/J7h3fvGN7NE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TCTrCPPeuN5YRz76IupFXoSEF+zriTR+OFuIeI8g3aDEfxrzFHAEzIqYwErFkdRudh+SArQZzrkYJ7kt7yfTcJxvPBxGuZabh2zWOi046+iVlPWin2GdigZo2C2JNoXyzDt4akTgWzU/V+VhqQx8JM3sAdOxe+Soy7OW2DFugjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a814406be9so32553725ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 11:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733598922; x=1734203722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjVvBmFM8IbMWp4d1INsUaiDkrYC100hzzldP+Ue6yU=;
        b=M9ls06VJQjSYk5kdjYW3p+gpMZNXyQreryufZz1Ahdb7zfuQ36RkWHPBGzSzlHd6M6
         9ilNXeVr7Ifd1B0C3kkRUdAfJQOe+XiBLcfjCqjUF1hvtptbJw5s9wTByHMwW6Z5qgT4
         aa4QmAdjNsZuWn8N7JB4CyMQdflGyeBfYyfF9edhKWnJ7bldw2XvBsbJmuh1aDxse7ul
         o34sq9Gc8du5s3cATXwPDrdat9FiFZS58hrKgIV6ePhHVQpyd2qT2hG/fIyRGejrP5HQ
         alqQps+3puYd/uuIxlxVrgDfl5boNOIrxhjpyUIPrHKlplOD2j8TfNl+hjStYiYeVIk6
         hBiw==
X-Forwarded-Encrypted: i=1; AJvYcCXaf89Mro4HXYh6ayV8snnTmNAJviP6fR8QCeD9zHFHgzAan/lviSqb+yev6ldoT6D22by8dFy5Gtu2IEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIk3/IovZ8piM9kZf2WGs7k10fAsPqs2ig1GZlQnH5EUObEbq
	VDomKkWiEPJ0ScG/9YgFCnnribYFdTY5K3PAzr0PxxrECaTIFzQHNXC/4ldIqUPfZOFPi6i4OUJ
	DK8DWqqk/VbP7px6urDE+d4cPcRNcT6oYiB+RZNc7NwH2vcN7v+LXOZQ=
X-Google-Smtp-Source: AGHT+IGffcNj5Cx3vYm28HgIaQoi5iARoOaBvBXcvD7s5gh22//+C6yfCLqUhlvLx3k761iKjU+wwfffk4G/AAZF3pM2CndOdFnT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:3a4:eca2:95f1 with SMTP id
 e9e14a558f8ab-3a811c76316mr86450795ab.6.1733598922304; Sat, 07 Dec 2024
 11:15:22 -0800 (PST)
Date: Sat, 07 Dec 2024 11:15:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67549eca.050a0220.2477f.001b.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in lru_gen_clear_refs
From: syzbot <syzbot+67a21f2b4c8e9e650adf@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    af2ea8ab7a54 Add linux-next specific files for 20241205
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1210e8df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=67a21f2b4c8e9e650adf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111050f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136fade8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8af0861258fa/disk-af2ea8ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ffb38cf7a344/vmlinux-af2ea8ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6fbd2e50358a/bzImage-af2ea8ab.xz

The issue was bisected to:

commit 51ac493f56fa00b052be4fbc94ac91f057ebc2e7
Author: Yu Zhao <yuzhao@google.com>
Date:   Mon Dec 2 03:28:19 2024 +0000

    mm/mglru: optimize deactivation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141418df980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=161418df980000
console output: https://syzkaller.appspot.com/x/log.txt?x=121418df980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67a21f2b4c8e9e650adf@syzkaller.appspotmail.com
Fixes: 51ac493f56fa ("mm/mglru: optimize deactivation")

 __kernel_write_iter+0x42a/0x940 fs/read_write.c:612
 __kernel_write fs/read_write.c:632 [inline]
 kernel_write+0x214/0x330 fs/read_write.c:653
 process_sysctl_arg+0x3f7/0x650 fs/proc/proc_sysctl.c:1683
 parse_one kernel/params.c:153 [inline]
 parse_args+0x623/0xdc0 kernel/params.c:186
 do_sysctl_args+0xeb/0x180 fs/proc/proc_sysctl.c:1715
 kernel_init+0x80/0x2b0 init/main.c:1489
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
page_owner free stack trace missing
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5828 at ./include/linux/memcontrol.h:730 folio_lruvec include/linux/memcontrol.h:730 [inline]
WARNING: CPU: 0 PID: 5828 at ./include/linux/memcontrol.h:730 lru_gen_clear_refs+0x498/0x520 mm/swap.c:410
Modules linked in:
CPU: 0 UID: 0 PID: 5828 Comm: syz-executor425 Not tainted 6.13.0-rc1-next-20241205-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:folio_lruvec include/linux/memcontrol.h:730 [inline]
RIP: 0010:lru_gen_clear_refs+0x498/0x520 mm/swap.c:410
Code: 66 ff ff ff e8 99 dc c2 ff e9 92 fe ff ff e8 8f dc c2 ff 4c 89 e7 48 c7 c6 20 c9 13 8c e8 20 95 0c 00 c6 05 4c 86 27 0e 01 90 <0f> 0b 90 e9 7b fc ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 43 fd
RSP: 0018:ffffc90003787460 EFLAGS: 00010246
RAX: dc5da43f42521400 RBX: 0000000000000000 RCX: ffffc90003787003
RDX: 0000000000000002 RSI: ffffffff8c0aa440 RDI: ffffffff8c5fbe80
RBP: ffffc90003787530 R08: ffffffff9019d9b7 R09: 1ffffffff2033b36
R10: dffffc0000000000 R11: fffffbfff2033b37 R12: ffffea00006a8000
R13: 1ffffd40000d5000 R14: 00fff00000000058 R15: 0000000000000000
FS:  0000555587a6b380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 000000007213e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 deactivate_file_folio+0x99/0x100 mm/swap.c:679
 mapping_try_invalidate+0x28b/0x550 mm/truncate.c:489
 drop_pagecache_sb+0x1ab/0x260 fs/drop_caches.c:40
 iterate_supers+0xc6/0x190 fs/super.c:934
 drop_caches_sysctl_handler+0x8c/0x160 fs/drop_caches.c:64
 proc_sys_call_handler+0x5ec/0x920 fs/proc/proc_sysctl.c:601
 do_iter_readv_writev+0x600/0x880
 vfs_writev+0x376/0xba0 fs/read_write.c:1050
 do_writev+0x1b6/0x360 fs/read_write.c:1096
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f625e20b329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc4d77ac58 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007ffc4d77ae28 RCX: 00007f625e20b329
RDX: 0000000000000001 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f625e27e610 R08: 0000000000000000 R09: 00007ffc4d77ae28
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc4d77ae18 R14: 0000000000000001 R15: 0000000000000001
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

