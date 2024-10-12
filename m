Return-Path: <linux-kernel+bounces-362028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E922B99B018
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA4E284410
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E7171CD;
	Sat, 12 Oct 2024 02:31:26 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A4881E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728700286; cv=none; b=WQ45yKEah+MsXEvXv6vIi8nxeVAKYb4eY9kx/neuKA8b67E9GWMFm405BwFthdK4+nvi/s+AvqbJWNS6gq/+r/c78MjR+tKQA/kKcX5KqRGLPucZcpFgH9RjonnOUZY3KdwrkSCikcUFrVAywaCcK320t1DpNXxhqlSxfbpDoF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728700286; c=relaxed/simple;
	bh=6unqlADF3sL9V14LakHrtpw9PuIZIUKyuzYItMO8Mhw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WONUmSC3XWKihgDUalEauyfi5jdFvYSxjvNM0cFe1VZSxZPFsBV78cMXAvO/0JzUaLJX6vbfmrj9zm7+/BYVTtZSqHcK5ElsryD6xCnBABc4DBgPfwaDOFVSMIiKpBOXu4yhYe6lEZ96cVl1UdL8Cv3vs/rXZnK+Xmkh4S9D0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83780092c0eso133412639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728700283; x=1729305083;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/NT18ZP7H1i4ohN1wAlSyANSX4TDDScvJRki6DI9aE=;
        b=KkX1S4EKHzyLhgI9sTibhgChIVmyLCPD8nkD/UDhk25/XcGfn94V8GrLMNN7B0U7yu
         Enkw1jgLl4WcJKt5089hTiy0BLDJ8j68sStnNY4B6VEzdHbVFLNn9bECEbwT7Vbcktzi
         BRAWNaKtibkfQi2W/0142NKKLybpZNwkGnb+rReVHqSIdfqKqY8VBRwcYkvb+W8OWrRl
         Zce5A6fFkG440sH7HtQYczo8DERehUh3rZnHOAYXO6A7o1Vzxor8OsoGUDmH04zzR3mO
         rEoNlaG1xODlZvQVmr1DK2qHk5a2GJuVEYFJ/m1N6Gxf8uhRbW/IZZUlzxD0P2znAQJI
         1Ruw==
X-Forwarded-Encrypted: i=1; AJvYcCUceUZM5B1LhkOu9SyFbNDBziBml/IaPxlzZazPs9YqszXDXtSTYQcToCsbvXNGXxZ29nyFPvojTxzQTRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFJvd/vCfOH7NIwGReYVei2ecJH/iNX4KzCo5qoV9vzDu/RXx
	J112a+gEi2kAKLxWOL/ue0Zv+h5JRQRoFK+/iRdlNzqhFsT3XLrBGZqPaLlfEpeNGNbJr84SZSY
	d623y9kQIxv6ZsBP2FvEoqsqdlNFdj6KFCZRtgGT88R47mXmlN+n9mzE=
X-Google-Smtp-Source: AGHT+IHVMPYArUidXGMj1woukUZe3nF19tslJW7Zy3HdiaTPlTLJTXeZSkgwFKkZw5AIrCul1e3xOMPHuAWknVEQeiVG5qJLv1Sl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d2:b0:82a:4480:badc with SMTP id
 ca18e2360f4ac-8379477a6b5mr601728239f.10.1728700283317; Fri, 11 Oct 2024
 19:31:23 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:31:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6709df7b.050a0220.3e960.001d.GAE@google.com>
Subject: [syzbot] [usb?] INFO: task hung in usblp_open
From: syzbot <syzbot+4f6d84a2e9aa11244d06@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zaitcev@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a9fe2a8ac53 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14060f9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=4f6d84a2e9aa11244d06
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/883c5319cb52/disk-4a9fe2a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4421ed2ef/vmlinux-4a9fe2a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8e3beb01d49/bzImage-4a9fe2a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f6d84a2e9aa11244d06@syzkaller.appspotmail.com

INFO: task syz.4.92:5230 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.92        state:D stack:28048 pid:5230  tgid:5229  ppid:2658   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 usblp_open+0x5c/0x450 drivers/usb/class/usblp.c:417
 usb_open+0x186/0x220 drivers/usb/core/file.c:47
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6cb/0x1390 fs/open.c:958
 vfs_open+0x82/0x3f0 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f224985c990
RSP: 002b:00007f22484d6b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f224985c990
RDX: 0000000000000002 RSI: 00007f22484d6c10 RDI: 00000000ffffff9c
RBP: 00007f22484d6c10 R08: 0000000000000000 R09: 00007f22484d6987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2249a15f80 R15: 00007ffce6b96e08
 </TASK>
INFO: task syz.3.105:5273 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.105       state:D stack:28352 pid:5273  tgid:5272  ppid:2659   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 usblp_open+0x5c/0x450 drivers/usb/class/usblp.c:417
 usb_open+0x186/0x220 drivers/usb/core/file.c:47
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6cb/0x1390 fs/open.c:958
 vfs_open+0x82/0x3f0 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1af1aec990
RSP: 002b:00007f1af0760b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1af1aec990
RDX: 0000000000000002 RSI: 00007f1af0760c10 RDI: 00000000ffffff9c
RBP: 00007f1af0760c10 R08: 0000000000000000 R09: 00007f1af0760987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1af1ca5f80 R15: 00007ffe9cbadee8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by getty/2606:
 #0: ffff88810ff360a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/0:5/5002:
 #0: ffff8881066d0548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90004e17d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109755190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109755190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811715c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811715c190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88811af2b160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88811af2b160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
1 lock held by syz.0.87/5225:
 #0: ffffffff89a94808 (usblp_mutex){+.+.}-{3:3}, at: usblp_release+0x79/0x310 drivers/usb/class/usblp.c:480
2 locks held by syz.4.92/5230:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
 #1: ffffffff89a94808 (usblp_mutex){+.+.}-{3:3}, at: usblp_open+0x5c/0x450 drivers/usb/class/usblp.c:417
2 locks held by syz.3.105/5273:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
 #1: ffffffff89a94808 (usblp_mutex){+.+.}-{3:3}, at: usblp_open+0x5c/0x450 drivers/usb/class/usblp.c:417
1 lock held by syz.1.118/5810:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.128/6551:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.141/6898:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.166/7399:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.177/7814:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.188/8335:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.190/8384:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.192/9283:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.202/10247:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.243/10379:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.244/10410:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.254/10690:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.254/10691:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.272/12354:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.257/12374:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.278/12557:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.278/12560:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.282/12591:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.282/12592:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.305/14393:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.289/14477:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.317/14499:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.317/14500:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.317/14501:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:111


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

