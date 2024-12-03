Return-Path: <linux-kernel+bounces-429706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A59E20D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE996169312
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1FC1F75B3;
	Tue,  3 Dec 2024 15:01:33 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4C1F7576
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238092; cv=none; b=KrbmM2Xabttf/6d872uPT4k7hKdtW5uzosaIRowx0jHXiWjgytD1uIRuUrX9UP88sHHxgsGop4RS1rdN8nQPJWe5y6oGsRzjapawmtQY5zPrbg5HM+2dJEa6JAlcuC7730K5bxIcwXP0ZQD0KpHOHGaJAovKNLLhqajIyPk+eXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238092; c=relaxed/simple;
	bh=epfXPtQQGV/4eFzs7XpCiT2I2Fk+Ddf8QWi9zuNcTjE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GW//2dEBwltZ1Kjls+83NcNfDTVUuA/oqMalnTK0QYrzTMfGl16Gza4hTcmCraqJQI+R6/yP5UjDrvuyDOc46H4YgdM34zqHgUJvYRIOiJUz3hNmIVZyl/8BHUB7u5YcXaeofJ/XKPSDWPaMjKIvdVsdT+/aR3TXGRbxwXFtUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-84188ac27bdso503805539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238090; x=1733842890;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htusEmkyDY/hbdcduVlcNhrCjMOkDBfuFuzKEt3oxJ0=;
        b=LgDa+Xn14PFk+qLcORGeLTMVNqhvoHRB7vlSFl4jx79JTWOWxk/Wjtwk/ZLJEDp+b3
         f4b68zMGiIGgdQRc+eojT/MM3IUKP7BcL1uEAecBRh9IZiJa6IHkDows1S9qvEP6KuIs
         vctz+xaLvH1Egj65128ge/zV4vnIN6oUH3dBCe7GuMLiB2lJ3WlLPPPvZmzRmNXJDPYD
         MXfpJ+KBHAu49g/D9EMHnAwT4T0fZttYVCbeKCnhmdwdawdotS3zZD0l0M9COJjbhuFk
         HhkeBx0gIGUyidOh486mmDPbrrpa28eZep1NH1KqNk0xT1T8EnthE48J/UnI4gSdjHbQ
         jM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwnTSGhKT3ujwc7dF1IKTLS6sjqwLtsJ2r2IRInXBO3vRonOsvdY4TQxTPWVjNeczwtVHxYa/r31DWbrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1xYHvgWtneFIx40ykXNyq0IETteyE3AMWUYdl+QKurOzyaRw
	gj2Ew24mSwq+aOlVEfjV5A0X8eFz/HfeYk24YUNO3oKfGXo4na98FsROTvTrndtYzjfbrwnGO2F
	ty55nigLVFspOXlqfkUta236qYDZaQjiI3ovFXf591zQ94jfIbypE6TY=
X-Google-Smtp-Source: AGHT+IEbjGX4zYdW+eNsISIwwcOpV6m4rCfsdUDuP40rWLKfNrY/QCJxUommigDOdl5Hxs2Y7WIN81pSYj8Q7Uiy77OOs2aChOdb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:3a7:e8df:3fde with SMTP id
 e9e14a558f8ab-3a7f9a46252mr27511935ab.9.1733238089926; Tue, 03 Dec 2024
 07:01:29 -0800 (PST)
Date: Tue, 03 Dec 2024 07:01:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f1d49.050a0220.48a03.003b.GAE@google.com>
Subject: [syzbot] [f2fs?] KMSAN: uninit-value in f2fs_new_node_page
From: syzbot <syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0e287d31b62b Merge tag 'rtc-6.13' of git://git.kernel.org/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=117ddf78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b131ba4658863ffa
dashboard link: https://syzkaller.appspot.com/bug?extid=5141f6db57a2f7614352
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145a65e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157ddf78580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/19a3d9ed3459/disk-0e287d31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3473a586f547/vmlinux-0e287d31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bfd02e5a5157/bzImage-0e287d31.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f9968897b785/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=1, run fsck to fix.
F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=2, run fsck to fix.
=====================================================
BUG: KMSAN: uninit-value in f2fs_new_node_page+0x14c5/0x1690 fs/f2fs/node.c:1341
 f2fs_new_node_page+0x14c5/0x1690 fs/f2fs/node.c:1341
 f2fs_new_inode_page+0xb6/0x100 fs/f2fs/node.c:1311
 f2fs_init_inode_metadata+0x18b/0x1e40 fs/f2fs/dir.c:501
 f2fs_add_inline_entry+0x5f5/0xbe0 fs/f2fs/inline.c:665
 f2fs_add_dentry fs/f2fs/dir.c:742 [inline]
 f2fs_do_add_link+0x4b0/0xad0 fs/f2fs/dir.c:785
 f2fs_add_link fs/f2fs/f2fs.h:3628 [inline]
 f2fs_symlink+0x6d5/0xf80 fs/f2fs/namei.c:641
 vfs_symlink+0x1ed/0x460 fs/namei.c:4669
 do_symlinkat+0x253/0x8b0 fs/namei.c:4695
 __do_sys_symlink fs/namei.c:4716 [inline]
 __se_sys_symlink fs/namei.c:4714 [inline]
 __x64_sys_symlink+0xe0/0x140 fs/namei.c:4714
 x64_sys_call+0x31ca/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:89
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable new_ni created at:
 f2fs_new_node_page+0xa4/0x1690 fs/f2fs/node.c:1317
 f2fs_new_inode_page+0xb6/0x100 fs/f2fs/node.c:1311

CPU: 0 UID: 0 PID: 5782 Comm: syz-executor986 Not tainted 6.12.0-syzkaller-11930-g0e287d31b62b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

