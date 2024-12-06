Return-Path: <linux-kernel+bounces-435372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD39E76AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757C4284724
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679231F3D49;
	Fri,  6 Dec 2024 17:07:35 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550691FFC4C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504855; cv=none; b=tM7Eo7y8RSXBxok0112r39zFpHv65hq3uoY95s5FRIQqVDl7wPxIhNSTiCJzawnTLvUQOT0Xc3xmcCQ35l/hoska2OMl4pUW5otSOF+x73r01zZc+50FrW7fJ5YOekxfs4Xr3FQ1ZTXBW93DT+iNk2lwHyKe7btLCNkc6vSAo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504855; c=relaxed/simple;
	bh=4q8yDMTfc09NPzzwRYnIFy2ENH9ObjoaraJo4EZShcY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ql6yDWquuXirJNDBih3pVCsAUNVZGp6b6P5LDC+AaW5G3EwjD8WGiJCh3XBt79dX1cLXsxD6uY2OkKS/cRrWvCWl2f0cUUQvDdh0lzDnpXtPKWvIRkYluxB1MddxYToK2PMnuFR0yPjz+JD/1hrCHis4vj3GF6mb1wRm5Cyl2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a81570ea43so9385195ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 09:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733504852; x=1734109652;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3ToCg1oZmUTHAe8VqTMmZaX3s+UFbukdNccXKpQqBM=;
        b=lRFYABMyoSz6uyR+GjzbiUkk/xyYPTDiYgTcrHcOgDGre4XE/nJ1ZcAL6X2rZSETY2
         10/d6ydFu3s/lvyG6FKGhcHYgB07zgjVnauCz6FboKbXfo7f3HLGycgccLLkgqCRRzl5
         +30F9bVpccZy8VQpZznEylYrQJ/LMMC8hG0HWI/kz15YGUomEUdJzqtuLuFKfrZymm5T
         ALeKLBuDi2ewb0uyn6MVV/PrTv79aFrRE+ZhepIPXm7RmfyOX/leL1YLj30rANklDsbi
         8tYF2+KBO1lMBsTOGLYdc8FE179PC9Kg6eIs1uHGpq/tzqnfZRsUhwJU6w5OuL8XQyB0
         LOQg==
X-Forwarded-Encrypted: i=1; AJvYcCV39cmhrsEqJpgH6NcS91LKf6mQ0O32PRhnKvvhhKVcj0gLfGpqSGXViklgqkDvCvuNCeiMAiq7I+sK8iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpwGCL0V6G+RNEokCfYlbgAzq8YB5cTqNHhVjMDveIooVF7kZz
	DncCgfbWvbgzsiTL0EEDfSamcAP8KNu0QOj3qdGZf7mwqhZp8bk+3jSO/2FvCn2+klf2gyXxhAy
	/FNy+e3vAn5uf2Dvx2/zoNYyw9ZPfGpEn/ZVQU4gqwa4Cra6d8G0Ckp0=
X-Google-Smtp-Source: AGHT+IH5KQd3lTPqzzszmHoWEmqSW5kBjzQ6bpWqs7MzSI8Vdtg6aMzGrjdBh6vQJjiXhA22kcylN2Fjx3SA257i1NtjWGt1tcfq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e06:b0:3a7:d082:651 with SMTP id
 e9e14a558f8ab-3a811db1f7amr47114085ab.12.1733504852456; Fri, 06 Dec 2024
 09:07:32 -0800 (PST)
Date: Fri, 06 Dec 2024 09:07:32 -0800
In-Reply-To: <67388dcc.050a0220.bb738.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67532f54.050a0220.a30f1.0142.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (4)
From: syzbot <syzbot+5c81eb8c0a380fa578b5@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b8f52214c61a Merge tag 'audit-pr-20241205' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ba98df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335e39020523e2ed
dashboard link: https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155bd0f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cad330580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cfa353b9a35b/disk-b8f52214.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e744ff2abaf/vmlinux-b8f52214.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2dbf687d48e1/bzImage-b8f52214.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/45ab44aae0f6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c81eb8c0a380fa578b5@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:920!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5827 Comm: syz-executor120 Not tainted 6.13.0-rc1-syzkaller-00182-gb8f52214c61a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:f2fs_evict_inode+0x1671/0x1690 fs/f2fs/inode.c:920
Code: 31 ff 89 de e8 f0 f0 a3 fd 40 84 ed 75 2c e8 e6 ed a3 fd 4c 8b 3c 24 e9 63 eb ff ff e8 d8 ed a3 fd 90 0f 0b e8 d0 ed a3 fd 90 <0f> 0b e8 c8 ed a3 fd 90 0f 0b 90 e9 fb fe ff ff e8 ba ed a3 fd e8
RSP: 0018:ffffc90003d17918 EFLAGS: 00010293
RAX: ffffffff83fb83f0 RBX: 0000000000000002 RCX: ffff88804cda8000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83fb7dd7 R09: 1ffff1100cbe51ad
R10: dffffc0000000000 R11: ffffed100cbe51ae R12: ffff888065f28910
R13: ffff888065f288c8 R14: dffffc0000000000 R15: ffff88807e0e0000
FS:  00005555814413c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2787dbd000 CR3: 0000000021b7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x4e8/0x9a0 fs/inode.c:796
 dispose_list fs/inode.c:845 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:899
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4972
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f278ef02cb7
Code: 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffca034a6e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f278ef02cb7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffca034a7a0
RBP: 00007ffca034a7a0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffca034b850
R13: 0000555581442700 R14: 0000000000016846 R15: 0000000000000008
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_evict_inode+0x1671/0x1690 fs/f2fs/inode.c:920
Code: 31 ff 89 de e8 f0 f0 a3 fd 40 84 ed 75 2c e8 e6 ed a3 fd 4c 8b 3c 24 e9 63 eb ff ff e8 d8 ed a3 fd 90 0f 0b e8 d0 ed a3 fd 90 <0f> 0b e8 c8 ed a3 fd 90 0f 0b 90 e9 fb fe ff ff e8 ba ed a3 fd e8
RSP: 0018:ffffc90003d17918 EFLAGS: 00010293
RAX: ffffffff83fb83f0 RBX: 0000000000000002 RCX: ffff88804cda8000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83fb7dd7 R09: 1ffff1100cbe51ad
R10: dffffc0000000000 R11: ffffed100cbe51ae R12: ffff888065f28910
R13: ffff888065f288c8 R14: dffffc0000000000 R15: ffff88807e0e0000
FS:  00005555814413c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2787dbd000 CR3: 0000000021b7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

