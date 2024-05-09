Return-Path: <linux-kernel+bounces-174235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524428C0BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA171F22A63
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649E0149C50;
	Thu,  9 May 2024 07:33:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551EC13CA80
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240014; cv=none; b=uzT59xWbSDA0YhZfGIuI06jrCtaoFlsybyz+ZiN7au6LUgtyhHbujUJxcbf4IMHO4goEsUiA7gsZkoaJ2aIPYY5h0kLAPQMA9eNxPW9J0jDQ0vme+G44Jn5iOox2NVNTfJyyckHOegfS98T6V13IZZABToT38+yUDtomz7SUt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240014; c=relaxed/simple;
	bh=nbhUY7Hy2FzYizNiopTHPz08Vlzquy3DunIbzZLwKEg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r0fzNWMPNaj1xLuS3ZFYtoli42+XqCrWBdrjyVCcs0mZ/gma3f/HtRXUnkJRaGL+k5qzu3E80K1WAuXBKHRX6+P6GIcpO0Rxetg0Wgo/JhFovUzTK0E4z6OkE8RksCEziPMu3CP/QEJTvBwvWti+J35I+4STYTl+Beolp8SEOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dec4e29827so53294539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 00:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240011; x=1715844811;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4o0VroiBOaqLrId7oLYRQ2ZetAUouWdNSkk+nerX6Mo=;
        b=DWLLcznyfQhH7/GIrSVJKf0IhprzKJ3U+lirstnW+Mxt+vMcNKJSy7915J1qjbeaAG
         HnQWKHoWdb9iNhf59TNkh/JYUXME8cvSsiiNeELebktHhkLMjOHGjx6fcVClNZ7bC/zZ
         8WOXCIWlaCB6S0n9ZDtrTbID7FM3tsAyAH4sfOC0rTmBtiGG7fkEDCqR3tIgObXfW5NY
         ACrLSP5OshPBk0AedPRG6NlkUuEg4efw+rfTRvYyuj9ELMjgxnJFHnr9LrbF4IBxgwat
         BPLIHKKmOCKD77eiaRVZwT/mlvAgOufI0DrJ/eRKJNjxV7TehJxhauq896ZQqGHQzXeQ
         ptHw==
X-Forwarded-Encrypted: i=1; AJvYcCVQzvBdv21/lUAY7Fq2bo09gUKGwUDBDJdMkIPVko0JJveTRQSHFltGm/5bCr5FXELOvUXHuvUGVoqhTZgTvidg9tFiKODUKvSQOsFR
X-Gm-Message-State: AOJu0Yw7RxtU/NQb8Wjg9/lr8BaQl23Bau5t+9/wA2BSa/2Zjnh/6Psh
	Vefp09GcE1tQzjYQPWh4l2ojhTtGOs+WGqWh8o7vhy8pWr9yjhb2giaYN+TS07SfJ++OGH9CGad
	yttyygl2d1aIH4xjFc3AH/q+117wMkPoGIdU6JtmSai2qIGbGuUgcurA=
X-Google-Smtp-Source: AGHT+IF8VT0V3MBeA2mEa87OCQ6rVDGFscddAAUp5v3UkiOBD81uKu4NZp/AVcJCqmfbYzSZeCa/8AAD+wJPVKOOD2NegzqUHxzP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641c:b0:7da:1885:e198 with SMTP id
 ca18e2360f4ac-7e18fbed198mr6957039f.0.1715240011477; Thu, 09 May 2024
 00:33:31 -0700 (PDT)
Date: Thu, 09 May 2024 00:33:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096c7e30618006f15@google.com>
Subject: [syzbot] [fs?] KASAN: use-after-free Read in sysv_new_inode (2)
From: syzbot <syzbot+8d075c0e52baab2345e2@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1c9135d29e9e Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=150ebfdf180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d2d53e64c7e6a4f
dashboard link: https://syzkaller.appspot.com/bug?extid=8d075c0e52baab2345e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132e5e04980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1031edbc980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52dd1b4921ab/disk-1c9135d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a4f1788dc25/vmlinux-1c9135d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8d8ebd42a80/Image-1c9135d2.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/816a43fa80f6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d075c0e52baab2345e2@syzkaller.appspotmail.com

loop0: rw=0, sector=17669878, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 8834939, async page read
==================================================================
BUG: KASAN: use-after-free in sysv_new_inode+0xd24/0xe9c fs/sysv/ialloc.c:153
Read of size 2 at addr ffff0000dee091ce by task syz-executor425/6318

CPU: 0 PID: 6318 Comm: syz-executor425 Not tainted 6.9.0-rc7-syzkaller-g1c9135d29e9e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load2_noabort+0x20/0x2c mm/kasan/report_generic.c:379
 sysv_new_inode+0xd24/0xe9c fs/sysv/ialloc.c:153
 sysv_mknod+0x5c/0x100 fs/sysv/namei.c:53
 sysv_create+0x38/0x4c fs/sysv/namei.c:67
 lookup_open fs/namei.c:3497 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0xfb4/0x2830 fs/namei.c:3796
 do_filp_open+0x1bc/0x3cc fs/namei.c:3826
 do_sys_openat2+0x124/0x1b8 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x11ee09
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000000 fffffdffc373ab48 fffffdffc3799848 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000dee09080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000dee09100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff0000dee09180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff0000dee09200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000dee09280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
syz-executor425: attempt to access beyond end of device
loop0: rw=0, sector=6491536, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 3245768, async page read
syz-executor425: attempt to access beyond end of device
loop0: rw=0, sector=17666806, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 8833403, async page read
syz-executor425: attempt to access beyond end of device
loop0: rw=0, sector=26539618, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 13269809, async page read
syz-executor425: attempt to access beyond end of device
loop0: rw=0, sector=16147212, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 8073606, async page read


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

