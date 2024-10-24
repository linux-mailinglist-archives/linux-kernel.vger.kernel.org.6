Return-Path: <linux-kernel+bounces-379272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08129ADC46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E411C21B18
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA618991B;
	Thu, 24 Oct 2024 06:36:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F117DFFA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751790; cv=none; b=W7nguhm0VGfZXzJR6MyI1IR8nT5Vha7Snybnfo7i/33AMMuX1fUdE1Rr4FSs4a8XadOpXWzaeTEYkIQ3lEc8VewcLcAX6g1v2RSDuzcNG54qS1Jd/PL/Yq5FpIU6RxTeK6wDLAFMw0L8twnbdF3bbvnNn9HhOOBPOma0C8K9n28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751790; c=relaxed/simple;
	bh=Z+kQskhQUG3wtC+RM563hz1nlxHhGyzSvq0LRD/hnKg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iNTdG5vLRyTYUErMiwv162dcQ/TBapd5hECJmQpHg/h76y0XsLOMrCa1Nb04n0qmSgJ3hxbogX/zIBj0eOhGShsGRwUcpwppsNbvSUBTZVBipyVhN9L94ZPDlxY2DOnx0wfz8IPjtsF7Nmj6haCnYWVFag2WZOssDHY1LnEu7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so5996635ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729751787; x=1730356587;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBsGN+TMCF/UMd7AdIfuXXu+2wHhpd7MAgqk7tyFpoU=;
        b=nuzPgDdMingAQZ0DrJOmMeh8HqmAok+X1KGxwEIIvzFwNgqUGbygFDSICmIIhkJxRn
         SSbW7EkQF1uUu1koopLy1ffvccjnTLzPj4tL9G19lY24qKSrUtfF3Bm3YJEuKg9mMtY4
         /TOXGSUqO7Gsa5H8P/G2TRfCX3tsbkbTjOGVCGWxgluvX9mmZjkXOgCjp16UVL3bxihE
         fbz5sbguOJkx8bF8AKd33CO112FDAuCS/gXokPxwp0ldeVUPkivbrnvT2IdoDBZQQSbM
         W8xCOwF31/HIbuwCzskJ4ot7mOkES907X8n4JO80yRwxDdgYSnFJ9BcScwUeOXBgdpyz
         v/nw==
X-Forwarded-Encrypted: i=1; AJvYcCWGx8+sG4rgnOx5JwB1FsVHFDtP0/d3+BXkK+NdX+zZ+BbtbxDvYafIUo6bQavgIaCAIWzdJf/JO0kIDJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7LknMZdKZP8TRZiKSvPtkkcXENFiZUxlkwUUV0295FB6Qkl3f
	apMoYEn5btI837qhKtZai7xvp3X/KT3z0IOwWKb9rkUY2SZrjmTYqqjePBXs6SluycsxNzjbPdb
	D47Cc7utsnvdVgN7V3MvwBWGDwxMD/zfHCL8OuBoyRHuOtCGzPGXiix8=
X-Google-Smtp-Source: AGHT+IHURXw3k60tLjdegVSEJcFlXF1vQdAy1OKUWGLXjQQflUVgcuW7yMgjZtEPCaa4T5IXH49U6aVsK3WFmSpAinoxI7Aw/p0s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a02:b0:3a4:d21d:111f with SMTP id
 e9e14a558f8ab-3a4d582128cmr59328815ab.0.1729751787359; Wed, 23 Oct 2024
 23:36:27 -0700 (PDT)
Date: Wed, 23 Oct 2024 23:36:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6719eaeb.050a0220.1e4b4d.00a0.GAE@google.com>
Subject: [syzbot] [kvm?] WARNING in kvm_put_kvm (2)
From: syzbot <syzbot+4f8d3ac3727ffc0ecd8a@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1397b240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=4f8d3ac3727ffc0ecd8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c85347a66a1c/vmlinux-15e7d45e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/648cf8e59c13/bzImage-15e7d45e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f8d3ac3727ffc0ecd8a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5483 at kernel/rcu/srcutree.c:656 cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:656
Modules linked in:
CPU: 0 UID: 0 PID: 5483 Comm: syz.3.30 Not tainted 6.12.0-rc3-next-20241016-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:656
Code: 74 84 00 48 c7 03 00 00 00 00 48 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 0f 0b 90 eb e7 90 0f 0b 90 eb e1 90 <0f> 0b 90 eb db 90 0f 0b 90 eb 0a 90 0f 0b 90 eb 04 90 0f 0b 90 48
RSP: 0018:ffffc900041ffc50 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88807b56f980 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffd70298
RBP: 0000000000000001 R08: ffffe8ffffd7029f R09: 1ffffd1ffffae053
R10: dffffc0000000000 R11: fffff91ffffae054 R12: dffffc0000000000
R13: ffffc900049ca8b8 R14: ffffc900049c1a70 R15: ffff88807b56f800
FS:  0000555574edd500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3fd02e CR3: 000000007f93e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvm_destroy_vm virt/kvm/kvm_main.c:1357 [inline]
 kvm_put_kvm+0xf25/0x1350 virt/kvm/kvm_main.c:1386
 kvm_vm_release+0x43/0x50 virt/kvm/kvm_main.c:1409
 __fput+0x23c/0xa50 fs/file_table.c:434
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fba34b7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc914498d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fba34d37a80 RCX: 00007fba34b7dff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fba34d37a80 R08: 0000000000000006 R09: 00007ffc91449bcf
R10: 00000000003ffd50 R11: 0000000000000246 R12: 0000000000011abb
R13: 00007ffc914499e0 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>


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

