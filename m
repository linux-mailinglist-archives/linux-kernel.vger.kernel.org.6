Return-Path: <linux-kernel+bounces-184007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D944C8CA15A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8D728202B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0293013A3EE;
	Mon, 20 May 2024 17:27:25 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E713A25F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226044; cv=none; b=sRpF9jRtdc6vZlCovJMwI5ygYgRBQ/ygED581eJSSYGaJD2NnmYAKKWeqPYNZe4sQCkWPMtMXPun0gl+ohAiYaT1RLtWeV75pu6ga1W7ZfA5Ox0ldSetIvUdmJ1CtYBSm42I50aBguo+tNvedNli0mI0FCkphO11KCiXZS6jQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226044; c=relaxed/simple;
	bh=8jKWLpeFqEi0tVoD5PQhedxsvnNt5TsoKIz60c4WXYI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hVT+nJvumJZBWrGuZxG0qQvUGIhF8PMCfXqoerz93Stag4+fhOfnhnMlQg20V/Zr960rNM79fcThK5iZaVnLk4BAb0IVfhonGMO7AUKgp8P4KdFjT/ntEK5hZdBBncZIjsk5IaoXw2yLeFrXGj60PvwMeJa2ohy04SHM3vOLuDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36cc59830caso98691345ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226042; x=1716830842;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p//mry6rvHNJZ1Kgc1osZXQNfn7an4FJuEyoTefgkwo=;
        b=tls6itZShMuAcaA9q5CyvVInwbzROjIkL++mxWsM4vIU07a1TMq5eqatiGf+DDhEmt
         OjwtM137rbuEwzF77mq5DMH8oGxiwn28JAB2NRcNjOcfQmkVAXj06Y+EcR2G8wfdNIIa
         INn0RUWR+1oWRBJr1ajbo1z0JOxL0y4QljN+n8monUp699YOu291MAxd5RcXGAFXSEFD
         byy/6us/HVsr+IihZCGAikbuAh7Y6ueTlpGw+7E1WwHCczRB13onRYF1+ju9XHhe0CbK
         A4nxtiFhoJru02JjMa9Jd8PrjILevb21K3EeDHsmUuAKIFHekzdv5fEvXtl/5LfdIlMS
         kWXA==
X-Forwarded-Encrypted: i=1; AJvYcCWiyfpePl4IvyT2ahDwYCUEhNX86FKMfuedF4z+mIbdbuLdwQCU0cDhj3aebHfZofTQxuFXLc4tCLYJOtFq6b6J0sP+sF7UAmI2ffY8
X-Gm-Message-State: AOJu0YxyzkTZ22DspC769yprhCYHRPGxpvDOdu4ec8N4PhRVsGdvNONj
	lnxOGUBCIO8BMqloFFLjLoMREtL2lQLRGUZ/2Iga+3/k8D241d1BsJD1Vq/hHVsCp2Ws7vNBdtK
	pc2LJJ3kGaHEw3Cz9lw9375RJM0B3doBvmJ49mtzUQWfuF73iwpeV0Sc=
X-Google-Smtp-Source: AGHT+IGgUte79A0RWTyBKxWfP7Yx1SwGSCDLTnFIFLBb96cqkfiCg6+Sew/hUH4YDJhPWe5r9FyxWVfNJYjp0ExFt/o061T+R3wB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24e:0:b0:36c:4c63:9c93 with SMTP id
 e9e14a558f8ab-36dd0b3cd3amr3876885ab.3.1716226042145; Mon, 20 May 2024
 10:27:22 -0700 (PDT)
Date: Mon, 20 May 2024 10:27:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098bb530618e60313@google.com>
Subject: [syzbot] [kernel?] WARNING in try_check_zero
From: syzbot <syzbot+8f70859e7bdfbdc69bda@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb6a9339efeb Merge tag 'mm-nonmm-stable-2024-05-19-11-56' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a0c2b2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2ea586e11acd6ec
dashboard link: https://syzkaller.appspot.com/bug?extid=8f70859e7bdfbdc69bda
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-eb6a9339.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21782c1528d1/vmlinux-eb6a9339.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c377678e8b1/bzImage-eb6a9339.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f70859e7bdfbdc69bda@syzkaller.appspotmail.com

------------[ cut here ]------------
Mixed NMI-safe readers for srcu_struct at 0xffffc9000dac28a8.
WARNING: CPU: 3 PID: 1945 at kernel/rcu/srcutree.c:453 srcu_readers_unlock_idx kernel/rcu/srcutree.c:453 [inline]
WARNING: CPU: 3 PID: 1945 at kernel/rcu/srcutree.c:453 srcu_readers_active_idx_check kernel/rcu/srcutree.c:466 [inline]
WARNING: CPU: 3 PID: 1945 at kernel/rcu/srcutree.c:453 try_check_zero+0x3aa/0x560 kernel/rcu/srcutree.c:1078
Modules linked in:
CPU: 3 PID: 1945 Comm: kworker/3:2 Not tainted 6.9.0-syzkaller-09699-geb6a9339efeb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: rcu_gp process_srcu
RIP: 0010:srcu_readers_unlock_idx kernel/rcu/srcutree.c:453 [inline]
RIP: 0010:srcu_readers_active_idx_check kernel/rcu/srcutree.c:466 [inline]
RIP: 0010:try_check_zero+0x3aa/0x560 kernel/rcu/srcutree.c:1078
Code: e9 8a fe ff ff 80 3d 6e 4b 57 0e 00 0f 85 47 fe ff ff c6 05 61 4b 57 0e 01 90 48 c7 c7 a0 42 2e 8b 4c 89 f6 e8 e7 8e dc ff 90 <0f> 0b 90 90 e9 26 fe ff ff 48 83 c4 48 31 c0 5b 5d 41 5c 41 5d 41
RSP: 0018:ffffc9000d44fb70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffe8ffffd5c100 RCX: ffffffff81510229
RDX: ffff888021a14880 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: 000000000000001d
R13: dffffc0000000000 R14: ffffc9000dac28a8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002054b000 CR3: 000000001e250000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 srcu_advance_state kernel/rcu/srcutree.c:1684 [inline]
 process_srcu+0x3f9/0x1730 kernel/rcu/srcutree.c:1811
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

