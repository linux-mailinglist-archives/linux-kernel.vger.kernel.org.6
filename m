Return-Path: <linux-kernel+bounces-267195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43DA940E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DAC2882AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6494B196DA4;
	Tue, 30 Jul 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PTOJIHVz"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D219412C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333043; cv=none; b=tOvyOCAvApD0eqDpGfHIhqbcYImvqL+LninbA1h2uXigbt2cj3ypuCZIlPd5E2zBioq66q7XLyqZjRJnMICvbYnqbDBukpDIa+xKUDNana8ta+Z+IfrvwnaydsHWixWCUPTrKidpd+NdsP9EohfBrfN4TmZs/ODQYvM2iH27Uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333043; c=relaxed/simple;
	bh=W46QDpobovE1qPPB+ZGCspWfP1dF88/cYk09yiXu2IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhlYnRIqK09I3HQ2yxdEOzEVnlI/SZkabvKLXiNbGGj689vg49dbslJVVlluEy7ppwvWXglZU9NHDgyBdrcjaT3VeTwR5LcGBSr2thKL540uywt1r/rQ7fqNNRybTPs9r4gwcTNBuPgNirj03Sq4i2rwIKzzx+/UnYGFweZLbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PTOJIHVz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a10835480bso6508322a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722333040; x=1722937840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dp55CwSJ1d2zUqe8HRuFuu7alLqkkhaTc60rPYE0hc=;
        b=PTOJIHVzxsIsg9Mx8XkhAqYVD4shacCEeY/14vfL7plQNRwbcFVqgsZyclJCkeCMxI
         vpxKYKaRIF1kxjps5l8ZIfIN3yaObf4vS5ILWfUaT8nXfeeWWHObtV/UXyBF1Jnayn1E
         3Id1o0AaxL9j9us6Ih/coDMQx+VhTWnnyYRK1YCC+h9LPGd1Qu2jZx0t7ZlSxlUSS5/K
         spTPt2bq5L7dLFbeRKUUXNp+o8Fop3fkIlvYuAcgz50SnuUECtU19QmTZy/76LBfgzCL
         JwhMgwRQCCzGyXPIJxcqvK46VmoO0pH8kpPB4kmRZRhPm82TzvpcoSdjIet2m6pASb6d
         FuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722333040; x=1722937840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dp55CwSJ1d2zUqe8HRuFuu7alLqkkhaTc60rPYE0hc=;
        b=f7bp+XvtGsDd3fZz8JLXDRudGWeyg81awBf5x/R/SjlMOdHIbDSYlSedY3JeCwquZU
         ocnZhxw8UFyY4KKc8Rtp78ObRBswwyw2L8fRsF2Cf/t2EByl+4yh6BEh8i7XYOIiSJQN
         efIlej+2DCJspOFr+LP0uFF5iFiP8f0Nmwq4SLuCxJ6+UALaEnNuc7l8uxFPMhyrn128
         jkAPIMNMTYlvG50TX6Er6F5EKo+6azDUyMmdpWBwEt9lcu1JBpsTuQWzgGU++8Ev6aHI
         EnybQBlMGZZdXSXtMElzjVXSELbEfrb01mh6R1JbaVO45+XQT/p7tcKRLBulLT7JvMCU
         th4g==
X-Forwarded-Encrypted: i=1; AJvYcCUpy+/nLxMkUc78bLLk9A1fO51UwbPTz9Q4dGmG2WbSBqUkMOCjJquAW0U19aGSsfir59+JVgCi5Z9ZzLphqJ+4CxkfR4Rnt6vXzGpM
X-Gm-Message-State: AOJu0YyytF6Dmanv64X8hdrGn4eVUpmj6qvi+0M5kT7KMZMvWTnyp6Po
	/nwIw5iZ0G3ypCmwU8BvD62Mg/FdrigBYCk90+ZTBrngTv8RKGkTa/joieLFQnI=
X-Google-Smtp-Source: AGHT+IFa66wrocU6YV+xRVVzarV2HNbLX7ZFlUEOVkZcy8nilaUaCiEicS/YmKhDEky+cuz49PtoDw==
X-Received: by 2002:a05:6402:35c8:b0:5af:6f52:c147 with SMTP id 4fb4d7f45d1cf-5b0202ef9b8mr7297493a12.2.1722333039614;
        Tue, 30 Jul 2024 02:50:39 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b03ccsm6975701a12.16.2024.07.30.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:50:39 -0700 (PDT)
Date: Tue, 30 Jul 2024 11:50:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 05/19] printk: Fail pr_flush() if before
 SYSTEM_SCHEDULING
Message-ID: <Zqi3bW7JBR0rOPQN@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-6-john.ogness@linutronix.de>
 <ZqOhNwkJKBSU848O@pathway.suse.cz>
 <87o76kw6sk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o76kw6sk.fsf@jogness.linutronix.de>

On Fri 2024-07-26 16:51:47, John Ogness wrote:
> On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2024-07-22 19:25:25, John Ogness wrote:
> >> A follow-up change adds pr_flush() to console unregistration.
> >> However, with boot consoles unregistration can happen very
> >> early if there are also regular consoles registering as well.
> >> In this case the pr_flush() is not important because the
> >> regular console manually flushes the boot consoles before
> >> unregistering them.
> >
> > It is not much clear what the "manual flush" means. Is it
> > the console_flush_all() in get_init_console_seq()?
> >
> > I would write something like:
> >
> > <proposal>
> > In this case the pr_flush() is not important because all consoles
> > are flushed when checking the initial console sequence number.
> > </proposal>
> 
> Yes, clearer. Thanks.
> 
> >> Allow pr_flush() to fail if @system_state has not yet reached
> >> SYSTEM_SCHEDULING. This avoids might_sleep() and msleep()
> >> explosions that would otherwise occur.
> >
> > What do you mean with the explosion, please?
> > Does it add some warnings into the log?
> > Does it cause extra delays?
> 
> I am certain that I could trigger a splat with might_sleep() using some
> configured preemption mode. But now I cannot reproduce it. However, with
> msleep() it is easy:
> 
> [    0.436739][    T0] printk: legacy console [ttyS0] enabled
> [    0.439820][    T0] printk: legacy bootconsole [earlyser0] disabled
> [    0.446822][    T0] BUG: scheduling while atomic: swapper/0/0/0x00000002

It complains about sheduling while atomic.

> [    0.450491][    T0] 1 lock held by swapper/0/0:
> [    0.457897][    T0]  #0: ffffffff82ae5f88 (console_mutex){+.+.}-{4:4}, at: console_list_lock+0x20/0x70

But it is under a mutex so that scheduling should be possible.

It is weird.

> [    0.463141][    T0] Modules linked in:
> [    0.465307][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc1+ #372
> [    0.469394][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [    0.474402][    T0] Call Trace:
> [    0.476246][    T0]  <TASK>
> [    0.481473][    T0]  dump_stack_lvl+0x93/0xb0
> [    0.483949][    T0]  dump_stack+0x10/0x20
> [    0.486256][    T0]  __schedule_bug+0x68/0x90
> [    0.488753][    T0]  __schedule+0xb9b/0xd80
> [    0.491179][    T0]  ? lock_release+0xb5/0x270
> [    0.493732][    T0]  schedule+0x43/0x170
> [    0.495998][    T0]  schedule_timeout+0xc5/0x1e0
> [    0.498634][    T0]  ? __pfx_process_timeout+0x10/0x10
> [    0.501522][    T0]  ? msleep+0x13/0x50
> [    0.503728][    T0]  msleep+0x3c/0x50
> [    0.505847][    T0]  __pr_flush.constprop.0.isra.0+0x56/0x500
> [    0.509050][    T0]  ? _printk+0x58/0x80
> [    0.511332][    T0]  ? lock_is_held_type+0x9c/0x110
> [    0.514106][    T0]  unregister_console_locked+0xe1/0x450
> [    0.517144][    T0]  register_console+0x509/0x620
> [    0.519827][    T0]  ? __pfx_univ8250_console_init+0x10/0x10
> [    0.523042][    T0]  univ8250_console_init+0x24/0x40
> [    0.525845][    T0]  console_init+0x43/0x210
> [    0.528280][    T0]  start_kernel+0x493/0x980
> [    0.530773][    T0]  x86_64_start_reservations+0x18/0x30
> [    0.533755][    T0]  x86_64_start_kernel+0xae/0xc0
> [    0.536473][    T0]  common_startup_64+0x12c/0x138
> [    0.539210][    T0]  </TASK>
> 
> And then the kernel goes into an infinite loop complaining about:
> 
> 1. releasing a pinned lock
> 2. unpinning an unpinned lock
> 3. bad: scheduling from the idle thread!
> 4. goto 1

Hmm, I have reproduced it as well. I do not understand it much.
But yeah, this is early during the boot and some things does
not work as expected.

I do not see any better solution. I am fine with the patch.

Well, it might we worth adding the above backtrace to the commit
message so that people know what we have seen.

Best Regards,
Petr

