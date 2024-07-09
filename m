Return-Path: <linux-kernel+bounces-246686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5503192C532
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7825D1C220E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C72185636;
	Tue,  9 Jul 2024 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uyn00xCn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2418560A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559610; cv=none; b=VCBuJkSAw8nskNXvAmwrPB0a+UWXOT5tFGnocAtm9BMzxOXLuJAfMLIFQdn+fUJ9lVeJ3q57uHCGQCIQzvKAASYlEvAaC4KpwHrpQlMcaBVEj+D7O3ahE/NE17ly5UvSodRbs5h4x13vViC6gq5vtOJXunB3lOGGbLbHfDgQS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559610; c=relaxed/simple;
	bh=98IxAdYgPX6Jr7PqsYEbwqKCv63rJ4BlitWPOe1SC+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gr1a1Gfj/j+Y1i8YvncfA1YPES6O7yynsDU4pTITwrj/q34HuTwp8fPWYx8rDjoZyfyyP+typ+dozDOsdsAGzL2vfm4sfOFHMW8oBDdVmwm9rizSJnWdZ8etOd8ogunMcfe1t3o5XHVleLSsZI1EV7tyzbxOvPYxHydMxrz6tuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uyn00xCn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fb3b398923so27168265ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720559607; x=1721164407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCxN1kpEpfZBxXrWADMXs6tBNh2vmqe3cjWxxQw4q0s=;
        b=Uyn00xCnBc5tFPYF4Eq/dhRasknkx+J+ZesjrqVSj3x2SamgDLTpqYYKUR4+NjEWU6
         9pJIuhowhPF2CenRuZgPlJ4qhQB8YSrlmPIW3nBjk96QVydeyXw4wg+fnBHIgqk5pdAx
         HkMVTChDYfDfMFSyzYO4Y0ZMJx5u7LQ7kQKcjz2tHsRE/UCzuuEmIzj+q68fEoUD2kAr
         QbXpL+O/KoopoBuTj493V6Yhejj2BksQ8dvq/VO3FIQLmu8VB7vO5HOVAwsjZWgdWoEO
         z0CS7gRw8UtCc1pMCAFex1uU9sywuIboLGd5IBXWrOYMaGdPllzxPPeHSheinXpO43kN
         kjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559607; x=1721164407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCxN1kpEpfZBxXrWADMXs6tBNh2vmqe3cjWxxQw4q0s=;
        b=AphfOGt/sMYqh1iFGTpUCmaxnHCmObx0TnPIAct1KX65F+CM+x1XPIJeZJSKlhnMly
         7IGpVkJUzUJPXgfuoHYN3zxeJHW1IOT+Ckhq0ayE7orxB67g6CIeQPxTVvS38kr7tw9R
         pVoyfO2jR1A+vvHmjc1J/NArP07t3CfJgbQU+lQFprAlVTZwUPjadgPNvWMGvQbEdbZB
         UMXiQwA+X4oWGRqr5yS+Y9c91b+3xiKIlmB9DR4d/CMoGT5RiE5nOuxqqTFBGBgUlQNW
         gyqPu8BmwWertDYjcP3aORURUW7jfsdC5Pq1XEwgc1dDKjR2DGRg7+KfZtuZ3Lye1QEg
         WB5g==
X-Forwarded-Encrypted: i=1; AJvYcCWOhowFEHq1Ao4vBqDVzr7HhRjTfbJCDlTJHPhqDXv9Vpsd7V2RSG6L3H6ZfBmhWJHsopKzKlVJX3g5WgdgXY/X5o9kHLZqXUJvz3VY
X-Gm-Message-State: AOJu0YxfGugqBCz8xqJegshb6HZqNtOPUhIMvGUgaV4+6qek8laNfSft
	rD82zovBJTLqT4rfUr/YhyOE0vlZzPrKG1HQmZ7S/ozkv+TIa4zHEcpl7mMo0X7zWY8PseDzDAx
	rFg==
X-Google-Smtp-Source: AGHT+IFdpjpN1wc3n2M16K74/2OQji70yWBUTcMFGct039d5tw8NoKCuSyI82ExR1eT0aXZIgG4bWhKW/n0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec8b:b0:1f9:8f8d:cc58 with SMTP id
 d9443c01a7336-1fbb6d8a001mr1469105ad.12.1720559606905; Tue, 09 Jul 2024
 14:13:26 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:13:25 -0700
In-Reply-To: <16658367af25852e4bb6abb0caf7c3bc58538db0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-49-seanjc@google.com>
 <16658367af25852e4bb6abb0caf7c3bc58538db0.camel@redhat.com>
Message-ID: <Zo2n9VQ3nBuf1d3F@google.com>
Subject: Re: [PATCH v2 48/49] KVM: x86: Add a macro for features that are
 synthesized into boot_cpu_data
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > Add yet another CPUID macro, this time for features that the host kernel
> > synthesizes into boot_cpu_data, i.e. that the kernel force sets even in
> > situations where the feature isn't reported by CPUID.  Thanks to the
> > macro shenanigans of kvm_cpu_cap_init(), such features can now be handled
> > in the core CPUID framework, i.e. don't need to be handled out-of-band and
> > thus without as many guardrails.
> > 
> > Adding a dedicated macro also helps document what's going on, e.g. the
> > calls to kvm_cpu_cap_check_and_set() are very confusing unless the reader
> > knows exactly how kvm_cpu_cap_init() generates kvm_cpu_caps (and even
> > then, it's far from obvious).
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---

...

> Now that you added the final F_* macro, let's list all of them:
> 
> #define F(name)							\
> 
> /* Scattered Flag - For features that are scattered by cpufeatures.h. */
> #define SF(name)						\
> 
> /* Features that KVM supports only on 64-bit kernels. */
> #define X86_64_F(name)						\
> 
> /*
>  * Raw Feature - For features that KVM supports based purely on raw host CPUID,
>  * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
>  * Simply force set the feature in KVM's capabilities, raw CPUID support will
>  * be factored in by __kvm_cpu_cap_mask().
>  */
> #define RAW_F(name)						\
> 
> /*
>  * Emulated Feature - For features that KVM emulates in software irrespective
>  * of host CPU/kernel support.
>  */
> #define EMUL_F(name)						\
> 
> /*
>  * Synthesized Feature - For features that are synthesized into boot_cpu_data,
>  * i.e. may not be present in the raw CPUID, but can still be advertised to
>  * userspace.  Primarily used for mitigation related feature flags.
>  */
> #define SYN_F(name)						\
> 
> /*
>  * Aliased Features - For features in 0x8000_0001.EDX that are duplicates of
>  * identical 0x1.EDX features, and thus are aliased from 0x1 to 0x8000_0001.
>  */
> #define AF(name)								\
> 
> /*
>  * VMM Features - For features that KVM "supports" in some capacity, i.e. that
>  * KVM may query, but that are never advertised to userspace.  E.g. KVM allows
>  * userspace to enumerate MONITOR+MWAIT support to the guest, but the MWAIT
>  * feature flag is never advertised to userspace because MONITOR+MWAIT aren't
>  * virtualized by hardware, can't be faithfully emulated in software (KVM
>  * emulates them as NOPs), and allowing the guest to execute them natively
>  * requires enabling a per-VM capability.
>  */
> #define VMM_F(name)								\
> 
> 
> Honestly, I already somewhat lost in what each of those macros means even
> when reading the comments, which might indicate that a future reader might
> also have a hard time understanding those.
> 
> I now support even more the case of setting each feature bit in a separate
> statement as I explained in an earlier patch.
> 
> What do you think?

I completely agree that there are an absurd number of flavors of features, but
I don't see how using separate statement eliminates any of that complexity.  The
complexity comes from the fact that KVM actually has that many different ways and
combinations for advertising and enumerating CPUID-based features.

Ignoring for the moment that "vmm" and "aliased" could be avoided for any approach,
if we go with statements, we'll still have

  kvm_cpu_cap_init{,passthrough,emulated,synthesized,aliased,vmm,only64}()

or if the flavor is an input/enum,

  enum kvm_cpuid_feature_type {
  	NORMAL,
	PASSTHROUGH,
	EMULATED,
	SYNTHESIZED,
	ALIASED,
	VMM,
	ONLY_64,
  }

I.e. we'll still need the same functionality and comments, it would simply be
dressed up differently.

If the underlying concern is that the macro names are too terse, and/or getting
one feature per line is desirable, then I'm definitely open to exploring alternative
formatting options.  But that's largely orthogonal to using macros instead of
individual function calls.

