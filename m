Return-Path: <linux-kernel+bounces-329961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4549797FC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27FD1F21935
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C0F1C9EB4;
	Sun, 15 Sep 2024 17:59:32 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C711C9DF3
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423172; cv=none; b=Gvxisiil6Pd+FERfKa+cFhjqZ4EzFri7/dITo/VQTuoEBciRdUEfvmjdfIG2Q4xepA69kdExW/tf5lP/bK+poXDMkMr3jKVhgjeoLblp3uOEnNGbfq5DDHjJGY5fOb0YYo4km+DFYmIQqukevys9qL2+KMpzdGj8fT0zoBLT8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423172; c=relaxed/simple;
	bh=AbLhdcIWMYHppvAa3FSNSS0WHV6p7IfDIqC9X6e3kPA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qfH0VesgMLOTK6g68zpmyagQIPiw6NTVcN6mRhtHODhwRmbPys3mY2hv15BCuUzcLKgYnnz/JIOs+nrDyzncY/skMPRcfY39JwOdRPebmdh6L9mUJyInjZ1pBomBTTy3EuOB8ExSwRNbiQo4mL3cg4nwrHnk7TCS5tBeWqs5Bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aa67b1101so757072139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 10:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726423170; x=1727027970;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Ytc8D5+w/wtl5BV7+3EPGFd5TX+8Aok77VMpyqa1MM=;
        b=WQDYDfRpID2lIBWhc8PubgpHfhv4Ti+WI4PMtUvVBSunc4m2zgXgQmIexQDe+eq458
         6IWAtdz4xO45vKQRVohV101G/j48duu6CMcI+MvjzUj85otZhvZ/7gdrzJGO8IGfFPI5
         J25/pcaDUVdvLb3sZ6+hEwpauC5vNffl4ar0DkEb/jY669zuVRCkhm3tURlLLFA72CeE
         GSR0dnl5lrHSBIEF5xdN/usac7eulqaj6Im2T10xnes3beH10Dl15bSennjHGZiWnBqU
         FP5MqpdlsjbI2x+H7Ai6K0JUEWlqPimHm857LHCKa/uvDZwisxFBjcx3AW0WuYHwyZH+
         Hjaw==
X-Forwarded-Encrypted: i=1; AJvYcCXoM4AMZjqWONnR3/cdChbsYuT1AZ9xwiPMYkNNm2QXEvfdRFwRPfsIBXVS3c64asWB/7Ie0XZCXuOF9/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1twoEs8MmSBKrR7GJMjLsDLJRs2dbESrVfuCEUJnEkEdhVUht
	qLLGp3dcAs0DdTu8vSQrsX+fZHdsE4I22gHxRX/MdKkiqkZTuE8hrd+qtfZJhgYlnfi9ukhNlwM
	ZeI0m/6sbgOxGurclaLI8XLf1b+5TYaqETdkr2ZpHpIgF6rlfRrchGYE=
X-Google-Smtp-Source: AGHT+IGH0tBFUzC4AkBBPaMLAIqXzAxgTQ7wfO8husem8wDFYPI1r2EM6ekcj5CSCha3TOgQ91XzRxZB7pN6TCiXF9IYzY/mk/4Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3a0:a08a:a0d3 with SMTP id
 e9e14a558f8ab-3a0a08aa209mr12566655ab.18.1726423169855; Sun, 15 Sep 2024
 10:59:29 -0700 (PDT)
Date: Sun, 15 Sep 2024 10:59:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c58c6f06222c3744@google.com>
Subject: [syzbot] [jfs?] kernel BUG in dbBackSplit
From: syzbot <syzbot+af0d2605ff1908d60ca9@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    df54f4a16f82 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15f1a200580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dde5a5ba8d41ee9e
dashboard link: https://syzkaller.appspot.com/bug?extid=af0d2605ff1908d60ca9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa2eb06e0aea/disk-df54f4a1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14728733d385/vmlinux-df54f4a1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99816271407d/Image-df54f4a1.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af0d2605ff1908d60ca9@syzkaller.appspotmail.com

read_mapping_page failed!
read_mapping_page failed!
BUG at fs/jfs/jfs_dmap.c:2700 assert(leaf[leafno] == NOFREE)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_dmap.c:2700!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6540 Comm: syz.0.10 Not tainted 6.11.0-rc5-syzkaller-gdf54f4a16f82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dbBackSplit+0x50c/0x510 fs/jfs/jfs_dmap.c:2700
lr : dbBackSplit+0x50c/0x510 fs/jfs/jfs_dmap.c:2700
sp : ffff80009b097910
x29: ffff80009b097940 x28: dfff800000000000 x27: 0000000000000074
x26: 0000000000000000 x25: 1fffe0001a90ac1d x24: 00000000000000ff
x23: 0000000000000006 x22: ffff0000d4856076 x21: 0000000000000055
x20: ffff0000d4856010 x19: ffff0000d48560ea x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008b22c470 x15: ffff700011eb116c
x14: 1ffff00011eb116c x13: 0000000000000004 x12: ffffffffffffffff
x11: 0000000000040000 x10: 000000000003ffff
 x9 : 66d0280209d6ee00
x8 : 66d0280209d6ee00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009b097078 x4 : ffff80008f5fb200 x3 : ffff800080381c08
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 000000000000003c
Call trace:
 dbBackSplit+0x50c/0x510 fs/jfs/jfs_dmap.c:2700
 dbFreeDmap fs/jfs/jfs_dmap.c:2108 [inline]
 dbFree+0x498/0x5b0 fs/jfs/jfs_dmap.c:409
 dbDiscardAG+0x604/0x748 fs/jfs/jfs_dmap.c:1650
 jfs_ioc_trim+0x3cc/0x5d8 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x338/0x550 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: d004e9a3 91128063 52815182 9592231d (d4210000) 
---[ end trace 0000000000000000 ]---


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

