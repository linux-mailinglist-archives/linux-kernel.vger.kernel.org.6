Return-Path: <linux-kernel+bounces-269301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477C7943138
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036C32810ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B161B0114;
	Wed, 31 Jul 2024 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GBO90un1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9241607BA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433581; cv=none; b=IA3nP7eLlCe5enecde3cHartPyQ2nHmjcoyU+cOBeRZGYAzS9LJK84kC9Y2xqzOdJowaXYGtVWiH1EIgFK8TlOlzsTqz+rxmgxpuQKMsHIdxK/mFHUxHo9Oz5XyVI0R5xkbFK/U0UFNCWRA1hm4y2FqFLRaSWG06UMpiCn4OVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433581; c=relaxed/simple;
	bh=MGH2t5I3iPljalQz2d2AqO5oAQYJGZaaDc/LmaOMKvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2Ebomra5NPAJapW9saWxigAo0Zoj5MDzNtWEe7e6XwbZfB4qJWbJ3T4kH6wq9QBzwZ1B1xezPcJGziW1VNSLvXzxXlJEADI3S4+GhcU71M/yZg4P/DGzjyiR5yFx2hmf9wqo05evf+jJy9ckw3MC2xZW/JyHZkvfMdHmXKoSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GBO90un1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so7795554a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722433577; x=1723038377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T34VsdOAI1Mafkezfjshe9vwscLcLz1Bds5/jskRUQM=;
        b=GBO90un1vSfTOYRAgqtynDZ4nSOJF/qQ4gECogRAGc3mozoLkkkWQ2B6DgyZWDk8Uv
         jPPIcSoHPevzQwPilDm2hN7EnG4+FwACs5Mo/E2PembNs2z9QCto+/0u4Uw/iwYP3nJl
         o8QnwFQ7NJ0nJ+rnZ7DjL6cWlNBJiXtXPOx/q23RB+m03i2uhxO5dyr/DAy/yftP7lAe
         vwOV22jz4gQXYt7Z1k+EOdnRHGfIANCcqr2aFAYSY+MOyn9RVOrGdbkPANTr0iyAFV3+
         0gvHnYof4d1tm//RvuSjCnPrG2kaZ35uQyNUTp+MzaneLEwAN0WF1GkfHZfakpGnjobY
         Ns1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433577; x=1723038377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T34VsdOAI1Mafkezfjshe9vwscLcLz1Bds5/jskRUQM=;
        b=Oe34Z04NxQw1ysDhwAiK/LfSI0jKj1P1AxL6E6L5o8etHP4C2+ypDy4sTN4mkkhVoA
         REH27Chzt0dW6NAT0s/qIKECK+c5jAT1PsGfTkxmzyXXy9Ht0AW8IFiEswGv02+zRV9Y
         obAdNO8H9bzm6tlqmi6Zqe74gzUel+U08Zk3v2ZwslL6D85F3TXmXs/fspKKHo415JV7
         AxW7CKsNiOS7JBxDfdVbtwk/GIo9v1YNDw5fJW0yzGBEaWj0g3BjhT9TEW25EUeZRwkL
         Rzhon4/lBnLi+2A+EBlwU4TUIjdNd8Tc78gbBJ2rXPqeHk6qeHa38YMVSJa2tFdk2UzP
         9Bbg==
X-Forwarded-Encrypted: i=1; AJvYcCXcnCHkJVjLgO6k7liiwZElqF7/OxIVQ7yW88dNffIerl4W0HOgjC48J9JukOGAFpL8yXbMcmBxWMy6sJXVCXnT5/e8eUVFHGTuhGG2
X-Gm-Message-State: AOJu0YzC5AQweBlB4klZ5VesYg/du4zq2g0B0nk5oeLct0EF/iNg1Krr
	8E099S47cY5Ko2rIveS5S8y5LIyPJGUmgTvMNNwRPQob9pWVR63VfGznKHsZamM=
X-Google-Smtp-Source: AGHT+IFrjraqh3/Jl+BVTJz+yJ2l7VIZ2QcKn+vrK9b005BFcwWu7rMrpYpZ1ZizYE934Dm06Lm3Yw==
X-Received: by 2002:a05:6402:3552:b0:5a1:cb3c:bd3e with SMTP id 4fb4d7f45d1cf-5b02119040dmr11542981a12.20.1722433576852;
        Wed, 31 Jul 2024 06:46:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b10e20dbb8sm5906722a12.49.2024.07.31.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:46:16 -0700 (PDT)
Date: Wed, 31 Jul 2024 15:46:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: preffer_ofload param: was: Re: [PATCH printk v3 11/19] printk:
 nbcon: Rely on kthreads for normal operation
Message-ID: <ZqpAJgKeB0cIlTg7@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-12-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-12-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:31, John Ogness wrote:
> Once the kthread is running and available
> (i.e. @printk_kthreads_running is set), the kthread becomes
> responsible for flushing any pending messages which are added
> in NBCON_PRIO_NORMAL context. Namely the legacy
> console_flush_all() and device_release() no longer flush the
> console. And nbcon_atomic_flush_pending() used by
> nbcon_cpu_emergency_exit() no longer flushes messages added
> after the emergency messages.
> 
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -190,11 +190,13 @@ extern bool legacy_allow_panic_sync;
>  /**
>   * struct console_flush_type - Define how to flush the consoles
>   * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
> + * @nbcon_offload:	Offload flush to printer thread
>   * @legacy_direct:	Call the legacy loop in this context
>   * @legacy_offload:	Offload the legacy loop into IRQ
>   */
>  struct console_flush_type {
>  	bool	nbcon_atomic;
> +	bool	nbcon_offload;
>  	bool	legacy_direct;
>  	bool	legacy_offload;
>  };
> @@ -220,7 +222,9 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft,
>  				ft->legacy_direct = true;
>  		}
>  
> -		if (have_nbcon_console && !have_boot_console)
> +		if (printk_kthreads_running)
> +			ft->nbcon_offload = true;
> +		else if (have_nbcon_console && !have_boot_console)
>  			ft->nbcon_atomic = true;
>  		break;
>  
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 233ab8f90fef..8cf9e9e8c6e4 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1511,10 +1511,10 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
>  
>  	/*
>  	 * If flushing was successful but more records are available, this
> -	 * context must flush those remaining records because there is no
> -	 * other context that will do it.
> +	 * context must flush those remaining records if the printer thread
> +	 * is not available do it.
>  	 */
> -	printk_get_console_flush_type(&ft, false);
> +	printk_get_console_flush_type(&ft, true);

Hmm, it is a bit weird that we change the value even though it does
not affect the behavior. The parameter @prefer_offload affects only
the legacy loop.

It is even more confusing because ft.legacy_offload and
ft.nbcon_offload have difference motivation:

  + legacy_offload is used when the direct flush is not allowed/possible
  + nbcon_offload is used when allowed/possible

I am not 100% sure why I added the @prefer_offload parameter. I think
that it was for situations when we wanted to call the legacy loop
independently on whether direct or offload was chosen. I think
that it was for __wake_up_klogd() called from
defer_console_output().

Anyway, this is cscope output in emacs after applying this patchset:

<paste>
Finding symbol: printk_get_console_flush_type

Database directory: /prace/kernel/linux-printk/
-------------------------------------------------------------------------------
*** kernel/printk/internal.h:
printk_get_console_flush_type[225] static inline void printk_get_console_flush_type(struct console_flush_type *ft, bool prefer_offload)

*** kernel/printk/nbcon.c:
nbcon_atomic_flush_pending_con[1548] printk_get_console_flush_type(&ft, true);
nbcon_device_release[1848]     printk_get_console_flush_type(&ft, true);

*** kernel/printk/printk.c:
printk_legacy_allow_panic_sync[2343] printk_get_console_flush_type(&ft, false);
vprintk_emit[2381]             printk_get_console_flush_type(&ft, false);
resume_console[2706]           printk_get_console_flush_type(&ft, true);
console_cpu_notify[2729]       printk_get_console_flush_type(&ft, false);
console_flush_all[3102]        printk_get_console_flush_type(&ft, true);
console_unlock[3223]           printk_get_console_flush_type(&ft, false);
console_flush_on_panic[3375]   printk_get_console_flush_type(&ft, false);
console_start[3453]            printk_get_console_flush_type(&ft, true);
legacy_kthread_should_wakeup[3484] printk_get_console_flush_type(&ft, true);
__pr_flush[4290]               printk_get_console_flush_type(&ft, false);
__pr_flush[4302]               printk_get_console_flush_type(&ft, false);
__wake_up_klogd[4466]          printk_get_console_flush_type(&ft, true);
console_try_replay_all[4851]   printk_get_console_flush_type(&ft, true);
-------------------------------------------------------------------------------
</paste>

Now, the parameter @prefer_offload makes a difference only
when it is set to "true" and "ft.legacy_offload" value is
later used. It reduces the above list to:

*** kernel/printk/printk.c:
resume_console[2706]           printk_get_console_flush_type(&ft, true);
console_start[3453]            printk_get_console_flush_type(&ft, true);
__wake_up_klogd[4466]          printk_get_console_flush_type(&ft, true);
console_try_replay_all[4851]   printk_get_console_flush_type(&ft, true);

IMHO, __wake_up_klogd() is the only location where we really need
to know if there are any messages for the legacy loop, for example,
when called from printk_deferred().

It should not be needed in other situations because it there
is always __pr_flush() or console_unlock() which would flush
the legacy consoles directly anyway.

=> I suggest to

1. Remove @prefer_offload parameter from printk_get_console_flush_type

2. Update __wake_up_klogd() to check both ft.legacy_offload and
   ft.legacy_direct, like:

	printk_get_console_flush_type(&ft);
	if (!ft.legacy_offload && !ft.legacy_direct)
		val &= ~PRINTK_PENDING_OUTPUT;


NOTE: I actually suggested to use in vprintk_emit():

	printk_get_console_flush_type(&ft, deffer_legacy);

      But it can be done even without this parameter. Like it
      is done in this version of the patchset.

Best Regards,
Petr

