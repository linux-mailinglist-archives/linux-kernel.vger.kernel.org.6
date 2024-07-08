Return-Path: <linux-kernel+bounces-244769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0F992A92A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69312281EA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB45E14B973;
	Mon,  8 Jul 2024 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wxFS7yrd"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDB14A4F0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464401; cv=none; b=PnbTO3vJy3RVr+EWih0Lx4KLAa2EsoIo/NZO+jVijfoM6yB1PJQqqj2WqvQ1aPXNSA8jP/bgbK4ijU2ZEi/SX6P2Qt/dbEhtyJ49PyDLuCPcS6V9Dz9925iIom/+zHir6XHk9dwpVaUocJd2G4BFLmzDrvYD/1DuL7zzz5xQrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464401; c=relaxed/simple;
	bh=/56atsTfTjnPrs5FoFv6UOTudwyM14s/+SUgSWC9RwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RH0UDe/hpfeyCrB3i/Y2yUZ5LDa+/9235OUNgrG0i1zL8czRlB52jcJ9df/R3pcFDeb3DvETLyxv5PTAwGCQtkSkofuxj8pXfd3Okw9ULHFxHMtkVdoV/6CM3fi9tnkZPPxhgASxX4FwuDAYMKGqq8xiQoqMPSHMzHTMlggq5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wxFS7yrd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c974ec599cso3269101a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720464399; x=1721069199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OluAXyDL51IclfJ6R+9CYULEGL1p2Kv9cyIlkwcQ5XM=;
        b=wxFS7yrdmwamqePz3IxfQJS3nTMszUWTcaSlBJnHUEqAKyWI/G8OPvLwhMvnk4lrjy
         mSsX1XBqcTzfsTSRzlE0HAF9IxOjAxD4XYXLbLk0oAqSivkecmBqibHFn9Oar1uayYL0
         EUG5K0PnmlfQhWpZsesvC+yAhFj1VeR2Xk0zES8DSXUI1cIsBkqHZ2ypZ+WZWDTaT60K
         BYckzZy9aq9T3/Vf/rtDqSkOtzlWROUANWM6dzxc75/mI/2AAT7/L1SVRw4J9aB9XPcB
         ke0O9DGNejVq/Zn6wHwQxfBtP9Q+NNJbcLUa03Nz2QA5yPandamfziV7L/wr+b8JAwMk
         Hapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720464399; x=1721069199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OluAXyDL51IclfJ6R+9CYULEGL1p2Kv9cyIlkwcQ5XM=;
        b=QQx7VeZ5K+1B3s7THvV3/MJA8p+qd4alLt2aNGXBkrgG+g2ckf6kL77RJNgrGH6dM6
         sEFnyWyL1D5S3LykkRfkj8Na3gr9RaZjVFePIx7imlPR2DLt5mu4uWACCyG26w92pbT+
         CWJZWEglvuaBMXMB1z3PSSaSFxt14WSy/fNSRXZk+UGD6b4iQOgVKXe4iiCC/rzSW56V
         HE7RKZrSEqDPcsd1benYAbxWWmNRRNS8DiEHycRDC/+JusbdyLsLcRyT0pcEwzSbUCSh
         yyFNy5dYRzgTOk7kHFtgWb6n+utiT4IBNpUbGByr6pM3in8UVF1TrH5qcdNyPL1x7NUi
         xotw==
X-Forwarded-Encrypted: i=1; AJvYcCU8KfxFwsmdPHcQind/YHRXsL+w+5GrTvCYyVTi3Jh2Lodf+YpwR5g7mQwZzVJdrgBEW7TDV5FjyCHowwfDZ65WNeMeDLHGId+FtD0u
X-Gm-Message-State: AOJu0YwNdFtqIro0DqYLaaF9ySzTfHaOrlRDk83U0MUCNPnlIqY8sfkK
	CUOjzuDucXNoyzczAXWCB/Ssbr3Az6aWaaATz8FC1hZvHpMq8wLrZyt9HNawsQ9zOd3LY4IIHZx
	gyw==
X-Google-Smtp-Source: AGHT+IEWMwmVefMuRwYf0AC9746JYti0Vj5RtvLEERFqD6hMD3wc5rWK9NthfopBzTb3qZFVuVqsYgmYh9c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:f18b:b0:2c6:d13f:3f9e with SMTP id
 98e67ed59e1d1-2ca3a7abd45mr337a91.1.1720464399107; Mon, 08 Jul 2024 11:46:39
 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:46:37 -0700
In-Reply-To: <62cbd606f6d636445fd1352ae196a0973c362170.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-2-seanjc@google.com>
 <62cbd606f6d636445fd1352ae196a0973c362170.camel@redhat.com>
Message-ID: <Zow0DVn4CvIxzGYz@google.com>
Subject: Re: [PATCH v2 01/49] KVM: x86: Do all post-set CPUID processing
 during vCPU creation
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
> > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > index 23dbb9eb277c..0a8b561b5434 100644
> > --- a/arch/x86/kvm/cpuid.h
> > +++ b/arch/x86/kvm/cpuid.h
> > @@ -11,6 +11,7 @@
> >  extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
> >  void kvm_set_cpu_caps(void);
> >  
> > +void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
> >  void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu);
> >  void kvm_update_pv_runtime(struct kvm_vcpu *vcpu);
> >  struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index d750546ec934..7adcf56bd45d 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -12234,6 +12234,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> >  	kvm_xen_init_vcpu(vcpu);
> >  	kvm_vcpu_mtrr_init(vcpu);
> >  	vcpu_load(vcpu);
> > +	kvm_vcpu_after_set_cpuid(vcpu);
> 
> This makes me a bit nervous. At this point the vcpu->arch.cpuid_entries is
> NULL, but so is vcpu->arch.cpuid_nent so it sort of works but is one mistake
> away from crash.
>
> Maybe we should add some protection to this, e.g empty zero cpuid or
> something like that.

Hmm, a crash is actually a good thing.  In the post-KVM_SET_CPUID2 case, if KVM
accessed vcpu->arch.cpuid_entries without properly consulting cpuid_nent, the
resulting failure would be a out-of-bounds read.  Similarly, a zeroed CPUID array
would effectiely mask any bugs.

Given that KVM heavily relies on "vcpu" to be zero-allocated, and that changing
cpuid_nent during kvm_arch_vcpu_create() would be an extremely egregious bug,
a crash due to a NULL-pointer dereference should never escape developer testing,
let alone full release testing.

KVM does the "empty" array thing for IRQ routing (though in that case the array
and the nr_entries are in a single struct), and IMO it's been a huge net negative
because it's led to increased complexity just so that arch code can omit a NULL
check.

