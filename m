Return-Path: <linux-kernel+bounces-330664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A824497A272
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AF428B05A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1461E1547F5;
	Mon, 16 Sep 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+1cK7Ow"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5719BBC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490359; cv=none; b=NZbZiF/NDXgA3oFE4QSJoS4QtFGS7METFfssThngCeyemC7goBU/ZVGAEloD+Mus2zAtKD9DFFkQzvddI4njo3z7QYy+oA6x41I6Vyc/YhEN9bGmTw6mFpfF2/UYZPe5tjkCAV4slDfd5eFikvOZFWG9ZxAM26iR6Srj+PjcnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490359; c=relaxed/simple;
	bh=RZkKybt20BrFAMvkBvu8gcqvGmwdfqgMDLPcU+OPREs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nos49HPZCoj5j56lF+26g/qrogyIhTIFz91S05Npel9FacM2dpRLJPryD8sk2v9Bc6+44ah8A7ae1UBcM6PaNHpYv9SvADutqfwCxipAO1fliq5j+LgesxKjTtlAPC3c4wYhxvB9BbEfZdE04vEz3XdoRhmQALp4Tls24d0QeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+1cK7Ow; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so37628185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726490356; x=1727095156; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dxWchoWn22rdAe/2dB1cdrVrt6OnsXWFBRvbrcWerg8=;
        b=w+1cK7Owrj/RPB1TTGRg/Zck2jw881n2XTgP20D66xFtjUV9hw1OKkaYWpT0AABziv
         HLOGEfkqjhBox7e1egQbR/OghAmfN6hAoeNWKTZPrW9pHaOXTBsrARJKKWxrzGl1G9kF
         EeR02GWAKrJMUlsFpzubZQGlPmce98Z13hFbjjzs120VwkSmCyzesuxOMHE5+DJ0rtwo
         etGtnYu1tCe5wiH6M1jN8DOGtuM/0baCSGDguDe9mqCjLlggdk6AOng4ojHMTp+4yk8I
         ZEVxrL0X7t+YqtbiWLOcU21mR4F6zC+Mg5vHN/qgE/JjRcFbGI9Fug09XIRf3zLd1ZbA
         HNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726490356; x=1727095156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxWchoWn22rdAe/2dB1cdrVrt6OnsXWFBRvbrcWerg8=;
        b=djZWkgkstqj9QDitwmLFE/lYQXeYHaPc+zXIXX6Vu/G5ZcQnQHztAMW6ZtD/ZIxgBC
         B4bK4maf8hbNFBDB5qVTthHxuqkiym8pbZol7GFSUPm6ywsXcDky9b/b1VSI5IzTmwz/
         kvaPN+QhzbBCiU+nB2Dw720REJXcc7JWcm1TAF4waJfyMjmBhxU+KODh5ogT6DvnCYFx
         Z+ANaNlWRUA9FgXkheGq5WOISzqzgtkq+na5L7j9fk8ylmhN9eM5MFVVCm28AXUnWs74
         C7E9Su3yt6itzebHWNLwZMSa/ltWgBkfbr0e4sdfHMJKYYaesxo1wLtJXQfYjRrjFh9L
         Q+zA==
X-Forwarded-Encrypted: i=1; AJvYcCXK2GxE8nxCX+k4o5I0xqIGZkff24r8WqtaNLxvNh1Fi64waQVjNMa2nVCR7PohTDrHsIDokFF1YRBG5RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbE20kNaqsiQwORfWkrYApqyDr6vxBs0Ql7XvN+aOMhPiNrB25
	cfX19sFao1NHx2QwN4cXWWp4X/JBHx2FsGF+9PyWtRJIQZOPl+YvE0QVKYxHKA==
X-Google-Smtp-Source: AGHT+IFQMybW3PX0qI+sz8J2Ss9CRF+75CADSBG6Hly78QAjV2aOvJ2n6gpbAy2/S/tFK1yOGYBOvw==
X-Received: by 2002:a05:600c:1c91:b0:42c:bd5a:945b with SMTP id 5b1f17b1804b1-42cdb53f8aemr110146165e9.21.1726490355612;
        Mon, 16 Sep 2024 05:39:15 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1947e2sm113668245e9.44.2024.09.16.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:39:15 -0700 (PDT)
Date: Mon, 16 Sep 2024 13:39:11 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: John Stultz <jstultz@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, will@kernel.org,
	qperret@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Subject: Re: [PATCH 09/13] KVM: arm64: Add clock for hyp tracefs
Message-ID: <Zugm77Z47-kal5rf@google.com>
References: <20240911093029.3279154-1-vdonnefort@google.com>
 <20240911093029.3279154-10-vdonnefort@google.com>
 <CANDhNCqvwn7W8JgdzY=2PrEk0unm3E0Kso7h2CCZBPO+hzLaOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqvwn7W8JgdzY=2PrEk0unm3E0Kso7h2CCZBPO+hzLaOw@mail.gmail.com>

On Fri, Sep 13, 2024 at 04:21:05PM -0700, 'John Stultz' via kernel-team wrote:
> On Wed, Sep 11, 2024 at 2:31 AM Vincent Donnefort <vdonnefort@google.com> wrote:
> >
> > Configure the hypervisor tracing clock before starting tracing. For
> > tracing purpose, the boot clock is interesting as it doesn't stop on
> > suspend. However, it is corrected on a regular basis, which implies we
> > need to re-evaluate it every once in a while.
> >
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Christopher S. Hall <christopher.s.hall@intel.com>
> > Cc: Richard Cochran <richardcochran@gmail.com>
> > Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> >
> ...
> > +static void __hyp_clock_work(struct work_struct *work)
> > +{
> > +       struct delayed_work *dwork = to_delayed_work(work);
> > +       struct hyp_trace_buffer *hyp_buffer;
> > +       struct hyp_trace_clock *hyp_clock;
> > +       struct system_time_snapshot snap;
> > +       u64 rate, delta_cycles;
> > +       u64 boot, delta_boot;
> > +       u64 err = 0;
> > +
> > +       hyp_clock = container_of(dwork, struct hyp_trace_clock, work);
> > +       hyp_buffer = container_of(hyp_clock, struct hyp_trace_buffer, clock);
> > +
> > +       ktime_get_snapshot(&snap);
> > +       boot = ktime_to_ns(snap.boot);
> > +
> > +       delta_boot = boot - hyp_clock->boot;
> > +       delta_cycles = snap.cycles - hyp_clock->cycles;
> > +
> > +       /* Compare hyp clock with the kernel boot clock */
> > +       if (hyp_clock->mult) {
> > +               u64 cur = delta_cycles;
> > +
> > +               cur *= hyp_clock->mult;
> 
> Mult overflow protection (I see you already have a max_delta value) is
> probably needed here.

That should never happen really with the max_delta. But I could add a WARN_ON
and fallback to a 128-bits compute instead here too? 
> 
> > +               cur >>= hyp_clock->shift;
> > +               cur += hyp_clock->boot;
> > +
> > +               err = abs_diff(cur, boot);
> > +
> > +               /* No deviation, only update epoch if necessary */
> > +               if (!err) {
> > +                       if (delta_cycles >= hyp_clock->max_delta)
> > +                               goto update_hyp;
> > +
> > +                       goto resched;
> > +               }
> > +
> > +               /* Warn if the error is above tracing precision (1us) */
> > +               if (hyp_buffer->tracing_on && err > NSEC_PER_USEC)
> > +                       pr_warn_ratelimited("hyp trace clock off by %lluus\n",
> > +                                           err / NSEC_PER_USEC);
> 
> I'm curious in practice, does this come up often? If so, does it
> converge down nicely? Have you done much disruption testing using
> adjtimex?

So far, I haven't seen any error above ~100 ns on the machine I have tested
with, but that's a good point, I'll check how it looks when the boot clock is
less stable.

> 
> > +       }
> > +
> > +       if (delta_boot > U32_MAX) {
> > +               do_div(delta_boot, NSEC_PER_SEC);
> > +               rate = delta_cycles;
> > +       } else {
> > +               rate = delta_cycles * NSEC_PER_SEC;
> > +       }
> > +
> > +       do_div(rate, delta_boot);
> > +
> > +       clocks_calc_mult_shift(&hyp_clock->mult, &hyp_clock->shift,
> > +                              rate, NSEC_PER_SEC, CLOCK_MAX_CONVERSION_S);
> > +
> > +update_hyp:
> > +       hyp_clock->max_delta = (U64_MAX / hyp_clock->mult) >> 1;
> > +       hyp_clock->cycles = snap.cycles;
> > +       hyp_clock->boot = boot;
> > +       kvm_call_hyp_nvhe(__pkvm_update_clock_tracing, hyp_clock->mult,
> > +                         hyp_clock->shift, hyp_clock->boot, hyp_clock->cycles);
> > +       complete(&hyp_clock->ready);
> 
> I'm very forgetful, so maybe it's unnecessary, but for future-you or
> just other's like me, it might be worth adding some extra comments to
> clarify the assumptions in these calculations.

Ack.

> 
> 
> thanks
> -john

Thanks for your time!

-- 
Vincent

