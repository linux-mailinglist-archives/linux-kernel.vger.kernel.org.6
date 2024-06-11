Return-Path: <linux-kernel+bounces-209313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A5A903263
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490212867A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959B171656;
	Tue, 11 Jun 2024 06:21:27 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919AB171641
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086887; cv=none; b=UIuUVb6qaK/sEXV6ILoyoQXvDqGU+9edt9XlcID8KpJeq0FinLlhtCFqj64nSKiPzA+ieMFswQfNBIzj9tm1znQXL86C84EDftPUYrOKETs+Sm6IypUfPKLUoDxMo3745LSsze3cIq+5FmVyECkdt4yep4y4theR7e9K7gipNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086887; c=relaxed/simple;
	bh=CqDG1xchg1Zq79fCCwKc00h20hrlWKLSZftL8B9BGjw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZrULgn+BLtH095ywrWKYdr7xxInGrZginF6EOtNBfKAGVkEOT6z9+dVZxWk5T6frmtwj/1oO2WqeslPKhblNCN40hm6PRq33cV4tIqG4nhLhr78RoWg+C4mH1p71xoacBxAzhWHM93WDWBNypfNSw652yXddzbsAsISl70gB2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7ead7796052so600357839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718086885; x=1718691685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whMQVx6Q5ysbxz2YokejrIpBQ9YrjYHYSvOnrc+a8nU=;
        b=hj2iyMLKb/Ae6L/5/DvMihUP3y+Zu+1iQH1JL64c2I3rnd91P84cuWPODM/0njDyCD
         RhJ7tJmmO+wV8OvAQaNOGjAWSsaoHR00toJDaexuBywYc8ZQUt98LbdMSMIlEsOb6Nad
         vEfAXz3nI2h/lmbnafvJWX+0WMYtFjMHw4DVXStqZRBQ0n4EfMFW2fd7DNjPcdVN0tUL
         OjWpoh9p9eQGu/YsROEFYoXYdOsO6Xghn2AwEphSdchVRxt1T5rDHmsoT3iwcDJP/HL9
         XYV1Zy1WlczwrEZsqQFg/rEHxC7fW5A5O9sWQxSQaRjgVQ/fmt0z4vxuWx/oX0/ZRxjg
         ycgg==
X-Forwarded-Encrypted: i=1; AJvYcCVtjXnnnoCnTjA/H/sqTRkzrhE8ex6wadrXPegHmBS3QKDqwf+4b4UGUrPZaxpaFQNRmmT2dlXOJ6HjuCHL0VhgDYVOYZgmGMKoDYel
X-Gm-Message-State: AOJu0YyqcjmRiPGR0kFcxE9hJC0i/jHJliO2pinPO9B3RmWYoZtCZODK
	olB8xhuyzX5kwhBYz8qGYlaWL5yKDZ6jhLgteFHPtfkDQaAJSBU0zezbuvr92QiNxbi2uZGjNkE
	JVGsFO8oK7781VfJrpg5q4jrfNtdrRX6V/SdycLVkKBkcKhrkQ963aIk=
X-Google-Smtp-Source: AGHT+IFiJVAiUuTxM+9cXTrftF/vHy6bHN93ftxoWMdzTUJhAtHXBrvIE94R/4DXYeRCnJ0k8T7gGz2A5W7tQg46DFl6EbITv9hE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8320:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4b7c9b56e75mr450968173.6.1718086884682; Mon, 10 Jun 2024
 23:21:24 -0700 (PDT)
Date: Mon, 10 Jun 2024 23:21:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000747dd6061a974686@google.com>
Subject: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work (2)
From: syzbot <syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=128ef202980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=3da70a0abd7f5765b6ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1095a80a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a9179a980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nci_rx_work+0x35a/0x5d0 net/nfc/nci/core.c:1519
 nci_rx_work+0x35a/0x5d0 net/nfc/nci/core.c:1519
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmem_cache_alloc_node+0x622/0xc90 mm/slub.c:3961
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1319 [inline]
 virtual_ncidev_write+0x6d/0x290 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x497/0x14d0 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 1079 Comm: kworker/u8:6 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: nfc2_nci_rx_wq nci_rx_work
=====================================================


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

