Return-Path: <linux-kernel+bounces-439844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA99EB4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEEF285B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D91BBBCC;
	Tue, 10 Dec 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9TNwePM"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1761BB6A0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844223; cv=none; b=qAckTuuTEfRWS/AuV+uTFwxotFrVzEPNSpj4sGC41Fh9I7OTB+sqwmnmSvGeXzVxxeJArbjSW5/xg4NGzIznWkMxv3mGFeA71tTIsETdpz2yjUk+skBhPy6J4ZFiFykMvvPCnYFe/ytVOmmhBREmyaGHd0H+HrGTlAymluvBuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844223; c=relaxed/simple;
	bh=Rmzl1NvQCsnYvdgeH7kzozFaaGGwMxy9wsWQ5HjV6V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoWGauxAIvrW2cwyyyT92r317J0cCMDxn34eAfTddwRg2RTHW3IgPKBb66rArwdhScg1YDGjMf0JUDRDBCsi8AIHfjFgk8HgQqdgniYBf+BEtnPE0jCC0sVR1wWuN6sPJRMVifpHGi1/dV0vfOQNam5FDtth9tTzqBiq1EDTDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9TNwePM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434fa6bf6e4so44805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733844219; x=1734449019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0FGmDG/56UxrJQSDRbh5h6XtcOYvVsfsQlg9xr0FPYs=;
        b=L9TNwePMgAZSN5qJ95vBOSTmlBr6zG40aIVlE4HymIQHWUMTRn9ycId1YzHLqvgzfZ
         EhP0btwSC8jP1MyoMn9cQuCO/HwNwCCA59DjPHoh8w2xiFZexAUkhQIADujNH3VTMEr5
         9DZqRCLfYiR9bqbuXr2Nu0btGpfcOQHfES90jrWTzx/F0gSs+SRN8rTRsWlwxH2W4G8h
         sFXHCEtWlHCE/Hhu1AMYnhFzR3ge09L1HqtggdVp1qj9zEBs/51mtnONQsjwt1Yk9Mnh
         uvQQ+inNwo7hRxd/J0yavYcYx/lm4EJ37SENExGTEDtfVNphJGLdPnBxjDGz1ea2yYZQ
         3Qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844219; x=1734449019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FGmDG/56UxrJQSDRbh5h6XtcOYvVsfsQlg9xr0FPYs=;
        b=HYp5y05WM++J/H0y04XpyWdrcRkn6HMfmuXNhD2hhoBcsPOfBoTNcmqkKI5OL4G9z3
         yza9D1Fxc9VqkbZ6qcftpM/qRCNEKc8+XA0evEVjtYfoz4DXlAQs1+YMfY3EU0azuzcV
         V1TM9sp8JRFnA8BSrs0mI3M5twpTIhDQI+K4AF5NMLh66AqrtQb1C19A8aLZfMshUpDT
         4vxzPGkEaqPyEZbMVAfmfsomCAIqJ6ztzf705hcLcMV0KfCxmJGrZc+JIt+QUvK12z7d
         aqwVbVlNaBwZ0wl81Od/vyyVwFCq3zksFZHeRC2SsvErTadepDKMDaaxwab/KlK688zx
         CM6A==
X-Forwarded-Encrypted: i=1; AJvYcCXKnIfsn3tJ5eIQ8+UPwtHTJQTxhJpZEkydifY1fxWMwDAJOLaXiY/pzJC43iZRwimzYHseMk4NuOzokHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaCwZC3DvFWAn2T1dfyFb6KYQs73Xh8jrmsWPrr10qsWhaHDf
	iQbsLQq3IVCamAg5jrlVrqAJ0uFnpj4dtK8kBVAHsUqDBm6usXerIIgsV+Xek8sTenwiAstR2iC
	RpOOs3RlE5jI+gVeQJQ7qyQNg4OZCN643zCKC
X-Gm-Gg: ASbGnct+8MS0ZjTiV7nSI3IX9X1S1tmX/fcGozWfEvQCh5d4wR4+kn4c072w4xch3M+
	LwMNWA/0lPbt11SarimSTcq6oynXDxNTg1ki0XHaTXRGiaT5nlGsKjhsE3l/5FOsk
X-Google-Smtp-Source: AGHT+IFj7W2A21RB271zIBxfODIG5QjupA4LpBwsV5eHpgstVb386fYaxm2Qzwdq67LZ1kRn3fUqgoJOaB0IFBrg8ho=
X-Received: by 2002:a05:600c:3b15:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-435027477c0mr1476295e9.2.1733844219282; Tue, 10 Dec 2024
 07:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-17-qperret@google.com>
In-Reply-To: <20241203103735.2267589-17-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 10 Dec 2024 15:23:02 +0000
Message-ID: <CA+EHjTw_e_q5TFkgxvVDKxwj-C5S0Hd1OfVO4_FitrB8_J2Rpw@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] KVM: arm64: Introduce __pkvm_tlb_flush_vmid()
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
> Introduce a new hypercall to flush the TLBs of non-protected guests. The
> host kernel will be responsible for issuing this hypercall after changing
> stage-2 permissions using the __pkvm_host_relax_guest_perms() or
> __pkvm_host_wrprotect_guest() paths. This is left under the host's
> responsibility for performance reasons.
>
> Note however that the TLB maintenance for all *unmap* operations still
> remains entirely under the hypervisor's responsibility for security
> reasons -- an unmapped page may be donated to another entity, so a stale
> TLB entry could be used to leak private data.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h   |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 6178e12a0dbc..df6237d0459c 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -87,6 +87,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
>         __KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
>         __KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_tlb_flush_vmid,
>  };
>
>  #define DECLARE_KVM_VHE_SYM(sym)       extern char sym[]
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index de0012a75827..219d7fb850ec 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -398,6 +398,22 @@ static void handle___kvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
>         __kvm_tlb_flush_vmid(kern_hyp_va(mmu));
>  }
>
> +static void handle___pkvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
> +{
> +       DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
> +       struct pkvm_hyp_vm *hyp_vm;
> +
> +       if (!is_protected_kvm_enabled())
> +               return;
> +
> +       hyp_vm = get_pkvm_hyp_vm(handle);
> +       if (!hyp_vm)
> +               return;
> +
> +       __kvm_tlb_flush_vmid(&hyp_vm->kvm.arch.mmu);
> +       put_pkvm_hyp_vm(hyp_vm);
> +}

Since this is practically the same as kvm_tlb_flush_vmid(), does it
make sense to modify that instead (handle___kvm_tlb_flush_vmid()) to
do the right thing depending on whether pkvm is enabled? Thinking as
well for the future in case we want to support the rest of the
kvm_tlb_flush_vmid_*().

Cheers,
/fuad

> +
>  static void handle___kvm_flush_cpu_context(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_s2_mmu *, mmu, host_ctxt, 1);
> @@ -582,6 +598,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_teardown_vm),
>         HANDLE_FUNC(__pkvm_vcpu_load),
>         HANDLE_FUNC(__pkvm_vcpu_put),
> +       HANDLE_FUNC(__pkvm_tlb_flush_vmid),
>  };
>
>  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> --
> 2.47.0.338.g60cca15819-goog
>

