Return-Path: <linux-kernel+bounces-244878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0593292AAC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5564928147F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651A14A08D;
	Mon,  8 Jul 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NbJ7Sjr"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D738FA5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471986; cv=none; b=T6botU094lYASvGIW1EkztjaiC8SZhkuzMUs8UHPqMwNnXsrafSzWd+6iT3Cfhukgsxb6haMucq9m43LSyXcaQ/j8bWBnMEElVcwAzlDidtwiNCt8dhGJ4aM4A4QPCkr5O2/GOZiFqNNn7OgM7IPArP/S1GOYNbpts22gxaF3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471986; c=relaxed/simple;
	bh=w1eGUfmQukYrQ1cZQTzQcmd1BC6BzYFQ+hgv8a6ff2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GHHjgYC6dGO/OJErG5dt6Bcx5yaPOWLjojWvXbddNCnhUEQRmSo52eed/q5ssaWoaXzyyjyV4K0VaU+xAA2ZEEKYoBRygu51JkI426sz3b0OaCkerm7t2rJrGeIPnikwlWAFaZEen+8bh3pNy6nd/dX/fIA99LdpZ/MJARTizzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NbJ7Sjr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fb20902842so19652295ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720471985; x=1721076785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aWSLYXxu+J9SS0caWJhnx/Ez21q/MXAxgdHC6l0lFnE=;
        b=1NbJ7SjrzeiVh8byFBEuzjH9V82gqhTkuulKakKaOZeXUEkVBI0T6/LmleEslIut31
         V86F3JFduMK8A2nXoGk9fQqs/CaRILebpDlOyL3lbse2mRC9NU/IhSg1S200fsUOzMaX
         YodceaXNi5Y7WIuiGRN619Z6aZBbXPUr7qTgFHG6+S+1Xe3L5LpO7kEaJQ+8/thmn7YA
         Z8zrgifzlwPWAU73ZNJOqHi8iwKieMpvDhCEil8j5Cd9IJRdLgDdsSsDu4fRpDtmurhM
         WArSB0Nys/ysTdFWFszWbsYowLR1hkNx81zj/+RiyHoYK/U4OJsnWL5LlDlrJyjKaEEQ
         Miqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720471985; x=1721076785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWSLYXxu+J9SS0caWJhnx/Ez21q/MXAxgdHC6l0lFnE=;
        b=PSGvUZKIoClAEk4dN+M9D1n2oRVZd4jy+7xPdo5Xluo6A9hPFn221VpTRgmJFcb7Y8
         zFHnihfiV+a12tb4DhvzzVjZRt2xBapq4Ad62n67JZmaku/wiNdqJaNao+xdTEkSqq15
         DdEsUzU3bl8F28I4Q7cVpjNCBa7G0RoThctvPMLlpvYYVC1lQ4l2yrzGFFIkFCIZEwKO
         ZrZX2H7V2rG4ijh8UDwqt9IFf6RMGMzlKNhOrZWLXOWL9woqMRstdfQDiT0WqXK/aMCn
         I8pQ+t/LrQsPvREd9/mZGz0E78HCCzphK+4pFWYClfyQ0K7v1ftMWwJgR0SGSTageXII
         v7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUxbi6f5z5UCD5sdnk/Js9jTYpwZu+yYuirFBjW4PobImo/g/xrBoGv3gxBsctZdhTZ3TYxk+i8qR/lRg91DVBEON2aCHsF8Ctf42WX
X-Gm-Message-State: AOJu0YzjtSI0gVvNzlT4KYXkrj+wSqGuo/kLBts8+7Yi/4jLOLncYyVd
	mwqDUElJPykT/VBTSSFUwvKwKSWJFz2hblvKnXRK2bzR2J7I8pQhp7Jo1ipsHRrWvV3klQo0RTh
	UjA==
X-Google-Smtp-Source: AGHT+IFBEPudpxzXPGD3b7GHY/rlOfg3GHBadGfCs8OKmROTsv++oDFCm4MUUoarwdiwvag8YzR3rF++haQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f546:b0:1fa:2b89:f550 with SMTP id
 d9443c01a7336-1fbb6d0f6a5mr629255ad.1.1720471984746; Mon, 08 Jul 2024
 13:53:04 -0700 (PDT)
Date: Mon, 8 Jul 2024 13:53:03 -0700
In-Reply-To: <2a4052ba67970ce41e79deb0a0931bb54e2c2a86.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-20-seanjc@google.com>
 <2a4052ba67970ce41e79deb0a0931bb54e2c2a86.camel@redhat.com>
Message-ID: <ZoxRr9P85f03w0vk@google.com>
Subject: Re: [PATCH v2 19/49] KVM: x86: Add a macro to init CPUID features
 that ignore host kernel support
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > Add a macro for use in kvm_set_cpu_caps() to automagically initialize
> > features that KVM wants to support based solely on the CPU's capabilities,
> > e.g. KVM advertises LA57 support if it's available in hardware, even if
> > the host kernel isn't utilizing 57-bit virtual addresses.
> > 
> > Take advantage of the fact that kvm_cpu_cap_mask() adjusts kvm_cpu_caps
> > based on raw CPUID, i.e. will clear features bits that aren't supported in
> > hardware, and simply force-set the capability before applying the mask.
> > 
> > Abusing kvm_cpu_cap_set() is a borderline evil shenanigan, but doing so
> > avoid extra CPUID lookups, and a future commit will harden the entire
> > family of *F() macros to assert (at compile time) that every feature being
> > allowed is part of the capability word being processed, i.e. using a macro
> > will bring more advantages in the future.
> 
> Could you explain what do you mean by "extra CPUID lookups"?

cpuid_ecx(7) incurs a CPUID to read the raw info, on top of the CPUID that is
executed by kvm_cpu_cap_init() (kvm_cpu_cap_mask() as of this patch).  Obviously
not a big deal, but it's an extra VM-Exit when running as a VM.

> > +/*
> > + * Raw Feature - For features that KVM supports based purely on raw host CPUID,
> > + * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
> > + * Simply force set the feature in KVM's capabilities, raw CPUID support will
> > + * be factored in by kvm_cpu_cap_mask().
> > + */
> > +#define RAW_F(name)						\
> > +({								\
> > +	kvm_cpu_cap_set(X86_FEATURE_##name);			\
> > +	F(name);						\
> > +})
> > +
> >  /*
> >   * Magic value used by KVM when querying userspace-provided CPUID entries and
> >   * doesn't care about the CPIUD index because the index of the function in
> > @@ -682,15 +694,12 @@ void kvm_set_cpu_caps(void)
> >  		F(AVX512VL));
> >  
> >  	kvm_cpu_cap_mask(CPUID_7_ECX,
> > -		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ | F(RDPID) |
> > +		F(AVX512VBMI) | RAW_F(LA57) | F(PKU) | 0 /*OSPKE*/ | F(RDPID) |
> >  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
> >  		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
> >  		F(CLDEMOTE) | F(MOVDIRI) | F(MOVDIR64B) | 0 /*WAITPKG*/ |
> >  		F(SGX_LC) | F(BUS_LOCK_DETECT)
> >  	);
> > -	/* Set LA57 based on hardware capability. */
> > -	if (cpuid_ecx(7) & F(LA57))
> > -		kvm_cpu_cap_set(X86_FEATURE_LA57);
> >  
> >  	/*
> >  	 * PKU not yet implemented for shadow paging and requires OSPKE
> 
> Putting a function call into a macro which evaluates into a bitmask is
> somewhat misleading, but let it be...
> 
> IMHO in long term, it might be better to rip the whole huge 'or'ed mess, and replace
> it with a list of statements, along with comments for all unusual cases.

As in something like this?

	kvm_cpu_cap_init(AVX512VBMI);
	kvm_cpu_cap_init_raw(LA57);
	kvm_cpu_cap_init(PKU);
	...
	kvm_cpu_cap_init(BUS_LOCK_DETECT);

	kvm_cpu_cap_init_aliased(CPUID_8000_0001_EDX, FPU);

	...

	kvm_cpu_cap_init_scattered(CPUID_12_EAX, SGX1);
	kvm_cpu_cap_init_scattered(CPUID_12_EAX, SGX2);
	kvm_cpu_cap_init_scattered(CPUID_12_EAX, SGX_EDECCSSA);

The tricky parts are incorporating raw CPUID into the masking and handling features
that KVM _doesn't_ support.  For raw CPUID, we could simply do CPUID every time, or
pre-fill an array to avoid hundreds of CPUIDs that are largely redudant.

But I don't see a way to mask off unsupported features without losing the
compile-time protections that the current code provides.  And even if we took a
big hammer approach, e.g. finalized masking for all words at the very end, we'd
still need to carry state across each statement, i.e. we'd still need the bitwise-OR
and mask  behavior, it would just be buried in helpers/macros.

I suspect the generated code will be larger, but I doubt that will actually be
problematic.  The written code will also be more verbose (roughly 4x since we
tend to squeeze 4 features per line), and it will be harder to ensure initialization
of features in a given word are all co-located.

I definitely don't hate the idea, but I don't think it will be a clear "win" either.
Unless someone feels strongly about pursuing this approach, I'll add to the "things
to explore later" list.

