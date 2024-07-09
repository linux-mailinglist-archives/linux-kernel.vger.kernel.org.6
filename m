Return-Path: <linux-kernel+bounces-246594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D20592C40A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897E01F23676
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B054018560E;
	Tue,  9 Jul 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SbKS2YAU"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FB146D74
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554405; cv=none; b=OlnOvArRDsZXP9GSXzuEMYFo7FwT5aTc/UCVOq01Cfsz1sKzYzTQVccx4MtNXi/rs9tY62N8mOZlFHxhrHb5TV4t+WccwmueopvD1/+kNdtf2bPQgpgWO7kWotKJbnzkW6F2uzpkIfLBBdeh+8SAKxPxsfvOSH9+UJbBbQnybFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554405; c=relaxed/simple;
	bh=ne5k5IWTYEPHPIcxlepI4S0hYR5ZyVirYxXdf72NEEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eZXthg2mFFi1avI20mTvPSJS1HlI/AyZhm8fmPv2hGAzKRtYYXkLdJLq51rWzqynSL32HBx61UBN7q2VT3iVF9ADxQzzE4mcMCpdUV/tMlwNMEhahOY12FDJtXbK2KbeiFmxBXXExWCxTThEQM4urp0X5G96e6aVOJ+qu1y9Pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SbKS2YAU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-71b1231febdso3268190a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720554403; x=1721159203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2D+exINq6dEkuW5ga7MfRBD1PNzA9YFyAu9E64c8E30=;
        b=SbKS2YAUC8KYvTr5ucITkaGjfIMJu0/Y3Sb42dih/1/mJ+/v6a6+6kRRxeGIPjHtZq
         LfRPG1sz2/0x9KhyfyLzsTC1t1R6lZCZzB5+LyJskP97W0RzLLsWxFcfqGAJ4kx3kFGG
         Qxauca/8imHNrx7SRqzanRCUBtDnLe4zkJaymP0+6P8Irle2wmRuFMKwv97pBt0MeNF6
         IoFROhTI861JNKoY2RyWm8HkkPIHV8GcTTow2zaTKyL4FlPVe7UIawyhCWsYjBtZEP9x
         09niExbl6n+y/6xDcLCTxQv2cIneS+lS4A7US4aQCOFHd/WT3Z1wIG6HcxHIaLenhE8h
         OGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720554403; x=1721159203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2D+exINq6dEkuW5ga7MfRBD1PNzA9YFyAu9E64c8E30=;
        b=b49u/0LsAnmA3BFwDgqxzjVM9e6+fvc0w88vzNERACMVyO6LxAXcPLOTfcc1FlmDaa
         solv/Pm44CslL1WLnMIj8+BBg8UhmtBVYh2zjW0pj1xdA15EOfydFWra4u59qhPvvTwi
         B89LhhGtEyVg2qSPxb2CJqmYMvOH1uGbYlnBg7U8i2UTZqVdfLwd+HR6ZrVc3mON2pLG
         sPdf3ZPcs5FgiefY5ZsSXrVDT7byJuGJdA38GOh0YBWJvWFPEIoWRQ3qvCA9hAuPseBC
         xdH0XG/S5sZwwxBFvFUng/C6zwrF/MB74A22FnEIgdw+OZwEiGZMkMzmm2ycE+D0GykC
         I0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXowD9MdzAj5Ed9w5h2tjVHyFOtAE/PWVIKbiFPyfbsZK/AToNo14DAFI0mGR7TOyF5bzGYBXZoDgiTIB1og2Cc/3t3aB+hQkUI8iSC
X-Gm-Message-State: AOJu0YyzM6zNoVr0c572H44c/qxS99Aw/nD2F2pdSMje8QsTE/ukJTon
	McjixN5Ds7UAUnLin31CW3giB4vfyNRBCuMSvLszXayVeEf9HLDhHL3fpR/pi2txERDF5F6Wb2x
	YTw==
X-Google-Smtp-Source: AGHT+IGBJf5WBWt4IHrAGPKRiMh3ofvI/6h+DV7zdYHHjMJyXDX32j5hzFz8OLBnyQvSVnYqMejlq6Ru6Pk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:495:b0:6c4:5b35:c986 with SMTP id
 41be03b00d2f7-77dbda555b5mr6766a12.8.1720554402695; Tue, 09 Jul 2024 12:46:42
 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:46:41 -0700
In-Reply-To: <d5ef3d7082f28fcad58b3f55a99c9cae17c4de5a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-3-seanjc@google.com>
 <d5ef3d7082f28fcad58b3f55a99c9cae17c4de5a.camel@redhat.com>
Message-ID: <Zo2ToWi3CDOQHF7A@google.com>
Subject: Re: [PATCH v2 02/49] KVM: x86: Explicitly do runtime CPUID updates
 "after" initial setup
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> >  	/*
> >  	 * KVM does not correctly handle changing guest CPUID after KVM_RUN, as
> >  	 * MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, etc.. aren't
> > @@ -440,6 +440,15 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
> >  	 * whether the supplied CPUID data is equal to what's already set.
> >  	 */
> >  	if (kvm_vcpu_has_run(vcpu)) {
> > +		/*
> > +		 * Note, runtime CPUID updates may consume other CPUID-driven
> > +		 * vCPU state, e.g. KVM or Xen CPUID bases.  Updating runtime
> > +		 * state before full CPUID processing is functionally correct
> > +		 * only because any change in CPUID is disallowed, i.e. using
> > +		 * stale data is ok because KVM will reject the change.
> > +		 */
> 
> If I understand correctly the sole reason for the below
> __kvm_update_cpuid_runtime is to ensure that kvm_cpuid_check_equal doesn't
> fail because current cpuid also was post-processed with runtime updates.

Yep.

> Can we have a comment stating this? Or even better how about moving the
> call to __kvm_update_cpuid_runtime into the kvm_cpuid_check_equal,
> to emphasize this?

Ya, I'll do both.

> > +		__kvm_update_cpuid_runtime(vcpu, e2, nent);
> > +
> >  		r = kvm_cpuid_check_equal(vcpu, e2, nent);
> >  		if (r)
> >  			return r;
> 
> 
> 
> Overall I am not 100% sure what is better:
> 
> Before the patch it was roughly like this:
> 
> 1. Post process the user given cpuid with bits of KVM runtime state (like xcr0)
> At that point the vcpu->arch.cpuid_entries is stale but consistent, it is just old CPUID.
> 
> 2. kvm_hv_vcpu_init call (IMHO this call can be moved to kvm_vcpu_after_set_cpuid)
> 
> 3. kvm_check_cpuid on the user provided cpuid
> 
> 4. Update the vcpu->arch.cpuid_entries with new and post processed cpuid
> 
> 5. kvm_get_hypervisor_cpuid - I think this also can be cosmetically moved to kvm_vcpu_after_set_cpuid
> 
> 6. kvm_vcpu_after_set_cpuid itself.
> 
> 
> After this change it works like that:
> 
> 1. kvm_hv_vcpu_init (again this belongs more to kvm_vcpu_after_set_cpuid)
> 2. kvm_check_cpuid on the user cpuid without post processing - in theory this can cause bugs
> 3. Update the vcpu->arch.cpuid_entries with new cpuid but without post-processing
> 4. kvm_get_hypervisor_cpuid
> 5. kvm_update_cpuid_runtime
> 6. The old kvm_vcpu_after_set_cpuid
> 
> I'm honestly not sure what is better but IMHO moving the kvm_hv_vcpu_init and
> kvm_get_hypervisor_cpuid into kvm_vcpu_after_set_cpuid would clean up this
> mess a bit regardless of this patch.

It takes many more patches, but doing the swap() allows for the removal of several
APIs that poke into a "raw" kvm_cpuid_entry2 array, and by the end of the series
(with your above feedback addressed) the code gets to (sans comments):

	swap(vcpu->arch.cpuid_entries, e2);
	swap(vcpu->arch.cpuid_nent, nent);

	memcpy(vcpu_caps, vcpu->arch.cpu_caps, sizeof(vcpu_caps));
	BUILD_BUG_ON(sizeof(vcpu_caps) != sizeof(vcpu->arch.cpu_caps));

	if (kvm_vcpu_has_run(vcpu)) {
		r = kvm_cpuid_check_equal(vcpu, e2, nent);
		if (r)
			goto err;
		goto success;
	}

Those are really just bonuses though, the main goal is to prevent recurrences of
bugs where KVM consumes stale vCPU state[*], which is what prompted this change.

[*] https://lore.kernel.org/all/20240228101837.93642-1-vkuznets@redhat.com

