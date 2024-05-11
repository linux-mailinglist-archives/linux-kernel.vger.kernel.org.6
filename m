Return-Path: <linux-kernel+bounces-176376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941538C2EDA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77971C21C61
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7614AB2;
	Sat, 11 May 2024 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D78yXGQU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EAD14A8E
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393510; cv=none; b=hfxSH5Wz7QWw0wyoL54Jggob7RUFXyzOuYPluzDGCieh8cqMaPv9KYt50Oqb/hRWhAxaeLVre1k+E1Wb9yGIjiVi0rJ2LuvCcFBIAK8dlLsMQrVXOtlfHtnsfyfgNuji38libQvsuPJSg6IQGcBMmnP8srzY8fWVZsymYZjaqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393510; c=relaxed/simple;
	bh=i370JQajy3aWMRuZbCpfoUCzv45kEjChB2LQhLHEfVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=Y/XQQceRp6NRaqic52WxBgVrmpH6ia5lcvDMDaVHRIoC3c2zXLzd6dUW6mTtnGIpMSV1uf9Rn/eCCU5sUa+LH3rP32J+iNy+/SwKG9RC9PQLzQAtaLuwItdpgLTOK7GotcXvLUJjD4IRPj249JiFPfjn8gpa1JWkVK3nb3Tyi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D78yXGQU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715393508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCrVTsZCa0hoHkBjUZaAalxSusJYxIl0S99WRdYG/Jo=;
	b=D78yXGQUYBXtSuLbzZfIOEFLeCQanhfxiIb0eB7tq3YQtKD1lxtv3HBg1MmLipHg/0fhMK
	m1KIDZIu1F41pL2Jk30sxWI4PC8CdIETdZKoKvNeNqmxumc/aFut0E44FBSvksFCmqtJj3
	ABYEn5sHZ+orrZwQmaU7HPp0gbVlkI8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-n9qurqWaPsGD6DSs1qSlRQ-1; Fri, 10 May 2024 22:11:46 -0400
X-MC-Unique: n9qurqWaPsGD6DSs1qSlRQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78ee7776740so317443785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715393506; x=1715998306;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCrVTsZCa0hoHkBjUZaAalxSusJYxIl0S99WRdYG/Jo=;
        b=f5b7/AKytfney5EeuakCe3DWSMKHZ9sqEC8JulcZgr6LJLstgkDCkkBOtqemNQL/S1
         GoHPz9e6q0obEwHkO+Zi2YIffmRVPWA0ZwcIRZAyksqeIt3WHxsnBJVbebzJX22F5PwS
         jAoPKDI9wiJN4M22YynkmgBhYkObzw+L0FK0U8QoL7wenJRYvj8IkEH8cAe7Ne4Fq/Ey
         JGnnk9pcaYoJQrIV3b+m1HfXqzZHNfKLJMoUJ32tE9tzXVlzXZBRSeCaDHabCQfceDkC
         C63glcnxBTutXRxO9ixZyO4TnofgBCeLTPbYxejFGD5AuaqxpINIFNIkCfHJ1pdMBNTu
         8U8A==
X-Forwarded-Encrypted: i=1; AJvYcCXzYWQ5K3rgEfHgiGUiMV53nfi7A8R8fak+fPjNeBgx/p+sUKHBW+LAPQBwUTNCooy6u5/3HoLHH/ZOrAjS+I2AfarajwRNrm9DQcRu
X-Gm-Message-State: AOJu0YzRjd1CIAS6MSLWBuKsE5bI+zolm3YzHDlif2Qo+AYYcKGq2HS5
	qLCug7BvKH9RlebRZzbBhHlTVrT7+IULkQKUVCjQq87i+K2HAi3PZpcFHnusiSGjHsbalA+xmBC
	FOHV3eZxdMTj2PHvFJwhtqeJyDmK7PUZAMYquC0xKn47sBvGS3i3Y4o8Q0kerRg==
X-Received: by 2002:a05:620a:22f:b0:792:bc48:cdab with SMTP id af79cd13be357-792c757701dmr456483885a.13.1715393506384;
        Fri, 10 May 2024 19:11:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1e1amTkPJC4bHZhB3yzTNDaD6gx/0MhQAvP0aPsfcDRa6XbUU75rxaSQwzuWv94WMS/1PSA==
X-Received: by 2002:a05:620a:22f:b0:792:bc48:cdab with SMTP id af79cd13be357-792c757701dmr456481085a.13.1715393505698;
        Fri, 10 May 2024 19:11:45 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:8d87:eac1:dae4:8dd4:fe50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf275229sm236347485a.18.2024.05.10.19.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 19:11:45 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] kvm: Note an RCU quiescent state on guest exit
Date: Fri, 10 May 2024 23:11:41 -0300
Message-ID: <Zj7T3duUQqQPBryS@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240511020557.1198200-1-leobras@redhat.com>
References: <20240511020557.1198200-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 10, 2024 at 11:05:56PM -0300, Leonardo Bras wrote:
> As of today, KVM notes a quiescent state only in guest entry, which is good
> as it avoids the guest being interrupted for current RCU operations.
> 
> While the guest vcpu runs, it can be interrupted by a timer IRQ that will
> check for any RCU operations waiting for this CPU. In case there are any of
> such, it invokes rcu_core() in order to sched-out the current thread and
> note a quiescent state.
> 
> This occasional schedule work will introduce tens of microsseconds of
> latency, which is really bad for vcpus running latency-sensitive
> applications, such as real-time workloads.
> 
> So, note a quiescent state in guest exit, so the interrupted guests is able

s/guests/guest

> to deal with any pending RCU operations before being required to invoke
> rcu_core(), and thus avoid the overhead of related scheduler work.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
> 
> ps: A patch fixing this same issue was discussed in this thread:
> https://lore.kernel.org/all/20240328171949.743211-1-leobras@redhat.com/
> 
> Also, this can be paired with a new RCU option (rcutree.nocb_patience_delay)
> to avoid having invoke_rcu() being called on grace-periods starting between
> guest exit and the timer IRQ. This RCU option is being discussed in a
> sub-thread of this message:
> https://lore.kernel.org/all/5fd66909-1250-4a91-aa71-93cb36ed4ad5@paulmck-laptop/
> 
> 
>  include/linux/context_tracking.h |  6 ++++--
>  include/linux/kvm_host.h         | 10 +++++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
> index 6e76b9dba00e..8a78fabeafc3 100644
> --- a/include/linux/context_tracking.h
> +++ b/include/linux/context_tracking.h
> @@ -73,39 +73,41 @@ static inline void exception_exit(enum ctx_state prev_ctx)
>  }
>  
>  static __always_inline bool context_tracking_guest_enter(void)
>  {
>  	if (context_tracking_enabled())
>  		__ct_user_enter(CONTEXT_GUEST);
>  
>  	return context_tracking_enabled_this_cpu();
>  }
>  
> -static __always_inline void context_tracking_guest_exit(void)
> +static __always_inline bool context_tracking_guest_exit(void)
>  {
>  	if (context_tracking_enabled())
>  		__ct_user_exit(CONTEXT_GUEST);
> +
> +	return context_tracking_enabled_this_cpu();
>  }
>  
>  #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
>  
>  #else
>  static inline void user_enter(void) { }
>  static inline void user_exit(void) { }
>  static inline void user_enter_irqoff(void) { }
>  static inline void user_exit_irqoff(void) { }
>  static inline int exception_enter(void) { return 0; }
>  static inline void exception_exit(enum ctx_state prev_ctx) { }
>  static inline int ct_state(void) { return -1; }
>  static inline int __ct_state(void) { return -1; }
>  static __always_inline bool context_tracking_guest_enter(void) { return false; }
> -static __always_inline void context_tracking_guest_exit(void) { }
> +static __always_inline bool context_tracking_guest_exit(void) { return false; }
>  #define CT_WARN_ON(cond) do { } while (0)
>  #endif /* !CONFIG_CONTEXT_TRACKING_USER */
>  
>  #ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
>  extern void context_tracking_init(void);
>  #else
>  static inline void context_tracking_init(void) { }
>  #endif /* CONFIG_CONTEXT_TRACKING_USER_FORCE */
>  
>  #ifdef CONFIG_CONTEXT_TRACKING_IDLE
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 48f31dcd318a..e37724c44843 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -480,21 +480,29 @@ static __always_inline void guest_state_enter_irqoff(void)
>  /*
>   * Exit guest context and exit an RCU extended quiescent state.
>   *
>   * Between guest_context_enter_irqoff() and guest_context_exit_irqoff() it is
>   * unsafe to use any code which may directly or indirectly use RCU, tracing
>   * (including IRQ flag tracing), or lockdep. All code in this period must be
>   * non-instrumentable.
>   */
>  static __always_inline void guest_context_exit_irqoff(void)
>  {
> -	context_tracking_guest_exit();
> +	/*
> +	 * Guest mode is treated as a quiescent state, see
> +	 * guest_context_enter_irqoff() for more details.
> +	 */
> +	if (!context_tracking_guest_exit()) {
> +		instrumentation_begin();
> +		rcu_virt_note_context_switch();
> +		instrumentation_end();
> +	}
>  }
>  
>  /*
>   * Stop accounting time towards a guest.
>   * Must be called after exiting guest context.
>   */
>  static __always_inline void guest_timing_exit_irqoff(void)
>  {
>  	instrumentation_begin();
>  	/* Flush the guest cputime we spent on the guest */
> -- 
> 2.45.0
> 


