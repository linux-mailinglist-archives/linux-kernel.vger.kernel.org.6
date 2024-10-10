Return-Path: <linux-kernel+bounces-359541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC26998CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294D91F26172
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7052E1CDFCE;
	Thu, 10 Oct 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkXWWeIG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392241CDA2D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576885; cv=none; b=k6Ij64RDQ+iJjbL6ZUqIYk0EUKKt53veoOQ0kHlFy70Xq2c/qtEJP2oXBIeSM9pG3+DlVs0NefjDPCMhgHNIivk++5kQa42nBNgMrBNe+UukqzDDPw2PnWnJ25A3dWjWjlfVPl5xXzsYopKHXCMDtD9z1h+4YUL3XYDNbrh8sgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576885; c=relaxed/simple;
	bh=SFwqU91UqXubaMd920BJMXFwfe/8S888ClNoO2Vjj2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fjc4fV6+/5hj5ddRXIkyMn8oVcuVXMum5hpoJjhG6SOTMY24geDt439MbHrheH1PLlYJ7Yxloy9H7kmwh+PD6UYmyjeDUy7IvZs4zWe2X1F8vAGaKzOwH5cVaOVixnGPypuvH5oCzfdnesk1yEGiDdKFa5MMFDVwR0WbbxTcSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkXWWeIG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e30fe2a9feso14373607b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728576883; x=1729181683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWAVPe7k8rd+2+QlAStjk+Ev1iLgZ7m4p8ZW490ckFE=;
        b=ZkXWWeIGsk2qEjLM8PROr20h38SMMiEjhA8qUAFs21PULrURPmeGie/qrH533w3Hwv
         ZI2gHRFddj6LJB9+5g5LVApRIjL5JFMZEqtOzby7ptRUfBndLUsAXu4JH0B66iof7Cqi
         RrgwlzeCglJVWCUUSBZxVwGza6wVipxggL+MAxKuquOU5EdwMPjBdyMB1JK+0USws+Ke
         t0SQ1CjTaWAD0aRgW32DvxmKhkU+o4BOubAwhSih8GcNASWrMn7KJCR5IIUw6dTEfr+z
         RGcZnfal5zHIkhMKzsYvNgBxrPTBXFYhLrvYn8OuVc1xCiXWIXEkXZO7mOs5eZ0wi3VY
         BUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728576883; x=1729181683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWAVPe7k8rd+2+QlAStjk+Ev1iLgZ7m4p8ZW490ckFE=;
        b=bRkqq0oXD4CTE5IfeqalG/4G10fOZ3BMvAglWRGKLzLaguUKmsI6w9ut2qvXbnTCr9
         yTqyTKcp8PyBY4G9bGWRY+GcCA1z7c/XvNZCzY68B2RQmzHWrBXYqGcir0GN0VSUYbf/
         jpb5O5Rl5nh9LMQXf8FjSN9IkQyLxFbuDJuH881kBPdRDZIH7pWf6UCY9SFtW/0kiL6u
         ZRr9J81A0H9OM9YyZK5gzW0cOhwacCzNRm3Xx2pSPORjog32xweVNw4FMQvURofOEx6V
         Bt4wqkUH/iu7aMwXZdlHjIFzTIh8PHU17BdS/Rw3suJCdtCvTu2lF38mV5wdPrPPtJ7U
         N3mg==
X-Forwarded-Encrypted: i=1; AJvYcCVeYOm3GW089DtehdYKEL4qHTrkTdMwFJuI20V898jWFd1RVmrZikqINzAwPEpUrjiwGYN90ggMOjnx/ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuS9yRrsWO8AnVeufk+9Nzmd7bWxDp+d/sZGK9b6aIujPw5qOo
	24P8/pToyIc4wPRzIb4Nrk2a06wxQHZQu857CKlyTlnhgj5ba43lyvAgniAx56di/exItGMix2Z
	OLQ==
X-Google-Smtp-Source: AGHT+IHNyx9a0JKUz7Ida+yhhL4jvx1d2ijTI5cJYmB9Djr54GGWfUWTsTyzKt1LAgDAlrhUHm/H8tfL4Lo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:20a3:b0:6e3:b08:92c7 with SMTP id
 00721157ae682-6e321fb7d24mr222557b3.0.1728576883263; Thu, 10 Oct 2024
 09:14:43 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:14:41 -0700
In-Reply-To: <Zwd75Nc8+8pIWUGm@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009192345.1148353-1-seanjc@google.com> <20241009192345.1148353-3-seanjc@google.com>
 <Zwd75Nc8+8pIWUGm@yzhao56-desk.sh.intel.com>
Message-ID: <Zwf9cSjhlp5clpTm@google.com>
Subject: Re: [PATCH 2/3] KVM: x86/mmu: Add lockdep assert to enforce safe
 usage of kvm_unmap_gfn_range()
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 10, 2024, Yan Zhao wrote:
> On Wed, Oct 09, 2024 at 12:23:44PM -0700, Sean Christopherson wrote:
> > Add a lockdep assertion in kvm_unmap_gfn_range() to ensure that either
> > mmu_invalidate_in_progress is elevated, or that the range is being zapped
> > due to memslot removal (loosely detected by slots_lock being held).
> > Zapping SPTEs without mmu_invalidate_{in_progress,seq} protection is unsafe
> > as KVM's page fault path snapshots state before acquiring mmu_lock, and
> > thus can create SPTEs with stale information if vCPUs aren't forced to
> > retry faults (due to seeing an in-progress or past MMU invalidation).
> > 
> > Memslot removal is a special case, as the memslot is retrieved outside of
> > mmu_invalidate_seq, i.e. doesn't use the "standard" protections, and
> > instead relies on SRCU synchronization to ensure any in-flight page faults
> > are fully resolved before zapping SPTEs.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 09494d01c38e..c6716fd3666f 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -1556,6 +1556,16 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> >  {
> >  	bool flush = false;
> >  
> > +	/*
> > +	 * To prevent races with vCPUs faulting in a gfn using stale data,
> > +	 * zapping a gfn range must be protected by mmu_invalidate_in_progress
> > +	 * (and mmu_invalidate_seq).  The only exception is memslot deletion,
> > +	 * in which case SRCU synchronization ensures SPTEs a zapped after all
> > +	 * vCPUs have unlocked SRCU and are guaranteed to see the invalid slot.
> > +	 */
> > +	lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
> > +			    lockdep_is_held(&kvm->slots_lock));
> > +
> Is the detection of slots_lock too loose?

Yes, but I can't think of an easy way to tighten it.  My original thought was to
require range->slot to be invalid, but KVM (correctly) passes in the old, valid
memslot to kvm_arch_flush_shadow_memslot().

The goal with the assert is to detect as many bugs as possible, without adding
too much complexity, and also to document the rules for using kvm_unmap_gfn_range().

Actually, we can tighten the check, by verifying that the slot being unmapped is
valid, but that the slot that KVM sees is invalid.  I'm not sure I love it though,
as it's absurdly specific.

(untested)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c6716fd3666f..12b87b746b59 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1552,6 +1552,17 @@ static bool __kvm_rmap_zap_gfn_range(struct kvm *kvm,
                                 start, end - 1, can_yield, true, flush);
 }
 
+static kvm_memslot_is_being_invalidated(const struct kvm_memory_slot *old)
+{
+       const struct kvm_memory_slot *new;
+
+       if (old->flags & KVM_MEMSLOT_INVALID)
+               return false;
+
+       new = id_to_memslot(__kvm_memslots(kvm, old->as_id), old->id);
+       return new && new->flags & KVM_MEMSLOT_INVALID;
+}
+
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
        bool flush = false;
@@ -1564,7 +1575,8 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
         * vCPUs have unlocked SRCU and are guaranteed to see the invalid slot.
         */
        lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
-                           lockdep_is_held(&kvm->slots_lock));
+                           (lockdep_is_held(&kvm->slots_lock) &&
+                            kvm_memslot_is_being_invalidated(range->slot));
 
        if (kvm_memslots_have_rmaps(kvm))
                flush = __kvm_rmap_zap_gfn_range(kvm, range->slot,


> If a caller just holds slots_lock without calling
> "synchronize_srcu_expedited(&kvm->srcu)" as that in kvm_swap_active_memslots()
> to ensure the old slot is retired, stale data may still be encountered. 
> 
> >  	if (kvm_memslots_have_rmaps(kvm))
> >  		flush = __kvm_rmap_zap_gfn_range(kvm, range->slot,
> >  						 range->start, range->end,
> > -- 
> > 2.47.0.rc1.288.g06298d1525-goog
> > 

