Return-Path: <linux-kernel+bounces-260091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7E893A2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D2C1F24583
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B209D154455;
	Tue, 23 Jul 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fHD7deP5"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D6139D1A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745504; cv=none; b=pn40IgMKjIHV50sphoez9W1dYXMw/wSyXWKrQDmj1XncuAIC7EjsqIA4wr4zZ3OtNySh3pJtxdj1gZikRE24KRDnPLzazPwJxBrT1ryRVEfUEp5xqOk59lB1k2e9DEFFz+gejSHU8dhIycspa1TuTOpX9p3Fe70DU72yyWDhxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745504; c=relaxed/simple;
	bh=UkiSE396ePQGzDozftjIjyhqALc4Ne+Ieift/3jKifg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uqVwYGy+hgJ179nZgven/WxEvDJKEf+oy3fp90vvD9xR2Ns2EvaJoS7FX1i/t6jg5V8MyFiF9PO3iLuyhTJ6E96lmV9pyVAI0DDSmYG8CTX5zdizCGme37ORJ433ghHRo6LmTcRf37wf3TLc/HyGkD8yWXCaYz9g51DUukdzTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fHD7deP5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efd855adbso4124757e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721745500; x=1722350300; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jg+jcQZKkeo38dU9kmt0SGXm4qBb0d76OYWNA0jUc+s=;
        b=fHD7deP50clLmyes6kmDwW8JUIyp5WtJYt6kqDLFt5qTJe9T8eDKnsl7uIh5U0WZhh
         PHpCK7KFlLDUKMsqkM00VMXFKRV4XmDwQ8J8vIMnkAdefZXD12W9x5Vwj1jeo4LD0NSi
         YBpSq3HSOUA5OzeJWrsNiRgvZNVJp1U7igdYNpKuG93s0vf2zjJ+4lO/5W7MGsKqc0os
         VXDaxNt0ZyLqcHsQufpXM8RKZOrV0ed4JZ9e0EiLKmIijLo2miQVM9PAt8F5LDhbk5iD
         XDWyBvInSEFejgtzfQuS+IMHY6CwZ6HxmXv6LvK/7Wk77eYrHLTdbYv432n7ZycRZRXR
         dEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745500; x=1722350300;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jg+jcQZKkeo38dU9kmt0SGXm4qBb0d76OYWNA0jUc+s=;
        b=Vn5tkQGBo9uzRo1NNNh056yM1aWoLjQ9RAY9Tvt69KieT39kEteYZ+x9I2TynyuftT
         fDwQsmbWJy+C32SDP+MuzjvusjtKdhFa9DiValSbaohxrQrfHD4eb/Rq6OJzfbJvKGSf
         +mjjWv7N9fZZWmZ+44a3ZbKdSTkzIfe8tmHbSpTUGECJn1QavGLcHwfzGU+hnd74EkDA
         MhGyrIhzksU1YQcbzBKJAlDgdW54dkH0wByh6+7d5fGZ1ENGud+WUxFsrPF7kLCyKZzt
         TYpCQ1ULbtHQ0XxrM/cEEAsqkrtj3qSf0QBhaWZryxztgvxO/LqeeKoeayWZO6iVm2E0
         ICzw==
X-Forwarded-Encrypted: i=1; AJvYcCXoXLxefQMQZNrcUxXLEqOxG2BsViHE5pq1iGolkpcTjYfVd2LA4AvRqQUwX4AD9Z/IP85UtCZghXi8amOZ5m+iYNSZU9hmj7GFFsg2
X-Gm-Message-State: AOJu0Yw6rocRojf34PJZMpBjfa6+ds9q7kDhKtU8lieK6/gZ4aBOCfPc
	+KJZaJqndvbbQrp5qS3qQHGEpqxpfFCgRo7wJTJLalW93aErBkTPikhF4JSshIs=
X-Google-Smtp-Source: AGHT+IFBmGzfAhsfiD5pOAgos6yWdCop7BhHF9ssBVZM4QDA++J0IpGoWZxLeYDeHAquRAF7v8yqug==
X-Received: by 2002:a05:6512:3b95:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-52fc40739bamr2220959e87.49.1721745500302;
        Tue, 23 Jul 2024 07:38:20 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c922d81sm548885366b.160.2024.07.23.07.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:38:20 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:38:18 +0200
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
Subject: [GIT PULL] printk for 6.11
Message-ID: <Zp-_7R49fIHgIhaq@pathway.suse.cz>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11

===========================================

Next preparation step for introducing printk kthreads. This part
wires up flushing consoles via con->write_atomic() callback.

The write_atomic() callback can be used for flushing nbcon consoles
in any context. It is needed when the console could not be reliably
flushed using the printk kthread. Namely, it is used:

  - During the early boot, from the legacy loop in console_unlock().
    It allows to see the messages before processes (kthreads) could
    get started.

    Note that it must be used as long as there is a boot console
    registered. The console_lock() serializes accesses to the same
    HW port between the early and normal console driver.

  - In an emergency section, directly from nbcon_cpu_emergency_exit()
    or nbcon_cpu_emergency_flush(). It allows to see the messages
    when the system is in an unexpected state and might not be
    able to continue properly.

    The messages are flushed at the end of the emergency section
    to allow storing the full log (backtrace) first. It helps to
    see it even when other CPUs add messages in parallel. The flush()
    API is used to explicitly flush parts of longer logs which might
    not fit into the buffer or might cause a softlockup.

    The emergency section is used for WARN(), Oops, RCU stall,
    and lockdep reports.

  - In panic(), directly from printk() on the panic-CPU. Note that
    other CPUs are not allowed to add new messages at this point.

There is also a new uart_port_lock() API in serial_core.h. It allows to
take port->lock and also acquire the nbcon console context when
the particular port gets registered as a console.

The port->lock serializes code for non-printing activities, for example,
for writing or setting the port speed. The nbcon context allows to
serialize the access in emergency or panic situations where the classic
spin lock (port->lock) could cause a deadlock. Note that the nbcon
context allows a safe takeover in the middle of a printed message.

IMPORTANT: The changes do not affect the behavior of legacy consoles,
    except for two situations:

  - Legacy consoles are not longer flushed directly from printk()
    in emergency sections. The flush is done on exit from
    the emergency section or by nbcon_cpu_emergency_flush().
    The motivation is the same as for nbcon consoles.

  - Legacy consoles are not longer flushed directly from printk()
    in panic() when crash dump is created and a nbcon console
    is registered. They could create a deadlock in compare with
    nbcon consoles.

----------------------------------------------------------------
Jeff Johnson (1):
      vsprintf: add missing MODULE_DESCRIPTION() macro

John Ogness (25):
      printk: Add notation to console_srcu locking
      printk: nbcon: Remove return value for write_atomic()
      printk: nbcon: Add detailed doc for write_atomic()
      printk: nbcon: Add callbacks to synchronize with driver
      printk: nbcon: Use driver synchronization while (un)registering
      serial: core: Provide low-level functions to lock port
      serial: core: Introduce wrapper to set @uart_port->cons
      console: Improve console_srcu_read_flags() comments
      nbcon: Add API to acquire context for non-printing operations
      serial: core: Implement processing in port->lock wrapper
      printk: nbcon: Do not rely on proxy headers
      printk: Make console_is_usable() available to nbcon
      printk: Let console_is_usable() handle nbcon
      printk: Add @flags argument for console_is_usable()
      printk: nbcon: Add helper to assign priority based on CPU state
      printk: Track registered boot consoles
      printk: nbcon: Use nbcon consoles in console_flush_all()
      printk: nbcon: Add unsafe flushing on panic
      printk: Avoid console_lock dance if no legacy or boot consoles
      printk: Track nbcon consoles
      printk: Coordinate direct printing in panic
      panic: Mark emergency section in oops
      rcu: Mark emergency sections in rcu stalls
      lockdep: Mark emergency sections in lockdep splats
      printk: nbcon: do not require migration disabled for nbcon_get_cpu_emergency_nesting()

Petr Mladek (2):
      printk: Properly deal with nbcon consoles on seq init
      Merge branch 'rework/write-atomic' into for-linus

Sebastian Andrzej Siewior (1):
      printk: Check printk_deferred_enter()/_exit() usage

Sreenath Vijayan (1):
      printk: Rename console_replay_all() and update context

Thomas Gleixner (3):
      printk: nbcon: Provide function to flush using write_atomic()
      printk: nbcon: Implement emergency sections
      panic: Mark emergency section in warn

 drivers/tty/serial/8250/8250_core.c |   6 +-
 drivers/tty/serial/amba-pl011.c     |   2 +-
 drivers/tty/serial/serial_core.c    |  16 +-
 drivers/tty/sysrq.c                 |   2 +-
 include/linux/console.h             | 112 ++++++--
 include/linux/printk.h              |  37 ++-
 include/linux/serial_core.h         | 117 +++++++-
 kernel/locking/lockdep.c            |  84 +++++-
 kernel/panic.c                      |   9 +
 kernel/printk/internal.h            |  73 ++++-
 kernel/printk/nbcon.c               | 513 ++++++++++++++++++++++++++++++++++--
 kernel/printk/printk.c              | 313 ++++++++++++++++------
 kernel/printk/printk_ringbuffer.h   |   2 +
 kernel/printk/printk_safe.c         |  23 +-
 kernel/rcu/tree_exp.h               |   9 +
 kernel/rcu/tree_stall.h             |  11 +
 lib/test_printf.c                   |   1 +
 lib/test_scanf.c                    |   1 +
 18 files changed, 1194 insertions(+), 137 deletions(-)

