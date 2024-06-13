Return-Path: <linux-kernel+bounces-213697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D299078DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E3A1C235BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E714A081;
	Thu, 13 Jun 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPSXC9he"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94D26AF0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297744; cv=none; b=HNWQ4vCjEoI3UjX/FvZ/BvEhxvOO2BH7Ty/CSHE0KJJLTSST488/i8x1KaqETdLWJPMv10F4xa2pCYuvypNYTf2WRHm8FOOtCY6Ivv6nsVU1EpBPsi8T2uiAIPzVbea65b4Ekm6JA4akPlxUpNnkGyH+i7whWYEOVtHxGgMuEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297744; c=relaxed/simple;
	bh=JBcO41UleHNq3lhHasPs977C4yzTa+av52awcjkovk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pjMnFZf228kcvm1NcXmL7qLoYy1HBV6+dlXEJRBhG228pNmn4haV43JsJx7+YDkxXP6kdWR5dlQW7Rgpv8Iamnw86bV4csj7lKOowh8BzLhz+wloZoutrca8OhKQoabMFwNyY3yHqSaCIeJjg7TauBBa8CFaEODu/u9s55zfCGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPSXC9he; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfefc2c8569so2389813276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718297741; x=1718902541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9CYt9bUQNxiXkzpZqytzyg53ZWv58TJdgtMwrRPm6U=;
        b=lPSXC9heprNeF8vL2j4xpLJh3aiTpXy9XicaYRrOPgkQlY8jqYcB26meROjBBxof19
         aKypBhw7bwuWFGZP5z3t/bWSVqHFDQHwXTVXEZRvdMU8mkGtXPIjG4r/NNYSsOp8Hqj2
         oIrIEZMQ4d2UfQ5Rgperkj9Zb9KmyDQ33LAsFYNunEI0P3ZqpWfKtx1hKOFfe7zdyUgx
         Dw45r6nR9vOREuYDYzDAxYchjT/tKPWhUwLk89rmY2MDGcCg/mPG+jeo8z3ncHn5DQhS
         tZAgHZUL8/PpBWlGwB+2X2ePpqD86UTrpYVE/lVKZr8ZY8ORn783y2l4M79pozTSrQ00
         34IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297741; x=1718902541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9CYt9bUQNxiXkzpZqytzyg53ZWv58TJdgtMwrRPm6U=;
        b=Z5RKLec/ryRFIIqkD+5RBfS1eMlpLYnHTyzlWf4ZyXZjWabNoMRgBACNp5mSufv6oo
         k4jsoPycJoxJeVghPHN0zachxahJLTJ8pIBGmnFLXJXdsEO98LsuzH32qJ2kA8gk6v4j
         ZrhFmk4mDvtHEFxuSJkGyBM7NM2WqFIsJ8AWV4FjwoyEn+gNS3di6t9Tc1c5fUAB4o4/
         4ghUYGFt2GBm+wyibI/sCwJrta8BrOVigdVMRUwFKA581QHDrLZaMlzaUzDcKlcyObGp
         PPTXM4xMuvLMSgl+GahedjDBjoHECmgerN4eXjni4q8O0duPBPRUl9mkBr6voj6lCTCC
         pgGQ==
X-Gm-Message-State: AOJu0Yx2hi3A3dVEYeTY3oFRvDSA0otugJs04l6GG8qmROCU5sNAY0ni
	d6tRQUnZObtNqFJLp7qImPuTiBaL48P6puCQrWii4rLNHEB3m7uikMIO/In6/tseeIm5WzZUYkg
	tmw==
X-Google-Smtp-Source: AGHT+IHCQlTH8aUKVHWrREgqElX3I3HQvj6sWaaSxtbwu4nlawWKgv1Yel798rbyLMa4rUaGweqDKSAm9QU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100f:b0:dfd:d6ec:4e3b with SMTP id
 3f1490d57ef6-dff15399367mr1866276.7.1718297740902; Thu, 13 Jun 2024 09:55:40
 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:55:39 -0700
In-Reply-To: <20240207172646.3981-12-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-12-xin3.li@intel.com>
Message-ID: <Zmski7ixgWOE7Snl@google.com>
Subject: Re: [PATCH v2 11/25] KVM: x86: Add kvm_is_fred_enabled()
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Xin Li wrote:
> Add kvm_is_fred_enabled() to get if FRED is enabled on a vCPU.
> 
> Signed-off-by: Xin Li <xin3.li@intel.com>
> Tested-by: Shan Kang <shan.kang@intel.com>
> ---
> 
> Change since v1:
> * Explain why it is ok to only check CR4.FRED (Chao Gao).
> ---
>  arch/x86/kvm/kvm_cache_regs.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
> index 75eae9c4998a..1d431c703fdf 100644
> --- a/arch/x86/kvm/kvm_cache_regs.h
> +++ b/arch/x86/kvm/kvm_cache_regs.h
> @@ -187,6 +187,23 @@ static __always_inline bool kvm_is_cr4_bit_set(struct kvm_vcpu *vcpu,
>  	return !!kvm_read_cr4_bits(vcpu, cr4_bit);
>  }
>  
> +/*
> + * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
> + * a vCPU is running with FRED enabled, because:
> + * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
> + * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
> + *
> + * More details at FRED Spec 6.0 Section 4.2 Enabling in CR4.

Please don't reference specific sections/tables/fields in comments.  They always
become stale.  And the code+comments always reflect the current state, i.e. don't
need to worry about spec revisions and whatnot.  If there is a spec change, then
there darn well needs to be a way for software to differentiate old vs. new, at
which point there will be accompanying code to capture the difference.

Even in changelogs, references specific specs by section number is usually
discouraged.  Again, it shouldn't matter if its FRED spec 6.0 vs. spec 5.0,
because if there is a difference between those two, then the code better be
different too.

Instead, for the changelog, if it's really necessary/helpful, reference the section
by name and/or keyword, as those are much less likely to become stale.

> + */
> +static __always_inline bool kvm_is_fred_enabled(struct kvm_vcpu *vcpu)

This doesn't need to be __always_inline, it's not used from a noinstr section.
kvm_is_cr4_bit_set() is  __always_inline so that @cr4_bit is guaranteed to be a
compile-time constant, otherwise the BUILD_BUG_ON() would fail.

