Return-Path: <linux-kernel+bounces-277828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB4C94A70F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE011C2112B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881D1E3CCA;
	Wed,  7 Aug 2024 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tg1u77VG"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930FA1DF69A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030752; cv=none; b=XqaxcA0cyAw1D4cgREfmI5e1huQQ/ppeIaLlILoVeT8u34lWQTVzP4+Ez8Ulhcmstj6BISuoK4EEUvBC8ISoxXO1xyFYUtg25oyR4oSsbD85FkOSIlDK3mjoT9S5VqLvPuZyfo4sUYaTf6BzImZV577JluyE3pU9ML2hrbEe25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030752; c=relaxed/simple;
	bh=dTE08WWFyTYJDu4UqZZG0Z4pfRFKkauBbjBUSJuMqVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkYSm0Spmc9CPZKYZAWfZnJj2HLsE9aW5ZBPW+CpYiegVfwfRFXxsgabuoHzuW9Z5vWjnfH5yl8m1FcuhyQcjVhTqExze7/TBYDk3cyq9IS2CU/JqCNhDy3IDATS8nK0xRgJs/bBA2mRkhOZzEpZk30uUnYlg8n1vb8Crm7pRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tg1u77VG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so173863066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723030749; x=1723635549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIW4g56oy8zImAxMMgO6nv4xjMXXHeZLJ12w5l7ltfo=;
        b=Tg1u77VGCTdPnccTut2lp+srIFson8/inbCTp4fFTmztYlIOtssKXu724cJhwyb2qD
         jHzvxke8rBiNYtbpxJBGESKvE8rSxtM2IIQ46e9+34vkse2UyZzO7q25UTAia/iqr9sd
         qw8oDJ/RCIy4oeX58OgcuopzHLSKggBSQfqxqps9Y6FHE2j0NX3oatUmQxstN0zZZrWO
         W213wmtcD22m6jG4grZU8pf9QxrZ68229BMXOAetb6V+X7CJpMpdbjOeEhNn9KEq2+Vn
         RRB7RLMRU+Z8G+kaHTj3sT5LJDvW1fMhhcEADW/jx8t/WppomGKJiPCUQv4rdQJdQjks
         Otmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723030749; x=1723635549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIW4g56oy8zImAxMMgO6nv4xjMXXHeZLJ12w5l7ltfo=;
        b=IxfThbMCQwb9ln0dDcxT0SdTsymLcpX4l3548GkbMuMlwLLSCeintJVduFzXvav/wd
         CYXsPmHTEZiBN7ROedAXk9XDQx0s1IfdV5kcYwSyO6U/mIPtyLrNogenMbHaM+O1MLiW
         3EtpmNKaC98ldPHJOXooHVxpz3zwoomjrF2S4O1tR61RSlQdn9qucw675Res9MKr2ako
         h3uU5IOsV3BYEGJyaZjvYfmQofjg/Yr8fPca3cRsWcf63aamrJAkW+QhDaf9XnPVLGsk
         daE3vvgZe1Jc8sG0nU35QkLtzbq2n4112wSgWq64sYGXleYewhXjUON/gE3tQz+NNxda
         01hg==
X-Forwarded-Encrypted: i=1; AJvYcCUT5ln873aVI7rMf4OUC/pP0P9CqrrYFqGHCer+UkgCHh3zSBuRO8d8FFYZD643Q8U/2bG15VXUc/VOH54lFQsEP823jaA4ZpJltjTa
X-Gm-Message-State: AOJu0YxmrASpYECIKD7+snHYrgGD0gBXeEHlBQhectDjn35+S9tOswx3
	5F/TgPM5s/ZbfRzMnaM9G28aDyuMRBqqCMGZIEtcOolBDuM1eplzmiJnV4q9Vw0=
X-Google-Smtp-Source: AGHT+IGGAiR9PB8r/fCHXgPP/QoJQ+gedTwAb3U7fZBkkwz9+5j5mJpsochUx89z0QxkJQp1M9HviQ==
X-Received: by 2002:a17:907:980a:b0:a6f:1036:98cf with SMTP id a640c23a62f3a-a7dc50f7e19mr1483593366b.54.1723030748676;
        Wed, 07 Aug 2024 04:39:08 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecad3esm629511566b.206.2024.08.07.04.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:39:08 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:39:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 30/35] printk: Add helper for flush type logic
Message-ID: <ZrNcr5-uZoQnSHii@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-31-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-31-john.ogness@linutronix.de>

Hi,

I have spent a lot of time on this patch. I have got lost and rewrote
the comments several times. I hope that they make sense after all.

On Sun 2024-08-04 02:57:33, John Ogness wrote:
> There are many call sites where console flushing occur.
> Depending on the system state and types of consoles, the flush
> methods to use are different. A flush call site generally must
> consider:
> 
> Introduce a new internal struct console_flush_type that
> specifies the flush method(s) that are available for a
> particular call site to use.
> 
> Introduce a helper function to fill out console_flush_type to
> be used for flushing call sites.
> 
> In many system states it is acceptable to flush legacy directly
> via console_unlock or via offload to irq_work. The caller must
> decide which of these methods it prefers.
> 
> Replace the logic of all flushing call sites to use the new
> helper.
> 
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -156,6 +157,70 @@ static inline bool console_is_usable(struct console *con, short flags) { return
>  #endif /* CONFIG_PRINTK */
>  
>  extern bool have_boot_console;
> +extern bool have_nbcon_console;
> +extern bool have_legacy_console;
> +
> +/**
> + * struct console_flush_type - Define available console flush methods
> + * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
> + * @legacy_direct:	Call the legacy loop in this context
> + * @legacy_offload:	Offload the legacy loop into IRQ
> + *
> + * Note that the legacy loop also flushes the nbcon consoles.
> + */
> +struct console_flush_type {
> +	bool	nbcon_atomic;
> +	bool	legacy_direct;
> +	bool	legacy_offload;
> +};
> +
> +/*
> + * Identify which console flushing methods are available to the context of
> + * the caller. The caller can then decide which of the available flushing
> + * methods it will use.
> + */
> +static inline void printk_get_console_flush_type(struct console_flush_type *ft)
> +{
> +	memset(ft, 0, sizeof(*ft));
> +
> +	switch (nbcon_get_default_prio()) {
> +	case NBCON_PRIO_NORMAL:
> +		if (have_nbcon_console && !have_boot_console)
> +			ft->nbcon_atomic = true;
> +
> +		if (have_legacy_console || have_boot_console) {
> +			ft->legacy_offload = true;
> +			if (!is_printk_legacy_deferred())
> +				ft->legacy_direct = true;
> +		}

I would suggest to change the semantic and set the _preferred_
flush method instead of an _available_ one. Something like:

		/* Legacy consoles are flushed directly when possible. */
		if (have_legacy_console || have_boot_console) {
			if (!is_printk_legacy_deferred()) {
				ft->legacy_direct = true;
			} else {
				ft->legacy_offload = true;
			}
		}


It would simplify vprintk_emit() in this patch. Also it might keep
nbcon_atomic_flush_pending_con() simple after adding the printk
thread. See below.

IMHO, it will not make any difference in other situations.

I personally prefer the "set preferred flush method" semantic. It
helps to make sure that all callers behave consistently. I mean that
this function would define the flush rules in "all" situations.

That said, I do not resist on it. The code looks reasonable also
with the current semantic. And it is rather easy to review
all callers. Also I might miss something. I still do not see the full
picture (patches adding the kthread).

> +		break;
> +
> +	case NBCON_PRIO_PANIC:
> +		/*
> +		 * In panic, the nbcon consoles will directly print. But
> +		 * only allowed if there are no boot consoles.
> +		 */
> +		if (have_nbcon_console && !have_boot_console)
> +			ft->nbcon_atomic = true;
> +
> +		/*
> +		 * In panic, if nbcon atomic printing occurs, the legacy
> +		 * consoles must remain silent until explicitly allowed.
> +		 * Also, legacy consoles cannot print when deferred. However,
> +		 * console_flush_on_panic() will flush them anyway, even if
> +		 * unsafe.
> +		 */
> +		if ((legacy_allow_panic_sync || !ft->nbcon_atomic) &&
> +		    !is_printk_legacy_deferred()) {
> +			ft->legacy_direct = true;

We should check here whether the legacy loop is needed at all.
I would write something like:

		if (have_legacy_console || have_boot_console) {
			/*
			 * Same decision as in PRIO_NORMAL. But we are interested
			 * only in wheter we could flush directly.
			 */
			if (!is_printk_legacy_deferred()) {
				ft->legacy_direct = true;
			}
			/* PRIO_PANIC specific part: Legacy consoles remain silent... */
			if (ft->nbcon_atomic && !legacy_allow_panic_sync)
				ft->legacy_direct = false;

> +		}
> +		break;
> +
> +	default:
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +}
>  
>  extern struct printk_buffers printk_shared_pbufs;
>  
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1186,8 +1187,16 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>  	 * other context that will do it.
>  	 */
>  	if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
> -		stop_seq = prb_next_reserve_seq(prb);
> -		goto again;
> +		printk_get_console_flush_type(&ft);
> +		/*
> +		 * If nbcon_atomic flushing is not available, this printing
> +		 * must be occurring via the legacy loop. Let that loop be
> +		 * responsible for flushing the new records.
> +		 */

The comment is a bit confusing. It is not clear who is responsible for
calling the legacy loop.

My understanding is that the caller of this function is responsible
for calling the legacy loop. At least this is the case now. The
function is called only from vprintk_emit() and
console_flush_on_panic() and they both call the legacy loop when
needed.

I would rather remove this comment. Instead, I would make it clear
in the function description that: "The caller is responsible for
flushing the console via the legacy loop when needed."

> +		if (ft.nbcon_atomic) {
> +			stop_seq = prb_next_reserve_seq(prb);
> +			goto again;
> +		}

BTW: I wonder how this code would look like after adding the printk
     threads. We should do "goto again" only when ft.nbcon_atomic
     is the preferred (only available) flush type for nbcon consoles.

     IMHO, it is another reason to change the semantic.

>  	}
>  }
>  
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2369,34 +2364,23 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	if (other_cpu_in_panic())
>  		return 0;
>  
> +	printk_get_console_flush_type(&ft);

It is a nice trick to call printk_get_console_flush_type() this early.
I allows to hack the result when processing the hacky LOGLEVEL_SCHED ;-)

> +
>  	/* If called from the scheduler, we can not call up(). */
>  	if (level == LOGLEVEL_SCHED) {
>  		level = LOGLEVEL_DEFAULT;
>  		do_trylock_unlock = false;
> -		defer_legacy = true;
> +	} else {
> +		do_trylock_unlock = ft.legacy_direct;
>  	}

We could hack the @ft structure directly here:

	if (level == LOGLEVEL_SCHED) {
		level = LOGLEVEL_DEFAULT;
		ft.legacy_offload |= ft.legacy_direct;
		ft.legacy_direct = false;
	}
>  
>  	printk_delay(level);
>  
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>  
> -	if (have_nbcon_console && !have_boot_console) {
> +	if (ft.nbcon_atomic)
>  		nbcon_atomic_flush_pending();
>  
> -		/*
> -		 * In panic, the legacy consoles are not allowed to print from
> -		 * the printk calling context unless explicitly allowed. This
> -		 * gives the safe nbcon consoles a chance to print out all the
> -		 * panic messages first. This restriction only applies if
> -		 * there are nbcon consoles registered and they are allowed to
> -		 * flush.
> -		 */
> -		if (this_cpu_in_panic() && !legacy_allow_panic_sync) {
> -			do_trylock_unlock = false;
> -			defer_legacy = false;
> -		}
> -	}
> -
>  	if (do_trylock_unlock) {

Then, with the "preferred flush method" semantic, we could use here:

	if (ft.legacy_direct) {

>  		/*
>  		 * The caller may be holding system-critical or
> @@ -2417,7 +2401,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		preempt_enable();
>  	}
>  
> -	if (defer_legacy)
> +	if (!do_trylock_unlock && ft.legacy_offload)

and here:

	if (ft.legacy_offload)

>  		defer_console_output();
>  	else
>  		wake_up_klogd();
> @@ -2776,10 +2760,14 @@ void resume_console(void)
>   */
>  static int console_cpu_notify(unsigned int cpu)
>  {
> -	if (!cpuhp_tasks_frozen && printing_via_unlock) {
> -		/* If trylock fails, someone else is doing the printing */
> -		if (console_trylock())
> -			console_unlock();
> +	struct console_flush_type ft;
> +
> +	if (!cpuhp_tasks_frozen) {
> +		printk_get_console_flush_type(&ft);
> +		if (ft.legacy_direct) {
> +			if (console_trylock())
> +				console_unlock();

Why do we actually call only the legacy loop here?
IMHO, we should also do

	if (ft.nbcon_atomic)
 		nbcon_atomic_flush_pending();


> +		}
>  	}
>  	return 0;
>  }
> @@ -3327,7 +3316,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
>  	if (mode == CONSOLE_REPLAY_ALL)
>  		__console_rewind_all();
>  
> -	if (!have_boot_console)
> +	printk_get_console_flush_type(&ft);
> +	if (ft.nbcon_atomic)
>  		nbcon_atomic_flush_pending();

I would use "ft.legacy_direct" also below for the decision about
the legacy loop:

-	if (legacy_allow_panic_sync)
+	if (ft.legacy_direct)
		console_flush_all(false, &next_seq, &handover);

>  
>  	/* Flush legacy consoles once allowed, even when dangerous. */

Best Regards,
Petr

