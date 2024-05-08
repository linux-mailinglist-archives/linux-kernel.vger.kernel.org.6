Return-Path: <linux-kernel+bounces-173443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8D8C0085
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DC31F25253
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AE986ADE;
	Wed,  8 May 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qs5cKPPD"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330361A2C0B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180107; cv=none; b=EAqia7COpYG5PqgJXxUXsXEMPQOTbSYbPgWE7+Xe/4uorWB3auYGRYtOLiCbJCRCcPFqI2fTa/ocF0Pap3+xVucdOZxj/FaviJBB/dUOqRriN2DPxY2myMQhyB4NBo7v6DD6Vu9wBdPJd4jDkaT23qieiBhItE6YVGwfbFLAN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180107; c=relaxed/simple;
	bh=E/TIUh0Tpb73YznKVdcAVd8jxg2CqQ6AzKWuQKahBNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUwMCg+A7cSYeV2Ein1DvrKdWjvyYbDKeIBRp8uJd+kiiiwWKjwFVyRaDCxaUgPW+wE5XOOdKwDrpmY4RznFAiP8mLryFc2bxruHN83JwW11ZF/OnQdytymSEsirKgqXLyxuFZQs1QbFXs9RxoJJ805XXvmpxeYdEaGRL66VUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qs5cKPPD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be8f7ed6eso12237307b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715180104; x=1715784904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkj273El9+gDZrjw9vIeFrFXoqJFtQgFlFhD69aQANs=;
        b=Qs5cKPPDaG1ePGrVyTVHUTtvH3N2ep4/LizH6+VUUik1CTssJ407selD5VVgU/vYub
         vBLMHw1YgHa7UZwrhj+R/m0b0wiOGu9ImqDYCiVeCjnTgygh/MjTic8+Spb0Bpi3OQL6
         WzHFMDGYYLbUuC8dnapdONUMP0HQa88TRLiDuQMyF4cmOnDh8zfY6eX/OLz7wNrvdJ0B
         iqwMCDLH6oLBNWWVMvZBimc0HB+QdbteYKKHBzmaXfiBU5QjkkY/PmiFZ4Jj8yGxWYhR
         5AC+nxFSd+cSGxgaf8Z2XO2dUUrd4cF5FE2RdSej+Q38t1JvNXlAbfBCywdqypoihOvU
         dV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715180104; x=1715784904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkj273El9+gDZrjw9vIeFrFXoqJFtQgFlFhD69aQANs=;
        b=EPLZsYJimKly5DyZEOH1cWCvsM2nZDM/1I4nKHTzzQUeSWwWdY0lJx100mWo894y/3
         XYehe2RbFW+B9TlOUFvEgeLBq2EQnSOyiBB40isSPNY2H8lko0fg5QR4zg1cnVsQA0e0
         Jkj0RqmiA7bfC1tQ1+gvi433UH7TA+a8KItXIZNaOBy2dT/S2ZOkibjM7AWxCY1tvH/n
         /BEopdvhoza7silJmxsXF8wqwUmEwtsifBoWt+n71YnnKwMQF6hhxsiRtoPbK3CAhKi0
         GlnTtxbcyGSgl/InOwP84aJ1zDoGDwj9yXkYD58IiVX2yubfI9O+kRQcTcQrAT7LMSje
         mBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw/Vt5nLQNd6E25eJKFWaAbIgIWhSsJubxxuAwz/4WIrfBoVZ7AJ+0ah+ulbx3cns5d/OGDnMQGb5oYuIpypll8xAw8aOZd1S1kXde
X-Gm-Message-State: AOJu0YyddXcjOut9FadGo25AiuvE0qu2Dcb3zw/F/Wh6CWLs2/bckPLP
	XF7WnD77bzLRb6WSBdIsq+HfWjaZpMEyRuHR+oCBxEudIo7BELOUkrqGfSu4kU+ZaBZXHtdUOnl
	Xug==
X-Google-Smtp-Source: AGHT+IGNnMh7SDyT+tmCKW/wAQTiQPJ6O/6gE49bwEt4ezpRjrE/J/gDwWlezF2pMhDi6mN9BxXkxc11rXw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:cad2:0:b0:618:5009:cb71 with SMTP id
 00721157ae682-62085c7c695mr7568127b3.5.1715180104287; Wed, 08 May 2024
 07:55:04 -0700 (PDT)
Date: Wed, 8 May 2024 07:55:02 -0700
In-Reply-To: <bf08a06675ed97d2456f7dcd9b0b2ef92f4602be.1715137643.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bf08a06675ed97d2456f7dcd9b0b2ef92f4602be.1715137643.git.houwenlong.hwl@antgroup.com>
Message-ID: <ZjuSRjwc_wRTSXQp@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Only allocate shadowed translation cache
 for sp->role.level <= KVM_MAX_HUGEPAGE_LEVEL
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 08, 2024, Hou Wenlong wrote:
> Only the indirect SP with sp->role.level <= KVM_MAX_HUGEPAGE_LEVEL might
> have leaf gptes, so allocation of shadowed translation cache is needed
> only for it. Additionally, use sp->shadowed_translation to determine
> whether to use the information in shadowed translation cache or not.
> 
> Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index fc3b59b59ee1..8be987d0f05e 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -716,12 +716,12 @@ static bool sp_has_gptes(struct kvm_mmu_page *sp);
>  
>  static gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index)
>  {
> +	if (sp->shadowed_translation)
> +		return sp->shadowed_translation[index] >> PAGE_SHIFT;
> +
>  	if (sp->role.passthrough)
>  		return sp->gfn;
>  
> -	if (!sp->role.direct)
> -		return sp->shadowed_translation[index] >> PAGE_SHIFT;

Why change the order?  Either the order doesn't matter, in which case go for the
smallest diff, or the order does matter, in which case this warrants an explanation
in the changelog (or perhaps even a separate patch, but that's likely overkill).

> -
>  	return sp->gfn + (index << ((sp->role.level - 1) * SPTE_LEVEL_BITS));
>  }
>  
> @@ -733,7 +733,7 @@ static gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index)
>   */
>  static u32 kvm_mmu_page_get_access(struct kvm_mmu_page *sp, int index)

Can you also extend the WARN in FNAME(sync_spte)()?  Partly to help communicate
to future readers that sync_spte() operates on leaf GPTEs, and also to help make
it somewhat obvious that this patch doesn't break shadow_mmu_get_sp_for_split()

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 7a87097cb45b..89b5d73e9e3c 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -911,7 +911,7 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
        gpa_t pte_gpa;
        gfn_t gfn;
 
-       if (WARN_ON_ONCE(!sp->spt[i]))
+       if (WARN_ON_ONCE(!sp->spt[i] || !sp->shadowed_translation))
                return 0;
 
        first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);

>  {
> -	if (sp_has_gptes(sp))
> +	if (sp->shadowed_translation)
>  		return sp->shadowed_translation[index] & ACC_ALL;
>  
>  	/*
> @@ -754,7 +754,7 @@ static u32 kvm_mmu_page_get_access(struct kvm_mmu_page *sp, int index)
>  static void kvm_mmu_page_set_translation(struct kvm_mmu_page *sp, int index,
>  					 gfn_t gfn, unsigned int access)
>  {
> -	if (sp_has_gptes(sp)) {
> +	if (sp->shadowed_translation) {
>  		sp->shadowed_translation[index] = (gfn << PAGE_SHIFT) | access;
>  		return;
>  	}
> @@ -1697,7 +1697,7 @@ static void kvm_mmu_free_shadow_page(struct kvm_mmu_page *sp)
>  	hlist_del(&sp->hash_link);
>  	list_del(&sp->link);
>  	free_page((unsigned long)sp->spt);
> -	if (!sp->role.direct)
> +	if (sp->shadowed_translation)
>  		free_page((unsigned long)sp->shadowed_translation);

Just drop the manual check, free_page() already handles the NULL/0 case.

>  	kmem_cache_free(mmu_page_header_cache, sp);
>  }
> @@ -1850,6 +1850,17 @@ static bool kvm_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
>  static void kvm_mmu_commit_zap_page(struct kvm *kvm,
>  				    struct list_head *invalid_list);
>  
> +static bool sp_might_have_leaf_gptes(struct kvm_mmu_page *sp)

Hmm, I think I'd prefer to forego the helper entirely, as this really is intended
to be used only when allocating the shadow page.  That way we avoid having to try
and clarify exactly what "might" means in this context, as well as potential future
goofs, e.g. if someone had the clever idea to check sp->shadowed_translation.

Oof, yeah, definitely omit the helper.  It took me a minute to fully appreciate
the difference between "leaf gptes" and "gptes" as it relates to write-protecting
gfns.

> +{
> +	if (sp->role.direct)
> +		return false;
> +
> +	if (sp->role.level > KVM_MAX_HUGEPAGE_LEVEL)
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool sp_has_gptes(struct kvm_mmu_page *sp)
>  {
>  	if (sp->role.direct)
> @@ -2199,7 +2210,8 @@ static struct kvm_mmu_page *kvm_mmu_alloc_shadow_page(struct kvm *kvm,
>  
>  	sp = kvm_mmu_memory_cache_alloc(caches->page_header_cache);
>  	sp->spt = kvm_mmu_memory_cache_alloc(caches->shadow_page_cache);
> -	if (!role.direct)
> +	sp->role = role;
> +	if (sp_might_have_leaf_gptes(sp))

And then this becomes:

	if (!role.direct && role.level <= KVM_MAX_HUGEPAGE_LEVEL)

>  		sp->shadowed_translation = kvm_mmu_memory_cache_alloc(caches->shadowed_info_cache);
>  
>  	set_page_private(virt_to_page(sp->spt), (unsigned long)sp);
> @@ -2216,7 +2228,6 @@ static struct kvm_mmu_page *kvm_mmu_alloc_shadow_page(struct kvm *kvm,
>  	kvm_account_mmu_page(kvm, sp);
>  
>  	sp->gfn = gfn;
> -	sp->role = role;

And this code doesn't need to move.

>  	hlist_add_head(&sp->hash_link, sp_list);
>  	if (sp_has_gptes(sp))
>  		account_shadowed(kvm, sp);
> -- 
> 2.31.1
> 

