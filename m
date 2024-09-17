Return-Path: <linux-kernel+bounces-331824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E47A97B1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE0B253FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348617623F;
	Tue, 17 Sep 2024 14:52:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C194535DC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584757; cv=none; b=bN91FRKXhVIDn24RJN/aBZJPVCwpAJ1sncuwGpiZzLRbdvlJCciGvy3lI2E23XBg+BHuMMweFcnBkslhJdBeGEgx8ptZcRiRnKslVTSBoHdDd0CpQ/uegjfOWWELH18FO5bgBf1uHZzQ7054j9si/onVR0Ulwa0UtnZeqO6nFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584757; c=relaxed/simple;
	bh=NHdxErWZLlcFou3et6VW/jqVsKMww5t7R/7IZb8fFls=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oFrTOrF3QDtLjI3+5B333caul97ZFvupHyTHdrUJeymVKQBX81yYEOAEa9fUE8exT1SXkn3NPHunbtagl5OB9PV8AVfgZJGpBAiXH5/aA7d4mCuDXmcXh4YtOuPukj+DQ2oDr0xBuS3gbFNtw/cLXNHcvBRfo2wDpjClE9tbl5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a09d8ee141so26298455ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726584754; x=1727189554;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ND+JGP15cORP52JXh7aypthiYEYXzh5frDsmMjoqgk=;
        b=ssU6kdKTlIXO2oRcjLI4zrbylcVhQlIXNRhzuwV/FHS/YT/WdolnKX9utwMlFKu8EQ
         1aXeF8Vd/e7ksTxoUp+f+nf7pkGRZuRmnnSR10ZTrWrGy8DPIx/hNT7pqxe+Y/VnmRut
         zHu3pLHQpyvrsGOCJfKHUmVhVHAosmICpC2NXulTx4h34n6xo1xhSC26wAvbRoIbTVMF
         GSlgPL2UgQ11A8lJlewzzRzof07zabd3U6QgebM9vZ2iUe+CGV18yOXVxzp6X2nJFNep
         pdOzIM+sYwwPtoIRYWDCRspWaxyV9Ox2xSRjwt483NjpH7LFQ0C2q2nkV9Eghw5iAfqJ
         eqUA==
X-Forwarded-Encrypted: i=1; AJvYcCVZPQ99JDOIMi2KRR4eiBWr7Qe4LSR0JIQl7k5expo4J+aHaaiqZuB6z7fxHt7xoiTxFzbUbgYlZALH0t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBuuq0PH/WXh6wFnsfoVCCiNMqICz1PlwGAN2NJUtyWJQi2de
	hnwg0kp5h2WsKEjm1y7LsaRfnYhM81CjBnCdKvo2xdJZX0ifUyNg7jMA9QfCxtOucjPNG/ytI8M
	d55otXYIKCbWXxUSoiltuDbq8ARBl2JcWsec5O+hHLYYyHSuJhys8zaY=
X-Google-Smtp-Source: AGHT+IFAx45lONB11iQ8nUVDX7G7cv4qheOlhxyMR6s4yV4QdM6d8IDQpB8eeCFM9fzDIq23mh5LRqKKOY/iImWHukzdl86R3jEQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:3a0:aac2:a0a4 with SMTP id
 e9e14a558f8ab-3a0aac2a445mr39165175ab.9.1726584754657; Tue, 17 Sep 2024
 07:52:34 -0700 (PDT)
Date: Tue, 17 Sep 2024 07:52:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9e854062251d673@google.com>
Subject: [syzbot] [udf?] KMSAN: uninit-value in udf_get_fileshortad
From: syzbot <syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17139900580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea008021530b2de3
dashboard link: https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14080c9f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13927c77980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a92580d12355/disk-0babf683.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8c7829a87d5b/vmlinux-0babf683.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52de69e62dfd/bzImage-0babf683.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e314f05a944a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com

loop0: detected capacity change from 2048 to 2047
=====================================================
BUG: KMSAN: uninit-value in udf_get_fileshortad+0x174/0x1c0 fs/udf/directory.c:504
 udf_get_fileshortad+0x174/0x1c0 fs/udf/directory.c:504
 udf_current_aext+0x6cb/0x950 fs/udf/inode.c:2225
 udf_next_aext+0x94/0x500 fs/udf/inode.c:2171
 udf_discard_prealloc+0x47c/0x830 fs/udf/truncate.c:135
 udf_release_file+0xfd/0x160 fs/udf/file.c:184
 __fput+0x344/0x1160 fs/file_table.c:422
 __fput_sync+0x74/0x90 fs/file_table.c:507
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close+0x290/0x4d0 fs/open.c:1551
 __x64_sys_close+0x48/0x60 fs/open.c:1551
 x64_sys_call+0x2c26/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:4
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4725
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2263
 alloc_pages_noprof mm/mempolicy.c:2343 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2350
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1008
 __filemap_get_folio+0xa05/0x14b0 mm/filemap.c:1950
 grow_dev_folio fs/buffer.c:1047 [inline]
 grow_buffers fs/buffer.c:1113 [inline]
 __getblk_slow fs/buffer.c:1139 [inline]
 bdev_getblk+0x2c9/0xab0 fs/buffer.c:1441
 __bread_gfp+0x93/0x730 fs/buffer.c:1495
 sb_bread include/linux/buffer_head.h:347 [inline]
 udf_next_aext+0x302/0x500 fs/udf/inode.c:2186
 udf_discard_prealloc+0x47c/0x830 fs/udf/truncate.c:135
 udf_release_file+0xfd/0x160 fs/udf/file.c:184
 __fput+0x344/0x1160 fs/file_table.c:422
 __fput_sync+0x74/0x90 fs/file_table.c:507
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close+0x290/0x4d0 fs/open.c:1551
 __x64_sys_close+0x48/0x60 fs/open.c:1551
 x64_sys_call+0x2c26/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:4
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5181 Comm: syz-executor248 Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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

