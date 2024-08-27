Return-Path: <linux-kernel+bounces-303568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAAD960E76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D74284662
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53F11C68A1;
	Tue, 27 Aug 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TC2vhn3j"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7011C57AF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770122; cv=none; b=Ej+sgzZ2a3D/l+yoOR2/oKyaN3XzMkdRgUPTWrQvH4yfb6x22LaV5KQzlk4lVx/1WDDMQYP6G7G1jMVWW58zbkH3GCc/5/eD3QcT2NS0CqSJzLn8aqDhM0plkGeM+kt/pJE0ugrBma14mn/gNbxktec0vSiE9pg+MQ3w62GZzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770122; c=relaxed/simple;
	bh=N4PX3ficBWqbXhrOOaGSmz0hcM7Nj1OqRrxnJAu2hIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVQu0kJEuH3FPLmrvAVuRKGfH1ryjVuFIbyYCvV2VYPVUkxOLE90wjro/wr13NSe0Mi0uPj/pLmmXqpOPcJaeoO7nhb92HGSPgxiVMiveMHKHfSofmtn4d6vaLxmFjd3VbzWKpaSm1n+uK3WjDfh9Wbrpg4GnMAHSUyb+lchlVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TC2vhn3j; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a83597ce5beso870776166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724770118; x=1725374918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI1YgmJmUxqiwDxWkP6tVGIL7ZqDPKsbaasItCi3Lco=;
        b=TC2vhn3jQ4JZuJ4zBpkw5bT7H8g5YMBTeZ0YIZQ0x9ZtrEEvUJV/UJFri6w4fO1M7f
         n2C7aHJBhbCEVLDZ/g5UkfCe76Hi11xXRBLzG3b3DmzkkKOyLpsYTWgmNoAw2FGQsFUz
         63BCcnPdiKzqLy3o0qvI1TQTPIZ7Md1iJ6llOfuPmJ0jK4SnT+KW8/VhZWl7E3fKDeQ4
         R4xQDB90dy1Rcbr60PCVBAOPO/y0EFlTQqOWMv8ZF1yV+TXjelJF+R0XFjRXQscDKRiM
         v08S8iDEaBR8wZjEJE/qLuHUOBrP+SlZVrAnn1UVVXUUXZmMNdygn1SoKgNKeIoFd4bK
         C6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770118; x=1725374918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI1YgmJmUxqiwDxWkP6tVGIL7ZqDPKsbaasItCi3Lco=;
        b=U/KzZXiP9JSNE/cGVAF4lrFrtzC+MsZxB6TUe3a0g4zZ+Yn5rqUltScOWaydHpYRpO
         xx1tHkZBSzQaWjhB7nUhBu0l0zs+ZNhwj1SxOiHeGiaUP1TnBoOVljWFGTDJEGPQwf5o
         G7KG6qwEeAH5rGmcZ4gQmGmgL8+ZmucoEQe3y2B1e8f3vQlf00FWP9GmLk5kQIV2VqFj
         JJO85dFLTyqefwiO5iDavriSA6kYw+WdnpvOXfe7RZ79YKWkn6QVjghiS+Y/qbh6kqui
         VgH2Om0HasWcTzZfkdLUzbBx3evHT45cJPSunelisQqN8mLPor65pL82yy4g8132WIju
         N1xA==
X-Forwarded-Encrypted: i=1; AJvYcCV82FtGLgfxm48DuxeFXdbUrBinHXkAyRH+2dAml9mT60wA/eVL7vixbCGi5tuo/OJK61egYU7HAmZgIqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLDTsEtqaV4eCIfUJoijHPAiS4vs5+b5UpH4BrDgKE4ug8D7E
	eIUMV1igNmLYfuVbTf98GYUmLmrptimL292gXnvXaRE8RJIZZgNSV9NavCK5Z3Q=
X-Google-Smtp-Source: AGHT+IGFZUub7b9KirSODZGvRP4+6xL/E0tNJ9cjj6B+Az0LgIDnM+S6Pz65QVnXSjp6yS7H2uHpAA==
X-Received: by 2002:a17:907:7e93:b0:a77:ab9e:9202 with SMTP id a640c23a62f3a-a86e28950f4mr303683666b.4.1724770117913;
        Tue, 27 Aug 2024 07:48:37 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d52csm117927366b.124.2024.08.27.07.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:48:37 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:48:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 06/17] printk: nbcon: Introduce printer kthreads
Message-ID: <Zs3nRK4ikgzMx7JU@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827044333.88596-7-john.ogness@linutronix.de>

On Tue 2024-08-27 06:49:22, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide the main implementation for running a printer kthread
> per nbcon console that is takeover/handover aware. This
> includes:
> 
> - new mandatory write_thread() callback
> - kthread creation
> - kthread main printing loop
> - kthread wakeup mechanism
> - kthread shutdown
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1036,6 +1042,219 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
[...]
> +/*
> + * nbcon_kthread_stop - Stop a console printer thread
> + * @con:	Console to operate on
> + */
> +void nbcon_kthread_stop(struct console *con)
> +{
> +	lockdep_assert_console_list_lock_held();
> +
> +	if (!con->kthread)
> +		return;
> +
> +	kthread_stop(con->kthread);
> +	con->kthread = NULL;
> +}
> +
> +/**
> + * nbcon_kthread_create - Create a console printer thread
> + * @con:	Console to operate on
> + *
> + * Return:	True if the kthread was started or already exists.
> + *		Otherwise false and @con must not be registered.
> + *
> + * If @con was already registered, it must be unregistered before
> + * the global state variable @printk_kthreads_running can be set.

This paragraph is quite confusing without more context. I would
either remove it completely or write something like:

<proposal>
 * This function is called when nbcon consoles are supposed to be flushed
 * using the kthread. The messages printed with NBCON_PRIO_NORMAL are not
 * longer flushed by the legacy loop. This is why the failure is considered
 * fatal leading to the console unregistration.
</proposal>

> + */
> +bool nbcon_kthread_create(struct console *con)
> +{
> +	struct task_struct *kt;
> +
> +	lockdep_assert_console_list_lock_held();
> +
> +	if (con->kthread)
> +		return true;
> +
> +	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name, con->index);
> +	if (WARN_ON(IS_ERR(kt))) {
> +		con_printk(KERN_ERR, con, "failed to start printing thread\n");
> +		return false;
> +	}
> +
> +	con->kthread = kt;
> +
> +	return true;
> +}
> +
>  /* Track the nbcon emergency nesting per CPU. */
>  static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
>  static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
> @@ -1419,6 +1644,13 @@ bool nbcon_alloc(struct console *con)
>  			con_printk(KERN_ERR, con, "failed to allocate printing buffer\n");
>  			return false;
>  		}
> +
> +		if (printk_kthreads_running) {
> +			if (!nbcon_kthread_create(con)) {
> +				kfree(con->pbufs);

It probably is not much important but I would rather do here:

				con->pbufs = NULL;

> +				return false;
> +			}
> +		}
>  	}
>  
>  	return true;

Otherwise, it looks good. With the two proposed changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

