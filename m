Return-Path: <linux-kernel+bounces-348582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF5E98E957
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B51C2142B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150D40879;
	Thu,  3 Oct 2024 05:22:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75772110E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932947; cv=none; b=UMr3ctftSUHcoZGMsYA7rsphVzv9yvyDJV+tB/c4KwwvLafJ8AZ2BtTeE5L/HXUhfKsFop2pKv3iqVS0Ah7AkG2Yr8jnOaVlkDlwXLYypmxhBHaXQskerQUJ/zq1jsSDOAdfXgUxoq/M0IrPFcSD9GejpGIlh0B1nZnMJeRmRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932947; c=relaxed/simple;
	bh=zrjqWxyx1KM73znQwv/Qe39o01mZlMnPXzDlN5Qcxw8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nKpEwukNqzWVeSeaXckStXWHbtqzJXWSCsKMTpMSTTmqHZ2asqovApCV3SjVRgBXIU9aFJRIbPsYbiLkiL4zM32ILViK0v1T6WejuFq0q319qvTj+ycjToFefDC4Vz3Y6tD1nIe8bV4Ky+C2sQgpnJE765r1u3k/myPeFjtk+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3453139c0so7310775ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727932945; x=1728537745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRbLzPjCHZ0TUlYnXRC4j6pufPY4JkwQb5Tk0/q3nVU=;
        b=NAaB7Ur0tMZxQJKYjKcOCUGX3vM3gBk0pmOLoQQnFiy3FrBJVvE9caq9wtn3rk/3xT
         JNqvDYnQmyaB+oZtjwpf4Ite5RaPsTbXNI1H2nAzQJloj0nZj4KpCOPAbQ51CWVKQ71E
         aQ3D3gGwsvmQqwqvJ5qOqsHxUoYCiRECRtfLFg/O8Q1y5PdZuQCWLfH0jDwuTT0h3+E5
         W/X++oJsCH3vNkPlcDaaxqzTOMRXQfUd0vvu4c7B71gw+HAATrJ1EOXP//k5+53fLqun
         ByPwVsR+RlnNZUoYy8aSNndr2bSKenHu+dzMKuWYHD3U+JurwIn/09H2r3WkCeS1+tNA
         MoIA==
X-Forwarded-Encrypted: i=1; AJvYcCWpvFKkFFj9q+SS1qQRYT7g/3yb2DRgx3WJQvvUT6YOsX9haYcF+W/WeXcq01U82mQU+sT2VoEtcG6v+9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu320g7OwQJBdDAYrsxYg2DRDHWErRiliTSrhMAjxKzVny1L6t
	xHdjEghr2gUyqNrNeaJf2AiLTLH4LdAaU/8s6JXvb/4Ifx0jm1pCE+udrhHmQXremhV0LjjS+x/
	f6CaKqcz2MIBc+lEbaAGKf19pgKgo7cgLnX2lggfbECKRWr22fsf8g5s=
X-Google-Smtp-Source: AGHT+IFqkEX4Ye2iuf3b8JgVfts4RYbiNQz45JsQ0etxrXMXbXgCQGI35qf+5nqzdFGj8u9IoHqyZGAkzfp9eQwodZQC9Gccttxw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:3a3:4164:eec9 with SMTP id
 e9e14a558f8ab-3a36592dd12mr52001815ab.14.1727932944927; Wed, 02 Oct 2024
 22:22:24 -0700 (PDT)
Date: Wed, 02 Oct 2024 22:22:24 -0700
In-Reply-To: <0000000000003eb4720622638663@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fe2a10.050a0220.28a3b.0209.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: corrupted list in do_compact_page
From: syzbot <syzbot+b7a3118f6a494674077f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linmiaohe@huawei.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f23aa4c0761a Merge tag 'hid-for-linus-2024090201' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13904b9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6248f0ab12f33349
dashboard link: https://syzkaller.appspot.com/bug?extid=b7a3118f6a494674077f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174ab580580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f23aa4c0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b65e6e0b52b/vmlinux-f23aa4c0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5dd7d20b144c/bzImage-f23aa4c0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7a3118f6a494674077f@syzkaller.appspotmail.com

list_add corruption. next->prev should be prev (ffffe8fefc9300e0), but was ffff88810a694800. (next=ffff88810868fc00).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 69 Comm: kworker/u32:3 Not tainted 6.12.0-rc1-syzkaller-00042-gf23aa4c0761a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: zswap1 compact_page_work
RIP: 0010:__list_add_valid_or_report+0xa9/0x100 lib/list_debug.c:29
Code: 9d d1 8b e8 19 93 d8 fc 90 0f 0b 48 c7 c7 60 9e d1 8b e8 0a 93 d8 fc 90 0f 0b 48 89 d9 48 c7 c7 c0 9e d1 8b e8 f8 92 d8 fc 90 <0f> 0b 48 89 f1 48 c7 c7 40 9f d1 8b 48 89 de e8 e3 92 d8 fc 90 0f
RSP: 0018:ffffc90000d67bf8 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff88810868fc00 RCX: ffffffff816d47e9
RDX: 0000000000000000 RSI: ffffffff816df0e6 RDI: 0000000000000005
RBP: ffff888040c49000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000000 R12: ffff88810868fc00
R13: ffff888040c490b0 R14: ffffea0001031240 R15: ffff888040c49008
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b764808 CR3: 000000006493a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 add_to_unbuddied mm/z3fold.c:550 [inline]
 do_compact_page+0x10f2/0x27b0 mm/z3fold.c:772
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xa9/0x100 lib/list_debug.c:29
Code: 9d d1 8b e8 19 93 d8 fc 90 0f 0b 48 c7 c7 60 9e d1 8b e8 0a 93 d8 fc 90 0f 0b 48 89 d9 48 c7 c7 c0 9e d1 8b e8 f8 92 d8 fc 90 <0f> 0b 48 89 f1 48 c7 c7 40 9f d1 8b 48 89 de e8 e3 92 d8 fc 90 0f
RSP: 0018:ffffc90000d67bf8 EFLAGS: 00010286

RAX: 0000000000000075 RBX: ffff88810868fc00 RCX: ffffffff816d47e9
RDX: 0000000000000000 RSI: ffffffff816df0e6 RDI: 0000000000000005
RBP: ffff888040c49000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000000 R12: ffff88810868fc00
R13: ffff888040c490b0 R14: ffffea0001031240 R15: ffff888040c49008
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b764808 CR3: 000000006493a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

