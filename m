Return-Path: <linux-kernel+bounces-445147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F699F11F8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62308281BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889F01E3DE6;
	Fri, 13 Dec 2024 16:24:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57ED1E47A5;
	Fri, 13 Dec 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107084; cv=none; b=JughsCt2JhxGBHFIDjYkKcVjmhOXUGL8CFhnvqH+6qdE2RWlcP341yO4hwAkVkF4SrOIi243lZJJNDP/pAb99YzMl3eTpNatlSRqO6f7uP3onC0fLCCPIIHv7IwLlo5QErzj4KBjQNEhZ02xkfS+YS034uYinicSLSoQxenG8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107084; c=relaxed/simple;
	bh=5XEd+exWKEpwz2Vn+qFmO3TGdmdDBWvZP2sAvnwEOQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icMh1q5XQr6dCTLvOVy7oHwPY8gA3XlA1Rd4ZS9tpukB+CecVyONbthPkykQL0xU87LmMBdE0w1D944a8nAYeBFXsmmqj/NBTo0kDij1KiSetxWFSrypFwmtFU2vbxKUBxTTFB354ZundBXTRDPOMYb2l7jVucLOZqrzdndn8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 545731480;
	Fri, 13 Dec 2024 08:25:08 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.1.196.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9A1B3F5A1;
	Fri, 13 Dec 2024 08:24:38 -0800 (PST)
Date: Fri, 13 Dec 2024 16:24:36 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: ryan.roberts@arm.com, catalin.marinas@arm.com, will@kernel.org,
	corbet@lwn.net, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [RESEND RFC PATCH v1 1/5] arm64: Add TLB Conflict Abort
 Exception handler to KVM
Message-ID: <20241213162436.GC30314@mazurka.cambridge.arm.com>
References: <20241211160218.41404-1-miko.lenczewski@arm.com>
 <20241211160218.41404-2-miko.lenczewski@arm.com>
 <86o71irucr.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86o71irucr.wl-maz@kernel.org>

Apologies again for spam (replied instead of group-replied).

On Wed, Dec 11, 2024 at 05:40:36PM +0000, Marc Zyngier wrote:
> On Wed, 11 Dec 2024 16:01:37 +0000,
> Mikołaj Lenczewski <miko.lenczewski@arm.com> wrote:
> > 
> > Currently, KVM does not handle the case of a stage 2 TLB conflict abort
> > exception. The Arm ARM specifies that the worst-case handling of such an
> > exception requires a `tlbi vmalls12e1`.
> 
> Not quite. It says (I_JCCRT):
> 
> <quote>
> * For the EL1&0 translation regime, when stage 2 translations are in
>   use, either VMALLS12E1 or ALLE1.
> </quote>
> 
> > Perform such an invalidation when this exception is encountered.
> 
> What you fail to describe is *why* this is needed. You know it, I know
> it, but not everybody does. A reference to the ARM ARM would
> definitely be helpful.
> 

You are correct. Will update the commit message.

> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index c9d46ad57e52..c8c6f5a97a1b 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -1756,6 +1756,12 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
> >  	ipa = fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
> >  	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
> >  
> > +	if (esr_fsc_is_tlb_conflict_abort(esr)) {
> > +		// does a `tlbi vmalls12e1is`
> 
> nit: this isn't a very useful comment.
> 

Will remove it.

> > +		__kvm_tlb_flush_vmid(&vcpu->kvm->arch.mmu);
> > +		return 1;
> > +	}
> 
> That's not enough, unfortunately. A nested VM has *many* VMIDs (the
> flattening of all translation contexts that the guest uses).
> 
> So you can either iterate over all the valid VMIDs owned by this
> guest, or more simply issue a TLBI ALLE1, which will do the trick in a
> much more efficient way.
> 
> The other thing is that you are using an IS invalidation, which is
> farther reaching than necessary. Why would you invalidate the TLBs for
> CPUs that are only innocent bystanders? A non-shareable invalidation
> seems preferable to me.
>

You are completely correct here. I had forgotten about nested VMs, and
agree that issuing a `tlbi alle1` is simpler and more efficient. I agree
also on not using an IS invalidation.

