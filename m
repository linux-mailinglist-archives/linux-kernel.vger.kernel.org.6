Return-Path: <linux-kernel+bounces-179312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3623C8C5EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E261F221B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E116138;
	Wed, 15 May 2024 01:09:10 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ACD5CB0
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715735348; cv=none; b=helopGJ7jRLo/B8TbicDUXFOxADYMBHiA38lbB8FnDLs6CzCHSOhvjA3h9CP+SoIKib8XSfBZyBDXYHJDCdRRNUmmwX1VmNgoP5Fux3bvb8uXTCio7RW0kPKOiHwQFsA9mQ7TySpIv/HfYAunJsKJzhQV3NNLk68/+bfqTIllGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715735348; c=relaxed/simple;
	bh=D8iGN+4icmxXkydaobcrxayLymRggzjefN7XAXWtC64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PopDNnB4uNG3v1IANPiheQWSFdR3xcADuExTGB2sJRbo1rN+TKwIoRP7q2aGOg6puQo6I3/8bpUEjMYicepq8tSHoUjzLpjCTWjOZw5CJtXHaqVjsVTFZ/HGffVGlcpgrSX8pbX1Q7CfU46QHOjh2iLnxugVzZl6BUqS0Uor/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1be009e6eso578232839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715735343; x=1716340143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fq+duhRs6Tp+Y55GfZEgV85bvDId0dyrQq5zCEGOoCo=;
        b=Obnqg36MT6u4Iwi6xBwu0LemvrbErrna4bfkugFZzlhl5R1jejpAEgVKNmF4khpYpv
         hMOVuaXh3zktWFCY2t9iPWMXFiOmhEqGiVZyq89slNlChsc2uskbiWC5nfrC2pDaty5A
         cjuMMbkgNgO0XUJWXKhP4Ra0LBqsQA8X+o3UmyDyqj4Fe850tZDZBdp5J2jx0YX+Se2U
         6ninEUtLbrR1JT8/vs/uGOKFpkZ6kj0tbRin+fnV4OYZU3ugM1VzND0g7oZi1ZeXtjQp
         gQ4l5qZNoglqeDsf1S3JycsAdNNeT3Qadjqyeto9gJwGkpAK9SZ9673xiyQsxbHvYNWe
         gAyw==
X-Forwarded-Encrypted: i=1; AJvYcCWj65Cq4eSomrua/FpIWC0QmbqVEU8xlpSURDOSLsCfVRjkFYtJg1OZUE1Qf7xaMuUp96wF0Np8qyoaoqbxFsSWeAdZHOQG95uEGJSy
X-Gm-Message-State: AOJu0YzoF0HAMCMok+Nzuw8YxCLoOtFSzXfdsfO9PdyVYA/2S1PTZ/ij
	VFt4jYRmnGLDiKJteHNOjwzlbsqMKHR9C98tB/D9qr3tQP7gp3GFmjsicEsDsyOWOVq489tjJVL
	sIMZNbHPFl5UMXwLvX5+8K4Utgm54tvtgUY+vZ7qTiKtvApFg+WQkQVI=
X-Google-Smtp-Source: AGHT+IGYjGvfzHXqt4/DPaFt6HZgv4VryIFdG5ipd4dfr5jk9M6FlRRy3woELwp6HVIcvDYKjC8VqOKaMwpuuX3ytTR3OWFKmyvi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:7838:5ac7 with SMTP id
 8926c6da1cb9f-4895868f2fcmr984467173.2.1715735342227; Tue, 14 May 2024
 18:09:02 -0700 (PDT)
Date: Tue, 14 May 2024 18:09:02 -0700
In-Reply-To: <20240514232319.3252-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a35fa061873c3e8@google.com>
Subject: Re: [syzbot] [kernfs?] [usb?] WARNING in kernfs_get (5)
From: syzbot <syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in firmware_uevent

============================================
WARNING: possible recursive locking detected
6.9.0-next-20240514-syzkaller-dirty #0 Not tainted
--------------------------------------------
kworker/0:2/930 is trying to acquire lock:
ffffffff8ec74268 (fw_lock){+.+.}-{3:3}, at: firmware_uevent+0x2f/0x1a0 drivers/base/firmware_loader/sysfs.c:84

but task is already holding lock:
ffffffff8ec74268 (fw_lock){+.+.}-{3:3}, at: fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:123 [inline]
ffffffff8ec74268 (fw_lock){+.+.}-{3:3}, at: fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:164 [inline]
ffffffff8ec74268 (fw_lock){+.+.}-{3:3}, at: firmware_fallback_sysfs+0x755/0x9d0 drivers/base/firmware_loader/fallback.c:240

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(fw_lock);
  lock(fw_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by kworker/0:2/930:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000441fd00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000441fd00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e1dd630 (umhelper_sem){++++}-{3:3}, at: usermodehelper_read_lock_wait+0x14e/0x260 kernel/umh.c:247
 #3: ffffffff8ec74268 (fw_lock){+.+.}-{3:3}, at: fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:123 [inline]
 #3: ffffffff8ec74268 (fw_lock){+.+.}-{3:3}, at: fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:164 [inline]
 #3: ffffffff8ec74268 (fw_lock){+.+.}-{3:3}, at: firmware_fallback_sysfs+0x755/0x9d0 drivers/base/firmware_loader/fallback.c:240

stack backtrace:
CPU: 0 PID: 930 Comm: kworker/0:2 Not tainted 6.9.0-next-20240514-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 firmware_uevent+0x2f/0x1a0 drivers/base/firmware_loader/sysfs.c:84
 dev_uevent+0x4e4/0x900 drivers/base/core.c:2687
 kobject_uevent_env+0x467/0x8e0 lib/kobject_uevent.c:558
 device_del+0x7db/0x9b0 drivers/base/core.c:3928
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:125 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:164 [inline]
 firmware_fallback_sysfs+0x3a8/0x9d0 drivers/base/firmware_loader/fallback.c:240
 _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         26dd54d0 Add linux-next specific files for 20240514
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157a1c84980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8af44e051929224
dashboard link: https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10776c68980000


