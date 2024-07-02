Return-Path: <linux-kernel+bounces-237851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FB0923EED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCA21C22AD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9C31B582D;
	Tue,  2 Jul 2024 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gtSOVgqR"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7541B581C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926790; cv=none; b=D0SVUjFmZP+bFgbgKVerRRI3G+kRKdx9vKMq5++D/wCVpStDCU3b38m8QnUZDiVHo/7bA4H9djCUFyi0P0fa+82z6BqCUraTqxziwKutTVu4f5Y++lyqWnNeUKDE4kZHmVw1Bp3pS3YeUy2rX8h5gI8tARL3uYty1+H5J+ljJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926790; c=relaxed/simple;
	bh=lg+tZDVs4hEyLY3HQiLLe2lKwm2BGwh2GCtDRaNR0hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wklp/8wveaOL8IofZJ5czv9bRvXDvBy2SF7f/o78ZStj7h0813Ymb7U5WOqCplJv92LWsuOY62HruGOyhfZlz2Bi90vsl4QwrYd/Mp88EyIgn6TR/O1I7IQEyrQvKe+/POXhqRo19IAcMGwriSZ11B+ASNJ5mwPwIxi1sFFW+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gtSOVgqR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee7885ac1cso5759901fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719926785; x=1720531585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEXzoyWOhFjqKYW61KLBPXBOfhQL6RJZ80o2uJwzay0=;
        b=gtSOVgqRsBClLWCLp+ZMn446DSCHeBhorvS8olEOTUpcDRvpe/S82Y6Xpp67EfcNhO
         0P5QaERRDxWpLfVzMuT7d9/cxw4l0ItrkwcPkSD3ojBgrQrfoU1tDKO6EepqWZ0rS+qk
         fh1PzyK75vGLFdQ58JAWDD32UoTmrRp24bLMo9e4QG4KdCLs8wdzQd0jlMx5bhqvjy5e
         tCmV/qZh/NPAlOHTQgJDQ90zxizqMAGZS7Quv2nRX0SG54nJJRrfy17v6EljUXPpuxwX
         l9RVxZjDUwRbjAf22UKFy3//PdY5NZjG4TgKM/dAgkePOb9omdTEmHIy9FEW+QtZuX/l
         MTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926785; x=1720531585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEXzoyWOhFjqKYW61KLBPXBOfhQL6RJZ80o2uJwzay0=;
        b=kmo2SLb0rfG4wHwPUlWhWyQwaaTaueijXzNVuMuqwhDZz/ohiK3KWQGbJmJgfY1gX7
         PM8ooLNurT3iYNnqgMr1InwMsa/ALWIy6U7SbDQGhMKQklgMxn2q7tYdriZht8vY8NpD
         1JRps7oFRKSC8YMFr/TwozgXl3/6pUjCmL0U0g31AwqbttLWSTBGxAbcs3GsYdUyd/hu
         hXs2J7/N7GFIhHqnjK+RtLzfnQJPRNWZ+JaabvRMiwKudS/5vRL42t2sHSQYjSx1w7Lt
         XXeKcRzeI9tb9tpPdZfi+11uXvl+E0729SRjptQWtd5ZcADzgjs7qZjuJKz8mi29lptt
         GhPA==
X-Forwarded-Encrypted: i=1; AJvYcCW/fjaU7znJNFyS3Z4fDglbQYwvYWMyEV2RyEY7tizN8RW8ttVrDHxCIPvgAOHC3F/Su7AJ388a/SrlBhA4tL50Thtw121jJZPTjdI5
X-Gm-Message-State: AOJu0YwfKMZH1JyVBXC1twci6YIvbEMRx7KQRrVNwm2SITZ1YMo+2bGa
	2oZfwZL68/SVd3m8OJYruQfo1NkmJZfhOEjc6HBehdw86KVg8ponH/aDqFbLFUc=
X-Google-Smtp-Source: AGHT+IHOwy0gSsJlyo6I2CbsLhWTUOs3Wi9zfbRiK0I3klKQk6XIRE1REHPqeHNsrUu9XlM+VeBpkw==
X-Received: by 2002:a2e:a813:0:b0:2ee:7a3e:4728 with SMTP id 38308e7fff4ca-2ee7a3e48d9mr4524661fa.53.1719926784755;
        Tue, 02 Jul 2024 06:26:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce44d5esm8782234a91.19.2024.07.02.06.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:26:24 -0700 (PDT)
Date: Tue, 2 Jul 2024 15:26:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 17/18] printk: Avoid false positive lockdep
 report for legacy printing
Message-ID: <ZoP_9w0nNr_ploOn@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-18-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-18-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:52, John Ogness wrote:
> Legacy console printing from printk() caller context may invoke
> the console driver from atomic context. This leads to a lockdep
> splat because the console driver will acquire a sleeping lock
> and the caller may already hold a spinning lock. This is noticed
> by lockdep on !PREEMPT_RT configurations because it will lead to
> a problem on PREEMPT_RT.
> 
> However, on PREEMPT_RT the printing path from atomic context is
> always avoided and the console driver is always invoked from a
> dedicated thread. Thus the lockdep splat on !PREEMPT_RT is a
> false positive.
> 
> For !PREEMPT_RT override the lock-context before invoking the
> console driver to avoid the false positive.
> 
> Do not override the lock-context for PREEMPT_RT in order to
> allow lockdep to catch any real locking context issues related
> to the write callback usage.

Could you please provide more information?
Is this anything new?
How did it work so far?

See below.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ea2d66152256..5e9778f69206 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2980,6 +2980,33 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  	return true;
>  }
>  
> +/*
> + * Legacy console printing from printk() caller context does not respect
> + * raw_spinlock/spinlock nesting. For !PREEMPT_RT the lockdep warning is a
> + * false positive. For PREEMPT_RT the false positive condition does not
> + * occur.
> + *
> + * This map is used to establish LD_WAIT_SLEEP context for the console write
> + * callbacks when legacy printing to avoid false positive lockdep complaints,
> + * thus allowing lockdep to continue to function for real issues.
> + */
> +#ifdef CONFIG_PREEMPT_RT
> +static inline void printk_legacy_lock_map_acquire_try(void) { }
> +static inline void printk_legacy_lock_map_release(void) { }
> +#else
> +static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
> +
> +static inline void printk_legacy_lock_map_acquire_try(void)
> +{
> +	lock_map_acquire_try(&printk_legacy_map);
> +}
> +
> +static inline void printk_legacy_lock_map_release(void)
> +{
> +	lock_map_release(&printk_legacy_map);
> +}
> +#endif /* CONFIG_PREEMPT_RT */
> +
>  /*
>   * Used as the printk buffers for non-panic, serialized console printing.
>   * This is for legacy (!CON_NBCON) as well as all boot (CON_BOOT) consoles.
> @@ -3035,7 +3062,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>  		/*
>  		 * With forced threading this function is either in a thread
>  		 * or panic context. So there is no need for concern about
> -		 * printk reentrance or handovers.
> +		 * printk reentrance, handovers, or lockdep complaints.
>  		 */
>  
>  		con->write(con, outbuf, pmsg.outbuf_len);
> @@ -3057,7 +3084,9 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>  		/* Do not trace print latency. */
>  		stop_critical_timings();
>  
> +		printk_legacy_lock_map_acquire_try();

I am not familiar with lockdep in these depths. The comment in
include/kernel/lockdep_types.h says that LD_WAIT_SLEEP is
a type used for sleeping locks. And this code says that
it is acquire_try(). I would assume that similar lockdep
map is set also by "console_trylock()".

Do we need this for a new callpath without console_trylock()?
Or do I miss anything?

>  		con->write(con, outbuf, pmsg.outbuf_len);
> +		printk_legacy_lock_map_release();
>  
>  		start_critical_timings();

Best Regards,
Petr

