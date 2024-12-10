Return-Path: <linux-kernel+bounces-439883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BB49EB56B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C60F18889DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FDA22FDFB;
	Tue, 10 Dec 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHeT+fVV"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6BA1D79B1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845994; cv=none; b=nIP1aA5RLKdDLlSR9rlN176j4bg1Ykscg1hvda4MfbXRUhsOogATPwZ6OrgDNPF7UJC+3RNu/54GlZkaWlcdoVCfCYLfHm2CMclLCyjoNNpDZODK+YI+/oKB1t0RN5TcVtvl0tkLofYFTG5+oMigK/E05QqcnBMTFpmsPUU6fS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845994; c=relaxed/simple;
	bh=DoYU+/30Dl80dHlEG4u8YeUUqKxsd0Ltv+sgf4U6hi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSIo3i16mJA470zE9bSFULU27tAJFV+VTA0jigIN42kRPAiu3D7DshRRjtmMnCCkjwafwXdJAO3PmzoQ7u1dFRNK+rbQrRRYMtW1f11Rs2Oab8JmfQbKF0D3W5ecokJ71fu8gKO9LR+r4MEOVwjU+SN2J2iJk0fcQ0dTPE1XWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KHeT+fVV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa629402b53so823630166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733845991; x=1734450791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWy1Pa9nuA7AiL8qsyDKeneupXk75MtK5+CUxS4BYrw=;
        b=KHeT+fVV5fbNrPPgaxLWPZ9/GqGB2UO6/S70rnH1dZThJuInhn8JrjWp8ZMGrYqdmV
         H8x6oIKcuGjPLVQFlFd+7Tpz1Yp5xZQlkkC7nC6JD9O5WS5N8T3OLE2w5ZpntN7LQvTx
         zPYwAY1r9gisQqFV5veDrtAjJHQVTLjCfC+YgbPSUiiGRCZxy0OKcA8usttD6/7P8xuF
         7WUnj78jxeZG1oDXDhSnJUVC/3ksms/1/F17+H9UWa+iXhIgne/l31fpFIO9MLTWj3iu
         5/Lj+ENTsKJnPFRBpcWrEJQZHfZQFtBgsZLIs07WNOcK2Bvm0uxslm25/wBczvYIMGVT
         fE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733845991; x=1734450791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWy1Pa9nuA7AiL8qsyDKeneupXk75MtK5+CUxS4BYrw=;
        b=C5ywXaKlrBxvUQw80rCiOwLI+VREUvxHucY726zWeEf1RiOEEUwK781ZrvsiMly1pA
         MGlDEFAj1MZC+T2v+GWGUlHQwB33OfMbpjfqKcWC9b3qtrEnhPgOHJ05w/G9eqiydrhn
         r0y+XI0DgLfZXjdzHL9YsWy/9wwgph7cZolej0FLz7EInsnmQsnJkmhoGcK5iJlmCyH/
         W6FZqQdxkwYqIv7D78l9O/lbWn/Grq5NVr5U5tTN0OlCFhCqDsIMdpzrHyrjEM6GpTjI
         GyE5J7J3op3sIwg+Ep8EQpZnRp0EDB1UDs0fhTjKb1tde4CCYnJmZXHQmPukhpnXpzfQ
         l2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+RUDJIh4I+h0Bu8Q6UrwtUN0ADwvYENcn/SG/jJPbmxzaG6NG18k+GO9YjJL51AncsPmG8M20Ar1vlTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWqt3JuNfBWJ/m/iV+TmC05FDzJfRVFfmdp12ZNR77+i7Lxiw
	B+szlJXBvwCUGUd32Os4PwOi0plXBCqwPClr1L4d+j0ZXD/hfmgNpeVyqj4ulw==
X-Gm-Gg: ASbGncuAeVOeZRpcu21wll3DQ1ywku2sacmN7iR84bWby3Tl2mytcjEEmo8UenFcaNF
	FC1Bw4cLM7Z4hEaECOv8rrLJ1+7lBfHyRUj/R5j5XhBYYpJQu0fnoOp9+yA5mowL6sJyQYF0CGE
	5qcFr5Q1LXDvFGcon76w22J4o+zsD1eQpVepZcEBYBq7cbsLMj6MJTBSnOrO7cDGyb+hGHxlGiq
	ugnXwLgSAIUddE3UzG/+wHQokPQ9taH4wKi/s2dNex9YWtTWJsr2TblTI9oO3NoFAMgs2B20GyH
	vRSFMLd1pGAL
X-Google-Smtp-Source: AGHT+IG6JHUPlW3rcHBlRIG3t67TyzudRZKBnkckHVRtpZ1PqYkjmD3fqr05U2jXp4GfVM3FXANs5w==
X-Received: by 2002:a17:907:2cd6:b0:aa6:93c4:c68b with SMTP id a640c23a62f3a-aa693c4d1f0mr681822066b.32.1733845990797;
        Tue, 10 Dec 2024 07:53:10 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa686af6709sm341781366b.88.2024.12.10.07.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:53:10 -0800 (PST)
Date: Tue, 10 Dec 2024 15:53:07 +0000
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
Subject: Re: [PATCH v2 11/18] KVM: arm64: Introduce
 __pkvm_host_unshare_guest()
Message-ID: <Z1hj49tuma2zZ1zv@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-12-qperret@google.com>
 <CA+EHjTw48LTFt=sKtPwS1rmA=ma6Sj9O-D=17FXoMybqZ7+g5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTw48LTFt=sKtPwS1rmA=ma6Sj9O-D=17FXoMybqZ7+g5g@mail.gmail.com>

On Tuesday 10 Dec 2024 at 14:41:12 (+0000), Fuad Tabba wrote:
> Hi Quentin,
> 
> On Tue, 3 Dec 2024 at 10:38, Quentin Perret <qperret@google.com> wrote:
> >
> > In preparation for letting the host unmap pages from non-protected
> > guests, introduce a new hypercall implementing the host-unshare-guest
> > transition.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_asm.h              |  1 +
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
> >  arch/arm64/kvm/hyp/include/nvhe/pkvm.h        |  5 ++
> >  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 24 +++++++
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 67 +++++++++++++++++++
> >  5 files changed, 98 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index 449337f5b2a3..0b6c4d325134 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -66,6 +66,7 @@ enum __kvm_host_smccc_func {
> >         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
> >         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
> >         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
> > +       __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
> >         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
> >         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
> >         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index a7976e50f556..e528a42ed60e 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -40,6 +40,7 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
> > +int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
> 
> The parameters of share_guest and unshare_guest are quite different. I
> think that the unshare makes more sense, that it uses the hyp_vm as
> opposed to the hyp_vcpu. Still, I think that one of the two should
> change.

Hmm, so that is actually a bit difficult. __pkvm_host_share_guest() is
guaranteed to always be called when a vCPU is loaded, and it needs to
use the per-vCPU memcache so we can't just give it the pkvm_hyp_vm as
is.

And on the other hand, __pkvm_host_unshare_guest() can end up being
called from MMU notifier where no vCPU is loaded, so it's not clear
which vCPU it should be using. We also just don't need to access
per-vCPU data-structures on that path (the unmap call can only free
page-table pages, which are always put back into the per-guest pool
directly, not in a memcache).

> >  bool addr_is_memory(phys_addr_t phys);
> >  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> > index be52c5b15e21..5dfc9ece9aa5 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> > @@ -64,6 +64,11 @@ static inline bool pkvm_hyp_vcpu_is_protected(struct pkvm_hyp_vcpu *hyp_vcpu)
> >         return vcpu_is_protected(&hyp_vcpu->vcpu);
> >  }
> >
> > +static inline bool pkvm_hyp_vm_is_protected(struct pkvm_hyp_vm *hyp_vm)
> > +{
> > +       return kvm_vm_is_protected(&hyp_vm->kvm);
> > +}
> > +
> >  void pkvm_hyp_vm_table_init(void *tbl);
> >
> >  int __pkvm_init_vm(struct kvm *host_kvm, unsigned long vm_hva,
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > index d659462fbf5d..04a9053ae1d5 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > @@ -244,6 +244,29 @@ static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
> >         cpu_reg(host_ctxt, 1) =  ret;
> >  }
> >
> > +static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
> > +{
> > +       DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
> > +       DECLARE_REG(u64, gfn, host_ctxt, 2);
> > +       struct pkvm_hyp_vm *hyp_vm;
> > +       int ret = -EINVAL;
> > +
> > +       if (!is_protected_kvm_enabled())
> > +               goto out;
> > +
> > +       hyp_vm = get_pkvm_hyp_vm(handle);
> > +       if (!hyp_vm)
> > +               goto out;
> > +       if (pkvm_hyp_vm_is_protected(hyp_vm))
> > +               goto put_hyp_vm;
> 
> bikeshedding: is -EINVAL the best return value, or might -EPERM be
> better if the VM is protected?

-EINVAL makes the code marginally simpler, especially given that we have
this pattern all across hyp-main.c, so I have a minor personal
preference for keeping it as-is, but no strong opinion really. This
really shouldn't ever hit at run-time, modulo major bugs or a malicious
host, so probably not a huge deal if EINVAL isn't particularly accurate.

> > +
> > +       ret = __pkvm_host_unshare_guest(gfn, hyp_vm);
> > +put_hyp_vm:
> > +       put_pkvm_hyp_vm(hyp_vm);
> > +out:
> > +       cpu_reg(host_ctxt, 1) =  ret;
> > +}
> > +
> >  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
> >  {
> >         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> > @@ -454,6 +477,7 @@ static const hcall_t host_hcall[] = {
> >         HANDLE_FUNC(__pkvm_host_share_hyp),
> >         HANDLE_FUNC(__pkvm_host_unshare_hyp),
> >         HANDLE_FUNC(__pkvm_host_share_guest),
> > +       HANDLE_FUNC(__pkvm_host_unshare_guest),
> >         HANDLE_FUNC(__kvm_adjust_pc),
> >         HANDLE_FUNC(__kvm_vcpu_run),
> >         HANDLE_FUNC(__kvm_flush_vm_context),
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index a69d7212b64c..aa27a3e42e5e 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -1413,3 +1413,70 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
> >
> >         return ret;
> >  }
> > +
> > +static int __check_host_unshare_guest(struct pkvm_hyp_vm *vm, u64 *__phys, u64 ipa)
> 
> nit: sometimes (in this and other patches) you use vm to refer to
> pkvm_hyp_vm, and other times you use hyp_vm. Makes grepping/searching
> a bit more tricky.

Ack, I'll do a pass on the series to improve the consistency.

> > +{
> > +       enum pkvm_page_state state;
> > +       struct hyp_page *page;
> > +       kvm_pte_t pte;
> > +       u64 phys;
> > +       s8 level;
> > +       int ret;
> > +
> > +       ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level);
> > +       if (ret)
> > +               return ret;
> > +       if (level != KVM_PGTABLE_LAST_LEVEL)
> > +               return -E2BIG;
> > +       if (!kvm_pte_valid(pte))
> > +               return -ENOENT;
> > +
> > +       state = guest_get_page_state(pte, ipa);
> > +       if (state != PKVM_PAGE_SHARED_BORROWED)
> > +               return -EPERM;
> > +
> > +       phys = kvm_pte_to_phys(pte);
> > +       ret = range_is_allowed_memory(phys, phys + PAGE_SIZE);
> > +       if (WARN_ON(ret))
> > +               return ret;
> > +
> > +       page = hyp_phys_to_page(phys);
> > +       if (page->host_state != PKVM_PAGE_SHARED_OWNED)
> > +               return -EPERM;
> > +       if (WARN_ON(!page->host_share_guest_count))
> > +               return -EINVAL;
> > +
> > +       *__phys = phys;
> > +
> > +       return 0;
> > +}
> > +
> > +int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm)
> > +{
> > +       u64 ipa = hyp_pfn_to_phys(gfn);
> > +       struct hyp_page *page;
> > +       u64 phys;
> > +       int ret;
> > +
> > +       host_lock_component();
> > +       guest_lock_component(hyp_vm);
> > +
> > +       ret = __check_host_unshare_guest(hyp_vm, &phys, ipa);
> > +       if (ret)
> > +               goto unlock;
> > +
> > +       ret = kvm_pgtable_stage2_unmap(&hyp_vm->pgt, ipa, PAGE_SIZE);
> > +       if (ret)
> > +               goto unlock;
> > +
> > +       page = hyp_phys_to_page(phys);
> > +       page->host_share_guest_count--;
> > +       if (!page->host_share_guest_count)
> > +               WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_OWNED));
> > +
> > +unlock:
> > +       guest_unlock_component(hyp_vm);
> > +       host_unlock_component();
> > +
> > +       return ret;
> > +}
> > --
> > 2.47.0.338.g60cca15819-goog
> >

