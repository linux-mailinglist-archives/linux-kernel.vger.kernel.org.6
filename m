Return-Path: <linux-kernel+bounces-564616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A0AA6584F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA4A160413
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC2A1B0F23;
	Mon, 17 Mar 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lT2JEXDD"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1ED1AF0C7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229460; cv=none; b=LD93TzN7mHawh/Z49Dc9T/v5R5EzhYUNynrV5Z4RdvwE9dkxqg724sadZ2dhf52poOu2sniPI3vbJZB/mTmd2NHf2qwAp6NAndePwjLtMGs1UXMjnoWyD3fs3mLnsr4YKJDY/TjL2f9DQCOHQ+1xlocd+B3/MTCJfCOZU8/Sn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229460; c=relaxed/simple;
	bh=AKuD9lL+3cui9iII20V5Gg63ovIP2T9Hg6+6gg3T6ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBOrF6sjPrJjHpP5y/yT8+QDlKxsO5k/zKg1OJXUjaoVWvKoS8hBfYJImzHmhXnGkUHmezrImB92ZR5LpxnaopdvUSeHwuCJ41Tf0v3s3abNxjA2TWlLXUG0g0ZrgCEVrWKlA9vzr8p+CFOwUvW5tnn8EDaRk75hoWDC3br43o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lT2JEXDD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240aad70f2so55275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742229458; x=1742834258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3/EYuGkMIiunQkE35x51UlkP8FydWfrU3XJ5GNt/b4=;
        b=lT2JEXDDW+AHpokZVPlM0pItosya9KanX/Bf+oX152gmIP/fZa9quGSLSA7e41mqKF
         ygIHYanY/z2y6bsOte9xwUH0Cpe5TfsWylutqZWDFSM48rAbST0k7i+60gTPfyBAmfwJ
         EbkxHUOogJL2MFMtMdN9/n0oAy6Nl2BZXfYIKRtEk7yC3shySVs1fVsy7CxI8bvMsYdj
         m3W2eeWDiJRzajZy1sbTBd1W+NcgWxHOzp6V2l1aSLJPo+tZnWcF5roab83oWpl3830H
         qvEp2WtaGNobc2oimeOqIEolcUKsGyCrIH0iUIRA8peFYvO5E6JbVfvwFQnzMVJ/+iDS
         QbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229458; x=1742834258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3/EYuGkMIiunQkE35x51UlkP8FydWfrU3XJ5GNt/b4=;
        b=rpI4KBetwf3Cc1FiFN+umkvvtV9uwD8Z5ua0+vIi21kTHDVgvvOSKgfsw3aqkxibWD
         GHgpsD1q6dyAR0piY/+4WUDt5rWIgR8tcrsrv7873oNfWogmH4/skmN724homrWqnAND
         cC2ja5Qf6zx59qQzkbh1D6Ep5VL35fmynWvtR7s0tfRR7xJF2Kof48n5DDKLGywQDOPG
         4oHRRAwJV21Mk3vFyn0OdbvcI8RIVCNLdbgJRUY6WTnV5sS8u/8HXLj5WwfYwBJ2KsK9
         FsEn6bBy7UQ3kA+Oy8byma88GGErshPNtqlh3It3IuodJDPREKmbv9F4l/tZd96dovYP
         h73w==
X-Forwarded-Encrypted: i=1; AJvYcCU0bOkSHm5dc22qtlIZZQb/dKNxyVqfYncJBCmG6Ehv0RXm8xCaIVNcKDTzih5K14jZ94fS+E9vDno4pKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXmK0j0Nm34CTAsE1+JzydJcPfXiKySB7KeeOBqmBupr3bqN/
	/tpgXbXPUGZgfBvtVisdAAeSFgoCnwDt7p4Ij8M/W3wSMPO9oDPOalt9l43VNA==
X-Gm-Gg: ASbGncuyidb6xU5MGuK+DXLJ6VU6AJtFJr8iSujc+FIp9emiUwBinYKpWVpA6Ax6kfB
	gcfZtyw2G6DnjYMuUmK/3YxvHLsFVvhwTVear5YtFTimRjQLq4rv6696Yp67pnQTJotDmiPjBdL
	c9fpsD1RlyM2K6qGhkerkAMwMBH+hH5rcmiFzzyj065YgsVzJcWgDMBJhXz+eYg2CUqwiYE/y/n
	SGnZ/38tUgNzgcHAv+1tax4IM3kUTe4VX9YJpRC+s+jZcMeeGOK6OXPH2SxeAsZwmpwJNQt9PZT
	H/yM/yiej3zeLV1S0Z/m6WyRz6njZc21yEa6eb1hRiVUixX/GuJ2R25FjVGSMiguKbfBem53J5e
	WR8LOt25iOWm6/rv4
X-Google-Smtp-Source: AGHT+IGTT7oirH5Crt6ZdBBB+GEod7hnh7ZOY2WV0JKG5s0rcA9DoR4brF9uecD18UnvNguCFzREug==
X-Received: by 2002:a17:903:17cd:b0:220:c905:68a2 with SMTP id d9443c01a7336-225f57daf74mr4054325ad.5.1742229458021;
        Mon, 17 Mar 2025 09:37:38 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e109sm7796841b3a.115.2025.03.17.09.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:37:36 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:37:32 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: x86/mmu: Dynamically allocate shadow MMU's
 hashed page list
Message-ID: <20250317163732.GA1863989.vipinsh@google.com>
References: <20250315024010.2360884-1-seanjc@google.com>
 <20250315024010.2360884-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315024010.2360884-2-seanjc@google.com>

On 2025-03-14 19:40:08, Sean Christopherson wrote:
> Dynamically allocate the (massive) array of hashed lists used to track
> shadow pages, as the array itself is 32KiB, i.e. is an order-3 allocation
> all on its own, and is *exactly* an order-3 allocation.  Dynamically
> allocating the array will allow allocating "struct kvm" using regular
> kmalloc(), and will also allow deferring allocation of the array until
> it's actually needed, i.e. until the first shadow root is allocated.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  4 ++--
>  arch/x86/kvm/mmu/mmu.c          | 21 ++++++++++++++++++++-
>  arch/x86/kvm/x86.c              |  5 ++++-
>  3 files changed, 26 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6673,13 +6685,19 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
>  		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
>  }
>  
> -void kvm_mmu_init_vm(struct kvm *kvm)
> +int kvm_mmu_init_vm(struct kvm *kvm)
>  {
> +	int r;
> +
>  	kvm->arch.shadow_mmio_value = shadow_mmio_value;
>  	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
>  	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
>  	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
>  
> +	r = kvm_mmu_alloc_page_hash(kvm);
> +	if (r)
> +		return r;
> +

In the patch 3, shouldn't this be moved to else part of the below 
'if (tdp_mmu_enabled)' line? Otherwise, this hash array will always get
allocated.

>  	if (tdp_mmu_enabled)
>  		kvm_mmu_init_tdp_mmu(kvm);
>  
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12704,7 +12704,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	if (ret)
>  		goto out;
>  
> -	kvm_mmu_init_vm(kvm);
> +	ret = kvm_mmu_init_vm(kvm);
> +	if (ret)
> +		goto out_cleanup_page_track;
>  
>  	ret = kvm_x86_call(vm_init)(kvm);
>  	if (ret)
> @@ -12757,6 +12759,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  
>  out_uninit_mmu:
>  	kvm_mmu_uninit_vm(kvm);
> +out_cleanup_page_track:

I think there is a memory leak in this series.

1. kvm_mmu_uninit_vm() is not freeing kvm->arch.mmu_page_hash. So, in
error case out_uninit_mmu will not recover memory allocated in
kvm_mmu_alloc_page_hash().

2. When VM terminates or is killed then the same thing will happen, no
one is reclaiming the memory.

>  	kvm_page_track_cleanup(kvm);
>  out:
>  	return ret;

