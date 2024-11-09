Return-Path: <linux-kernel+bounces-402866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DDF9C2DCB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 15:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9901F21C0A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8F198A22;
	Sat,  9 Nov 2024 14:37:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8D14EC60
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731163049; cv=none; b=u0NUTWMEM3JrB/xti2awXjkoM2DqMVtPqiD09TM91F0LMFm+L/dMaqq2zbyXtvwOjvF1KFEfq3Y7+W6rtqEQrlrLRBQ6YmOz8GcgCLaPtNDjV/9mPNYSxe9Y+tQw53j2FcWUI4bFQ0AMMgVs6cLtfyy93YOUAl0C7zgM/VWYe5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731163049; c=relaxed/simple;
	bh=cSIE7qNjON3ZvMGSjQZorCMQx6wzmUkmQnPA+PjwVSc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JTxtw7HNe3Ifc/LP2B0SYe4tc0feuHMdUshf9gzamaNbXgEM+KLkIi6wSbIr+tmo+BEYIqnaOOG7rgsmUqwSYZ+wYiAKYMeh+Wpxok24ZsJVmNq+jMp7dc1NaD91b4sqOSJizqOqxr3NFMT7rNfIXt7T95KguheJVCz/bNyt6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3cb771556so38256245ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 06:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731163046; x=1731767846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+yIMUbl2KB+6KCrpnMFK1VBIkf6bpmrGOjHzQlPk2o=;
        b=TonmRy6o1SV7E5K3hdAVJ7w1gGpI16LjuvfKuAoBG099H80MjJIQlilsFrsAkmHj/S
         1bD47ma3ZXwayRV4Ieo8A2gpcs/FptQTnB/8jf8KHDMqcfd105dSnLgZUE7ttJMr31af
         yx1VXd8B8FEQiS4DiG3Bp8xqRydUHP1vm0M7OhVADIf2pDKOojxOj5g8xEQqaWZrgYvQ
         ZtBIbRlMK/AtKFVB9ymMIUUag5eEfQieYk31rR6FEmWU94rrxIQLHi0gIFGor3JHWA3e
         hghcdhNx7fhu1FZNtJe+wT853hLjvxEVXvBNxX1DvWtKUOWzJmcVn2eWhPKE2QoKiG2l
         n13Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsfH08r4NfI9PHTQCQNaZqn6bdxVctdAHv2KnV5e/Q3stpqDr14IPFSbggE6Dr46fHbqNEuIOA58Wiai4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7HW2winDWFY5CeHwrGDbOB4aKcGITt1jENlwnKSi/AHSKUsIc
	psNU1pJa5uFotwlA2+rGDKpEdfJdnPpAvz47Pko/6hhVRY7K6F9q7gUsG5bSIs1LmxjOU1PbPp8
	6AdMRqWWeUiWnnH5tlWQlKrUpoh8HK8wLuHeyJKgCvWYyjWucT14ANkw=
X-Google-Smtp-Source: AGHT+IFdnMyUvmeHkNlsWvBaxztj3ATa+2vlmdIvL8TUnywCu8Y0CAVPyxvkEEwaIgZLyCJbL/Ibslq8ZR1dtl79IPCVuFRpSj50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3a6:af3c:56ae with SMTP id
 e9e14a558f8ab-3a6f1a09adamr85629165ab.11.1731163046028; Sat, 09 Nov 2024
 06:37:26 -0800 (PST)
Date: Sat, 09 Nov 2024 06:37:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672f73a6.050a0220.138bd5.0041.GAE@google.com>
Subject: [syzbot] [usb?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    226ff2e681d0 usb: typec: ucsi: Convert connector specific ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13459e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=358c1689354aeef3
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fd60c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e48f2af8afd7/disk-226ff2e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76328e28b54c/vmlinux-226ff2e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab9f75a466a2/bzImage-226ff2e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com

INFO: task udevd:5791 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:26960 pid:5791  tgid:5791  ppid:2861   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x1042/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc285c9b6a
RSP: 002b:00007fffbf7a8838 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055d1a13396f0 RCX: 00007fbc285c9b6a
RDX: 0000000000001000 RSI: 000055d1a13d00f0 RDI: 0000000000000008
RBP: 000055d1a13396f0 R08: 0000000000000008 R09: 0000000000010000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007fffbf7a8d18 R15: 000000000000000a
 </TASK>
INFO: task udevd:5796 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27904 pid:5796  tgid:5796  ppid:2861   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x1042/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc285c9b6a
RSP: 002b:00007fffbf7a8838 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055d1a13396f0 RCX: 00007fbc285c9b6a
RDX: 0000000000001000 RSI: 000055d1a13d00f0 RDI: 0000000000000008
RBP: 000055d1a13396f0 R08: 0000000000000008 R09: 0000000000000020
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007fffbf7a8d18 R15: 000000000000000a
 </TASK>
INFO: task udevd:5798 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27600 pid:5798  tgid:5798  ppid:2861   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x1042/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc285c9b6a
RSP: 002b:00007fffbf7a8838 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055d1a13396f0 RCX: 00007fbc285c9b6a
RDX: 0000000000001000 RSI: 000055d1a13fed80 RDI: 0000000000000008
RBP: 000055d1a13396f0 R08: 0000000000000008 R09: 0000000000000100
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007fffbf7a8d18 R15: 000000000000000a
 </TASK>
INFO: task udevd:5837 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27488 pid:5837  tgid:5837  ppid:2861   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x1042/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc285c9b6a
RSP: 002b:00007fffbf7a8838 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055d1a13396f0 RCX: 00007fbc285c9b6a
RDX: 0000000000001000 RSI: 000055d1a13bf2d0 RDI: 0000000000000008
RBP: 000055d1a13396f0 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007fffbf7a8d18 R15: 000000000000000a
 </TASK>
INFO: task udevd:5838 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27488 pid:5838  tgid:5838  ppid:2861   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x1042/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc285c9b6a
RSP: 002b:00007fffbf7a8838 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055d1a13396f0 RCX: 00007fbc285c9b6a
RDX: 0000000000001000 RSI: 000055d1a13d61f0 RDI: 0000000000000008
RBP: 000055d1a13396f0 R08: 0000000000000008 R09: 0000000000000020
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007fffbf7a8d18 R15: 000000000000000a
 </TASK>
INFO: task udevd:5840 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27488 pid:5840  tgid:5840  ppid:2861   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x1042/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc285c9b6a
RSP: 002b:00007fffbf7a8838 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055d1a13396f0 RCX: 00007fbc285c9b6a
RDX: 0000000000001000 RSI: 000055d1a1345640 RDI: 0000000000000008
RBP: 000055d1a13396f0 R08: 0000000000000008 R09: 0000000000000000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007fffbf7a8d18 R15: 000000000000000a
 </TASK>

Showing all locks held in the system:
7 locks held by kworker/0:1/9:
2 locks held by kworker/u8:0/11:
6 locks held by kworker/1:0/24:
 #0: ffff8881062c7548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000019fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88810af01190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff88810af01190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888112a29190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888112a29190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888113966160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888113966160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888113966160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff89bd82a8 (input_mutex){+.+.}-{3:3}, at: __input_unregister_device+0x136/0x450 drivers/input/input.c:2272
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:8/2240:
 #0: ffff888100abb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003fafd80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffffffff8a18d750 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xbb/0xb40 net/core/net_namespace.c:580
1 lock held by acpid/2846:
 #0: ffffffff88ec6a38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
2 locks held by getty/2921:
 #0: ffff8881121220a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
4 locks held by udevd/5791:
 #0: ffff8881115fb0a0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88811769e088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888108f5b878 (kn->active#3){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88810af01190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88810af01190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/5796:
 #0: ffff88810db8dd58 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88811df55488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888108f5b878 (kn->active#3){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88810af01190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88810af01190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/5798:
 #0: ffff888131f13668 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88811769f488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88810af37008 (kn->active#3){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88810b349190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88810b349190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
6 locks held by kworker/0:3/5806:
 #0: ffff8881062c7548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001ac7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88810b36b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff88810b36b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811f7f3190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811f7f3190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88811f5b5160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88811f5b5160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88811f5b5160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff89bd82a8 (input_mutex){+.+.}-{3:3}, at: __input_unregister_device+0x136/0x450 drivers/input/input.c:2272
4 locks held by udevd/5819:
 #0: ffff888112ca6e80 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff8881198cac88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888108f58a58 (kn->active#3){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88810afd1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88810afd1190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/5837:
 #0: ffff88811529ae80 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff8881198cb088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888108f58a58 (kn->active#3){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88810afd1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88810afd1190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/5838:
 #0: ffff88811529ad58 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff8881198c8088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88810af46d28 (kn->active#3){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88810b36b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88810b36b190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
1 lock held by udevd/5840:
 #0: ffffffff88ec6a38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
4 locks held by udevd/5842:
 #0: ffff888112ca6668 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88811adac488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88810af46d28 (kn->active#3){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88810b36b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88810b36b190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
2 locks held by kworker/u8:7/6505:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000203fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:13/6524:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002ccfd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:14/6526:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002cefd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:16/6530:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002d2fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
1 lock held by modprobe/6557:
1 lock held by modprobe/6559:
1 lock held by modprobe/6560:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
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
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6561 Comm: modprobe Not tainted 6.12.0-rc6-syzkaller-00103-g226ff2e681d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x13/0x70 kernel/kcov.c:217
Code: 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 15 e4 d0 ad 7e 65 8b 05 e5 d0 ad 7e <a9> 00 01 ff 00 48 8b 34 24 74 1d f6 c4 01 74 43 a9 00 00 0f 00 75
RSP: 0000:ffffc90002d1fad0 EFLAGS: 00000293
RAX: 0000000080000001 RBX: ffffc90002d1fc68 RCX: ffffffff81885d98
RDX: ffff888133113a80 RSI: 0000000000000002 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0008ff9480
R13: 000000000000002d R14: ffff8881110d3440 R15: dffffc0000000000
FS:  00007f43362ce380(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f43362fc991 CR3: 0000000112e72000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 xas_next_entry+0x213/0x3c0 include/linux/xarray.h:1715
 next_uptodate_folio+0x29/0x4b0 mm/filemap.c:3493
 filemap_map_pages+0x5cb/0x13d0 mm/filemap.c:3686
 do_fault_around mm/memory.c:5255 [inline]
 do_read_fault mm/memory.c:5288 [inline]
 do_fault mm/memory.c:5431 [inline]
 do_pte_missing mm/memory.c:3965 [inline]
 handle_pte_fault mm/memory.c:5766 [inline]
 __handle_mm_fault+0x1e12/0x33b0 mm/memory.c:5909
 handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
 do_user_addr_fault+0x613/0x12c0 arch/x86/mm/fault.c:1338
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f43362fc991
Code: Unable to access opcode bytes at 0x7f43362fc967.
RSP: 002b:00007ffc553f3418 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007f43365d0570 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f4336323178
RBP: 0000000000000003 R08: 0000000000000000 R09: 000000000000000d
R10: 00007ffc553f30f0 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffc553f34b8 R14: 00007ffc553f34e0 R15: 0000000000000000
 </TASK>


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

