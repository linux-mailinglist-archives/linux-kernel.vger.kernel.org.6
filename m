Return-Path: <linux-kernel+bounces-175911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56918C2703
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F96F281092
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8B1708B1;
	Fri, 10 May 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4R96vW7N"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3714B08C
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351957; cv=none; b=Xvr7UkgEFdij6cup+Q08WwtHC3lqdQzW0Mg4JNr4EnzJmALf/HrwKFiBuwLocdFRBN7vpkKEpLzK5s5842mAsR2GXRkfzmDfd5YlGXK92bjIyS7VENIKmGKP1WmmDmJLn12AKix/4UF2nj3oFCl6ZFczwTDC+0agWSTTGRLjsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351957; c=relaxed/simple;
	bh=2w9De7V5jOfTq8rH1l9a1Xsc541rGrm7F/L+4BdzLqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqsoXkLtd9ii6mR+GDxmrx79YdSxPZHBbjkD19KOi+fGVC3Z2SXok8KambjmdEZhpA16nVjYtZTw2gGdOPhnRiIkgnGW/AoT2fHOfP4UZS99d5JAPEisA5y2/qonL2xF8lnptqvStmlPxNvFbyRVTEaxOpLjdyRng4H/cO6XmLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4R96vW7N; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b38f3e2919so2499622a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715351956; x=1715956756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKy0hWUxkHzFjSEjyTqN35P4DeSOXD6rseF0af2cPcA=;
        b=4R96vW7N54aIW9Yb0dziMr+i6W3KFdPC8+UVYhim7167BnmAT8iXdWsZJGvsH9mtNJ
         EyV0GQIC4gKMeOnZ3z9X2F3buOTQc7spaCR3a1UJraa7bl9fzrVO8XFy5Lsr+xYz49Vx
         AIVzHxtc1mbfBTzQeUsZWcyM73Sv+mBMyJ/w1bOASMF9n85UkIqed9ZxPzIMDJ856xwf
         XeirRXaz8MHj0wsIi00z6uJwRsuFFgwlW8adYCp+3d7RIQYgXlUVgPoVE24ZtPBL0e9F
         vLYpEvc4RLZ7aU9Crc0tWPDKoGSRi0+hmppRzQ/p5Uaqdff3Fg/oMMDKnKLFNoOjsZTS
         342w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351956; x=1715956756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKy0hWUxkHzFjSEjyTqN35P4DeSOXD6rseF0af2cPcA=;
        b=RzQJxCvlI5msN0N1jz6AAax18GFV7lvAsGytRaH2CxVRpYG+MrLKTJ1nX+LwFib/mw
         0FdzQPVwRYuRl51pffU2hVgIzLR2GGiwAKSgxpHO61HMtavbSMIg7FRQtlpJ01Ex0vyn
         LCa9sQ2bp3b8U+wFSPIIrjJsbaalIyihU6l6GBnkxBkooBCqURfscjrq1yb8DVq7CEor
         CXtI+az6Dxr9cDGE7PSvHRxxNgPxxYGwUi+0CeNiTrPxiBsrrnX3c0e5EcFpO3gpMjrU
         3QqL+clAkcVc+JsNE/N5pHc6SZiCD8DqQKyontkPKR2N7igfJC13Pa3XadrSjiLMSnT8
         Ujcg==
X-Forwarded-Encrypted: i=1; AJvYcCXED+TW/UeyiedeuLALkhCQ/jfuZk2IEQy7Uxjn7AXZ8AbVCOxBxAg8Rgw7W7zVkINxpoGNQAZS3VtPnHpUCq0p671MfppnsyfOLYvU
X-Gm-Message-State: AOJu0Yw14SIE9K0wYc2pUoGndKec3ZNQuK2Jp1IDEnnob0FKUwz7kxbd
	KHyzOS2gwbUUsDg9EeHtZqIeuo8uKNHe1hnuEIchrJmvfAGhbYX+Xkc22tySe6CUi+m9zXb1rdH
	jWg==
X-Google-Smtp-Source: AGHT+IGZeVKNIE9bJ4O0rd5TeJRSNjyTsYan7QSvYjPkqaIu/3O25cixtXLnzCOJSyWTprQTMx7K6kjXyfo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:30c5:b0:2b2:1919:dda4 with SMTP id
 98e67ed59e1d1-2b6c75cf00amr30981a91.4.1715351955569; Fri, 10 May 2024
 07:39:15 -0700 (PDT)
Date: Fri, 10 May 2024 07:39:14 -0700
In-Reply-To: <Zj3ksShWaFSWstii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509090146.146153-1-leitao@debian.org> <Zjz9CLAIxRXlWe0F@google.com>
 <Zj3ksShWaFSWstii@gmail.com>
Message-ID: <Zj4xkoMZh8zJdKyq@google.com>
Subject: Re: [PATCH] KVM: Addressing a possible race in kvm_vcpu_on_spin:
From: Sean Christopherson <seanjc@google.com>
To: Breno Leitao <leitao@debian.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, rbc@meta.com, paulmck@kernel.org, 
	"open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 10, 2024, Breno Leitao wrote:
> > IMO, reworking it to be like this is more straightforward:
> > 
> > 	int nr_vcpus, start, i, idx, yielded;
> > 	struct kvm *kvm = me->kvm;
> > 	struct kvm_vcpu *vcpu;
> > 	int try = 3;
> > 
> > 	nr_vcpus = atomic_read(&kvm->online_vcpus);
> > 	if (nr_vcpus < 2)
> > 		return;
> > 
> > 	/* Pairs with the smp_wmb() in kvm_vm_ioctl_create_vcpu(). */
> > 	smp_rmb();
> 
> Why do you need this now? Isn't the RCU read lock in xa_load() enough?

No.  RCU read lock doesn't suffice, because on kernels without PREEMPT_COUNT
rcu_read_lock() may be a literal nop.  There may be a _compiler_ barrier, but
smp_rmb() requires more than a compiler barrier on many architectures.

And just as importantly, KVM shouldn't be relying on the inner details of other
code without a hard guarantee of that behavior.  E.g. KVM does rely on
srcu_read_unlock() to provide a full memory barrier, but KVM does so through an
"official" API, smp_mb__after_srcu_read_unlock().

> > 	kvm_vcpu_set_in_spin_loop(me, true);
> > 
> > 	start = READ_ONCE(kvm->last_boosted_vcpu) + 1;
> > 	for (i = 0; i < nr_vcpus; i++) {
> 
> Why do you need to started at the last boosted vcpu? I.e, why not
> starting at 0 and skipping me->vcpu_idx and kvm->last_boosted_vcpu?

To provide round-robin style yielding in order to (hopefully) yield to the vCPU
that is holding a spinlock (or some other asset that is causing a vCPU to spin
in kernel mode).

E.g. if there are 4 vCPUs all running on a single CPU, vCPU3 gets preempted while
holding a spinlock, and all vCPUs are contented for said spinlock then starting
at vCPU0 every time would result in vCPU1 yielding to vCPU0, and vCPU0 yielding
back to vCPU1, indefinitely.

Starting at the last boosted vCPU instead results in vCPU0 yielding to vCPU1,
vCPU1 yielding to vCPU2, and vCPU2 yielding to vCPU3, thus getting back to the
vCPU that holds the spinlock soon-ish.

I'm sure more sophisticated/performant approaches are possible, but they would
likely be more complex, require persistent state (a.k.a. memory usage), and/or
need knowledge of the workload being run.

