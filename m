Return-Path: <linux-kernel+bounces-333854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8697CEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 23:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259321C21D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5D1197531;
	Thu, 19 Sep 2024 21:53:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501DA181B8F
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782783; cv=none; b=GcHdLcgr60ri5jG5UQtVexA8+5djSlUhANiAd10/cKVGdPutFM5kDb/PAzid2P0wJPHZNoy8LLPFx1wabeIGj6qMw8EaKD2Beu2sMHOGhQJv53cR/R4Lza/hlYP73UBtjtuYodQyDhNw/BA/pNFspesMVODFnOAU0bKitIGHQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782783; c=relaxed/simple;
	bh=gH5jeaXTOGjaMZRbBoeeFR0tONnZ8x+YTluzWwg/Ygc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NaKVMz+QMkHbIz0Y30dlLi3tZ7BchanO/Be4V+sqmloy0Gtj6uH71l7HWrnXe5yktGRPhClIJw5fYJ76zrBAOB/MV1dPrvTLAI4O6KQWx2X2dBn6EQVS9mDpACBupx2nmeg8ilvxR1sYwZhmmTqUXR1sZSf3rldgbTBNjbyFOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0a2c95e81so18607425ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726782781; x=1727387581;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQDaAGdJwvcAPCWoOavAWx/j7bUgvmt62gUqSd994u0=;
        b=J65ukdtfRMsKSum3UYKHsSksiRGcSF49XV1vdrGW5uy0jSxhJ1cvZvpfNCIjCMeagu
         5+Q1BHHkH2hQEx9hCzcVLdwPGVTHXY8S6xPLrVq1lrT4IaFiP3lDQAKwjHVzPck8nkAx
         WhQi3QwN0oDYeBzLyZi8G/FWiZwS20Qf1cWGjt5E4TBYK8h8rWosz/oiYF7ZgpuI+U53
         AEg7GPvzO7LSNIcf23cETuErKd6q1p1v2A2M//7g1l05mlzUbNImiU84bx8TJKTh4ht+
         6U4QkYbe6ENJyDmW3e9bVHM8E+mLWK1mxC1IIlFxYF3ttkT/m9r7Wmu7jzOveUHoXeaU
         OxcA==
X-Gm-Message-State: AOJu0YxlRaA8N5ecbQ5Zsc2g4lQTeldz/Crw/d8JmBJyTadAWbk/WC63
	S8yr8DIXRTBl+gwjAKmJ0iIukFVZDnIP1j5PHep+i0iG2frxaZ6nM1OdSiaMPg4cKUzyB5yDLrQ
	2kRH9HuOTqkOG0BMfpATOjcPrZ2vX5D/EW9j6kKt1AQRjQtrzGTpQei0=
X-Google-Smtp-Source: AGHT+IF0wXVWbu6My1mpl1Aqkhgi3/rW2D16gewIV+AXX7+/8ASthr6SzBVD3SkJtPG7DAkc9QFxQx1+Zmk0TWaor6q54b6HWdGA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:3a0:9952:5fcb with SMTP id
 e9e14a558f8ab-3a0c8d1602fmr11551775ab.17.1726782781530; Thu, 19 Sep 2024
 14:53:01 -0700 (PDT)
Date: Thu, 19 Sep 2024 14:53:01 -0700
In-Reply-To: <TT27cZDqBGQEtV6whPGMs_ax9ZUJqt8I-54DUJm01rMuL0GpRVbg5Xa99R75GSKEvzaU7Vx8zNUFXCNhF1GZnFWioSD1pbhyvxq92Kc_Fw0=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec9d3d.050a0220.2abe4d.0001.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_journal_flush_seq_async
From: syzbot <syzbot+d119b445ec739e7f3068@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in bch2_journal_flush_seq_async

bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
requested to flush journal seq 36028797018963972, but currently at 15
WARNING: CPU: 1 PID: 7336 at fs/bcachefs/journal.c:672 bch2_journal_flush_seq_async+0x668/0x6c0
Modules linked in:
CPU: 1 UID: 0 PID: 7336 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkaller-00105-g5f5673607153-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bch2_journal_flush_seq_async+0x668/0x6c0
lr : bch2_journal_flush_seq_async+0x664/0x6c0 fs/bcachefs/journal.c:670
sp : ffff8000a2ba78e0
x29: ffff8000a2ba7960 x28: dfff800000000000 x27: 1fffe0001c739537
x26: 1ffff00014574f20 x25: 000000000000000f x24: ffff0000e39ca9c8
x23: 0000000000000000 x22: 1fffe0001c739539 x21: ffff0000e39ca9b8
x20: ffff0000e39ca380 x19: ffff8000927b7000 x18: 0000000000000008
x17: 0000000000000000 x16: ffff800083032784 x15: 0000000000000001
x14: 1fffe000366d7a5a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : c755fe8fa63d1700
x8 : c755fe8fa63d1700 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a2ba7038 x4 : ffff80008f65b620 x3 : ffff8000806051a0
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 bch2_journal_flush_seq_async+0x668/0x6c0
 bch2_journal_flush_seq+0xe8/0x280 fs/bcachefs/journal.c:759
 bch2_flush_inode+0x220/0x390 fs/bcachefs/fs-io.c:185
 bch2_fsync+0x1a0/0x44c fs/bcachefs/fs-io.c:205
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fsync fs/sync.c:220 [inline]
 __se_sys_fsync fs/sync.c:218 [inline]
 __arm64_sys_fsync+0x178/0x1c0 fs/sync.c:218
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 75740
hardirqs last  enabled at (75739): [<ffff800080388420>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (75739): [<ffff800080388420>] __console_unlock kernel/printk/printk.c:2801 [inline]
hardirqs last  enabled at (75739): [<ffff800080388420>] console_unlock+0x18c/0x3d4 kernel/printk/printk.c:3120
hardirqs last disabled at (75740): [<ffff80008b3363f4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (75718): [<ffff8000801f8e88>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (75718): [<ffff8000801f8e88>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (75375): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---


Tested on:

commit:         5f567360 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=117b6607980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=d119b445ec739e7f3068
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10136607980000


