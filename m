Return-Path: <linux-kernel+bounces-288345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6E953908
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6296A1F23277
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9997768E1;
	Thu, 15 Aug 2024 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9xqtquZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BF4D8C3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743109; cv=none; b=RK8ihNPs8Um1mwnBHWpRNAZMTBljfbzRwsORGUtmUZM9FgJtOjOim9laS4bkru6uNG6jmefUF9/B9KSK9N+KkYph+bQ8L8xtaEvNEXnlO4u1T6ISNnD+PXQ1ahxGbq+ntqmu8IhO31EP44E6JDqVkTkPMsG8z7sOeswyQP/2YTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743109; c=relaxed/simple;
	bh=QbXlSIN7Jb6zKr7Do8xhpv3pvluEnhYN3MIAUO+roak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AFXMR1nb4O9fZbb6Yd/DiCr6TZn41P8BB4GJa/o6T+Yhl68yXNpVpgirO0UaRkHA4cZ/9iwiexPtC58KZcqG01vtwgH3WFQ73OpFf3VH/1rhr5g0AuRZ3UGtN0Bh6PGOhqJqstzTC/UmJkJXWn2mmiyJp6mo2lPjWjKft+bOD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C9xqtquZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-672bea19c63so19726817b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723743106; x=1724347906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=37F32RQuy8+0cBTW6OKKkuSelNVTFSr/zBWZTj9nXuI=;
        b=C9xqtquZtAo1tz31Fxl4sP0bAZogb8j+eJAXE3bwt00wMyF56gaMDDgJfQR9P3SRhz
         LJQ2EBG5IP+EDMr075SN1/iLxnPK9la1WTHtY1gqrg8PdIOlYp6or6uKIEzpA29/nu1q
         2vuF2oxi/wgXp2Q60j8jjx3XX1B2mbzR0JQ9pzU7kxej6snDK43DWEgSwSwS+b6i3Nhn
         u+gxHY2a09O6Sr9Sp8nLMDvTbVr+MvUrEbVwZGC6yu2QDjHlaOlUol9MDAfT4PxMR8SA
         H75Eq2Qv4SzEK4yra0Y3MK9bCcTx8rsk78ZxNNqGeo8QXOKJAD1gRfoNaCyTisgwHyP/
         59Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743106; x=1724347906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37F32RQuy8+0cBTW6OKKkuSelNVTFSr/zBWZTj9nXuI=;
        b=PWVz9xNPuMReO39bgYsGtled1OnRb9Z2t3HCJ2BhF0427etV+KxizAoOjkWwhhiCl8
         pX28hgSYL2uRDuseC2niO0SuULcPxlzTXdB/v9j0tUGmyX+h8k84Abl61qvPlToyplka
         p7ySVouOYNVfjyxFauAHu0C3GGwRSIGAH4FJyV4jZTPvbIaGvPz85SL7Tv8r0KxXuCF3
         hlNg/vdfY25gDJMIT5/UN1jwHzhD+8HtsPckOCq2ln3rnQRVMT9wUcNsyVs6TdtPA9tv
         T2iuOzC5fnSC6JjiUWDFv/vCgfnKDrkZWl23kuF1Q1bQYxI8PCAGy1daYaVlU/EaGq27
         UOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUy/X51s1POckRZDG6pjZZ8igm+rTMC+3CYR0LvN9IVrDoPErM5f6y+spa+Aaq7qxxQcvvgjXmzZdo0GRZwlIypqgCW06Ev2XXxQwi
X-Gm-Message-State: AOJu0Yx0wyag5/hfNj0QnGpoSMHh99RLoTjx7DqUJrx2EjmG9MMfs0l5
	Q0+Y2uKQANYryOCn6Yte6M42SMpN2HK+AaqfCNTHYdpem+kI/gY+ro1n4Z+tpCLetgt5zIWnpT5
	chw==
X-Google-Smtp-Source: AGHT+IFcExSDSrYqJfIAeCJVnOPaRKoHoSW2taeGhC9rK65ohx19AQTb8ulOz1IcFs0HZt63/1LzBvs8k7k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:7690:b0:69b:2f8e:4d10 with SMTP id
 00721157ae682-6b1bbe2eb40mr149967b3.7.1723743106134; Thu, 15 Aug 2024
 10:31:46 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:31:44 -0700
In-Reply-To: <20240522001817.619072-19-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522001817.619072-1-dwmw2@infradead.org> <20240522001817.619072-19-dwmw2@infradead.org>
Message-ID: <Zr47gM9HWnzG9aN9@google.com>
Subject: Re: [RFC PATCH v3 18/21] KVM: x86: Avoid gratuitous global clock
 reload in kvm_arch_vcpu_load()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jalliste@amazon.co.uk, sveith@amazon.de, zide.chen@intel.com, 
	Dongli Zhang <dongli.zhang@oracle.com>, Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 22, 2024, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Commit d98d07ca7e034 ("KVM: x86: update pvclock area conditionally, on
> cpu migration") turned an unconditional KVM_REQ_CLOCK_UPDATE into a
> conditional one, if either the master clock isn't enabled *or* the vCPU
> was not previously scheduled (vcpu->cpu == -1). The commit message doesn't
> explain the latter condition, which is specifically for the master clock
> case.

It handles the first load of the vCPU, which is distinctly different from CPU
migration.

> Commit 0061d53daf26f ("KVM: x86: limit difference between kvmclock
> updates") later turned that into a KVM_REQ_GLOBAL_CLOCK_UPDATE to avoid
> skew between vCPUs.
> 
> In master clock mode there is no need for any of that, regardless of
> whether/where this vCPU was previously scheduled.
> 
> Do it only if (!kvm->arch.use_master_clock).
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 32a873d5ed00..dd53860ca284 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5161,7 +5161,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  		 * On a host with synchronized TSC, there is no need to update
>  		 * kvmclock on vcpu->cpu migration
>  		 */
> -		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1)
> +		if (!vcpu->kvm->arch.use_master_clock)
>  			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);

I believe this needs to be:

		if (!vcpu->kvm->arch.use_master_clock)
			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
		else if (vcpu->cpu == -1)
			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);

or alternatively do KVM_REQ_CLOCK_UPDATE during vCPU creation (hotplug?).

>  		if (vcpu->cpu != cpu)
>  			kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);
> -- 
> 2.44.0
> 

