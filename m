Return-Path: <linux-kernel+bounces-422441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0029B9D99B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F66B2A461
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD0D1D5CC5;
	Tue, 26 Nov 2024 14:34:41 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D8BE46
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631681; cv=none; b=E67GduHMQm6NSXqvLaOXYK2uHsFMuRZ3LdHmxst4hXsySZBGr0UFI/pC6VcCMb3cyS6D/OzNsNNXTyAodK4fDkZweV7ZktTLTZJuL4Y+HvRjh2JqHxLmyrzUEjaorv4rt/Cnki4XyMtYNXM8ZF+MyFtMTPHE4I3re7Z3kPf0OcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631681; c=relaxed/simple;
	bh=SwCLUDoCn1zSFH0ezygDJUTXfuTmbMkj3R+icj9Rb78=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H7VQOKqJbQUsNbvkH8/pGQQLSe+m+xhYlcSHoLWGydPjr6T2CmoId8o7d4/TPauZJoYiJqeLo5GgE1Lv27MGv8xqwGm8619Mhg7HwmeK45QvidP3K/GLa0qR5ilEvhwVSBI+ThuFTUAeRVDMIXRP3Qsv1kIXwkPTF+AFkGiI/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8418307b4f9so270255339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732631679; x=1733236479;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppzdMjBrQKtYQbXhvhZNE8f0sJO6PN9v2KluOrYgajk=;
        b=KP0FNsz5H4DDq8pEfrduXcqJnMHBH+Rlfz8BPWZRxeniG7PETNdPw8JFOwdX16akCU
         l26PDNzKwMTNRjUdfTl4yZrPi5lzNDyrcGk3Ppqh2T85tfJoqr+YhwhFFeaH9ixnUtYd
         +AzBHaVe4zWtW4sXp4j1JRdHCToZKMcAqkmwj4Kz3QoaZ0g982t4ldT63i3MsSLXB5DC
         dK/OyaEJjB7LFbO8tDxNa2BJQXSRCjCGpy8A6ZWLig2dh7/h7BcCsvxGAD/imCgM1PPp
         eW3uW5mx46GsAYRGr+Wg8JDIOQhY6oDG6DkG2MOsBuZyCjoVhlvGz81nSyBDrVBbGfAk
         PLlA==
X-Forwarded-Encrypted: i=1; AJvYcCUAky6ln+GaotzvXuloGtlpn/XbfeS5sgwXuIjZaITyUT6kRuLDXW/ejczpYjxcK3ydkUP6Tb3Vw0Jb6ME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3aau7WeNuwtyQIZZ7atQ+4doEvC1e1s2MiFgSRwadNlZXwMNF
	AWb/28XSBUVKnLPmmQg/uYDu+gBSSTvzWr6+9ux38YaMgs9IMxo+FvJr0uD09+sZrGAE1e0HmuB
	DUwbFboaRHKfqVR7fhVi9svG9GMlFqULSvT6ZBpmP7MmR9m+J35NR85I=
X-Google-Smtp-Source: AGHT+IHnzYCZfVidcmEg7JPBJoVVbmQX8ycrZwy0QxfGPNjhFvMHtJLyWSIDRK1Glon6Xp2u54iOuEOEOU0rm6JWXzPmhmYCvdIh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e03:b0:3a7:98c4:8d55 with SMTP id
 e9e14a558f8ab-3a79afc807cmr182909555ab.20.1732631679143; Tue, 26 Nov 2024
 06:34:39 -0800 (PST)
Date: Tue, 26 Nov 2024 06:34:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745dc7f.050a0220.21d33d.0018.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in hsr_forward_skb (2)
From: syzbot <syzbot+671e2853f9851d039551@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc39fb56917b Merge tag 'jfs-6.13' of github.com:kleikamp/l..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12483930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a5c320d506b5745
dashboard link: https://syzkaller.appspot.com/bug?extid=671e2853f9851d039551
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130abec0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1026d7f7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c35bd17a0dc5/disk-fc39fb56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/900f3f8ce653/vmlinux-fc39fb56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fae5edad1eaf/bzImage-fc39fb56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+671e2853f9851d039551@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in fill_frame_info net/hsr/hsr_forward.c:709 [inline]
BUG: KMSAN: uninit-value in hsr_forward_skb+0x9ee/0x3b10 net/hsr/hsr_forward.c:724
 fill_frame_info net/hsr/hsr_forward.c:709 [inline]
 hsr_forward_skb+0x9ee/0x3b10 net/hsr/hsr_forward.c:724
 hsr_dev_xmit+0x2f0/0x350 net/hsr/hsr_device.c:235
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3606
 __dev_queue_xmit+0x366a/0x57d0 net/core/dev.c:4434
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3146 [inline]
 packet_sendmsg+0x91ae/0xa6f0 net/packet/af_packet.c:3178
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 __sys_sendto+0x594/0x750 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
 x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1323 [inline]
 alloc_skb_with_frags+0xc8/0xd00 net/core/skbuff.c:6612
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2881
 packet_alloc_skb net/packet/af_packet.c:2995 [inline]
 packet_snd net/packet/af_packet.c:3089 [inline]
 packet_sendmsg+0x74c6/0xa6f0 net/packet/af_packet.c:3178
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 __sys_sendto+0x594/0x750 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
 x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5821 Comm: syz-executor335 Not tainted 6.12.0-syzkaller-05676-gfc39fb56917b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================


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

