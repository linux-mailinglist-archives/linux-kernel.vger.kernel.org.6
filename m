Return-Path: <linux-kernel+bounces-413736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D99D1E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826481F2160A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CFB13B2A4;
	Tue, 19 Nov 2024 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fIVEgPuj"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBFC2C9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982778; cv=none; b=D3cbZt+M0+e7jpuJWTNE7u8Ynsrx4lgSdbnfIOiEGqTXU/bw+M2aA0XRAF4QzmKXuRTuQBjD2aBD7VfRmrdsMUtKWBJfOPPIsJK5aGbFwhD/hpEg/aMkJb0td8UT/4D08ifztiK8Jijuj4Wcby6V0DcpcajDPRyu85IX622LSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982778; c=relaxed/simple;
	bh=059KpEiQnGj+DowfIDKQ1LMmGviX1/NFgUxj+2EwpnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mG7LYFJhYteIBCvZypf57+Og5UEKytZOpryCERUn+UieSIQyowMS1GB60pyJbNOBFVhsGMxS37FTeX47283PjjammzyKDuhPsv1hj/CWeEC7F9rW+Y/CJ1NjnaRWfK26cvLN3Ld1xsKd5Hj/Ovj/G/H8CsyGhsXV+QfMqZ6NrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fIVEgPuj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7245f6ee486so315322b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1731982775; x=1732587575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A655RAsjrc0n0KeRsMivGdZUsC8dADXJJLySqKGLFNM=;
        b=fIVEgPuj/Hzmc6VZS5oe0t7PYzbkknzGI2NJH3r5NmkqBMeEykT2ncJLDrIWHHH0RV
         ffHU9qKn02Ea91OW5qwQlUIC469uF7BYAU0EX5cqjt3u818N3KwyaZ8VVWrurEXXM0bt
         lc67+thYN1tRcmqthvd47qllMYSXmJlucuP8WwbZEuSgSu4Rw107EZAb1q436j8iJ0iK
         e37AvFaY/hSt+d0LfhXMfPIyTcCia0KJG4oPmX/iJzYzhM3F6b3/GlSMDHzvuL1UAV3W
         0WnSAjMNqChu10iw634Eu31fgfbNCAYQtrgrOAlKqeayQTcra+KFYfLARsokZ2Fz1b6v
         5mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731982775; x=1732587575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A655RAsjrc0n0KeRsMivGdZUsC8dADXJJLySqKGLFNM=;
        b=SjcuUFAiuvFAq6N12KykAQF5PPlyYFUjy7x/W84VHG2y+/4Ziuwo79f+TlmKU3pp9l
         ipTIwR5RqpKfRz9N1uzQUA01ieHGm/VA6f6jGKS2IJ3GjcZpOEKPlb3FJao6+w27jL5K
         9IIPs1sTKqVvlpgkItOg3phc89lFoyTMy1qKajppEIow9iy4NO6QV4IKACBfgz6EX8A1
         H+19q/c7Cexw1zm2swRHZcJEKda55PJX2uhgyFvRQWu44rBFCVpU1b6f8i7B0Jy3S36T
         VkipPcbyus3ZhxD1fDmWy7XbtnuGHUt0AtbHIMldTAl9QASh3HaOrFMRfemICHX3wMVR
         xn9w==
X-Forwarded-Encrypted: i=1; AJvYcCVEqLb8nilzz0en0Q0TfNdLB37vHXeWJ3RLxjB4qTGWGXeA8+3o3liCOmDkA6KgnEZX8sPxC4qabltqrR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5+GR5T9M8c24WMU4R1kn1EDqddlyh7ccAoIgzmtdRN//dTP3
	/Qx+stwM0a/EHf/RD8C8VrGpPD0TSIxOYkYTYHUon4Pm5Tmkg5IKZJKULualpNbTSjGa0geZfDd
	YLnfvWfigpIS1zmo3V8nbUmeux9iXjPCZHQXm9Q==
X-Gm-Gg: ASbGncvvAsLRWSNT4+5SP53Y3ATNjZSi5BH2uwhBf+o/Wxf2EO6l7131/mk/DhstfSw
	P8vVRfe39pY18eDhnIyHLd2hQbC7SaA==
X-Google-Smtp-Source: AGHT+IF9naYefsU6fVUKEz8CjB0ob2Vbqid7iR0mUp8JGd0+p30P3KusHcin5BG8HvmlcFGAfIoMJf5ukFQv7xMANFI=
X-Received: by 2002:a17:902:e5c5:b0:20b:709d:768b with SMTP id
 d9443c01a7336-211d0ecaef5mr82299095ad.14.1731982775136; Mon, 18 Nov 2024
 18:19:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67383db1.050a0220.85a0.000e.GAE@google.com>
In-Reply-To: <67383db1.050a0220.85a0.000e.GAE@google.com>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 18 Nov 2024 18:19:23 -0800
Message-ID: <CADUfDZqBUvm5vUgRHXKjvo=Kk4Ze8xU5tn-wG6J0wmUE6TTREA@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in dev_prep_valid_name
To: syzbot <syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, parav@nvidia.com, saeedm@nvidia.com, 
	syzkaller-bugs@googlegroups.com, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm, it seems very unlikely that "mlx5/core: Schedule EQ comp tasklet
only if necessary" could have caused this issue. The commit only
touches the mlx5 driver. Does the test machine have ConnectX NICs? The
commit itself simply moves where tasklet_schedule() is called for the
mlx5_cq_tasklet_cb() tasklet, making it so the tasklet will only be
scheduled to process userspace RDMA completions.
Is it possible that the failure is not consistently reproducible and
the bisection is landing on the wrong commit?

Thanks,
Caleb


On Fri, Nov 15, 2024 at 10:37=E2=80=AFPM syzbot
<syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    80b6f094756f Merge branch 'suspend-irqs-during-applicatio=
n..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16b80ce858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dea5200d154f86=
8aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D21ba4d5adff0b6a=
7cfc6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D107dfe30580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D147dfe3058000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1460e7e4f91a/dis=
k-80b6f094.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9375c3c40003/vmlinu=
x-80b6f094.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/33f29f155ac1/b=
zImage-80b6f094.xz
>
> The issue was bisected to:
>
> commit 0ac20437412bfc48d67d33eb4be139eafa4a0800
> Author: Caleb Sander Mateos <csander@purestorage.com>
> Date:   Tue Nov 5 20:39:59 2024 +0000
>
>     mlx5/core: Schedule EQ comp tasklet only if necessary
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12a981a798=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16a981a798000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com
> Fixes: 0ac20437412b ("mlx5/core: Schedule EQ comp tasklet only if necessa=
ry")
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc000000004c: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000260-0x0000000000000267]
> CPU: 0 UID: 0 PID: 5944 Comm: syz-executor276 Not tainted 6.12.0-rc6-syzk=
aller-01329-g80b6f094756f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/30/2024
> RIP: 0010:dev_prep_valid_name+0x3e3/0xa40 net/core/dev.c:1165
> Code: 20 08 00 00 e8 6e 50 27 fb 48 85 c0 0f 84 8f 04 00 00 48 89 44 24 3=
8 48 8b 5c 24 30 48 81 c3 68 02 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00=
 74 08 48 89 df e8 ce d4 6b f8 48 8b 03 48 89 5c 24
> RSP: 0018:ffffc90004266940 EFLAGS: 00010203
> RAX: 000000000000004c RBX: 0000000000000265 RCX: 0000000000002000
> RDX: 0000000000001000 RSI: ffffffff8c610a80 RDI: ffffffff8c610a40
> RBP: ffffc90004266a50 R08: 0000000000000920 R09: 00000000ffffffff
> R10: dffffc0000000000 R11: fffffbfff203ac56 R12: dffffc0000000000
> R13: 1ffff9200084cd38 R14: ffff88802172e126 R15: 1ffff9200084cd34
> FS:  00007ff6558636c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff655821d58 CR3: 0000000012380000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  dev_get_valid_name net/core/dev.c:1199 [inline]
>  register_netdevice+0x542/0x1b00 net/core/dev.c:10509
>  veth_newlink+0x455/0xc10 drivers/net/veth.c:1819
>  rtnl_newlink_create+0x2df/0xa30 net/core/rtnetlink.c:3774
>  __rtnl_newlink net/core/rtnetlink.c:3891 [inline]
>  rtnl_newlink+0x17dd/0x24f0 net/core/rtnetlink.c:4001
>  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6903
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:744
>  ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2609
>  ___sys_sendmsg net/socket.c:2663 [inline]
>  __sys_sendmsg+0x292/0x380 net/socket.c:2692
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff6558ea759
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff655863218 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007ff655974368 RCX: 00007ff6558ea759
> RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000006
> RBP: 00007ff655974360 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000009 R11: 0000000000000246 R12: 00007ff65597436c
> R13: 00007ff655941074 R14: 006e75742f74656e R15: 74656e2f7665642f
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:dev_prep_valid_name+0x3e3/0xa40 net/core/dev.c:1165
> Code: 20 08 00 00 e8 6e 50 27 fb 48 85 c0 0f 84 8f 04 00 00 48 89 44 24 3=
8 48 8b 5c 24 30 48 81 c3 68 02 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00=
 74 08 48 89 df e8 ce d4 6b f8 48 8b 03 48 89 5c 24
> RSP: 0018:ffffc90004266940 EFLAGS: 00010203
> RAX: 000000000000004c RBX: 0000000000000265 RCX: 0000000000002000
> RDX: 0000000000001000 RSI: ffffffff8c610a80 RDI: ffffffff8c610a40
> RBP: ffffc90004266a50 R08: 0000000000000920 R09: 00000000ffffffff
> R10: dffffc0000000000 R11: fffffbfff203ac56 R12: dffffc0000000000
> R13: 1ffff9200084cd38 R14: ffff88802172e126 R15: 1ffff9200084cd34
> FS:  00007ff6558636c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff655821d58 CR3: 0000000012380000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   20 08                   and    %cl,(%rax)
>    2:   00 00                   add    %al,(%rax)
>    4:   e8 6e 50 27 fb          call   0xfb275077
>    9:   48 85 c0                test   %rax,%rax
>    c:   0f 84 8f 04 00 00       je     0x4a1
>   12:   48 89 44 24 38          mov    %rax,0x38(%rsp)
>   17:   48 8b 5c 24 30          mov    0x30(%rsp),%rbx
>   1c:   48 81 c3 68 02 00 00    add    $0x268,%rbx
>   23:   48 89 d8                mov    %rbx,%rax
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   42 80 3c 20 00          cmpb   $0x0,(%rax,%r12,1) <-- trapping in=
struction
>   2f:   74 08                   je     0x39
>   31:   48 89 df                mov    %rbx,%rdi
>   34:   e8 ce d4 6b f8          call   0xf86bd507
>   39:   48 8b 03                mov    (%rbx),%rax
>   3c:   48                      rex.W
>   3d:   89                      .byte 0x89
>   3e:   5c                      pop    %rsp
>   3f:   24                      .byte 0x24
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

