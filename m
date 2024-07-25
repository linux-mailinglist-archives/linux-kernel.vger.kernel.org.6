Return-Path: <linux-kernel+bounces-262529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6068C93C84F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8035E1C21035
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A9A3771C;
	Thu, 25 Jul 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0Sz0iC2"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3408210FB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931885; cv=none; b=S/IWJln0hRpE4/7+ZaLykeWXdkNuy7Ya3dCzpBNwNoGG45FkdS8MP3hvk4nA8OMsfsxoyxlm86tJAIgZ3XkvHYypD/LUoo/9SxUoeItq06DjlDLznkP56FQWzlKcG5oHiBTOC1rKshT4rWSc34qQyBDNsUtJTHvLyKZBw6Qv6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931885; c=relaxed/simple;
	bh=i3R8nP9zLb+svWwS6BlGQj3N7iJXoBGSLMafotY8l+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV6RXM7+zl7Ovkiu+ubLNUIY4AxkS4dTXkGWtSuCO1kWykjPEgeNV6fB+njVjpGrZi27zu6EG9VshCsH0Sh51MyTLGaNMNgq+8MDSQrv77HmFdWxctgtFyMtAsAOdtHdq7Tzy1A7nxv2FFhBt5uVdv0jNoASehBiVNaRIUDAaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0Sz0iC2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd66cddd4dso11553535ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721931883; x=1722536683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Se8gRYY5LIzNKXtdqfpnU7+bApyeWuI8Q5DVjozYskA=;
        b=B0Sz0iC2mQxQ1OlnT48cw0EaJRrxh3u4oaSuWDITfETMQ5TAw5Jmtwp/Ub681JbEOg
         k3ExGVrA1en2nRKW8pmyMzH0oe1eRaodEJl0IulyJxTfu3mu5Fks+/5rr8ZSvUbL8hz0
         OFJ9Hu/4rLy1d+lsQKe6sHAQu25if6Eu8DWB5hP5pJc1jYVHRSG2Ma5H3WaDHI9zhH7r
         MgO006Gm7ZZoJEAAGO0ztS9WVK0bDeaw2UyAYIvE3kS5HmANHOHpcSmUi2WS+vac6aGV
         uqUZ488oQSxmby2BMrno2rluMLBeBTqFL68ccdCyckkGlUXRINoYtoQgR4qHqzSKLU6p
         QcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931883; x=1722536683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se8gRYY5LIzNKXtdqfpnU7+bApyeWuI8Q5DVjozYskA=;
        b=xECpc8YxPmayaNCBe6oDpbMHAlQnN3UufBuYdz56sYRf15wySWMrod9LCNiISFbdgu
         wLsNYSvji0tqRQzSvCeMMMwRSYynPg8xR/AHlj/HH0IFWl6bDzlfdSfEx/TprPeauYx8
         G9OyATjCxkP9Uv9cSZE1R4rJKcCM0L0Y9R0E/MGVWtdpXGCob7JAPz+eJE+9sTw6tQ0Q
         Ai9RGj0WnkXaiXRS5QQ51UpzAnaxC1hTTyhyrhXvDieggPJ1jhdFO5AA2IW26YHsc6So
         O8mXJeeAW2CIoJqtaaKmMZUmdskt2gpBaK5tUhbSUCyFfQWGI7X7LjBw3miAxGhHFvcM
         1qKA==
X-Forwarded-Encrypted: i=1; AJvYcCX34dH8OPk4jBQew6pCh5tNd1WZiLzmceibKKgGwcltcibo6TChrPHLQC/uXnzXaKydQHZcETRCZfjZLA4gCfMDaaCe19ThLCtlBqb3
X-Gm-Message-State: AOJu0Yw/nCCkagoMbyDsASLqz9ZzF4YInJq6CZi2cQfRmnGyohSk4Usq
	oTNZErAhOIgdAcbAzHQH6jjcJfEDBFfEglZB65KA5RhZTD+5Wd/a+OC2x5NYSQ==
X-Google-Smtp-Source: AGHT+IGk5VWe3MPnS2h4842sbCO2M3IxnHPFyqsvxia4EgfDcheEN/25uzJzuwNsHLA2SFZv0xA2tg==
X-Received: by 2002:a17:902:da91:b0:1fc:5b68:ffb8 with SMTP id d9443c01a7336-1fed38ba92fmr44676985ad.30.1721931882617;
        Thu, 25 Jul 2024 11:24:42 -0700 (PDT)
Received: from google.com (61.139.125.34.bc.googleusercontent.com. [34.125.139.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa4045sm17298215ad.258.2024.07.25.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:24:42 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:24:37 -0700
From: David Matlack <dmatlack@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Rientjes <rientjes@google.com>,
	James Morse <james.morse@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>,
	Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/11] KVM: x86: Implement fast_only versions of
 kvm_{test_,}age_gfn
Message-ID: <ZqKYZagP55dVD1m4@google.com>
References: <20240724011037.3671523-1-jthoughton@google.com>
 <20240724011037.3671523-10-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724011037.3671523-10-jthoughton@google.com>

On 2024-07-24 01:10 AM, James Houghton wrote:
> These fast-only versions simply ignore the shadow MMU. We can locklessly
> handle the shadow MMU later.
> 
> Set HAVE_KVM_MMU_NOTIFIER_YOUNG_FAST_ONLY for X86_64 only, as that is
> the only case where the TDP MMU might be used. Without the TDP MMU, the
> fast-only notifiers will always be no-ops. It would be ideal not to
> report has_fast_only if !tdp_mmu_enabled, but tdp_mmu_enabled can be
> changed at any time.

tdp_mmu_enabled is a read-only KVM parameter. And even when it was
writable, it was still fixed for a given VM at VM creation time.

Would it make more sense to have kvm_arch_post_init_vm() set
has_fast_aging if the architecture supports it. And for x86 that means
iff tdp_mmu_enabled.

> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  arch/x86/kvm/Kconfig   | 1 +
>  arch/x86/kvm/mmu/mmu.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 6ac43074c5e9..ed9049cf1255 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -24,6 +24,7 @@ config KVM
>  	select KVM_COMMON
>  	select KVM_GENERIC_MMU_NOTIFIER
>  	select KVM_MMU_NOTIFIER_YOUNG_LOCKLESS
> +	select HAVE_KVM_MMU_NOTIFIER_YOUNG_FAST_ONLY if X86_64
>  	select HAVE_KVM_IRQCHIP
>  	select HAVE_KVM_PFNCACHE
>  	select HAVE_KVM_DIRTY_RING_TSO
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 919d59385f89..3c6c9442434a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1641,7 +1641,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>  	if (tdp_mmu_enabled)
>  		young |= kvm_tdp_mmu_age_gfn_range(kvm, range);
>  
> -	if (kvm_has_shadow_mmu_sptes(kvm)) {
> +	if (!range->arg.fast_only && kvm_has_shadow_mmu_sptes(kvm)) {
>  		write_lock(&kvm->mmu_lock);
>  		young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
>  		write_unlock(&kvm->mmu_lock);
> @@ -1657,7 +1657,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>  	if (tdp_mmu_enabled)
>  		young |= kvm_tdp_mmu_test_age_gfn(kvm, range);
>  
> -	if (!young && kvm_has_shadow_mmu_sptes(kvm)) {
> +	if (!young && !range->arg.fast_only && kvm_has_shadow_mmu_sptes(kvm)) {
>  		write_lock(&kvm->mmu_lock);
>  		young = kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
>  		write_unlock(&kvm->mmu_lock);
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 

