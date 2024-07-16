Return-Path: <linux-kernel+bounces-254442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53C933339
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E87C1F22B91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51261FCE;
	Tue, 16 Jul 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfXvN+pW"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348E1DA4D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164070; cv=none; b=P4RstjE0poPTRLRi2Ac1eZrFlD1kTTt2hppBVwcOWYjN2+H1mFLWJIzVp1aiQlJQIBDGPJTiaE+sFHpJviFNEmEHyU47P8fwycVCLbHFWh4MN3TsjeCc8DE+ywEfrOnc1AQFf5Ft5zlFMI731lvoi3CHdhhbK7uZ6cKKycZkt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164070; c=relaxed/simple;
	bh=xLwRgUEtiPeGNCRhFb5N/RLWBiXreg5PFnjrBVpkX2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qI9mik5ZM9rGuBOdm6SbduS14AL4Um4rykHFF0eump2S9FtJgqGfUVT9/5Hu55ET6SFgNoe4pkVSUzdy2B49f6GfT1o3P1q8czjPqhtIr0s4DrukdJC4Pw3wpuk9EAKsg5NlGg+Q7E04O+d1YH89uzyQ6B416UNyxy3IK2b0f0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfXvN+pW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70af524f6b9so3846697b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721164068; x=1721768868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNSo8wMNtEPJpK++67iaBSDns70oXM/KSOlCgrXK7Ls=;
        b=kfXvN+pWHTOTSPJ9vKnt+4qRZOjn0USYnd6msb0dp5dWQ4RsKk5/6wfrFPGUgbIfMS
         YM2hsKo+J/NdZL6mMg0YjaC1bs9zycqqXbssoDEbCfL3smIsbE6deLb4I5e0dNqTZphd
         R1NJAG6vJAe4JNpcp01puFMB6iE4w5yw/0SkK2Ypuses3T9dQ9vAHLsshqfPYVgnYN67
         M1GYWfb5DIqgMiLHIrxklGMiqbDb+SnW56aIQlaHWdzYybUXHEs1/4bA/sfImciKbXbQ
         qtAN5O+G+xur7yJoEUmXtlqmXQGjbfHbxQgUOhbkxih3GIRF+6DLjN4GBcmQhZLLcHUg
         mTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721164068; x=1721768868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNSo8wMNtEPJpK++67iaBSDns70oXM/KSOlCgrXK7Ls=;
        b=egibMdRTdeclMpGOP/q1tnVsP7kayudb7oEvbP4yFsP6J/yd95GMeHuSY65v7xp8L7
         0xW85nHPo92i7viBWdqdFDerZ1K+ketshWH8goEiEG6Ke3lYeLWYgjEt4He4nPOlt4CL
         oL9W+cPIvFm1LmpuxbFLZDK2FPwjzOqNNbXTZdC9x/ocFk8J8TRb8Dh+Apg+XWGtAmyA
         Ec9qIx6PQQBW4yfqkBvqM7mfZ8tpTUScHyE1IT14JAPDUGyB/qJtiASmboGGpqlOTI6X
         ZlRZf4L+rIzbqOxRW02VPO2zhyEiYDpe27UMoSNHZa1AWKJf+sDOQRL9TS6d0R9r6vAF
         7L/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7lZBsx80l35F+kRIutlgBWuVZVjKT9gL1Jq2xrSLQ4Tml/gAOMub8WqWo6tM+D7MdYdM0LpHMZ7L4bllvaz8WNlcgO4eMGCXtkk42
X-Gm-Message-State: AOJu0YwjxdXq+Wn6mvEmjxFpSgX7cxSIe7vv92KqhYhiPAaqArt/jOIa
	ORJSBeHGn9uCY7odKyUwkOAYoGiAlRBrVTmFLG6k97uWqlZhPu7N29lXHIivyxC0KDoEDhgJn2e
	9dA==
X-Google-Smtp-Source: AGHT+IGLUH/Jz3hz7GJ232DTMeLmfXv2NQE7AIuBmDXbxZsUvaIwKAcy8kB9Zc33im3CkpfiA8pCvnHmHFw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1993:b0:706:5ca6:1c6b with SMTP id
 d2e1a72fcca58-70c1fb39f34mr252936b3a.1.1721164067842; Tue, 16 Jul 2024
 14:07:47 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:07:46 -0700
In-Reply-To: <20240716022014.240960-2-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240716022014.240960-1-mlevitsk@redhat.com> <20240716022014.240960-2-mlevitsk@redhat.com>
Message-ID: <ZpbhItUq-p_emFUT@google.com>
Subject: Re: [PATCH v2 1/2] KVM: nVMX: use vmx_segment_cache_clear
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 15, 2024, Maxim Levitsky wrote:
> In prepare_vmcs02_rare, call vmx_segment_cache_clear, instead
> of setting the segment_cache.bitmask directly.
> 
> No functional change intended.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 5 +++--
>  arch/x86/kvm/vmx/vmx.c    | 4 ----
>  arch/x86/kvm/vmx/vmx.h    | 5 +++++
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 643935a0f70ab..d3ca1a772ae67 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2469,6 +2469,9 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  
>  	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
>  			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
> +
> +		vmx_segment_cache_clear(vmx);
> +
>  		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
>  		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
>  		vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
> @@ -2505,8 +2508,6 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  		vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
>  		vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
>  		vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
> -
> -		vmx->segment_cache.bitmask = 0;

This actually exacerbates the bug that you're trying fix in patch 2.  Clearing
segment_cache.bitmask _after_ writing the relevant state limits the stale data
to only the accessor that's running in IRQ context (kvm_arch_vcpu_put()).

Clearing segment_cache.bitmask _before_ writing the relevant statement means
that kvm_arch_vcpu_put() _and_ all future readers will be exposed to the stale
data, because the stale data cached by kvm_arch_vcpu_put() won't mark it invalid.

