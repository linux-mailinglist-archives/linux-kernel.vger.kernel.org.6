Return-Path: <linux-kernel+bounces-292978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA6A957758
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0401C23176
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52CE1DD396;
	Mon, 19 Aug 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqypCEJe"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01891DB458
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105963; cv=none; b=rQ88yd5iIMB8vWK0nnEiGcSaR8KFi5Fygipmt6zXr8Ge8A77xHyxX3vaklT8zyFVOw8A3Q+K4C59r0y5313ZVXUvfg8DUfMI9SxAZM7UOjEbkECbTP5NEO8oOF9gZ/TDyRJo/WvlkaUBlnts9VM0EJUwTldJZD6/iLlUV6NpfVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105963; c=relaxed/simple;
	bh=SYp3tksf77bo6qTn2UGfcC0zNiZVqhwqCOP3DWafP9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2DvugFJsVvkR5DMuMxyomcrGxiFk2SqK2kno73kkeR8Xz1f6dUMWvg2nPVijT/l+atnMm6jWE2xkxxQTdGgBsmYcZGPU5HIhMtrMgn+oOkY72uYjry7YNNrWAYu93LDtmnOnVMV97o/l3ceP0v4UUNCyPUc8siE4/OW5cqfhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqypCEJe; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d2f925b01so4523156b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724105961; x=1724710761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SYLh/JPAc2oF3XEhfhevi/a4vY//ccYnWwMPOLwIpg=;
        b=eqypCEJeQwJo43ULBUahh2ta3RWnT5lzs1eyRIX95z9I00BkVUv4r3GQcBFcSuoOXA
         M6gCDqi/J3HhAtpXjfCUvSfZp59LFeKGBq3iTo5oAp3X2sdMRGIPHvYn25+C1fbg8kc1
         XQnmwZ6mYrKWOraE170gsCStpQs63dQgXG6hMbjg9alVMpyZr8vQaRVhVZDWhMzAUS8r
         lHTPXFssL3bPaA3o9MstXzFFL31MwqKAh975KvBxJjJCJEjpz87FhEnrl7LWw0sbv/74
         XGlwUobv5VYw/lWrtY7HgGUvhTG1UOJP26QaDEy59GyiJu8a2+1VGlI+OzMkRj7l2M4a
         xaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724105961; x=1724710761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SYLh/JPAc2oF3XEhfhevi/a4vY//ccYnWwMPOLwIpg=;
        b=mUhTyvK+CD5QLrDi4prD71H8Fl0c1XN1bCq9jopHGL3B3fIlwLYUY1SUq2vMAELarp
         FZ1jFYFiHKGHhQk6Uwb+GF0ZORJyqz8R7nEF6nWRVDluOavuyw/V6SOgPr7WztopgPzG
         5cZbyv+F0pPMggOoHd5SqV1Th/GIrKHeWbN2X9pNhUmqtLZDyZc7knLwTRA77dwOHpSZ
         05JzUtrSfbqoanvzjaPbGV5nyJ0eXMFVfOAq957wncr9RI1ql7upFTcapb4swVuK2elF
         W/20qvT+67sbwca26G3/8Io4vnHzlv2tK4hi8wlNIaAqyeq+jRivCsJ+690XKQyFqX7N
         STtw==
X-Forwarded-Encrypted: i=1; AJvYcCWjR6yLytS9MuhmUkU/GZgzSuMTjIcSujIfkdhneFJPPqvibTD0dc0i8cS+Y8Guy8isVmAMZsnxvEjcw/pg94ySNdtKwtq1N2lSZBiJ
X-Gm-Message-State: AOJu0YxyzrUW+BXqq55a6+dNnzLEWxJksWVCkVklACvUUK/t7ZClIN6z
	D//Z7oUA0kR2dFV+KG6ttpsFLy/JCl0viCXzIRhbRJEQD7UG572h/tnLFDdCFiz2ZZ/izl712kU
	vCA==
X-Google-Smtp-Source: AGHT+IHm278QwIY/OX92uRPN+eRVywdVAQcXvKqkS5cFMSC5mSDI9+smOYf7rkHoPuip6boFZYqviDtYqSc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f06:b0:706:71f1:51bd with SMTP id
 d2e1a72fcca58-713c53a2077mr42981b3a.6.1724105960751; Mon, 19 Aug 2024
 15:19:20 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:19:19 -0700
In-Reply-To: <20240812171341.1763297-3-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812171341.1763297-1-vipinsh@google.com> <20240812171341.1763297-3-vipinsh@google.com>
Message-ID: <ZsPE56MnelsV490m@google.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging to TDP
 MMU under MMU read lock
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 12, 2024, Vipin Sharma wrote:
> Use MMU read lock to recover NX huge pages belonging to TDP MMU. Iterate
> through kvm->arch.possible_nx_huge_pages while holding
> kvm->arch.tdp_mmu_pages_lock. Rename kvm_tdp_mmu_zap_sp() to
> tdp_mmu_zap_sp() and make it static as there are no callers outside of
> TDP MMU.
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 933bb8b11c9f..7c7d207ee590 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -817,9 +817,11 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
>  	rcu_read_unlock();
>  }
>  
> -bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
> +static bool tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp)

At this point, I think we should rename this to tdp_mmu_zap_possible_nx_huge_page(),
as I can't imagine there's another use case where we'll zap a SP starting from the
SP itself, i.e. without first walking from the root.

>  {
> -	u64 old_spte;
> +	struct tdp_iter iter = {};

Rather than initializes the on-stack structure, I think it makes sense to directly
initialize the whole thing and then WARN after, e.g. so that its easier to see
that "iter" is simply being filled from @sp.

	struct tdp_iter iter = {
		.old_spte = sp->ptep ? kvm_tdp_mmu_read_spte(sp->ptep) : 0,
		.sptep = sp->ptep,
		.level = sp->role.level + 1,
		.gfn = sp->gfn,
		.as_id = kvm_mmu_page_as_id(sp),
	};

	lockdep_assert_held_read(&kvm->mmu_lock);

	/*
	 * Root shadow pages don't a parent page table and thus no associated
	 * entry, but they can never be possible NX huge pages.
	 */
	if (WARN_ON_ONCE(!sp->ptep))
		return false;

> +
> +	lockdep_assert_held_read(&kvm->mmu_lock);
>  
>  	/*
>  	 * This helper intentionally doesn't allow zapping a root shadow page,
> @@ -828,12 +830,25 @@ bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
>  	if (WARN_ON_ONCE(!sp->ptep))
>  		return false;
>  
> -	old_spte = kvm_tdp_mmu_read_spte(sp->ptep);
> -	if (WARN_ON_ONCE(!is_shadow_present_pte(old_spte)))
> +	iter.old_spte = kvm_tdp_mmu_read_spte(sp->ptep);
> +	iter.sptep = sp->ptep;
> +	iter.level = sp->role.level + 1;
> +	iter.gfn = sp->gfn;
> +	iter.as_id = kvm_mmu_page_as_id(sp);
> +
> +retry:
> +	/*
> +	 * Since mmu_lock is held in read mode, it's possible to race with
> +	 * another CPU which can remove sp from the page table hierarchy.
> +	 *
> +	 * No need to re-read iter.old_spte as tdp_mmu_set_spte_atomic() will
> +	 * update it in the case of failure.
> +	 */
> +	if (sp->spt != spte_to_child_pt(iter.old_spte, iter.level))
>  		return false;
>  
> -	tdp_mmu_set_spte(kvm, kvm_mmu_page_as_id(sp), sp->ptep, old_spte,
> -			 SHADOW_NONPRESENT_VALUE, sp->gfn, sp->role.level + 1);
> +	if (tdp_mmu_set_spte_atomic(kvm, &iter, SHADOW_NONPRESENT_VALUE))
> +		goto retry;

I'm pretty sure there's no need to retry.  Non-leaf SPTEs don't have Dirty bits,
and KVM always sets the Accessed bit (and never clears it) for non-leaf SPTEs.
Ditty for the Writable bit.

So unless I'm missing something, the only way for the CMPXCHG to fail is if the
SPTE was zapped or replaced with something else, in which case the sp->spt will
fail.  I would much prefer to WARN on that logic failing than have what appears
to be a potential infinite loop.

