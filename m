Return-Path: <linux-kernel+bounces-217844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E169790B506
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93581C223B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A615956C;
	Mon, 17 Jun 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NSJ1dkP2"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48786158DD4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637697; cv=none; b=ZUdKreCRP9nASTpMK8i3RmJGrLM/El9/1c70qUW0imuXRrE80TtY9xS9bi+cs2Ybc7hn8dt86elfv1Fyqyg+MD9FnGDaR5eOZ/CKqWkJPZXmAZWSorQ8lZPr8wV4ZzFzAmOYsEe0bO4pG8Kl0+WDyRSEfYZiq+Z6we+Om9Nu/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637697; c=relaxed/simple;
	bh=Q9WnguKm+UBjQSRP4b97vXSra71dt9RFpU0p4AXuSIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvcxikFwiZBBl+yh9eJXs4YjJVqIwkS9D3JEvRksg/qGEm0qVQ9YBHoq4uP4LRzWex9WPHNl0wpF3UDWl2adg5Ia/mBxu1mIvpFGVGbgMwSXiwNxOqdXXl9UvROYwMIdCzCqiC4ZqcOZrHVJJ/UGEiJyYdLwAKys6yRy7WVbioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NSJ1dkP2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6ef46d25efso557390766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718637693; x=1719242493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5snYc+Qico17+UwnnuvmPc5oEWV7IQ5Wznvf984u0Q=;
        b=NSJ1dkP2XcqGLA3fr80YZgn7iLCDHeXRO5mhZM2RdcaOsK/rX5an6IMeyTE0iH4Cfo
         K/hCVeY+kI/5RY3mrNoVsJJnDVLTC5ocDn1STRARIef80MxmWNDqJHD2L3v06KVBN/sh
         y9g44pObbc7FrwWOXbjcDEHIwSiSIZCoca5bWZ4qgBUbDQr0xlQF7H9f1fAZKKK5tEUl
         RhfpQv7wxAXhbiBAZCQ/VdHWkUo0AK74U+xFNmR0V9ctd7fns72HUDPq88TEjOrI3b5K
         ic5hqqCEKu8xpdexJ3y9vvWprAbEVLIi7Cp8KAQovJpfFHgfmljgKdOwOEAk03SQT8/2
         zY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718637693; x=1719242493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5snYc+Qico17+UwnnuvmPc5oEWV7IQ5Wznvf984u0Q=;
        b=RDG8bGlcEZ+ctI/hRjDR5f/qHxlDaxdF+3kRVCX5zCiYQeq5aNFYoTWaibsBkAxFis
         XP7ceSBHCBGeEJDh0kxbpezo6+ebOjQxx24uKGkuxy24OpGe5+DoE6fxD3fcphG3CgOD
         Led/krNkxwC9vdlWoMqYcNGFe5BXYuca5jinVG3ARBI3bRZriUP9VAj2lchp+1iG7IN5
         cAgH1ymVVxnT6irWdb/if1SoMZXZBcipkIPQLjUtsECKx7z3FyaPeU6Uv72emozSB0qX
         Q7ebcVZkz5ERCfFg9guvyk7bRIALiuPLt8O8YGk1rq3ob3VT57KbWnLvxB/3d1JSqalU
         PCpw==
X-Forwarded-Encrypted: i=1; AJvYcCXynmrNcalrVJCzEn5RjwV9/8+EAPm5pJjtl0ZfxbBtgkfMo9zfwNnlDiiZSEdrI4DLs+ysRgsqDTmqxAlqC56XxANst7z9YVtDQBUa
X-Gm-Message-State: AOJu0YzGGxQ4rUPM9q4+VM1c5SoVUyq3tQlgC22wmITDwWmn6MzAg35i
	K8AyE+PeVyA4vivpwSBdxngTFB5Aexq4H8k+3LCikv7DTmW3f4CSrJe8qsA2JcU=
X-Google-Smtp-Source: AGHT+IHmoBd0YCnYXoNipxTVZiGnK0CNG3XEyfuGo0DU31tnCZ9xpe/d/H5KI0iWr9XgD0kRzNwzfQ==
X-Received: by 2002:a17:907:d50d:b0:a6f:61c7:dea7 with SMTP id a640c23a62f3a-a6f61c7df44mr739053066b.18.1718637693478;
        Mon, 17 Jun 2024 08:21:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdcfbsm521442666b.109.2024.06.17.08.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 08:21:33 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:21:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 08/18] printk: nbcon: Stop threads on
 shutdown/reboot
Message-ID: <ZnBUe0ZJgjbZXlAL@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-9-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:43, John Ogness wrote:
> Register a syscore_ops shutdown function to stop all threaded
> printers on shutdown/reboot. This allows printk to cleanly
> transition back to atomic printing in order to provide a robust
> mechanism for outputting the final messages.

It looks like a simple straightforward patch. But there are some
hidden questions.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1703,3 +1704,33 @@ void nbcon_device_release(struct console *con)
>  	console_srcu_read_unlock(cookie);
>  }
>  EXPORT_SYMBOL_GPL(nbcon_device_release);
> +
> +/**
> + * printk_kthread_shutdown - shutdown all threaded printers
> + *
> + * On system shutdown all threaded printers are stopped. This allows printk
> + * to transition back to atomic printing, thus providing a robust mechanism
> + * for the final shutdown/reboot messages to be output.
> + */
> +static void printk_kthread_shutdown(void)

I would rename this to "printk_shutdown_threads() because it
is symmetric to printk_setup_threads().


> +{
> +	struct console *con;
> +
> +	console_list_lock();

First ideas (how the waterfall of questions started):

    + I though that we should do here:

	    printk_threads_enabled = false;

      It would tell vprintk_emit() to call nbcon_atomic_flush_pending().
      And it would be symetric with printk_setup_threads().


    + Also I though whether to call it before or after stopping the kthreads.

      If we set the variable before stopping kthreads then the kthreads
      might try to flush the messages in parallel with the flush from
      vprintk_emit(). It should be safe because it would be serialized
      via the nbcon console context. But it would be the first scenario
      where this happen => not much tested.

      Well, we should start the direct flush before stopping kthreads.
      So that we could see the messages when the stopping fails.


But then I realized:

Ha, vprintk_emit() would call nbcon_atomic_flush_pending() anyway
because these notifiers are called with:

	system_state > SYSTEM_RUNNING

This makes me wonder whether we need to stop the kthreads at all.
How exactly does this make printk more robust during shutdown?

Well, there is one differece. The kthreads could not interferre with
the direct flush when they are stopped.

But we have the same problem also with suspend/resume. And we do not
stop the kthreads in this case.

Maybe, we should just add a check of

       system_state > SYSTEM_RUNNING

also into the nbcon_kthread_func(). Maybe, the kthread should not try
to flush the messages when they are flushed directly by
vprintk_emit().

But then there is the problem with "the current owner is responsible
for flushing everything". vprintk_emit() could not flush the messages
when nbcon_atomic_flush_pending() races with the kthread. And if
the kthread stops flushing then nobody would flush the rest
of the pending messages.

Maybe, the notifier could just call pr_flush() like in suspend_console().
Maybe it is not important to stop the kthreads.

But maybe, the messages get flushed before the kthread is stopped.
Also the kthread could not interfere with direct flush once stopped.
Mabye, this is the idea behind "more robust during suspend".

But why is suspend solved another way then?
Is the suspend less important than shutdown?

My opinion:

I am not against stopping the kthreads. But the mechanism of switching
between kthreads and direct flush should be the same for both suspend
and shutdown. And I am not sure if we need to stop the kthreads then.

> +	for_each_console(con) {
> +		if (con->flags & CON_NBCON)
> +			nbcon_kthread_stop(con);
> +	}
> +	console_list_unlock();
> +}
> +
> +static struct syscore_ops printk_syscore_ops = {
> +	.shutdown = printk_kthread_shutdown,
> +};
> +
> +static int __init printk_init_ops(void)
> +{
> +	register_syscore_ops(&printk_syscore_ops);
> +	return 0;
> +}
> +device_initcall(printk_init_ops);

I guess that "device_initcall" is cut&pasted ;-) IMHO, it does not
fit much. That said, I do not have strong opinion where
it belongs.

IMHO, the best solution would be to register the notifier in
printk_setup_threads() before we actually allow creating them.
(Later update: if we really need to stop them).

Best Regards,
Petr

