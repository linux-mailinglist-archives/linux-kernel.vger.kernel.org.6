Return-Path: <linux-kernel+bounces-534014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029CA4617D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B678188DB90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767EE33EC;
	Wed, 26 Feb 2025 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wwt1P8JM"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4521E0BD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578336; cv=none; b=KEWqpeoNqMNJ+n8qVMG6D1orGD8tpDJOTHbDLFzpkiH6QRUJdNOhWFpcMf7AyD+o2QfPPRZV2hbN+HXsn5luYrIXp666xmY/Ct5dqQU1JV2vzc9l9UmYyGTA1N+La+lREFxg9EMqoKLck1FiqeTfRvxYZJtZjOcdaW91irugH08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578336; c=relaxed/simple;
	bh=KoKXByWBSIf2npww0uaQKf+dyiKZnSdD0qxQQbGGdP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHZwjg5N1noOqmqkcg6Xrlmwgu+tYAG4g6Xv2n+S87gEXc657LwiCzcqI7nVvSZAJWEMbk0T+emX/ugNxdX1eYFF/VcAKwY0uuJ3dZN/bKgJp2s1o0zHrkpi4sQTp1YRioU+8ZMVyMc6e50DJmxvx80HWcuvfcAiPt8xC4ywnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wwt1P8JM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f31f7732dso573902f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740578330; x=1741183130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmseASJhwtjUx66eupfQddMd/CgXSgseQQBlGoFAbbA=;
        b=Wwt1P8JMizpOaKDwxvswfug4uFEhk5bFLPGlyfcCiyQFpsiRVzOhtuiEV7Uv/uhJer
         dHpgwUheepHxxyhpia+jdawAg4MPeraytZw+W2w6uDLv5kPuoUU54zbgrcBVXwg6l111
         /OfEPJgtOavptilW68b5iqT3xr34f8smExn2mGcosxsia1uKWsfqPQ0WXDO+75EZVstQ
         CvrYVy46WPuA43TEoZ4thenNYL+4HjRk0CeQxDyhfUPMGJ3/kc1RsDKwFdbHp8qPVu99
         oM3cEc+bDIy4hiFEIY+k4G6I2FSbY65gJW1yDce3IBQG1YG+izSobXozGkUeUsF9ebvs
         5lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578330; x=1741183130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmseASJhwtjUx66eupfQddMd/CgXSgseQQBlGoFAbbA=;
        b=cv8JDOSGPanil2JcHTWB+aRimH1Tk9jYlrcPLvcyuvMAM/9AvGBXnxFzOVGdWvkYSc
         KosU+IkamRQtEUSs8AioF7AArQp4DGjdhZ0oK+hM5/D/1yi2QZt11MCRgsFb7QRd3re4
         LhZNm2ioukb/nPJhke7wtD15uei18zeYjtN29255kIASdMImsasn3kv2nVt1H7yv68v1
         6ACKQ95PgEWU8qJcTK0bP+StQDjiz2kA9H7PUIHc7iJOof3/Iy1GKGXC25sUTY9TzkqV
         kWmp58gE+nLSi8mvDsqAJhIk58vFUsM2+mB0JJVtv0Bi2cUMZvH6RVfipsinny0kee5p
         YtvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEYXpgHaAagcUTso6D6s3hIllUoRHnk6+G8IDurac0TptTp6lWb6u/wN/AqfutBEsEd86vvZRX+b62eP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlsLRkbwzQRgViEqBauzY1pwKeKhW5vIYD9QxLxx67LRDDe5yA
	7NwwvvRUz6521zwzs0dGlJ/IN9exiyMyICotRyqQDR1FyFckmjY+kM4YOD8C96g=
X-Gm-Gg: ASbGncsrAPAS/zlwElS7+IbjA6lHZ5DAeCjfcToAf/7NpAFiYk0tir96OEIip3H8AhI
	5G8GIc4dFKnFNg8+iZD5NEtVCH/Rht140m4V3qaAmJZsrgrMayn4TB3o9TBaahsDJGSd2aWH1SU
	H3oo5qgxrv70w95RFI7SZvIr6A4oy4b5mvhpkoUvmoGToDVmT9nPWagpq9Ns87uWisKWIMN9v6K
	xKUTV8k1KPNWeNd5S3PuolFBqTBLVQGSpVq0FLXn1e1Eds6t55wavcld5Cm3iVNS02WtLNCBqWA
	khGCesMGVDmJGLnK5Baav+nUJdmb
X-Google-Smtp-Source: AGHT+IH224GviuTJrh5AcJGfibuR1lqHBOWNfk1sSRAsPvkCiW1x3c4TCaZgR0852ytZTE9PRQBbQA==
X-Received: by 2002:a5d:6d82:0:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-38f6f3c507amr17324474f8f.1.1740578330309;
        Wed, 26 Feb 2025 05:58:50 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7108sm5802782f8f.69.2025.02.26.05.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:58:49 -0800 (PST)
Date: Wed, 26 Feb 2025 14:58:48 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Donghyeok Choe <d7271.choe@samsung.com>, linux-kernel@vger.kernel.org,
	takakura@valinux.co.jp, youngmin.nam@samsung.com,
	hajun.sung@samsung.com, seungh.jung@samsung.com,
	jh1012.choi@samsung.com
Subject: Re: printk: selective deactivation of feature ignoring non panic
 cpu's messages
Message-ID: <Z78eGNIuG_-CVOGl@pathway.suse.cz>
References: <CGME20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0@epcas2p3.samsung.com>
 <20250226031628.GB592457@tiffany>
 <84ikoxxrfy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ikoxxrfy.fsf@jogness.linutronix.de>

On Wed 2025-02-26 05:31:53, John Ogness wrote:
> Hi Donghyeok,
> 
> On 2025-02-26, Donghyeok Choe <d7271.choe@samsung.com> wrote:
> > I would like to print out the message of non panic cpu as it is.
> > Can I use early_param to selectively disable that feature?
> 
> I have no issues about allowing this type of feature for debugging
> purposes.

Yes. It makes sense. Another scenario might be when
panic_other_cpus_shutdown() is not able to stop some CPUs.
It might be useful to see messages from the problematic ones.

> I do not know if early_param is the best approach. I expect
> Petr will offer good insight here.

early_param() looks good to me. There are already similar early
parameters, for example, "ignore_loglevel".


> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index fb242739aec8..3f420e8bdb2c 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2368,6 +2368,17 @@ void printk_legacy_allow_panic_sync(void)
> >         }
> >  }
> >
> > +static bool __read_mostly keep_printk_all_cpu_in_panic;
> > +
> > +static int __init keep_printk_all_cpu_in_panic_setup(char *str)
> > +{
> > +       keep_printk_all_cpu_in_panic = true;
> > +       pr_info("printk: keep printk all cpu in panic.\n");
> > +
> > +       return 0;
> > +}
> > +early_param("keep_printk_all_cpu_in_panic", keep_printk_all_cpu_in_panic_setup);
> 
> Quite a long argument. I am horrible at naming. I expect Petr would have
> a good suggestion (if early_param is the way to go).

Heh. It seems to be hard to find a good name ;-)

Anyway, I would use "printk_" prefix to make it clear that
it is printk-related. The following comes to my mind:

  + printk_allow_non_panic_cpus
  + printk_keep_non_panic_cpus
  + printk_debug_non_panic_cpus

I prefer "printk_debug_non_panic_cpus", see below.


> >  asmlinkage int vprintk_emit(int facility, int level,
> >                             const struct dev_printk_info *dev_info,
> >                             const char *fmt, va_list args)
> > @@ -2379,13 +2390,15 @@ asmlinkage int vprintk_emit(int facility, int level,
> >         if (unlikely(suppress_printk))
> >                 return 0;
> >
> > -       /*
> > -        * The messages on the panic CPU are the most important. If
> > -        * non-panic CPUs are generating any messages, they will be
> > -        * silently dropped.
> > -        */
> > -       if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
> > -               return 0;
> > +       if (!keep_printk_all_cpu_in_panic) {
> > +               /*
> > +                * The messages on the panic CPU are the most important. If
> > +                * non-panic CPUs are generating any messages, they will be
> > +                * silently dropped.
> > +                */
> > +               if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
> > +                       return 0;
> > +       }
> 
> I would not nest it. Just something like:
> 
> 	/*
> 	 * The messages on the panic CPU are the most important. If
> 	 * non-panic CPUs are generating any messages, they may be
> 	 * silently dropped.
> 	 */
> 	if (!keep_printk_all_cpu_in_panic &&
> 	    !panic_triggering_all_cpu_backtrace &&
> 	    other_cpu_in_panic()) {
> 		return 0;
> 	}

I would prefer this form as well.

Thinking loudly:

I wonder if this is actually safe. I recall that we simplified the
design somewhere because we expected that non-panic CPUs will not
add messages. I am not sure that I found all locations. But
we might want to revise:


1st problem: _prb_read_valid() skips non-finalized records on non-panic CPUs.

   opinion: We should not do it in this case.


2nd problem: Is _prb_read_valid() actually safe when
	panic_triggering_all_cpu_backtrace is true?

   opinion: It should be safe because the backtraces from different CPUs
	are serialized via printk_cpu_sync_get_irqsave().


3rd problem: nbcon_get_default_prio() returns NBCON_PRIO_NORMAL on
	non-panic CPUs. As a result, printk_get_console_flush_type()
	would suggest flushing like when the system works as expected.

	But the legacy-loop will bail out after flushing one
	message on one console, see console_flush_all(). It is weird
	behavior.

	Another question is who would flush the messages when the panic()
	CPU does not reach the explicit flush.

   opinion: We should probably try to flush the messages on non-panic
	CPUs in this mode when safe. This is why I prefer the name
	"printk_debug_non_panic_cpus".

	We should update console_flush_all() to do not bail out when
	the new option is set.

	We should call nbcon_atomic_flush_pending() on non-panic CPUs
	when the new option is set. printk_get_console_flush_type()
	should behave like with NBCON_PRIO_EMERGENCY.

	Maybe, nbcon_get_default_prio() should actually return
	NBCON_PRIO_EMERGENCY on non-panic CPUs when this option is set.
	It allow the non-panic CPUs to take over the nbcon context
	from the potentially frozen kthread.


Best Regards,
Petr

