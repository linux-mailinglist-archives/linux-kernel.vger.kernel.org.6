Return-Path: <linux-kernel+bounces-374445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9B9A6A67
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588D01F2357D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632731F8933;
	Mon, 21 Oct 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UlNBehwf"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E811EBA0C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517615; cv=none; b=udJyqVWcAl7/vZbNZ259qSxZxZiThMHS3kNP14yaZ4E0htvTuyL/0K22qagwjGiOT3U3IliuVa3PF9JX5mnFXiYAGRXV869XubBrEK1Cz0vuMZ+IoiGhtee04MR6LEIRcpc8ipwHjNN+RORvT8zcrafpfTz0PEKIzUh9pytVNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517615; c=relaxed/simple;
	bh=Xz7FfdVN7zd3+jJtg9M19VBDU7kqZSw49biDmvDmB0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8f48bakfdSEQ1mC7R4gfDaFiW5gciNYpNI3NOWn45XHwtyr+yQo5ADf/LqQX80k+AR1wua50R+P7EoXI3vcaSMDQD+ldpTZ8KUwlERqUwBvhgZmXt2qhbcddpufKVW+nyPDxoNZ0iDcZcVYQ3UbaUb/ixDBXW0dSmTre/hT3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UlNBehwf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so14747015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729517611; x=1730122411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmMrC2OzRPqpFSTohNG2UKX+gtED3pFdgQ93RqnjCxA=;
        b=UlNBehwfqu3XQ2jJZEePtexeGYnSItLCc+cGxeqA2D3J+gytQ3vf0mE/y3NwMKnGHF
         aTLuaBMzEyhn63Ev4jroLc1vhAhngqMtOIU715r0g1/LX9ynEIESTeFECm1qrbbZmlsF
         97r8DO+a26loZcsyQg/4t77HvHUU5XocwzSVUmXwZrgItEpWTJiJ/J15tpWWuHFWCvNN
         JrCeuAJ83e+AGiIeK2fxnaV6Lsx/qS93sdFXisIm1ubNqut8aUHcoijQ62VsAdp+uBtz
         LFEPlHXbkchUp1szBgA+PFeVH8F8tdHyF+fEGO22Y0WGhI97EMcskPEj33TQ59Y2RzkX
         u+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517611; x=1730122411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmMrC2OzRPqpFSTohNG2UKX+gtED3pFdgQ93RqnjCxA=;
        b=p/Lgrk2LkXpow74E1v1y0CJPNq2TZs+DSQDGneBEs47QuQ75r0nODzhcBYyH48v1Ub
         imtLELx3CZL1qUEo2cfBv/aikqWutD8rrBFWBfqVG5pq5tyPCPfx9OEnPGjtsb5IHu7E
         lZJEMHxqqsTRDiHW9WRsVBle6YCC5Huf9FrY96DISV7c07rVsSeox5B0249+3Q0iknJl
         e5WC5xwU0McAM0Clxbbg6B/KLjjS00eQyomSvgaOe2cxmeybJbHeACbdX5YCvt68l0kF
         zkXXvW8epC33GKGxqdefS8on/ndj+L6RXMCNgl/aI8loSVxSKNd/a1VEv6tobMHJ1yYI
         vjlA==
X-Forwarded-Encrypted: i=1; AJvYcCWryDvC65I1nc4oteC3p6F31G8iXRwwz8xzmNDWFoZZux781oLTYnYET1z2YSY6b0xYUigQ+HuUBd1GEhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHw3iOzk1Io1wivAOUt6wuwMtFSKeO5z+cBOemlGYfaTLsatt
	nZKw7ZkCIAGKdW527K8+ThJIUDXMIOp5dCEZa91tCzOmBf8wla8LAYXlQGIhubs=
X-Google-Smtp-Source: AGHT+IEfW+CIBn8UHEt/2gvUUws+y1TH4gv5C41keK7p1Je1zfNoB3sebbL4+7gAW8SjEaUa8T3WZg==
X-Received: by 2002:a05:600c:1e26:b0:431:51a9:e956 with SMTP id 5b1f17b1804b1-4317b8d64femr85275e9.1.1729517611196;
        Mon, 21 Oct 2024 06:33:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2b46sm57705055e9.36.2024.10.21.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:33:30 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:33:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
Message-ID: <ZxZYKe0t7jWX-_1K@pathway.suse.cz>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
 <84plnz29zv.fsf@jogness.linutronix.de>
 <ZxDl-VcVAI8DGM40@pathway.suse.cz>
 <847ca5rigk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847ca5rigk.fsf@jogness.linutronix.de>

On Fri 2024-10-18 09:20:19, John Ogness wrote:
> On 2024-10-17, Petr Mladek <pmladek@suse.com> wrote:
> > # echo h >/proc/sysrq-trigger
> >
> > produced:
> >
> > [   53.669907] BUG: assuming non migratable context at kernel/printk/printk_safe.c:23
> > [   53.669920] in_atomic(): 0, irqs_disabled(): 0, migration_disabled() 0 pid: 1637, name: bash
> > [   53.669931] 2 locks held by bash/1637:
> > [   53.669936]  #0: ffff8ae680a384a8 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x6e/0xf0
> > [   53.669968]  #1: ffffffff83f226e0 (rcu_read_lock){....}-{1:3}, at: __handle_sysrq+0x3d/0x120
> > [   53.670002] CPU: 2 UID: 0 PID: 1637 Comm: bash Not tainted 6.12.0-rc3-default+ #67
> > [   53.670011] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
> > [   53.670020] Call Trace:
> > [   53.670026]  <TASK>
> > [   53.670045]  dump_stack_lvl+0x6c/0xa0
> > [   53.670064]  __cant_migrate.cold+0x7c/0x89
> > [   53.670080]  printk_loud_console_enter+0x15/0x30
> > [   53.670088]  __handle_sysrq+0x60/0x120
> > [   53.670104]  write_sysrq_trigger+0x6a/0xa0
> > [   53.670120]  proc_reg_write+0x5f/0xb0
> > [   53.670132]  vfs_write+0xf9/0x540
> > [   53.670147]  ? __lock_release.isra.0+0x1a6/0x2c0
> > [   53.670172]  ? do_user_addr_fault+0x38c/0x720
> > [   53.670197]  ksys_write+0x6e/0xf0
> > [   53.670220]  do_syscall_64+0x79/0x190
> > [   53.670238]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > IMHO, the best solution would be to call migrate_disable()/enable()
> > in printk_loud_console_enter()/exit().
> 
> That will not work because migrate_enable() can only be called from
> can_sleep context. Instead, the migrate_disable()/enable() should be at
> the few (one?) call sites where printk_loud_console_enter()/exit() is
> used from task context.

Hmm, if I get it correctly, we could not use migrate_disable() in
__handle_sysrq() because it can be called also in atomic context,
for example:

  + pl010_int()
    + pl010_rx_chars()
      + uart_handle_sysrq_char()
	+ handle_sysrq()
	  + __handle_sysrq()

I do not see any easy way how to distinguish whether it was called in
an atomic context or not.

So, I see three possibilities:

  1. Explicitly call preempt_disable() in __handle_sysrq().

     It would be just around the the single line or the help. But still,
     I do not like it much.


  2. Avoid the per-CPU variable. Force adding the LOUD_CON/FORCE_CON
     flag using a global variable, e.g. printk_force_console.

     The problem is that it might affect also messages printed by
     other CPUs. And there might be many.

     Well, console_loglevel is a global variable. The original code
     had a similar problem.


  3. Add the LOUD_CON/FLUSH_CON flag via a parameter. For example,
     by a special LOGLEVEL_FORCE_CON, similar to LOGLEVEL_SCHED.

     I might work well for __handle_sysrq() which calls the affected
     printk() directly.

     But it won't work, for example, for kdb_show_stack(). It wants
     to show messages printed by a nested functions.


I personally prefer the 2nd variant. It fixes the problem and it
should not make things worse.

Best Regards,
Petr

