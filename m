Return-Path: <linux-kernel+bounces-448881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411EC9F46BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E7216A397
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E21DC745;
	Tue, 17 Dec 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1VmnGZt"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303731805B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426076; cv=none; b=elZsnlRBysGBD5UkxThsL0KRmGjzwxbixa0iBzS+XDX/iGoD32GcgmbURjIv1V3r0RdGva/mtm39aDvQQVyMwFkBruwVx2JhI0Je+z9YxIk/Cmq0e+HK0HOeSK39odmYa/5/u1n2PlvN856iofm+ZhGCuCudiQkrocMfqNrq9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426076; c=relaxed/simple;
	bh=3RenyzS3NONn/LSyfsCTUFB7A3rM0DdKDQDhYTRM9lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U77r+ad4ffDomrpYqlZctXjpjfgdZcedYXfwEHIslIUeOsTMJidQ5ydZHBqQbqnhDZlwOyoYsWAsg1BZnNa1YMB7apXes3F9E8gnFhMOQzRwkQtWWBQTImdU2Z0L1YO5fWy2omt3/7fhT4W7qlAqtv8FlYRFzkd8SbjY7CaPZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1VmnGZt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361d5730caso28135e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734426072; x=1735030872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn36mxEjfO11KqvkRwmiDrEX6J7ZOG8Km82941NlBuM=;
        b=s1VmnGZt6EiA+EU6UvJg0MZ5b3Ltie/AgQX0XqKvu+iLW+tivXDc0mMSzuqBt+Skfc
         6FsN7G7a20+SNz/vQHGphGYbB2KxAzWfF/NwTMqW68iUgsbJksP+HWbLaecr0kBsu8RJ
         kA0SiqXc+ahSAz5O/7+/wOqbP06iXm0dqOkyhKy5fpCz13BY7IvmLekcD7u29PgCwblJ
         4qKyibk4WB7XlQZ8Ktfu5jEkvp5XGsFvofipnnBK/PKjsbzskeu305iWq81ku7QnWjVd
         VetlIHlAf5w0yXjahLOCSl/NB+1dxeWsV30IV4RapVM735MlMYNg14haPCzjE26sNuAU
         r3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426072; x=1735030872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xn36mxEjfO11KqvkRwmiDrEX6J7ZOG8Km82941NlBuM=;
        b=mbWfdvr4XXStIhZsUq0IvB72Q+QxCeR4yy/Ui9tqXM/za9HmATKTfp5FGz0lwCqsIG
         CN5F+q1JwUX9EUd5BkDqgwm1BmS2FF+ihaBRIlpF9HbHeeUpx9dMmgFqaCHBZVD2PtFU
         Tpa6Bql1olHGPPt0QaK+IqXfU1pSD3iMP84SDJBEpPcnrPftWBX0F2TE3NZpY5XJuyEP
         3GFVQHj0FNFMwRa56rlw3BQTY0QwFPLMH0j9qsshAQHziPZXBcgyrIZg9afelEiBrCV6
         aZuEkhxDrzTjWNSY98PSLMCMHTC6Ev99679zryp4U0H5S9KY9IXBXDDvOY2KTJU6SQ98
         NbDA==
X-Forwarded-Encrypted: i=1; AJvYcCUJqWBX0B4WXDwmX97gwdFbUUHVhosryonMs5Z91KMUTiqXgzf1gVQZeWyifB7J+1PnorBk4PWWtg94gHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuwBNMOEShLrzgaCXi10nBzDtGNT5b/17l0zZcDX3d2R29yeQ9
	hlM5ux6XYWPE87TXbs56A/OYG6nFI2Dz6S7lExWOGUKNVTPvvk8wsYr9v2WFTY++gb5F4V44oui
	3F0sELWQ1g8TfaJHuCa9ULw1wcmyTppVBFSuK
X-Gm-Gg: ASbGncvttIL1NnqQXNuu52Gl8K8KiTE419qFpIRs74KhBI3UtoFdkZAy3lyZcrdBxgx
	G7z1mXScAuAutdLLOzlYxXcDL+iWV2jlPbHchZ3diERYSa3scl1Y6U72LjiWaS5085Vg=
X-Google-Smtp-Source: AGHT+IGTMsIK/+fqyiclNvnxiumOrPL+9bRBaA9Q/a+ejFhKcdGovQJz4621GOwlV2PhnNytnWUP3JoeS+CcBPepzUE=
X-Received: by 2002:a05:600c:258:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-4364ad50a2bmr724755e9.5.1734426072395; Tue, 17 Dec 2024
 01:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-16-qperret@google.com>
In-Reply-To: <20241216175803.2716565-16-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 09:00:36 +0000
Message-ID: <CA+EHjTx-2vBMY67Y6hm4U-DFirM93BK-CQOvcnBgYXO75xhmFw@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] KVM: arm64: Introduce __pkvm_host_mkyoung_guest()
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 17:58, Quentin Perret <qperret@google.com> wrote:
>
> Plumb the kvm_pgtable_stage2_mkyoung() callback into pKVM for
> non-protected guests. It will be called later from the fault handling
> path.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 19 ++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 20 +++++++++++++++++++
>  4 files changed, 41 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 4f97155d6323..a3b07db2776c 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -70,6 +70,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_relax_perms_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_test_clear_young_guest,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_host_mkyoung_guest,
>         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
>         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
>         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index b3aaad150b3e..65c34753d86c 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -44,6 +44,7 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>  int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
>  int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>  int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
> +int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu);
>
>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 616e172a9c48..32c4627b5b5b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -324,6 +324,24 @@ static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *ho
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
> @@ -538,6 +556,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_host_relax_perms_guest),
>         HANDLE_FUNC(__pkvm_host_wrprotect_guest),
>         HANDLE_FUNC(__pkvm_host_test_clear_young_guest),
> +       HANDLE_FUNC(__pkvm_host_mkyoung_guest),
>         HANDLE_FUNC(__kvm_adjust_pc),
>         HANDLE_FUNC(__kvm_vcpu_run),
>         HANDLE_FUNC(__kvm_flush_vm_context),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 0e42c3baaf4b..eae03509d371 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1549,3 +1549,23 @@ int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *
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
> +       ret = __check_host_shared_guest(vm, &phys, ipa);
> +       if (!ret)
> +               kvm_pgtable_stage2_mkyoung(&vm->pgt, ipa, 0);
> +
> +       guest_unlock_component(vm);
> +       host_unlock_component();
> +
> +       return ret;
> +}
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

