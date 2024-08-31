Return-Path: <linux-kernel+bounces-309999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04059672E7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3423B1F223BD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B259813AD05;
	Sat, 31 Aug 2024 17:59:29 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72863A29A
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725127169; cv=none; b=UTpfhwbK/PloKStGGmtnHUyNNdjSy+PGWJYrGIjvzahhSBYrPs26pa8uWGhGegCcanCuN/bMy4XmapNJGAj+uK3Od7HJ3r9bYmYB/pGi6WcjtXHrVuB72LP6cxKs2KsfeC4NUDFdKDLu1VXmvYWQguoC6WB32tgqvLJvtCWHa2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725127169; c=relaxed/simple;
	bh=XHyQVpoMoTxGb69pUdf4yvKKvfJPBy+TRpZq/a0CTw8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E8SC6tGB3Dpo8Y4HgTAZLSt1xMvmZwMb8bp3axe2XDmS1ZAhtw2gXUAYfqRLG5bQbABv0nwhrCFQWU5VWJwgMZMj8XOlfMj0aA+micBNNark+/6YjriwajntUGjsxUvjJeD7zQDR9Mv5BPPM53FjQPYc5TyaCn4odIZBXaJDYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a217cec33so264472139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725127166; x=1725731966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uy2DsHo15yiAT/5MKMd0euNM1waTYrVWOuLOMaJMGkE=;
        b=NxGyEh0l22dsqcvLBQXgRIEZui4DHHcz4+aoJuk6I6uateGPvb7jll5LN3uy83zFvL
         AkLEDegGOODc/nk57tryV9WlT1JTlRkxBZaI4beKt/esnbA/tcdB7Rg9NT6vzfnB/HWY
         DvPvtKhaFSCvegk8aqvjCOzizJEzvO81U6EdEQIFByH0v9mEMy80lyuVsJWvvnhPF/sa
         x1gRjYfiklSjYLEERO0Gab8iqQuyw/PoSC96ZLPIEH18krgZ6+4fIDnVTb0KvnF6xPqy
         1bfNv7lFcDZtjDmdQhXhU1hIvMiCwsZW1ddXIFrk7TSygEpfElHV64zjT31TXhRJQ9Bf
         g01w==
X-Forwarded-Encrypted: i=1; AJvYcCXLGjjc5x9r7sqDWM4MCVqMqBtraZmP5gRuojPcDsA+z+rTFj8Uka5Obe9El0Db7irPzyelLDfLkCM+4qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0jFzQOIzlW0idr/I9x8AjH0u6E1wt/TzfB3FdOx9rUlJa7a+
	zSJpHTC3+IINwHnMf487jLvbPBNdMuna1rC8xPWNdxFkDtmA6uvXKEVwcV/vX3NxFa611eGpv7o
	U+Rjns0ulLDiDJXniobeSa5EiMF2fPcl75zF2IH1x2QNfLrvtPWoFO4Q=
X-Google-Smtp-Source: AGHT+IHABU6CUpEMDZoF5MyCkDP5u7UXfJn6S/W02Bb5mB3rEh78QPKW4q4fvhMv3+ex5ea4niUHJZyuMgMCxIQ1ZW/bH8ZaJstR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:39d:1ca5:3903 with SMTP id
 e9e14a558f8ab-39f40f042d4mr4887855ab.1.1725127165814; Sat, 31 Aug 2024
 10:59:25 -0700 (PDT)
Date: Sat, 31 Aug 2024 10:59:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e93ea70620fe777a@google.com>
Subject: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (3)
From: syzbot <syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86987d84b968 Merge tag 'v6.11-rc5-client-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109f1425980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=480676efc0c3a76b5214
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87692913ef45/disk-86987d84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a27da6973d7f/vmlinux-86987d84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e28d02ce725/bzImage-86987d84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -2)
WARNING: CPU: 1 PID: 63 at fs/btrfs/extent-tree.c:2972 do_free_extent_accounting fs/btrfs/extent-tree.c:2972 [inline]
WARNING: CPU: 1 PID: 63 at fs/btrfs/extent-tree.c:2972 __btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3346
Modules linked in:
CPU: 1 UID: 0 PID: 63 Comm: kworker/u8:4 Not tainted 6.11.0-rc5-syzkaller-00057-g86987d84b968 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
RIP: 0010:do_free_extent_accounting fs/btrfs/extent-tree.c:2972 [inline]
RIP: 0010:__btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3346
Code: e8 24 a4 ae fd 90 0f 0b 90 90 e9 3c f3 ff ff e8 35 80 ec fd 90 48 c7 c7 00 79 2b 8c 44 8b 6c 24 18 44 89 ee e8 00 a4 ae fd 90 <0f> 0b 90 90 4c 8b 24 24 e9 4f f3 ff ff e8 0d 80 ec fd 90 48 c7 c7
RSP: 0018:ffffc900015e6f80 EFLAGS: 00010246
RAX: ec2b4374561a8400 RBX: ffff88805d790001 RCX: ffff888015581e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900015e7150 R08: ffffffff8155b212 R09: fffffbfff1cba0e0
R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: dffffc0000000000
R13: 00000000fffffffe R14: 0000000000000000 R15: ffff88805d3be5c8
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3dca9f0270 CR3: 000000002dd02000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1724 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1750 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2015 [inline]
 __btrfs_run_delayed_refs+0x112e/0x4680 fs/btrfs/extent-tree.c:2085
 btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2197
 btrfs_commit_transaction+0x4be/0x3740 fs/btrfs/transaction.c:2198
 flush_space+0x19c/0xd00 fs/btrfs/space-info.c:835
 btrfs_async_reclaim_metadata_space+0x6dc/0x840 fs/btrfs/space-info.c:1106
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

