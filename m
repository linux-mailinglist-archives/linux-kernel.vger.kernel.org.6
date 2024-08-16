Return-Path: <linux-kernel+bounces-290436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15B29553CC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 01:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582701F22E76
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FF1474BF;
	Fri, 16 Aug 2024 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acN0+rDe"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D79B661
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723851489; cv=none; b=QsLT7ZyIbA2stoJAR6zq6GWFwBT9bewrJrwwvl7rZYBhpaNIdsC1e4hp4FhhlGg44hE8ya7jVWRZ/9+OrFL/zBcvj1SUB84IU3D2jFqUvVs8T/eC0xvWf7P3FjkrrQZn6VxRCMmeBAE9GYCpwin0ZLBSLWZgc5tcDiOQf/YKDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723851489; c=relaxed/simple;
	bh=Y/+GOpDSzsK+M2joesQEHhyTfRfgx6dQoGr2ckDIQ94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NcULdOMczedLuDMABPja/6J2QOWkEtaqBhMt/mt3bHlnOKcSebsA+ZRVEqMG2sxN3owH1NtAFz4xjD42Smd5/8hLqkAsTtnmGmt0Ue0Kpd8bmNA9XCyAvPOPQyLYVTHFK+ll++AktxEvrbRmsyLoEg2+zRjscptbG4J9ULeIErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=acN0+rDe; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-713d4a9a3ffso438010b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723851487; x=1724456287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTcVp0/hDkDmdE0O3eFD0NUXBKlO6QGLbLpx53J90N4=;
        b=acN0+rDeHyPQwqte9lFiEDzfBe4n5PI4+eiTCqJy2n4t1vZ4RloBZDcOXG/C2Hoj/8
         6sjDDrtn4n7DEvFof7xqTjuWjAuSMRiWr1WwlvVcijOFN3QcYGDrrL3HmBLG7C+sej0S
         KTbUWC4VYNj73KtV2fevxaOV6r5pTyk4dlkLH0rpFirA9itUuY/kr9EyyJ4ETEZfCIzD
         eQu/lyEHS96a74RAv+R+ijE20Ni7Zr2b6pcwLCGu2s2Hv+gRWlZO3RVuHTKHQhgIwMcQ
         htmU2YQFEOb516JvwJUa2evWIDWF3RWiFZH+X1VCeGYBm22zz07vBiVQIUKrM9zVE4Gx
         QcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723851487; x=1724456287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTcVp0/hDkDmdE0O3eFD0NUXBKlO6QGLbLpx53J90N4=;
        b=QEI8ulI9llB/hFDP/wv1ztVx6zFf8HsPNWMh36atyaReeFSpmyyO7p6OTfI8vtVuhB
         fpRyPINcY4uxAcG4v55YU6BNIO6mf9Wsitj/BHAHrZniym398S08072suSx5uF7M+Un5
         5Qpy3XRyB2kt5Sh5aLfDzYTV3aP2qehaarQO3uYkbWt4eP/GljRM+PayQoxS/EPyJu9A
         R2mV71QxOHcshg9SCdt7bB7qdm7FpywhjX65WTBs3TjUdh8Mp+ZkSKWdR3Femgnq6QUB
         a2f7o0fR3FmWprC7YeRG7HsFXYofkEsYdppeVaWp5cXlORX4LWJcE2PTuvqBm+FCqx6R
         rU3A==
X-Forwarded-Encrypted: i=1; AJvYcCX2HKUPNULVfzrnjIDg+bhXvBuVA/ygGADZSyR99PYmbVW1VsY8r+LGVHVIcOFbntjZKI40+UNL3b5+wE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynZ9L/JavRZIFnlH4KsEsp28Eg1X7xO5FJx2gUFAICf0q2fQOa
	TYgzzkVvSI/TrXSBBl1hYpm2uXtC7J+JC145d/eg2Hae0FTMYuC97cU/PLyeH7lyxutxkOXd5gn
	WrQ==
X-Google-Smtp-Source: AGHT+IFPiEjpU2pNJWwknUPhM6DoLa+l6jzczj/GbpouGqoqHH/veVZwucqHOJ6XnNZmWTfIdO/KC9mWQms=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9466:b0:70d:1b0d:a15d with SMTP id
 d2e1a72fcca58-7127719dd68mr86539b3a.3.1723851486760; Fri, 16 Aug 2024
 16:38:06 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:38:05 -0700
In-Reply-To: <20240812171341.1763297-3-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812171341.1763297-1-vipinsh@google.com> <20240812171341.1763297-3-vipinsh@google.com>
Message-ID: <Zr_i3caXmIZgQL0t@google.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging to TDP
 MMU under MMU read lock
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 12, 2024, Vipin Sharma wrote:
> @@ -1807,7 +1822,7 @@ ulong kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm, ulong to_zap)
>  	struct kvm_mmu_page *sp;
>  	bool flush = false;
>  
> -	lockdep_assert_held_write(&kvm->mmu_lock);
> +	lockdep_assert_held_read(&kvm->mmu_lock);
>  	/*
>  	 * Zapping TDP MMU shadow pages, including the remote TLB flush, must
>  	 * be done under RCU protection, because the pages are freed via RCU
> @@ -1821,7 +1836,6 @@ ulong kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm, ulong to_zap)
>  		if (!sp)
>  			break;
>  
> -		WARN_ON_ONCE(!sp->nx_huge_page_disallowed);
>  		WARN_ON_ONCE(!sp->role.direct);
>  
>  		/*
> @@ -1831,12 +1845,17 @@ ulong kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm, ulong to_zap)
>  		 * recovered, along with all the other huge pages in the slot,
>  		 * when dirty logging is disabled.
>  		 */
> -		if (kvm_mmu_sp_dirty_logging_enabled(kvm, sp))
> +		if (kvm_mmu_sp_dirty_logging_enabled(kvm, sp)) {
> +			spin_lock(&kvm->arch.tdp_mmu_pages_lock);
>  			unaccount_nx_huge_page(kvm, sp);
> -		else
> -			flush |= kvm_tdp_mmu_zap_sp(kvm, sp);
> -
> -		WARN_ON_ONCE(sp->nx_huge_page_disallowed);
> +			spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
> +			to_zap--;
> +			WARN_ON_ONCE(sp->nx_huge_page_disallowed);
> +		} else if (tdp_mmu_zap_sp(kvm, sp)) {
> +			flush = true;
> +			to_zap--;

This is actively dangerous.  In the old code, tdp_mmu_zap_sp() could fail only
in a WARN-able scenario, i.e. practice was guaranteed to succeed.  And, the
for-loop *always* decremented to_zap, i.e. couldn't get stuck in an infinite
loop.

Neither of those protections exist in this version.  Obviously it shouldn't happen,
but it's possible this could flail on the same SP over and over, since nothing
guarnatees forward progress.  The cond_resched() would save KVM from true pain,
but it's still a wart in the implementation.

Rather than loop on to_zap, just do

	list_for_each_entry(...) {

		if (!to_zap)
			break;
	}

And if we don't use separate lists, that'll be an improvement too, as it KVM
will only have to skip "wrong" shadow pages once, whereas this approach means
every iteration of the loop has to walk past the "wrong" shadow pages.

But I'd still prefer to use separate lists.

