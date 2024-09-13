Return-Path: <linux-kernel+bounces-328403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F099782EA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6341F24A39
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692631BC2A;
	Fri, 13 Sep 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bIF+j8as"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB80BA27
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239059; cv=none; b=A64LYA+1rVtGnrB3N6vLFRIkO43vgFP4Oo3BPnjPfNjvvuw3SasPkZIFYyySDqjrbsSMbgRTaKYWwJ5qiTKCDjYgk1OnSOD0Y+4FVG41Y4dw6eMIV/ZK7UysoYsdeHmVsnYqWQcUmLxWX9fChc9MLI7JyE+hcalHTiiVg/z/qZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239059; c=relaxed/simple;
	bh=qQ1fPHhhxO0uJKcUzjVmzqJ4jzMIolTWvCIi9NWyopc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i9RQGYiAVPsl72xN80LNgtm8ydfI6cOTRHywYCz8UcNt6M6zjETqCOIi6fu0fSGcLIq66xCS/1lbebPhIK0VHIQZRlpfdLiPyIyywrh/Hb4Tb7R4Ww5wp6nRFqliAPj2zPsT4Bo//a51lfOL+kHADDk41GKnKbGgZV3OPn2QlyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bIF+j8as; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d56155f51so268257766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726239055; x=1726843855; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/YqolgBvIx1q6+sg7mUiKb9vuKDNpNoFJ+8JhEljDY=;
        b=bIF+j8asDs1Q+GQ+SqxfAimg/YmYTSqSTA3/nWlZWV6/kYTklw7ZXG/V4FOtf1HYUF
         Yge0VgegKGDNG7P6KMHsVbbZ23kBMp3qPn7q7KK8dwLKd67GlV/GDk2H4C/5SdYYrbLz
         2h0QN1yU9oV1N/3rOwfHh9zefvap39M1fD2ZMf2p6H4b2OmzqqEPDfWmVPG32PGd9z6/
         i5pIyln/yzrzlJZmlUn7aB4XR2I9s5otRCF8fo86MwQLL74w3UdzHEMn8Vc8wgRWkTsE
         /BrMIgpUDib+4v/VvQB9k97XH/weYgdIgYSehGaMt/ofdbJpqwDjQ+AlvQYoIAUfU0y9
         D/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726239055; x=1726843855;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/YqolgBvIx1q6+sg7mUiKb9vuKDNpNoFJ+8JhEljDY=;
        b=eHN8hJuU94bTjVxZrbP5Ke0xWAz8kuZkeWBkOlNHphHsVjg3ZCPgQLSgxubx0SqJM5
         w6iNAJAdJhBKPkHr3hA18aXwiD1z1DP0SGJ+hxYYeKVwKboxLjLRiOlkg9Q3NqWN5yS/
         jDVqt9lVcYIX5LqSKH2E3ctBlJFNYRW5NcLKYJsqS/uGcxffFjyjLxVFHoE6lnvlxRz3
         TZ5efs9uQ0GZTibc/9nFxMceuekWM5y6AvTWYsaduDpXmhKbUjeazWRiv6YDA88X/+aN
         O1VdwSS18pBOtNG11ToFWKmm2lAY+AcxpE8a6bwf4cAMDzNFxsRMmsnmWSWWEjJCnd46
         18Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXPc/R8G+08XfeaLiEECkZh4xYHZly0B87xqdYFmu1CC9P7eYOm+kk2exYAwZMh1mTO57mwMG4AQ2cQt9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDaqI26GlW1dk0q85Ignx/zBN1ELhgyd2vrvJitt0GAFT7FAq
	SJMpujeSxOxgvK03JF5JTgGYvaqX/+ulGhi1ASVS7u1HlkwBl/5q/XznOg4siaE=
X-Google-Smtp-Source: AGHT+IHQFzCsX1ZXlE6FCwyTZ9f6v4ASvFh/LChmAvsVbCV0SoKxruN09Ga7WU/bkfUmqnenG4x5lQ==
X-Received: by 2002:a17:906:6a12:b0:a86:8d83:542d with SMTP id a640c23a62f3a-a9029617539mr590616266b.45.1726239055007;
        Fri, 13 Sep 2024 07:50:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61258sm877009866b.116.2024.09.13.07.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 07:50:54 -0700 (PDT)
Date: Fri, 13 Sep 2024 16:50:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.12
Message-ID: <ZuRRTbapH0DCj334@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.12

=============================================

This is the "last" part of the support for the new nbcon consoles.
Where "nbcon" stays for "No Big console lock CONsoles" aka not under
the console_lock.

New callbacks are added to struct console:

  - write_thread() for flushing nbcon consoles in task context.

  - write_atomic() for flushing nbcon consoles in atomic context,
    including NMI.

  - con->device_lock() and device_unlock() for taking the driver
    specific lock, for example, port->lock.

New printk-specific kthreads are created:

  - per-console kthreads which get responsible for flushing normal
    priority messages on nbcon consoles.

  - thread which gets responsible for flushing normal priority messages
    on all consoles when CONFIG_RT enabled.

The new callbacks are called under a special per-console lock which has
already been added back in v6.7. It allows to distinguish three severities:
normal, emergency, and panic. A context with a higher priority could take
over the ownership when it is safe even in the middle of handling a record.
The panic context could do it even when it is not safe. But it is allowed
only for the final desperate flush before entering the infinite loop.

The new lock helps to flush the messages directly in emergency and panic
contexts. But it is not enough in all situations:

  - console_lock() is still need for synchronization against boot consoles.

  - con->device_lock() is need for synchronization against other operations
    on the same HW, e.g. serial port speed setting, non-printk related
    read/write.

The dependency on con->device_lock() is mutual. Any code taking the driver
specific lock has to acquire the related nbcon console context as well.
For example, see the new uart_port_lock() API. It provides the necessary
synchronization against emergency and panic contexts where the messages
are flushed only under the new per-console lock.

Maybe surprisingly, a quite tricky part is the decision how to flush
the consoles in various situations. It has to take into account:

  - message priority:	 normal, emergency, panic

  - scheduling context:	 task, atomic, deferred_legacy

  - registered consoles: boot, legacy, nbcon

  - threads are running: early boot, suspend, shutdown, panic

  - caller:		 printk(), pr_flush(), printk_flush_in_panic(),
			 console_unlock(), console_start(), ...

The primary decision is made in printk_get_console_flush_type(). It creates
a hint what the caller should do:

  - flush nbcon consoles directly or via the kthread

  - call the legacy loop (console_unlock()) directly or via irq_work

The existing behavior is preserved for the legacy consoles. The only
exception is that they are not longer flushed directly from printk() in
panic() before CPUs are stopped. But this blocking happens only when at
least one nbcon console is registered. The motivation is to increase
a chance to produce the crash dump. They legacy consoles might create
a deadlock in compare with nbcon consoles. The nbcon console should
allow to see the messages even when the crash dump fails.

There are three possible ways how nbcon consoles are flushed:

  - The per-nbcon-console kthread is responsible for flushing messages
    added with the normal priority. This is the default mode.

  - The legacy loop, aka console_unlock(), is used when there is still
    a boot console registered. There is no easy way how to match an early
    console driver with a nbcon console driver. And the console_lock()
    provides the only reliable serialization at the moment.

    The legacy loop uses either con->write_atomic() or con->write_thread()
    callbacks depending on whether it is allowed to schedule. The atomic
    variant has to be used from printk().

  - In other situations, the messages are flushed directly using
    write_atomic() which can be called in any context, including NMI.
    It is primary needed during early boot or shutdown, in emergency
    situations, and panic.

The emergency priority is used by a code called within
nbcon_cpu_emergency_enter()/exit(). At the moment, it is used in four
situations: WARN(), Oops, lockdep, and RCU stall reports.

Finally, there is no nbcon console at the moment. It means that the changes
should _not_ modify the existing behavior. The only exception is CONFIG_RT
which would force offloading the legacy loop, for normal priority context,
into the dedicated kthread.

===============================================

Two thirds of the changes has already been in the pull request for 6.11.
The user-visible change is that the flushing is no longer postponed
in the emergency sections. The logic has been further simplified
by using printk_get_console_flush_type() already at this stage.

The new third of the changes added the write_thread() callback,
implemented the kthreads, and updated procfs and sysfs interfaces.

----------------------------------------------------------------
Jinjie Ruan (1):
      printk: Use the BITS_PER_LONG macro

John Ogness (47):
      printk: Add notation to console_srcu locking
      printk: nbcon: Consolidate alloc() and init()
      printk: nbcon: Clarify rules of the owner/waiter matching
      printk: nbcon: Remove return value for write_atomic()
      printk: nbcon: Add detailed doc for write_atomic()
      printk: nbcon: Add callbacks to synchronize with driver
      printk: nbcon: Use driver synchronization while (un)registering
      serial: core: Provide low-level functions to lock port
      serial: core: Introduce wrapper to set @uart_port->cons
      console: Improve console_srcu_read_flags() comments
      nbcon: Add API to acquire context for non-printing operations
      serial: core: Acquire nbcon context in port->lock wrapper
      printk: nbcon: Do not rely on proxy headers
      printk: Make console_is_usable() available to nbcon.c
      printk: Let console_is_usable() handle nbcon
      printk: Add @flags argument for console_is_usable()
      printk: nbcon: Add helper to assign priority based on CPU state
      printk: Track registered boot consoles
      printk: nbcon: Use nbcon consoles in console_flush_all()
      printk: Add is_printk_legacy_deferred()
      printk: nbcon: Flush new records on device_release()
      printk: Flush nbcon consoles first on panic
      printk: nbcon: Add unsafe flushing on panic
      printk: Avoid console_lock dance if no legacy or boot consoles
      printk: Track nbcon consoles
      printk: Coordinate direct printing in panic
      printk: Add helper for flush type logic
      panic: Mark emergency section in oops
      rcu: Mark emergency sections in rcu stalls
      lockdep: Mark emergency sections in lockdep splats
      printk: nbcon: Use raw_cpu_ptr() instead of open coding
      printk: nbcon: Add function for printers to reacquire ownership
      printk: Fail pr_flush() if before SYSTEM_SCHEDULING
      printk: Flush console on unregister_console()
      printk: nbcon: Add context to usable() and emit()
      printk: nbcon: Init @nbcon_seq to highest possible
      printk: nbcon: Relocate nbcon_atomic_emit_one()
      printk: nbcon: Use thread callback if in task context for legacy
      printk: nbcon: Rely on kthreads for normal operation
      printk: Provide helper for message prepending
      printk: nbcon: Show replay message on takeover
      proc: consoles: Add notation to c_start/c_stop
      proc: Add nbcon support for /proc/consoles
      tty: sysfs: Add nbcon support for 'active'
      printk: Implement legacy printer kthread for PREEMPT_RT
      printk: nbcon: Assign nice -20 for printing threads
      printk: Avoid false positive lockdep report for legacy printing

Petr Mladek (1):
      printk: Properly deal with nbcon consoles on seq init

Sebastian Andrzej Siewior (1):
      printk: Check printk_deferred_enter()/_exit() usage

Thomas Gleixner (4):
      printk: nbcon: Provide function to flush using write_atomic()
      printk: nbcon: Implement emergency sections
      panic: Mark emergency section in warn
      printk: nbcon: Introduce printer kthreads

 drivers/tty/serial/8250/8250_core.c |   6 +-
 drivers/tty/serial/amba-pl011.c     |   2 +-
 drivers/tty/serial/serial_core.c    |  16 +-
 drivers/tty/tty_io.c                |   2 +-
 fs/proc/consoles.c                  |   7 +-
 include/linux/console.h             | 158 +++++-
 include/linux/printk.h              |  33 +-
 include/linux/serial_core.h         | 117 ++++-
 kernel/locking/lockdep.c            |  83 +++-
 kernel/panic.c                      |   9 +
 kernel/printk/internal.h            | 207 +++++++-
 kernel/printk/nbcon.c               | 936 +++++++++++++++++++++++++++++++++---
 kernel/printk/printk.c              | 714 ++++++++++++++++++++++-----
 kernel/printk/printk_ringbuffer.h   |   7 +-
 kernel/printk/printk_safe.c         |  25 +-
 kernel/rcu/tree_exp.h               |   7 +
 kernel/rcu/tree_stall.h             |   9 +
 17 files changed, 2125 insertions(+), 213 deletions(-)

