Return-Path: <linux-kernel+bounces-263464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4F93D66F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D107285122
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0A217A594;
	Fri, 26 Jul 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WzPZmniF"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F1101F7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009086; cv=none; b=POoEZCltLKZRCKqn1D4XDOpbbDqJ4oagBEEKzirFDv32qwEVbVeSAnrfLOAo7OYf5lItNCOmsq0ZwAXuVH3Y4hjd0uBGVi21Dor5kLQBk1ktmganwBowRrlOsOud96g4BgpSq75j9gMfTPAg2zG+1XPuZYQ6we4u06PoEF5Ulbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009086; c=relaxed/simple;
	bh=64CT6rHOF4yikfO4hoj2HxheQZouAn1v+thLXn+EAPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9ZydrihFk8BLomvCdZ3GZ/W3g4PWKwKsAFK5TU0kiig8/Jk526RbhXHgSM+IkfHSk99OW/ngcmtt5GD8GUuf+XXRRQo/mZmJGTkaR2jMtEprBCeA3bjV2xpmlLWuUboHzmSdgKGM3RrLPhWNXq2Zn6klB569aeQ9wzv9mTgRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WzPZmniF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so2899174a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722009082; x=1722613882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TupnoGkpxOend/KHBEomu6OJY+OhuErmLwCpXobNuTs=;
        b=WzPZmniF+8f3kBUGMIl5Q2gofcu3xp8VCuAfIdyKHMf/4c/KEfBGXUGRjL96oy2YbX
         wlxxyE+5w3OiabKGOeGv0jzZBkMULeSRifg7sY53vasQbZr0ChCiTHsKdDMzjloB54jl
         2NOLjrxTcj3YUk0s+EaSL6sQ8W8AiFnv2ApUViWxzdXy8O19DA65d+VqbR3ae6DEJYSx
         a0H7+w69yxLP3w7vv7UmGbtg+shQKVB12zwliv/CPJze3kkf+CHXFlJsSRU27Wlxtvp4
         ymUrj+Cp+eAngfaTHpD+rXPZ/ZNuELmKLYGMAv0NAo0I0flGf5awXkaEE4A/ShCBWlBP
         RVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722009082; x=1722613882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TupnoGkpxOend/KHBEomu6OJY+OhuErmLwCpXobNuTs=;
        b=gA/0Mt6r1KzGA1QnpL14HTNDgccVMWj/Eur6CJzNDuHVrc8ZC/j86utxwbKzl+39iY
         RLY3GdwydBXXZa8eU2YF1aOdXpy9kbD8/UKcSTPKxeunqCDqh23vrvLnQhWBlxWzhjPA
         Hd8xesHh+kBTIh9q81x7BSmrUSFxW/dkpcW3oJ5UjavKYSKHZoNl8gjiAMCnWqksprbK
         e08FoEZvuFJLdVwRCm3Ji4gFOzBhv7uZ8/VCZhzkKZxdYYLloS+oCIi7dSw0/YhdzH0x
         uGaZg+LPU3fHAdAtY46lUUdflB0E4dgxaznBenWQjm0pDuNKhIqpiZ0aFgjvzzrIUot8
         lsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYzs4/UL3DGpOfSc+LiunDINiKzAbrRsOhlwCD+dXdg6XMUGnlH5ZzKL3GZwpLMviLMSoRpKEJG42JO5EbcwEBSxe1E0TKN/qHOA/W
X-Gm-Message-State: AOJu0YzwxP0KnkD9KRQ/zACB6qiiUVNwkBMpI/yYhrOgAo+cxSkMr3ug
	WQyDMUiXx5tCvaDvWpTEy9CvNOV8hN+TiRt00nh4v2h5iT4O7SIbAJWhu9Fk8UA=
X-Google-Smtp-Source: AGHT+IG5kFhWuns/LlJYfK8ShY+/hH0FlPFSy7c4GChO/ZTwWW6+XRfesF5QeUc1bzV1W1gnZ33csA==
X-Received: by 2002:a50:d746:0:b0:5a1:e7e6:ce37 with SMTP id 4fb4d7f45d1cf-5ac2c0cfca5mr4183715a12.26.1722009082557;
        Fri, 26 Jul 2024 08:51:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac655996fasm2041378a12.84.2024.07.26.08.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:51:22 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:51:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 07/19] printk: Add helpers for flush type logic
Message-ID: <ZqPF-GjhCUlR1fQv@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-8-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-8-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:27, John Ogness wrote:
> There are many call sites where console flushing occur.
> Depending on the system state and types of consoles, the flush
> methods to use are different. A flush call site generally must
> consider:
> 
> 	@have_boot_console
> 	@have_nbcon_console
> 	@have_legacy_console
> 	@legacy_allow_panic_sync
> 	is_printk_preferred()
> 
> and take into account the current CPU state:
> 
> 	NBCON_PRIO_NORMAL
> 	NBCON_PRIO_EMERGENCY
> 	NBCON_PRIO_PANIC
> 
> in order to decide if it should:
> 
> 	flush nbcon directly via atomic_write() callback
> 	flush legacy directly via console_unlock
> 	flush legacy via offload to irq_work
> 
> All of these call sites use their own logic to make this
> decision, which is complicated and error prone. Especially
> later when two more flush methods will be introduced:
> 
> 	flush nbcon via offload to kthread
> 	flush legacy via offload to kthread
> 
> Introduce a new internal struct console_flush_type that
> specifies the flush method(s) that are available for a
> particular call site to use.
> 
> Introduce helper functions to fill out console_flush_type to
> be used for emergency and non-emergency call sites.
> 
> In many system states it is acceptable to flush legacy directly
> via console_unlock or via offload to irq_work. For this reason
> the non-emergency helper provides an argument @prefer_offload
> for the caller to specify which method it is interested in
> performing. (The helper functions will never allow both.)
> 
> Replace the logic of all flushing call sites to use the new
> helpers. Note that this cleans up various corner cases where
> is_printk_preferred() and @have_boot_console were not being
> considerered before.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2330,9 +2331,13 @@ static bool legacy_allow_panic_sync;
>   */
>  void printk_legacy_allow_panic_sync(void)
>  {
> +	struct console_flush_type ft;
> +
>  	legacy_allow_panic_sync = true;
>  
> -	if (printing_via_unlock && !in_nmi()) {
> +	printk_get_console_flush_type(&ft, false);
> +
> +	if (ft.legacy_direct && !in_nmi()) {

in_nmi() check is not needed any longer. It is already done in
is_printk_deferred() in printk_get_console_flush_type().

>  		if (console_trylock())
>  			console_unlock();
>  	}
> @@ -2342,7 +2347,8 @@ asmlinkage int vprintk_emit(int facility, int level,
>  			    const struct dev_printk_info *dev_info,
>  			    const char *fmt, va_list args)
>  {
> -	bool do_trylock_unlock = printing_via_unlock;
> +	struct console_flush_type ft;
> +	bool defer_legacy = false;
>  	int printed_len;
>  
>  	/* Suppress unimportant messages after panic happens */
> @@ -2360,41 +2366,19 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	if (level == LOGLEVEL_SCHED) {
>  		level = LOGLEVEL_DEFAULT;
>  		/* If called from the scheduler, we can not call up(). */
> -		do_trylock_unlock = false;
> +		defer_legacy = true;
>  	}
>  
>  	printk_delay(level);
>  
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>  
> -	if (have_nbcon_console && !have_boot_console) {
> -		bool is_panic_context = this_cpu_in_panic();
> +	printk_get_console_flush_type(&ft, false);

We could pass "defer_legacy" here. It won't be needed to check it
later then.

> -		/*
> -		 * In panic, the legacy consoles are not allowed to print from
> -		 * the printk calling context unless explicitly allowed. This
> -		 * gives the safe nbcon consoles a chance to print out all the
> -		 * panic messages first. This restriction only applies if
> -		 * there are nbcon consoles registered.
> -		 */
> -		if (is_panic_context)
> -			do_trylock_unlock &= legacy_allow_panic_sync;
> +	if (ft.nbcon_atomic)
> +		nbcon_atomic_flush_pending();
>  
> -		/*
> -		 * There are situations where nbcon atomic printing should
> -		 * happen in the printk() caller context:
> -		 *
> -		 * - When this CPU is in panic.
> -		 *
> -		 * Note that if boot consoles are registered, the console
> -		 * lock/unlock dance must be relied upon instead because nbcon
> -		 * consoles cannot print simultaneously with boot consoles.
> -		 */
> -		if (is_panic_context)
> -			nbcon_atomic_flush_pending();

Just for record. If I get it correctly than this actually fixes a bug.
The original code called nbcon_atomic_flush_pending() only in panic().
The nbcon consoles were not flushed when there were only nbcon consoles
(printing_via_unlock == false).

I think that we did not notice it because it probably got fixed by
later patches adding the printk kthreads.

> -	}
> -
> -	if (do_trylock_unlock) {
> +	if (!defer_legacy && ft.legacy_direct) {

@defer_legacy should not be needed if we passed it to
printk_get_console_flush_type().

>  		/*
>  		 * The caller may be holding system-critical or
>  		 * timing-sensitive locks. Disable preemption during
> @@ -2409,22 +2393,17 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		 * semaphore. The release will print out buffers. With the
>  		 * spinning variant, this context tries to take over the
>  		 * printing from another printing context.
> -		 *
> -		 * Skip it in EMERGENCY priority. The console will be
> -		 * explicitly flushed when exiting the emergency section.
>  		 */
> -		if (nbcon_get_default_prio() != NBCON_PRIO_EMERGENCY) {
> -			if (console_trylock_spinning())
> -				console_unlock();
> -		}
> +		if (console_trylock_spinning())
> +			console_unlock();
>  
>  		preempt_enable();
>  	}
>  
> -	if (do_trylock_unlock)
> -		wake_up_klogd();
> -	else
> +	if ((defer_legacy && ft.legacy_direct) || ft.legacy_offload)

ditto.

>  		defer_console_output();
> +	else
> +		wake_up_klogd();
>  
>  	return printed_len;
>  }
> @@ -2728,10 +2707,15 @@ void resume_console(void)
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
> +		printk_get_console_flush_type(&ft, false);
> +
> +		if (ft.legacy_direct) {
> +			if (console_trylock())
> +				console_unlock();
> +		}

One might be curious why we do not flush nbcon consoles here.
I guess that it will be less important after introducing
the kthreads.

Could it be called before the kthreads are started?

Anyway, this looks like a common pattern. Maybe, we could hide
it into some helper and be in the safe side:

/* Try to flush consoles directly when needed. */
void try_console_flush()
{
	struct console_flush_type ft;

	printk_get_console_flush_type(&ft, false);

	if (ft.nbcon_atomic)
		nbcon_atomic_flush_pending();

	if (ft.legacy_direct)
		console_flush_all(false, &next_seq, &handover);
}

>  	}
>  	return 0;
>  }

Otherwise, it looks good.

Heh, I wondered several times if it was worth it. The struct
console_flush_type and printk_get_console_flush_type()
sometimes looked like an overkill. But I see many advantages:

  + As the commit message says, the decision how to flush the messages
    depend on many variables. And it is nice to have it in one place.

  + The logic will get even more complicated after adding the
    kthreads.

  + printk_get_console_flush_type() allows to change the behavior
    in many situations in one place.

  + printk_get_console_flush_type() allows to easily find all
    locations where we decide how to flush the messages. It helps
    to check affected code paths.

So, I think that it is worth it in the end.

Note that I did not check the emergency code paths because
they are going to be reworked as discussed in the printk pull
request for 6.11, see
https://lore.kernel.org/r/ZqJKbcLgTeYRkDd6@pathway.suse.cz

Best Regards,
Petr

