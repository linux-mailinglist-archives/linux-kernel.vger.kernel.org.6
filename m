Return-Path: <linux-kernel+bounces-277103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B035A949C88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116D8B22A23
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A298176FB6;
	Wed,  7 Aug 2024 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZuOINgP"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B72176FA1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722988809; cv=none; b=RmOFMF0BPJDrU4JsXwG7yvLta3XubSJk1ZkP2DfqcUwo06Ty7nPqI1rL5iUvjVUKNYnXkoQ5fIqv4cwTRR/tBbNxuRCg5hBeXYahmNdj+QT2vempdo8+rgtTQmI/9WTY2AZM8AC7Svj9mX/Feea/AeKtqyWHqmRVo0wlzfwHsnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722988809; c=relaxed/simple;
	bh=UHgIWVKvGfmyugfK+5SUX8pCsbKk968BZK+Jt1c65xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uo5tiK35aGJPk9sOHN9T8KhaCd+KezSbQdl3CqB281IHi0WdXfka7T8UloNOAVNAbvr7HchhYo7EYdhXx434OPxoQLt48rJw44nbu/w45IntS4zUqDXvocoh9gxn5X1V+54iU2oTSh4SMi02Pxsc7qUOEcb2AmWDpnE25ge1SlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZuOINgP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a3c6dd559aso994416a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 17:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722988806; x=1723593606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q2NRiav7MDRT7LLYySbofxe/7oFalUeoZKG+LR63fQ=;
        b=tZuOINgPZnMdi9v4GMYmHna5biCt5cMm8nKMJNgu8dr0hnRqfRyXSDSDAjOsJ11mGB
         jhcMMGJu9e61LPnCr4weFK89Jk+J02KL1AUaoi/DRRzpUIwC4IPs6nfZrgZjBQoVVb4p
         hBoMBNnae0JkFsueJqhwtLkhj/TuajQz76u4qFRwgsH3HFyF+nbMU+w/BtBYgjhfYXdK
         ss/o/ohOA2wPWuhymFk4sGIw/0IzXlUEmaG/da77jmeBrTF+5KjiwXmVyqq5PGLogzLo
         ovnCxPGxREByI0fwRe5FiLGLUNfM+Uo9ZUfi+Vf3/T8UPGacrTH7b4XsqQirmNdoa7Jt
         fm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722988806; x=1723593606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q2NRiav7MDRT7LLYySbofxe/7oFalUeoZKG+LR63fQ=;
        b=ECc4oS7FT4Q0L/tXOX++0nJ0z1em8CVWNFxDq7AJG0drryfwNFOCTVR5fGko9nKLkK
         5ML7WPle+gHrIOc4N2aPsk50RkQxnxyPOgcqJAS5SVUKn3PW9bgTLj0JhW1qk6LK5dnc
         7lT/dnZILYF7XE/Eb6Zh8OntGzKxswOhHJW3f1/dUdKVxaPTTIXzUyb0ic42ETeJjmFq
         spdR71CCnLQyGrLowcbOz9dr3+Q/PjEMIViXV2HAGiBpHkvwol0dw3iZ8pmbqpWfxuGS
         gQxjocv8rz1bHV/CIPuFf4QC0m6vSjxFrpE0r411vdWUAeBZ6yU4KRGn5PxC2iOOglHN
         EC0g==
X-Forwarded-Encrypted: i=1; AJvYcCVXFFS74ucLn/zT9bnv4lQlwt4Ty0EfiGcXPxpKjz3yTvFHKHQcRFL8NjpiAKB8SPs4CMNz2vlaEfRSiSh2KttBiAKnGIdHv9E4+7Z7
X-Gm-Message-State: AOJu0Yy/wrE4YewbM7qJPdFpdlr7nYOxTryW0bB7zBBRwNBfmN6/gWIx
	FM//L8bZN83dsFTv0UBhNIYmLqWYL3sRGm8q4GizTYewBJBIUry1IAF2yFIUlxkSQo/MlCaWQ7P
	dSA==
X-Google-Smtp-Source: AGHT+IHvS0fM2LOTssx0eAi+ioCPUdUHmTfVhIBg5USnscLvdfSuqB0Ekxw+gGimmHjT/noSv8q+S+cCN3A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6904:0:b0:7a0:cd17:c701 with SMTP id
 41be03b00d2f7-7b74a9d0286mr33925a12.10.1722988805874; Tue, 06 Aug 2024
 17:00:05 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:59:03 -0700
In-Reply-To: <ZrKqrCnNpNQ_K_qi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802200136.329973-1-seanjc@google.com> <20240802200136.329973-3-seanjc@google.com>
 <ZrKqrCnNpNQ_K_qi@linux.dev>
Message-ID: <ZrK4x4LLz1wlwGQN@google.com>
Subject: Re: [PATCH 2/2] KVM: Protect vCPU's "last run PID" with rwlock, not RCU
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 06, 2024, Oliver Upton wrote:
> On Fri, Aug 02, 2024 at 01:01:36PM -0700, Sean Christopherson wrote:
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index a33f5996ca9f..7199cb014806 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -1115,7 +1115,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> >  void kvm_arm_halt_guest(struct kvm *kvm);
> >  void kvm_arm_resume_guest(struct kvm *kvm);
> >  
> > -#define vcpu_has_run_once(vcpu)	!!rcu_access_pointer((vcpu)->pid)
> > +#define vcpu_has_run_once(vcpu)	(!!READ_ONCE((vcpu)->pid))
> >  
> >  #ifndef __KVM_NVHE_HYPERVISOR__
> >  #define kvm_call_hyp_nvhe(f, ...)						\
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 689e8be873a7..d6f4e8b2b44c 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -342,7 +342,8 @@ struct kvm_vcpu {
> >  #ifndef __KVM_HAVE_ARCH_WQP
> >  	struct rcuwait wait;
> >  #endif
> > -	struct pid __rcu *pid;
> > +	struct pid *pid;
> > +	rwlock_t pid_lock;
> >  	int sigset_active;
> >  	sigset_t sigset;
> >  	unsigned int halt_poll_ns;
> 
> Adding yet another lock is never exciting, but this looks fine.

Heh, my feelings too.  Maybe that's why I didn't post this for two years.

> Can you nest this lock inside of the vcpu->mutex acquisition in
> kvm_vm_ioctl_create_vcpu() so lockdep gets the picture?

I don't think that's necessary.  Commit 42a90008f890 ("KVM: Ensure lockdep knows
about kvm->lock vs. vcpu->mutex ordering rule") added the lock+unlock in
kvm_vm_ioctl_create_vcpu() purely because actually taking vcpu->mutex inside
kvm->lock is rare, i.e. lockdep would be unable to detect issues except for very
specific VM types hitting very specific flows.

But for this lock, every arch is guaranteed to take the lock on the first KVM_RUN,
as "oldpid" is '0' and guaranteed to mismatch task_pid(current).  So I don't think
we go out of our way to alert lockdep.

> > @@ -4466,7 +4469,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >  		r = -EINVAL;
> >  		if (arg)
> >  			goto out;
> > -		oldpid = rcu_access_pointer(vcpu->pid);
> > +		oldpid = vcpu->pid;
> 
> It'd be good to add a comment here about how this is guarded by the
> vcpu->mutex, as Steve points out.

Roger that.

