Return-Path: <linux-kernel+bounces-261006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9D993B175
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A82428594B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644C158D84;
	Wed, 24 Jul 2024 13:18:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30501157E6C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827103; cv=none; b=ZV+Hv0Q03Td35R2eJLl6apWCvZ21spylB4T50v/zo+axGD/tD8v1ZdfxrwF3R6CSa9UvxJHmiBeanES3HYU/1BIw5Py3ZViVUq7iJ+eMUh7LcL8EHNhwC3sebaGyqbM8xD/Yc8YmnOGz4Uv22OShRWNJUk4TgbynNnBP0tYTo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827103; c=relaxed/simple;
	bh=F/KOJ3mKSfeOCZQbhXBJmwffOQkcBP+ECPPdb7BJJ7o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Uq13Slb1Bi6ErEff4HyufNQBGoTXLRk77wr9H1gKu3FfDxKP8PIkCsAO//xF5gsF/PHTRxJ+XiGBow+cniz6pUIc/081WFzHxOZ/BRVDG+RlHsl4AbNyLL+Ojlqg+LF96UhmVkMLgKRy5jm9Twge9VdbtZ8FjrmCJ78h8VHONE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-804888d4610so114299839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827101; x=1722431901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9OLYAO0oAZgU3ZQkkdEML/gOHWNdnZu6zW9bwNbKa8=;
        b=oF80PciqrSZyH5xFfUsYZcKcnIpvKLvXF1Uqf/oukkEuGJzd0mtKJIFeoTa9MAhL9D
         q7VY4wgpWSFR+Gyda05vt7O9I7JyU7DCc8L9nzWl0jGrbmUMVK82LOr/FhroFQArBIro
         XG0EOHT0tw+kIMfNJPAzwDRIwMVeFOS7GYoSTynaDY83h9CEuQGYprwpuh+19Bo3tq1/
         jbiTd/ZwLBJoz6aUXGTsLGb7KiycZLR3s8amiMbN5NBmDDR6jPgFsVvUS2tictnLvQFH
         IHNXxVbgtVCIEazr+6wk/iwEn2VFGyrkiEG/6DdLKSXS70d/jR1nJ+JG1HWfFVoiCjZ4
         Wghw==
X-Forwarded-Encrypted: i=1; AJvYcCUFINpyryggPuE7lBgugbFaCbihyeN+v7QAXvwCvIBk0zfExC0vQ4FvsIO8hRXMfL43BqEFv0ApwrYegrpQdVJ5JjnNqNGd7dJz5h2Y
X-Gm-Message-State: AOJu0YxJHuEMsBXRfdmKZjGb1vq2DIApWJff6R8buSjGq2/QtU/3s3Zn
	jcI/4Z3/fjX6grgLVBzJX0KQgFB1trKpXaLSjc46CqjwyNLH4q+qPrzjSDmKgx3lGFnP0bp11HD
	zbUFAf7t9Bj6rWWR1wTJeDGAiHr+Sb53jie99yVilNBVx1GAFBSWxfhw=
X-Google-Smtp-Source: AGHT+IEFttKXpBqlDhq5Hg2s0McqaO3xxn3g7bNmAxNEOOv9JvpkhmiGNGjT1kexde9AqgilxHa1uj7D/vapJukx9BLM6aO38W/q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8625:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4c28fd69265mr94135173.3.1721827101371; Wed, 24 Jul 2024
 06:18:21 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be000d061dfe1c55@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in l2cap_sock_resume_cb
From: syzbot <syzbot+52115a16e7eac723d587@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13550ec3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4129de17851dbe
dashboard link: https://syzkaller.appspot.com/bug?extid=52115a16e7eac723d587
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/105004175f16/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d8a81aaa129/bzImage-2c9b3512.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52115a16e7eac723d587@syzkaller.appspotmail.com

Bluetooth: hci2: ISO packet for unknown connection handle 0
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
BUG: KASAN: null-ptr-deref in l2cap_sock_resume_cb+0xd0/0x130 net/bluetooth/l2cap_sock.c:1697
Write of size 8 at addr 0000000000000518 by task kworker/u33:6/5222

CPU: 1 PID: 5222 Comm: kworker/u33:6 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
 l2cap_sock_resume_cb+0xd0/0x130 net/bluetooth/l2cap_sock.c:1697
 l2cap_security_cfm+0x78d/0x11d0 net/bluetooth/l2cap_core.c:7354
 hci_encrypt_cfm+0x194/0x720 include/net/bluetooth/hci_core.h:2041
 hci_encrypt_change_evt+0x554/0x10f0 net/bluetooth/hci_event.c:3649
 hci_event_func net/bluetooth/hci_event.c:7445 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7497
 hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4029
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
==================================================================


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

