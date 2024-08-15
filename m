Return-Path: <linux-kernel+bounces-288228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A79537A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408041C22F50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B551B29B7;
	Thu, 15 Aug 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zdF2Efvh"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66571AC450
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737145; cv=none; b=fBYmedIa7IOhdlRrSYy09TDBawiBFMdkqFNNCcMHxBD8JYVxicOueL5ozoZHTwVYkUVOm+7wJtmxcTI/IpfzpT6E7gWTK48+NG5QII6jHUAD/kBfiT0/Kg8UyTF4lTFw5QqQHvRDSROAAt9CM4t3zf08dfEts2/Cj7j3jO/z1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737145; c=relaxed/simple;
	bh=snKXFCF6FnyiOrGKJVBPz6luqmn6mmdCtFo8tjxYdls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MKQ5nMUz6BBLFmVyLm8H3fTcuw2w/1V6Q2IiWGB41SCmJ/+Suf/5n/3Qy52PHhRVr/oYKyE0Oix9wHDAUiN2+1kmn/q4vW5lYLMqmQSEMn0lnmYEqOAkIHKwbRn1xLia7l/fj2vIa/I+UngP0PETZHG3wmdW/aNLSWGlloqpFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zdF2Efvh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a23a0fb195so921993a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723737142; x=1724341942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsUSd9Woo/iqPvXMwajq5VMWihmQ0h2yWsEHJq+e+9A=;
        b=zdF2Efvhw8kMRsbjOC6prXruy5KR/vKK84JMIFWniz2YoEP5U3m4SDTHKbSyb0t8Jt
         +BMtOy2MF3VpOSPtyeY/Re7DtcnpV0/W7hxt9k5uMnNt9J4NdFzwTto5vcdI+a3FGpAn
         WNkuDd3xFTum9/Vz5+nU4/7v9yMZk4WtOeQdM+T9uHie3vMKKjLtuUk0Zba9dK+8+ET5
         ZFDGsN82/AqQg2+waIZW6xHQ7arn+xIr2YQkpY2E53Nx4Kr/sFDmLrohNDFnVTrVIanl
         mmHbAU9kSdB0Pc/1Q1tZx8zAQWxavg4eK2/oZyUmtGbW/ZNbWj+pTxFLnEnT54KRhvvP
         OlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737142; x=1724341942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsUSd9Woo/iqPvXMwajq5VMWihmQ0h2yWsEHJq+e+9A=;
        b=Y2rFUKti/YBvBffTZJH7r+ZqqfX+9LUq3wYAh7DhHB2+cYHYtMkv8Dh/MvV0DRpqVA
         KsCuDVPXv9h5wVYhzCXPqMcOvbZO2PZP1gFnElKYj43b1SEM7dXR1te5gPC0NxvMbyQz
         UL1mPSoDdqmV80+czgVeZAbYVeIM+2zdhrM/dnaL0EVU/wKNk/eVCWcEi8KgptuKHnkx
         L2XGNxPnWd3sy6QB4yYDhChh8bYfxEY5vYQAdrmz+glvzliwbGGxD04wQHxAs5wcYojo
         epbQDtow3QEVPQIWYtZsXK+ky6AXAjzxcyP/cYSfkd1PCY3BocYAoAw+d2n6FZqHKgpZ
         HL8A==
X-Forwarded-Encrypted: i=1; AJvYcCV8Pv/S+kmXeE41tB/NDGeEgj/6bFUByIBCN/39IuLVNs7n5wGTDLG87WXlopKvje586+WbDT0rH7kTJiHEpoz/pqmGULBw7iOOFEyq
X-Gm-Message-State: AOJu0Yz8g/J+t9giC23ZaCjZ5RQ8fkAKtH2fTf5yHclDgZmJlg0OGe5x
	o9TiBHeH9KvD2guWyzQh8oHwrHXD9D2fJzEiTa2VQfeqsf8vge8o+8xjNUBhLpnTcVkN9XoJ9IJ
	6bg==
X-Google-Smtp-Source: AGHT+IHMf5W2rCdu8YRq9VXD8sk35Ym0aHc+ICn2snu/UUL0F247jmEidV+J/NhiZtp1ZaUNES3oCsmPNJ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:f3cc:b0:2cd:bbfa:3e5e with SMTP id
 98e67ed59e1d1-2d3e03e9b1emr68a91.7.1723737141799; Thu, 15 Aug 2024 08:52:21
 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:52:20 -0700
In-Reply-To: <20240522001817.619072-13-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522001817.619072-1-dwmw2@infradead.org> <20240522001817.619072-13-dwmw2@infradead.org>
Message-ID: <Zr4kNNUUm4E6R5zC@google.com>
Subject: Re: [RFC PATCH v3 12/21] KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
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
> Let the callers pass the host TSC value in as an explicit parameter.
> 
> This leaves some fairly obviously stupid code, which using this function
> to compare the guest TSC at some *other* time, with the newly-minted TSC
> value from rdtsc(). Unless it's being used to measure *elapsed* time,
> that isn't very sensible.
> 
> In this case, "obviously stupid" is an improvement over being non-obviously
> so.
> 
> No functional change intended.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/x86.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ef3cd6113037..ea59694d712a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2601,11 +2601,12 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio)
>  	return _tsc;
>  }
>  
> -static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
> +static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 host_tsc,
> +				     u64 target_tsc)

Would it make sense to have a __kvm_compute_l1_tsc_offset() version that takes
in the host TSC, and then this?

static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
{
	return __kvm_compute_l1_tsc_offset(vcpu, rdtsc(), target_tsc);
}


Hmm, or maybe a better option would be:

static u64 kvm_compute_current_l1_tsc_offset(struct kvm_vcpu *vcpu,
					     u64 target_tsc)
{
	return kvm_compute_l1_tsc_offset(vcpu, rdtsc(), target_tsc);
}

Meh, after typing those out, I don't like either one.  Let's keep it how you
wrote it, I think there's quite a bit of added readability by forcing callers to
provide the host TSC.

>  {
>  	u64 tsc;
>  
> -	tsc = kvm_scale_tsc(rdtsc(), vcpu->arch.l1_tsc_scaling_ratio);
> +	tsc = kvm_scale_tsc(host_tsc, vcpu->arch.l1_tsc_scaling_ratio);
>  
>  	return target_tsc - tsc;

Opportunistically drop "tsc" too?  E.g.

	return target_tsc -
	       kvm_scale_tsc(host_tsc, vcpu->arch.l1_tsc_scaling_ratio);

or

	return target_tsc - kvm_scale_tsc(host_tsc, vcpu->arch.l1_tsc_scaling_ratio);

I find either of those much easier to read.

