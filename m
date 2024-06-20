Return-Path: <linux-kernel+bounces-222205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E26A90FE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F71C20D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F5C4315B;
	Thu, 20 Jun 2024 08:02:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025B2139D7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870524; cv=none; b=F2ttVn5S21F9dulVj4JBgmpYFh8Ym0nNWx9g9iWv5pu4S72HiJa0RrZIJwa8xI5hWtb+ILgWDHeJyaCQSHN/osX58+4F/WxR5Vsfr1FhiJQCe+pmEtAuiFjkskN1ospis64NyV3SgIOxtwfLQofE1uML73br/G27s2GBQ/G7UWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870524; c=relaxed/simple;
	bh=PA/HI5rU4uPp01IVlceLhi1UarqzruXrsue5Gr466UU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O6UoSHUrhp1Vm3uSqb/5PrHB0m/QNaTYScJIN/wRuvvXLg1dq+vuxKw9sDPaHRR5Q8cWAijFxUCnJtkX+BQpsg1oNmGXyLutLeafRlqhxqQJEvHYgYM9a+RyPZDGWMw7Bg/00hgN2l0r8VaB39Ukr2w83nKDw6TtoyP7U6hkfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37624b27e27so6213045ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870522; x=1719475322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwSfaNcF5zY3Ol42a15Zv9ifiw08n590E8hBhuNKH7c=;
        b=EVIeziB8r5WCvoPS/7EfddVYIsAkiFc/84tcgR5zYFoCMWnOLnwPOMfxDvLWhqnXkQ
         Oxl/M30Oxkq7WqsfEXaPL39PyI2NsEa9hp1Il3rQ6vaCTNLDYOKC9Xd+8tMZaStfD3dK
         WAznSBFzJZhp+gOemlqR7HGK92PQ8qQDQurU768HV3VDk/xnuo/C+KUnUvCX1tKW814d
         WDS/yOrZD6l4oLFn5Y/XPvS1hHIXxRk6f8tL+rcV3nD4WIZIT/lggjZe+nBd6k2KThRf
         ps85Dk2ewsQdCmCwE17T/bmQa2Pi4NcswElt2+ronAhDNQfMRowa46z+8xtd/cIhxwuD
         ynqw==
X-Gm-Message-State: AOJu0YxAdKnN61nfoneTDSwCq9y4xGI8mSWxstxmf8OxhWUmODbPMGKT
	veSQWvWGEuVbr/1yh73x92tR8P8vTQHuZjlx2SmJMUXgv3noBimsKj3lhM5nB7miX7EFwjO0JMW
	d+wYUahd6L8RKMUSkZyT66SG3ZEZD2wPi7VACBRAJopJcqAixwBmac/A=
X-Google-Smtp-Source: AGHT+IG/9ypkqDEvVbQq8YkYBg/332ntiXOu/rnGp8xljFy7vg17NfkmQd4d75utank7aWzPNK6N15a2YmKm0qsgcfjlf2gRGBM4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12eb:b0:375:9522:1831 with SMTP id
 e9e14a558f8ab-3761d749acdmr2511915ab.4.1718870522216; Thu, 20 Jun 2024
 01:02:02 -0700 (PDT)
Date: Thu, 20 Jun 2024 01:02:02 -0700
In-Reply-To: <PN2PR01MB489157F204C812E350B53303FCC82@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e46014061b4dba56@google.com>
Subject: Re: [syzbot] [net?] [bpf?] KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in sock_hash_delete_elem

=====================================================
BUG: KMSAN: uninit-value in spin_lock_bh include/linux/spinlock.h:356 [inline]
BUG: KMSAN: uninit-value in sock_hash_delete_elem+0x490/0x690 net/core/sock_map.c:939
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0x490/0x690 net/core/sock_map.c:939
 ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
 bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:2011
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2250
 bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
 __bpf_prog_run include/linux/filter.h:667 [inline]
 bpf_prog_run include/linux/filter.h:674 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2396 [inline]
 bpf_trace_run3+0x201/0x500 kernel/trace/bpf_trace.c:2438
 __bpf_trace_block_bio_remap+0x34/0x50 include/trace/events/block.h:507
 trace_block_bio_remap include/trace/events/block.h:507 [inline]
 blk_partition_remap block/blk-core.c:571 [inline]
 submit_bio_noacct+0x2449/0x2800 block/blk-core.c:762
 submit_bio+0x58a/0x5b0 block/blk-core.c:879
 submit_bh_wbc+0x81e/0x890 fs/buffer.c:2804
 submit_bh fs/buffer.c:2809 [inline]
 write_dirty_buffer+0x1ac/0x1f0 fs/buffer.c:2822
 flush_descriptor fs/jbd2/revoke.c:657 [inline]
 jbd2_journal_write_revoke_records+0x1c0b/0x1c80 fs/jbd2/revoke.c:562
 jbd2_journal_commit_transaction+0x1949/0xa620 fs/jbd2/commit.c:551
 kjournald2+0x494/0x900 fs/jbd2/journal.c:201
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2250
 bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
 __bpf_prog_run include/linux/filter.h:667 [inline]
 bpf_prog_run include/linux/filter.h:674 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2396 [inline]
 bpf_trace_run3+0x201/0x500 kernel/trace/bpf_trace.c:2438

CPU: 0 PID: 4418 Comm: jbd2/sda1-8 Not tainted 6.9.0-rc1-syzkaller-00257-ge478cf26c556 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
=====================================================


Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=1663af02980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=c33bff5d5da1391df027
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

