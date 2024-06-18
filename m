Return-Path: <linux-kernel+bounces-219685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642090D67C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D1F1C23239
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDDD1C6B5;
	Tue, 18 Jun 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="dQRkcdX5"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486EDDA6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723062; cv=none; b=Gdvntj6FPtwroR/EMImtTX7SZfUSEiOzrZ0rAO2595YXYSX674yj9ypqCPgzJEl+JLHFBQQVMJKmitqEaNhPCoK4oUUa/BIbiyrLBz41+r78Cl7OAYxN44B5BFKpXkQA5jMKMdqm+IKwqWlcvjd7nc1OvEQ0rxNaiUrFwQL1zHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723062; c=relaxed/simple;
	bh=oNI7wm+Qxqd3SCj8JcCQ4rv2O6lkSDHsI4IM0lVPhwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiELWwafhuqN+kKCmjWEBHAaoJ1mvJx0NMFnYDtmn8IzWDm5ex0iW5YIiF4rw0fXcPcmoFd8VioJ3pOhcJjtO7rvgCD46MfUrgSAjnRqPtkEZNCTF1JwrBLRuyErdmQJfilSTh/yQNISi3vzYCg6RJw82kSqpqG+GBofkuQD010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=dQRkcdX5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so34803775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718723059; x=1719327859; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13sfXGKnATjfKiQ/igSfK3J245EVnxbN3IyXAWPl7PE=;
        b=dQRkcdX51bwFi4EqwpIQQT7cQXP+UusOPBOZAwh/a+E4Iyo+vsjp6Ccr0vDJWm+8Ld
         hRlcoCAtjd59sieUFmJXrPSkRMiaOk96+H/82C9VOb2wwVLjCdpFibWWuKzk3FttO8kD
         sDfkZXao/ouv/0sDUnXD+i7Z8G+FuSloOQkAuO5Fpp7uBqmNDV+2UWyCk+J1ADMUPGDr
         yG0lj38nGHEwMrjMNq1nfGnJsE5Y46mGBkpQ7qcVCNDGd3CRgFCKEQy7YG3TYgcEY3op
         C1Yl0DCS+T5Z+u5TGKeXgUz91sJ6/yhuhjwsGrRC4w1ODh54ArLoqTaVPPxn7+NI3yWA
         sSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718723059; x=1719327859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13sfXGKnATjfKiQ/igSfK3J245EVnxbN3IyXAWPl7PE=;
        b=eWgXpGE4+AyRLgLOmlASTkMcdiFqigzAjKlryLV8R4kSyJ+x2ew1Rz7V/o8ZHyUnzE
         j6eQz+PmjRAzxT4ejKJfoEIKqfWk05PMR0+ZWBbg4Pr1+GGVl3cPg3v9joYSTN+WeEPE
         HnPkrFk5dEaKc0JffW/Ynw4SjWHkqgzHt3drr1WKZ4xgRGLyfz73nVsaIkODdXFb8h/R
         1qCBHfjGSQrwAkb/NA6eN+w0rNPyTmOLTiviJjmrYsHaAeKrRf4KkQX15s+3vsHt9Xkh
         oZC89dv9XSXv85Q8T/COkhhOo+Vm8cELoaRTtFGtJCS5okpZxEybiluXGhP7yMj/XzkJ
         2KEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXal3xOZzYujeXDsJvvhYzYJ8j0YIKc2IeqR8dTT7+cRVGkGdm05RTwsw4X+aHSCuU6BrxqKw5VfggR7FKYhGfwhHrsdIahpKBJJvHw
X-Gm-Message-State: AOJu0YycZjI2quSkaQ2qcnxNEPowCFN7zzgHK1dDnum9URudia0R/iep
	U3J6aoC4iByo+tbB3uukdh54MdSEjA9KIN0pJTdRsiumrB3OGE9dfGKGGl2+QUI=
X-Google-Smtp-Source: AGHT+IEdpKD66dCM7Cva1YKCkJ7f5vumKkaFc5LCpY1Zf69IecrHscE++hQ3VwlsuYfD+9eXHBk49A==
X-Received: by 2002:a05:600c:314a:b0:421:811b:b83e with SMTP id 5b1f17b1804b1-4246f5cfa54mr30393565e9.13.1718723059000;
        Tue, 18 Jun 2024 08:04:19 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509355dsm14279716f8f.13.2024.06.18.08.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:04:18 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:04:17 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling
 update_rq_clock
Message-ID: <20240618150417.kuoft7jqqg6pcjrf@airbuntu>
References: <20240613015837.4132703-1-jstultz@google.com>
 <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu>
 <20240614094833.GM8774@noisy.programming.kicks-ass.net>
 <CANDhNCqcbCJNSyrKG5b7vyjmuHUm0kAJmDecqHF-QRZ_EHq=Zw@mail.gmail.com>
 <CANDhNCrShc0ak2BZN91fR9uj0MM6R20oskoDD-f7++SgPao6vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCrShc0ak2BZN91fR9uj0MM6R20oskoDD-f7++SgPao6vA@mail.gmail.com>

On 06/17/24 21:45, John Stultz wrote:
> On Mon, Jun 17, 2024 at 5:42 PM John Stultz <jstultz@google.com> wrote:
> >
> > Also, separately, while I didn't see this earlier testing on physical
> > devices, when running virtualized, I can pretty easily trip over the
> > following:
> >
> > [   65.207340] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> > [kworker/0:3:374]
> > [   65.211107] irq event stamp: 118664
> > [   65.212786] hardirqs last  enabled at (118663):
> > [<ffffffff97a00e46>] asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [   65.218440] hardirqs last disabled at (118664):
> > [<ffffffff977fdeca>] sysvec_apic_timer_interrupt+0xa/0xc0
> > [   65.223074] softirqs last  enabled at (118546):
> > [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> > [   65.227118] softirqs last disabled at (118541):
> > [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> > [   65.231137] CPU: 0 PID: 374 Comm: kworker/0:3 Not tainted
> > 6.10.0-rc4-dirty #4393
> > [   65.234625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [   65.239089] Workqueue: events psi_avgs_work
> > [   65.241122] RIP: 0010:collect_percpu_times+0xff/0x310
> ...
> > [   65.288730] Call Trace:
> > [   65.289958]  <IRQ>
> > [   65.290965]  ? watchdog_timer_fn+0x275/0x310
> > [   65.293185]  ? __pfx_watchdog_timer_fn+0x10/0x10
> > [   65.295379]  ? __hrtimer_run_queues+0x190/0x3b0
> > [   65.297795]  ? hrtimer_interrupt+0xf9/0x230
> > [   65.299782]  ? __sysvec_apic_timer_interrupt+0x82/0x210
> > [   65.302243]  ? sysvec_apic_timer_interrupt+0x98/0xc0
> > [   65.304590]  </IRQ>
> > [   65.305658]  <TASK>
> > [   65.306708]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [   65.309206]  ? psi_avgs_work+0x3c/0xb0
> > [   65.311001]  ? collect_percpu_times+0xff/0x310
> > [   65.313153]  psi_avgs_work+0x3c/0xb0
> > [   65.314864]  process_one_work+0x1fe/0x700
> > [   65.316782]  ? lock_is_held_type+0xcd/0x120
> > [   65.318782]  worker_thread+0x1c7/0x3b0
> > [   65.320571]  ? __pfx_worker_thread+0x10/0x10
> > [   65.322626]  kthread+0xe0/0x110
> > [   65.324103]  ? __pfx_kthread+0x10/0x10
> > [   65.325853]  ret_from_fork+0x28/0x40
> > [   65.327512]  ? __pfx_kthread+0x10/0x10
> > [   65.329255]  ret_from_fork_asm+0x1a/0x30
> > [   65.331073]  </TASK>
> > [   65.332119] Kernel panic - not syncing: softlockup: hung tasks
> 
> As I've been digging on this some more, I'm still a bit baffled.  The
> kworker seems to get stuck once the irq lands and we don't seem to go
> back to the workqueue work that was in progress. That cpu ends up not
> doing anything but occasionally handling ticks until we crash from the
> softlockup watchdog.
> 
> Interestingly, if I move the psi_account_irqtime() call to be under
> the rq_lock in sched_tick(), as I suggested earlier, I have yet to
> reproduce the problem.
> But I'm still trying to piece together exactly why.

A bit of a guess, but should irq_time_read() be done with interrupts disabled?

