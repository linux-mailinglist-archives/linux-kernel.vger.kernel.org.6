Return-Path: <linux-kernel+bounces-171951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9FD8BEB1B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7004B244D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4BD16D4EE;
	Tue,  7 May 2024 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqwBqJye"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1E16D339
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105158; cv=none; b=kRP0Q3tC5FoWiNHozfCPwXNK0XQs5cDKF9Heh1eEioJnPeiVdkcSPMoLejaNdHlCganL9eAyC+y4/kvBmSl0ayAVGIWwu3QBLdol+mQHWqpWSwlOcvkWG+zkddS2Im2zu099S6kFbdXfoJHBjgvcovXXSdHGFC5zTsdD1lId9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105158; c=relaxed/simple;
	bh=Xb5whRwDyx5E2riHjw3KTgP+9PH574imG/syxIYEytQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jk5Yi95ci5cmDUv2KW4GBphgfcN+9UKUMsGo1m74igecjYSWiwn1Cc+79YCZf86JF4cpECPUxHbg7wFBJPSNjERchrZYBT4nScjFHBdj7JLapXtl2/g4EmCveXDUkMk6CRjCh2nKixgRAKujT8hDONbyerJZkaoOncjJJhWZbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqwBqJye; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f4755be972so1894152b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715105157; x=1715709957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4B3b0fSHvBV0t0bfPLzBXODTqy0x2bXlGHdHOkNN940=;
        b=jqwBqJye19do5EWiytzLlpVtzf0lqGFylsGNz8vZp1F1W6dQpp63id7T7FFAv8T+va
         wbE7pnNA7j7Tgchl+Z9bOfbP9Xk3J4/J0acmfhkdDevlTFmrrUdMVj0b+2dHrzLvjG0s
         EGSADrdL7krrzZtgIUSEnX8vjALX4YkuQ4ki/EFv0dPOoXjx0lfpyddRr1/YqjwbFS98
         tjmhNfUyOk5yil79poH80o04VU4aoUaxVrnxirXTjsodm+v2gKDhTTDOUjEYHElSUQB1
         VS+8Hk44RGPkiXa8LRzQRqIMV5fcOPjhEtp6+/lgkubmlh/bp7WcUPPKrzZosZcpga2q
         ylVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105157; x=1715709957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B3b0fSHvBV0t0bfPLzBXODTqy0x2bXlGHdHOkNN940=;
        b=hGcKlfC0ge50Wrsr7S3j1qXWFnn9MmEBBI4YnzjXtY96q9UG0MhRWFL8ezYxRDjwbD
         tKoi+iwRySpNyrpPLUIqpew8OCOnxkSHKVL1vfggWg/uPbza4O6Ah9pvfdWe87/sRiO1
         XUZj7aSjIpyeaWv4wkAQAYzW10n1t4MIR8bXDrXA9vUGVrvrNuD/f0St9hanfAnp4yN6
         t6ncHepEdtmz6knLI1j2TxO/lSrEB5JhMIXzjhGiibFHXGU/i96ZeppQuEAzOYLXDfBa
         VPjKXHJ14BoxfgFrB2ofNtd/7tvjtY1ErRaXmMjvXCqDUFvw32f3HmBKjOuqJ3duBxXt
         kchg==
X-Forwarded-Encrypted: i=1; AJvYcCVhdRmG5zKy8KsRorkfY0DzauAaqUWaX+yDqsyipgTTn+0oppGl9v0YZa5kTbLSkKslnCR+gGfpgD74ttjkoyIVCl/GNsyLucxYCjti
X-Gm-Message-State: AOJu0YweUeh1oOmQDvOZddrSuC12JerHG8yVV6GtT4BkA0ciOI280fIO
	LbUUCFGYG/7fnSWhC4KPZESjN3YBrLjdUpAWGDbSTYyNSXwnAw3KQ12rob6uoeClGKM9K+3hDUI
	W8Q==
X-Google-Smtp-Source: AGHT+IHEZwm2ACyKJwy8891F9ZqV8QggRFcnt3bRT/yT7KZWsBFqpyB+AjiErMqKZ/bjCLkxY7pledYiulk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2191:b0:6f4:9fc7:d21e with SMTP id
 d2e1a72fcca58-6f49fc7d436mr734b3a.5.1715105156569; Tue, 07 May 2024 11:05:56
 -0700 (PDT)
Date: Tue, 7 May 2024 11:05:55 -0700
In-Reply-To: <ZjkludR5wh0mKZ2H@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <a7398da4-a72c-4933-bb8b-5bc8965d96d0@paulmck-laptop>
 <ZhQmaEXPCqmx1rTW@google.com> <Zh2EQVj5bC0z5R90@tpad> <Zh2cPJ-5xh72ojzu@google.com>
 <Zh5w6rAWL+08a5lj@tpad> <Zh6GC0NRonCpzpV4@google.com> <Zh/1U8MtPWQ/yN2T@tpad>
 <ZiAFSlZwxyKzOTRL@google.com> <ZjVMpj7zcSf-JYd_@LeoBras> <ZjkludR5wh0mKZ2H@tpad>
Message-ID: <Zjptg53OzzKwImH5@google.com>
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
From: Sean Christopherson <seanjc@google.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 06, 2024, Marcelo Tosatti wrote:
> On Fri, May 03, 2024 at 05:44:22PM -0300, Leonardo Bras wrote:
> > > And that race exists in general, i.e. any IRQ that arrives just as the idle task
> > > is being scheduled in will unnecessarily wakeup rcuc.
> > 
> > That's a race could be solved with the timeout (snapshot) solution, if we 
> > don't zero last_guest_exit on kvm_sched_out(), right?
> 
> Yes.

And if KVM doesn't zero last_guest_exit on kvm_sched_out(), then we're right back
in the situation where RCU can get false positives (see below).

> > > > > >         /* Is the RCU core waiting for a quiescent state from this CPU? */
> > > > > > 
> > > > > > The problem is:
> > > > > > 
> > > > > > 1) You should only set that flag, in the VM-entry path, after the point
> > > > > > where no use of RCU is made: close to guest_state_enter_irqoff call.
> > > > > 
> > > > > Why?  As established above, KVM essentially has 1 second to enter the guest after
> > > > > setting in_guest_run_loop (or whatever we call it).  In the vast majority of cases,
> > > > > the time before KVM enters the guest can probably be measured in microseconds.
> > > > 
> > > > OK.
> > > > 
> > > > > Snapshotting the exit time has the exact same problem of depending on KVM to
> > > > > re-enter the guest soon-ish, so I don't understand why this would be considered
> > > > > a problem with a flag to note the CPU is in KVM's run loop, but not with a
> > > > > snapshot to say the CPU recently exited a KVM guest.
> > > > 
> > > > See the race above.
> > > 
> > > Ya, but if kvm_last_guest_exit is zeroed in kvm_sched_out(), then the snapshot
> > > approach ends up with the same race.  And not zeroing kvm_last_guest_exit is
> > > arguably much more problematic as encountering a false positive doesn't require
> > > hitting a small window.
> > 
> > For the false positive (only on nohz_full) the maximum delay for the
> > rcu_core() to be run would be 1s, and that would be in case we don't
> > schedule out for some userspace task or idle thread, in which case we have
> > a quiescent state without the need of rcu_core().
> > 
> > Now, for not being an userspace nor idle thread, it would need to be one or
> > more kernel threads, which I suppose aren't usually many, nor usually take
> > that long for completing, if we consider to be running on an isolated
> > (nohz_full) cpu. 
> > 
> > So, for the kvm_sched_out() case, I don't actually think we are  
> > statistically introducing that much of a delay in the RCU mechanism.
> > 
> > (I may be missing some point, though)

My point is that if kvm_last_guest_exit is left as-is on kvm_sched_out() and
vcpu_put(), then from a kernel/RCU safety perspective there is no meaningful
difference between KVM setting kvm_last_guest_exit and userspace being allowed
to mark a task as being exempt from being preempted by rcuc.  Userspace can
simply do KVM_RUN once to gain exemption from rcuc until the 1 second timeout
expires.

And if KVM does zero kvm_last_guest_exit on kvm_sched_out()/vcpu_put(), then the
approach has the exact same window as my in_guest_run_loop idea, i.e. rcuc can be
unnecessarily awakened in the time between KVM puts the vCPU and the CPU exits to
userspace.

