Return-Path: <linux-kernel+bounces-511964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02663A3321F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3F11687B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EFE204086;
	Wed, 12 Feb 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3eQwrTN"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C92036E6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398165; cv=none; b=M3hJ4kTFnYSMie206DGCgh4eL2W0oBJ2tM6WjH7Pj36QfEC28UHa3bsgzt4+Qrd8sT6CMVjbIMHmycgU/Jnxq+Fx3NrmaGP3Zuf2XDf3NpRECzFYu8JVESjVJ6Bca+WB6Q6GWk8uWCqJanaFmVQX4euB66cGgaXWjDOzUfJAjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398165; c=relaxed/simple;
	bh=+hmnB1xRz1YURup1Xw+JOjt5Tdivt9hLIgpOvmd50R0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nAH+viNloym2EnBerJiQygTd7x8JvS5vRxTrBBk9MMavAgsK0RlOduWK7WhJttb/k8fsY0o3Y52JsNlsqBQt82fKPycPij4C1OcDli5qMqF1EL3T9zq+7LMKQK0oQAstEvROXCPGP1ExEtyN1j8+JvpXXb99k6RecdwA4Lp+OE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3eQwrTN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f61a983ddso6232215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739398163; x=1740002963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2ICBUuQRIYIog7pz5lKDrW5zN3KbpSFac5007xznog=;
        b=H3eQwrTNmz9xFdew2yWIGFBuW257xwH1IUEBdFPIS85btVP97uW/ffuFbM2zDJeTFO
         zyTlvhYGwDEZTaBqKjwH8pfJq5EA6xm6aj33zyBprKFRltknfyl00YmV/9R3f4p9lJ/E
         ogYedeGhdxZ0rnK0rWWnRvzW/kj+26NkmsgIGokxuyfHHWpq4T1yeMEle2Ng2tcO6NgI
         AjTn6gVHxPMY0VsBCRH5YjYhx2caNFY7+mOc8CgOjksckU6HzvWXy9bEXkJ6Iehq8qJC
         XeqOUqztneyZ7qjSa1aNEiNwwQ/sw72lUX4IG+JaD0l6lDLmHfyvKod1IEwNdPf++L5H
         cjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739398163; x=1740002963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2ICBUuQRIYIog7pz5lKDrW5zN3KbpSFac5007xznog=;
        b=C4X1WHEXf+SWkEPpYJrBUpaOvLhsERYt6lax152dOW32kY0XGApR427mNtWu4D/2X3
         sz4/BcA/LbnTz2umieBTRs6AbnAU3fvwDfo0Bt2i7E1elfDYzwTbjBBHfPI/e9+Isq6v
         iePHAHnF4ANTfCTLarYAV+EVJEWjiTjAplEtx4Fa341rtH6wf88NmPUtTlG3kV988hFN
         SBxidMSLrfhZClu8xJrxXPs6ZE5sZmtO4QAL/F+tSbcHpeA5G61eYmwimJlwHRjM3hOZ
         YlRSaD7tDsHAxEFFO76n8eauE4wtyt/11fWqKq1m/sMktMpd3cE2Zv+pLO4Fs6YZPPFm
         YTCw==
X-Forwarded-Encrypted: i=1; AJvYcCVQOsK52HrvsYGtE7MJ1KIrGSOKgdQxVqPruIgbFrvc8O61A/rHc9ApnQ3qPBZiFBQFr9PLR7Ii7LERWug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzgKjFWeHth3cP6vS6M2eCAA2gWPBSejo3v9E9D8BSbRqk9gN
	nrR5n6EzrCrAwAIjZx5jcW2VthwfEZmX3B4vnbzC+D3ltSvivKsZL8p2plhovkdgm37tVcMKPHY
	2/A==
X-Google-Smtp-Source: AGHT+IFfiIZ2DEso+N+paKeu5OgQzYFebfjWCB9EVzOGCvy3Mzjrl//YuPs2vfH++icWQIO/ZuqrhAgLnYk=
X-Received: from pfx23.prod.google.com ([2002:a05:6a00:a457:b0:730:7921:292a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1591:b0:1e1:9b77:e237
 with SMTP id adf61e73a8af0-1ee5c88f0abmr10648015637.40.1739398162979; Wed, 12
 Feb 2025 14:09:22 -0800 (PST)
Date: Wed, 12 Feb 2025 14:09:21 -0800
In-Reply-To: <20250204004038.1680123-6-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204004038.1680123-1-jthoughton@google.com> <20250204004038.1680123-6-jthoughton@google.com>
Message-ID: <Z60cEcQ0P1G7oyFK@google.com>
Subject: Re: [PATCH v9 05/11] KVM: x86/mmu: Rename spte_has_volatile_bits() to spte_needs_atomic_write()
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 04, 2025, James Houghton wrote:
> spte_has_volatile_bits() is now a misnomer, as the an SPTE can have its
> Accessed bit set or cleared without the mmu_lock held, but the state of
> the Accessed bit is not checked in spte_has_volatile_bits().
> Even if a caller uses spte_needs_atomic_write(), Accessed bit
> information may still be lost, but that is already tolerated, as the TLB
> is not invalidated after the Accessed bit is cleared.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---

...

> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 59746854c0af..4c290ae9a02a 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -519,7 +519,7 @@ static inline u64 get_mmio_spte_generation(u64 spte)
>  	return gen;
>  }
>  
> -bool spte_has_volatile_bits(u64 spte);
> +bool spte_needs_atomic_write(u64 spte);
>  
>  bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>  	       const struct kvm_memory_slot *slot,
> diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
> index 05e9d678aac9..b54123163efc 100644
> --- a/arch/x86/kvm/mmu/tdp_iter.h
> +++ b/arch/x86/kvm/mmu/tdp_iter.h
> @@ -55,7 +55,7 @@ static inline bool kvm_tdp_mmu_spte_need_atomic_write(u64 old_spte, int level)
>  {
>  	return is_shadow_present_pte(old_spte) &&
>  	       is_last_spte(old_spte, level) &&
> -	       spte_has_volatile_bits(old_spte);
> +	       spte_needs_atomic_write(old_spte);

Unless you object, I'll change this to spte_needs_atomic_update(), and tweak
kvm_tdp_mmu_spte_need_atomic_write() accordingly.  "write" was a bad choice by
me.  It's not just the store/write that needs to be atomic, it's the entire
read-modify-write.  E.g. KVM needs to preserve the existing value, but for many
flows, it's even more important that KVM's snapshot of the old SPTE is accurate.

>  }
>  
>  static inline u64 kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 old_spte,
> -- 
> 2.48.1.362.g079036d154-goog
> 

