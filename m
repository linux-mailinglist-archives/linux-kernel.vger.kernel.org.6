Return-Path: <linux-kernel+bounces-276133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAE948EEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95EE0B287F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2271C3F13;
	Tue,  6 Aug 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qbng7Lna"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABE1C37A5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946649; cv=none; b=IGjmwz3bdezgw1/JGpGyxz8gawpiYuX6PWACehNh9J5KdvUIydcYw2tDvrUDzET4swMINxjSJDdzaV1txP/kamGr3X6sc/DSmgMg5kmQFB4+cH+yBzyg1Vw5+TxuQVsxS0j5dOlj9wVePYjoOh9hfJQtUqK69vmaQY8VazI+LJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946649; c=relaxed/simple;
	bh=Y5Lk8utgvN9qhhsZE0wWnwTG+el+eeThYRzdG741g+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgvmWZi4xz8vq5Vl+KIdDl5OMBzVqulK6N6iBcXCGAOcRNmvh9YkRH6p7P6lAVMScCQciB0kMuYz9TtBzam5Zoj0oDQop0UYdJzwcB2H8EX519WeM9xXRPywh7rf3/SLQc8P4QxHgEQDKgqR4qfPrs840ortsFQHGw5RR/upm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qbng7Lna; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7d26c2297eso82511566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722946645; x=1723551445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7htz1EAzvRD6js9z9EcUXUeGvMBNqsOKB0twfn94hAg=;
        b=Qbng7Lnaq1Vrsl/riudHhorFrxax+D3jkSwcMZ2rcG5LQv0oxUsXuYpwnHr7E4hlno
         xiHthjwEfLKO/vaB+OfVBbNN/IlHquWNMz5ghYzGFrslyiKi/atrqpOelOhpUT6C8hNX
         cEWvh5GHWdM1MY8nnQnemjBgVPNdxc6GjnxRM/+R38etXMbzZpTl/6ZoP8qEwpCv1W90
         NM6IRNp5TZ88z8D2bOmXSsUeYLlbRTsE8h2SJzQ+xT12KPNtSbzDg5DFeAzhhP0/xLaZ
         MSuBt46blZ2aQVpoO6mt2bIxaxykTCgqKMHnqFro70N7/u8kYF9Y2HNRcvxJi+TV6RL1
         BMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946645; x=1723551445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7htz1EAzvRD6js9z9EcUXUeGvMBNqsOKB0twfn94hAg=;
        b=skhl0OjSEoMK8crLtUslD6alm2qXXJOLhkDvX3aQYoBhLFJkg9UZny0ijTBu8FeiRz
         tCZy2/tyDWT8ln/8LAPh2l8cO8BYLbghUb1s9sfHf+z9LhQTJVTSJo9pSU8D0r9+f/nb
         wt70Jryg1WdRqhQxKvZh4mPm0eToY91nOKWr8AgYVNCHakSTcLMOamMwPB/BTHV1aaQN
         P30djiP6Y7GHrXSoBI/+0eSHDy7Vt6b1NGk3iogGLW86owwRW7ZhKIY+X0UwlvK8YivN
         TouzSPkpPFVXe7u6G6xw08C16gRtdx8sKExNRc01jTMsc9PgWiCl3AMXPMdFqQSqZX+1
         es8A==
X-Forwarded-Encrypted: i=1; AJvYcCVtIUlc5daTKohDy4Megm1AxkqgFOPt4FvJx8PB/MhJ9rZWYYHIebT50VDHGWoMjcYLu3FmfK+E8t849RgaBKfqbWVdtBhtOTt71p7S
X-Gm-Message-State: AOJu0YwizYH70/1Wh1DkOO6L4Liq4q1IEAUCg/gJ4DuByNvQultnADOx
	UjJAB1qBtMfx3i/NlN7Gni2YdGnZ2PXKWG12KfAHVBW/6kzNPqvyUl5n6/JT4x6qmjHuJc10HqP
	T
X-Google-Smtp-Source: AGHT+IGtjM27LXPwTsjnpy7qsYc2eFCVzptG6Rs0k544h1k6IBJpQi0VLMfjoC+Mn8srwA+U/u6bnA==
X-Received: by 2002:a17:906:d253:b0:a77:e48d:bc8 with SMTP id a640c23a62f3a-a7dc4e69cb8mr1110709866b.21.1722946644842;
        Tue, 06 Aug 2024 05:17:24 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc4225sm549297366b.18.2024.08.06.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:17:24 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:17:22 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH printk v7 29/35] printk: Coordinate direct printing in
 panic
Message-ID: <ZrIUUhE_RDxizKcN@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-30-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-30-john.ogness@linutronix.de>

On Sun 2024-08-04 02:57:32, John Ogness wrote:
> If legacy and nbcon consoles are registered and the nbcon
> consoles are allowed to flush (i.e. no boot consoles
> registered), the legacy consoles will no longer perform
> direct printing on the panic CPU until after the backtrace
> has been stored. This will give the safe nbcon consoles a
> chance to print the panic messages before allowing the
> unsafe legacy consoles to print.
> 
> If no nbcon consoles are registered or they are not allowed
> to flush, there is no change in behavior (i.e. legacy
> consoles will always attempt to print from the printk()
> caller context).
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2330,12 +2332,30 @@ int vprintk_store(int facility, int level,
>  	return ret;
>  }
>  
> +static bool legacy_allow_panic_sync;
> +
> +/*
> + * This acts as a one-way switch to allow legacy consoles to print from
> + * the printk() caller context on a panic CPU. It also attempts to flush
> + * the legacy consoles in this context.
> + */
> +void printk_legacy_allow_panic_sync(void)
> +{
> +	legacy_allow_panic_sync = true;
> +
> +	if (printing_via_unlock && !is_printk_legacy_deferred()) {
> +		if (console_trylock())
> +			console_unlock();
> +	}
> +}
> +
>  asmlinkage int vprintk_emit(int facility, int level,
>  			    const struct dev_printk_info *dev_info,
>  			    const char *fmt, va_list args)
>  {
> +	bool do_trylock_unlock = printing_via_unlock;
> +	bool defer_legacy = !do_trylock_unlock;

This should be:

	bool defer_legacy = false;

If we do not need to call the legacy loop then we do not need
to do defer it. The nbcon consoles are flushed directly, see below.


>  	int printed_len;
> -	bool in_sched = false;
>  
>  	/* Suppress unimportant messages after panic happens */
>  	if (unlikely(suppress_printk))
> @@ -2349,17 +2369,35 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	if (other_cpu_in_panic())
>  		return 0;
>  
> +	/* If called from the scheduler, we can not call up(). */
>  	if (level == LOGLEVEL_SCHED) {
>  		level = LOGLEVEL_DEFAULT;
> -		in_sched = true;
> +		do_trylock_unlock = false;
> +		defer_legacy = true;

And this should be:

		defer_legacy = do_trylock_unlock;
		do_trylock_unlock = false;

>  	}
>  
>  	printk_delay(level);
>  
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>  
> -	/* If called from the scheduler, we can not call up(). */
> -	if (!in_sched && printing_via_unlock) {
> +	if (have_nbcon_console && !have_boot_console) {
> +		nbcon_atomic_flush_pending();

The nbcon consoles will always be flushed directly. At least at this
stage of the patchset. I guess that a later patch will offload it to
the kthread when possible.

> +		/*
> +		 * In panic, the legacy consoles are not allowed to print from
> +		 * the printk calling context unless explicitly allowed. This
> +		 * gives the safe nbcon consoles a chance to print out all the
> +		 * panic messages first. This restriction only applies if
> +		 * there are nbcon consoles registered and they are allowed to
> +		 * flush.
> +		 */
> +		if (this_cpu_in_panic() && !legacy_allow_panic_sync) {
> +			do_trylock_unlock = false;
> +			defer_legacy = false;
> +		}
> +	}
> +
> +	if (do_trylock_unlock) {
>  		/*
>  		 * The caller may be holding system-critical or
>  		 * timing-sensitive locks. Disable preemption during
> @@ -3292,7 +3330,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
>  	if (!have_boot_console)
>  		nbcon_atomic_flush_pending();
>  
> -	console_flush_all(false, &next_seq, &handover);
> +	/* Flush legacy consoles once allowed, even when dangerous. */
> +	if (legacy_allow_panic_sync)
> +		console_flush_all(false, &next_seq, &handover);
>  }

This is a good change. It make the console_flush_on_panic()
API more safe to use. console_flush_all() should not be called
before stopping other CPUs.

Best Regards,
Petr


>  
>  /*
> -- 
> 2.39.2

