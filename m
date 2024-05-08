Return-Path: <linux-kernel+bounces-172640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16438BF4BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176B01F253E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6112E5E;
	Wed,  8 May 2024 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUEZNn0C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D814A8C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136699; cv=none; b=k3yyyls8ty8HC9p12OI7Rab+wN7ShfE0UwKV/dEqb55zkKt+YzJFiXG/j/RU8m/diaWLCXSny6hwD6C603zl7FznZZW5yiqifcx9J81mJo4xo+rKVORkDPOMTYSREr1nnjJFl2KuKcYz1DiVHAGTGq/awpw60xHslbo+N/IDtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136699; c=relaxed/simple;
	bh=96jLrpnO7xA+Xi8Fl73OQcTWlA1+oomeCJfeSICvHaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=SGanTuiSuSjA1m32Vp6WKnJ4F0nivOu2I5DZ8cVkIphTBkGX3s24XBQjUD1ePZ4Fo2IitC/F4Jo5f1shmky6VentUvjLSJUFMcn1/JYxrmk6CJximxoNRWPY0KCTMRCFr7moaP37IxXVglnESeZYLlL1VpumSIWPjxb/xEBU8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUEZNn0C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715136696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzghtbwC7fCwhqmIIbZDW0dMUUlzfhLtklhx6OArQF4=;
	b=YUEZNn0Cy0xl19WtIUNE09paz1tpISK/IIolfdh2wBcdJV4kBuVaHay1ln9ANTbNNQIxLz
	JmncdqQNJENnOK/m8/lo4xXXccMduiugu36vofiJmv5jtjaz5jnvWFrRaCgRegh40xAmZu
	k3nesG6VnvVSnybUy3A3zsTzm3WC01E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-1cSnd8ZLOlqdM0b3-QKkEQ-1; Tue, 07 May 2024 22:51:35 -0400
X-MC-Unique: 1cSnd8ZLOlqdM0b3-QKkEQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ec4c65a091so29299995ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 19:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715136694; x=1715741494;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzghtbwC7fCwhqmIIbZDW0dMUUlzfhLtklhx6OArQF4=;
        b=kxG1CPlwLUQ8oX/KRqFKAAz/lxdZsGq4HfUnZ+GRrHNWSBPquVRg763lSF78+1Rzz9
         29uCxUPx7cZHq2q1HN9s+s+BqiQMCF/t+DMG7Gn5cPW5IX248NK3dGwjSPmCx92UvaF2
         8S439OVYeiypQdnsQ18Pvi8ERxsQ0I0ulMmhIi5m6MVkQbHFx36UH/0NFaqq/S9L3sMG
         kXJsUHk4vvw+BZWL8c/Ydg8+e9pDvP/Vf8CASvog0ce/Um9kcFEedGW/Q51yhTs+ugf1
         BJLSpMCTc0qc553BEk+Tu0DYoNCC0kWNSXCoS5czYiRncyVLE1AMFJRJhAW5dVX/FkcX
         A0mw==
X-Forwarded-Encrypted: i=1; AJvYcCWGbsf2zDP40XC6RYqok2csqtVDFZOcEHNHVkf+t+WsRhGXZ1Qrs/0OwaDErEBgp5RrgKqaLzMr4skoOaZvLLu5qxdE/wM3DkW2hslY
X-Gm-Message-State: AOJu0YxjB9PF/ZKfGujvl7eFpnbzoOtq7r6BlCzwKv8Fx+occIhk1JIt
	KFK6uIAZfbpNxKaqZlTtiU9SpZE71DkjyPrGH4PtXvQcpFyBzIj7XKnDvyloo8gUG+tFZo013Zr
	TKjFVzCB/UZjjeCrKx/tFA+801qtC1F5rOHu7ceVZ/UEh+VrHrfSF//m1K/LRtg==
X-Received: by 2002:a17:902:aa8e:b0:1eb:54b7:2724 with SMTP id d9443c01a7336-1eeb0bad67emr12695545ad.64.1715136694185;
        Tue, 07 May 2024 19:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6dF5z3NTCGB2Np9gpb1pWKKzHfNNQr6EvBR9bVSywVQJlhuuJPHAKfYXvfhKyBw3H22dhnQ==
X-Received: by 2002:a17:902:aa8e:b0:1eb:54b7:2724 with SMTP id d9443c01a7336-1eeb0bad67emr12695315ad.64.1715136693642;
        Tue, 07 May 2024 19:51:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:4b0a:b7a4:5eb9:b8a9:508d])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b001eb8fb27b59sm10727134plh.111.2024.05.07.19.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 19:51:32 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
Date: Tue,  7 May 2024 23:51:15 -0300
Message-ID: <Zjroo8OsYcVJLsYO@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ZjrClk4Lqw_cLO5A@google.com>
References: <ZgsXRUTj40LmXVS4@google.com> <ZjUwHvyvkM3lj80Q@LeoBras> <ZjVXVc2e_V8NiMy3@google.com> <3b2c222b-9ef7-43e2-8ab3-653a5ee824d4@paulmck-laptop> <ZjprKm5jG3JYsgGB@google.com> <663a659d-3a6f-4bec-a84b-4dd5fd16c3c1@paulmck-laptop> <ZjqWXPFuoYWWcxP3@google.com> <0e239143-65ed-445a-9782-e905527ea572@paulmck-laptop> <Zjq9okodmvkywz82@google.com> <ZjrClk4Lqw_cLO5A@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 07, 2024 at 05:08:54PM -0700, Sean Christopherson wrote:
> On Tue, May 07, 2024, Sean Christopherson wrote:
> > On Tue, May 07, 2024, Paul E. McKenney wrote:
> > > On Tue, May 07, 2024 at 02:00:12PM -0700, Sean Christopherson wrote:
> > > > On Tue, May 07, 2024, Paul E. McKenney wrote:
> > > > > On Tue, May 07, 2024 at 10:55:54AM -0700, Sean Christopherson wrote:
> > > > > > On Fri, May 03, 2024, Paul E. McKenney wrote:
> > > > > > > On Fri, May 03, 2024 at 02:29:57PM -0700, Sean Christopherson wrote:
> > > > > > > > So if we're comfortable relying on the 1 second timeout to guard against a
> > > > > > > > misbehaving userspace, IMO we might as well fully rely on that guardrail.  I.e.
> > > > > > > > add a generic PF_xxx flag (or whatever flag location is most appropriate) to let
> > > > > > > > userspace communicate to the kernel that it's a real-time task that spends the
> > > > > > > > overwhelming majority of its time in userspace or guest context, i.e. should be
> > > > > > > > given extra leniency with respect to rcuc if the task happens to be interrupted
> > > > > > > > while it's in kernel context.
> > > > > > > 
> > > > > > > But if the task is executing in host kernel context for quite some time,
> > > > > > > then the host kernel's RCU really does need to take evasive action.
> > > > > > 
> > > > > > Agreed, but what I'm saying is that RCU already has the mechanism to do so in the
> > > > > > form of the 1 second timeout.
> > > > > 
> > > > > Plus RCU will force-enable that CPU's scheduler-clock tick after about
> > > > > ten milliseconds of that CPU not being in a quiescent state, with
> > > > > the time varying depending on the value of HZ and the number of CPUs.
> > > > > After about ten seconds (halfway to the RCU CPU stall warning), it will
> > > > > resched_cpu() that CPU every few milliseconds.
> > > > > 
> > > > > > And while KVM does not guarantee that it will immediately resume the guest after
> > > > > > servicing the IRQ, neither does the existing userspace logic.  E.g. I don't see
> > > > > > anything that would prevent the kernel from preempting the interrupt task.
> > > > > 
> > > > > Similarly, the hypervisor could preempt a guest OS's RCU read-side
> > > > > critical section or its preempt_disable() code.
> > > > > 
> > > > > Or am I missing your point?
> > > > 
> > > > I think you're missing my point?  I'm talking specifically about host RCU, what
> > > > is or isn't happening in the guest is completely out of scope.
> > > 
> > > Ah, I was thinking of nested virtualization.
> > > 
> > > > My overarching point is that the existing @user check in rcu_pending() is optimistic,
> > > > in the sense that the CPU is _likely_ to quickly enter a quiescent state if @user
> > > > is true, but it's not 100% guaranteed.  And because it's not guaranteed, RCU has
> > > > the aforementioned guardrails.
> > > 
> > > You lost me on this one.
> > > 
> > > The "user" argument to rcu_pending() comes from the context saved at
> > > the time of the scheduling-clock interrupt.  In other words, the CPU
> > > really was executing in user mode (which is an RCU quiescent state)
> > > when the interrupt arrived.
> > > 
> > > And that suffices, 100% guaranteed.
> > 
> > Ooh, that's where I'm off in the weeds.  I was viewing @user as "this CPU will be
> > quiescent", but it really means "this CPU _was_ quiescent".
> 
> Hrm, I'm still confused though.  That's rock solid for this check:
> 
> 	/* Is the RCU core waiting for a quiescent state from this CPU? */
> 
> But I don't understand how it plays into the next three checks that can result in
> rcuc being awakened.  I suspect it's these checks that Leo and Marcelo are trying
> squash, and these _do_ seem like they are NOT 100% guaranteed by the @user check.
> 
> 	/* Does this CPU have callbacks ready to invoke? */
> 	/* Has RCU gone idle with this CPU needing another grace period? */
> 	/* Have RCU grace period completed or started?  */
> 
> > > The reason that it suffices is that other RCU code such as rcu_qs() and
> > > rcu_note_context_switch() ensure that this CPU does not pay attention to
> > > the user-argument-induced quiescent state unless this CPU had previously
> > > acknowledged the current grace period.
> > > 
> > > And if the CPU has previously acknowledged the current grace period, that
> > > acknowledgement must have preceded the interrupt from user-mode execution.
> > > Thus the prior quiescent state represented by that user-mode execution
> > > applies to that previously acknowledged grace period.
> > 
> > To confirm my own understanding: 
> > 
> >   1. Acknowledging the current grace period means any future rcu_read_lock() on
> >      the CPU will be accounted to the next grace period.
> > 
> >   2. A CPU can acknowledge a grace period without being quiescent.
> > 
> >   3. Userspace can't acknowledge a grace period, because it doesn't run kernel
> >      code (stating the obvious).
> > 
> >   4. All RCU read-side critical sections must complete before exiting to usersepace.
> > 
> > And so if an IRQ interrupts userspace, and the CPU previously acknowledged grace
> > period N, RCU can infer that grace period N elapsed on the CPU, because all
> > "locks" held on grace period N are guaranteed to have been dropped.
> > 
> > > This is admittedly a bit indirect, but then again this is Linux-kernel
> > > RCU that we are talking about.
> > > 
> > > > And I'm arguing that, since the @user check isn't bombproof, there's no reason to
> > > > try to harden against every possible edge case in an equivalent @guest check,
> > > > because it's unnecessary for kernel safety, thanks to the guardrails.
> > > 
> > > And the same argument above would also apply to an equivalent check for
> > > execution in guest mode at the time of the interrupt.
> > 
> > This is partly why I was off in the weeds.  KVM cannot guarantee that the
> > interrupt that leads to rcu_pending() actually interrupted the guest.  And the
> > original patch didn't help at all, because a time-based check doesn't come
> > remotely close to the guarantees that the @user check provides.
> > 
> > > Please understand that I am not saying that we absolutely need an
> > > additional check (you tell me!).
> > 
> > Heh, I don't think I'm qualified to answer that question, at least not yet.
> > 
> > > But if we do need RCU to be more aggressive about treating guest execution as
> > > an RCU quiescent state within the host, that additional check would be an
> > > excellent way of making that happen.
> > 
> > It's not clear to me that being more agressive is warranted.  If my understanding
> > of the existing @user check is correct, we _could_ achieve similar functionality
> > for vCPU tasks by defining a rule that KVM must never enter an RCU critical section
> > with PF_VCPU set and IRQs enabled, and then rcu_pending() could check PF_VCPU.
> > On x86, this would be relatively straightforward (hack-a-patch below), but I've
> > no idea what it would look like on other architectures.
> > 
> > But the value added isn't entirely clear to me, probably because I'm still missing
> > something.  KVM will have *very* recently called __ct_user_exit(CONTEXT_GUEST) to
> > note the transition from guest to host kernel.  Why isn't that a sufficient hook
> > for RCU to infer grace period completion?

This is one of the solutions I tested when I was trying to solve the bug:
- Report quiescent state both in guest entry & guest exit.

It improves the bug, but has 2 issues compared to the timing alternative:
1 - Saving jiffies to a per-cpu local variable is usually cheaper than 
    reporting a quiescent state
2 - If we report it on guest_exit() and some other cpu requests a grace 
    period in the next few cpu cycles, there is chance a timer interrupt 
    can trigger rcu_core() before the next guest_entry, which would 
    introduce unnecessary latency, and cause be the issue we are trying to 
    fix.

I mean, it makes the bug reproduce less, but do not fix it.

Thx,
Leo

> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 1a9e1e0c9f49..259b60adaad7 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -11301,6 +11301,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >         if (vcpu->arch.guest_fpu.xfd_err)
> >                 wrmsrl(MSR_IA32_XFD_ERR, 0);
> >  
> > +       RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
> > +                        lock_is_held(&rcu_lock_map) ||
> > +                        lock_is_held(&rcu_sched_lock_map),
> > +                        "KVM in RCU read-side critical section with PF_VCPU set and IRQs enabled");
> > +
> >         /*
> >          * Consume any pending interrupts, including the possible source of
> >          * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b2bccfd37c38..cdb815105de4 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3929,7 +3929,8 @@ static int rcu_pending(int user)
> >                 return 1;
> >  
> >         /* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
> > -       if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
> > +       if ((user || rcu_is_cpu_rrupt_from_idle() || (current->flags & PF_VCPU)) &&
> > +           rcu_nohz_full_cpu())
> >                 return 0;
> >  
> >         /* Is the RCU core waiting for a quiescent state from this CPU? */
> > 
> > 
> 


