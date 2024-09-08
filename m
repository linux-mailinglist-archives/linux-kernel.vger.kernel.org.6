Return-Path: <linux-kernel+bounces-319984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0E9704BC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66737B217BD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77FFC11;
	Sun,  8 Sep 2024 01:51:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736193FD4
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725760265; cv=none; b=QzVNP+DicPMyl7/TFMKVYIYtFDFy5vNgOlt89YDy2x8YM9Jq4QmRrQ5EVi99Cy6KyL3aSDfRQ0VkIu3jStivZ2QXiSNn0jEDug3AOYX4z2jbKksbFZ+cAzNSYUmhBgJaWFS4Zj8YvX1VxLYhwmH1mc8SG6zjendQ1Rcodtyk3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725760265; c=relaxed/simple;
	bh=3oof+d/sEUwvXhBHjVxJg/xFjRfQAnvjc7M6WruSWyg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LO+HXU1xPrvVQSsyrhbn9x5hrSSiH5k68HmIabQ8FKZ4eayzhwqH+I1W8KitUq6Jt8hnVn+9U72APj2d82bokTWwKGNWTn59LqlxetDMhcbopo0wRBWWoTF7FlASdIK0iDuJZSS2GnlJ5UVVN0Tb6MkwwrN+i9HNITiK99wAHPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a045e7ed57so60230155ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 18:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725760262; x=1726365062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsPndAlw+A4Qdm5HdVelBDNSmtYuiuWWNv6zLYxik7w=;
        b=Ivvdfo31zze6n3zwTuFbW4O1ejl5qmsBziRmZsLG/qdD/v1nNaiM3cZLp4XwLwL1Jh
         E5xlAYXDZg8LqofMvvuWsP8j9hXwCBItarOlK8VhmuGo/DgHxwqRno5wA2sxP33ecgdw
         E0+qgxw7JXdjGpC95QCIq9nCDQiVrByWPWvgmPqg2VhOQt4QT+UtnxzMc1R95tgwAJZi
         sbXlozdqNxr2efZ5pmWOAumMkNy9cLU7MoCfMb5tgqMF95UCY2+rPFzx71EG/xoz8wJ4
         BsbVGiDMDPA0np5LtL5D0TMvAJOX1E/gOZ+EJZiTNPOI9+KE0HxDNhQQtJMXoVFoj8f4
         cq1w==
X-Forwarded-Encrypted: i=1; AJvYcCWX2IXDgq0HnZlYUPklPsqUWXsjU7VSkzr2qcst2j0HjHPCUcgtJtFnIDCH1p5h3Du6Q3kkFrwlQtpDu0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Qg+53ym817iJUAAPn6GiPiYLneFWOwD9VYtxtI3ZL7iwHs9r
	eSDlAauzWl5QoHIzkgCjvfEMWRqkk5OnDknjfBRWg1QxKgUtNVK4XPp/24AlkV0NSw386d/fUuC
	iO4yXsmxoL5Pb8JnJp6q0SOC2ualGeoI9mnx9GeDN9VgOgd5Ed8Ow7/Y=
X-Google-Smtp-Source: AGHT+IFQb7bOhqBR9rq8ZalT5CE4Y69SPX86GTOf9AwGxDmUlm3UnhFIVJtf3YcGlW9gXvGQ27aWrUNp3TtlnYpeb6pqiLPNiV4j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b06:b0:3a0:4a63:e7b3 with SMTP id
 e9e14a558f8ab-3a056868d66mr33198245ab.9.1725760262622; Sat, 07 Sep 2024
 18:51:02 -0700 (PDT)
Date: Sat, 07 Sep 2024 18:51:02 -0700
In-Reply-To: <tencent_76044DF76E976446D4336AC37A297143A105@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006be4e0062191df02@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hci_conn_failed

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0 Not tainted
------------------------------------------------------
kworker/u9:6/7098 is trying to acquire lock:
ffff888025470aa0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: touch_work_lockdep_map kernel/workqueue.c:3890 [inline]
ffff888025470aa0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4144 [inline]
ffff888025470aa0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: __flush_work+0x46d/0xc30 kernel/workqueue.c:4176

but task is already holding lock:
ffffffff8fc9caa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
ffffffff8fc9caa8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1265

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (
hci_cb_list_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
       hci_remote_features_evt+0x4dc/0x9e0 net/bluetooth/hci_event.c:3721
       hci_event_func net/bluetooth/hci_event.c:7446 [inline]
       hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7498
       hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4023
       process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (&hdev->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       hci_store_wake_reason net/bluetooth/hci_event.c:7191 [inline]
       hci_event_packet+0x323/0x1180 net/bluetooth/hci_event.c:7494
       hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4023
       process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0
 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       touch_work_lockdep_map kernel/workqueue.c:3890 [inline]
       start_flush_work kernel/workqueue.c:4144 [inline]
       __flush_work+0x477/0xc30 kernel/workqueue.c:4176
       __cancel_work_sync+0x10c/0x130 kernel/workqueue.c:4332
       l2cap_conn_del+0x55c/0x780 net/bluetooth/l2cap_core.c:1803
       l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7242
       hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
       hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1265
       hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
       abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
       hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
       process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  (work_completion)(&hdev->rx_work) --> &hdev->lock --> hci_cb_list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hci_cb_list_lock);
                               lock(&hdev->lock);
                               lock(hci_cb_list_lock);
  lock((work_completion)(&hdev->rx_work));

 *** DEADLOCK ***

6 locks held by kworker/u9:6/7098:
 #0: 
ffff88803384c148 (
(wq_completion)hci2
){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000adcfd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff888025470d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:327
 #3: ffff888025470078
 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5564
 #4: ffffffff8fc9caa8 (hci_cb_list_lock){+.+.}-{3:3}
, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1265
 #5: ffffffff8ddb9fe0
 (rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
, at: start_flush_work kernel/workqueue.c:4118 [inline]
, at: __flush_work+0x103/0xc30 kernel/workqueue.c:4176

stack backtrace:
CPU: 1 UID: 0 PID: 7098 Comm: kworker/u9:6 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 touch_work_lockdep_map kernel/workqueue.c:3890 [inline]
 start_flush_work kernel/workqueue.c:4144 [inline]
 __flush_work+0x477/0xc30 kernel/workqueue.c:4176
 __cancel_work_sync+0x10c/0x130 kernel/workqueue.c:4332
 l2cap_conn_del+0x55c/0x780 net/bluetooth/l2cap_core.c:1803
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7242
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12acabc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10640e00580000


