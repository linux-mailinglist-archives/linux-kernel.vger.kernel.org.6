Return-Path: <linux-kernel+bounces-448493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C79F40F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DBC7A2A61
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F013DBB6;
	Tue, 17 Dec 2024 02:43:30 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AF24B28
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403410; cv=none; b=aDagGCr7inugv/BrOjIWxiH7KWqnx++BrmtAfhc9ivd3S2OPIB/hnnKhXu5CzRB/kAgnukBR/zN1YaQwhiycpfmt/9EmkmHnuSOxhbBMpGUYxdQEgPqEs8wgbpKBph7+pB4Bs+gufN3YJayqVjRQZ7Jipu+tnQXpXKgJwNKtb5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403410; c=relaxed/simple;
	bh=7b/i0/7v3zR/h77CHsxN38gG0BNtlu6Lk8HiPRWujtQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TgZZ/5qGM1o4P0yJ9uaH0xk0yMKbaH5LqXvSNjlNxsVFiR/ZusbbMTogPEAR8Kwi/6E1VOEaR2OD+Cr0WRguK3uf8aAbwSudIVrMaRP9qBynw/a+PktoqopH5xETYsSfVIpmk9wyewXjaKfgCHjd/X20y4qgWEX7fjgkhSufbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so103686565ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734403408; x=1735008208;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qu1MMB+hoYgMdweo0Qa2QY0CoK/Gp8J8v++ER42Ayzc=;
        b=dRhb4qPZDJ+YDPD/OjNrUlh2r8sNBi2WJjq2c2bsi3lcnBw+k20t2vSmZ12Fsal0Qo
         HvIMHz8WYdTr3xcFopX2m/27QaittmQfuX+qU1jWJoQQ6jCyUtPZfgfzD85P+mDiDAix
         m3ZhWMYG3w3pv//FhT6X8NRYrMivZbkMW86M59m1RctKa077ttwH9TKLmG+1AR+fO3vP
         6wBxKrKpLrGUmnIsx9WVN/Wz+UpSjwL0XNYh+Qpi7ix4jIPk9NOLczDUO68W1ZXWio1V
         H9XP+1LoP2692NarON4WnqHrx9mdf7STKZTEF64KhvcyOOQGX2e8JGy4CVZGk+tXNgwq
         FbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8D57yTS8rTekceX3O0xYeVKh0fzLwHsiACC0x/8d6JgtbdslQ91XIKiKDyNsd6Iw4rfFHdBGOghaf1bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGeDmnyN4UDbdlVf7tXHE+CeFdTjReWRkPqJ1QDcY+woGEVPIs
	pjnaf/DZHp0dtu+Ol9mUzR4ORkRTAWs98GyEyTLwyrkCWvinFAm71+jw70nlH7MODIP5jElmCpQ
	cQAKeyAjiVMbW/GPqS27xRPZV0RrxP6pZ6jvM2a0+Hg9Qps4tpB7hvz8=
X-Google-Smtp-Source: AGHT+IFtjrQQ+hRh8O6mpSspPY3JErwmwS3IEJlSfKzbzz8iOWvTDcaDKEZKStGI4uMesYJ+JqV942VL0i+uEBBtCCzkwc7StTDG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:3a7:1f72:ad3c with SMTP id
 e9e14a558f8ab-3aff0961e22mr162128285ab.19.1734403406120; Mon, 16 Dec 2024
 18:43:26 -0800 (PST)
Date: Mon, 16 Dec 2024 18:43:26 -0800
In-Reply-To: <6741d52e.050a0220.1cc393.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6760e54e.050a0220.37aaf.0143.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in __find_get_block (2)
From: syzbot <syzbot+3c9f079f8fb1d7d331be@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f44d154d6e3d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14d627e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=3c9f079f8fb1d7d331be
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e302df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1265b4f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a0fb07264d5d/disk-f44d154d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/adf6a39fbd67/vmlinux-f44d154d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d07b6ebb722e/bzImage-f44d154d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2fe321e2e902/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c9f079f8fb1d7d331be@syzkaller.appspotmail.com

------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: CPU: 1 PID: 5156 at fs/buffer.c:1229 __brelse fs/buffer.c:1229 [inline]
WARNING: CPU: 1 PID: 5156 at fs/buffer.c:1229 brelse include/linux/buffer_head.h:324 [inline]
WARNING: CPU: 1 PID: 5156 at fs/buffer.c:1229 bh_lru_install fs/buffer.c:1346 [inline]
WARNING: CPU: 1 PID: 5156 at fs/buffer.c:1229 __find_get_block+0x109d/0x1150 fs/buffer.c:1400
Modules linked in:
CPU: 1 UID: 0 PID: 5156 Comm: jbd2/sda1-8 Not tainted 6.13.0-rc3-syzkaller-00017-gf44d154d6e3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__brelse fs/buffer.c:1229 [inline]
RIP: 0010:brelse include/linux/buffer_head.h:324 [inline]
RIP: 0010:bh_lru_install fs/buffer.c:1346 [inline]
RIP: 0010:__find_get_block+0x109d/0x1150 fs/buffer.c:1400
Code: c7 3c 9a e8 d5 60 dc ff e9 1b f7 ff ff e8 5b 83 78 ff e9 87 f7 ff ff e8 51 83 78 ff 90 48 c7 c7 20 ee 18 8c e8 74 26 39 ff 90 <0f> 0b 90 90 e9 6b f7 ff ff e8 35 83 78 ff 48 c7 c7 40 c8 a8 8e 4c
RSP: 0018:ffffc9001048f440 EFLAGS: 00010246
RAX: 8c4056f058b05800 RBX: 0000000000000000 RCX: ffff888035151e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9001048f570 R08: ffffffff81601962 R09: fffffbfff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa210 R12: ffff88807a001828
R13: ffff8880b87398b0 R14: ffff88807f336910 R15: ffff88807f335a58
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1a9566c130 CR3: 000000006602e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __getblk_slow fs/buffer.c:1127 [inline]
 bdev_getblk+0x189/0x670 fs/buffer.c:1431
 __getblk include/linux/buffer_head.h:380 [inline]
 jbd2_journal_get_descriptor_buffer+0x1c3/0x4e0 fs/jbd2/journal.c:968
 journal_submit_commit_record+0x11e/0xa90 fs/jbd2/commit.c:129
 jbd2_journal_commit_transaction+0x3c10/0x6560 fs/jbd2/commit.c:877
 kjournald2+0x41c/0x7b0 fs/jbd2/journal.c:201
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

