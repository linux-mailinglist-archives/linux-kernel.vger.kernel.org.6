Return-Path: <linux-kernel+bounces-313164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B396A141
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12C71F25E61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C216D156871;
	Tue,  3 Sep 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FU3uqcKs"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A115573B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375236; cv=none; b=X6SZW9bxChlfHbPfjoe5tMpMXZeiaP5AmoJwCQaQ5J7iZLOSnQ2qh2LjfoQ00E+e4dvOzwNRXijPdCv8Zm0lkfwxaqHaLDYvFT5b+PJcCYIHr//mdXTAunDFIoFWNUOr1/PwIsw9T+bYPJMG5j1c6U40QttfXCJUkPMSrKWM6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375236; c=relaxed/simple;
	bh=2FT8c10AkYvY80YjQRJvvosjj4mrogPHpDHJUl2D2cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcTX25bAQmP+YcyyIjDqU5qclIAJC92g/MaO87z44Y/M51EE3LUVeKeOIjPpz57zX5ZLXN0I6BMQihwH8MS/PHbkMGIhNDPsFdgx7iTymwMVLbo1B8MCaFbl9YUv2nGkpw7FtiNb4AuSntU83zfCL6P0NHzaxB+1f/VDqlOi+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FU3uqcKs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86a37208b2so627289866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725375232; x=1725980032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfk3M8meVjel2VLk0d2wXjtsD1/6GZWbQVpdYUoqgkc=;
        b=FU3uqcKs/XiykSBDdElRI7BqxUGGOIz/zF+T5ya0hVrtTW25Xr6KJ5+2P41dWPt9PL
         UwaoVvaKo0iljYEgapzc1BqZDaVjXtOuKSHzpceVgYWLhXl6V7AFPACMoT066W+GUdeV
         kG8i5Z8cPP+4v5kg5DknAR3HNFfNu84av5q89p0lT3lFtXxgFiETY0RLIEdngRLf8ns5
         eVHgv702Ry7ePQKNlnmRIks7B4jNgXJIqzYcZqeqaBRgshfATDzaR0MVMUlzwxYMsDn0
         8ioYRib465G8k45ck3ZVRK/9D3+cm09iNwb8Aw9CEsl0exXuxJw+yTRmyfYTg0Z32HVl
         RGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725375232; x=1725980032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfk3M8meVjel2VLk0d2wXjtsD1/6GZWbQVpdYUoqgkc=;
        b=ea8vux0hEg34m45XUegku4UyGBlK8aPOxWZsBUqaKY/tJvC0O5Pwq8phAF2WBS84MP
         4bIy8sWUztBrwWdaQtbupzSNXlDHM7gQa5j6REcf1n8oSxNuQrOdutanbd+UmLfxMk5y
         iZc9Nntc5EDc+9K0gMfm9I6t9VJDc76HbtcDJLXNhabDL6/8kmCtyzuJIYkqpIQaXBD/
         XOobx5LNPl5+H1NDtgPBW2kYmvmAG28MK3zAWWU+OaErbvxBNUY8U4iqhlb/plf7tQrl
         HSHpZiSiXf6NSmV7fi17z0pMMr7zIktiReorzYo0R/sqQbax3Y0arCZCIJeukdy9oR0n
         BRUw==
X-Forwarded-Encrypted: i=1; AJvYcCV3PaVGMQZYkrPWgg6VnrHZMu2/i+zHZ/ShnIa6jGfceF7Reo8+HEgL/0yd8QvBUFH7wRxDvkcxQuY61fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvTTNFk16poL06hRf5gYPLwDOndITowZxlEs6W4oCom/YlY3d
	uSGU9/Iv0R93DCMLwfLERfJPq0ew2N/RUvVOj1XGJ01/y1KsWVvNOWrq0IAPzNo=
X-Google-Smtp-Source: AGHT+IHGdFV2oTThl8yDKdpzxHf74GQ/hsymgHw/WkcSVjKHMhk9YDqCVndaympg+ksetPaeK86Hgw==
X-Received: by 2002:a17:907:7dac:b0:a7d:c148:ec85 with SMTP id a640c23a62f3a-a897fad50afmr1096260966b.62.1725375232195;
        Tue, 03 Sep 2024 07:53:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989233403sm688802166b.212.2024.09.03.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:53:51 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:53:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 17/17] printk: Avoid false positive lockdep
 report for legacy printing
Message-ID: <Ztci_qeXE9FGr5EA@pathway.suse.cz>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
 <20240830152916.10136-18-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830152916.10136-18-john.ogness@linutronix.de>

On Fri 2024-08-30 17:35:16, John Ogness wrote:
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
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3030,31 +3058,46 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>  		con->dropped = 0;
>  	}
>  
> -	/*
> -	 * While actively printing out messages, if another printk()
> -	 * were to occur on another CPU, it may wait for this one to
> -	 * finish. This task can not be preempted if there is a
> -	 * waiter waiting to take over.
> -	 *
> -	 * Interrupts are disabled because the hand over to a waiter
> -	 * must not be interrupted until the hand over is completed
> -	 * (@console_waiter is cleared).
> -	 */
> -	printk_safe_enter_irqsave(flags);
> -	console_lock_spinning_enable();
> +	/* Write everything out to the hardware. */
>  
> -	/* Do not trace print latency. */
> -	stop_critical_timings();
> +	if (force_legacy_kthread() && !panic_in_progress()) {
> +		/*
> +		 * With forced threading this function is in a task context
> +		 * (either legacy kthread or get_init_console_seq()). There
> +		 * is no need for concern about printk reentrance, handovers,
> +		 * or lockdep complaints.
> +		 */

The legacy kthread is used only when it is running.
What about early boot messages?
And what about NBCON_PRIO_EMERGENCY?

Hmm, it seems that force_legacy_kthread() really prevents calling this
in interrupt context because is_printk_legacy_deferred() always
returns true in this case. Is this correct? I actually reported this
as a bug, see https://lore.kernel.org/r/ZtcRZpLjCjWeC4nG@pathway.suse.cz

Or is this the only possible way to avoid taking sleeping spinlock
under raw spinlock in RT, please?


> -	/* Write everything out to the hardware. */
> -	con->write(con, outbuf, pmsg.outbuf_len);
> +		con->write(con, outbuf, pmsg.outbuf_len);
> +		con->seq = pmsg.seq + 1;
> +	} else {
> +		/*
> +		 * While actively printing out messages, if another printk()
> +		 * were to occur on another CPU, it may wait for this one to
> +		 * finish. This task can not be preempted if there is a
> +		 * waiter waiting to take over.
> +		 *
> +		 * Interrupts are disabled because the hand over to a waiter
> +		 * must not be interrupted until the hand over is completed
> +		 * (@console_waiter is cleared).
> +		 */
> +		printk_safe_enter_irqsave(flags);
> +		console_lock_spinning_enable();
>  
> -	start_critical_timings();
> +		/* Do not trace print latency. */
> +		stop_critical_timings();
>  
> -	con->seq = pmsg.seq + 1;
> +		printk_legacy_allow_spinlock_enter();
> +		con->write(con, outbuf, pmsg.outbuf_len);
> +		printk_legacy_allow_spinlock_exit();
>  
> -	*handover = console_lock_spinning_disable_and_check(cookie);
> -	printk_safe_exit_irqrestore(flags);
> +		start_critical_timings();
> +
> +		con->seq = pmsg.seq + 1;
> +
> +		*handover = console_lock_spinning_disable_and_check(cookie);
> +		printk_safe_exit_irqrestore(flags);
> +	}
>  skip:
>  	return true;
>  }

Best Regards,
Petr

