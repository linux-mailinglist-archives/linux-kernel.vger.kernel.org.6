Return-Path: <linux-kernel+bounces-385691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD79B3A78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7662283043
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B5149E00;
	Mon, 28 Oct 2024 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGmOsa6E"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9B173
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143837; cv=none; b=JXtA2bdKCiCpoeh4ENqM/lV8TLVNa3yx6QZ7DcvrntcKYFk6Vv11993U6JSlQdGQOCD4F45udNN+zVdwtn5lK8Vbj950LLQw2GrCFnDREPgqQG47mBb+Odye6Jq4CRYpIqrIyT+A2vk/JMqWINrhMohVHTSeqm0P0OF/ouGrgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143837; c=relaxed/simple;
	bh=+dQGxhlBGjXERLsSIrUME5gPdgt0T04Wn4mJ3d9Xi+8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=el5FjuxRFrnbml8XJ/MNTjzjBAnFfl4SaKVKj6nf8rDx8v2A+jp8v0FwtFYndLu8/emlruY3XRdELgk0YOtNaKUNfo1IYvB7PGR3AX0efHYia2hW67fYFv+pTSVbIBYb8aojsMo78y65F9io+uCpbAaVnrxyVi6pgtuCfi+NxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CGmOsa6E; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e6c754bdso4198683e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730143832; x=1730748632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pjVVDKyMQJcDkO9PRJnNlItLffVmPfb9Vq+C3do3VgA=;
        b=CGmOsa6EmWyKjPMt4ELpdwEg9vvG9p66cu8AblRWz/9q+Rsdg9m1O+JrxVgJHFUVzP
         3+W6gy+O+KcYAkSAuy1JH5MZCSfmgl2Y7GFFUjoVvcPldK0zH/uG/ct5CwRPmRha9PGD
         Vzmr5j66GJWNOeMTdlpgAuIP7jMQMLuMgg3pGNcEt9NeRzVQGNSY4QfejBAFAW8cMOuI
         YjGzsxNFmCmqgDq8v6vVFlj5ZJzhMlV0O9PZQpU4cdJgeOudA9I1N+G6gbMIk1JiX+TK
         6de5h5qmcQkkcob4pGcVxdHj+KZOHrLvnl7tmIvp8bI7Z6xHRi7e/n6MtQVzd1VPVfAg
         3lBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730143832; x=1730748632;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjVVDKyMQJcDkO9PRJnNlItLffVmPfb9Vq+C3do3VgA=;
        b=Tq3DgTeybC+BKg/3s28N5ZRu+wak4LNT+g5tvWGhaxi0H9k+4ZuK9td0+d/PHZYsju
         IUHjsB3t9wPisrKQy8uI6KtzY8birYsYTi/jNzbogkOQrfVVnB4HxbrdwlBGdFeZr5au
         Ibid81+GzedW5iWIBN2gW4TkPZOMrqkITmjkJajSw8qOvlM6RCph+/RsLVrWMw8V4n8x
         DTFxCvGHCP308zlze5vJqTrl2Ew5QiVNR5X024CLepVceu/hHE2nEYujuwNgkInmqVc0
         xBd3tWnIhNTzx4268hEYJInv/JwGnuTmmlEbI72FlEIWEUwJBCJltUUTp98T8Ny05DB3
         E7Nw==
X-Gm-Message-State: AOJu0YyU6FWnnpmm6mR63j9bT81JlXZB6OvQueBZu9ZWMTTmx2jgyMmf
	8jKnAjhmM5qPIdtKoEOLnvswp1B05wbgt/W0IiPp0aYPvf6BRgKOI7aqtbVaz3FlZJwya67LSyj
	nnnBJo8g7O5kfc4nZfS5/WerjvPKXUJ48ObU=
X-Google-Smtp-Source: AGHT+IEknlCPMRNCvofx3rzi6GWUQXVrrGCLEh++KtXDJ2aZq9E5yi9TkDHDS9lLB8s4qnJN58Czh9dx4maNTZZMDzg=
X-Received: by 2002:a05:6512:1189:b0:539:ec87:bc7f with SMTP id
 2adb3069b0e04-53b348d63ddmr4496757e87.19.1730143832280; Mon, 28 Oct 2024
 12:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Stultz <jstultz@google.com>
Date: Mon, 28 Oct 2024 12:30:20 -0700
Message-ID: <CANDhNCo8NRm4meR7vHqvP8vVZ-_GXVPuUKSO1wUQkKdfjvy20w@mail.gmail.com>
Subject: Deadlock?: console_waiter/serial8250_ports/low_water_lock with 6.12-rc
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jirislaby@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

In stress testing my own patches over the weekend, I ran across a hang
that looks unrelated to my changes, so I wanted to raise it with folks
to see if they have seen anything.

I basically left a shell script looping rebooting a qemu system (which
uses a number of in-kernel torture/selftest drivers) over and over,
and on boot the hang happened right as init was starting. On the
serial console I saw:

[   69.661820] Freeing unused kernel image (initmem) memory: 3788K
[   69.669203] Write protecting the kernel read-only data: 28672k
[   69.680557] Freeing unused kernel image (rodata/data gap) memory: 1436K
[   69.758577] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   69.763876] x86/mm: Checking user space page tables
[   69.826932] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   69.832656] Run /init as init process
[   69.841940] mkdir (833) used greatest stack depth: 14272 bytes left
[   69.847347] mkdir (834) used greatest stack depth: 13856 bytes left
[   69.852756] mount (837) used greatest stack depth: 12960 bytes left

Attaching gdb to qemu, I see:
* Most of the non-idle/halted cpus are stuck in:
virt_spin_lock (lock=lock@entry=0xffffffff82c6d3a0 <low_water_lock>)
at ./arch/x86/include/asm/qspinlock.h:106. The backtrace shows they
are being call from  check_stack_usage () at kernel/exit.c:849  from
do_exit (code=code@entry=0) at kernel/exit.c:982

* One thread is in virt_spin_lock (lock=lock@entry=0xffffffff843d19a0
<serial8250_ports>) at ./arch/x86/include/asm/qspinlock.h:106.  The
backtrace there, is similarly going through
do_exit()->check_stack_usage()->printk (I suspect blocking all the
other cpus), where it hits: serial8250_console_write
(up=0xffffffff843d19a0 <serial8250_ports>, s=0xffffffff8434f7e0
<printk_shared_pbufs> "[   69.857641] \n", count=<optimized out>) at
drivers/tty/serial/8250/8250_port.c:3352,  then into the spinlock
code.

* Another thread is stuck in:
console_trylock_spinning () at kernel/printk/printk.c:2031

This one has the most interesting backtrace, as it is going from
ksys_write() -> uart_write() [which takes the uart port_lock] ->
__pm_runtime_resume() -> trying to grab the dev->power.lock, which
trips lockdep, which tries to then printk lockdep details which gets
stuck on console_trylock_spinning.

Full gdb backtrace trace below.

I wanted to raise this in case anyone else has already hit something
similar, or had any ideas as to the root cause.

#0  console_trylock_spinning () at kernel/printk/printk.c:2031
#1  vprintk_emit (facility=0, level=<optimized out>, dev_info=0x0
<fixed_percpu_data>, fmt=0xffffffff82980860 "\0014\nwhich lock already
depends on the new lock.\n\n",
    args=0xffffc90000017a28) at kernel/printk/printk.c:2406
#2  0xffffffff8113b9d4 in _printk (fmt=fmt@entry=0xffffffff82980860
"\0014\nwhich lock already depends on the new lock.\n\n") at
kernel/printk/printk.c:2432
#3  0xffffffff81121319 in print_circular_bug_header
(entry=entry@entry=0xffffffff8418fa50 <list_entries+5712>,
depth=depth@entry=5,
    check_src=check_src@entry=0xffff888100360b58,
check_tgt=check_tgt@entry=0xffff888100360b30) at
kernel/locking/lockdep.c:1968
#4  0xffffffff811213dc in print_circular_bug
(this=this@entry=0xffffc90000017b10, target=0xffffffff8418fa50
<list_entries+5712>,
    check_src=check_src@entry=0xffff888100360b58,
check_tgt=check_tgt@entry=0xffff888100360b30) at
kernel/locking/lockdep.c:2057
#5  0xffffffff811217fe in check_noncircular
(src=src@entry=0xffff888100360b58,
target=target@entry=0xffff888100360b30,
trace=trace@entry=0xffffc90000017c10)
    at kernel/locking/lockdep.c:2206
#6  0xffffffff81122a6b in check_prev_add
(curr=curr@entry=0xffff888100360000,
prev=prev@entry=0xffff888100360b30,
next=next@entry=0xffff888100360b58, distance=1,
    trace=trace@entry=0xffffc90000017c10) at kernel/locking/lockdep.c:3161
#7  0xffffffff81125b0c in check_prevs_add (next=0xffff888100360b58,
curr=0xffff888100360000) at kernel/locking/lockdep.c:3280
#8  validate_chain (chain_key=<optimized out>, chain_head=<optimized
out>, hlock=0xffff888100360b58, curr=0xffff888100360000) at
kernel/locking/lockdep.c:3904
#9  __lock_acquire (lock=lock@entry=0xffff88810b4a2970,
subclass=subclass@entry=0, trylock=trylock@entry=0, read=read@entry=0,
check=<optimized out>, check@entry=1,
    hardirqs_off=<optimized out>, nest_lock=<optimized out>,
ip=<optimized out>, references=<optimized out>, pin_count=<optimized
out>, sync=<optimized out>)
    at kernel/locking/lockdep.c:5202
#10 0xffffffff8112686e in lock_acquire (ip=<optimized out>,
nest_lock=0x0 <fixed_percpu_data>, check=1, read=0, trylock=0,
subclass=0, lock=0xffff88810b4a2970)
    at kernel/locking/lockdep.c:5825
#11 lock_acquire (lock=lock@entry=0xffff88810b4a2970,
subclass=subclass@entry=0, trylock=trylock@entry=0, read=read@entry=0,
check=check@entry=1,
    nest_lock=nest_lock@entry=0x0 <fixed_percpu_data>, ip=<optimized
out>) at kernel/locking/lockdep.c:5790
#12 0xffffffff82177e5f in __raw_spin_lock_irqsave
(lock=0xffff88810b4a2958) at ./include/linux/spinlock_api_smp.h:110
#13 _raw_spin_lock_irqsave (lock=lock@entry=0xffff88810b4a2958) at
kernel/locking/spinlock.c:162
#14 0xffffffff81a4295e in __pm_runtime_resume
(dev=dev@entry=0xffff88810b4a2800, rpmflags=rpmflags@entry=5) at
drivers/base/power/runtime.c:1171
#15 0xffffffff81760715 in pm_runtime_get (dev=0xffff88810b4a2800) at
./include/linux/pm_runtime.h:396
#16 __uart_start (state=state@entry=0xffff8881172b8000) at
drivers/tty/serial/serial_core.c:148
#17 0xffffffff817655c6 in uart_write (tty=<optimized out>,
buf=0xffff888108010800 "Loading, please wait...\n\020",
count=<optimized out>)
    at drivers/tty/serial/serial_core.c:635
#18 0xffffffff81742e1e in process_output_block (nr=24,
buf=0xffff888108010800 "Loading, please wait...\n\020",
tty=0xffff8881080d7000) at drivers/tty/n_tty.c:574
#19 n_tty_write (tty=0xffff8881080d7000, file=<optimized out>,
buf=0xffff888108010800 "Loading, please wait...\n\020", nr=24) at
drivers/tty/n_tty.c:2389
#20 0xffffffff8173dfbe in iterate_tty_write (from=0xffffc90000017e60,
file=0xffff888108154000, tty=0xffff8881080d7000,
ld=0xffff8881080cf060) at drivers/tty/tty_io.c:1015
#21 file_tty_write (file=0xffff888108154000, from=0xffffc90000017e60,
iocb=<optimized out>) at drivers/tty/tty_io.c:1090
#22 0xffffffff8132e756 in new_sync_write (ppos=0xffffc90000017ef0,
len=24, buf=0x55b9dbbffa60 "Loading, please wait...\n",
filp=0xffff888108154000) at fs/read_write.c:590
#23 vfs_write (file=file@entry=0xffff888108154000,
buf=buf@entry=0x55b9dbbffa60 "Loading, please wait...\n",
count=count@entry=24, pos=pos@entry=0xffffc90000017ef0)
    at fs/read_write.c:683
#24 0xffffffff8132ec05 in ksys_write (fd=<optimized out>,
buf=0x55b9dbbffa60 "Loading, please wait...\n", count=24) at
fs/read_write.c:736
#25 0xffffffff8216267b in do_syscall_x64 (nr=1,
regs=0xffffc90000017f58) at arch/x86/entry/common.c:52
#26 do_syscall_64 (regs=0xffffc90000017f58, nr=1) at arch/x86/entry/common.c:83
#27 0xffffffff82200130 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:121
#28 0x00007ffd2cd643c0 in ?? ()

