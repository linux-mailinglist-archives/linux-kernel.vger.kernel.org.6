Return-Path: <linux-kernel+bounces-260966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD29D93B106
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7A41C2270A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8B1586DB;
	Wed, 24 Jul 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UHlSoU2L"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF01E488
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825158; cv=none; b=VNYivtKchdcLoxFr5CHH0Q2YY9iQCf8utYmhZYRUVAFlbf5XBmxqkdxtRobRQ1cHl66cP3pAIfG6KeDv1Afg6OodyDh5pu0qh7RLhXUcGsPH/j2S6XHh62W6mlxX8Ja8DdisW3xvoGckrMoZurYc0RhPj09Hn9F+suNhVvCJiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825158; c=relaxed/simple;
	bh=2iuxZPN//4wuOUYWtzsXQzlcyfAii5VD1zPSKU9+998=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kln9u+yjSyCuZfQ9Xb4eiL2bsPYJ2gV5qi1BH+ooW8dRR3dY8qd6QFsC5y6YedU9fDt8TNkdpy7emrqp4Nk9E1V5w8HqC+VNoacm2rnvjIvEuP3cobSh3dElJ+Sspz894OGn0r0z092nA9EbR4cb3Ash9UGBIc2ij0AKFtaS0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UHlSoU2L; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so181399766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721825151; x=1722429951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgR591S6edERZx1kqoj89+jf2qFd6rUuEqLgUhSQlaU=;
        b=UHlSoU2LMu6mFNrpcouayleXpRKQdLS46FY2NVMzwg+zfqCrSIrtV0FUuRXdxJqE6v
         iFb/MpiwINmqtBFsEWPhN0iaSWYCbt2fLn59Ots1/kSj8nHma768RAXly6dT/WwSIfzE
         bSd9eNLns3+Dx07lv7FskFXrMZ85UTYC20TRjSbQR03a9zJx/OZ1fclrjKXjwUi0Pzs8
         SkQZ9xpvqp/7uCVJtU/j/Dkd0qXKJtdmAlfbflM2HYhOuKFHA0UvIXL549+eUd+z7AXS
         jggH5GWguWo90Tu05kzR0SdZFH0/sIuvDM2NmK8HqjnRvgzYNZ/R35CotQavacIiMpBv
         46NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721825151; x=1722429951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgR591S6edERZx1kqoj89+jf2qFd6rUuEqLgUhSQlaU=;
        b=c9bOTD2P4P0ei8cbZ1RIqkDqIq8GUD8DeJqp0ej8v9Kj/BH5BwebTtnCloKDpUJ2N5
         owH9wMXvRS+Z46MkeXU0NsdKue/IwXOVZG0NucKcA8yoIat5Ph+aUkTd3ZxOL4VzVfPU
         gAadk3RkdRSqqcgLtlnFwjcCImw11S7ruCnA9qUMW4rjBOP/N34nDZMNh+xp0i8UbYMN
         CDSrm8QgdYV4L6CNpunY6Fz2XkR+yL4s2AeJJ0vGYNLSOleBNZgJ2Ue0vROBob/vegbe
         Wl/rSta7IDwT4EOwGIi/72sZ5y4Ews1PCoLsWzJ7oKUZySRvKWt2pxTwOdpJowLTgE20
         zV9g==
X-Forwarded-Encrypted: i=1; AJvYcCXHEpvNic5pq8aWWc98IDtvWesipa8/3Y92SL6rDM1mAtMU7Ac9Fiv4NAjKxogd4HiA8YV0N0HVmvnt6Vj291CrsLXqX02Sk3zURqd+
X-Gm-Message-State: AOJu0YyklPR7wM2ufx5ZXj4PjcrvSBIPwj6Ovad3ovn6ykaYXT37Zxy/
	HSXGYIsfcR/RXRhnd0GOp6j8MWWV7wAgVZaBEdWiJcAJ/IPD7NFrt/OkeR8zO54POAdz3r0s1bg
	q
X-Google-Smtp-Source: AGHT+IEwaGqxEvlgUfLSQXk1nGKm+K/r9oK7Zet6DCycRvB5KZ5thR+7GKlxhLtu1UiyA2uAkNW0Og==
X-Received: by 2002:a17:907:7e81:b0:a7a:97ca:3059 with SMTP id a640c23a62f3a-a7ab0ee96f4mr156281266b.34.1721825151373;
        Wed, 24 Jul 2024 05:45:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aa08b6f18sm152328366b.46.2024.07.24.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:45:51 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:45:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
Message-ID: <ZqD3fb8mQqWwePEU@pathway.suse.cz>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
 <87plrcqyii.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plrcqyii.fsf@jogness.linutronix.de>

On Wed 2024-07-17 09:22:21, John Ogness wrote:
> On 2024-07-15, Rik van Riel <riel@surriel.com> wrote:
> > Both nmi_backtrace and dump_stack_lvl call printk_cpu_sync_get_irqsave.
> >
> > However, dump_stack_lvl will call into the printk code, while holding
> > the printk_cpu_sync_get lock, and then take the console lock.
> >
> > Another CPU may end up getting an NMI stack trace printed, after
> > being stuck printing something to serial console for too long,
> > with the console lock held.
> >
> > This results in the following lock order:
> > CPU A: printk_cpu_sync_get lock -> console_lock
> > CPU B: console_lock -> (nmi) printk_cpu_sync_get lock
> >
> > This will cause the system to hang with an ABBA deadlock
> 
> The console lock is acquired via trylock, so that will not yield
> deadlock here. However, if CPU B was printing, then CPU A will spin on
> @console_waiter (in console_trylock_spinning()). _That_ is a deadlock.
>
> The purpose of printk_cpu_sync_get_irqsave() is to avoid having the
> different backtraces being interleaved in the _ringbuffer_. It really
> isn't necessary that they are printed in that context. And indeed, there
> is no guarantee that they will be printed in that context anyway.

Well, backtraces are printed when unexpected things happen. It is
usually an emergency situation and we should do our best to
flush consoles ASAP.

> Perhaps a simple solution would be for printk_cpu_sync_get_irqsave() to
> call printk_deferred_enter/_exit. Something like the below patch.
> 
> John Ogness
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 65c5184470f1..1a6f5aac28bf 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -315,8 +315,10 @@ extern void __printk_cpu_sync_put(void);
>  #define printk_cpu_sync_get_irqsave(flags)		\
>  	for (;;) {					\
>  		local_irq_save(flags);			\
> +		printk_deferred_enter();		\
>  		if (__printk_cpu_sync_try_get())	\
>  			break;				\
> +		printk_deferred_exit();			\
>  		local_irq_restore(flags);		\
>  		__printk_cpu_sync_wait();		\
>  	}
> @@ -329,6 +331,7 @@ extern void __printk_cpu_sync_put(void);
>  #define printk_cpu_sync_put_irqrestore(flags)	\
>  	do {					\
>  		__printk_cpu_sync_put();	\
> +		printk_deferred_exit();		\
>  		local_irq_restore(flags);	\
>  	} while (0)
>  

OK, there is the basic rule: "Never take a lock in NMI when the lock might
be taken in another context". printk_cpu_sync_get() violates the rule.
But it is safe as long as the lock is re-entrant and tail.

The above patch fixes a situation where printk_cpu_sync_get() was not
a tail lock. So it looks like a reasonable fix if we want to keep it simple.

Well, I still prefer the alternative solution at
https://lore.kernel.org/r/93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com
which does not deffer the console output in normal/IRQ context. There
are doubts whether it is safe. I think that it is. Let me to reply there.

Best Regards,
Petr

