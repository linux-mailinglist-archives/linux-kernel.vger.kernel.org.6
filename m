Return-Path: <linux-kernel+bounces-439870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B309EB53D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6039C283F09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1472C1BD9C7;
	Tue, 10 Dec 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cne81ElN"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683C1B6D15
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845284; cv=none; b=baCofGfivKvoYe7NJrXMtcIBVyW/2kxsNBHT2Cp0lgmfD/zFetT1feO7AAI3ynSXJL5O4OrG4H5WcMq1aoclTR1RR105fkWxSMOZOiB9UlT0XRXdwcjhWWMhMZyPqz3xt2MejKC9VRLPPLrt0jUYcK8JI/iMJcOBMZ43iT5oXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845284; c=relaxed/simple;
	bh=qd6YKEbWDFCo/YX2GMRPSCiLBqvGl9LxvWTkIEijQeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce34aisECktODjCQouAmW5Ele4u6OLnT/12Ezkp+lLLyztQ/XTpSnTrMb3g3ZrU1GFZVwJtkBsKll8PDwD7QmXcfApRtRRKKucZarRWL50gx9SmAXKs2msL+CxKd9pSdPk+1tCRtoabYil3U+4CCaqHD7mhXfJbFPPJwUeOGZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cne81ElN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so7519575a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733845280; x=1734450080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46JcCD1FU52F31DPGJd2oqCDKaVkpmJWGNJI8dSnpAI=;
        b=cne81ElNoQb2FrsRjLx7dZdCpyzUiroTaHO3Yy2tDkSWhG64Nb2VKvgeyZ5fzrPYER
         9+AiZTI+Ne9C8ac/r7hB4i3ReGqF11SvNVdJdYLC56LeJUOVcsHbQKPPMbolKJ9aG1DJ
         2na+79dYb2NaqBgoy+wQt6DNIEPpYx1NgXCm7LuiQX+NK7oOOhBfT2g0pQXvxi68WogG
         so/tWnLE7J/aIfdvK49sd2ANSm1WeNhMQtdG5aNCD8bYxs7Bh4XlUR7XePiHPqsLKJIu
         iHhAZOSjWlNGY/MeDzJa+Crs+Rj92XyEwp0IxTYnt6L8QcStTETya9WJtZ1XTEHd1aMp
         Nakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733845280; x=1734450080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46JcCD1FU52F31DPGJd2oqCDKaVkpmJWGNJI8dSnpAI=;
        b=n9PgSZAaDh61GfqK5/sg1PLIa9aS8Sc6H9BdP4OMlhhwqAYn2Yi2xmMsbxsPW3rzMs
         Zm7RVx/TSrGNp0ochpCpkMIoerdjSQXrkx/hBFdgazuYQjLyds9diF8NoWuyggg+/NDg
         JkGDFV5Ffa+aP0h067HbWQD+1pjD6R2o2XoEaxMsIKDZM4HXmk1VcFRI6eUgyDv5MFYt
         zSAv4yRSr+uKQZmFFpOvGatFPprKoQ3HLh2KoRokH3g6b6Jno4R9Z4AhEIXi6iRCkiRf
         1xXNlgxiUiI0DLh2XGZimozGaR6GxEhH+2hGiyYW2CQt/y3FZb2LGs62JKygEtThg1v3
         jaJw==
X-Forwarded-Encrypted: i=1; AJvYcCX7K5WPWAEXbhVZ0sLXQmxyWHw+9kGAdUsnQuLpH4yj/RMuSOJBUHZ7LEyfK/60282syZegkwikyBffmcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyuQdmGFxUAkMcyISFbt/LrCxQ9pweUiWUtTAreQS42UR1zElc
	8gVkvohqSDLz+BSKKvz1U6TlIGhD8GTSfEpAcDph52jnCIiKKPszOHf7Fw9Lpg==
X-Gm-Gg: ASbGnctbIDEktIL4tVeFdvEsZN8T3eLmAGWkJphL7qbEllCy0MWaAGn1o7TlcUs3PR/
	79p88DBQRk/B5TZNKPSzVQkgZGuEiOJWXQ8+gC61g67MOYw8xRh0yPTXqucuKYKPq+ip+HYVbQ9
	qjYdOqWximG8ysObb3D2uQMV1QiFfqEkEAkCNZxwyYZb0vPtCug0EfAYrMQKY8b6ZwEeJr01kDM
	Eopn9MywctuCcUMMMBKiacgPG//bZvW2NG5nUuMJeZDP4l+wrAHCngNAuKiEH7BQ3b9cnG6dNkF
	gvz0JvwTI3EE
X-Google-Smtp-Source: AGHT+IFd2fS0c4aNKhVmWqn1O4x50wI/ObkXLOpUBJRXItQq6lrIDoii/Xko+BKKQfRgv1hUzcvzmQ==
X-Received: by 2002:a05:6402:28a6:b0:5d3:ce7f:abee with SMTP id 4fb4d7f45d1cf-5d41861313bmr5127220a12.25.1733845280257;
        Tue, 10 Dec 2024 07:41:20 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3eb7722acsm4349946a12.3.2024.12.10.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:41:19 -0800 (PST)
Date: Tue, 10 Dec 2024 15:41:17 +0000
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
Subject: Re: [PATCH v2 10/18] KVM: arm64: Introduce __pkvm_host_share_guest()
Message-ID: <Z1hhHRdpCZcLs046@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-11-qperret@google.com>
 <CA+EHjTwHSyQ1FJc7axbLNuBxSWpRVE6brb34nO+F59=QRmfQEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTwHSyQ1FJc7axbLNuBxSWpRVE6brb34nO+F59=QRmfQEg@mail.gmail.com>

On Tuesday 10 Dec 2024 at 13:58:42 (+0000), Fuad Tabba wrote:
> Hi Quentin,
> 
> On Tue, 3 Dec 2024 at 10:37, Quentin Perret <qperret@google.com> wrote:
> >
> > In preparation for handling guest stage-2 mappings at EL2, introduce a
> > new pKVM hypercall allowing to share pages with non-protected guests.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_asm.h              |  1 +
> >  arch/arm64/include/asm/kvm_host.h             |  3 +
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
> >  arch/arm64/kvm/hyp/include/nvhe/memory.h      |  2 +
> >  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 34 +++++++++
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 70 +++++++++++++++++++
> >  arch/arm64/kvm/hyp/nvhe/pkvm.c                |  7 ++
> >  7 files changed, 118 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index 89c0fac69551..449337f5b2a3 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -65,6 +65,7 @@ enum __kvm_host_smccc_func {
> >         /* Hypercalls available after pKVM finalisation */
> >         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
> >         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
> > +       __KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
> >         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
> >         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
> >         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index e18e9244d17a..f75988e3515b 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -771,6 +771,9 @@ struct kvm_vcpu_arch {
> >         /* Cache some mmu pages needed inside spinlock regions */
> >         struct kvm_mmu_memory_cache mmu_page_cache;
> >
> > +       /* Pages to be donated to pkvm/EL2 if it runs out */
> 
> Runs out of what? :) I'm being facetious, it's just that the comment
> is a bit unclear.

	/* Pages to top-up the pKVM/EL2 guest pool */

Is that any better?

> > +       struct kvm_hyp_memcache pkvm_memcache;
> > +
> >         /* Virtual SError ESR to restore when HCR_EL2.VSE is set */
> >         u64 vsesr_el2;
> >
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index 25038ac705d8..a7976e50f556 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -39,6 +39,7 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
> >  int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
> > +int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
> >
> >  bool addr_is_memory(phys_addr_t phys);
> >  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > index 08f3a0416d4c..457318215155 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > @@ -47,6 +47,8 @@ struct hyp_page {
> >
> >         /* Host (non-meta) state. Guarded by the host stage-2 lock. */
> >         enum pkvm_page_state host_state : 8;
> > +
> > +       u32 host_share_guest_count;
> >  };
> >
> >  extern u64 __hyp_vmemmap;
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > index 95d78db315b3..d659462fbf5d 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > @@ -211,6 +211,39 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
> >         cpu_reg(host_ctxt, 1) =  ret;
> >  }
> >
> > +static int pkvm_refill_memcache(struct pkvm_hyp_vcpu *hyp_vcpu)
> > +{
> > +       struct kvm_vcpu *host_vcpu = hyp_vcpu->host_vcpu;
> > +
> > +       return refill_memcache(&hyp_vcpu->vcpu.arch.pkvm_memcache,
> > +                              host_vcpu->arch.pkvm_memcache.nr_pages,
> > +                              &host_vcpu->arch.pkvm_memcache);
> > +}
> > +
> > +static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
> > +{
> > +       DECLARE_REG(u64, pfn, host_ctxt, 1);
> > +       DECLARE_REG(u64, gfn, host_ctxt, 2);
> > +       DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
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
> > +       ret = pkvm_refill_memcache(hyp_vcpu);
> > +       if (ret)
> > +               goto out;
> > +
> > +       ret = __pkvm_host_share_guest(pfn, gfn, hyp_vcpu, prot);
> > +out:
> > +       cpu_reg(host_ctxt, 1) =  ret;
> > +}
> > +
> >  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
> >  {
> >         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> > @@ -420,6 +453,7 @@ static const hcall_t host_hcall[] = {
> >
> >         HANDLE_FUNC(__pkvm_host_share_hyp),
> >         HANDLE_FUNC(__pkvm_host_unshare_hyp),
> > +       HANDLE_FUNC(__pkvm_host_share_guest),
> >         HANDLE_FUNC(__kvm_adjust_pc),
> >         HANDLE_FUNC(__kvm_vcpu_run),
> >         HANDLE_FUNC(__kvm_flush_vm_context),
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 1595081c4f6b..a69d7212b64c 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -861,6 +861,27 @@ static int hyp_complete_donation(u64 addr,
> >         return pkvm_create_mappings_locked(start, end, prot);
> >  }
> >
> > +static enum pkvm_page_state guest_get_page_state(kvm_pte_t pte, u64 addr)
> > +{
> > +       if (!kvm_pte_valid(pte))
> > +               return PKVM_NOPAGE;
> > +
> > +       return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
> > +}
> > +
> > +static int __guest_check_page_state_range(struct pkvm_hyp_vcpu *vcpu, u64 addr,
> > +                                         u64 size, enum pkvm_page_state state)
> > +{
> > +       struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> > +       struct check_walk_data d = {
> > +               .desired        = state,
> > +               .get_page_state = guest_get_page_state,
> > +       };
> > +
> > +       hyp_assert_lock_held(&vm->lock);
> > +       return check_page_state_range(&vm->pgt, addr, size, &d);
> > +}
> > +
> >  static int check_share(struct pkvm_mem_share *share)
> >  {
> >         const struct pkvm_mem_transition *tx = &share->tx;
> > @@ -1343,3 +1364,52 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
> >
> >         return ret;
> >  }
> > +
> > +int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
> > +                           enum kvm_pgtable_prot prot)
> > +{
> > +       struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> > +       u64 phys = hyp_pfn_to_phys(pfn);
> > +       u64 ipa = hyp_pfn_to_phys(gfn);
> > +       struct hyp_page *page;
> > +       int ret;
> > +
> > +       if (prot & ~KVM_PGTABLE_PROT_RWX)
> > +               return -EINVAL;
> > +
> > +       ret = range_is_allowed_memory(phys, phys + PAGE_SIZE);
> > +       if (ret)
> > +               return ret;
> > +
> > +       host_lock_component();
> > +       guest_lock_component(vm);
> > +
> > +       ret = __guest_check_page_state_range(vcpu, ipa, PAGE_SIZE, PKVM_NOPAGE);
> > +       if (ret)
> > +               goto unlock;
> > +
> > +       page = hyp_phys_to_page(phys);
> > +       switch (page->host_state) {
> > +       case PKVM_PAGE_OWNED:
> > +               WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_SHARED_OWNED));
> > +               break;
> > +       case PKVM_PAGE_SHARED_OWNED:
> > +               /* Only host to np-guest multi-sharing is tolerated */
> 
> Initially I thought the comment was related to the warning below,
> which confused me.

It actually is about the warning below :-)

> Now I think what you're trying to say is that we'll
> allow the share, and the (unrelated to the comment) warning is to
> ensure that the PKVM_PAGE_SHARED_OWNED is consistent with the share
> count.

So, the only case where the host should ever attempt do use
__pkvm_host_share_guest() on a page that is already shared is for a page
already shared *with an np-guest*. The page->host_share_guest_count being
elevated is the easiest way to check that the page is indeed in that
state, hence the warning.

If for example the host was trying to share with an np-guest a page that
is currently shared with the hypervisor, that check would fail. We can
discuss whether or not we would want to allow it, but for now there is
strictly no need for it so I went with the restrictive option. We can
relax that constraint later if need be.

> I think what you should have here, which would work better with the
> comment, is something like:
> 
>                 /* Only host to np-guest multi-sharing is tolerated */
> +               if (pkvm_hyp_vcpu_is_protected(vcpu))
> +                       return -EPERM;
> 
> That would even make the comment unnecessary.

I would prefer not adding this here, handle___pkvm_host_share_guest() in
hyp-main.c already does that for us.

> 
> > +               WARN_ON(!page->host_share_guest_count);
> > +               break;
> > +       default:
> > +               ret = -EPERM;
> > +               goto unlock;
> > +       }
> > +
> > +       WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
> > +                                      pkvm_mkstate(prot, PKVM_PAGE_SHARED_BORROWED),
> > +                                      &vcpu->vcpu.arch.pkvm_memcache, 0));
> > +       page->host_share_guest_count++;
> > +
> > +unlock:
> > +       guest_unlock_component(vm);
> > +       host_unlock_component();
> > +
> > +       return ret;
> > +}
> > diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > index d5c23449a64c..d6c61a5e7b6e 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > @@ -795,6 +795,13 @@ int __pkvm_teardown_vm(pkvm_handle_t handle)
> >         /* Push the metadata pages to the teardown memcache */
> >         for (idx = 0; idx < hyp_vm->nr_vcpus; ++idx) {
> >                 struct pkvm_hyp_vcpu *hyp_vcpu = hyp_vm->vcpus[idx];
> > +               struct kvm_hyp_memcache *vcpu_mc = &hyp_vcpu->vcpu.arch.pkvm_memcache;
> > +
> > +               while (vcpu_mc->nr_pages) {
> > +                       void *addr = pop_hyp_memcache(vcpu_mc, hyp_phys_to_virt);
> 
> nit: newline
> 
> Cheers,
> /fuad
> 
> 
> 
> > +                       push_hyp_memcache(mc, addr, hyp_virt_to_phys);
> > +                       unmap_donated_memory_noclear(addr, PAGE_SIZE);
> > +               }
> >
> >                 teardown_donated_memory(mc, hyp_vcpu, sizeof(*hyp_vcpu));
> >         }
> > --
> > 2.47.0.338.g60cca15819-goog
> >

