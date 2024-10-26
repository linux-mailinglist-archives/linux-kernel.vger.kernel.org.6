Return-Path: <linux-kernel+bounces-383222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD79B189E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C709282FAD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAA51804A;
	Sat, 26 Oct 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F2IYVKt9"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154DDEAD0
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729953338; cv=none; b=Ah/Q9IXom7qeoH69HSyqhIAJHPwhNPmM52iE12+Bj4/sQjkkJVYX741eqgRdq6YVY0fNxD0zf4Mix/tnWxgA0dLuU5dEn4rEBUDOx309DmbYswUHZnmtjyg8j8UOoUXyAwuZXSnERsVNBuGQi9WjtUjuZiWkLqeUB+dwQxADzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729953338; c=relaxed/simple;
	bh=deGo36gnajoWP+DowAn/iMIyx/awPKKXNmEJ26vjqmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2GLA0v0LwzxGZvixmMfOkBVGZducBcG/ECvSjQehgwoo6J3MgcYA2f4fG/NAe6FygpsgcLkMtnL1ImjVXrQMoLGJUTxmlO4EzNEZG0bsuwXpuFwGBV4xUXUcldvNYU7bPLgQQYA6popbSFcvDb8SWmw0n7zuYc6eAo4jI4T+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F2IYVKt9; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 26 Oct 2024 14:35:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729953332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFmQ3g+4IAepm2mpZZIQvyrjJDFwDM0PVhWAGARzdh0=;
	b=F2IYVKt9wwTeWiNFOGahnxdxOpcgp+X0rGKqdi4PqbQICyB4SfSARm0Xpljy1aYEwkn6Bl
	oCYeG0DFz7Z93sbK5WE3peOEVOaWehi7dBCwiLLjomlOxzNveqUYWzWEeMmxcdIij2coZi
	ETkOmQtFcMi1girOaHrfX7jRS2MkEhs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/18] KVM: arm64: nv: Reinject traps that take effect
 in Host EL0
Message-ID: <Zxz-LocgUKuzE3t0@linux.dev>
References: <20241025182354.3364124-1-oliver.upton@linux.dev>
 <20241025182354.3364124-9-oliver.upton@linux.dev>
 <87r083th7m.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r083th7m.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hey,

On Sat, Oct 26, 2024 at 09:13:17AM +0100, Marc Zyngier wrote:
> On Fri, 25 Oct 2024 19:23:43 +0100,
> Oliver Upton <oliver.upton@linux.dev> wrote:
> > 
> > Wire up the other end of traps that affect host EL0 by actually
> > injecting them into the guest hypervisor. Skip over FGT entirely, as a
> > cursory glance suggests no FGT is effective in host EL0.
> 
> Yes, and this (thankfully) is by design! :-)
> 
> > 
> > Note that kvm_inject_nested() is already equipped for handling
> > exceptions while the VM is already in a host context.
> > 
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> >  arch/arm64/include/asm/kvm_emulate.h |  5 +++++
> >  arch/arm64/kvm/emulate-nested.c      | 29 ++++++++++++++++++++++++----
> >  2 files changed, 30 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index a601a9305b10..bf0c48403f59 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -225,6 +225,11 @@ static inline bool is_hyp_ctxt(const struct kvm_vcpu *vcpu)
> >  	return vcpu_has_nv(vcpu) && __is_hyp_ctxt(&vcpu->arch.ctxt);
> >  }
> >  
> > +static inline bool vcpu_is_host_el0(const struct kvm_vcpu *vcpu)
> > +{
> > +	return is_hyp_ctxt(vcpu) && !vcpu_is_el2(vcpu);
> > +}
> > +
> >  /*
> >   * The layout of SPSR for an AArch32 state is different when observed from an
> >   * AArch64 SPSR_ELx or an AArch32 SPSR_*. This function generates the AArch32
> > diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
> > index e1a30d1bcd06..db3149379a4d 100644
> > --- a/arch/arm64/kvm/emulate-nested.c
> > +++ b/arch/arm64/kvm/emulate-nested.c
> > @@ -20,6 +20,9 @@ enum trap_behaviour {
> >  	BEHAVE_FORWARD_READ	= BIT(0),
> >  	BEHAVE_FORWARD_WRITE	= BIT(1),
> >  	BEHAVE_FORWARD_RW	= BEHAVE_FORWARD_READ | BEHAVE_FORWARD_WRITE,
> > +
> > +	/* Traps that take effect in Host EL0, this is rare! */
> > +	BEHAVE_IN_HOST_EL0	= BIT(2),
> 
> nit: BEHAVE_IN_HOST_EL0 lacks an action verb (forward?).

Thinking I'll squash this in (plus renaming in later patches):

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index db3149379a4d..b072098ee44e 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -22,7 +22,7 @@ enum trap_behaviour {
 	BEHAVE_FORWARD_RW	= BEHAVE_FORWARD_READ | BEHAVE_FORWARD_WRITE,
 
 	/* Traps that take effect in Host EL0, this is rare! */
-	BEHAVE_IN_HOST_EL0	= BIT(2),
+	BEHAVE_FORWARD_IN_HOST_EL0	= BIT(2),
 };
 
 struct trap_bits {
@@ -2279,7 +2279,7 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
 
 	b = compute_trap_behaviour(vcpu, tc);
 
-	if (!(b & BEHAVE_IN_HOST_EL0) && vcpu_is_host_el0(vcpu))
+	if (!(b & BEHAVE_FORWARD_IN_HOST_EL0) && vcpu_is_host_el0(vcpu))
 		goto local;
 
 	if (((b & BEHAVE_FORWARD_READ) && is_read) ||

-- 
Thanks,
Oliver

