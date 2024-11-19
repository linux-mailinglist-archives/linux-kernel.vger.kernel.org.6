Return-Path: <linux-kernel+bounces-413699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D49D1D59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5CB23F04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063483CC1;
	Tue, 19 Nov 2024 01:31:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BE25634
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979883; cv=none; b=tlamGHNurSByzs3gdptmTh4oZXqaAGxOA8gBWfzmmpGk8QLRuaaUYs1W6agX3uwFuys7OQyl0xKkL9M7TtzdAS1BNrTJZZLoZ7Jn1nCraas3S7KCs3uEpnGdUeHofvizkboqnxBQdvI49K3BUfRK77U9CeyF7d4ns+CPqeO1v2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979883; c=relaxed/simple;
	bh=HzqeGSIHkDYtNxsS0GEB2VlS9uAPvgfjv8f39/id4EA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JVwfnprMTlK9Ynf0yj3S9osuN9ta+XMoTrEjBXDtudT1enTAa9jds8v8vqNIuz5jOB9Uv4VoQIBb+vSiN9Ft7hD6Tn6i6WzSRQTRCfhdcaup7TVmdqMm7yj+Cwfy1lGd1+o9B/eXvNgz6dmdu051V31H8vBEqXF4i7or05AuXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a715ac91f6so41228615ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979881; x=1732584681;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6EjDLjjtQ68xGBuwGRxdUrqM8C5RZmamt1lDWE5w9g=;
        b=fXPfyCCANAww71uTJ5ur6IlFm414QYRjBRLZm5gdh6dF5LzJiosC2a3J01fueNs3GJ
         FRXteNCSnIvMsFXz3eBtrOeQip+/S1C7gPVBVPBPvvLrTNc9HrnTu1bUnpkQ9NLXDj7R
         NU5sdteZruj315rWx2eRvPBVWNtcUaQdwf+WV0/fYNGz2y5O8E83IznXVShIaXkjPxGI
         JXApochMGttjxtQhllVSO7y0Hp01vKUt+PsYaRRUE+VxlOJNUZimEgCRyAxkBRaYTq3y
         X+vIFDH4o6L+k+l+lbb/g+LVu6wcEqetURRglOKjFZ4OIlOofPCK14+TdvNNipwFQv+Z
         hoaw==
X-Forwarded-Encrypted: i=1; AJvYcCWIOL/KC7QhGdToBD/LbA3y50jk7EMPpSl+WRSa+mV/S2AYiAE11XARpZksMXDJoLoDBzy9IGhM7u9l0w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj931z/PHMyNyD5/a980kaoh5sDpIDLk30Junj6ZHCOr2wJf6t
	J/M/rHPm0rnnEL/1A2tRDRwmANM73UogLGAxiEWleF9OAmiaqxx2C59PixwbtOse6Ki6Cj04bQ8
	2wddoox8YfDpQ9GueJGsbibdiY71wYu/u1v3jjpILZwEDz+iNZhrnVmo=
X-Google-Smtp-Source: AGHT+IHOoxjL4Xq4d3UyvEdls8RH9GHMu6BOLYRDy5KOxpfuN4r1O0xA6FL8YQvee5NfcCtpcDu/9lWwkFmYbVyixVRDt0H0OSff
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a02:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a74800eedamr139156545ab.7.1731979881303; Mon, 18 Nov 2024
 17:31:21 -0800 (PST)
Date: Mon, 18 Nov 2024 17:31:21 -0800
In-Reply-To: <000000000000bd671b06222de427@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673bea69.050a0220.87769.0061.GAE@google.com>
Subject: Re: [syzbot] [net] INFO: task hung in tun_chr_close (5)
From: syzbot <syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jason@zx2c4.com, jasowang@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9fb2cfa4635a Merge tag 'pull-ufs' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a57378580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31661728c1a4027
dashboard link: https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1026f2e8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9fb2cfa4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e676eb2a9e5f/vmlinux-9fb2cfa4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/abff576e0e8f/bzImage-9fb2cfa4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com

INFO: task syz-executor:5443 blocked for more than 143 seconds.
      Not tainted 6.12.0-syzkaller-00233-g9fb2cfa4635a #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20280 pid:5443  tgid:5443  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x184f/0x4c30 kernel/sched/core.c:6693
 __schedule_loop kernel/sched/core.c:6770 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6785
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6842
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 __fput+0x23c/0xa50 fs/file_table.c:450
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16a3/0x1740 kernel/signal.c:2918
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f250b78049a
RSP: 002b:00007ffd42ecadc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: 0000000000000000 RBX: 00007ffd42ecadf0 RCX: 00007f250b78049a
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007ffd42ecadec R09: 00007ffd42ecb207
R10: 00007ffd42ecadf0 R11: 0000000000000246 R12: 00007f250b90a500
R13: 00007ffd42ecadec R14: 0000000000000000 R15: 00007f250b90c000
 </TASK>
INFO: task syz-executor:5449 blocked for more than 148 seconds.
      Not tainted 6.12.0-syzkaller-00233-g9fb2cfa4635a #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20752 pid:5449  tgid:5449  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x184f/0x4c30 kernel/sched/core.c:6693
 __schedule_loop kernel/sched/core.c:6770 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6785
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6842
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 __fput+0x23c/0xa50 fs/file_table.c:450
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16a3/0x1740 kernel/signal.c:2918
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f853b18049a
RSP: 002b:00007fff077d36d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000037
RAX: 0000000000000000 RBX: 00007fff077d3760 RCX: 00007f853b18049a
RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007fff077d36fc R09: 00007fff077d3b17
R10: 00007fff077d3760 R11: 0000000000000202 R12: 00007f853b30b280
R13: 00007fff077d36fc R14: 0000000000000000 R15: 00007f853b30c000
 </TASK>
INFO: task kworker/0:8:5617 blocked for more than 152 seconds.
      Not tainted 6.12.0-syzkaller-00233-g9fb2cfa4635a #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:8     state:D stack:25104 pid:5617  tgid:5617  ppid:2      flags:0x00004000
Workqueue: events switchdev_deferred_process_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x184f/0x4c30 kernel/sched/core.c:6693


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

