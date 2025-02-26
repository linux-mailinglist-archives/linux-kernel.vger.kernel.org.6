Return-Path: <linux-kernel+bounces-534124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63891A4630D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6000E3AEA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20927221542;
	Wed, 26 Feb 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbA1zzU/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E2221704
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580643; cv=none; b=IhxznJ+K5zj4LXcblH0I1aYbLra1zZnYUS4UoTJUUj8Bgs2VUa2rjRE7jzvHKqwKFsn6HxVp4XYG067M3UMswYCrltewk46GYDEnomD+yx97rGWPuZrZc/ABJVEqpTpjsKR3nZQwAhL+/6Rc1g1JkqGvg7qyPh4rZSTSpOakBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580643; c=relaxed/simple;
	bh=3XN3CZ6Qu0sOD7aMn6lx66tz8pfFLoHS7/kLRsshnp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWNIreDMujF/3AeBTqSWwszMVY/ql34e954RX6f+XEEgcHe2ZVgJ/4KetEPJ031jjS2zkJqT8q27qcswQyMQ/OWS33raJpV/UbgvZAUS/C8zH/do2bfx4cWDD/68J1t8zYfED22S/0oJ8BtkSWaac0ZiqjaUtHW4trt4BDdzyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbA1zzU/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740580640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNNyHaSzh3aipvYYRYAq367+LGxJVyGiBGHv/4SoK5k=;
	b=LbA1zzU/ipY9SBGh6XbW7rXQoaqat/+rw0UpBeU+eyg8o52pcv4yOZWxhbjgB8DqpapjPx
	YvR6/uHvv2ZLYuKne+6ZvNAlwUQPxEJuPT4cYcm2034c42zGOsPigwjIFlglbsIYeKn2Bx
	CLxiMoujWKRyn5TyhVwkZkeFYSdUeWM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-YxW9wZIhM4eXBm_sJaNHWg-1; Wed, 26 Feb 2025 09:37:18 -0500
X-MC-Unique: YxW9wZIhM4eXBm_sJaNHWg-1
X-Mimecast-MFC-AGG-ID: YxW9wZIhM4eXBm_sJaNHWg_1740580637
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so34924215e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580637; x=1741185437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNNyHaSzh3aipvYYRYAq367+LGxJVyGiBGHv/4SoK5k=;
        b=a1Nv1rCKdHDbXfv6/pxL3aSaPBaxQJl6b17SFArAf4lhxqh32PaFK36H8zrlg0Lvod
         1SvMSQ4DPiCDrZoZUGj5vRFJjr14oxM646c8NgwFOQFa56B15Mh9wwQ8XJMCIZqR15+r
         XK7XoTWXTKt76+C11SMw/ILsy4OwsYzK3yIeKMUZBCJu4kcO+BVNaNaDemdruYsksyTw
         o30/Px4KIKOcWr2Xd73MuLG7Q3XHC4+xVPCgKj83g0dRL/jOAeawB3wE3FcB++99A3Uw
         u25bUuM8eof8AlxVrEKeac4+LdRdFUvAgWhyVmJ/lQQ4J3hhtixg1K5Cm3at6ngvHIiO
         qZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCV3TPSjzsagFSq8NidJPvo7eE9otquz9xcQoWvW0A9sekVOjaUf6XLtyaQw4vSO+Hu9cgDonQpngc/CZcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4PRvOaqQOTYlrPcZOjyc1e2apazRbgML47INSA0FHcJ9rLjWG
	FlvPtEnSbiBPcq2fH+Vwy/RqNq31mtdlyx1+dSyqwqgXGIMoTZ/su/IDPLk5K7E3frkR+PHIN//
	1PrIor3gDM9+ExF8fz0ZxGb6jThwTDdKJGd8rnS3K3EhMJQJvJZ0J8LaUAm8hZw==
X-Gm-Gg: ASbGncvRrD3d6QBn80CYFe1Mydyi3ZCm52iuvugFLB7VdU1a3YqbVYmCbVvMSisDOUg
	x1Y6TNAO3XV0Q6USyJWXYJb6V8OoNe1jwygjg/pGbLZQWAd136lMLTWifK4vyTOeLmAYFR4Hjs2
	Q/WxCytNlv/z44bD6/lQ6IJG7sIY+8nEm8v4aGsi59VPmqmaYqwsmWMIyFT10d2vENfCUdMBowb
	OHK78Wz3X7jBtbE6rObKDw4w0WkVfZFkTMjwuqr9tpLrSMJuXgayxAmCSPqtVK42XlqWRDZ9nzC
	ASQ9PWNBuk9qkxVQomFXegR0AaPKIUI3uTC5/aEtLhizM010OuQIb0BMiXhhdyQ=
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id 5b1f17b1804b1-439b2b06189mr206467995e9.14.1740580637309;
        Wed, 26 Feb 2025 06:37:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSCA3XFIVyQZsw18frYh1t81BW8lTaHenavCbqgsRrhYxpuoQ/ptQly88DpV9iZZ1qQr4+YQ==
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id 5b1f17b1804b1-439b2b06189mr206467585e9.14.1740580636855;
        Wed, 26 Feb 2025 06:37:16 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5711fcsm24896715e9.28.2025.02.26.06.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:37:16 -0800 (PST)
Date: Wed, 26 Feb 2025 15:37:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/14] acpi/ghes: prepare to change the way HEST
 offsets are calculated
Message-ID: <20250226153714.20c57efe@imammedo.users.ipa.redhat.com>
In-Reply-To: <9eeaabf88e7ddc4884633702b7bc419075975bc8.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<9eeaabf88e7ddc4884633702b7bc419075975bc8.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:35:10 +0100
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
>  hw/acpi/ghes.c           | 46 ++++++++++++++++++++++++----------------
>  hw/arm/virt-acpi-build.c | 15 ++++++++++---
>  include/hw/acpi/ghes.h   | 14 ++++++++++--
>  3 files changed, 52 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index b709c177cdea..e49a03fdb94e 100644
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
> @@ -357,11 +361,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
> -    /* Create a read-write fw_cfg file for Address */
> -    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> -        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> -
> -    ags->present = true;
> +    if (!ags->use_hest_addr) {
> +        /* Create a read-write fw_cfg file for Address */
> +        fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> +    }
>  }
>  
>  static void get_hw_error_offsets(uint64_t ghes_addr,
> @@ -411,8 +415,11 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      ags = &acpi_ged_state->ghes_state;
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
>      if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");
> @@ -494,5 +501,8 @@ bool acpi_ghes_present(void)
>          return false;
>      }
>      ags = &acpi_ged_state->ghes_state;
> -    return ags->present;
> +    if (!ags->hw_error_le)
> +        return false;
> +
> +    return true;
>  }
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e17861..8ab8d11b6536 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -946,9 +946,18 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
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
                            ^^^ will explode if object_resolve_path_type() returns NULL
> +                                                       NULL));

it's also expensive load-wise.
You have access to vms with ged pointer here, use that
(search for 'acpi_ged_state = ACPI_GED' example)

                            

> +        if (acpi_ged_state) {

                hence, this check is not really needed,
                we have to have GED at this point or abort

                earlier code that instantiates GED should take care of
                cleanly exiting if it failed to create GED so we would never get
                to missing GED here


> +            ags = &acpi_ged_state->ghes_state;
> +
> +            acpi_add_table(table_offsets, tables_blob);
> +            acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> +                            tables->linker, vms->oem_id, vms->oem_table_id);
> +        }
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 39619a2457cb..a3d62b96584f 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -64,12 +64,22 @@ enum {
>      ACPI_GHES_ERROR_SOURCE_COUNT
>  };
>  
> +/*
> + * AcpiGhesState stores an offset that will be used to fill HEST entries.
> + *
> + * When use_hest_addr is false, the stored offset is placed at hw_error_le,
> + * meaning an offset from the etc/hardware_errors firmware address. This
> + * is the default on QEMU 9.x.
> + *
> + * An offset value equal to zero means that GHES is not present.
> + */
>  typedef struct AcpiGhesState {
>      uint64_t hw_error_le;
> -    bool present; /* True if GHES is present at all on this board */
> +    bool use_hest_addr;         /* Currently, always false */
>  } AcpiGhesState;
>  
> -void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
> +                     GArray *hardware_errors,
>                       BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,


