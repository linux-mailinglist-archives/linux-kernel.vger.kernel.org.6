Return-Path: <linux-kernel+bounces-169232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86598BC57B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 03:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150651C210E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 01:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C8381AA;
	Mon,  6 May 2024 01:34:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40522FB6
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714959245; cv=none; b=AKYH7IS8B9KIBrstq3fUYGsI4ADvDxNABjpSXUTAcWYUAF/SvXpMU0a+xAmuOitYwijaeSWdCPYcRad+3M+GfxGcbuAW/SSg+z8kZpF59Ynu2iIfTJHSs6PXpi4NcphA+p2YFotc5n3eoPY6gUxocVJTyPXpsSwte56ifNaH8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714959245; c=relaxed/simple;
	bh=PfbTXQlcuURZ+vN+PZ5u2wq8vO5+kDMe0J/+k+wKXGM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mtr+BFrHOxmt1g450qRUQXAH+6Li6rxhrqUXTZVtiHPZGNQUdkp+CH7vaFz/K32fESeI0TiG0Vq8Ade0jCrF7hgn36dXTZmS8ggGKwnZwARyCnTaV93+vwCQaHQz3Cs9DLNyEp/JRgHtKQ6B7Jh5SM1hgcgqt9NsKZFEikgz8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dab89699a8so190078239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 18:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714959243; x=1715564043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fRMvPdjrWJ/16wZHTFZUTGKHf/OyT2Xy4ugjtl1NuM=;
        b=ow2L1UsANSNQXdbcTCJPCFOzz5RmO4oq9XioK8dCabenxE8B0QWLd2+UJfhAVtTUco
         T8s2yITtnjO5vijaDwwQyKnqDjcZxCjHVLrTnjLSmB6JVM9H9Imefe1tIYytfLcBsQf3
         44eQ1B20Skw/NMIenntbJm39rbbvvczW+s7wkyLZaVnsDXnpy0y24ta9fiAOFL30sfN/
         pWiKz48BkUYGVNUfY9lVABQ+36TLDz7hMJpb6ekxCyvz7YjRQ1QgMxpa9outPNWYdIfy
         R6Fm69GgGD3brAXUEUKNo771qzOSbb3yaTx55F2zibJYzuy8NP7uzzlfu4v15k7xZMRb
         w91Q==
X-Gm-Message-State: AOJu0YyERvXO7kE31eSxDDUrsgI8I4LEm3hnmvf19PNus1dt16oqRBOR
	x3LhvUU1TF8rboDceypodrnjoyF040X/ozH9VDjKWlPxaii1Z7JCd12Stkbb1pC6VKC74C3TS0N
	wkGdffRqH2v48hy5RvNiBvuyrwYi33v6CkAsH6RqbJRCadobs1zuvn90=
X-Google-Smtp-Source: AGHT+IHFus9mJHzvrPU/l8JwnwqenjV+lVFLJkvRFjcIOA9JoYo+cSTEGR6yEyqgjtzNwHXmRLCydBmb0MCg+U3x6/vhx5TLLXto
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:869c:b0:487:c6e:1bf2 with SMTP id
 iv28-20020a056638869c00b004870c6e1bf2mr559587jab.1.1714959242866; Sun, 05 May
 2024 18:34:02 -0700 (PDT)
Date: Sun, 05 May 2024 18:34:02 -0700
In-Reply-To: <20240506010441.1627271-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079c3720617bf10a2@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in rewrite_old_nodes_pred
From: syzbot <syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
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
UBSAN: shift-out-of-bounds in fs/bcachefs/move.c:986:30
shift exponent -1 is negative
CPU: 1 PID: 5493 Comm: syz-executor.0 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 bformat_needs_redo fs/bcachefs/move.c:986 [inline]
 rewrite_old_nodes_pred+0x496/0x640 fs/bcachefs/move.c:1002
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
RIP: 0033:0x7f91bb47f3aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f91bc1b7ef8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f91bc1b7f80 RCX: 00007f91bb47f3aa
RDX: 0000000020011a00 RSI: 0000000020000100 RDI: 00007f91bc1b7f40
RBP: 0000000020011a00 R08: 00007f91bc1b7f80 R09: 0000000003004081
R10: 0000000003004081 R11: 0000000000000246 R12: 0000000020000100
R13: 00007f91bc1b7f40 R14: 00000000000119f5 R15: 0000000020000040
 </TASK>
---[ end trace ]---


Tested on:

commit:         7367539a Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1739b22f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=594427aebfefeebe91c6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115b28d4980000


