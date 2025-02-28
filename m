Return-Path: <linux-kernel+bounces-539246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE19AA4A266
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08C73A7362
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4C1ADC8C;
	Fri, 28 Feb 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4d0Gipp"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118301C5D43
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769614; cv=none; b=Z60RHnIULqrQx/mlLCXyKyPNrN4RmVDZaf4cJe/ZAI0S1i9MsUjaZY9+PyB6tUKD9/5i3mkqnQUcwj/dRH6Q+QSiZFEu/2JUxdZNHPXUCp55SqMp5U9M83FnKBEYl99xRrUj+LLzum5qsboDD2GttxG0EsLiB6tbUXr6s5WYXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769614; c=relaxed/simple;
	bh=OCN3u5wSjbvOGv3cYLmLbEn4K1fJZqzIx2HUAFJtftw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbfXL6JA4O/Gb86YN/1h0xOvY43qqzqdd5dY1CvNRzlzDLiN5p4LInbLBkV8dB8056ElduGvWs8Vf/I6j+6iOosl8PkhEJMiRoqEgJuNJMomSzxn9iBR3OJR0MwCbproFaz8zM42bWHIuc4SaMZaFwOlo1EgxOTu91wtcsmnNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4d0Gipp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf4b376f2fso29307466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740769611; x=1741374411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea7ysfoGL0hxym9kuH3xIfg8V89PAft4k8+18YntGKQ=;
        b=X4d0Gipp2LaAnr/0wEyWyI47NT/FNykzONuQSmMHR0gLSJVsaQ2mprP6sCco3zzuy1
         qlSBvJB2hDw9aXI+zrKdJLqj1Lve9Vgqe3JHX1CSnIrujlFmm86bJa92nFXqLoUZBWIY
         b21Kh9xMacE+l6wNSgKpMgVkC05rWTCWyzr/2gZdEpALb9ZSl8UxgWCbWyHR/5Spbfw1
         0HZteGb2L00zjZZ/muUdHqPdSjto4kgvq56bX68giBjCQp6YthNnYt3XJXyRBRjD+5LW
         xAQvWivH8QBggk/Wrs92RWdyFdw+lNu+m4He+f/9rQ41vW6kyS/eWlDV0Xyn3lMCvCNg
         EToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769611; x=1741374411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea7ysfoGL0hxym9kuH3xIfg8V89PAft4k8+18YntGKQ=;
        b=fLHBwpaB9o+dr7vP9ZDV0P6XR34sPdHitrX3p5GCq5rreCZebquqZJGmyjkuf6vACQ
         mK/GyOJ0Qh3ghfG1iipe4dN5W8uLmW8zyfOINJL+rY+DF41lVPPaEDMDScYz0uWL/Bec
         m4TzU8kNhoDHyf5bbBogrl9VlKJiBXvrNx99avXAUsdGgKv+PszdSHanitpWTiTbcYfF
         VLfOpgIKxgl8ls3G+irL7KTsmalK3p66HtVynXd/ZIzy0f0NoRVDkOyozyb3axVOdiHk
         9Iu2FBHzfgBb3lt1cp/aqXtteffwvSERPTkcJdKRCEk5w2X0hswiqPq4ihxwJTe0JrIj
         YMBw==
X-Forwarded-Encrypted: i=1; AJvYcCXV9pQPy0N3VgMvWTDk2r/jebCQ0cj3t5k/73bIs3PG3+boSPZbESfi2Mmpae7TnPOUmz1GEvMv5HM4XDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lcBNehUht3rWEfBu0foBSjle8XtxIbXuEZ5cjvrwIrqjj3k0
	xziBWzfqe2VVfRi2tZLejQqm+gadba/r/ROsUA4B+9ulgLIzODF3A/ffc1Fth83rPso2xeesCr6
	ok1/s
X-Gm-Gg: ASbGncs9rbMnqz8/M0G8xOrvQs4wRo+WO0AgSxLtcJYATLry9PPAfgyGKpPIZ96HOfD
	DNa28f7qzuYKdvO+7pDBkMEtrBYKr+mqgoQwcmNwaAeLiHmMn4fJ5kQfTit7r3I+PTBhMW/ejtm
	Ybw63bXp25YgFH388NS/vBb6MoBZcM8qHEE+kXLTvhL5AIWSQjggEmEV4ylO51FyY21bH3x1Fpu
	5zMJmpRvgqt2ZK2Fyb2bb0QbKQ2YQdyMC3sjkZeR0w7hIXHbrpGjVZofq/PudPtuyBUm27byhgJ
	GDMYn8z7RWoFgIgG/q3+Akq2PWBJfah/zWxz9CWhunA9Ozx/T1Rdyuor6M0oAs4=
X-Google-Smtp-Source: AGHT+IHwpQw241bZAJUNRa/tRbDYtqAe8cu3t+94vTg5nA3MIoSIYj/LClqOfEXXyyELcdm0kfuXLg==
X-Received: by 2002:a17:907:7f0f:b0:ab6:b9c0:1ea2 with SMTP id a640c23a62f3a-abf261f2529mr471016666b.25.1740769611173;
        Fri, 28 Feb 2025 11:06:51 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c1165e7sm333069566b.82.2025.02.28.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:06:50 -0800 (PST)
Date: Fri, 28 Feb 2025 19:06:46 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/9] KVM: arm64: Add a range to __pkvm_host_share_guest()
Message-ID: <Z8IJRpoQUoGazLku@google.com>
References: <20250228102530.1229089-1-vdonnefort@google.com>
 <20250228102530.1229089-3-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228102530.1229089-3-vdonnefort@google.com>

On Friday 28 Feb 2025 at 10:25:18 (+0000), Vincent Donnefort wrote:
> +int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu *vcpu,
>  			    enum kvm_pgtable_prot prot)
>  {
>  	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
>  	u64 phys = hyp_pfn_to_phys(pfn);
>  	u64 ipa = hyp_pfn_to_phys(gfn);
>  	struct hyp_page *page;
> +	u64 size;
>  	int ret;
>  
>  	if (prot & ~KVM_PGTABLE_PROT_RWX)
>  		return -EINVAL;
>  
> -	ret = check_range_allowed_memory(phys, phys + PAGE_SIZE);

I'm not sure it is safe to drop this check here, see below.

> +	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
>  	if (ret)
>  		return ret;
>  
>  	host_lock_component();
>  	guest_lock_component(vm);
>  
> -	ret = __guest_check_page_state_range(vcpu, ipa, PAGE_SIZE, PKVM_NOPAGE);
> +	ret = __guest_check_page_state_range(vm, ipa, size, PKVM_NOPAGE);
>  	if (ret)
>  		goto unlock;
>  
>  	page = hyp_phys_to_page(phys);

Phys really needs to be a valid memory address here for 'page' to be
present in the vmemma -- dereference right below. So we can't rely on
the check in __host_check_page_state_range() sadly ...

> +	ret = __host_check_page_state_range(phys, size, page->host_state);
> +	if (ret)
> +		goto unlock;
> +
>  	switch (page->host_state) {
>  	case PKVM_PAGE_OWNED:
> -		WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_SHARED_OWNED));
> +		WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED));
>  		break;
>  	case PKVM_PAGE_SHARED_OWNED:
> -		if (page->host_share_guest_count)
> -			break;
> -		/* Only host to np-guest multi-sharing is tolerated */
> -		WARN_ON(1);
> -		fallthrough;
> +		for_each_hyp_page(phys, size, page) {
> +			/* Only host to np-guest multi-sharing is tolerated */
> +			if (WARN_ON(!page->host_share_guest_count)) {
> +				ret = -EPERM;
> +				goto unlock;
> +			}
> +		}
> +		break;
>  	default:
>  		ret = -EPERM;
>  		goto unlock;
>  	}
>  
> -	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
> +	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, size, phys,
>  				       pkvm_mkstate(prot, PKVM_PAGE_SHARED_BORROWED),
>  				       &vcpu->vcpu.arch.pkvm_memcache, 0));
> -	page->host_share_guest_count++;
> +	__host_update_share_guest_count(phys, size, true);
>  
>  unlock:
>  	guest_unlock_component(vm);
> diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
> index 930b677eb9b0..00fd9a524bf7 100644
> --- a/arch/arm64/kvm/pkvm.c
> +++ b/arch/arm64/kvm/pkvm.c
> @@ -361,7 +361,7 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
>  		return -EINVAL;
>  
>  	lockdep_assert_held_write(&kvm->mmu_lock);
> -	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, prot);
> +	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, 1, prot);
>  	if (ret) {
>  		/* Is the gfn already mapped due to a racing vCPU? */
>  		if (ret == -EPERM)
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

