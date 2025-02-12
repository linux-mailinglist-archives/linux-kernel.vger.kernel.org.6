Return-Path: <linux-kernel+bounces-511961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C95A33213
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743F03A3149
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F97820409E;
	Wed, 12 Feb 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zqChrpn/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166620011E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398023; cv=none; b=p0eaIsHhplJAc2SmkZeJhizlQPDt1YjyDV4rIy+XSxuNPS+aH3HXa26he+EcjE5ZUA6RuIq19N1IgJUO2XTNb+Bp8ADRLr4ZAJWDdE9W6l5RBZcidRIL1QDuhCCf8xsElyuYf7XWOrTP53i+ZYA9pcSWtZ1HePLEtVyPt5y7EWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398023; c=relaxed/simple;
	bh=W3EI/JwSNPCRO8AUPEByM5MP57IzTM5+fEGnsedN1Ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gaM6qeec6wgdr/ZTtQ0/+OD+AjGxebfLbLyHKXJqmgPosc3Vm+I0MOefVjoe6adwHua2W3MgVG5Sj25QxMSvkQDoFVcfE9Zg0O/+/s43pKTJlRF8Ap99eZqbDSsPDOq0LnNFTg861Tjd2SskKcF2/lq0M1VAKocLCw41cF1IAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zqChrpn/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa57c42965so602769a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739398021; x=1740002821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGqR78gPCoFohz0E/LUFCYULs/zf/5PcEDAbIwIJG7o=;
        b=zqChrpn/YmDKUa67UCS4deAYBjUWUZ6angJCX0/BPXWzrghuC0+p1cf/drWY5jl2Qd
         PmIP2Ntr9elLU687zScTkpQv0hO+tqUM61C6cUG+pS5LYlC4rjAUwTl152S0CQHn+vMq
         mIu4jvkCsBFobgxNq7Y/l9jjY9LL3I6r8Tc+VjD1TXhUNKD0a3gFNlg86HSaXA32M7GD
         GIsgjbpV3NASsErTt0fWnvY5l2U5487RnKz+6pBunuCQzzl+g69X0mpWfKnEhy3SDAxu
         /MKdf0trrqLVJznxNbOD0Rhhay4y0KQjEZ33kNwFpsd5sxTf1NNxswDFL5qFsGDZL280
         qKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739398021; x=1740002821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGqR78gPCoFohz0E/LUFCYULs/zf/5PcEDAbIwIJG7o=;
        b=didIihkgPEKo3IFDV4XxTGyoAPXQGmHhlPHGWjSMD4o9954NoSlEM58v8yXjMz2BS1
         cO14h31yV4/1fBngJuHlr0pdiMePcCt0/K7x4GZZWh+7/2luuUwEaHz9mB3LG2IfG2RS
         hyuFCAicMTVlF+gZHh0hKjMtJTpjCnpHDDgutHokPol+xB9TK2GfXpIPHHw29yhjs8XP
         8NOCTLFEoXWL0bo7/n/ZD1itx5ZwCOs714FRdo/o1gNIzOLLQ1rQDcgFZkXyqRsIpBoN
         nsByNmsJFJg/hERP+qBydBReS7WaGj1FdxOM4Lm553ecwq11OY55IhwY0XGwpQKyPpDF
         lY3A==
X-Forwarded-Encrypted: i=1; AJvYcCX2D6Fz/GwZCWTZHd80ptlPnO2+cWiYjnuwHpIvlphzTc80nNSvlT/bNUsbbm+VykCNYAKfV7sWOf/3fwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YRhJq0ZAfblThHua2enOx+121B0K79r1lHTDFcn38NfzLTCr
	gxZn4C0k43nKGymP2NPYS4q81MnTbW8VxkmbRQg+YKdDQd3jmQ+0KFISkilmio/qOyDoAUFJcpn
	JLg==
X-Google-Smtp-Source: AGHT+IHKwOsGnli7OQRD04PJwE+8VS+SYu/aOMm+pcV1q2UPRiD3IUftLWbwfUqgVsLruaomYZD37oPEl7A=
X-Received: from pjtd15.prod.google.com ([2002:a17:90b:4f:b0:2fa:1771:e276])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280b:b0:2f8:2c47:fb36
 with SMTP id 98e67ed59e1d1-2fbf5c6ea65mr8404846a91.33.1739398021418; Wed, 12
 Feb 2025 14:07:01 -0800 (PST)
Date: Wed, 12 Feb 2025 14:07:00 -0800
In-Reply-To: <20250204004038.1680123-5-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204004038.1680123-1-jthoughton@google.com> <20250204004038.1680123-5-jthoughton@google.com>
Message-ID: <Z60bhK96JnKIgqZQ@google.com>
Subject: Re: [PATCH v9 04/11] KVM: x86/mmu: Relax locking for
 kvm_test_age_gfn() and kvm_age_gfn()
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 04, 2025, James Houghton wrote:
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index 22551e2f1d00..e984b440c0f0 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -142,8 +142,14 @@ bool spte_has_volatile_bits(u64 spte)
>  		return true;
>  
>  	if (spte_ad_enabled(spte)) {
> -		if (!(spte & shadow_accessed_mask) ||
> -		    (is_writable_pte(spte) && !(spte & shadow_dirty_mask)))
> +		/*
> +		 * Do not check the Accessed bit. It can be set (by the CPU)
> +		 * and cleared (by kvm_tdp_mmu_age_spte()) without holding

When possible, don't reference functions by name in comments.  There are situations
where it's unavoidable, e.g. when calling out memory barrier pairs, but for cases
like this, it inevitably leads to stale code.

> +		 * the mmu_lock, but when clearing the Accessed bit, we do
> +		 * not invalidate the TLB, so we can already miss Accessed bit

No "we" in comments or changelog.

> +		 * updates.
> +		 */
> +		if (is_writable_pte(spte) && !(spte & shadow_dirty_mask))
>  			return true;

This 100% belongs in a separate prepatory patch.  And if it's moved to a separate
patch, then the rename can/should happen at the same time.

And with the Accessed check gone, and looking forward to the below change, I think
this is the perfect opportunity to streamline the final check to:

	return spte_ad_enabled(spte) && is_writable_pte(spte) &&
	       !(spte & shadow_dirty_mask);

No need to send another version, I'll move things around when applying.

Also, as discussed off-list I'm 99% certain that with the lockless aging, KVM
must atomically update A/D-disabled SPTEs, as the SPTE can be access-tracked and
restored outside of mmu_lock.  E.g. a task that holds mmu_lock and is clearing
the writable bit needs to update it atomically to avoid its change from being
lost.

I'll slot this is in:

--
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Feb 2025 12:58:39 -0800
Subject: [PATCH 03/10] KVM: x86/mmu: Always update A/D-disable SPTEs
 atomically

In anticipation of aging SPTEs outside of mmu_lock, force A/D-disabled
SPTEs to be updated atomically, as aging A/D-disabled SPTEs will mark them
for access-tracking outside of mmu_lock.  Coupled with restoring access-
tracked SPTEs in the fast page fault handler, the end result is that
A/D-disable SPTEs will be volatile at all times.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 9663ba867178..0f9f47b4ab0e 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -141,8 +141,11 @@ bool spte_needs_atomic_update(u64 spte)
 	if (!is_writable_pte(spte) && is_mmu_writable_spte(spte))
 		return true;
 
-	/* Access-tracked SPTEs can be restored by KVM's fast page fault handler. */
-	if (is_access_track_spte(spte))
+	/*
+	 * A/D-disabled SPTEs can be access-tracked by aging, and access-tracked
+	 * SPTEs can be restored by KVM's fast page fault handler.
+	 */
+	if (!spte_ad_enabled(spte))
 		return true;
 
 	/*
@@ -151,8 +154,7 @@ bool spte_needs_atomic_update(u64 spte)
 	 * invalidate TLBs when aging SPTEs, and so it's safe to clobber the
 	 * Accessed bit (and rare in practice).
 	 */
-	return spte_ad_enabled(spte) && is_writable_pte(spte) &&
-	       !(spte & shadow_dirty_mask);
+	return is_writable_pte(spte) && !(spte & shadow_dirty_mask);
 }
 
 bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
--

