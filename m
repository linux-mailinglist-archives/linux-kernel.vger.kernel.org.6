Return-Path: <linux-kernel+bounces-268753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856B09428E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA6B284C26
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC8D1A7206;
	Wed, 31 Jul 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XzpWOj9u"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC61A7F6C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413479; cv=none; b=la1cs9nAkRm77ulknIAXBXUSNom2PX3QeolHYfaoBA2uWnKZo409fuXnvDBaacfRZk7w71xFTWI7pNbJV0YSIFMFlBzZzbNI/DlvHP86HhFTabYm9YU8ApZ9xsfes/TO1RT/7c5HEG2tsUT69vOVnZNHUiiqd6tgkW2SPiOK9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413479; c=relaxed/simple;
	bh=2Gl8bDEMJ7EROOAewtyGSnYyggrq+9cliJTSl46a0AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owl+JloZ7mV96OCDRAnhIj4DWjaPhqsYPr+qG0c9wwymlihvtNIrTS3NdxPR1fRLRGFofN40f9SgozoJhZUYR5MiV+EzvebM3DMMFPYTm+ZshsIrHIY/Nq7PYXbw+ySDffrdP5H6bt5iA8lvQ7OySAQC1hubuMYVvTO4Xgp5qRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XzpWOj9u; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a8553db90so747374866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722413476; x=1723018276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6o5eOKMgYVhFfCfAX4KZTyTvIb4CeiZ7EcRemTMKgE=;
        b=XzpWOj9uEN/HBmC9Nti+ZlboUO4ecfQm5gr1NLQKCQc0igzf0i5g79lvBw2D+a65WX
         /6dTtywIK7b7CvxNlUopjQwCTaWtv7bGOEzztsDGFqWJQP8Dlsc+OZnxBvgFl3f5WYW1
         oXTwrmJUAaYDjI+DI64eTa8DT0jxSX0P1IyJ5YJUWFEEt+/yK7wAe1Uvd7uk9fI2AkaT
         Nu4eyojBTu0TBMdYRwSreHYknBNCZYLJBwxEeOtvYxYLQ7PaF6W+GirnfKJAWwZdea+J
         GADeRlayoG2b6FfyGv9oRNvpxy7gfyrMJngbXCTVowCEXWwk4GQLQIgAn0Zq6616Z+Qh
         FEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722413476; x=1723018276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6o5eOKMgYVhFfCfAX4KZTyTvIb4CeiZ7EcRemTMKgE=;
        b=Tr+ZLHOpCf/qR9Z+I60kSJM4ooRtlywkMjXS+qWQP9AB6xqC5KWkf0zwqR+LYlp4jw
         jcYwsSAsx1yNzEHGMI3A/mtvpZPspdANmgtDk01qXmOE7KXyys/0cwtfp30EDaVoLkS4
         vv9Lqt/wP5hIUGiyCCSuxnF/Gz+x8togqTBPqCf4pIRfjvRwC24HFMYirON61S5DfWB4
         54H628XYXpHg2tAXr0A0m+BTuFbLYfmfWqusnTFR1QhyMat1AGlx1wuHJkDtqcIQO9p+
         vkHGjo3y/u1wIP1NH0012W7ZKkJnAPLnzYXnDRiYhkD+251bWF1F7mPmAa6XqG8o96DX
         UHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Qg0QqjxYy8YSH1fGIgD9G5E5QIbCZiCFhT9OjMxfrn4xJCMKAo12cEDP5sg3EphxanAve+Hs4tD4J9J3zdRIwpidHi0VNbFUeZmz
X-Gm-Message-State: AOJu0YxeB7A5hEA5C6IXSU1QMV0w76IxPBZ8CtMci8lTd67OpvEjUPGf
	yjBeSylBnmRlyUNBCov3l2yyo6T8SgvWs+SPbp88rKyXnwBNeiWHiY5E67VMF2w=
X-Google-Smtp-Source: AGHT+IF8KtMuBT/lx87J71F/lRrgIXThKYLKm0Q9zh/TR0QeaI4sQXL1DHSiINUT/9ZA+lMCzDpL5Q==
X-Received: by 2002:a17:907:1b26:b0:a7a:af5d:f312 with SMTP id a640c23a62f3a-a7d4011442emr913154866b.46.1722413475678;
        Wed, 31 Jul 2024 01:11:15 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad414e2sm738525466b.127.2024.07.31.01.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 01:11:15 -0700 (PDT)
Date: Wed, 31 Jul 2024 10:11:14 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v12 58/84] KVM: RISC-V: Use kvm_faultin_pfn() when
 mapping pfns into the guest
Message-ID: <20240731-a5f8928d385945f049e5f96e@orel>
References: <20240726235234.228822-1-seanjc@google.com>
 <20240726235234.228822-59-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726235234.228822-59-seanjc@google.com>

On Fri, Jul 26, 2024 at 04:52:07PM GMT, Sean Christopherson wrote:
> Convert RISC-V to __kvm_faultin_pfn()+kvm_release_faultin_page(), which
> are new APIs to consolidate arch code and provide consistent behavior
> across all KVM architectures.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/riscv/kvm/mmu.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 806f68e70642..f73d6a79a78c 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -601,6 +601,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  	bool logging = (memslot->dirty_bitmap &&
>  			!(memslot->flags & KVM_MEM_READONLY)) ? true : false;
>  	unsigned long vma_pagesize, mmu_seq;
> +	struct page *page;
>  
>  	/* We need minimum second+third level pages */
>  	ret = kvm_mmu_topup_memory_cache(pcache, gstage_pgd_levels);
> @@ -631,7 +632,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  
>  	/*
>  	 * Read mmu_invalidate_seq so that KVM can detect if the results of
> -	 * vma_lookup() or gfn_to_pfn_prot() become stale priort to acquiring
> +	 * vma_lookup() or __kvm_faultin_pfn() become stale priort to acquiring
                                                            ^ while here
						could fix this typo

>  	 * kvm->mmu_lock.
>  	 *
>  	 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
> @@ -647,7 +648,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  		return -EFAULT;
>  	}
>  
> -	hfn = gfn_to_pfn_prot(kvm, gfn, is_write, &writable);
> +	hfn = kvm_faultin_pfn(vcpu, gfn, is_write, &writable, &page);
>  	if (hfn == KVM_PFN_ERR_HWPOISON) {
>  		send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva,
>  				vma_pageshift, current);
> @@ -681,11 +682,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  		kvm_err("Failed to map in G-stage\n");
>  
>  out_unlock:
> -	if ((!ret || ret == -EEXIST) && writable)
> -		kvm_set_pfn_dirty(hfn);
> -	else
> -		kvm_release_pfn_clean(hfn);
> -
> +	kvm_release_faultin_page(kvm, page, ret && ret != -EEXIST, writable);
>  	spin_unlock(&kvm->mmu_lock);
>  	return ret;
>  }
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

