Return-Path: <linux-kernel+bounces-267770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3967A941542
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93E4B23BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DE1A2570;
	Tue, 30 Jul 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bz7DY0qo"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04529A2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352601; cv=none; b=d/rgqxhGgrQkgX2HcY+qWadrjSJV5RTT5JvU/BJTmGPKhltaPGK07jHVFuX8fz6nSgjFgPD/bKP44VhNuPene7rDhlJtPSDjIQPWxCE9EO7GDj71jvm+x6V8razHaKQkEvBg9CMp5k5GNPBsYaFeNGYPQ6Y4wrl7AYurv+0TI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352601; c=relaxed/simple;
	bh=QkaU8UiA5I9djqt6kbRkZU3tC6MKjfSdPVrPhjG33+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSB8a8sJKnp4i39bQcux/Uete2lqYEuxIuxOU52Siv5l4QuemilH7SwY3K6pnXgJ3VYZDlV4kjN8SDK3HlEGL1U59sLlT5Y+yM1zfpSjzuRGSWR1J+LQ32RrssKMQ/5Fn3ad6GRWFs+hYCakyxsYLaiF2rsCqHmFGmoTBbWZXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bz7DY0qo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso7044261a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722352597; x=1722957397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U73EqV18yTDw5WAowVTQIczwGm2YhF2hix9RVY2/sS4=;
        b=bz7DY0qozZxFvX8KDxwX6bGHcdkpdp6UPWFDKDvjbQAwAFlQa885cg3LG8Wq3WKAcv
         7CnP/VzQj89i+r8IplHL+8SfvWS0ARTiWJKbQD/rxcNmYTcd2IHhcSuAo9b6fAxzee1e
         49rr0U9DR2hsqcTEmRm4arfdbijUXsikcZSXWu1G/fBtjqetbPg6l8G9cxMLUQVLvWgE
         zkIklMS/MzupOupB+0V2MLmVLVYC7TLIZH1jKg/UBparKYNC4uNeLSkBN9EFudR3/9xk
         fSJvRa7Dt4ehsh+3kiA81DzJI5xlUwawJKw+2YSP927FTMGr2neFGb/p+FVzzWjyofek
         Af2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352597; x=1722957397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U73EqV18yTDw5WAowVTQIczwGm2YhF2hix9RVY2/sS4=;
        b=a0XGXtaBehGOVPyD2cPjN5AlGTXRyWi5NfeUMwZ9BIX8au1oHYIpqDjXvGqIL1YS5Y
         eMRfHsroD8hykDmxpcg9qksxxB+cW2eS4fyxCl9JZkKJimAnfmWebDAP+yj+FVqMilHn
         ZqM+D2d822SpK1DxJiw9OyvIRpo9en1w121KAOWEKO5ClyR/H7yKp06Rt0mVvzhR6j7v
         UaOFaVK+RExAuXg5otsj0ZoEMD/cR2gdMFAdokz3izFt6PX/AH1efjzvRfWkoTHeFkAS
         O6ZtzERxQt3AHnF4CP0bsURCsktBZk00nKXMTeuwC4q7E0njzvU0pwLIu3GXMeWjoEvr
         y2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUDQBueshScLMny8fnVQFHETcxoLj+Rs8wmCKpnBpnxLnzH0m0Cg6nNIfulT5m3aHinXMAmSUqM0qNWEUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOGB3S+f+dLtJyEVzpcGzkKu4WlWPAJxlEINi2tj7JLLMpsvs
	ixvTqkxXcU4IEtfKeo34xRpOBdDx6FPn0r3wwkDuiRAQYaXEsTHQw/n3j6G5lB8=
X-Google-Smtp-Source: AGHT+IGzAkqO9+zIJIy8uga6PAdPY056k2a+FMQmVjRj15tgNTBqG/jqMglCbo9bZ0THLeflTHXvHw==
X-Received: by 2002:a50:a406:0:b0:5a3:3062:36d6 with SMTP id 4fb4d7f45d1cf-5b020101f69mr7733438a12.1.1722352597243;
        Tue, 30 Jul 2024 08:16:37 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac65783621sm7476764a12.89.2024.07.30.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:16:37 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:16:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 09/19] printk: nbcon: Introduce printer kthreads
Message-ID: <ZqkD096ddCv_4PgB@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-10-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:29, John Ogness wrote:
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

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -985,17 +986,10 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
>  	/* Initialize the write context for driver callbacks. */
>  	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
>  
> -	if (use_atomic) {
> +	if (use_atomic)
>  		con->write_atomic(con, wctxt);
> -	} else {
> -		/*
> -		 * This function should never be called for legacy consoles.
> -		 * Handle it as if ownership was lost and try to continue.
> -		 */
> -		WARN_ON_ONCE(1);
> -		nbcon_context_release(ctxt);
> -		return false;
> -	}

This "else" code path should have been removed in the previous patch (8th).

> +	else
> +		con->write_thread(con, wctxt);

We need to make sure that this callback exists by extending the check
at the beginning of this function:

	/*
	 * This function should never be called for consoles that have not
	 * implemented the necessary callback for writing: i.e. legacy
	 * consoles and, when atomic, nbcon consoles with no write_atomic().
	 * Handle it as if ownership was lost and try to continue.
	 */
	if (WARN_ON_ONCE((use_atomic && !con->write_atomic) ||
+			 (!use_atomic && !con->write_thread) ||
			 !(console_srcu_read_flags(con) & CON_NBCON))) {
		nbcon_context_release(ctxt);
		return false;
	}

>  
>  	if (!wctxt->outbuf) {
>  		/*

Otherwise, it looks good.

Best Regards,
Petr

