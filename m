Return-Path: <linux-kernel+bounces-366511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F799F6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CDC1F23CED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788E1FAEFE;
	Tue, 15 Oct 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca9c7ntL"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574791F5823
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018550; cv=none; b=GbEj70kSmOctujvRVeeByXKQfDC85SwRZDbgG+8Q6l2+K/FhNyMxIwGKxCXfq+zP2fdIO5wPcZUgEPVRn/neV6Cs2Yy01GJKXC+y9o5oKL3fyv4erqkvRHa9CzGh4+KTtUA1zPHJCnQaQ8vdsh7ft3xvVy2FPLOS/mj/SqwQVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018550; c=relaxed/simple;
	bh=5d+QrChBydD8uNo/Vf9IhMlc6efU/6T5CQw4iWGmA3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0ky7YQ/johtnR+IBk1rRMprk9fUTGr3g0SqfQffsNDVjUVczZrwIpwoG6ndzOtO7S/p2POrHR+4V8GXKvaqEEUWOyVUYyT8vPlIl3Yy74MEbQGo5RhMjG8/HdTsKQZLrBGfYRjVHcpfH3nGnRedHUQpb01VL0S9QEmVyfRld3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca9c7ntL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c942ef8d83so946993a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729018546; x=1729623346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1McI21P9PZLqd9U6cP7b3GlJ67DljIDOMeRqxgFwc/0=;
        b=ca9c7ntLfKDZCN0HY5y0AtLBZ9UfZJVljcj7Bg3we4LnAFb9Bm6Ms2sxF7bAra25tX
         +DGo7R9ZhrdEakGh7v2AWF4u21PJQAr/UIMjmf62FWHyiRJihrQXe7BGSdwMjEK/iJxv
         zLpGM984OArYBzEr6U9ATMs9jo4Dqyb8I0sfRwZkXDOhmCweeXYF/vyHKc/pp/nrzs4A
         sSXH+yMmD14DmMiIi2e1ElcND0ryB1LIK6VDb8hT7rQ5FieZt0a6tzzVTuHPn8q2Jxqf
         5vhGJcS8lu8ogFcJUJ6dVWRQoMG0Ef1mila5oVLq9K43/nKOOU4ookV+/16SS4MFYujI
         n/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018546; x=1729623346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1McI21P9PZLqd9U6cP7b3GlJ67DljIDOMeRqxgFwc/0=;
        b=ChsS9Oi7lhU0MOSUIBy/anTlXE9vEjF22tRh+eM+CcfWUveuEei5+ZWH5JEDRBx5aR
         CowTV0WdEBmGfymHi/MIwuBP11dXvLXVcgqu7xCemztNzWd+vVSP/hzbsvnA6Lzcka9e
         VIlUkZI+glbsecNHeriqo/p9etEigJ8rlwnx0oC1AEAf5SK7Fk8m26n2JvLKFUqcybMj
         KOj/8RzT24U1Gcha/JDF38aKSnCia63cTw2T32eKoYekguBelcfBE7tjiJmwlC69zf5/
         +p1kXHf40qpctB1sEm9SnGQog6svmQ2v/T/iuuK4l7P+0V8k11qcXAUnnZb3aR04IbvN
         7vIg==
X-Forwarded-Encrypted: i=1; AJvYcCVgpnH5d1q9ulo+xMbYJ2wzzwcp1qGPMjDyqsTFkZNQcJvqrajIMjYnC8wXUkB7QgvLf/eB4XcUwH/EZwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHiTuxg7eMMFfjHJ0O3XumwmXySYJb++836kG+OKwb5fseLxk
	iEbjdm2vCuOn/5dP4Ypm8icYNuh0FsZ0ghj0Y1mP6da+Uo+4M3cBEXXSglvZfLeDA3Dy5IWCnWP
	14ojzj2NrdFsg6+iJWsW53OuRs1A=
X-Google-Smtp-Source: AGHT+IEnIrWPn6BdfY8D+/ZV0NE9hzC6N6RuNxDo5Kqh8Qd5r/tnoBMtmSZsOsDflvnmVO4MhpxFwpgPBmPs9pOQFcM=
X-Received: by 2002:a05:6402:5210:b0:5c9:85d3:7e9b with SMTP id
 4fb4d7f45d1cf-5c997c0f6bbmr28258a12.0.1729018545495; Tue, 15 Oct 2024
 11:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jwijTP5fre8woS4JVJQ8iUA6v+iNcsOgtj9Zfpc3obDOQ@mail.gmail.com>
In-Reply-To: <CAJg=8jwijTP5fre8woS4JVJQ8iUA6v+iNcsOgtj9Zfpc3obDOQ@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Tue, 15 Oct 2024 11:55:34 -0700
Message-ID: <CAJg=8jxg=hCxTeNMmtUTKeBhP=4ryoAb0ekoP05FOLjmDN5G0g@mail.gmail.com>
Subject: Re: WARNING in get_pat_info
To: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Hope you are doing well!

Quick update from our side: The reproducer from the previous email
still triggers a WARNING on v5.15 (commit hash
3a5928702e7120f83f703fd566082bfb59f1a57e). Happy to also test on
other kernel versions if that helps.

Please let us know if there is any other helpful information we can provide=
.

Wishing you a nice day!

Best,
Marius

On Thu, 18 Apr 2024 at 13:11, Marius Fleischer
<fleischermarius@gmail.com> wrote:
>
> Hi,
>
>
> We would like to report the following bug which has been found by our mod=
ified version of syzkaller.
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> description: WARNING in get_pat_info
>
> affected file: arch/x86/mm/pat/memtype.c
>
> kernel version: 5.15.156
>
> kernel commit: c52b9710c83d3b8ab63bb217cc7c8b61e13f12cd
>
> git tree: upstream
>
> kernel config: attached
>
> crash reproducer: attached
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> Crash log:
>
> WARNING: CPU: 0 PID: 100140 at arch/x86/mm/pat/memtype.c:1020 get_pat_inf=
o+0x212/0x270 arch/x86/mm/pat/memtype.c:1020
>
> Modules linked in:
>
> CPU: 0 PID: 100140 Comm: syz-executor.3 Not tainted 5.15.156 #1
>
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
>
> RIP: 0010:get_pat_info+0x212/0x270 arch/x86/mm/pat/memtype.c:1020
>
> Code: c1 ea 03 80 3c 02 00 75 71 49 89 1e eb 92 e8 25 68 42 00 0f 0b e9 9=
b fe ff ff 41 bc ea ff ff ff e9 7b ff ff ff e8 0e 68 42 00 <0f> 0b 41 bc ea=
 ff ff ff e9 69 ff ff ff 4c 89 ff e8 d9 67 8a 00 e9
>
> RSP: 0018:ffffc900044cf718 EFLAGS: 00010216
>
> RAX: 000000000002315b RBX: ffff88801994db58 RCX: ffffc90004571000
>
> RDX: 0000000000040000 RSI: ffffffff81355ee2 RDI: 0000000000000007
>
> RBP: ffffc900044cf7d0 R08: 0000000000000000 R09: ffffc900044cf6a0
>
> R10: 0000000000000020 R11: 0000000000086082 R12: 0000000000000028
>
> R13: 1ffff92000899ee3 R14: 0000000000000000 R15: ffff88801994dba8
>
> FS:  00007f786237e640(0000) GS:ffff888063e00000(0000) knlGS:0000000000000=
000
>
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>
> CR2: 000000c045391000 CR3: 000000001ee0c000 CR4: 0000000000750ef0
>
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>
> PKRU: 55555554
>
> Call Trace:
>
>  <TASK>
>
>  untrack_pfn+0xdc/0x240 arch/x86/mm/pat/memtype.c:1122
>
>  unmap_single_vma+0x1bc/0x310 mm/memory.c:1589
>
>  unmap_vmas+0x16d/0x2f0 mm/memory.c:1642
>
>  exit_mmap+0x1d0/0x620 mm/mmap.c:3186
>
>  __mmput+0x122/0x4b0 kernel/fork.c:1126
>
>  mmput+0x58/0x60 kernel/fork.c:1147
>
>  dup_mm kernel/fork.c:1481 [inline]
>
>  copy_mm kernel/fork.c:1517 [inline]
>
>  copy_process+0x7ca5/0x8730 kernel/fork.c:2206
>
>  kernel_clone+0xe7/0x9f0 kernel/fork.c:2604
>
>  __do_sys_clone+0xc8/0x110 kernel/fork.c:2721
>
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>
>  entry_SYSCALL_64_after_hwframe+0x66/0xd0
>
> RIP: 0033:0x7f7863e0ed2d
>
> Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>
> RSP: 002b:00007f786237dfd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
>
> RAX: ffffffffffffffda RBX: 00007f7863f4bf80 RCX: 00007f7863e0ed2d
>
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000024080
>
> RBP: 00007f786237e0a0 R08: 0000000000000000 R09: 0000000000000000
>
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
>
> R13: 000000000000000b R14: 00007f7863f4bf80 R15: 00007f786235e000
>
>  </TASK>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
>
> Please note, I used the crashing location to identify relevant maintainer=
s/mailing lists. I hope that is the correct approach in this case. I apolog=
ize in case it is not and would appreciate your help in getting the report =
to the right people/mailing list.
>
>
> From a very brief look, it appears as if one of the two anon_vma_chain_al=
loc calls in mm/rmap.c fails which leads to this warning. I was not able to=
 understand the connection between this allocation failure and the resultin=
g warning though.
>
>
> The attached reproducer is in syzlang format. Please find instructions on=
 how to execute the reproducer here: https://github.com/google/syzkaller/bl=
ob/master/docs/executing_syzkaller_programs.md
>
> Here is also the command we used to execute the reproducer:
>
> ./syz-execprog -executor=3D./syz-executor -procs=3D8 -repeat=3D0 repro.sy=
z
>
>
> Kind regards,
>
> Marius

