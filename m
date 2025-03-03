Return-Path: <linux-kernel+bounces-540969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F2A4B70C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EDC16C699
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983791D798E;
	Mon,  3 Mar 2025 03:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GroJ3LdS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C711C860E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740974327; cv=none; b=ZsA/GsLrpCsH7ubB6lbdZQ4ANu7KhJQfr6B1g9Xq/ffnAgwe67UTEEGVZZWNv2j/bfjnYWTIXlV67fIDP+sgyGGJHGle+hGn8h4mOrvWSXXE62gEcwF/I81MoiX0/ncYDOeCMIIXkBOvF64PJSONoVmnnGDT7NMriKrgqRZQr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740974327; c=relaxed/simple;
	bh=5XWMnCpsL3+OmndufPxHzXLJG4vZSP/uRjyzPigxAD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oD3YFc7eX0PvOn5W4OeG/uSDwUBXyl93dpSo3Nd7o4Rd72k3TsWlSHRyP6EwpbuEo36rpFEKDMMgHPQ22OKsBh9gP1srQUriUQg5PAlx//KU/alPyLGhDUKnuftU6dODI2+QkbbcCPz7PvGUzozaG93dBt8qLHxD0edtf/YoIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GroJ3LdS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740974324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bT3NNS/Dtjig2F+g725um6EB7JLWxqo2+V7HPlUk08=;
	b=GroJ3LdSLk6jZBvPXFjlxsFomBJnkhJ7cbFzIb6Xa1kosBUZUeUKLcBijxC8eFRvS1oDUP
	DLkUcGBmJiFGxEJA/gmy2P5Os2QNJaru547l43bq7kruRij7dE4XhScmbX7BFvCqMgw7fz
	q+Q/mcApXkxIuqZDW1bMUD1sBVWOr1w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-7uLUDb_oPzeIAsUhupTnKw-1; Sun, 02 Mar 2025 22:58:41 -0500
X-MC-Unique: 7uLUDb_oPzeIAsUhupTnKw-1
X-Mimecast-MFC-AGG-ID: 7uLUDb_oPzeIAsUhupTnKw_1740974321
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22368a8979cso43881625ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 19:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740974320; x=1741579120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bT3NNS/Dtjig2F+g725um6EB7JLWxqo2+V7HPlUk08=;
        b=XviOGXvmkD2uNjnNnTZWRchp45LNjcOFu7yEI6hZSn/yDbIKZSTyQBdmeaBuyQq9fb
         9FTEe/jy8O4o9A2RJH7/OtLXoCyB2dhfclQWtb7GisJiBd51Kst9g3pdlUYKFgsSvR5a
         oEr0DYcW16vzKW0b/oiJ5m+tKMYUlhjXJx6M07szgiYIlIG0Y1l2DfV1LpJ/Tqgjr/9K
         jfHqF1vYoIxDckT4RI44PovoVcB1U23j8t5o2g6eyMDbET1pcjZGNg1jIrb6yUHzZM49
         qiCMuvEXykhtUWtIV1UrGllHqxAp9CCluoLxmZHpxXb9XBebHcz0Pk3iCbdBUAfe2fxR
         uSyg==
X-Forwarded-Encrypted: i=1; AJvYcCXlUoVL2Voan+IvQ0NBXVoWpEFFwnnn56B65mjVNfKogahmyMRSYs2Bgrc1rlnUnMee2URIGloAdNqFqLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOrLJA3BAiGoPiBleN1F+tcDI6nAHRmSREewOMiHMuPsjOfE7
	+r3kwQzPwASJnGnWy/c9YohkZ43XM9Lf2Svqxisbo50DJEDqCJ/8H6TXVnyuJi6rmXMrMkgmSay
	nHMZ+e9gb1hVo84mZXZqpCmnHvmS+t/VR+B3Sunvga+z+csmWNXHGbqZtPstOIQ==
X-Gm-Gg: ASbGnct50jo2gT5/fIlr6s1bOj0y7nIgXqUMeYMIrsY9obe+a9TDL77FTtrBjt0Eug2
	PqQtvO7nt8eM31NZzYoA2dVUhnhQ5n/2z1XBa874hWmj3JYEJNQ3BfvtWG6ogv1UeBoj12I8M2V
	Z2WOwXJ0EwIrb/LuBQPfFenL+hxS8V1v1Q7Kw3S2O73pKsPDOMFBqyByJJSGjXw3RJxao/imSfM
	1hE65atLCx3X0ndkvaF/7DQK2whC/DLFtjzZx9F8HhYqQLschj9vAkuJ3x4QkgyINr7fxTmpvvh
	2N0I3wvD+zCILbNaZA==
X-Received: by 2002:a17:903:2990:b0:218:a43c:571e with SMTP id d9443c01a7336-22368fba44fmr198572605ad.28.1740974320588;
        Sun, 02 Mar 2025 19:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqxI9Mvost7AdZYVBARMmzV+zMeNyiF17A+hAYLID4ebKywG48SoiE0P59KMBywZaWp4wy2w==
X-Received: by 2002:a17:903:2990:b0:218:a43c:571e with SMTP id d9443c01a7336-22368fba44fmr198572335ad.28.1740974320191;
        Sun, 02 Mar 2025 19:58:40 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fb05bsm67615055ad.96.2025.03.02.19.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 19:58:39 -0800 (PST)
Message-ID: <f3b31f6e-7960-432b-a522-3ec5f5ac7c6f@redhat.com>
Date: Mon, 3 Mar 2025 13:58:31 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/45] arm64: RME: Check for RME support at KVM init
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-7-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-7-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> Query the RMI version number and check if it is a compatible version. A
> static key is also provided to signal that a supported RMM is available.
> 
> Functions are provided to query if a VM or VCPU is a realm (or rec)
> which currently will always return false.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v6:
>   * Improved message for an unsupported RMI ABI version.
> Changes since v5:
>   * Reword "unsupported" message from "host supports" to "we want" to
>     clarify that 'we' are the 'host'.
> Changes since v2:
>   * Drop return value from kvm_init_rme(), it was always 0.
>   * Rely on the RMM return value to identify whether the RSI ABI is
>     compatible.
> ---
>   arch/arm64/include/asm/kvm_emulate.h | 18 +++++++++
>   arch/arm64/include/asm/kvm_host.h    |  4 ++
>   arch/arm64/include/asm/kvm_rme.h     | 56 ++++++++++++++++++++++++++++
>   arch/arm64/include/asm/virt.h        |  1 +
>   arch/arm64/kvm/Makefile              |  3 +-
>   arch/arm64/kvm/arm.c                 |  6 +++
>   arch/arm64/kvm/rme.c                 | 56 ++++++++++++++++++++++++++++
>   7 files changed, 143 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/include/asm/kvm_rme.h
>   create mode 100644 arch/arm64/kvm/rme.c
> 

It may be worthy to add one comments in the change log, something like "struct realm"
and its states aren't used until the ioctl interfaces are revised to support realm
and REC creation and destruction. Otherwise, the definition would belong to that
patch revising the ioctl interface.

With the following nitpick is addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 47f2cf408eed..52c7a8923c65 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -691,4 +691,22 @@ static inline bool guest_hyp_sve_traps_enabled(const struct kvm_vcpu *vcpu)
>   {
>   	return __guest_hyp_cptr_xen_trap_enabled(vcpu, ZEN);
>   }
> +
> +static inline bool kvm_is_realm(struct kvm *kvm)
> +{
> +	if (static_branch_unlikely(&kvm_rme_is_available) && kvm)
> +		return kvm->arch.is_realm;
> +	return false;
> +}
> +
> +static inline enum realm_state kvm_realm_state(struct kvm *kvm)
> +{
> +	return READ_ONCE(kvm->arch.realm.state);
> +}
> +
> +static inline bool vcpu_is_rec(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}
> +
>   #endif /* __ARM64_KVM_EMULATE_H__ */
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 7cfa024de4e3..992eb2a6f56f 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -27,6 +27,7 @@
>   #include <asm/fpsimd.h>
>   #include <asm/kvm.h>
>   #include <asm/kvm_asm.h>
> +#include <asm/kvm_rme.h>
>   #include <asm/vncr_mapping.h>
>   
>   #define __KVM_HAVE_ARCH_INTC_INITIALIZED
> @@ -383,6 +384,9 @@ struct kvm_arch {
>   	 * the associated pKVM instance in the hypervisor.
>   	 */
>   	struct kvm_protected_vm pkvm;
> +
> +	bool is_realm;
> +	struct realm realm;
>   };
>   
>   struct kvm_vcpu_fault_info {
> diff --git a/arch/arm64/include/asm/kvm_rme.h b/arch/arm64/include/asm/kvm_rme.h
> new file mode 100644
> index 000000000000..69af5c3a1e44
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_rme.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +
> +#ifndef __ASM_KVM_RME_H
> +#define __ASM_KVM_RME_H
> +
> +/**
> + * enum realm_state - State of a Realm
> + */
> +enum realm_state {
> +	/**
> +	 * @REALM_STATE_NONE:
> +	 *      Realm has not yet been created. rmi_realm_create() may be
> +	 *      called to create the realm.
> +	 */
> +	REALM_STATE_NONE,
> +	/**
> +	 * @REALM_STATE_NEW:
> +	 *      Realm is under construction, not eligible for execution. Pages
> +	 *      may be populated with rmi_data_create().
> +	 */
> +	REALM_STATE_NEW,
> +	/**
> +	 * @REALM_STATE_ACTIVE:
> +	 *      Realm has been created and is eligible for execution with
> +	 *      rmi_rec_enter(). Pages may no longer be populated with
> +	 *      rmi_data_create().
> +	 */
> +	REALM_STATE_ACTIVE,
> +	/**
> +	 * @REALM_STATE_DYING:
> +	 *      Realm is in the process of being destroyed or has already been
> +	 *      destroyed.
> +	 */
> +	REALM_STATE_DYING,
> +	/**
> +	 * @REALM_STATE_DEAD:
> +	 *      Realm has been destroyed.
> +	 */
> +	REALM_STATE_DEAD
> +};
> +
> +/**
> + * struct realm - Additional per VM data for a Realm
> + *
> + * @state: The lifetime state machine for the realm
> + */
> +struct realm {
> +	enum realm_state state;
> +};
> +
> +void kvm_init_rme(void);
> +
> +#endif

#endif /* __ASM_KVM_RME_H */

> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index ebf4a9f943ed..e45d47156dcf 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -81,6 +81,7 @@ void __hyp_reset_vectors(void);
>   bool is_kvm_arm_initialised(void);
>   
>   DECLARE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
> +DECLARE_STATIC_KEY_FALSE(kvm_rme_is_available);
>   
>   static inline bool is_pkvm_initialized(void)
>   {
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 3cf7adb2b503..ce8a10d3161d 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -23,7 +23,8 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
>   	 vgic/vgic-v3.o vgic/vgic-v4.o \
>   	 vgic/vgic-mmio.o vgic/vgic-mmio-v2.o \
>   	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
> -	 vgic/vgic-its.o vgic/vgic-debug.o
> +	 vgic/vgic-its.o vgic/vgic-debug.o \
> +	 rme.o
>   
>   kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
>   kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 646e806c6ca6..6d371a2b648a 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -40,6 +40,7 @@
>   #include <asm/kvm_nested.h>
>   #include <asm/kvm_pkvm.h>
>   #include <asm/kvm_ptrauth.h>
> +#include <asm/kvm_rme.h>
>   #include <asm/sections.h>
>   
>   #include <kvm/arm_hypercalls.h>
> @@ -59,6 +60,8 @@ enum kvm_wfx_trap_policy {
>   static enum kvm_wfx_trap_policy kvm_wfi_trap_policy __read_mostly = KVM_WFX_NOTRAP_SINGLE_TASK;
>   static enum kvm_wfx_trap_policy kvm_wfe_trap_policy __read_mostly = KVM_WFX_NOTRAP_SINGLE_TASK;
>   
> +DEFINE_STATIC_KEY_FALSE(kvm_rme_is_available);
> +
>   DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
>   
>   DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_base);
> @@ -2759,6 +2762,9 @@ static __init int kvm_arm_init(void)
>   
>   	in_hyp_mode = is_kernel_in_hyp_mode();
>   
> +	if (in_hyp_mode)
> +		kvm_init_rme();
> +
>   	if (cpus_have_final_cap(ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE) ||
>   	    cpus_have_final_cap(ARM64_WORKAROUND_1508412))
>   		kvm_info("Guests without required CPU erratum workarounds can deadlock system!\n" \
> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
> new file mode 100644
> index 000000000000..67cf2d94cb2d
> --- /dev/null
> +++ b/arch/arm64/kvm/rme.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +
> +#include <linux/kvm_host.h>
> +
> +#include <asm/rmi_cmds.h>
> +#include <asm/virt.h>
> +
> +static int rmi_check_version(void)
> +{
> +	struct arm_smccc_res res;
> +	unsigned short version_major, version_minor;
> +	unsigned long host_version = RMI_ABI_VERSION(RMI_ABI_MAJOR_VERSION,
> +						     RMI_ABI_MINOR_VERSION);
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_VERSION, host_version, &res);
> +
> +	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> +		return -ENXIO;
> +
> +	version_major = RMI_ABI_VERSION_GET_MAJOR(res.a1);
> +	version_minor = RMI_ABI_VERSION_GET_MINOR(res.a1);
> +
> +	if (res.a0 != RMI_SUCCESS) {
> +		unsigned short high_version_major, high_version_minor;
> +
> +		high_version_major = RMI_ABI_VERSION_GET_MAJOR(res.a2);
> +		high_version_minor = RMI_ABI_VERSION_GET_MINOR(res.a2);
> +
> +		kvm_err("Unsupported RMI ABI (v%d.%d - v%d.%d) we want v%d.%d\n",
> +			version_major, version_minor,
> +			high_version_major, high_version_minor,
> +			RMI_ABI_MAJOR_VERSION,
> +			RMI_ABI_MINOR_VERSION);
> +		return -ENXIO;
> +	}
> +
> +	kvm_info("RMI ABI version %d.%d\n", version_major, version_minor);
> +
> +	return 0;
> +}
> +
> +void kvm_init_rme(void)
> +{
> +	if (PAGE_SIZE != SZ_4K)
> +		/* Only 4k page size on the host is supported */
> +		return;
> +
> +	if (rmi_check_version())
> +		/* Continue without realm support */
> +		return;
> +
> +	/* Future patch will enable static branch kvm_rme_is_available */
> +}

Thanks,
Gavin


