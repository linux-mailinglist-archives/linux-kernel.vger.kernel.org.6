Return-Path: <linux-kernel+bounces-290142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C82E954FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014B31F260BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62DA1C2300;
	Fri, 16 Aug 2024 17:21:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7F2BB0D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828884; cv=none; b=EwgsKeSs/1UlBbUBqXFGKa9Jx4bC8BJiHmJCGwTP/91UyrsXzr5tEn5+fIgbFcga7wt0IOfGmizo8PN4y6V4cm/jkt1v3SeC8C13ia5mLY717x01rTOJJCOZtc3+8uFD3XIAGwzQr8ItGBHpA3vGg/WWcUeoHx4KuvF0yEhSPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828884; c=relaxed/simple;
	bh=D9d3dbMjwN0iTzVGsM0oPrwGpdHliQeSUy2aKT3aoyI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JhqYYKIlrMd2Tmq18QpJ8WLc0UKAtS7C3iwxl9S3YsYoGKQSC9e+o3CBOI1g9+OXYdiWR7iqQi2K+X6BC/YoG8u4xn3DNa5JqEe2vteUAJrGDc1aCZxiumsuqNJ93HUqq4j03NWiIxUovue491+Q7RWbpS945nTY8rYAyZwR/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso228824439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723828882; x=1724433682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZaiE4/CykC4CjI1jiArqwDBbga3NJxhQD4fGAV/tik=;
        b=Ud7Gr1eUkkiiRBBnhy1xVzxaQrkoqFBPaeRmvr3zXISvW8goC+l2Py14OKqvWY/UsK
         /Y/B552j36ggWXL1QvypOCnAMgm2V2n7IKQSFxBFJ0ySzhfl1baE4cKmBE5T83qqrroY
         ChV/vNCIG8yjrGqIVfEdgQQtHOK/ztlnV5IvGL6iaFr1SJtcfUHwAc0mIoCD+7oDn+8f
         s3PQXvSoMa7f8ixqQ7PCbadFhRkmUnftFb0hARuvejFGS5PLX0UGUImls6ytHUfiC5tc
         iAi75NOm5omfSPv0dHH0lVHmSiVvNjcBHVaD/oekO0d5Gk2lMGVg4mehZk9ljSmdOJHn
         /g1A==
X-Forwarded-Encrypted: i=1; AJvYcCUj/eAIN0BPfa16oQe1d8LJiT7qsZjkK2HBmISCzVdubU4UD9Ib6NifLVTdLRYTiUTbzVEfZh+oKaB3z+79xUPKUp+NmSUrBetk4+oY
X-Gm-Message-State: AOJu0Yxp7iJoA9+mph9cBruNG7dFbtTea9ouUtSZOvHqzLLrErl+fK5/
	PPscfBBeOrf20TGQVyKAxh9iBIUqhQQEVlsfbdPw++uMZkPyAEv3/tb38n62VGu2U1HmmAWcN61
	8k3ave/ppbMSP7LVku3LTlORQ/FmqNQgZRq+fA8M3BhghDl79n7a/rOo=
X-Google-Smtp-Source: AGHT+IEHNmA2K9MgZUoJypFuF47vnlsMQgCY50I0s+wuC/4g9V92thL7XdfT6WQ/lAS0ocTyO+bDBDEYAjFizW6B8xOZkEefe5fn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8903:b0:4b9:26f5:3632 with SMTP id
 8926c6da1cb9f-4cce1735129mr137692173.6.1723828882088; Fri, 16 Aug 2024
 10:21:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:21:22 -0700
In-Reply-To: <000000000000d1e1180618b99e10@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bb47c061fd030c7@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbAdjTree (2)
From: syzbot <syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d7a5aa4b3c00 Merge tag 'perf-tools-fixes-for-v6.11-2024-08..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=109f2df3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=412dea214d8baa3f7483
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12114991980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11422f5d980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64022429061b/disk-d7a5aa4b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f4aba88f7db8/vmlinux-d7a5aa4b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/120456a2d9dc/bzImage-d7a5aa4b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/947fb73311a3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2902:18
index -3 is out of range for type 's8[1365]' (aka 'signed char[1365]')
CPU: 0 UID: 0 PID: 5217 Comm: syz-executor310 Not tainted 6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dbAdjTree+0x377/0x520 fs/jfs/jfs_dmap.c:2902
 dbAllocBits+0x4ea/0x990 fs/jfs/jfs_dmap.c:2193
 dbAllocDmap+0x6d/0x150 fs/jfs/jfs_dmap.c:2034
 dbAlloc+0x509/0xca0 fs/jfs/jfs_dmap.c:816
 extBalloc fs/jfs/jfs_extent.c:326 [inline]
 extAlloc+0x4f8/0x1010 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x41b/0xe60 fs/jfs/inode.c:248
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2235
 jfs_write_begin+0x31/0x70 fs/jfs/inode.c:299
 generic_perform_write+0x399/0x840 mm/filemap.c:4019
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4147
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ed0fe9e99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed45f7398 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8ed1033095 RCX: 00007f8ed0fe9e99
RDX: 00000000fffffdef RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00007f8ed10645f0 R08: 00005555618f94c0 R09: 00005555618f94c0
R10: 0000000000006289 R11: 0000000000000246 R12: 00007ffed45f73c0
R13: 00007ffed45f75e8 R14: 431bde82d7b634db R15: 00007f8ed103303b
 </TASK>
---[ end trace ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

