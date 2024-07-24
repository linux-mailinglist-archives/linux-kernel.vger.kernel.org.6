Return-Path: <linux-kernel+bounces-261328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4493B5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82642855E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092F615F41D;
	Wed, 24 Jul 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXYjTOSQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FA15F3F9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841870; cv=none; b=sxPhMFPzkorkWb0jDMmtWOC8BSw4N0v0qP9byTK44KLzrmU3GizDLxEquVFWcQRKUz63yo0cEq07sC2qWUIvw1x+KnM8aGCJIIrM19Kf7HunZrC6uhidmudalamMn44IkkeTlNWE2BSDO4XSuuqIbXtjynhn1FQ1I38ukzln5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841870; c=relaxed/simple;
	bh=RH3e05g7x2fsdOYGaeqH3JWqapIdf+9tyH6V6bj9bDc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gpJypDq1kQeAv57YkfCYrIYfx8ypvevRBgAuOHnLcfBYxqlj4gITkEaE59xhnTou4sxmDrr3+s1X/Z/Xw9pcfUHXabqYjKEhXdy7MDvuU1vDzz0+UdDWgyu+SKx6P2dvv9BDP86ATEaJUegMHs9qoaPZw0Qef3mXjIeGs53ZdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXYjTOSQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721841867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sd6eNsRYAeTf2pAwdiin6ALyuAUn1OiZY29qeGEgt18=;
	b=SXYjTOSQpgjhb2z8BWzRyzdaAAWx0ia1IQkN9/0xCvyXirkyqvQHT0F8kZTGa2DMhBgx7y
	XLmU7lGxMuKs/b44TAZAeVaAGmtxST0om1W3wnNi6bm2DbZPyVWoNo1rzOsVqMvZsRUqPS
	PekLo4odwvYuuQ8hAjhfMve2xfpcF/A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-hzN7oM5gPhu3pYhyK1TjyQ-1; Wed, 24 Jul 2024 13:24:26 -0400
X-MC-Unique: hzN7oM5gPhu3pYhyK1TjyQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44dbd6ef5b2so314641cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721841865; x=1722446665;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sd6eNsRYAeTf2pAwdiin6ALyuAUn1OiZY29qeGEgt18=;
        b=pQ9UQ13hiUhDuboeX0ttxHAwpnUvoYqSqkc0F2R0JR7YSUBYX9oXzaC35fpg3xE2fb
         4dWyJvsum6zw8iibs8F9I46iyVikkhFxisoi+TC0uGLMwiCwoGPHOjfOArP7FjJGKGJd
         pmzMUubho5mr/DJJKnaxmAKIw9bHti3BLCyVMaWF87ah+Id7ivPupN3kk9hNSzTUgQul
         CyWbyY4o/DGO/2MqJWyQ+4blWLhr4ugtkc+4NuQlqYm5aQA6Cmde40vJHZO3nF3MxAlw
         sBUcqrF6qvI+Ln9vCFax4fYE/CI5yUP8k4gwJFd0v2HTouzVHjAe2/IPEkvEE3ZeHXLf
         lk5w==
X-Forwarded-Encrypted: i=1; AJvYcCU3hnepUJSqWHqCj6mQ0ElJ4C+aCDa0qsh+Kc1sWrI+J2jZJ4nvAoSPYANRETgZ+WuGpbeSTwGXsGELclDMy2KzICQF3iABdszLlgh2
X-Gm-Message-State: AOJu0YzTx1oZyt/p9OzQ/i11C7ETP2AZx421NWlFTiPSIitZ13W5GczF
	xz3rLvMqHOKHcpppQadVqpl60TfqKpB9sS9L9qyVJaFzLcccSv3ET7DhVueKxyexS49SHCUN6Sq
	+J1e6ogPwGhn9RvwDIXMalC3XDIrCvSUC3aAxQQBBWycFQO4tTt3eucD0Oas5kw==
X-Received: by 2002:a05:622a:1455:b0:447:edb9:3427 with SMTP id d75a77b69052e-44fe49045c8mr3623221cf.55.1721841865662;
        Wed, 24 Jul 2024 10:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyFHXRUJgTHIKXRWjIUivDP++KKWx3VvWIJhFaWQ9NpP5a2P/fEwbkO0U3wLRU8Qspk+efOg==
X-Received: by 2002:a05:622a:1455:b0:447:edb9:3427 with SMTP id d75a77b69052e-44fe49045c8mr3622941cf.55.1721841865297;
        Wed, 24 Jul 2024 10:24:25 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fdd2a9390sm3767681cf.23.2024.07.24.10.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:24:24 -0700 (PDT)
Message-ID: <44825b14c4d696dc059e1a08a6f604a1c25eb178.camel@redhat.com>
Subject: Re: [PATCH v2 02/49] KVM: x86: Explicitly do runtime CPUID updates
 "after" initial setup
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 13:24:23 -0400
In-Reply-To: <Zo2ToWi3CDOQHF7A@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-3-seanjc@google.com>
	 <d5ef3d7082f28fcad58b3f55a99c9cae17c4de5a.camel@redhat.com>
	 <Zo2ToWi3CDOQHF7A@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-09 at 12:46 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > >  	/*
> > >  	 * KVM does not correctly handle changing guest CPUID after KVM_RUN, as
> > >  	 * MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, etc.. aren't
> > > @@ -440,6 +440,15 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
> > >  	 * whether the supplied CPUID data is equal to what's already set.
> > >  	 */
> > >  	if (kvm_vcpu_has_run(vcpu)) {
> > > +		/*
> > > +		 * Note, runtime CPUID updates may consume other CPUID-driven
> > > +		 * vCPU state, e.g. KVM or Xen CPUID bases.  Updating runtime
> > > +		 * state before full CPUID processing is functionally correct
> > > +		 * only because any change in CPUID is disallowed, i.e. using
> > > +		 * stale data is ok because KVM will reject the change.
> > > +		 */
> > 
> > If I understand correctly the sole reason for the below
> > __kvm_update_cpuid_runtime is to ensure that kvm_cpuid_check_equal doesn't
> > fail because current cpuid also was post-processed with runtime updates.
> 
> Yep.
> 
> > Can we have a comment stating this? Or even better how about moving the
> > call to __kvm_update_cpuid_runtime into the kvm_cpuid_check_equal,
> > to emphasize this?
> 
> Ya, I'll do both.
> 
> > > +		__kvm_update_cpuid_runtime(vcpu, e2, nent);
> > > +
> > >  		r = kvm_cpuid_check_equal(vcpu, e2, nent);
> > >  		if (r)
> > >  			return r;
> > 
> > 
> > Overall I am not 100% sure what is better:
> > 
> > Before the patch it was roughly like this:
> > 
> > 1. Post process the user given cpuid with bits of KVM runtime state (like xcr0)
> > At that point the vcpu->arch.cpuid_entries is stale but consistent, it is just old CPUID.
> > 
> > 2. kvm_hv_vcpu_init call (IMHO this call can be moved to kvm_vcpu_after_set_cpuid)
> > 
> > 3. kvm_check_cpuid on the user provided cpuid
> > 
> > 4. Update the vcpu->arch.cpuid_entries with new and post processed cpuid
> > 
> > 5. kvm_get_hypervisor_cpuid - I think this also can be cosmetically moved to kvm_vcpu_after_set_cpuid
> > 
> > 6. kvm_vcpu_after_set_cpuid itself.
> > 
> > 
> > After this change it works like that:
> > 
> > 1. kvm_hv_vcpu_init (again this belongs more to kvm_vcpu_after_set_cpuid)
> > 2. kvm_check_cpuid on the user cpuid without post processing - in theory this can cause bugs
> > 3. Update the vcpu->arch.cpuid_entries with new cpuid but without post-processing
> > 4. kvm_get_hypervisor_cpuid
> > 5. kvm_update_cpuid_runtime
> > 6. The old kvm_vcpu_after_set_cpuid
> > 
> > I'm honestly not sure what is better but IMHO moving the kvm_hv_vcpu_init and
> > kvm_get_hypervisor_cpuid into kvm_vcpu_after_set_cpuid would clean up this
> > mess a bit regardless of this patch.
> 
> It takes many more patches, but doing the swap() allows for the removal of several
> APIs that poke into a "raw" kvm_cpuid_entry2 array, and by the end of the series
> (with your above feedback addressed) the code gets to (sans comments):
> 
> 	swap(vcpu->arch.cpuid_entries, e2);
> 	swap(vcpu->arch.cpuid_nent, nent);
> 
> 	memcpy(vcpu_caps, vcpu->arch.cpu_caps, sizeof(vcpu_caps));
> 	BUILD_BUG_ON(sizeof(vcpu_caps) != sizeof(vcpu->arch.cpu_caps));
> 
> 	if (kvm_vcpu_has_run(vcpu)) {
> 		r = kvm_cpuid_check_equal(vcpu, e2, nent);
> 		if (r)
> 			goto err;
> 		goto success;
> 	}
> 
> Those are really just bonuses though, the main goal is to prevent recurrences of
> bugs where KVM consumes stale vCPU state[*], which is what prompted this change.
> 
> [*] https://lore.kernel.org/all/20240228101837.93642-1-vkuznets@redhat.com
> 

All makes sense, thanks!
Best regards,
	Maxim Levitsky


