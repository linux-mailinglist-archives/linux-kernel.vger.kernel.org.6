Return-Path: <linux-kernel+bounces-237946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB759240F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDDDB280F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803BA1BA07C;
	Tue,  2 Jul 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LOA4i/QO"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940CBE7F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930682; cv=none; b=e90zPM6HQ2IRKeBlULJaKnSQkF71CZmwFei+aiAZYZaPQNKiDPqaPjLF4Ox6pYoqzBJuZ/oXx2jNO0+Qk9vIyq7yydElFdwhj/3Ff0T130ltShmZ8sxliOzPJvDhuett0+3gBa+A10rpC5UA+t7JCea1igAJfXvoEBuztO6w0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930682; c=relaxed/simple;
	bh=l6JVGMlNyYRkcFYfdqOo5/r/SI3XCX2R3K6D4nyaWZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gInlzBFS77nV3TN9Vpq67wHlhJJ0QFMObW0jkKEWsq6+u+nv5lga6faBQyPalQ0H7wmVmTSITbQ+1XczLuatQqhOQWQMGaIfmmwXlUGvDoQkcs9Fw9ptP1xoi4RzuN8ZT0G99wPSh0qLHZG77eMun96GLSYkqkhD8cE7szqXzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LOA4i/QO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso51044611fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719930677; x=1720535477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjc/BRxjcmiCb2253U5dycj6Bj9X7JTZEyKzIJ2pbhE=;
        b=LOA4i/QOYICnJmjuN0EUJHZ6GJXeJeNJ+aunGKLYfCh8MXWk0RicbsuZx4qepVkmBw
         Qvu5LTC9JLWjSiuLLhhoHYirPqj1XI3CSkRP4G8xaqFkfBXh9mlZZDbbC4TsJ+qApc1b
         SWzDaWe99WZJ5SsW50fXBSGkLpr4LrHVnBf6v1lWhepKNxTFRBWj3xS/GlqAJ4/mj4hs
         cFBi1XHukHvmnbsXXQrg15OJSpz1fPWGJr+flNpI8Df9dtT8/pIRD7lZOU9AYzeholb7
         MbHyY2WpP4N1xWIuTPdWl94VMELkpyIY/K5JJA7+68EVKlgnYnis6ovtBiiVlSbSBuC2
         8Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930677; x=1720535477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjc/BRxjcmiCb2253U5dycj6Bj9X7JTZEyKzIJ2pbhE=;
        b=MXISEQ7SlvcUDRBeJs9VpEpUDRpCWNC8jzavNWQ+W3+O1ilBi+2KnxLhLMNgyE/q4Q
         GFs43cf17cR2ShgVSsJGnoS3sgXoilOp8NQunOb4DHh9U2isT6W55bG8KvlevDsUKGRZ
         SC25K5ndaxSpP6Hqg9e1W9xMqtIluFWljff5A88baBLf6+xKqiHSKvNuXIy7knjqA0V6
         cDGSb4dqjhGVrArOR5F+kgf4U2RNSLjx1aBoiu0X4wCEI2gZn0RepvQqr0MJWP0mrU1T
         S20UGjGTB3k6PqbQoWuOxItvijyDY81BKubntJA/QVB1Na3ItdPPZCzUsQFisc8LnWgH
         Qm6w==
X-Forwarded-Encrypted: i=1; AJvYcCVk46pP4VEbFOcc8ktMsCm6j5es+7A47c3CPxyxNFinJMKUWk5lJHqB0jZHpZhUF9AqAbHLXbAtuustVamZxRhx0qXk0WdaVi3/Zta4
X-Gm-Message-State: AOJu0YwZuFRnNfeHExTtqFiRYsaW1/XMOKthR9+nlaQnpPlB5iiS6YEK
	lz+w2Y7KoDgsEhZ/YFmqfzuplGgyVERQ6/pAaYd12q9ownyPmJQMpSs0SKYlrLgmHTOJ56MeevY
	F
X-Google-Smtp-Source: AGHT+IFo6KTiQ1JrCqd5r6y21NRg87CBVANurgUAb5IOP4DgbPWsyqy655pzyYd7G2J9dP9SRSrrhg==
X-Received: by 2002:a2e:a889:0:b0:2ec:558d:4e0a with SMTP id 38308e7fff4ca-2ee5e393e16mr80931611fa.19.1719930677016;
        Tue, 02 Jul 2024 07:31:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f6021sm6729746a12.71.2024.07.02.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:31:16 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:31:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 18/18] printk: nbcon: Add function for printers
 to reacquire ownership
Message-ID: <ZoQPLe-VogelU4Jm@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-19-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-19-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:53, John Ogness wrote:
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
> 
> Provide nbcon_reacquire() for exactly this purpose. It allows a
> printing context to reacquire ownership using the same priority
> as its previous ownership.
> 
> Note that after a successful reacquire the printing context
> will have no output buffer because that has been lost. This
> function cannot be used to resume printing.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -838,6 +838,38 @@ bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
>  }
>  EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
>  
> +/**
> + * nbcon_reacquire - Reacquire a console after losing ownership while printing
> + * @wctxt:	The write context that was handed to the write callback
> + *
> + * Since ownership can be lost at any time due to handover or takeover, a
> + * printing context _must_ be prepared to back out immediately and
> + * carefully. However, there are scenarios where the printing context must
> + * reacquire ownership in order to finalize or revert hardware changes.
> + *
> + * This function allows a printing context to reacquire ownership using the
> + * same priority as its previous ownership.
> + *
> + * Note that after a successful reacquire the printing context will have no
> + * output buffer because that has been lost. This function cannot be used to
> + * resume printing.
> + */
> +void nbcon_reacquire(struct nbcon_write_context *wctxt)

I think about calling it "nbcon_reacquire_nobuf" to make it clear
that it is not a complete recovery.

> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	struct nbcon_state cur;
> +
> +	while (!nbcon_context_try_acquire(ctxt))
> +		cpu_relax();
> +
> +	wctxt->outbuf = NULL;
> +	wctxt->len = 0;
> +	nbcon_state_read(con, &cur);
> +	wctxt->unsafe_takeover = cur.unsafe_takeover;

The nbcon_state_read() makes it a bit tricky. I would hide it into
a helper script:

void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
				 char *buf, unsigned int len)
{
	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
	struct console *con = ctxt->console;
	struct nbcon_state cur;

	wctxt->outbuf = buf;
	wctxt->len = len;
	nbcon_state_read(con, &cur);
	wctxt->unsafe_takeover = cur.unsafe_takeover;
}

It would help to keep it in sync with nbcon_emit_next_record().

> +}
> +EXPORT_SYMBOL_GPL(nbcon_reacquire);

Otherwise, it looks good. I do not resist on the proposed changes.

Best Regards,
Petr

