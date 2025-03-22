Return-Path: <linux-kernel+bounces-572273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4726BA6C878
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26697188C9AE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE381DBB13;
	Sat, 22 Mar 2025 09:05:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04D187550
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742634306; cv=none; b=cV5nsYKr+vtg7iKg/Pp7ZpVKZdsoRGl0+mBZuKESpKyYbbwYe2fAXnvIzCcwYN02uMfr5cuyyJBQlgjaorcSCkr06PRC+XQZzuHOHPVKfJK+AN40pUQh1Lqv4V8kOhcVlm4CtrToJs3ra9CWtzIPV5SkCOxNs7Ehh1eCcyvKaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742634306; c=relaxed/simple;
	bh=fvC87F3YUiEQxEElPGuptnR3EYPtjVSmwI4/ZZKhZdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j8gx6+u9GA3WtAx8srjG3M1ulpLgbqYoQ80w1jpc8d9XMCf1BeyKVTMpE/8XVLcsXyydIu7eA2RNLnrjd0jcl1Ajlmwi0j9OFphCGJu98DHYIFbVmGE36MiMpbmt5QjfLRCGcGv4GY2eBfRwEOx3EhJgfLTr/SeKVc0D6ekgcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d443811f04so25297435ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 02:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742634303; x=1743239103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGVaarRB/L0i+F7Cnq1M1dqOGn52GYljV2EOw47H1/8=;
        b=D2NEp921SYZJso71jD6tg7Rhcu7Oyq/zxvl1u8//RHpCL55IC7XtJVDvXXqtykQG1c
         LaxD4fw4BU85ciQ2WwJTo/CnBd4oZ2803QizIeZme3QRPZqDPX4az4oVBOoedApZuBcO
         /8c9kBAcS8tDZvRIVwzVLK4y63YwqeLMrPAdNCez0opT8NNKLMozzN0gJeVdL5+NUhVs
         NXbWLWaSHpOrSWIYwE6DWa2vwkfoMIuWnV+IHM+QmcY0GEJNzYp9dWgQiRaCnUsLwrW2
         MVCkLSVLRVLFCFKupYKU5O3tzj/xMfivuejuVWJFXR6pqOO0aJYVlN00qSHuRjEY7NW0
         bzqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW88ayQaf+U1hU7hqYRZEsCJvSn8wkOwkm6rp7mylTDUHH/hpVFSyrl8PI2y+9XXkDGnsj5l0+oawuM3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SMB0LJm1vjBgIaDMR4weSguYCeemi0oqixTjWz+XpOAKRPnf
	GiFuXcJeMCDsotO186u1cKJbEJ04+42TGQjT0OFGFpl5LA1kKa31ENYTY6UhHnor0DcuSd7R+DM
	Y+d+jYjy+zBD2LNECz9UCiCCn6D2Csw5Cb2faCPOhpkJQL0xampmaIfA=
X-Google-Smtp-Source: AGHT+IHBpkTVZVpNf/oHAEd5id+2hbFFgAODAUvj+UsUhsqcbfqd+9wwtNefKqJo2ni4u46S72AprUE9Hgqp+1eI4bdcL4GUeWbC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:3cf:c7d3:e4b with SMTP id
 e9e14a558f8ab-3d596186625mr74862335ab.21.1742634303618; Sat, 22 Mar 2025
 02:05:03 -0700 (PDT)
Date: Sat, 22 Mar 2025 02:05:03 -0700
In-Reply-To: <tencent_FFC5C6E792E24668C997EEDB6ED34CA52706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67de7d3f.050a0220.31a16b.002d.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in _find_next_bit

ocfs2: Finishing quota recovery on device (7,0) for slot 0
ents: 3990, sb: ffff888042873800, chunk: 0, blksize: 512, rcb: ffff88804b966800, offset: -1, ocfs2_recover_local_quota_file
=====================================================
BUG: KMSAN: uninit-value in _find_next_bit+0x11c/0x130 lib/find_bit.c:145
 _find_next_bit+0x11c/0x130 lib/find_bit.c:145
 find_next_bit include/linux/find.h:69 [inline]
 ocfs2_recover_local_quota_file fs/ocfs2/quota_local.c:493 [inline]
 ocfs2_finish_quota_recovery+0xcc4/0x3fd0 fs/ocfs2/quota_local.c:646
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
 ocfs2_recovery_load_quota+0x415/0x1450 fs/ocfs2/quota_local.c:363
 ocfs2_local_read_info+0x139e/0x2c10 fs/ocfs2/quota_local.c:758
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

CPU: 1 UID: 0 PID: 6462 Comm: kworker/u8:0 Not tainted 6.14.0-rc7-syzkaller-g88d324e69ea9-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: ocfs2_wq ocfs2_complete_recovery
=====================================================


Tested on:

commit:         88d324e6 Merge tag 'spi-fix-v6.14-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b095e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d4644c4063c5098
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea0b96c4ddb49fd1a70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d9043f980000


