Return-Path: <linux-kernel+bounces-382930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748FA9B1522
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280B528338E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 05:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494315B987;
	Sat, 26 Oct 2024 05:18:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529329A5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729919887; cv=none; b=um8O3+NxQKyjUezePZhlWj386LyuoqZ/8i0e8omuJWCkyqR3EykxqsjFttm7Xn2lQ6G0UpgisgeYm1yYeorAUZ5h0mtIC8rdEsvGgkb7Zy4i5KQmgGJSecEyAfk7+WuV0MMMTnQ0xsolsMr3y1uHYILmI0n4dFwPwSWFH/n2XVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729919887; c=relaxed/simple;
	bh=ngRKkJ4pytcpnpGAkPgPEaoaIQV5Q7IksTlx7O1VnEs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MuV5hrPvoitgZCRrZkuI5V8nU5KkBGzcSc7Ei86y45/RB7CHiFNCuUiryr9Mv6bt5OZh1xTmtZcwMJei5OCj781OXpXQ8EV6yn89OLXIBhMN6Xug/hMOGyUwMQ2S31VRVOC9BCpBvlOuVqk5OyRtZZEY4FwV2hIt00Ed54uldU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso28173265ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729919884; x=1730524684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqDaNDGJcPn0bYph8ZbOoP9Yyh7Atu0GA0pW2tEEQSI=;
        b=mDd23iDCytPOfRZL6pSK3lr/eT+8Vst+qtx/zcFz5/ayhPeIB3LBsAZzxQwqsuU1Wt
         R4EBCrTGy7fmHLzGYp6Zq5Vi3o4w3BhBJV81ZY67HPS/88VM6BGkNqHJSVsB5GH9N2lN
         PVA+Dzz42Gd1HTOaq4H89sQg0ohYOtNSjjBUFGfY0vgr/6ZFrr+CF9AJ7lBtEb5aJdzO
         TGOVLbvYRa3mBBzokn2Kkn7qi+Udcimq5xGGXRU5zZTODoJzM9jHkdHK5HJKlEFlFWZr
         WasJhWEiSm1qRbl7CTSEKr5/mu8GvQKTIkcazq8i4eJf1PsQZtKIokToDJZdt0gvRk9R
         KEiA==
X-Forwarded-Encrypted: i=1; AJvYcCXLoHysGEld/oTVhT8KDrkbOpd4X7D+GwczN7oic/y7lvkFHMhlGbai/zo3oQhDCd4qC0c/zr1XCinj7QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyayiagXqBOZCDwIgePUqifQNNTypFY61fHiEej40gSDWvRUDOR
	RxOrY5/KJt0y2h07xMrku3bIwSKABEAnSRrEXsBEctf/uo+CfDR1p83SnfplFcn6gs3/aVHkuOY
	KqC06c/8LhTorxffSci7Ykk1Nn3DXGXh0HIyIgxYNgBXbuRahV1SsXzY=
X-Google-Smtp-Source: AGHT+IFrWN6OExWl9c9WsecoJ/yc8vL+8TWAluLrseqKhm4X6lE3JFHf2U/x2OY0AmN2rC7LOB1cOPqGMs7XdLzpJp/zKuMxmP0k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:3a4:ec57:d7c1 with SMTP id
 e9e14a558f8ab-3a4ed2f7184mr13925365ab.17.1729919884127; Fri, 25 Oct 2024
 22:18:04 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:18:04 -0700
In-Reply-To: <tencent_8AD1777367243C273694968636624A487409@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671c7b8c.050a0220.2fdf0c.0222.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_journal_reclaim_thread
 (2)
From: syzbot <syzbot+820dc3b465c69f766a57@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in bch2_fs_btree_cache_exit

bcachefs (loop0): flushing journal and stopping allocators complete, journal seq 10
bcachefs (loop0): unshutdown complete, journal seq 11
bcachefs (loop0): done going read-only, filesystem not clean
bcachefs (loop0): shutdown complete
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_cache.c:594!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5815 Comm: syz-executor Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:bch2_fs_btree_cache_exit+0x1124/0x1130 fs/bcachefs/btree_cache.c:593
Code: fd 90 0f 0b e8 6d 46 84 fd 90 0f 0b e8 65 46 84 fd 90 0f 0b e8 5d 46 84 fd 90 0f 0b e8 55 46 84 fd 90 0f 0b e8 4d 46 84 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003717c40 EFLAGS: 00010293
RAX: ffffffff8410a3d3 RBX: 0000000000000002 RCX: ffff88802d6a9e00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 1ffff11006350f16 R08: ffffffff84109a77 R09: 1ffff1100c0e03b6
R10: dffffc0000000000 R11: ffffed100c0e03b7 R12: ffff888060701c78
R13: ffff888060700000 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055555b937500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3b2944000 CR3: 000000002888e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bch2_fs_free fs/bcachefs/super.c:556 [inline]
 bch2_fs_release+0x20e/0x7d0 fs/bcachefs/super.c:610
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe3bbb7f327
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd2b5b2c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe3bbb7f327
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd2b5b2d00
RBP: 00007ffd2b5b2d00 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd2b5b3d80
R13: 00007fe3bbbf0134 R14: 0000000000045d95 R15: 00007ffd2b5b3dc0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_fs_btree_cache_exit+0x1124/0x1130 fs/bcachefs/btree_cache.c:593
Code: fd 90 0f 0b e8 6d 46 84 fd 90 0f 0b e8 65 46 84 fd 90 0f 0b e8 5d 46 84 fd 90 0f 0b e8 55 46 84 fd 90 0f 0b e8 4d 46 84 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003717c40 EFLAGS: 00010293
RAX: ffffffff8410a3d3 RBX: 0000000000000002 RCX: ffff88802d6a9e00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 1ffff11006350f16 R08: ffffffff84109a77 R09: 1ffff1100c0e03b6
R10: dffffc0000000000 R11: ffffed100c0e03b7 R12: ffff888060701c78
R13: ffff888060700000 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055555b937500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000d98000 CR3: 000000002888e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         850925a8 Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161704a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113eaebb980000


