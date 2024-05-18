Return-Path: <linux-kernel+bounces-182890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D44688C9165
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9B0B2124A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753CA45014;
	Sat, 18 May 2024 13:55:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4544C68
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716040507; cv=none; b=hFmWvmvNIAoUQzPWNcT3mPTFXdAsuktUZ4+yuEG7fimWLG3pepCPgxIqoTxdgXe2BqhhcGG1IBwWZ8p5JHA66yrO5mFsvXSuJWlbrbW8gxCb7BvtlQOu15y17hg9MzVH9Q0j7IQVxiTqYqUoKWd4kVC4WfTwIIIq5Hj1N+wJ82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716040507; c=relaxed/simple;
	bh=wzdS8cN3ceJuuNb+lmQbNLx5BqAzZ/Nze2sZmLAeN2Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cAU56JaTXhikIJF+P4XHU8V6oOCFUeN4fm0nCxnIa6Hxx22QOQ0T79B+Vbkb6us/yRNkgZBjfpC9dUlXhm0FqohYUO6rgcwvU3bnQOQUslsSNh9WRYAPnK8eV8gjQYoKP8pZMUJB7uEucYSl1PmvWRY+TQRjUsa3PoyNIea70IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e17a8bed9eso997934739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 06:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716040505; x=1716645305;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLwSnBIPW3gItsRd1Dx5nZRcca/mMWMca9KWWOedY6Y=;
        b=YIZL8znzhYVxSdMOX6TXVoyggSamCkDT4QQ+x80fhIobW1RyZa5qCHxZWyM3x0K2MA
         D4ldaYEytkrDdCscvYTnN/qO6JdESmV2bT9iBUAAofTcZbuLepmfRzZiPlR20mM7ijLM
         ivsSIPYwVVjQ4v9fUUFhSCkOxt1tQgCP5TD3HNozVhSjPLRghsIFhMLEZ3hitSN3icqU
         ia92YVZkt07tE/DOPA+Ehye8zmSWNWz8/K9rT9N/Khrgb9OCuwjg2rhVriJPKXIT9jTS
         iHDvF8TncPTpJbdn6CPQSZMODBKkGexQLhPN1Wc8ecf8levFmwtw93XOyKXSM/QU0HTN
         7m9g==
X-Forwarded-Encrypted: i=1; AJvYcCXB3kqpNe5En16Qq6txqVIB0zeamNTzZzb/v7nUc2TPRk1E68jLJljUGuJfIoxTGjDvuyAU1GTYd47uS75/Yt2FARVz2nNudJKaSQ+q
X-Gm-Message-State: AOJu0YzhDRYRg0cmxR+iLo4e53REp5SVmoWPbh0k1owXNwhRGFD6ZM8D
	cdFIkNiTtreVYvp8kRXbUXt+JKf8ZKKaOxyHEDKzfkYcMlVCtcMXS2JWeMW4zx7w7ZP4TWxVny0
	uXj04T6Vt8lM/KbPPHHH3LGVJbexlHwd4xHvWJGPmiM5mSlAdQawvOc8=
X-Google-Smtp-Source: AGHT+IECWZq0s60NjfGGwn3hpE2xy6tSNCgxb7/Nc6yE6xoIBfste4RXVabQVRBfuu/EaJLsTkYvyThidIi2KzKbVsZiZWCLem/Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:5e26:ffb5 with SMTP id
 8926c6da1cb9f-48958694bafmr1693958173.2.1716040504765; Sat, 18 May 2024
 06:55:04 -0700 (PDT)
Date: Sat, 18 May 2024 06:55:04 -0700
In-Reply-To: <20240518133234.1786-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4fca50618bad06f@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in p9_req_put

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 3 PID: 1092 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 3 PID: 1092 Comm: kworker/u32:8 Not tainted 6.9.0-syzkaller-08284-gea5f6ad9ad96-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events_unbound netfs_write_collection_worker
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 98 2d 0d fd 84 db 0f 85 66 ff ff ff e8 0b 33 0d fd c6 05 97 cc 4c 0b 01 90 48 c7 c7 00 24 8f 8b e8 f7 47 cf fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 e8 32 0d fd 0f b6 1d 72 cc 4c 0b 31
RSP: 0018:ffffc90003a5f830 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814ff319
RDX: ffff888023018000 RSI: ffffffff814ff326 RDI: 0000000000000001
RBP: ffff88804070b768 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804070b760
R13: ffff88804070b768 R14: ffff88802d844c00 R15: 00000000ffffffea
FS:  0000000000000000(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc1bfd2c38 CR3: 000000000d97a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 p9_req_put+0x1f4/0x250 net/9p/client.c:402
 p9_client_rpc+0x5fd/0xc00 net/9p/client.c:757
 p9_client_clunk+0x93/0x170 net/9p/client.c:1448
 p9_fid_put include/net/9p/client.h:280 [inline]
 v9fs_free_request+0xdc/0x110 fs/9p/vfs_addr.c:138
 netfs_free_request+0x22c/0x690 fs/netfs/objects.c:133
 netfs_put_request+0x19b/0x1f0 fs/netfs/objects.c:165
 netfs_write_collection_worker+0x19d0/0x59e0 fs/netfs/write_collect.c:701
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         ea5f6ad9 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=140cc3d0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1755df84980000


