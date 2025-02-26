Return-Path: <linux-kernel+bounces-535029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BDA46DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CCF3ACCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C6E25D551;
	Wed, 26 Feb 2025 21:53:24 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8725A63D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606803; cv=none; b=TjFJu77pphdgeRua9UpIoVjv9pD9Q8UVMhgPJQFa8jKKoCNcVBWodI/WV8mgcIoM5h90Z+ZEVgSqSLqdOn/Xejk7Zhrmhs6itAQK/v8A0DOBvZxjcJPajQK26njUmGXEnFqd1f8rkCoGjp2lR3gcxVPqsnPlkfl1H0FxWKx4Wk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606803; c=relaxed/simple;
	bh=sv0dKcBt/bKkXVRUC1sAljTJTNjVv3FGpLnyxt9RQBE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d4g4Z6Ydd2GGYhMWSl7OnUCN++r/rzw+nMgTx7AUdOu/S1zWFcx9kQ4aLAOvfQluw6/0MbE+eYARJGalbDd76qTnvMdGgUpk6VyD+LQg4m7BQFUxZVW8oL616DPF8INFQnUz45KlGSzzN41Ks1GBv6uGKfPCup7+76kQmCYwAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d18700311dso3192145ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740606801; x=1741211601;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbmWJ9DJNoOMF0ppF15ubSg2HJVCK35INpCBaiEGn10=;
        b=kutfgTh5SmwyfDVjstulvo1qdo5+mPmmYcUdWfCMVzQDikrLGUr4+1geFXBgDH/XhM
         cWPbhR6umJdXD11ubUY5orGFSZDL6jNcSqL2IcZwWRzUE7zC/PAT8DP/Pb/ee4lAzzWe
         Grz9BHlr8tmJB7lL/0L8jZkpChqiS3uyukr7JzOaC4WlMHL9UOztsSycLXll/7mWgsMg
         AZy3PNMcTjZsokMZ7dAzZl31Kgz6R3kHobteZb+5lYR8xhsECaphZfkckKmOoWlrgf5s
         bG0jQWX3kjEbmUMQPNstU0WzX/fkxfboTPQLO2aTK3b2TsC7ZB6+cPH/xLgh5VIlyK/H
         ybgA==
X-Forwarded-Encrypted: i=1; AJvYcCWKxbvvvkb0Zo7Q9t3zYAOO0XQ6Eb5L98XGgt67sQxkm7qeHaVxtD1Gc86jJ3trpc5ZLXi97QfssWPuPr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbN6JWYH7zLJ4gg4tiiAi4gAb3ivK9Cw5LVBa6XS0UYyKX7XQ
	BDZQJlHktl5xEE7jLq6q0wYgprB0llgAP5CyVBcXAjK0RX7z/qjiYisZzd5xQhzn3PRRT54HMPu
	qXpvZq8o0PEKW5meJY438yrSu/WyIHtfF4i0PqXTpjYDWPdP9jegntTk=
X-Google-Smtp-Source: AGHT+IEq0kEjVTCJtgk1ykwmmIcPRwJAg9qPvwCmP+cJoK8Hli2D+nss5GYGHls/7yoZVnEa8zErRmMoqQ+4LCFDvND6eAHhJ0+s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a86:b0:3d3:cdde:fbf2 with SMTP id
 e9e14a558f8ab-3d3d1f9885dmr56339175ab.15.1740606800100; Wed, 26 Feb 2025
 13:53:20 -0800 (PST)
Date: Wed, 26 Feb 2025 13:53:20 -0800
In-Reply-To: <67bf882e.050a0220.1ebef.008f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf8d50.050a0220.1ebef.0095.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in traverse
From: syzbot <syzbot+0b16dd9bd622c40b2bbe@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ac9c34d1e45a Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175b003f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1635bf4c5557b92
dashboard link: https://syzkaller.appspot.com/bug?extid=0b16dd9bd622c40b2bbe
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ba9db0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10479c98580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ed21c75da715/disk-ac9c34d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f51096fe566c/vmlinux-ac9c34d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e6a27961fbbe/bzImage-ac9c34d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b16dd9bd622c40b2bbe@syzkaller.appspotmail.com

RBP: 0000000000000001 R08: 00007ffd17221997 R09: 00007fd111db0032
R10: 00000000000005af R11: 0000000000000246 R12: 00007fd111db3618
R13: 00007ffd17221dd8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
=====================================
WARNING: bad unlock balance detected!
6.14.0-rc4-syzkaller-00052-gac9c34d1e45a #0 Not tainted
-------------------------------------
syz-executor218/5831 is trying to release lock (event_mutex) at:
[<ffffffff82399e2d>] traverse.part.0.constprop.0+0x2bd/0x640 fs/seq_file.c:131
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor218/5831:
 #0: ffff88802f5d5790 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182

stack backtrace:
CPU: 1 UID: 0 PID: 5831 Comm: syz-executor218 Not tainted 6.14.0-rc4-syzkaller-00052-gac9c34d1e45a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_unlock_imbalance_bug kernel/locking/lockdep.c:5289 [inline]
 print_unlock_imbalance_bug+0x1aa/0x1f0 kernel/locking/lockdep.c:5263
 __lock_release kernel/locking/lockdep.c:5528 [inline]
 lock_release+0x525/0x6f0 kernel/locking/lockdep.c:5872
 __mutex_unlock_slowpath+0xa3/0x6a0 kernel/locking/mutex.c:891
 traverse.part.0.constprop.0+0x2bd/0x640 fs/seq_file.c:131
 traverse fs/seq_file.c:98 [inline]
 seq_read_iter+0x934/0x12b0 fs/seq_file.c:195
 seq_read+0x39f/0x4e0 fs/seq_file.c:162
 vfs_read+0x1df/0xbf0 fs/read_write.c:563
 ksys_pread64 fs/read_write.c:756 [inline]
 __do_sys_pread64 fs/read_write.c:764 [inline]
 __se_sys_pread64 fs/read_write.c:761 [inline]
 __x64_sys_pread64+0x1f6/0x250 fs/read_write.c:761
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd111d48329
Code: 48 83 c4 28 c3 e8 17 1a 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd17221bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

