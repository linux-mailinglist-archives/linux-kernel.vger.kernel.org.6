Return-Path: <linux-kernel+bounces-380770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892369AF5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5FB1C21D13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E3C2185BC;
	Thu, 24 Oct 2024 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwIl6ahA"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A961D5AB5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729812353; cv=none; b=NIi21lEarOJsZbTniE8iCD54uKQ3eLXoVORCpY2IPOlfTam5vTIr0tuPRN11aYUJpI95gUB0/6OjfC5ztDZkgaMO/8FwVMJ0bWKdTDM5h3tTn8VoiSndCUdmZoq6F4MLykMQyerL3pRNa+SIQ0jfhiPHTEeY+ZrT24ZMzArVJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729812353; c=relaxed/simple;
	bh=A2M9dwzI2dleJm/Tj0b8eflNdiAFk3S68gRrsZPrq24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qmM1vtf0ckF3OcYEsLvRQmhvprjbpruy/yF81so0hys45U4HT2kovvjULVtEiY6nxo9YzTAHrQoRgGSFPzMiu2XcBbk+SHS8GXbAZn+0Ane8YJXkWtd6SBwRP8iD4eR3/6old7hSes2wOF+s/k4Gs3hRl0oQIsNwuw1AtFqRWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwIl6ahA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ec0d56d624so1314427a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729812350; x=1730417150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6ofNIG/FWjor+LkJgXQrXvGHYsbVWGzGeus18IdWzY=;
        b=fwIl6ahAn+6gqxwD49zQ933kQNyrEqM49XxckeiYF4MZNAToApeuzbb84ZgajRlrjh
         eiUJTqAs52hRTxfSvFmRFObU/hQlBs8uGG4C5kHriKrIuR1LQWWRF7CgigBhVfbzBsN4
         Y4ovrFn4n2F3Zb0NsGQOU1RMROqLYMhoALmzvgwgZF7b2qeRyxwY0SgB1n0MWVT1qphf
         vGC1n65RNZ/9xFGAesO7S9NigLpMSi3QFGdjAj8Zjtk7tuaXzS6L6ukhfCA3xepRlqCo
         xvMeeJAinuISXHRTfPQfribka+2/JAcOmxvD9JP8BRyoFRfeJCHCyU7RN5axjVmz2sDL
         6RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729812350; x=1730417150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6ofNIG/FWjor+LkJgXQrXvGHYsbVWGzGeus18IdWzY=;
        b=UJkksteBUiTVVwHX3HWizm3j14fC8vOGwZ8xJNhz0EyOkRvtpQaAljI0Gm9zbq8A2M
         Xn/xoh2p8k8nxVfi6vbO7m1DqooInpXK3IWgV6TQdQ1cEvrVifKr4H5/k11/XEICVzzb
         pObQfKnO/TWQxznX8nM8FDWVxoLQz4IiCvc+6ky0ghmdFpxpJ5o58gZrBnJD97SNw7Xl
         oWnZp1KLajvNN5H1N2IFHxJsEk5FJ50a7LsjF2/FHSj7bTZuvFw7DdxNS89hBMgqzTKP
         CQ7P5e+xKfGnOZZq+z/d/hHXEiWl28UyKxRFE0boc53MAmHbKmcgZ6Yu4aYYZfLNmE8S
         z8aw==
X-Forwarded-Encrypted: i=1; AJvYcCVfilB8Terrb2hG677ptIyArh+qY7oJAxvtzO3XhFK1ee98Sj/oO6NXdKCkEhDvJH4N3ZR4LglL+CtKHH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZXy+8rIK7BnKrERvFJnadcsIFwhKdGssW5i0+eCDe3X5hhJF
	YNwcqrwLTbJbPenWHJ3j1b4IwEgVPp8CLn0S5sMEgfFW7RaFsfCCvkQoEVf6G+RwkC2bX4F/Va7
	VVA==
X-Google-Smtp-Source: AGHT+IGGcXhAT9alIKzDegKCU2ah5sKo6L3bo5eJnRMUIWu6peoIxtruCpUAP64IUjTNHDb4xvwyalk2y+A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:7319:0:b0:7c1:271a:c780 with SMTP id
 41be03b00d2f7-7edb305c093mr5669a12.0.1729812349604; Thu, 24 Oct 2024 16:25:49
 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:25:47 -0700
In-Reply-To: <20241004195540.210396-3-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004195540.210396-1-vipinsh@google.com> <20241004195540.210396-3-vipinsh@google.com>
Message-ID: <ZxrXe_GWTKqQ-ch8@google.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/mmu: Use MMU shrinker to shrink KVM MMU
 memory caches
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, zhi.wang.linux@gmail.com, 
	weijiang.yang@intel.com, mizhang@google.com, liangchen.linux@gmail.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 04, 2024, Vipin Sharma wrote:
> Use MMU shrinker to iterate through all the vCPUs of all the VMs and
> free pages allocated in MMU memory caches. Protect cache allocation in
> page fault and MMU load path from MMU shrinker by using a per vCPU
> mutex. In MMU shrinker, move the iterated VM to the end of the VMs list
> so that the pain of emptying cache spread among other VMs too.
> 
> The specific caches to empty are mmu_shadow_page_cache and
> mmu_shadowed_info_cache as these caches store whole pages. Emptying them
> will give more impact to shrinker compared to other caches like
> mmu_pte_list_desc_cache{} and mmu_page_header_cache{}
> 
> Holding per vCPU mutex lock ensures that a vCPU doesn't get surprised
> by finding its cache emptied after filling them up for page table
> allocations during page fault handling and MMU load operation. Per vCPU
> mutex also makes sure there is only race between MMU shrinker and all
> other vCPUs. This should result in very less contention.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---

...

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 213e46b55dda2..8e2935347615d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4524,29 +4524,33 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  	if (r != RET_PF_INVALID)
>  		return r;
>  
> +	mutex_lock(&vcpu->arch.mmu_memory_cache_lock);
>  	r = mmu_topup_memory_caches(vcpu, false);
>  	if (r)
> -		return r;
> +		goto out_mmu_memory_cache_unlock;
>  
>  	r = kvm_faultin_pfn(vcpu, fault, ACC_ALL);
>  	if (r != RET_PF_CONTINUE)
> -		return r;
> +		goto out_mmu_memory_cache_unlock;
>  
>  	r = RET_PF_RETRY;
>  	write_lock(&vcpu->kvm->mmu_lock);
>  
>  	if (is_page_fault_stale(vcpu, fault))
> -		goto out_unlock;
> +		goto out_mmu_unlock;
>  
>  	r = make_mmu_pages_available(vcpu);
>  	if (r)
> -		goto out_unlock;
> +		goto out_mmu_unlock;
>  
>  	r = direct_map(vcpu, fault);
>  
> -out_unlock:
> +out_mmu_unlock:
>  	write_unlock(&vcpu->kvm->mmu_lock);
>  	kvm_release_pfn_clean(fault->pfn);
> +out_mmu_memory_cache_unlock:
> +	mutex_unlock(&vcpu->arch.mmu_memory_cache_lock);

I've been thinking about this patch on and off for the past few weeks, and every
time I come back to it I can't shake the feeling that we came up with a clever
solution for a problem that doesn't exist.  I can't recall a single complaint
about KVM consuming an unreasonable amount of memory for page tables.  In fact,
the only time I can think of where the code in question caused problems was when
I unintentionally inverted the iterator and zapped the newest SPs instead of the
oldest SPs.

So, I'm leaning more and more toward simply removing the shrinker integration.

