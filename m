Return-Path: <linux-kernel+bounces-263225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D16D93D2EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CF31C21316
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B87C17A922;
	Fri, 26 Jul 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PuLfZwPh"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9FE57E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996727; cv=none; b=ZzsXoEM9lCSyu7Mds5SaYis13AEY4R7ybRQLWw5sXxEzn//mylj9/V4kipSYulzJdUn/uArPhvgU2MaEekO3C8M0UOUdJ6O9lphffcosx+OibgObW8AmZxvQK40TY2cpEoJI3gal8FdRyFmg4/xogwcnr0EqrPou+OIjgvs+5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996727; c=relaxed/simple;
	bh=MTgnslXe+A1fSxmMYf8YcWnUSPILT5QASaJ5dgLuDjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIfI+7zeh1InmatuEnT673Qm/V+R0S5dJvNUkwt4emu78LSElpBL2mQE0qPcqd5PfmQGzNHld3rBGHijEbkcvcIMOZcG/uvpoc7QQq1hN3M8S4kPY8tmp2wLxQkVDgv/97Wgm2dWW8wdWNwajfZ8LT5ehbpV+jnDwzfaMlih9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PuLfZwPh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso1927075a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721996724; x=1722601524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SReWfJbm+hDNspPtpMlPGtYPQJ1oBqxc9fLUZr6H50U=;
        b=PuLfZwPh3I6hdIiwBw4+LE3LrxRlWQzfAX2h/wuSsh4xUOdYrDxtyS66dkB4KPK76E
         gH89nL7EIh6I93cTWSF6rM61v2xqhn/CR1vTkRTJRgeb7DBSohISPNvprU55OjJK/9Mc
         EpFxfwgs9T+Yyy2hvSNQGR3lQtq+1tLK+iZ+pa0aqpIec6H+w4QWQwh8D+HajGcBeD8C
         Hd0Mr/LJJBPU3uBEe/s3qrA2l8LOGEj2ldGalc3MVSOnnT6FpehSjTpZu8x5yL4pfx/Y
         s1u38DprfSQpHa/vjozUjbg7QCM74sGWQKKEZGF+faoOBKJMQAXja2xN39/BxFYaZuvy
         XPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721996724; x=1722601524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SReWfJbm+hDNspPtpMlPGtYPQJ1oBqxc9fLUZr6H50U=;
        b=qcUVyjT4AyP+T/9GfP60WVUGSI1fZ8w++R6lMp2r94YgNeWrud/PMZSzunYUTd3abH
         EeeZDIBNidd2tuqlwCA1d8i9f7cLQ4Md7tsM4R710B8PWKbo+LzmBNjoBruXIaRGUt6B
         EVss90pa6VtgVxyJNUkExjMBpT/STbmM0+pSoyaeE3kWN0G6hNixji4FLJbcdmvk0ydl
         9n7JTGue0+CT2w0MzDg6Or/yyQdNaUdDid6SDDTVwJ+8Ipqx0wLULHEKjuidSzHfRlUN
         iPGikYdcafOaW/cW1zeVLLTaArlV7xJN9Li130EFYofnGVShwsh/07KcqWfAzHvJHKsb
         0r8g==
X-Forwarded-Encrypted: i=1; AJvYcCW6Px2CIha8NkMRPKHgdZ2oMMaVTOsu9VLLRJ/6JMdJIzNs3axk30GnWWJ4eZedhVJIeznNmeNeZE5WZSG5PP4R/itgrehCE2hCwo6e
X-Gm-Message-State: AOJu0YxxT2Q0AMsXosYhVB94w35oGXnjKjt7XR5i7EkssnYQMo9sLPNy
	QR12TLHdD3s7/C3Mg5cN+poXipDUuIJHu0X74hkxsyUavcYYtvoNnhPlp1mWm2Y=
X-Google-Smtp-Source: AGHT+IFNDDXw6RcUlpYLXUW2kq/FptHCPKgNj3Vyz5pSTFDWre3HnwSBX1s6cmwtkH9rZwQ4sK/6uw==
X-Received: by 2002:a17:906:2749:b0:a7a:b4bd:d0eb with SMTP id a640c23a62f3a-a7ac4ef5b07mr359921766b.24.1721996723591;
        Fri, 26 Jul 2024 05:25:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23094sm171607166b.5.2024.07.26.05.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:25:23 -0700 (PDT)
Date: Fri, 26 Jul 2024 14:25:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 03/19] printk: nbcon: Add function for printers
 to reacquire ownership
Message-ID: <ZqOVsZ1KGh3rkxE6@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-4-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:23, John Ogness wrote:
> Since ownership can be lost at any time due to handover or
> takeover, a printing context _must_ be prepared to back out
> immediately and carefully. However, there are scenarios where
> the printing context must reacquire ownership in order to
> finalize or revert hardware changes.
> 
> One such example is when interrupts are disabled during
> printing. No other context will automagically re-enable the
> interrupts. For this case, the disabling context _must_
> reacquire nbcon ownership so that it can re-enable the
> interrupts.

I am still not sure how this is going to be used. It is suspicious.
If the context lost the ownership than another started flushing
higher priority messages.

Is it really safe to manipulate the HW at this point?
Won't it break the higher priority context?

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -911,6 +948,15 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>  		return false;
>  	}
>  
> +	if (!wctxt->outbuf) {

This check works only when con->write_atomic() called nbcon_reacquire_nobuf().

At least, we should clear the buffer also in nbcon_enter_unsafe() and
nbcon_exit_unsafe() when they realize that they do own the context.

Even better would be to add a check whether we still own the context.
Something like:

bool nbcon_can_proceed(struct nbcon_write_context *wctxt)
{
	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
	struct nbcon_state cur;

	nbcon_state_read(con, &cur);

	return nbcon_context_can_proceed(ctxt, &cur);
}

> +		/*
> +		 * Ownership was lost and reacquired by the driver.
> +		 * Handle it as if ownership was lost.
> +		 */
> +		nbcon_context_release(ctxt);
> +		return false;
> +	}
> +
>  	/*
>  	 * Since any dropped message was successfully output, reset the
>  	 * dropped count for the console.

Best Regards,
Petr

