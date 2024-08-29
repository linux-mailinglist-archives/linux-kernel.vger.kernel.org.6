Return-Path: <linux-kernel+bounces-306117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F27B963970
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CC11F24E79
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907854652;
	Thu, 29 Aug 2024 04:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="CogOaLdt";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="osttyEmb"
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD7212D760
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905985; cv=none; b=tl4rxOlufRCsYxW4VQGLU/zTUUl8N+4RhqxP+w5NN0/alPkb9u+MLbvJHyyyntpy8MgqitWKsQeVpxvlVzfqJoBueaUWOrHZvuaqYQvCEBIb8N1KBYapachRhmbmJAI+A4focuoQp/dHfaGR/6WjTGuHUEb7MsUWTdgWyfwtnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905985; c=relaxed/simple;
	bh=YmcfNsyprOkjvzfrqi5ctVS0XMlpOpf8JOWiJUkfNIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Pjy7kjsPZqzS+U3Ft0PJJpOHpRRGUtk23//ME8/sPtdSMyBjxjDQFTgnndW0aAZ6K4NovcJiB9mYRn9J/yaWbcdtCnR+4x3oMI/0fxIwVqqrahom0FcijI6hXOk/bQPJmEoUi4MyD0gp1DpVIiIpctQpzA3Qq3MiNAy+s+6hJSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=CogOaLdt; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=osttyEmb; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724905984; x=1756441984;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=YmcfNsyprOkjvzfrqi5ctVS0XMlpOpf8JOWiJUkfNIg=;
  b=CogOaLdtu37yHizjJfpGzHy0D+x1ls8+0loasxYC51bNOGnPjwkhdjSO
   uSLTRq8q4zZm8apnbJgQ7KVHyDFS7lXeUk6L8BPB7S49W4CHMHvUbxAq6
   y4y40U76cfp+0ViAmQZZYA176jJdH5TGrjecmJI0eTwfkUYV/T3l6GbG5
   nK0J27isqSjblj6Pbl5LwGGlzGY/LvtfytEzH4bexVytiRzg/BhyhFzcA
   Zts0Qe6oB7Cw9D2k1LFVVo6Ftu4CjZNNhVGrk3t97XvC3A26UxoO6sC9V
   avQG+gUjiJhkwocuT1jdL0n9mKFu+06i6vPFRkVhpmMXl23HT9jjgJ04S
   g==;
X-CSE-ConnectionGUID: /XBqQG3lTO22RkEkAqbp8w==
X-CSE-MsgGUID: woeczYq/QEGGIpfml48+5A==
Received: from mail-il1-f200.google.com ([209.85.166.200])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 21:33:03 -0700
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d47fe875cso2622965ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724905982; x=1725510782; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19ZCMa6kbTGd7rUOHNxgUi7pF9KSa2RZc9b0v82EY34=;
        b=osttyEmbVpvVPiAckNp0Xrcj/3tDCClUaXV6/28UoQFNteKKgQPOpIKDn6QX/EgqU7
         AXnClTKekIxSdWIzzqcYVirT+R7NOpN78VqXy5Gf1DHvXcCfp6FejBg2cGRgNziLGJYU
         JaqsYAoT0ZEmBd5xao/lA1BUojQXcBoDf8FeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724905982; x=1725510782;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19ZCMa6kbTGd7rUOHNxgUi7pF9KSa2RZc9b0v82EY34=;
        b=WVu9sXEVDvnXZ3oGSnBJC2lT7S/Q966y59mOcWFAEbR6pHm6lCaeMyfWah5SQdrB4w
         nldCiPhlQEyE1aDV65RjzG34ruV8hsaezJUcTza9XICk8ybtXEAAlBgqHak5G0HpwBfO
         0ckITPIHQpke5goJgbRFrcfqTijmfjZ9XfeNeh39x2eydRKjqE4Mc8exSLoJ8Ad4bxDk
         QzvNLHF6soeuSkm3iSQ0lqDv3gvldZT3ApSiaXPZ6WQpu/yQ6V88b+55Ki3bdgbEidew
         ZIXC65xWr1NvGb2nQu9BJy8fgJjBB4qKUuxIrBBkLAVJPErmthV4PX+lUfWxlXp1hzAg
         A/hA==
X-Forwarded-Encrypted: i=1; AJvYcCV/IQ2ns7iipUKfXvoenM2PVOdgtLVb5IgtEdPSSfpISVBWKxSxjckIxL8kor27oIM6SWTJnZl60IUUM10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWIUrWOE5AUUbrMeazgU6bsG8ydLCPhsXR48/b8FgVb7FeLm3
	vWnHC7XOtdKUwGyiMYCrCdrXit7S52O8jJwqDl7qeskw8q2ch8ek3IYqsjcB9vk8oeeAy59IrvV
	6yNNk3CPtkMtxEz/Dnv3f5IqXHg9t8THpMjsXPa3KuPEctg12wCyMw45TN9rUoy3G5jLpnif5NV
	s1+QqxdPtP+MLfwy4ghY9Cem/EAWZF1ZvzTRLr0w==
X-Received: by 2002:a05:6e02:1e07:b0:397:351b:2c0c with SMTP id e9e14a558f8ab-39f37846838mr22492685ab.17.1724905982258;
        Wed, 28 Aug 2024 21:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQVvAyP6uQc13zE5AKpikYrGN/JfwFBhDWh/m5FRX7/FYivQ5DKTJW0iyqyzmuzBDE3y6mKqZt1nLBo8UXZZE=
X-Received: by 2002:a05:6e02:1e07:b0:397:351b:2c0c with SMTP id
 e9e14a558f8ab-39f37846838mr22492565ab.17.1724905981844; Wed, 28 Aug 2024
 21:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6gJ4W1rPj=CWG7bFUPpEJnUjEhQd3uvH=7C=aGKb=CUQ@mail.gmail.com>
In-Reply-To: <CALAgD-6gJ4W1rPj=CWG7bFUPpEJnUjEhQd3uvH=7C=aGKb=CUQ@mail.gmail.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 21:32:51 -0700
Message-ID: <CALAgD-6_=C6Cmau94Aoj8NKTeX37y17HYUvwgsJVhs5-ATTYdQ@mail.gmail.com>
Subject: Re: BUG: general protection fault in update_io_ticks
To: "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The above reproducer needs the additional support to run it. And here
is the C reproducer:
https://gist.github.com/freexxxyyy/8d77167be200ccd7e198cab2222ff9e6

On Sat, Aug 24, 2024 at 10:10=E2=80=AFPM Xingyu Li <xli399@ucr.edu> wrote:
>
> Hi,
>
> We found a bug in Linux 6.10. It is probably a null pointer dereference b=
ug.
> The bug report and syzkaller reproducer are as follows:
>
> Bug report:
>
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> CPU: 0 PID: 45 Comm: kworker/u4:3 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: writeback wb_workfn (flush-8:0)
> RIP: 0010:update_io_ticks+0x94/0x2c0 block/blk-core.c:992
> Code: f3 f3 f3 48 89 54 24 18 4a 89 04 32 e8 75 77 59 fd 48 c1 eb 03
> 48 89 5c 24 08 eb 03 4c 8b 2b 49 8d 5d 28 48 89 d8 48 c1 e8 03 <42> 80
> 3c 30 00 74 08 48 89 df e8 6d 82 bc fd 4c 8b 3b 48 8b 44 24
> RSP: 0018:ffffc9000090e620 EFLAGS: 00010206
> RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffff888015330000
> RDX: 0000000000000000 RSI: 0000000100000845 RDI: 0000000000000000
> RBP: ffffc9000090e6d8 R08: ffffffff843a8b4a R09: 1ffffffff1e48be5
> R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: 0000000100000845
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88801d4f2058
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd0a027408 CR3: 00000000232cc000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  blk_account_io_start+0x189/0x2d0 block/blk-mq.c:1022
>  blk_mq_bio_to_request block/blk-mq.c:2559 [inline]
>  blk_mq_submit_bio+0x1043/0x1f40 block/blk-mq.c:2996
>  __submit_bio+0x1bc/0x550 block/blk-core.c:627
>  __submit_bio_noacct_mq block/blk-core.c:708 [inline]
>  submit_bio_noacct_nocheck+0x3ed/0xc20 block/blk-core.c:737
>  ext4_io_submit+0xd4/0x130 fs/ext4/page-io.c:377
>  ext4_do_writepages+0x293b/0x38e0 fs/ext4/inode.c:2699
>  ext4_writepages+0x20c/0x3b0 fs/ext4/inode.c:2768
>  do_writepages+0x36f/0x880 mm/page-writeback.c:2656
>  __writeback_single_inode+0xe2/0x660 fs/fs-writeback.c:1651
>  writeback_sb_inodes+0x8ee/0x1140 fs/fs-writeback.c:1947
>  __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2018
>  wb_writeback+0x3e7/0x750 fs/fs-writeback.c:2129
>  wb_check_old_data_flush fs/fs-writeback.c:2233 [inline]
>  wb_do_writeback fs/fs-writeback.c:2286 [inline]
>  wb_workfn+0xa29/0xf00 fs/fs-writeback.c:2314
>  process_one_work kernel/workqueue.c:3248 [inline]
>  process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
>  worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
>  kthread+0x2eb/0x380 kernel/kthread.c:389
>  ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:update_io_ticks+0x94/0x2c0 block/blk-core.c:992
> Code: f3 f3 f3 48 89 54 24 18 4a 89 04 32 e8 75 77 59 fd 48 c1 eb 03
> 48 89 5c 24 08 eb 03 4c 8b 2b 49 8d 5d 28 48 89 d8 48 c1 e8 03 <42> 80
> 3c 30 00 74 08 48 89 df e8 6d 82 bc fd 4c 8b 3b 48 8b 44 24
> RSP: 0018:ffffc9000090e620 EFLAGS: 00010206
> RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffff888015330000
> RDX: 0000000000000000 RSI: 0000000100000845 RDI: 0000000000000000
> RBP: ffffc9000090e6d8 R08: ffffffff843a8b4a R09: 1ffffffff1e48be5
> R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: 0000000100000845
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88801d4f2058
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd0a027408 CR3: 00000000232cc000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0: f3 f3 f3 48 89 54 24 repz repz xrelease mov %rdx,0x18(%rsp)
>    7: 18
>    8: 4a 89 04 32           mov    %rax,(%rdx,%r14,1)
>    c: e8 75 77 59 fd       call   0xfd597786
>   11: 48 c1 eb 03           shr    $0x3,%rbx
>   15: 48 89 5c 24 08       mov    %rbx,0x8(%rsp)
>   1a: eb 03                 jmp    0x1f
>   1c: 4c 8b 2b             mov    (%rbx),%r13
>   1f: 49 8d 5d 28           lea    0x28(%r13),%rbx
>   23: 48 89 d8             mov    %rbx,%rax
>   26: 48 c1 e8 03           shr    $0x3,%rax
> * 2a: 42 80 3c 30 00       cmpb   $0x0,(%rax,%r14,1) <-- trapping instruc=
tion
>   2f: 74 08                 je     0x39
>   31: 48 89 df             mov    %rbx,%rdi
>   34: e8 6d 82 bc fd       call   0xfdbc82a6
>   39: 4c 8b 3b             mov    (%rbx),%r15
>   3c: 48                   rex.W
>   3d: 8b                   .byte 0x8b
>   3e: 44                   rex.R
>   3f: 24                   .byte 0x24
>
>
> Syzkaller reproducer:
> # {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
> Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
> NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
> KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
> Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
> HandleSegv:false Trace:false LegacyOptions:{Collide:false Fault:false
> FaultCall:0 FaultNth:0}}
> write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
> &(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf=
264340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b=
12ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6=
a300916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53b=
c414539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
> 0xb4)
> r0 =3D syz_open_dev$sg(&(0x7f00000000c0), 0x0, 0x181040)
> ioctl$syz_spec_1724254976_2866(r0, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
> [0x85, 0x8, 0x15, 0xd]})
>
>
> --
> Yours sincerely,
> Xingyu



--=20
Yours sincerely,
Xingyu

