Return-Path: <linux-kernel+bounces-186851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E57AC8CC9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139371C21A63
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E571494AE;
	Wed, 22 May 2024 23:52:05 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB61509B3
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421925; cv=none; b=TLW4iXQy30nvo5fljDGcZOQZjKhuMydYB6gYC5dPs/wgCIzxGmd0mn7olLdB7kg9NVLGE8oqFTYl1CLx6jPG+TZaLQR3apaAyDt3DASvboiWBYl1DWIt8Q2wJ22wFdTkhxddeLu1uE244Klw4lRTOhEfgbxKTajTV+bnMR5xooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421925; c=relaxed/simple;
	bh=Pmnm7rhzxz2k9acIiTWsEWfHDNkUBt1qYi5Zk39lXB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fqo4iW6Js5cBT4F+X6MGV+pJB4c0XiRUcSFgtju5eLlhTP/gre2nfKFX0CAs2tPYYL5rQynzO+RTGehakazqbOPqO6Bqs1QCl4ZYjV6aUZoZG2fLfBRSGZXLy7FhaHvdGIT/wlypwZ+BFQoYZ+MHWp4JvW1OgwkSGFXSbM4NjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f335e8d493so2469395ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716421923; x=1717026723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgJe/VU2CHA4O5aH9yebofep1FFi9VwegOd03XFkMT0=;
        b=SRXqsvBtmKSI3GYUZOg30ucbeRthCGYeNq1lpPj/RAiesP4eLli26zklDhSVyGJTOJ
         5Qz38ClINofMdxNuODa97tiNrtBvt+ciGUu3WwXfIJJBWJG7oG0MDfciuXGSSMQ43alM
         vNHhhSU9Co6jZeZpnneWd14jbEeQCwqxjDhrTqNfFEXeO7ntd5euGIZisJsk6kVah/JI
         qibnQEPyUyUwpUPOOYGrNLG4DaBalC5qHUMA+ldioM01ObQphee8PW3DD3zuWsbtqCQU
         6Nt+JmlhF6A7ARSsM/rk9olTlNHa0+YWLp9FzcZMXz9ZqtJFJ6+YabLrhzYkqeZsBHZg
         uOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcR/QQ6Kbez5X8xC4Piiey6JWhcSxFfkxPGzTZRNLfisyLAz2vObJrUkkBEmPeNaDl1l7x9QI+vVSVfg0P+flVy1sE4pHJhMeaVKsg
X-Gm-Message-State: AOJu0Ywo8X6B+/FiEsQ0h2dvFQrrdsBMmaZgpJBWEMWrQvW+DN/uVeuW
	7EdDXL2c6wxSuu4aY1QyChETH8SLRnMr4q2pShcfLEQNguxB9EDg
X-Google-Smtp-Source: AGHT+IFx9sqketrAstF369fJMuliVnj7CDzB4Ud/h+zw6WNkjxLXPUMX9giQK7mMH1W/C8fVySpfvg==
X-Received: by 2002:a17:902:ce8f:b0:1f3:33b:ff18 with SMTP id d9443c01a7336-1f31c964f6bmr39555795ad.11.1716421923052;
        Wed, 22 May 2024 16:52:03 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d97e9sm245050305ad.17.2024.05.22.16.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:52:02 -0700 (PDT)
Date: Wed, 22 May 2024 16:52:00 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tj@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	vbabka@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] percpu_counter: add a cmpxchg-based _add_batch variant
Message-ID: <Zk6FIJTUEiNORrzl@snowbird>
References: <20240521233100.358002-1-mjguzik@gmail.com>
 <Zk1HsDYKwxpzeBjq@snowbird>
 <CAGudoHGpiJwuNX5MEj_RGdc+vVo_3u3hSv9wWSRm6ZrmAi65NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGpiJwuNX5MEj_RGdc+vVo_3u3hSv9wWSRm6ZrmAi65NA@mail.gmail.com>

On Wed, May 22, 2024 at 06:59:02AM +0200, Mateusz Guzik wrote:
> On Wed, May 22, 2024 at 3:17 AM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > Hi Mateusz,
> >
> > On Wed, May 22, 2024 at 01:31:00AM +0200, Mateusz Guzik wrote:
> > > Interrupt disable/enable trips are quite expensive on x86-64 compared to
> > > a mere cmpxchg (note: no lock prefix!) and percpu counters are used
> > > quite often.
> > >
> > > With this change I get a bump of 1% ops/s for negative path lookups,
> > > plugged into will-it-scale:
> > >
> > > void testcase(unsigned long long *iterations, unsigned long nr)
> > > {
> > >         while (1) {
> > >                 int fd = open("/tmp/nonexistent", O_RDONLY);
> > >                 assert(fd == -1);
> > >
> > >                 (*iterations)++;
> > >         }
> > > }
> > >
> > > The win would be higher if it was not for other slowdowns, but one has
> > > to start somewhere.
> >
> > This is cool!
> >
> > >
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >
> > > v3:
> > > - add a missing word to the new comment
> > >
> > > v2:
> > > - dodge preemption
> > > - use this_cpu_try_cmpxchg
> > > - keep the old variant depending on CONFIG_HAVE_CMPXCHG_LOCAL
> > >
> > >  lib/percpu_counter.c | 44 +++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 39 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> > > index 44dd133594d4..c3140276bb36 100644
> > > --- a/lib/percpu_counter.c
> > > +++ b/lib/percpu_counter.c
> > > @@ -73,17 +73,50 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
> > >  EXPORT_SYMBOL(percpu_counter_set);
> > >
> > >  /*
> > > - * local_irq_save() is needed to make the function irq safe:
> > > - * - The slow path would be ok as protected by an irq-safe spinlock.
> > > - * - this_cpu_add would be ok as it is irq-safe by definition.
> > > - * But:
> > > - * The decision slow path/fast path and the actual update must be atomic, too.
> > > + * Add to a counter while respecting batch size.
> > > + *
> > > + * There are 2 implementations, both dealing with the following problem:
> > > + *
> > > + * The decision slow path/fast path and the actual update must be atomic.
> > >   * Otherwise a call in process context could check the current values and
> > >   * decide that the fast path can be used. If now an interrupt occurs before
> > >   * the this_cpu_add(), and the interrupt updates this_cpu(*fbc->counters),
> > >   * then the this_cpu_add() that is executed after the interrupt has completed
> > >   * can produce values larger than "batch" or even overflows.
> > >   */
> > > +#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
> > > +/*
> > > + * Safety against interrupts is achieved in 2 ways:
> > > + * 1. the fast path uses local cmpxchg (note: no lock prefix)
> > > + * 2. the slow path operates with interrupts disabled
> > > + */
> > > +void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
> > > +{
> > > +     s64 count;
> > > +     unsigned long flags;
> > > +
> > > +     count = this_cpu_read(*fbc->counters);
> >
> > Should this_cpu_read() be inside the do {} while in case the extreme
> > case that we get preempted after the read and before the cmpxchg AND
> > count + amount < batch on both the previous and next cpu?
> >
> 
> this_cpu_try_cmpxchg updates the local value on failure (hence &), so
> from semantic pov this is equivalent to having this_cpu_read in the
> loop. I'm using it the same way as mod_zone_state.
> 

Ah I didn't catch that last night. Thanks. I've applied this to
percpu#for-6.11.

Thanks,
Dennis

> > > +     do {
> > > +             if (unlikely(abs(count + amount)) >= batch) {
> > > +                     raw_spin_lock_irqsave(&fbc->lock, flags);
> > > +                     /*
> > > +                      * Note: by now we might have migrated to another CPU
> > > +                      * or the value might have changed.
> > > +                      */
> > > +                     count = __this_cpu_read(*fbc->counters);
> > > +                     fbc->count += count + amount;
> > > +                     __this_cpu_sub(*fbc->counters, count);
> > > +                     raw_spin_unlock_irqrestore(&fbc->lock, flags);
> > > +                     return;
> > > +             }
> > > +     } while (!this_cpu_try_cmpxchg(*fbc->counters, &count, count + amount));
> > > +}
> > > +#else
> > > +/*
> > > + * local_irq_save() is used to make the function irq safe:
> > > + * - The slow path would be ok as protected by an irq-safe spinlock.
> > > + * - this_cpu_add would be ok as it is irq-safe by definition.
> > > + */
> > >  void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
> > >  {
> > >       s64 count;
> > > @@ -101,6 +134,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
> > >       }
> > >       local_irq_restore(flags);
> > >  }
> > > +#endif
> > >  EXPORT_SYMBOL(percpu_counter_add_batch);
> > >
> > >  /*
> > > --
> > > 2.39.2
> > >
> >
> > Thanks,
> > Dennis
> 
> 
> 
> -- 
> Mateusz Guzik <mjguzik gmail.com>

