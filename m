Return-Path: <linux-kernel+bounces-444472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E24999F0763
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB08188BF54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F19A1ACDF0;
	Fri, 13 Dec 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkW54lDZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5318E377
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081193; cv=none; b=IQz+NnYT/ub+UKoT9404AHI1+O2ZO/m01NHC2wtK5LQF6nw3ZuyCLpq/xLvJYcAr8dPsAGhzw+ZtdV4PRsXudCVnl+kumPvj+ksVDwM/cDb3+k1kfM1q4TKzPi9kqg5HKihsuoO7K97T/1lYai1wNg2FnR/9gJeINKE6EjKxCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081193; c=relaxed/simple;
	bh=UKC21nN8FLpm7sOqWwqTDuzftQBScDYGSimzzKk01/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3w5e3qxG+3RcWxVd9OF0qZLzUXxkoCNTNVKEts5+nAdASmxdGXCtGUi7+8B1bmhmSPbg8nyOq0tnfVgc4JJL3T20LrHi/IVRazybXehKWzmOQx1g9oopsEPCeha9N8/Ge8GV9Q8EUoth1OINjDCLYgFY2mw2MiXZ1tYkce2yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkW54lDZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216395e151bso10096425ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734081191; x=1734685991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9odnWlNvbIAJxNwIQe2y8lDLwTJga+YaH3t7y8G83cM=;
        b=WkW54lDZhAdZnvpirsVFTyv8doIjyDRMLfZg308LN1VtWimdZNa3LF4XuEYlWTDriE
         y/d5pLOir+jPqbzwGffs/DmKVtlNNLztP2UCiCyuFYYsi7ZDtySvNDF5UiV97eciwOv5
         DKJIlSNyv66oxsQ6hbd/EDohqnBhqlXGsuF01EC8r+O87nXh+HYlWL1he6JSBciqx9MG
         6tyeBJkHDrwk3mpVQT3V/emEBPEaqm4YJEckl63hVWJUr4uWexGYSKmwfwajyadlesa8
         zzngvfpgbqrqESAnKccuoLeJUxm/iFVUhAcFa1DWg0C1wn4wiAKKw7ybxeYn+NK4nl+h
         Uf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734081191; x=1734685991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9odnWlNvbIAJxNwIQe2y8lDLwTJga+YaH3t7y8G83cM=;
        b=Zg8Y7FQWc0qeWdePSNF9bHQMY7Eb92KpKem/mOzME8oqFpdfHKUc+eG7bnB6NA4Zdb
         KF0AVTKKelQdMUCaxHdy68wMTnqZmws0uAigPSclGO5HJ2l6OoO5vtoqPWzTBa3vUsGh
         HomRgGlJxfbq2MZOuuUYxxqOhIymsOD2Opt9L41yADvxsZaIUto2Efwesy0vWHdfQ9sx
         dZGHxX2dA5v3a0fupUPAND8+pwS08vzzgBV2PT/FV2ZF+QDFZ91B7th8uQh9dXJezheN
         Ut7BDboXyAqcXSfT5PyEeDZTTsFedybueLLDl47z6rGobFQKE7FZMpwKWrJIcG+0aaoA
         9+bw==
X-Forwarded-Encrypted: i=1; AJvYcCXo0LoepIUXDgzpOV4ZNH9PWRMXZNItmlu6gwool69UKMcuW0Hk9JgcnowFNs2srEHPty2UMecXbaIIHUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8GF6+siujJw+xkpJ5EhfnGzOiDF1pxginqd+HYITNuEdGV6WJ
	uXNSS3U1k6XDLwFvc9/V//Fumco7z2h0RE2F67njdlJVOmr9SMYj
X-Gm-Gg: ASbGncuPc2MDCYgXdSwaHNFJD5fwdJ3AZgYhxErUnSel7SK1ySuxWhCOU6YmOPzyk9e
	aBt7efM0monmg4NE7z6fW40aavDZgXqN7rKCKtf9qaBOrUjbwhgt2zqT2u+lZWfqzzjWqI0SyW7
	PyK1k3fW15xhR7fk+DPq094FFs01maXz9USwtp9HaNAxDRBlH1MP4FJFg45TTHsLV5bKL9p0fZJ
	/w3mKYOlGtvIvhCMAAWJh43St/zdST0tWrdRB0hUpqVxg9xngjklGDJs/W5xLzayyo9F1Oh3Byh
	xwZ+SCA=
X-Google-Smtp-Source: AGHT+IFtEar1BU3xr1HATQkCx25u8mBGWmtsfz6eRpRGGvEh8YuIBVU9Mn1d1iJyHg69ffJV1tOlMg==
X-Received: by 2002:a17:902:f711:b0:215:b18d:ca with SMTP id d9443c01a7336-2178c85c532mr108043425ad.18.1734081191039;
        Fri, 13 Dec 2024 01:13:11 -0800 (PST)
Received: from MBC02GN1V4Q05P ([117.143.114.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21625b4f979sm109576545ad.172.2024.12.13.01.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 01:13:10 -0800 (PST)
Date: Fri, 13 Dec 2024 17:13:03 +0800
From: Richard Clark <richard.xnu.clark@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Question about interrupt prioriyt of ARM GICv3/4
Message-ID: <Z1v6n6c6GB2_pFiR@MBC02GN1V4Q05P>
References: <CAJNi4rMfhZOCT+7Ki14vUs+dZbv9cxCZ0s+jgn6=_om4NTgo_A@mail.gmail.com>
 <86cyi5tanz.wl-maz@kernel.org>
 <CAJNi4rPDVXS3Ft3nHLXvMzHmn9d10Nz4Pxeduoe+v5HaK=CEAg@mail.gmail.com>
 <86ldwlryzz.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86ldwlryzz.wl-maz@kernel.org>

Hi M,

On Thu, Dec 12, 2024 at 10:12:32AM +0000, Marc Zyngier wrote:
> On Thu, 12 Dec 2024 09:18:56 +0000,
> richard clark <richard.xnu.clark@gmail.com> wrote:
> > 
> > Hi M,
> 
> Hi r,
> 
> > 
> > On Fri, Dec 6, 2024 at 5:37 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Fri, 06 Dec 2024 08:33:11 +0000,
> > > richard clark <richard.xnu.clark@gmail.com> wrote:
> > > >
> > > > Hi,
> > > > Currently seems the GICv3/4 irqchip configures all the interrupts as
> > > > the same priority, I am thinking about to minimize the latency of the
> > > > interrupt for a particular device, e.g, the arm arch_timer in the RTL
> > > > system. The question is,
> > > > 1. Why don't we provide a /proc or /sys interface for the enduser to
> > > > set the priority of a specific interrupt(SPI/PPI)?
> > >
> > > I'm afraid this really has nothing to do with any particular interrupt
> > > architecture.
> > >
> > > Before thinking of exposing the interrupt priority to userspace, you
> > > should look at what this translates into for the kernel once you allow
> > > interrupts to be preempted by another one with a higher priority.
> > >
> > Interrupt priority doesn't necessarily mean the preemption, seems
> > you're talking about the interrupt preemption harm according to your
> > statement followed.Frankly I am just thinking higher priority will win
> > the lower ones in case massive external interrupts received in the GIC
> > level (you see I am still talking about GIC, not kernel)
> 
> As I stated at the end of my email, the GIC only gives guarantee that
> you will ack the highest priority interrupt in finite time. Not right
> when it is made pending. Yes, it has the concept of HPPI. But that
> from the PoV of the CPU interface, not that of the distributor. Factor
> in the Stream interface, and you realise that expecting to always ack
> the highest priority pending interrupt is akin to expecting no
> reordering of packets in a network.
> 

I am trying to figure out a meticulous way to verify if the priority really work
or not, all we're here is talk abou like the 'technically', we'd show the
statistic data collected. Except that the stress-ng to stress massive interrupts
to the cpu0, another way I can see is a kmod to remote cross cpu call targeting
the cpu0 from other cpus. From the current data collected, I do see some gain of
latency, still it's not finalized yet. Be patient baby :)

> > >
> > > This means that at every point where you would normally see a
> > > local_irq_save(), spinlock_irqsave() or equivalent, you would need to
> > > explicitly specify the priority that you allow for preemption. You
> > > should then make sure that any code that can be run during an
> > > interrupt is reentrant. You need to define which data structures can
> > > be manipulated at which priority level... The list goes on.
> > >
> > irqsave just masks the interrupt from the point of cpu, I don't think
> > it will mess things up if preemption really happens (no? then what the
> > side-effect is for the nested interrupt handling in the softirq part.
> > damage the semantic of the lock primitives?)
> > >
> > > If you want a small taste of the complexity, just look at what
> > > handling NMIs (or even pseudo-NMIs in the case of GICv3) means, and
> > > generalise it to not just two, but an arbitrary range of priorities.
> > >
> > > If you want the full blown experience, look at the BSDs and their use
> > > of spl*(). I don't think anyone has any plan to get there, and the RT
> > > patches have shown that there is little need for it.
> > >
> > As supplement，the fiq is suggested to be used as an alternative to the
> > higher priority in the RT area...
> 
> <PulpFiction>
> FIQ's dead, baby. FIQ's dead.
> </PulpFiction>
> 

As an advice too...

> > >
> > > > 2. Is there any way to verify the higher priority interrupt will have
> > > > more dominant to be selected to the CPU (IOW, the priority is really
> > > > working) in case of multiple different interrupts asserted to the GIC
> > > > at the same time(some debug registers of GIC like GICD_REEMPT_CNT :-)
> > > > to record higher priority wins)?
> > >
> > > The GIC architecture makes no promise that the interrupt you
> > > acknowledge is the highest priority pending interrupt, because this is
> > > by definition a very racy process.
> > >
> > > Also, even on busy systems, you will very rarely see two interrupts
> > > targeting the same CPU being made pending at the same time, so that
> > > the interrupt delivery system would have to arbitrate between the two.
> > > That's because interrupts are vanishingly rare in the grand scheme of
> > > things.
> > >
> > 1. I am trying to stress the external interrupts to the core#0 via the
> > stress-ng tool with one of interrupt being configured as higher
> > priority to see the benchmark data, it's time consuming as you can
> > image, still is in progress(BTW, I can't see any lockup similar hang
> > in the system with a higher priority configured)
> 
> If you don't have preemption, I don't think anything wrong will
> happen. But I don't expect any benefit either.
>

As a said before in this eamil, real statistic data is needed as evaluation,
WIP through now.

> 
> > 2. This raises a very interesting question and I am also very curious
> > about is, what is the purpose for the GIC to introduce the interrupt
> > priority features, a placeholder feature reserved for the future? Ah,
> > hardware prefer to provide more functionalities than its being
> > actually used by software, any other justification except that?
> 
> You realise that the HW is not exclusively designed for Linux, right?
> 
I realize, but it will be better if you can point is there any other OS
kernels make use of these interrupt priority of GIC but Linux, if no then
what the rational is for GIC to support these priority features...

	r. 
>
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

