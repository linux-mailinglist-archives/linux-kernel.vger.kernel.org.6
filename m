Return-Path: <linux-kernel+bounces-349931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4433898FD7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0489C2822AE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953684037;
	Fri,  4 Oct 2024 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5lXn5qH"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BFC1D5AA7
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024460; cv=none; b=uXTzcy3zjRbKLPmeORKBBD773BPEOAXZ1PEr8uR4OjmAeP/+sgTnXrA9KzJl8LOq/WDFH8RbKLHKlktdAY7kWFgJ2r7rHXvnqHBn8dBJevqhXtZYAlvoDcJ8OIqmEgG67fQ7xFzB450H8FLP5w9Ot1enTs3BZP4C/xzuapRiV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024460; c=relaxed/simple;
	bh=BTqwsyahRo6YeejCWkC0o5cZT4+CHAfmKv3Eog+3pj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oM5BVMLj1jWYdUww3rHeFwnDMP9Fm20nBq8K7FWXSt7L8DowW7MF64MWpi6AjJUQrKJSnezVNudYCL7JVCbwxONX9re/k9PaGROr8F3bdaIykezf4vIOjKDKfIy5orkZOvz5gCTe2Dvs6StgNo5QERLjRqcG6U0GFovlSMtwrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5lXn5qH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b0b5cdb57so20698445ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 23:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728024458; x=1728629258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iBDSXa3KaY4HCHNhCGcb5G6RKQRUGT6lNXmgTdsTxvE=;
        b=V5lXn5qH4t/Iu9sipEEK+HacjTN6EBz1O/Z+qkE3EqE5OEpKsaiIDFRJVebf7Oyg8i
         JalckqGcO6P5eJ6I44Q7mIKSQqadA1tXR38El0DWBuE6zeiJTokhcp2Ta4E2xwDg2Mii
         ygah4wB+maluY1cccEpGEMj1xVHTywRODjMcCVjUhGkd9TVvYVGQffDTfw8yHxBp/eqo
         U1GQqwM8CJ6xaEqGn5Cm7TVD5fqa2D1s8MFiXtx09jRbdu+TgCQra/eU1MoNs6MsUWQ8
         xHPjy5oGWp8gak+q8EHhXBOEDEF3NeWG7NJnCaZudgi5ANHLVCIw3K2MoungZ8LCyN+g
         UCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728024458; x=1728629258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBDSXa3KaY4HCHNhCGcb5G6RKQRUGT6lNXmgTdsTxvE=;
        b=nlTeVjy37guy9xnZennn+cxD4tBCIjnTtYE4ACFhAgS7si65HtXBIFfkFBpoHvFgtR
         gKSiraeCIN/fchojVdsb1JQlziqL2QM0iSaj3ob8st7WAk+j1cZTSVJob6vhhUvokDXK
         UuM1SQ1/Unt7iN6o6qIAJdvgG4TTxAv2vmNArf4M7BPccf2QYAAJSdGotcGGZ3wo3hmS
         ZvEVEyWIHXwKcbGUgy5OG0vl60zD15Ag8u80hn8JmrWpFRZlTLWIHoG+7SCtHsVLb3PD
         nEyv1f63gzCQBMhPyw6oOF4f++d617+PvDYlLLDISK6uZ71/L3oqHOae5KyjpJNDjvnE
         555g==
X-Gm-Message-State: AOJu0YyDy1r9QGNowb49KT7CUjbF2SINYb+aKB473jDIIRkdUKTwbDm9
	zo3iSP68dPaZLPNjYms0qRwjUkDdXpi5EGrdt1UBqOTB8nIPtJuChzykENNbOCnwQA7+4jLN+EB
	2C2ISVyBSVN8EEA1LHitiMZNHLIBjOE9KobbDNCFDR4w5OM1XAsnb
X-Google-Smtp-Source: AGHT+IEGS4g3eRvlYRww65N1dSUIJB9P7fOCi6xFJzDqc8M9QePFTD4xRVoovwW65JBdUhRS0TK73EvBwGP4QWNTXu0=
X-Received: by 2002:a17:90b:3850:b0:2e0:8bf7:4f0f with SMTP id
 98e67ed59e1d1-2e1b38a1a20mr8999654a91.5.1728024457166; Thu, 03 Oct 2024
 23:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66ff8bf6.050a0220.49194.0453.GAE@google.com>
In-Reply-To: <66ff8bf6.050a0220.49194.0453.GAE@google.com>
From: Marco Elver <elver@google.com>
Date: Fri, 4 Oct 2024 08:47:01 +0200
Message-ID: <CANpmjNPxWQScMMy6rFMLzFrgPK4a3jaDrKYzBnRTjTVDNnWapQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KFENCE: memory corruption in add_sysfs_param
To: syzbot <syzbot+873cb3989e92ad5d796d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 08:32, syzbot
<syzbot+873cb3989e92ad5d796d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10ac0d80580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
> dashboard link: https://syzkaller.appspot.com/bug?extid=873cb3989e92ad5d796d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/641e642c9432/disk-c02d24a5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/98aaf20c29e0/vmlinux-c02d24a5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c23099f2d86b/bzImage-c02d24a5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+873cb3989e92ad5d796d@syzkaller.appspotmail.com
>
> can: broadcast manager protocol
> can: netlink gateway - max_hops=1
> can: SAE J1939
> can: isotp protocol (max_pdu_size 8300)
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM ver 1.11
> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> Bluetooth: BNEP filters: protocol multicast
> Bluetooth: BNEP socket layer initialized
> Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> Bluetooth: HIDP socket layer initialized
> NET: Registered PF_RXRPC protocol family
> Key type rxrpc registered
> Key type rxrpc_s registered
> NET: Registered PF_KCM protocol family
> lec:lane_module_init: lec.c: initialized
> mpoa:atm_mpoa_init: mpc.c: initialized
> l2tp_core: L2TP core driver, V2.0
> l2tp_ppp: PPPoL2TP kernel driver, V2.0
> l2tp_ip: L2TP IP encapsulation support (L2TPv3)
> l2tp_netlink: L2TP netlink interface
> l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
> l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
> NET: Registered PF_PHONET protocol family
> 8021q: 802.1Q VLAN Support v1.8
> DCCP: Activated CCID 2 (TCP-like)
> DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
> DCCP is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
> sctp: Hash tables configured (bind 32/56)
> NET: Registered PF_RDS protocol family
> Registered RDS/infiniband transport
> Registered RDS/tcp transport
> tipc: Activated (version 2.0.0)
> NET: Registered PF_TIPC protocol family
> tipc: Started in single node mode
> NET: Registered PF_SMC protocol family
> 9pnet: Installing 9P2000 support
> NET: Registered PF_CAIF protocol family
> NET: Registered PF_IEEE802154 protocol family
> Key type dns_resolver registered
> Key type ceph registered
> libceph: loaded (mon/osd proto 15/24)
> batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibility version 15) loaded
> openvswitch: Open vSwitch switching datapath
> NET: Registered PF_VSOCK protocol family
> mpls_gso: MPLS GSO support
> IPI shorthand broadcast: enabled
> AES CTR mode by8 optimization enabled
> ==================================================================
> BUG: KFENCE: memory corruption in krealloc_noprof+0x160/0x2e0
>
> Corrupted memory at 0xffff88823be6c088 [ 0x08 0x46 0x11 0x30 0x80 0x88 0xff 0xff 0x60 0x46 0x11 0x30 0x80 0x88 0xff 0xff ] (in kfence-#53):
>  krealloc_noprof+0x160/0x2e0
>  add_sysfs_param+0x137/0x7f0 kernel/params.c:663
>  kernel_add_sysfs_param+0xb4/0x130 kernel/params.c:817
>  param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
>  param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
>  do_one_initcall+0x248/0x880 init/main.c:1266
>  do_initcall_level+0x157/0x210 init/main.c:1328
>  do_initcalls+0x3f/0x80 init/main.c:1344
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1577
>  kernel_init+0x1d/0x2b0 init/main.c:1466
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> kfence-#53: 0xffff88823be6c000-0xffff88823be6c087, size=136, cache=kmalloc-192
>
> allocated by task 1 on cpu 1 at 10.052565s (0.009153s ago):
>  __do_krealloc mm/slub.c:4784 [inline]
>  krealloc_noprof+0xd6/0x2e0 mm/slub.c:4838
>  add_sysfs_param+0x137/0x7f0 kernel/params.c:663
>  kernel_add_sysfs_param+0xb4/0x130 kernel/params.c:817
>  param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
>  param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
>  do_one_initcall+0x248/0x880 init/main.c:1266
>  do_initcall_level+0x157/0x210 init/main.c:1328
>  do_initcalls+0x3f/0x80 init/main.c:1344
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1577
>  kernel_init+0x1d/0x2b0 init/main.c:1466
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> freed by task 1 on cpu 1 at 10.059120s (0.002598s ago):
>  krealloc_noprof+0x160/0x2e0
>  add_sysfs_param+0x137/0x7f0 kernel/params.c:663
>  kernel_add_sysfs_param+0xb4/0x130 kernel/params.c:817
>  param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
>  param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
>  do_one_initcall+0x248/0x880 init/main.c:1266
>  do_initcall_level+0x157/0x210 init/main.c:1328
>  do_initcalls+0x3f/0x80 init/main.c:1344
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1577
>  kernel_init+0x1d/0x2b0 init/main.c:1466
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Possible cause:
https://lore.kernel.org/all/CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com/

