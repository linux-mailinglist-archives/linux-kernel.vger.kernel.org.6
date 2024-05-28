Return-Path: <linux-kernel+bounces-192582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728938D1F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2919C28587C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274AB17083A;
	Tue, 28 May 2024 14:59:33 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81F16FF26
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908372; cv=none; b=F0CFXUgtBZFqxL1PqUpmp2aa/ftRY6Wg+35nQBqZx3Er8Y3Hfow0jrcl8wmwjBPRvFvDoHEqwqFK+YlbYhb30LxUnp+hfos7l0hzapDj344eX/35XcwV4fN/aK74TRG+1zGPfR1xrY64SRKupa5OI/hukExXon6hAMkcUMfGbFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908372; c=relaxed/simple;
	bh=9fEbcK6Ji5F/hsoLdQuzaVFpQ27ana8T35CD8IKHdYU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FZpBlMUmaPdkcmkyLL3iMPmkiE68EMGhtLPNgpIHGQowEE6GVioc8Qjpjvjk2SL8h5KXYTJ9AWZnvjgahQwIpaqElXRL27jhrSGYI8MNfSYyL/Nu3e2A6o65+jba9a3MpEQNfhdQC3DCWVb8aIZH9rQIcdNS0r8sHfM8lpgVfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-373809cc942so10856705ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716908370; x=1717513170;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMsMUaD7ww793f11rGFv6mx1W6SMkIrkC4gxidkFHnY=;
        b=wGx66Yvi163DTBJC5+Q8WUOhxxyggz0L7FFqmdydmulFvdG3Js4QyQWP3zVkexkSdw
         9FcNXgk5NRwzmZgGnOsqTVbpOQ7EuzqCAz7ZiSLQqFkkUddzhKmL1IWLy/Fgr1FkMX9h
         CqVod6523ec+iAiWAUXekipgHFhGogY8wUVHcOxEI/4Kz/uPbAcY5xrJoGeKkUU3QHN4
         S2I9Jm3I9F+pzZ7kcqXqMhFKYkvi2UN7d/TPAH5+s4iUCgcx5c/KknkNtf8PXl8Cuui+
         dXIudNdoaASecYMr28C+Otwmm/22jvNVgPLyPhIoOzVNEj5a09Mc3WhNTcAqI8XFSL94
         oMfg==
X-Forwarded-Encrypted: i=1; AJvYcCUq+IuLbB9Tx8+iVwxCWRFCxlWZx0NuNMDTFUZstlVVQ8fZH4d7+NRk5F7ejK/q3KYXJpEI2aK8papoxWoZYKWMa5tjgKPrjUCsTeUE
X-Gm-Message-State: AOJu0YyOKg32jdyCWBDCTv7CEB9xYDzx0eErdoqsGrsWTCoz39o7c1Z3
	F8IOo7gTk8+322/o/KC1oAO2h+B2uUNGlnkPYHblCoEeK8q+m7grn7NQADUOuk6FTqRNPL8KMfn
	yRIEMuXlRTZWnYVBllVj2GFtYlt+SaGy17uMM6GGIf84YnsDnC74US3Y=
X-Google-Smtp-Source: AGHT+IGNaRyDRbzL6cLWekgvrOX2suNA4KhlAx38P9MDOZUiJPMFeXQzg+ndOlxXuLRqSSVwi/NldVGTNvP7FzmomBkQJB5FDMv6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a42:b0:374:5315:95de with SMTP id
 e9e14a558f8ab-3745315971bmr5140735ab.6.1716908370275; Tue, 28 May 2024
 07:59:30 -0700 (PDT)
Date: Tue, 28 May 2024 07:59:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085bb82061984e155@google.com>
Subject: [syzbot] [kvm?] WARNING in __kvm_gpc_refresh (2)
From: syzbot <syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2bfcfd584ff5 Merge tag 'pmdomain-v6.10-rc1' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=177b913a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=fd555292a1da3180fc82
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f436ec980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c7463a980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b18ff1cae231/disk-2bfcfd58.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/53ed72a5c174/vmlinux-2bfcfd58.xz
kernel image: https://storage.googleapis.com/syzbot-assets/230e68bda335/bzImage-2bfcfd58.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5090 at arch/x86/kvm/../../../virt/kvm/pfncache.c:259 __kvm_gpc_refresh+0xf17/0x1090 arch/x86/kvm/../../../virt/kvm/pfncache.c:259
Modules linked in:
CPU: 0 PID: 5090 Comm: syz-executor403 Not tainted 6.10.0-rc1-syzkaller-00013-g2bfcfd584ff5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__kvm_gpc_refresh+0xf17/0x1090 arch/x86/kvm/../../../virt/kvm/pfncache.c:259
Code: c6 05 82 51 8a 0e 01 48 c7 c7 40 e6 c1 8b be 03 04 00 00 48 c7 c2 80 e6 c1 8b e8 04 72 65 00 e9 cd f3 ff ff e8 9a d2 88 00 90 <0f> 0b 90 41 bf ea ff ff ff e9 c2 fe ff ff e8 86 d2 88 00 90 0f 0b
RSP: 0018:ffffc90003e57430 EFLAGS: 00010293
RAX: ffffffff810d43e6 RBX: ffffffffffffff01 RCX: ffff888078a31e00
RDX: 0000000000000000 RSI: fffffffe00000000 RDI: ffff887fffffffff
RBP: ffff88807e301148 R08: ffffffff810d351f R09: 1ffffffff25f50c9
R10: dffffc0000000000 R11: fffffbfff25f50ca R12: fffffffe00000000
R13: ffff88807e3010d0 R14: ffff88807e3010d0 R15: ffff887fffffffff
FS:  00005555630c7380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffce7710df0 CR3: 000000001f254000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __kvm_gpc_activate+0xdc/0x400 arch/x86/kvm/../../../virt/kvm/pfncache.c:416
 kvm_xen_vcpu_set_attr+0x1c1/0x11c0 arch/x86/kvm/xen.c:890
 kvm_arch_vcpu_ioctl+0x16b7/0x2cd0 arch/x86/kvm/x86.c:6280
 kvm_vcpu_ioctl+0x6e0/0xd00 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4578
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f628f30b6e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff93337768 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff93337770 RCX: 00007f628f30b6e9
RDX: 0000000020000040 RSI: 000000004048aecb RDI: 000000000000000d
RBP: 00007f628f37e610 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 65732f636f72702f R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff933379a8 R14: 0000000000000001 R15: 0000000000000001
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

