Return-Path: <linux-kernel+bounces-294304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E84958BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64C61C21B04
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41711990B5;
	Tue, 20 Aug 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="epIHfuZo"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E918E345
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170046; cv=none; b=ElounoQOEhczFEVk+g8mA715CaJYQkpMAJwlBv+daCT3tPVMOecbB9VH1l4MXRq8iMewde3n6TliWJYsgabNwoFAkUCqbz2lXe/WnXoEZhqzQvEitlyRFA2TLW66NTzCD5GONc8Wo74ER86/Kna6J3nn0zQDs5KzC7OL3R/txZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170046; c=relaxed/simple;
	bh=GuqNt/WKBwMOQjwuovf+qbKr3249vIBbAvbr+Cm3cLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O09O9D2+3U9L5HBbyhDkrrHUIQPvZk5+8Pr4mSWZgO9nfvmOh6bp8k0v6heJ1RAhxQuPW/esij6FF7uUYSI6UEpVm1KNiCmdTcEPnzMYCPiysfie+xS9GW6smhJ/4QMnSwqEYTejACql4HLApMPssjC5WZXlyjDOl4Gjyf1DWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=epIHfuZo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-201e24bd4d9so58047865ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724170044; x=1724774844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBLETOBLRe3FOaeolInTVXtiFI90U5zFa+5MnX88eIE=;
        b=epIHfuZok1tA3USNu4FrQrOx8I8vpcwJfY4jbfhcXhF0SVe6OrhFniWz5L4LwtlzSI
         werhUpJ0GzisfF8l1NFs/d4i2f9Y7PpnSNtdkOiZR23gISkRVpfZE+OOBuAyP5bHbEnF
         /BG0c4613ja30ArJqT/GgRI425MNADRmpSpFqixFPh2Z3DqdAdI/1+FbKKwkqwBM+hrJ
         HuhVKBdrCxwCtbkFcdykzubgtO1Yqjk5x2lN92utbO83/Z/thNYgsioVMKwpnSZ5y/No
         CbD9NZ3Nl/nzY8ybHctYy/1Ln8AM6uD1hP4jIK5Tlb4yw6q5fXz12x/63gETk9Vdt9gw
         vjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724170044; x=1724774844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBLETOBLRe3FOaeolInTVXtiFI90U5zFa+5MnX88eIE=;
        b=EZehzZYA0ZalU7Crna1r5GSKIMjTgu6S3N118YbO3PffBoL9J3bBEONdTn8QdjyaOK
         cak08Uqe1jLsJYuYpFfZmGqw5rYF9W6LsL2H6uX+s9lzuXqPM5RQIaiqbbT+ho+egXhg
         pDjlXrIytzRla9FZFqriumOvHmF7GalHEWrMfd6Gh0gcSt+eFDYTBQ+UZbP/CYWbfBZ9
         OHs6v+nqZbc97cB88FlLfkHxVcejGhmAVFpwSfK5djeskcwiUpWH+cau8Suyv5F5Uq+B
         PasMmqiuL0egMu/KZ5HVQ0471FtmKkYcK5KCnFeyObzvUmW2Ej8oGU5PRzd97B2Mhnl2
         bt4A==
X-Forwarded-Encrypted: i=1; AJvYcCXEkvD+0lYIRKYmyZbNJgi3effjHm3vDGeZ3HDvAGLaImv3lgo0xfDHMuOol/SSf84WFJ9DQqgFUtqs+7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsiUDtbTD0tVMKZoFzuBTtAwRcp9eVzAs7LdYTb9NFUr1onPo
	HvdWefWhRlvnk7oQAcs4SfqtfvPeLkJ/sYeh7Wa6OKRykVEYjNQ9Kxnvk1Ffkg6/eHudJBWcYgw
	GQw==
X-Google-Smtp-Source: AGHT+IHZu0MLZIkwzktJnFBnfwiJgxSvwp7590GQmqxYpMavl/flp6jy6p8nQmoOb7rKMH6bzVFbGX7RM/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:18e:b0:202:38d8:172 with SMTP id
 d9443c01a7336-20238d8021dmr7351955ad.5.1724170043696; Tue, 20 Aug 2024
 09:07:23 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:07:22 -0700
In-Reply-To: <20240820154150.GA28750@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802191617.312752-1-seanjc@google.com> <20240820154150.GA28750@willie-the-truck>
Message-ID: <ZsS_OmxwFzrqDcfY@google.com>
Subject: Re: [PATCH] KVM: Use precise range-based flush in mmu_notifier hooks
 when possible
From: Sean Christopherson <seanjc@google.com>
To: Will Deacon <will@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 20, 2024, Will Deacon wrote:
> Hi Sean,
> 
> On Fri, Aug 02, 2024 at 12:16:17PM -0700, Sean Christopherson wrote:
> > Do arch-specific range-based TLB flushes (if they're supported) when
> > flushing in response to mmu_notifier events, as a single range-based flush
> > is almost always more performant.  This is especially true in the case of
> > mmu_notifier events, as the majority of events that hit a running VM
> > operate on a relatively small range of memory.
> > 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> > 
> > This is *very* lightly tested, a thumbs up from the ARM world would be much
> > appreciated.
> > 
> >  virt/kvm/kvm_main.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index d0788d0a72cc..46bb95d58d53 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -599,6 +599,7 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
> >  	struct kvm_gfn_range gfn_range;
> >  	struct kvm_memory_slot *slot;
> >  	struct kvm_memslots *slots;
> > +	bool need_flush = false;
> >  	int i, idx;
> >  
> >  	if (WARN_ON_ONCE(range->end <= range->start))
> > @@ -651,10 +652,22 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
> >  					goto mmu_unlock;
> >  			}
> >  			r.ret |= range->handler(kvm, &gfn_range);
> > +
> > +			/*
> > +			 * Use a precise gfn-based TLB flush when possible, as
> > +			 * most mmu_notifier events affect a small-ish range.
> > +			 * Fall back to a full TLB flush if the gfn-based flush
> > +			 * fails, and don't bother trying the gfn-based flush
> > +			 * if a full flush is already pending.
> > +			 */
> > +			if (range->flush_on_ret && !need_flush && r.ret &&
> > +			    kvm_arch_flush_remote_tlbs_range(kvm, gfn_range.start,
> > +							     gfn_range.end - gfn_range.start))
> > +				need_flush = true;
> 
> Thanks for having a crack at this.
> 
> We could still do better in the ->clear_flush_young() case if the

For clear_flush_young(), I 100% think we should let architectures opt out of the
flush.  For architectures where it's safe, the primary MMU doesn't do a TLB flush,
and hasn't for years.  Sending patches for this (for at least x86 and arm64) is
on my todo list.

Even better would be to kill off mmu_notifier_clear_flush_young() entirely, e.g.
if all KVM architectures can elide the flush.

And even better than that would be to kill pxxx_clear_flush_young_notify() in
the kernel, but I suspect that's not feasible as there are architectures that
require a TLB flush for correctness.

> handler could do the invalidation as part of its page-table walk (for
> example, it could use information about the page-table structure such
> as the level of the leaves to optimise the invalidation further), but
> this does at least avoid zapping the whole VMID on CPUs with range
> support.
> 
> My only slight concern is that, should clear_flush_young() be extended
> to operate on more than a single page-at-a-time in future, this will
> silently end up invalidating the entire VMID for each memslot unless we
> teach kvm_arch_flush_remote_tlbs_range() to return !0 in that case.

I'm not sure I follow the "entire VMID for each memslot" concern.  Are you
worried about kvm_arch_flush_remote_tlbs_range() failing and triggering a VM-wide
flush?

