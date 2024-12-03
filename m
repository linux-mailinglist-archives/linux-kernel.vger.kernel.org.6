Return-Path: <linux-kernel+bounces-430012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03549E2AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7956A167BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE63200120;
	Tue,  3 Dec 2024 18:30:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571521FDE01
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250632; cv=none; b=c0myhZR2OCneJyIDYIceZ5RfrmI/hl31B6hL6FLPTb30K9r2v5/spexcpEME90uwPXiPSTOO+Q8qgreRFzLN85ZkjeG1lkV03Dq3Icaa5aNi5miD/k1zs5cZ4Q3Tp9IscFgA24WZblAAzXWtgUs7kx35v3OVyTpstvOlXscW1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250632; c=relaxed/simple;
	bh=i4UHFrSGdcOHwXdDkGHOOxumyD4o4c/mQgYQZoscD0c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jEpUzd7MZkHNw0Z8iXNJhgzPj6Q/d8GnIL1UUD2iV/U+rho3Yoi7PLdUxAsriUkivtbxYHQWNsRlzCWp5Ti8XVF9aNW7qKccSw5vwBHkVKUOuONZwh75NXw6G2k57iaYaSq9Xz0IHSG236DvBZqtsmdlXKDn0h+/GfrJofCjqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7ace5dd02so75022155ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 10:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250628; x=1733855428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g41HMocjhmcSbYqA9PiTXZer3eZk85Z91S99c7Qwu0w=;
        b=s4GhNw1gZi2q+02vJ/q/CXHt9jhXzKWrb/+0LIti4DoC05qQsiLEmeY7LWN7n3SqC7
         b+szXnCXR2vPDekcVMrYFrowHnZzdekUg/vPZSXV4kwbknQqDNpWuOTKaRWLfNaLo78L
         ZU/bgs8Ktz8CoCy5ArdEixHiHkNtULH2l2gnzdaIc83q8A5AZvSs7bfpUyQ4QXwmjaeZ
         YZpuumekNkVlGNQDcXtBr6HaFijDk2ILqvXxeIYJ4iFzFHC7TeLXb4FkVbOZxnswCYis
         4uHnThXv/ZnbMTtkZydn9ac1DSHB5E/p5Lue5f3DzT7kCeZHI98xwj2WbBsZm1XjlLTM
         xfug==
X-Forwarded-Encrypted: i=1; AJvYcCWMyGaTPqn3XzpRzcI7gUL1aCL4Eh1lLJSqBq8WEcjR7EA4g93UFB+uQD48bkCkt6fKxBnhLjNK8SVVroU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwIRXm5AkI8q+/s+pztbW7tPBwsBU0PG9i+ZfxZfJSSltAmI7
	dDQ63qmhjumBCK0wP5y7AzMwkzXbmWwLLshki2KWTiGhadH7dVe/G2OJE3xZiXLFeJ54iVfX9H7
	lv/24WdSkqpiHwJlD3HMw0Pq/cHko1yVueDHiWfQiVyjXR/g7vajgPjY=
X-Google-Smtp-Source: AGHT+IEoviy+l5JXFxU3qZ/Jygx3Q1zYvygjSxOjv65SMOmbFLQumKvtLsMV6VJlDf0x8TUMk+F/qMPqV/6oM+KRB8CqOf826J7I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ca:b0:3a7:e701:bd1b with SMTP id
 e9e14a558f8ab-3a7f9ab0f4dmr41934375ab.20.1733250626933; Tue, 03 Dec 2024
 10:30:26 -0800 (PST)
Date: Tue, 03 Dec 2024 10:30:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f4e42.050a0220.17bd51.004c.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in LZ4_decompress_safe_partial
From: syzbot <syzbot+3c88ea590c13f5f92152@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    509f806f7f70 Merge tag 's390-6.13-2' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f3b9e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d66c9f9a88c492bd
dashboard link: https://syzkaller.appspot.com/bug?extid=3c88ea590c13f5f92152
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14da1f78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100bb9e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3bcf9103a9e/disk-509f806f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a595be33a5b0/vmlinux-509f806f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3488b782ca32/bzImage-509f806f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7a0522f2b5b7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c88ea590c13f5f92152@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in LZ4_decompress_generic lib/lz4/lz4_decompress.c:148 [inline]
BUG: KMSAN: uninit-value in LZ4_decompress_safe_partial+0x825/0x1e50 lib/lz4/lz4_decompress.c:473
 LZ4_decompress_generic lib/lz4/lz4_decompress.c:148 [inline]
 LZ4_decompress_safe_partial+0x825/0x1e50 lib/lz4/lz4_decompress.c:473
 __bio_uncompress+0x503/0xa30 fs/bcachefs/compress.c:166
 bch2_bio_uncompress+0x4d9/0x800 fs/bcachefs/compress.c:283
 __bch2_read_endio+0x1b17/0x3070 fs/bcachefs/io_read.c:617
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4774
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2344
 __bio_alloc_page_pool fs/bcachefs/io_write.c:113 [inline]
 bch2_bio_alloc_pages_pool+0xc2/0x2d0 fs/bcachefs/io_write.c:134
 __bch2_read_extent+0x33b8/0x6a50 fs/bcachefs/io_read.c:988
 bch2_read_extent fs/bcachefs/io_read.h:120 [inline]
 bchfs_read+0x2f5e/0x3660 fs/bcachefs/fs-io-buffered.c:217
 bch2_readahead+0x14a8/0x1970 fs/bcachefs/fs-io-buffered.c:277
 read_pages+0x193/0x1110 mm/readahead.c:160
 page_cache_ra_order+0xdbb/0x1290 mm/readahead.c:513
 page_cache_sync_ra+0xed1/0x11a0 mm/readahead.c:613
 page_cache_sync_readahead include/linux/pagemap.h:1397 [inline]
 filemap_get_pages+0x5a8/0x3860 mm/filemap.c:2546
 filemap_read+0x613/0x1560 mm/filemap.c:2646
 bch2_read_iter+0x1a90/0x2010 fs/bcachefs/fs-io-direct.c:208
 __kernel_read+0x726/0xd30 fs/read_write.c:523
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1731/0x3c90 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x464/0xd20 security/integrity/ima/ima_api.c:293
 process_measurement+0x294a/0x3f30 security/integrity/ima/ima_main.c:372
 ima_file_check+0x8e/0xd0 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xc6/0x540 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x58cc/0x6200 fs/namei.c:3987
 do_filp_open+0x268/0x600 fs/namei.c:4014
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1428
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 4883 Comm: kworker/u8:24 Not tainted 6.12.0-syzkaller-10740-g509f806f7f70 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound __bch2_read_endio
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

