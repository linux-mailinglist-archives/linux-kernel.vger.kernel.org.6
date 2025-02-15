Return-Path: <linux-kernel+bounces-516016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA6CA36C01
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61853ACE03
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BAD158D8B;
	Sat, 15 Feb 2025 04:32:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86571748F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 04:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739593925; cv=none; b=eWhwz+d+Jvw5yWSa+ZQ5oIZeJXuh0Ot7TNxHXlk5zpa2ZvDivWn2vKSilYyw0crNvVboXy51l/zMl1ahowG0g655BPbn6QvkspFsZ8+FhOBS2yU8RKSdRTYFOuPmDRgDPHhVwcVqCyOCTB2eZm7PmfVTCSBohE938G3GDQUWjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739593925; c=relaxed/simple;
	bh=jXxB1sO1Q2mgr279iig2laqVk5aIiyar2+mpIsWZStQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DegIIWkrBU2gW0Kg4fnfcrOJhUGwfXelsjwkU9pZishPhnORhLQR6+KPynsMU2sS/7cJlp0C3xdxu37tLoEigKNaaKVud1KanJqMOWmHEzquW84Qf5PnmQH0sRJeHgmLhbxnbCZHqvyNxanJiK9FuZMlVVS/COGzjgq/Meljf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so20990355ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 20:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739593922; x=1740198722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVj83mTTuUySpU37KiSifYmO61f5xL6NkhpndYoELdo=;
        b=EYnH3c8Uc+U9JQNFHF9YDz+eg1a6PqBkxXbZzlxA3VTy2JMSb7k8ULao+PFmLN4qq8
         0dWjX9HzV4e9gAk7uuMGVdLm/I264SuMXA5PK0rXZ1g8/VPn9SVnAo4rpYqenkvFBWPh
         H0MehoiLA7afHvNCsmGqZU8hz1Omu38STJDWIBx7+CA0h6/NJo3uh1vGhgcUn6uUzc7g
         fHfrIUV/U+Ei8jk59WYxAS3J9aX0jhugihvWStyaEVgIsj7e5wwGVqC5FnVWV9bzmpQk
         AQQpATP3YnIt22FPfhyDcI86/NapyOG0+qd44N2hBXcJzZS7HUCQUx3qApFZq6yxja0e
         4IrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKi3rmWIpBpGJC/7hQL8kpTvLDmSyEJbx78suTi9B6ZfFN3aihHG11MfjHGKWAoPkM0WD+tHcvRex2irE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwK9X1C8wB8HC1Z+G5JGjiJ9+PLhoD38Bh40av5ZI6S9p99Rr4
	NdJN4paU8L1utsYJgbjq7eHoloW+iyaHPxHZSyglMF8V13rMp/7/iKTHGK9MCJFQZCSofwpEo4x
	1XWhLOgESiZyQleo7j8YizeR7WFSB10JwpFkOCJd2lygpi1uJatJ/Cdo=
X-Google-Smtp-Source: AGHT+IEP5HtynDLeociMDDauE2PQpRqgTS/N1TfzgfUEuab2pjz7bcnsBiGzD2H5Wru3YFTc4wty0jfEu8ThOp2lwST8FGHZTjxh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0f:b0:3d1:883c:6e86 with SMTP id
 e9e14a558f8ab-3d2808d7ad1mr16579715ab.8.1739593922687; Fri, 14 Feb 2025
 20:32:02 -0800 (PST)
Date: Fri, 14 Feb 2025 20:32:02 -0800
In-Reply-To: <tencent_69777A376EC6CD33652368897203A5C44405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b018c2.050a0220.21dd3.0066.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
From: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in netfs_put_subrequest

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 85 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 85 Comm: kworker/u32:4 Not tainted 6.14.0-rc2-syzkaller-g7ff71e6d9239-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound netfs_read_collection_worker
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 08 5b f5 fc 84 db 0f 85 66 ff ff ff e8 5b 60 f5 fc c6 05 17 5d 86 0b 01 90 48 c7 c7 c0 00 d3 8b e8 b7 99 b5 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 38 60 f5 fc 0f b6 1d f2 5c 86 0b 31
RSP: 0018:ffffc90000fdfac0 EFLAGS: 00010286

RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817a1229
RDX: ffff888021798000 RSI: ffffffff817a1236 RDI: 0000000000000001
RBP: ffff888030d38e60 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000005
R13: 0000000000000135 R14: 0000000000000001 R15: ffff888030d38e60
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0022d90a0 CR3: 0000000023ac0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 netfs_put_subrequest+0x2c1/0x4d0 fs/netfs/objects.c:230
 netfs_collect_read_results fs/netfs/read_collect.c:300 [inline]
 netfs_read_collection+0x1f09/0x3cc0 fs/netfs/read_collect.c:424
 netfs_read_collection_worker+0x285/0x350 fs/netfs/read_collect.c:471
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         7ff71e6d Merge tag 'alpha-fixes-v6.14-rc2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142967df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c09dc55ba7f798e3
dashboard link: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143167df980000


