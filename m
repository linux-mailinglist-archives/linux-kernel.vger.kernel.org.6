Return-Path: <linux-kernel+bounces-263343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F40E93D4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F94283175
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735B617B505;
	Fri, 26 Jul 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogEQBQJZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6eVRwarO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE81E521
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002209; cv=none; b=LvkAzrir4CGpbdOolINLfidscRNZqL2SDo1MIw7WH24Dj1ZugjalxFqBgOUMiZumQqtNzLcZijyz660Wqm+4CTTPSsE+SBUf2JUjMQaRxMnnXqbnmhmuyhpa0ER1wrj2kqze3YCXbOKZsrtf35/nd4tjefGVwZZQ13kpEffz00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002209; c=relaxed/simple;
	bh=OdPvvurns1glIMR094bYEnuGMBqAgRUynQ3LTBhpDLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ctHnoJL4F8NCDmIW25aiKubt1WnuwGLawAB7k4GRFjCUoYG/rax02HQooRd68z5+rVnDmNpCarTjGCLyY7b0OBITYHsmPPEeWgaHKTIhC1/wB2wdcCxjLiF32MwOFOGbBir6CxiJbidpjGDrY8b9W73KCKdiIrsD5owS4/UtYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogEQBQJZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6eVRwarO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722002206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CslQJZK9o0FbYK08dNZ8mRXHKazIdTC2ln492EgRRE=;
	b=ogEQBQJZ/Z2VGH7BX9s3cZ1CsYkixizKKv+K2HPJiOyAZK0m/dPE97Fa+HHovrGiAvEimU
	/qubjHcp1chtfJAD7L+u1c9IbaC8bSztQRNEEHx+9qbWHb/Fx5Ne9aGo0ld71AS6XH0Jok
	I+FVU1mo4XfYJP8znGBMHZx14jODADJjTX9H4q/2uNaW+O/hwlYpR7uuOVkH9NeK/IfWwm
	bJPRNBScr7KL0p2AgDdFKDi/n2Dz3hmOTbLn1eGAzohW6vvsjf7J/yBgE1sZXl9qeb51LV
	N3ofZkZelEPY1wLLv7Pc4g6VBqo0oB4Z4767SuFVwFGgRsgCovlAmAKmsDNeXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722002206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CslQJZK9o0FbYK08dNZ8mRXHKazIdTC2ln492EgRRE=;
	b=6eVRwarONg9EYxBVS5EIthshU8geHCP+eIsLz432ft9esUiRnxbUhupWuLQW7JtL7oUDIm
	WeYy1BIAezCmj/DA==
To: Petr Mladek <pmladek@suse.com>, takakura@valinux.co.jp
Cc: rostedt@goodmis.org, senozhatsky@chromium.org,
 akpm@linux-foundation.org, bhe@redhat.com, lukas@wunner.de,
 wangkefeng.wang@huawei.com, ubizjak@gmail.com, feng.tang@intel.com,
 j.granados@samsung.com, stephen.s.brennan@oracle.com,
 linux-kernel@vger.kernel.org, nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH] printk: CPU backtrace not printing on panic
In-Reply-To: <ZqN-oBH5FWJqspMO@pathway.suse.cz>
References: <20240726094437.306330-1-takakura@valinux.co.jp>
 <ZqN-oBH5FWJqspMO@pathway.suse.cz>
Date: Fri, 26 Jul 2024 16:02:45 +0206
Message-ID: <87ttgcw92a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
> I would do it the other way and enable printing from other CPUs only
> when triggring the backtrace. We could do it because
> trigger_all_cpu_backtrace() waits until all backtraces are
> printed.
>
> Something like:
>
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 3130e0b5116b..980bacbdfcfc 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -16,6 +16,7 @@ extern void oops_enter(void);
>  extern void oops_exit(void);
>  extern bool oops_may_print(void);
>  
> +extern int panic_triggering_all_cpu_backtrace;
>  extern int panic_timeout;
>  extern unsigned long panic_print;
>  extern int panic_on_oops;
> diff --git a/kernel/panic.c b/kernel/panic.c
> index f861bedc1925..7e9e97d59b1e 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -64,6 +64,8 @@ unsigned long panic_on_taint;
>  bool panic_on_taint_nousertaint = false;
>  static unsigned int warn_limit __read_mostly;
>  
> +int panic_triggering_all_cpu_backtrace;
> +
>  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>  EXPORT_SYMBOL_GPL(panic_timeout);
>  
> @@ -253,8 +255,12 @@ void check_panic_on_warn(const char *origin)
>   */
>  static void panic_other_cpus_shutdown(bool crash_kexec)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
> +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
> +		/* Temporary allow printing messages on non-panic CPUs. */
> +		panic_triggering_all_cpu_backtrace = true;
>  		trigger_all_cpu_backtrace();
> +		panic_triggering_all_cpu_backtrace = false;

Note, here we should also add

		nbcon_atomic_flush_pending();

Your suggestion allows the other CPUs to dump their backtrace into the
ringbuffer, but they are still forbidden from acquiring the nbcon
console contexts for printing. That is a necessary requirement of
nbcon_waiter_matches().

Or since the cpu_sync is held while printing the backtrace, we could
allow the non-panic CPUs to print by modifying the check in
nbcon_context_try_acquire_direct():

----- BEGIN -----
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index ef6e76db0f5a..cd8724840edc 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -241,7 +241,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 	struct nbcon_state new;
 
 	do {
-		if (other_cpu_in_panic())
+		if (other_cpu_in_panic() && !__printk_cpu_sync_owner())
 			return -EPERM;
 
 		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 613644c55e54..f486d0b84a84 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4569,6 +4569,11 @@ void __printk_cpu_sync_wait(void)
 }
 EXPORT_SYMBOL(__printk_cpu_sync_wait);
 
+bool __printk_cpu_sync_owner(void)
+{
+	return (atomic_read(&printk_cpu_sync_owner) == raw_smp_processor_id());
+}
+
 /**
  * __printk_cpu_sync_try_get() - Try to acquire the printk cpu-reentrant
  *                               spinning lock.
----- END -----

> +	}
>  
>  	/*
>  	 * Note that smp_send_stop() is the usual SMP shutdown function,
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 054c0e7784fd..c22b07049c38 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2316,7 +2316,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	 * non-panic CPUs are generating any messages, they will be
>  	 * silently dropped.
>  	 */
> -	if (other_cpu_in_panic())
> +	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
>  		return 0;

I wonder if it is enough to check if it is holding the cpu_sync. Then we
would not need @panic_triggering_all_cpu_backtrace.

John

