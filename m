Return-Path: <linux-kernel+bounces-572804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88B8A6CEDD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584813B5751
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48656204098;
	Sun, 23 Mar 2025 10:43:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAA202C20
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726583; cv=none; b=cQ/A5ACNgZlx7nEnhUzhfvg5Qz1TUJ85IKpheXzYiHn1NN/ga1oIW1j/P0tCJDKaedofWwMjNZq9HJAIQAxbhvxnj4NauIYOlkX2AY8Fy2YDD5hHshBQBwCLqRPrNhHX/WqQYxMWhwjghbP7+Roc8CnWt0LT5cYQd2Jb3bexLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726583; c=relaxed/simple;
	bh=rNv7IQEtqlUFO3pYS4lODJ9+wqgYM0DkWZ1HfwdBj0w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eGUhLmJfsmtN9u3qUJP66sM3sFrR7bXX0Xzhl66u0S8bDAwnCd8PMzTGBU8T5hgFhi5J6FRYCs0BeewlfDIR8UqEF8cxgBAxiUtHuBB45lCrMYJF0ym+NfuzNHIKDp21dlTCtOqcaoJNAUBLGmAAQLHEPOwfzTv1ze1VQ1BYBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d4423d0c49so25652455ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 03:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742726581; x=1743331381;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M4ee4IcuLE63FupaUrgUZ3OAZYnfdnFqK4iwQgtCG8=;
        b=BQDRzTB1ZRnFVvkTFGp8JGzT68nDcfmcKKAhgW2yPvJCQeOYgXlUwxFn9ZWUJkWF5s
         D1bH9u9bBsYFPTeMEFo9GXE7OdQE3O7QqELKLrbV3q4v8AabX8iIBqx83c3etVdcxkJE
         VORnxRgzLb9SRlSbCYIDE9J2B9b2mM9igA1YgCoyZjePCBhDoOahvLopTdtmVf7ytdVu
         Ev2VhlDRyvoubIfR1Ws/YwmxfN8pFPaW3Jh2pyrNi93V+tpih0yyNhxrzTsDXD+lROwL
         5DRGMpTukeeNe8vNN9n6KMYW962+YdS0Y4kk4mBxBP8nWXYSG6MSk+XdXvDjEE/ndd+L
         6avw==
X-Forwarded-Encrypted: i=1; AJvYcCUiEnGMS2tQYrteLAqpvgfxq2JXFNi+Z9evhkMXbE4ctwKtBAtQn4A606pj+EpsvTIvRUjUEhSO017CjOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLCMVV/ud77bc7fX/r+mKmEINpIUNILUxntDSD4qJdglFCo1F6
	oigEew1M/hM+Uv/OPO7NpQkfYMFYvY6AX/rswlPsoSLxkStmh0QvrDKicfxonsIYJwV6DhGYt5S
	RRpgmdefHDOKVM+jdvtZ747UqPgTb3F4RKJ2z6OQ9u3I6TaIXtbrcLdM=
X-Google-Smtp-Source: AGHT+IFGUGOinUfbG2wK/kFa6FkyAFtWl9kON5/jpNGvZTRZst4WY8KMssW3AuzPwPZUpQFSw+gU4JV3Ti42lWQ90Fu+3TH/DF3C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:85:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d5960d1ef4mr108885605ab.2.1742726581661; Sun, 23 Mar 2025
 03:43:01 -0700 (PDT)
Date: Sun, 23 Mar 2025 03:43:01 -0700
In-Reply-To: <tencent_2E6078366F502DC96E3897D0EBBAED7ACE0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dfe5b5.050a0220.31a16b.005d.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in _find_next_bit

ocfs2: Finishing quota recovery on device (7,0) for slot 0
=====================================================
BUG: KMSAN: uninit-value in _find_next_bit+0x11c/0x130 lib/find_bit.c:145
 _find_next_bit+0x11c/0x130 lib/find_bit.c:145
 find_next_bit include/linux/find.h:69 [inline]
 ocfs2_recover_local_quota_file fs/ocfs2/quota_local.c:494 [inline]
 ocfs2_finish_quota_recovery+0xc4f/0x3ea0 fs/ocfs2/quota_local.c:647
 ocfs2_complete_recovery+0x229f/0x38a0 fs/ocfs2/journal.c:1357
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3319
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3400
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_noprof+0x923/0x1230 mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 ocfs2_add_recovery_chunk fs/ocfs2/quota_local.c:305 [inline]
 ocfs2_recovery_load_quota+0x40a/0x1650 fs/ocfs2/quota_local.c:366
 ocfs2_local_read_info+0x139e/0x2c10 fs/ocfs2/quota_local.c:759
 dquot_load_quota_sb+0xa35/0xdc0 fs/quota/dquot.c:2459
 dquot_load_quota_inode+0x662/0x9f0 fs/quota/dquot.c:2496
 ocfs2_enable_quotas+0x1d4/0x6e0 fs/ocfs2/super.c:930
 ocfs2_fill_super+0xa6b7/0xb550 fs/ocfs2/super.c:1140
 get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
 get_tree_bdev+0x37/0x50 fs/super.c:1659
 ocfs2_get_tree+0x34/0x40 fs/ocfs2/super.c:1184
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
 path_mount+0x742/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x71f/0x800 fs/namespace.c:4088
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 3002 Comm: kworker/u8:16 Not tainted 6.14.0-rc7-syzkaller-g586de92313fc-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: ocfs2_wq ocfs2_complete_recovery
=====================================================


Tested on:

commit:         586de923 Merge tag 'i2c-for-6.14-rc8' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c5443f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d4644c4063c5098
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea0b96c4ddb49fd1a70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13def004580000


