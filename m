Return-Path: <linux-kernel+bounces-267332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E10941059
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF00B1F248FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0FD19D8A6;
	Tue, 30 Jul 2024 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOaxamRs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6519885F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338240; cv=none; b=abPSnTIJ04NhYuK0Sjy38BbNOBC98tR61gP81QZzeEaPSyC6na8VkR+fADa0+mzGk8+y7/tZm8aqzSHWb/KJH6FwMqpIcYa4ERt4pItvsnZC8gaUF4aIDuQVtSvxUp/pR8YgDT288d8fXBCz5ZjU++72Fccdzz9kI7qiMvvMA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338240; c=relaxed/simple;
	bh=/xr1KVQLJ4awnh0yUryMays3hQP4fKZ0fH1o2k9nb7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmgB1CImORqJIL6mdZIn9SAqKwdA6cQCM9jiBLNJr9BZhMKPscGrXFIXGtezxKPNCxofg6M3ZuBNJEVLoQp10jAEcp1R9oPccU3EjKFanScLXh0Pa3n4jY54naWt21II/+C/N1XMJdSDkDdXllOZOtJDBUKtYxjTVHcAyUqjjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOaxamRs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722338237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiz5nlNmhxD5hy6+byQmGFEhWqEBELICkobAX0l8hKY=;
	b=EOaxamRsLZOuZgdP2o2sTq3giJS08QI5NrnTbQMbFH9xt+H91tgMUO6nW+mBSuhYCeHS4o
	SW31LC1GwO+1oHYoZhwqLjqF9YN/Y4fmKeQjFo3FbklDD0Cy3pxyXkOJ5rWztSHG/WCOHA
	a5OnLR08tbjMYDnTorj1uPNRVtsC5qg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-hB5dLLehP92M23sZ1JDrsw-1; Tue, 30 Jul 2024 07:17:15 -0400
X-MC-Unique: hB5dLLehP92M23sZ1JDrsw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3685bbd6dfbso1827661f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722338234; x=1722943034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiz5nlNmhxD5hy6+byQmGFEhWqEBELICkobAX0l8hKY=;
        b=sXxxP1wb5NAaEnpzgoT8b5PPjcoeIx6pplWXWIKATe0rvFVC35t2QlAreyYJkDeLXj
         H2Omys4uVQEkxgjnv8kv94kjcCw+l/cC1ylVrI70zhc3/Nz00r648yHA+DDfIC8UmhFH
         NnY3ogChW/TJsUyqrxdTb2TWG0UhWog33VyNtos+0zikFnZY7qf2NxhCC5LxYzc/uMOx
         g7FMMahAURMeLvo/5T4OD+B+52cqw+9eR9vDrChiC6orMHED9gMtjvOr0Lk02I1XhxN2
         R3jfpzSe+sy0/1MuSOYI8LGXaJDIrMb9T0E2oeDk9RRTkGlciphoLWun6H+CHtgaOkXX
         AvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQMXYnyZLCpjF3q+lADGm4NbJ+xEx8Jl6NJX3ucoU3uTxkTS6JXxwbhs/S0igWjZjZs3bRu0pj/Qtdb8z40rSNZiBxV2/ExXzWtm6I
X-Gm-Message-State: AOJu0YyMENJJuKdwHckdLutqkxD2ahFnYrEbanJfPxgiCjAJRJSK/lSP
	GoEE/i6RZjZR1xy+sWztW/8YKA1NjLfCgqYEZ3c05dP7VthB0kiLXX1CSXGS04hTcBv0+zS1seP
	KnfsIE/RSVvut7mMiByb9DSDezraS8eiVOwSOQLbA5EhBc3QLzsDhVro5w5FI8Q==
X-Received: by 2002:a5d:4485:0:b0:368:31c7:19dd with SMTP id ffacd0b85a97d-36b5cee2da9mr7751284f8f.5.1722338233805;
        Tue, 30 Jul 2024 04:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYIHqDSUFvtbFgGNyhA8NK+vudju8KjFFq/vKlLfI8HA/4r6Jd+xe7pHZKUGB8x/AjZblKjw==
X-Received: by 2002:a5d:4485:0:b0:368:31c7:19dd with SMTP id ffacd0b85a97d-36b5cee2da9mr7751227f8f.5.1722338232262;
        Tue, 30 Jul 2024 04:17:12 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857fdesm14739917f8f.75.2024.07.30.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 04:17:11 -0700 (PDT)
Date: Tue, 30 Jul 2024 13:17:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240730131709.10e72c7d@imammedo.users.ipa.redhat.com>
In-Reply-To: <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 08:45:56 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

that's quite a bit of code that in 99% won't ever be used
(assuming error injection testing scenario),
not to mention it's a hw depended one and governed by different specs.

Essentially we would need to create _whole_ lot of QAPI
commands to cover possible errors for no benefit to QEMU.

Let take for example very simple _OST status reporting,
QEMU of cause can decode values and present it to users in
more 'presentable' form. However instead of translating
numbers (aka. spec language) into a made up QEMU language,
QEMU just passes values up the stack and users can use
well defined spec to interpret its meaning.

benefits are: QEMU doesn't have to maintain translation
code and QAPI ABI is limited to passing raw values.

Can we do similar thing here as well?
i.e. simplify error injection commands to
a command that takes raw value and passes it
to guest (QEMU here acts as proxy, if I'm not
mistaken)?

Preferably make it generic enough to handle
not only ARM but other error formats HEST is
able to handle.

PS:
For user convenience, QEMU can carry a script that
could help generate this raw value in user friendly way
but at the same time it won't put maintenance
burden on QEMU itself.

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 1. Some GHES functions require handling addresses. Add a helper function
>    to support it.
> 
> 2. Add support for ACPI CPER (firmware-first) ARM processor error injection.
> 
> Compliance with N.2.4.4 ARM Processor Error Section in UEFI 2.6 and
> upper specs, using error type bit encoding as detailed at UEFI 2.9A
> errata.
> 
> Error injection examples:
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error']
>       }
> }
> 
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['tlb-error']
>       }
> }
> 
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['bus-error']
>       }
> }
> 
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error', 'tlb-error']
>       }
> }
> 
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error', 'tlb-error', 'bus-error', 'micro-arch-error']
>       }
> }
> ...
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> For Add a logic to handle block addresses,
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> For FW first ARM processor error injection,
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  configs/targets/aarch64-softmmu.mak |   1 +
>  hw/acpi/ghes.c                      | 258 ++++++++++++++++++++++++++--
>  hw/arm/Kconfig                      |   4 +
>  hw/arm/arm_error_inject.c           |  35 ++++
>  hw/arm/arm_error_inject_stubs.c     |  18 ++
>  hw/arm/meson.build                  |   3 +
>  include/hw/acpi/ghes.h              |   2 +
>  qapi/arm-error-inject.json          |  49 ++++++
>  qapi/meson.build                    |   1 +
>  qapi/qapi-schema.json               |   1 +
>  10 files changed, 361 insertions(+), 11 deletions(-)
>  create mode 100644 hw/arm/arm_error_inject.c
>  create mode 100644 hw/arm/arm_error_inject_stubs.c
>  create mode 100644 qapi/arm-error-inject.json
> 
> diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
> index 84cb32dc2f4f..b4b3cd97934a 100644
> --- a/configs/targets/aarch64-softmmu.mak
> +++ b/configs/targets/aarch64-softmmu.mak
> @@ -5,3 +5,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
>  TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=y
> +CONFIG_ARM_EINJ=y
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 5b8bc6eeb437..6075ef5893ce 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -27,6 +27,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "qemu/uuid.h"
> +#include "qapi/qapi-types-arm-error-inject.h"
>  
>  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
>  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> @@ -53,6 +54,12 @@
>  /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
>  #define ACPI_GHES_MEM_CPER_LENGTH           80
>  
> +/*
> + * ARM Processor section CPER size, UEFI 2.10: N.2.4.4
> + * ARM Processor Error Section
> + */
> +#define ACPI_GHES_ARM_CPER_LENGTH (72 + 600)
> +
>  /* Masks for block_status flags */
>  #define ACPI_GEBS_UNCORRECTABLE         1
>  
> @@ -231,6 +238,142 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
>      return 0;
>  }
>  
> +/* UEFI 2.9: N.2.4.4 ARM Processor Error Section */
> +static void acpi_ghes_build_append_arm_cper(uint8_t error_types, GArray *table)
> +{
> +    /*
> +     * ARM Processor Error Record
> +     */
> +
> +    /* Validation Bits */
> +    build_append_int_noprefix(table,
> +                              (1ULL << 3) | /* Vendor specific info Valid */
> +                              (1ULL << 2) | /* Running status Valid */
> +                              (1ULL << 1) | /* Error affinity level Valid */
> +                              (1ULL << 0), /* MPIDR Valid */
> +                              4);
> +    /* Error Info Num */
> +    build_append_int_noprefix(table, 1, 2);
> +    /* Context Info Num */
> +    build_append_int_noprefix(table, 1, 2);
> +    /* Section length */
> +    build_append_int_noprefix(table, ACPI_GHES_ARM_CPER_LENGTH, 4);
> +    /* Error affinity level */
> +    build_append_int_noprefix(table, 2, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table, 0, 3);
> +    /* MPIDR_EL1 */
> +    build_append_int_noprefix(table, 0xAB12, 8);
> +    /* MIDR_EL1 */
> +    build_append_int_noprefix(table, 0xCD24, 8);
> +    /* Running state */
> +    build_append_int_noprefix(table, 0x1, 4);
> +    /* PSCI state */
> +    build_append_int_noprefix(table, 0x1234, 4);
> +
> +    /* ARM Propcessor error information */
> +    /* Version */
> +    build_append_int_noprefix(table, 0, 1);
> +    /*  Length */
> +    build_append_int_noprefix(table, 32, 1);
> +    /* Validation Bits */
> +    build_append_int_noprefix(table,
> +                              (1ULL << 4) | /* Physical fault address Valid */
> +                             (1ULL << 3) | /* Virtual fault address Valid */
> +                             (1ULL << 2) | /* Error information Valid */
> +                              (1ULL << 1) | /* Flags Valid */
> +                              (1ULL << 0), /* Multiple error count Valid */
> +                              2);
> +    /* Type */
> +    if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR) ||
> +        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR) ||
> +        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR) ||
> +        error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR)) {
> +        build_append_int_noprefix(table, error_types, 1);
> +    } else {
> +        return;
> +    }
> +    /* Multiple error count */
> +    build_append_int_noprefix(table, 2, 2);
> +    /* Flags  */
> +    build_append_int_noprefix(table, 0xD, 1);
> +    /* Error information  */
> +    if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_CACHE_ERROR)) {
> +        build_append_int_noprefix(table, 0x0091000F, 8);
> +    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_TLB_ERROR)) {
> +        build_append_int_noprefix(table, 0x0054007F, 8);
> +    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_BUS_ERROR)) {
> +        build_append_int_noprefix(table, 0x80D6460FFF, 8);
> +    } else if (error_types & BIT(ARM_PROCESSOR_ERROR_TYPE_MICRO_ARCH_ERROR)) {
> +        build_append_int_noprefix(table, 0x78DA03FF, 8);
> +    } else {
> +        return;
> +    }
> +    /* Virtual fault address  */
> +    build_append_int_noprefix(table, 0x67320230, 8);
> +    /* Physical fault address  */
> +    build_append_int_noprefix(table, 0x5CDFD492, 8);
> +
> +    /* ARM Propcessor error context information */
> +    /* Version */
> +    build_append_int_noprefix(table, 0, 2);
> +    /* Validation Bits */
> +    /* AArch64 EL1 context registers Valid */
> +    build_append_int_noprefix(table, 5, 2);
> +    /* Register array size */
> +    build_append_int_noprefix(table, 592, 4);
> +    /* Register array */
> +    build_append_int_noprefix(table, 0x12ABDE67, 8);
> +}
> +
> +static int acpi_ghes_record_arm_error(uint8_t error_types,
> +                                      uint64_t error_block_address)
> +{
> +    GArray *block;
> +
> +    /* ARM processor Error Section Type */
> +    const uint8_t uefi_cper_arm_sec[] =
> +          UUID_LE(0xE19E3D16, 0xBC11, 0x11E4, 0x9C, 0xAA, 0xC2, 0x05, \
> +                  0x1D, 0x5D, 0x46, 0xB0);
> +
> +    /*
> +     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> +     * Table 17-13 Generic Error Data Entry
> +     */
> +    QemuUUID fru_id = {};
> +    uint32_t data_length;
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +
> +    /* This is the length if adding a new generic error data entry*/
> +    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_ARM_CPER_LENGTH;
> +    /*
> +     * It should not run out of the preallocated memory if adding a new generic
> +     * error data entry
> +     */
> +    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> +            ACPI_GHES_MAX_RAW_DATA_LENGTH);
> +
> +    /* Build the new generic error status block header */
> +    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> +        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
> +
> +    /* Build this new generic error data entry header */
> +    acpi_ghes_generic_error_data(block, uefi_cper_arm_sec,
> +        ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> +        ACPI_GHES_ARM_CPER_LENGTH, fru_id, 0);
> +
> +    /* Build the ARM processor error section CPER */
> +    acpi_ghes_build_append_arm_cper(error_types, block);
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_address, block->data, block->len);
> +
> +    g_array_free(block, true);
> +
> +    return 0;
> +}
> +
>  /*
>   * Build table for the hardware error fw_cfg blob.
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
> @@ -392,23 +535,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> +static uint64_t ghes_get_state_start_address(void)
> +{
> +    AcpiGedState *acpi_ged_state =
> +        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
> +    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> +
> +    return le64_to_cpu(ags->ghes_addr_le);
> +}
> +
>  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>  {
>      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> -    uint64_t start_addr;
> +    uint64_t start_addr = ghes_get_state_start_address();
>      bool ret = -1;
> -    AcpiGedState *acpi_ged_state;
> -    AcpiGhesState *ags;
> -
>      assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
>  
> -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> -                                                       NULL));
> -    g_assert(acpi_ged_state);
> -    ags = &acpi_ged_state->ghes_state;
> -
> -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> -
>      if (physical_address) {
>  
>          if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
> @@ -448,6 +590,100 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      return ret;
>  }
>  
> +/*
> + * Error register block data layout
> + *
> + * | +---------------------+ ges.ghes_addr_le
> + * | |error_block_address0 |
> + * | +---------------------+
> + * | |error_block_address1 |
> + * | +---------------------+ --+--
> + * | |    .............    | GHES_ADDRESS_SIZE
> + * | +---------------------+ --+--
> + * | |error_block_addressN |
> + * | +---------------------+
> + * | | read_ack_register0  |
> + * | +---------------------+ --+--
> + * | | read_ack_register1  | GHES_ADDRESS_SIZE
> + * | +---------------------+ --+--
> + * | |   .............     |
> + * | +---------------------+
> + * | | read_ack_registerN  |
> + * | +---------------------+ --+--
> + * | |      CPER           |   |
> + * | |      ....           | GHES_MAX_RAW_DATA_LENGT
> + * | |      CPER           |   |
> + * | +---------------------+ --+--
> + * | |    ..........       |
> + * | +---------------------+
> + * | |      CPER           |
> + * | |      ....           |
> + * | |      CPER           |
> + * | +---------------------+
> + */
> +
> +/* Map from uint32_t notify to entry offset in GHES */
> +static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
> +                                                 0xff, 0xff, 0xff, 1, 0};
> +
> +static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
> +                          uint64_t *read_ack_register_addr)
> +{
> +    uint64_t base;
> +
> +    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
> +        return false;
> +    }
> +
> +    /* Find and check the source id for this new CPER */
> +    if (error_source_to_index[notify] == 0xff) {
> +        return false;
> +    }
> +
> +    base = ghes_get_state_start_address();
> +
> +    *read_ack_register_addr = base +
> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> +        error_source_to_index[notify] * sizeof(uint64_t);
> +
> +    /* Could also be read back from the error_block_address register */
> +    *error_block_addr = base +
> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> +
> +    return true;
> +}
> +
> +bool ghes_record_arm_errors(uint8_t error_types, uint32_t notify)
> +{
> +    int read_ack_register = 0;
> +    uint64_t read_ack_register_addr = 0;
> +    uint64_t error_block_addr = 0;
> +
> +    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_register_addr)) {
> +        return false;
> +    }
> +
> +    cpu_physical_memory_read(read_ack_register_addr,
> +                             &read_ack_register, sizeof(uint64_t));
> +    /* zero means OSPM does not acknowledge the error */
> +    if (!read_ack_register) {
> +        error_report("Last time OSPM does not acknowledge the error,"
> +                     " record CPER failed this time, set the ack value to"
> +                     " avoid blocking next time CPER record! exit");
> +        read_ack_register = 1;
> +        cpu_physical_memory_write(read_ack_register_addr,
> +                                  &read_ack_register, sizeof(uint64_t));
> +        return false;
> +    }
> +
> +    read_ack_register = cpu_to_le64(0);
> +    cpu_physical_memory_write(read_ack_register_addr,
> +                              &read_ack_register, sizeof(uint64_t));
> +    return acpi_ghes_record_arm_error(error_types, error_block_addr);
> +}
> +
>  bool acpi_ghes_present(void)
>  {
>      AcpiGedState *acpi_ged_state;
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 1ad60da7aa2d..bafac82f9fd3 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -712,3 +712,7 @@ config ARMSSE
>      select UNIMP
>      select SSE_COUNTER
>      select SSE_TIMER
> +
> +config ARM_EINJ
> +    bool
> +    default y if AARCH64
> diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
> new file mode 100644
> index 000000000000..1da97d5d4fdc
> --- /dev/null
> +++ b/hw/arm/arm_error_inject.c
> @@ -0,0 +1,35 @@
> +/*
> + * ARM Processor error injection
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi-commands-arm-error-inject.h"
> +#include "hw/boards.h"
> +#include "hw/acpi/ghes.h"
> +
> +/* For ARM processor errors */
> +void qmp_arm_inject_error(ArmProcessorErrorTypeList *errortypes, Error **errp)
> +{
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    uint8_t error_types = 0;
> +
> +    while (errortypes) {
> +        error_types |= BIT(errortypes->value);
> +        errortypes = errortypes->next;
> +    }
> +
> +    ghes_record_arm_errors(error_types, ACPI_GHES_NOTIFY_GPIO);
> +    if (mc->set_error) {
> +        mc->set_error();
> +    }
> +
> +    return;
> +}
> diff --git a/hw/arm/arm_error_inject_stubs.c b/hw/arm/arm_error_inject_stubs.c
> new file mode 100644
> index 000000000000..b51f4202fe64
> --- /dev/null
> +++ b/hw/arm/arm_error_inject_stubs.c
> @@ -0,0 +1,18 @@
> +/*
> + * QMP stub for ARM processor error injection.
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi-commands-arm-error-inject.h"
> +
> +void qmp_arm_inject_error(ArmProcessorErrorTypeList *errortypes, Error **errp)
> +{
> +    error_setg(errp, "ARM processor error support is not compiled in");
> +}
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 0c07ab522f4c..cb7fe09fc87b 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>  arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>  arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
> +arm_ss.add(when: 'CONFIG_ARM_EINJ', if_true: files('arm_error_inject.c'))
>  
>  system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
>  system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
> @@ -77,5 +78,7 @@ system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
>  system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>  system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>  system_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
> +system_ss.add(when: 'CONFIG_ARM_EINJ', if_false: files('arm_error_inject_stubs.c'))
> +system_ss.add(when: 'CONFIG_ALL', if_true: files('arm_error_inject_stubs.c'))
>  
>  hw_arch += {'arm': arm_ss}
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 4f1ab1a73a06..dc531ffce7ae 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -75,6 +75,8 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
>  int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
>  
> +bool ghes_record_arm_errors(uint8_t error_types, uint32_t notify);
> +
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
>   *
> diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
> new file mode 100644
> index 000000000000..430e6cea6b60
> --- /dev/null
> +++ b/qapi/arm-error-inject.json
> @@ -0,0 +1,49 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# = ARM Processor Errors
> +##
> +
> +##
> +# @ArmProcessorErrorType:
> +#
> +# Type of ARM processor error to inject
> +#
> +# @unknown-error: Unknown error
> +#
> +# @cache-error: Cache error
> +#
> +# @tlb-error: TLB error
> +#
> +# @bus-error: Bus error.
> +#
> +# @micro-arch-error: Micro architectural error.
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'ArmProcessorErrorType',
> +  'data': ['unknown-error',
> +	   'cache-error',
> +           'tlb-error',
> +           'bus-error',
> +           'micro-arch-error']
> +}
> +
> +##
> +# @arm-inject-error:
> +#
> +# Inject ARM Processor error.
> +#
> +# @errortypes: ARM processor error types to inject
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 9.1
> +##
> +{ 'command': 'arm-inject-error',
> +  'data': { 'errortypes': ['ArmProcessorErrorType'] },
> +  'features': [ 'unstable' ]
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..5927932c4be3 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -22,6 +22,7 @@ if have_system or have_tools or have_ga
>  endif
>  
>  qapi_all_modules = [
> +  'arm-error-inject',
>    'authz',
>    'block',
>    'block-core',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..479a22de7e43 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -81,3 +81,4 @@
>  { 'include': 'vfio.json' }
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
> +{ 'include': 'arm-error-inject.json' }


