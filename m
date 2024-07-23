Return-Path: <linux-kernel+bounces-260449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BBD93A966
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E661C22786
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E343149011;
	Tue, 23 Jul 2024 22:40:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8FA143C6B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774430; cv=none; b=RZD/XiPU6XanaoSclBFLKgImnw/qL1+inAgNZAYZO+5kYDDikjwTmA7lyXqy5Gc3yYpo3Ae4ZGnAu5lrY9dkbCFfFWDYQT/TAQB7cQ+EJGoltuzLOj5ZX7XQnS/qPsCL+E4r2uX0SCq/hbLqtTqvqG+1obqq7tErNuab2SbF9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774430; c=relaxed/simple;
	bh=78lY9dLD+h0MZQyf6Lojrg3dQffz//tJbxHzxxeqVxI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AwYqDbkUapvtEVa9ud4bDPIudZIT4wYm1Y6DmttUcX0Ed7kuxyY07FFk/7m/Tz5g9Oc6Ax1WudTMfUb39fDyT2wDyyaV8/kCTSwQQMseNDzmO5K0pej8xVORG3rkgN/B7E619ONRu0OUWeyKyebAy/uuYB0Q4AtIhIel7wGVaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f682b4694aso977691239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721774427; x=1722379227;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuj23c4ClzVXWf4TxC/cdJVB/gE1ITlvKVJTRiCxwf8=;
        b=ML1PKMwZlFQTc/zz+uVnDfD8zv36xqsjchY4pGn4sLeUdQYeJk7igJRSXJqUkHvvzS
         k0QxBNBahQLbGf4b5w/FxUtznXa86ArmOKYsU3XA/CZEzFAMy1q5N1ZGgIVIQ575t9Ph
         mIOKTwr7NfcZPQgahkh6rEv17nsyaArItCgJq6R52GRdiMGU3EUD7+a/BWw3ar/5GCKc
         pzUdV1Wu9bCst5D6qyWCxzHc5kMNvdxtiS3njebva6SjgJ5vcG5KHbOBrsALgseIkEio
         gHhthAEzwwwdU2voG8+UdcnUZByRqmTOUotbfEVqLg1bVpe4IPoKGgwZC1uZvOuaz1Ib
         TCOA==
X-Forwarded-Encrypted: i=1; AJvYcCWIHuVpySObFvcKxYgWlJuDhMATuuMw54N8TePj9DiBmm0M6KXDJEtfFzzO01erv5bfR0h4vfp04JPIxExsc9X5fXuCZNb2M2wjm3fK
X-Gm-Message-State: AOJu0Yz9pExF9zOAnR1I5ojxwZF67WFbtwclcs3thwN8I3v93hDa8ZuE
	mulC/1IjF7XJx7hR6lPjEOrYCva5sHo78OeHejJTH+o70kPeuI7icR3e8av/NC+kKLtg47iWskH
	UNPfiimb4wdpd/ZWXzp48AjAvOgrw2H7GIudrG2vy4R0TjVXvFBPg1Yo=
X-Google-Smtp-Source: AGHT+IFAaPm9UajL6GXF7/pDH0JqTHiu3mXQYr4xniz5kwvXqYfladgB1ToZ2a08YupRumup6tA11VQCsqYcn6nz0h30N3sSP7/t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:148d:b0:4c2:7f96:6f4 with SMTP id
 8926c6da1cb9f-4c28eed1b0emr9492173.4.1721774427680; Tue, 23 Jul 2024 15:40:27
 -0700 (PDT)
Date: Tue, 23 Jul 2024 15:40:27 -0700
In-Reply-To: <000000000000264c0d0617d88912@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025403d061df1d927@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: user-memory-access Read in jfs_statfs
From: syzbot <syzbot+cea4fad5485bc30243a9@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    28bbe4ea686a Merge tag 'i2c-for-6.11-rc1-second-batch' of ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=157aa8e3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d240b438cabdc8e
dashboard link: https://syzkaller.appspot.com/bug?extid=cea4fad5485bc30243a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d35b1d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120152b1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd50d9d26f43/disk-28bbe4ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5cc17b9d307f/vmlinux-28bbe4ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bfb78d6d09b6/bzImage-28bbe4ea.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0522d99a5f0b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cea4fad5485bc30243a9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: user-memory-access in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: user-memory-access in jfs_statfs+0x20e/0x510 fs/jfs/super.c:140
Read of size 4 at addr 00000000000050c0 by task syz-executor415/5092

CPU: 1 UID: 0 PID: 5092 Comm: syz-executor415 Not tainted 6.10.0-syzkaller-12084-g28bbe4ea686a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 jfs_statfs+0x20e/0x510 fs/jfs/super.c:140
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs fs/statfs.c:90 [inline]
 user_statfs+0x213/0x460 fs/statfs.c:105
 __do_sys_statfs fs/statfs.c:195 [inline]
 __se_sys_statfs fs/statfs.c:192 [inline]
 __x64_sys_statfs+0xe8/0x1a0 fs/statfs.c:192
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa111cece59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa111c82218 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
RAX: ffffffffffffffda RBX: 00007fa111d7b718 RCX: 00007fa111cece59
RDX: 00007fa111cece59 RSI: 0000000000000000 RDI: 00000000200003c0
RBP: 00007fa111d7b710 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa111d4829c
R13: 0032656c69662f2e R14: a92483129444e42d R15: 00007ffecd531438
 </TASK>
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

