Return-Path: <linux-kernel+bounces-339520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EEC98664D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB36A1C236D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AC713DDDF;
	Wed, 25 Sep 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4yg7lMjM"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502391D5ADC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289047; cv=none; b=O02LK2IXtfuyxlPmV9Qg4KkQEKST54GG7iN1Y2TA64v8mpElE3IsHkXYJx0yv62h5izH4bMmFfBVTI10plkvdpCCjgWX4X8Mf55FJ9QZ388JI/6dBoL5Q6QBBvVoa3PW8Cemnz7iwTorFe36dvT6xEcp9mbLJwu6jfJYfBqEwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289047; c=relaxed/simple;
	bh=6JpXlaM+q70Ep1gyRy/VYd9wgs4rM1BuNKkYbnGpQz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QgsBLm6cTcnhZxIlOKqa38DgZKub/J1d1G80QmmRqa3Vddhp2wXuZ7pdix6ThZ79H6kpiPktSMQurCDLiuPjJFm4evZ8MvKSZH+WNWVlbnbUPQ96dU9d/T2faTXEsnTDKpdfVLJgIYraXI88SHlw34eifkayIaDVL19/9U2pId8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4yg7lMjM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2db24468f94so302227a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727289045; x=1727893845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DciY5j00msLXR2ca5NbWEcO/RtSRLLFLfOyEd9A9Zlg=;
        b=4yg7lMjMQ9hI4swIqO+uLyT48seao+a5Pgm6z8nG45CboRS+rJRDXygR/fJmnL+xA8
         HjFuWt4cM82HRS9A82+7A5puL357ewSOzpttY6fSQHCOdE87xmbxf8nW+YCQo182p6lv
         u9YWjs4s9NQ2tCkZFKzdOVpG/8TW+xhGitVXlLLNGxFqar6ll+lafyd6v8goEbFwiAiY
         78We8TqxVlMC1ZTB+r0sIPziahHGkWsGvskZw1WqYQISl5D+9UuE1RHms75JYJyqMjns
         ULZ3ThScg6lrEADmhu2f/GVyLCjppB9529M10bAksdKEgY2ftt7YZf+G/3za6PDF053B
         KGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727289045; x=1727893845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DciY5j00msLXR2ca5NbWEcO/RtSRLLFLfOyEd9A9Zlg=;
        b=C5n/gsUFDD3PSRYx866x0gYy/lyztkqzaXR/7aDcbSKF2S08plkLAnKoTubTbQYbDF
         lkQwPE05cRoRcJDAx+WUUVx2iiQiLCJ+ma5hf7DMreLv8EQbLmpTAaduQZ0qstgUD5b8
         83wRYDkUqCQ8r3D10XME4swNG0O4En7c0kBST9nhVGtffdvxCCo2rpdLMFD5rC6lDMoj
         yUOA97mQ0n23KgoDkDKCigZEaf9c8s/q3AiNBAZIjYOwhAdkv65CVXnRqhfuu1hsbc4w
         eMHFUMq4CwDu6uKGERqc+CmYqD6iFP6k0DQCy/hGHLEbygqHlaootSVxl+mX8qqJH4vE
         y4og==
X-Forwarded-Encrypted: i=1; AJvYcCX6bZ6DuHa4bgy/qS7FHNZquqFKT5vZKmbsA69mZP21+JqS50maEcuw+ZeosjLVvUFLWsUD6N8UPZsSARs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr79TN0sAEx6IJpIjW545q+lKAxqdhWA7eAY8yNN1m3AU9bppi
	R1Y2f7SDG9U0AAXIFROvEvTwSsIvzfRRgiuM9g8mkfxz9ktkizaiL4qwFiGGO7UVkKzveRiFUJ0
	K9A==
X-Google-Smtp-Source: AGHT+IFpnwXmjJNlKzKlwKTPfGspfGpOspl6v/pMyaFe8Q0hMwsgEZPyhAKfpNV1pX2Mtg7RTNish6id3Gc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:a887:b0:2d8:964a:1269 with SMTP id
 98e67ed59e1d1-2e06aff6467mr8193a91.7.1727289045207; Wed, 25 Sep 2024 11:30:45
 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:30:37 -0700
In-Reply-To: <b06172780e3af37fe91d1cc434aceff4169f88b3.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725175232.337266-1-mlevitsk@redhat.com> <20240725175232.337266-3-mlevitsk@redhat.com>
 <ZrF55uIvX2rcHtSW@chao-email> <ZrY1adEnEW2N-ijd@google.com>
 <61e7e64c615aba6297006dbf32e48986d33c12ab.camel@redhat.com>
 <65fe418f079a1f9f59caa170ec0ae5d828486714.camel@redhat.com>
 <ZvQne77ycOKQ1nvU@google.com> <b06172780e3af37fe91d1cc434aceff4169f88b3.camel@redhat.com>
Message-ID: <ZvRWzXfAV0gN2OZN@google.com>
Subject: Re: [PATCH v3 2/2] VMX: reset the segment cache after segment
 initialization in vmx_vcpu_reset
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 25, 2024, Maxim Levitsky wrote:
> On Wed, 2024-09-25 at 08:08 -0700, Sean Christopherson wrote:
> > > Finally all 3 places that read the segment cache, only access one piece of
> > > data (SS.AR or RIP), thus it doesn't really matter if they see an old or a
> > > new value. 
> > > 
> > > I mean in theory if userspace changes the SS's AR bytes out of the blue, and
> > > then we get a preemption event, in theory as you say the old value is correct
> > > but it really doesn't matter.
> > > 
> > > So IMHO, just ensuring that we invalidate the segment cache right after we do
> > > any changes is the simplest solution.
> > 
> > But it's not a very maintainable solution.  It fixes the immediate problem, but
> > doesn't do anything to help ensure that all future code invalidates the cache
> > after writing,
> 
> If we wrap segment cache access with something like segment_cache_access_begin()/end(),
> we can ensure that segment cache is only modified then (with some macros even maybe),
> or that at least it is clear to the developer that all writes should be wrapped by these
> functions.
> 
> I also do think that we should still re-order the segment cache accesses in vmx_vcpu_reset()
> and other places just for the sake of consistency.

Yeah, I've no objection to doing that, I just don't want that to be the long-term
solution.

> >  nor does it guarantee that all future usage of SS.AR can tolerate
> > consuming stale values.
> > 
> > > I can in addition to that add a warning to kvm_register_is_available and
> > > vmx_segment_cache_test_set, that will test that only SS.AR and RIP are read
> > > from the interrupt context, so that if in the future someone attempts to read
> > > more fields, this issue can be re-evaluated.
> > 
> > There's no need to add anything to vmx_segment_cache_test_set(), because it uses
> > kvm_register_is_available().  I.e. adding logic in kvm_register_is_available()
> > will suffice.
> > 
> > If we explicitly allow VMCS accesses from PMI callbacks, which by we *know* can
> > tolerate stale data _and_ never run while KVM is updating segments, then we can
> > fix the preemption case by forcing a VMREAD and bypassing the cache.
> >  
> > And looking to the future, if vcpu->arch.guest_state_protected is moved/exposed
> > to common code in some way, then the common PMI code can skip trying to read guest
> > state, and the ugliness of open coding that check in the preemption path largely
> > goes away.
> This is assuming that most VMs will be protected in the future?

No, the assumption is that other architectures will have VMs with protected guest
state, e.g. ARM's CCA stuff, at which point handling the "don't bother reading
guest RIP" logic in the common PMI handler is worth doing.

> > If you're ok with the idea, I'll write changelogs and post the below (probably over
> > two patches).  I don't love adding another kvm_x86_ops callback, but I couldn't
> > come up with anything less ugly.
> 
> This was one of the reasons I didn't want to write something like that.
> If we indeed only add callback for get_cpl_no_cache, then it is tolerable.

...

> > diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
> > index b1eb46e26b2e..0370483003f6 100644
> > --- a/arch/x86/kvm/kvm_cache_regs.h
> > +++ b/arch/x86/kvm/kvm_cache_regs.h
> > @@ -43,6 +43,18 @@ BUILD_KVM_GPR_ACCESSORS(r14, R14)
> >  BUILD_KVM_GPR_ACCESSORS(r15, R15)
> >  #endif
> >  
> > +/*
> > + * Using the register cache from interrupt context is generally not allowed, as
> > + * caching a register and marking it available/dirty can't be done atomically,
> > + * i.e. accesses from interrupt context may clobber state or read stale data if
> > + * the vCPU task is in the process of updating the cache.  The exception is if
> > + * KVM is handling an IRQ/NMI from guest mode, as that bounded sequence doesn't
> > + * touch the cache, it runs after the cache is reset (post VM-Exit), and PMIs
> > + * need to several registers that are cacheable.
> > + */
> > +#define kvm_assert_register_caching_allowed(vcpu)		\
> > +	lockdep_assert_once(in_task() ||			\
> > +			    READ_ONCE(vcpu->arch.handling_intr_from_guest))
> 
> This is ugly, but on the second thought reasonable, given the circumstances.
> 
> How about using kvm_arch_pmi_in_guest() instead? It is a tiny bit more accurate
> and self-documenting IMHO.

Ah, yeah, good idea.

> Also, how about checking for in_task() in __vmx_get_cpl() and then avoiding the cache?
> This way we will avoid adding a new callback, and in theory if there is more code that
> tries to read CPL from interrupt context, it will work for free. 
> 
> But on the other hand we might actually not want new code to get this for free. 
> Is this the reason you added the callback?

Yeah, exactly.  I actually started coding up using in_task(), but I didn't want
to allow all reads from !in_task() because then it would do the wrong thing for
any usage that isn't tolerant of stale data, i.e. where KVM _should_ read from
the cache.  Even worse, such bugs wouldn't be caught because the in_task() check
would bypass kvm_assert_register_caching_allowed().

I considered guarding the in_task() code with preempt_model_preemptible() so that
non-preemptible kernels would always use the cache, i.e. would detect unexpected
cases.   But that felt like a bit of a hack, and for preempt_dynamic kernels
preempt_model_preemptible() requires a function call, at which point it's entirely
possible that reading from the cache would end up being slower than doing VMREAD.

