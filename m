Return-Path: <linux-kernel+bounces-364619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F97299D700
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF095B22557
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C471CBE82;
	Mon, 14 Oct 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LASAZqtx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A12231C83
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932769; cv=none; b=BZ3Pj7THqAVpsQwpmD8wCv10N6sZ3qge4kElllrP5y9w80Z4B4wPWBy0gSmlbslHWCsEXQhBRBfclGI5LutToW7ZXKk7FD4YDR8TVHRXs6AO3XelKsF/16bMigCOynVaDM7vS85gV3ZcYm+Mf24k6UvZMsiv4WG2rj4Oc5x4vZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932769; c=relaxed/simple;
	bh=Vu81vPys2CDyMCoxEAosBTJdlZFjGflRzpJDBRLNgis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VAYdxedBYbMoGE4uPtovfKam6QdRk3P8Lk2cTGryVudBTXvIp+gn241GTgMzxL5rvjhXBcZeONG18E1fDuEjeyUM2k27CkuGYpgu9sXAPxaaQVGBap0fCKR7r/UzAOP0mGMM6TiYuIOyrNaRE5KdFcUsjEPmKcJs1bUJnpZLzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LASAZqtx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2e4874925so70466047b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728932766; x=1729537566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+8YwZPzd8hGbK2LKgFesQD2Tb42n+UtlImdb92fFxg=;
        b=LASAZqtxGEwBXK1Xo4rHbQxnrFvsRe/VmZsekYuFDCQEqydtzgJcKQHgYeRiVOF+Bo
         9/MonBKx2onw3HDPJm9H//HbL4JCvE9wbt6ZdR5WuC7hEAGpqkpm1zlDrL5qt7jrsvs2
         IqSRl1rTLV4FpIvgpdHdxXhNqlyThhLx5fhBZM3gFjPkYbUJ3dQLlO6ArkFK5LXn07D/
         19nNRpl7ZMkmsSBEdHv9bYklSl3kW5FJ0bXU0dUYW5FVoLbf5631VLQJxr6EIdbkVKib
         74yAfs05OGnKZLJIkhriSITtsPP8NLIFb/puCG9GgnRUexvGD1PwNG/rr74SVBia49Ou
         0cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728932766; x=1729537566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+8YwZPzd8hGbK2LKgFesQD2Tb42n+UtlImdb92fFxg=;
        b=pkptrBVFD6UGKjZI4oLOXjOBuI+j+vpTucBrG3PjVMy71R3O+up1FSAJvcv32yhdv0
         Ex5V+tKquUwVEX7KzmIsxtjYoXYyzV1wk7xMkFqUYeDykMx4Z3LIPC2vruvPQexqGPdj
         4jY1g5Hxeigc4MUPSb0xUVu1WHJk0TXBeMFItJy2sVxkhnB4DKUTb2BNoM8qSxBo9XiG
         i0c8B+c3IAKVLTdc1h9lw/YfJZNU6vgsyEZURzezw4o/Oth48bg2qgM9efZvVzt7g9hs
         cWJr1YkSz5XzbR0u7fp8Ls9QjN4KB/ntjL6UN79gh6YeGNEOJbM2lrcAd+4hnL7SbZd8
         nVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCURa5Khxhq8tV+Rgjl8SIUUOQ228sA9+fyrpna+dhJVwVOEFLEf+gJUZeUBtBqa2op4WGyQ1RNCGoJVqMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojHyKmJNLSRwXVvuNlQsgjdoB1/wQLHV3Iq2Hf6wWvWVCXFu4
	wurHFqxpMuyJwAlM5I+Iek7D4TVYp6T26vUWq/EgOJIBlhTaIqI+IWnWpfQDh47Vn4r0ZFoiNhJ
	c4g==
X-Google-Smtp-Source: AGHT+IFFy+ijPVSn3Z0NrUzEvtkGt60BJRFz+jmpA5cHbksFT8RdYrRabv6QwgmqYZVGdxBTWcsctzKdroU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:ef0c:0:b0:e28:f231:1aa8 with SMTP id
 3f1490d57ef6-e2919d51daemr51049276.2.1728932766196; Mon, 14 Oct 2024 12:06:06
 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:06:04 -0700
In-Reply-To: <d09669af3cc7758c740f9860f7f1f2ab5998eb3d.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009181742.1128779-1-seanjc@google.com> <20241009181742.1128779-6-seanjc@google.com>
 <d09669af3cc7758c740f9860f7f1f2ab5998eb3d.camel@intel.com>
Message-ID: <Zw1rnEONZ8iJQvMQ@google.com>
Subject: Re: [PATCH 5/7] KVM: x86: Move kvm_set_apic_base() implementation to
 lapic.c (from x86.c)
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 14, 2024, Kai Huang wrote:
> On Wed, 2024-10-09 at 11:17 -0700, Sean Christopherson wrote:
> > Move kvm_set_apic_base() to lapic.c so that the bulk of KVM's local APIC
> > code resides in lapic.c, regardless of whether or not KVM is emulating the
> > local APIC in-kernel.  This will also allow making various helpers visible
> > only to lapic.c.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/lapic.c | 21 +++++++++++++++++++++
> >  arch/x86/kvm/x86.c   | 21 ---------------------
> >  2 files changed, 21 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index fe30f465611f..6239cfd89aad 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -2628,6 +2628,27 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
> >  	}
> >  }
> >  
> > +int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > +{
> > +	enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
> > +	enum lapic_mode new_mode = kvm_apic_mode(msr_info->data);
> > +	u64 reserved_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu) | 0x2ff |
> > +		(guest_cpuid_has(vcpu, X86_FEATURE_X2APIC) ? 0 : X2APIC_ENABLE);
> > +
> > +	if ((msr_info->data & reserved_bits) != 0 || new_mode == LAPIC_MODE_INVALID)
> > +		return 1;
> > +	if (!msr_info->host_initiated) {
> > +		if (old_mode == LAPIC_MODE_X2APIC && new_mode == LAPIC_MODE_XAPIC)
> > +			return 1;
> > +		if (old_mode == LAPIC_MODE_DISABLED && new_mode == LAPIC_MODE_X2APIC)
> > +			return 1;
> > +	}
> > +
> > +	kvm_lapic_set_base(vcpu, msr_info->data);
> > +	kvm_recalculate_apic_map(vcpu->kvm);
> > +	return 0;
> > +}
> 
> Nit:
> 
> It is a little bit weird to use 'struct msr_data *msr_info' as function
> parameter if kvm_set_apic_base() is in lapic.c.  Maybe we can change to take
> apic_base and host_initialized directly.
> 
> A side gain is we can get rid of using the 'struct msr_data apic_base_msr' local
> variable in __set_sregs_common() when calling kvm_apic_set_base():

Ooh, nice.  I agree, it'd be better to pass in separate parameters.

Gah, and looking at this with fresh eyes reminded me why I even started poking at
this code in the first place.  Patch 1's changelog does a poor job of calling it
out, but the main impetus for this series was to avoid kvm_recalculate_apic_map()
when doing KVM_SET_SREGS without modifying APIC_BASE.  That's _mostly_ handled by
patch 1, but it doesn't completely fix things because if the map is already DIRTY,
then KVM will unnecessarily fall into kvm_recalculate_apic_map()'s slow path, even
though some other vCPU/task is responsible for refreshing the calculation.

I'll send a v2 with your suggested change, a better changelog for patch 1, and
another patch at the end to short-circuit kvm_apic_set_base() (not just the inner
helper) if the new value is the same as the old value.

Thanks Kai!

> static int __set_sregs_common(...)
> {
>         struct msr_data apic_base_msr;
> 	...
> 
>         apic_base_msr.data = sregs->apic_base;
>         apic_base_msr.host_initiated = true;
>         if (kvm_set_apic_base(vcpu, &apic_base_msr))
>                 return -EINVAL;
> 	...
> }
> 

