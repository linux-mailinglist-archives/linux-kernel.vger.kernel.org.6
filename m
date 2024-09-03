Return-Path: <linux-kernel+bounces-312684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DE69699C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB2D281B95
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F251AD25D;
	Tue,  3 Sep 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OpdnXiQg"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755701AD249
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358225; cv=none; b=bEfZn5tu9uFaazAdZLqF2w5Bw4264cwOrUNQYRrhEwoIaWGMnx6R1pejyIT+kl8ytpNrJVWYKWP/RyCpmjRANmTW1IQIemUIgisOWIoIxwHTAFcvv/Uc8BHivl2sYIgjLlzavwiJZkwFQSHtFqxcS1IiTSlfn3BdHuaTZkN5q+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358225; c=relaxed/simple;
	bh=3JCUCGOalfVLf4Pnw13dLNB2prGfR3vFCW0rOQRO6oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7gN9I/ECQ51rpsNqhvFbSf4IBQLUmxamIeGMxAo/0ck8JKsljBqLu2PSAr6wSv0ZKdmlzRfcsmHiufxSM1/r86OoyUK9zZMOkiZX4GGPfRxPbkb/jQANND9bQpGapVUQK7pxcnUSyyE05+wAdQ412q2RyTLSwGA19YxKyoaKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OpdnXiQg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334c4d6829so6444893e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725358221; x=1725963021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpTm6nQFZc7wQpz6maqlrgIsVe85cYLxZDYF4cKpgdg=;
        b=OpdnXiQgKZNsgG44Rg+prk6l7ovmMa6S+66yhUFxyeQwrKglPr7PGahiCFKdVwxRyk
         +l4vRm96Lw9Vg7xlisgBc9rorm4gaxSIYLG2I/G7QnpGY+S+uMcqZir5TmiZuOyAECD3
         RZ3L7qbvyMWYiUJURLH+SEoBtVIxGK8aEru+bHtkHoXXES1jiysS3EJYrb/7XNefAlot
         3jzrwnTPFQBLoH7EB2WWeBNngvutCNHGBoVcdKdqlJ0F3kUR4iz2+vpMsIQ4YSBwj/+s
         oBaURNmdmRh9ivCYbj0PIEemv02BeKmn7tDSbXI2Qd+ocPdKl9EKuEjQKsUU7kR0jumz
         lLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725358221; x=1725963021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpTm6nQFZc7wQpz6maqlrgIsVe85cYLxZDYF4cKpgdg=;
        b=AldSrSfw7WJCgxL1wbOB0xz1ZMjkhpqqvPPuYYNuyUQqoYoRekgIE9cJZSsgo4lrBX
         EFkCqBFsiqVu5TD6VhpcjX3W53A4FdJK4qPJ1qoHnJTZRmDvM6ozfk11VDtb/frEZ3KR
         5Wg3KvDZ6BYpyEPH2sCavPyxguQy731YIGr9BS7lbxzTMlHN42ZTR8WB+w5DIJ/B45pY
         O7pYi9kwIUPRz+WRbyf27aCrMFAp3neGMyENSG5P6JUJ5AfkyHT9OrvmO9BEMAMwi862
         +gATE4vGwA7LB0auQhmTYQKBFXQAspyqkL0ChV/EwnTRIzhUUwprqFDpY0txqm6OMATj
         +Smw==
X-Forwarded-Encrypted: i=1; AJvYcCW2RKE8GNEGgBvGKhVDO60h0SNW/Pwofzc5E+bQtv837NzK+KHxJG2eydn232VraC2C0M+NuPUbNw6AViY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dh4lvTGq4txTJwbzpd5l4ZSI/MywsIpBj7Ytv7h+ENa1RoED
	WE53FoVPQf4j7tKaFxfmzzg1mqQJWXxcenl6N33xNZsTU/xckTXds/IO2nsamv8=
X-Google-Smtp-Source: AGHT+IH6rmCXRDv0fy0gbCWpcCBqnNioaHGYF9fx1Zc5Tw35MyVm7DQG/2SMzWk9yJjBEZhsusRH4A==
X-Received: by 2002:a05:6512:baa:b0:52c:e11e:d493 with SMTP id 2adb3069b0e04-53546b452b7mr9590952e87.26.1725358221267;
        Tue, 03 Sep 2024 03:10:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196ba0sm659228866b.119.2024.09.03.03.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:10:20 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:10:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 09/17] printk: nbcon: Rely on kthreads for
 normal operation
Message-ID: <Ztbgi4-gDvxMYMXw@pathway.suse.cz>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
 <20240830152916.10136-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830152916.10136-10-john.ogness@linutronix.de>

On Fri 2024-08-30 17:35:08, John Ogness wrote:
> Once the kthread is running and available
> (i.e. @printk_kthreads_running is set), the kthread becomes
> responsible for flushing any pending messages which are added
> in NBCON_PRIO_NORMAL context. Namely the legacy
> console_flush_all() and device_release() no longer flush the
> console. And nbcon_atomic_flush_pending() used by
> nbcon_cpu_emergency_exit() no longer flushes messages added
> after the emergency messages.
> 
> The console context is safe when used by the kthread only when
> one of the following conditions are true:
> 
>   1. Other caller acquires the console context with
>      NBCON_PRIO_NORMAL with preemption disabled. It will
>      release the context before rescheduling.
> 
>   2. Other caller acquires the console context with
>      NBCON_PRIO_NORMAL under the device_lock.
> 
>   3. The kthread is the only context which acquires the console
>      with NBCON_PRIO_NORMAL.
> 
> This is satisfied for all atomic printing call sites:
> 
> nbcon_legacy_emit_next_record() (#1)
> 
> nbcon_atomic_flush_pending_con() (#1)
> 
> nbcon_device_release() (#2)
> 
> It is even double guaranteed when @printk_kthreads_running
> is set because then _only_ the kthread will print for
> NBCON_PRIO_NORMAL. (#3)
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/internal.h | 26 ++++++++++++++++++++++
>  kernel/printk/nbcon.c    | 17 ++++++++++-----
>  kernel/printk/printk.c   | 47 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 83 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index a96d4114a1db..8166e24f8780 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -113,6 +113,13 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
>  		/* The write_atomic() callback is optional. */
>  		if (use_atomic && !con->write_atomic)
>  			return false;
> +
> +		/*
> +		 * For the !use_atomic case, @printk_kthreads_running is not
> +		 * checked because the write_thread() callback is also used
> +		 * via the legacy loop when the printer threads are not
> +		 * available.
> +		 */
>  	} else {
>  		if (!con->write)
>  			return false;
> @@ -176,6 +183,7 @@ static inline void nbcon_atomic_flush_pending(void) { }
>  static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
>  						 int cookie, bool use_atomic) { return false; }
>  static inline void nbcon_kthread_wake(struct console *con) { }
> +static inline void nbcon_kthreads_wake(void) { }
>  
>  static inline bool console_is_usable(struct console *con, short flags,
>  				     bool use_atomic) { return false; }
> @@ -190,6 +198,7 @@ extern bool legacy_allow_panic_sync;
>  /**
>   * struct console_flush_type - Define available console flush methods
>   * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
> + * @nbcon_offload:	Offload flush to printer thread
>   * @legacy_direct:	Call the legacy loop in this context
>   * @legacy_offload:	Offload the legacy loop into IRQ
>   *
> @@ -197,6 +206,7 @@ extern bool legacy_allow_panic_sync;
>   */
>  struct console_flush_type {
>  	bool	nbcon_atomic;
> +	bool	nbcon_offload;
>  	bool	legacy_direct;
>  	bool	legacy_offload;
>  };
> @@ -211,6 +221,22 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>  
>  	switch (nbcon_get_default_prio()) {
>  	case NBCON_PRIO_NORMAL:
> +		if (have_nbcon_console && !have_boot_console) {
> +			if (printk_kthreads_running)
> +				ft->nbcon_offload = true;
> +			else
> +				ft->nbcon_atomic = true;
> +		}
> +
> +		/* Legacy consoles are flushed directly when possible. */
> +		if (have_legacy_console || have_boot_console) {
> +			if (!is_printk_legacy_deferred())
> +				ft->legacy_direct = true;
> +			else
> +				ft->legacy_offload = true;
> +		}
> +		break;
> +
>  	case NBCON_PRIO_EMERGENCY:
>  		if (have_nbcon_console && !have_boot_console)
>  			ft->nbcon_atomic = true;
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 8745fffbfbb0..cebdb9936609 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1492,6 +1492,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>  static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>  					   bool allow_unsafe_takeover)
>  {
> +	struct console_flush_type ft;
>  	unsigned long flags;
>  	int err;
>  
> @@ -1521,10 +1522,12 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>  
>  	/*
>  	 * If flushing was successful but more records are available, this
> -	 * context must flush those remaining records because there is no
> -	 * other context that will do it.
> +	 * context must flush those remaining records if the printer thread
> +	 * is not available do it.
>  	 */
> -	if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
> +	printk_get_console_flush_type(&ft);
> +	if (!ft.nbcon_offload &&
> +	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
>  		stop_seq = prb_next_reserve_seq(prb);
>  		goto again;
>  	}
> @@ -1752,17 +1755,19 @@ void nbcon_device_release(struct console *con)
>  
>  	/*
>  	 * This context must flush any new records added while the console
> -	 * was locked. The console_srcu_read_lock must be taken to ensure
> -	 * the console is usable throughout flushing.
> +	 * was locked if the printer thread is not available to do it. The
> +	 * console_srcu_read_lock must be taken to ensure the console is
> +	 * usable throughout flushing.
>  	 */
>  	cookie = console_srcu_read_lock();
> +	printk_get_console_flush_type(&ft);
>  	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
> +	    !ft.nbcon_offload &&
>  	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
>  		/*
>  		 * If nbcon_atomic flushing is not available, fallback to
>  		 * using the legacy loop.
>  		 */
> -		printk_get_console_flush_type(&ft);
>  		if (ft.nbcon_atomic) {
>  			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
>  		} else if (ft.legacy_direct) {
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 55d75db00042..b9378636188e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2384,6 +2384,9 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	if (ft.nbcon_atomic)
>  		nbcon_atomic_flush_pending();
>  
> +	if (ft.nbcon_offload)
> +		nbcon_kthreads_wake();
> +
>  	if (ft.legacy_direct) {
>  		/*
>  		 * The caller may be holding system-critical or
> @@ -2732,6 +2735,7 @@ void suspend_console(void)
>  
>  void resume_console(void)
>  {
> +	struct console_flush_type ft;
>  	struct console *con;
>  
>  	if (!console_suspend_enabled)
> @@ -2749,6 +2753,10 @@ void resume_console(void)
>  	 */
>  	synchronize_srcu(&console_srcu);
>  
> +	printk_get_console_flush_type(&ft);
> +	if (ft.nbcon_offload)
> +		nbcon_kthreads_wake();
> +
>  	pr_flush(1000, true);
>  }
>  
> @@ -3060,6 +3068,7 @@ static inline void printk_kthreads_check_locked(void) { }
>   */
>  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
>  {
> +	struct console_flush_type ft;
>  	bool any_usable = false;
>  	struct console *con;
>  	bool any_progress;
> @@ -3071,12 +3080,21 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  	do {
>  		any_progress = false;
>  
> +		printk_get_console_flush_type(&ft);
> +
>  		cookie = console_srcu_read_lock();
>  		for_each_console_srcu(con) {
>  			short flags = console_srcu_read_flags(con);
>  			u64 printk_seq;
>  			bool progress;
>  
> +			/*
> +			 * console_flush_all() is only for legacy consoles when
> +			 * the nbcon consoles have their printer threads.
> +			 */
> +			if ((flags & CON_NBCON) && ft.nbcon_offload)
> +				continue;

If I get it correctly then we could skip nbcon consoles here also when
ft.nbcon_atomic == true.

In this case, the messages are flushed directly from vprintk_emit() by
nbcon_atomic_flush_pending(). It goes down to
nbcon_atomic_flush_pending_con() which takes care also about parallel
printk() calls.

A question is whether we want this.

On one side, we want to separate the legacy code as much as possible.
And it should be needed only when there is either a boot or legacy
console.

On the other side, the legacy loop has the console_trylock_spinning()
which allows to pass the owner. While nbcon_atomic_flush_pending_con()
leaves the responsibility on the current owner.

Well, the printk kthreads should be started early enough to prevent
softlockups. I hope that the owner steeling trick won't be needed
for nbcon consoles.

In addition, nbcon_atomic_flush_pending_con() allows to flush
the messages directly even in NMI.

So, I think that we go in the right direction. I mean that we really
should handle nbcon consoles in the legacy loop only when there
is a boot console (both ft.nbcon_* == false).

> +
>  			if (!console_is_usable(con, flags, !do_cond_resched))
>  				continue;
>  			any_usable = true;

Best Regards,
Petr

