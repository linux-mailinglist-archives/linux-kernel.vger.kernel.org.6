Return-Path: <linux-kernel+bounces-319384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1214E96FBD9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90A51F22A19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352341D2F7D;
	Fri,  6 Sep 2024 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sw+z/cbt"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85621C86FB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649888; cv=none; b=AJ3AyH0Vig75+6dW47mjGBs2vUOpxoaeX7pCsJ6j8ruSQCZ7d9B+hWLjAmNtS4Agp3ScThcyaAzIr04/f9p7tB+Ew3L4tMkSWh41e4b3L9pn+kPp3lHzMDrp8Be6teu5RgtbB5RkrAWhIeH9TPrz3YGEKETEhPph/FS5m5lkLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649888; c=relaxed/simple;
	bh=6TNn8+lHfCcEkHZyuNAq5M7dD7gnucn0H0fd52AI5Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+s/ULHJML/tab9Un+RHI5Uf8bjvfjATdxRbsw7FCnuMWOgGNgmF0WPD672WiK4PJzVguxZLYMCSLAjleJpdLCYQo0joRAvgJkkXuf3X5S9Rj00oVDQLfcCgZjZ4CBP7I15+5pVoqwRZpH9EZanoXlxWiSnpPWg8c3r3OUOsmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sw+z/cbt; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 12:11:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725649883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vvF+by9Cq7Jpk7yCycOnruqpPFbO3RQsR0w5/z3Sk8M=;
	b=sw+z/cbtovcwqH6EtEzp4F7zRxLFR1/S+BKd9UorVP+/PmJv43JhZczuZml0tSZHAcm6TY
	z8oge9kZYaVDKYUwh5nF6s6qQcc1k6lWQGJH/fE7dtQWGWuzsUGicFNTqbhZJBQVjxhHxf
	pGoIfncO08gYoy1UXraMBQCuH2YvRfo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tom Dohrmann <erbse.13@gmx.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH] KVM: x86: Only advertise KVM_CAP_READONLY_MEM when
 supported by VM
Message-ID: <y2vqv2k6b3ytwgvxkhl3jlxx2lpfcla6zigccuo426zp63lqgl@zvdztkpwuxed>
References: <20240902144219.3716974-1-erbse.13@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902144219.3716974-1-erbse.13@gmx.de>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 02, 2024 at 02:42:19PM GMT, Tom Dohrmann wrote:
> Until recently, KVM_CAP_READONLY_MEM was unconditionally supported on
> x86, but this is no longer the case for SEV-ES and SEV-SNP VMs.
> 
> When KVM_CHECK_EXTENSION is invoked on a VM, only advertise
> KVM_CAP_READONLY_MEM when it's actually supported.
> 
> Fixes: 66155de93bcf ("KVM: x86: Disallow read-only memslots for SEV-ES and SEV-SNP (and TDX)")
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
> ---
>  arch/x86/kvm/x86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 70219e406987..9ad7fe279e72 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4656,7 +4656,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ASYNC_PF_INT:
>  	case KVM_CAP_GET_TSC_KHZ:
>  	case KVM_CAP_KVMCLOCK_CTRL:
> -	case KVM_CAP_READONLY_MEM:
>  	case KVM_CAP_IOAPIC_POLARITY_IGNORED:
>  	case KVM_CAP_TSC_DEADLINE_TIMER:
>  	case KVM_CAP_DISABLE_QUIRKS:
> @@ -4815,6 +4814,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_VM_TYPES:
>  		r = kvm_caps.supported_vm_types;
>  		break;
> +	case KVM_CAP_READONLY_MEM:
> +		r = kvm ? kvm_arch_has_readonly_mem(kvm) : 1;

Need a break here otherwise -Wimplicit-fallthrough option will warn.

>  	default:
>  		break;
>  	}
> --
> 2.34.1

