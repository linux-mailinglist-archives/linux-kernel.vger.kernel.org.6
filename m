Return-Path: <linux-kernel+bounces-282213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E622A94E0E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E70B1C20DAB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4A3EA83;
	Sun, 11 Aug 2024 10:43:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E147C8E9
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723372985; cv=none; b=S8F6D20aKFRVE2lJMu+5g5FTOeDEhTF38VHRhuIZO7DKGu2j92FQPKFKEpLl19EBWY1W/mxDRJwQGYUxfbg2xKKLPqEC2dgxaKghlFzwPD1e/I1juM99SBmFy1T2bgtbH0yr/p5udCnV6+5nNjXKL7Q7qlvag57o6NNfcVVOiGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723372985; c=relaxed/simple;
	bh=aUnMoTq2jIXbg8u/VBEZbX0vfSzeUKq/JletJa8Mm1o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U//5dJ+WJO+UqtqiLX++u7JdjH9GGj+VxLJROkvwSGwUQTE2MiheJQTbjL/9uJFXHvoyjnKiwqTjpZS6W35ZadedZLfwaANx2rEgHTU9riIkW5joQpj0H8bbDucjNBaOQ+SukeFxjHtY55FrQSch9e1Ru+KfRE9QpLkKemypDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b349a0234so51237435ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723372983; x=1723977783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHnf0rYTZCNPZDDGcyfulut31vwLZIHnkhGfxnekLC0=;
        b=ZPNYXHcQ8IdG4SK6UHRR/tddquW+dvPcB284k69k4ugiAKTfpPBD9TXr8lVjLEanWj
         20jvM2+igTSACgU6FWKbaLI4T8zt0K7aZ4LUV48O6rcqONdrKtvUSAkD5hfXXMyZrHzY
         aAVIpIEhvDLyQAs6NiiY787jftaAHoyxPeL/M47fUs7ni9rGBgEABYMhjwUGlfEH/Wpk
         0noxG4gcz69qiXXEJP7FJbCVd5lQNrxf0/T3Y9UTCS/ItK7hT2mcSpY34u6ATTe6XcGp
         /5OcpC5uAynHe1NWGAERNSFgoNvREalwILJNYAl0TrMFLIjkWIfrBxZp72RzlZv3VcyK
         AlpA==
X-Forwarded-Encrypted: i=1; AJvYcCVCCKInxgneafqtgKtuIWLcDOo//g3vYaoFmCJZcjQHtf8rUxVZgZd14scf+jxafnje0A+HfQQ5fnzxtHnsVst08Z510i6rgK6aMRFG
X-Gm-Message-State: AOJu0Yx4ZgOU2FLWKxAboKkKCXX4cojsYZUqRXfFZlYCdVjLEBLoJEFB
	/+kIvKAzPMSozM9fEcDbx/xhqaSUEuzVefBbz1nm5If4CJbRIdC2h0WXqpw2pEescfHGlFNXFBn
	K+6F/Tg1eYcik5OlPpKzUjnfNOPL4vDZi7ulXw/2p4q6hCGRZrleQmB8=
X-Google-Smtp-Source: AGHT+IFefyKRpwO20nqs3n+flBNAF5z59p/3O0V3Y/BPFOhX2WTBK87W5dS8GXrvGSBzm2LobdT7/cGW88aF/KDGyRyLPTGRNP9N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8f:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-39bd755259fmr5067435ab.2.1723372983564; Sun, 11 Aug 2024
 03:43:03 -0700 (PDT)
Date: Sun, 11 Aug 2024 03:43:03 -0700
In-Reply-To: <tencent_8CEBCCA4E7D406EF12CD864A49942EFEEE06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000804cad061f660ac2@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino state: 393351, ino: 1901337, comm: kworker/u32:9, folio: ffffea0000b70480, netfs_writepages
ino: 1901337, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901337
WARNING: CPU: 0 PID: 1137 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 0 UID: 0 PID: 1137 Comm: kworker/u32:9 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-246)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 e0 a2 8e 8b e8 15 3e 0d fe 90 <0f> 0b 90 90 eb 80 e8 39 27 a8 fe e9 6f ff ff ff e8 9f 26 a8 fe e9
RSP: 0018:ffffc90005b77478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88804550b9f0 RCX: ffffffff814cc379
RDX: ffff888022754880 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88804550b9f0
R13: dffffc0000000000 R14: ffffc90005b77840 R15: ffff88801b231958
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000000db7c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x6ee/0xec0 fs/netfs/write_issue.c:536
 do_writepages+0x1ae/0x940 mm/page-writeback.c:2683
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x611/0x1150 fs/fs-writeback.c:1947
 wb_writeback+0x199/0xb50 fs/fs-writeback.c:2127
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x28d/0xf40 fs/fs-writeback.c:2314
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11288d7d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113ac96d980000


