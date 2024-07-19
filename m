Return-Path: <linux-kernel+bounces-257711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FAB937DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103B51F21B60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096E84A57;
	Fri, 19 Jul 2024 23:21:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C118F77
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721431266; cv=none; b=kgLMqV4LFCW9Hf6fBFkY/F0Qqxbl/fXcEswBJrkBMaRyCklQuKxCEgTzRwCqMREWUXzhDinVmKbkxh+PhBPxYTAPOrcERVRwWn8VX1h+CkJG6c0yMcMmsS6KS5f1OyEmJ8U3I8nksVESHHppXD5WXe3Ungok0z5NE7FfqQiV3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721431266; c=relaxed/simple;
	bh=7WYKGObzqkZtWhutlue8J3RS83P0brqbsQWJEj66H2s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JGtMaq9FJtf6eilFEy0RX8DRZmr+5OWtelOF8Xv5lROOXKkx6zYz34q+xW959wGU5flLYNZqEEK1mzCo+6LmCNZlV+iYgR2GJHqLbaPeVorII7+3oy8F//rjzijheYpgNNLEYgll6KwoLjEm4NNuJd7yh5kTkt3E6YvvPE6MiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39827d07ca7so16893455ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721431264; x=1722036064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WBwPCqKRP31uegkiKtqFU6ew4YLIJPmdt8UKkMefjc=;
        b=psVJyWvR9Kp98VTFzEcBbFyW62zd45pSZfmyaPWIdcHYTi5ERp66WRaAzPvjm1jsEF
         l+V1nBz6QEKtNZUV5mR+XJ+MJrnYdgN8e92UOxo0XxLSwMptnR9Iz2lRlbZ5I4Aogd23
         nff601GPeytNskaqZZ4iHUx3L4aXjF2bY0K0pksDoLBQRD5aZLjKUu8IZyEh9+owd70W
         TC+iHd8zv7jsrof1US4B/+vVjiwRC4rr8SS72lPHRreVSS2i/Ufez2q+oRIG40KXjqMP
         0GhGvNZb8nPanbDidB92DIa4eYItYB1VaMfrt0WdUPLQs2u+Puny2ERsU7/KG+fvbVaD
         +Jog==
X-Forwarded-Encrypted: i=1; AJvYcCVHs2A5EvDppRhAdheyvETd5NFEHBZaQbFdQ5fdn2jeUbnRCwjNEZffRdSKEiaWKXLk2FarBaBn9TTVeeKRaomsWLccfujcHMFdF4ky
X-Gm-Message-State: AOJu0Yz87bQjnnqIQtjFK2hB+d+uFHpdfYjhvM5qv64kEmcxcB0iQ8yL
	8d66k6jZKB+LQqsCw4gwBPyC9QTA6WZiUrFC+0yYxJI3viyQloALdz+sDpA7w9Jr50/7fPwdBSL
	QFhWTzXqh77ybESFKw0+wo+duK8YoiKw4ByhUsMnyQ/B7PyU4gZkezyg=
X-Google-Smtp-Source: AGHT+IGG2lbA1GBE/5P3UenJ/xUhsOOBSSuCMgwyH44qAB0Xz+nhv/8TMEfgDYR482cAPgK0yxV8tAwDwCEXxMWxdoBFqSXF/ZBc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:376:1fae:4604 with SMTP id
 e9e14a558f8ab-398e76356b1mr742355ab.4.1721431264177; Fri, 19 Jul 2024
 16:21:04 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:21:04 -0700
In-Reply-To: <20240719230827.1693-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001bf0f061da1f368@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
From: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in truncate_inode_folio

------------[ cut here ]------------
kernel BUG at mm/truncate.c:195!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3864 Comm: syz.0.15 Not tainted 6.10.0-rc7-syzkaller-00266-g4d145e3f830b-dirty #0
Hardware name: linux,dummy-virt (DT)
pstate: 21400009 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : truncate_inode_folio mm/truncate.c:195 [inline]
pc : truncate_inode_folio+0x70/0x7c mm/truncate.c:189
lr : truncate_inode_folio+0x28/0x7c mm/truncate.c:194
sp : ffff800089763970
x29: ffff800089763970 x28: 0000000000000000 x27: ffffc1ffc01a0e00
x26: 0000000000000000 x25: ffff800089763a28 x24: ffffffffffffffff
x23: ffff800089763a30 x22: 0000000000000000 x21: f7f0000007441b18
x20: f7f0000007441b10 x19: ffffc1ffc01a0e00 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000005 x7 : f7f0000007441ba8 x6 : ffff800089763950
x5 : 0000000000000000 x4 : f9f0000005f48410 x3 : f7f0000007441ba8
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000001
Call trace:
 truncate_inode_folio+0x70/0x7c mm/truncate.c:195
 shmem_undo_range+0x208/0x620 mm/shmem.c:1012
 shmem_truncate_range mm/shmem.c:1125 [inline]
 shmem_evict_inode+0x130/0x2dc mm/shmem.c:1253
 evict+0xb4/0x198 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput fs/inode.c:1767 [inline]
 iput+0x100/0x1b8 fs/inode.c:1753
 dentry_unlink_inode+0xc0/0x188 fs/dcache.c:404
 __dentry_kill+0x7c/0x1d4 fs/dcache.c:607
 dput.part.0+0x30/0xbc fs/dcache.c:849
 dput+0x4c/0x50 fs/dcache.c:860
 __fput+0x110/0x2d4 fs/file_table.c:430
 ____fput+0x10/0x1c fs/file_table.c:450
 task_work_run+0x78/0xd0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x134/0x164 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xc8/0xf8 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: b9405260 11000400 7100001f 54fffecd (d4210000) 
---[ end trace 0000000000000000 ]---


Tested on:

commit:         4d145e3f Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15ef360d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b5a15443200e31
dashboard link: https://syzkaller.appspot.com/bug?extid=ec4b7d82bb051330f15a
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d7443d980000


