Return-Path: <linux-kernel+bounces-182845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D838C90D0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 14:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD2B1F21530
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 12:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683CC39AC9;
	Sat, 18 May 2024 12:29:35 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8803715E
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716035375; cv=none; b=lDtIhtVLdO9jXEQyZF8GocUyzNaZGIYcjqsYl6PX99HHFIyoFyUnLfgmQlAxhrFsJhINMEMrRpd1++5azKGUdn5w7bT0CxqBPz7KN0V2VF/eWzIO5Q0YbcD5Xz6REiqJAAFf/7Ydz7iQpljt2FiBEw+HdnhlLUdnkm3YPu0BiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716035375; c=relaxed/simple;
	bh=SmC9Mub4nLHeIfJxmiAZFWQ2cQaoxVAjmR0MaKtmGOg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UtCQel9t5cNRaj4fN+QeZx689bVY9TVbsjE9KOlxVsRXBgwX9mcOjJxnpr2gy4ohm2nUVxQW+Hf8VYaYZkxk6Br98BnZO+KW7aR6HRWSVDM5r/zCq1g4sSyDblAQJxjgoJeqoP3BsmkeRmqH7x5871g4jGNvCuYdgF6lpyvZwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7dabc125bddso1160583939f.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 05:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716035372; x=1716640172;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWHEF8V+gaWWBVFsVrOFR14VWki8ZARAWVvQbJIaMcg=;
        b=g1tP+P+nZNqCIcx8AL5hVewVdnk+ra/pKRx26mVTjSXzsrrCbj2GJClxkMiYukYzUP
         EW53/hpqR9WQYHYWqrRu+oKeJLyZxHuGqbsfs3giKTSqsi2mo2RdommW9M+5Y0xclSa0
         bZn9l42AvMPp/TNb+VY5ldTJ3puSgQh0CePC8tInecqYl0dstGABaFDwkrpAuYlHEmPr
         8wv0zhekoBAuM2XzoN7KQFL/7Ocr3G2GqcjZzjlpCsobU1XO+CtCq677yvEgr1jXezbL
         8ZyE5K9KqjwpUHRjojD8Gnxy8xgmFbiHwutg4y+liqkHs8p9F/prp2QkM5kqgif8mtSa
         l2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtqPxmh/38xHiC5pKcyei9IDPJy0Z8g78U2BZtGSTXleEIHUkPlFz2zvh1cEnxOFDQ5kG6t8JTXwlnxPwrMm/Ra1lZ3O9uKyYwbjoF
X-Gm-Message-State: AOJu0YzkouXBHM8aKKuFJcwgzg6k83VBA/j4gNkQ2R9NuogHdzyYeBEu
	HZhx/mWbZIu12bbDQ57MOkqgUlLQstGHIHibVLU3wI9IjMMpGHTxIrG+7tp2fJbcvDDdzXSB0Ui
	SzI43FxrQmg8OjY6lneVFdJnudwAets6eR7ThILbtr8GI1UaR++DtpRY=
X-Google-Smtp-Source: AGHT+IEgkzLeTubGk9iaHD7jHca9t2O+mUExst2fjK1oKz+DGHMpd8YJo7cIEwTpEZhapGgGhqSe++qOuOzgALY4wvDnbufkFRsS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210d:b0:488:e34a:5f72 with SMTP id
 8926c6da1cb9f-4895857588dmr2012339173.2.1716035372830; Sat, 18 May 2024
 05:29:32 -0700 (PDT)
Date: Sat, 18 May 2024 05:29:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1e1180618b99e10@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbAdjTree (2)
From: syzbot <syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ea5f6ad9ad96 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e91bd4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e06a6259c6a4416
dashboard link: https://syzkaller.appspot.com/bug?extid=412dea214d8baa3f7483
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/db5d9201b572/disk-ea5f6ad9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d8ed484f1b5/vmlinux-ea5f6ad9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0de047f553aa/bzImage-ea5f6ad9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2900:31
index -3 is out of range for type 's8 [1365]'
CPU: 0 PID: 111 Comm: jfsCommit Not tainted 6.9.0-syzkaller-08284-gea5f6ad9ad96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x110/0x150 lib/ubsan.c:429
 dbAdjTree+0x383/0x3d0 fs/jfs/jfs_dmap.c:2900
 dbJoin+0x24b/0x2b0 fs/jfs/jfs_dmap.c:2841
 dbFreeBits+0x15c/0x8f0 fs/jfs/jfs_dmap.c:2338
 dbFreeDmap+0x62/0x1b0 fs/jfs/jfs_dmap.c:2087
 dbFree+0x266/0x550 fs/jfs/jfs_dmap.c:409
 txFreeMap+0x788/0xe60 fs/jfs/jfs_txnmgr.c:2515
 xtTruncate+0x1e57/0x2c80 fs/jfs/jfs_xtree.c:2467
 jfs_free_zero_link+0x372/0x4f0 fs/jfs/namei.c:759
 jfs_evict_inode+0x423/0x4b0 fs/jfs/inode.c:153
 evict+0x2f0/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 txUpdateMap+0xaf3/0xd20 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x5e6/0xb20 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

