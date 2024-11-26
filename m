Return-Path: <linux-kernel+bounces-421904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB89D91CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B2E286278
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279C16C687;
	Tue, 26 Nov 2024 06:31:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5A69D31
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602691; cv=none; b=cn1jvfRuxiPlktcFOqTjdqqjYIEEj9y6hj29mZExs0V1Lq4/cVa6mPxrmqHTDHLDWs5ZmoW4rwuyEsgQOCyWiv3An+QhT/PIuJY9AuXTouI/1Kc1lENWqyeOMTYuRwVkw7+ANK1euvqeyCIziaa7bazlZJYnJiot9zt82gBSdTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602691; c=relaxed/simple;
	bh=FVi48ZRIhhrj2r9IqmQ9F+1/rvbFztFGBcox3pN1TL8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EXF482x4OsiGwUDXulM+70gybMiTdKXprguOKWvLymfXTojHKQznXr7L2YRuWfzHdVQBwiK72N4dklPYD+HOUZ496AkR8Zf0Iw/sdFTbKkfO4WIdYQyh/fbUPBe9ntxaOpfHC6pMe82Yb8bx0fWJUy8YGi+BFMYAxxVKlUUHEgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a75c23283cso44248605ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732602689; x=1733207489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYXLiLYKZ16gMJUmMyuH4EbrtOFYV5j00PiblsEE4V0=;
        b=QlUyoxHrRBVyNIJ9H7EggH90f/PUaKZVd4KRlSLmOBcLV27LCfUCeLveXbs+gOBkJm
         th6sIp4OD3y4874D7Ne/C5Gm8RUxl6AeyGK6zCIoOE7HFMuMeatXRNlK9NM6v6HhrwH1
         vaX94eSLZTo4/QZBUsZKKX4BWyXcAsukvkrtgpzaXtHWspQFFtMpAEtiyT4BH4lNJtXl
         SIsjXrAXywwJo6u/ZCoos64seeDLnFupG+qZxvlfFz0rB+ZeJb4QSt2pQCtDRvwUnqD/
         u4DLBSFYPXIGIAyUh0SQYIUWNNl/Rl9F9DhiEzKiZN28Z5fbfNxjmBK77fGSwZsqwSEb
         /SXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBW578SdTWVQFDH9LmXwdb4nCC7OBKYUIqyQJt+T4UrlAOXpAIe9BRCocITG0TMYO5ZWF+HDJ2nofiZNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJ7HCpLrSj+fV19newhhqZ0Nf9/V4VidHKVPUPRrUpLAFSBnI
	qZIQuPr9rbxECGWCW8gUWFRJBQz2HSof7pvH8SyB08sMiQTLHKSvSYh6p6sI0Avj86KRkUvgN1U
	ccznhSdJYnijtQYzkKYCH1h35NXQsE6PS8rbTo76TgF3BP7okyIrX7pk=
X-Google-Smtp-Source: AGHT+IEZspe+G8koaV4jPTwdLt6pz75t3BvKY5UPEhWLur3Week9eA4DTA0I/hi2m/3wDJ95jTOiIH+W0gaOCtoo70jhlxwPi4yL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3284:b0:3a7:bcc5:9de3 with SMTP id
 e9e14a558f8ab-3a7bcc59ef6mr15846965ab.2.1732602688943; Mon, 25 Nov 2024
 22:31:28 -0800 (PST)
Date: Mon, 25 Nov 2024 22:31:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67456b40.050a0220.21d33d.000f.GAE@google.com>
Subject: [syzbot] [mm?] WARNING: locking bug in __sysvec_apic_timer_interrupt
From: syzbot <syzbot+2c02da94a158ca39fcc0@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148d675f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c04b80691ccbb7
dashboard link: https://syzkaller.appspot.com/bug?extid=2c02da94a158ca39fcc0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f68aa5d85643/disk-fcc79e17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad99781945ae/vmlinux-fcc79e17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c4059c60213/bzImage-fcc79e17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c02da94a158ca39fcc0@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-syzkaller-05480-gfcc79e1714e8 #0 Not tainted
-----------------------------
syz.1.233/6687 is trying to lock:
ffffffff8e39fbd8 (stack_list_lock){-.-.}-{3:3}, at: add_stack_record_to_list mm/page_owner.c:182 [inline]
ffffffff8e39fbd8 (stack_list_lock){-.-.}-{3:3}, at: inc_stack_record_count mm/page_owner.c:214 [inline]
ffffffff8e39fbd8 (stack_list_lock){-.-.}-{3:3}, at: __set_page_owner+0x3ea/0x560 mm/page_owner.c:329
other info that might help us debug this:
context-{2:2}
1 lock held by syz.1.233/6687:
 #0: ffff88807a2cf110 (&u->iolock){+.+.}-{4:4}, at: __unix_dgram_recvmsg+0x267/0xe50 net/unix/af_unix.c:2432
stack backtrace:
CPU: 1 UID: 0 PID: 6687 Comm: syz.1.233 Not tainted 6.12.0-syzkaller-05480-gfcc79e1714e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x878/0x3c40 kernel/locking/lockdep.c:5176
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
 __unix_dgram_recvmsg+0x1d1/0xe50 net/unix/af_unix.c:2435


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

