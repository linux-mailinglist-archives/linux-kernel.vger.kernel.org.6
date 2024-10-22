Return-Path: <linux-kernel+bounces-375815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B39A9B27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2531D1F236E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A61D14F9F4;
	Tue, 22 Oct 2024 07:35:35 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F98126C15
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582534; cv=none; b=owMI1VHzwOh98PRxdA42e6Qdmx1uGW0ksuUR1XHGX+5oS3q6YkXq6xPdU8cLkgK5e5NcMpXIbLKLc7QHRsc5LG5Vd5oJeflbaaR9gcF9se4BpMGCfQWQ8dFYvT4od0AVQlu09rQUE8SewdYxPKAjUbOOMEN3EQ+NiF0CQlQstKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582534; c=relaxed/simple;
	bh=hnR5bUjb8W/RgOEfctotjbRKClMizc8aNaiUO0M8Ck0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CuruSWrBSufMwZdtXzkbqGtWtrAaJ0NOTy5rGKIC1wUIr72sx0YR5yyTinxzd7sz7uqDlI7Lpykg/NoqMDAFkSpl6GkYtVz0oQ/rEf96sx6jJgJFAfpuerDBDQv6DSuQcPU9baunPwCaoD6pc72yKYfPeS+9y4yiiEYr/mjPcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c24f3111so52440955ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729582529; x=1730187329;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4V+SKVnrENvEZwiILjJKLlu9ky5/HJRa8td+S1PL1rY=;
        b=qN6MGxdmiFwZbhov8aY3FNA9PayKmBC38eYKXrcr4+ZjHxe5b2jZ7xaswXjlY3um2L
         8Dljwejq67KRdL93ET9aCN18jgzmAU4DEWplsq5KzP7KTlRQPEct1/cRvhsMPO8UbFz0
         5fw19TsfNhi5oWB5aJemTQHo15HZzaMBSY6lrWyhF1bfmUp9wj3ApD3riAHihS4rMMMy
         nyuDE2xgknGjJ100JX+DLceBdz9k5Z93nrOtgOqKVHxydZBLcJFx/m7TtqeeQ3aupZ4h
         I6U1yvIZsO0Q7rBHq0T+c7KIbsaY+jR1zk8wvi9RDBWeMvhxuRXp/fYJcOx7DN/EiMIW
         T96A==
X-Forwarded-Encrypted: i=1; AJvYcCXOKxuBG0SYPURytOUZfFGZvp+PVsbAA4+8ORSvbPEL2QMZRjG9ol/TUby1VcCzUdWqXsVRNTxIcMjR2qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWOeFFf9UO1Kb7amaaCCMJEt7/BTCCzg8Arl/0/4W+KUKSgn6
	6jfLiDWpWnnFQbN0qrJxb7jiEyYv6ElPXFg53Q8t9Ysf0y77R1sA3TUQaJ/6dMmNit3LTHH/m+d
	qo3qmzj+/4/2CiHeG8S5cF/V/hgG9CYAw8KEYiAdeeymxf0VUsLiX96M=
X-Google-Smtp-Source: AGHT+IG1mCcqKMX2Yl0wJcSjApkPOC4zcwxpLrq2/g/sRH4qni7gY8XTXbtjc0uezs3EWot9FwXJwEw+nJaioAOQEzSzc4PbaG56
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3a3:4175:79d2 with SMTP id
 e9e14a558f8ab-3a4cd69ca27mr16542255ab.14.1729582529001; Tue, 22 Oct 2024
 00:35:29 -0700 (PDT)
Date: Tue, 22 Oct 2024 00:35:28 -0700
In-Reply-To: <66fa3eb3.050a0220.6bad9.0030.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671755c0.050a0220.1e4b4d.0071.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in btree_node_iter_and_journal_peek
From: syzbot <syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d8c640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=005ef9aa519f30d97657
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117f9430580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d8c640580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a00efacc2604/bzImage-c2ee9f59.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c9f863564593/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com

bucket 0:41 data type btree ptr gen 0 missing in alloc btree
while marking u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 9aa2895aefce4bdf written 24 min_key POS_MIN durability: 1 ptr: 0:41:0 gen 0, fixing
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5091 Comm: syz-executor910 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_bkey_buf_reassemble fs/bcachefs/bkey_buf.h:27 [inline]
RIP: 0010:btree_node_iter_and_journal_peek+0x260/0x1010 fs/bcachefs/btree_iter.c:886
Code: 4c 24 18 45 89 f0 50 53 41 51 e8 2b b3 00 00 48 83 c4 18 4c 89 ff e8 8f 87 00 00 48 89 c3 49 89 d7 48 c1 e8 03 48 89 44 24 18 <42> 0f b6 04 28 84 c0 4c 89 ea 0f 85 d1 0c 00 00 48 89 5c 24 38 44
RSP: 0018:ffffc9000b015fc0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000000000ff RDI: ffffc9000b016174
RBP: ffffc9000b016250 R08: ffffc9000b016173 R09: 0000000000000000
R10: ffffc9000b016160 R11: fffff52001602c2f R12: ffffc9000b0161c0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000055558e598380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c63dfb7508 CR3: 000000003f50c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btree_path_down fs/bcachefs/btree_iter.c:914 [inline]
 bch2_btree_path_traverse_one+0x1981/0x2940 fs/bcachefs/btree_iter.c:1169
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:247 [inline]
 __bch2_btree_iter_peek fs/bcachefs/btree_iter.c:2197 [inline]
 bch2_btree_iter_peek_upto+0xb58/0x70e0 fs/bcachefs/btree_iter.c:2297
 bch2_btree_iter_peek_upto_type fs/bcachefs/btree_iter.h:685 [inline]
 bch2_gc_btree fs/bcachefs/btree_gc.c:670 [inline]
 bch2_gc_btrees fs/bcachefs/btree_gc.c:729 [inline]
 bch2_check_allocations+0x1a8b/0x6e80 fs/bcachefs/btree_gc.c:1123
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:185
 bch2_run_recovery_passes+0x387/0x870 fs/bcachefs/recovery_passes.c:232
 bch2_fs_recovery+0x25cc/0x39c0 fs/bcachefs/recovery.c:862
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9107f3bbba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffede58d8a8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffede58d8c0 RCX: 00007f9107f3bbba
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007ffede58d8c0
RBP: 0000000000000004 R08: 00007ffede58d900 R09: 00000000000058d0
R10: 0000000000010000 R11: 0000000000000282 R12: 0000000000010000
R13: 00007ffede58d900 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_bkey_buf_reassemble fs/bcachefs/bkey_buf.h:27 [inline]
RIP: 0010:btree_node_iter_and_journal_peek+0x260/0x1010 fs/bcachefs/btree_iter.c:886
Code: 4c 24 18 45 89 f0 50 53 41 51 e8 2b b3 00 00 48 83 c4 18 4c 89 ff e8 8f 87 00 00 48 89 c3 49 89 d7 48 c1 e8 03 48 89 44 24 18 <42> 0f b6 04 28 84 c0 4c 89 ea 0f 85 d1 0c 00 00 48 89 5c 24 38 44
RSP: 0018:ffffc9000b015fc0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000000000ff RDI: ffffc9000b016174
RBP: ffffc9000b016250 R08: ffffc9000b016173 R09: 0000000000000000
R10: ffffc9000b016160 R11: fffff52001602c2f R12: ffffc9000b0161c0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000055558e598380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005594e96c70c8 CR3: 000000003f50c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	4c 24 18             	rex.WR and $0x18,%al
   3:	45 89 f0             	mov    %r14d,%r8d
   6:	50                   	push   %rax
   7:	53                   	push   %rbx
   8:	41 51                	push   %r9
   a:	e8 2b b3 00 00       	call   0xb33a
   f:	48 83 c4 18          	add    $0x18,%rsp
  13:	4c 89 ff             	mov    %r15,%rdi
  16:	e8 8f 87 00 00       	call   0x87aa
  1b:	48 89 c3             	mov    %rax,%rbx
  1e:	49 89 d7             	mov    %rdx,%r15
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	4c 89 ea             	mov    %r13,%rdx
  34:	0f 85 d1 0c 00 00    	jne    0xd0b
  3a:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
  3f:	44                   	rex.R


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

