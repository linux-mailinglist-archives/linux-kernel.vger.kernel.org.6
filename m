Return-Path: <linux-kernel+bounces-399279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE829BFCF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEB7283EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB2155398;
	Thu,  7 Nov 2024 03:25:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C780038
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949906; cv=none; b=a03Ht8h1ozUt6usA80YifQafQqdWt5lmvB9M11SWt89DL+NH3ywLpDL2H8/A+Z90lyy7BrMtInPfxJvltc1Wi76maRo3iELQNXUmvQ4hN/nEur2PY1688C8uZcLHLLI0uH5Q6EEfAg5pQg/tdYYhsjNyrmSHGn2mZlJroEwmlto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949906; c=relaxed/simple;
	bh=GKGhX8bBSfBH/fNe56TimE8vZBw4po3YTdFjyfNFC9o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PlvbyhkC8Ushlq1s+xeBXIfdFXq9kNzuxmwRgvLRL/1F99VEqWFPmDPXT0ngm8y3xi8YUE1DMyUp4rpGLAMtELDStYgpBkG2ydbjv8jXIrDA+q+tFqxR7D7/JYTpBneACCkB+5TcLuitgMNMfDFgKoOkrTmq9NBH0nZhWSqwOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abef51173so64952139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 19:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730949904; x=1731554704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPgjA4NgnTzvkkOpgsT6Kr9VDrk5EvCDlE4eLGzdMPg=;
        b=qx27EMGomtjGjCZwG4wuHZFXfA3HOjCatuzZIo2od3i4IueHh/oSwORxq+BwNi3LF+
         0R45qFzkZ6NN2wlln0CXXLJ1LSLPjsvNwxlooSakEdjeYR5f94/15Xcni4ENBWQGcuoP
         FyyP6dSJQmkzpCWh/88b4C7rtSz1bdSNLSGII+QFOYwDoLq+wHMsdrBq783gmyYjJIcQ
         4vi5ed9N2dJa9YXhPMTks4oTc9eFtbf436j0Yx3RwuklCR8q3Vx4c4wyDqf3k34CPlnK
         w+8LxPoYvhQf0+7c+ryGILuHVVOvxbA6JbUSjuteF6c6KYCmVvUL3X1IXnknfCBfh9Vt
         IJaQ==
X-Gm-Message-State: AOJu0Yy2gh8sBgqiy41vGBHGgXMNBVCyvCPEx0iLlYlsAwxhG7cRxi5t
	6xizvqpCv1BE70NIq19vvERqQ4rK7KymRVaisx2SBqJgB+YQSMgKH6mUJ47NZwCX2TMUTO0TvTa
	nn94GBb5/NSsytahEzVGNlPWcpppbQdjxiswkmDNqMJPl63D1XsA6vAs=
X-Google-Smtp-Source: AGHT+IFe6Ezmo2UGZSEUU0hIA7QchgRSHZ+Zve95NRL3mY89byua1cDL0u7h6OJnC89kzg7nwsz4hDV4ys5LB6QaKkp/MtVrf5AT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcd:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a6eb26b1a4mr5975235ab.21.1730949903773; Wed, 06 Nov 2024
 19:25:03 -0800 (PST)
Date: Wed, 06 Nov 2024 19:25:03 -0800
In-Reply-To: <20241107031237.2751625-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c330f.050a0220.49393.0170.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: stack guard page was hit in v9fs_file_read_iter

BUG: TASK stack guard page was hit at ffffc90003ed7ef8 (stack is ffffc90003ed8000..ffffc90003ee0000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 6479 Comm: syz.1.23 Not tainted 6.12.0-rc6-syzkaller-gff7afaeca1a1-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 b0 4d 7a
RSP: 0018:ffffc90003ed7f00 EFLAGS: 00010086
RAX: 0000000000000004 RBX: ffff888031338b2a RCX: 0000000000000080
RDX: dffffc0000000000 RSI: ffff888031338b08 RDI: ffff888031338000
RBP: ffffc90003ed8040 R08: 0000000000000000 R09: fffffbfff2dc5b88
R10: ffffffff96e2dc47 R11: 0000000000000000 R12: 0000000000000002
R13: ffff888031338b08 R14: 0000000000000002 R15: ffff888031338000
FS:  00007f29143fe6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90003ed7ef8 CR3: 00000000320be000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 mark_usage kernel/locking/lockdep.c:4634 [inline]
 __lock_acquire+0x8a3/0x3ce0 kernel/locking/lockdep.c:5156
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
 _raw_spin_trylock+0x63/0x80 kernel/locking/spinlock.c:138
 spin_trylock include/linux/spinlock.h:361 [inline]
 rmqueue_pcplist mm/page_alloc.c:3012 [inline]
 rmqueue mm/page_alloc.c:3056 [inline]
 get_page_from_freelist+0x34e/0x2d10 mm/page_alloc.c:3454
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x367/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 p9_fcall_init+0x97/0x260 net/9p/client.c:233
 p9_tag_alloc+0x21c/0x870 net/9p/client.c:300
 p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
 p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
 p9_client_read_once+0x443/0x820 net/9p/client.c:1570
 p9_client_read+0x13f/0x1b0 net/9p/client.c:1534
 v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
 netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
 netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
 netfs_unbuffered_read_iter_locked+0x12f6/0x19b0 fs/netfs/direct_read.c:221
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 do_iter_readv_writev+0x614/0x7f0 fs/read_write.c:832
 vfs_readv+0x4cf/0x890 fs/read_write.c:1025
 do_preadv fs/read_write.c:1142 [inline]
 __do_sys_preadv fs/read_write.c:1192 [inline]
 __se_sys_preadv fs/read_write.c:1187 [inline]
 __x64_sys_preadv+0x22d/0x310 fs/read_write.c:1187
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f291517e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f29143fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007f2915335f80 RCX: 00007f291517e719
RDX: 0000000000000001 RSI: 00000000200015c0 RDI: 0000000000000003
RBP: 00007f29151f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2915335f80 R15: 00007ffdecdb72b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 b0 4d 7a
RSP: 0018:ffffc90003ed7f00 EFLAGS: 00010086
RAX: 0000000000000004 RBX: ffff888031338b2a RCX: 0000000000000080
RDX: dffffc0000000000 RSI: ffff888031338b08 RDI: ffff888031338000
RBP: ffffc90003ed8040 R08: 0000000000000000 R09: fffffbfff2dc5b88
R10: ffffffff96e2dc47 R11: 0000000000000000 R12: 0000000000000002
R13: ffff888031338b08 R14: 0000000000000002 R15: ffff888031338000
FS:  00007f29143fe6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90003ed7ef8 CR3: 00000000320be000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	55                   	push   %rbp
   6:	48 89 e5             	mov    %rsp,%rbp
   9:	41 57                	push   %r15
   b:	41 56                	push   %r14
   d:	41 89 d6             	mov    %edx,%r14d
  10:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  17:	fc ff df
  1a:	41 55                	push   %r13
  1c:	41 54                	push   %r12
  1e:	53                   	push   %rbx
  1f:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  23:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
* 2a:	48 c7 44 24 30 b3 8a 	movq   $0x41b58ab3,0x30(%rsp) <-- trapping instruction
  31:	b5 41
  33:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
  38:	48                   	rex.W
  39:	c7                   	.byte 0xc7
  3a:	44 24 38             	rex.R and $0x38,%al
  3d:	b0 4d                	mov    $0x4d,%al
  3f:	7a                   	.byte 0x7a


Tested on:

commit:         ff7afaec Merge tag 'nfs-for-6.12-3' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169d5f40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
dashboard link: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169cf6a7980000


