Return-Path: <linux-kernel+bounces-349921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E032F98FD5D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EA11C215A6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A484D3E;
	Fri,  4 Oct 2024 06:32:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05634437F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728023545; cv=none; b=i38hPlEliBl9bRTeC4zS/llpZxR+PaDgRWIp3dHgwFuEfgFfFKC9igVWgSnNPPfH3dwLORliLXDqz3oKex3gbMH2p8PHFtQhWefF/tlw4QkCSVw7F8cfb6uBHiOXVQfwm1L1+k8XtS+ejXY+zPPZRUpe17mJWMw+5o0vWj0Iyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728023545; c=relaxed/simple;
	bh=5yECEdZDdJxBQ3pZ99Sx/sae70L+V6BuCkBrNXJAVqk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Lpm+4dpJmWBzwghJxxWx3qmLiTjYDACHrhD1CbtmFn08dtjAgHEidtd4xQq99sSk3XjhrtxEgZJI95rXd3pij+XL2wEh/UGL6NxTkdMdlTq+V/K+fkljxuzCmcwwOlMeeWOcLvVWvs57IghzWBPW4jnKdrptNvGPpAtHHtCtAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3481b26d6so21419125ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 23:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728023543; x=1728628343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1R67B8WDUS0bnDbu/tkHPHS5hy4aySnARn7yS1n9m1I=;
        b=GL6w0kqqVcoe9QpUJzo0dQFMO0IGJwScDbfZMOIuWkzqRBeiIDLHxSysBajNn6sefc
         3pbkk2XHioy5tY94a+8IOI638YtGPqozRZHJ74qWYpBfYX8JL9CGwW4qQBNZea1/MA8E
         apE2+ay6UIpmGunUvvOPiKyNDXIUrZJ8lzaO/CSL7UHEq0P5OWEws8YRDOArhjnd+dXu
         3R3H+5gBHSx83J8MDN1anQQLK0loJL3LlKKs3J5dXCCw244G82cMAWdkfaqxRCj/oab9
         1F+01nNL80YgBjf24u36tblUHlX/AK5OP+IJtibBFdTpO95tgz035rJReTQZXUwx/7MS
         OX5w==
X-Gm-Message-State: AOJu0YwHi5+ZeAXsYiCPSO+HdDn1KbvFTIqAkoo0qH0inYgskdJCoeJe
	uC5q+o+Kj32lYu95ZQVgGnH0U7BQhIp1FjZaMyDDqQdHox2aiHDK5yJMv7IiCspsB04NKQUdJHM
	UCgwk64fS0pzaZlaiHCXTHvVcKsjOEQlfXx94UUeqISvV29sC5JsYMSI=
X-Google-Smtp-Source: AGHT+IGD3bHaBSJx2xqv4tRVY8RKS+3PtuEM+Dul7/0amtPWqr3ul39K7VmhS9OtmFjDxdwd/AApQd2uX9hmXIllX/1AKqVtxjGD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4aa:b0:3a1:a243:c7a7 with SMTP id
 e9e14a558f8ab-3a375978e65mr15692875ab.2.1728023542793; Thu, 03 Oct 2024
 23:32:22 -0700 (PDT)
Date: Thu, 03 Oct 2024 23:32:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ff8bf6.050a0220.49194.0453.GAE@google.com>
Subject: [syzbot] [kernel?] KFENCE: memory corruption in add_sysfs_param
From: syzbot <syzbot+873cb3989e92ad5d796d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ac0d80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=873cb3989e92ad5d796d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/641e642c9432/disk-c02d24a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98aaf20c29e0/vmlinux-c02d24a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c23099f2d86b/bzImage-c02d24a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+873cb3989e92ad5d796d@syzkaller.appspotmail.com

can: broadcast manager protocol
can: netlink gateway - max_hops=1
can: SAE J1939
can: isotp protocol (max_pdu_size 8300)
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
Bluetooth: HIDP socket layer initialized
NET: Registered PF_RXRPC protocol family
Key type rxrpc registered
Key type rxrpc_s registered
NET: Registered PF_KCM protocol family
lec:lane_module_init: lec.c: initialized
mpoa:atm_mpoa_init: mpc.c: initialized
l2tp_core: L2TP core driver, V2.0
l2tp_ppp: PPPoL2TP kernel driver, V2.0
l2tp_ip: L2TP IP encapsulation support (L2TPv3)
l2tp_netlink: L2TP netlink interface
l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
NET: Registered PF_PHONET protocol family
8021q: 802.1Q VLAN Support v1.8
DCCP: Activated CCID 2 (TCP-like)
DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
DCCP is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
sctp: Hash tables configured (bind 32/56)
NET: Registered PF_RDS protocol family
Registered RDS/infiniband transport
Registered RDS/tcp transport
tipc: Activated (version 2.0.0)
NET: Registered PF_TIPC protocol family
tipc: Started in single node mode
NET: Registered PF_SMC protocol family
9pnet: Installing 9P2000 support
NET: Registered PF_CAIF protocol family
NET: Registered PF_IEEE802154 protocol family
Key type dns_resolver registered
Key type ceph registered
libceph: loaded (mon/osd proto 15/24)
batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibility version 15) loaded
openvswitch: Open vSwitch switching datapath
NET: Registered PF_VSOCK protocol family
mpls_gso: MPLS GSO support
IPI shorthand broadcast: enabled
AES CTR mode by8 optimization enabled
==================================================================
BUG: KFENCE: memory corruption in krealloc_noprof+0x160/0x2e0

Corrupted memory at 0xffff88823be6c088 [ 0x08 0x46 0x11 0x30 0x80 0x88 0xff 0xff 0x60 0x46 0x11 0x30 0x80 0x88 0xff 0xff ] (in kfence-#53):
 krealloc_noprof+0x160/0x2e0
 add_sysfs_param+0x137/0x7f0 kernel/params.c:663
 kernel_add_sysfs_param+0xb4/0x130 kernel/params.c:817
 param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
 param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
 do_one_initcall+0x248/0x880 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

kfence-#53: 0xffff88823be6c000-0xffff88823be6c087, size=136, cache=kmalloc-192

allocated by task 1 on cpu 1 at 10.052565s (0.009153s ago):
 __do_krealloc mm/slub.c:4784 [inline]
 krealloc_noprof+0xd6/0x2e0 mm/slub.c:4838
 add_sysfs_param+0x137/0x7f0 kernel/params.c:663
 kernel_add_sysfs_param+0xb4/0x130 kernel/params.c:817
 param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
 param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
 do_one_initcall+0x248/0x880 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

freed by task 1 on cpu 1 at 10.059120s (0.002598s ago):
 krealloc_noprof+0x160/0x2e0
 add_sysfs_param+0x137/0x7f0 kernel/params.c:663
 kernel_add_sysfs_param+0xb4/0x130 kernel/params.c:817
 param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
 param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
 do_one_initcall+0x248/0x880 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================


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

