Return-Path: <linux-kernel+bounces-211990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8A39059BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9101F2145F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87243181D0E;
	Wed, 12 Jun 2024 17:18:24 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0517E90B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212703; cv=none; b=M5t/tGy22qrNRlBctQiDYYJrQ7yJb7yvr+TIt0O0cL4/S05AqDGQ2zeBFnyzrVGBZZZkqx0XaB/hmCAqBValCxiJbXec/5USFm3XZ8wanPyVOgYCS0i0BMBh7fAJscLM1qDtc/44N3TiMRciyayI9hWwJl+x7HEWz47dEpKn+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212703; c=relaxed/simple;
	bh=Sq1psVMjIrxMRUXO4i2VqGZZu1i5PES+5UP+m7xAHHs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NhX46s1MP96wwVI2oaOlJoP5JdZSj2G8Za0ICQCC99TIk+EOc0woHmy/sTwfpFy0q/jFMcp6pcyIuEpkQGgwJNvX7fp2zFQG0Cc5H5gNPw2m4DB+jR4o/GEYfOKVHykLwK2OYReU22ffTVDB7ZZru5LCN0HdiJ2DVzsXoGEyg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-37586a82295so444595ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718212701; x=1718817501;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Wm5Y4VMxUk5RR3ELuQXPAkBPSR2A0FumYvOfuADlfg=;
        b=IwTkL/amM4je4rZkCwdjmUmr3h5s4XCkUMd4himJ9zJpSMKbYxwnO5KkttBf2nHaIB
         wdJWP8rt7Ynp4GI4E3c/unehCs7cXKxlUkMu6j+v0tlD5fxj0VSI8u3iw/TF4blMVJL9
         L+YMn4tDrxUlCDl77spkHzjHxFGvrVWQlLQehRQeyy/pGLwi1U6kbmzcEPzhOSwJRG5l
         yrIqj2u6OUlNIgXukAuLGnpqlokqWZhZd2hsqyn5mTEE6121JEyxUkcME2HOx3wMFMz4
         SMjC0b1YoWid/toiYQf3nGpF66BBLOH/0VLYLLN9rnzaqPOZvp1znjPyOcZBctX+LoRo
         SGBg==
X-Forwarded-Encrypted: i=1; AJvYcCUf4ZXY4gH+z97q8bpT/c4e3MR4Y9RLHGCnrFoKwj2TJ0rJs4W++rlC2+mF5EPvwVMOEIREK+MwLdq7sXKxwliwtOUpJizdJBTtVoSV
X-Gm-Message-State: AOJu0YxfxF/Oa4mtrhgFjuj+MLGHPdiNg6Xkavi/F0Iv3TEciZQZUcT5
	jwEItEs5kdxqufruZVUe/V9dPoAXK1Oo4uBL44CRIlLDyMHOv2Z8bz+WIplGU0UVAXsP/Q4keKz
	mVKLgBgV/oNtEYvA9qzK2l6WtKciK6nptkLdY3p/JJBzWOOo+uh2Eu64=
X-Google-Smtp-Source: AGHT+IGABgvSCB59Bl9Umbb17HV0yPEaE00tnPCyL7J6hU6mgOPM7oSjKkSkDy1HjeMf0N4eMQ5MYK0z+F625VCHKedG2LGL71JF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d10:b0:375:cbad:7b48 with SMTP id
 e9e14a558f8ab-375ccfc00fcmr1052675ab.0.1718212701428; Wed, 12 Jun 2024
 10:18:21 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7b11a061ab49122@google.com>
Subject: [syzbot] [mm?] WARNING in __page_table_check_ptes_set (2)
From: syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=146b3d96980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=0b56d6ed0d0c0c9a79dc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6ea21f50498b/disk-8867bbd4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2fed09364aa/vmlinux-8867bbd4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4860173c7a18/Image-8867bbd4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com

Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
Bluetooth: CMTP (CAPI Emulation) ver 1.0
Bluetooth: CMTP socket layer initialized
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
Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 79e1c0a63a233d95d926db3e542dc8d9e342ab6b'
zswap: loaded using pool lzo/zsmalloc
Demotion targets for Node 0: null
debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at mm/page_table_check.c:198 page_table_check_pte_flags mm/page_table_check.c:198 [inline]
WARNING: CPU: 1 PID: 1 at mm/page_table_check.c:198 __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : page_table_check_pte_flags mm/page_table_check.c:198 [inline]
pc : __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211
lr : page_table_check_pte_flags mm/page_table_check.c:198 [inline]
lr : __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211
sp : ffff800093d57520
x29: ffff800093d575a0 x28: ffff7000127aaec8 x27: dfff800000000000
x26: 0000000000000001 x25: bfeffffffffffff3 x24: 1ffff000127aaea8
x23: 0408000000000000 x22: 0000000000000001 x21: ffff0000d38131b8
x20: ffff800093d57540 x19: 0408000000000000 x18: ffff800093d57300
x17: 00000000000074be x16: ffff800080b0d2d4 x15: ffff7000127aaeb0
x14: 1ffff000127aaeb0 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff80008eb6e78c x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c1968000 x7 : ffff80008096b550 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000001
x2 : bfeffffffffffff3 x1 : 0408000000000000 x0 : 0408000000000000
Call trace:
 page_table_check_pte_flags mm/page_table_check.c:198 [inline]
 __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211
 page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
 __set_ptes arch/arm64/include/asm/pgtable.h:404 [inline]
 set_ptes arch/arm64/include/asm/pgtable.h:1586 [inline]
 pte_clear_tests+0x510/0x538 mm/debug_vm_pgtable.c:640
 debug_vm_pgtable+0x268/0x590 mm/debug_vm_pgtable.c:1392
 do_one_initcall+0x254/0x9e4 init/main.c:1267
 do_initcall_level+0x154/0x214 init/main.c:1329
 do_initcalls+0x58/0xac init/main.c:1345
 do_basic_setup+0x8c/0xa0 init/main.c:1364
 kernel_init_freeable+0x324/0x478 init/main.c:1578
 kernel_init+0x24/0x2a0 init/main.c:1467
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 1342246
hardirqs last  enabled at (1342245): [<ffff8000809ba500>] seqcount_lockdep_reader_access+0x6c/0xd4 include/linux/seqlock.h:74
hardirqs last disabled at (1342246): [<ffff80008af10a10>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (1342178): [<ffff8000801ea530>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (1342178): [<ffff8000801ea530>] handle_softirqs+0xa60/0xc34 kernel/softirq.c:582
softirqs last disabled at (1341257): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
page_owner is disabled
Key type .fscrypt registered
Key type fscrypt-provisioning registered
kAFS: Red Hat AFS client v0.1 registering.
Btrfs loaded, assert=on, ref-verify=on, zoned=yes, fsverity=yes
Key type big_key registered
Key type encrypted registered
ima: No TPM chip found, activating TPM-bypass!
Loading compiled-in module X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 79e1c0a63a233d95d926db3e542dc8d9e342ab6b'
ima: Allocated hash algorithm: sha256
ima: No architecture policies found
evm: Initialising EVM extended attributes:
evm: security.selinux (disabled)
evm: security.SMACK64
evm: security.SMACK64EXEC
evm: security.SMACK64TRANSMUTE
evm: security.SMACK64MMAP
evm: security.apparmor (disabled)
evm: security.ima
evm: security.capability
evm: HMAC attrs: 0x1
printk: legacy console [netcon0] enabled
netconsole: network logging started
gtp: GTP module loaded (pdp ctx size 128 bytes)
rdma_rxe: loaded
cfg80211: Loading compiled-in X.509 certificates for regulatory database
Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
clk: Disabling unused clocks
PM: genpd: Disabling unused power domains
ALSA device list:
  #0: Dummy 1
  #1: Loopback 1
  #2: Virtual MIDI Card 1
md: Skipping autodetection of RAID arrays. (raid=autodetect will force)
EXT4-fs (nvme0n1p2): mounted filesystem 126e38a5-b482-40da-8f06-bd78886e02c1 ro with ordered data mode. Quota mode: none.
VFS: Mounted root (ext4 filesystem) readonly on device 259:2.
devtmpfs: mounted
Freeing unused kernel memory: 4416K
Run /sbin/init as init process


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

