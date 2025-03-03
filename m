Return-Path: <linux-kernel+bounces-542825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696FA4CE31
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A293173388
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A1720E313;
	Mon,  3 Mar 2025 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cMhefseP"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342A1DDA3C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040523; cv=none; b=gYrS2UvBPylpW7JjKtPO2ZKWlRbc50lbat94BYg3w2EhAq7K3IQulhMwQzPLyXPheFq/WtRSbTbD4K5gqOvs0vNUVc+fQ4FVq2NFTTb74VgzhdAy8LwVgafIRXQ5xhJ1Z28Zu4pxlEB2Tx55By43tQWGqlYFLv1VYc6CHst2lGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040523; c=relaxed/simple;
	bh=AVvde8e9ud7ZCrieN85PrhdPi/SKF2EGfAuEoMezMAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJQEdlVaTuB/QkmWST20arsqkYMZ9SfYOxrzrdg0ynRbaCc3al76Piy8/QFlRe/SEaIT0hYY4ze+NE3Jkj9RQGvZ8rlq3lnKBZSnkAEPv4mdsBdvT0e4avuFShvIfPmKnStJbNkH9IKI71WK+tuix6A+IiekzsxVQ+Vult3E59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cMhefseP; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 22:21:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741040509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BYrgJBaa1/wGcdat97a1kwri4kikfmUhgip+C5EAWY4=;
	b=cMhefsePY6VzZS4izliyQG9/8mNX+LztTTLm5CoG1oIuSMilJi9mSEFFe21fL3plsQvCNs
	0qPAjWNTQCWMkGgOVH1UDIV5AhlkphPhzzqsTtKyGz4thVCafAe6bnYdR0o3vOaAo7Eqmd
	XTAnb0dNbfXMbSBcCclxCCbXNDKJ+sc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 13/13] KVM: nSVM: Stop bombing the TLB on nested
 transitions
Message-ID: <Z8YrdcWd1PD76adM@google.com>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
 <20250205182402.2147495-14-yosry.ahmed@linux.dev>
 <da0b13813b11e5b13f01dced9a629ac07fad27cd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0b13813b11e5b13f01dced9a629ac07fad27cd.camel@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 28, 2025 at 09:21:54PM -0500, Maxim Levitsky wrote:
> On Wed, 2025-02-05 at 18:24 +0000, Yosry Ahmed wrote:
> > Now that nested TLB flushes are properly tracked with a well-maintained
> > separate ASID for L2 and proper handling of L1's TLB flush requests,
> > drop the unconditional flushes and syncs on nested transitions.
> > 
> > On a Milan machine, an L1 and L2 guests were booted, both with a single
> > vCPU, and pinned to a single physical CPU to maximize TLB collisions. In
> > this setup, the cpuid_rate microbenchmark [1] showed the following
> > changes with this patch:
> > 
> > +--------+--------+-------------------+----------------------+
> > > L0     | L1     | cpuid_rate (base) | cpuid_rate (patched) |
> > +========+========+===================+======================+
> > > NPT    | NPT    | 256621            | 301113 (+17.3%)      |
> > > NPT    | Shadow | 180017            | 203347 (+12.96%)     |
> > > Shadow | Shadow | 177006            | 189150 (+6.86%)      |
> > +--------+--------+-------------------+----------------------+
> > 
> > [1]https://lore.kernel.org/kvm/20231109180646.2963718-1-khorenko@virtuozzo.com/
> > 
> > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > ---
> >  arch/x86/kvm/svm/nested.c | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 8e40ff21f7353..45a187d4c23d1 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -512,9 +512,6 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> >  		svm->nested.last_asid = svm->nested.ctl.asid;
> >  		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> >  	}
> > -	/* TODO: optimize unconditional TLB flush/MMU sync */
> > -	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> > -	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> >  }
> >  
> >  static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
> > @@ -530,10 +527,6 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
> >  	 */
> >  	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
> >  		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> > -
> > -	/* TODO: optimize unconditional TLB flush/MMU sync */
> > -	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> > -	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> >  }
> >  
> >  /*
> 
> 
> Assuming that all previous patches are correct this one should work as well.
> 
> However only a very heavy stress testing, including hyperv, windows guests
> of various types, etc can give me confidence that there is no some ugly bug lurking
> somewhere.

I tried booting an L2 and running some workloads like netperf in there.
I also tried booting an L3.

I am planning to try and run some testing with a windows L2 guest. I am
assuming this exercises the hyper-V emulation in L1, which could be
interesting.

I am not sure if I will be able to test more scenarios though,
especially Windows as an L1 (and something else as an L2).

Let me know if you have something specific in mind.

> 
> TLB management can be very tricky, so I can't be 100% sure that I haven't missed something.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Thanks!

