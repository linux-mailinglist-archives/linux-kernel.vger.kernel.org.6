Return-Path: <linux-kernel+bounces-176727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2488C33C3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 22:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC301F219B6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BED17BB7;
	Sat, 11 May 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJKdQ47R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FF1CD11
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715459510; cv=none; b=UdLjJUfMMXO0LNInk8A3fpxpVkaolUOpJDaOJIm6yuOY6JMls0rrAEqSJ9OVEi1rH0Wq6PpXspdfcBDWzRTBOQgthVxnmQ/aHeqz8UlT663m1WozVLj00GNCj+6HCEL1EF5UtnM463YQTWy1lP8mMnTmisLvC2XVrEf1lEX/n5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715459510; c=relaxed/simple;
	bh=ZJCjeTD4BIzJC78hCBnDbdYDSIfpi5tTg6nMh5euC6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=gN9d01CjfRo1RpZmFnjRKHIWgfHn6tf8NM2hbBa2d7oGs9cigk4+UnrISQl6X2f0t4quxEeR2uBCzzdaqu35pT48b+YZlEYAmhfViDSABwE1ue/RT07/NcyaW9DIPE6An/lW2Vgjzat8L2xZuO0I08bk0mt5k8z6hIo09HTzsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJKdQ47R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715459507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzSjQIEMrJJgZniLc2C8D6P/avkSP2th2xNzph1s0BM=;
	b=IJKdQ47RyMLYsdiRETII/HFGo7IqvxNtCaEy8YRkMXGkENjGoOr7pWSyE9WvBX7CkW86TP
	O7poXvNGS6KP3vICt/EQQT38mjSUSlBxiGc4eUVk0XLkepS+HUK2plAfcXoWWEeyfJYt5m
	24kIrJnn1VnqA1qy5wmo5C0vxhvAUXw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-JO9l8hh9OTuw2KHS4Oth4A-1; Sat, 11 May 2024 16:31:38 -0400
X-MC-Unique: JO9l8hh9OTuw2KHS4Oth4A-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ee3b4f8165so32784265ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 13:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715459498; x=1716064298;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzSjQIEMrJJgZniLc2C8D6P/avkSP2th2xNzph1s0BM=;
        b=GkCiddywW6qacMjSLs24BHmfxzUEulaX7GJ794CG6JKhwb3TJ+vS097i2zlyg33Dq+
         vVjHAlBnfxfeXuGXxt7tPHrzwn94hEKabsmlzHUVt8XfnwyNEt8qToNPp8OOCuX6H2rp
         aDXrzuomC53Yc4RXuk3JNXrl8WWR/ggl3s/dbV+nMSx+DtT2DeRD20EsTzyx0BZ6MKlm
         Uf67Kk15h8Nvv/qTp+gLMqrREUPhBca2+SLhVLjHBuZ0DsJ+KSTv/SuWZzajcmoT0dAC
         VNvyXXdnng6L0mMICmKNkzDA88k6l5HgtOQFyVAazmoYQ7+Ch0JeFL/JFlkVPxal7RL2
         IR2g==
X-Forwarded-Encrypted: i=1; AJvYcCVy8drKIGc6zKdn9zawnxaSQdAw8hvTtVNX8lyhZkHBMUxcBgrNEffcmPaac2lrHIhSgFQ9LJkCtEL+DDD2hca3RAqpWXPI6LHZrOfk
X-Gm-Message-State: AOJu0YxVYb+o9eOQhs0pcRxURcWXq2PB3mnmk61qAq75ZyXZtwit38Uz
	Ch3MWLB9QT5uVpKUZUUyhWgaCAKeovl1uy0fE7QtjfbKXaRPDf/2++pfJklmg+8pFn9RdAGVcy6
	BL2zvntxn3v/3l+xXOmGKxG/ULT9qF+vOALr7JBJLtt0Y9Vbv7bRDNmbyBIKbAw==
X-Received: by 2002:a17:903:1250:b0:1ea:26bf:928 with SMTP id d9443c01a7336-1ef44161501mr74878955ad.50.1715459497706;
        Sat, 11 May 2024 13:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJwasUoov14+GDZen/0VvvhZVxtK7I1vIGZMsS0lAp8OwoeSy+UK0QH0xibloBei2YEBMThQ==
X-Received: by 2002:a17:903:1250:b0:1ea:26bf:928 with SMTP id d9443c01a7336-1ef44161501mr74878775ad.50.1715459497223;
        Sat, 11 May 2024 13:31:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:a9e8:e01f:c640:3398:ffe5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c0361b2sm52236155ad.202.2024.05.11.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 13:31:36 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] kvm: Note an RCU quiescent state on guest exit
Date: Sat, 11 May 2024 17:31:20 -0300
Message-ID: <Zj_VmALxIhqaNgzG@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <e6e42572-f73b-4217-871a-37c439ec8552@paulmck-laptop>
References: <20240511020557.1198200-1-leobras@redhat.com> <e6e42572-f73b-4217-871a-37c439ec8552@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, May 11, 2024 at 07:55:55AM -0700, Paul E. McKenney wrote:
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
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Thanks!
Leo

> 
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
> 


