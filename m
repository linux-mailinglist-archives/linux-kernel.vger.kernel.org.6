Return-Path: <linux-kernel+bounces-250981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BA92FF26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794341C220DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60C178378;
	Fri, 12 Jul 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4VXl0+Fu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EA17624C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804127; cv=none; b=Y4MQCY6p+YQdYYxU3aH2PkTUaCs6UKjKbTkRejFKlJiIVGx2C/8cbiyjunmlay8Wu9HcpNTO7vC4rKyBIcZTA5G/F3VJzm5zKJK7i7h+OAMuhRKGcKfdyaJJHqh1wO/U66dCPsHgJR0faRKj9RGJ1kBuPu2w6NOFYVXLWvgTzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804127; c=relaxed/simple;
	bh=lguhKTPts0/J0iW6TYJxdC+/TX8VJ5VrF72R57E6y2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h7kRyybHCu6wWu5l7AgOMAYd0mWl1NXM/1CDqhOI/X9qnz1ob1pva4qIIMT9sq7ay4WmZ1U1jq19pdWQ/cRRnEq8jrZLag0sJbUSDIuz5lUEsCOLeML9AGOpYl1MhTdKGyhpQQmY6QpZD+hF5nsoI4qEI3J6L7dB+LFi/FiA5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4VXl0+Fu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6590a57788aso34733337b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720804124; x=1721408924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzaVFggLRNr62pI1xSKpOhyCfu6Q6cckeYujw0nn2aQ=;
        b=4VXl0+Fu3oDLqDYeJHVPpLEntNzxMXGElLNHdGnRA0Ca+xgty5MEBztlpgHh9BkTmI
         7ZyfKxFAm0AoESHcbC2AgUpWsI2dF7TVZtUDcwXW0kOUm868ZHtD4+iYERzltR9bu8Fn
         jhBvA6j1ae1MrCRLQeuTvuS42uHt5b0wcew1YvWfLq+CegZbrp+WodGnJDp4g0QTJ4uZ
         P3z5j5ys9PMVAwtee+gwmMhfkyxPEOkq7Swm3G+KKFcoemRa/eCJBdBVM/paJJKvJaF7
         GD9yqN2a7swuJfaprItozxJc9ty8TLYYGAhAJjCrCiI9U6RjHoVScwld6LzepH3KJ5pu
         3ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804124; x=1721408924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzaVFggLRNr62pI1xSKpOhyCfu6Q6cckeYujw0nn2aQ=;
        b=l7/27dyr5IxHRFeLrLdtblrUaYyGHjxbNQS1lI/qHRjga26aWNSS+wyZws8iuEtFyW
         bmB/b0T8/Rn5Zx2MeXDXa8gJ/sDq0tcJft4InVITOHQAxLD+UqYJKGkD0qb26MJEaxb0
         9RcPibxrEbA9xxJXqBKfHwXwHvekBdq6ogoE1HdHH1+rn1IAekRQtW/hUMFbENT8zyH1
         zqKqNiTH3wXPapvNY7vU8yTMRQyzAp8hnsmgB9X1aDEfriXS68EuQRFsCjLT6ducMrIG
         u+owp6sgm1X0eArZ99RdxNo9t5c6karhQc5F42YCWdgvkdV7G5YM50fThGu+xggYwo0N
         G+1w==
X-Forwarded-Encrypted: i=1; AJvYcCVIzWYeLxtc8Kp5JTDd3W4NVCjX/3HEFq+sHYjo2+0AeGOOufFBwGDbbJuV7787qSl4iGu35Yla7Ms7QB8nxOXcYSbQ4fNu0xMQyyO4
X-Gm-Message-State: AOJu0Yy/YWrzXXksq2EK7tnMsmFBTDULn9ppV+GS38LT4nTfmPl5xf4L
	RexBSpR+Jv9OeES4VKwrzbTMXqTSzrZVmaegAQcVEpTXVwGBJrt3aNSLiztAs3ifXXD/ML0oJV9
	ZSQ==
X-Google-Smtp-Source: AGHT+IHZk57F3WvuOURYDUU46FpClsrkVa/s/m2kVKpzGYBPX8bvSEa5MWWTcj1S+0Y9SfhGEjG4CzdK3sc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4d82:b0:62d:42d:5f63 with SMTP id
 00721157ae682-658f0cc3c0emr3160787b3.5.1720804124557; Fri, 12 Jul 2024
 10:08:44 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:08:43 -0700
In-Reply-To: <66915ef3.050a0220.72f83.316b@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403140116.3002809-1-vineeth@bitbyteword.org>
 <ZjJf27yn-vkdB32X@google.com> <CAO7JXPgbtFJO6fMdGv3jf=DfiCNzcfi4Hgfn3hfotWH=FuD3zQ@mail.gmail.com>
 <CAO7JXPhMfibNsX6Nx902PRo7_A2b4Rnc3UP=bpKYeOuQnHvtrw@mail.gmail.com>
 <66912820.050a0220.15d64.10f5@mx.google.com> <19ecf8c8-d5ac-4cfb-a650-cf072ced81ce@efficios.com>
 <20240712122408.3f434cc5@rorschach.local.home> <ZpFdYFNfWcnq5yJM@google.com> <66915ef3.050a0220.72f83.316b@mx.google.com>
Message-ID: <ZpFjG-seBN33uTP2@google.com>
Subject: Re: [RFC PATCH v2 0/5] Paravirt Scheduling (Dynamic vcpu priority management)
From: Sean Christopherson <seanjc@google.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Ben Segall <bsegall@google.com>, 
	Borislav Petkov <bp@alien8.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Mel Gorman <mgorman@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Suleiman Souhlal <suleiman@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, himadrics@inria.fr, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	graf@amazon.com, drjunior.org@gmail.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 12, 2024, Joel Fernandes wrote:
> On Fri, Jul 12, 2024 at 09:44:16AM -0700, Sean Christopherson wrote:
> > On Fri, Jul 12, 2024, Steven Rostedt wrote:
> > > On Fri, 12 Jul 2024 10:09:03 -0400
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > 
> > > > > 
> > > > > Steven Rostedt told me, what we instead need is a tracepoint callback in a
> > > > > driver, that does the boosting.  
> > > > 
> > > > I utterly dislike changing the system behavior through tracepoints. They were
> > > > designed to observe the system, not modify its behavior. If people start abusing
> > > > them, then subsystem maintainers will stop adding them. Please don't do that.
> > > > Add a notifier or think about integrating what you are planning to add into the
> > > > driver instead.
> > > 
> > > I tend to agree that a notifier would be much better than using
> > > tracepoints, but then I also think eBPF has already let that cat out of
> > > the bag. :-p
> > > 
> > > All we need is a notifier that gets called at every VMEXIT.
> > 
> > Why?  The only argument I've seen for needing to hook VM-Exit is so that the
> > host can speculatively boost the priority of the vCPU when deliverying an IRQ,
> > but (a) I'm unconvinced that is necessary, i.e. that the vCPU needs to be boosted
> > _before_ the guest IRQ handler is invoked and (b) it has almost no benefit on
> > modern hardware that supports posted interrupts and IPI virtualization, i.e. for
> > which there will be no VM-Exit.
> 
> I am a bit confused by your statement Sean, because if a higher prio HOST
> thread wakes up on the vCPU thread's phyiscal CPU, then a VM-Exit should
> happen. That has nothing to do with IRQ delivery.  What am I missing?

Why does that require hooking VM-Exit?

