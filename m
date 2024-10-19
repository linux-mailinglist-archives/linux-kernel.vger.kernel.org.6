Return-Path: <linux-kernel+bounces-372636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CF49A4B48
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 07:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882021C21730
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 05:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01CD1D5CF4;
	Sat, 19 Oct 2024 05:20:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848D1CC8A3
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729315205; cv=none; b=lQ4Ec0Qw+XDcqhZg0nVGvr8LX5MppxhlULxewzFXKb8UxBvsOB4+mOI40nakkR+m/dGcpDz0ysMSrdwc3noDiM13LgsvbFwzd7vC6WKlRcxviWorar/7PnxJ+GwxVA1S3FH6U9xIUFUH4P6KvAe6/NlkBVKm/DVooIwemx/td34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729315205; c=relaxed/simple;
	bh=fyuvITcQCsYlvsn8rW8Eakh+VpT6R3gvHiTF9T8hfYo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CAJPfcLESPdCflyWfvGhhV/U1wp8mCoUlHZ5HK9tJu/fr5Fg+rb5tGDTEp4Qj2OevXclrXZ+8BRR9eBwLhuRqG7IYjsziNWFPA7FxRMnPbqiHQXlahQ+V6ruEvZ4kG+vEClNcMm0M+u1eK+My75Nz8nisbHYweUBGoRaM27jwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so23411825ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729315202; x=1729920002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlxeE9Vr5F5vKty6EBmDxdWCPl9yGNSG5XRCNC14GcM=;
        b=LTrb81b2OjJmxwcDDECKZtTfJH8VtSyiIk5XHxdbpfjeh/a0W/7OFl2wiVxDVMRNC2
         4De9gnPkYM3wZ/fa+o92JpM9GBlzIYUnUewXdBilt6tt4MR2nlNiFfW5LjY5oRVyzD3Z
         3QkXyKhJgSJtsLtccju70y2ZtZW0Rkr0KVV9vKFIdgg7JOhqE1yw7uzMPG+4G9GgBguA
         1ojNoUCPv5qwufeXqPWtUzZmYSPI2r29ujdUllKLKz1k+spalpzFOK5T3vaNUxIB39GQ
         TgvHzmL/EM9aiM/sEVBiJKQkleoTWX6IeOPVNK4x3lFxbciRHE5u+ggVkBLwGS2Eej2N
         Ytuw==
X-Forwarded-Encrypted: i=1; AJvYcCUIYZSK/3mcZ6c5yBmDw1TmJUfoSFpkryi72ZE1iYMns+3haxn1z3dh6khx82Kfw7fLKVVwzXvWWocJj6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlvaXp9m52bGTXApQXYIOIY69gBT99uMxfi7I7tha/FhKWo7x
	acFuP7dw3O2rVfdHKuKS6lx9TlmEjSmHfkYdUZr2ex5lvOm8vWGONh4y465vi5xvTCCDvKYrqzs
	UqiHLQtlNB5Fyg+0M9jAOuji4YJyFv3XVf7+a9sfH8JtPRcc+4qOxR/Y=
X-Google-Smtp-Source: AGHT+IHDOX9xUrAoICrzmF/Qx6PZYlpzPgB1YaSRu2i/o/0q9TaHs9HEUIrz2vTjGWZwjvKqmpon7Rqp5xkZp+Daj33zTRKQXERK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54e:0:b0:3a0:a80a:997c with SMTP id
 e9e14a558f8ab-3a3f40ab41dmr36985375ab.19.1729315202208; Fri, 18 Oct 2024
 22:20:02 -0700 (PDT)
Date: Fri, 18 Oct 2024 22:20:02 -0700
In-Reply-To: <CAKYAXd8Sai7+S1AnAhLtnYWKwZMoAUgUmq_9HRG=oKSg4p-CnQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67134182.050a0220.34b26a.0000.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __exfat_get_dentry_set

loop0: detected capacity change from 0 to 256
exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0x726052d3, utbl_chksum : 0xe619d30d)
=====================================================
BUG: KMSAN: uninit-value in __exfat_get_dentry_set+0x10ca/0x1500 fs/exfat/dir.c:810
 __exfat_get_dentry_set+0x10ca/0x1500 fs/exfat/dir.c:810
 exfat_get_dentry_set+0x57/0xf60 fs/exfat/dir.c:865
 __exfat_write_inode+0x3c1/0xe30 fs/exfat/inode.c:46
 __exfat_truncate+0x7f3/0xbb0 fs/exfat/file.c:211
 exfat_truncate+0xee/0x2a0 fs/exfat/file.c:257
 exfat_write_failed fs/exfat/inode.c:421 [inline]
 exfat_direct_IO+0x5a3/0x900 fs/exfat/inode.c:485
 generic_file_direct_write+0x275/0x6a0 mm/filemap.c:3977
 __generic_file_write_iter+0x242/0x460 mm/filemap.c:4141
 exfat_file_write_iter+0x894/0xfb0 fs/exfat/file.c:598
 do_iter_readv_writev+0x88a/0xa30
 vfs_writev+0x56a/0x14f0 fs/read_write.c:1064
 do_pwritev fs/read_write.c:1165 [inline]
 __do_sys_pwritev2 fs/read_write.c:1224 [inline]
 __se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215
 __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215
 x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:329
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0xe53/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 shmem_file_read_iter+0xa09/0x12b0 mm/shmem.c:3162
 do_iter_readv_writev+0x88a/0xa30
 vfs_iter_read+0x278/0x760 fs/read_write.c:923
 lo_read_simple drivers/block/loop.c:283 [inline]
 do_req_filebacked drivers/block/loop.c:516 [inline]
 loop_handle_cmd drivers/block/loop.c:1910 [inline]
 loop_process_work+0x20fc/0x3750 drivers/block/loop.c:1945
 loop_workfn+0x48/0x60 drivers/block/loop.c:1969
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x12b7/0x3100 lib/iov_iter.c:481
 copy_folio_from_iter_atomic include/linux/uio.h:201 [inline]
 generic_perform_write+0x8d1/0x1080 mm/filemap.c:4066
 shmem_file_write_iter+0x2ba/0x2f0 mm/shmem.c:3216
 do_iter_readv_writev+0x88a/0xa30
 vfs_iter_write+0x44d/0xd40 fs/read_write.c:988
 lo_write_bvec drivers/block/loop.c:243 [inline]
 lo_write_simple drivers/block/loop.c:264 [inline]
 do_req_filebacked drivers/block/loop.c:511 [inline]
 loop_handle_cmd drivers/block/loop.c:1910 [inline]
 loop_process_work+0x15e6/0x3750 drivers/block/loop.c:1945
 loop_workfn+0x48/0x60 drivers/block/loop.c:1969
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4756
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010
 __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952
 block_write_begin+0x6e/0x2b0 fs/buffer.c:2226
 exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
 exfat_extend_valid_size fs/exfat/file.c:553 [inline]
 exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:588
 do_iter_readv_writev+0x88a/0xa30
 vfs_writev+0x56a/0x14f0 fs/read_write.c:1064
 do_pwritev fs/read_write.c:1165 [inline]
 __do_sys_pwritev2 fs/read_write.c:1224 [inline]
 __se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215
 __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215
 x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:329
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6003 Comm: syz.0.15 Not tainted 6.12.0-rc3-syzkaller-g3d5ad2d4eca3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         3d5ad2d4 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16155240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142fbc5f980000


