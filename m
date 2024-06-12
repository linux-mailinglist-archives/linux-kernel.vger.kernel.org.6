Return-Path: <linux-kernel+bounces-212257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1887905D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BAE1F210D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E683884FCC;
	Wed, 12 Jun 2024 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bW+jOPvr"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008312D753
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226181; cv=none; b=Fn6Z2zYUd2Pv78amAWmnvzcoXsDyP9OQnFYi/YISbtyjA9+2QOiFsWhzdCA8UXbga0SfJzLFP5KHyrV8ShrjTmFhMQFfmXyqqFb0FG2jWdaDtWJvNclIXhTevFflA3rlFhDml40V8WjjGtlKdH8+qR3t7LnXk+woIY21GAUaO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226181; c=relaxed/simple;
	bh=1TYIkyImVcWQGBXXHpL6wbMEynsMIkTMy8d3F8mZSP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f2aO5NMrcRBuuJBdrYKqz4XVOg8b5gPQ/gW3Vf48lz30B5hDd92+ooRGXIaO/zoZyw76nXO9rscRatKmeJv5G7vesMt1idncbeL2OkwuDFL0wppoBwwydGaOv4ZSKNnaRZYoDZkL4SQs2W3H5jo5LXR6Vy2XBYTMNsoD/3wiG3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bW+jOPvr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c2d6e09e62so182989a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718226179; x=1718830979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3xgWRxCgfKePUIQRk1/bOVRKkSjNiVa6+ku2rMooqI=;
        b=bW+jOPvrXWc2sN7IGlpVQaq8Zx9w7YW/aPk2UtDiT5Ev/7RR4PBWThSAVJj2YUDWRc
         DzZPTEKxCvRVYPLZhpe3TtAKgdcGC/+/RHJzfhYp+pGRQpTghRtTT2JI8UaX1Sd76jLV
         vr/A8JrJkoMVkydXTRobtq8LpBQAdfymeE6FfSXk3PszR5JUMX+vyYxe1CDeZIuZ48bs
         LDauAl6Lh25UP03oml8RjZFoEpfLnxRNBjTscaAZmDGCu2M6+7GL6c+vDyl34WHNY/lB
         5OWD3pd0J/Tt+xyWyh+m2PSJr4I4h69C5Q+hTk+rr69c0qnSUiF/Uoh18pmMixeO0aF0
         43ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226179; x=1718830979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3xgWRxCgfKePUIQRk1/bOVRKkSjNiVa6+ku2rMooqI=;
        b=bfUrwpIf5Yh77owVuFma94QYycH5O2svHaUo895v2dRz2Ais77uzWml8C8xOrzhj7H
         f+wTlwl6ZXZkUHtdbpSFnyhFOkRZKpZpHNVdY89AztJWTYDSdWa1RJoUZ4Z8T3XEta33
         5AR4Gv008o70Ec3uZb0hV3ERCuTwuGg9rUgMrfSM9bu+YjYUd06tduKeXWhJwT1SdY8W
         AsIV1+YVxDSiUW6YGQnmM3Vrw+9E7xZVn6FJ3zrOKnApExgu3CRmCvQg/oJ3sOKIii48
         HrK3zUypMg5BQ538B7GuNhPPINZBt+X1VEuxnlO73xYq1WzDsIWLrfGDcShLda+XIGpn
         2FQw==
X-Forwarded-Encrypted: i=1; AJvYcCUKoi02NlXEfJyvUQrVLTP0e1Jd5ias7Tei6qPwFHcc4m+ZSSQfP8WK78zjACO8VATjUaWAf/N+reV7HDpzh9JLcL3sMw3RcjZDEJJl
X-Gm-Message-State: AOJu0YzVJcNXxowbGIeirsj/RbCM8I4jLQ01YF6StKobYMJCgG2jwsy1
	fg/rHP1qM4srN7jJdKT1zTYT1pbGts11IVfRqpDfFlBo9uVq1dRzUr2KDbmBzJCurpAhse5fgT7
	9Yw==
X-Google-Smtp-Source: AGHT+IHtBONcZJ3ua6rr9KF0YTE06FmHu2WTAWj/KJP5w7j/Ttnoq6SE0bp0Q5inkEDQ0elbifO9mus7g/Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:62c9:b0:2c2:c65f:52dc with SMTP id
 98e67ed59e1d1-2c4a770e8f6mr8383a91.6.1718226179078; Wed, 12 Jun 2024 14:02:59
 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:02:57 -0700
In-Reply-To: <d5a6e125-bff4-4d82-ae65-b99d9cb10e90@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419085927.3648704-1-pbonzini@redhat.com> <20240419085927.3648704-6-pbonzini@redhat.com>
 <d5a6e125-bff4-4d82-ae65-b99d9cb10e90@intel.com>
Message-ID: <ZmoNAQmwIH5tigyv@google.com>
Subject: Re: [PATCH 5/6] KVM: x86: Implement kvm_arch_vcpu_pre_fault_memory()
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, binbin.wu@linux.intel.com, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 22, 2024, Xiaoyao Li wrote:
> On 4/19/2024 4:59 PM, Paolo Bonzini wrote:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 10e90788b263..a045b23964c0 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4647,6 +4647,78 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >   	return direct_page_fault(vcpu, fault);
> >   }
> > +static int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code,
> > +		     u8 *level)

Align parameters:

static int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code,
			    u8 *level)

> > +{
> > +	int r;
> > +
> > +	/* Restrict to TDP page fault. */

This is fairly obvious from the code, what might not be obvious is _why_.  I'm
also ok dropping the comment entirely, but it's easy enough to provide a hint to
the reader.

> > +	if (vcpu->arch.mmu->page_fault != kvm_tdp_page_fault)
> > +		return -EOPNOTSUPP;
> > +
> > +retry:
> > +	r = __kvm_mmu_do_page_fault(vcpu, gpa, error_code, true, NULL, level);
> > +	if (r < 0)
> > +		return r;
> > +
> > +	switch (r) {
> > +	case RET_PF_RETRY:
> > +		if (signal_pending(current))
> > +			return -EINTR;
> > +		cond_resched();
> > +		goto retry;

Rather than a goto+retry from inside a switch statement, what about:

	int r;

	/* 
	 * Pre-faulting a GPA is supported only non-nested TDP, as indirect
	 * MMUs map either GVAs or L2 GPAs, not L1 GPAs.
	 */
	if (vcpu->arch.mmu->page_fault != kvm_tdp_page_fault)
		return -EOPNOTSUPP;

	do {
		if (signal_pending(current))
			return -EINTR;

		cond_resched();

		r = kvm_mmu_do_page_fault(vcpu, gpa, error_code, true, NULL, level);
	} while (r == RET_PF_RETRY);

	switch (r) {
	case RET_PF_FIXED:
	case RET_PF_SPURIOUS:
		break;

	case RET_PF_EMULATE:
		return -ENOENT;

	case RET_PF_CONTINUE:
	case RET_PF_INVALID:
	case RET_PF_RETRY:
	default:
		WARN_ON_ONCE(r >= 0);
		return -EIO;
	}

	return 0;

