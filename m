Return-Path: <linux-kernel+bounces-512585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF8A33B21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B105188B889
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E6C20CCC4;
	Thu, 13 Feb 2025 09:24:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEB820A5DC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438674; cv=none; b=U1RjrIrUe1d4t55h/ME7Rkmicq59y0nwzQ2p0Th0ihZIZQueyw1CE0kSA5/6SYplWa8gkUqn+EsoHeiyL0Si8RQWDe3V2+NMvLqJK6NNnngoQH4bvZKNCqZ8fI8gk6qDZonEI2Q94Wq2aL8930ZX+Wwvlk/n49LW30gCV1dVzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438674; c=relaxed/simple;
	bh=iqZX9vlmTh8Gz3IOozatDHf855QCyukvJ48qmfrPENU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4lkXPZ3yzzpJn9GXGpw7u2bkBalrCaIIGhaU/ftuw8w8wcptpguQnnejE3uMhpuFeiGwJemwt6egxnBBnvuRPL5++Z4XH800L94juqWAJkxEbxDSc8fM77Mb0sqX3kXH/Z76T1Xe8WkQXty4Zj6vuBvUxvUAwCuhjHVKSMsTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE7BE16F3;
	Thu, 13 Feb 2025 01:24:51 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77FCF3F58B;
	Thu, 13 Feb 2025 01:24:29 -0800 (PST)
Date: Thu, 13 Feb 2025 09:24:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v7] KVM: arm64: Fix confusion in documentation for pKVM
 SME assert
Message-ID: <Z626RqzA3HMskwJd@J2N7QTR9R3>
References: <20250212-kvm-arm64-sme-assert-v7-1-0f786db838d3@kernel.org>
 <Z6yByMUBPDUyEWOr@J2N7QTR9R3>
 <86tt8yrzon.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86tt8yrzon.wl-maz@kernel.org>

On Thu, Feb 13, 2025 at 08:55:52AM +0000, Marc Zyngier wrote:
> On Wed, 12 Feb 2025 11:11:04 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Feb 12, 2025 at 12:44:57AM +0000, Mark Brown wrote:
> > > diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> > > index 4d3d1a2eb157047b4b2488e9c4ffaabc6f5a0818..e37e53883c357093ff4455f5afdaec90e662d744 100644
> > > --- a/arch/arm64/kvm/fpsimd.c
> > > +++ b/arch/arm64/kvm/fpsimd.c
> > > @@ -93,11 +93,14 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
> > >  	}
> > >  
> > >  	/*
> > > -	 * If normal guests gain SME support, maintain this behavior for pKVM
> > > -	 * guests, which don't support SME.
> > > +	 * Protected and non-protected KVM modes require that
> > > +	 * SVCR.{SM,ZA} == {0,0} when entering a guest so that no
> > > +	 * host/guest SME state needs to be saved/restored by hyp code.
> > > +	 *
> > > +	 * In protected mode, hyp code will verify this later.
> > >  	 */
> > > -	WARN_ON(is_protected_kvm_enabled() && system_supports_sme() &&
> > > -		read_sysreg_s(SYS_SVCR));
> > > +	WARN_ON_ONCE(is_protected_kvm_enabled() && system_supports_sme() &&
> > > +		     read_sysreg_s(SYS_SVCR));
> > 
> > As I mentioned on the last round, we can drop the is_protected_kvm_enabled()
> > check, i.e. have:
> > 
> > 	/*
> > 	 * Protected and non-protected KVM modes require that
> > 	 * SVCR.{SM,ZA} == {0,0} when entering a guest so that no
> > 	 * host/guest SME state needs to be saved/restored by hyp code.
> > 	 *
> > 	 * In protected mode, hyp code will verify this later.
> > 	 */
> > 	WARN_ON_ONCE(system_supports_sme() && read_sysreg_s(SYS_SVCR));
> > 
> > Either way:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Marc, are you happy to queue this atop the recent fixes from me? Those
> > try to ensure SVCR.{SM,ZA} == {0,0} regardless of whether KVM is in
> > protected mode.
> 
> In all honesty, I find that at this stage, the comment just gets in
> the way and is over-describing what is at stake here.
> 
> The
> 
>  	WARN_ON_ONCE(system_supports_sme() && read_sysreg_s(SYS_SVCR));
> 
> is really the only thing that matters. It perfectly shows what we are
> checking for, and doesn't need an exegesis.
> 
> As for the Fixes: tag, and given the magnitude of the actual fixes
> that are already queued, I don't think we need it.

That's fair; if you haven't spun a patch for that already, I guess we're
after the following?

Mark.

---->8----
From 4d05f6dd6d39c747c175782b7b44daa775251994 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 13 Feb 2025 09:15:31 +0000
Subject: [PATCH] KVM: arm64: Simplify warning in kvm_arch_vcpu_load_fp()

At the end of kvm_arch_vcpu_load_fp() we check that no bits are set in
SVCR. We only check this for protected mode despite this mattering
equally for non-protected mode, and the comment above this is confusing.

Remove the comment and simplify the check, moving from WARN_ON() to
WARN_ON_ONCE() to avoid spamming the log.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kvm/fpsimd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 3cbb999419af7..7f6e43d256915 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -65,12 +65,7 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 	fpsimd_save_and_flush_cpu_state();
 	*host_data_ptr(fp_owner) = FP_STATE_FREE;
 
-	/*
-	 * If normal guests gain SME support, maintain this behavior for pKVM
-	 * guests, which don't support SME.
-	 */
-	WARN_ON(is_protected_kvm_enabled() && system_supports_sme() &&
-		read_sysreg_s(SYS_SVCR));
+	WARN_ON_ONCE(system_supports_sme() && read_sysreg_s(SYS_SVCR));
 }
 
 /*
-- 
2.30.2


