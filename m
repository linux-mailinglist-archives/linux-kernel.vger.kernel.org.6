Return-Path: <linux-kernel+bounces-234178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8619A91C353
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFD52822B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF71C8FDA;
	Fri, 28 Jun 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACrxuD85"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF461BE25A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590959; cv=none; b=OPrNRMl6DxvDRrIz0+/NsJeyM4hXFyXKYS77dKmkedFMltjAd1EF75O/h2pISnfjOcIdP2/FGmEAyGgiJOmMMY3U2zUoGle2oYYaX+Gc2QBhmcFLFoa14xA9Fmu2pxtz6pwWdJeEYtanVOsz1Mnsimr3Hkv9gUFTTWhhOnqhVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590959; c=relaxed/simple;
	bh=xSiS5VbBTWtHkMjKE2FM2x8QgKqasXrVFPcpXxJBCgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mocUPUB7smI9EO4j69yov+hRBcaqxyuAfSTdZONUMBv0HAhnWSQzcOD0C0w560o909uXA+k+Dp1zfxEZZcP0Dp7k20FRzKTi1Rq/oNbino+xJBwOgm2/jVTibEDCYL80c80PyKMFnSfThY5+fOZvqMg2iXUqtEP0xxvFSTKTcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ACrxuD85; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bf44b87d4so8334627b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719590957; x=1720195757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dLquM4FkT/DoL6SKER0hksUwO28Urfz4ARvtIF4KV8=;
        b=ACrxuD85npxF2sDckIotp0Zetm0RVFfhRzm4nDfgqWP7MfB5RWNKnL3J3Bn+qZ+kFS
         56ywuwwvhT6HMl0wfQEqxdAmuiEejUEVc7JdR+04ABJUbzxX1KfIhzhJqaLZa8umEio2
         QLNHTSbART3obQGDdUu8AJ3bEaLvfsIvRfDawauPfY1+bQaNxm6pgeNXczdhws4xkQ+x
         bYx0F/f/HO6bDM8MK0MMUdv0tLPvhpASLf3tNhqOZjO0tsHcH0EUDwzhRf/ZbmGRqAEp
         xp1RQS8xy7KWipIAzMqX1jB19PYmMYIQRHnfrNQuxqrckYQ8Jscjfre4O88ayU+GCfG2
         4o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719590957; x=1720195757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dLquM4FkT/DoL6SKER0hksUwO28Urfz4ARvtIF4KV8=;
        b=e8i5GwbBB62CKyIJAZq9xi//reUJWklqdOE3NDK5O+ywobt0AfogsvgsP3hEV0Fdcb
         mUmbEUIZm5sAFaAvk21FMyuSEklCwqS1cnHpYxZJ0Dl3MmANvpUY4LE7m96jEgL68i/J
         LJX4ofprVXgFPGYOhYZYsAG7rMAq5IZGNbjal4k1qTNSQjQz2SR6DiZtKrvlxg31MdeH
         hO2WAgwtWIl73ffNLNksMScOLt++k+05b34ZTeRNx8Jxwi58qNAQWtnD+NNIT41tzrXv
         +9dpbfRBDLMciIILT3bUwLX7lPT7cYEI+hQyl7b9Ylvg1yx+S7yKB9wqDC2LXxUIfMzk
         moPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfbayi61BZhaXfT92DiRVOuglQVMIoFmCp6NI/6VpWNvaKhOnCl7GVFK/6NN37hBSGK/lt03mxe+1q7y7XY2rWxBw3bu/9EY2gnXbD
X-Gm-Message-State: AOJu0YwwrDV5Sn6P/wAJ1wgY37CHe5Lb6MhkEyAnNFlB2Ys+NTHL8R63
	+s06B8Oy/CJkUMVy/D77utEULkjed/AISnQaop8rNOoN2IbLecY9GPeM7duoQyb0dBjfVc92q+E
	J/g==
X-Google-Smtp-Source: AGHT+IHJY/lTxp/95vjfGeiS7oXbM4P6tRf14ezu1AV3VayEqpmqGBX9AHi66wPOpt9anlmG2eQslSmpJn4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:8451:0:b0:627:edcb:cbe2 with SMTP id
 00721157ae682-64af5dfeb07mr216687b3.5.1719590957359; Fri, 28 Jun 2024
 09:09:17 -0700 (PDT)
Date: Fri, 28 Jun 2024 09:09:15 -0700
In-Reply-To: <20240626073719.5246-1-amit@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626073719.5246-1-amit@kernel.org>
Message-ID: <Zn7gK9KZKxBwgVc_@google.com>
Subject: Re: [PATCH v2] KVM: SVM: let alternatives handle the cases when RSB
 filling is required
From: Sean Christopherson <seanjc@google.com>
To: Amit Shah <amit@kernel.org>
Cc: pbonzini@redhat.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, amit.shah@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kim.phillips@amd.com, david.kaplan@amd.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 26, 2024, Amit Shah wrote:
> ---
>  arch/x86/kvm/svm/vmenter.S | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
> index a0c8eb37d3e1..2ed80aea3bb1 100644
> --- a/arch/x86/kvm/svm/vmenter.S
> +++ b/arch/x86/kvm/svm/vmenter.S
> @@ -209,10 +209,8 @@ SYM_FUNC_START(__svm_vcpu_run)
>  7:	vmload %_ASM_AX
>  8:
>  
> -#ifdef CONFIG_MITIGATION_RETPOLINE
>  	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
> -	FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
> -#endif
> +	FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT

Out of an abundance of paranoia, shouldn't this be?

	FILL_RETURN_BUFFER %_ASM_CX, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT,\
			   X86_FEATURE_RSB_VMEXIT_LITE

Hmm, but it looks like that would incorrectly trigger the "lite" flavor for
families 0xf - 0x12.  I assume those old CPUs aren't affected by whatever on earth
EIBRS_PBRSB is.

	/* AMD Family 0xf - 0x12 */
	VULNWL_AMD(0x0f,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
	VULNWL_AMD(0x10,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
	VULNWL_AMD(0x11,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
	VULNWL_AMD(0x12,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),

	/* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't work */
	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB | NO_BHI),
	VULNWL_HYGON(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB | NO_BHI),

>  
>  	/* Clobbers RAX, RCX, RDX.  */
>  	RESTORE_HOST_SPEC_CTRL
> @@ -348,10 +346,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
>  
>  2:	cli
>  
> -#ifdef CONFIG_MITIGATION_RETPOLINE
>  	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
> -	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
> -#endif
> +	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT
>  
>  	/* Clobbers RAX, RCX, RDX, consumes RDI (@svm) and RSI (@spec_ctrl_intercepted). */
>  	RESTORE_HOST_SPEC_CTRL
> -- 
> 2.45.2
> 

