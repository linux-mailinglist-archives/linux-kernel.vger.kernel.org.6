Return-Path: <linux-kernel+bounces-274911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F72947E26
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525922821F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69248154C0F;
	Mon,  5 Aug 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gJqADUZJ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD81552E1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871914; cv=none; b=ufmBSeiFHgJSXdcx7i1J27GokTZkRFUkV8uJ+xhmXpxkrl/ydD2tCDF3eqt8N7TlVa+X1DBiFYUvSMWZjGx1XUvBesbTESxZvsGHQ8nDWifDHgjTe2z+5PNn1yZKUZz1Yv+zURqt3eC16OxhpxTL6iPfZmmjlyGVmveUZZ4v0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871914; c=relaxed/simple;
	bh=3Y4+9im4Lq0hRfUUzT5FdwKW8F+GvgdgYFtb9S6sswI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozMveD68fgQH7E8bfz4KIuIR2mxOk95nmaaPuQET5NjTaGpNz4bupj5uGU0kWmIZBuO4KzXDC1leTpw3gQgVnw99pukTo/lCMaPHOFBZLTZuukygU4bGH8gZM6YjVlyPA7MgToHMnErOG95aVrj5dK60L68BYpSFUUD3ERRB69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gJqADUZJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ad02501c3so415760366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722871911; x=1723476711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr85ognB7QX1sL7u2ppwuaqqTAHLd03/BoSoILdTIdk=;
        b=gJqADUZJQ5hnzSQ9kDONMoLliDjF8MBdDsMKq8ppAmkHXdF6gzO1/trBkjGrFq4rRZ
         B7sfhELXl73LCY+6lYOowWUtBIT6SbdDxgTUEmikydx4FgnfxhDE3J3UxVvjJR4IsRfV
         htPAaVKJn5Wuy1HQuer65yNocc/g6eTICZbTE5ta+bzO4kdYbc6JChVh6BLG/xd8SNvr
         RiGEEliFiIU38v1c/TxvVjqc4ly7buMsXaDI301lLfH1wNhP/orVfzk5qnBvbQoymmAU
         PWBZnWXwqd6DTSuI6KIcNAZQL3cio6Qrxdikiy+8R9bF07+9b3JeVjxXMDnniZuDC30j
         kOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871911; x=1723476711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dr85ognB7QX1sL7u2ppwuaqqTAHLd03/BoSoILdTIdk=;
        b=GYgzbILWniA8CCppJyRNvh2Fln9thqa7C5nmTmp45X+WznKZ+Ed+RJqf5kkDL4g29C
         FPGAfZ2GyCOXQRLazJ1yjc8Kw1nBVTKa6Lqe0GzrIgZLPoziYMI1fGG5a8yfS2boRERW
         o2NlyOSjrWQa3LHNGHgecxoC18W03YjZwPhY5g2psdN+2LredjEBrTBYQx08AGM92lbg
         AC5+hS9RQG45NFMLZMy69kN2XwrT2eEdH0kuu8HjRr88xengcBq3HSxDc/y37hV+8DFo
         TjcK3w+o7TUa3ZqtB75FNm8gvaRwYo55SFbmobnsAWixDWb3lNesXp6msSTYiJybb0JC
         9+SA==
X-Forwarded-Encrypted: i=1; AJvYcCV1g+F79so3XEB05fmz0ChMSQHzHd2jlbKIByA+7fLDVVv8a+0+qZNybH7i6IjFt90AqCucdVN4M7QJp5z/UhkqZeBbKPnDwCkGcHPe
X-Gm-Message-State: AOJu0YxePu8EsZ0ZvsGDwM/IZeB7tOWwmivFGuailW60rU8MPyIvERa0
	JYDJjCrZcMNqkngYqDr/O7JvqREd8ireL6HTKBSgzV3ps7B0LXbYCXRsiV2K4u0=
X-Google-Smtp-Source: AGHT+IFtxMP9Zaznf0Qf9EdYFx5NDmX4Vh+Xa4lm7f110oTyQ6Dx6vbCw1oobutMLPWmtIpc4svTeQ==
X-Received: by 2002:a17:907:1b10:b0:a7a:be79:ca1e with SMTP id a640c23a62f3a-a7dc501ee11mr860694466b.20.1722871910718;
        Mon, 05 Aug 2024 08:31:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d89aacsm458196166b.159.2024.08.05.08.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:31:50 -0700 (PDT)
Date: Mon, 5 Aug 2024 17:31:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 24/35] printk: nbcon: Flush new records on
 device_release()
Message-ID: <ZrDwZfGriZSxmjnp@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-25-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-25-john.ogness@linutronix.de>

On Sun 2024-08-04 02:57:27, John Ogness wrote:
> There may be new records that were added while a driver was
> holding the nbcon context for non-printing purposes. These
> new records must be flushed by the nbcon_device_release()
> context because no other context will do it.
> 
> If boot consoles are registered, the legacy loop is used
> (either direct or per irq_work) to handle the flushing.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

It makes some sense and seems to work. I do not know how to
make it better.

Reviewed-by: Petr Mladek <pmladek@suse.com>

But it makes me nervous a bit, see below:

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1326,10 +1326,30 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
>  void nbcon_device_release(struct console *con)
>  {
>  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
> +	int cookie;
>  
>  	if (!nbcon_context_exit_unsafe(ctxt))
>  		return;
>  
>  	nbcon_context_release(ctxt);
> +
> +	/*
> +	 * This context must flush any new records added while the console
> +	 * was locked. The console_srcu_read_lock must be taken to ensure
> +	 * the console is usable throughout flushing.
> +	 */
> +	cookie = console_srcu_read_lock();
> +	if (console_is_usable(con, console_srcu_read_flags(con)) &&
> +	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
> +		if (!have_boot_console) {
> +			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
> +		} else if (!is_printk_legacy_deferred()) {
> +			if (console_trylock())
> +				console_unlock();

nbcon_device_release() is going to be called in uart_port_unlock*()
still under the port->lock.

=> It smells with a potential deadlock. The console_flush_all() in
   console_unlock() might want to flush this console under the
   port->lock as well.

   And it almost happens because nbcon_legacy_emit_next_record()
   might eventually take con->device_lock() when called in
   a task context.

   It will not happen here because this code uses console_trylock()
   which would set @console_may_schedule to false.

Anyway, it would look more safe when the flush was done after releasing
the port->lock.

I still have to think about this.

> +		} else {
> +			printk_trigger_flush();
> +		}
> +	}
> +	console_srcu_read_unlock(cookie);
>  }
>  EXPORT_SYMBOL_GPL(nbcon_device_release);

Best Regards,
Petr

