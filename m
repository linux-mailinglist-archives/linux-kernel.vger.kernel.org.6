Return-Path: <linux-kernel+bounces-444498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2C9F07DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE0C1880531
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF81B0F36;
	Fri, 13 Dec 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgjM0ylb"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4C1AF0CE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082030; cv=none; b=Dnrpy0P3334V/vfYZqeiMua12sb6fE08klW0QB/i734T1JMqlNpRdlPTeslOEorhy1BJtrFB+J07NBbBSFjHKCX3JzrnzVMlQOj7uS0FshzGOHjKhvJGoLvVJPRyOqpwAXenNBe5eqkORXSVXm/1HjWZOpQ4Q/baiScoH3sIOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082030; c=relaxed/simple;
	bh=7wsHpbPrm3JuP3pkMUblDPT6fGtmNSvAU46M95067SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM2sFFwHUdvFgc6NTfIceiL72KKqoisW985Qqw695KYI4nVjgXulRifmChCsDX52MohdERrZjcnfi1CQeSdeTfjcE2Bdf3nOGnOC08uXbYnYlTM65WW67Wtgsh7q2LQnEiwesU2orB3GmjLa2APWZhhfSz8zfRzmYwAFgIaw8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgjM0ylb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so1344861b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734082028; x=1734686828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hTzQyXIHcaxEEVwjd+PpJ1XyNFyqZzECKyZ+9DQUQzo=;
        b=FgjM0ylb7SBd6ZKcHmFYFmm+EiciM5xxtRUjG5Aom5+fNAElOu1yhGQ3jc2+oOub6e
         zCc2fr+IL92vGGj2r4MgpWG/9+k6J+HyyqnXW68LFcSG2TUw1pNj8BOe5EY0ciKnSl5r
         l1mhuMTn77fzrvvtCgfSyXKTtVCgVMwGpD01QXt7fc/FfacrsMyzXkNfSNCsFqtfEnke
         Cqh99EckH6HgMeMzxMRMqsrDi8ayz20HXbQf6u3IatYnToAa8NBSNX1wat6STzw47Mz7
         s7IoB8/u9OkxskU39v/cmvLKmM6uKiKKp7ymX9ZuADstZdihtyF3YP++oTuddXPnuf9s
         7x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734082028; x=1734686828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTzQyXIHcaxEEVwjd+PpJ1XyNFyqZzECKyZ+9DQUQzo=;
        b=OMd6QrmC4WqdvCKG926+l8v8Zq4uOIq53Tw69LV5tG5U4NDZR51CxD3A5fkk3cfISa
         0map8AuArgqp+Fu/E90+vtvesLdfmNEnJzP6FAkvJ0b00MRaBc+4/yp7j8ociPkR1Th8
         wHkH18c4TlqJiJ1HGXmXzlPlXKrzSyZq5flTuT9TBg7O4LlLInKsPJ4zci0s5+7FYqbH
         5e6LB9F5OUr79zeK31vw7XsHFX/os6/hfNyXdWx07CmN8E6upSsZ6P1g5UeOzC2O/Bj0
         lXrRJK09xlQ3VQdtGx6XFNI7XxKbh/4qFmWYiTXNoQ5FY+KOUIz/jGTPj0nc44of9MWB
         N9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9qf6m2+2oQ9sdRttfSkqMTLW5prEyZ18kwjbn+hStE23EuWbxovqqtPp2jZBcgGhcGtF/KvmJi1TayAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyjX0jSKJ5hplOC0U6Xriz/RTjXKYF4wauHmt0Sy72GOtsS+4u
	VM2hTK7XgUAb8vjy8SLIxzW13mHLmTHtTO59b7t41wtHUgPZVXAL
X-Gm-Gg: ASbGnctGicosu2X1YovLRPJZko6sAxWVUYZAr7r5PQykJpH7C4DmSMapfU/cNBH5Pw2
	k1yr9qujU+X3v1vkfU1jgnv/npYB/26I2SYNtw3NwofOIFIbUsgvxgbDIfLAa3BjdoRAfuBjvp3
	hjtLU9d7oI/ERcqcXeFg339S5bgOxIqEP7bnEiFPNO+ICgwurmME3rAonJBGMiHL2rZ0FUJvEIT
	ckJL8488LpQA5X1wlKGhY3IfV3NXFPZ7mQ0PkKxSdlRkKEQ2QciDFYdb2N+6qI5MAydhkGyBC/R
	TBmNiZg=
X-Google-Smtp-Source: AGHT+IEotA2MyBaR6GaoJwJuWdf/DB/mrRTTIJotvOvCF3vwProtl1t9f2/mF88td+J4waI8v5QJVg==
X-Received: by 2002:a05:6a00:430f:b0:728:8c17:127d with SMTP id d2e1a72fcca58-7290c12ef7amr3243500b3a.8.1734082028273;
        Fri, 13 Dec 2024 01:27:08 -0800 (PST)
Received: from MBC02GN1V4Q05P ([117.143.114.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725c7cba42fsm11948546b3a.123.2024.12.13.01.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 01:27:07 -0800 (PST)
Date: Fri, 13 Dec 2024 17:27:02 +0800
From: Richard Clark <richard.xnu.clark@gmail.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, will@kernel.org,
	linux@armlinux.org.uk, mark.rutland@arm.com,
	torvalds@linux-foundation.org
Subject: Re: Question about interrupt prioriyt of ARM GICv3/4
Message-ID: <Z1v9GKkghPjpnvp6@MBC02GN1V4Q05P>
References: <CAJNi4rMfhZOCT+7Ki14vUs+dZbv9cxCZ0s+jgn6=_om4NTgo_A@mail.gmail.com>
 <86cyi5tanz.wl-maz@kernel.org>
 <CAJNi4rPDVXS3Ft3nHLXvMzHmn9d10Nz4Pxeduoe+v5HaK=CEAg@mail.gmail.com>
 <86ldwlryzz.wl-maz@kernel.org>
 <871pydxde2.fsf@bloch.sibelius.xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pydxde2.fsf@bloch.sibelius.xs4all.nl>

Hi Mark,

On Thu, Dec 12, 2024 at 02:02:45PM +0100, Mark Kettenis wrote:
> > Date: Thu, 12 Dec 2024 10:12:32 +0000
> > From: Marc Zyngier <maz@kernel.org>
> 
> Hi Marc, Richard,
> 
> > On Thu, 12 Dec 2024 09:18:56 +0000,
> > richard clark <richard.xnu.clark@gmail.com> wrote:
> > > 
> > > Hi M,
> > 
> > Hi r,
> > 
> > > 
> > > On Fri, Dec 6, 2024 at 5:37 PM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On Fri, 06 Dec 2024 08:33:11 +0000,
> > > > richard clark <richard.xnu.clark@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > > Currently seems the GICv3/4 irqchip configures all the interrupts as
> > > > > the same priority, I am thinking about to minimize the latency of the
> > > > > interrupt for a particular device, e.g, the arm arch_timer in the RTL
> > > > > system. The question is,
> > > > > 1. Why don't we provide a /proc or /sys interface for the enduser to
> > > > > set the priority of a specific interrupt(SPI/PPI)?
> > > >
> > > > I'm afraid this really has nothing to do with any particular interrupt
> > > > architecture.
> > > >
> > > > Before thinking of exposing the interrupt priority to userspace, you
> > > > should look at what this translates into for the kernel once you allow
> > > > interrupts to be preempted by another one with a higher priority.
> > > >
> > > Interrupt priority doesn't necessarily mean the preemption, seems
> > > you're talking about the interrupt preemption harm according to your
> > > statement followed.Frankly I am just thinking higher priority will win
> > > the lower ones in case massive external interrupts received in the GIC
> > > level (you see I am still talking about GIC, not kernel)
> > 
> > As I stated at the end of my email, the GIC only gives guarantee that
> > you will ack the highest priority interrupt in finite time. Not right
> > when it is made pending. Yes, it has the concept of HPPI. But that
> > from the PoV of the CPU interface, not that of the distributor. Factor
> > in the Stream interface, and you realise that expecting to always ack
> > the highest priority pending interrupt is akin to expecting no
> > reordering of packets in a network.
> > 
> > > >
> > > > This means that at every point where you would normally see a
> > > > local_irq_save(), spinlock_irqsave() or equivalent, you would need to
> > > > explicitly specify the priority that you allow for preemption. You
> > > > should then make sure that any code that can be run during an
> > > > interrupt is reentrant. You need to define which data structures can
> > > > be manipulated at which priority level... The list goes on.
> > > >
> > > irqsave just masks the interrupt from the point of cpu, I don't think
> > > it will mess things up if preemption really happens (no? then what the
> > > side-effect is for the nested interrupt handling in the softirq part.
> > > damage the semantic of the lock primitives?)
> > > >
> > > > If you want a small taste of the complexity, just look at what
> > > > handling NMIs (or even pseudo-NMIs in the case of GICv3) means, and
> > > > generalise it to not just two, but an arbitrary range of priorities.
> > > >
> > > > If you want the full blown experience, look at the BSDs and their use
> > > > of spl*(). I don't think anyone has any plan to get there, and the RT
> > > > patches have shown that there is little need for it.
> > > >
> > > As supplement，the fiq is suggested to be used as an alternative to the
> > > higher priority in the RT area...
> > 
> > <PulpFiction>
> > FIQ's dead, baby. FIQ's dead.
> > </PulpFiction>
> 
> Hah, tell that to Apple! ;).
>
Suppose you're kiding, seems neither Apple employee nor working on its HW :)
> 
> > > > > 2. Is there any way to verify the higher priority interrupt will have
> > > > > more dominant to be selected to the CPU (IOW, the priority is really
> > > > > working) in case of multiple different interrupts asserted to the GIC
> > > > > at the same time(some debug registers of GIC like GICD_REEMPT_CNT :-)
> > > > > to record higher priority wins)?
> > > >
> > > > The GIC architecture makes no promise that the interrupt you
> > > > acknowledge is the highest priority pending interrupt, because this is
> > > > by definition a very racy process.
> > > >
> > > > Also, even on busy systems, you will very rarely see two interrupts
> > > > targeting the same CPU being made pending at the same time, so that
> > > > the interrupt delivery system would have to arbitrate between the two.
> > > > That's because interrupts are vanishingly rare in the grand scheme of
> > > > things.
> > > >
> > > 1. I am trying to stress the external interrupts to the core#0 via the
> > > stress-ng tool with one of interrupt being configured as higher
> > > priority to see the benchmark data, it's time consuming as you can
> > > image, still is in progress(BTW, I can't see any lockup similar hang
> > > in the system with a higher priority configured)
> > 
> > If you don't have preemption, I don't think anything wrong will
> > happen. But I don't expect any benefit either.
> 
> Based on my experience with OpenBSD, I'm not even sure there is much
> benefit even if you have preemtion.
>
is OpenBSD has this priority feature supported? or do you have some related perf
data on BSP...
> 
> And regarding anything wrong happening: there is an interesting bug in
> the RK3399 GIC integration where it gets the priorities wrong:
> 
> https://github.com/openbsd/src/blob/feb3ea439d8f49b3c0e33f54c34631a611b98e21/sys/arch/arm64/dev/agintc.c#L395
> 
> (that comment is my interpretation of what's happening; I might be
> misinterpreting what's really going on)
> 
> As far as I can tell the Linux code doesn't handle that quirk.
> Probably it doesn't matter because Linux only uses the priority
> mechanisms to implement pseudo-NMI functionality and/or doesn't do
> preemption of interrupts.
>
seems the BSP has the priority support but encounter the bug/quirk, correct me if I am wrong. Frankly I have no
time to read the code of your link

	r.

> 
> > > 2. This raises a very interesting question and I am also very curious
> > > about is, what is the purpose for the GIC to introduce the interrupt
> > > priority features, a placeholder feature reserved for the future? Ah,
> > > hardware prefer to provide more functionalities than its being
> > > actually used by software, any other justification except that?
> > 
> > You realise that the HW is not exclusively designed for Linux, right?
> > 
> > 	M.
> > 
> > -- 
> > Without deviation from the norm, progress is not possible.
> > 
> > 

