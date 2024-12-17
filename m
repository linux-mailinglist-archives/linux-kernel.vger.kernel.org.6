Return-Path: <linux-kernel+bounces-448850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299389F466F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28171887E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7505D1D63DB;
	Tue, 17 Dec 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Czc+tfVv"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A4126C08
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425284; cv=none; b=N1fMr12esE2FQ7EDoet++0FIs3xljOBGxoChtVqcbhouN1e38JUqyp9gv/HyI9hLOQYsyF0TnHnWP8ZOscZSKkOIScUguQatL1h9bvIHULWkAQ5UMuAeo5OKAIFf686ihZQRMiFmr6x451JtoVRHejNFJUqLl0lm0hCtQjPM4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425284; c=relaxed/simple;
	bh=y6oO2c62Z7FAKERSlKc3B+GB0QalB/SXetwRKAGhlmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0tUzl5hrW8w0nUOvitoXLX/Pe7+qQRf8VejQRf8mH0FWcSGSSaSWTeoA4x7K2rODz+bfD9hkPEjs6fR+g4CZKi2kxos2ZMTK5OPoZ7Xtu7z9XHYHA3ZRVxVj/SRnJIDlkUN1mnghmJIUJJQARDxRLU+Vvobl7PJuYIvqV0Tex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Czc+tfVv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361d5730caso27165e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425281; x=1735030081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6hCYoIRnSlinICHyKBQa7JIGTnDJ2BuS+GfwqYyMo7E=;
        b=Czc+tfVvo8jWxYdZjem5jsVnLhQEsxRAiwEvqolRAzsmEVPvBq+um7Ou4t4ZI/zIXc
         q8KZvXMF3Zp8RpN2Ag1CZUnItK0EGHOaUQbNXZ43qN3GlJX/9UgTfwRVs+ny3Xhso8Gr
         BFaHZKoVgMeWfHBnKSumBGg/1h+iVITVRhVdml2AE3YW4dgfuDKODQzMfwyTRq8gZAn9
         xq+eDMXnRuSwejzrW0n+nKxJ+e1Ba4phDfaAMUP0PhupXxYh+OaY03RkDwGoHsZPLZ+y
         Fylcmk70J1AOSO+EEut8VjepC9wJ4tqF/18BOz0/+NQxsikGC1pc4tZyQM+WWO9ygF4f
         DJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425281; x=1735030081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hCYoIRnSlinICHyKBQa7JIGTnDJ2BuS+GfwqYyMo7E=;
        b=amSMc8lBg27e3Tr7cbDklqILAYKWntHoei1QY5n4GtmCIf57eAIeSzAfBMC2+wNRdW
         yKXWVfZfXRRGPdD3L3D7eHaT632d4oeaoPMKNS0GCMWueQ3DVrkAVBEIRXQBvE71EVs7
         9KtHq4Gv8UOtgVNXXJc+Rx5HgJOPcrzJ4RX1cMkvfyebkIBbBNheBip+pm4U3Qzp6USd
         vlwLJvhFKfx1Gbm+B6NwRUHp6OzbOMYoPSQcIUiRtR0CRxRbCX9ACRFJjJUKc9rLfhGB
         oeFZr6DNU9grdaCx93rUgEp4ul8RpEaqvNtmsDWEqzWRsxIZoV5B1E7NBOrqjdxnpyig
         Pi1A==
X-Forwarded-Encrypted: i=1; AJvYcCVU8M8jlr+h9BpwibdRF32KF3itfQrGvNM9HB6Z1wKdnqlnRbyYcLZjUwI3Ps/GBdNvNJfXv2Lof6moEic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw23QRfDxmA0R50xpeSY/zsZSuJ/EYcLVVBH0E/1PNb7j6mkwCP
	9q2qS0QAc/9XR0UyrFOy7akcXK1d8BYyD4B9x6nN57KRq+Yhh0K0d5odFFjVMZe0x7YjEqdx+jj
	9gvbHMbaPrAX0JkyoC6yMOFevhp67kjF7vb1Y
X-Gm-Gg: ASbGncutqcdV74YHV7ledpFLmr2JPYbhKpmqg+MxmmNk9ET1TxA9dA81mIHc+gGV7iL
	v3G7xivDLkYVYii9hvLEOGRdmfSxRAVMnHrAzbgk+SE98Aqh2cOucJR9JkgEr+6puL4k=
X-Google-Smtp-Source: AGHT+IFxXKN9usqQV3kNbNh4Lz31/fk7TbK5vkz5uPgTlGxQEqYyZajHdqHVpeCOx8ECqjWbYxVv8GfDoeuTtmoKPxQ=
X-Received: by 2002:a7b:ce88:0:b0:436:186e:13a6 with SMTP id
 5b1f17b1804b1-436492cf51dmr1039795e9.6.1734425281269; Tue, 17 Dec 2024
 00:48:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-6-qperret@google.com>
In-Reply-To: <20241216175803.2716565-6-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:47:24 +0000
Message-ID: <CA+EHjTzfqR8=g=VzazL3__TyGpJJtPCoG20sJeUnY+d0b6NSBA@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] KVM: arm64: Pass walk flags to kvm_pgtable_stage2_mkyoung
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 17:58, Quentin Perret <qperret@google.com> wrote:
>
> kvm_pgtable_stage2_mkyoung currently assumes that it is being called
> from a 'shared' walker, which will not be true once called from pKVM.
> To allow for the re-use of that function, make the walk flags one of
> its parameters.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 4 +++-
>  arch/arm64/kvm/hyp/pgtable.c         | 7 +++----
>  arch/arm64/kvm/mmu.c                 | 3 ++-
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index aab04097b505..38b7ec1c8614 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -669,13 +669,15 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
>   * kvm_pgtable_stage2_mkyoung() - Set the access flag in a page-table entry.
>   * @pgt:       Page-table structure initialised by kvm_pgtable_stage2_init*().
>   * @addr:      Intermediate physical address to identify the page-table entry.
> + * @flags:     Flags to control the page-table walk (ex. a shared walk)
>   *
>   * The offset of @addr within a page is ignored.
>   *
>   * If there is a valid, leaf page-table entry used to translate @addr, then
>   * set the access flag in that entry.
>   */
> -void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
> +void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr,
> +                               enum kvm_pgtable_walk_flags flags);
>
>  /**
>   * kvm_pgtable_stage2_test_clear_young() - Test and optionally clear the access
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 40bd55966540..0470aedb4bf4 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -1245,14 +1245,13 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
>                                         NULL, NULL, 0);
>  }
>
> -void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
> +void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr,
> +                               enum kvm_pgtable_walk_flags flags)
>  {
>         int ret;
>
>         ret = stage2_update_leaf_attrs(pgt, addr, 1, KVM_PTE_LEAF_ATTR_LO_S2_AF, 0,
> -                                      NULL, NULL,
> -                                      KVM_PGTABLE_WALK_HANDLE_FAULT |
> -                                      KVM_PGTABLE_WALK_SHARED);
> +                                      NULL, NULL, flags);
>         if (!ret)
>                 dsb(ishst);
>  }
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index c9d46ad57e52..a2339b76c826 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1718,13 +1718,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  /* Resolve the access fault by making the page young again. */
>  static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>  {
> +       enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED;
>         struct kvm_s2_mmu *mmu;
>
>         trace_kvm_access_fault(fault_ipa);
>
>         read_lock(&vcpu->kvm->mmu_lock);
>         mmu = vcpu->arch.hw_mmu;
> -       kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa);
> +       kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa, flags);
>         read_unlock(&vcpu->kvm->mmu_lock);
>  }
>
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

