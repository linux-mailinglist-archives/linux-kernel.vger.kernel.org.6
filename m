Return-Path: <linux-kernel+bounces-411128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF59CF435
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6579EB2C37A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D641D6DC5;
	Fri, 15 Nov 2024 17:58:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EC12B17C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693511; cv=none; b=oE+kVbflGUVIQFnEiBihu+Zx12n30F2tdyWF1W0wKyMXxf5dYTCR5l3/kxkh+P7w3alUGRexxfyalgND1GDCAtEyhyr+7JZ5MFeo3cKPtSEkRfGNFs1b0d8o3OVofViJPrCZ7rLe+QAlT6G9JKl7vDHC0UfR7HaPFBXfwIEQLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693511; c=relaxed/simple;
	bh=Sk+g9CEJo9TNsAy5BDfeJSONCoPtAkaQsr8tgV1ZdjI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gq/WwNx1JuUzCCo1S/yqq4g9rLSzX/OIunbX98avYTgaV2TJsjpTTy1OgdtmajQpHUoOXJ6DQU+r5ONlyKeoLPlmZrXxbxMFkJ0HpNq11bim2Jar0k4BBLdxzSXavwwPj/vWmwH2ww508K0IKmoDoR1UxDezYqkWkHCEm0JQ/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a71a9ed154so22812835ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731693509; x=1732298309;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpBG4j55OBS4CbTZkLvIGCZ3Si830F+jfWPBkn5V/XQ=;
        b=Y35SIYrqGutkAwqsZVYxpJjfsVNnEB2BpSmKqs6tqVzc9RhNvS3BFE+kSIuiN2gAvF
         mM7d2Xpzg0qfA9JeWK3cEZtjHpHNLcZ70JjHq2eA1NcNCmHba7S63CebzVMtooj2T0FF
         FrVvp+nrRfXjpslPmfQ5KssFnPtWU6AsQT+A95aU6bsJNms93kZOjIgHS3oZBRL0dJA1
         mFovfYC6W5fgIJiu2xKArU3U+4TeQ3l4VvzctD50BsCAu24UDn+uUTcxHbFvyvjw3ZH9
         0DZMsVoP0VZ3wgsUE5XvidcOdZ07Af2gsVzuzNeelX/TR3UKtzDUYTqgoT2Fyjo0ef4y
         eKjg==
X-Forwarded-Encrypted: i=1; AJvYcCXM3qrYfE1jRY/nKLlll1+n1fYhr4ltS8aMMHRZadof8FiqUcTendQAXWFD14gMaeOtHLfCWuxONrQyPWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRmiaIl9p9NnAvcdsc+VPFjK6N2IFgfcJzyLQm1bT1UrMB5+l
	Q/YApUZOQDaKbYNlSKTpk/ytTBvbqE0ZVIug8XMiObrlDpOkecYn/u/AtaCbkp4lgSOGD4Nq7bx
	jzxuNbNiQQte+eL0TfCnNNVTTjsPV5ysEL+ZreXjaeacOZJ0UzI7RLYc=
X-Google-Smtp-Source: AGHT+IH+QpNQIVcGHlqwDPdNBXlfiqr7C5/cP71RsOcQwrIxYsa84lYmKrhRvSLaz+8C2sZAk0EL1uz7GVA4/Mw5VzEdpHGl2xIh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388e:b0:3a7:1f70:ddd9 with SMTP id
 e9e14a558f8ab-3a748023285mr36393995ab.10.1731693509265; Fri, 15 Nov 2024
 09:58:29 -0800 (PST)
Date: Fri, 15 Nov 2024 09:58:29 -0800
In-Reply-To: <67218131.050a0220.4735a.0265.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67378bc5.050a0220.3bcb1c.0005.GAE@google.com>
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
From: syzbot <syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    cfaaa7d010d1 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122b6b5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=f51a2a34984e4d8888fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1293dcc0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162b6b5f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-cfaaa7d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/63eae0d3e67f/vmlinux-cfaaa7d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6495d9e4ddee/bzImage-cfaaa7d0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3d8024ecda8b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor160 Not tainted 6.12.0-rc7-syzkaller-00125-gcfaaa7d010d1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bfs_move_block fs/bfs/file.c:43 [inline]
RIP: 0010:bfs_move_blocks fs/bfs/file.c:57 [inline]
RIP: 0010:bfs_get_block+0xa75/0xb70 fs/bfs/file.c:126
Code: 00 41 8b 0f b8 77 7f ff ff 21 c1 81 c9 08 80 00 00 4c 89 ef 4c 89 f6 e8 d9 12 a0 ff 49 89 c5 48 8d 68 28 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 3c 6f 7b ff 4c 8b 75 00 48 8d 7b
RSP: 0018:ffffc9000cfd7870 EFLAGS: 00010206
RAX: 0000000000000005 RBX: ffff8880479293a0 RCX: ffff88801f8c8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000028 R08: ffffffff82236dd7 R09: 1ffffd400022314e
R10: dffffc0000000000 R11: fffff9400022314f R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000054 R15: ffff8880008cce68
FS:  0000555570718380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000043b1c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2121
 block_write_begin+0x8f/0x120 fs/buffer.c:2231
 bfs_write_begin+0x35/0xd0 fs/bfs/file.c:179
 generic_perform_write+0x344/0x6d0 mm/filemap.c:4054
 generic_file_write_iter+0xae/0x310 mm/filemap.c:4181
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1355821db9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe17b1ddc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f135586b066 RCX: 00007f1355821db9
RDX: 000000000000fecc RSI: 0000000020000100 RDI: 0000000000000008
RBP: 00007f1355895610 R08: 00007ffe17b1df98 R09: 00007ffe17b1df98
R10: 00007ffe17b1df98 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe17b1df88 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bfs_move_block fs/bfs/file.c:43 [inline]
RIP: 0010:bfs_move_blocks fs/bfs/file.c:57 [inline]
RIP: 0010:bfs_get_block+0xa75/0xb70 fs/bfs/file.c:126
Code: 00 41 8b 0f b8 77 7f ff ff 21 c1 81 c9 08 80 00 00 4c 89 ef 4c 89 f6 e8 d9 12 a0 ff 49 89 c5 48 8d 68 28 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 3c 6f 7b ff 4c 8b 75 00 48 8d 7b
RSP: 0018:ffffc9000cfd7870 EFLAGS: 00010206
RAX: 0000000000000005 RBX: ffff8880479293a0 RCX: ffff88801f8c8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000028 R08: ffffffff82236dd7 R09: 1ffffd400022314e
R10: dffffc0000000000 R11: fffff9400022314f R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000054 R15: ffff8880008cce68
FS:  0000555570718380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000043b1c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	41 8b 0f             	mov    (%r15),%ecx
   3:	b8 77 7f ff ff       	mov    $0xffff7f77,%eax
   8:	21 c1                	and    %eax,%ecx
   a:	81 c9 08 80 00 00    	or     $0x8008,%ecx
  10:	4c 89 ef             	mov    %r13,%rdi
  13:	4c 89 f6             	mov    %r14,%rsi
  16:	e8 d9 12 a0 ff       	call   0xffa012f4
  1b:	49 89 c5             	mov    %rax,%r13
  1e:	48 8d 68 28          	lea    0x28(%rax),%rbp
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 3c 6f 7b ff       	call   0xff7b6f74
  38:	4c 8b 75 00          	mov    0x0(%rbp),%r14
  3c:	48                   	rex.W
  3d:	8d                   	.byte 0x8d
  3e:	7b                   	.byte 0x7b


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

