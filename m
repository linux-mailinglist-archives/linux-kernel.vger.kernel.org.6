Return-Path: <linux-kernel+bounces-421827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1D99D909E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1240289502
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A94740C03;
	Tue, 26 Nov 2024 03:04:32 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27454BE65
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590271; cv=none; b=U7IYZc7LezXrnmnxjZ16r5b6IBPucZ6i0iOYImFwZbrATXfsJ7EbxnSMaYZGhbROK7vnd8nwzlceNn2fEjlgE9u/xWOs39A9PSKsRQvImOyPs9gPbKgkR7tRpnTt49S6KAnSaMcG6bo2gAPE7Cj0FzwqQetGx9yaAihxEjX0mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590271; c=relaxed/simple;
	bh=P19WWwfgbFEf7AqER2f429xUDIzlJMpqe+gRhfanih8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=og/FRnUv4N26XdzRP7kO+ZhGb1HBMQI3qvwpK3TbfUTfwPlm0Z0bbE2/iU0tTjlFiyz+/VaUsHSVEhFwqd7msi8LX+BY7CGjX/SpwAHmCXGwiMZrXdf1CAhCZjOWquSsSWXv8rLtx1b9c+WVNt+EnxQgI0cEcum0oLaxBN7aZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-841a9ae0f26so123729439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732590269; x=1733195069;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRfzjzc/xInDnhgzk040JjwlrrhzC743QavYKNg9fd4=;
        b=EsgU8eH0CMdZbduqyB9OYY10ylVWE7OxOqinMvj7G0oLfOiGn/RHyDkj7DidNXRFAp
         1ZjQCmyIq+Vt4Gk7I0nR706npkseS+mDiMCh/T1StBAS0kUmvjKqpL1+toGJjTxvKJwX
         OIDbEEC0ezbRHd/KakdXJ5aBLDPWTFhwrbWO0iMpKGQrkIHhd2K0RD1PvMhDlVGICbAx
         ISR0MF1uhAheSDkqM6fmVi8imuUZR++wX6dHH4OdFcF7esq7I0kHDXSTbRcD5e+0gFeb
         fpJsWyJzjEVmryTMCwhmUXFIO1fAZF6CB5LuY15c1fJLJ46/8wkbCwjO6f/0kMHdKcnA
         GNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXozpEbWtoKkQQrPxuHWohiLF4BOYicGK88mKRzolzAZTPC97Epkdcqp2w1Zz0b345G+lzlchon57+Q4Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybV1WsXhLXRQSdx2o09SEy7FfXfFGcJ7GMKSeIVDS9kiqFxfEb
	gw+0A8NByQRMqPPE/EdegRflhpun6ejRHBlmal3tbfJx9Zj9rXGLI66SC6MSJLGcTSyYvHMyQYl
	HVcc7e5t1CPY9GGfb7cHmSeKPdLDmz8NxfvxKLusjh9lknoWby/KDQmU=
X-Google-Smtp-Source: AGHT+IGLaTZForFqVV69sik6YOxgHxlcdbPLObaEwVzlPgvUc3DAEKaMSUYPoXEPDAzQJmGFNIDpEDWcUXm3/gW1XO8mtsxNWq9a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3a7:95e4:a165 with SMTP id
 e9e14a558f8ab-3a79aceab1cmr161143195ab.2.1732590267900; Mon, 25 Nov 2024
 19:04:27 -0800 (PST)
Date: Mon, 25 Nov 2024 19:04:27 -0800
In-Reply-To: <671a976f.050a0220.2eb763.00c7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67453abb.050a0220.21d33d.0009.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING: locking bug in ntfs_fill_super (2)
From: syzbot <syzbot+b856fe782caf1f85be6e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    85a2dd7d7c81 Add linux-next specific files for 20241125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=137ee778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=b856fe782caf1f85be6e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14173ee8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eff72ae97118/disk-85a2dd7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/18f336c941c2/vmlinux-85a2dd7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddb67e7b7257/bzImage-85a2dd7d.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/0dfd78502424/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/48b325f85b71/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b856fe782caf1f85be6e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 10300 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 10300 at kernel/locking/lockdep.c:232 __lock_acquire+0x135a/0x2100 kernel/locking/lockdep.c:5223
Modules linked in:
CPU: 1 UID: 0 PID: 10300 Comm: syz.0.2130 Not tainted 6.12.0-next-20241125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:__lock_acquire+0x135a/0x2100 kernel/locking/lockdep.c:5223
Code: 00 00 83 3d fb 04 9f 0e 00 75 23 90 48 c7 c7 e0 94 0a 8c 48 c7 c6 e0 97 0a 8c e8 b1 54 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 83 c3 40 48 89 d8 48 c1 e8 03 80 3c 10 00
RSP: 0018:ffffc9000c03f650 EFLAGS: 00010046
RAX: 89afe599c3bc1700 RBX: 0000000000001700 RCX: ffff88802fd80000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 8fe977d821a4f04f R08: ffffffff81601b32 R09: 1ffff110170e519a
R10: dffffc0000000000 R11: ffffed10170e519b R12: ffff88802fd80000
R13: ffff88802fd80000 R14: 1ffff11005fb0165 R15: 0000000000000001
FS:  00007fdea42fe6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4631891001 CR3: 0000000031e76000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 iput_final fs/inode.c:1935 [inline]
 iput+0x615/0xa50 fs/inode.c:1972
 ntfs_fill_super+0x3e27/0x4730 fs/ntfs3/super.c:1472
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdea357ffba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdea42fde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fdea42fdef0 RCX: 00007fdea357ffba
RDX: 0000000020000080 RSI: 000000002001f740 RDI: 00007fdea42fdeb0
RBP: 0000000020000080 R08: 00007fdea42fdef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000002001f740
R13: 00007fdea42fdeb0 R14: 000000000001f70e R15: 00000000200000c0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

