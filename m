Return-Path: <linux-kernel+bounces-257300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEBE93782B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FA2282282
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0CD13C689;
	Fri, 19 Jul 2024 13:14:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531681749
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721394845; cv=none; b=bxqvGCwry2AmT46h08UWchoyjHtm1w+o5mKKZbWwRDDEYbcftPtmUQ6U+mQryF2ljcq/pG5xRaHw7kVk+O6SD/INmC8IAatwZHed3bLVRL0BdMK9OoqbPJ1rhWgrG+HQNKNFlZASEQT8SuMLlqQuZPdGm0/iWpa4XE8z0TcUy5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721394845; c=relaxed/simple;
	bh=7uobmiUD7dbv4LLQAiM6m1STIrSQigxnVXYEYquKaLM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HkxnFQAykt6iDbpFUl/UgrrA3hb3PM8gI+0+y9SiRd7N/i4KiWQ/QhMNb/GEkyFp9a6MlgSgvwahgZv0WNb1QuJ3ztZr7KkK8dx3bWFUFwvmY7vmaG2/4iAsR9DmiY5kYyPmgIwdiHA4chTut6Mja7c6bYh/BHOkCeuRiNEYE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-80627fd1a81so222708239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 06:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721394843; x=1721999643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZAv84ragVpcMkykuodnJAUUXEKgwZWSeWHHCBMY1FQ=;
        b=XP2Mfgo3jsHM6iv+vhh7Fe4JWemm0r2bKOEMsJ7wjzOakSKBWkbAHPUirWTQqeQr6s
         /zAEBoyu0GBlTJd1fg8VsnLwTj+OLT3faCVJpm/7atPbCHYcJ4HhZCuc0E2iGu1nojLe
         7gqm1PVAtu/uOQ0B0ZsjCOXBfpIxpL2wb8WASdN25MmGr1N62qcsWjMHVcdc5jKoe/w7
         e9vvcax+KVVDT+2wk0kTUkW9YU07e3hhMf/fnLaFhpDRmQPe8ATde+jvMDrVC1+ViBNR
         MIymL/Vdt6Xr172u63zoOByLWgkfy4tBrFJkyp0pQDDQp86l40mrawC5/NGDyhBGZMXx
         kR3w==
X-Forwarded-Encrypted: i=1; AJvYcCVaeze3f9kW4IIAAwe0nM7+9V/41i4jBX7CgkRdzWqcse50d2c91mDFC8zawNZSCIuKWFxU5KUnfXDa06NE32cGpK6MEWwg56DPg4pc
X-Gm-Message-State: AOJu0Yxlgkm2v4VwTUJ/R4dyag6ESws1iw6i2pnAtoz6Yf3fmlvTUg0E
	1p8hzZt7fzLbDv6T/v7uznUz3rANs1qEdGaBnS3jHwbC+Q7U6b2M3pWeVULY76SplwenUrkyAza
	97I4+rEisIQpqDRxWfKXoxxUlrTWYD3Tgk5IqFfHtep5vRaxZ6QmJKH8=
X-Google-Smtp-Source: AGHT+IEzfNmX3B+uy5v6JlQTGG6rtgH03E8S99qfBO1RGOo5Ew6NG56Nf7IZdpM5w+UPNrxdMQq/yPE0PVnxr9Fe22jpUSj6R61Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9803:b0:4ba:f3bd:3523 with SMTP id
 8926c6da1cb9f-4c21fb4fba5mr235939173.2.1721394842799; Fri, 19 Jul 2024
 06:14:02 -0700 (PDT)
Date: Fri, 19 Jul 2024 06:14:02 -0700
In-Reply-To: <20240719130043.1621-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fa07f061d997826@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
From: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad page cache in process syz.NUM.NUM pfn:4a961

BUG: Bad page cache in process syz.0.15  pfn:4a961
page: refcount:4 mapcount:1 mapping:000000007efdb730 index:0x0 pfn:0x4a961
memcg:f8f00000073c6000
aops:shmem_aops ino:401
flags: 0x1ffc0000004002d(locked|referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002d ffffc1ffc01bf9c8 ffffc1ffc038adc8 f0f00000061e6ab0
raw: 0000000000000000 0000000000000000 0000000400000000 f8f00000073c6000
page dumped because: still mapped when deleted
CPU: 1 PID: 3851 Comm: syz.0.15 Not tainted 6.10.0-rc7-syzkaller-00266-g4d145e3f830b-dirty #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 filemap_unaccount_folio+0x118/0x278 mm/filemap.c:167
 __filemap_remove_folio+0x3c/0x178 mm/filemap.c:231
 filemap_remove_folio+0x48/0xa8 mm/filemap.c:264
 truncate_inode_folio+0x30/0x4c mm/truncate.c:195
 shmem_undo_range+0x208/0x620 mm/shmem.c:1012
 shmem_truncate_range mm/shmem.c:1125 [inline]
 shmem_evict_inode+0x130/0x2dc mm/shmem.c:1253
 evict+0xb4/0x198 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput fs/inode.c:1767 [inline]
 iput+0x100/0x1b8 fs/inode.c:1753
 dentry_unlink_inode+0xc0/0x188 fs/dcache.c:404
 __dentry_kill+0x7c/0x1d4 fs/dcache.c:607
 dput.part.0+0x30/0xbc fs/dcache.c:849
 dput+0x4c/0x50 fs/dcache.c:860
 __fput+0x110/0x2d4 fs/file_table.c:430
 ____fput+0x10/0x1c fs/file_table.c:450
 task_work_run+0x78/0xd0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x134/0x164 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xc8/0xf8 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page cache in process syz.0.15  pfn:4e2b7
page: refcount:4 mapcount:1 mapping:000000007efdb730 index:0x1 pfn:0x4e2b7
memcg:f8f00000073c6000
aops:shmem_aops ino:401
flags: 0x1ffc0000004002d(locked|referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002d ffffc1ffc02a5848 ffffc1ffc02d1a88 f0f00000061e6ab0
raw: 0000000000000001 0000000000000000 0000000400000000 f8f00000073c6000
page dumped because: still mapped when deleted
CPU: 1 PID: 3851 Comm: syz.0.15 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b-dirty #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 filemap_unaccount_folio+0x118/0x278 mm/filemap.c:167
 __filemap_remove_folio+0x3c/0x178 mm/filemap.c:231
 filemap_remove_folio+0x48/0xa8 mm/filemap.c:264
 truncate_inode_folio+0x30/0x4c mm/truncate.c:195
 shmem_undo_range+0x208/0x620 mm/shmem.c:1012
 shmem_truncate_range mm/shmem.c:1125 [inline]
 shmem_evict_inode+0x130/0x2dc mm/shmem.c:1253
 evict+0xb4/0x198 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput fs/inode.c:1767 [inline]
 iput+0x100/0x1b8 fs/inode.c:1753
 dentry_unlink_inode+0xc0/0x188 fs/dcache.c:404
 __dentry_kill+0x7c/0x1d4 fs/dcache.c:607
 dput.part.0+0x30/0xbc fs/dcache.c:849
 dput+0x4c/0x50 fs/dcache.c:860
 __fput+0x110/0x2d4 fs/file_table.c:430
 ____fput+0x10/0x1c fs/file_table.c:450
 task_work_run+0x78/0xd0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x134/0x164 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xc8/0xf8 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598


Tested on:

commit:         4d145e3f Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14caa0ad980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b5a15443200e31
dashboard link: https://syzkaller.appspot.com/bug?extid=ec4b7d82bb051330f15a
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10541fe1980000


