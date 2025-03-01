Return-Path: <linux-kernel+bounces-539935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB75A4AB00
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B7E1898194
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD771CF284;
	Sat,  1 Mar 2025 12:45:27 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821C1E4BE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740833126; cv=none; b=VE7DRry6gG2QHvpuC5x5RKESuaC+A9Mbl8tl5qduQg3WGqjWqce8Znxfnx/+jyh1NXFBNwgrelJTUJllyxNTcFvn18CiuUcIpQOjZELOTDivdEG2nquPbvoyZ5Nv8CBKrp0oUD0ZzluSNrdAGalt3S6IpECC8WgnnjaLzmqlYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740833126; c=relaxed/simple;
	bh=nge10YJ9o3E9q9UptcYzZwL7sKC0Uq263Ftv4GNbgWo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n+7KtP3AmC2OIw5/8GU8vFZ8RmDGZ27/Ee9OYY14grH96atN3RZO5UhSH+a/X5sYYntmgn0XcwoUDCB2axyPmNQeXPdb30Fjq2nYFtA0gxz7s4rcYJzdp4lPXtIziwoOJgcD0Gn1XDTWima2AxotPSayQKg5wdoVp6jAp7IwZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d054d79dacso58053635ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 04:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740833124; x=1741437924;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Q95zOLSYKCLrzAjQokGWyvnP2OsuHAOqXHJfcqwyKo=;
        b=HE8Cq8JFTsveB9AjeNADT+i194cGY+E4jgHtQ1lkzRPzHVPtJA2TVdUn3+QZlOqNU7
         8AjSq8OeGiaB2D7ZpQZ4pGCvQyEau58s5phTxHNnFDcVr3Vlh0RhSu66F+dP+c4Qo5ta
         FVgrexECNxze0HTw1HLCb8sWaxTeOiiubCBQBge4gDeUkxog7yLVFFrWVXm3Peq01BXp
         urmL7vB9VbHMdJVmAI78oyKlIVStaG4e5RIx/UcPw7gJr9666rMSWQd3hxYyFvJES4hY
         WRj9DzyIR5K8H6N7XNOnIM97DE1jI24G4/R3HVvBc7exq6nrwBAB1xrtqF3cDZM4ZxdP
         tdYA==
X-Forwarded-Encrypted: i=1; AJvYcCVo6QbH8eX3LT/S2PIHVD8DLKly/roGEHYw9qbOERWu3pDaczzNSsrGzkq2jZMZB4br5GvzrsJAA8ZgfHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Wlold5HIxP25ltQ7/x1xPwDgb1dR+ap8SaLzcE8z1ZOjxs8e
	b9kSS823woYDRoWg/SHn49IBAwP42bPYSfbntBJG49gEcLK9Osvzn2nBX2GdY6ay9d/gND2EIAu
	V0gf0SFOjVsqJ81/Ze8c3IFMQc5fTdRkffOj2/BS0eKrLwnq43Fhwg2w=
X-Google-Smtp-Source: AGHT+IE5s3royZQYoqIz9BOPOExK81G7mfqUYFmrRU/4SNieha6SBeizmY8gV4VqmfFf+0UXzsYSDo0j7wz+nYO9nrb4GSPcuqKI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3d3:dcfd:2768 with SMTP id
 e9e14a558f8ab-3d3e6e458d8mr75129835ab.4.1740833124198; Sat, 01 Mar 2025
 04:45:24 -0800 (PST)
Date: Sat, 01 Mar 2025 04:45:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c30164.050a0220.dc10f.0167.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in exit_itimers
From: syzbot <syzbot+d9da13b17db05637e02d@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173537a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=299fb852e91f4f3c
dashboard link: https://syzkaller.appspot.com/bug?extid=d9da13b17db05637e02d
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-d082ecbc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdb92972b307/vmlinux-d082ecbc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15450a9ada87/Image-d082ecbc.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9da13b17db05637e02d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 21835 at kernel/time/posix-timers.c:1109 exit_itimers+0x238/0x34c kernel/time/posix-timers.c:1109
Modules linked in:
CPU: 0 UID: 0 PID: 21835 Comm: syz.0.5419 Not tainted 6.14.0-rc4-syzkaller #0
Hardware name: linux,dummy-virt (DT)
pstate: 21402009 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : exit_itimers+0x238/0x34c kernel/time/posix-timers.c:1109
lr : itimer_delete kernel/time/posix-timers.c:1081 [inline]
lr : exit_itimers+0x17c/0x34c kernel/time/posix-timers.c:1103
sp : ffff800088ffbbf0
x29: ffff800088ffbbf0 x28: 0000000000000001 x27: f0f0000007b99a38
x26: 0000000000000000 x25: 0000000000000000 x24: f0f0000007b99240
x23: 0000000000000000 x22: f0f0000007b99240 x21: f0f0000007b99240
x20: 0000000000000001 x19: f0f0000007b99240 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffea2d02c8
x14: f0f0000007b992c0 x13: ffff8000828500c8 x12: 0000000000000001
x11: 00000355b7b9e14b x10: 5d48c5ec52c2bb1a x9 : b4052c63a0d52864
x8 : ffff800088ffbe38 x7 : fdf0000003263488 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000001000001 x3 : 00000000000001f4
x2 : fff000007f8d0758 x1 : f0f0000007b99240 x0 : fdf0000016d5fb60
Call trace:
 exit_itimers+0x238/0x34c kernel/time/posix-timers.c:1109 (P)
 do_exit+0x17c/0x98c kernel/exit.c:912
 do_group_exit+0x34/0x90 kernel/exit.c:1087
 copy_siginfo_to_user+0x0/0xec kernel/signal.c:3036
 do_signal+0x94/0x360 arch/arm64/kernel/signal.c:1658
 do_notify_resume+0xd8/0x164 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xc0/0xe0 arch/arm64/kernel/entry-common.c:745
 el0t_64_sync_handler+0x10c/0x138 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:600
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
rcuref - imbalanced put()
WARNING: CPU: 0 PID: 21835 at lib/rcuref.c:267 rcuref_put_slowpath+0xbc/0xd0 lib/rcuref.c:267
Modules linked in:
CPU: 0 UID: 0 PID: 21835 Comm: syz.0.5419 Tainted: G        W          6.14.0-rc4-syzkaller #0
Tainted: [W]=WARN
Hardware name: linux,dummy-virt (DT)
pstate: 61402009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : rcuref_put_slowpath+0xbc/0xd0 lib/rcuref.c:267
lr : rcuref_put_slowpath+0xbc/0xd0 lib/rcuref.c:267
sp : ffff800088ffbbd0
x29: ffff800088ffbbd0 x28: 0000000000000001 x27: f0f0000007b99a38
x26: 0000000000000000 x25: 0000000000000000 x24: f0f0000007b99240
x23: 0000000000000000 x22: f0f0000007b99240 x21: f0f0000007b99240
x20: 00000000ffffffff x19: fdf0000016d5fc28 x18: 000000000001cf9f
x17: 0000000000000000 x16: 0000000000000000 x15: ffff800088ffb560
x14: 00000000ffffffea x13: ffff800088ffb988 x12: ffff80008292d920
x11: fffffffffffd8010 x10: fffffffffffd7fe8 x9 : 0000000000009be8
x8 : c0000000ffffe67f x7 : ffff80008287d898 x6 : 0000000000023ba8
x5 : ffff8000828a14c8 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f0f0000007b99240
Call trace:
 rcuref_put_slowpath+0xbc/0xd0 lib/rcuref.c:267 (P)
 __rcuref_put include/linux/rcuref.h:94 [inline]
 rcuref_put include/linux/rcuref.h:150 [inline]
 posixtimer_putref include/linux/posix-timers.h:226 [inline]
 posix_timer_cleanup_ignored kernel/time/posix-timers.c:977 [inline]
 exit_itimers+0x334/0x34c kernel/time/posix-timers.c:1114
 do_exit+0x17c/0x98c kernel/exit.c:912
 do_group_exit+0x34/0x90 kernel/exit.c:1087
 copy_siginfo_to_user+0x0/0xec kernel/signal.c:3036
 do_signal+0x94/0x360 arch/arm64/kernel/signal.c:1658
 do_notify_resume+0xd8/0x164 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xc0/0xe0 arch/arm64/kernel/entry-common.c:745
 el0t_64_sync_handler+0x10c/0x138 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:600
---[ end trace 0000000000000000 ]---


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

