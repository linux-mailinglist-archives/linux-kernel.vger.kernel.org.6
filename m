Return-Path: <linux-kernel+bounces-314155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC196AF50
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C3728714B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567F24317B;
	Wed,  4 Sep 2024 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNoliAk4"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5691A59
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420666; cv=none; b=eL5KFyc1nDD3MzYw2ePUbaNuG2u9WK534J+TYXs2NX69NGE/2oQxe5UQ9TRQdwGBODjPFwqML/qtBwyX056wzWL+9BxE/O6gnvGdRAc+AEbcuIZL6tatBl3OrPYkm4NA4KSyovb3/BUmpCeanz0YtNlXUZb/tKQeA6m2+nbh2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420666; c=relaxed/simple;
	bh=JTy6X61FLb5RXg1R3IF93GYRtQabWigAiN7BYREM5xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoiBEMQXN35faBYiqf1tuCI8jYHrAME+ei2mC01As7k60EAR21rmtR4KRI26KJhWU632us7O32Jbu4F0wvDCW0E4TLa8UiW2gZ0MQRPbTvpjFNliZamwcRpevWh73HVz08RJobKY3MrcF9UiUxd1HIJkZVHGQ5sVJAs6dXtNy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNoliAk4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5353d0b7463so10210209e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725420663; x=1726025463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c86wg7THsnDkrIeS8Dd4r+jYDZqYPMMnscZGwW5aRvM=;
        b=lNoliAk4yVPRtkY/DvW7gOReg6Z3ISIKxMR6oPewkMUQLxLAPOnuW8MgjELKrNi2Ek
         oniH6p8bFd0vtPJ1YK5cs4jpfttH5cAPNrCZENzsZ7fpQz6laA9Bdv+1heVzwC3Eeq5d
         e1byvE+GrNP3OOS5j+s9m/rhYlF7XUpl/lJto8a7QbQjnC7B1A2gp5srssVozLIf0xAI
         2HnshoNXp7MbqsaUBCrqKn28HvkSTTLoq8LX4SqiFzPpkBjTjK9zy32ki4iphjeUvUi4
         M/qgPpVJ3niQMaCnM/CNqAYf2XxNqTeaYOQHv2+QH7TRnDqawaH6uhwslnO3T8nlDaez
         4+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725420663; x=1726025463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c86wg7THsnDkrIeS8Dd4r+jYDZqYPMMnscZGwW5aRvM=;
        b=aiv97XJSNDIYRib9IwlPxDBsOH73IEyU/2vskIIh5jhFtltsAlVHAdncmpbc0OqFXG
         bKWzB9+d218wXmYA5piLyx8E6jYNwcjKGFUfL4ulT2+pEjezws/DIB1FX4Nf6eNRNUfH
         15d5mfhoDHHzmDTLREmdqF0iKgvmEH9u8+HtZ4jjvRs3pZlRrQM9bp79bth39KKx2zjP
         DMZfOU4M6y+G84SYnYWGc93CT1bJUgMT427SOuWnNgxJ3R4g+Ir/g2UkBMw7iro2BiUk
         QoIhOgC/rp4VQl6HbDiVjZd1LqoV6derC0TVMkMHF4ro8+czWGW/EwRTp/haCwzmj1Jb
         bHuA==
X-Gm-Message-State: AOJu0YwQ5kanEdvdoqcClRB7Il/OiGH9z0Fz7PO2mugU+J7jXGOFDfHJ
	cusWLtVeIhRLzyQ1jltCgStNTbmwZj5I6NP8vT9kL4f+77QN/IKuw0I+WYT4x0oiYXuuJoewUbT
	apjUzIODNTN8bxiCRVL0BsBB3KohODMtS
X-Google-Smtp-Source: AGHT+IE6nmGf65u2jrkT0XqDZ+3Slhm1rcdCACc71rKH8ntjrqM2MPbfvPOwnXWJUYMUUxJUUEVh85RQTAlwfKCwxjs=
X-Received: by 2002:a05:6512:108b:b0:52c:df83:a740 with SMTP id
 2adb3069b0e04-53546b54df6mr12791150e87.30.1725420662046; Tue, 03 Sep 2024
 20:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86bd3013-887e-4e38-960f-ca45c657f032.bugreport@valiantsec.com>
In-Reply-To: <86bd3013-887e-4e38-960f-ca45c657f032.bugreport@valiantsec.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 4 Sep 2024 12:30:45 +0900
Message-ID: <CAKFNMokHcFTxGuKXrUykPmpa55S7hY2XPUtudBsRcymSUrDzEQ@mail.gmail.com>
Subject: Re: general protection fault in touch_buffer
To: Ubisectech Sirius <bugreport@valiantsec.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:05=E2=80=AFAM Ubisectech Sirius wrote:
>
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.=
 Recently, our team has discovered a issue in Linux kernel 6.11.0-rc2-g6a0e=
38264012. Attached to the email were a PoC file of the issue.
>
> Stack dump:
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> CPU: 0 UID: 0 PID: 14256 Comm: syz.1.435 Not tainted 6.11.0-rc2-g6a0e3826=
4012 #49
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:perf_trace_block_buffer+0x232/0x590 include/trace/events/block.=
h:24
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 5f 02 00 00 48 b8 00 00 00 0=
0 00 fc ff df 49 8b 56 30 48 8d 7a 34 48 89 f9 48 c1 e9 03 <0f> b6 0c 01 48=
 89 f8 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 9c
> RSP: 0018:ffffc90001957818 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffffe8ffad633a98 RCX: 0000000000000006
> RDX: 0000000000000000 RSI: 1ffff110058c6f97 RDI: 0000000000000034
> RBP: ffffc900019578d8 R08: 0000000000000004 R09: 0000000000000004
> R10: ffffe8ffad6ba000 R11: 0000000000000001 R12: 1ffff9200032af06
> R13: ffffffff8e3a3fe0 R14: ffff88801fb7e2b8 R15: ffffc900019578b0
> FS:  00007f6a432a0640(0000) GS:ffff88802c600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005614bbc3d038 CR3: 000000004c664000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  trace_block_touch_buffer include/trace/events/block.h:54 [inline]
>  touch_buffer+0x178/0x250 fs/buffer.c:64
>  __nilfs_get_folio_block fs/nilfs2/page.c:42 [inline]
>  nilfs_grab_buffer+0x1bb/0x380 fs/nilfs2/page.c:61
>  nilfs_mdt_submit_block+0xa4/0x870 fs/nilfs2/mdt.c:121
>  nilfs_mdt_read_block+0x92/0x3c0 fs/nilfs2/mdt.c:176
>  nilfs_mdt_get_block+0xd2/0xaa0 fs/nilfs2/mdt.c:251
>  nilfs_cpfile_get_checkpoint_block fs/nilfs2/cpfile.c:139 [inline]
>  nilfs_cpfile_set_snapshot fs/nilfs2/cpfile.c:763 [inline]
>  nilfs_cpfile_change_cpmode+0x19f/0x1b70 fs/nilfs2/cpfile.c:1055
>  nilfs_ioctl_change_cpmode fs/nilfs2/ioctl.c:209 [inline]
>  nilfs_ioctl+0x64f/0x1720 fs/nilfs2/ioctl.c:1278
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __x64_sys_ioctl+0x1a1/0x210 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6a4259712d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6a4329ff98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f6a42735f80 RCX: 00007f6a4259712d
> RDX: 0000000020000080 RSI: 0000000040106e80 RDI: 000000000000000c
> RBP: 00007f6a4261bd8a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f6a42735f80 R15: 00007f6a43280000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:perf_trace_block_buffer+0x232/0x590 include/trace/events/block.=
h:24
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 5f 02 00 00 48 b8 00 00 00 0=
0 00 fc ff df 49 8b 56 30 48 8d 7a 34 48 89 f9 48 c1 e9 03 <0f> b6 0c 01 48=
 89 f8 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 9c
> RSP: 0018:ffffc90001957818 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffffe8ffad633a98 RCX: 0000000000000006
> RDX: 0000000000000000 RSI: 1ffff110058c6f97 RDI: 0000000000000034
> RBP: ffffc900019578d8 R08: 0000000000000004 R09: 0000000000000004
> R10: ffffe8ffad6ba000 R11: 0000000000000001 R12: 1ffff9200032af06
> R13: ffffffff8e3a3fe0 R14: ffff88801fb7e2b8 R15: ffffc900019578b0
> FS:  00007f6a432a0640(0000) GS:ffff88802c600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005614bbc3d038 CR3: 000000004c664000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> ----------------
> Code disassembly (best guess):
>    0:   48 89 fa                mov    %rdi,%rdx
>    3:   48 c1 ea 03             shr    $0x3,%rdx
>    7:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>    b:   0f 85 5f 02 00 00       jne    0x270
>   11:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   18:   fc ff df
>   1b:   49 8b 56 30             mov    0x30(%r14),%rdx
>   1f:   48 8d 7a 34             lea    0x34(%rdx),%rdi
>   23:   48 89 f9                mov    %rdi,%rcx
>   26:   48 c1 e9 03             shr    $0x3,%rcx
> * 2a:   0f b6 0c 01             movzbl (%rcx,%rax,1),%ecx <-- trapping in=
struction
>   2e:   48 89 f8                mov    %rdi,%rax
>   31:   83 e0 07                and    $0x7,%eax
>   34:   83 c0 03                add    $0x3,%eax
>   37:   38 c8                   cmp    %cl,%al
>   39:   7c 08                   jl     0x43
>   3b:   84 c9                   test   %cl,%cl
>   3d:   0f                      .byte 0xf
>   3e:   85                      .byte 0x85
>   3f:   9c                      pushf
>
> Thank you for taking the time to read this email and we look forward to w=
orking with you further.

Thanks for reporting.

The relevant part of the code looks normal.  The NULL pointer
dereference may be due to the buffer head list being broken elsewhere.

I was unable to reproduce this issue with the attached poc program,
but since this seems to be a non-trivial issue, I think the key to
debugging is to establish a reproducible environment.
Do we need to use some special kconfig setting?  Or is the probability
of reproduction low?

Regards,
Ryusuke Konishi

