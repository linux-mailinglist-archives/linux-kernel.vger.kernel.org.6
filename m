Return-Path: <linux-kernel+bounces-183880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B0C8C9F44
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BFD280CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039D13698D;
	Mon, 20 May 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bzh1WdYt"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4E137760
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217482; cv=none; b=HKxDdy28Tj62lfOhhtRXbYq6AQIk6hd2bxgVj22znseCalptCDywHFZ4sHQm/lBEb+qePWAfYOAkX0xoVn+l/nwvp7xUtA3LKRSo73kv4Nd9R2g97wUfOJ0aPY+xpN8jfdWAtKyHnJzMukLgduLWPMgZ83229XUu4QJVgESGecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217482; c=relaxed/simple;
	bh=dOT01Hcmol/w+i8HTMkOabqzQ0OOxpuP/qElwGc6DUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g184/eIILCku2jcq/VwTuSaS2TtWbsXQgA6egb4tZIJpZouCoQHhoqaSs/vN22ZHZTZbEuxip62p4cdPzBjhqJD2TyjDKKxbyZVi5vIt84721eT5lpmKBJOzkvkGtqOFEtvi/36hID0eyIu2VlQuZNGtTCPZhvGzR3jAb/0hSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bzh1WdYt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-574b3d6c0f3so8211590a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716217479; x=1716822279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvLrfoVuZsik/S4pLvvhPC3LDmXYmMs4M858YUCbRoc=;
        b=bzh1WdYt9WHl+Yi46pakDuslH8knfgdA1vC/MOOUUiS4D21cC0DTtwMMo4fWbAJBBy
         jTjd7Zx1XczPwEx1lHnCZXhJOEcyKqSApbsZFIbprEwi5B/0UDKI/ahAaMo+T+sWARSL
         DqDVhgfmHtqG2OWKpV89tk3KBAuvytX16PyKQAo+/iTNczMM2TsBdaq4PtxIFStVLDqa
         lV8hyGKKJTMDbaxMMG4ltlbjanzDXdpN2StHTapWTXPEhwZhrCJeumO5IbOBRd4GVfUl
         Qy1pERVSxaaug8Hfp1iQmQ73aqp6S4MC+OSNuPso4vc5WGa7hOg422vsYE+7eulgGWR+
         L5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716217479; x=1716822279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvLrfoVuZsik/S4pLvvhPC3LDmXYmMs4M858YUCbRoc=;
        b=UGmIzDXwuRvWS+C7xe5ey96yV3/lY57pcmj9kQAdL9QZqod/AMUD0eQl9iVs3C/PAg
         TztipRGr50VcAfTnaCJ4nEb1ItSTSJ3CFdv/4MsdkpkRAHYMuLmiTW4ZqZ+OxDJv39Dx
         5QzHjpY3CL3GG6UhDyBtMfjEA0oh9GJp4hM1v59wZHFU7yOAAmL8921f4k1ktsZMGB6+
         2WH+ltDxEIKJ/PIpY5rgMYfWy9s7Vx38dVgYeYjk3kNfTC5pEPgwK0ocNWlA9ow+FK93
         6amKxNoly5AViO1emyShE8m9p8BhFFymt/immw7csa5eTwPjlf9jBmc+1eaLSPJ8eFYm
         1NHg==
X-Forwarded-Encrypted: i=1; AJvYcCXNr5UhfvVYKoJnsTBYaqiU5R9yrPnq3QEPxYHH2KufdHR7KIx3T7NSze/2IX3bYAjxc0tIZpUyP9W7e5ceAxa5JKRqc3RcL4n+Al6R
X-Gm-Message-State: AOJu0Yzru4EIepEegHDS4PB/GdPag9eC+qrZJkcntURmEruCR5BjgUte
	rtfOLnxM4u8i/PoxMoZmPahoKvXJtnDAS1YnmCJ8z18lLgKOJ2W9rl7y6a+qkCI=
X-Google-Smtp-Source: AGHT+IHs1SGzyRS1L6YpTKiec84cpUXV6NjCMf4xdkJ/fW8BLUR25jMIXRL6OpdJRS/Eg0J4ALMtKg==
X-Received: by 2002:a50:d496:0:b0:572:3bcc:8370 with SMTP id 4fb4d7f45d1cf-5734d4417b4mr18393313a12.0.1716217478700;
        Mon, 20 May 2024 08:04:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574d738c80csm9232168a12.81.2024.05.20.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:04:38 -0700 (PDT)
Date: Mon, 20 May 2024 17:04:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 19/30] printk: nbcon: Provide function to flush
 using write_atomic()
Message-ID: <ZktmhL2hos8-IrNb@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-20-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-20-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:28, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide nbcon_atomic_flush_pending() to perform flushing of all
> registered nbcon consoles using their write_atomic() callback.
> 
> Unlike console_flush_all(), nbcon_atomic_flush_pending() will
> only flush up through the newest record at the time of the
> call. This prevents a CPU from printing unbounded when other
> CPUs are adding records. If new records are added while
> flushing, it is expected that the dedicated printer threads
> will print those records. If the printer thread is not
> available (which is always the case at this point in the
> rework), nbcon_atomic_flush_pending() _will_ flush all records
> in the ringbuffer.
> 
> Unlike console_flush_all(), nbcon_atomic_flush_pending() will
> fully flush one console before flushing the next. This helps to
> guarantee that a block of pending records (such as a stack
> trace in an emergency situation) can be printed atomically at
> once before releasing console ownership.
> 
> nbcon_atomic_flush_pending() is safe in any context because it
> uses write_atomic() and acquires with unsafe_takeover disabled.
> 
> Use it in console_flush_on_panic() before flushing legacy
> consoles. The legacy write() callbacks are not fully safe when
> oops_in_progress is set.
> 
> Also use it in nbcon_driver_release() to flush records added
> while the driver had the console locked to perform non-printing
> operations.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -953,6 +952,148 @@ enum nbcon_prio nbcon_get_default_prio(void)
>  	return NBCON_PRIO_NORMAL;
>  }
>  
> +/*
> + * __nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
> + *					write_atomic() callback
> + * @con:			The nbcon console to flush
> + * @stop_seq:			Flush up until this record
> + *
> + * Return:	0 if @con was flushed up to @stop_seq Otherwise, error code on
> + *		failure.
> + *
> + * Errors:
> + *
> + *	-EPERM:		Unable to acquire console ownership.
> + *
> + *	-EAGAIN:	Another context took over ownership while printing.
> + *
> + *	-ENOENT:	A record before @stop_seq is not available.
> + *
> + * If flushing up to @stop_seq was not successful, it only makes sense for the
> + * caller to try again when -EAGAIN was returned. When -EPERM is returned,
> + * this context is not allowed to acquire the console. When -ENOENT is
> + * returned, it cannot be expected that the unfinalized record will become
> + * available.
> + */
> +static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
> +{
> +	struct nbcon_write_context wctxt = { };
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
> +	int err = 0;
> +
> +	ctxt->console			= con;
> +	ctxt->spinwait_max_us		= 2000;
> +	ctxt->prio			= nbcon_get_default_prio();
> +
> +	if (!nbcon_context_try_acquire(ctxt))
> +		return -EPERM;
> +
> +	while (nbcon_seq_read(con) < stop_seq) {
> +		/*
> +		 * nbcon_emit_next_record() returns false when the console was
> +		 * handed over or taken over. In both cases the context is no
> +		 * longer valid.
> +		 */
> +		if (!nbcon_emit_next_record(&wctxt))
> +			return -EAGAIN;
> +
> +		if (!ctxt->backlog) {

This would deserve a comment:

			/* Are there reserved and no-yet finalized records? */
> +			if (nbcon_seq_read(con) < stop_seq)
> +				err = -ENOENT;
> +			break;
> +		}
> +	}
> +
> +	nbcon_context_release(ctxt);
> +	return err;
> +}
> +
> +/**
> + * nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
> + *					write_atomic() callback
> + * @con:			The nbcon console to flush
> + * @stop_seq:			Flush up until this record
> + *
> + * This will stop flushing before @stop_seq if another context has ownership.
> + * That context is then responsible for the flushing. Likewise, if new records
> + * are added while this context was flushing and there is no other context
> + * to handle the printing, this context must also flush those records.
> + */
> +static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
> +{
> +	unsigned long flags;
> +	int err;
> +
> +again:
> +	/*
> +	 * Atomic flushing does not use console driver synchronization (i.e.
> +	 * it does not hold the port lock for uart consoles). Therefore IRQs
> +	 * must be disabled to avoid being interrupted and then calling into
> +	 * a driver that will deadlock trying to acquire console ownership.
> +	 */
> +	local_irq_save(flags);
> +
> +	err = __nbcon_atomic_flush_pending_con(con, stop_seq);
> +
> +	local_irq_restore(flags);
> +
> +	/*
> +	 * If flushing was successful but more records are available, this
> +	 * context must flush those remaining records because there is no
> +	 * other context that will do it.
> +	 */
> +	if (!err && prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
> +		stop_seq = prb_next_reserve_seq(prb);
> +		goto again;
> +	}
> +
> +	/*
> +	 * If there was a new owner, that context is responsible for
> +	 * completing the flush.
> +	 */

This is a bit weird code layout. I wonder if it will get extended
in some future patchset but...

Anyway, there are three possible errors and the above paragraph
talks about one situation. Let's get through them:

  -EPERM: OK, can't do much

  -EAGAIN: OK, the other context is responsible for flush

  -ENOENT: ??? It took me quite some time to scratch my head
	around this. IMHO, it makes sense after all but it
	would deserve a comment.

What about reshufling the code a bit?

<proposal>
	/*
	 * If there was a new owner (-EPERM, -EAGAIN), that context is
	 * responsible for completing.
	 *
	 * Do not wait for not-yet finalized records (-ENOENT) to a possible
	 * deadlock. They will either get flushed by the writer or eventually
	 * skipped on panic CPU.
	 */
	 if (err)
		return;

	/*
	 * If flushing was successful but more records are available, this
	 * context must flush those remaining records because there is no
	 * other context that will do it.
	 */
	if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
		stop_seq = prb_next_reserve_seq(prb);
		goto again;
	}
</proposal>


> +}
> +
> @@ -1064,8 +1205,23 @@ EXPORT_SYMBOL_GPL(nbcon_driver_try_acquire);
>  void (struct console *con)
>  {
>  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_driver_ctxt);
> +	int cookie;
>  
> -	if (nbcon_context_exit_unsafe(ctxt))
> -		nbcon_context_release(ctxt);
> +	if (!nbcon_context_exit_unsafe(ctxt))
> +		return;
> +
> +	nbcon_context_release(ctxt);
> +
> +	/*
> +	 * This context must flush any new records added while the console
> +	 * was locked. The console_srcu_read_lock must be taken to ensure
> +	 * the console is usable throughout flushing.
> +	 */
> +	cookie = console_srcu_read_lock();

In principle, this should not be needed because the console is
added/removed under con->device_lock() in register_console()/unregister_console().
And this function nbcon_driver_release() should be called under the
same lock.

If only we could add an lockdep_assert() here. But I can't think of
any simple solution.



> +	if (console_is_usable(con, console_srcu_read_flags(con)) &&
> +	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
> +		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
> +	}
> +	console_srcu_read_unlock(cookie);
>  }
>  EXPORT_SYMBOL_GPL(nbcon_driver_release);

Best Regards,
Petr

