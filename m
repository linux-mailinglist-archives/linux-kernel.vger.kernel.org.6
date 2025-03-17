Return-Path: <linux-kernel+bounces-564983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A21DCA65E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43317ACD17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E91EB5DB;
	Mon, 17 Mar 2025 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWzyo4JG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C61E832F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240644; cv=none; b=b5dhRUaX+Vxv7Ngl0Cgdqomon3Hpx+mXv3sdYsex/z1xZi2M5au3G/Ne2iCwy6BgI9g+9XAa9MvFuLVuM650mdwXmLkHLYqgLWGfVZ48B+y2U1Rn5Z3Dj/pT3X4tsMoQ0DGFEKJWgDkXGUDUYc2oK1SSoWeXVHfSAz+uVSZ/7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240644; c=relaxed/simple;
	bh=a8vGscu3S40Os036mZXI+eElnD8bWcx+puivXuhMvTc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHqcxxMtjGpzMmLegkwhMlwe21VaBtCacVyVrcw25BkluOCBvNAmtQoVtNw9BFF2LRNiv63wXgzQbRc3GEDd4/y3/tQpHfc/PZ+fuGb7CsrOE/egy1d46Sp90AJCM85t78lP1oSIJjfzKGhfNJjAO4OryKLW5sMbDSHnvh43lB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWzyo4JG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3011bee1751so3751162a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742240642; x=1742845442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=na2cp2lUno+la+VBtxVAJtMeOi1hZL3/SfoDx822RBQ=;
        b=jWzyo4JGW621z/XMxkRi3LUZVD6g0ySDEe3jrvcO6JrevCmn2D5A1ObVGGCOvluYiM
         Ch1EOtyr58SGQ9PLaEj8v7+nzJLhIXuQFpdOJhJV5MeFqq1hIFI4c+UnVPoLS9JC+/BL
         DUT/5zwz9l58rFaykrcmGs1yZ9pana484EWs8qMcRHI29OnBZFqY633IiSD406VkLvxg
         lvYXVLtToFz9yA9IdqIx9xGDivuZimIRN+XQxp/V5P0C0MA4FXSnNZmPw/isDRpk3VDl
         4fYa1iDDaiJZrD+EZd1UrOpbNfnlhTVBONhTwqGOjJYgwVBAopTcM8tMtVOW5D7cgd7n
         17KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742240642; x=1742845442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=na2cp2lUno+la+VBtxVAJtMeOi1hZL3/SfoDx822RBQ=;
        b=abCls8d1vBiXY3ktg7AO19X94SHUln4x/CeZOH1Mwpew3x0N5Ii0WcHLTpSED069Bw
         3YOGYPW2ziGKkugYoCOCcYis9PrBPQbopmz4yXiW9OjmuHkpojWsPjyjW3OSVBd9hEsE
         Mv9VJX669vrxi9njUnESyL+JodXfLIeBGZ7b3NGNnNpAAwx2fFZYYKCtFE1Q9tMqb7mr
         n8fxcgQ9hbNN7ahVHIZY4CpDYD+HeVvO6ryUkxY8XN6ot6oiK0oKq/D56B77ZG5WG/C/
         8sGLkKuefR3lDyKyHL8HDWSEH+ANrHBS3YWz7wu2x6pRwAj3CEomt2/B2nDQkhapc+Gv
         k3ew==
X-Forwarded-Encrypted: i=1; AJvYcCUJBIXvfElV1DFVfnNKKnZZvKtmV3RP81mdJuC7XfZWO/AWuBEx5WsCBmJkvJtfXyoan4bndJEdQddnUYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQUrtamgXrPHl26BdOvup1sDgXtpZNrR5mhuYtd/UbZDT6SXz
	a/ErggaM/pZDcp2SYk103fEzAcVH/NeW0evwTC/WAScWZp9jR5G9tObwbXS3n5GJ+GIfJ9dZR/C
	4dQ==
X-Google-Smtp-Source: AGHT+IH5k69qql42UsEmhrDthlQuj0cVkZFynZegT0/HbDDK/pk/lfiDnezEWJwaFGoWC3aaiGxu/DkRf1s=
X-Received: from pjj14.prod.google.com ([2002:a17:90b:554e:b0:2fc:d77:541])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d4e:b0:2ea:aa56:499
 with SMTP id 98e67ed59e1d1-30151cb4c11mr15755968a91.1.1742240642242; Mon, 17
 Mar 2025 12:44:02 -0700 (PDT)
Date: Mon, 17 Mar 2025 12:43:53 -0700
In-Reply-To: <Z9hvwW2C-7_ivkPU@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250315025615.2367411-1-seanjc@google.com> <Z9hvwW2C-7_ivkPU@google.com>
Message-ID: <Z9h7eTs8i8TRRxqU@google.com>
Subject: Re: [PATCH] KVM: x86: Add a module param to control and enumerate
 device posted IRQs
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 17, 2025, Yosry Ahmed wrote:
> On Fri, Mar 14, 2025 at 07:56:15PM -0700, Sean Christopherson wrote:
> > Add a module param to allow disabling device posted interrupts without
> > having to sacrifice all of APICv/AVIC, and to also effectively enumerate
> > to userspace whether or not KVM may be utilizing device posted IRQs.
> > Disabling device posted interrupts is very desirable for testing, and can
> > even be desirable for production environments, e.g. if the host kernel
> > wants to interpose on device interrupts.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 1 +
> >  arch/x86/kvm/svm/avic.c         | 3 +--
> >  arch/x86/kvm/vmx/posted_intr.c  | 7 +++----
> >  arch/x86/kvm/x86.c              | 9 ++++++++-
> >  4 files changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index d881e7d276b1..bf11c5ee50cb 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1922,6 +1922,7 @@ struct kvm_arch_async_pf {
> >  extern u32 __read_mostly kvm_nr_uret_msrs;
> >  extern bool __read_mostly allow_smaller_maxphyaddr;
> >  extern bool __read_mostly enable_apicv;
> > +extern bool __read_mostly enable_device_posted_irqs;
> >  extern struct kvm_x86_ops kvm_x86_ops;
> >  
> >  #define kvm_x86_call(func) static_call(kvm_x86_##func)
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 65fd245a9953..e0f519565393 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -898,8 +898,7 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
> >  	struct kvm_irq_routing_table *irq_rt;
> >  	int idx, ret = 0;
> >  
> > -	if (!kvm_arch_has_assigned_device(kvm) ||
> > -	    !irq_remapping_cap(IRQ_POSTING_CAP))
> > +	if (!kvm_arch_has_assigned_device(kvm) || !enable_device_posted_irqs)
> 
> This function will now also be skipped if enable_apicv is false. Is this
> always the case here for some reason? Sorry if I missed something
> obvious.

Working as intended, though I failed to document it.  Hrm, but I wasn't expecting
this to be a functional change.  Oh, I know what happened.  I had originally
tacked this on to a big series to clean up the IRTE stuff (spoiler alert), and in
that series common code checked kvm_arch_has_irq_bypass() (which incorporates
enable_apicv) before calling pi_update_irte().

I'll prepend a patch or three to do minimal cleanup before introducing the new
module param.

> > @@ -9772,6 +9776,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
> >  	if (r != 0)
> >  		goto out_mmu_exit;
> >  
> > +	enable_device_posted_irqs = enable_device_posted_irqs && enable_apicv &&
> > +				    irq_remapping_cap(IRQ_POSTING_CAP);
> 
> Maybe this is clearer:
> 
> 	enable_device_posted_irqs &= enable_avivc && irq_remapping_cap(IRQ_POSTING_CAP);

I don't have a strong opinion.  I went with the "self check" approach purely
because SVM does so for a few params, e.b.

	nrips = nrips && boot_cpu_has(X86_FEATURE_NRIPS);

Anyone else care either way?  If not, I'll go with Yosry's suggestion.

