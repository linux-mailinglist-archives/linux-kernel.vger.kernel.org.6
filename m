Return-Path: <linux-kernel+bounces-396915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D68C9BD42F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DE81F236D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5984F1E572C;
	Tue,  5 Nov 2024 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVxrRF8J"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A14D8D0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830223; cv=none; b=qTDLf9U8ZUVqg7Zb31hCF/+frviBJRQzeHfigdvg1oyeP+l7Jd4xKjuBUO7G9gWShrVsfL0l7q4eIN1bSdF/1Ur13MmYiPo4cxYqo3wEpocpildWXMDvElFeRXk2bSIuIyAbU+o/7u3vP8QX7ZZJtzWARulKjYz8yvQASmpCu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830223; c=relaxed/simple;
	bh=fz6xeFnmysicpSDpNhy8mDv8wbsXDHiThab+QK7p088=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HVUdAiDfUBd+dGCosoYyF46fX+BRg2trTXS0sHfcL8eXWAjp0QaKyel4H+yAZuJG+wzlc+t/AuPD7IU/eDOJ8z9WEpVMjGuRRUhVl+kzDxl86cCNTwScDzzBehhSS+Bd7ZlPkfpzf8sOICRbB41obJtOxQIJi76DdlVk6z97F+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVxrRF8J; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2eb765285so7333294a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 10:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730830222; x=1731435022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkEGd4+bukWRAG7FqtPkBnT4uJ2GJNJY6UkTabicd3E=;
        b=wVxrRF8JzyV56iMyNMJJku9fxJrpcXZAzw1ZzvnHmO8EYsSaVKV8vnFLruSCkQ5znH
         fqry5oVlIWawZw8WS9LfHP5pnONM/4//0TGsj8bFkSXUe6C6YcT3kti+VkvyvFNbZ8jP
         NhwDDm3nUpQHCLGf9xxMMI6ub8IYuD+EqoMP8r7O9ozERk6MhzFbYI6BRfp1KozGwTyq
         J9tC2gPpsLsCGaKLVWBXaDyfD3jH68euAdMx1hjS8gEdPpSf4/UJR/ZfzlQPvHekuSfx
         Oq9SxaWbBXliJv3oYo8tas54WFF8vDaZQZYyjF2LmZWmGPPqM3Jg1heGjNhy36waqoww
         AmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730830222; x=1731435022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkEGd4+bukWRAG7FqtPkBnT4uJ2GJNJY6UkTabicd3E=;
        b=TYz3ChD4X93KsN2v36hJ40gertKfT9JHAdLVAQkNuPV3cI5atj+pvIHfateBo5RceU
         NitmqTZCM6AiZL/2NsE6D+q3b1kQ4J/AV7MAYqmjpplG+W0GSY58jVRImM438WgGwq4D
         wDw1N2AWg0qESZtYOUR9JgCAejl9jvnGkMYsGKgqPYMs3FSslq4iES8Y44y4TpNMif+v
         wt7aQqhYfuYTD6dg123QNSZV6rhswCGb43HTS38TQ6M6w7NQhbfm5q9HlJyRs19RaGK5
         foiNR+BiZMQG21w+BShr6k6tjKdWBWrn4F12BIh4hi2i1+eFwnCUL45P8kh0uM+kJo/s
         HWZg==
X-Forwarded-Encrypted: i=1; AJvYcCVvvemAfexnRFsFv/1Z1uz+02rdPhSs/r0HzhgiC7lTYJSn1GvgJQxt4ktpXWGucYD5iIzbL/sR8ndDQWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDBJnAa0Gul+yH5EXUIuPbGlBqN7FXRasxgPBYfU7+GlGCaE0
	V2OMS/79D+aeauZ6BPeyvy7sQ4tomqPWlnF8JW134iKN0Mdo4EaYuCZt309SKMu9+Ge/0feR2wi
	52Q==
X-Google-Smtp-Source: AGHT+IFUTkbcBRXmscHo1q+zQgvZfi61AWn7KTfXysjzi6xAhC8CxkXctNHnMeSmNRFbvvBhxsiJcV0Leg8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1fce:b0:2e2:d434:8540 with SMTP id
 98e67ed59e1d1-2e94c532745mr50926a91.6.1730830221685; Tue, 05 Nov 2024
 10:10:21 -0800 (PST)
Date: Tue, 5 Nov 2024 10:10:20 -0800
In-Reply-To: <20241105123416.GBZyoQyAoUmZi9eMkk@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104101543.31885-1-bp@kernel.org> <ZyltcHfyCiIXTsHu@google.com>
 <20241105123416.GBZyoQyAoUmZi9eMkk@fat_crate.local>
Message-ID: <ZypfjFjk5XVL-Grv@google.com>
Subject: Re: [PATCH] x86/bugs: Adjust SRSO mitigation to new features
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, kvm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 05, 2024, Borislav Petkov wrote:
> On Mon, Nov 04, 2024 at 04:57:20PM -0800, Sean Christopherson wrote:
> > scripts/get_maintainer.pl :-)
> 
> That's what I used but I pruned the list.
> 
> Why, did I miss anyone?

All of the actual maintainers.  AFAIK, Paolo doesn't subscribe to kvm@.

> > But why do this in KVM?  E.g. why not set-and-forget in init_amd_zen4()?
> 
> Because there's no need to impose an unnecessary - albeit small - perf impact
> on users who don't do virt.
> 
> I'm currently gravitating towards the MSR toggling thing, i.e., only when the
> VMs number goes 0=>1 but I'm not sure. If udev rules *always* load kvm.ko then
> yes, the toggling thing sounds better. I.e., set it only when really needed.
> 
> > Shouldn't these be two separate patches?  AFAICT, while the two are related,
> > there are no strict dependencies between SRSO_USER_KERNEL_NO and
> > SRSO_MSR_FIX.
> 
> Meh, I can split them if you really want me to.

I do.

> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 9df3e1e5ae81..03f29912a638 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -608,6 +608,9 @@ static void svm_disable_virtualization_cpu(void)
> > >  	kvm_cpu_svm_disable();
> > >  
> > >  	amd_pmu_disable_virt();
> > > +
> > > +	if (cpu_feature_enabled(X86_FEATURE_SRSO_MSR_FIX))
> > > +		msr_clear_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
> > 
> > I don't like assuming the state of hardware.  E.g. if MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT
> > was already set, then KVM shouldn't clear it.
> 
> Right, I don't see that happening tho. If we have to sync the toggling of this
> bit between different places, we'll have to do some dance but so far its only
> user is KVM.
> 
> > KVM's usual method of restoring host MSRs is to snapshot the MSR into
> > "struct kvm_host_values" on module load, and then restore from there as
> > needed.  But that assumes all CPUs have the same value, which might not be
> > the case here?
> 
> Yes, the default value is 0 out of reset and it should be set on each logical
> CPU whenever we run VMs on it. I'd love to make it part of the VMRUN microcode
> but... :-)
> 
> > All that said, I'd still prefer that MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT is set
> > during boot, unless there's a good reason not to do so.
> 
> Yeah, unnecessary penalty on machines not running virt.

What does the bit actually do?  I can't find any useful documentation, and the
changelog is equally useless.

