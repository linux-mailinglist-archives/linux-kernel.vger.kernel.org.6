Return-Path: <linux-kernel+bounces-577433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7CA71CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CE33B65F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E88E1FF1BF;
	Wed, 26 Mar 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NE2Ouqek"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46481FECD9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009469; cv=none; b=Up2C4a8hopuyD/HTAgqcMRSfidjHeChy/UZg24v4millyBTonQghrvPo3bdCzjGqiYhU7IKd6u+ksue8D+0m1t60KlMUkkv5MC5kc04JYhFHORVNTyfi3xm6aL0yrNR/uh96Wgy72NJgayDi9M2BPmgtariMUfyYBUM7Fj3n4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009469; c=relaxed/simple;
	bh=LMWgUoP8H5hud2jquf3xDSpzfKmXw3BzZ/VDXBFKOC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dzZZt7i1y5LFkT9Au796MI2hDbtvMeCnal/N+d4Ay7QlcG0YBA5kMgtX/6Q5IYwU04eShdL2ZPv4iTP61Nrwcvc42MRG7YjBMlnbEHhc0yUEK/RtwH1bPks8c1/III8p1vvAv9MgS94gnM9m5k4Ql8JrY1XWYm1iqzr0mKcJxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NE2Ouqek; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so20606a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743009467; x=1743614267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hluGm6VRaRlKKkj14E5M+udWDJDyW7msOhz4xM53G1w=;
        b=NE2OuqekmtU+8vrT6qtX4HdCRpMAMILxmHf2Mz1ij7rPqhi9aY0eL71xspsUANAoXD
         t8UgJTvn6OXYeK9xLKYlGjj1FnILK4e87T/een0GGFfGyoVVVAUyBBCgsgI8fAVhtEKm
         8FOo1btREtKugQ1YUqDXpXvzLr9qdc8Bu/ty5MBLypS4EbHyBh1NYurP3qoF2HzyNSQR
         8kC24rPCvvqkm3CfeytsBUDkQqhzMED9fae9Yw8pgzNL04XNTRl5HeRAW1rrIRDd0/ni
         vp9+sMgl9Y83rAla6oZhRFFDwszFbZofsJ56Xf1UwOIf6S/WhT95SG+9m8rF1KYNFIGH
         w2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009467; x=1743614267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hluGm6VRaRlKKkj14E5M+udWDJDyW7msOhz4xM53G1w=;
        b=r8SEvnhP90y+cH3RmIBgHjliS50/6Fmwm58nhYQjBEEt1q+GyyMgpAre3s6ADHiLS7
         1sRciNn6osjD95C6czKbuJoFnW/qNCilcQiIZd7VLXyuImlfSuH389FYfwVf0wiFDoM2
         tj09Um1pyugjEQoDrIO6HY+dShKLn4Laz0hw2PsAB40Rx5OsPc/8szJ3Uqsxq8Hh6HIQ
         xvI5ONRYRCcPRUr1o6CadQeM95+Zvmb6xfL8IZARbnIYuObMDT2br7Tl0MOKr16niPyo
         I7lNpSr/xp/HZTCGATQj5pR6iNghF7+2zIoal+/YP+roTBqjGMi7EQk471+bcx+k47/W
         Y6NA==
X-Forwarded-Encrypted: i=1; AJvYcCXlWnXKfZ7h7iZKg43P7EgsRcKZVoTtXB69Va8ElxDDsvlSiS1ruhFplcDs7sq8sjXv9tQduXPv5fjn5uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LjBNh2upXNzvh8wYHjYR1XZ6ayj8YlR/RaVAQR/5FtxZr/Ra
	yc8gIZGbOHKRmYEmA8J+cs7HMi2t9rtewAZm1YJE4G+Cy/DVd/iBnrHRMdF/ZljLNt63Ng4DjKN
	ExA==
X-Google-Smtp-Source: AGHT+IEJBmy0VbIydSttkDIQEZdME5KE7UTUfEYnfDQDlN3EXThMA4yqR2HKH7n59GKJLZV+S/r5RRpuLWY=
X-Received: from pjbof13.prod.google.com ([2002:a17:90b:39cd:b0:2fa:15aa:4d2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2cd:b0:301:1bce:c252
 with SMTP id 98e67ed59e1d1-303a8d81d2bmr548198a91.27.1743009467251; Wed, 26
 Mar 2025 10:17:47 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:17:45 -0700
In-Reply-To: <41bfb025-008c-db03-2f6d-33b2d542ae65@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6053e8eba1456e4c1bf667f38cc20a0ea05bc72c.1742232014.git.thomas.lendacky@amd.com>
 <48899db8-c506-b4d1-06cd-6ba9041437f7@amd.com> <Z9hbwkqwDKlyPsqv@google.com>
 <8c0ed363-9ecc-19b2-b8d7-5b77538bda50@amd.com> <91b5126e-4b3e-bcbf-eb0d-1670a12b5216@amd.com>
 <29b0a4fc-530f-29bf-84d4-7912aba7fecb@amd.com> <aeabbd86-0978-dbd1-a865-328c413aa346@amd.com>
 <Z93zl54pdFJ2wtns@google.com> <9a36b230-bf41-8802-e7ba-397b7feb5073@amd.com> <41bfb025-008c-db03-2f6d-33b2d542ae65@amd.com>
Message-ID: <Z-Q2uQ0perBQiZh-@google.com>
Subject: Re: [PATCH] KVM: SVM: Fix SNP AP destroy race with VMRUN
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 26, 2025, Tom Lendacky wrote:
> On 3/25/25 12:49, Tom Lendacky wrote:
> > On 3/21/25 18:17, Sean Christopherson wrote:
> >> On Fri, Mar 21, 2025, Tom Lendacky wrote:
> >>> On 3/18/25 08:47, Tom Lendacky wrote:
> >>>> On 3/18/25 07:43, Tom Lendacky wrote:
> >>>>>>> Very off-the-cuff, but I assume KVM_REQ_UPDATE_PROTECTED_GUEST_STATE just needs
> >>>>>>> to be annotated with KVM_REQUEST_WAIT.
> >>>>>>
> >>>>>> Ok, nice. I wasn't sure if KVM_REQUEST_WAIT would be appropriate here.
> >>>>>> This is much simpler. Let me test it out and resend if everything goes ok.
> >>>>>
> >>>>> So that doesn't work. I can still get an occasional #VMEXIT_INVALID. Let
> >>>>> me try to track down what is happening with this approach...
> >>>>
> >>>> Looks like I need to use kvm_make_vcpus_request_mask() instead of just a
> >>>> plain kvm_make_request() followed by a kvm_vcpu_kick().
> >>
> >> Ugh, I was going to say "you don't need to do that", but I forgot that
> >> kvm_vcpu_kick() subtly doesn't honor KVM_REQUEST_WAIT.
> >>
> >> Ooof, I'm 99% certain that's causing bugs elsewhere.  E.g. arm64's KVM_REQ_SLEEP
> >> uses the same "broken" pattern (LOL, which means that of course RISC-V does too).
> >> In quotes, because kvm_vcpu_kick() is the one that sucks.
> >>
> >> I would rather fix that a bit more directly and obviously.  IMO, converting to
> >> smp_call_function_single() isntead of bastardizing smp_send_reschedule() is worth
> >> doing regardless of the WAIT mess.  This will allow cleaning up a bunch of
> >> make_request+kick pairs, it'll just take a bit of care to make sure we don't
> >> create a WAIT where one isn't wanted (though those probably should have a big fat
> >> comment anyways).

...

> >> @@ -3764,12 +3764,12 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
> >>         if (kvm_arch_vcpu_should_kick(vcpu)) {
> >>                 cpu = READ_ONCE(vcpu->cpu);
> >>                 if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
> >> -                       smp_send_reschedule(cpu);
> >> +                       smp_call_function_single(cpu, ack_kick, NULL, wait);
> > 
> > In general, this approach works. However, this change triggered
> > 
> >  WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
> > 	      && !oops_in_progress);
> > 
> > in kernel/smp.c.

Drat, I forgot that smp_call_function_xxx() can deadlock even if wait=false due
to needing to take locks to set the callback function.

> Is keeping the old behavior desirable when IRQs are disabled? Something
> like:
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index a6fedcadd036..81cbc55eac3a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3754,8 +3754,14 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait)
>  	 */
>  	if (kvm_arch_vcpu_should_kick(vcpu)) {
>  		cpu = READ_ONCE(vcpu->cpu);
> -		if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
> -			smp_call_function_single(cpu, ack_kick, NULL, wait);
> +		if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu)) {
> +			WARN_ON_ONCE(wait && irqs_disabled());
> +
> +			if (irqs_disabled())
> +				smp_send_reschedule(cpu);
> +			else
> +				smp_call_function_single(cpu, ack_kick, NULL, wait);
> +		}
>  	}
>  out:
>  	put_cpu();

That, or keying off wait, and letting smp_call_function_xxx() yell about trying
to use it with IRQs disabled, i.e.

			if (wait)
				smp_call_function_single(cpu, ack_kick, NULL, wait);
			else
				smp_send_reschedule(cpu);

My vote would be for the checking "wait", so that the behavior is consistent for
a given request.

