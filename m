Return-Path: <linux-kernel+bounces-442241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349809ED9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B27A282659
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D011F2C53;
	Wed, 11 Dec 2024 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zdTAouF9"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DB1F0E59
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956066; cv=none; b=AKRXjcU14L7+vMPaAUtA7pLHmf/PzuxQO2+SFDHAJlaFoPn+LfDtZ+4rz8NMbPScHnuhPJNlOJI/ccpOzX9MdliVuMgfNn6v8loa27POhkKz9S6/jJ56zaOUZb3jAI2fi9ZyGRFaOGw4SkTUENBgegyA2Mb+ENczYippVM41EVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956066; c=relaxed/simple;
	bh=zfvlbXt0pmSzkKhbUQaTnd9GPrIIyhoIklT1xW6Pt7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fGtPZHXiMISpFHCXaLa+TlR+wCUi2O/Z68eFVgLF8BVg5H3WVbQ8Q9sswOAo1TYgQCr5kPJ8u1Cf7J9ExeUiDot10c3eK311Wjov6PXn3NKg9kvSMMJvlqDD9dDex+N2uAFBWIQFVwwsSHkDkZXlc8cKJgNFELGF68gi6gd4Vlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zdTAouF9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fd561e68d9so9981a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733956065; x=1734560865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Baoz8HDL/9D+jzuoT41t0AkYhSUuididMmHyAXJrHww=;
        b=zdTAouF9XMk67ZfPM0jr0BrmI1e9RAsxvDwtitBmOn0vXcH9GckrVU14cz3g1CjyQd
         bbu/NN/4nHJKmdTpf+fyXhcpibcksYI3LSjk1jjUBbydbL6rDlRM0pvFD6JMudxwg5/P
         xlTc8yKRGOjwoj/RvRsQsYe2Yt25l6SgOvnpBKUPxs5KwUrXK5b4XyIbT3G1WI/90NY1
         Vn60UVbWFk/mr+Gd7R6lzgpvs0y4569bKxzEaYhNCCcOcw9oxKpO+Gkyk7GQMz4cdRBH
         a7RlAqGUDLHeF8C/JaV1UOZ6Png40PVO9btbFwfwn4h/chPNZvRQnNZ8HUy5el6fDD/g
         IJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956065; x=1734560865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Baoz8HDL/9D+jzuoT41t0AkYhSUuididMmHyAXJrHww=;
        b=ivMBwyB1mE18h1fvn1MDecKBVN/V2luIgVC3xPO2D9g6pnOXx2+7vtPcKRm0LZ1Apj
         LAmKQGyhjWliavDCTNKRPgVkLSjrEDc7Sg1OKO/1/JFWWCMcdf0ov4vgpFoe5UxGqwz2
         kCdSimK6nt4K6TZv/55cI/QRKF4mzclSFxa+H63V6i6KpboDD5oKdzyhCwz6fke2hc5K
         PzOkAjvZYVR4ynAa0tI6fzm69juvGV7v1dPkvMXHaATcZu8QH9yEdFY9OMHOs6HjuJbx
         NBDMuxwFGMt1up/MLy6BT7oFPt088uuyAMR2C0fsNX5hzhVApwEx55wfnBCCSBxe3aiA
         qSRg==
X-Forwarded-Encrypted: i=1; AJvYcCUfolYDhfedCB4kUAgufDzK9RgEKvIIcEuJEuxMQQr1y4YiAkwzJdZXR3la+cQMD5CCrk1OOA8bP7ijmK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygtCFh2S2D3DDVb2bbkZEgOnAaG5YPb0XQtm2/n/mgB3OHEPJO
	lUJq08w3Z1EcVkEqtFhQ8J5UWHtcC/nADn2Fs3PE+AcyqWDH7oX8YyrjeUnIRrkdtBD2Monzw8c
	R2g==
X-Google-Smtp-Source: AGHT+IF7Glp3nlBE0Tq75FWGp2Z+wd30I0Kg/yL9mErCj7/SwuZKuKJdgZl+9j5Z7gC8Ntc4Kg3i9rHQuKw=
X-Received: from pjbqd13.prod.google.com ([2002:a17:90b:3ccd:b0:2ef:8ef8:2701])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f86:b0:2ef:31a9:95c6
 with SMTP id 98e67ed59e1d1-2f139293c58mr2630585a91.14.1733956064657; Wed, 11
 Dec 2024 14:27:44 -0800 (PST)
Date: Wed, 11 Dec 2024 14:27:42 -0800
In-Reply-To: <20241202120416.6054-4-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202120416.6054-1-bp@kernel.org> <20241202120416.6054-4-bp@kernel.org>
Message-ID: <Z1oR3qxjr8hHbTpN@google.com>
Subject: Re: [PATCH v2 3/4] x86/bugs: KVM: Add support for SRSO_MSR_FIX
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@kernel.org>
Cc: X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	KVM <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 02, 2024, Borislav Petkov wrote:
> diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
> index 2ad1c05b8c88..79a8f7dea06d 100644
> --- a/Documentation/admin-guide/hw-vuln/srso.rst
> +++ b/Documentation/admin-guide/hw-vuln/srso.rst
> @@ -104,7 +104,17 @@ The possible values in this file are:
>  
>     (spec_rstack_overflow=ibpb-vmexit)
>  
> + * 'Mitigation: Reduced Speculation':
>  
> +   This mitigation gets automatically enabled when the above one "IBPB on
> +   VMEXIT" has been selected and the CPU supports the BpSpecReduce bit.
> +
> +   Currently, the mitigation is automatically enabled when KVM enables
> +   virtualization and can incur some cost. 

How much cost are we talking?

>  static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
> @@ -2665,6 +2667,12 @@ static void __init srso_select_mitigation(void)
>  
>  ibpb_on_vmexit:
>  	case SRSO_CMD_IBPB_ON_VMEXIT:
> +		if (boot_cpu_has(X86_FEATURE_SRSO_MSR_FIX)) {
> +			pr_notice("Reducing speculation to address VM/HV SRSO attack vector.\n");
> +			srso_mitigation = SRSO_MITIGATION_BP_SPEC_REDUCE;
> +			break;
> +		}
> +
>  		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
>  			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
>  				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index dd15cc635655..e4fad330cd25 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -608,6 +608,9 @@ static void svm_disable_virtualization_cpu(void)
>  	kvm_cpu_svm_disable();
>  
>  	amd_pmu_disable_virt();
> +
> +	if (cpu_feature_enabled(X86_FEATURE_SRSO_MSR_FIX))
> +		msr_clear_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
>  }
>  
>  static int svm_enable_virtualization_cpu(void)
> @@ -685,6 +688,9 @@ static int svm_enable_virtualization_cpu(void)
>  		rdmsr(MSR_TSC_AUX, sev_es_host_save_area(sd)->tsc_aux, msr_hi);
>  	}
>  
> +	if (cpu_feature_enabled(X86_FEATURE_SRSO_MSR_FIX))
> +		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);

IIUC, this magic bit reduces how much the CPU is allowed to speculate in order
to mitigate potential VM=>host attacks, and that reducing speculation also reduces
overall performance.

If that's correct, then enabling the magic bit needs to be gated by an appropriate
mitagation being enabled, not forced on automatically just because the CPU supports
X86_FEATURE_SRSO_MSR_FIX.

And depending on the cost, it might also make sense to set the bit on-demand, and
then clean up when KVM disables virtualization.  E.g. wait to set the bit until
entry to a guest is imminent.

