Return-Path: <linux-kernel+bounces-269542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867FC943409
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20525282914
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3CF1BB6B2;
	Wed, 31 Jul 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZoIpqTF"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C61BC075
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442741; cv=none; b=XU6Brxl4KwBNqv6Mn7ams6W9NM49wsqZNl0Z+yu7R0Io9d4lKfwZO5hbzWVOPLSrh0K4+IsZAr85lHsqZaKU9tXbE/v41bfFvGopLaqggfHcgM/1UdK4kuT2zUoaDmQZEV26GfSstmQtm63zxW64IG0X4RaRsNmGiZxRPgoOizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442741; c=relaxed/simple;
	bh=ElAcQ+gpc9rbYRw6zuWtY49Lo01Kky3BFlz2QoDeVlE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJUEZjJDICbwr7It+Dv0PsrmExNNe5S8WhPL8eEAfqVYGnfWhB2YkF4gbxCUiQhN61smmVTMUhfA0crvVtwjOuWlkbss6hcq9S9nPn6J+OriSDSzGmhGym4EDKo6HH3ZpeOXDQnHlCOYcsGDLOIKglLmQC5aUUi+nOmEAar1+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZoIpqTF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d2ae2e4f3so6272044b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722442738; x=1723047538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEkAg/E0EBKwZG+0w3Tkn7qnDNz9XXpCm5xfKJGg0ro=;
        b=RZoIpqTFiy3ob5fef0NrGruFZ/sVu9oSCozCwnxWtoxQPaVMY1ga+DevPIc2fLO5qY
         W+D8xou+WrVE+yGJXb3GMWWiAsDBuJGSWh98gAHb3XDsCq4FqVU+MVeTnSbKwNI+qbGq
         zxxNnmTxjpSob/MUVi890c0nofo8x694oYYC6P/ICws+gJ9nl94oecfd7aa45O5Gp+A2
         9Mwd1Xwpxl/UmtjQ9Uw8okkr9xDoj4PSdhnSgWHbYxXWX90KI1w7ByfGTf8hT1er++TZ
         tpzxUtl7qcFPNUUzvIMU+kXbTV/bhw/ll5hsl8MzzuVh6+eGX/lpJAmlGbXslOMmTOgx
         uRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442738; x=1723047538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEkAg/E0EBKwZG+0w3Tkn7qnDNz9XXpCm5xfKJGg0ro=;
        b=CKZL7dcwh3y1w9QkoVTLg7FJtcPVQ7eXxEwgLrCvZFlNnUkdg5rKCKsZQUr/BunSeo
         ZqN33sEmCE/2gk8TECLi7k/HESNVZseheHT1fwHyRTy41oC7O+/Qy8dEF4ex40uupYt6
         pZ7k2t6KmxNZ2lwxUz8IOt/kGtW5bzWpyBdj8uJT/Zo+J7poPu0DF92QWF5cxxCBUHMo
         4W814BLqy0RvxYVt9uAl1eaBKLZbYQPv5jBANjT+57Am6zu+KVqe9dHx6aiLimp6XecN
         jv4YPnWlW1Wm0vAlWzFdytpl89AcprSL8BEYrZ9SpT+GrlXZBLxzBzVw8pZQHKyEl3Ov
         pA4g==
X-Forwarded-Encrypted: i=1; AJvYcCXzgvcmbEAfjF0v4fPCqIBpUspAtqfOqrjS7lv/3RGYNYLookHa631Shd5NGtz2blwYDWKFHE7Mg78ep1LGunZr5UoJBPJ5R19UCAnF
X-Gm-Message-State: AOJu0YxIMnyzukJGqgZQVpIHcdCW6OHxhXX2/gSm+2rNLkm5XXywzW7V
	mA4KkzMnG0jKuQgko7SRzsdXfAV+yYw03/YnHy/GpFpdxt0fXKGI4Y3/XjppsZLcN9NKhJUq0ZP
	zyw==
X-Google-Smtp-Source: AGHT+IE3vR/52fbHBcG0mD8gAg08EvW707+6aqhxcpp+uszsjVVLSlqCBB7w2jlGO3uwCGZS192zyStdcJU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1823:b0:70d:3548:bb59 with SMTP id
 d2e1a72fcca58-70ecedefc97mr113184b3a.4.1722442738134; Wed, 31 Jul 2024
 09:18:58 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:18:56 -0700
In-Reply-To: <3e5f7422-43ce-44d4-bff7-cc02165f08c0@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240730155646.1687-1-will@kernel.org> <ccd40ae1-14aa-454e-9620-b34154f03e53@rbox.co>
 <Zql3vMnR86mMvX2w@google.com> <20240731133118.GA2946@willie-the-truck> <3e5f7422-43ce-44d4-bff7-cc02165f08c0@rbox.co>
Message-ID: <Zqpj8M3xhPwSVYHY@google.com>
Subject: Re: [PATCH] KVM: Fix error path in kvm_vm_ioctl_create_vcpu() on
 xa_store() failure
From: Sean Christopherson <seanjc@google.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Will Deacon <will@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 31, 2024, Michal Luczaj wrote:
> On 7/31/24 15:31, Will Deacon wrote:
> > On Tue, Jul 30, 2024 at 04:31:08PM -0700, Sean Christopherson wrote:
> >> On Tue, Jul 30, 2024, Michal Luczaj wrote:
> >>> On 7/30/24 17:56, Will Deacon wrote:
> >>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> >>>> index d0788d0a72cc..b80dd8cead8c 100644
> >>>> --- a/virt/kvm/kvm_main.c
> >>>> +++ b/virt/kvm/kvm_main.c
> >>>> @@ -4293,7 +4293,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> >>>>  
> >>>>  	if (KVM_BUG_ON(xa_store(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, 0), kvm)) {
> >>>>  		r = -EINVAL;
> >>>> -		goto kvm_put_xa_release;
> >>>> +		goto err_xa_release;
> >>>>  	}
> >>>>  
> >>>>  	/*
> >>>> @@ -4310,6 +4310,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> >>>>  
> >>>>  kvm_put_xa_release:
> >>>>  	kvm_put_kvm_no_destroy(kvm);
> >>>> +err_xa_release:
> >>>>  	xa_release(&kvm->vcpu_array, vcpu->vcpu_idx);
> >>>>  unlock_vcpu_destroy:
> >>>>  	mutex_unlock(&kvm->lock);
> >>>
> >>> My bad for neglecting the "impossible" path. Thanks for the fix.
> >>>
> >>> I wonder if it's complete. If we really want to consider the possibility of
> >>> this xa_store() failing, then keeping vCPU fd installed and calling
> >>> kmem_cache_free(kvm_vcpu_cache, vcpu) on the error path looks wrong.
> >>
> >> Yeah, the vCPU is exposed to userspace, freeing its assets will just cause
> >> different problems.  KVM_BUG_ON() will prevent _new_ vCPU ioctl() calls (and kick
> >> running vCPUs out of the guest), but it doesn't interrupt other CPUs, e.g. if
> >> userspace is being sneaking and has already invoked a vCPU ioctl(), KVM will hit
> >> a use-after-free (several of them).
> > 
> > Damn, yes. Just because we haven't returned the fd yet, doesn't mean
> > userspace can't make use of it.
> >
> >> As Michal alluded to, it should be impossible for xa_store() to fail since KVM
> >> pre-allocates/reserves memory.  Given that, deliberately leaking the vCPU seems
> >> like the least awful "solution".
> > 
> > Could we actually just move the xa_store() before the fd creation? I
> > can't immediately see any issues with that...
> 
> Hah, please see commit afb2acb2e3a3 :) Long story short: create_vcpu_fd()
> can legally fail, which must be handled gracefully, which would involve
> destruction of an already xa_store()ed vCPU, which is racy.

Ya, the basic problem is that we have two ways of publishing the vCPU, fd and
vcpu_array, with no way of setting both atomically.  Given that xa_store() should
never fail, I vote we do the simple thing and deliberately leak the memory.

