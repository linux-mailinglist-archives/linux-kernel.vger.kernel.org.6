Return-Path: <linux-kernel+bounces-285717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3E9511B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0161F24E48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F721BF3F;
	Wed, 14 Aug 2024 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sV5pJ14D"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EED18026
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600374; cv=none; b=VqTK0jMxuHHITFVV550cLX+s+cfWKu47NFFtlsbgT5mMgJv1lOXF581t2iINqXLp1nqpyN+Z+ZU/qB5w0NTdYz1B3y2naaruDpF+j9WhubX+4dZXx0A/nNFKLU9jNjl3zias5XGmvwcRpi1p12cbH26EyJ0Nvi3VC2cP2pdJte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600374; c=relaxed/simple;
	bh=MBCa2yJn6tPfuatc5ue5hU/K2qFjzCAd7cqEpq1nl2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O25+ApGWRg2D0g9rsixCEav5cYF8q+Pc9f3aUuLjWQi/bLHMZ0/OekXiQkFas7R5hjgVVrZMIDbvWfa57zSBd//0nwiC+u5H+7Kxh0RLMTeC9l1KtEb3C1XnGwzcRG3v3VVWWBLsIIgJM1XTKalW9tLCICaiwOXb69SKirxMqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sV5pJ14D; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d24aead3eso5317258b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723600371; x=1724205171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4yGIdJv7M/k+bCqCZh00a/qc87zMvXpkoJKzkdnDM8=;
        b=sV5pJ14DgfCih+EMZx6iDTCb5mZP6rF/Y/30hbpEe/3liCXVfrH2Bt43KdoB62JlMd
         DKc2YHOU+EwUnulBOIJ9VresJh5txSr7lO9O3o04Nl6CU+mMWqZ+4vx7j02OZmJPZi6s
         xqklKKrR5O6NHKzNYXXC3XIin++uOdXoBGjOCqeRE9vplHe07OPND2MF2jDo33+hWBAs
         aNSYGOLNt8w2bT5CEewOS8SVK1/jZX9k3gcC5uXOC2nNUAi1rXLYwdSM4lL4HvxtEXNg
         pYWil48ih6iuCSnl7Z6zls384Y6o6ge56GdF0kWQdvSeYQWAlsMpAchynxHGq8xnu5qu
         3PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600371; x=1724205171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4yGIdJv7M/k+bCqCZh00a/qc87zMvXpkoJKzkdnDM8=;
        b=BrOtlnuPpq9vmSC6Im/J3bcwZYUtxw5iYxoiiSNzPBCWHEk3X+kLqCoF4GYxZEvv2Q
         hUS1/wMzFQXHNaYWGnyfPevR8Is5TnoGDKaH4TvR7wc/dZOC8/kjJEOhei+smX8PEnl6
         PnajpztErTjd4s9eXmNylFIPo8fTmDKIan9dpJfSHz3TzMzXz5sPMARfa9rNvBgbdfLX
         O4RshtlbWWjFrWr77CJDUxcYxuOAoP6+aHb9TL0hfPHWjQY8thkVPk7uJjWvVPLZjUO9
         drbXYr5jKgstBuQB/ouJrTzbrbKKsxm1OUmWJx8/dO21g6bBmML+cXs8wHffNlsoqFMb
         8dBg==
X-Forwarded-Encrypted: i=1; AJvYcCWaeCj+YcJGUzYf46YnZxJcWHqkKGx3wwu2LLTRrB0oyOGfTHyo4QQbBVtoTZNLyhPQVRo0wivv3MrYpku6URzhNuBXzosyyQtf/OvO
X-Gm-Message-State: AOJu0YxREwtz0RnU1wKKOSkgc2oDL0+6Mq4DmIEANganlJZTBo4vPCgO
	tOxPNKPJCgH2QYJC15oEpEBeTSpUzt2njSNA3Jk/RtjEOOjCr/PNASFAVrjUdSn79xiD2MVKFLZ
	L/w==
X-Google-Smtp-Source: AGHT+IFwKCIOV5o7L3PLXRmNBudEXbN7xq9tO/YnjNTtRMxUwLL8mbEGKsngAowwXWeHPhTmxOCOIjUexcA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2ce:b0:710:9d5d:f2ad with SMTP id
 d2e1a72fcca58-712670fd788mr4153b3a.2.1723600370238; Tue, 13 Aug 2024 18:52:50
 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:52:49 -0700
In-Reply-To: <20240522001817.619072-8-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522001817.619072-1-dwmw2@infradead.org> <20240522001817.619072-8-dwmw2@infradead.org>
Message-ID: <ZrwN8eGIaA4dzB5l@google.com>
Subject: Re: [RFC PATCH v3 07/21] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the
 documentation on TSC migration
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
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 72ad5ace118d..fe7c98907818 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -864,6 +864,12 @@ struct kvm_hyperv_eventfd {
>  /* for KVM_{GET,SET,HAS}_DEVICE_ATTR */
>  #define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
>  #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
> +#define   KVM_VCPU_TSC_SCALE  1 /* attribute for TSC scaling factor */
> +
> +struct kvm_vcpu_tsc_scale {
> +	__u64 tsc_ratio;
> +	__u64 tsc_frac_bits;
> +};
>  
>  /* x86-specific KVM_EXIT_HYPERCALL flags. */
>  #define KVM_EXIT_HYPERCALL_LONG_MODE	_BITULL(0)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 42abce7b4fc9..00a7c1188dec 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5715,6 +5715,7 @@ static int kvm_arch_tsc_has_attr(struct kvm_vcpu *vcpu,
>  
>  	switch (attr->attr) {
>  	case KVM_VCPU_TSC_OFFSET:
> +	case KVM_VCPU_TSC_SCALE:
>  		r = 0;
>  		break;
>  	default:
> @@ -5737,6 +5738,17 @@ static int kvm_arch_tsc_get_attr(struct kvm_vcpu *vcpu,
>  			break;
>  		r = 0;
>  		break;
> +	case KVM_VCPU_TSC_SCALE: {
> +		struct kvm_vcpu_tsc_scale scale;
> +
> +		scale.tsc_ratio = vcpu->arch.l1_tsc_scaling_ratio;

I'm pretty sure vcpu->arch.l1_tsc_scaling_ratio is set to the correct value only
if the vCPU is using KVM's default frequency, or TSC scaling is supported in
hardware.

	/* TSC scaling supported? */
	if (!kvm_caps.has_tsc_control) {
		if (user_tsc_khz > tsc_khz) {
			vcpu->arch.tsc_catchup = 1;
			vcpu->arch.tsc_always_catchup = 1;
			return 0;
		} else {
			pr_warn_ratelimited("user requested TSC rate below hardware speed\n");
			return -1;
		}
	}

I assume the easiest solution is to enumerate support for KVM_VCPU_TSC_SCALE if
and only if kvm_caps.has_tsc_control is true.

> +		scale.tsc_frac_bits = kvm_caps.tsc_scaling_ratio_frac_bits;
> +		r = -EFAULT;
> +		if (copy_to_user(uaddr, &scale, sizeof(scale)))
> +			break;
> +		r = 0;
> +		break;
> +	}
>  	default:
>  		r = -ENXIO;
>  	}

