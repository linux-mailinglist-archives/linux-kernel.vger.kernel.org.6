Return-Path: <linux-kernel+bounces-361860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1799AE01
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774491F24FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86231D1518;
	Fri, 11 Oct 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2xhD5Oo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6D1CCEC7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728681757; cv=none; b=dV5wg8p9QmphmAvLjOaDnMGYqONQBMTKuRSAv4ha58Avwi+JTuEMfoqZxHQ4vqwc/qyvPdcDY+hyqwbLRbJr3t7LcXuNh7c+N52JMsDWG4U9iAsl5wiGs0vkRyPdTY2XxUaJZWOrMQy0Ys6BY5fWu91cl3LYfMV9f3yoKWfC9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728681757; c=relaxed/simple;
	bh=8yrhJxTPEmA+lV8X8aA4mVh5ZQlxvMpXifIu33PWNQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kQMP3/MoUIA7D+FbD4gkV6UJ0ucG6iTSJ23zEJ+I0i1C1yemEEXXBQrtQUlXlJcJj4vXA+nM7iiOIRUpWtWseaM0A8itOdjUl8lpk8EVnEaBPr842DPnSHe4R8J3n3efHU7TR13uJAOuio6rRXbJFux/uNI84kuy8O79nxkb5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2xhD5Oo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3529d80e5so13726607b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728681754; x=1729286554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfxKra0QMYuqtLRZLgn1kR3MPSfcM5KS33w9dB++uGA=;
        b=L2xhD5OoikoVrEl+QiLn83uJDuV7NV3m7sYnT7KxC9xFl2h+jsYSYvDVvwiep/cLNi
         0hVaBGFUUFU47jwxHWw0U3zZbLwXcyPv3vkJDbQ/hrAET1Xuzcwg1FbwlLG+UuAd7jIG
         A+yv7EG+gjSxwLtEaLKVEbd48vov95AOum4xzGqgK+Voy2lXX2B2C4acoUd6zKxICzGt
         ip2YLajWNC4U0djGmM2rtmW8XPd+4cvbWSz8995cF4f7VEBkDMHUx1ZOQO0LV2I3XTAc
         9IoPVynwClIhAkffIh+wt7AO28tIZ8KkGDhTheo0z3n9m5U+jyvYPBi0Zy4bd6vteOou
         8e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728681754; x=1729286554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfxKra0QMYuqtLRZLgn1kR3MPSfcM5KS33w9dB++uGA=;
        b=sQT2N0Gf8KJCO+kU2jAb6FwOVO5IkV0vTwlHbFOCLmOXpKUYZK44Eaq/ccCFus6dEC
         t8Fdhp8YXJzAcMqP4ybpCSDHQ5rk+Im4RllTlQrNvh755NJ0bSc11IyXJ6yt+sNslKSy
         bgz2itn4e8LPgyIVV9EjrKvhyDziPmyea/UB4Yic1+jWI22jbaEMW3QEDYLMkpALvLYa
         KvRkxhmQkXrhwWICnBErZKxCzdG4mkPpdJ9VtEeD/KpdXCH73S3KkcBR8UcYWs4/e2Pp
         Qs1ej3oG20/kM1hRG6Q6eBDDgWbKj5LCibKsxPjqW3wfdWLkh3jOoBtean8ReJ/qm1N5
         kucA==
X-Forwarded-Encrypted: i=1; AJvYcCWviALXvDAk/E8JhUDsNgmJksA3a1uWZxf9Px2r5dKgtiSpZRezZ1zVWXwq/VYmbsl0eJThWh+Q/mayt4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgR/OfvFEG5+DiUqw4EeFklldVqtHTlrcAmXM2G606lwUR5XXy
	ZyB0FV/BBXN54OxJw0uQlMIdLcE764ZvzOW2t9PoDE1ru00tqI8A4n2td4YlGWELiedhgWovhg8
	usw==
X-Google-Smtp-Source: AGHT+IEuzhhKTg1oOETdykTlofSzGwmkypQx/8EyEKtabRiMxJLeu1de1NAXEgZxF0dauPcFiqJf3MahPCg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3190:b0:6e2:371f:4af9 with SMTP id
 00721157ae682-6e347b37d57mr439337b3.3.1728681754523; Fri, 11 Oct 2024
 14:22:34 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:22:32 -0700
In-Reply-To: <Zwi5ogcOiu7aG5hK@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009192345.1148353-1-seanjc@google.com> <20241009192345.1148353-3-seanjc@google.com>
 <Zwd75Nc8+8pIWUGm@yzhao56-desk.sh.intel.com> <Zwf9cSjhlp5clpTm@google.com> <Zwi5ogcOiu7aG5hK@yzhao56-desk.sh.intel.com>
Message-ID: <ZwmXGIVysayOnj-k@google.com>
Subject: Re: [PATCH 2/3] KVM: x86/mmu: Add lockdep assert to enforce safe
 usage of kvm_unmap_gfn_range()
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 11, 2024, Yan Zhao wrote:
> On Thu, Oct 10, 2024 at 09:14:41AM -0700, Sean Christopherson wrote:
> > On Thu, Oct 10, 2024, Yan Zhao wrote:
> > > On Wed, Oct 09, 2024 at 12:23:44PM -0700, Sean Christopherson wrote:
> > > > Add a lockdep assertion in kvm_unmap_gfn_range() to ensure that either
> > > > mmu_invalidate_in_progress is elevated, or that the range is being zapped
> > > > due to memslot removal (loosely detected by slots_lock being held).
> > > > Zapping SPTEs without mmu_invalidate_{in_progress,seq} protection is unsafe
> > > > as KVM's page fault path snapshots state before acquiring mmu_lock, and
> > > > thus can create SPTEs with stale information if vCPUs aren't forced to
> > > > retry faults (due to seeing an in-progress or past MMU invalidation).
> > > > 
> > > > Memslot removal is a special case, as the memslot is retrieved outside of
> > > > mmu_invalidate_seq, i.e. doesn't use the "standard" protections, and
> > > > instead relies on SRCU synchronization to ensure any in-flight page faults
> > > > are fully resolved before zapping SPTEs.
> > > > 
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > ---
> > > >  arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > index 09494d01c38e..c6716fd3666f 100644
> > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > @@ -1556,6 +1556,16 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> > > >  {
> > > >  	bool flush = false;
> > > >  
> > > > +	/*
> > > > +	 * To prevent races with vCPUs faulting in a gfn using stale data,
> > > > +	 * zapping a gfn range must be protected by mmu_invalidate_in_progress
> > > > +	 * (and mmu_invalidate_seq).  The only exception is memslot deletion,
> > > > +	 * in which case SRCU synchronization ensures SPTEs a zapped after all
> > > > +	 * vCPUs have unlocked SRCU and are guaranteed to see the invalid slot.
> > > > +	 */
> > > > +	lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
> > > > +			    lockdep_is_held(&kvm->slots_lock));
> > > > +
> > > Is the detection of slots_lock too loose?
> > 
> > Yes, but I can't think of an easy way to tighten it.  My original thought was to
> > require range->slot to be invalid, but KVM (correctly) passes in the old, valid
> > memslot to kvm_arch_flush_shadow_memslot().
> > 
> > The goal with the assert is to detect as many bugs as possible, without adding
> > too much complexity, and also to document the rules for using kvm_unmap_gfn_range().
> > 
> > Actually, we can tighten the check, by verifying that the slot being unmapped is
> > valid, but that the slot that KVM sees is invalid.  I'm not sure I love it though,
> > as it's absurdly specific.
> Right. It doesn't reflect the wait in kvm_swap_active_memslots() for the old
> slot.
> 
>   CPU 0                  CPU 1
> 1. fault on old begins
>                        2. swap to new
> 		       3. zap old
> 4. fault on old ends
> 
> Without CPU 1 waiting for 1&4 complete between 2&3, stale data is still
> possible.
> 
> So, the detection in kvm_memslot_is_being_invalidated() only indicates the
> caller is from kvm_arch_flush_shadow_memslot() with current code.

Yep, which is why I don't love it.

> Given that, how do you feel about passing in a "bool is_flush_slot" to indicate
> the caller and asserting?

I like it even less than the ugliness I proposed :-)  It'd basically be a "I pinky
swear I know what I'm doing" flag, and I think the downsides of having true/false
literals in the code would outweigh the upside of the precise assertion.

