Return-Path: <linux-kernel+bounces-439760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C049EB3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DF1164585
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C411B21A0;
	Tue, 10 Dec 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HP5um6DW"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649EB1A2C0B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841712; cv=none; b=HLHUsqqXUoEEP73MjVk+8yvf9bJF63vZFa4+TQZ9OEnFAoIqbC0Xbh5ZChuxPEWTSA1VT0cv855oSdt9ygTgBzwmLuhkgcThMIVRiZsS9yRulv5jaaj3CmGU27rumP3yV3XeGCC20H3BWwiRZdtgw3DCJl9d2iauP6rFoj9H8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841712; c=relaxed/simple;
	bh=AcrbO+SuNtKLVmDZhBaiYjMz2KfvE/P3okFUvZ7PtwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOEq0aQ2ewX1HVej2HdxAabXlfpz9Pod524jXyM+D0sWTnaHkATso4S1FXjLLDGL7tEqpbJ0zyVHRYeVqBTy5g2B8jQWhIaFEw97hJzQF7qrRBfjU3BZpCap8VMGKHoYTBljzGts/YUBbj3a6zHDEK4aXsC+K+q0JWCstF/lGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HP5um6DW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso38505e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733841709; x=1734446509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5fIIWMp7qjjozw0r8pKMUPB5DziYW5td3dF2oKjVLsg=;
        b=HP5um6DWzOMY+gT9SRzzbHvPaWK3nrrwDYN87x327LBmZjzE+RsgB0VrIYmtG8qUoq
         gdoUcbvG98B3KXefYUX1M3+uply1xHQomSjlkk3MerLk6Wduootnxas0FWcsxxWoD+wR
         9U73u3j/0Wd1Ae7v+nKmHSc8tfzvQRfMYr5iscEpjvqbqcWVCehhlQEP6QYendXyxGIJ
         EbfpUiRWpbPiqmAba/NifOWmdWaDc2fQywFerIbaOWSF17j4biGuTasL/za5ZSAZH0tG
         BSF7KvnZV24iL4fSex6IXF2wEG/6gy7+BsFjU64BnR2SYJJjzB2/uss4VWZHZcIQzP9x
         nebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841709; x=1734446509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fIIWMp7qjjozw0r8pKMUPB5DziYW5td3dF2oKjVLsg=;
        b=IDfFgzufU9tlJcInv9UaWqghMXX4qkiAFHvvQY7NG5x/WNFmX6LD39GuEJJCtDRFLa
         Ju5uVGed4lOsxRhEBfbUhP5MbaXG4NTTtflejWsftIMs5zaIqOhvVsN9XGtHoyblRTA0
         +uRPDoMR3z3Tasv5xKbRyRQ4u4R6jU+EAoxtoWPRkbS9hqmbA/sHNHqbZ82oNIBr1Eu/
         gHRMDL9M4k9Tw2WIQAcRiUUZdwpr5J8Yr90CtQatCcLOGFZo2rymin+x3beGpTnYaRAI
         rPH9UHa/TzSSBRqPuQfkbNbaRgXG8Xf++gHXy8RTHVi6soNDKDZp3AkrGmdw3Brqsf61
         ZCQw==
X-Forwarded-Encrypted: i=1; AJvYcCUxVwPTFLiCpp4n2GpFPQxMbcE93NfDzNGOObAWX1DBhvs9P4JizF9MigxJZ/uXtH/duK30PrqPrGrEfTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/W4Uf7WN/l8DX4Ybfd6GyYPtH5iED6a0JcN/YENSVfu6JcS4
	dMJGieiN3OY+0lEvNdAPAl7eVTqepBoCMGA0aoD2MGZzKhOzrBrHJNBUOol2dkFxqgPykle130W
	XvP6fvFA4w5UQrm8ZnsWeD9Z7RcXVhJnKaerB
X-Gm-Gg: ASbGncs5yIp69T+Wycip33Ynqc8j5uqwDRBf6iBnrczjbM+iQpE+sC9InSyrU99FcDk
	QkSH3HnXG9zm/EqvokCIWnlCsdFeuJ+TLb6q0TxglmQ9+6pVOYVbyuQTkOP/UYkLS
X-Google-Smtp-Source: AGHT+IGt3oMRotBPgAwrwV/rrRSOvtwIdVWe57J7beeBt9bYDDljWajSERju3lMmJnq6Z9ZrG8XVFNSEZ9oxYokNtW0=
X-Received: by 2002:a05:600c:350b:b0:435:921b:3535 with SMTP id
 5b1f17b1804b1-435921b360amr969545e9.3.1733841708454; Tue, 10 Dec 2024
 06:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-12-qperret@google.com>
In-Reply-To: <20241203103735.2267589-12-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 10 Dec 2024 14:41:12 +0000
Message-ID: <CA+EHjTw48LTFt=sKtPwS1rmA=ma6Sj9O-D=17FXoMybqZ7+g5g@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] KVM: arm64: Introduce __pkvm_host_unshare_guest()
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

On Tue, 3 Dec 2024 at 10:38, Quentin Perret <qperret@google.com> wrote:
>
> In preparation for letting the host unmap pages from non-protected
> guests, introduce a new hypercall implementing the host-unshare-guest
> transition.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/pkvm.h        |  5 ++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 24 +++++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 67 +++++++++++++++++++
>  5 files changed, 98 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 449337f5b2a3..0b6c4d325134 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -66,6 +66,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
>         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
>         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
>         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index a7976e50f556..e528a42ed60e 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -40,6 +40,7 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
>  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
> +int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);

The parameters of share_guest and unshare_guest are quite different. I
think that the unshare makes more sense, that it uses the hyp_vm as
opposed to the hyp_vcpu. Still, I think that one of the two should
change.

>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> index be52c5b15e21..5dfc9ece9aa5 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> @@ -64,6 +64,11 @@ static inline bool pkvm_hyp_vcpu_is_protected(struct pkvm_hyp_vcpu *hyp_vcpu)
>         return vcpu_is_protected(&hyp_vcpu->vcpu);
>  }
>
> +static inline bool pkvm_hyp_vm_is_protected(struct pkvm_hyp_vm *hyp_vm)
> +{
> +       return kvm_vm_is_protected(&hyp_vm->kvm);
> +}
> +
>  void pkvm_hyp_vm_table_init(void *tbl);
>
>  int __pkvm_init_vm(struct kvm *host_kvm, unsigned long vm_hva,
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index d659462fbf5d..04a9053ae1d5 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -244,6 +244,29 @@ static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
>         cpu_reg(host_ctxt, 1) =  ret;
>  }
>
> +static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
> +{
> +       DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
> +       DECLARE_REG(u64, gfn, host_ctxt, 2);
> +       struct pkvm_hyp_vm *hyp_vm;
> +       int ret = -EINVAL;
> +
> +       if (!is_protected_kvm_enabled())
> +               goto out;
> +
> +       hyp_vm = get_pkvm_hyp_vm(handle);
> +       if (!hyp_vm)
> +               goto out;
> +       if (pkvm_hyp_vm_is_protected(hyp_vm))
> +               goto put_hyp_vm;

bikeshedding: is -EINVAL the best return value, or might -EPERM be
better if the VM is protected?

> +
> +       ret = __pkvm_host_unshare_guest(gfn, hyp_vm);
> +put_hyp_vm:
> +       put_pkvm_hyp_vm(hyp_vm);
> +out:
> +       cpu_reg(host_ctxt, 1) =  ret;
> +}
> +
>  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> @@ -454,6 +477,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_host_share_hyp),
>         HANDLE_FUNC(__pkvm_host_unshare_hyp),
>         HANDLE_FUNC(__pkvm_host_share_guest),
> +       HANDLE_FUNC(__pkvm_host_unshare_guest),
>         HANDLE_FUNC(__kvm_adjust_pc),
>         HANDLE_FUNC(__kvm_vcpu_run),
>         HANDLE_FUNC(__kvm_flush_vm_context),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index a69d7212b64c..aa27a3e42e5e 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1413,3 +1413,70 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
>
>         return ret;
>  }
> +
> +static int __check_host_unshare_guest(struct pkvm_hyp_vm *vm, u64 *__phys, u64 ipa)

nit: sometimes (in this and other patches) you use vm to refer to
pkvm_hyp_vm, and other times you use hyp_vm. Makes grepping/searching
a bit more tricky.

Cheers,
/fuad


> +{
> +       enum pkvm_page_state state;
> +       struct hyp_page *page;
> +       kvm_pte_t pte;
> +       u64 phys;
> +       s8 level;
> +       int ret;
> +
> +       ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level);
> +       if (ret)
> +               return ret;
> +       if (level != KVM_PGTABLE_LAST_LEVEL)
> +               return -E2BIG;
> +       if (!kvm_pte_valid(pte))
> +               return -ENOENT;
> +
> +       state = guest_get_page_state(pte, ipa);
> +       if (state != PKVM_PAGE_SHARED_BORROWED)
> +               return -EPERM;
> +
> +       phys = kvm_pte_to_phys(pte);
> +       ret = range_is_allowed_memory(phys, phys + PAGE_SIZE);
> +       if (WARN_ON(ret))
> +               return ret;
> +
> +       page = hyp_phys_to_page(phys);
> +       if (page->host_state != PKVM_PAGE_SHARED_OWNED)
> +               return -EPERM;
> +       if (WARN_ON(!page->host_share_guest_count))
> +               return -EINVAL;
> +
> +       *__phys = phys;
> +
> +       return 0;
> +}
> +
> +int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm)
> +{
> +       u64 ipa = hyp_pfn_to_phys(gfn);
> +       struct hyp_page *page;
> +       u64 phys;
> +       int ret;
> +
> +       host_lock_component();
> +       guest_lock_component(hyp_vm);
> +
> +       ret = __check_host_unshare_guest(hyp_vm, &phys, ipa);
> +       if (ret)
> +               goto unlock;
> +
> +       ret = kvm_pgtable_stage2_unmap(&hyp_vm->pgt, ipa, PAGE_SIZE);
> +       if (ret)
> +               goto unlock;
> +
> +       page = hyp_phys_to_page(phys);
> +       page->host_share_guest_count--;
> +       if (!page->host_share_guest_count)
> +               WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_OWNED));
> +
> +unlock:
> +       guest_unlock_component(hyp_vm);
> +       host_unlock_component();
> +
> +       return ret;
> +}
> --
> 2.47.0.338.g60cca15819-goog
>

