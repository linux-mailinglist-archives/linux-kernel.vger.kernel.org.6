Return-Path: <linux-kernel+bounces-313031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF46969F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0FF2867E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEA2168D0;
	Tue,  3 Sep 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eRG1tJdx"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9917756
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370732; cv=none; b=SKDJcKvuAnBQz5yiCYfu/6sX5CAbym68VqSnBbSOpy5OroVhYJzpsZhnMteina77+0EnFMtcf5v8d9yq8ZsPLr1YkrBvQPu3gssYP2fChOzalKWl+CNGUeN5Ydn5/HxBr+BqsNHuz5fFM1pXIW+h4hA7cxRN+fGjdU2L0vM4YGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370732; c=relaxed/simple;
	bh=2GWEjIpz+MSjeECpD3uAima02/GJskSTIUvLsRZEruY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIqeq+0yYLC+Et2khYwnVnw+5MUODpU1nticCNat2VwvQwNhbMo/+yJ/Ur9BXIi/TuZ8RmuT37BA7hUxtbs4ccG2Ce4BV5FYutyLhAfT5N8kXZZEd1d2ro7oCXpDR+T8WkG+a3eVxe44BASmVaIomD1A9DOrCLrjGGQsK/BLPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eRG1tJdx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86abbd68ffso884243966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725370728; x=1725975528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXf+ko9xHOiXDzwKMvUwb6cPd+dFkczo/0jVQ7rjtP4=;
        b=eRG1tJdxls7+MvAaOA6q/3rX6YAlyt4sGOwipnD6u7H3weelto1HwFB2Tw1vUUEgJ7
         BE1iZKnjhH/C1JmCvy2G04xO3OUYdVjo0kOdxRC7HiebVwk1bxZ5J6PeamlcjSDXjlKP
         bns1NtX5fmPjqRUqGZLeT4DKV0zB0wvaHu+D7BZVTICM0qOl+elJV5ZAuHcgHvHlSoCG
         i832c/8QhAc3Q4N1WnQiqZAwEKLA7EmOPKkPPdc0Wc0pKjDFsgpuUQtJMcwMeOhRYOwR
         21BOhOqeOICySsAGWIJTqdLayv9Hjsj+lu68GtLiAEr0wBwM75Bq7rrcAwj8FM3ldNXc
         Xc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725370728; x=1725975528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXf+ko9xHOiXDzwKMvUwb6cPd+dFkczo/0jVQ7rjtP4=;
        b=UCiYCgmamdfV7LzQ8Ekcq8uHclZuH0iNIKmNhzkN8K0bC5XM/6qHNuaXwJcRalTFiM
         zC15PziGO+uX1GLPYM0cZIz1UrLjz3pYw6yDdZAG5T1PVTyxvBQ8JZiRzViGCxiOi5MN
         eHA6KSzW2UGfVNUjGPjcqRjN+PgAOYKIPcwmPkXR+M1kB0d6rlMwLexJWYagTjS5/3Yv
         ASq29UcqoBu/4zHbPvGuwfIJRsjEnRHLmCC3rTMnkUqk8Is1i8SbPa5kElGnieO8kBgz
         S5zAENukPJuCj0CC3YVgV2/0jCeSvb7dMzF4LzjKRipWHSQmxGwrbcx/GHrnekIcjCPX
         aQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrkUU7sE69vgjh35RQ5n4EBCU38h7b3snj3kGrHBz4mWxyEv3ZZ4c1fUgZKEXfNdaVuywGctarkfda3+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDuXbuxwQKAuBkCzUdeV9pM4i8s/NhMrzMe2TFNy8kGOHB3km
	8vAQgj2S7rGVwfxEezy8j9iPsMhcjZCFi561HUSboF+zHauFRNjSb6MljV+Nra6mX131JPaqJ95
	x
X-Google-Smtp-Source: AGHT+IH/F6IbXemlHgBMRs2Js3Ir8ZqvtYCog5lU8fNn66LEKMc1coQVItVsTdrtkehfy0VLdCAVFA==
X-Received: by 2002:a17:907:2d21:b0:a72:7a71:7f4f with SMTP id a640c23a62f3a-a89a249ca36mr1379627566b.7.1725370728084;
        Tue, 03 Sep 2024 06:38:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898908f62bsm683472866b.91.2024.09.03.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 06:38:47 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:38:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 15/17] printk: Implement legacy printer kthread
 for PREEMPT_RT
Message-ID: <ZtcRZpLjCjWeC4nG@pathway.suse.cz>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
 <20240830152916.10136-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830152916.10136-16-john.ogness@linutronix.de>

On Fri 2024-08-30 17:35:14, John Ogness wrote:
> The write() callback of legacy consoles usually makes use of
> spinlocks. This is not permitted with PREEMPT_RT in atomic
> contexts.
> 
> For PREEMPT_RT, create a new kthread to handle printing of all
> the legacy consoles (and nbcon consoles if boot consoles are
> registered). This allows legacy consoles to work on PREEMPT_RT
> without requiring modification. (However they will not have
> the reliability properties guaranteed by nbcon atomic
> consoles.)
> 
> Use the existing printk_kthreads_check_locked() to start/stop
> the legacy kthread as needed.
> 
> Introduce the macro force_legacy_kthread() to query if the
> forced threading of legacy consoles is in effect. Although
> currently only enabled for PREEMPT_RT, this acts as a simple
> mechanism for the future to allow other preemption models to
> easily take advantage of the non-interference property provided
> by the legacy kthread.
> 
> When force_legacy_kthread() is true, the legacy kthread
> fulfills the role of the console_flush_type @legacy_offload by
> waking the legacy kthread instead of printing via the
> console_lock in the irq_work. If the legacy kthread is not
> yet available, no legacy printing takes place (unless in
> panic).
> 
> If for some reason the legacy kthread fails to create, any
> legacy consoles are unregistered. With force_legacy_kthread(),
> the legacy kthread is a critical component for legacy consoles.
> 
> These changes only affect CONFIG_PREEMPT_RT.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3459,6 +3475,87 @@ static int unregister_console_locked(struct console *console);
>  /* True when system boot is far enough to create printer threads. */
>  static bool printk_kthreads_ready __ro_after_init;
>  
> +static struct task_struct *printk_legacy_kthread;
> +
> +static bool legacy_kthread_should_wakeup(void)
> +{
> +	struct console_flush_type ft;
> +	struct console *con;
> +	bool ret = false;
> +	int cookie;
> +
> +	if (kthread_should_stop())
> +		return true;
> +
> +	printk_get_console_flush_type(&ft);
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
> +		short flags = console_srcu_read_flags(con);
> +		u64 printk_seq;
> +
> +		/*
> +		 * The legacy printer thread is only for legacy consoles when
> +		 * the nbcon consoles have their printer threads.
> +		 */
> +		if ((flags & CON_NBCON) && ft.nbcon_offload)
> +			continue;

I am still scratching my head about the fact that the legacy loop
probably should not handle the nbcon consoles also when
printk_get_console_flush_type() returns ft.nbcon_atomic().

We probably does not have to take care of it here because this
code is called only when the legacy kthread is running.
It means that nbcon consoles should have their kthreads as well
when they can be handled outside the legacy loop. I mean
that we should never see ft.nbcon_atomic set here.

Sigh, the logic is so complicated.

Do I get it correctly, please?

> +		if (!console_is_usable(con, flags, false))
> +			continue;
> +
> +		if (flags & CON_NBCON) {
> +			printk_seq = nbcon_seq_read(con);
> +		} else {
> +			/*
> +			 * It is safe to read @seq because only this
> +			 * thread context updates @seq.
> +			 */
> +			printk_seq = con->seq;
> +		}
> +
> +		if (prb_read_valid(prb, printk_seq, NULL)) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +	console_srcu_read_unlock(cookie);
> +
> +	return ret;
> +}

> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -44,7 +44,9 @@ bool is_printk_legacy_deferred(void)
>  	 * The per-CPU variable @printk_context can be read safely in any
>  	 * context. CPU migration is always disabled when set.
>  	 */
> -	return (this_cpu_read(printk_context) || in_nmi());
> +	return (force_legacy_kthread() ||

This is not correct when used in panic(). force_legacy_kthread()
is not a reason for offload in that case.

IMHO, we should keep is_printk_legacy_deferred() as is.
Instead, we should check force_legacy_kthread() explicitly in
printk_get_console_flush_type(). It should cause the offload only
in NBCON_PRIO_NORMAL/EMERGENCY.

In fact, the legacy kthread should be used only in NBCON_PRIO_NORMAL.
The legacy loop should be called directly even in NBCON_PRIO_EMERGENCY.

> +		this_cpu_read(printk_context) ||
> +		in_nmi());
>  }
>  
>  asmlinkage int vprintk(const char *fmt, va_list args)

Best Regards,
Petr

