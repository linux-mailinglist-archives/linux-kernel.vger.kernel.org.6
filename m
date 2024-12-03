Return-Path: <linux-kernel+bounces-428687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF19E1221
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE242826DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0F184523;
	Tue,  3 Dec 2024 03:56:26 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E015B0FE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198186; cv=none; b=sY+z4F2suROeiwssS0ft47SUQqWzItSvFL4Yb9ppbe2cLBY0z1TEOGL8Z909yCwP2f0PZIbEebHTjZsUJV51515xTyCBAXEelAaBJHPa72u63NRYmeSHtJvPAxGFrjzPdSZt8/wdv/bBFTIcSFCkESpwEtWbKXHN38L42yLgD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198186; c=relaxed/simple;
	bh=NyJA+90dIlOyWxI0xK+DfgrkLo5d2UdClJecAFhrV54=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S9EkbaMS6GWVGsKche9t1b71kRaUbXN7peT/FjwIxMIMRJTVRLVSfo2klvbM0kIC7GGyxFogCcueKF4QMwbdaWzYCQhjaGQMXf0MwyltB05Z3jY+QzUpFcxuIdmBwZBG7zjNSD28i2iaeGs+qedkZxV/xuc9dB2MP46bzrzQvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-843e5314cb8so451721139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 19:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733198183; x=1733802983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DLlfBu7sF3qqZ3Coy4Z1Lom0afRmT8UFb5NzVld/SE=;
        b=WwpDSLn69s7c7HDcZAUvBjWJDbm0ySfNKcT10iUZ+iOUYcCDDrhwyaNIqfCuWaC7jK
         EIFcNycEF//FmJejc0a7trpIri/WCq1SRDx3dsb3uBV5UltvGl47gpxQ8RHojLKFBSlY
         ZHYEc6kU3DO3kugNfTIodvqTmEwKKerSuHFv7fKB15dPBfy1vmg3xK2LojtS+JYgjEeE
         I4hUEjC5eEbfO2gGGb6I+aeiv3nh7vk02imiDVs9AeAxh6SBZsWRG6eHiT2zgJVoRMyn
         RxwZR+owGI5mMytwcqCAEC8ouwmPQw5+xB70uwHXwJyWMOKvyAp8jlbHgzA7+/ttUZx8
         DFYw==
X-Forwarded-Encrypted: i=1; AJvYcCVg6vQNJBbaZyOV4gH0d5vM81W5xcaNtPMHoxaNobRw9ZZQQyTWRBe7Y04osHfu74x3CkpthxkU43nSj1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQiL94ZesVqwlNhYboh3TP9u3kcAJD3XHSfyvP27pofyjpsJh
	gqzfeIcTDOl92fFrVvoMHzPNGmPt7KlyieGSC1lgqVA7j1VgVwOzEY9RDasle1ZbYSYlPid1eHA
	lAmX2z+2VWSVrx8aQEF7XgylxThLne0+DgqhmEdRPhdKyjhQIzguLy9k=
X-Google-Smtp-Source: AGHT+IFDRTk2l97KtR3fQihyFXXXX/TaWqJWsUzElZAxAvJ+2by8UglQPoLkW6dmP5NiG6bpKd3jlxQihQrTmnZVmsI8YtJSbSzA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ca:b0:3a7:8208:b847 with SMTP id
 e9e14a558f8ab-3a7f9ab0ee5mr10552585ab.22.1733198183506; Mon, 02 Dec 2024
 19:56:23 -0800 (PST)
Date: Mon, 02 Dec 2024 19:56:23 -0800
In-Reply-To: <67290b04.050a0220.2edce.14f8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674e8167.050a0220.17bd51.003f.GAE@google.com>
Subject: Re: [syzbot] [udf?] possible deadlock in udf_free_blocks
From: syzbot <syzbot+d472c32c5dd4cd2fb5c5@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12eeb0df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91c852e3d1d7c1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117440f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1659b5e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7e1e116ea6e/disk-cdd30ebb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76410fd02a13/vmlinux-cdd30ebb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60bcdb55dd9c/bzImage-cdd30ebb.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/559ad34ed532/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/90c832beabca/mount_9.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d472c32c5dd4cd2fb5c5@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0 Not tainted
--------------------------------------------
syz-executor233/6288 is trying to acquire lock:
ffff888033753d28 (&sbi->s_alloc_mutex){+.+.}-{4:4}, at: udf_table_free_blocks fs/udf/balloc.c:375 [inline]
ffff888033753d28 (&sbi->s_alloc_mutex){+.+.}-{4:4}, at: udf_free_blocks+0x9ff/0x2270 fs/udf/balloc.c:677

but task is already holding lock:
ffff888033753d28 (&sbi->s_alloc_mutex){+.+.}-{4:4}, at: udf_table_new_block fs/udf/balloc.c:581 [inline]
ffff888033753d28 (&sbi->s_alloc_mutex){+.+.}-{4:4}, at: udf_new_block+0xf81/0x21c0 fs/udf/balloc.c:725

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sbi->s_alloc_mutex);
  lock(&sbi->s_alloc_mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor233/6288:
 #0: ffff88807972e420 (sb_writers#11){.+.+}-{0:0}, at: direct_splice_actor+0x49/0x220 fs/splice.c:1163
 #1: ffff8880669baf40 (&sb->s_type->i_mutex_key#18){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #1: ffff8880669baf40 (&sb->s_type->i_mutex_key#18){+.+.}-{4:4}, at: udf_file_write_iter+0x6f/0x660 fs/udf/file.c:95
 #2: ffff8880669bad70 (&ei->i_data_sem#2){++++}-{4:4}, at: udf_map_block+0x3b7/0x5340 fs/udf/inode.c:439
 #3: ffff888033753d28 (&sbi->s_alloc_mutex){+.+.}-{4:4}, at: udf_table_new_block fs/udf/balloc.c:581 [inline]
 #3: ffff888033753d28 (&sbi->s_alloc_mutex){+.+.}-{4:4}, at: udf_new_block+0xf81/0x21c0 fs/udf/balloc.c:725

stack backtrace:
CPU: 1 UID: 0 PID: 6288 Comm: syz-executor233 Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 udf_table_free_blocks fs/udf/balloc.c:375 [inline]
 udf_free_blocks+0x9ff/0x2270 fs/udf/balloc.c:677
 udf_delete_aext+0x70a/0xed0 fs/udf/inode.c:2372
 udf_table_new_block fs/udf/balloc.c:645 [inline]
 udf_new_block+0x18ba/0x21c0 fs/udf/balloc.c:725
 inode_getblk fs/udf/inode.c:894 [inline]
 udf_map_block+0x1c9a/0x5340 fs/udf/inode.c:447
 __udf_get_block+0x126/0x410 fs/udf/inode.c:461
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2116
 block_write_begin+0x8f/0x120 fs/buffer.c:2226
 udf_write_begin+0x104/0x350 fs/udf/inode.c:256
 generic_perform_write+0x344/0x6d0 mm/filemap.c:4055
 __generic_file_write_iter+0x1b5/0x230 mm/filemap.c:4153
 udf_file_write_iter+0x2fc/0x660 fs/udf/file.c:111
 iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x564/0x8a0 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f912262ca29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9121dd6168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f91226b4708 RCX: 00007f912262ca29
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
RBP: 00007f91226b4700 R08: 00007f9121dd66c0 R09: 0000000000000000
R10: 0000000800000009 R11: 0000000000000246 R12: 00007f91226b470c
R13: 0000000000000016 R14: 00007ffe6add21b0 R15: 00007ffe6add2298
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

