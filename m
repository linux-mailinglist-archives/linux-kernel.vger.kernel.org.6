Return-Path: <linux-kernel+bounces-546153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60EA4F706
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F2D3A8F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AD21C84CC;
	Wed,  5 Mar 2025 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C3G39o1I"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358951078F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741155632; cv=none; b=utqPTQE7G7/CcjKxNTTLqDyV1z2e0krN/9YYp+zPZP3t5Ow70pBu/3Vl2K4MetSlpAxzZQg7xfLcPuPkmc8VCYKqCvLUYtV/eVgqZPUJMwhgbB6LyIPUBPwRYscK9oPWhoGIoCVZlVvFHRKIaumDONgRIaf2IayCRk5DOobgK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741155632; c=relaxed/simple;
	bh=O0mbpCp1l7uilnWQeQS48zmxUFS4ExnbRfRLBzRTlJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk5vUt37QeM21yROagjkkNFFcxnGfEYPgeFpK00nnbK6w+zC6sI0fopFzZfxf2S5EeR6EVkb8KXjL7FZxoojYw8IngDs8MMdJevrxWodCDCOrpbaPsr9uFx4cd5TN9/RBOLo8AD2y49smVRJYa5LVPdxiQqnNP5lm5ww2Qjj57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C3G39o1I; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 06:20:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741155618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iR/IlkhcEw6NgMhu7KhhR6WGEh8XFGtm9E89QfE35YY=;
	b=C3G39o1I0j9jQAPxpjXulwIhGLoe1PbaasSp2BD/CSmoLLXXjnEKkTuUXS19Mjt+5Ddp0c
	FkyxVuehX4I44rC8srKKiL+Poalu+EUnT5j3jQObmCjOfgDBbAf0gUKVhnakjg40leqTRW
	76AD5EhQPxXqU7EPObuwmCss+mxHz8s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/13] KVM: nSVM: Handle INVLPGA interception
 correctly
Message-ID: <Z8ftGvcQrR_B1Ds1@google.com>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
 <20250205182402.2147495-8-yosry.ahmed@linux.dev>
 <330b0214680efacf15cf18d70788b9feab2b68b0.camel@redhat.com>
 <Z8YnjhfwHM_0HBNx@google.com>
 <f34c5ab727d2e0b6f064ddd11d596fb1841b75b3.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34c5ab727d2e0b6f064ddd11d596fb1841b75b3.camel@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 04, 2025 at 09:54:54PM -0500, Maxim Levitsky wrote:
> On Mon, 2025-03-03 at 22:05 +0000, Yosry Ahmed wrote:
> > On Fri, Feb 28, 2025 at 08:55:18PM -0500, Maxim Levitsky wrote:
> > > On Wed, 2025-02-05 at 18:23 +0000, Yosry Ahmed wrote:
> > > > Currently, INVPLGA interception handles it like INVLPG, which flushes
> > > > L1's TLB translations for the address. It was implemented in this way
> > > > because L1 and L2 shared an ASID. Now, L1 and L2 have separate ASIDs. It
> > > > is still harmless to flush L1's translations, but it's only correct
> > > > because all translations are flushed on nested transitions anyway.
> > > > 
> > > > In preparation for stopping unconditional flushes on nested transitions,
> > > > handle INVPLGA interception properly. If L1 specified zero as the ASID,
> > > > this is equivalent to INVLPG, so handle it as such. Otherwise, use
> > > > INVPLGA to flush the translations of the appropriate ASID tracked by
> > > > KVM, if any. Sync the shadow MMU as well, as L1 invalidated L2's
> > > > mappings.
> > > > 
> > > > Opportunistically update svm_flush_tlb_gva() to use
> > > > svm->current_vmcb->asid instead of svm->vmcb->control.asid for
> > > > consistency. The two should always be in sync except when KVM allocates
> > > > a new ASID in pre_svm_run(), and they are shortly brought back in sync
> > > > in svm_vcpu_run(). However, if future changes add more code paths where
> > > > KVM allocates a new ASID, flushing the potentially old ASID in
> > > > svm->vmcb->control.asid would be unnecessary overhead (although probably
> > > > not much different from flushing the newly allocated ASID).
> > > > 
> > > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > > ---
> > > >  arch/x86/include/asm/kvm_host.h |  2 ++
> > > >  arch/x86/kvm/mmu/mmu.c          |  5 +++--
> > > >  arch/x86/kvm/svm/svm.c          | 40 ++++++++++++++++++++++++++++++---
> > > >  3 files changed, 42 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > > index 5193c3dfbce15..1e147bb2e560f 100644
> > > > --- a/arch/x86/include/asm/kvm_host.h
> > > > +++ b/arch/x86/include/asm/kvm_host.h
> > > > @@ -2213,6 +2213,8 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
> > > >  		       void *insn, int insn_len);
> > > >  void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg);
> > > >  void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
> > > > +void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > +			       u64 addr, unsigned long roots, bool gva_flush);
> > > >  void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > >  			     u64 addr, unsigned long roots);
> > > >  void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
> > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > index ac133abc9c173..f5e0d2c8f4bbe 100644
> > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > @@ -6158,8 +6158,8 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
> > > >  	write_unlock(&vcpu->kvm->mmu_lock);
> > > >  }
> > > >  
> > > > -static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > -				      u64 addr, unsigned long roots, bool gva_flush)
> > > > +void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > +			       u64 addr, unsigned long roots, bool gva_flush)
> > > >  {
> > > >  	int i;
> > > >  
> > > > @@ -6185,6 +6185,7 @@ static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu
> > > >  			kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
> > > >  	}
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(__kvm_mmu_invalidate_addr);
> > > >  
> > > >  void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > >  			     u64 addr, unsigned long roots)
> > > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > > index a2d601cd4c283..9e29f87d3bd93 100644
> > > > --- a/arch/x86/kvm/svm/svm.c
> > > > +++ b/arch/x86/kvm/svm/svm.c
> > > > @@ -2483,6 +2483,7 @@ static int clgi_interception(struct kvm_vcpu *vcpu)
> > > >  
> > > >  static int invlpga_interception(struct kvm_vcpu *vcpu)
> > > >  {
> > > > +	struct vcpu_svm *svm = to_svm(vcpu);
> > > >  	gva_t gva = kvm_rax_read(vcpu);
> > > >  	u32 asid = kvm_rcx_read(vcpu);
> > > >  
> > > > @@ -2492,8 +2493,41 @@ static int invlpga_interception(struct kvm_vcpu *vcpu)
> > > >  
> > > >  	trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
> > > >  
> > > > -	/* Let's treat INVLPGA the same as INVLPG (can be optimized!) */
> > > > -	kvm_mmu_invlpg(vcpu, gva);
> > > > +	/*
> > > > +	 * APM is silent about using INVLPGA to flush the host ASID (i.e. 0).
> > > > +	 * Do the logical thing and handle it like INVLPG.
> > > > +	 */
> > > > +	if (asid == 0) {
> > > > +		kvm_mmu_invlpg(vcpu, gva);
> > > > +		return kvm_skip_emulated_instruction(vcpu);
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Check if L1 specified the L2 ASID we are currently tracking. If it
> > > > +	 * isn't, do nothing as we have to handle the TLB flush when switching
> > > > +	 * to the new ASID anyway. APM mentions that INVLPGA is typically only
> > > > +	 * meaningful with shadow paging, so also do nothing if L1 is using
> > > > +	 * nested NPT.
> > > > +	 */
> > > > +	if (!nested_npt_enabled(svm) && asid == svm->nested.last_asid)
> > > > +		invlpga(gva, svm->nested.vmcb02.asid);
> > > 
> > > Hi, 
> > > 
> > > IMHO we can't just NOP the INVLPGA because it is not useful in nested NPT case.
> > > 
> > > If I understand the APM correctly, the CPU will honor the INVLPGA
> > > request, even when NPT is enabled, and so KVM must do this as well.
> > > 
> > > It is not useful for the hypervisor because it needs GVA, which in case of NPT,
> > > the hypervisor won't usually track, but we can't completely rule out that some
> > > hypervisor uses this in some cases.
> > 
> > Yeah I knew this was going to be a contention point, was mainly waiting
> > to see what others think here.
> > 
> > I guess we can just map the ASID passed by L1 to the actual ASID we use
> > for L2 and execute the INVLPGA as-is with the gva passed by L1.
> 
> 
> If I understand correctly, we in essence support only 2 nested ASIDs: 0 and the one that
> L1 used last time. Anything else will get flushed on next VM entry.
>  
> So, if I understand this correctly all we need to do is to drop the 
> 'nested_npt_enabled(svm)' check above, and it should work.

That's exactly what I did in my local tree.

