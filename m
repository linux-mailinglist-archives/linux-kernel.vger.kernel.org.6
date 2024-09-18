Return-Path: <linux-kernel+bounces-332607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336397BBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD76F1F23648
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E99418952A;
	Wed, 18 Sep 2024 11:58:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853BF2AEE0
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726660712; cv=none; b=MTKPVhBl1+9brfgqoKZtnpVzGSTgBmtnJtcShZ4V1kNL0SzXbWUxUKY6NBWwEvKZovegd80koK1MPSDkstz9ouS4Chaa/pOiPrY3/bRaqghwAtmSsOwiY7SgsSSEx9quhxiXr7+eFiHAIdj/wXoXKcOI0izEcD612O8xba4cNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726660712; c=relaxed/simple;
	bh=gV7ZSIwBcjf9C5cJ1AgrdYNvM7CcZ5AkJZy6xSQONqY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ToUFsKa4x1f7ovlyrha85DsNltlL/Bmkeb+Xkz9o+nXJwDVZ0ynHr75U3NBDgPbnRpZlfjOUTZKkkNfrzqgLCNeiYpU4p67msZGaTeUSdC9S1siDl/Q/AAKemGevSmSF9X0WGfFVyiyDJzXyFnzjam2o+UV7aVhtsVkpsOVVILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso136307315ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 04:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726660709; x=1727265509;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPRoccCC8HjD6D9LfLL/a4bQwOUDG1cXt5Py2S69TzA=;
        b=wSJ4hS8HjJwTJioLr3hkVz7W8KLFWyOnBfsjP6YPKFFkbRWk+nFESqhuCxt3yl4rtk
         m+fFvsxD7ivIcm+3OVI/gKN7rvHXgiQhLNNjXNKypkXevjgDhZKC65WRC2RHhajPlI3L
         Cm3CVEMGK2lfVv4AnogSCbn0ZvX5DJlADxY9bKBq1ArzrsbN5IG51p2kMswpzNEBUl6R
         6AY1YX6t+rYFpXOVl8so9dvFMTxEapcsFI4ZXgDewitcTwQYFR+VSu9yqtS4wuoXORy3
         xA49ommxpo0ZvJIxE8KhACIOYy9KnwwypdzZNeSjWsk9a7wH5HVa01HwKS+5JY6aOj3H
         +hlA==
X-Forwarded-Encrypted: i=1; AJvYcCWX9mlaftA/tR+iHLYvQ8UZ5scmgVpRtMomLhlxycXStgAOLZYM4U7RfOh58Ffjuq2N1nmjKjHXuy1aDW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbP57oGDQ/mFM0R9QXrrnGXiVc7ciNcNQXCcx9XhjRbcCU/v07
	fPvFXG3WJHCnBkYJ7sA0JuAXNFxdZ2WSG1xhyepqps7tzys13jiTM5jQuF5ayc40GnrF2vfIb7e
	Ikh3ZcWZ0eVGvI3i0qoVi7ZpqEPHZH1v+uKLpuD9Evsvcpz9pMK/jdfo=
X-Google-Smtp-Source: AGHT+IGrr7aBCO5bIn9nBSwrdpDTKFJQxElOqYKguxum6xMjVKG4QBTL3G6TwVhMWw48PVsYIHhnJm5N3xqi2M4VMmle/2rRFYVA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ce:b0:3a0:b0dc:abfe with SMTP id
 e9e14a558f8ab-3a0b0dcacfemr54462795ab.17.1726660709622; Wed, 18 Sep 2024
 04:58:29 -0700 (PDT)
Date: Wed, 18 Sep 2024 04:58:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003eb4720622638663@google.com>
Subject: [syzbot] [mm?] BUG: corrupted list in do_compact_page
From: syzbot <syzbot+b7a3118f6a494674077f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linmiaohe@huawei.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1f2d51b711a Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d2abc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=b7a3118f6a494674077f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d1f2d51b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3668422e8cc6/vmlinux-d1f2d51b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65c03a0a8e96/bzImage-d1f2d51b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7a3118f6a494674077f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 1106 Comm: kworker/u32:7 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: zswap1 compact_page_work
RIP: 0010:__list_add_valid_or_report+0xa9/0x100 lib/list_debug.c:29
Code: fb b0 8b e8 59 68 de fc 90 0f 0b 48 c7 c7 60 fc b0 8b e8 4a 68 de fc 90 0f 0b 48 89 d9 48 c7 c7 c0 fc b0 8b e8 38 68 de fc 90 <0f> 0b 48 89 f1 48 c7 c7 40 fd b0 8b 48 89 de e8 23 68 de fc 90 0f
RSP: 0018:ffffc90005d2fbf8 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff88802fef5000 RCX: ffffffff816c5a79
RDX: 0000000000000000 RSI: ffffffff816ceeb6 RDI: 0000000000000005
RBP: ffff888024213000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000293 R12: ffff88802fef5000
R13: ffff8880242130b0 R14: ffffea00009084c0 R15: ffff888024213008
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c35107b CR3: 000000004352c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 add_to_unbuddied mm/z3fold.c:550 [inline]
 do_compact_page+0x10f2/0x27b0 mm/z3fold.c:772
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xa9/0x100 lib/list_debug.c:29
Code: fb b0 8b e8 59 68 de fc 90 0f 0b 48 c7 c7 60 fc b0 8b e8 4a 68 de fc 90 0f 0b 48 89 d9 48 c7 c7 c0 fc b0 8b e8 38 68 de fc 90 <0f> 0b 48 89 f1 48 c7 c7 40 fd b0 8b 48 89 de e8 23 68 de fc 90 0f
RSP: 0018:ffffc90005d2fbf8 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff88802fef5000 RCX: ffffffff816c5a79
RDX: 0000000000000000 RSI: ffffffff816ceeb6 RDI: 0000000000000005
RBP: ffff888024213000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000293 R12: ffff88802fef5000
R13: ffff8880242130b0 R14: ffffea00009084c0 R15: ffff888024213008
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c35107b CR3: 000000004352c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

