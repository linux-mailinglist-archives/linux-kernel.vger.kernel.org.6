Return-Path: <linux-kernel+bounces-393681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6D9BA3F9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7B61C210ED
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2667083B;
	Sun,  3 Nov 2024 04:53:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA962320B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730609585; cv=none; b=H4bkP4RhYft68NmuCG02DugFruAhcY98IvrUWkgzfLupHkF/pdmnan/OwF+GqxzNhhdiAH6DFk543bXzrOZ/+EQSERir6iDvBETOgz05ZdmiXa/OzaoaRMzmkgpY0DlR49LyEr4cfp5SYrdb3Fl35JLmIqDC+DVWpqSl6DW4MSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730609585; c=relaxed/simple;
	bh=KnTcpxV2Csaoz+qznWX4eaIHImAzCqqbHpljKL5o7Zg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j4gGeQxPpNVndiwakNdrN/l674LYPfgKG6be7x1Ue8G1mw0BsHm+5HnIeXDmz/Yf9S35wKpepurfB0oAbmwIDjcPvXtDOX9zsrS54KtpTh/u5tjxhW5bmvuhhxUbe6JssFicaVolxDL211n2jGMn405KKPL1agmhWY89P/6K4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aecd993faso280436339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 21:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730609583; x=1731214383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAtLRilBTFpPx/YLvFzcW4k2VwXzdJnybWVQ9gNy8RI=;
        b=RTvtIC6UoefvHA3lJ3Qb+dkhwi6KRVA66NWZUWLRD1dceMlVY35AArKHkIMWspKijB
         1AmIOo3hSrnlrIxd/VrWrpXT4raEuoNNMITmv+PFmajU/WDu+i5iLG0pc/IHZEcz/0jS
         UBMqvm9byeL5DQBURYuojBCE3krX2PbNF5te0OcIleo5tCn0DJYhyTVXvuWKpZj5A00O
         78eA9JDnItUM6hUf9MGDtIac1M/ASk5KU1LnEIPrPX6fwU+fbHUsMUYQM31ea8GY+56l
         xLExST9PFKfFu9Ac3nmaaNTOxlBWbje028q8wCyptspij8PS+DXdhQH4c+5b9ta8GTo4
         Gz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEpvZCfNynjDHJZUepj8wtddx41hSRJpYWxJJMVKDfuEoOXxBYUR+gxFGqIvQBlqNRzFqJRwIJICqpqNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvU2QD4AwOAYsy5dra131jJWvdtBoMKD0IZmQY+Nps+KHKraAC
	YHvj5lnY/ntz5MdbZAiW2p4WvWyuE63J+re4FGMb3SSmnpF5Lm1KwrqQzDAAKXcQUcTsUW5Dajy
	C5ATdv1zEBepJuYyUjdnbLO5zx1QZ0oyRdI0Oxu2+1weSKpzSmbkXxRM=
X-Google-Smtp-Source: AGHT+IHGrpdNkC8XRCLcJd8TJjGLm7IJtsTowhdjYwCwhvBSDXoVIC/6UxWDlHt1eYVXqG0ekH+nKqacs1XagDKQT6ol+5rSNgCd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:3a6:abb0:59a0 with SMTP id
 e9e14a558f8ab-3a6abb05ca3mr83151515ab.0.1730609582839; Sat, 02 Nov 2024
 21:53:02 -0700 (PDT)
Date: Sat, 02 Nov 2024 21:53:02 -0700
In-Reply-To: <tencent_F692365DD35DD7192C4FB18DEFA5F30DE107@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672701ae.050a0220.35b515.0195.GAE@google.com>
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
From: syzbot <syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in mark_buffer_dirty

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5982 at fs/buffer.c:1177 mark_buffer_dirty+0x2e5/0x520 fs/buffer.c:1177
Modules linked in:
CPU: 0 UID: 0 PID: 5982 Comm: syz.0.15 Not tainted 6.12.0-rc5-syzkaller-00308-g3e5e6c9900c3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:mark_buffer_dirty+0x2e5/0x520 fs/buffer.c:1177
Code: 89 df e8 fe 82 db ff 48 8b 3b be 20 00 00 00 5b 41 5e 41 5f 5d e9 fb e8 fb ff e8 26 c4 71 ff e9 73 ff ff ff e8 1c c4 71 ff 90 <0f> 0b 90 e9 61 fd ff ff e8 0e c4 71 ff 90 0f 0b 90 e9 88 fd ff ff
RSP: 0018:ffffc9000cecf848 EFLAGS: 00010293
RAX: ffffffff82231604 RBX: ffff8880474fa301 RCX: ffff8880363cc880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82231361 R09: 1ffff11008e9f474
R10: dffffc0000000000 R11: ffffed1008e9f475 R12: ffff88804243f658
R13: dffffc0000000000 R14: ffff8880474fa3a0 R15: ffff8880516f1c00
FS:  00007fd80c3ae6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f88016aa0a0 CR3: 0000000040b52000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bfs_move_block fs/bfs/file.c:49 [inline]
 bfs_move_blocks fs/bfs/file.c:62 [inline]
 bfs_get_block+0x64e/0xb70 fs/bfs/file.c:131
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2121
 block_write_begin+0x8f/0x120 fs/buffer.c:2231
 bfs_write_begin+0x35/0xd0 fs/bfs/file.c:184
 generic_perform_write+0x344/0x6d0 mm/filemap.c:4054
 generic_file_write_iter+0xae/0x310 mm/filemap.c:4181
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd80b57e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd80c3ae038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd80b735f80 RCX: 00007fd80b57e719
RDX: 000000000000fecc RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007fd80b5f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd80b735f80 R15: 00007ffd276927f8
 </TASK>


Tested on:

commit:         3e5e6c99 Merge tag 'nfsd-6.12-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1689ab40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f51a2a34984e4d8888fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15091aa7980000


