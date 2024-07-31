Return-Path: <linux-kernel+bounces-268938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C3942B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FA6B230DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031E1AC42C;
	Wed, 31 Jul 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bYs9SsG9"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD21AC422
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419963; cv=none; b=UX1Qp7wf0DZt4zj2ulqq5k3V489wLPZ2WehNmXc/2bUs6UrWTU68BkpgmPL9AwlTCQLn2fiAJ5rLT/nvpiN6Rm5sUcUSsqs4HjpNUfR/iPaSfY4RcvFSBHU3wo/WN7EFuulSzNO1MO5woCM/j9uoNfrgukUKDgQZL5z44HLS9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419963; c=relaxed/simple;
	bh=xxaZDSHPSbWG+9OYNLbtaMjHopRzYXUYl8KMXs4ueuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHJVgk2ST7Ynj0Rg6Ahs4qZoZHz4OC4ggAeUBt0Zil2xowLOeUYJoqFdEhmm4S71Rgj5H5eku6mIWcbYF9lqUDiraMBtGE19zgxMUHIFDLlv9944Y8L/pGapSEIZX+x7kbs4wQhwu6cVUkH3eM+zHX/Q6XldHgASL2RHmG9lzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bYs9SsG9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so8627109a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722419960; x=1723024760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+aa526TSclrrERsz0Rb7PzESdmpKNj7JeMdwOPlAOg=;
        b=bYs9SsG95KPOWyraZY5rtXxpmchf4BCbm0BJ7k5qSEkeRvw6zUx/r52kcZR1B6u9Iq
         hLt2d8b7SZaW3tLeZvRrQb4TGQRHPr/2l2sloxN37fc4449HyjkIyDjsgVMRnI9k08uj
         p/dMRmAYWnTfRs3SFy1XkT2WqSKhAqjrMuWkLujfZOgaH3rs+NGVuUvgZY1z4xN/PpNX
         RWFpEW+/Ok5j7ty3dZXKqUExn4yr9sRvkhFtH8mgdKZWnDpDrXC3FY/FxYSLxprYsDr/
         Rb51r4NYxAJG1CuMW4W7D5hmy4fzf0ukmNRMWBz/sFsl9tvAAecr/gUXtowgU7nS9rfw
         gwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419960; x=1723024760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+aa526TSclrrERsz0Rb7PzESdmpKNj7JeMdwOPlAOg=;
        b=Zm8QzLQyRm5C9lUwrKoiN4poi5odJqXR1cF5k47xPnHCfxauJyGZuPdqjDfZsXD+2N
         ep6oCjPSq9tU10urzGhJOhKQu7L8ySiDwDmPhn+nNXDskCa3mgwz+Xi7McuPVmG20Gdc
         bUI8OzJbPrr/GjYg6XwmQNvcpBvqAnkMLtxbXgsXMNvqOCnVKfwjLDWpxGyGBY95m0zU
         yboYw+fc+5ISQWBUxnxcSqHBDzG/RRy74MDmNFRGh0fjQqvX8qjf5SnxyXpJNQmxgLQt
         6eGqMRHM7KXCnIuMDlK6WR3eIrsOYnaRAswP+pVUGvEp6A28k2zzKS7/MSNH8NTb5cJo
         igOg==
X-Forwarded-Encrypted: i=1; AJvYcCXqEWi9QAvsvmrXRl1IztExiMqyY3sSCSbCcqMguOzCnHsIoCW8CiyfApMwF+LLhdvrawLcSdhcpMYYfg+W7iC+9nLg73d1jlBlV5X7
X-Gm-Message-State: AOJu0YxC9YYOSEbaeUwegkayXXX7NQEDeyivcjwoq8T5xBE6A+JvafXM
	P3aPp3AzDyDRSNNH2Qu3q61sKXRLfZzWeIPVdBJ+QWl+a4S3wHFhaYQ02QhqjWY=
X-Google-Smtp-Source: AGHT+IEkc+sjETGoPMTO2NoiVOFwoF15zP7D/75dEYKUSLQXxUtZfX7JBq1gLb//1/BS/V8btHHM/w==
X-Received: by 2002:a50:cd54:0:b0:5a0:c709:aa0b with SMTP id 4fb4d7f45d1cf-5b021f0c45bmr9628009a12.24.1722419959629;
        Wed, 31 Jul 2024 02:59:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afa605d81bsm6898759a12.74.2024.07.31.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:59:19 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:59:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 09/19] printk: nbcon: Introduce printer kthreads
Message-ID: <ZqoK77CDoqNll7_M@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-10-john.ogness@linutronix.de>
 <871q3bkkgw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q3bkkgw.fsf@jogness.linutronix.de>

On Tue 2024-07-30 16:50:47, John Ogness wrote:
> On 2024-07-22, John Ogness <john.ogness@linutronix.de> wrote:
> > +/**
> > + * nbcon_kthread_should_wakeup - Check whether a printer thread should wakeup
> > + * @con:	Console to operate on
> > + * @ctxt:	The nbcon context from nbcon_context_try_acquire()
> > + *
> > + * Return:	True if the thread should shutdown or if the console is
> > + *		allowed to print and a record is available. False otherwise.
> > + *
> > + * After the thread wakes up, it must first check if it should shutdown before
> > + * attempting any printing.
> > + */
> > +static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
> > +{
> > +	bool ret = false;
> > +	short flags;
> > +	int cookie;
> > +
> > +	if (kthread_should_stop())
> > +		return true;
> > +
> > +	cookie = console_srcu_read_lock();
> > +
> > +	flags = console_srcu_read_flags(con);
> > +	if (console_is_usable(con, flags, false)) {
> > +		/* Bring the sequence in @ctxt up to date */
> > +		ctxt->seq = nbcon_seq_read(con);
> > +
> > +		ret = prb_read_valid(prb, ctxt->seq, NULL);
> 
> With this v3 series, the kthreads could be started before @nbcon_seq has
> been set to the correct initial value. This will cause it to start
> printing immediately from 0.

Great catch!

> To fix this, I would change nbcon_alloc() to initialize @nbcon_seq to
> the highest possible value:
> 
> 	/*
> 	 * Initialize @nbcon_seq to the highest possible sequence number so
> 	 * that practically speaking it will have nothing to print until a
> 	 * desired initial sequence number has been set via nbcon_seq_force().
> 	 */
> 	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), ULSEQ_MAX(prb));
> 
> With the following ULSEQ_MAX macro added to printk_ringbuffer.h:
> 
> #ifdef CONFIG_64BIT
> #define ULSEQ_MAX(rb) (-1)
> #else
> #define ULSEQ_MAX(rb) (prb_first_seq(rb) + 0x80000000)
> #endif
> 
> This will allow the prb_read_valid() in nbcon_kthread_should_wakeup() to
> return false and the kthread will sleep until @nbcon_seq has been
> correctly setup and the kthread is woken when the "enabled" printk() is
> called.

It looks good.

Alternative solution would be to delay setting of the CON_ENABLED bit.
Well, there is one catch, some console drivers pre-set CON_ENABLED to
enforce the registration, see the comment in
try_enable_preferred_console(). We would need to handle this somehow.

So the trick with ULSEQ_MAX is a better way to go.

> > +	}
> > +
> > +	console_srcu_read_unlock(cookie);
> > +	return ret;
> > +}
> 
> Other options would be to add extra checks to
> nbcon_kthread_should_wakeup() or add some wait/notify code before
> entering the kthread main loop. But both are overkill for this simple
> startup scenario.

Yeah, the trick with ULSEQ_MAX is easier and looks reliable. I am fine
with it.

Best Regards,
Petr

