Return-Path: <linux-kernel+bounces-169772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36578BCD74
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78361286B16
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2460D143882;
	Mon,  6 May 2024 12:08:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCB23D2
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997288; cv=none; b=cgMazuCuQBBEswE1U7xTiZk7Yh0Z/4MRTKPccmFhHBr8vQVuNqm8X3qS8I+nDZhnfqFXB2AOm072l8dqXD/oj8FhrWWVHgqUZfW+Dv3hyeBBKxtrJcYOr/K9tMAj1e6TzcsVsL8P+pXRwaZYKVW4IQyRjIh4AjXReqt/GQJmngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997288; c=relaxed/simple;
	bh=yMB73GUeBbjf/Mz8RwCQOtmC/yPXfgt6zWGIACdggOc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H1RBTVHTgThIEBPhshd5w7f4fmQ0IDKIdzoSkbPLtH0e79PqCgbwcaLj59hRMo6odLiHUDisG/MjWvGMJggsov27/WdNp1rHIL9Ic7caFMqw4eaDiPE/oA15L9tRrOopaIWukzoD5L0ULs+B5Urcj0p5RjwUTGLXKJQQX4si3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da7d4ccb67so215078939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714997286; x=1715602086;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEfmEG7fEoPis0UwcNNV3nxoI/VNpiQ1oISNvF0hSzY=;
        b=aH/KVMEgECK65DjU0hEfyfAatScli3QQ4FdHUgsUQPPmFxRL1PyG8YZzIE/9l7LJQI
         HQ4lYXTc5dmt7bFdx/VAtvgEOMRqPuRIK1KYcDK15hhZGIxvyBRz6Sla817rfMNJy2kB
         /av9M69hXpwbQ7eqgM2LapQNuTOiU9y4/E+e6WFggusyBh1MjER+IZ8l5uCbDzR1Jttb
         Lb+2j0x+fQpSSROyXq5HdB2SoHhD2k0SYbVx8/RBmjterFPIU1xJ82tDoc0t3CCzi8Wh
         ML0mNKJzVK3LIkXGHmGGqwov0M+yS6uJFDEzfAQ3Nq7fei8k5Gn7pEeeNKDkoUL/xyRG
         CQKA==
X-Forwarded-Encrypted: i=1; AJvYcCXq1OYP6wiFRFZ32tg72SdIpCR3I2t0TS3zxI6kF/9hxw5IjGfwQJHMfJg/AU8RaGcWAPPykUNxw5GhUEQBnbt4vNR+p6f+KWUwDwlO
X-Gm-Message-State: AOJu0YzLIIZJt12VVf1CQCLdVRkxJKiP1VQjilHzYzz5CiNbzIHRqviu
	DF+/spybjAumrT7XgYdyopkGA/OauaXz9KLWK28d4qriF6z5vCDbJNhxHFOnGPcZIXvqmzuGtXa
	9QFReb+OHUggGdDo9oPOm8VEqw3hMd1i8DkutroCWtNRaNgj+iIvCh0Q=
X-Google-Smtp-Source: AGHT+IEyBUxwaRV0toOml00RqZd7MJt+Ikbt6uaPVrdSb5WD5TGa7HpyEdx9BDBXU/PVVTZa5lAkAr3feClza6I/Lqk2O6oiiHVp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9508:b0:485:65de:892 with SMTP id
 lb8-20020a056638950800b0048565de0892mr383392jab.5.1714997286008; Mon, 06 May
 2024 05:08:06 -0700 (PDT)
Date: Mon, 06 May 2024 05:08:05 -0700
In-Reply-To: <tencent_8FCF868D9725D00DF592245DE4DD86997807@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006085a0617c7eccc@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in rewrite_old_nodes_pred
From: syzbot <syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in rewrite_old_nodes_pred

bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): journal_replay... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): scanning for old btree nodes: min_version 0.24: unwritten_extents
bcachefs (loop0): going read-write
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/move.c:986:31
shift exponent 64 is too large for 64-bit type 'unsigned long long'
CPU: 0 PID: 5498 Comm: syz-executor.0 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 bformat_needs_redo fs/bcachefs/move.c:986 [inline]
 rewrite_old_nodes_pred+0x45e/0x620 fs/bcachefs/move.c:1002
 bch2_move_btree+0x792/0xde0 fs/bcachefs/move.c:886
 bch2_scan_old_btree_nodes+0x14b/0x3c0 fs/bcachefs/move.c:1016
 bch2_fs_recovery+0x534e/0x6390 fs/bcachefs/recovery.c:887
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1043
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2102
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f272547f3aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f27261f7ef8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f27261f7f80 RCX: 00007f272547f3aa
RDX: 0000000020011a00 RSI: 0000000020000100 RDI: 00007f27261f7f40
RBP: 0000000020011a00 R08: 00007f27261f7f80 R09: 0000000003004081
R10: 0000000003004081 R11: 0000000000000246 R12: 0000000020000100
R13: 00007f27261f7f40 R14: 00000000000119f5 R15: 0000000020000040
 </TASK>
---[ end trace ]---


Tested on:

commit:         7367539a Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=171a15f8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=594427aebfefeebe91c6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10bade4c980000


