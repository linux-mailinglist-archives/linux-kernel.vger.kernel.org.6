Return-Path: <linux-kernel+bounces-366048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC02699F02A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15C3281A55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8D1C4A29;
	Tue, 15 Oct 2024 14:52:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30211FC7EC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003948; cv=none; b=WKZEK4PVWQvMnsSYQbd24NC0lYmKPFS1K1mLTEXf9W8aC/C9B6SenZMUEecZ4Ubf0raki1dRus0kKhj1sUhVoJ5D3qorsiwNRvX4cLBZNI5Yf7+YLMM6x6LElB4tW5uoxTWti3ktGLTnUIH6pbO6ABf9E73PqCXD7xjI8shYUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003948; c=relaxed/simple;
	bh=X3UOslAHpv0oVRMBpVAOzaa3HMqPJtHuEZ1xEUDrWKw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q9K0XszZwwV/M2KrC7XNzgE4WesSCk446u5y2GJXOtXcoLWARSAdpEyWZVifPURv215e+BQkSDDDB8gEf8uNgN/r/XDg4+r5hR7wtie2sVQ53Wy6iUy7Ln83d1wYZxnsYJ4p4nco0anVavSjSXb/68rTlxTIN7bnMxvbQBOX+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso42177145ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003946; x=1729608746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XO+GUzRmHdqNnyc7dwi6fD+423rtAZPTsedwNl5XHEc=;
        b=X7GdAO4ji6CiEaHijDT0o6dvmCZfNe3J7R914nfwqFZ0OOW5Hx7E5XAL5z93eZimS1
         ak/ioMO2WEMtr1K4vyGbXX3ns1VBMVuXJEn3QLBoQQAIoC0iiRqB5YccCQOCcsC34i4U
         MZMZtucs9o8ikQVau4sZeVldi14zS7pDYwIUVv9YIy6pD71WcIcS970n6lqRv7vNmjYe
         aY8iR9Wu0XpaPZRoANytnYqtX1Dy0XRFTI46ghxyAoV+pYb1u/OjfeLofTXqtZWf5JR7
         EhexUs0itvIu1A8TWJfW9vJEk1/ScsbqDF2Pe1uAvXmjp1fbuMR9mOuw9QZV76dayic+
         /d7A==
X-Forwarded-Encrypted: i=1; AJvYcCWfY095CiJa70xD97g9grTr4+5oLBpmVx8Yf2TZH2SS1jvVFP5/S0UMsN49rq6lgdiPapvVEkwgJIbOPf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzILb7U9Tf/Afz8Q32YXGJTeAbGlnjsqC/5OigHhcKgArFss6S7
	UzGziYIL6CrzQSrU5lkpZWAKzu+OQ0R2JuWu/k/IM3NyfmYK5ruBnVuHv5PoI6drQzhqro8pti1
	8HHFxyPQyZpNO0CECdR/rHz+1MDtNrhSEmz1iIXhOih6WhCFYahNNjNU=
X-Google-Smtp-Source: AGHT+IEoJm9PjF6QOifHwNJPiBNytBOPAPjNYhK04sArKfWSnnvpFgbmFBTohYogPCH5zI4Xgf/tgrbovi3fqMJNu8t5SwY598Xo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ce:b0:3a3:9337:4cf4 with SMTP id
 e9e14a558f8ab-3a3dc4a04ecmr6302055ab.4.1729003945886; Tue, 15 Oct 2024
 07:52:25 -0700 (PDT)
Date: Tue, 15 Oct 2024 07:52:25 -0700
In-Reply-To: <000000000000c6b91e0621a312f4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e81a9.050a0220.d9b66.0153.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: corrupted list in add_to_unbuddied
From: syzbot <syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linmiaohe@huawei.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    eca631b8fe80 Merge tag 'f2fs-6.12-rc4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d0845f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=30eac43568e2b3d65728
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16df4c40580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-eca631b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/830e1433408d/vmlinux-eca631b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5538dfbaa4ef/bzImage-eca631b8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/66bf3424533c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com

list_add corruption. next->prev should be prev (ffffe8ffffc31ed0), but was ffff88803ccdc800. (next=ffff88801e21b400).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:31!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.12.0-rc3-syzkaller-00013-geca631b8fe80 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: zswap1 compact_page_work
RIP: 0010:__list_add_valid_or_report+0xd6/0xf0 lib/list_debug.c:29
Code: e8 1f 26 00 07 90 0f 0b 48 c7 c7 00 fe 60 8c e8 10 26 00 07 90 0f 0b 48 c7 c7 60 fe 60 8c 4c 89 e6 4c 89 f1 e8 fb 25 00 07 90 <0f> 0b 48 c7 c7 e0 fe 60 8c 4c 89 f6 4c 89 e1 e8 e6 25 00 07 90 0f
RSP: 0000:ffffc900003d7ad0 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff88801e21b408 RCX: 18a79d2c00c9a300
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffe8ffffc31ed0 R08: ffffffff8174afec R09: 1ffff9200007aef4
R10: dffffc0000000000 R11: fffff5200007aef5 R12: ffffe8ffffc31ed0
R13: dffffc0000000000 R14: ffff88801e21b400 R15: ffff8880400e6000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c001e70000 CR3: 000000003dd36000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 add_to_unbuddied+0x2e4/0x4d0 mm/z3fold.c:550
 do_compact_page+0x924/0xc50 mm/z3fold.c:772
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xd6/0xf0 lib/list_debug.c:29
Code: e8 1f 26 00 07 90 0f 0b 48 c7 c7 00 fe 60 8c e8 10 26 00 07 90 0f 0b 48 c7 c7 60 fe 60 8c 4c 89 e6 4c 89 f1 e8 fb 25 00 07 90 <0f> 0b 48 c7 c7 e0 fe 60 8c 4c 89 f6 4c 89 e1 e8 e6 25 00 07 90 0f
RSP: 0000:ffffc900003d7ad0 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff88801e21b408 RCX: 18a79d2c00c9a300
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffe8ffffc31ed0 R08: ffffffff8174afec R09: 1ffff9200007aef4
R10: dffffc0000000000 R11: fffff5200007aef5 R12: ffffe8ffffc31ed0
R13: dffffc0000000000 R14: ffff88801e21b400 R15: ffff8880400e6000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c001e70000 CR3: 000000003dd36000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

