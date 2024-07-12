Return-Path: <linux-kernel+bounces-250942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F167F92FECF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966EE1F21C83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFE2176AB1;
	Fri, 12 Jul 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HNsotdYJ"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E6171E74
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803062; cv=none; b=VHG8THHFUdxfPCh2j74kiTg5N01Ri9JQw6IoOMZVYE3otZsz1Uyv7zw0RAvb/zNriI2tTSv+K3IX8mDszQnIIfYUaSu49EuqXwvHNZCMABMp02uBUEJtI0SowF9+Nm8Ur3q9+60wgKgBd2oarcdJI1yXFeEmQVpYgREukPVxaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803062; c=relaxed/simple;
	bh=GIxv7kyr1fOYOTFD8h5UlkXFpaIz/l2mkymV2jG4dIE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTnAWkKUNQkVv1w6OA6qPMKlea26D1XhRDU5ItStwyEWfbLMCpvgYm/IF1zFXRCvOeGI3TvJ3mZbaDkYOqLSTatYMXrG9sYPquei99SpNL0A0x9kpsn/nHW66N1gs/juRrMpz3tGP3RZeIT2wiW4c6xM0S53CJdzv5MVUAc62Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=HNsotdYJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a05c755477so138474185a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1720803060; x=1721407860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7TgW3Fxolq5hWIfDVfOFTW8e1mACsU8DTpdpP/Urrsw=;
        b=HNsotdYJlvsa9HEb6tYdil5Z7eEehGhUnob80gYft2Our5dMqzzZtJPNFl3zYxlGH4
         b3WAwaq6JR/2ErF8f0Ro9qOPeY+BGTSV9iFWVCY2l04o1E2kWtesgS1Tbq4yEhRJHyQ7
         G9SoCTuBNlGVZsdUXpRZl3vdU8s6/Ay/lOZeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803060; x=1721407860;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TgW3Fxolq5hWIfDVfOFTW8e1mACsU8DTpdpP/Urrsw=;
        b=c3VchMzxo1SJX6m7EaXmhVzoI8aPt75OhbD3+fyjZgUFJKIWpYjbZ6UUHAH2ZLFMsz
         qduRCoTY/Aed+O7p40d5xV8yDVR3FurmVE2tf2VzD4bcOOFeuvG8efykibhktujzIP2g
         ir+hPTf7eGBI0tzpgnxUhX81YEH5tvKO0dxcsJ+IzgfcwVkzBtaV75ubHpMs6B6qclLF
         9dH0JzXHIFEEmdsTSrnqHhIlnML+ZVzOLcVYrSHv/7kMqwvITJeXoZdgAcSEwxQ5UsQ7
         SraLnxSDNE19CoTLjJRC/Voom9L92mCnrEdUdJbiwEhCcvUaoVfQKWXodijcWPUWatdM
         qh1A==
X-Forwarded-Encrypted: i=1; AJvYcCWKllGebcW1K8U2P7yvkhSzyrcX7Yc0vzLykhAKeOQCdf7MWIS2Ls5zqh1RkUuvn223peSi/vfOVb85qa2U5t/LNB85LB98GbcN8N+l
X-Gm-Message-State: AOJu0YwI+G6UOYiuiu4jjXXMUDiOK7qHopTfjliGRZl90OmLGdOL/9/V
	f+Q1dUGMsEYVTldYjIdpzG8toroCIjcnHMLI6vJIs2oQ+XeIZhMcI30PAF3+cvI=
X-Google-Smtp-Source: AGHT+IGDZbjK2vfzdGQ04zfdQtcFDzbhW00kvjY2XCWo4lK+eLrLbVcitvWMacaFEGabuMdumAuMzw==
X-Received: by 2002:a05:620a:28c8:b0:79e:fca5:c312 with SMTP id af79cd13be357-79f19a78d1emr1572957785a.38.1720803059944;
        Fri, 12 Jul 2024 09:50:59 -0700 (PDT)
Received: from localhost ([73.134.137.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b2f93sm417696685a.125.2024.07.12.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:50:59 -0700 (PDT)
Message-ID: <66915ef3.050a0220.72f83.316b@mx.google.com>
X-Google-Original-Message-ID: <20240712165057.GA57824@JoelBox.>
Date: Fri, 12 Jul 2024 12:50:57 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, himadrics@inria.fr,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	graf@amazon.com, drjunior.org@gmail.com
Subject: Re: [RFC PATCH v2 0/5] Paravirt Scheduling (Dynamic vcpu priority
 management)
References: <20240403140116.3002809-1-vineeth@bitbyteword.org>
 <ZjJf27yn-vkdB32X@google.com>
 <CAO7JXPgbtFJO6fMdGv3jf=DfiCNzcfi4Hgfn3hfotWH=FuD3zQ@mail.gmail.com>
 <CAO7JXPhMfibNsX6Nx902PRo7_A2b4Rnc3UP=bpKYeOuQnHvtrw@mail.gmail.com>
 <66912820.050a0220.15d64.10f5@mx.google.com>
 <19ecf8c8-d5ac-4cfb-a650-cf072ced81ce@efficios.com>
 <20240712122408.3f434cc5@rorschach.local.home>
 <ZpFdYFNfWcnq5yJM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpFdYFNfWcnq5yJM@google.com>

On Fri, Jul 12, 2024 at 09:44:16AM -0700, Sean Christopherson wrote:
> On Fri, Jul 12, 2024, Steven Rostedt wrote:
> > On Fri, 12 Jul 2024 10:09:03 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > > > 
> > > > Steven Rostedt told me, what we instead need is a tracepoint callback in a
> > > > driver, that does the boosting.  
> > > 
> > > I utterly dislike changing the system behavior through tracepoints. They were
> > > designed to observe the system, not modify its behavior. If people start abusing
> > > them, then subsystem maintainers will stop adding them. Please don't do that.
> > > Add a notifier or think about integrating what you are planning to add into the
> > > driver instead.
> > 
> > I tend to agree that a notifier would be much better than using
> > tracepoints, but then I also think eBPF has already let that cat out of
> > the bag. :-p
> > 
> > All we need is a notifier that gets called at every VMEXIT.
> 
> Why?  The only argument I've seen for needing to hook VM-Exit is so that the
> host can speculatively boost the priority of the vCPU when deliverying an IRQ,
> but (a) I'm unconvinced that is necessary, i.e. that the vCPU needs to be boosted
> _before_ the guest IRQ handler is invoked and (b) it has almost no benefit on
> modern hardware that supports posted interrupts and IPI virtualization, i.e. for
> which there will be no VM-Exit.

I am a bit confused by your statement Sean, because if a higher prio HOST
thread wakes up on the vCPU thread's phyiscal CPU, then a VM-Exit should
happen. That has nothing to do with IRQ delivery.  What am I missing?

thanks,

 - Joel

