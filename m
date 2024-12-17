Return-Path: <linux-kernel+bounces-448882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 618719F46C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9825188D0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D4A1DC745;
	Tue, 17 Dec 2024 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xMRlv+YM"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A6335C0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426098; cv=none; b=p5ROLmfD7G1M5HzFIddFzojyVY3epr8R1Bz8kKWZBRSRYlnh9xIvddzHpXiNMPIdu2tgFBY4gyo+hO9CffPP0f+msU3AFuhUN8Aeju8Yb8h0+/geCZXmEdh25/mw+pl2E9dh8fGsq8vyPdrbdtgkXfalQIUWdcme2IvOM2ODH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426098; c=relaxed/simple;
	bh=ZTkuH4/9gDLlJyFVKfPGevHfOfBFDw5yEJuU0XqdH9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeKGRpfwQ54WLH9SKxUn62apQ3OBxm3aqgKdpVIkkIJBhGR+IcdyC1KWski+5yzHFQBAx8HAtvAB/9zHaG4lR1POIS4gNzrZQM4feb8IQgVW/v7D6Snyji5Rby/1/8UzvZEko9a3kqcNsb50jYaosxRbmaAnfI6V/osmLuhnxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xMRlv+YM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43621d2dd4cso39555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734426095; x=1735030895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bpai75X11LMfvePNjrqzhIaWJn/QBSdWg0KnRrx/c7Y=;
        b=xMRlv+YMukwqpeaROoD8So4LyWgPdZknTgdmWMgH8nC499qthUQcKpfXZGWor3Ogue
         5cRFO8WuXn+f8xq/DchvK+HTE5e25m7EAVejMmvOuV5VOQx5OGb/Q06jzs3dwr+fi/LL
         kMDOOZ52neDJqNxYZEjyOLO1L6if8fGPXoM3lgLh8RH4JJh94fmjsEui02EEHAmj2+9Z
         w+OoXCBqlLjwM7NhyJLJpczYI+6mztOU987sJy99rSfHHlFjCFY7Ux4XwbH2dCoN8eOq
         JAl+gAuvEF/jLdAdHCWjuXiRy+ZihutJbc+7NSxEGo+r9YNR79YtF8g7qKWMztkGOFAs
         3mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426095; x=1735030895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bpai75X11LMfvePNjrqzhIaWJn/QBSdWg0KnRrx/c7Y=;
        b=jPyG9Z4IgeTMn6yq/Olbug8DlYIEVWpnjvXEU1otSld644TzR7ZpUmAIRiNiZpnCJ5
         tPrzxsjwX0U822bjGEtg20lMX8e3JNRnW6WIwzEC7DuDV7H4IFhtCcFI5kyxAudA4gNu
         6n1rgqrYLuRZ/9wbcBZ6cxt0MUcB0fkWfa6AdhyLr+Bumo3pJ5IxoZGaX9ke3sm8BsHX
         uXgaijnXzinvFdVSiooiiYxX5LyFeLaJsUfS15jlSgTtPcV6Jqnj9EPFsRQgx2/ARw4b
         WXAi4J79H+HeAWIBgc8YnoIolwNODgzhkrVRM/BEp4OLbXa3gd44EaUswdi1/DYLIXKI
         qM+A==
X-Forwarded-Encrypted: i=1; AJvYcCX8V/nxyhXmjeBgfZvGOSsPDR7YDvhbYKJ4tpXxH+xL1JTRlhXGMLDK/6rat5KVB8YgYArO6iMhOTZQ0Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3z+Gn9tDlNdoFZmpVIjALzA4Oit0SijUY4y6lS45ZoQbc22Ug
	4B25nurpqLJj5CkS6UuR3DkkgCfiDDYybO4fqlPGH25/31lBnQSoFDP9CbSU8zpscJGbebwvHVG
	q9OS07+3lNm2ZfmmgcpjJKKWfSbiJmZ6vFGOI
X-Gm-Gg: ASbGncsUmUQoaX5DDr8RgCJP4yjhzBBUsAZ/g4dDuIxTvlVr1uE4KktmiAk33wfmsgw
	SoPSCjayT5uNbD+9iRXUxvvIG0W5mJZpdWyzXmeeKLyRHJarF8Y22rpohbTgJgO2q9C8=
X-Google-Smtp-Source: AGHT+IEQQFJCYIi7D2fpMZdC3EviO5hPxfEuwAdpwMV205YFizbZuxpptBGEW5SdOPdDWzDZGDlz+zHkfEB6EtA0CpQ=
X-Received: by 2002:a7b:c057:0:b0:436:1868:b29f with SMTP id
 5b1f17b1804b1-436492e7bd8mr1053605e9.6.1734426095446; Tue, 17 Dec 2024
 01:01:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-17-qperret@google.com>
In-Reply-To: <20241216175803.2716565-17-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 09:00:58 +0000
Message-ID: <CA+EHjTw7X5fOY+1yLmGdqYbUDCOVCPfmJf--q8dBj3XLzPicBQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] KVM: arm64: Introduce __pkvm_tlb_flush_vmid()
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

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/include/asm/kvm_asm.h   |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index a3b07db2776c..002088c6e297 100644
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
> index 32c4627b5b5b..130f5f23bcb5 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -389,6 +389,22 @@ static void handle___kvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
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
> +       hyp_vm = get_np_pkvm_hyp_vm(handle);
> +       if (!hyp_vm)
> +               return;
> +
> +       __kvm_tlb_flush_vmid(&hyp_vm->kvm.arch.mmu);
> +       put_pkvm_hyp_vm(hyp_vm);
> +}
> +
>  static void handle___kvm_flush_cpu_context(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_s2_mmu *, mmu, host_ctxt, 1);
> @@ -573,6 +589,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_teardown_vm),
>         HANDLE_FUNC(__pkvm_vcpu_load),
>         HANDLE_FUNC(__pkvm_vcpu_put),
> +       HANDLE_FUNC(__pkvm_tlb_flush_vmid),
>  };
>
>  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

