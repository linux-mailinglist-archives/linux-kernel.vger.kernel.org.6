Return-Path: <linux-kernel+bounces-557256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A59A5D5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130171732D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305281E25EF;
	Wed, 12 Mar 2025 06:09:25 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294501DE3AF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759764; cv=none; b=V2kgQe4JdYQFB2TE8PlOs4G8BNlTAF2lwYx6tfRMmEQJ0ERxBDqBYxYMndtNPjYJw/31D2LHv/LVFSNzPgTEeSDdNhCvKpkd5aTw4PGA3h1t3652/yq5ZJ86jm71KX1LJC9I84eYEcB0v5EJLQKYX4foRH0AbbVnIkFSI4OPa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759764; c=relaxed/simple;
	bh=j3UuTTEVdawcWTa0Vkwivai05fETZmt7ecaAtna3sqY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aX5OY8xDl+tc1cmg8v/zE2SNq74IU2DSB65YPgGPDlbgItDHTW166HVY2dL7wLd9S7z+juWMF3BqH6Ivnz5qyNh9L0y1HMAcoMrm6kVqlC2IEFyX0eNVPf84lji5W4A5jOFTvq2ZpEThNH4rdiwT0FJ+5snWg6ijhlCqJVm4vig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso6482385ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741759762; x=1742364562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlAhTF+CPuoAdJyBdKNcaFIo3UaoUqHUSXygs4JlGNY=;
        b=xElydE2s9vfJ+xam1mHjIhhRavRD/gTcsGTrq8NU471L+adzz+SffwXDQGvf1ynK0i
         KFpJqm2KLEFpZrNJJMrO74sQ7UdITDfktI/qsJ6jvsbPgnv/XPQ/WxWrwJTJ9RbZfN2d
         DhGdTmK5B4pczmuO52KWMh/yflu0zsr7aifcN+wwYlNIn4UXjGokhJkw1i8HEqPotyI/
         1bqwhnOfvlO3wmwVBtGfSqBJp8x8zfQjnjOlF1f49bvtDffo2VQpkvW/NqkzQsYZo2sV
         bRXtL+Bmlnw3eS7uKdRXFi0GDhzMOP6HhkYZRRXYIKUgVdXZ6sRQB49Y5zDapITENMQb
         3wzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNyPrJO9oYjaoEJgbhlEjkLw8DeRejFV8IChx6QMXmmzbu7hQQt6lh0YaDIpRsMr1b9eRKPEm1jl9e0eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xdz0pQWWwhkpRmjwQpi6ZgGjngfnvRRjUfRlBSiTFAPBoSo+
	nO/Fx/ZxGRG/h4YXlDY9gwVHFXHjLkTEBkbkMyK3hrXiHYKS89U5lpflkjLDR/bqdwtGGoHWFaP
	45LF9vXwqIQUrMPqZVC/IuumLSUdAe97Knd1CoueaBTTZSKrMWTVrtAw=
X-Google-Smtp-Source: AGHT+IHP+t5+h0+k+9OMs8EyDKkmNW1S2EHpsqdJzpF52oqdt92JB08StTBwt52snubHmPXpfXVETq9qCGU83haWnauj7NuoePU5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148b:b0:3d4:2ea4:6b87 with SMTP id
 e9e14a558f8ab-3d4691f1f6dmr58336555ab.11.1741759762297; Tue, 11 Mar 2025
 23:09:22 -0700 (PDT)
Date: Tue, 11 Mar 2025 23:09:22 -0700
In-Reply-To: <67ceb347.050a0220.3d01d1.000c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d12512.050a0220.14e108.0024.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] general protection fault in p9_client_walk
From: syzbot <syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0fed89a961ea Merge tag 'hyperv-fixes-signed-20250311' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173fa654580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f71f17a9b92472b2
dashboard link: https://syzkaller.appspot.com/bug?extid=5b667f9a1fee4ba3775a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177b6874580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138b17a8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0fed89a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/178c4c7fb0b4/vmlinux-0fed89a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97ef169a8fde/bzImage-0fed89a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 UID: 0 PID: 5936 Comm: syz-executor316 Not tainted 6.14.0-rc6-syzkaller-00016-g0fed89a961ea #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:p9_client_walk+0x9a/0x530 net/9p/client.c:1165
Code: 28 00 00 00 48 89 84 24 88 00 00 00 31 c0 e8 3d 44 b0 f6 48 89 d8 31 f6 48 c1 e8 03 66 89 74 24 40 48 c7 44 24 50 00 00 00 00 <42> 80 3c 30 00 0f 85 3e 04 00 00 31 ff 89 ee 4c 8b 33 e8 0f 3f b0
RSP: 0018:ffffc9000380faa0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: ffff88802a9bc880 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000007 R09: fffffffffffff000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff92000701f56
FS:  000055558c345380(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f412d1932a9 CR3: 000000002107c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 clone_fid fs/9p/fid.h:23 [inline]
 v9fs_fid_xattr_set+0x119/0x2d0 fs/9p/xattr.c:121
 v9fs_set_acl+0xe6/0x150 fs/9p/acl.c:276
 v9fs_set_create_acl+0x4b/0x70 fs/9p/acl.c:306
 v9fs_vfs_mkdir_dotl+0x517/0x6e0 fs/9p/vfs_inode_dotl.c:411
 vfs_mkdir+0x57d/0x860 fs/namei.c:4313
 do_mkdirat+0x301/0x3a0 fs/namei.c:4336
 __do_sys_mkdir fs/namei.c:4356 [inline]
 __se_sys_mkdir fs/namei.c:4354 [inline]
 __x64_sys_mkdir+0xef/0x140 fs/namei.c:4354
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd26f335429
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6d918e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00004000000000c0 RCX: 00007fd26f335429
RDX: 00007fd26f335429 RSI: 0000000000000040 RDI: 00004000000000c0
RBP: 0000000000000073 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff6d919008 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:p9_client_walk+0x9a/0x530 net/9p/client.c:1165
Code: 28 00 00 00 48 89 84 24 88 00 00 00 31 c0 e8 3d 44 b0 f6 48 89 d8 31 f6 48 c1 e8 03 66 89 74 24 40 48 c7 44 24 50 00 00 00 00 <42> 80 3c 30 00 0f 85 3e 04 00 00 31 ff 89 ee 4c 8b 33 e8 0f 3f b0
RSP: 0018:ffffc9000380faa0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: ffff88802a9bc880 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000007 R09: fffffffffffff000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff92000701f56
FS:  000055558c345380(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f412d1932a9 CR3: 000000002107c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	28 00                	sub    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
   b:	00
   c:	31 c0                	xor    %eax,%eax
   e:	e8 3d 44 b0 f6       	call   0xf6b04450
  13:	48 89 d8             	mov    %rbx,%rax
  16:	31 f6                	xor    %esi,%esi
  18:	48 c1 e8 03          	shr    $0x3,%rax
  1c:	66 89 74 24 40       	mov    %si,0x40(%rsp)
  21:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
  28:	00 00
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	0f 85 3e 04 00 00    	jne    0x473
  35:	31 ff                	xor    %edi,%edi
  37:	89 ee                	mov    %ebp,%esi
  39:	4c 8b 33             	mov    (%rbx),%r14
  3c:	e8                   	.byte 0xe8
  3d:	0f 3f                	(bad)
  3f:	b0                   	.byte 0xb0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

