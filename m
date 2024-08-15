Return-Path: <linux-kernel+bounces-288018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7948C953091
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE251F21965
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0419EED0;
	Thu, 15 Aug 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlWjmqXg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA319F470
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729452; cv=none; b=rcuqhktHqGvYLW6P7XMOpapSj+PPmSMSlG1phLfuDo7o+shOc9N7zJfwQCOS6LfogsKGkDhE8tmPzGICzALdyG5X1WnaZufjY0l+yO/vkEToYf30VWW7txDu7lZimlZUko7FJ/hx2gthEG4kMAijRz+7BEXQRMr+NOUCBvrqNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729452; c=relaxed/simple;
	bh=9AGELrkuV7EZRikIMXBDlNIHEDvCKbJikKbwKsHwsv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gCA90QQCOqgieWW6qV2sCAtV/HpwLicw4TFWoIN+cGpJzP7rRHU86vkXGFBu0gA0rUCdUhCoLOuAAenDIG+TBqj9QOa+QF/Utm/XBtxFtL48Mxygge07Nahp61qPF8uClRGeRcW/kCX+gb6G0Geaytz/NZUQeVSuOZaAfrmGBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlWjmqXg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso1471559276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723729450; x=1724334250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPX484PwSJ0KtNfnOFVCkU6UyyOJERQv814+10anCE0=;
        b=zlWjmqXgu7ZI7yiWh4lZlj/LPHkFQ92UZhA0QLww3rePfrlIcAgHVsXbXq2bz1DYMV
         IM3s/VLLokKueOjzMoAUjuGauO43FPqC57f06Vke122IGQt9cpmDjl23FLiMTMhAu6Yk
         Qwffh0TndhPTKK6GGsmiDLRPAp0Jov9//9fbuw0i+k0LXP7B9w0Aw2JR55yQlvb4qP3e
         6N1zFoYAQo/x9mvaBa8yGliWbUunSNr6TgDMx1oraaQKZhdH0CfMojzdYNttaPRLZJpb
         ZmbxVaImKwptDKID8V7B68Dtia/WhmH7N+QRt5aGWgetyxRLlLRe4jRdiQQ8hWnK9b/g
         prKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723729450; x=1724334250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPX484PwSJ0KtNfnOFVCkU6UyyOJERQv814+10anCE0=;
        b=YiYnfBdhkMgchc4bqlp7S4P9y0xAy9W8IcwxEyEkutKAsFOY11Hef25dlN2hz4JAyo
         4I0M9ydpNhN76bPHE65sFXJWjko9kFvrBKxIKWr+Gj3xA/1Y4vwQj2+gIYiUGKcQTrxa
         DUxZ+nrIIfDbMwHMSSuyNlQyqVmBc+cW8EHTm2YajDzDGyO6JPGJES9H8XUkbg4T4+gm
         Oy25MdtlbRdqNY9l5ZoWgfdDcO55ApL97G5sgaCulXXgElw99dTtXgqqVrYUDjHN6+wm
         xM4R0RxWGSyO5yHBivzVGOuubTPsn6+vlK1kqFOJEPMhQFrKjoYUxiCuLjlnYG2FI3ig
         EnFw==
X-Forwarded-Encrypted: i=1; AJvYcCUewLMZagQYlJlu1Un0pWNJt5q2E7sIIdPgTXs55eWJD84OCMwTlhi/bc2ah7SV6lk7KAtNhrZpyA+5SydGULn1LV14fB5V60gjSqNB
X-Gm-Message-State: AOJu0Yx1kAhbss2IXE6lje3J5+8Y0aNEhtJecDhBBQaFKl3kVjxZbOFu
	jDV8wAJb6UP7C4XXM37A7ul+Jj1mxdFvDjbX0IHe8tUZnx+tjnaFZMv1RHY8kwrS/FPWZRAcYEn
	b7g==
X-Google-Smtp-Source: AGHT+IGSgylacpA/2U2pcu8PcEw6cZjfuj/ASwhZ1QB063VQnq4fE/QQFvRwasAXHSOpiMB5bZZ2pZbZXxU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:e4c4:0:b0:e03:6556:9fb5 with SMTP id
 3f1490d57ef6-e1155ba2c78mr102561276.11.1723729449919; Thu, 15 Aug 2024
 06:44:09 -0700 (PDT)
Date: Thu, 15 Aug 2024 06:44:08 -0700
In-Reply-To: <87h6bmfbgm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b44227c5-5af6-4243-8ed9-2b8cdc0e5325@gmail.com>
 <Zpq2Lqd5nFnA0VO-@google.com> <207a5c75-b6ad-4bfb-b436-07d4a3353003@gmail.com>
 <87a5i05nqj.fsf@redhat.com> <b20eded4-0663-49fb-ba88-5ff002a38a7f@gmail.com>
 <87plqbfq7o.fsf@redhat.com> <ZrzIVnkLqcbUKVDZ@google.com> <87mslff728.fsf@redhat.com>
 <Zr0rEy0bO1ju_f1C@google.com> <87h6bmfbgm.fsf@redhat.com>
Message-ID: <Zr4GKEzp8eQDDH1d@google.com>
Subject: Re: [BUG] =?utf-8?Q?arch=2Fx86=2Fkvm=2Fvmx?= =?utf-8?Q?=2Fvmx=5Fonhyperv=2Eh=3A109=3A36=3A_error=3A_dereference_of_NUL?=
 =?utf-8?B?TCDigJgw4oCZ?=
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 15, 2024, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Aug 14, 2024, Vitaly Kuznetsov wrote:
> >> Sean Christopherson <seanjc@google.com> writes:
> >> 
> >> > On Wed, Aug 14, 2024, Vitaly Kuznetsov wrote:
> >> >> What I meant is something along these lines (untested):
> >> >> 
> >> >> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
> >> >> index eb48153bfd73..e2d8c67d0cad 100644
> >> >> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
> >> >> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
> >> >> @@ -104,6 +104,14 @@ static inline void evmcs_load(u64 phys_addr)
> >> >>         struct hv_vp_assist_page *vp_ap =
> >> >>                 hv_get_vp_assist_page(smp_processor_id());
> >> >>  
> >> >> +       /*
> >> >> +        * When enabling eVMCS, KVM verifies that every CPU has a valid hv_vp_assist_page()
> >> >> +        * and aborts enabling the feature otherwise. CPU onlining path is also checked in
> >> >> +        * vmx_hardware_enable(). With this, it is impossible to reach here with vp_ap == NULL
> >> >> +        * but compilers may still complain.
> >> >> +        */
> >> >> +       BUG_ON(!vp_ap);
> >> >
> >> > A full BUG_ON() is overkill, and easily avoided.  If we want to add a sanity
> >> > check here and do more than just WARN, then it's easy enough to plumb in @vcpu
> >> > and make this a KVM_BUG_ON() so that the VM dies, i.e. so that KVM doesn't risk
> >> > corrupting the guest somehow.
> >> >
> >> 
> >> I'm still acting under the impression this is an absolutely impossible
> >> situation :-)
> >> 
> >> AFAICS, we only call evmcs_load() from vmcs_load() but this one doesn't
> >> have @vcpu/@kvm either and I wasn't sure it's worth the effort to do the
> >> plumbing (or am I missing an easy way to go back from @vmcs to
> >> @vcpu?). On the other hand, vmcs_load() should not be called that ofter
> >> so if we prefer to have @vcpu there for some other reason -- why not.
> >
> > kvm_get_running_vcpu(), though I honestly purposely didn't suggest it earlier
> > because I am not a fan of using kvm_get_running_vcpu() unless it's absolutely
> > necessary.  But for this situation, I'd be fine with using it.
> 
> Ah, nice, so we don't even need the plumbing then I guess? Compile-tested only:
> 
> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
> index eb48153bfd73..318f5f95f211 100644
> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
> @@ -104,6 +104,19 @@ static inline void evmcs_load(u64 phys_addr)
>         struct hv_vp_assist_page *vp_ap =
>                 hv_get_vp_assist_page(smp_processor_id());
>  
> +       /*
> +        * When enabling eVMCS, KVM verifies that every CPU has a valid hv_vp_assist_page()
> +        * and aborts enabling the feature otherwise. CPU onlining path is also checked in
> +        * vmx_hardware_enable(). With this, it is impossible to reach here with vp_ap == NULL
> +        * but compilers may still complain.
> +        */
> +       if (!vp_ap) {
> +               struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
> +
> +               KVM_BUG_ON(1, vcpu->kvm);
> +               return;

Eh, I would just do:

	if (KVM_BUG_ON(!vp_ap, kvm_get_running_vcpu()->kvm))
		return

> +       }
> +
>         if (current_evmcs->hv_enlightenments_control.nested_flush_hypercall)
>                 vp_ap->nested_control.features.directhypercall = 1;
>         vp_ap->current_nested_vmcs = phys_addr;
> 
> (I hope we can't reach here with kvm_running_vcpu unset, can we?)

Yes?  kvm_running_vcpu is set before kvm_arch_vcpu_load() and cleared after
kvm_arch_vcpu_put(), and I can't think of a scenario where it would be legal/sane
to invoke vmcs_load() without a running/loaded vCPU.  VMX needs the current VMCS
to be loaded to ensure guest state can be accessed, so any ioctl() that can touch
guest state needs to do vcpu_load().

x86's kvm_arch_vcpu_ioctl() unconditionally does vcpu_load(), and the only ioctls
I see in kvm_vcpu_ioctl() that _don't_ do vcpu_load() are KVM_SET_SIGNAL_MASK and
KVM_GET_STATS_FD, so I think we're good.

And if I'm wrong and the impossible happens twice, so be it, we die on #GP :-)

