Return-Path: <linux-kernel+bounces-397178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054E59BD7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B904D283F58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF3215C6A;
	Tue,  5 Nov 2024 21:34:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29D383
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842446; cv=none; b=SW9wPatL6W3htvOdkT6oTXor8Qg5JDWSi3x4DuCh4IZDD2IUCfmhh5t+cKHg0I5pZLJ8NvMuWYZPyyf9lUNuixeEKvCgFsjzbwrFSlcBggHmwnopxJTeMAKtNJIHdDLsCEKag4G3ZAakBA8mQ12uWcafjrGHBaZKBiaGy607KaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842446; c=relaxed/simple;
	bh=ECo/6Utb8uXg7m9LLyPJabqq6NdT6trTSuuy8+X+FJs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QE9b/K4TVGUYVU0GFzTbn7hj7uJiBPkFoSzNuDEfwubDzZCLQ+8IfM/stLuahqw7JPkRFTq8NaAXm0Dz4RUsF7EKM6OpWBZADSa/WwdyWWJ3VWEU/Ql+8PDsvoVDa4duAHIV4GQzK8okpqpkGWHjlv2u891p2GOMVhkXJ4encKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b37c6dd4so50773915ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842444; x=1731447244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNSvEA7CNiWsPLrMc43Kl3aUzo1EBoS/vK4XQYZ0atg=;
        b=SlYvbGpfTjKAMWIIk70gOPqD7zscDCBZX4YMxjoKDQllQlkM6Oop43YKutArKDFun9
         1NXc+mbpsiXJrRp75vcDQ7HKbYa/Bv/bNPlqU/tiTG1efeQwV6xPR8vqDf0k8vFR7+aq
         KMIcd5uA+4j2cvdyE2ckFsenndvmtkCYR12ptG8Nnx8PkZm4xthqJXq1gGFCF7YsXjUr
         7RNvCJOksNw38ZudF1RdPVIh+Ww3rnJYINZFboom32a4R/iMFvxnwWC3wTPSeZ9wMtCH
         TCN5cjmlw87yqWmJ4XbejRm94BN+jesaDG7qCoOBFdxbuHgLUQvkLb2x2o8fKae8viCF
         UfEA==
X-Gm-Message-State: AOJu0Yyt8l+zr6KXbTq7ddEr3eoo98gjbxdS6N+q4013h9d0wzjdCxb/
	0liHFAiRB3baU98CEmMSf3+gMAkEvcxf7CAQYUSUnbq8KZv7CFHbKdA/CaGGyzQnWNXZwWpYiKB
	xY/3vE2gN+nJ8/LRuzqqr4e9O/YIpRXYn+sw5hxJKRaYOd2N+8THTAmg=
X-Google-Smtp-Source: AGHT+IEBwKdp4z7iOpCtO6m2ouGUo6JNS+qJeFUw5LR6bP2cMjei0W0lGk7bAoIxfwFPepg5YtVpcDYikgaTUjmUGKqVvVs5Djjc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1382:b0:3a6:ab13:2b7d with SMTP id
 e9e14a558f8ab-3a6ab133d94mr207148525ab.15.1730842444202; Tue, 05 Nov 2024
 13:34:04 -0800 (PST)
Date: Tue, 05 Nov 2024 13:34:04 -0800
In-Reply-To: <CAHiZj8jogtw4qmoY2gBGfX2gwjBqro=XbZJU=sJzOu-e3gQiRA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a8f4c.050a0220.2edce.1512.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_bh
From: syzbot <syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in ntfs_read_bh

=====================================================
BUG: KMSAN: uninit-value in ntfs_fix_post_read fs/ntfs3/fsntfs.c:180 [inline]
BUG: KMSAN: uninit-value in ntfs_read_bh+0x1fa/0xdf0 fs/ntfs3/fsntfs.c:1319
 ntfs_fix_post_read fs/ntfs3/fsntfs.c:180 [inline]
 ntfs_read_bh+0x1fa/0xdf0 fs/ntfs3/fsntfs.c:1319
 indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067
 indx_find+0xd12/0x1440 fs/ntfs3/index.c:1181
 indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2666
 ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3298
 ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3389
 ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1016
 write_inode fs/fs-writeback.c:1503 [inline]
 __writeback_single_inode+0x8da/0x1290 fs/fs-writeback.c:1723
 writeback_sb_inodes+0xa34/0x1c20 fs/fs-writeback.c:1954
 wb_writeback+0x4df/0xcb0 fs/fs-writeback.c:2134
 wb_do_writeback fs/fs-writeback.c:2281 [inline]
 wb_workfn+0x40b/0x1940 fs/fs-writeback.c:2321
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 ntfs_read_run_nb+0x786/0x1070 fs/ntfs3/fsntfs.c:1252
 ntfs_read_bh+0x64/0xdf0 fs/ntfs3/fsntfs.c:1313
 indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067
 indx_find+0xd12/0x1440 fs/ntfs3/index.c:1181
 indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2666
 ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3298
 ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3389
 ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1016
 write_inode fs/fs-writeback.c:1503 [inline]
 __writeback_single_inode+0x8da/0x1290 fs/fs-writeback.c:1723
 writeback_sb_inodes+0xa34/0x1c20 fs/fs-writeback.c:1954
 wb_writeback+0x4df/0xcb0 fs/fs-writeback.c:2134
 wb_do_writeback fs/fs-writeback.c:2281 [inline]
 wb_workfn+0x40b/0x1940 fs/fs-writeback.c:2321
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
 grow_dev_folio fs/buffer.c:1043 [inline]
 grow_buffers fs/buffer.c:1109 [inline]
 __getblk_slow fs/buffer.c:1135 [inline]
 bdev_getblk+0x2c9/0xab0 fs/buffer.c:1437
 __getblk include/linux/buffer_head.h:380 [inline]
 sb_getblk include/linux/buffer_head.h:386 [inline]
 ntfs_get_bh+0x605/0x1190 fs/ntfs3/fsntfs.c:1367
 indx_new+0x1bc/0x780 fs/ntfs3/index.c:955
 indx_insert_into_root+0x2fd1/0x37d0 fs/ntfs3/index.c:1723
 indx_insert_entry+0xe1d/0xee0 fs/ntfs3/index.c:1982
 ntfs_create_inode+0x438d/0x4e50 fs/ntfs3/inode.c:1653
 ntfs_mkdir+0x56/0x70 fs/ntfs3/namei.c:207
 vfs_mkdir+0x4a0/0x780 fs/namei.c:4257
 do_mkdirat+0x529/0x810 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0xc6/0x120 fs/namei.c:4293
 x64_sys_call+0x3a81/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:259
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 3959 Comm: kworker/u8:20 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: writeback wb_workfn (flush-7:0)
=====================================================


Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114f1d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8a4f4c5365f96b
dashboard link: https://syzkaller.appspot.com/bug?extid=7a2ba6b7b66340cff225
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120fed5f980000


