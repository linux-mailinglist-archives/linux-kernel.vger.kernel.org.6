Return-Path: <linux-kernel+bounces-448875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCA19F46A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B347016450F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3D1DDA36;
	Tue, 17 Dec 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQ/WltW1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4BA192B66
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425878; cv=none; b=HX524cuVzOQlSlQsVpsvN0EjOPwgoUKfC4C7Yy8pX41pkKct6QM0tWp5KQFbCiiHerP+WR0PUO4QuRO2gPmDWhTbAxmclFjGs3FJokgC1QuC03DaWfmy8REZxIrzgQy34aA2QRD1zCkLWwyMaCx0wzzYQjdhxvW0ch1KObGlp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425878; c=relaxed/simple;
	bh=KSNgjhFPDqRZpu7/UdXMTYonkVgq2dG2a6Kv/xslTxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTbSjizdkcxZrFzi2oW3jvn/jqlIGiUEjpPsZMdnWXcGJtW1+6jyUbjsx1Kg/dc6wVs7Sr7UiqXzbj4VUAaYf0AT3g29GMKWWCX+LBoztgSWc9+enotfgxbfF+iqRgWTvej54ptAl0rOqqDdp4vXlGW/iYTGLTFZ643eSPb5yn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQ/WltW1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso39665e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425874; x=1735030674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A9mGOwcKJkPD0/hT208rpyXS4+JWLUF2rILHUVjXzsc=;
        b=uQ/WltW1ZL8NaRDFJuvtIHyQH5n9GslaL6SMHLRQO1y354p/IbbOqTBMPb4us2NTiX
         mF4I1NZR7X5hPvKjEJikBa/gEG5Baksr02wVAGiWfQTGuKnG4tNTuDZBtp3A48T+pKg4
         SE2+Gr5BL9GASa9GEduz/rejsV05AJdnQ4W41vW+orftxHQWAgihpqAPQ7+L8KN5/wKF
         c3QUfbTBFyXad8j2+vlizT3O9Ca0k6tcBxl7/PdhjCtPhzBu0oSL+YgteJXmdDwB4VIZ
         k0RUw48Qr/je8udTiA9elAGXkC4A+wkJ1bC2AKrhuYiycjmvLng4eY7z90IGZPgHQ4Up
         9j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425874; x=1735030674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9mGOwcKJkPD0/hT208rpyXS4+JWLUF2rILHUVjXzsc=;
        b=iUCcGHYxX2IW75C09YpFOMpq80SrdivyjBQm2T0MLThXEh5tSveVOLbK67Ut++GfoZ
         HuBAUyr8Iwi18SZqTpe/syrApAj8IrM1EBGGclRMpxJZghyMJLL+End1BB1XyMIgQruW
         U4CmZuPOTfKJuSMKPYahbnf7VCZeul9/dWR4P+p9QS1ttJh8PQ98qS8tdxl0poGpTWhL
         TEVmU8fVEi33eaixhOSPbZcGkFviOY8U6rFnahAu9OPBLyFh7ltYEiuG0g1pk6zT0ug9
         49eLmVnRMMluUid5anOhaxfXbxFhS8QPJ6HmkTKc780N+sUFKm0knn4JRCGwTsrPa2lL
         mcxg==
X-Forwarded-Encrypted: i=1; AJvYcCVvY0DkgL+H6skF86VJ3eNDEqTBR83HGQuO480t4TlkthaK506NTgQf4J7Hpr2qe+FE1dL6Q/82RadPKd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBIIF1PbYP0rHoonSXKS1UmuRULsExrkM0elZMxRgDiWm/hRe
	lt+5RPDWhTkTxP4ikXmolI4c3K6FBXxys+fm+atDSIvngOrQR5bkA+WLux0meuoDlCBqU3EOYB3
	8Zho6+N4fTJ7l0q5dB4CLyo0uc8zqlLKQBK08
X-Gm-Gg: ASbGncux6+A8k88hJVZKAhFvQdDVuF9cIuFowwKyk+YnE/MisSgqrf3jpqFY5Hsv4mS
	4T4GnceLqu+fn0CgKj8xEmNiwLW4Bw04L0DQDAla+F6Nv3YZV500VAkdqXDc9z8yU6Lk=
X-Google-Smtp-Source: AGHT+IEYjt67uUTelKuWfZAZMUFcRBjP36zX3A1L63lz75C+g/NuQwlwiqMKzdVpK/gkc3nId/dg69M2v0a1+rqPXqA=
X-Received: by 2002:a7b:cd88:0:b0:434:c967:e4b5 with SMTP id
 5b1f17b1804b1-4364ad490dbmr705545e9.1.1734425874443; Tue, 17 Dec 2024
 00:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-13-qperret@google.com>
In-Reply-To: <20241216175803.2716565-13-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:57:17 +0000
Message-ID: <CA+EHjTy-tzmmu0vNCkK_J614FG1QVO79WSfzV78hQRYqGhP7EQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] KVM: arm64: Introduce __pkvm_host_relax_guest_perms()
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
> Introduce a new hypercall allowing the host to relax the stage-2
> permissions of mappings in a non-protected guest page-table. It will be
> used later once we start allowing RO memslots and dirty logging.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 20 ++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 23 +++++++++++++++++++
>  4 files changed, 45 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 0b6c4d325134..66ee8542dcc9 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -67,6 +67,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_host_relax_perms_guest,
>         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
>         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
>         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index e528a42ed60e..a308dcd3b5b8 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -41,6 +41,7 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
>  int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
> +int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
>
>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 3c3a27c985a2..287e4ee93ef2 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -264,6 +264,25 @@ static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
>         cpu_reg(host_ctxt, 1) =  ret;
>  }
>
> +static void handle___pkvm_host_relax_perms_guest(struct kvm_cpu_context *host_ctxt)
> +{
> +       DECLARE_REG(u64, gfn, host_ctxt, 1);
> +       DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 2);
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
> +       ret = __pkvm_host_relax_perms_guest(gfn, hyp_vcpu, prot);
> +out:
> +       cpu_reg(host_ctxt, 1) = ret;
> +}
> +
>  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> @@ -475,6 +494,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_host_unshare_hyp),
>         HANDLE_FUNC(__pkvm_host_share_guest),
>         HANDLE_FUNC(__pkvm_host_unshare_guest),
> +       HANDLE_FUNC(__pkvm_host_relax_perms_guest),
>         HANDLE_FUNC(__kvm_adjust_pc),
>         HANDLE_FUNC(__kvm_vcpu_run),
>         HANDLE_FUNC(__kvm_flush_vm_context),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 30243b7922f1..aa8e0408aebb 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1488,3 +1488,26 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *vm)
>
>         return ret;
>  }
> +
> +int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot)
> +{
> +       struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> +       u64 ipa = hyp_pfn_to_phys(gfn);
> +       u64 phys;
> +       int ret;
> +
> +       if (prot & ~KVM_PGTABLE_PROT_RWX)
> +               return -EINVAL;
> +
> +       host_lock_component();
> +       guest_lock_component(vm);
> +
> +       ret = __check_host_shared_guest(vm, &phys, ipa);
> +       if (!ret)
> +               ret = kvm_pgtable_stage2_relax_perms(&vm->pgt, ipa, prot, 0);
> +
> +       guest_unlock_component(vm);
> +       host_unlock_component();
> +
> +       return ret;
> +}
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

