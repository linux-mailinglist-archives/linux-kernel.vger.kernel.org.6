Return-Path: <linux-kernel+bounces-323842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A07A97441D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CF428711A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754501AAE20;
	Tue, 10 Sep 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtbOw00c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466E1A7AE3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000634; cv=none; b=LX0E3d3/VNnj4AqcMBV9/sly6tEIiAA88JW+ELVNYfxfn/xdfixwoxhAAmvpi3EGIbko4k20ck481kkaz4J3RZykaqV2PoNDZAPAr7NVPtSAMNJq6H4revMcix/eJLaq/4BH1XPG4UQRXlabiMuy8aSK1yc6ZMl/jknB+iK2F3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000634; c=relaxed/simple;
	bh=aVHEeNzFOm4LF+kU6BEHYMwFBnWzH9T9ec3sbI1wGzw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=levyAB1HIFJXAHyE6fnlVqX13QyGmJ94RVg/bcJbPQ33xXNN5dsWYw3J1QK266RZeMI1qwoGGXVF074YD8gji8bucrR23Ffhs5sZ3PVzigs28ZC52WfS0yBc5fXGxAqdp/N9aF3zR9Dl4puSZ6Wn+5bmXYZaI9BN0YUC95V8jbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtbOw00c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726000627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9/XnTNN38MUq9u6fZgBkjo42UTNP+Y6Vu/qqdocpo0=;
	b=HtbOw00ch7WxozUKn1tFkSnq44dVPLF18hBIIwzPFeI/fm52FfWWIHyFBP1b+ggN2z+Aqh
	uiCki7H4HduWaw6e5Go1t9IrTTZ0OPlM0GRPs0CaQDcMttiILhZ9DaYu3dOBki2rqmdRQx
	JMNex6VoZqPP1GJ6o1lFVb/aiBMQCP4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-hIDpsbaUP1Gjmzc1S6dHCg-1; Tue, 10 Sep 2024 16:37:05 -0400
X-MC-Unique: hIDpsbaUP1Gjmzc1S6dHCg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c35b3a220aso4772836d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726000625; x=1726605425;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9/XnTNN38MUq9u6fZgBkjo42UTNP+Y6Vu/qqdocpo0=;
        b=qGsO01SBts4pqjdMPMnWquIVRu9MKnqPD1/hZT2/29rTjjzcgHlVozHTXrx3HWanyg
         er1TgQueSBEAc7t75IwTd4EDaE3fxqXih3cOhEGJ3mQ/sDgz71qJZ+lYTZlF/8bTCVtg
         NaOvmbkMk9mKItC7d3FQGOko+hm6LDnPgjnzbRN21E2Brj5z3S5o23o7r0GUUILBnrOB
         DmY3QoPBvniNjY2hqD390dmz5jIWIuGMa1XGIZrg5TkJVJwfgexZDzJczay2LAqRQwPV
         bd939lK0lvYR2T1f0RtOaZZ0EroBbgfR9zuDsNEcYq0X9hcK9pkKUEyOYzcsHKZLS8eK
         8AZw==
X-Forwarded-Encrypted: i=1; AJvYcCVX5k6AYgWdgH2F2GZSGNqLfJZBZ0E2Y7EutCJK6V+Z4ZsRPqndjZaCwERAgYw6taASLa6mEszuHEqEkFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+rQPw5L+WkAhFmYBqagYTzgmG8mGD8u/NoQtWASpRnJx/I2pA
	Z6rdCRq4OEEz9plfJo2Bym8YvLjcpFgit+Ls6TCJo3vrDZg8xZzhLPXvdAP2A5jsKMfkr4Yv+Ce
	+hX9XUEzuF3OTUb/CHtosC5UN9J22Ch/1zGJoDqxJQURzzVk+YJvZ6NzdR0DyTQ==
X-Received: by 2002:ad4:5dc6:0:b0:6c4:d2f9:644e with SMTP id 6a1803df08f44-6c554d43f77mr72921496d6.12.1726000624749;
        Tue, 10 Sep 2024 13:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrqSLKSPDJj3hMABilp0LfLhiMlrqFtNDvhizWXrMFBxm/Irv+MVixW3x//LDXGfBMevPJ6Q==
X-Received: by 2002:ad4:5dc6:0:b0:6c4:d2f9:644e with SMTP id 6a1803df08f44-6c554d43f77mr72920956d6.12.1726000624143;
        Tue, 10 Sep 2024 13:37:04 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5343397f7sm33307116d6.49.2024.09.10.13.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:37:03 -0700 (PDT)
Message-ID: <44e7f9cba483bda99f8ddc0a2ad41d69687e1dbe.camel@redhat.com>
Subject: Re: [PATCH v2 22/49] KVM: x86: Add a macro to precisely handle
 aliased 0x1.EDX CPUID features
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Tue, 10 Sep 2024 16:37:02 -0400
In-Reply-To: <ZrFLlxvUs86nqDqG@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-23-seanjc@google.com>
	 <43ef06aca700528d956c8f51101715df86f32a91.camel@redhat.com>
	 <ZoxVa55MIbAz-WnM@google.com>
	 <3da2be9507058a15578b5f736bc179dc3b5e970f.camel@redhat.com>
	 <ZqKb_JJlUED5JUHP@google.com>
	 <8f35b524cda53aff29a9389c79742fc14f77ec68.camel@redhat.com>
	 <ZrFLlxvUs86nqDqG@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-08-05 at 15:00 -0700, Sean Christopherson wrote:
> On Mon, Aug 05, 2024, mlevitsk@redhat.com wrote:
> > У чт, 2024-07-25 у 11:39 -0700, Sean Christopherson пише:
> > > > On Wed, Jul 24, 2024, Maxim Levitsky wrote:
> > > > > > On Mon, 2024-07-08 at 14:08 -0700, Sean Christopherson wrote:
> > > > > > > > On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > > > > > > > > > What if we defined the aliased features instead.
> > > > > > > > > > Something like this:
> > > > > > > > > > 
> > > > > > > > > > #define __X86_FEATURE_8000_0001_ALIAS(feature) \
> > > > > > > > > >         (feature + (CPUID_8000_0001_EDX - CPUID_1_EDX) * 32)
> > > > > > > > > > 
> > > > > > > > > > #define KVM_X86_FEATURE_FPU_ALIAS       __X86_FEATURE_8000_0001_ALIAS(KVM_X86_FEATURE_FPU)
> > > > > > > > > > #define KVM_X86_FEATURE_VME_ALIAS       __X86_FEATURE_8000_0001_ALIAS(KVM_X86_FEATURE_VME)
> > > > > > > > > > 
> > > > > > > > > > And then just use for example the 'F(FPU_ALIAS)' in the CPUID_8000_0001_EDX
> > > > > > > > 
> > > > > > > > At first glance, I really liked this idea, but after working through the
> > > > > > > > ramifications, I think I prefer "converting" the flag when passing it to
> > > > > > > > kvm_cpu_cap_init().  In-place conversion makes it all but impossible for KVM to
> > > > > > > > check the alias, e.g. via guest_cpu_cap_has(), especially since the AF() macro
> > > > > > > > doesn't set the bits in kvm_known_cpu_caps (if/when a non-hacky validation of
> > > > > > > > usage becomes reality).
> > > > > > 
> > > > > > Could you elaborate on this as well?
> > > > > > 
> > > > > > My suggestion was that we can just treat aliases as completely independent
> > > > > > and dummy features, say KVM_X86_FEATURE_FPU_ALIAS, and pass them as is to the
> > > > > > guest, which means that if an alias is present in host cpuid, it appears in
> > > > > > kvm caps, and thus qemu can then set it in guest cpuid.
> > > > > > 
> > > > > > I don't think that we need any special treatment for them if you look at it
> > > > > > this way.  If you don't agree, can you give me an example?
> > > > 
> > > > KVM doesn't honor the aliases beyond telling userspace they can be set (see below
> > > > for all the aliased features that KVM _should_ be checking).  The APM clearly
> > > > states that the features are the same as their CPUID.0x1 counterparts, but Intel
> > > > CPUs don't support the aliases.  So, as you also note below, I think we could
> > > > unequivocally say that enumerating the aliases but not the "real" features is a
> > > > bogus CPUID model, but we can't say the opposite, i.e. the real features can
> > > > exists without the aliases.
> > > > 
> > > > And that means that KVM must never query the aliases, e.g. should never do
> > > > guest_cpu_cap_has(KVM_X86_FEATURE_FPU_ALIAS), because the result is essentially
> > > > meaningless.  It's a small thing, but if KVM_X86_FEATURE_FPU_ALIAS simply doesn't
> > > > exist, i.e. we do in-place conversion, then it's impossible to feed the aliases
> > > > into things like guest_cpu_cap_has().
> > 
> > This only makes my case stronger - treating the aliases as just features will
> > allow us to avoid adding more logic to code which is already too complex IMHO.
> > 
> > If your concern is that features could be queried by guest_cpu_cap_has()
> > that is easy to fix, we can (and should) put them into a separate file and
> > #include them only in cpuid.c.
> > 
> > We can even #undef the __X86_FEATURE_8000_0001_ALIAS macro after the kvm_set_cpu_caps,
> > then if I understand the macro pre-processor correctly, any use of feature alias
> > macros will not fully evaluate and cause a compile error.
> 
> I don't see how that's less code.  Either way, KVM needs a macro to handle aliases,
> e.g. either we end up with ALIAS_F() or __X86_FEATURE_8000_0001_ALIAS().  For the
> macros themselves, IMO they carry the same amount of complexity.
> 
> If we go with ALIASED_F() (or ALIASED_8000_0001_F()), then that macro is all that
> is needed, and it's bulletproof.  E.g. there is no KVM_X86_FEATURE_FPU_ALIAS that
> can be queried, and thus no need to be ensure it's defined in cpuid.c and #undef'd
> after its use.
> 
> Hmm, I supposed we could harden the aliased feature usage in the same way as the
> ALIASED_F(), e.g.
> 
>   #define __X86_FEATURE_8000_0001_ALIAS(feature)				\
>   ({										\
> 	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) != CPUID_1_EDX);	\
> 	BUILD_BUG_ON(kvm_cpu_cap_init_in_progress != CPUID_8000_0001_EDX);	\
> 	(feature + (CPUID_8000_0001_EDX - CPUID_1_EDX) * 32);			\
>   })
> 
> If something tries to use an X86_FEATURE_*_ALIAS outside if kvm_cpu_cap_init(),
> it would need to define and set kvm_cpu_cap_init_in_progress, i.e. would really
> have to try to mess up.
> 
> Effectively the only differences are that KVM would have ~10 or so more lines of
> code to define the X86_FEATURE_*_ALIAS macros, and that the usage would look like:
> 
> 	VIRTUALIZED_F(FPU_ALIAS)
> 
> versus
> 
> 	ALIASED_F(FPU)


This is exactly my point. I want to avoid profiliation of the _F macros, because
later, we will need to figure out what each of them (e.g ALIASED_F) does.

A whole leaf alias, is once in x86 arch life misfeature, and it is very likely that
Intel/AMD won't add more such aliases.

Why VIRTUALIZED_F though, it wasn't in the patch series? Normal F() should be enough
IMHO.


> 
> At that point, I'm ok with defining each alias, though I honestly still don't
> understand the motivation for defining single-use macros.
> 

The idea is that nobody will need to look at these macros (e.g__X86_FEATURE_8000_0001_ALIAS() and its usages), 
because it's clear what they do, they just define few extra CPUID features 
that nobody really cares about.

ALIASED_F() on the other hand is yet another _F macro() and we will need,
once again and again to figure out why it is there, what it does, etc.

Best regards,
	Maxim Levitsky




