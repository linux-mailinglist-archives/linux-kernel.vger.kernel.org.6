Return-Path: <linux-kernel+bounces-532787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFEAA4522F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9297A398A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBB118A95A;
	Wed, 26 Feb 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2KaZOHg"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAA1531E1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533412; cv=none; b=OQLcMgP60m5BM0ypxr/thtVNb6ItPhxB+qQdLowojFei0TyA++oODNIX1q6R+rwwDBPyP66QGkM+lRJ/y951b0q8tVBrpRgNA9nzYlZLPUzUuYl7JzQSLOGpbMQx0slSfuw0SFON8mKOdEoemnKrpVdT7taaJeHo/sTx3GVaprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533412; c=relaxed/simple;
	bh=AXgISx/rfQKSUQUtD9kRW8PtnfW37tCP1oQ632lE4X0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6XRvtZBpIbkZfvuk3BAiKDL+Qx95x4TtMHcfaQXuKayIpIu5HwRYj7UcdZMmKIroCoQKJQEFpQXRjVKtvauGIE4AbA2stWoFZwo/cZihqKNU4g7ICGurQzxG0bP/PDN/uWyM7tNrNCj7mtEp3ZDGuZsI/jK++8UAKcMF8eBpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2KaZOHg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so17764829a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740533411; x=1741138211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovU2TC113wn5DGLqOT0sBSNiJvPMkX6DGvOFo3nswIg=;
        b=j2KaZOHgIsahEvULYi9dVNrnGUDmIhTo0YSQ8OyHowV/zDNScW11WOH8Ogo/RoXz7f
         6EJc51Q0rNE0F7hUB6cMz/QiwSdQ8IjiADDAnFrsvn2qEx4plo9EL1Hi+xtxrZdQ9UIK
         j+jjGMQcOROuHwo46mT/Ir9bMuNjHNFYvHvSaU5Fy+naSuy7rMjTUUMLksOVgiirnMoa
         wlmp+M4cxHOnwEjXnW9NIB/291KTcYBY8YYLvtexxKtzAw1ISXWgqXaypHT16Ax5MUrs
         VkmGEY800ya7VuHtPbL0u/TEbcJLjXbdYexM2eTL7uiVRSItnLSkB77Luf6zGk8HIkdP
         FEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740533411; x=1741138211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovU2TC113wn5DGLqOT0sBSNiJvPMkX6DGvOFo3nswIg=;
        b=wwMdztezZoFhrh/CiPJVMZxJ8h6zxZuMDU3AGF+uW/cgZ+v52SEc8eJ9BCfZEL8a80
         J3dbKJW+5d9IgMx0zW3omjP99xV98Vt0mGZjiTaKfjw6EgHl/ZUqdXlSjtMx38cHErjR
         1IFQ+gy2oQpdBwyFOHVeSsXI63292tyX/hsL7J52pDVrcTGZ144cZE0zuN+F3+ZHujmV
         DRASOJG7EbRL+yRsQ4Tb/DigkoVGbWjfiZVzE2UHITFJy//gdE/GPRSY0GgK/frgCLBI
         LCosZh+3utvQEDlDd33GO/xZ2HbZUl10nYAQcBUoQ4QJdFwzZv3XPCze9Z74ZV7BrjUo
         ZOMA==
X-Gm-Message-State: AOJu0YxHQxPXegGdacDLay7Y6AHniiCaTlXnqnDXB3wfK6DKtknFsX5B
	XH6H67RJCpaj6MCa5MGsjjZnDMgqaJXU3AqPaaC83A9j1YMutusrxhw0yq2YDGdL4FJYIwDIBaH
	KhQ==
X-Google-Smtp-Source: AGHT+IHe7VGiQdZFEkSDkFW0n4rBxtU+HYXhau0TNSFX7GYcFv5JsroYZOPb6rKvYsGgr3ZF2dnmObeNn+g=
X-Received: from pgah6.prod.google.com ([2002:a05:6a02:4e86:b0:ad5:2d36:c6a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:4046:b0:1ee:c598:7a93
 with SMTP id adf61e73a8af0-1eef55b6a93mr31196675637.42.1740533410760; Tue, 25
 Feb 2025 17:30:10 -0800 (PST)
Date: Tue, 25 Feb 2025 17:30:09 -0800
In-Reply-To: <20250123002422.1632517-3-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122013438.731416-1-kevinloughlin@google.com>
 <20250123002422.1632517-1-kevinloughlin@google.com> <20250123002422.1632517-3-kevinloughlin@google.com>
Message-ID: <Z75uoedJyZ18CZeh@google.com>
Subject: Re: [PATCH v5 2/2] KVM: SEV: Prefer WBNOINVD over WBINVD for cache
 maintenance efficiency
From: Sean Christopherson <seanjc@google.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	pbonzini@redhat.com, kirill.shutemov@linux.intel.com, kai.huang@intel.com, 
	ubizjak@gmail.com, jgross@suse.com, kvm@vger.kernel.org, 
	thomas.lendacky@amd.com, pgonda@google.com, sidtelang@google.com, 
	mizhang@google.com, rientjes@google.com, manalinandan@google.com, 
	szy0127@sjtu.edu.cn
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 23, 2025, Kevin Loughlin wrote:
> +static inline void sev_writeback_caches(void)
> +{
> +	/*
> +	 * Ensure that all dirty guest tagged cache entries are written back
> +	 * before releasing the pages back to the system for use. CLFLUSH will
> +	 * not do this without SME_COHERENT, so issue a WBNOINVD.

This is somewhat misleading.  A naive reading of this would interpret the above
as saying that KVM _should_ do CLFLUSH on SME_COHERENT CPUs, which begs the
question of why KVM _doesn't_ do that.  I also think this is the right place to
call out that WBNOINVD support isn't guaranteed.

	 * Ensure that all dirty guest tagged cache entries are written back
	 * before releasing the pages back to the system for use.  CLFLUSH will
	 * not do this without SME_COHERENT, and flushing many cache lines
	 * individually is slower than blasting WBINVD for large VMs, so issue
	 * WBNOINVD (or WBINVD if the "no invalidate" variant is unsupported)
	 * on CPUs that have done VMRUN, i.e. may have dirtied data using the
	 * VM's ASID.

> +	 */
> +	wbnoinvd_on_all_cpus();
> +}
> +
>  static unsigned long get_num_contig_pages(unsigned long idx,
>  				struct page **inpages, unsigned long npages)
>  {
> @@ -2773,12 +2784,7 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
>  		goto failed;
>  	}
>  
> -	/*
> -	 * Ensure that all guest tagged cache entries are flushed before
> -	 * releasing the pages back to the system for use. CLFLUSH will
> -	 * not do this, so issue a WBINVD.
> -	 */
> -	wbinvd_on_all_cpus();
> +	sev_writeback_caches();
>  
>  	__unregister_enc_region_locked(kvm, region);
>  
> @@ -2899,12 +2905,7 @@ void sev_vm_destroy(struct kvm *kvm)
>  		return;
>  	}
>  
> -	/*
> -	 * Ensure that all guest tagged cache entries are flushed before
> -	 * releasing the pages back to the system for use. CLFLUSH will
> -	 * not do this, so issue a WBINVD.
> -	 */
> -	wbinvd_on_all_cpus();
> +	sev_writeback_caches();
>  
>  	/*
>  	 * if userspace was terminated before unregistering the memory regions
> @@ -3126,16 +3127,16 @@ static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va)
>  
>  	/*
>  	 * VM Page Flush takes a host virtual address and a guest ASID.  Fall
> -	 * back to WBINVD if this faults so as not to make any problems worse
> +	 * back to WBNOINVD if this faults so as not to make any problems worse

I don't like replacing WBINVD with WBNOINVD everywhere.  It incorrectly implies
that WBNOINVD is guaranteed.  Easiest thing is just to avoid mnemonics and describe
the behavior in conversational language (well, as conversational as cache flushin
gets :-D).
 
> @@ -3858,7 +3859,7 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
>  		 * guest-mapped page rather than the initial one allocated
>  		 * by KVM in svm->sev_es.vmsa. In theory, svm->sev_es.vmsa
>  		 * could be free'd and cleaned up here, but that involves
> -		 * cleanups like wbinvd_on_all_cpus() which would ideally
> +		 * cleanups like sev_writeback_caches() which would ideally

Similarly, avoid function names in comments, because they too become stale.

>  		 * be handled during teardown rather than guest boot.
>  		 * Deferring that also allows the existing logic for SEV-ES
>  		 * VMSAs to be re-used with minimal SNP-specific changes.

