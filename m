Return-Path: <linux-kernel+bounces-334555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661C97D8C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A11C2863BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B1017F389;
	Fri, 20 Sep 2024 17:00:35 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577B2B9B9
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851635; cv=none; b=Z3x/QvPAkFeXurjbSb4p3niVAoTAHueTFy3y6dLMHUvfkTJ+GtmVIqiEuLwOclWPmf1PBlzkdkiQGd9pSJdogJLIhAhlS1XuBm5jerkeYq/vBVbVZRNPTlKgUWurcRXypy5C6F1n3LsW5uqhbSdsPBc14SUDqgHJOvFSZmdOLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851635; c=relaxed/simple;
	bh=4j+fUHE3+805kbYfg1lYbt761J4oZtOOvdmszfKJ8RQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M+/8ustbbdWjzb/Bf+VCOZsMhAnvflLIIuIXHIbMqzSty7cGmWrcXlvcvhuEFcTaDAi0pgMdOsTlrSPeAk6UocdSTWzNHVCtopKR49bk6nTCNunn/bZl9nrTwtl9eM3AqCsyMBn/kzSqFpgDrduhRpQC8zETr/pqnrGUH6XBXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ce3316d51so282562239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851633; x=1727456433;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfDdPHt9GI0mh8ly82kMMRpzmCBeMx53wohZf9EjjOU=;
        b=AwL/F6dsHVfINgPFb/AthVNz2Nvj8WaYDhgwB75og1pK2wJr1B9aaClXmSe+HsIGIW
         fXti0o+UJDPfZh557c9a/buD6NighS+nRFA2iOA9mw+lGotUVxUtCEZAIN/SB3b1Na8+
         evOumGr/UBbBr67no57p8pmIrEbAnfmCpJO3p7Hdw/5cwLvYFO/bQHOGiOd6LlrRTRdG
         OGF6T0fWk7KOd6z0rh0Av3dGDtIWQ9g5atM2E40d5mw1PaYhoLHnMptWqLWfN8CQMikP
         QIT8IJI1HPHEV/ByMbcYRCUFVao/EqrvzBATp+rb5CtAA75fcUju6xyHZKpI0Wby3Umz
         rh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzVmfCAJY3zcll4m095Dg9T9CMW2sNpHURzjrV4aO6oigW8el+RT3/24+juHDVZY7yDp01eqBQySh54Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xErcvOQ4KoMgawEWoXhZkvOLlj47lsnOGFyzjxr8R2OC4B7V
	oQ9vGD4eqLGXS63aAdSUeapCaODEyO26dEbh1k3vKGCAI3qrzh1GmSnkNGlKpLo9GVqXPh+Ubaf
	SSq6vJVcHVU0Kh9tgBfqEte6+JKFls4OH8pwkIokdVThrNQKoc2P7S84=
X-Google-Smtp-Source: AGHT+IGHQLJzZ3Fwb8rhyPaE93K4zYCduyO6cmykcNi4QNNVdsnzFUnAgaEPQ+1hPSwt7ObLXPFgHEAlZ0B43MJ/HEgM61DDf8E8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:3a0:b1ea:816 with SMTP id
 e9e14a558f8ab-3a0c9db0144mr31192415ab.25.1726851632712; Fri, 20 Sep 2024
 10:00:32 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:00:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66edaa30.050a0220.25340c.0006.GAE@google.com>
Subject: [syzbot] [netfs?] KMSAN: uninit-value in netfs_clear_buffer
From: syzbot <syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f27fce67173 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10da7500580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d864366be695947
dashboard link: https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bdbfc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17acc69f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c167a07d047b/disk-2f27fce6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a68ac6093374/vmlinux-2f27fce6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72a53f77d2bc/bzImage-2f27fce6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in netfs_clear_buffer+0x216/0x4e0 fs/netfs/misc.c:75
 netfs_clear_buffer+0x216/0x4e0 fs/netfs/misc.c:75
 netfs_free_request+0x51f/0x890 fs/netfs/objects.c:146
 netfs_put_request+0x161/0x360 fs/netfs/objects.c:170
 netfs_write_collection_worker+0x7337/0x7c20
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4038 [inline]
 __kmalloc_cache_noprof+0x4f0/0xb00 mm/slub.c:4185
 kmalloc_noprof include/linux/slab.h:690 [inline]
 netfs_buffer_append_folio+0x2cf/0x8b0 fs/netfs/misc.c:25
 netfs_write_folio+0x1120/0x3050 fs/netfs/write_issue.c:421
 netfs_writepages+0xe60/0x1670 fs/netfs/write_issue.c:541
 do_writepages+0x427/0xc30 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 __filemap_fdatawrite mm/filemap.c:436 [inline]
 filemap_fdatawrite+0xbf/0xf0 mm/filemap.c:441
 v9fs_dir_release+0x1f2/0x810 fs/9p/vfs_dir.c:219
 __fput+0x32c/0x1120 fs/file_table.c:431
 ____fput+0x25/0x30 fs/file_table.c:459
 task_work_run+0x268/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xd88/0x4050 kernel/exit.c:882
 do_group_exit+0x2fe/0x390 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3c/0x50 kernel/exit.c:1040
 x64_sys_call+0x3b9a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 2945 Comm: kworker/u8:9 Not tainted 6.11.0-syzkaller-04557-g2f27fce67173 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events_unbound netfs_write_collection_worker
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

