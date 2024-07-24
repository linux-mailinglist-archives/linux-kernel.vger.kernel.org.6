Return-Path: <linux-kernel+bounces-260971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271D93B119
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D593F285A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CF6158A34;
	Wed, 24 Jul 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EO4x044B"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323A2C1A5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825768; cv=none; b=cWpwHGUYGADjKFNCFTWsH47bvtx303c+9T5vUmqLVHIut9nfOJUN4bMfKwJRbq3Gq11yU0xeUh1OglnJWdu1wf4EsO4C+w3maumwiyuzeHltyQUodqSjdm5uqgW5XNMMaIFJuq/L/KfAI1LF8MNyv4Ac4Mvgc5qJv1kpNIpL4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825768; c=relaxed/simple;
	bh=KJK3kNGk/ZYdaxiirCLp4f4Tlb8LdPTn74kcbCNKjok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAyTsQh4S/Dv7Z486FYuo+/qPWS7SLEStWyRpQpTpw9Ok/Satol1DxEqPUo3d9Tz+CPE2f4hwg5GfvZewMU/uUUxpsSWre8pM9ZKTDttynRZzZJ15IuJE+07yDtrnmu2qGqJXibr06ZiHziFnIt1wjlRifiXyWHkIx4D85gk87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EO4x044B; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so1564202a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721825763; x=1722430563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LBX8L3H3QpEGM3CoAA66+GXUa/86vPMkMdreDTxzZBs=;
        b=EO4x044BeKLhPl7zQ0S1JILJ8AEeCDV7dpxZOFRRZiQSLfAQdBhz0MKGGPg0TE3apa
         Yia1ecNo/hRFuVgU/O4VOf2pDr3U8Zl9r1Z6uTgVWe7j00G4+lkCrQRlpsNm8cTnnyI1
         QeOwhlW1xSN6D+6YHfFSm0RnLCC7MifI+G8bRiJa348udCmt5U40uQxwPUNgwP24tkjC
         JFzZ+FRZEn9g7q0dFwVVzsqNjYsKtUt/glPeZ39+BtUYCQlt9iP1q502G45W9k7wbYhr
         ZBSCGySqDCBWpZdyA7UisQhRnVGnuC40+tmjdrtxBe8MvOZfCvaoZH3W8InkkJVyAqEy
         oH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721825763; x=1722430563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBX8L3H3QpEGM3CoAA66+GXUa/86vPMkMdreDTxzZBs=;
        b=KQAC5rsEO7DpcKuLtAFOUXYhQ8uxb6ZRkhmENoTw8xg3yCGA2plC2H/67FhdH5UlC/
         Jvs1NQsvUvWfRr0Z1JtdFbHl9OTGBdJvcHox9I5b7B8wOsh9lthNOBLz+CPogdsfjcud
         LEsWUD1BntkD9NPGSAXwkoIj0Nl3e8Edhkwh1kV00xcObbToItJyHRxUACDQAxcL7lEF
         PGmBwmbi4VJOSD3sSjRu1E/gpM1bBGhcjiV2l/rPUS1oADNOUpIlZIyoAdX/8GGF4xRz
         OOALSQlM46HMA4438h/zZuJSb9pa6RAXhTrvxXlxKfP1yZkR0CQ2RIn4wVQrZ2iD1rx1
         c+zA==
X-Forwarded-Encrypted: i=1; AJvYcCXWA2Fj5o53owpUYNPw19QqzspkbMcQBYFjNVy55H+FJAcTbpbelfS6OSFpK3kuxOfOL3GwM7LX4C+n/m/EI3L9rTjYI83LnJq54lC8
X-Gm-Message-State: AOJu0YwVL3SZfpxtZUTmesMVMRa79a9X4wAZeXPG+weq2KFJ0TnrzMzq
	R2ofqJOMFgBUO3U8biXHwKBYEz8MX0CCr0X1/Xz5kpOp3GgWQbDv1fskYyj5S85q6DXYSKz5Ktu
	8
X-Google-Smtp-Source: AGHT+IERKATBkSZMgY4kUzG6qzoYpC2VpKGv3Oskd6TJQ17wueFOPvASCqIxlY1v1yDaiOXRlTHvJQ==
X-Received: by 2002:a50:c192:0:b0:5a1:21df:9a5e with SMTP id 4fb4d7f45d1cf-5ab1be53906mr1471786a12.18.1721825763505;
        Wed, 24 Jul 2024 05:56:03 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a4c7e67af1sm6598869a12.56.2024.07.24.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:56:03 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:56:01 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	kernel-team <kernel-team@meta.com>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
Message-ID: <ZqD54dcZUAirxTYg@pathway.suse.cz>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
 <87plrcqyii.fsf@jogness.linutronix.de>
 <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
 <87r0brkvqd.fsf@jogness.linutronix.de>
 <d18ff73a0ef7536f654b63854dc891984319093f.camel@surriel.com>
 <877cdilrko.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cdilrko.fsf@jogness.linutronix.de>

On Thu 2024-07-18 16:15:43, John Ogness wrote:
> On 2024-07-18, Rik van Riel <riel@surriel.com> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index dddb15f48d59..36f40db0bf93 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -1060,6 +1060,8 @@ static int __init log_buf_len_setup(char *str)
> >>  early_param("log_buf_len", log_buf_len_setup);
> >>  
> >>  #ifdef CONFIG_SMP
> >> +static bool vprintk_emit_may_spin(void);
> >> +
> >>  #define __LOG_CPU_MAX_BUF_LEN (1 << CONFIG_LOG_CPU_MAX_BUF_SHIFT)
> >>  
> >>  static void __init log_buf_add_cpu(void)
> >> @@ -1090,6 +1092,7 @@ static void __init log_buf_add_cpu(void)
> >>  }
> >>  #else /* !CONFIG_SMP */
> >>  static inline void log_buf_add_cpu(void) {}
> >> +static inline bool vprintk_emit_may_spin(void) { return true };
> >>  #endif /* CONFIG_SMP */
> >>  
> >>  static void __init set_percpu_data_ready(void)
> >> @@ -2330,6 +2333,8 @@ asmlinkage int vprintk_emit(int facility, int
> >> level,
> >>  
> >>  	/* If called from the scheduler, we can not call up(). */
> >>  	if (!in_sched) {
> >> +		int ret;
> >> +
> >>  		/*
> >>  		 * The caller may be holding system-critical or
> >>  		 * timing-sensitive locks. Disable preemption during
> >> @@ -2344,7 +2349,11 @@ asmlinkage int vprintk_emit(int facility, int
> >> level,
> >>  		 * spinning variant, this context tries to take over
> >> the
> >>  		 * printing from another printing context.
> >>  		 */
> >> -		if (console_trylock_spinning())
> >> +		if (vprintk_emit_may_spin())

I would either open code the check or change the function to
is_printk_cpu_sync_owner().

> >> +			ret = console_trylock_spinning();
> >> +		else
> >> +			ret = console_trylock();
> >> +		if (ret)
> >>  			console_unlock();
> >>  		preempt_enable();
> >>  	}
> >> @@ -4321,6 +4330,15 @@ void console_replay_all(void)
> >>  static atomic_t printk_cpu_sync_owner = ATOMIC_INIT(-1);
> >>  static atomic_t printk_cpu_sync_nested = ATOMIC_INIT(0);
> >>  
> >> +/*
> >> + * As documented in printk_cpu_sync_get_irqsave(), a context holding
> >> the
> >> + * printk_cpu_sync must not spin waiting for another CPU.
> >> + */
> >> +static bool vprintk_emit_may_spin(void)
> >> +{
> >> +	return (atomic_read(&printk_cpu_sync_owner) !=
> >> smp_processor_id());
> >> +}
> >
> > I think what the code would have to do is only trylock, and never
> > spin after taking the printk_cpu_sync_get_irqsave lock.
> 
> That is what the code does. If @printk_cpu_sync_owner is set to the
> current CPU, the context is holding the cpu_sync and will call the
> non-spinning variant, console_trylock().
> 
> However, my first suggestion to defer whenever the cpu_sync is held
> really is the only option because console_unlock() will spin on the uart
> port lock, and that is also not allowed when holding the cpu_sync.

It would have helped if Rick added backtraces from the crash dumps.
He just wrote:

> > CPU A: printk_cpu_sync_get lock -> console_lock
> > CPU B: console_lock -> (nmi) printk_cpu_sync_get lock

My quess is that it looked like:

CPU A				CPU B

				printk()
				  console_try_lock_spinning()
				  console_unlock()
				    console_emit_next_record()
				      console_lock_spinning_enable();
					con->write()
					  spin_lock(port->lock);

printk_cpu_sync_get()
  printk()
    console_try_lock_spinning()
      # spinning and wating for CPU B

				NMI:

				  printk_cpu_sync_get()
				    # waiting for CPU A

=> DEADLOCK


The deadlock is caused under/by printk_cpu_sync_get() but only because
console_try_lock_spinning() is blocked. It is not a true "try_lock"
operation which should never get blocked.

=> The above patch should solve the problem as well. It will cause
   that console_try_lock_spinning() would fail immediately on CPU A.

Note that port->lock can't cause any deadlock in this scenario.
console_try_lock_spinning() will always fail on CPU A until
the NMI gets handled on CPU B.

By other words, printk_cpu_sync_get() will behave as a tail lock
on CPU A because of the failing trylock.

Best Regards,
Petr

