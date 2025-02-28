Return-Path: <linux-kernel+bounces-538545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C5A49A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C344E3B283F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5860726B2C8;
	Fri, 28 Feb 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWi8uFY3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E726A1CB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747465; cv=none; b=PN0qk1G+l8g0nb4T51CF93eOQy86R03WDh3stFfopqMZ+o4Ed75YIsiqHrfd37dRjRzp3TALLdipJEtX8Ac6tM7xUBRYFZ7UrgBXqIgQfMaTPRBy1dc/407R6vIJmi1NNC/TwmVDvCSTkir9xULd0PfORTEH8PVXi4hvQ5CAgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747465; c=relaxed/simple;
	bh=udHQp7xmQO4RdshNE3H57EULNRvh/CXR5HOa/p5rSHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV+VltgUcai9pXJqhUQzUgbvsL5L3ckdIMQBu3OqRqhTbKqlMrZConJC8F+QPT06pI7IVnzxEKVoU3ZEsvS2jva2T8EbL5yL6z25NJL/D1KDx6utXhsfGLf3pO7m6x7iuf9mm6g2JyGPsomVoCW117PHdBj0dR6NsEqwyJsNyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWi8uFY3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740747461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EO0dvLIRsOSJYII3MZSMXo/uV/4vt5Geh4Q79B7fQU0=;
	b=QWi8uFY3/eogAJ9vvB32OSSudEIN2S3LhmlAbfNDdzkYNzu5LrL8GDBQH5FBAIP1fYHWFX
	RpNbEX8hyVhNWzA31z6Af1/d7KvxoOwpduB9hE04BfhA3ezpZzm8PIIkq8mDfUf7idQlXQ
	TQEIW+Y7I0iCy2hALopqTSScMXx9jFA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-u0BzDtydN9qenL6dh35fzA-1; Fri, 28 Feb 2025 07:57:39 -0500
X-MC-Unique: u0BzDtydN9qenL6dh35fzA-1
X-Mimecast-MFC-AGG-ID: u0BzDtydN9qenL6dh35fzA_1740747458
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso15364375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747458; x=1741352258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO0dvLIRsOSJYII3MZSMXo/uV/4vt5Geh4Q79B7fQU0=;
        b=Mwf9HDlVah4JkS5gxza7KvxN6OLMjZT0rLmVUg3tWhzvv9VvptFUzRHQsYH85v4Bn+
         3kOccCCG95HSujyeIxNVU1E2l/ZO5fubI1JmzwguL7fu4iJDu+y3Y+NGPYwgVWyAOKRM
         +A0odSuWQ4qIHLzmuaA+FJRpq2x1fP96aBCbUU2AfqBQGSlc875w5hw/EP/8VMbqfNj3
         C0TlzfnIPTT2LD/fQlWBUgC+SeKrtiVvOt3qJa84WJO3qS5a99/PV9U/1qNau4pAuCuu
         yLi90eUhhCVpletSiitywDzNlbQ0Yk+EVrRyqDh2Vf2X2jN0/dzIp7b0fraQ9r6r9jqK
         ymow==
X-Forwarded-Encrypted: i=1; AJvYcCXSfLHcmeq0JAZsQats14llUperOrSDQXGqnuh/45tjMoFa5R2Y7qriUgjV7IFjNqCUsQj6So5v+nVaUmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcShDaroYgVMaO11aN+a5EK4u/wZ8IyPQ3EMMIoD4aAh8bxpJq
	B0dq+uO31KWCy3DFCMGGxQaIa0N+8IrdlzgLCtQ59TYOEWWJ+TgB3vb/XvOhIEcCQ30HKdwyz9M
	UqAuF0JkpEGHREp9XXQTSbeSdxJ4LpX5HOeH+bxvdUIWacgSZQ9o/psVQQl0oeQ==
X-Gm-Gg: ASbGncvOU8Y6MwA26qJTeVjFnQAgcR33S4PYTdxAI6y2YX9c6Ei6oJq8Z8oSuvUGeLN
	3gh4oKJpc7NW7G7syhWWVffoQSNcYD6doDacCkGETxQd7wi2ndad/ZRDELw4VTZMUCpgPqer5eR
	+hAAaKNRIHP5RRPwnRBLP66WcikXzdyi5OcwOvso2W8FG3natjLs7HSuNIJnTRfnZF76Ct5Ceox
	MSpIXquTVrEClnESLHt9EpDVoeEcq/SYMit2F9FaEqNDdG6174UYT8stOYEyk6nFUCobu/a3DFH
	ZcpDjaMzbKWZs4e4A/ycIrIONe6bUkTTudqgLBxGFyE9Az3q59hGq2ovBzstFSc=
X-Received: by 2002:a5d:6da2:0:b0:38f:4acd:975c with SMTP id ffacd0b85a97d-390ec9bcf2cmr2037403f8f.27.1740747458245;
        Fri, 28 Feb 2025 04:57:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5pZkRnTSZmpHVs+jeM3IRrIXDHQTuhiGcbapnJ6k3yjf+h2Zt1ij5RmmtgvDB3MGiIGYEYA==
X-Received: by 2002:a5d:6da2:0:b0:38f:4acd:975c with SMTP id ffacd0b85a97d-390ec9bcf2cmr2037382f8f.27.1740747457848;
        Fri, 28 Feb 2025 04:57:37 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844c0dsm5029592f8f.80.2025.02.28.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:57:37 -0800 (PST)
Date: Fri, 28 Feb 2025 13:57:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/19] acpi/ghes: prepare to change the way HEST
 offsets are calculated
Message-ID: <20250228135735.43c3ad9c@imammedo.users.ipa.redhat.com>
In-Reply-To: <ac3cc2002267e1ad848aea367ff0b08f2c4b5c69.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
	<ac3cc2002267e1ad848aea367ff0b08f2c4b5c69.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 17:00:43 +0100
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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c           | 39 ++++++++++++++++++++++++---------------
>  hw/arm/virt-acpi-build.c | 13 ++++++++++---
>  include/hw/acpi/ghes.h   | 12 +++++++++++-
>  3 files changed, 45 insertions(+), 19 deletions(-)
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
> index 3ac8f8e17861..040d875d4e83 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -946,9 +946,16 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> -                        vms->oem_id, vms->oem_table_id);
> +        AcpiGedState *acpi_ged_state;
> +        AcpiGhesState *ags;
> +
> +        acpi_ged_state = ACPI_GED(vms->acpi_dev);
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
> index f96ac3e85ca2..411f592662af 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -64,11 +64,21 @@ enum {
>      ACPI_GHES_ERROR_SOURCE_COUNT
>  };
>  
> +/*
> + * AcpiGhesState stores GPA values that will be used to fill HEST entries.
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


