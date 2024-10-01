Return-Path: <linux-kernel+bounces-345565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAF398B78C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F1BB24A82
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A501E4AF;
	Tue,  1 Oct 2024 08:50:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9419CD19
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772604; cv=none; b=PRyCz8ijApjj+Im1gL8iFEDy/iWrd0ELceTBXIqPHKx423zZ5iwsQb/kHgvC45Z9qmTkLTwpY31DuGi7w3cBNWEFD6yzdkFqBZjTnrP33j/A6X9qsMBLLVaqXyoQUudRiRif4Ou4g56PICN50qrqcCXaeLFopB2Fr/4HTk2IRZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772604; c=relaxed/simple;
	bh=bSVyuhB6U6lRxJyvjhSuTefCWXClIF/fLYhnG54YBpI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DMgDW+42fb6UY5XlHfOIvdmC/Fp+9v/18U7COgC+nJH1xOlfpC2V+4E5JEThZDIlPt5B3eRTiHDfs3l3N4IcuieCbsKhzDUv/ccETrW0Y8UWd4Xu3wb1CwNgaWchmr6PI+Sies38jlLyZlmRAqZ77TCGdx0GGdi5E/1IltD/NWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3479460f4so38278665ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727772602; x=1728377402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/mfbWFXvjNnnWlW1HDBA3n5IUAJeccF0MYxwVBasIg=;
        b=Q9c4Yp7MqvTAuk1ge4FiXZpHl+swBR01xZLYalOvcSc6pall5FIEHDoL8KY9g0KUVt
         gWe2jP8TUuszYtNoCFOgSdkQDCOC+qAjAFlXYATzOxV3uVFGj02aF365DPbZvGJ/ASOD
         lksbNePDHYVRG5NTGeJu6EZxsUTWLu3dPd2ZZ0tBBimdf1xR5SSlSfky+F+6RpnrEQ9H
         35X5NRZjgunH1VgB0/h4yrpKJmt6L/khwQYYCP6jMWNHOpQDNhMvAa0ggFtgYdr7MbGn
         Wn1s0EhPSTly3fuSJ3HFPYMA5bZ/u/yEeWx24RsMRc97ErOIV6NyJqmN8Yp+9C6cJliF
         wy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpWmB/kNWDH+FXwUQjbug47IG6BRf23IYr55cIa1vYY9nvI9qHTrr6FWtlGq6Z2x+fJh7kEAQ7PvRRGyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyL7olgoRW40J4hj60C2r05xhsVv2SSyD3WTHSA8URgZzr6FJ
	12DugYnVmduHpcruhHPtBuGXu25kVAIlPNPIQljNEhmOKiCOToxsLCn8gTXuxBh4DXhiGWjVphD
	Xbhz0Ojaeq/piegG2Jh1nzYKpgCriKr7/kbOhy3zYyeo+YuhXBdIleUs=
X-Google-Smtp-Source: AGHT+IFDNXwczB5NK5a22mAVTO25HMnCVhDSMHyI8jnP9dCF4lEMGed21s07BhkhnK4m3s8dBvu4Sk+2JpzTiXfoSk0XO6Q8DwzR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0c:b0:3a0:a385:911d with SMTP id
 e9e14a558f8ab-3a344fcc3e1mr139813785ab.0.1727772601771; Tue, 01 Oct 2024
 01:50:01 -0700 (PDT)
Date: Tue, 01 Oct 2024 01:50:01 -0700
In-Reply-To: <20241001083126.1792-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbb7b9.050a0220.aab67.0042.GAE@google.com>
Subject: Re: [syzbot] [kernel] WARNING: locking bug in try_to_wake_up
From: syzbot <syzbot+8aaf2df2ef0164ffe1fb@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
VFS: Busy inodes after unmount (use-after-free)

VFS: Busy inodes after unmount of loop0 (btrfs)
------------[ cut here ]------------
kernel BUG at fs/super.c:652!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5883 Comm: syz-executor Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:generic_shutdown_super+0x2ca/0x2d0 fs/super.c:650
Code: 1b 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 39 28 ed ff 48 8b 13 48 c7 c7 40 bd 18 8c 4c 89 e6 e8 f7 65 ab 09 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004217d10 EFLAGS: 00010246
RAX: 000000000000002f RBX: ffffffff8ee96c40 RCX: 5f1cd68d4a54fd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100dde90f0 R08: ffffffff81749d9c R09: 1ffff92000842f3c
R10: dffffc0000000000 R11: fffff52000842f3d R12: ffff88806ef48668
R13: dffffc0000000000 R14: ffffffff8c4bc158 R15: ffff88806ef48780
FS:  0000555593b76500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f019f6ff866 CR3: 000000003235e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2121
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ce297f327
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffedd46b3d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9ce297f327
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffedd46b490
RBP: 00007ffedd46b490 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffedd46c510
R13: 00007f9ce29f0134 R14: 000000000001a3f1 R15: 00007ffedd46c550
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:generic_shutdown_super+0x2ca/0x2d0 fs/super.c:650
Code: 1b 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 39 28 ed ff 48 8b 13 48 c7 c7 40 bd 18 8c 4c 89 e6 e8 f7 65 ab 09 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004217d10 EFLAGS: 00010246
RAX: 000000000000002f RBX: ffffffff8ee96c40 RCX: 5f1cd68d4a54fd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100dde90f0 R08: ffffffff81749d9c R09: 1ffff92000842f3c
R10: dffffc0000000000 R11: fffff52000842f3d R12: ffff88806ef48668
R13: dffffc0000000000 R14: ffffffff8c4bc158 R15: ffff88806ef48780
FS:  0000555593b76500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f019f6ff866 CR3: 000000003235e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b03dd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f009dd80b3799c2
dashboard link: https://syzkaller.appspot.com/bug?extid=8aaf2df2ef0164ffe1fb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a3c777980000


