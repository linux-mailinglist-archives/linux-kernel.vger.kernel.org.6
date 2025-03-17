Return-Path: <linux-kernel+bounces-564761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5CFA65A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F099189F267
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51401DC9A8;
	Mon, 17 Mar 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrr2/brR"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7981ABEA5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231464; cv=none; b=b2cEKuCCdzHMlZzglKK+TtDlApUVnrievCcIeYmQDNooF9YjpE0sP+EjigHCtBgykLhQYHvupIDtVw2LaH9U/NlpVb6RtZhsXNo9miyEWcmOFfNq36oaMF28L8c6NqpdviGz9SQ2yyWPttpu5k6UmJ8gwxmd6L0N6/z5+rhfD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231464; c=relaxed/simple;
	bh=E7NRVoeW6QLMS+MWBGrVvpxiEuhVlHkMez1FQSllQdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=efAtc6dgI9ZZ72wghs/ODXU9ePp3JAgQpXLJRhUvELRGmW1Zl3jDbObt1r13VjM4JbIf1WUM/I4VaJHn1xmJbojF1JJAWuYKMLgAx7d+RMv+/yqCN0fa6tpLtr7Eo+kWKZnNjIVfSkPbjA10o44nx7VnP81+VDE33ZW0JiA22MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrr2/brR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225505d1ca5so75651675ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742231462; x=1742836262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9knZPJpn8PhD+WzxR4XtImTK5+wb3pUib9drnoaFpE=;
        b=hrr2/brRm1nE8tx86eN1N9bZkUb8/CJwGH2QR22fS+m35YdmwD8MuSXSWnJlnfNIPq
         s5QD7m14IMKwg9U6YseuMz4NzNdMG2MfjyNpLaOCyZwE4ZPJ7xacT/csBcVudFEPsIEd
         KBdawP9cFWFNgmv+A1o8lbidWO+espqN0xSA659/KgyiCq/ChMRKMKCx1kzEB4qYP1zX
         mw9HL2wJnBzmGWTvCdR0jmJj0oM6Y7xafbvf2y9PRyrsuquSMir6K7ZT6stQCVXXXkP0
         McJsIU+tICgJFolluD0neF0Hygtv9kYvraavrOlDDp3SwvMe7t4AaHu8QjrFW6OWjixO
         JuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231462; x=1742836262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9knZPJpn8PhD+WzxR4XtImTK5+wb3pUib9drnoaFpE=;
        b=A0VvbI3EmbIODMTX2mG0OC/0qBw6UGGIKiHm+2RREJjNv2NYXS4d69M1/OdkQrr7V/
         ma4EotiOAuKGiTvt1ug5Sks4uj2NAtYx8usmgp/Q1SKz08UfB5/SaR1wqQqzxLS9cRg+
         VmsYmack/jElFPgFvWSPiybwLDCx0KYE6gDsRr5xchNbya7F5WFI3s9amYwwOQhdNLPx
         wC+YwGF/fILMmxpI41zwVlowsXbIJtuRyAwipNsU/W3pzRMiupgClVNLONr8ZspPrEFC
         i17YGauOY1hqEbwthklioHwgwtaYeStmQighstyXGw+iTKiqo93O8BJH7Hl3/4y15aSm
         /AkA==
X-Forwarded-Encrypted: i=1; AJvYcCX7pX01s3gDJ2ZX/EzILnoNB9F91A/CVZXgw0QATHscMvuGBGl3ifbZ5B/XgCnPMeDsGbpAymqjC/fcot0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyihtLSroS8LnA8nReqLisHGcGhdBoVhgd7q+BXYYTfyuiylBGg
	Hn4eWFuLYwpESyjcDrL4e3OpIhqsrlXbug+erGRRy0FdLzcJ9zMU8rHQzy2MnBXenjYV3ngD/DX
	mOQ==
X-Google-Smtp-Source: AGHT+IH1zZ9W/kpTUJXF2FPrO8JqvpUawmfI5OD8mApbCpcciEbhqh+L5kndo4w5LOOpGmVgZxZq3OOAQTk=
X-Received: from pgfb2.prod.google.com ([2002:a63:a102:0:b0:af2:7bd1:57e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d22:b0:1f5:6878:1a43
 with SMTP id adf61e73a8af0-1f5c1183cdcmr18936810637.14.1742231461786; Mon, 17
 Mar 2025 10:11:01 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:11:00 -0700
In-Reply-To: <20250317163732.GA1863989.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250315024010.2360884-1-seanjc@google.com> <20250315024010.2360884-2-seanjc@google.com>
 <20250317163732.GA1863989.vipinsh@google.com>
Message-ID: <Z9hXpERDYZX9pj6V@google.com>
Subject: Re: [PATCH 1/3] KVM: x86/mmu: Dynamically allocate shadow MMU's
 hashed page list
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 17, 2025, Vipin Sharma wrote:
> On 2025-03-14 19:40:08, Sean Christopherson wrote:
> > Dynamically allocate the (massive) array of hashed lists used to track
> > shadow pages, as the array itself is 32KiB, i.e. is an order-3 allocation
> > all on its own, and is *exactly* an order-3 allocation.  Dynamically
> > allocating the array will allow allocating "struct kvm" using regular
> > kmalloc(), and will also allow deferring allocation of the array until
> > it's actually needed, i.e. until the first shadow root is allocated.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  4 ++--
> >  arch/x86/kvm/mmu/mmu.c          | 21 ++++++++++++++++++++-
> >  arch/x86/kvm/x86.c              |  5 ++++-
> >  3 files changed, 26 insertions(+), 4 deletions(-)
> > 
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -6673,13 +6685,19 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
> >  		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
> >  }
> >  
> > -void kvm_mmu_init_vm(struct kvm *kvm)
> > +int kvm_mmu_init_vm(struct kvm *kvm)
> >  {
> > +	int r;
> > +
> >  	kvm->arch.shadow_mmio_value = shadow_mmio_value;
> >  	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
> >  	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
> >  	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
> >  
> > +	r = kvm_mmu_alloc_page_hash(kvm);
> > +	if (r)
> > +		return r;
> > +
> 
> In the patch 3, shouldn't this be moved to else part of the below 
> 'if (tdp_mmu_enabled)' line? Otherwise, this hash array will always get
> allocated.

Ugh, I botched the rebase, and didn't point test that the allocations actually
went away.

Before commit 0df9dab891ff ("KVM: x86/mmu: Stop zapping invalidated TDP MMU roots
asynchronously"), kvm_mmu_init_tdp_mmu() returned a value and so the code was:

	if (tdp_mmu_enabled)
		r = kvm_mmu_init_tdp_mmu(kvm);
	else
		r = kvm_mmu_alloc_page_hash(kvm);
	if (r < 0)
		return r;

I suppose the least ugly approach is:

	if (tdp_mmu_enabled) {
		kvm_mmu_init_tdp_mmu(kvm);
	} else {
		r = kvm_mmu_alloc_page_hash(kvm);
		if (r)
			return r;
	}

> >  	if (tdp_mmu_enabled)
> >  		kvm_mmu_init_tdp_mmu(kvm);
> >  
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -12704,7 +12704,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> >  	if (ret)
> >  		goto out;
> >  
> > -	kvm_mmu_init_vm(kvm);
> > +	ret = kvm_mmu_init_vm(kvm);
> > +	if (ret)
> > +		goto out_cleanup_page_track;
> >  
> >  	ret = kvm_x86_call(vm_init)(kvm);
> >  	if (ret)
> > @@ -12757,6 +12759,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> >  
> >  out_uninit_mmu:
> >  	kvm_mmu_uninit_vm(kvm);
> > +out_cleanup_page_track:
> 
> I think there is a memory leak in this series.

/facepalm

Good job, me.

Thanks for the review!

