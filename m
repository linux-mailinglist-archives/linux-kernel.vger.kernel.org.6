Return-Path: <linux-kernel+bounces-334445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5662697D764
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADAC286627
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC50156F2B;
	Fri, 20 Sep 2024 15:21:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62CC13B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726845685; cv=none; b=hPtbk3A/uXOpYn86To35qq4sViVm5dwlRa1rQKJoLLMw8aIpSzfS6mN0oRDZlwRGz9sbQKGG4wRvWbyxt94Vr1MnN2teNIhItfPJZaJk6mlpFDWQaD+RA69rG0VK+ZEvlRHCIdVu0HAMkZBKL7n3f7Bvg/nxbCezqEmcwiURTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726845685; c=relaxed/simple;
	bh=ZKN/Jx0Cgg3E49vF+Ha0Y1UmXQXpo/qvF2nu4rNnzQo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PdHNj6Ck9VXPwQ1I5PtKiMP184xVCXmef8xahA/pB7vimcx2rdHCaQUCyhOfJOHICNyFJWWsVJXoiYsBIg6nH/KwKYX0Ap8crw1rXNKluhqDPpea9VG/v27K4v2JNcM0sNR3h8PNGE0NEm9x9uQGONVSCt/c4uDnwKs53GrHNbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a09da3baa8so29066105ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726845683; x=1727450483;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fr78q/KfWsNOxKd5MbJvZ/ms4Nh44n0ECdqoTNwBoQ0=;
        b=lzuNPi2q2o5BMFVIUMMKhAHm3BAwDt/N7/ypSZQaJXCf8hWdYPJiXGGjjiOo2HqhGL
         Y/QqzLDEQZyXJ72YVY56KaWiEt41MpTh8cjnaaQ7L35cgRVrnqx4oW0/51nNncOSUzan
         BDl3CbEQ3TJpFCPU1Huy4QkBkWY70T6nIL4RAd6z0yubNyA4sK7jeUad5Y4LaNFvyR2A
         32dKPdf3EYo1OjaHy17Aknr+bjV/Pdegh74y3HniLHZbl4YMFu+H315scUPZ2+ho8zEw
         DEEuxnZj5EmgquDp//ggoaXZ5OfXqY1Rb30+/eVYq42boiXcrgBVTEcCU/ADvxP6JOsE
         yctg==
X-Forwarded-Encrypted: i=1; AJvYcCXbYPvWcdmCYrNVzzUFHuP5lX6VKEqXQG3XtS3aHa1TNGLgiPIroDqb4Lba3jPHRW7uJvXVravJSsCAGdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjBsBu2YCRYgns+iu25AdB+hBd6IXxP/nHnBd39C2OBltBxb+s
	gtXtPpS00+jx9jTo7/MIqb9buXQPhMuMO+ULD/OcLGTpVMGo4DB/9jhYL6udhyBcEHdQv3Vit/l
	/iyx/sB8g+8yT6RqhidLsafAPVhOBMmMM6slWn29i/G5UWb66QINatUg=
X-Google-Smtp-Source: AGHT+IFJ7PooyB6Fp2shSustKNFxH99VCZua4ONb9rvwq7nmc5I2bzlN/pp+wfJk9EL3oWivxGfTtqa9mhtGxXQ6zuroZ2O3MP+i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3a0:a057:6908 with SMTP id
 e9e14a558f8ab-3a0c8a225edmr25801565ab.11.1726845682764; Fri, 20 Sep 2024
 08:21:22 -0700 (PDT)
Date: Fri, 20 Sep 2024 08:21:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed92f2.050a0220.29194.005a.GAE@google.com>
Subject: [syzbot] [ocfs2?] KMSAN: uninit-value in from_kuid (2)
From: syzbot <syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2004cef11ea0 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1737fb00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea86c03799707382
dashboard link: https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ad1607980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b7fb00580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/712bb1e6270f/disk-2004cef1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c85f46e8c8b/vmlinux-2004cef1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e811c6cc65b/bzImage-2004cef1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2a5b0a53fa65/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com

ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
=====================================================
BUG: KMSAN: uninit-value in map_id_up_base kernel/user_namespace.c:355 [inline]
BUG: KMSAN: uninit-value in map_id_up kernel/user_namespace.c:385 [inline]
BUG: KMSAN: uninit-value in from_kuid+0x41e/0x990 kernel/user_namespace.c:433
 map_id_up_base kernel/user_namespace.c:355 [inline]
 map_id_up kernel/user_namespace.c:385 [inline]
 from_kuid+0x41e/0x990 kernel/user_namespace.c:433
 ocfs2_setattr+0x254/0x3140 fs/ocfs2/file.c:1133
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate fs/open.c:65 [inline]
 do_ftruncate+0x8c1/0xbf0 fs/open.c:181
 do_sys_ftruncate fs/open.c:199 [inline]
 __do_sys_ftruncate fs/open.c:207 [inline]
 __se_sys_ftruncate fs/open.c:205 [inline]
 __x64_sys_ftruncate+0x133/0x280 fs/open.c:205
 x64_sys_call+0x9e4/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:78
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable newattrs.i created at:
 do_truncate fs/open.c:43 [inline]
 do_ftruncate+0x600/0xbf0 fs/open.c:181
 do_sys_ftruncate fs/open.c:199 [inline]
 __do_sys_ftruncate fs/open.c:207 [inline]
 __se_sys_ftruncate fs/open.c:205 [inline]
 __x64_sys_ftruncate+0x133/0x280 fs/open.c:205

CPU: 0 UID: 0 PID: 5177 Comm: syz-executor217 Not tainted 6.11.0-syzkaller-07337-g2004cef11ea0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

