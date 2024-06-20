Return-Path: <linux-kernel+bounces-222656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B6910564
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2471C2081D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC821B14FE;
	Thu, 20 Jun 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eXrwXJV8"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412A1B14F9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888569; cv=none; b=c0T1fw5AN1r1/BH4oc/cQajIGm/LGeDafsazwQdR223CvGl0YUUs8avm7NhdCx/A8D3D3rGW+ft7d6A4Ps+7cVqjHSg9qPcM35cd8oP/nVmExU6Nb3Kr1gPd/dpsBgafRgIgb+hczXTVJ9v03+UH/67qqqxZBDQRWaMeILdC104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888569; c=relaxed/simple;
	bh=JeX2cHHt1BB+yQUaqJ/7ylch+ELl58bfOYjk1aFra0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLR6N3h4pDMbp2obULU3WZW4wNUy20nngw1Tp4cDc0R2GZ43rfTxpnR0CeOSXBnok4sj8RQ6ntzQThLdFnkE4svUVTZU3ED1UmXnXJXtJYUNmvCR2txr58YEp5DUKikaij4EqNqvhO2HpIVbiCSal3JlA9EmuDNVYRE4LI0i6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eXrwXJV8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so10693821fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718888565; x=1719493365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GyGKE7avvRKc8S2du0HE2b7qe8g3hybbtAloIUKP5U0=;
        b=eXrwXJV8xFQh6ZJm/qg2D+6S3rLh65JERlVtYSkxPHFHCOtnEJ8YoJTmL2kvfm7xJs
         9X78E+iXXldn0MfYHcf4ZdHXcfBoJClWVC93YjRNezZSMNsuTBPYDi/V/XgZmT+Euw6z
         R1cMMmVMJvztheM4TWRb4Umw4v/m8m2t1ci12WR97wlppxr/Hqm71vvYOpH1Ztf6F6FC
         rCnEEJeXJpvS/fgBeBpx/zX2fMMadzTjupIWZYKevdUB8zEY4lsYYd2WXI7/luPypCTp
         kgEsk1sbN6rSkhcYKrt8WsJucry19ptLdq0hdEtRj4GJD79CdFIQBbcpd0kVbqISO6qv
         P0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888565; x=1719493365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyGKE7avvRKc8S2du0HE2b7qe8g3hybbtAloIUKP5U0=;
        b=FScrH2q16MKfQ6lvCMWDHtbdw1bMJQmLp5pt8KVKfhhGICKptg1qzM2dcnri+/2ZBH
         cIj5dOtzValQkqGFizAcgOdkx+driKXV8qqln7z0bDVcBF/T9dQcWD7dwFXOdcuikMS2
         jHhPPJEPL21NncZmjTDpDWCm8wYCDgonFGJrQTuccN1jFi3xSOdLN3XAjKPHmdSZKCIt
         BpeMbbNEDqHGhsQYp9VF6iSH/pWOAE+AVQVb1ra6IZW8VoISSWFBmCxIUEBdx3p0uaoO
         VnwIbK+2jGT8488bTWFAtPhCCVC/ERdrBKKP2tcFwTLuidqRNCXHqFp6nml2sLalb90L
         mFjw==
X-Forwarded-Encrypted: i=1; AJvYcCVUzYHVv2HHEJCJ6TTnxzmHnNqo7VIuALHJb4w6E8qX3p/+oXMV6PbkWA7wRFkQQbyCT86NKnGNPCjHdF4qs9nveWsnAYKGPrwUDHhD
X-Gm-Message-State: AOJu0YzrBRSq18n4sbNlV6ibuqaTkuuJfgJ/8zNsE1yfA/RHxOlyeqi6
	ldwUYqwiILEOGyLRrQWvwuYpmx8Gzm+OaqsDABqq9QuJCeEscJGItzgVGWSneF8=
X-Google-Smtp-Source: AGHT+IFtHBvlnVNc/moBvKq6vvrK/WhnmlOYYkT7lAoP72B6LkCk/KZuuFLzrI4HNnuyKpNKzBfNtA==
X-Received: by 2002:a2e:8796:0:b0:2ec:3cc6:e156 with SMTP id 38308e7fff4ca-2ec3cfff59fmr31484231fa.50.1718888565179;
        Thu, 20 Jun 2024 06:02:45 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e57cdd9bsm1610433a91.34.2024.06.20.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 06:02:44 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:02:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 11/18] printk: nbcon: Show replay message on
 takeover
Message-ID: <ZnQobCf7kk5LZOHL@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-12-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-12-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:46, John Ogness wrote:
> An emergency or panic context can takeover console ownership
> while the current owner was printing a printk message. The
> atomic printer will re-print the message that the previous
> owner was printing. However, this can look confusing to the
> user and may even seem as though a message was lost.
> 
>   [3430014.1
>   [3430014.181123] usb 1-2: Product: USB Audio
> 
> Add a new field @nbcon_prev_seq to struct console to track
> the sequence number to print that was assigned to the previous
> console owner. If this matches the sequence number to print
> that the current owner is assigned, then a takeover must have
> occurred. In this case, print an additional message to inform
> the user that the previous message is being printed again.
> 
>   [3430014.1
>   ** replaying previous printk message **
>   [3430014.181123] usb 1-2: Product: USB Audio
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -891,6 +892,28 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
>  	if (dropped && !is_extended)
>  		console_prepend_dropped(&pmsg, dropped);
>  
> +	/*
> +	 * If the previous owner was assigned the same record, this context
> +	 * has taken over ownership and is replaying the record. Prepend a
> +	 * message to let the user know the record is replayed.
> +	 */
> +	ulseq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_prev_seq));
> +	if (__ulseq_to_u64seq(prb, ulseq) == pmsg.seq) {
> +		console_prepend_replay(&pmsg);
> +	} else {
> +		/*
> +		 * Ensure this context is still the owner before trying to
> +		 * update @nbcon_prev_seq. Otherwise the value in @ulseq may
> +		 * not be from the previous owner.
> +		 */
> +		nbcon_state_read(con, &cur);
> +		if (!nbcon_context_can_proceed(ctxt, &cur))
> +			return false;

I would like to better understand the motivation here.
I guess that this pattern might be repeated in the future.

For example, it might bring the question why we do not do
the same in nbcon_seq_try_update().

OK, this is called in context where the takeover is unsafe.
It could race only with nbcon_atomic_flush_unsafe()
which is called at the very end of panic().

So we have:

   + The race is a corner case.

   + It could happen only once beause non-panic() CPUs should
     not be able to acquire the console context any more.

   + The check reduces the race window but it does not prevent
     the race.

Do we care about these races?


BTW: In this particular case, the race looks innocent. It might
     happen only once. And the cmpxchg would fail in this case.


I would replace the check with a comment:

		/*
		 * Only nbcon_atomic_flush_unsafe() could take over this
		 * context. It would be the only context which could move
		 * forward from now on. The try_cmpxchg() would fail in
		 * this case. It should succeed and be safe in all other
		 * scenarios.
		 */
> +
> +		atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_prev_seq), &ulseq,
> +					__u64seq_to_ulseq(pmsg.seq));
> +	}
> +
>  	if (!nbcon_context_exit_unsafe(ctxt))
>  		return false;
>  

Othrewise, it looks good.

Best Regards,
Petr

