Return-Path: <linux-kernel+bounces-221320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1390F1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ADB1F21959
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A602136664;
	Wed, 19 Jun 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J0IwpmrJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB5132112
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809999; cv=none; b=L4fhM+vyvx6YGzrysYQunv9KwySCTF5KKju9YACucON09NxDiemTvXd8hiIdJzANE7OErrukPrvTfiQ5dSTRs9TogNuv76fKiKvTwIIkJu6MEjkVDgFy6z+d/dC3zbMqpAJpdoy0kLj1pg6eptUQfBS8O/rOMaU9XS72mosLVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809999; c=relaxed/simple;
	bh=RVkOK6oQ/dcRDJpUU9VMqhBkpawDWtQZxR45zwcaSDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iam3enlwqDfXeFrANddn9crdVyDX1KPgxSZv0DwjImWB5v4TnAHiMaqZVfJMSr/5T/LTB6CnLssnGd0Xb1G67xYC+vaPK3KgnjGv+WLCZZag0OlyoyGsbBSDHhrMEfq9fN8oO1J0CfFxpmLDShxgLFEe6MvK1DAn1gJuj1LCsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J0IwpmrJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso82155061fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718809993; x=1719414793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezi/uEzLGzslJaPPbIdfFRfE8KECdwRO44MyNp56OyM=;
        b=J0IwpmrJv3TVBo++7L8lbtqEwXlz7+cRvqb9EFZRDx+mauf97ZT9wW347v1sd5Z+3Y
         LlKJtVawS9PB98s1FyY0q3t8Zh5CgOpRWdIh3lMNX2w0j/utMqJYEM5sGj5e/OWYlcCG
         BSmPml5ITfBGw6puyRExC57In/aNibkU3Yq9/sn8nQYgruDQkkfOKvE31cW0D1EIu9bt
         /L06gTAIrGR58ToFjOfvcD1Okn7zK85NnE/60yZxkLUJAW/GBFC78BOTa8ZZelyD1kA3
         cd5ij7i2stz95LtrQmYEr9ncrt+mHUbPU0sBSUfULFXM6AS3XSCY+RxI+uQfd/ARJu5w
         3gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718809993; x=1719414793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezi/uEzLGzslJaPPbIdfFRfE8KECdwRO44MyNp56OyM=;
        b=R4g3o5iUzJWHbnvYxRrACM7ci0oXwyFLIrDOyZb/Y9w4TSRVVOs4xR+xedQ5wlGQfU
         25lbjVDrmO/rOAWKcxgWBDu1BVUDxdcpd2Jm2rIpIOHTo6MXN+eYK8rhRF6rSA8O/qae
         WSMPfnSWbZwsD0eP8wOoXERtoVBTIwBirb9TdAaSrg9mShNTU8CDsW/0ngvx/M6p8fr7
         tpKGzowzXDqRmpXjoO/wmVFXx2T3KOIGd0uIQCnpybTWDHTR0V6o0SNH+X+fjw5jnEUn
         ZtK3Tjt35PynsPav+rey1MJnblS72uiUvonIzJKN1CZWa7xaJ6DGElTRTMzOx6OAXIF8
         o/UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf6Hcr+A2oHWCX2yyFIR/NeLHZdhlX/oYEbvVWm/8aRNi4yXgt03fF7qSm8aVFStuJSyPri6quLIzUMx8cDIZMr3bzJJVmM5Txjjpj
X-Gm-Message-State: AOJu0YwZbwzTiDu2ZzXFjL1sFB8XRXMBltUsP3iVdv3YFvAGEp/hY079
	LPG929jsN6ytRs1BXlOh+yFzsrUe/Wg2A5jxlZ/QVxD96Fuhz5nDZ9FYTahA/+w=
X-Google-Smtp-Source: AGHT+IFCdomoFBqL3U7SvW2u/BH7+7kJhyRy6Uc3pirf5lHqqQtUqhDWqtFFeAhcmoH4azWgNv/hOg==
X-Received: by 2002:a2e:3815:0:b0:2ec:453:e46e with SMTP id 38308e7fff4ca-2ec3cfe8b10mr17732221fa.42.1718809993384;
        Wed, 19 Jun 2024 08:13:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9978e82c6sm33627345ad.268.2024.06.19.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:13:12 -0700 (PDT)
Date: Wed, 19 Jun 2024 17:13:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 09/18] printk: nbcon: Start printing threads
Message-ID: <ZnL1gGFeW073gm62@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-10-john.ogness@linutronix.de>
 <ZnGo-7ctV9oidQM8@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnGo-7ctV9oidQM8@pathway.suse.cz>

On Tue 2024-06-18 17:34:22, Petr Mladek wrote:
> On Tue 2024-06-04 01:30:44, John Ogness wrote:
> > If there are no boot consoles, the printing threads are started
> > in early_initcall.
> > 
> > If there are boot consoles, the printing threads are started
> > after the last boot console has unregistered. The printing
> > threads do not need to be concerned about boot consoles because
> > boot consoles cannot register once a non-boot console has
> > registered.
> > 
> > Until a printing thread of a console has started, that console
> > will print using atomic_write() in the printk() caller context.
>
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1568,6 +1570,19 @@ void nbcon_kthread_create(struct console *con)
> >  	sched_set_normal(con->kthread, -20);
> >  }
> >  
> > +static int __init printk_setup_threads(void)
> > +{
> > +	struct console *con;
> > +
> > +	console_list_lock();
> > +	printk_threads_enabled = true;
> 
> What is the actual meaning of the variable?
> 
> Does it mean that kthreads can be created? (can be forked?)
> 
> It does not guarantee that the kthreads will be running.
> They might still get blocked by a boot console.

I have investigated it more. And it looks like the variable
means that the system is initialized enough to support
the kthreads.

It is similar to the variable __printk_percpu_data_ready.

I am not sure if it would have helped to prevent the confusion
but I would suggest to rename it and add a comment:

/*
 * The graphics console drivers are going to use workqueues.
 * This variable is set to true when they are safe to use.
 */
static bool __printk_threads_ready __ro_after_init;

> 
> > +	for_each_console(con)
> > +		nbcon_kthread_create(con);

Also we should make it more clear when this function is supposed
to succeed. I mean:

	if (have_nbcon_console && !have_boot_console)
		for_each_console(con)
			nbcon_kthread_create(con);

And similar in unregister_console()

	/*
	 * When the last boot console unregisters, start up the
	 * printing threads.
	 */
	if (is_boot_con && have_nbcon_console && !have_boot_console) {
		for_each_console(c)
			nbcon_kthread_create(c);
	}

The same condition (have_nbcon_console && !have_boot_console)
is used on many other locations.

In another mail, I suggested to define a macro for this condition:

    #define printing_via_context_safe (have_nbcon_console && !have_boot_console)

It might be even better because it would connect the related
code via cscope.

Hmm, the "_safe" suffix might be confusing in this context.
A better name might be "printing_via_nbcon_context" so that
we have:

/* Printing serialized by console_lock dance is needed. */
#define printing_via_unlock (have_legacy_console || have_boot_console)

/* Printing serialized by nbcon console context is needed and safe. */
#define printing_via_nbcon_context (have_nbcon_console && !have_boot_console)

> > +	console_list_unlock();
> > +	return 0;
> > +}
> > +early_initcall(printk_setup_threads);
> > +
> >  /**
> >   * nbcon_alloc - Allocate buffers needed by the nbcon console
> >   * @con:	Console to allocate buffers for
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2397,6 +2400,7 @@ asmlinkage int vprintk_emit(int facility, int level,
> >  		 * consoles cannot print simultaneously with boot consoles.
> >  		 */
> >  		if (is_panic_context ||
> > +		    !printk_threads_enabled ||
> >  		    (system_state > SYSTEM_RUNNING)) {
> >  			nbcon_atomic_flush_pending();
> 
> IMHO, this is not safe. nbcon_atomic_flush_pending()
> is synchronized only via the nbcon console context.
> It means that there might be races with boot consoles.
> 
> Another problem is the meaning of @printk_threads_enabled variable.
> It does not guarantee that the kthreads are running. They might
> still be blocked by boot consoles.
> 
> 
> BTW: The same problem might have the system_state > SYSTEM_RUNNING.
>      The boot consoles are removed only when the preferred console
>      is registered and "keep_bootcon" is not set.
> 
>      Note that printk_late_init() unregisters the boot consoles
>      only when they are using a code in the init sections.
> 
> >  		}

I take it back. We are on the safe side because the above code is
called only when

	if (have_nbcon_console && !have_boot_console)

This is why I suggest to use the same condition around the code
starting the kthreads. It might help to create the mental
model.

Best Regards,
Petr

