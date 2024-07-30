Return-Path: <linux-kernel+bounces-267451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63359411A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0AD28405B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A119E7D1;
	Tue, 30 Jul 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cCr3x+Zo"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4B86AEE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341686; cv=none; b=b5P6ugtQLjv8XUTvEPz7RA0BT1T+CrvOgC/xxfCqJyzEEs1KWXKO5FJ5LgZq7oY7rZvl7ZhzrTU7OrYfM2ceQRv/DdBTF2rXwJgXXvfgJ5GeuqPfnEakVUKgwujTiRzDhXVFWKtX8cKCLoQX+Nx0O54RlrU2LivR+6oiWzIawdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341686; c=relaxed/simple;
	bh=bu1rAiAmz8p4TYgP/Vi+u6ULwZUhe1/XH1Guosylg8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvTC6bmw/w/4ieERdikA3FI2Gf94VTvWd7vZOLbsl8auAaCjcyZkPlUCZpAG8dXmG1Fv+xsx4pMKqR9U1H/m5QKx2wZ/0OwmcoScnpfCkknzmJxcVOreV5eI4UaH/jSI2bNDAmoprRw5V9GbVK3CxP2LkVAqsx/QfGvXeMHeZp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cCr3x+Zo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso334450966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722341682; x=1722946482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKzsyRD1n5kNT4pYyhNrKNeskD4vGbzsD/H9RADAmL8=;
        b=cCr3x+ZoyBhwZjOyvrkPZjNfbV4lCj4j2KFnig8/3OkPPcs7jABO3C7X+N8gbm/YR+
         /T+gM3C2Fy76Kz36LXo8N7VFaUBoeas7sH+eicrSUffgWy2v1e7giQ3gi7KUBMxIbTkO
         f2AjceiaxnlTzu+UsbITfrm+P6QOfHzqJ+pBBi9hQ8DgT3E9mk03lxvybR9cQpPWNnrR
         iH6Qy99hOuavJ74m3CD8SMArfnvIf9+ujfEJssmcS8QopoCbKGpsub72d/GTSUmpXDdS
         zbj9Zj/r1fm7DwbFkCqg/pACywvPJGEgp1Uv4BZNyLXf9OvlJcYYAGgxIToJ5acMnL8u
         UWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722341682; x=1722946482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKzsyRD1n5kNT4pYyhNrKNeskD4vGbzsD/H9RADAmL8=;
        b=SoIsizGGO0PFmMo86mUhpfx38B2LQds629taVBhRmTcyVeL/zMzPsIKKGuP+9gidQ6
         pYLJLxgNb3EtyEYe2W4OfRwazJhIskska0b3Mro8Mc9YsU1CZte8HajkNJwN1q7Vqkgv
         brjmlaMtIQtmDYXfO3hbZkOgnH2ZjuwtHWXZpMRKmVfzpJXKrhtVELcXyh7TYfBFi/qi
         sWlVqtvMwEi3qhbSIalDlsl+SMnRACOakZBaLfjPxPmpZ5zi0uabpGa+9FGYhNg2O3o6
         cMsTcKWGT0tv4Sp10x0Tzz7qCsTka3S+qdW4v72LKiHu6Zs+VN6PYRqQidzd4nlr/Qtd
         OKyw==
X-Forwarded-Encrypted: i=1; AJvYcCVUrUpqoj0gOwRmNQ5zVdJVgYHg3xR7QU8vUGe8ykYZdnLsCDDeR6BXF3FA9+4qxWWqflgD9xDlNqThooXHIfxFaQiAXjue1FEG1Pr9
X-Gm-Message-State: AOJu0Yx4fIvigF9rPHabaIMNiKU+Hlh3IXWmAn1ajG/3Crazi2yJbsZw
	WsySJ82mp5QW39UJ6TpvMv2te1cKEix4lMBV0gH5OPJgORpKDpRsq5B5an4/++A=
X-Google-Smtp-Source: AGHT+IG49uC7zFLbkzZn4LRJXSIRqp6T0gO/8YJip7KzkWbbBLO0sKf+0dyNvxV2uQ0RpyWInR1lSg==
X-Received: by 2002:a17:907:5cc:b0:a6f:27e6:8892 with SMTP id a640c23a62f3a-a7d4014d23bmr630580566b.60.1722341682194;
        Tue, 30 Jul 2024 05:14:42 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad426aasm635836366b.105.2024.07.30.05.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:14:41 -0700 (PDT)
Date: Tue, 30 Jul 2024 14:14:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: takakura@valinux.co.jp, rostedt@goodmis.org, senozhatsky@chromium.org,
	akpm@linux-foundation.org, bhe@redhat.com, lukas@wunner.de,
	wangkefeng.wang@huawei.com, ubizjak@gmail.com, feng.tang@intel.com,
	j.granados@samsung.com, stephen.s.brennan@oracle.com,
	linux-kernel@vger.kernel.org, nishimura@valinux.co.jp,
	taka@valinux.co.jp
Subject: Re: [PATCH] printk: CPU backtrace not printing on panic
Message-ID: <ZqjZMIxgm46qVgjL@pathway.suse.cz>
References: <20240726094437.306330-1-takakura@valinux.co.jp>
 <ZqN-oBH5FWJqspMO@pathway.suse.cz>
 <87ttgcw92a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttgcw92a.fsf@jogness.linutronix.de>

On Fri 2024-07-26 16:02:45, John Ogness wrote:
> On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
> > I would do it the other way and enable printing from other CPUs only
> > when triggring the backtrace. We could do it because
> > trigger_all_cpu_backtrace() waits until all backtraces are
> > printed.
> >
> > Something like:
> >
> > diff --git a/include/linux/panic.h b/include/linux/panic.h
> > index 3130e0b5116b..980bacbdfcfc 100644
> > --- a/include/linux/panic.h
> > +++ b/include/linux/panic.h
> > @@ -16,6 +16,7 @@ extern void oops_enter(void);
> >  extern void oops_exit(void);
> >  extern bool oops_may_print(void);
> >  
> > +extern int panic_triggering_all_cpu_backtrace;
> >  extern int panic_timeout;
> >  extern unsigned long panic_print;
> >  extern int panic_on_oops;
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index f861bedc1925..7e9e97d59b1e 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -64,6 +64,8 @@ unsigned long panic_on_taint;
> >  bool panic_on_taint_nousertaint = false;
> >  static unsigned int warn_limit __read_mostly;
> >  
> > +int panic_triggering_all_cpu_backtrace;
> > +
> >  int panic_timeout = CONFIG_PANIC_TIMEOUT;
> >  EXPORT_SYMBOL_GPL(panic_timeout);
> >  
> > @@ -253,8 +255,12 @@ void check_panic_on_warn(const char *origin)
> >   */
> >  static void panic_other_cpus_shutdown(bool crash_kexec)
> >  {
> > -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
> > +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
> > +		/* Temporary allow printing messages on non-panic CPUs. */
> > +		panic_triggering_all_cpu_backtrace = true;
> >  		trigger_all_cpu_backtrace();
> > +		panic_triggering_all_cpu_backtrace = false;
> 
> Note, here we should also add
> 
> 		nbcon_atomic_flush_pending();
> 
> Your suggestion allows the other CPUs to dump their backtrace into the
> ringbuffer, but they are still forbidden from acquiring the nbcon
> console contexts for printing. That is a necessary requirement of
> nbcon_waiter_matches().

Great catch!

I would prefer to solve this in a separate patch. This problem existed
even before the commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
to ringbuffer"). In fact, the problem existed very long time even for
the legacy consoles.

It is pity that we need to handle both consoles separately. IMHO,
we could get the same job done by calling

	console_flush_on_panic(CONSOLE_FLUSH_PENDING);

It flushes both nbcon and legacy consoles.

> Or since the cpu_sync is held while printing the backtrace, we could
> allow the non-panic CPUs to print by modifying the check in
> nbcon_context_try_acquire_direct():
> 
> ----- BEGIN -----
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index ef6e76db0f5a..cd8724840edc 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -241,7 +241,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>  	struct nbcon_state new;
>  
>  	do {
> -		if (other_cpu_in_panic())
> +		if (other_cpu_in_panic() && !__printk_cpu_sync_owner())

Interesting idea. I am not completely against it.

Well, this would be the only situation when nmi_cpu_backtrace() would
be allowed to flush the messages directly. Also it would be yet
another exception.

I would probably keep it simple and just flush the messages from
the panic-CPU (using console_flush_on_panic(CONSOLE_FLUSH_PENDING).


>  			return -EPERM;
>  
>  		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2316,7 +2316,7 @@ asmlinkage int vprintk_emit(int facility, int level,
> >  	 * non-panic CPUs are generating any messages, they will be
> >  	 * silently dropped.
> >  	 */
> > -	if (other_cpu_in_panic())
> > +	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
> >  		return 0;
> 
> I wonder if it is enough to check if it is holding the cpu_sync. Then we
> would not need @panic_triggering_all_cpu_backtrace.

I prefer to keep panic_triggering_all_cpu_backtrace. I know, it is an
ugly long name. But it clearly defines what we want to achieve.
And it limits the exception to printing the backtraces.

The check of the cpu_owner would work now because it is used basically
only for the backtraces. But it might change anytime in the future.
cpu_owner is a "generic" lock. I guess that it will be used
in more situations in the future. Any change might break this
scenario again...

Summary:

I prefer two patches:

  1st patch would allow storing the backtraces using the variable
     panic_triggering_all_cpu_backtrace (better name appreciated).

  2nd patch would cause flushing the backtraces. And I would use
     console_flush_on_panic(CONSOLE_FLUSH_PENDING) as a variant
     which can be backported to stable kernels. It might later
     be updated by the upcoming printk rework.

Best Regards,
Petr

