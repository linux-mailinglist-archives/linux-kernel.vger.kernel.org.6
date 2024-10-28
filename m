Return-Path: <linux-kernel+bounces-385946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CB9B3D68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFBEB231AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A681F4296;
	Mon, 28 Oct 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eONJorz3"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E8185B54
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152726; cv=none; b=B6UxKaOmm9jU/LLlgVkqqG1ML0P9l89JutNQpODs5Ea248EO0YSOEO8SBqASZDKKPRpUHcjTmgo3bESQhFD2xZ/urFTISOlsc8/CYaV+o+1drkaNH9iIo5ImgN+gOa6TEmb/JE2ukchl8SLM42ofsskw3LFx1+iynM0qA2/gpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152726; c=relaxed/simple;
	bh=uk+VmjtE33HFszyZLI7BP3QA2mx14Mps++FLYyPehKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4TjBS+EMEBbcgAaCEsRMTLmyC5or69VTR/xOrimPX7m5TFhRKX8/RTrhhypMvam/gxU6i2jA9WVroT2Rh4FMvIiIQKy0is7gaPPBKgepSp3fAB4RlUW4kBpn/7HgnJnTUkzbT2GyvqjAmZxSU+IPFuWYYH2HdiKX5udQxfM/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eONJorz3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b149ef910eso397371685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730152723; x=1730757523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=otcSI5ZfVLC7sd2ktiY3XatbWjITKxFZhQOQHrOCnO8=;
        b=eONJorz3bFk526zXDdGYrM89hNMaUcirzR3QENvOUQWSD1ig1ic8Z9+1Rr3xep/hCq
         eo3pxZhLxSuVOzfdUpCiS+H4aKJvuKQPyqw3ZYlTUWhBhzoL+EGoyjmyt44eC1sx04kD
         g8wD5ktL4gZo5dA9HyIenGtu/VnGbfAB0fB5NTcneK+dxHEWTlCWKktJ7xJlqR+jvgUE
         p9Jm3Hziu/L+LkQ9ocz5JMgNzIVF3Qbi6ivdOe0L1V0bOXkHsCWVpgHVkOKhh7aWv0lE
         E34wong7wIrwknzNdqB2bRBOXIcOEX0Wi2oBMr8q82yD07T9DqweRFj9HkI4E4Kbjacc
         Ne9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730152723; x=1730757523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otcSI5ZfVLC7sd2ktiY3XatbWjITKxFZhQOQHrOCnO8=;
        b=SnbSeyr1+69qKnCkSB3MiWU82JqWG9pa++owE+9RaBBgXUiiV2hdeUoG4vzyK1oc8N
         6DL4TY14Hqnfgv1ANbrwKF/wagDypqi7WHvY2oIV9vufGno7WmQ4U5dwjXjzMZ9fEyFk
         vQXQtuSiwIPm+l14LLNjFLAPkPd9rHf6H6tDtxAwVb19lXsq32KsBpJpslyt1ei3FAjR
         fSMcfTKdGxKdxu12JPJ+S5YNYVSnt5D5y5KdTdgqW5fwKDmrdYLKTmEyWkwJnv+qntZz
         KHSvU4KeVd4b3Kk6aRa+jaPuOv44lq6tLwctar3xVFLyivvmYm3vPBJYiQlOh4P1d4MH
         DXfA==
X-Forwarded-Encrypted: i=1; AJvYcCXZHiMdDOrYSFCx8KKi2ti/jSrRGq6qM4SnEyzTEwXMIgWbXtg20JaktLhDQvCTR2HiKl+dLhW+0VEasqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAWxBG7BHucL4pV46QyRViXPRodD5MGmV6v7/Om3Xy4DSE8ZrJ
	Qfpme4N26GY9iAjt4s5zi47DSznHdDe5fVWCSHx/F3wlmFOD7hWxYL7KBA==
X-Google-Smtp-Source: AGHT+IEFj/zutiWi7FAqhRGObCjVh+KFTyrW+MhVlW+sNGKyjD0SpFq2Y/XwSsVnxGcoan6/mcuWxA==
X-Received: by 2002:a05:620a:1a11:b0:7b1:4823:fa84 with SMTP id af79cd13be357-7b193eed7f4mr1456575685a.16.1730152722656;
        Mon, 28 Oct 2024 14:58:42 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d343cefsm359017585a.106.2024.10.28.14.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:58:42 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 73A84120007A;
	Mon, 28 Oct 2024 17:58:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 28 Oct 2024 17:58:41 -0400
X-ME-Sender: <xms:EQkgZ79A1R8R5oF1TtTaTfQ2Xggl_sp3l8FGvPVU3swxGC_gTHIAdQ>
    <xme:EQkgZ3tHAsD2GWj6VYiwV5RPVzr3Utw5Bh6wi2LD31kU6jQ-QJvjD76DWA00MXMy0
    XdDqHrTU8ICBCy6jw>
X-ME-Received: <xmr:EQkgZ5BJ9VODmOBQEtDfwC57RX8nze8BxOpW6TZCY_7k67jFMUG-ysQuQuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdguvgdp
    rhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomhdprhgtphhtthhopehgrhgvgh
    hkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjihhrihhs
    lhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghm
    segrnhgurhhoihgurdgtohhmpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmh
    gv
X-ME-Proxy: <xmx:EQkgZ3ceKxUGXW3Zl59NcsbvBEYFVANmw_3n-jfsEaTBhwnycFy9Bw>
    <xmx:EQkgZwOnskTI3n3CgEYkTOOXzUWGtnCin0lU9BSrRADdECzM3W8qTw>
    <xmx:EQkgZ5lqyNP9P0qxn88mVb0Jd1ePco192lmOUPKxLlum3cNdzmzyQA>
    <xmx:EQkgZ6tqxKGBR2AvwWg37nGexiXDM-3Mr8pJMBwb54_ZqlK-sItqzQ>
    <xmx:EQkgZ6vZywCa9sq2MRGNuBDEY5pPA8XUQbcyPl_pObNrTGMxqVomskIV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 17:58:40 -0400 (EDT)
Date: Mon, 28 Oct 2024 14:58:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: John Stultz <jstultz@google.com>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jirislaby@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	kernel-team@android.com
Subject: Re: Deadlock?: console_waiter/serial8250_ports/low_water_lock with
 6.12-rc
Message-ID: <ZyAJD5IPWRoXhd_B@Boquns-Mac-mini.local>
References: <CANDhNCo8NRm4meR7vHqvP8vVZ-_GXVPuUKSO1wUQkKdfjvy20w@mail.gmail.com>
 <CANDhNCpaJ85EvMvjs+Qpgnohpo_cy96PGXJ7Y3S6SOZ2iaG9aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCpaJ85EvMvjs+Qpgnohpo_cy96PGXJ7Y3S6SOZ2iaG9aA@mail.gmail.com>

On Mon, Oct 28, 2024 at 12:54:35PM -0700, John Stultz wrote:
> On Mon, Oct 28, 2024 at 12:30 PM John Stultz <jstultz@google.com> wrote:
> > * One thread is in virt_spin_lock (lock=lock@entry=0xffffffff843d19a0
> > <serial8250_ports>) at ./arch/x86/include/asm/qspinlock.h:106.  The
> > backtrace there, is similarly going through
> > do_exit()->check_stack_usage()->printk (I suspect blocking all the
> > other cpus), where it hits: serial8250_console_write
> > (up=0xffffffff843d19a0 <serial8250_ports>, s=0xffffffff8434f7e0
> > <printk_shared_pbufs> "[   69.857641] \n", count=<optimized out>) at
> > drivers/tty/serial/8250/8250_port.c:3352,  then into the spinlock
> > code.
> >
> 
> I got a question on IRC about the backtrace for this cpu, so I wanted
> to also share it here as well.
> 

I think the cause of the issue is:

	CPU X					CPU Y
	=====					=====
	uart_write():				console_unlock(): // console lock is held by Y.
	  uart_port_lock();			  __console_flush_and_unlock():
	  __uart_start():			    __console_flush_all():
	    pm_runtime_get():			      console_emit_next_record():
	      __pm_runtime_resume():		        con->write(); <- serial8250_console_write() // will try to acquire uart_port_lock();
	        spin_lock_irqsave(&dev->power.lock, flags):
		  <this triggers the lockdep splats, probably because
		   PM has done some print under "&dev->power.lock">
		  lock_acquire():
		    printk():
		      vprintk_emit():
		        // Because NBCON_PRIO_EMERGENCY is used, and 
		        console_trylock_spinning();

So CPU X has the uart_port_lock() but need the console lock, and CPU Y
has the console lock but need the uart_port_lock().

Regards,
Boqun

> #0  virt_spin_lock (lock=lock@entry=0xffffffff843d19a0
> <serial8250_ports>) at ./arch/x86/include/asm/qspinlock.h:106
> #1  queued_spin_lock_slowpath (lock=lock@entry=0xffffffff843d19a0
> <serial8250_ports>, val=1) at kernel/locking/qspinlock.c:324
> #2  0xffffffff8112954e in queued_spin_lock (lock=0xffffffff843d19a0
> <serial8250_ports>) at ./include/asm-generic/qspinlock.h:114
> #3  do_raw_spin_lock (lock=lock@entry=0xffffffff843d19a0
> <serial8250_ports>) at kernel/locking/spinlock_debug.c:116
> #4  0xffffffff82177e67 in __raw_spin_lock_irqsave
> (lock=0xffffffff843d19a0 <serial8250_ports>) at
> ./include/linux/spinlock_api_smp.h:111
> #5  _raw_spin_lock_irqsave (lock=lock@entry=0xffffffff843d19a0
> <serial8250_ports>) at kernel/locking/spinlock.c:162
> #6  0xffffffff817723d0 in uart_port_lock_irqsave (flags=<synthetic
> pointer>, up=0xffffffff843d19a0 <serial8250_ports>) at
> ./include/linux/serial_core.h:711
> #7  serial8250_console_write (up=0xffffffff843d19a0
> <serial8250_ports>, s=0xffffffff8434f7e0 <printk_shared_pbufs> "[
> 69.857641] \n", count=<optimized out>)
>     at drivers/tty/serial/8250/8250_port.c:3352
> #8  0xffffffff8113ef11 in console_emit_next_record (cookie=<optimized
> out>, handover=<optimized out>, con=0xffffffff82e11e40
> <univ8250_console>)
>     at kernel/printk/printk.c:3092
> #9  console_flush_all (do_cond_resched=do_cond_resched@entry=false,
> next_seq=next_seq@entry=0xffffc9000274fdb8,
> handover=handover@entry=0xffffc9000274fdb3)
>     at kernel/printk/printk.c:3180
> #10 0xffffffff8113f1a3 in __console_flush_and_unlock () at
> kernel/printk/printk.c:3239
> #11 console_unlock () at kernel/printk/printk.c:3279
> #12 0xffffffff8113f745 in vprintk_emit (facility=0, level=<optimized
> out>, dev_info=0x0 <fixed_percpu_data>,
>     fmt=0xffffffff8297cc28 "\0016%s (%d) used greatest stack depth:
> %lu bytes left\n", args=0xffffc9000274fe30) at
> kernel/printk/printk.c:2407
> #13 0xffffffff8113b9d4 in _printk (fmt=fmt@entry=0xffffffff8297cc28
> "\0016%s (%d) used greatest stack depth: %lu bytes left\n") at
> kernel/printk/printk.c:2432
> #14 0xffffffff810994d0 in check_stack_usage () at ./include/linux/pid.h:232
> #15 do_exit (code=code@entry=0) at kernel/exit.c:982
> #16 0xffffffff81099876 in do_group_exit (exit_code=0) at kernel/exit.c:1088
> #17 0xffffffff81099908 in __do_sys_exit_group (error_code=<optimized
> out>) at kernel/exit.c:1099
> #18 __se_sys_exit_group (error_code=<optimized out>) at kernel/exit.c:1097
> #19 __x64_sys_exit_group (regs=<optimized out>) at kernel/exit.c:1097
> #20 0xffffffff81003ab3 in x64_sys_call (regs=<optimized out>,
> nr=<optimized out>) at
> ./arch/x86/include/generated/asm/syscalls_64.h:232
> #21 0xffffffff8216267b in do_syscall_x64 (nr=231,
> regs=0xffffc9000274ff58) at arch/x86/entry/common.c:52
> #22 do_syscall_64 (regs=0xffffc9000274ff58, nr=231) at
> arch/x86/entry/common.c:83
> #23 0xffffffff82200130 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:121
> #24 0x0000000000000000 in ?? ()
> 
> 
> thanks
> -john

