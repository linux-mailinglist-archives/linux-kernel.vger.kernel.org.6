Return-Path: <linux-kernel+bounces-267474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9E9411EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8193C1C23140
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520CF19E7E5;
	Tue, 30 Jul 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RvmrdIGe"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52C1922E2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342641; cv=none; b=FkygbXA6JvGZZxAMBbo6VGney+Az4DCP4xLwaDEL9k95F4LjnAwKeoZNc9SoHSMTRymqdT9kMEjgbHaWPLJUfjlU9EW0XhpH69vHJ1kh6FkCq9Homr8U4bjccogyeql57Jri/UXrpE4ep0+gAHTtJHLmToLNREpMUmkWD4Eml4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342641; c=relaxed/simple;
	bh=yB6rRXPulKe8ER/kgRWjockJNCr7wU0t40Cgr3W/kqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCKQLGvcqugTFDbGX9qiS9BDeMZxJu2vsSZJPpXWOojuA0PVmm8Eer809JRuA7yPNeMfv39seUsDnzk0wCMc9Z6mgTylgoa3fGmv6cs8oXb0ITa+eGyV7DVGtzEtvOELlYw+CIbRrIg3IZeQ+LW2iSfvKY4CGKFU1L+qrUmGO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RvmrdIGe; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f04c29588so8150248e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722342637; x=1722947437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPqerWhUZy1/aAz0EtcQxQ+rdP9sW3XIfvIfHEpzdfQ=;
        b=RvmrdIGeS5PsC6sYfFV5SDbgFOKyAfHn5yA9VxQZa1YI+jBh9rwqJUsfhGf2UlaUMg
         oHgLiy9u0HrP46JHPts3O++aIGgXmUI+UV9IDXi+ADqFHsLfE6o6p7QvRO8PQesTxsCN
         oEZFo2jG9TpBQiKpYDJfue02+bnAmWkzXQjjtGHBvacP5wR7eY9bIXiHtvgvv5HLgse0
         E59GtloRKNKk6JvNtquKIkxzruZ+0P4pCxx+1qrz0l5b9aT4by++bcnrsM4W+MRDnLkl
         4PpkO0566RWYF0oqo5bHSMSSRodQft0/wTi/eq6IbmGwFbjaVl0qAro7XgxF1EVUdotT
         1XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722342637; x=1722947437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPqerWhUZy1/aAz0EtcQxQ+rdP9sW3XIfvIfHEpzdfQ=;
        b=EVkoNsDm0QhLPJTxYFoZNDO5lduvYdSkKS2TEWEdQt45h8UVB/UgPRvJDOIixg1HQw
         OqZg8aorFXIVQD8I1DEEh0rIbAuNbZ9fnTYxXktByf4s97e1COOCmZ4mfg6qOeiPJkSm
         Q+8vmaU4mPIyyHbMmZUrlJEBMy3Ae0MTIiCtgrEh9KXOaMDrH5Yyp6ChKn3OJZXMbBya
         1UFoZHAnWI+ZRUVJSQwJLQd+mgiCq4sJ0DBgXtod1eQu41oTgZffVh1fpsqKfMG4tsUJ
         NAyjnin1NjwEeWmiyEolfjWy4SErXYW855zX1cw7uMZ4o+9vUo8vT13uJ3b3s4rOX1yp
         V5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVusE0RCmUDzT6AhZah3qiy3XSoMqYhdKPPfucBeyVCVVs0G3ZN9+T7YZsCaA9jFz72IPU9fHsYv/0qn6R+xAj5XqiB9V03RJ1eEp3r
X-Gm-Message-State: AOJu0YwdVEGhCul5qNsd9WChbPxIMGzytefXixgSCV3p+X0Us+01cPaJ
	mbYlHv4OD10TZMb8+dxcHpRDgZYmAtcONAA7HxpxfnWoa2Gf7APBfBX9b4Hch4E=
X-Google-Smtp-Source: AGHT+IEKliAdIsWwyGoq7/gtKcT5IxaLalwveAES344NAJZjLbb0B5nGpRIuDsDEk7y65gdiL1wWAA==
X-Received: by 2002:a05:6512:2c85:b0:52e:f9f1:c13a with SMTP id 2adb3069b0e04-5309b2698c3mr8956076e87.12.1722342637190;
        Tue, 30 Jul 2024 05:30:37 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4debasm640720966b.60.2024.07.30.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:30:35 -0700 (PDT)
Date: Tue, 30 Jul 2024 14:30:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 08/19] printk: nbcon: Add context to usable()
 and emit()
Message-ID: <Zqjc6eDy9NzSaStJ@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-9-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:28, John Ogness wrote:
> The nbcon consoles will have two callbacks to be used for
> different contexts. In order to determine if an nbcon console
> is usable, console_is_usable() must know if it is a context
> that will need to use the optional write_atomic() callback.
> Also, nbcon_emit_next_record() must know which callback it
> needs to call.
> 
> Add an extra parameter @use_atomic to console_is_usable() and
> nbcon_emit_next_record() to specify this.
> 
> Since so far only the write_atomic() callback exists,
> @use_atomic is set to true for all call sites.
> 
> For legacy consoles, @use_atomic is not used.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -938,6 +939,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>  	unsigned long con_dropped;
>  	unsigned long dropped;
>  
> +	/*
> +	 * This function should never be called for consoles that have not
> +	 * implemented the necessary callback for writing: i.e. legacy
> +	 * consoles and, when atomic, nbcon consoles with no write_atomic().
> +	 * Handle it as if ownership was lost and try to continue.
> +	 */
> +	if (WARN_ON_ONCE((use_atomic && !con->write_atomic) ||
> +			 !(console_srcu_read_flags(con) & CON_NBCON))) {
> +		nbcon_context_release(ctxt);
> +		return false;
> +	}
> +
>  	/*
>  	 * The printk buffers are filled within an unsafe section. This
>  	 * prevents NBCON_PRIO_NORMAL and NBCON_PRIO_EMERGENCY from
> @@ -972,7 +985,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>  	/* Initialize the write context for driver callbacks. */
>  	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
>  
> -	if (con->write_atomic) {
> +	if (use_atomic) {
>  		con->write_atomic(con, wctxt);
>  	} else {
>  		/*

This "else" code path duplicates the WARN_ON_ONCE() and nbcon_context_release(ctxt).
It could/should be removed.

BTW: There is the opposite bug in the next patch which adds con->write_thread().
     It removes this duplicate "else" path but it does not extend the initial check.

     I am sorry. These are mistakes from the refactoring which I have asked you
     to do.


Otherwise, this patch good.

Best Regards,
Petr

