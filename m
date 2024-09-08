Return-Path: <linux-kernel+bounces-319990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530A19704D5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C131C21260
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 02:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E71CAB8;
	Sun,  8 Sep 2024 02:29:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4418E06
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725762545; cv=none; b=EY0HOXuAWVkGJGP+BVJHkCCPAcNCnFJeambWlPUJD5v7I8wiQSZbKYVYD4d8bwto12RVEKAufxyZjdWcL7kZV4X3cF2W/m/qYKe4j8TdocBSaYuYh1y0AY9wocV7Vk65hpVUt0H9juPgyBh2vCnsse4VKDXcHKM+YKeZjFF/6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725762545; c=relaxed/simple;
	bh=+XKiIObvSCPSAgX7pAurM4jZ8EGmkt1FMDRQUDTBGjU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r1BJuX5eS4ydPiYeUiWk+BXps9C4355MfqqBYR1GjSnSbF0lFRAvQVEs6gdBgpf9+jfyQXUgrkPM0wQeteduNMtDpGmBjiI2q3vDqTmVqR3I8TutaxCcv1BHkIQZrnnU63sMgcISDCHw1E0iDyfj+t5FOA6KHfwcdr64FK3Nir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d28a70743so63034555ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 19:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725762543; x=1726367343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiTPIOaKoJ8RROFx9phlWAm18ZpiaONe8dYomUfcGEI=;
        b=bqrQtA52Q0/spqwVmvLvzWcK6IWF6ZyIrybKRgtCRxTfX/qngF62oIsYE+CwZZshI7
         BkS7O3Y9QwnqFpBsQ2ajqU1SvSmEPACE73cM9M/8Rda2gceozxAbSPFeVc3q3ert1L+t
         bW75KYZXsp9i14hhg2QUa+WM+qXWP+N8wmTC6whotMF7+7nOEFxn9FecdAWkIhT14eZH
         jnBiAvUK8up1Xv73Jcf3FCmrFNBOnQGESqIXtgMxdKG2GczEZquzyBaAQtiF5QqtYf86
         RpPJ33PYBYlyPYr2sJBSr//hpr0Xka4TSW8yTKo6UprAl9+8imyL6q/2gfr9mSYJ1XlX
         2WbA==
X-Forwarded-Encrypted: i=1; AJvYcCUF00QZ5NeleNWK9mjgY+R13oiQS+cPj79WDzJ1a2Wgfckb3ptOcL1bFPnQVfSJXCc9qC2AejbnDEI7OOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzunjao0UjdJDJ5TPLVdkKpJnQ9PxFg58PAKc2EbOr6TfapoGvh
	kKDnIh3LMY966YV2zFB7npCEyVNfJHT0nOLGebi43H6MKmhqV6zYUsdZtjqTNTj8z4Cgk0veivu
	N0aA2y7hM03DwAe5dZitDc+cYSTKV/fZ1BuhPh+69rN0+cKWT3TdC24E=
X-Google-Smtp-Source: AGHT+IHk6CFfFbrdiyTssZ3bHX6GYTGz1Vwz1rwBOMSYX/k6HRfPZUpaXk2T3lLFoBHYpqt+BpI1FhZE2lE5OCZ37pQSl6kueczR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a04eb6051emr62133845ab.1.1725762542829; Sat, 07 Sep 2024
 19:29:02 -0700 (PDT)
Date: Sat, 07 Sep 2024 19:29:02 -0700
In-Reply-To: <tencent_4264A96683BCC4583779976346D633660305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005514e806219267eb@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hci_abort_conn_sync

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0 Not tainted
------------------------------------------------------
kworker/u9:2/5285 is trying to acquire lock:
ffff888043094aa0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: touch_work_lockdep_map kernel/workqueue.c:3890 [inline]
ffff888043094aa0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4144 [inline]
ffff888043094aa0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: __flush_work+0x46d/0xc30 kernel/workqueue.c:4176

but task is already holding lock:
ffff888043094078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5564

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

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

-> #0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}:
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
       hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
       abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2918
       hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
       process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->lock);
                               lock((work_completion)(&hdev->rx_work));
                               lock(&hdev->lock);
  lock((work_completion)(&hdev->rx_work));

 *** DEADLOCK ***

5 locks held by kworker/u9:2/5285:
 #0: ffff8880439ca148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000392fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff888043094d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:327
 #3: ffff888043094078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5564
 #4: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #4: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #4: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: start_flush_work kernel/workqueue.c:4118 [inline]
 #4: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: __flush_work+0x103/0xc30 kernel/workqueue.c:4176

stack backtrace:
CPU: 0 UID: 0 PID: 5285 Comm: kworker/u9:2 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci0 hci_cmd_sync_work
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
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2918
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
console output: https://syzkaller.appspot.com/x/log.txt?x=146feffb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175c0e00580000


