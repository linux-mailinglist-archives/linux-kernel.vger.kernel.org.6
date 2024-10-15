Return-Path: <linux-kernel+bounces-366340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3272099F407
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC0528279A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00001F9EAE;
	Tue, 15 Oct 2024 17:29:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF871F9EA0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013370; cv=none; b=Nbs+4o+UOwyO/mhLpvgHD02fNYled8xXc1lFW6C2ejaXJqxfp/IxyR7KPtmlY38stNaX8keyEs4JH73BLaqcuaeCO3mGj+vd1k2o/IQlmYgW3XxDgXx5CJ9hBop1xtFS2O0at3ASeuzRi7XvTP4FF+jk4MrwqMyCGRZ69lLG5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013370; c=relaxed/simple;
	bh=q33cYYopDekDCRcZAwvDSMZNFJEflYa9wSS0/ibI0q0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uD2Px9PJ9Lnv3TkFTJSE9YkzZF45wduH+RT8z5OKk7P+yCL3mFFXdxlyAlb8spZBNvD8IyIHAKe3mKYSz9va0QsVJi3gX8eI0QcUeYu//Z+1UcLHPoejRNfMubF5tTr4GIjZGHGQR1BLOpqsk6RDInkBZbjumCUM71Wjx6JIdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c9886eccso23541195ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729013368; x=1729618168;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skFPW33VGv1s1JqEpC2/mpqw+JweLIgTbRQQYpesroQ=;
        b=fu0SBRxNysevXF9yPjQdZd5ZR0ETIwdju7OADjxbf1r4MUol0zKvjrcfrgk7E8DH62
         NFYM3QU425tvezQI6VND7g+SKoWnAZQqVqGMljmArJIuDg1f23X9H3ligu6leZg5h2SE
         ITbzqELt0kJi5ey2JZ5AiRkS/VerqAZ/nb/DFFsCZ4ahI/1MVE6mnRWGfP1ImxXjJytH
         9godNkB+auL+ZSaUTI0brFVyCF1+Aui/n04acwEI7j4apjSMAVxByizlhxwTFo4mar0p
         k8Bna4l9HpKaz8hgIJwX2tr7oN2Yt+2H/02TOQuY/yy1QpxgG5mYAo66G7npB+R8SCqZ
         MOhA==
X-Forwarded-Encrypted: i=1; AJvYcCU6BobkPrWHysbsL+rNAiIzSg6IpAZxBNpNkRIDcWbaHIkGmCFpm5FqOkjOiD6lJ6pU5w0Sbz1AKhLdnyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1R+0AUWH08eZqxErGaXzAtHg6h7Htm7BQDivrkX2L2f/rkGx
	FDaxui+yD1Arb+LaxEMM4fAIe2ZOkMWQ6SHR4wLhXboxUrLb88oyyyNSflT7uL52mVPbwPMlm+j
	wYMquiNqLkOvNYlTIl5HXHy2qt70RCtaRucokqSH1yokJbwr+BJ2TgS8=
X-Google-Smtp-Source: AGHT+IG9+q+H5kI8MCuHdsxZRYetfgqrzi3K+JVBRYt3vXfubjkncW3Sh14dcWRWG1bFGTWUs6wZmRQ/VXnxfIR0BRMrAlSC7Vsa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:3a2:4cc4:cfd with SMTP id
 e9e14a558f8ab-3a3b5faab6amr148219125ab.14.1729013368184; Tue, 15 Oct 2024
 10:29:28 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:29:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670ea678.050a0220.d5849.000b.GAE@google.com>
Subject: [syzbot] [nilfs?] WARNING in nilfs_btree_propagate (2)
From: syzbot <syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1d227fcc7222 Merge tag 'net-6.12-rc3' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1342205f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=b2b14916b77acf8626d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11692840580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ea6f07980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f64f03b05002/disk-1d227fcc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ab8ba99a1b6/vmlinux-1d227fcc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97581c221708/bzImage-1d227fcc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0cfc62de73c5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 5245 at fs/nilfs2/btree.c:2089 nilfs_btree_propagate+0xc79/0xdf0 fs/nilfs2/btree.c:2089
Modules linked in:
CPU: 0 UID: 0 PID: 5245 Comm: segctord Not tainted 6.12.0-rc2-syzkaller-00205-g1d227fcc7222 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:nilfs_btree_propagate+0xc79/0xdf0 fs/nilfs2/btree.c:2089
Code: 48 8b 44 24 08 49 8d 74 05 58 e8 12 67 ff ff 48 8b 6c 24 10 43 80 3c 27 00 0f 85 16 fe ff ff e9 19 fe ff ff e8 78 1d 20 fe 90 <0f> 0b 90 e9 ea f3 ff ff e8 6a 1d 20 fe 48 8b 1c 24 48 81 c3 d0 00
RSP: 0018:ffffc90003d873a0 EFLAGS: 00010293
RAX: ffffffff8374c988 RBX: 0000000000000000 RCX: ffff888011dada00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8c47aec8 R08: ffffffff8374bd6c R09: 1ffff1100ec15f96
R10: dffffc0000000000 R11: ffffed100ec15f97 R12: dffffc0000000000
R13: 1ffff1100ec15f9f R14: 1ffff1100ec15f96 R15: ffff8880760afcb0
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8737b0dd58 CR3: 0000000079068000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_bmap_propagate+0x75/0x120 fs/nilfs2/bmap.c:345
 nilfs_collect_file_data+0x4d/0xd0 fs/nilfs2/segment.c:587
 nilfs_segctor_apply_buffers+0x184/0x340 fs/nilfs2/segment.c:1006
 nilfs_segctor_scan_file+0x28c/0xa50 fs/nilfs2/segment.c:1045
 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1216 [inline]
 nilfs_segctor_collect fs/nilfs2/segment.c:1540 [inline]
 nilfs_segctor_do_construct+0x1c28/0x6b90 fs/nilfs2/segment.c:2115
 nilfs_segctor_construct+0x181/0x6b0 fs/nilfs2/segment.c:2479
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2587 [inline]
 nilfs_segctor_thread+0x69e/0xe80 fs/nilfs2/segment.c:2701
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

