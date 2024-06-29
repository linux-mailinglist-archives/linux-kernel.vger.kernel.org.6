Return-Path: <linux-kernel+bounces-234882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B991CC03
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 12:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9483282E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E4F3FE55;
	Sat, 29 Jun 2024 10:05:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BE3BBCB
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719655523; cv=none; b=NTknKwJ0DfuuoQCRoIOKGaQTkGxid3ryf4lHgKjF8CR3QSYeVmagkFdZXqPBMxpfg5gU80PUpsJ4x298cmlMsT9aonuFfAANciHlckkUvJKObPdsdv3mDVf8YS3SEGBGJ4bE7RTfDHLtgu2SSui8IS3AFszcX5gXDbah27sW2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719655523; c=relaxed/simple;
	bh=GhWNiMgQ8W8OQGUpj8Z2BAIbjk+vSoVqX26p/BMPOJ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T0npbA9EqbI2Ryk2eYzBkq6XAsg+k2S3JWqlD83I/sluphdfNF+xt+BCIsLrGq+0rMM728bl1kZ5D53v4a2FDpM0lBGR/7ZFqZrdPb/Rq+y0XZUiAkOIS96oe+tRVb9B4XLXaC1qQT+YLypu3wUOCP2WnSRdJi9UQsh4q12tFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so157959339f.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719655521; x=1720260321;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pj2Zym6gdMBi8TPGUSJCWSi/4Z/PpOgcewXL1Xg2crI=;
        b=oSaoZ2/WIOIOlTxv4sBB6j4+3Eqm1m6LEr8CK9agoFp1b3lr7F63qQmrKgVL8x0fzy
         5FuJpOjLR2qFgItYke5z8zEnJJ5RzBBGIQBwrsrYG/wPgZxy4Hc4tTC1XpRF9bX1Lulo
         sqWzu5FEZ7vUz88qeQjcf+dfV2Z8a+qqqkayVk8I/Rw4Nz3D7lIPWl/qT7WKtn1gZWOV
         1DnWpGot2YimxrcQfUv8JB+lBM/YDHfvHfAgnGUIKRb7U1sRQu0gcPt03ZOYq1MSS/RE
         HDs2SYx24KF9DNfC1Ea8ol18rW2xtP11jOmNmFluT51p2tinjmPPvbW6Q1G1Y6QIaETm
         3Ygg==
X-Forwarded-Encrypted: i=1; AJvYcCUeqV9YVFYktrT7vMSWVPqpcXfiK2Dsi2P3z+uPKI9vzw6+coh8avh01UKiA0tFJNdiG3vbP1+VtC+iL+E2Z9oNb+dbMXWYueLive+Y
X-Gm-Message-State: AOJu0YwI8kxNbxR0g+T2IQiuWFXH3KGPvZZcQpQIrVNg7KGmPyixdKbT
	5wLYglUgmRdUpIpWs50W+KHrblW2qwYyGLALpdxbEMBvXp4eY9fY5xgImFuFw39JPGz4ny2YjY/
	W3kjmqfr3CHYNM5zwZra9dcxKaxyWccZx0Mmo34TljF9cN5oHNLByYmA=
X-Google-Smtp-Source: AGHT+IH9CQ8jKhvgnMhEPpmwUQPkaYG2/Cf5CrBKIQ4nBWeIMdd91pagobz2XDCE5E09VkmdiayYLC1u/78Pozt0AIvQ7wW11Cpq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130e:b0:4b0:b123:d9d with SMTP id
 8926c6da1cb9f-4bbb70abb58mr60021173.5.1719655520896; Sat, 29 Jun 2024
 03:05:20 -0700 (PDT)
Date: Sat, 29 Jun 2024 03:05:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075a135061c0480d0@google.com>
Subject: [syzbot] [ext4?] BUG: unable to handle kernel paging request in do_split
From: syzbot <syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    55027e689933 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=100ec271980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67463c0717b8d4ca
dashboard link: https://syzkaller.appspot.com/bug?extid=ae688d469e36fb5138d0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14296bb6980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a53e3e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5a4561e75890/disk-55027e68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/40e478722974/vmlinux-55027e68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3bbbd2462f2/bzImage-55027e68.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/451986899a3c/mount_0.gz

Bisection is inconclusive: the first bad commit could be any of:

3b51788a2d5f IB/hfi1: use new function dev_fetch_sw_netstats
44fa32f008ab net: add function dev_fetch_sw_netstats for fetching pcpu_sw_netstats
3618ad2a7c0e virtio-net: ethtool configurable RXCSUM
9d0151673e70 net: macsec: use new function dev_fetch_sw_netstats
c9bf52a173c7 net/af_unix: Remove unused old_pid variable
ec173778e96e net: usb: qmi_wwan: use new function dev_fetch_sw_netstats
0403a2b53c29 net/tls: use semicolons rather than commas to separate statements
ab2b3ff21b9f net: usbnet: use new function dev_fetch_sw_netstats
1f68b2096f65 qtnfmac: use new function dev_fetch_sw_netstats
6159e9633f17 net/ipv6: use semicolons rather than commas to separate statements
44797589c20e tcp: use semicolons rather than commas to separate statements
f3f04f0f3ab9 net: bridge: use new function dev_fetch_sw_netstats
7e38b03f0fe7 net: mscc: ocelot: remove duplicate ocelot_port_dev_check
a0d269810185 net: dsa: use new function dev_fetch_sw_netstats
c93c5482c7d4 Merge branch 'macb-support-the-2-deep-Tx-queue-on-at91'
cf89f18fa407 iptunnel: use new function dev_fetch_sw_netstats
0a4e9ce17ba7 macb: support the two tx descriptors on at91rm9200
6401297e7610 mac80211: use new function dev_fetch_sw_netstats
3569939a811e net: openvswitch: use new function dev_fetch_sw_netstats
73d742281383 macb: prepare at91 to use a 2-frame TX queue
5fc3594d36d1 xfrm: use new function dev_fetch_sw_netstats
fa6031df12fc macb: add RM9200's interrupt flag TBRE
a003ec1f47bc Merge branch 'net-add-and-use-function-dev_fetch_sw_netstats-for-fetching-pcpu_sw_netstats'
ccdf7fae3afa Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
30cf856a691f i40e: Allow changing FEC settings on X722 if supported by FW
a308283fdbf7 Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next
793d5d612426 netfilter: flowtable: reduce calls to pskb_may_pull()
f2bf814a27c5 e1000: remove unused and incorrect code
d3519cb89f6d netfilter: nf_tables: add inet ingress support
d5e6f064ac66 Merge branch '40GbE-Intel-Wired-LAN-Driver-Updates-2020-10-12'
50172733d01c Merge tag 'mlx5-updates-2020-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
60a3815da702 netfilter: add inet ingress support
d25e2e9388ed netfilter: restore NF_INET_NUMHOOKS

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14154fda980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com

EXT4-fs error (device loop0): ext4_orphan_get:1399: comm syz-executor306: couldn't read orphan inode 15 (err -117)
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
BUG: unable to handle page fault for address: ffffed11022e24fe
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffee067 P4D 23ffee067 PUD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5079 Comm: syz-executor306 Not tainted 6.10.0-rc5-syzkaller-00018-g55027e689933 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:do_split+0x150b/0x2490 fs/ext4/namei.c:2046
Code: 89 f8 48 c1 e8 03 0f b6 04 10 84 c0 48 89 74 24 18 0f 85 f5 0c 00 00 46 8b 3c f6 41 8d 46 ff 48 8d 1c c6 48 89 d8 48 c1 e8 03 <0f> b6 04 10 84 c0 4c 8b a4 24 98 00 00 00 0f 85 f7 0c 00 00 8b 1b
RSP: 0018:ffffc9000327f060 EFLAGS: 00010a02
RAX: 1ffff111022e24fe RBX: ffff8888117127f0 RCX: ffff8880237e1e00
RDX: dffffc0000000000 RSI: ffff8880117127f8 RDI: ffff8880117127f8
RBP: ffffc9000327f250 R08: ffffffff825fc2ad R09: ffffffff82541cf8
R10: 0000000000000007 R11: ffffffff825435f0 R12: 0000000000000000
R13: 0000000000000400 R14: 0000000000000000 R15: 000000002b74e18c
FS:  00005555787b4380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed11022e24fe CR3: 0000000043598000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 make_indexed_dir+0xdaf/0x13c0 fs/ext4/namei.c:2341
 ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2451
 ext4_rename fs/ext4/namei.c:3936 [inline]
 ext4_rename2+0x26e5/0x4370 fs/ext4/namei.c:4214
 vfs_rename+0xbdb/0xf00 fs/namei.c:4887
 do_renameat2+0xd94/0x13f0 fs/namei.c:5044
 __do_sys_rename fs/namei.c:5091 [inline]
 __se_sys_rename fs/namei.c:5089 [inline]
 __x64_sys_rename+0x86/0xa0 fs/namei.c:5089
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe5c7dcdb59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd201c228 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007fe5c7e16568 RCX: 00007fe5c7dcdb59
RDX: 0000000000000000 RSI: 0000000020000f40 RDI: 00000000200003c0
RBP: 00007fe5c7e16668 R08: 00005555787b54c0 R09: 00005555787b54c0
R10: 00005555787b54c0 R11: 0000000000000246 R12: 00007ffcd201c250
R13: 00007ffcd201c478 R14: 431bde82d7b634db R15: 00007fe5c7e1603b
 </TASK>
Modules linked in:
CR2: ffffed11022e24fe
---[ end trace 0000000000000000 ]---
RIP: 0010:do_split+0x150b/0x2490 fs/ext4/namei.c:2046
Code: 89 f8 48 c1 e8 03 0f b6 04 10 84 c0 48 89 74 24 18 0f 85 f5 0c 00 00 46 8b 3c f6 41 8d 46 ff 48 8d 1c c6 48 89 d8 48 c1 e8 03 <0f> b6 04 10 84 c0 4c 8b a4 24 98 00 00 00 0f 85 f7 0c 00 00 8b 1b
RSP: 0018:ffffc9000327f060 EFLAGS: 00010a02
RAX: 1ffff111022e24fe RBX: ffff8888117127f0 RCX: ffff8880237e1e00
RDX: dffffc0000000000 RSI: ffff8880117127f8 RDI: ffff8880117127f8
RBP: ffffc9000327f250 R08: ffffffff825fc2ad R09: ffffffff82541cf8
R10: 0000000000000007 R11: ffffffff825435f0 R12: 0000000000000000
R13: 0000000000000400 R14: 0000000000000000 R15: 000000002b74e18c
FS:  00005555787b4380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed11022e24fe CR3: 0000000043598000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 f8                	mov    %edi,%eax
   2:	48 c1 e8 03          	shr    $0x3,%rax
   6:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   a:	84 c0                	test   %al,%al
   c:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
  11:	0f 85 f5 0c 00 00    	jne    0xd0c
  17:	46 8b 3c f6          	mov    (%rsi,%r14,8),%r15d
  1b:	41 8d 46 ff          	lea    -0x1(%r14),%eax
  1f:	48 8d 1c c6          	lea    (%rsi,%rax,8),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	4c 8b a4 24 98 00 00 	mov    0x98(%rsp),%r12
  37:	00
  38:	0f 85 f7 0c 00 00    	jne    0xd35
  3e:	8b 1b                	mov    (%rbx),%ebx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

