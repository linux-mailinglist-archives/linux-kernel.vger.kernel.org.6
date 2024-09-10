Return-Path: <linux-kernel+bounces-322579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B938972B12
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0BB1F24DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BD017E8E5;
	Tue, 10 Sep 2024 07:43:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7517DE36
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954185; cv=none; b=VdJCaDLokdgX8rlt+/bbzCBZGMHnDnMD5ECEZof96Rq2mY/ISstcyatv89qEeozAspCl6H97oVkJasPk4E/MzUhvbSep+9stC/aEFZQvDsq1yzQOSONUGoq8PMI50eb0Id+oGrAIM1UlcvFSOcP7ggtGUAV0tYfFbknuO606pks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954185; c=relaxed/simple;
	bh=agDh5uSrUaRfmL2l3e+u+SgR8YKDegx1ASp5V3gWUNc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LYWkZE7oiL1suZ8hVqmx789ANuM3LgeObP7TiM+mgU/ly4tyjbmg37Y6Ikg0PrlnJ79dG4GR+T+zuCyXlFBpc5cxkaMJkM5ujdjni3jKKD71jHPxTnYyc/EQs21XitkJI8BgHjJHueSGQ/gHf12qqgo64HBqFt8YXggJ2I6r3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ce2629e40so402828939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954183; x=1726558983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ03XQFNZMqhbImfNKMgvJZs5lZWQY9KTsvzod3/cDY=;
        b=Hz0nVPeEu/vgJuwiOuFgjO3Sx4+72gfUTOL4IL6Luv+uHjRL7OTsNnrpZ/rjW95x1R
         qXazC6UxXy0VSJmcpDzgbOuGFQ/IVvcAzglm+zyP1cQ0+zgm+ctddUqZLkGBgwBjMtBg
         SWmVqGvRdN9/ufRW8skPHaBXSklavGvlYoONjxLffphARVlZEmy9mvhGbRmOuKLRoZeP
         Pm7SH3WnxuDpgFEVqRvHmaXyZTHbgObPEUqyrUcmqKWjdSfg+4S2yz304W7OGB28jgMb
         TGWGOmv41jwZYJXV6KbmI0ssVQWkLZyDvV6ckB1A5B9jUOPcJkkacnMzAqWreTh4a09C
         cjgg==
X-Forwarded-Encrypted: i=1; AJvYcCXmin9JUDwVcjv4nN4PmDdhIuoFGqFviQ9vxoY0Eu2I6Yj1QdosROhAPK+iU4b4gwNiiBljhSegd6Gt0LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7GqZPLfeZ0SzRwmG/G3KyrGHGtK90vEqtqCBhJZ7i1STsArI
	mGEd0XSRyw5Tv6T14cadf9wprGgKPh6B10cTZbwb8qwtQp2xXfP1r7lbTLPfVnFYFkAhfp2DynY
	SP2x0EOZQAoWrBGCNnj5sj/nCOxpigydXsZWXtKdWFpIfSvi2JesrsdM=
X-Google-Smtp-Source: AGHT+IEE21rX19rK9X93cdUde08nWnfVf1LfYJA50EWYkVL9Q6ySPo2n+ArWPR+P3Z7/B4TCtgHyWFMw3wt6taC05D60uop8AOGJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c4:b0:82a:a8af:626f with SMTP id
 ca18e2360f4ac-82aa8af63bcmr1183133839f.2.1725954182913; Tue, 10 Sep 2024
 00:43:02 -0700 (PDT)
Date: Tue, 10 Sep 2024 00:43:02 -0700
In-Reply-To: <bab2637d-45a0-4f45-8488-6a56b4feaf4e@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8b3650621bf0562@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-out-of-bounds Read in
 udf_get_filelongad (2)
From: syzbot <syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, zhaomengmeng@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __udf_add_aext

loop0: rw=0, sector=117, nr_sectors = 1 limit=0
syz.0.15: attempt to access beyond end of device
loop0: rw=0, sector=117, nr_sectors = 1 limit=0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5602 at fs/udf/inode.c:2043 __udf_add_aext+0x571/0x700 fs/udf/inode.c:2042
Modules linked in:
CPU: 0 UID: 0 PID: 5602 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkaller-gbc83b4d1f086-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__udf_add_aext+0x571/0x700 fs/udf/inode.c:2042
Code: 41 5f 5d c3 cc cc cc cc e8 5c d7 74 fe 90 0f 0b 90 e9 e7 fb ff ff e8 4e d7 74 fe 90 0f 0b 90 e9 54 fc ff ff e8 40 d7 74 fe 90 <0f> 0b 90 e9 45 fd ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c c7
RSP: 0018:ffffc900026b78f8 EFLAGS: 00010293
RAX: ffffffff831eb570 RBX: 0000000000000120 RCX: ffff888000990000
RDX: 0000000000000000 RSI: 0000000000000120 RDI: ffffffffffffff40
RBP: 00000000bffffe00 R08: ffffffff831eb2b0 R09: ffffffff831eb066
R10: 0000000000000002 R11: ffff888000990000 R12: ffffc900026b7b80
R13: ffffffffffffff40 R14: dffffc0000000000 R15: 0000000000000010
FS:  00007f2deb03b6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa084b2c000 CR3: 0000000054cbe000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_add_aext fs/udf/inode.c:2104 [inline]
 udf_do_extend_file+0xaf7/0x11e0 fs/udf/inode.c:540
 udf_extend_file fs/udf/inode.c:692 [inline]
 udf_setsize+0xcc2/0x1320 fs/udf/inode.c:1265
 udf_setattr+0x3c7/0x5d0 fs/udf/file.c:236
 notify_change+0xbca/0xe90 fs/attr.c:503
 do_truncate fs/open.c:65 [inline]
 do_ftruncate+0x46b/0x590 fs/open.c:181
 do_sys_ftruncate fs/open.c:199 [inline]
 __do_sys_ftruncate fs/open.c:207 [inline]
 __se_sys_ftruncate fs/open.c:205 [inline]
 __x64_sys_ftruncate+0x95/0xf0 fs/open.c:205
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2dea179eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2deb03b038 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f2dea315f80 RCX: 00007f2dea179eb9
RDX: 0000000000000000 RSI: 0000008002007ffb RDI: 0000000000000005
RBP: 00007f2dea1e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2dea315f80 R15: 00007ffec4d97f58
 </TASK>


Tested on:

commit:         bc83b4d1 Merge tag 'bcachefs-2024-09-09' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10303f29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1686f43b980000


