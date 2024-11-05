Return-Path: <linux-kernel+bounces-395789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563849BC2FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55D0B21898
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9D44C76;
	Tue,  5 Nov 2024 02:10:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0AF3C30
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772622; cv=none; b=EmPAqw3hOExBbwcEAl2qPOULQTZ4aOlvwdPPSEXm6uli0YEJWfdBUyQ+pIPdNgQ16vejXqWb9QQiim9PaeZbGFz8lDBl8Wy6kDS+Wozx6C7hs7f0ixfPkoAUiL9tmmUKJorf5HOtlY/5Bm1bQHarxdhsNYyDfT0cLZnl8ouH1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772622; c=relaxed/simple;
	bh=WOG2w6ROnRZSeXpBfdm1M5ozrfMG8hm2/mR6/2ljo78=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S64jbHUzisJRFN2joRxgcaxBdIIhwu7rSYWT2mRIxMplFdUI40wFh4Sl4qhRuGNO/Rk9axwvadawA1Lp6AWGWSEgZJM0ksvW2iUECZe5226Vb1pmKfqTT9FQ9c/zyWt9MDnaksTMim9Rp4z7O178HWm5bSx/GBw0uDtEJDQp5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abf68e7ffso537881339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 18:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730772620; x=1731377420;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOwK7LgCTCkhpBtnCmrshYoV78C7UhrxMFbq+MY09GY=;
        b=I49OyOcHdxgfHngUs0zI0rFRcHJiolxWbfh+kdPirhvSPZJM4MDw7INqahtPjvF1BL
         XYQuJgthdyXv3Wgxm/MoJamcVLGs0cis2/ObspVrG3eAMhHavZmm4JyDryN0mM/JUyjL
         TYZ8HC3vzgbXwq63vwbO2YYEstWjyNHmz+BPN3Ge6YS/ygdN8Khm3caWPzuDcZGSOF5F
         TFVIQLoth6pdCAw7cWuKKKBvMcJuamLRgzt66zPnNJR7RyC6AIbQcQN6FtbpVhPzbpCF
         C7mIgE4CHgkO88fQFWnmL6d3nJinaWSi/7y1lL6aRMOlUWFsibTOLASftrK3ComNIdRk
         UnXw==
X-Forwarded-Encrypted: i=1; AJvYcCUF0P5vTsU71d7TwKcyPmrBINxomWg9SKisdfW/Ikz0FN/5XCzsv7m8sq0pjEFKKH8sAhcu2MQBmOJhOaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJ8MecG6iMRRpAITpyQQWnBzaLXzvEPDgPH6GG38HO+Oiw+Po
	IdECtnSOFMWN6FncwZtu8UD7LzAn3EBdrTutHkn6Cs9rgXMjP7a7K6bNTS7fXusRLzHTM/KZuyJ
	V4Z9TiPUl9nNqWgP8LNlSWIWSsN0dvt0xN9RM3oTvF981PdGJvePngFE=
X-Google-Smtp-Source: AGHT+IFmFAjJO8uzUsuCAVpvck1Ngr6POR2cxcKVMv7earv4Zm+aMtsG/f0rRxn1JsuyuBFlvcE+i4tJFgztvHW4mdoNEuXhCN4e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:39f:5e12:1dde with SMTP id
 e9e14a558f8ab-3a4ed2f2830mr327954935ab.21.1730772620239; Mon, 04 Nov 2024
 18:10:20 -0800 (PST)
Date: Mon, 04 Nov 2024 18:10:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67297e8c.050a0220.2edce.14fe.GAE@google.com>
Subject: [syzbot] [rdma?] WARNING in ib_uverbs_release_dev (2)
From: syzbot <syzbot+a617d4c5ff27f35f8255@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0fc810ae3ae1 x86/uaccess: Avoid barrier_nospec() in 64-bit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ac9340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=a617d4c5ff27f35f8255
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d7ec34ee152e/disk-0fc810ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba87040ccb6c/vmlinux-0fc810ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e189a9b5a22/bzImage-0fc810ae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a617d4c5ff27f35f8255@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8645 at kernel/rcu/srcutree.c:656 cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:656
Modules linked in:
CPU: 1 UID: 0 PID: 8645 Comm: kworker/u8:11 Not tainted 6.12.0-rc5-syzkaller-00063-g0fc810ae3ae1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:656
Code: 4d 84 00 48 c7 03 00 00 00 00 48 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 84 f4 75 0a 90 0f 0b 90 eb e7 90 0f 0b 90 eb e1 90 <0f> 0b 90 eb db 90 0f 0b 90 eb 0a 90 0f 0b 90 eb 04 90 0f 0b 90 48
RSP: 0018:ffffc90003f07930 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff888079789980 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffd59658
RBP: 0000000000000001 R08: ffffe8ffffd5965f R09: 1ffffd1ffffab2cb
R10: dffffc0000000000 R11: fffff91ffffab2cc R12: dffffc0000000000
R13: ffff88805bab05e8 R14: ffff88805bab0000 R15: ffff888079789800
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b86306d58 CR3: 0000000060ea6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ib_uverbs_release_dev+0x4e/0x80 drivers/infiniband/core/uverbs_main.c:136
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 remove_client_context+0xb9/0x1e0 drivers/infiniband/core/device.c:782
 disable_device+0x13b/0x360 drivers/infiniband/core/device.c:1288
 __ib_unregister_device+0x2ac/0x3d0 drivers/infiniband/core/device.c:1518
 ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1630
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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

