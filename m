Return-Path: <linux-kernel+bounces-177123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0188C3A64
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206BB281277
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 03:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080A145B1D;
	Mon, 13 May 2024 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwZOT0p6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9683CDE
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715570099; cv=none; b=F9FaZjwKiYZRAop7yH/DGJ/mmujRu5PjdqLJSIaB2SFT5yWaGfASc8eH5cjG1HyIgcU7d+SNnd8upcs72P1rmkA4/PrUbGuOeEz89DH/3QneKPS2KmeZbsVVskIg+Kjzn/H1PBkzHDdLvAajFfuIdOXeeCluLYnAWhnDET3prmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715570099; c=relaxed/simple;
	bh=e83pyTSL/0FYOwrnJ5j49Wi6n7/x+jlh8h3ehPnVBmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=hv3rRPFwJX8vVVMGXFsi0VVD0FJ+8nIzW/alk3BzLbaaq9nWexKCyF8ZpVU9Jq1mXsvtqMGxFr43r2qYcU5y2DX0axtxQSim4dDtKHMk35PaAIXi8td/XDipBNTJKuz0llfemlAg13FcJhUBOIYmFbD+0GrpCF0G5MTzzzHtjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwZOT0p6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715570096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdp0sTJWZleI1ZvLM/ZeS0ROuPS4/85owNKykPi0fwE=;
	b=ZwZOT0p6hI5hqn7X+Y/SvcjOV46pmoTEWKxvxW3HF87QnLMzbUGjsWUSL1K6uZY3qfC2md
	uoccEa+kjkiapFrIdq9+fz4uI+d4XUcb9uUq3qcUPMv+OMsZOIBBzqHK4spWYx1blL9NfC
	XCBrWEJJ43cZq8n6uBlqCYGFreocR24=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-v8VPyEdaNYOKpExq4Vr2pQ-1; Sun, 12 May 2024 23:14:55 -0400
X-MC-Unique: v8VPyEdaNYOKpExq4Vr2pQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6f454878580so3850967b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 20:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715570094; x=1716174894;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdp0sTJWZleI1ZvLM/ZeS0ROuPS4/85owNKykPi0fwE=;
        b=rh+42xmuq01wxFzuhMECsde8kaBTT35G4D9unPodzPbtUFeuQbVruTbXXm8xXCO3IZ
         zMCS4NtlrIdLftv+Yt/5rTq8CFs3JFJJKW0KftmLHu3SeL3c1WMFytYx9u2JOIzngZ9I
         EoY13ZuXP/rAUQDa0aLr6oregGhDwJSESLpbZWcfu/IjO8tfkFH5V2GE/JJipYeLnZxC
         HmMB7fviEtVeOFlOu2sYr4vFsYEr4eQdAWVKz5Wb6gB6BVI48MkGLyogXeZbfqEAn0A4
         J8y4n9tr5z4JZnRAymCBh5gFx/s1aocKgcmmGQTONsuAy1c5WrBvwvnPJLzv4e3Pgzau
         mX6A==
X-Forwarded-Encrypted: i=1; AJvYcCUqL706zvfSI4zcns0OihrWpXrl6ZQWOQ9yGj3qEKcD5GEPdyHGYdEfE1GkHegJfQ8VJr/DlS70RPiSTmdBl5diFpdr7ZXDTaBJWv79
X-Gm-Message-State: AOJu0Ywtt8BiORA/CUQVmTEcJ8tqLlqplm3EWQeUwWqSsHvGoA3SHGIG
	mtTNsD8uZvjMZaqL1VmtFitWpNEw1E8aguTna2ClvR5zX6j8SZrn6h6v4ZTjXbpTG5KxcTJM0nD
	A3kDcLlmOWGUPhGPKZCd8W58vbE0lCEyiuV+iy32J6gOEg61lhktaBEPeYxHRGA==
X-Received: by 2002:a05:6a00:4f86:b0:6ec:f0e7:d942 with SMTP id d2e1a72fcca58-6f4e032358amr11580581b3a.28.1715570093944;
        Sun, 12 May 2024 20:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpTRiqaJXicVKodhK+KVvkmH5VRFOWl2CZ8RVYO2f78UigU6Bh0g8Vf5xllRMeWrjV7wYNBQ==
X-Received: by 2002:a05:6a00:4f86:b0:6ec:f0e7:d942 with SMTP id d2e1a72fcca58-6f4e032358amr11580540b3a.28.1715570092799;
        Sun, 12 May 2024 20:14:52 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:a9e8:e01f:c640:3398:ffe5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f89d7ff5sm2127569b3a.84.2024.05.12.20.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 20:14:52 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] kvm: Note an RCU quiescent state on guest exit
Date: Mon, 13 May 2024 00:14:32 -0300
Message-ID: <ZkGFmISfnrKNrUgj@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ZkE4N1X0wglygt75@tpad>
References: <20240511020557.1198200-1-leobras@redhat.com> <ZkE4N1X0wglygt75@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, May 12, 2024 at 06:44:23PM -0300, Marcelo Tosatti wrote:
> On Fri, May 10, 2024 at 11:05:56PM -0300, Leonardo Bras wrote:
> > As of today, KVM notes a quiescent state only in guest entry, which is good
> > as it avoids the guest being interrupted for current RCU operations.
> > 
> > While the guest vcpu runs, it can be interrupted by a timer IRQ that will
> > check for any RCU operations waiting for this CPU. In case there are any of
> > such, it invokes rcu_core() in order to sched-out the current thread and
> > note a quiescent state.
> > 
> > This occasional schedule work will introduce tens of microsseconds of
> > latency, which is really bad for vcpus running latency-sensitive
> > applications, such as real-time workloads.
> > 
> > So, note a quiescent state in guest exit, so the interrupted guests is able
> > to deal with any pending RCU operations before being required to invoke
> > rcu_core(), and thus avoid the overhead of related scheduler work.
> 
> This does not properly fix the current problem, as RCU work might be
> scheduled after the VM exit, followed by a timer interrupt.
> 
> Correct?

Correct, for this case, check the note below:

> 
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> > 
> > ps: A patch fixing this same issue was discussed in this thread:
> > https://lore.kernel.org/all/20240328171949.743211-1-leobras@redhat.com/
> > 
> > Also, this can be paired with a new RCU option (rcutree.nocb_patience_delay)
> > to avoid having invoke_rcu() being called on grace-periods starting between
> > guest exit and the timer IRQ. This RCU option is being discussed in a
> > sub-thread of this message:
> > https://lore.kernel.org/all/5fd66909-1250-4a91-aa71-93cb36ed4ad5@paulmck-laptop/

^ This one above.
The idea is to use this rcutree.nocb_patience_delay=N :
a new option we added on RCU that allow us to avoid invoking rcu_core() if 
the grace_period < N miliseconds. This only works on nohz_full cpus.

So with both the current patch and the one in above link, we have the same 
effect as we previously had with last_guest_exit, with a cherry on top: we 
can avoid rcu_core() getting called in situations where a grace period just 
started after going into kernel code, and a timer interrupt happened before 
it can report quiescent state again. 

For our nohz_full vcpu thread scenario, we have:

- guest_exit note a quiescent state
- let's say we start a grace period in the next cycle
- If timer interrupts, it requires the grace period to be older than N 
  miliseconds
  - If we configure a proper value for patience, it will never reach the 
    end of patience before going guest_entry, and thus noting a quiescent 
    state

What do you think?

Thanks!
Leo

> > 
> > 
> >  include/linux/context_tracking.h |  6 ++++--
> >  include/linux/kvm_host.h         | 10 +++++++++-
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
> > index 6e76b9dba00e..8a78fabeafc3 100644
> > --- a/include/linux/context_tracking.h
> > +++ b/include/linux/context_tracking.h
> > @@ -73,39 +73,41 @@ static inline void exception_exit(enum ctx_state prev_ctx)
> >  }
> >  
> >  static __always_inline bool context_tracking_guest_enter(void)
> >  {
> >  	if (context_tracking_enabled())
> >  		__ct_user_enter(CONTEXT_GUEST);
> >  
> >  	return context_tracking_enabled_this_cpu();
> >  }
> >  
> > -static __always_inline void context_tracking_guest_exit(void)
> > +static __always_inline bool context_tracking_guest_exit(void)
> >  {
> >  	if (context_tracking_enabled())
> >  		__ct_user_exit(CONTEXT_GUEST);
> > +
> > +	return context_tracking_enabled_this_cpu();
> >  }
> >  
> >  #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
> >  
> >  #else
> >  static inline void user_enter(void) { }
> >  static inline void user_exit(void) { }
> >  static inline void user_enter_irqoff(void) { }
> >  static inline void user_exit_irqoff(void) { }
> >  static inline int exception_enter(void) { return 0; }
> >  static inline void exception_exit(enum ctx_state prev_ctx) { }
> >  static inline int ct_state(void) { return -1; }
> >  static inline int __ct_state(void) { return -1; }
> >  static __always_inline bool context_tracking_guest_enter(void) { return false; }
> > -static __always_inline void context_tracking_guest_exit(void) { }
> > +static __always_inline bool context_tracking_guest_exit(void) { return false; }
> >  #define CT_WARN_ON(cond) do { } while (0)
> >  #endif /* !CONFIG_CONTEXT_TRACKING_USER */
> >  
> >  #ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
> >  extern void context_tracking_init(void);
> >  #else
> >  static inline void context_tracking_init(void) { }
> >  #endif /* CONFIG_CONTEXT_TRACKING_USER_FORCE */
> >  
> >  #ifdef CONFIG_CONTEXT_TRACKING_IDLE
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 48f31dcd318a..e37724c44843 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -480,21 +480,29 @@ static __always_inline void guest_state_enter_irqoff(void)
> >  /*
> >   * Exit guest context and exit an RCU extended quiescent state.
> >   *
> >   * Between guest_context_enter_irqoff() and guest_context_exit_irqoff() it is
> >   * unsafe to use any code which may directly or indirectly use RCU, tracing
> >   * (including IRQ flag tracing), or lockdep. All code in this period must be
> >   * non-instrumentable.
> >   */
> >  static __always_inline void guest_context_exit_irqoff(void)
> >  {
> > -	context_tracking_guest_exit();
> > +	/*
> > +	 * Guest mode is treated as a quiescent state, see
> > +	 * guest_context_enter_irqoff() for more details.
> > +	 */
> > +	if (!context_tracking_guest_exit()) {
> > +		instrumentation_begin();
> > +		rcu_virt_note_context_switch();
> > +		instrumentation_end();
> > +	}
> >  }
> >  
> >  /*
> >   * Stop accounting time towards a guest.
> >   * Must be called after exiting guest context.
> >   */
> >  static __always_inline void guest_timing_exit_irqoff(void)
> >  {
> >  	instrumentation_begin();
> >  	/* Flush the guest cputime we spent on the guest */
> > -- 
> > 2.45.0
> > 
> > 
> > 
> 


