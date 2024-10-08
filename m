Return-Path: <linux-kernel+bounces-355556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE41A995405
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F34FB2727D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC771E00B4;
	Tue,  8 Oct 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYOfN1Jb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C064A8F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403642; cv=none; b=BMSpqm6UqbtGtCSS0xWQdlTyVZBg19xYUuerxXwd/mmrVfUsXerw82XO/AMqhlpsk3b4M7oYiuIVV1WunOaYQyURZ9cgMjHrDQkgpxNTaOF4Q3+95WdfdYWfrv3UoEoMTNCtCiR9u9tXD1PpX96dM20B29FZvIbpRUYxous2U9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403642; c=relaxed/simple;
	bh=Jryp7LH+8F0BmJi4LTiGbJ1Y9iu7yCp25arP1ycMQNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KfO0QUzEOkL77pD+yNQ5w85VYrzY5IxGAt7PzHIRnxtrjZpzwXQH3g7hj6EjXDschXSWN6PrhMcSq/QtD9dWlB+aj8N6iPfy/NvjCC4huEok0GA7Yqez60IbQrlF2UguvsllX2NZDw3X/AgpxSKCLLBKiua9kGpyj37vKjRrK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYOfN1Jb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25d62bfe12so8944011276.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728403639; x=1729008439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2GrBB1U08T2w/p1kNVN37u8zyKk4xj/d7lqFEpuNQg=;
        b=XYOfN1JbzS2aorkz30evFJxxXmQJs00IgZr8H/J1o1FMAQ3HfuaHr6zVBRJcRYOrmn
         iadKwcG0xWYrkOjbH0HlZenghlaWmo9ZVCsO+D8i8x6QXlvfx4wdJAcbdQTK19mJ3KLo
         weFACiXtaa0imsJKY1Tyhd5hVkkR7Ku2/qEFNxVBBqiTwe5KC5eCXi39i4di0jx4zGKz
         TbbXgqXg1Sy2M0pR4j/sBf/iwXAz+KLPlmO5gACTctIdlr9/zDJ5iTfnGBHcuYlJ8iyI
         w9xb5eUEKdd4J6P2A5/209ag0Gz/S031EY6/TAZM9kpTDBYRupicgbO4feiNoFTRx/0e
         Ir6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403639; x=1729008439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2GrBB1U08T2w/p1kNVN37u8zyKk4xj/d7lqFEpuNQg=;
        b=azTI2/tl64S0yj65Yd7gtiSRccT8tp1pBQfrB/VxViPvqBB4UD25m32JZQ6QUA1EiM
         8Z+jA8nu0i+DAmRi7lp0XMo4/kdrscXfRt6FOJfitO+2ECX+Q2n1NGSj6x8wAfyvlO9s
         PEPyPQ4hlmQI6oMYta2m1b6pEkQSHkzE90QpOIuNX1iIVDj9uRB2lT8rD/TG4AZV7nlX
         AFI10A9tBp7GTdHGOsTJ/8fqyvB5dNI4IoMVljB97AbKRgdiTCdMAtotMvtUjojXq5nt
         sY0xINuoWpHcnzj1tFPhx7WJg3WYzXMyqLQq1jCXWoe1IecDl+rSiMeau7PMpwPCr4MO
         f4rw==
X-Forwarded-Encrypted: i=1; AJvYcCWoXLT/3s0UFIcm+iOqZuQMGvKrw4aJFuBmaeyfRnwAmVMgZpI1basOd42ZdZSCg28cS7xwzpL+f53Y9A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz93bPUuBU+pUv/WoPNJE554lkFsTgUJhQTeqS39EQ+7XCEYeAm
	DxRbJPmpUGHtqN4fGPasgBK9tXg5ikYlnQK7eHLmQ2D3lG1d8HahS3ZYKOn1ADrmxPf9Bp+lt1t
	VOA==
X-Google-Smtp-Source: AGHT+IEkX/NNjX7Bqm2H8qUc1h2OJv8Pv4ROroEQ8Ifzfk0p1QvySMglhwTVS6UCdy4Zjq8Lob8owYfcAXw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:a206:0:b0:e03:53a4:1a7 with SMTP id
 3f1490d57ef6-e289394dedemr66667276.10.1728403639316; Tue, 08 Oct 2024
 09:07:19 -0700 (PDT)
Date: Tue, 8 Oct 2024 09:07:17 -0700
In-Reply-To: <ZwSAZ0uiwhKOZVlN@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6eecc450d0326c9bedfbb34096a0279410923c8d.1726182754.git.isaku.yamahata@intel.com>
 <ZuOCXarfAwPjYj19@google.com> <ZvUS+Cwg6DyA62EC@yzhao56-desk.sh.intel.com>
 <Zva4aORxE9ljlMNe@google.com> <ZvbB6s6MYZ2dmQxr@google.com>
 <ZvkdkAQkN5LmDaE6@yzhao56-desk.sh.intel.com> <ZvrJvucBw1iIwEG6@google.com> <ZwSAZ0uiwhKOZVlN@yzhao56-desk.sh.intel.com>
Message-ID: <ZwVYtaKFKat0OeWY@google.com>
Subject: Re: [PATCH] KVM: x86/tdp_mmu: Trigger the callback only when an
 interesting change
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, kvm@vger.kernel.org, sagis@google.com, 
	chao.gao@intel.com, pbonzini@redhat.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 08, 2024, Yan Zhao wrote:
> On Mon, Sep 30, 2024 at 08:54:38AM -0700, Sean Christopherson wrote:
> > On Sun, Sep 29, 2024, Yan Zhao wrote:
> > > On Fri, Sep 27, 2024 at 07:32:10AM -0700, Sean Christopherson wrote:
> > > >  * Don't flush if the Accessed bit is cleared, as access tracking tolerates
> > > >  * false negatives, and the one path that does care about TLB flushes,
> > > >  * kvm_mmu_notifier_clear_flush_young(), uses mmu_spte_update_no_track().
> > > I have a question about why access tracking tolerates false negatives on the
> > > path kvm_mmu_notifier_clear_flush_young().
> > > 
> > > kvm_mmu_notifier_clear_flush_young() invokes kvm_flush_remote_tlbs()
> > > only when kvm_age_gfn() returns true. But age_gfn_range()/kvm_age_rmap() will
> > > return false if the old spte is !is_accessed_spte().
> > > 
> > > So, if the Access bit is cleared in make_spte(), is a TLB flush required to
> > > avoid that it's not done in kvm_mmu_notifier_clear_flush_young()?
> > 
> > Because access tracking in general is tolerant of stale results due to lack of
> > TLB flushes.  E.g. on many architectures, the primary MMU has omitted TLB flushes
> > for years (10+ years on x86, commit b13b1d2d8692).  The basic argument is that if
> > there is enough memory pressure to trigger reclaim, then there will be enough TLB
> > pressure to ensure that omitting the TLB flush doesn't result in a large number
> > of "bad" reclaims[1].  And conversely, if there isn't much TLB pressure, then the
> > kernel shouldn't be reclaiming.
> > 
> > For KVM, I want to completely eliminate the TLB flush[2] for all architectures
> > where it's architecturally legal.  Because for KVM, the flushes are often even
> > more expensive than they are for the primary MMU, e.g. due to lack of batching,
> > the cost of VM-Exit => VM-Enter (for architectures without broadcast flushes).
> > 
> > [1] https://lore.kernel.org/all/CAOUHufYCmYNngmS=rOSAQRB0N9ai+mA0aDrB9RopBvPHEK42Ng@mail.gmail.com
> > [2] https://lore.kernel.org/all/Zmnbb-Xlyz4VXNHI@google.com
> 
> It makes sense. Thanks for explanation and the provided links!
> 
> Thinking more about the prefetched SPTEs, though the A bit tolerates fault
> negative, do you think we still can have a small optimization to grant A bit to
> prefetched SPTEs if the old_spte has already set it? So that if a prefault
> happens right after a real fault, the A bit would not be cleared, basing on that
> KVM not changing PFNs without first zapping the old SPTE.
> (but I'm not sure if you have already covered this optmication in the
> mega-series).

Already handled :-)

Though I need to test the shadow MMU code, as I was initially thinking the issue
was unique to the TDP MMU (no idea why I thought that).

Hmm, though I think something like what you've proposed may be in order.  There
are currently four cases where @prefetch will be true:

 1. Prefault
 2. Async #PF
 3. Prefetching
 4. FNAME(sync_spte)

For 1-3, KVM shouldn't overwrite an existing shadow-present SPTE, which is what
my code does.

But for 4, FNAME(sync_spte) _needs_ to overwrite an existing SPTE.  And, ignoring
the awful A/D-disabled case, FNAME(prefetch_invalid_gpte) ensures the gPTE is
Accessed, i.e. there's no strong argument for clearing the Accessed bit.

Hrm, but the _only_ "speculative" access type when commit 947da5383069 ("KVM:
MMU: Set the accessed bit on non-speculative shadow ptes") went in was the
FNAME(sync_spte) case (at the time called FNAME(update_pte)).  I.e. KVM deliberately
clears the Accessed bit for that case.

But, I'm unconvinced that's actually appropriate.  As above, the gPTE is accessed,
and kvm_sync_spte() ensures the SPTE is shadow-present (with an asterisk, because
it deliberately doesn't use is_shadow_present() SPTE so that KVM can sync MMIO
SPTEs).

Aha!  Before commit c76e0ad27084 ("KVM: x86/mmu: Mark page/folio accessed only
when zapping leaf SPTEs"), clearing the Accessed bit kinda sorta makes sense,
because KVM propagates the information to the underlying struct page.  But when
that code is removed, KVM's SPTEs are the "source of truth" so to speak.

Double aha!  Spurious clearing of the Accessed (and Dirty) was mitigated by commit
e6722d9211b2 ("KVM: x86/mmu: Reduce the update to the spte in FNAME(sync_spte)"),
which changed FNAME(sync_spte) to only overwrite SPTEs if the protections are
actually changing.

So at the very least, somewhere in all of this, we should do as you suggest and
explicitly preserve the Accessed bit.  Though I'm quite tempted to be more aggressive
and always mark the SPTE as accessed when synchronizing, because odds are very
good that the guest still cares about the page that's pointed at by the unsync
SPTE.  E.g. the most common case where FNAME(sync_spte) actually overwrites an
existing SPTE is CoW in the guest.

I'll think a bit more on this, and either go with a variant of the below, or
something like:

	if (!prefetch || synchronizing)
		spte |= spte_shadow_accessed_mask(spte);

> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -163,6 +163,8 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>         int level = sp->role.level;
>         u64 spte = SPTE_MMU_PRESENT_MASK;
>         bool wrprot = false;
> +       bool remove_accessed = prefetch && (!is_shadow_present_pte(old_spte) ||
> +                              !s_last_spte(old_spte, level) || !is_accessed_spte(old_spte))
>         /*
>          * For the EPT case, shadow_present_mask has no RWX bits set if
> @@ -178,7 +180,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>                 spte |= SPTE_TDP_AD_WRPROT_ONLY;
>  
>         spte |= shadow_present_mask;
> -       if (!prefetch)
> +       if (!remove_accessed)
>                 spte |= spte_shadow_accessed_mask(spte);
>  
>         /*
> @@ -259,7 +261,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>                 spte |= spte_shadow_dirty_mask(spte);
>  
>  out:
> -       if (prefetch)
> +       if (remove_accessed)
>                 spte = mark_spte_for_access_track(spte);
>  
>         WARN_ONCE(is_rsvd_spte(&vcpu->arch.mmu->shadow_zero_check, spte, level),

