Return-Path: <linux-kernel+bounces-545997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D747A4F4F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11127A3110
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398F1547E9;
	Wed,  5 Mar 2025 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea6nFyUZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41ED45C18
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143453; cv=none; b=PaoTh5Tb0gnaL91IWLUf/pH80Rt8DIg9ZAlwqOtDNhCBcXLXYHrOvY/AMc2eCehxh+U6+dpPhtyJywmNRnE7xrTfwZKEUQUwn92E5Cu1mVeqcXuCV3AVAt0X8uUChYXmLU6oqQrR5NjkceORpqM9o+3gHnAXxMBDrkivLyKqsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143453; c=relaxed/simple;
	bh=aGKbrULwTdTRyT0A0kuO9eEUK3LxuA3FDrupb74BRd8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QNMivd0QIz825r5F+8XwAs9KvrIo8ebeO4fH+QL0GEvXcBWot1+MsJLs27WYbAsnqZfQHdwoNohFjAOPtLCB6UdmbgvzF3+LqoulKzPWScaq48YkYQ2gc11gXNX5nxWZMFYgHR51AZyW9G+EzdI2joybvmQfhk5E7kChqB2HT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ea6nFyUZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741143449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k22zgh/jyAhJXidTGCj8WdWHgPrd2RoeEQ1YeZh9VQU=;
	b=ea6nFyUZelcPbeKMEARgNi36k9BBlZYOds25u/JkNZTq0s1ydFv0DmeflgJSrYa0/B2c0O
	YbN4OTihc3edoWg0jfdmH2wn4Cbrps7HsCFDtOmeoG+9zEytNcuMkXzs5q/hf5zeNf10oh
	TRSgNolYT0uJ/5N+JjTRuNKrQ2ABYBs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-pZwSXZBANg-j6pUnAaKfYg-1; Tue, 04 Mar 2025 21:57:26 -0500
X-MC-Unique: pZwSXZBANg-j6pUnAaKfYg-1
X-Mimecast-MFC-AGG-ID: pZwSXZBANg-j6pUnAaKfYg_1741143446
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e19e09cc20so105233986d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143446; x=1741748246;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k22zgh/jyAhJXidTGCj8WdWHgPrd2RoeEQ1YeZh9VQU=;
        b=SYr2Wx7z/MSQKXvOGtVtbw68qK2IrlXsXDZg5mANIxdQh+lQa1cuVAHtpba71hsmwb
         HLujF7n1qY5B8U3rngz8D2ITRZQLpcCOWxiKvpzdE6NRxkrMrPltWALKKGtpI+4vwRNQ
         m1H+s52sj2MAF5Ljx/RDyV/H/MjdkGGm1sVHwWm+2Ykc1ZolcjXKCI3jvyxWTo2mXmid
         HTPdgUbVaNIiYXT9+t6Ade18pBIB/686jZ8Akg5CH2UWsOD5vQATQq5+PrSlYbuqn65/
         bjaoI8aIc/T1d+Y3z7swqmxgpqne7sSOAN2Ml71ZhTvLlGgzs+AmhJZRF5dFkhEI8xFV
         iyfw==
X-Forwarded-Encrypted: i=1; AJvYcCWwm5zS+Td5Px+g4VQ3s8vzCjVvDsh1eBDMWxLOw63WVlwyqMqZdrElEbeeTToCkn939v3egmSsAlvmbgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIMdsjGnw4WI+Vp1xenR8PRlX9gQvU/wCr56/SKoskggLvLok
	kEMyQNKZ0AevkbPeBW6RIHc2J65bILZwl6h9NgCCToL7J4pI3w+cjq8VQtDkgxEJDuDVqVea1qL
	LD5qPL/4I/NaAoYSval7NaZeS7f7tKi1UGr3bHBf4R3HW1D4ApRGJGtWSpQ3tQQ==
X-Gm-Gg: ASbGncsiwaGzgwqlpjvlly1lBG2x2TEneCu/1wlNbF9K+2464nlcXrrEZNxgVQEWUSA
	i4o22nw4kUbBS8zB0eD5knUL9C2NzP+8HfLx1BjOOe50+l7CVkH3TVMekLmddzsqdMvUi+d54Y8
	ELaSAY/DBR2yIOo+6sNCt5fRtJsxoXPZVQK/VhoWv/Vi6ShnVMptIQN+7Q1C1WwQkS3oiE3Bdn8
	+6sf+/8MDsAym47EP6o6XZBamqHM3jbI/qnFViVzgALLY65zF+2wHs7aZ62edHqE89H42DsQ2D4
	wjz4Jdi9zbfLrmA=
X-Received: by 2002:a05:6214:1d0a:b0:6e8:91fd:cfc1 with SMTP id 6a1803df08f44-6e8e6cc7c25mr25924266d6.8.1741143445879;
        Tue, 04 Mar 2025 18:57:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3t4AK4fYtyo86fru1RHMwYN6P4wHGOvLU4MQp/ldo7sNJZGdqoRV/DagPPmpy/Tv+u7OWHA==
X-Received: by 2002:a05:6214:1d0a:b0:6e8:91fd:cfc1 with SMTP id 6a1803df08f44-6e8e6cc7c25mr25924086d6.8.1741143445523;
        Tue, 04 Mar 2025 18:57:25 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976eb136sm73941656d6.117.2025.03.04.18.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:57:25 -0800 (PST)
Message-ID: <910d5380b320ad39081c4a32ba643e6ad1cfcd55.camel@redhat.com>
Subject: Re: [RFC PATCH 09/13] KVM: nSVM: Handle nested TLB flush requests
 through TLB_CONTROL
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2025 21:57:24 -0500
In-Reply-To: <Z8Yovz0I3QLuq6VQ@google.com>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-10-yosry.ahmed@linux.dev>
	 <2dfc8e02c16e78989bee94893cc48d531cdfa909.camel@redhat.com>
	 <Z8Yovz0I3QLuq6VQ@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2025-03-03 at 22:10 +0000, Yosry Ahmed wrote:
> On Fri, Feb 28, 2025 at 09:06:18PM -0500, Maxim Levitsky wrote:
> > On Wed, 2025-02-05 at 18:23 +0000, Yosry Ahmed wrote:
> > > Handle L1's requests to flush L2's TLB through the TLB_CONTROL field of
> > > VMCB12. This is currently redundant because a full flush is executed on
> > > every nested transition, but is a step towards removing that.
> > > 
> > > TLB_CONTROL_FLUSH_ALL_ASID flushes all ASIDs from L1's perspective,
> > > including its own, so do a guest TLB flush on both transitions. Never
> > > propagate TLB_CONTROL_FLUSH_ALL_ASID from the guest to the actual VMCB,
> > > as this gives the guest the power to flush the entire physical TLB
> > > (including translations for the host and other VMs).
> > > 
> > > For other cases, the TLB flush is only done when entering L2. The nested
> > > NPT MMU is also sync'd because TLB_CONTROL also flushes NPT
> > > guest-physical mappings.
> > > 
> > > All TLB_CONTROL values can be handled by KVM regardless of FLUSHBYASID
> > > support on the underlying CPU, so keep advertising FLUSHBYASID to the
> > > guest unconditionally.
> > > 
> > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 42 ++++++++++++++++++++++++++++++++-------
> > >  arch/x86/kvm/svm/svm.c    |  6 +++---
> > >  2 files changed, 38 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 0735177b95a1d..e2c59eb2907e8 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -484,19 +484,36 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
> > >  
> > >  static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> > >  {
> > > +	struct vcpu_svm *svm = to_svm(vcpu);
> > > +
> > >  	/* Handle pending Hyper-V TLB flush requests */
> > >  	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> > >  
> > > +	/*
> > > +	 * If L1 requested a TLB flush for L2, flush L2's TLB on nested entry
> > > +	 * and sync the nested NPT MMU, as TLB_CONTROL also flushes NPT
> > > +	 * guest-physical mappings. We technically only need to flush guest_mode
> > > +	 * page tables.
> > > +	 *
> > > +	 * KVM_REQ_TLB_FLUSH_GUEST will flush L2's ASID even if the underlying
> > > +	 * CPU does not support FLUSHBYASID (by assigning a new ASID), so we
> > > +	 * can handle all TLB_CONTROL values from L1 regardless.
> > > +	 *
> > > +	 * Note that TLB_CONTROL_FLUSH_ASID_LOCAL is handled exactly like
> > > +	 * TLB_CONTROL_FLUSH_ASID. We can technically flush less TLB entries,
> > > +	 * but this would require significantly more complexity.
> > > +	 */
> > 
> > I think it might make sense to note that we in essence support only one non zero ASID
> > in L1, the one that it picks for the nested guest.
> > 
> > 
> > Thus when asked to TLB_CONTROL_FLUSH_ALL_ASID 
> > we need to flush the L2's real asid and L1 asid only.
> 
> This is described by the comment in nested_svm_exit_tlb_flush(). Do you
> mean that we should also mention that here?
> 
> I guess one way to make things clearer is to describe the behavior for
> all values of TLB_CONTROL here, and in nested_svm_exit_tlb_flush() just
> say /* see nested_svm_entry_tlb_flush() */. Would that improve things?

I guess that this will be a bit better.
This was just a tiny nitpick though, just something I wondered a bit when
reviewing.


Best regards,
	Maxim Levitsky



> 
> > 
> > > +	if (svm->nested.ctl.tlb_ctl != TLB_CONTROL_DO_NOTHING) {
> > > +		if (nested_npt_enabled(svm))
> > > +			kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> > > +		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> > > +	}
> > > +
> > >  	/*
> > >  	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
> > >  	 * things to fix before this can be conditional:
> > >  	 *
> > > -	 *  - Honor L1's request to flush an ASID on nested VMRUN
> > > -	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
> > >  	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
> > > -	 *
> > > -	 * [*] Unlike nested EPT, SVM's ASID management can invalidate nested
> > > -	 *     NPT guest-physical mappings on VMRUN.
> > >  	 */
> > >  	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> > >  	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> > > @@ -504,9 +521,18 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> > >  
> > >  static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
> > >  {
> > > +	struct vcpu_svm *svm = to_svm(vcpu);
> > > +
> > >  	/* Handle pending Hyper-V TLB flush requests */
> > >  	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> > >  
> > > +	/*
> > > +	 * If L1 had requested a full TLB flush when entering L2, also flush its
> > > +	 * TLB entries when exiting back to L1.
> > > +	 */
> > > +	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
> > > +		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> > 
> > Makes sense.
> > 
> > > +
> > >  	/* See nested_svm_entry_tlb_flush() */
> > >  	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> > >  	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> > > @@ -825,7 +851,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
> > >  	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
> > >  
> > >  	svm_switch_vmcb(svm, &svm->nested.vmcb02);
> > > -	nested_vmcb02_prepare_control(svm, vmcb12->save.rip, vmcb12->save.cs.base);
> > > +	nested_vmcb02_prepare_control(svm, vmcb12->save.rip,
> > > +				      vmcb12->save.cs.base);
> > >  	nested_vmcb02_prepare_save(svm, vmcb12);
> > >  
> > >  	ret = nested_svm_load_cr3(&svm->vcpu, svm->nested.save.cr3,
> > > @@ -1764,7 +1791,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
> > >  	nested_copy_vmcb_control_to_cache(svm, ctl);
> > >  
> > >  	svm_switch_vmcb(svm, &svm->nested.vmcb02);
> > > -	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);
> > > +	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip,
> > > +				      svm->vmcb->save.cs.base);
> > >  
> > >  	/*
> > >  	 * While the nested guest CR3 is already checked and set by
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 8342c7eadbba8..5e7b1c9bfa605 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -5242,9 +5242,9 @@ static __init void svm_set_cpu_caps(void)
> > >  		kvm_cpu_cap_set(X86_FEATURE_VMCBCLEAN);
> > >  
> > >  		/*
> > > -		 * KVM currently flushes TLBs on *every* nested SVM transition,
> > > -		 * and so for all intents and purposes KVM supports flushing by
> > > -		 * ASID, i.e. KVM is guaranteed to honor every L1 ASID flush.
> > > +		 * KVM currently handles all TLB_CONTROL values set by L1, even
> > > +		 * if the underlying CPU does not. See
> > > +		 * nested_svm_transition_tlb_flush().
> > >  		 */
> > >  		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
> > >  
> > 
> > Patch looks OK, but I can't be 100% sure about this.
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > 



