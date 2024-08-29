Return-Path: <linux-kernel+bounces-306169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7E963A24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCB31F22E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B001537CB;
	Thu, 29 Aug 2024 05:57:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB682D94
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911025; cv=none; b=SPyb/cg2XxjLZNEKwJoz3PlyZVZHvLS+lplBOOER5EbzIaTV4h6/mpv5ElM8nbqKr6srNk0KcZh+VWz4GpSJG1idaO9+4MT11bVdylP7rwYJTFPY0gtylOOf5YG2HWDbBmH/oRNWzvjY58g4guGvLkjJAIpDyV9hQ5lO4QdgQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911025; c=relaxed/simple;
	bh=cfdPW45FESLgM15k3LRbinNyNYsFZXahPgFCu3AMxKA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jQbcfBBp/isAnEuo4o2yuHzeGYhfBQhCNfM7v9OiQHLfWzad5y2K88i3VFf7ui6slP2UwVIcSG+WMyCIcoVj9HaGq+mcZWU179cUmEnzXVttAffUqregGcmrzH6bs2R6slRzlKNuN/DbL+FwBUTpoQVkxtKnDQWexo/2Bh4jKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f36def4feso2737945ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911023; x=1725515823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tr+e1ubLc48wQhKJZkcJj66Oqxz6UPS6LetYk33BfSw=;
        b=duyUyRN7cdd9gsPgAKyetCupHGgjEU3l/279IM1NfQ+X2spfltjP6//s8KTcva3Cxi
         9geh7jlMfsdT9OXeRCAPHM4+o7NVdIkFp8t+o4Z4yy/xKdVjThbISeKt045N5laKuRvv
         gcs90gFOpLUSGAxv8vqrsS1tMHGK5VxFjTwcv0WoeoMeHqnuJhwlMKkrX8Qk2cmBVXYy
         klk3LvuNBmA4Jb8PH/0527K1ecLrOnwFqwqjxH7da2LCj7iY0LBHuRg5cFDVFY8jlgma
         9x672TcQLh9lWGIkLs2hzqhCccxTCYya+3nJ3YpPeeeaopX6S6aj2n3gdOESDXJ93JZ+
         sduw==
X-Gm-Message-State: AOJu0YzGAiQw35HsVmBbkZ1zXi1jq288u0Y55yhjsBp57kuMpMTUSllv
	8FZFm2yrJnvNmrx4FYVg9zHZw5MIuV5ogmVITwEquEBroe+XgDOF6ZqCCIBad+7ECWqFUhPoj2k
	G4zIsZ/VerXWGceEk1L6gB7pIxB6RC1SX/KmdoIFevYcgUGwC2cUzkHQ=
X-Google-Smtp-Source: AGHT+IEQsCK+CXpYudyljjTo8qwcMVBqDJI8Xu4CIV4KBkAS1lEXlq0cyPmB3lrclUxoM5gwf6IGDtSjx/SbmYYTUa045YVMAfa2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d17:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-39f377eb269mr1438445ab.0.1724911023218; Wed, 28 Aug 2024
 22:57:03 -0700 (PDT)
Date: Wed, 28 Aug 2024 22:57:03 -0700
In-Reply-To: <20240829054235.3940345-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cef6da0620cc24a1@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io (2)
From: syzbot <syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in btrfs_add_extent_mapping

em: ffff888066d637e0, blockstart: 18446744073709551613, em refs: 1, add_extent_mapping
em: ffff888066d637e0, blockstart: 18446744073709551613, mblockstart: 18446744073709551613, try_merge_map
setuped, em: ffff888066d637e0, blockstart: 18446744073709551613, em refs: 2, add_extent_mapping
assertion failed: extent_map_block_start(em) != EXTENT_MAP_HOLE, in fs/btrfs/extent_map.c:752
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_map.c:752!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6365 Comm: syz.1.20 Not tainted 6.11.0-rc5-syzkaller-00081-gd5d547aa7b51-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:btrfs_add_extent_mapping+0x715/0x790 fs/btrfs/extent_map.c:752
Code: f9 07 90 0f 0b e8 8b e6 e1 fd 48 c7 c7 20 5b 2c 8c 48 c7 c6 20 5c 2c 8c 48 c7 c2 a0 59 2c 8c b9 f0 02 00 00 e8 2c c5 f9 07 90 <0f> 0b e8 64 e6 e1 fd 49 be 00 00 00 00 00 fc ff df e9 6a fb ff ff
RSP: 0018:ffffc900032b7160 EFLAGS: 00010246
RAX: 000000000000005d RBX: dffffc0000000000 RCX: 10a2bc291a71c100
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff1100cdac701 R08: ffffffff817400cc R09: fffffbfff1cba0e0
R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: ffff888066d63808
R13: ffff888066d637e0 R14: 0000000000000000 R15: fffffffffffffffd
FS:  00007f3abd3676c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffd35749c8 CR3: 0000000074d68000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_get_extent+0x124b/0x1d30 fs/btrfs/inode.c:6962
 btrfs_cont_expand+0x28f/0xcd0 fs/btrfs/inode.c:4923
 btrfs_write_check+0x440/0x590 fs/btrfs/file.c:1181
 btrfs_buffered_write+0x288/0x1360 fs/btrfs/file.c:1221
 btrfs_direct_write+0x531/0xb40 fs/btrfs/direct-io.c:942
 btrfs_do_write_iter+0x2a1/0x760 fs/btrfs/file.c:1505
 do_iter_readv_writev+0x60a/0x890
 vfs_writev+0x37c/0xbb0 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3abc579e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3abd367038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f3abc716058 RCX: 00007f3abc579e79
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f3abc5e793e R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000002000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f3abc716058 R15: 00007ffe16a6f238
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_add_extent_mapping+0x715/0x790 fs/btrfs/extent_map.c:752
Code: f9 07 90 0f 0b e8 8b e6 e1 fd 48 c7 c7 20 5b 2c 8c 48 c7 c6 20 5c 2c 8c 48 c7 c2 a0 59 2c 8c b9 f0 02 00 00 e8 2c c5 f9 07 90 <0f> 0b e8 64 e6 e1 fd 49 be 00 00 00 00 00 fc ff df e9 6a fb ff ff
RSP: 0018:ffffc900032b7160 EFLAGS: 00010246
RAX: 000000000000005d RBX: dffffc0000000000 RCX: 10a2bc291a71c100
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff1100cdac701 R08: ffffffff817400cc R09: fffffbfff1cba0e0
R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: ffff888066d63808
R13: ffff888066d637e0 R14: 0000000000000000 R15: fffffffffffffffd
FS:  00007f3abd3676c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffd35749c8 CR3: 0000000074d68000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         d5d547aa Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1266cceb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=ba3c0273042a898c230e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11df82eb980000


