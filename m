Return-Path: <linux-kernel+bounces-314364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958FB96B24E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA92F1C20A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F413B2A4;
	Wed,  4 Sep 2024 07:04:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021A1EC01C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433445; cv=none; b=bpXfqL9QZpsDYIfxE3ma29Qneiuz0EsVoZH7FlFsjipf97utKojMy2g2ud/CX2Xrl+kxs+rz2gOB8+yFvABNExXHGh/41bXm0pucJ1ovjTl7zALXkKiqXeSnAed9X2lT8JbkzYvqhwwoFj4V84KrVdkn4a1ShV2ubaeCgSAuyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433445; c=relaxed/simple;
	bh=i3+Hf1ab/g+31CTHiFkSxmRlt36SammWuwiumwNX3OQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nAZoicLrnURH3hW7HEZWiXxDEhHY8ShvGXvHASUjp/52VIc1F57WEyKID3uaZbkxh4xmhYrRQVSD2VlglU5azyXk7znfMUhocXD4U/AWmSCZ1+q/e+yQtU3asQpvKgzCh1okyousSrtV6CHn1se4th7MkJncrWvU1R/dsAZQ6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a321567d4so520332939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725433443; x=1726038243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecSvyV5tZ6GP6zSVIFI8UpENf3GOc6t1nuzW2gOeIkQ=;
        b=YFj4TG2nshZjvvRP1drb4RnSzwv/Pql8suLkwZmAFmtS5jKXSu2It+6VZ+64kf8JCK
         Qn2Y3dYe9cyZTN641DfREI1LfBpvrM+523clNqfxzsopV2/DlAeQe8ldie4q2MsIvuh8
         I0LFrv1PfMHwtHUKYzOSoJjrBfRY0dmNBTWOrBOjknigPt18Qzk6ca+Mjs233O89eMnw
         lpS4mckcZ14Y368itlqFSGppuWPDaiHFSHj2ogg6960ji8udJtA5zM7aEdwSyBYM2M/u
         u0ZpL/hKiAM0q5iNqdxwO3HDXArSEC/QmMpHRGjuw7puZTmdQz/5Q4IB9saKhL4s7KGd
         An1g==
X-Forwarded-Encrypted: i=1; AJvYcCWR6Guim16z8u9IOcqWh1KryTnBfPvEFcyb13EY51Uc71EbX8uU2rHvhAIsPme1YXIq51FRHcCsmVHbLHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyJNP/jJ//ABhOoWXH/6dg8U7199ppLBoV+HkJDJ/5UN//xvZ
	nSzbWupUvNSzVyxcqityQjer2FB04pgtFhmf73BJDFaIB9qzTXIIHfmsnkukEMpQtPNB9muSOoq
	UfcLWbBdfG0z3Fn2tzdU+gZ/j2IkivXlMDSS2VYPJoA9fz0zxZf6JXHg=
X-Google-Smtp-Source: AGHT+IH1Z06igPV7QXz7rOHaiCvWHz7pxAms/IIiNM9fGg0u3r0rzP9MAvDeryFoRqbGny3c/AAGTAyolrfQf5fl0W3B9z5/QI9K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3409:b0:82a:3236:9d22 with SMTP id
 ca18e2360f4ac-82a32369dbfmr44792439f.4.1725433443077; Wed, 04 Sep 2024
 00:04:03 -0700 (PDT)
Date: Wed, 04 Sep 2024 00:04:03 -0700
In-Reply-To: <66d79038.170a0220.22e970.97fd@mx.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000756497062145c7a0@google.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
From: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
To: andrew.kanner@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in __lookup_slow

loop0: detected capacity change from 0 to 64
overlayfs: fs on './file0' does not support file handles, falling back to index=off,nfs_export=off.
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 800000001f849067 P4D 800000001f849067 PUD 1fabf067 PMD 0 
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6157 Comm: syz.0.15 Not tainted 6.11.0-rc5-syzkaller-00017-g7d6899fb69d2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000492f558 EFLAGS: 00010246
RAX: 1ffffffff17f1868 RBX: ffffffff8bf8c340 RCX: ffff888024845a00
RDX: 0000000000000000 RSI: ffff8880699ead38 RDI: ffff888069bac018
RBP: ffffc9000492f670 R08: ffffffff820c2f53 R09: 1ffffffff29ad1f5
R10: dffffc0000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880699ead38 R14: 1ffff1100d33d5a7 R15: 1ffff92000925eb0
FS:  00007f735e4b46c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000078faa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1718
 lookup_slow fs/namei.c:1735 [inline]
 lookup_one_unlocked+0x1a4/0x290 fs/namei.c:2898
 ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
 ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
 ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
 ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1633
 filename_create+0x297/0x540 fs/namei.c:3980
 do_mknodat+0x18b/0x5b0 fs/namei.c:4125
 __do_sys_mknod fs/namei.c:4171 [inline]
 __se_sys_mknod fs/namei.c:4169 [inline]
 __x64_sys_mknod+0x8c/0xa0 fs/namei.c:4169
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f735d779ef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f735e4b4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000085
RAX: ffffffffffffffda RBX: 00007f735d915f80 RCX: 00007f735d779ef9
RDX: 0000000000000700 RSI: 0000000000002000 RDI: 0000000020000140
RBP: 00007f735d7e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f735d915f80 R15: 00007ffd8cecbb18
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000492f558 EFLAGS: 00010246
RAX: 1ffffffff17f1868 RBX: ffffffff8bf8c340 RCX: ffff888024845a00
RDX: 0000000000000000 RSI: ffff8880699ead38 RDI: ffff888069bac018
RBP: ffffc9000492f670 R08: ffffffff820c2f53 R09: 1ffffffff29ad1f5
R10: dffffc0000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880699ead38 R14: 1ffff1100d33d5a7 R15: 1ffff92000925eb0
FS:  00007f735e4b46c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000078faa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         7d6899fb ovl: fsync after metadata copy-up
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git overlayfs-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1272d5b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
dashboard link: https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

