Return-Path: <linux-kernel+bounces-182155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026A58C876C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970181F246D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031DC54BEF;
	Fri, 17 May 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B2SJN3h/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566446452
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953495; cv=none; b=RpZBi6uvOuCNv0+Vha7eejg3BE3UHn6846AgpE2O8mI9dZfKKqW0zL4PReBr1OShrLT+xaatl9PkyH4khjGgiLJhM17qSzMMnPSJ2qYNE4CD84IyXif2HNOUpGN4yymYOqmHvadRMYogFcYY1sIoNs2ABXY8jvWH/+IzRE/91IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953495; c=relaxed/simple;
	bh=GExcdOY85f+aEWahGqlvmsWhKfnoLUnvrPSZ4xD2rr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p15jjr/mCIzDEbZuILEDYeaFxheH1V/zBU/e1Z91xmhEQi3YMq2JFLvvD/eqCLbn+HY02YE4GuJ+QlW2C5VFFE1dpesuzpQr3n/6hLfsixjQNORl2kTU0Um4MY16iwNJi1gItR+OLX3LBjvjFSq0hSlro8gJsICfmoqT8ffzprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B2SJN3h/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5a88339780so484225666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715953491; x=1716558291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vpnp0ikbeI08D7PBvPP5hNJOwdhrB+t4w5/Ot513WnI=;
        b=B2SJN3h/Klmp/GUao4eJoR3au7heR1YAxWIJkAHKqfJNoeiv4A8f8oMpzv809fKin0
         3UKhMGgj98DyEhnLIJKa3nJr0bAqCD0UaBWnZKg7EFi9VSA5IKOI9T3LAmR28XSLm4iL
         /e6XX5Af8I8grmtZAGLn4jY8erawKpNPCNhN1YARG2mWrwOU3iYzlNgQGmlm017SKTh8
         bAGvhsqNUVVlv6Ln3O0quLoXkXV/RGFCbyWuhUpcaphxMoFfY2AUOmDEf64QVJXSHzr9
         DvyTrgYUAo7Q9X8SRCspUi9mKKR8GkUVGIeR8qPifJvqr6sOHxA637KQhDaFS/iLNtso
         tLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715953491; x=1716558291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpnp0ikbeI08D7PBvPP5hNJOwdhrB+t4w5/Ot513WnI=;
        b=Kulp2WvP83QX4XwTDpanOHRJQb1ygb+JzoI2sT86bH9POSVWdehKt+QYkXiHBMQ+oi
         DYR2PToHTABUx0TWzZUQaZBCUq0NMnn8y5i1I4jUCcihzK7LanffScxBtG8bkx4yUp5B
         6g/yEdjYaNbBouAMGUymmhejwYB9xxZa08CMRHreJsN11yAfI9ucckZ4Dw0g8NMLwr4t
         dcOoOJNhRRlfcvJXs/W19NCKs2XjOURgFacBZWHw2Kgau9ormNTbD1rPguGA4KCq5C81
         LhDXjILZkOr62voCsE5QjVCJnzB9pqYzWHZyvOcAzHffr1RB7dw6DyuINXmM2/0Vl0zM
         xcyg==
X-Forwarded-Encrypted: i=1; AJvYcCW5znhMYPkGpSl44kV45RifMq7sMj8KMXWSLxGpVx0msq7H7ksnVJ5mmKFMW/D45AzpbNyXTg/NvKT+PnoBu7Y+Vf0BtCfgGhtUZY+N
X-Gm-Message-State: AOJu0YwVYEF/HZ1LFKHT/be/ljQr2AML7c0QuLmrjs43xFZ1Wacu9d6j
	Y92uXSMyU2jy2jwr5x68l7A/q4yn2gPGIpn6LblYq9KcYF4WBryjHP7t+YUbYwA=
X-Google-Smtp-Source: AGHT+IGJxs+MndzB8kHTjyEpj6aouUS78da3peyTrtzGICSeRUd4HL6p1v35A3Rs72U5LlqDxc9Jmw==
X-Received: by 2002:a17:907:3601:b0:a55:9195:362c with SMTP id a640c23a62f3a-a5a2d66a3ffmr1715437766b.49.1715953491463;
        Fri, 17 May 2024 06:44:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a534bfb05sm852590266b.36.2024.05.17.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 06:44:51 -0700 (PDT)
Date: Fri, 17 May 2024 15:44:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 07/30] printk: nbcon: Use driver
 synchronization while (un)registering
Message-ID: <ZkdfUYuM7KYEz_7K@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-8-john.ogness@linutronix.de>
 <87msp3i6b3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msp3i6b3.fsf@jogness.linutronix.de>

On Mon 2024-05-06 12:33:28, John Ogness wrote:
> On 2024-05-02, John Ogness <john.ogness@linutronix.de> wrote:
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index e6b91401895f..15d19d8461ed 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3537,6 +3538,19 @@ void register_console(struct console *newcon)
> >  		newcon->seq = init_seq;
> >  	}
> >  
> > +	/*
> > +	 * If another context is actively using the hardware of this new
> > +	 * console, it will not be aware of the nbcon synchronization. This
> > +	 * is a risk that two contexts could access the hardware
> > +	 * simultaneously if this new console is used for atomic printing
> > +	 * and the other context is still using the hardware.
> > +	 *
> > +	 * Use the driver synchronization to ensure that the hardware is not
> > +	 * in use while this new console transitions to being registered.
> > +	 */
> > +	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
> > +		newcon->device_lock(newcon, &flags);
> > +
> >  	/*
> >  	 * Put this console in the list - keep the
> >  	 * preferred driver at the head of the list.
> > @@ -3561,6 +3575,10 @@ void register_console(struct console *newcon)
> >  	 * register_console() completes.
> >  	 */
> >  
> > +	/* This new console is now registered. */
> > +	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
> > +		newcon->device_unlock(newcon, flags);
> > +
> 
> Rather than writing the conditions twice, I will add a local variable
> and check that instead.
> 
> bool use_device_lock = (newcon->flags & CON_NBCON) && newcon->write_atomic;
> 
> ...
> 
> if (use_device_lock)
> 	newcon->device_lock(newcon, &flags);
> 
> ...
> 
> if (use_device_lock)
> 	newcon->device_unlock(newcon, flags);
> 

Makes sense. With this change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

