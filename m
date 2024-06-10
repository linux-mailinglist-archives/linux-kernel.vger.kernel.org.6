Return-Path: <linux-kernel+bounces-208688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1EA902822
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820BF1F232BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB614900C;
	Mon, 10 Jun 2024 17:58:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537E14BF89
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042284; cv=none; b=g4KQvKI+HO5c4vhlHuPahgvwgQ/lcZvrblSl5rIdvYzQ7LYQo4AdiaV4uVc3GOAezJiHwYr/LzpN44TJv7anMQngpQLSboo+We+NYf/x448COYZzbgcV2ShzRanLJJOFHIxefP6z3oSAdvWS+7j2xfnCmO5S52ERnLxfJxI1uyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042284; c=relaxed/simple;
	bh=CZtH7Ao+C5oTSuA5K4jC2pck/kyUckCO8qhUQIFgIrg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IeqLHcHRb1H8EnU4YK+tJhkgghIMiJtnp3yJJ88XwPdsNp12y0BdUv6bDf55y7jQic3JdfvxA+oKDZMHX5uQpagySD/1eOm9lVkVt+zC3Qw5oPvLsrNhjFvevuaxitNJPe05wbNNRx2nEvln02iaNeoTAHj2T/WHOi2jWesveWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e94cac3ee5so20793439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042282; x=1718647082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MU+323og30grVWQXcxG4YNn0xgi84AVzfHAxcCczLpE=;
        b=uthWtTDjS6aogkHXcBqoKGHI5HgK+szfCRJzD3cdShlIyeVUDUHrTD1sIfxNl2scGr
         uSXw37/kkJ/a/g+rIpFoiNbto3ssZtqrJTJcmb3UVe7wIF8iV52falyztSAx7pNRnxKR
         /988ENiNyrrs++FSJXXYLtKgyimkFQmXv/7lgsxfgks/tl7dq0rVvFwHT34/340fcaIM
         j+VdJ6yvsBlnaIG573ZippYIuRVEVg4t+VLM0+wJp0tyeMJSd/jfHpfC08uV8LXHGzs2
         yqKPPdaHcuro8Kc5y2My/ahh1ag5dKB/IIFzdxxKJl7Jf5zGASE51UgEwyDY9uGYRUwl
         LUuw==
X-Forwarded-Encrypted: i=1; AJvYcCUmB7pYJmFoxvk29WNB/zjcDaF9rkDyehKYGwqihnCgx7KyjRx9xR1PP1V+5xO0XSUcjMUHUKQ3lccMOj5yDHd5ft0eFFr8spZ/5k/l
X-Gm-Message-State: AOJu0YwfUlC4Jbg1KEZxEH/vK7+WTnHFyNKJ8q3CkH2foE+FA4kt1p3u
	6mb2aNimEX3ykLdZ2pDFDRFdOIRNGgWlAtcKyuYTwSeLYj0MNgLmwCkS/sJYbwSWUtg6QL1rzwc
	btOKCgHS6bnxuePMjDV4j2/GjIGQIYVrfbyZsYLPadDp1bqe9Td1RPoA=
X-Google-Smtp-Source: AGHT+IHqdhYEA70jCGH19iPxU6tBAhR8yxwgdzCpzeCFLSAGYeIj3djXjDo3eIKB6v4HQUYEoBhOYIk92QM1vh6RyXhM5QuPmVuw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d17:b0:7eb:7e4a:8ea9 with SMTP id
 ca18e2360f4ac-7eb7e4a92e3mr22432339f.4.1718042282049; Mon, 10 Jun 2024
 10:58:02 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:58:02 -0700
In-Reply-To: <e8b8013b-d8b4-4eee-8643-1d512aa17133@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee54e1061a8ce3f6@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in raw_ioctl
From: syzbot <syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: soft lockup in raw_ioctl

dummy_hcd dummy_hcd.0: urbp 000000006bf6c1dd 40409880 next_frame 0000000000000000
cdc_wdm 1-1:1.0: nonzero urb status received: -71
cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
dummy_hcd dummy_hcd.0: urbp 000000003f481f40 40409880 next_frame 000000003f481f40
watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [syz-executor415:10796]
CPU#0 Utilization every 4s during lockup:
	#1:  95% system,	  1% softirq,	  5% hardirq,	  0% idle
	#2:  95% system,	  1% softirq,	  5% hardirq,	  0% idle
	#3:  95% system,	  2% softirq,	  5% hardirq,	  0% idle
	#4:  95% system,	  1% softirq,	  5% hardirq,	  0% idle
	#5:  95% system,	  2% softirq,	  5% hardirq,	  0% idle
Modules linked in:
irq event stamp: 223968
hardirqs last  enabled at (223967): [<ffff80008037bc00>] console_emit_next_record kernel/printk/printk.c:2935 [inline]
hardirqs last  enabled at (223967): [<ffff80008037bc00>] console_flush_all+0x650/0xb74 kernel/printk/printk.c:2994
hardirqs last disabled at (223968): [<ffff80008af10ec0>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (223968): [<ffff80008af10ec0>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (223962): [<ffff8000801ea530>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (223962): [<ffff8000801ea530>] handle_softirqs+0xa60/0xc34 kernel/softirq.c:582
softirqs last disabled at (223957): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
CPU: 0 PID: 10796 Comm: syz-executor415 Tainted: G        W          6.10.0-rc2-syzkaller-00003-g8867bbd4a056-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:176 [inline]
pc : arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
pc : console_emit_next_record kernel/printk/printk.c:2935 [inline]
pc : console_flush_all+0x67c/0xb74 kernel/printk/printk.c:2994
lr : console_emit_next_record kernel/printk/printk.c:2935 [inline]
lr : console_flush_all+0x678/0xb74 kernel/printk/printk.c:2994
sp : ffff80009c6d7380
x29: ffff80009c6d7480 x28: ffff80009c6d7530 x27: 0000000000000001
x26: ffff80009090b530 x25: ffff80009090b520 x24: dfff800000000000
x23: 1ffff000121216af x22: dfff800000000000 x21: ffff80009090b578
x20: 0000000000000000 x19: 00000000000000c0 x18: ffff80009c6d72b8
x17: 000000302e646368 x16: ffff80008033878c x15: 0000000000000001
x14: 1ffff00011e379c8 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000dac7bc80 x7 : ffff800080381d44 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000000000080 x0 : 0000000000000000
Call trace:
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
 console_emit_next_record kernel/printk/printk.c:2935 [inline]
 console_flush_all+0x67c/0xb74 kernel/printk/printk.c:2994
 console_unlock+0xec/0x3d4 kernel/printk/printk.c:3063
 vprintk_emit+0x1ec/0x350 kernel/printk/printk.c:2345
 vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2360
 vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
 _printk+0xdc/0x128 kernel/printk/printk.c:2370
 usb_gadget_register_driver_owner+0x1f0/0x224 drivers/usb/gadget/udc/core.c:1711
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:595 [inline]
 raw_ioctl+0x10c0/0x33bc drivers/usb/gadget/legacy/raw_gadget.c:1306
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 532 Comm: kworker/u8:6 Tainted: G        W          6.10.0-rc2-syzkaller-00003-g8867bbd4a056-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: bat_events batadv_nc_worker
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : lock_release+0x500/0x9cc
lr : lockdep_recursion_finish kernel/locking/lockdep.c:467 [inline]
lr : lock_release+0x4c4/0x9cc kernel/locking/lockdep.c:5776
sp : ffff8000988e78e0
x29: ffff8000988e79b0 x28: ffff80008f1c76a0 x27: dfff800000000000
x26: 1fffe00018cc6517 x25: ffff0000c6632910 x24: ffff0000c6631e40
x23: ffff0000c66328b8 x22: 00000000ffe2000d x21: 73559e3b58d8591b
x20: 0000000000000002 x19: ffff0001b3db6000 x18: 1fffe000367b6bde
x17: ffff80008efed000 x16: ffff80008af15aa8 x15: 0000000000000001
x14: ffff80008eff0558 x13: dfff800000000000 x12: 000000001635a668
x11: 0000000061619286 x10: 0000000000ff0100 x9 : ffff80008ef36000
x8 : 0000000000000000 x7 : ffff80008ac4e1b0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000008 x1 : 0000000000000080 x0 : 0000000000000001
Call trace:
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
 lock_release+0x500/0x9cc kernel/locking/lockdep.c:5777
 rcu_lock_release+0x2c/0x38 include/linux/rcupdate.h:339
 rcu_read_unlock include/linux/rcupdate.h:812 [inline]
 batadv_nc_process_nc_paths+0x28c/0x324 net/batman-adv/network-coding.c:699
 batadv_nc_worker+0x3c4/0x580 net/batman-adv/network-coding.c:728
 process_one_work+0x7b0/0x15e8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:3393
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


Tested on:

commit:         8867bbd4 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=137ec67a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=5f996b83575ef4058638
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151eb522980000


