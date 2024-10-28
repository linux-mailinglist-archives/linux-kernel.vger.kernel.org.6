Return-Path: <linux-kernel+bounces-385723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E29B3ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12126B22038
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F5D1DF75C;
	Mon, 28 Oct 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEsQCh1Q"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ACA19006B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145295; cv=none; b=skghDtKFdiDEAHt4g2b1TyI7S39qgiIhL34hgnRnsMjmSp5pzPmQOoC8P6A3yx5K4Gc027a5WPUuB9n8ZupJijY4QbP2pSVVlIZf0GMmiwWXHbnyg8HLR1X1BlVEwhPlCTBErL8w9h7vsyuTPrz/MX7G3CluywJAGdxA3+ZUCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145295; c=relaxed/simple;
	bh=fXxT0tJLQxNoyXrx34i3lmz7ZgJyGcdxlt7aHrBKri8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1NRMKhHm0jvSMCVT/YhA2xiRNWePhbMWVwmDk/RVAYmhwHJnFQFMOPIzHLSfdTTupPl2ZLGWJuEjvBFj1wCDCuJscmCyq4LIDYe6npHeO3hPBFJJ7Sba6w5gQXmz9rJLopZ8+8NEyzC9+jFjQnTJ//tdp1bbY+b5njivQgSV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEsQCh1Q; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99e3b3a411so919674466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730145289; x=1730750089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6S/xT6SLcIlnvtwfNz+Kl8IFPvr8msL6nxzhNKodXM=;
        b=CEsQCh1QVc4mG4zDjyzOGx/k8Hcm/gR9V8OY2sZEWg/GPa5tgBYaRug4eFVhAVeSgl
         4DagGtaNprUlzPRGRb8d0h1qbZ0S4kiY6m/mvXg/uqT3D2AxxqTjfj0NJY+i/wY1tPkJ
         48ml6voftmmQ/BERGFuj7n30ONy/XLPoSowE0RRDjBmexguekQTzHh2KXlEQT7aU1kGU
         5YUEpzZdNG6yjJPnx4NOQpyfUAhkrAEFz+knyw5KRmSSX6ACwDL6n6wemwvYGwUPlOCD
         c+7QAPF7gPIrLa0KqGlNkIM9TDXYSkWuuuin16J8Kps2dW3HMF8lYpHu98lnla6ZscVR
         5iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145289; x=1730750089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6S/xT6SLcIlnvtwfNz+Kl8IFPvr8msL6nxzhNKodXM=;
        b=ByGe8u5JEmhO1p0SB25u3y8Lj03cGR3eyydqnDzydqZZyye4CN4gfWnac/B/8RoDwz
         8pBqwvdCnudLgZZE1dRdWL2NSYlnO6ZBP2d5b3kJ5CSiSYFdVT2Vt8F5sgBvzv7DLLe6
         65Lgr7fK7RQq61YYB3FFh1Qfxk1xtlnpXubV56xpkwsBQDFE5gslG1GY60wC0G0bWpWV
         m11+2/dT5na6hUZfo5lKXGAgA1MxdyMzqB0G3nppTjtHPwbeS2CFtpmitDA1RrJPN3Ur
         kXvFsQ7+Um4fX9FpooGHnCi6KvvpJQ90G/4R9AqiUDsM3jiH6+PHXLvLrLAapb7nYrzE
         fDSw==
X-Gm-Message-State: AOJu0Yzt69I5jHVfcIAkjJxbHwqpYjz6ojpxoE6ldNdE8Wi49VPqAHhX
	fjXvOj2E+cZsp43QxPxTy4IFvGoNrA71yKXnuSclxJDkw9F6MpQiZoD9x2ilVeSp3g+cIomBAcb
	CPtQIbtAF+XXqLAHfzwDAz8m+qGh7gUdPbKE=
X-Google-Smtp-Source: AGHT+IHtgTrLyVOm2Jvj7327qh9e33rLqAbYouP4a/FBFUtE4F2brZ7GWTjbUdHiqbDl4ANtrmoZbfCV6H4zzFBZD1w=
X-Received: by 2002:a17:907:3f84:b0:a9a:f19:8c47 with SMTP id
 a640c23a62f3a-a9e22775058mr57707166b.13.1730145289031; Mon, 28 Oct 2024
 12:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCo8NRm4meR7vHqvP8vVZ-_GXVPuUKSO1wUQkKdfjvy20w@mail.gmail.com>
In-Reply-To: <CANDhNCo8NRm4meR7vHqvP8vVZ-_GXVPuUKSO1wUQkKdfjvy20w@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 28 Oct 2024 12:54:35 -0700
Message-ID: <CANDhNCpaJ85EvMvjs+Qpgnohpo_cy96PGXJ7Y3S6SOZ2iaG9aA@mail.gmail.com>
Subject: Re: Deadlock?: console_waiter/serial8250_ports/low_water_lock with 6.12-rc
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jirislaby@kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 12:30=E2=80=AFPM John Stultz <jstultz@google.com> w=
rote:
> * One thread is in virt_spin_lock (lock=3Dlock@entry=3D0xffffffff843d19a0
> <serial8250_ports>) at ./arch/x86/include/asm/qspinlock.h:106.  The
> backtrace there, is similarly going through
> do_exit()->check_stack_usage()->printk (I suspect blocking all the
> other cpus), where it hits: serial8250_console_write
> (up=3D0xffffffff843d19a0 <serial8250_ports>, s=3D0xffffffff8434f7e0
> <printk_shared_pbufs> "[   69.857641] \n", count=3D<optimized out>) at
> drivers/tty/serial/8250/8250_port.c:3352,  then into the spinlock
> code.
>

I got a question on IRC about the backtrace for this cpu, so I wanted
to also share it here as well.

#0  virt_spin_lock (lock=3Dlock@entry=3D0xffffffff843d19a0
<serial8250_ports>) at ./arch/x86/include/asm/qspinlock.h:106
#1  queued_spin_lock_slowpath (lock=3Dlock@entry=3D0xffffffff843d19a0
<serial8250_ports>, val=3D1) at kernel/locking/qspinlock.c:324
#2  0xffffffff8112954e in queued_spin_lock (lock=3D0xffffffff843d19a0
<serial8250_ports>) at ./include/asm-generic/qspinlock.h:114
#3  do_raw_spin_lock (lock=3Dlock@entry=3D0xffffffff843d19a0
<serial8250_ports>) at kernel/locking/spinlock_debug.c:116
#4  0xffffffff82177e67 in __raw_spin_lock_irqsave
(lock=3D0xffffffff843d19a0 <serial8250_ports>) at
./include/linux/spinlock_api_smp.h:111
#5  _raw_spin_lock_irqsave (lock=3Dlock@entry=3D0xffffffff843d19a0
<serial8250_ports>) at kernel/locking/spinlock.c:162
#6  0xffffffff817723d0 in uart_port_lock_irqsave (flags=3D<synthetic
pointer>, up=3D0xffffffff843d19a0 <serial8250_ports>) at
./include/linux/serial_core.h:711
#7  serial8250_console_write (up=3D0xffffffff843d19a0
<serial8250_ports>, s=3D0xffffffff8434f7e0 <printk_shared_pbufs> "[
69.857641] \n", count=3D<optimized out>)
    at drivers/tty/serial/8250/8250_port.c:3352
#8  0xffffffff8113ef11 in console_emit_next_record (cookie=3D<optimized
out>, handover=3D<optimized out>, con=3D0xffffffff82e11e40
<univ8250_console>)
    at kernel/printk/printk.c:3092
#9  console_flush_all (do_cond_resched=3Ddo_cond_resched@entry=3Dfalse,
next_seq=3Dnext_seq@entry=3D0xffffc9000274fdb8,
handover=3Dhandover@entry=3D0xffffc9000274fdb3)
    at kernel/printk/printk.c:3180
#10 0xffffffff8113f1a3 in __console_flush_and_unlock () at
kernel/printk/printk.c:3239
#11 console_unlock () at kernel/printk/printk.c:3279
#12 0xffffffff8113f745 in vprintk_emit (facility=3D0, level=3D<optimized
out>, dev_info=3D0x0 <fixed_percpu_data>,
    fmt=3D0xffffffff8297cc28 "\0016%s (%d) used greatest stack depth:
%lu bytes left\n", args=3D0xffffc9000274fe30) at
kernel/printk/printk.c:2407
#13 0xffffffff8113b9d4 in _printk (fmt=3Dfmt@entry=3D0xffffffff8297cc28
"\0016%s (%d) used greatest stack depth: %lu bytes left\n") at
kernel/printk/printk.c:2432
#14 0xffffffff810994d0 in check_stack_usage () at ./include/linux/pid.h:232
#15 do_exit (code=3Dcode@entry=3D0) at kernel/exit.c:982
#16 0xffffffff81099876 in do_group_exit (exit_code=3D0) at kernel/exit.c:10=
88
#17 0xffffffff81099908 in __do_sys_exit_group (error_code=3D<optimized
out>) at kernel/exit.c:1099
#18 __se_sys_exit_group (error_code=3D<optimized out>) at kernel/exit.c:109=
7
#19 __x64_sys_exit_group (regs=3D<optimized out>) at kernel/exit.c:1097
#20 0xffffffff81003ab3 in x64_sys_call (regs=3D<optimized out>,
nr=3D<optimized out>) at
./arch/x86/include/generated/asm/syscalls_64.h:232
#21 0xffffffff8216267b in do_syscall_x64 (nr=3D231,
regs=3D0xffffc9000274ff58) at arch/x86/entry/common.c:52
#22 do_syscall_64 (regs=3D0xffffc9000274ff58, nr=3D231) at
arch/x86/entry/common.c:83
#23 0xffffffff82200130 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:=
121
#24 0x0000000000000000 in ?? ()


thanks
-john

