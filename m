Return-Path: <linux-kernel+bounces-305934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3BF96369D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2ABB1C2149E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5CB657;
	Thu, 29 Aug 2024 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ole8FK9b";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="WOxMDVYC"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869CD8836
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889899; cv=none; b=FvojCB5kaVrayspUWglCOnrpnHLFsDz5/b9A3uwUxjeXFyU5K30Lvi7W+nqs+wmo2e2UXP6s8hyESlu+S+wJw25iPz8bFkiSWiKQqgaXjn4uAgp8L503WyBOMNmbMAh2w5DbRMiDEnpnoUWAhNll4+a1fq+1LxnmRaQQmlNz4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889899; c=relaxed/simple;
	bh=tciz4WM9PQ5Hd5Zbbvdmid9mUAeLTfjs9fW16NMVs20=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bETBz7xRB/76H+jj3NwKmbaHgO5oKEb1bGcho/KUaEsvFTTqngbLAMqsWxucL7HXW1qiIBa5JMU3a8FjXYUah/GiP8q2j9MQjYpauMDarNFujmfF0FsaPOMe17f+FSWnpByTGL3Xp0lfkZwoVqnHL2gHzJdVPX0ypGBJq12A7f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=ole8FK9b; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=WOxMDVYC; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724889898; x=1756425898;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=tciz4WM9PQ5Hd5Zbbvdmid9mUAeLTfjs9fW16NMVs20=;
  b=ole8FK9b739Qi4N9v9Ni4te0/3130B193Ex32qIXH2NeP77RsXeear7t
   zgFkO8aBcb9dGPoAGuiuYX2fbuIeu2cZddW9h9/FnP+KV8Y+zbN+4A/pf
   u/LiEKxXHWROi2mHpWfTvH8B3YWcO1zEXGfgyBIvr32WdcGR/JPgbI4fF
   Cs+gu9VQoRJRwNmwclOyL9McGLC/5kSXIaRiL56U12/i1np3BiOi6eNzw
   VeXGJfY88XiS7brUjFTku5lPOt9j6QdU+0l0c25fzHhgQZeqXM0ySO8uR
   QIfVsbHK0RIs1C7ETnwr6MiZLqDarbIDZD+NIaLytVnYrhA1lvaJeo+Ma
   g==;
X-CSE-ConnectionGUID: juh+5antRl2ZVeT9dpgu/Q==
X-CSE-MsgGUID: twGT714PTMakIvpoec3WTQ==
Received: from mail-il1-f197.google.com ([209.85.166.197])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 17:04:57 -0700
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d3061c2b5so290405ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724889896; x=1725494696; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsXuq09A6uhOYb9BV8eT0h4//D362mmZer/oWoMPRDM=;
        b=WOxMDVYCC/bnax9bjwdfKohmQhAshPxU48vTfAPg54DfiZ8xvISBPF2Er0EYoleG6M
         zz8bkZWDLQX5xW2izSH2YtBiOhOtioB0GfGBtjTWzjeekvE7qgTfcNqFWCRdwXjNUu40
         CRVKhPNOGZQa50m+Sa9VE0VmzcYGnoJPuB8Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724889896; x=1725494696;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsXuq09A6uhOYb9BV8eT0h4//D362mmZer/oWoMPRDM=;
        b=wIUpg1kED0jc0vyL87x8Peb5nxt5UYDgJm7PCrHprshO0MQa3C6I3m9/ygs+J1Pr2z
         jSXd2JBQ1igUxfisBSdeXNBZYukiOF9rfI2J7TGbOWYfW6rAHYPAMJmkaNqfvrRA2WO9
         lxQMOJjhpZEFejt9al5DLDgcir9wTrNKsInHM7c8s+PG+JmQJaly0bLBbLGEiA3QmdIx
         jjxOoBDWD9OrJedEgQWYRoXdz2r9JZFxak11GkjGVDinvcauTE20r/Z5GUqjktmqEOeP
         BfFtF/VGWS8v1MM9ouSfI0dh9wNh9OEHxTchByPIRoet1zaVIIII3RqABs9SdKQ2JVTx
         vywA==
X-Forwarded-Encrypted: i=1; AJvYcCWItR4iG/X0YBwwWg3DVAm0h9YeKY2U5p7Frl6bVFw1cByU3bajHYqfbVvdmSqzFtFeq3B2d492GxUm2+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfO6Dd/L0Pd1NECGyM9KJ0Egku3biF5S2QaVSCz7JfCWxq/EG
	7BeXJkVArT5yF25RtKt1Z0ap8SoLqceowB95ZJwGOOrGb2Vt+FeoiCVS+NXOAOmpal2V0fpAEeX
	N6cwXhX/PCWJnya9UC/a+q3OywuZiXouc8VnSmimvR9cwuS5cOYHnOWvT6qn2fiSV7mq3oFhLci
	UuHGtE55q3i6U7up55jSYRxn5Nk46VR06eYzg6XQ==
X-Received: by 2002:a05:6e02:1a27:b0:39e:68f8:43d8 with SMTP id e9e14a558f8ab-39f3792e171mr16210525ab.13.1724889895926;
        Wed, 28 Aug 2024 17:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjJJNG5WuBpgsl2Bf9VA1DlDVhXimio9j6QmBvywuhLjEKfCCQHLJiHAQFUT8DN/nFtdmKuipXRsJe459W4cU=
X-Received: by 2002:a05:6e02:1a27:b0:39e:68f8:43d8 with SMTP id
 e9e14a558f8ab-39f3792e171mr16210245ab.13.1724889895489; Wed, 28 Aug 2024
 17:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 17:04:44 -0700
Message-ID: <CALAgD-7HBA_wLo-7WOFh=xB1HMBfACabb-6WbgkC905xbE76Jg@mail.gmail.com>
Subject: BUG: general protection fault in arpt_do_table
To: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a null
pointer dereference  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000007: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 0 PID: 2893 Comm: kworker/u4:9 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: bat_events batadv_bla_periodic_work
RIP: 0010:arpt_do_table+0x2a8/0x1dc0 net/ipv4/netfilter/arp_tables.c:210
Code: 28 00 74 08 48 89 df e8 26 b3 69 f8 48 8b 1b e8 de f9 6c 01 41
89 c6 48 89 9c 24 88 00 00 00 4c 8d 7b 38 4c 89 f8 48 c1 e8 03 <42> 80
3c 28 00 74 08 4c 89 ff e8 f9 b2 69 f8 44 89 f3 48 c1 e3 03
RSP: 0000:ffffc900000076c0 EFLAGS: 00010202
RAX: 0000000000000007 RBX: 0000000000000000 RCX: ffffffff8c7668e0
RDX: 0000000080000101 RSI: ffffffff8ba956c0 RDI: ffffffff8ba95680
RBP: ffffc900000078a8 R08: ffffffff898aa86c R09: 0000000000000000
R10: ffffc90000007820 R11: ffffffff898aa6d0 R12: ffffc90000007960
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000038
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffb61bfff40 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc0/0x210 net/netfilter/core.c:626
 nf_hook+0x2be/0x450 include/linux/netfilter.h:269
 NF_HOOK include/linux/netfilter.h:312 [inline]
 arp_rcv+0x304/0x500 net/ipv4/arp.c:989
 __netif_receive_skb_one_core net/core/dev.c:5625 [inline]
 __netif_receive_skb+0x2cf/0x640 net/core/dev.c:5739
 process_backlog+0x37d/0x7a0 net/core/dev.c:6068
 __napi_poll+0xcc/0x480 net/core/dev.c:6722
 napi_poll net/core/dev.c:6791 [inline]
 net_rx_action+0x7ed/0x1040 net/core/dev.c:6907
 handle_softirqs+0x272/0x750 kernel/softirq.c:554
 do_softirq+0x117/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1b0/0x1f0 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 netif_rx+0x7f/0x90 net/core/dev.c:5210
 batadv_bla_send_claim+0x827/0xc60 net/batman-adv/bridge_loop_avoidance.c:447
 batadv_bla_send_announce net/batman-adv/bridge_loop_avoidance.c:675 [inline]
 batadv_bla_periodic_work+0x598/0xa80
net/batman-adv/bridge_loop_avoidance.c:1481
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:arpt_do_table+0x2a8/0x1dc0 net/ipv4/netfilter/arp_tables.c:210
Code: 28 00 74 08 48 89 df e8 26 b3 69 f8 48 8b 1b e8 de f9 6c 01 41
89 c6 48 89 9c 24 88 00 00 00 4c 8d 7b 38 4c 89 f8 48 c1 e8 03 <42> 80
3c 28 00 74 08 4c 89 ff e8 f9 b2 69 f8 44 89 f3 48 c1 e3 03
RSP: 0000:ffffc900000076c0 EFLAGS: 00010202
RAX: 0000000000000007 RBX: 0000000000000000 RCX: ffffffff8c7668e0
RDX: 0000000080000101 RSI: ffffffff8ba956c0 RDI: ffffffff8ba95680
RBP: ffffc900000078a8 R08: ffffffff898aa86c R09: 0000000000000000
R10: ffffc90000007820 R11: ffffffff898aa6d0 R12: ffffc90000007960
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000038
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffb61bfff40 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 28 00                 sub    %al,(%rax)
   2: 74 08                 je     0xc
   4: 48 89 df             mov    %rbx,%rdi
   7: e8 26 b3 69 f8       call   0xf869b332
   c: 48 8b 1b             mov    (%rbx),%rbx
   f: e8 de f9 6c 01       call   0x16cf9f2
  14: 41 89 c6             mov    %eax,%r14d
  17: 48 89 9c 24 88 00 00 mov    %rbx,0x88(%rsp)
  1e: 00
  1f: 4c 8d 7b 38           lea    0x38(%rbx),%r15
  23: 4c 89 f8             mov    %r15,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 28 00       cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 4c 89 ff             mov    %r15,%rdi
  34: e8 f9 b2 69 f8       call   0xf869b332
  39: 44 89 f3             mov    %r14d,%ebx
  3c: 48 c1 e3 03           shl    $0x3,%rbx


-- 
Yours sincerely,
Xingyu

