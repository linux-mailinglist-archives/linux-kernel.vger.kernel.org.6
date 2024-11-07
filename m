Return-Path: <linux-kernel+bounces-399317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3419B9BFD61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BAF2839E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F35188A3B;
	Thu,  7 Nov 2024 04:23:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B7BA2D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953385; cv=none; b=gUb31jFknZm91c1vlrDbb5OhwP9d/jOO6E6Q0T14R6uzlTWz3u57d5StLARxXEJRNmNIDFJoHiL8f2v7y9PhwbHhepeCpNywAI49wwJ3cdaVE0/O3nf1NVBXdtBufDflO49upJgkZs/v3Ymr12KPH5Sjz1cc3gKcrAuw0VIhX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953385; c=relaxed/simple;
	bh=HFbz5dp6GxboTowLoUZqUZHfvqFga4TqV+sF8d7oUK4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XeKn61JniU7HCwIHpSWHQivcZV3HqvOgk3XtukIZeVEq510/oCrFvKFQ3Up1n7vlLNugp3RKIhMjlUkxmLCYyQ8rYx3MHjGDIBlpMx2Cws7ro4z7VyX9Qq35grfvCEw2AmA4MWC8XKD1TprcwNvlo13HQgVYVh0jvFFp7tPRhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e80ccd1bso6186155ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730953382; x=1731558182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p975kV6jmS4Aq1jEDsAX5vlE5VwjFZqqSQ+HVFllDrA=;
        b=cVAAyaiT9BfSsZdOZf6dEuuHfcFxcK/Qp2+KPSGlJrn35BNznBeutk1kroGQVPrNYJ
         8C1HBfVeP3BbOMOtjcw7LkSc8d82FA26WKMJkzoVVOf2Bd/rvm0CwJsgxfb6JCVt7i70
         xrNWrmuf+xP6wesbPGNccTsBQyBdfOAZnYB64HSgoU+Xz9HzwUvwMnda/UJMkSy6GAXD
         nVutciqr55GGxfhClzlAk0VPlOa1o5PZrKa/pHObuqh7uJMaE5mFupWuKH5c0chrMumb
         JEkaSv7UVMk/YH9oYtrbw3nACiYDoEpXA+xyxzHvopnywhO4XfGNEeJh4/SOc59PVKCZ
         e6LA==
X-Gm-Message-State: AOJu0Yz6BnKPPlX9N3TjjH02cFZNW8nIfFTlMKqsgSNWWMh6P70wJhNA
	F+OFqyYDGt/4/N5PFPab9Wb5jrEMXWOfF+f+5vzdljTtUYKnX8dmhq5bGJMaJJM8UFzJeTCLWv3
	Hfl+6q4LIRULY5PxdikpAxfX7jbx+6vaDQYqTp5nFuyhqHvnhhQqfupU=
X-Google-Smtp-Source: AGHT+IGEhUkDDEAQNKm6R7VbTdo9sKbf2VqkCh5HRUQNw02hVC1/wdU7pNlDaIkx7eWt1IaMvRbU6xaq4MqS4mBK32/CChJyNWph
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a5:b0:3a4:e62b:4e20 with SMTP id
 e9e14a558f8ab-3a6b0281c6bmr220948815ab.9.1730953382448; Wed, 06 Nov 2024
 20:23:02 -0800 (PST)
Date: Wed, 06 Nov 2024 20:23:02 -0800
In-Reply-To: <20241107041020.3067059-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c40a6.050a0220.350062.0287.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: stack guard page was hit in v9fs_file_read_iter

BUG: TASK stack guard page was hit at ffffc9000e0e7ff8 (stack is ffffc9000e0e8000..ffffc9000e0f0000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 9051 Comm: syz.2.783 Not tainted 6.12.0-rc6-syzkaller-gff7afaeca1a1-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:kasan_check_range+0x1a/0x1a0 mm/kasan/generic.c:188
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 85 f6 0f 84 50 01 00 00 48 89 f8 41 54 44 0f b6 c2 48 01 f0 55 <53> 0f 82 c6 00 00 00 48 b8 ff ff ff ff ff 7f ff ff 48 39 f8 0f 83
RSP: 0018:ffffc9000e0e8000 EFLAGS: 00010086
RAX: ffffc9000e0e80e8 RBX: ffffc9000e0e8088 RCX: ffffffff813d6ebe
RDX: 0000000000000001 RSI: 0000000000000060 RDI: ffffc9000e0e8088
RBP: 0000000000000060 R08: 0000000000000001 R09: 0000000000000000
R10: ffff888050fd0d48 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000e0e8148 R14: ffffc9000e0e8088 R15: ffffc9000e0e80b0
FS:  00007fee299f36c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000e0e7ff8 CR3: 000000004eb82000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 __asan_memset+0x23/0x50 mm/kasan/shadow.c:84
 __unwind_start+0x2e/0x7f0 arch/x86/kernel/unwind_orc.c:688
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x74/0x100 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4141
 radix_tree_node_alloc.constprop.0+0x1e8/0x350 lib/radix-tree.c:253
 idr_get_free+0x528/0xa40 lib/radix-tree.c:1506
 idr_alloc_u32+0x191/0x2f0 lib/idr.c:46
 idr_alloc+0xc1/0x130 lib/idr.c:87
 p9_tag_alloc+0x394/0x870 net/9p/client.c:321
 p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
 p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
 p9_client_read_once+0x443/0x820 net/9p/client.c:1570
 p9_client_read+0x13f/0x1b0 net/9p/client.c:1534
 v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
 netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
 netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
 netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
 netfs_rreq_assess+0x5eb/0x890 fs/netfs/read_collect.c:372
 netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:408
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
RIP: 0033:0x7fee28b7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fee299f3038 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007fee28d36058 RCX: 00007fee28b7e719
RDX: 0000000000000001 RSI: 00000000200015c0 RDI: 0000000000000003
RBP: 00007fee28bf139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fee28d36058 R15: 00007fffcb1ce608
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_check_range+0x1a/0x1a0 mm/kasan/generic.c:188
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 85 f6 0f 84 50 01 00 00 48 89 f8 41 54 44 0f b6 c2 48 01 f0 55 <53> 0f 82 c6 00 00 00 48 b8 ff ff ff ff ff 7f ff ff 48 39 f8 0f 83
RSP: 0018:ffffc9000e0e8000 EFLAGS: 00010086
RAX: ffffc9000e0e80e8 RBX: ffffc9000e0e8088 RCX: ffffffff813d6ebe
RDX: 0000000000000001 RSI: 0000000000000060 RDI: ffffc9000e0e8088
RBP: 0000000000000060 R08: 0000000000000001 R09: 0000000000000000
R10: ffff888050fd0d48 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000e0e8148 R14: ffffc9000e0e8088 R15: ffffc9000e0e80b0
FS:  00007fee299f36c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000e0e7ff8 CR3: 000000004eb82000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	66 0f 1f 00          	nopw   (%rax)
  14:	48 85 f6             	test   %rsi,%rsi
  17:	0f 84 50 01 00 00    	je     0x16d
  1d:	48 89 f8             	mov    %rdi,%rax
  20:	41 54                	push   %r12
  22:	44 0f b6 c2          	movzbl %dl,%r8d
  26:	48 01 f0             	add    %rsi,%rax
  29:	55                   	push   %rbp
* 2a:	53                   	push   %rbx <-- trapping instruction
  2b:	0f 82 c6 00 00 00    	jb     0xf7
  31:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
  38:	7f ff ff
  3b:	48 39 f8             	cmp    %rdi,%rax
  3e:	0f                   	.byte 0xf
  3f:	83                   	.byte 0x83


Tested on:

commit:         ff7afaec Merge tag 'nfs-for-6.12-3' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15134d87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
dashboard link: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f73d5f980000


