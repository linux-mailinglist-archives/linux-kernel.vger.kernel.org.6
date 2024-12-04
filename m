Return-Path: <linux-kernel+bounces-430398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1739E3067
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314C328138B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C2B64A;
	Wed,  4 Dec 2024 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUKgLb7H"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7A846F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733272052; cv=none; b=bGBKfpxgzP9yB8XeFOr6mXrd74bZNuzt/8s12GtLZ0N5wNLdCHAVhLHB3zgbJLv6apLRE6KY5loFLqt3lMy1MJJiTrm3YPAicVLM8GJ+mA+NUuQdIKNCxBvEA4pfaixS4WM7n5e7vIFg5iuZ/fGUNC1JKvX1iywzpJ82T3H9sUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733272052; c=relaxed/simple;
	bh=mlDxbR0ksxk6SszK/KuDXIohNA2afwaCxT+p8r8vTao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oMaxlehItVf2JqwBGlZpJGzd4Fuwt5RCMixYu/1HTjBrfFlnAY8PZLjJBTwheUsHw/2+IRqB+E8MhqjTy/vNZER9WbOgqJv0c+UKbz59YfwwmHeHrPWtvjDqe4RVOFQEmNouw1ZvvBMQ0AXj2e68U77PtJsFOu9KhO7ZllDPl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUKgLb7H; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fb966ee0cdso355984a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 16:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733272049; x=1733876849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aANPg97Zcm8rcmUO5fgtzXnkk00xvaS+AXzgw4y0hEg=;
        b=zUKgLb7HwkFWLmuBlOaMMFrfkB+br04yktID50owH7OSp0wGLumRWjg/mZStTLXprj
         XGYn6v0AGZc/0IDwo8k7xMWIgcD+5hNEzYVXfM11XL9CnuyXecMLwBOAdLuymOcUGjEI
         fbVb0IkB5Ii1qUOiS8OhcOilRytd9SSY3BYAmCJuieP+ox19gAEfEkURPG8ArnIhnmZy
         key5S2iDosNPqFocfsMwAxfkeHmPZ5LbOqKk9NyS/TkScd1OERWFGPVQYmFOcpuNapQe
         KeiLHF7hfCm6T9Cj6BQNbN4jhkqtgSAdABJYlvAQZj0TOlxfDC3vow6gAeZAce63rP69
         nSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733272049; x=1733876849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aANPg97Zcm8rcmUO5fgtzXnkk00xvaS+AXzgw4y0hEg=;
        b=ZPpFXoLg7DrKFizxiawQeEalAXpiG48/gf5DV+LLJmE1UQaWR/QKXrWoQ2pLnMWHlf
         gcQJNsi1oYZgI32Em4QFHfKYYzB1cbr1Ov0lZFmFR9bCDY+aPjXi4D2TQEAle2+Dc5GU
         YjEbkUQaGIT4Bm7JCaKIMv2mk6hQb6hGQ2sEnqykFe0GqTzqIP3p9ykg7007AxKaoAXF
         /bX3g7VMqCoEe+vobC2fptxrXkF6gkYIVnvL3aiAbUIN2eQDuGhBn4k6/iNtjIdk2dn7
         MKZVE2NkdScXLFiJct8+9BU0idef1cjibQthFfa3wWfBgqiNt/QeK8E9UVCKgF7X7TPB
         U9gg==
X-Forwarded-Encrypted: i=1; AJvYcCUYfPXbgdyXREOfkelNzqEU2HX0+wo0R5TOl8mdbZZ+RP0G7eFQyxdfAm/Riesaxm+Gcm88LD2yDiGEUKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhn2O48xTx6oElzib8EdXyXXbPlT3ixfyNW4ZzFXMiRG66kHD
	APfSzobimJLgs4JqtUkP31DuTJwG5bPLOY0PXX20Xwefix1GsR8rgNAjepRnKXLN5Txxh18ApXC
	pAA==
X-Google-Smtp-Source: AGHT+IFKDItcOU4QRHI/roOYDniQGqYNuFynA7LgIsa7adtsz0YHsHHtCZfTIl+E0q0a5gCqKm+ESIKI9Jg=
X-Received: from pjbph8.prod.google.com ([2002:a17:90b:3bc8:b0:2e9:29d3:c920])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1844:b0:2ee:823e:39c4
 with SMTP id 98e67ed59e1d1-2ef025a4403mr7892877a91.7.1733272049143; Tue, 03
 Dec 2024 16:27:29 -0800 (PST)
Date: Tue, 3 Dec 2024 16:27:27 -0800
In-Reply-To: <20240411140445.1038319-3-szy0127@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240411140445.1038319-1-szy0127@sjtu.edu.cn> <20240411140445.1038319-3-szy0127@sjtu.edu.cn>
Message-ID: <Z0-h73xBQgGuAI3H@google.com>
Subject: Re: [PATCH v4 2/2] KVM: SVM: Flush cache only on CPUs running SEV guest
From: Sean Christopherson <seanjc@google.com>
To: Zheyun Shen <szy0127@sjtu.edu.cn>
Cc: thomas.lendacky@amd.com, pbonzini@redhat.com, tglx@linutronix.de, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="us-ascii"

+Kevin

My apologies for the very slow review.

On Thu, Apr 11, 2024, Zheyun Shen wrote:
> On AMD CPUs without ensuring cache consistency, each memory page
> reclamation in an SEV guest triggers a call to wbinvd_on_all_cpus(),
> thereby affecting the performance of other programs on the host.
> 
> Typically, an AMD server may have 128 cores or more, while the SEV guest
> might only utilize 8 of these cores. Meanwhile, host can use qemu-affinity
> to bind these 8 vCPUs to specific physical CPUs.
> 
> Therefore, keeping a record of the physical core numbers each time a vCPU
> runs can help avoid flushing the cache for all CPUs every time.
> 
> Since the usage of sev_flush_asids() isn't tied to a single VM, we just
> replace all wbinvd_on_all_cpus() with sev_do_wbinvd() except for that
> in sev_flush_asids().
> 
> Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>
> ---
>  arch/x86/kvm/svm/sev.c | 48 ++++++++++++++++++++++++++++++++++++++----
>  arch/x86/kvm/svm/svm.c |  2 ++
>  arch/x86/kvm/svm/svm.h |  4 ++++
>  3 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index f760106c3..3a129aa61 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -215,6 +215,42 @@ static void sev_asid_free(struct kvm_sev_info *sev)
>  	sev->misc_cg = NULL;
>  }
>  
> +static struct cpumask *sev_get_wbinvd_dirty_mask(struct kvm *kvm)
> +{
> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +
> +	return sev->wbinvd_dirty_mask;
> +}
> +
> +void sev_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> +{
> +	/*
> +	 * The per-VM wbinvd_dirty_mask should record all physical CPUs

Don't hedge with "should", just state KVM's behavior.  E.g.

	/*
	 * To optimize cache flushes when memory is reclaimed from an SEV VM,
	 * track physical CPUs that enter the guest for SEV VMs and thus can
	 * have encrypted, dirty data in the cache, and flush caches only for
	 * CPUs that have entered the guest.
	 */


> +	 * that are running a SEV guest and be used in memory reclamation.
> +	 *
> +	 * Migrating vCPUs between pCPUs is tricky. We cannot clear
> +	 * this mask each time reclamation finishes and record it again
> +	 * before VMRUN, because we cannot guarantee the pCPU will exit
> +	 * to VMM before the next reclamation happens.

Migration is easy enough to solve (I think; famous last words).  KVM is already
forcing an exit to service the IPI, just set the associated pCPU's bit if it has
a running vCPU loaded.

However, to play nice with multiple flushers, we'd need something like
kvm_recalculate_apic_map() to ensure subsequent flushers wait for previous
flushers to finish before reading the cpumask.  Maybe a simple mutex would
suffice?  Contention should be extremely rare for well-behaved setups.

Kevin, since I believe your use case cares about vCPU migration, is this
something you'd be interesting in tackling?  It can go on top, i.e. I don't think
this base series needs to be held up for fancier migration handling, it's a clear
improvement over blasting WBINVD to all CPUs.

> +	 *
> +	 * Thus we just keep stale pCPU numbers in the mask if vCPU
> +	 * migration happens.
> +	 */

This can be conditioned on vcpu->wants_to_run, so that loading a vCPU outside of
KVM_RUN doesn't trigger WBINVD.

> +	cpumask_set_cpu(cpu, sev_get_wbinvd_dirty_mask(vcpu->kvm));
> +}
> +
> +static void sev_do_wbinvd(struct kvm *kvm)
> +{
> +	struct cpumask *dirty_mask = sev_get_wbinvd_dirty_mask(kvm);
> +
> +	/*
> +	 * Although dirty_mask is not maintained perfectly and may lead
> +	 * to wbinvd on physical CPUs that are not running a SEV guest,
> +	 * it's still better than wbinvd_on_all_cpus().

This belongs in the changelog not as a comment.  This would be a good spot to add
the:

	/*
	 * TODO: Clear CPUs from the bitmap prior to flushing.  Doing so
	 * requires serializing multiple calls and having CPUs mark themselves
	 * "dirty" if they are currently running a vCPU for the VM.
	 */ 

> +	 */
> +	wbinvd_on_many_cpus(dirty_mask);
> +}
> +
>  static void sev_decommission(unsigned int handle)
>  {
>  	struct sev_data_decommission decommission;
> @@ -265,6 +301,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	ret = sev_platform_init(&argp->error);
>  	if (ret)
>  		goto e_free;
> +	if (!zalloc_cpumask_var(&sev->wbinvd_dirty_mask, GFP_KERNEL_ACCOUNT))
> +		goto e_free;
> +
>  
>  	INIT_LIST_HEAD(&sev->regions_list);
>  	INIT_LIST_HEAD(&sev->mirror_vms);
> @@ -2048,7 +2087,7 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
>  	 * releasing the pages back to the system for use. CLFLUSH will
>  	 * not do this, so issue a WBINVD.
>  	 */
> -	wbinvd_on_all_cpus();
> +	sev_do_wbinvd(kvm);

Hmm, I am not convinced that optimizing sev_mem_enc_unregister_region() is worth
doing.  Nothing here prevents a vCPU from racing with unregistering the region.
That said, this path isn't exactly safe as it is, because KVM essentially relies
on userspace to do the right thing.  And userspace can only corrupt itself,
because the memory hasn't actually been freed, just unpinned.  If userspace hasn't
ensured the guest can't access the memory, it's already hosed, so I supposed we
might as well, because why not.

All the other paths in KVM ensure vCPUs don't have access to the relevent regions,
*before* doing WBINVD.

>  	__unregister_enc_region_locked(kvm, region);
>  
> @@ -2152,7 +2191,7 @@ void sev_vm_destroy(struct kvm *kvm)
>  	 * releasing the pages back to the system for use. CLFLUSH will
>  	 * not do this, so issue a WBINVD.
>  	 */
> -	wbinvd_on_all_cpus();
> +	sev_do_wbinvd(kvm);

I am 99% certain this wbinvd_on_all_cpus() can simply be dropped.  sev_vm_destroy()
is called after KVM's mmu_notifier has been unregistered, which means it's called
after kvm_mmu_notifier_release() => kvm_arch_guest_memory_reclaimed().

>  	/*
>  	 * if userspace was terminated before unregistering the memory regions
> @@ -2168,6 +2207,7 @@ void sev_vm_destroy(struct kvm *kvm)
>  
>  	sev_unbind_asid(kvm, sev->handle);
>  	sev_asid_free(sev);
> +	free_cpumask_var(sev->wbinvd_dirty_mask);
>  }
>  
>  void __init sev_set_cpu_caps(void)
> @@ -2343,7 +2383,7 @@ static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va)

Similar to sev_vm_destroy(), I'm quite certain sev_flush_encrypted_page() is
completely superfluous.  It's used only by sev_free_vcpu(), and sev_free_vcpu()
is called after kvm_mmu_notifier_release().  sev_free_vcpu() is also called when
vCPU creation fails, but the vCPU can't have entered the guest in that case, not
to mention its VMSA can't have been encrypted.

So I think we can delete this one too.

>  	return;
>  
>  do_wbinvd:
> -	wbinvd_on_all_cpus();
> +	sev_do_wbinvd(vcpu->kvm);
>  }
>  
>  void sev_guest_memory_reclaimed(struct kvm *kvm)
> @@ -2351,7 +2391,7 @@ void sev_guest_memory_reclaimed(struct kvm *kvm)
>  	if (!sev_guest(kvm))
>  		return;
>  
> -	wbinvd_on_all_cpus();
> +	sev_do_wbinvd(kvm);
>  }
>  
>  void sev_free_vcpu(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e90b429c8..6ec118df3 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1560,6 +1560,8 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  	}
>  	if (kvm_vcpu_apicv_active(vcpu))
>  		avic_vcpu_load(vcpu, cpu);
> +	if (sev_guest(vcpu->kvm))
> +		sev_vcpu_load(vcpu, cpu);
>  }
>  
>  static void svm_vcpu_put(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 8ef95139c..dfb889c91 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -90,6 +90,9 @@ struct kvm_sev_info {
>  	struct list_head mirror_entry; /* Use as a list entry of mirrors */
>  	struct misc_cg *misc_cg; /* For misc cgroup accounting */
>  	atomic_t migration_in_progress;
> +
> +    /* CPUs invoked VMRUN should do wbinvd after guest memory is reclaimed */
> +	struct cpumask *wbinvd_dirty_mask;
>  };
>  
>  struct kvm_svm {
> @@ -694,6 +697,7 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm);
>  void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
>  void sev_es_prepare_switch_to_guest(struct sev_es_save_area *hostsa);
>  void sev_es_unmap_ghcb(struct vcpu_svm *svm);
> +void sev_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
>  
>  /* vmenter.S */
>  
> -- 
> 2.34.1
> 

