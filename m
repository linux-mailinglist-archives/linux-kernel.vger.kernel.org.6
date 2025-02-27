Return-Path: <linux-kernel+bounces-536402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFE2A47F34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0676016A4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908D22FDF1;
	Thu, 27 Feb 2025 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULoxHFdw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03A23236F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662729; cv=none; b=sSQ1k51ybArwT8f7fu8AX9xRQhvfldnf6aXNar/QYXb2f1ZupfCBZeFjF4iNe4i1wlKPCCme9Znk8XJQXuvKi1QQEUOJpF5t+nZzvjUBl/B8i1pNIL6Tu17qkxsxtEs4UsygSpkQAphG9NGzAVRu1HU0ZoahXoaaY0M/+HqITX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662729; c=relaxed/simple;
	bh=85jFEyYKejN6U9NTdv3wuxl8AsFly+Adtfx5FI+2FP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4hqCQpMIKfwZHdFR6K9LdNmPXGcIN0U9VhLWF3r9oTi8jTws2X7LuoI03ZI8guaPcukK3vP5IO5fy4QtnOe2QJ8ushzOuIVwnT63aGrfJJZcT0KP7oF4X9ScIBSH6ubmXw43xJQM5sGF6XrcdETJNlho9o1MAY2KC6dBdJD4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULoxHFdw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740662725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f51Tc1bxzTeBFM23W9emUsW0S9cYm+o+zyeX5lS8VVw=;
	b=ULoxHFdw6sjE0DGebiNK/hOO8vKnby7R9mtKa3pyS19nOfn3NAg+3z/3idYt6nqxjocTYM
	ErxKM/WO8ZHIrDoTQoYqy5avXsV/b2j+uM2PMmZIf0O6pUSZd2cu8ce+NpbkYDDAU2IFy1
	nMiI9KYFcRpUmwL8Xu19ePibVCCdm6E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-LbAgg8KLNZqMT3xXWSOeLg-1; Thu, 27 Feb 2025 08:25:24 -0500
X-MC-Unique: LbAgg8KLNZqMT3xXWSOeLg-1
X-Mimecast-MFC-AGG-ID: LbAgg8KLNZqMT3xXWSOeLg_1740662723
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f3bac2944so408940f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662723; x=1741267523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f51Tc1bxzTeBFM23W9emUsW0S9cYm+o+zyeX5lS8VVw=;
        b=Es/kAh2WZTwpbPRmhC36SbwpL3zDUikGzu3wdGQifqN1CAznfH9UfCj9WrqR+EQm37
         VkvMsd/30iq0qRXXj8ul7BtSlVXhz+Bn4jExHFYyOMGPAomlIDi7PrzvqSUJeu9/GCAn
         rIN6dxlibblfnY6toepDMM+kP+VzskVma9ppDlMwlIrO/9HVMUa52tMOHx0WBX5XjXF6
         S5/DwBSrrBPPhErbrYksBsWY8hOTxxA6q5ifIJDrOeAHrcJha4VKzUU3+0942NvpAjlj
         iRNlU1NVYGVwv5YAlUJdbY+39ZgfbR81ObPYTck5hUFf8Sma5xY2v5XR8oBRJEmC61iU
         d8kg==
X-Forwarded-Encrypted: i=1; AJvYcCVksC0mWwSb740cp5EEjUT5jBgCU6tLZoZDDZ+ijRnNwrcf2CVOdEfGJ8Q/8kp0ToPXHAV9SfCuNX6OjZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9+UOXQgTBVCEaCVQxpuD2ScJK1cp4PfCbSig+AoNfMtVAf1W
	ARsl3HSzJ3+kkpLD4nTIRZJSbMUydPzEEqBIbPBwlQLtz9yU48zhIu6WKbV8W94MBIW5wYDyZxu
	O97W38IoklZyGxdGeZt75h35lBQR+JbZcvopRhJaCpk8BrD24HNIFo3QLrp8+7Q==
X-Gm-Gg: ASbGncunIHVH4BqqYb1KeZKQGnCIe+nS2UamRQevuDICwRNuZjZWV0lOFof377vuxYr
	XahyLxSZ0ys16K9gbv829/g9XMpesXgv+ZwSAr1hSAIofDqJ9mVWDvMvxgVnavhFzT0OlN01ZdI
	WoA9V5VMpis40CPA1jvKA+Vi73nm2QFWSsJxNXuTLw03OykxxY4QGIO8s+T54wRGsaq8BddxGwm
	gtC+9FuiopK8hq3LrXZ5DO3Qfypm4if+Lpy2TxIctPeRlS1I7nqYGO2idim1YI32eSfa+NDVQC9
	d88JWy1tJCurA4bl9DZbFieoclF/5Q601Obk/hw45P7cUvU8AUBAXKjLNcS4DKU=
X-Received: by 2002:a5d:5989:0:b0:38f:2856:7d96 with SMTP id ffacd0b85a97d-390d4f3685fmr5296718f8f.1.1740662723262;
        Thu, 27 Feb 2025 05:25:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqdo7LataS/kpUfF2mQCodajCZgi8Dpd3/GK9lISyjmD9OqePtsdIdm5ZeELgs2Y9Fgd7I9w==
X-Received: by 2002:a5d:5989:0:b0:38f:2856:7d96 with SMTP id ffacd0b85a97d-390d4f3685fmr5296695f8f.1.1740662722887;
        Thu, 27 Feb 2025 05:25:22 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7c4fsm2061408f8f.52.2025.02.27.05.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:25:22 -0800 (PST)
Date: Thu, 27 Feb 2025 14:25:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/21] acpi/ghes: prepare to change the way HEST
 offsets are calculated
Message-ID: <20250227142521.278015ee@imammedo.users.ipa.redhat.com>
In-Reply-To: <d1b8873b680b1b56ec798d25b71a1622cf1eb3ab.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<d1b8873b680b1b56ec798d25b71a1622cf1eb3ab.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:03:35 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Add a new ags flag to change the way HEST offsets are calculated.
> Currently, offsets needed to store ACPI HEST offsets and read ack
> are calculated based on a previous knowledge from the logic
> which creates the HEST table.
> 
> Such logic is not generic, not allowing to easily add more HEST
> entries nor replicates what OSPM does.
> 
> As the next patches will be adding a more generic logic, add a
> new use_hest_addr, set to false, in preparation for such changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c           | 39 ++++++++++++++++++++++++---------------
>  hw/arm/virt-acpi-build.c | 14 +++++++++++---
>  include/hw/acpi/ghes.h   | 12 +++++++++++-
>  3 files changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 84b891fd3dcf..9243b5ad4acb 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -206,7 +206,8 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
> -static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> +static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
> +                                   BIOSLinker *linker)
>  {
>      int i, error_status_block_offset;
>  
> @@ -251,13 +252,15 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>                                         i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
>      }
>  
> -    /*
> -     * tell firmware to write hardware_errors GPA into
> -     * hardware_errors_addr fw_cfg, once the former has been initialized.
> -     */
> -    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> -                                     sizeof(uint64_t),
> -                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
> +    if (!ags->use_hest_addr) {
> +        /*
> +         * Tell firmware to write hardware_errors GPA into
> +         * hardware_errors_addr fw_cfg, once the former has been initialized.
> +         */
> +        bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE,
> +                                         0, sizeof(uint64_t),
> +                                         ACPI_HW_ERROR_FW_CFG_FILE, 0);
> +    }
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> @@ -331,14 +334,15 @@ static void build_ghes_v2(GArray *table_data,
>  }
>  
>  /* Build Hardware Error Source Table */
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id)
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>  
> -    build_ghes_error_table(hardware_errors, linker);
> +    build_ghes_error_table(ags, hardware_errors, linker);
>  
>      acpi_table_begin(&table, table_data);
>  
> @@ -357,9 +361,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
> -    /* Create a read-write fw_cfg file for Address */
> -    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> +    if (!ags->use_hest_addr) {
> +        /* Create a read-write fw_cfg file for Address */
> +        fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> +    }
>  }
>  
>  static void get_hw_error_offsets(uint64_t ghes_addr,
> @@ -395,8 +401,11 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      }
>  
>      assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
> -    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> -                         &cper_addr, &read_ack_register_addr);
> +
> +    if (!ags->use_hest_addr) {
> +        get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> +                             &cper_addr, &read_ack_register_addr);
> +    }
>  
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e17861..e6328af5d238 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -946,9 +946,17 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> -                        vms->oem_id, vms->oem_table_id);
> +        AcpiGedState *acpi_ged_state;
> +        AcpiGhesState *ags;
> +
> +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +        ags = &acpi_ged_state->ghes_state;
> +        if (ags) {
> +            acpi_add_table(table_offsets, tables_blob);
> +            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> +                            tables->linker, vms->oem_id, vms->oem_table_id);
> +        }
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index f96ac3e85ca2..5000891f163f 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -64,11 +64,21 @@ enum {
>      ACPI_GHES_ERROR_SOURCE_COUNT
>  };
>  
> +/*
> + * AcpiGhesState stores an offset that will be used to fill HEST entries.
                              s/^^^^/GPA/

> + *
> + * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
> + * is stored at hw_error_le. This is the default on QEMU 9.x.
> + *
> + * An GPA value equal to zero means that GHES is not present.
> + */
>  typedef struct AcpiGhesState {
>      uint64_t hw_error_le;
> +    bool use_hest_addr;         /* Currently, always false */
>  } AcpiGhesState;
>  
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,


