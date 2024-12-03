Return-Path: <linux-kernel+bounces-430037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BFA9E2D13
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45B8B3570D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149EC20409D;
	Tue,  3 Dec 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWv0hY6H"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFD20010B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252871; cv=none; b=fwMnMnqGIUtVxe8vdfQQOPW21mlhxtRQ6M1swsA7ZeDYexz44kZAR8jGBO1TiipxwXP1G4b4QMQwIJaJ8bixhiXWQwwBJ3YRYMeQ8uv5kOEISpDAKFNBbALl9mbz4wQCKG56/t/xHvTzh/GPughwgyUduryZ6NEZYyyDKFWeobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252871; c=relaxed/simple;
	bh=MJR7wMKmDqS5aFmAfPznb4O85+40BOjFkprVenAI+OE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fw1IOuNzMrtw4vfNLBC09dN2VAb3+uUHw4wCTSHZZ8+A5YQ3aw+FhCa0S/fOPi5cs+dX68rmAiqgQ4rweH8K/CgN6kmt8Bi6ZdvVtNUGK1VoHPTSY5zzaNwqRjHpJVCGqDAbKD0FFgDjqkVo3HkBVd+hcXNWpZwVBQavmRaMmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWv0hY6H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee36569f4cso4987139a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733252869; x=1733857669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PaCdFtyuZCc6AtbaS5uMRjDy7Mq8Hk8zYjV/jOWuGVc=;
        b=pWv0hY6H1ZbDJXZq8K56SPd9d/5CdYLTRtI5I8rRnhH8VXQWtc6OIeTsO5lYUQeUhk
         ToQDUxS5JHRFw5tsmgB8GozyH7+ddc2Mmx2UnFLZ+TsaJf4hIAxPHq9LscBjb2ij7ll6
         z3HO3YY/IEHQcn5q1sCOfe4/LU0RTQmAa00CUrZ6QcT0aUZBVx0xpVNGcYMs9/nhROPW
         E6u9Uq/2zA4epZaKnYpPT7HUbQZkyIVtKcyWJPyIfO1imtEW0KwKwmdqOQZHSI3sZvta
         WZOcq9Jq/7Q+LWj0f1tA3heaiJsy2sghzmTfUCWOwL8RAJp2q+Nlna2TzDUkssngaovM
         Fteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733252869; x=1733857669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaCdFtyuZCc6AtbaS5uMRjDy7Mq8Hk8zYjV/jOWuGVc=;
        b=gbsIPZDli5pG8tZ7hD/I/j3BFf3/eCiHKmrkXvz8ojLOOk6JYCIXX+BaaAaXBi11WD
         tCxmnsT5bYBfjuuxKidDluG4gOl0NYlAdAyoWqEk+9jV/8vg6AJyK2xoYda3Zkcv/k8E
         /lwTCPpK7YW7hST6PS07EmrPu64p8uIqKKhmUm6/G6iA51PKM4ZOIgXcc0uzsFWB6ICW
         c9qOTiPj8iRTYfaLvO9R/6ewBeItWFDMC/4JM8pN4CrE9no5i9a/iOE3itxMGbLQ8TWz
         z+NBn9bHgLRFgBXUGnW0CnyrCky3lIMPRNfQvTsrdgku50zEszs9RqrAkdD/3v6AXEpA
         nldg==
X-Forwarded-Encrypted: i=1; AJvYcCVq81HhpsQuVk36VCeBQp6Z0DvvCbvqX8DnBDuJ0Fv0fEcPzEz6XYXRY4xuiHUcijvKcWubSc5guDNBZwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywKrP2A6gqRzd5xqVfiAwbuwHMn+g2tTYuBScF1hyToeZkyDPQ
	LtH3kL+F6uwn9Mib0HIznqh75PcihIlS6f78Vktxh2phVbXhRbuW1KwXIrCog/O0HMTh1j0dqfC
	wyA==
X-Google-Smtp-Source: AGHT+IHjoirwBfWtmi9PaYx/CFYut1Vj6FLcEXqUtE33259R8PXsBNLecTER6HtXRPmwtYfrA0AIIAqHdZ4=
X-Received: from pjbsb14.prod.google.com ([2002:a17:90b:50ce:b0:2ee:3882:175b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4a:b0:2ee:e18b:c1fa
 with SMTP id 98e67ed59e1d1-2ef0125b2e5mr4090519a91.28.1733252869223; Tue, 03
 Dec 2024 11:07:49 -0800 (PST)
Date: Tue, 3 Dec 2024 11:07:47 -0800
In-Reply-To: <20241121185315.3416855-7-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com> <20241121185315.3416855-7-mizhang@google.com>
Message-ID: <Z09XA-2ao5CbXhV5@google.com>
Subject: Re: [RFC PATCH 06/22] KVM: x86: INIT may transition from HALTED to RUNNABLE
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

The shortlog is an observation, not a proper summary of the change.

  KVM: x86: Handle side effects of receiving INIT while vCPU is HALTED

On Thu, Nov 21, 2024, Mingwei Zhang wrote:
> From: Jim Mattson <jmattson@google.com>
> 
> When a halted vCPU is awakened by an INIT signal, it might have been
> the target of a previous KVM_HC_KICK_CPU hypercall, in which case
> pv_unhalted would be set. This flag should be cleared before the next
> HLT instruction, as kvm_vcpu_has_events() would otherwise return true
> and prevent the vCPU from entering the halt state.
> 
> Use kvm_vcpu_make_runnable() to ensure consistent handling of the
> HALTED to RUNNABLE state transition.
> 
> Fixes: 6aef266c6e17 ("kvm hypervisor : Add a hypercall to KVM hypervisor to support pv-ticketlocks")
> Signed-off-by: Jim Mattson <jmattson@google.com>

Mingwei's SoB is missing.

> ---
>  arch/x86/kvm/lapic.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 95c6beb8ce279..97aa634505306 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -3372,9 +3372,8 @@ int kvm_apic_accept_events(struct kvm_vcpu *vcpu)
>  
>  	if (test_and_clear_bit(KVM_APIC_INIT, &apic->pending_events)) {
>  		kvm_vcpu_reset(vcpu, true);
> -		if (kvm_vcpu_is_bsp(apic->vcpu))
> -			vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
> -		else
> +		kvm_vcpu_make_runnable(vcpu);

This is arguably wrong.  APs are never runnable after receiving.  Nothing should
ever be able to observe the "bad" state, but that doesn't make it any less
confusing.

This series also fails to address the majority cases where KVM transitions to RUNNABLE:

  __set_sregs_common()
  __sev_snp_update_protected_guest_state()
  kvm_arch_vcpu_ioctl_set_mpstate()
  kvm_xen_schedop_poll()
  kvm_arch_async_page_present()
  kvm_arch_vcpu_ioctl_get_mpstate()
  kvm_apic_accept_events() (SIPI path)

Yeah, some of those don't _need_ to be converted, and the existing behavior of
pv_unhalted is all kinds of sketchy, but fixing a few select paths just so that
APERF/MPERF virtualization does what y'all want it to do does not leave KVM in a
better place.

I also think we should add a generic setter, e.g. kvm_set_mp_state(), and take
this opportunity to sanitize pv_unhalted.  Specifically, I think pv_unhalted
should be clear on _any_ state transition, and unconditionally cleared when KVM
enters the guest.  The PV kick should only wake a vCPU that is currently halted.
Unfortunately, the cross-vCPU nature means KVM can't easily handle that when
delivering APIC_DM_REMRD.

Please also send these fixes as a separate series.  My crystal ball says APERF/MPERF
virtualization isn't going to land in the near future, and I would like to get
the mp_state handling cleaned up soonish.

> +		if (!kvm_vcpu_is_bsp(apic->vcpu))
>  			vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
>  	}
>  	if (test_and_clear_bit(KVM_APIC_SIPI, &apic->pending_events)) {
> -- 
> 2.47.0.371.ga323438b13-goog
> 

