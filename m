Return-Path: <linux-kernel+bounces-439826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB81A9EB467
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049B91643F9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872051B0F12;
	Tue, 10 Dec 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXelyY43"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB871A76AC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843684; cv=none; b=jkj8EJteu7LRsFRa/2g8RQFCdX5X67KTI/NO8lswmix3LlrV0N1Vk5MAcdUlLD2QzCwe5TqGUo3+ROiq3WMCvCET8ubys5ljhJ/qfoWfbG0rWsZXWIHZzTwXuHUYl/TKRblEJWnNdzf5h90AZpYL25RrSWRf2oMo3vrr1iB8Kks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843684; c=relaxed/simple;
	bh=7zo20DDr3e1Vl7Jg/vFQRSFliSYtKFd3w6KZiwM6lhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkfA/RMuH6XZ4HsTYOD5IiL9UgE/pUCiTZHfzjT0YM16lFidnLflCeIu8bt8yw3kD+SbyQ4Aku2fYOE9Szd9U29blj5Cg2Ac4/7H44QShHXHyi8hpb1lTIzFqZfA0oPUQ04LOJRdMOo4z/UrMYcBIGEUxsUsVRer1+tcEkpgWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXelyY43; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434f150e9b5so44605e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733843680; x=1734448480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aGp4xmxqvFNS4aKzzUdEFGSpZc9CuS65nIZ2CXfL9DI=;
        b=gXelyY43tehNLre03YRIg1RLwCwhGH8QRA3CUWqMpygvLl4BonFop6QE8bU0dpcRm4
         j6KKcsbHQHNNU1M1uGtsMhxD4AwPfdmzkCvzyG0GiItT+mOWfNy7muBekr5VGkoIFh3d
         kmAfbetbq+KDm4EfkcZNPh+fXP2ZH30eKWPDRPg7fw1KlDyY1tnZtZdi4Uif+J5odmR9
         MN79gkHD+w4fSZeo2AMrBsvEv2AVMya2gc5UZAB8DaYaL3P8+Dm4i4xWQHA9MwU3JQzB
         C2vxhsag/hDk/5wZlje5szfUqy73+eLPMhCElIjJi1O2E33SG/JXuNmHTuUXtTnc/42e
         lvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843680; x=1734448480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGp4xmxqvFNS4aKzzUdEFGSpZc9CuS65nIZ2CXfL9DI=;
        b=moh3Ga6DEYiEenq5KRQAXcVXWEmoBiB3xLQhHVzE5gPilHEyhjDwNZRFDTuk+vIkWB
         O3bnBmBw/bHklIpSzorYaYwulj0UOBLHtFMSZRyLD784GrbEXdxuarHNBr/KdPiofP0K
         NvkU8EIrZF/SBk0tb7LdQyx7aOvMKw4CAH+uBYgY2ivQcPTzFfJMIye5/FR4QKCYk+/+
         vYk+c2EsJuYu68PRYk3YMtrgptFrc+hg51fHrDPTG2ZQl5X1olSVUiPNve8eixcEvHtm
         Wccge5ZpeG422nbGOTXHtttVklnOXcTyCXgyaA6S7dKkpD8gm7SBFvQ+oDHyXhFivdhy
         O6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS91bQR7ehmFQC8Kvk6FEYXO5jqOcfKe3cDzsAHXFm/5MRXpQVOidwQrYThIkqAJc6ZCxam5vlPLhGjSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Z1v4WSncaJySKastnCeDoQ/8dpF4LBbVyreoD/0y4l7MJQAR
	fW3Y21qHzyq8+6mvXGtxEwOGHTGKR7HwE5zh5HwBQYcAeGob9K1XjQUs/A5wkiegcLpG+51I5da
	ljdq6NzZ95EaYlrQS2U41/0ZxXSYa7hyzeawq
X-Gm-Gg: ASbGncvcVRxD4IR8t1xFj5IF68AYlUVT9TPnASjiMFPOZuCAvpev10tI6BWJpdIlWuW
	aHxGwVMPFRUJ0RRVS20Mp8y3QX+f2qVxUMxL9BNI31yhbIwXWRYqIQU+qUjZY9VX6
X-Google-Smtp-Source: AGHT+IExtEJYbzPbhtvTj138hbJaUMAGq3rsSDYLbkcmP/S+jYpwTOuL2FE8QW/DEJ3y6pie8o3bjxV+CMjjg3V8Q7Q=
X-Received: by 2002:a05:600c:6b06:b0:434:9e1d:44ef with SMTP id
 5b1f17b1804b1-43539dd9773mr1230565e9.7.1733843680024; Tue, 10 Dec 2024
 07:14:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-16-qperret@google.com>
In-Reply-To: <20241203103735.2267589-16-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 10 Dec 2024 15:14:03 +0000
Message-ID: <CA+EHjTzOjwNyUkS5_zSUiAbiCauLKKgkKU6TM_-+Wsh9A0FdRQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] KVM: arm64: Introduce __pkvm_host_mkyoung_guest()
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
> Plumb the kvm_pgtable_stage2_mkyoung() callback into pKVM for
> non-protected guests. It will be called later from the fault handling
> path.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 19 ++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 20 +++++++++++++++++++
>  4 files changed, 41 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index cb676017d591..6178e12a0dbc 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -70,6 +70,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_relax_guest_perms,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_test_clear_young_guest,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_host_mkyoung_guest,
>         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
>         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
>         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 554ce31882e6..3ae0c3ecff48 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -44,6 +44,7 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>  int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
>  int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>  int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
> +int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu);
>
>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 67cb6e284180..de0012a75827 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -333,6 +333,24 @@ static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *ho
>         cpu_reg(host_ctxt, 1) = ret;
>  }
>
> +static void handle___pkvm_host_mkyoung_guest(struct kvm_cpu_context *host_ctxt)
> +{
> +       DECLARE_REG(u64, gfn, host_ctxt, 1);
> +       struct pkvm_hyp_vcpu *hyp_vcpu;
> +       int ret = -EINVAL;
> +
> +       if (!is_protected_kvm_enabled())
> +               goto out;
> +
> +       hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
> +       if (!hyp_vcpu || pkvm_hyp_vcpu_is_protected(hyp_vcpu))
> +               goto out;
> +
> +       ret = __pkvm_host_mkyoung_guest(gfn, hyp_vcpu);
> +out:
> +       cpu_reg(host_ctxt, 1) =  ret;
> +}
> +
>  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> @@ -547,6 +565,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_host_relax_guest_perms),
>         HANDLE_FUNC(__pkvm_host_wrprotect_guest),
>         HANDLE_FUNC(__pkvm_host_test_clear_young_guest),
> +       HANDLE_FUNC(__pkvm_host_mkyoung_guest),
>         HANDLE_FUNC(__kvm_adjust_pc),
>         HANDLE_FUNC(__kvm_vcpu_run),
>         HANDLE_FUNC(__kvm_flush_vm_context),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 0e064a7ed7c4..7605bd7f80b5 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1541,3 +1541,23 @@ int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *
>
>         return ret;
>  }
> +
> +int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu)
> +{
> +       struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> +       u64 ipa = hyp_pfn_to_phys(gfn);
> +       u64 phys;
> +       int ret;
> +
> +       host_lock_component();
> +       guest_lock_component(vm);
> +
> +       ret = __check_host_unshare_guest(vm, &phys, ipa);

While I'm bikeshedding some more, does the name
__check_host_unshare_guest() make sense? Should it be something like
__check_host_changeperm_guest(), or something along those lines? (feel
free to ignore this :) )

Thanks,
/fuad

> +       if (!ret)
> +               kvm_pgtable_stage2_mkyoung(&vm->pgt, ipa, 0);
> +
> +       guest_unlock_component(vm);
> +       host_unlock_component();
> +
> +       return ret;
> +}
> --
> 2.47.0.338.g60cca15819-goog
>

