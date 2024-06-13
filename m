Return-Path: <linux-kernel+bounces-213228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941890723D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8410CB2521C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B981AA7;
	Thu, 13 Jun 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LNf+c3Oe"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED24A07
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282699; cv=none; b=Kg+F0LaSSOR2K7hITSIVvRXgbsQT14mqvvPZdIyE/KQZ2ZRzktBNOgXRGT0w2z32OzH/fjfcCeVOvawOJG83yW6sOLBoPZqGDh33ymwZER72MtXaysDcsWIdBVl+zY6ggzAu3oOoBdIIOP2agZF/gx6VawRcy+QdnTnYYKznNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282699; c=relaxed/simple;
	bh=Oc/aNnSJanTDNPeyaIgkcgxBXSkytTnrCARPAp5zkbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vpouf7QXsZq9KqbDFHqutnRnmqguzYDU5QnqlHIsZTPXL32GguCapflu5HBkr55eeKWLSTju8HR64HHXCG4vCg3AnQamhe6RpSp7Lvac7BofJN3WEVWJI00B6hAeymou9IIqDFqtdZceqhKv0AzFj/Zjq8r358u0fIcaSAhv1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LNf+c3Oe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so1030926a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718282695; x=1718887495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvOE+xx/r3Ze7HhTtH9a9kVEqKKwBRndNOB7sOnUFic=;
        b=LNf+c3Oe82hN9WrzMqF5cJk5oC4xCGEZgexK4aRQqbccgxHDnXswb0EazwSLCSbARP
         KxHomZ5E4MO3wP24sI72ZIL+RgEm8fGq4/hVPF518jhWviIPwG3B355EaVRZwXttN5nJ
         ppg9izQrkzOSv9DpvtQjLD6ex3qGWf+JCK4Hc3PFO1yvf/0/s9HAmlA+cbK8sBkhZ9Vi
         iX5nlzIeghIKXLwfuM6N3pg4mHYj0YOVCu2s438vAUAA71yDlLXCJd7o3frKBBzgC8Jw
         bWY6oTI4DdyWU2q9PgKMMjim6ZSaLD/4XL8dfhEO3BRr3yTn9qyNdgOLYUe5Wpr5AB6X
         h1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718282695; x=1718887495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvOE+xx/r3Ze7HhTtH9a9kVEqKKwBRndNOB7sOnUFic=;
        b=mIkxsktoPd427emjGCu+OSpvHYWV2KCm4UcpgZL23pI6VJg2DsYS9+S8v+lg0LkycY
         rnk34DbyvrkfGgDqePG5mT43jIFQmks6D46AxGiPYRp7P4qfp9wgQV18VdqTb0Oeb4TI
         jY++vT3ZG0Rd0p9hL33dk2oum3f3+SwUurMNc/1alaPgSXAhzjaqUXV+lFXU4yeDeSZC
         Frq7s6KmgDxGkX86O/nu+aNtjg4PIqRymcX4ADR4E3d8NRv9BvnkyqlWprNXwDf/Mlas
         zGLFCSOzL9hW775U3lHnpGGwvs2ACgeLYGazYMprR8RuKdlnMiTNSGys97eoyJI6Prj5
         29MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUorvQ67iAsARwIgyIofCewivUZXR1bth3rsj/z6Acy9SDYyia5FumZq1SD4btkK/RO2/oXMMDgaoZTuzjt15l8QZPTBzKdtA2JvEPP
X-Gm-Message-State: AOJu0YwzVJnL3BMQN2A6+oMqqZEek5QDM2aJRVjuYQMK3Mh0hUEYoN1P
	/+Otkpa468noJudBNSRZo+cW+3tsyg629QzIb1ywpufA6sslM6jLT5fHjZ2wfiQ=
X-Google-Smtp-Source: AGHT+IE7tRl2qbcE5CGef/X1hGQ2OhLzQSUYdcPVKA68oRoqNWQX61/A8+u6giaDms0iPzKB0J7/7g==
X-Received: by 2002:a17:906:6bc1:b0:a6f:3155:bb89 with SMTP id a640c23a62f3a-a6f47d5f3c8mr266082466b.70.1718282695398;
        Thu, 13 Jun 2024 05:44:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9978esm67672866b.200.2024.06.13.05.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:44:55 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:44:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: atomic_flush vs boot consoles - was: Re: [PATCH printk v2 05/18]
 printk: Atomic print in printk context on shutdown
Message-ID: <ZmrpxWxUb8k4swrA@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-6-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:40, John Ogness wrote:
> For nbcon consoles, normally the printing is handled by the
> dedicated console printing threads. However, on shutdown the
> printing threads may not get a chance to print the final
> messages.
> 
> When shutting down or rebooting (system_state > SYSTEM_RUNNING),
> perform atomic printing from the printk() caller context.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/nbcon.c  | 5 +++--
>  kernel/printk/printk.c | 7 ++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2389,12 +2389,17 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		 *
>  		 * - When this CPU is in panic.
>  		 *
> +		 * - During shutdown, since the printing threads may not get
> +		 *   a chance to print the final messages.
> +		 *
>  		 * Note that if boot consoles are registered, the console
>  		 * lock/unlock dance must be relied upon instead because nbcon
>  		 * consoles cannot print simultaneously with boot consoles.
>  		 */
> -		if (is_panic_context)
> +		if (is_panic_context ||
> +		    (system_state > SYSTEM_RUNNING)) {
>  			nbcon_atomic_flush_pending();
> +		}
>  	}

I was curious why we do not need to add this check also to
console_flush_all() which checks con->kthread as well.

I realized that we call it only when

  #define printing_via_unlock (have_legacy_console || have_boot_console)

=> it handles nbcon consoles only when there is still a boot console.

It actually have to handle them in this case because the boot consoles
can be serialized only via console_lock().

In fact, nbcon_atomic_flush_pending() is not safe when there are boot
consoles. This is handled in vprintk_emit(). But it is not enforced
on several other locations.

I played with a possible solutions. The conditions around the console
calls are getting more and more complicated. I am going to send a
solution which looks acceptable to me.

Best Regards,
Petr

