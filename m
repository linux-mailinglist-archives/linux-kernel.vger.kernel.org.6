Return-Path: <linux-kernel+bounces-441015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06DA9EC7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DDE188B420
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A31F2387;
	Wed, 11 Dec 2024 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2312hhyJ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298B1F2372
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907451; cv=none; b=e9AyzDjug9ZSFpiueDB3/m7SC3xvpKNd1iepjbWsXIQNIO6oe41MiCGbHAR94QU6MOt8/xTINN65iEF9B6oTxlB9ge+uXN177AKV5E0CQD9gke//090LeAewaNq+cylaerotCohPwFrzoe4StOdNnGUmE7zA/+F5h9rUIWPsoJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907451; c=relaxed/simple;
	bh=hTO47TjEz8YkQDlnU4yWl4tccFrgvSrN+zoOledAG2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4XyNaDIJfVo2Kd6guZ79XITaaY0gsLIolDjmCKvl6vVocV2fwRZ7EceiKyE6t76GY8myXnBFU5Qu1asRWYQrE4ebgkmFoeTnaGbTVjJanNMF5XN/+Vd/m8BC0Vw8rgmTKQxag++ATds/rIbF8jstW9/K2x9Mc9Y8dPQoz9lJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2312hhyJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ec267b879so1266783566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733907448; x=1734512248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oo3menW0cQpST6JzATpIJfUIQbPsEjgJ47y7gQ4Tejs=;
        b=2312hhyJexL0OzCImrfS+sWkT3aHPSwbyQ0rW/HgR6I7WVd4q9/c9Ue1adrV3aJyJU
         6cVZeMs6bFm1inteEix/KXU0S5iT/442u4+AkWC2FO4Q67WjG0kCboj+DDaBxTf1qQsn
         sJdbnq8kh0QhFs4BVEc0wwdCt0/8YDTKbkxpkz7f+MrFaQJVF2wiubzU8wF+fkz+VuID
         MdslbHMXaZYrkggYfwlkqYo/nXwTa1P0Ls7obivw7l0zr+VSHwq/iURTN9jFfm6W2/c0
         QrqfbYkIgBL6jrppFA283+Qcg2OVUmM0KptlRS1TmtAxoGJC6W5OdAwBbPHwnvGDZ6VZ
         NqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733907448; x=1734512248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo3menW0cQpST6JzATpIJfUIQbPsEjgJ47y7gQ4Tejs=;
        b=pRLlgWzGafe/WHfUVUvHIB4UAmKyLTyQXQ9JmmvSKcphjmPG1Dk5B5hDTz4m+hb4TZ
         995T7EwqH01pKPjWUUjArpltRQmCwd2aarKFX5zHQrlAAAdPR4S3yV9bVMgd7WGiKoST
         KK/OtMeUBPeeRHswC4ItsESAj5mAIL2XVu1y/nS6k7Bd9h/fF+/wb3I04hC5p9QyFj/q
         LyuetAe+I51o72B/dB4/d8xJ6Q/Tuh5JiySEEDcMh0rTx271kKGFzKMMcUzdTo3vU30D
         SkxeH+CAquQ8+uLQ9OQgQV2UWe0E4qzH0pONctTEoQxA2n1aJ49p2O7v3dGBye4g7r8M
         1ZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrVf8JqoYOrzMU7QK/nb80+P9568XQu8H//yw/EYzjasyplPaafJBbJ9QLxTtnxRB6cOJKNcJ56/i5ltU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tVW0eQCUKwi1VNncPJLBOw9/QjS6wf8hEut2EGL1/1LAMJq1
	SUZzy12AMQU9tvYa0CpHi1zAZaUJsdi7MZ6ZGHs+xSLvLnHpMySPUS9jE6aaWA==
X-Gm-Gg: ASbGncvYgpvi7D2KoUHMxpvEBsr2WEjXRA0NxGvDrAMIf/vVeM9xCLm+ocCllViYUtn
	bYcIPI5KiyA5x/TxTfj0KoJhInqoF1B/cWsJ4b5gLsbSafygPijUX1/c3SsQdzTuEHkjwd9K8fQ
	qPvhZ7cm2CnllPH4OFU3ctJJ6POkSzPy5hkQv9ynZJ6FYGS/EH+Oy1gOGJ5xjigkLpx1/B4/Q1b
	zb+3Syjh4hf+iwwkmEr63aUjcnhHFNFdZUU5PxWrZJITLLfL6ZoKZ+JDE4At2VBLPvoGJLU8qKv
	plk82TiV4X/R
X-Google-Smtp-Source: AGHT+IFqR5S7WtoTxZn/dwkqI2hfNcplXWeCmCphFUX2+vkF0OoBPoS7u02WD5rzLiYhib1xK/ZI0g==
X-Received: by 2002:a17:907:6194:b0:aa6:6c08:dc71 with SMTP id a640c23a62f3a-aa6b11d6ba7mr149850466b.23.1733907446424;
        Wed, 11 Dec 2024 00:57:26 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68f4eb962sm383187366b.3.2024.12.11.00.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:57:25 -0800 (PST)
Date: Wed, 11 Dec 2024 08:57:22 +0000
From: Quentin Perret <qperret@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/18] KVM: arm64: Introduce
 __pkvm_host_relax_guest_perms()
Message-ID: <Z1lT8nGwEMqkedQs@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-13-qperret@google.com>
 <CA+EHjTwNgf5fPuWMaPaN4mcdd5y4uydJsXi-zEBatFnbwoaLLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTwNgf5fPuWMaPaN4mcdd5y4uydJsXi-zEBatFnbwoaLLQ@mail.gmail.com>

On Tuesday 10 Dec 2024 at 14:56:05 (+0000), Fuad Tabba wrote:
> Hi Quentin,
> 
> On Tue, 3 Dec 2024 at 10:38, Quentin Perret <qperret@google.com> wrote:
> >
> > Introduce a new hypercall allowing the host to relax the stage-2
> > permissions of mappings in a non-protected guest page-table. It will be
> > used later once we start allowing RO memslots and dirty logging.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_asm.h              |  1 +
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
> >  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 20 ++++++++++++++++
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 23 +++++++++++++++++++
> >  4 files changed, 45 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index 0b6c4d325134..5d51933e44fb 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -67,6 +67,7 @@ enum __kvm_host_smccc_func {
> >         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
> >         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
> >         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
> > +       __KVM_HOST_SMCCC_FUNC___pkvm_host_relax_guest_perms,
> >         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
> >         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
> >         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index e528a42ed60e..db0dd83c2457 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -41,6 +41,7 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
> >  int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
> > +int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
> 
> The parameters are the same as __pkvm_host_share_guest, but in a
> different order. I looked ahead at later patches in the series, and similar
> issues regarding parameter type and ordering, so I won't mention it
> for the later patches.

Ack to this and the other comment below, thanks for the review!

> 
> >  bool addr_is_memory(phys_addr_t phys);
> >  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > index 04a9053ae1d5..60dd56bbd743 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > @@ -267,6 +267,25 @@ static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
> >         cpu_reg(host_ctxt, 1) =  ret;
> >  }
> >
> > +static void handle___pkvm_host_relax_guest_perms(struct kvm_cpu_context *host_ctxt)
> > +{
> > +       DECLARE_REG(u64, gfn, host_ctxt, 1);
> > +       DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 2);
> > +       struct pkvm_hyp_vcpu *hyp_vcpu;
> > +       int ret = -EINVAL;
> > +
> > +       if (!is_protected_kvm_enabled())
> > +               goto out;
> > +
> > +       hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
> > +       if (!hyp_vcpu || pkvm_hyp_vcpu_is_protected(hyp_vcpu))
> > +               goto out;
> > +
> > +       ret = __pkvm_host_relax_guest_perms(gfn, prot, hyp_vcpu);
> > +out:
> > +       cpu_reg(host_ctxt, 1) = ret;
> > +}
> > +
> >  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
> >  {
> >         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> > @@ -478,6 +497,7 @@ static const hcall_t host_hcall[] = {
> >         HANDLE_FUNC(__pkvm_host_unshare_hyp),
> >         HANDLE_FUNC(__pkvm_host_share_guest),
> >         HANDLE_FUNC(__pkvm_host_unshare_guest),
> > +       HANDLE_FUNC(__pkvm_host_relax_guest_perms),
> >         HANDLE_FUNC(__kvm_adjust_pc),
> >         HANDLE_FUNC(__kvm_vcpu_run),
> >         HANDLE_FUNC(__kvm_flush_vm_context),
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index aa27a3e42e5e..d4b28e93e790 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -1480,3 +1480,26 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm)
> >
> >         return ret;
> >  }
> > +
> > +int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu)
> > +{
> > +       struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> > +       u64 ipa = hyp_pfn_to_phys(gfn);
> > +       u64 phys;
> > +       int ret;
> > +
> > +       if ((prot & KVM_PGTABLE_PROT_RWX) != prot)
> > +               return -EPERM;
> 
> Why not
> 
> +       if (prot & ~KVM_PGTABLE_PROT_RWX)
> 
> Simpler and consistent with similar checks in the file (e.g.,
> __pkvm_host_share_guest)
> 
> Cheers,
> /fuad
> 
> 
> > +
> > +       host_lock_component();
> > +       guest_lock_component(vm);
> > +
> > +       ret = __check_host_unshare_guest(vm, &phys, ipa);
> > +       if (!ret)
> > +               ret = kvm_pgtable_stage2_relax_perms(&vm->pgt, ipa, prot, 0);
> > +
> > +       guest_unlock_component(vm);
> > +       host_unlock_component();
> > +
> > +       return ret;
> > +}
> > --
> > 2.47.0.338.g60cca15819-goog
> >

