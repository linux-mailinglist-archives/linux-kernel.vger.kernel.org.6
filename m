Return-Path: <linux-kernel+bounces-292050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03528956A87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828B01F220EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D816938C;
	Mon, 19 Aug 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8Tyzvki"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12214EC5D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069451; cv=none; b=log1oJua3ncEf46GPJrzNsLspXHqFcNqUwS0YOVxJzU4A1annN/NpzNGm/HwszLvRS5Uhjars332IMYSAW5AmykQvS+XvSC60Kp+ZpO5WUN3rQY7e7MSKeWzepcmK1NnLx61zIUVd5rj5bma7n+vdTQra1aRQXABtFHKkqfYBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069451; c=relaxed/simple;
	bh=mzlYZdPIPCLmzSvFs6P4TxEjPokiH+pjszmfvj/oRsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaplfNHUDSxzu0QScGEBUgIL2FzXxVjF+EeVF82f7emFoIN/MVuelW5+qGaedRdoEUHiHJuGefJuQ5XUvLKhdPIq5lTxJGV5m5lxEXpiHAL597sMyVEKVUO5QI0DbLwtkf4PC4Muxxpfd4BxQobS+Wy6SGu0RlliLtA/rdwjwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8Tyzvki; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724069448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRQkGUuVh3gE6L9cAkViA3PO4Y/y2wIWE1UR2Aak60w=;
	b=M8TyzvkidD2lIiPX6WUeUvJmxPjbNHKyqNZq9GbbYqGgYD3r73wdGlF8P0VHM0MpDUEaKT
	yd5vrFREhQ0nqnBx4MKyxkq3D7n6CpF+CMQl1GkjhwLnEXtnhVFBt+19RCztxe84WbbT4Z
	/X6IvA31i1PsP5Tia+v1FqBrL2J5NVQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-CX_XcC9xMWiKSMyDU9EY4g-1; Mon, 19 Aug 2024 08:10:44 -0400
X-MC-Unique: CX_XcC9xMWiKSMyDU9EY4g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so23075655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069440; x=1724674240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRQkGUuVh3gE6L9cAkViA3PO4Y/y2wIWE1UR2Aak60w=;
        b=kNh3vSXW2utwI5XUZXpDsFXiRjhY1cuBZSyX2i2fx+kHuk9GSIsk2jfyxzTsLvNfpB
         KCPYmaCZpgO4xNe3gYnRhMHTZ4qoluGZF+Gw1sWcmBTo4deRYPtKbfp6vl20kWzAOiQg
         Wsixzly7XIrEyECldgbSggXQ+TkvUf0aLmUjbm/6AaFDTFJmR3IsEdSvHrOsB4UQIXro
         G+gCMuDdhMOXZLzTvM9+ItjcHMv5i6vxgN46BGG6mUBwTOFYZZazRCDodVHYSzVt5I70
         btG7NOB8LPpr/bnfYXRFeD3eEsTMIYn8AzW98R9nRoruYPFvazJOFFCEWgkN0tDRsHbl
         dUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhhXFTwhJsD/2g9qMKm7eNNeHUwkqKVUaR/QceI1Gx2RvwuHCz8ZuP6oNxNwUcMz83tB/GpI2U7CKI2O1kAH/wAIBXZSzG2gxu8ITc
X-Gm-Message-State: AOJu0Yz6jDIs4Cxi9i2rx7Hocf0RGBDwvSvleUot4fM12vr1ea+3bLsU
	HAeDvmzXXg9Ub6ui/PvvyE9vn7nhI4/cB+3Ta5HRXHEnXvdkpAVpFHNMh2BBJNhclKRCUscQyVN
	lqpbawm+8FFrWILZ9S/W0Pq6wOmNBIEiBIUjYMjrTFg8wj9RiRHzfd8ERjFpO4w==
X-Received: by 2002:a05:600c:1d0e:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-429eda1f0ebmr62274895e9.11.1724069439928;
        Mon, 19 Aug 2024 05:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2zdm9HmKkDxDAC5b2EiMcJogiqOO9XKRxe36sTZL9ONh8MSoRczyleUPhTemQ+M1iJocrBQ==
X-Received: by 2002:a05:600c:1d0e:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-429eda1f0ebmr62274735e9.11.1724069439370;
        Mon, 19 Aug 2024 05:10:39 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896be4sm10472049f8f.77.2024.08.19.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:10:38 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:10:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 05/13] acpi/ghes: rework the logic to handle HEST
 source ID
Message-ID: <20240819141037.12929696@imammedo.users.ipa.redhat.com>
In-Reply-To: <97fc9d96b52a13f07a481d8b9fe0a92f4f550faf.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<97fc9d96b52a13f07a481d8b9fe0a92f4f550faf.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 09:37:37 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current logic is based on a lot of duct tape, with
> offsets calculated based on one define with the number of
> source IDs and an enum.
> 
> Rewrite the logic in a way that it would be more resilient
> of code changes, by moving the source ID count to an enum
> and make the offset calculus more explicit.
> 
> Such change was inspired on a patch from Jonathan Cameron
> splitting the logic to get the CPER address on a separate
> function, as this will be needed to support generic error
> injection.

patch does too many things, that it's hard to review.
Please split it up on smaller distinct parts, with more specific
commit messages. (see some comments below)


> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes-stub.c      |   3 +-
>  hw/acpi/ghes.c           | 210 ++++++++++++++++++++++++---------------
>  hw/arm/virt-acpi-build.c |   5 +-
>  include/hw/acpi/ghes.h   |  17 ++--
>  4 files changed, 138 insertions(+), 97 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index c315de1802d6..8762449870b5 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,8 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
> +                            uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index df59fd35568c..7870f51e2a9e 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -28,14 +28,23 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "qemu/uuid.h"
>  
> -#define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
> -#define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> +#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> +#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
split out renaming part into a presiding separate patch,
so it won't mask a new code

> +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
>  


> -/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
> -#define ACPI_GHES_ERROR_SOURCE_COUNT        2
> +/*
> + * ID numbers used to fill HEST source ID field
> + */
> +enum AcpiHestSourceId {
> +    ACPI_HEST_SRC_ID_SEA,
> +    ACPI_HEST_SRC_ID_GED,
> +
> +    /* Shall be the last one */
> +    ACPI_HEST_SRC_ID_COUNT
> +} AcpiHestSourceId;
>  
this rename also should go into its own separate patch.

>  /* Generic Hardware Error Source version 2 */
>  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> @@ -63,6 +72,19 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * Offsets with regards to the start of the HEST table stored at
> + * ags->hest_addr_le, according with the memory layout map at
> + * docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/* ACPI 4.0: 17.3.2 ACPI Error Source */
> +#define ACPI_HEST_HEADER_SIZE    40
> +
> +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2 */
> +#define HEST_GHES_V2_TABLE_SIZE  92
> +#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -236,17 +258,17 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
> -void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> +static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  {
>      int i, error_status_block_offset;
>  
>      /* Build error_block_address */
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
>          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
>      }
>  
>      /* Build read_ack_register */
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
>          /*
>           * Initialize the value of read_ack_register to 1, so GHES can be
>           * writable after (re)boot.
> @@ -261,20 +283,20 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  
>      /* Reserve space for Error Status Data Block */
>      acpi_data_push(hardware_errors,
> -        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
> +        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_HEST_SRC_ID_COUNT);
>  
>      /* Tell guest firmware to place hardware_errors blob into RAM */
> -    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
> +    bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
>                               hardware_errors, sizeof(uint64_t), false);
>  
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
>          /*
>           * Tell firmware to patch error_block_address entries to point to
>           * corresponding "Generic Error Status Block"
>           */
>          bios_linker_loader_add_pointer(linker,
> -            ACPI_GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i,
> -            sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> +            ACPI_HW_ERROR_FW_CFG_FILE, sizeof(uint64_t) * i,
> +            sizeof(uint64_t), ACPI_HW_ERROR_FW_CFG_FILE,
>              error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
>      }
>  
> @@ -282,16 +304,39 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>       * tell firmware to write hardware_errors GPA into
>       * hardware_errors_addr fw_cfg, once the former has been initialized.
>       */
> -    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE,
> -        0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
> +    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> +                                     sizeof(uint64_t),
> +                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
> +}
> +
> +static bool ghes_notify_to_source_id(enum AcpiGhesNotifyType notify,
> +                                     enum AcpiHestSourceId *source_id)
> +{
> +    switch (notify) {
> +    case ACPI_GHES_NOTIFY_SEA:             /* ARMv8 */
> +        *source_id = ACPI_HEST_SRC_ID_SEA;
> +        return false;
> +    case ACPI_GHES_NOTIFY_GPIO:
> +        *source_id = ACPI_HEST_SRC_ID_GED;
> +        return false;
> +    default:
> +        /* Unsupported notification types */
> +        return true;
> +    }
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> -static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> +static void build_ghes_v2(GArray *table_data,
> +                          enum AcpiGhesNotifyType notify,
> +                          BIOSLinker *linker)

I'd suggest to drop this change as AcpiGhesNotifyType is not unique ID,
in fact one can easily have several ID with the same type.


>  {
>      uint64_t address_offset;
> +    enum AcpiHestSourceId source_id;
>  
> -    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +    if (ghes_notify_to_source_id(notify, &source_id)) {
> +        error_report("Error: notify %d not supported", notify);
> +        abort();
> +    }
>  
>      /*
>       * Type:
> @@ -319,24 +364,13 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>      build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                       4 /* QWord access */, 0);
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
> -        ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
> +                                   address_offset + GAS_ADDR_OFFSET,
> +                                   sizeof(uint64_t),
> +                                   ACPI_HW_ERROR_FW_CFG_FILE,
> +                                   source_id * sizeof(uint64_t));
>  
> -    switch (source_id) {
> -    case ACPI_HEST_SRC_ID_SEA:
> -        /*
> -         * Notification Structure
> -         * Now only enable ARMv8 SEA notification type
> -         */
> -        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
> -        break;
> -    case ACPI_HEST_SRC_ID_GED:
> -        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
> -        break;
> -    default:
> -        error_report("Not support this error source");
> -        abort();
> -    }
> +    /* Notification Structure */
> +    build_ghes_hw_error_notification(table_data, notify);
>  
>      /* Error Status Block Length */
>      build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
> @@ -350,9 +384,11 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>      build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                       4 /* QWord access */, 0);
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -        address_offset + GAS_ADDR_OFFSET,
> -        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> -        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
> +                                   address_offset + GAS_ADDR_OFFSET,
> +                                   sizeof(uint64_t),
> +                                   ACPI_HW_ERROR_FW_CFG_FILE,
> +                                   (ACPI_HEST_SRC_ID_COUNT + source_id) *
> +                                   sizeof(uint64_t));
>  
>      /*
>       * Read Ack Preserve field
> @@ -365,90 +401,100 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>  }
>  
>  /* Build Hardware Error Source Table */
> -void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
> +void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +                     BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id)
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>  
> +    build_ghes_error_table(hardware_errors, linker);
> +
> +    int hest_offset = table_data->len;
> +
>      acpi_table_begin(&table, table_data);
>  
>      /* Error Source Count */
> -    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
> -    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> -    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GED, linker);
> +    build_append_int_noprefix(table_data, ACPI_HEST_SRC_ID_COUNT, 4);
> +    build_ghes_v2(table_data, ACPI_GHES_NOTIFY_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_GHES_NOTIFY_GPIO, linker);
>  
>      acpi_table_end(linker, &table);
> +
> +    /*
> +     * tell firmware to write into GPA the address of HEST via fw_cfg,
> +     * once initialized.
> +     */
> +    bios_linker_loader_write_pointer(linker,
> +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                     sizeof(uint64_t),
> +                                     ACPI_BUILD_TABLE_FILE, hest_offset);
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>                            GArray *hardware_error)
>  {
>      /* Create a read-only fw_cfg file for GHES */
> -    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
> +    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
>      /* Create a read-write fw_cfg file for Address */
> -    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
> +    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
>  
> +    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +
>      ags->present = true;
>  }
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
> +                            uint64_t physical_address)
>  {
> -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> -    uint64_t start_addr;
> -    bool ret = -1;
> +    uint64_t cper_addr, read_ack_register = 0;
> +    uint64_t read_ack_start_addr;
> +    enum AcpiHestSourceId source;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> -    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +    if (ghes_notify_to_source_id(ACPI_HEST_SRC_ID_SEA, &source)) {
> +        error_report("GHES: Invalid error block/ack address(es) for notify %d",
> +                     notify);
> +        return -1;
> +    }
>  
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
>      g_assert(acpi_ged_state);
>      ags = &acpi_ged_state->ghes_state;
>  
> -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> +    cper_addr = le64_to_cpu(ags->ghes_addr_le);
> +    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
> +    read_ack_start_addr = cper_addr + source * sizeof(uint64_t);
>  
> -    if (physical_address) {
> +    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
> +    cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
>  
> -        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
> -            start_addr += source_id * sizeof(uint64_t);
> -        }
> -
> -        cpu_physical_memory_read(start_addr, &error_block_addr,
> -                                 sizeof(error_block_addr));
> -
> -        error_block_addr = le64_to_cpu(error_block_addr);
> -
> -        read_ack_register_addr = start_addr +
> -            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> -
> -        cpu_physical_memory_read(read_ack_register_addr,
> -                                 &read_ack_register, sizeof(read_ack_register));
> -
> -        /* zero means OSPM does not acknowledge the error */
> -        if (!read_ack_register) {
> -            error_report("OSPM does not acknowledge previous error,"
> -                " so can not record CPER for current error anymore");
> -        } else if (error_block_addr) {
> -            read_ack_register = cpu_to_le64(0);
> -            /*
> -             * Clear the Read Ack Register, OSPM will write it to 1 when
> -             * it acknowledges this error.
> -             */
> -            cpu_physical_memory_write(read_ack_register_addr,
> -                &read_ack_register, sizeof(uint64_t));
> -
> -            ret = acpi_ghes_record_mem_error(error_block_addr,
> -                                             physical_address);
> -        } else
> -            error_report("can not find Generic Error Status Block");
> +    if (!physical_address) {
> +        error_report("can not find Generic Error Status Block for notify %d",
> +                     notify);
> +        return -1;
>      }
>  
> -    return ret;
> +    cpu_physical_memory_read(read_ack_start_addr,
> +                             &read_ack_register, sizeof(read_ack_register));
> +
> +    /* zero means OSPM does not acknowledge the error */
> +
> +    read_ack_register = cpu_to_le64(0);
> +    /*
> +     * Clear the Read Ack Register, OSPM will write it to 1 when
> +     * it acknowledges this error.
> +     */
> +    cpu_physical_memory_write(read_ack_start_addr,
> +                              &read_ack_register, sizeof(uint64_t));
> +
> +    return acpi_ghes_record_mem_error(cper_addr, physical_address);
>  }
>  
>  NotifierList acpi_generic_error_notifiers =
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1769467d23b2..79635bc7a0a8 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -944,10 +944,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        build_ghes_error_table(tables->hardware_errors, tables->linker);
>          acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->linker, vms->oem_id,
> -                        vms->oem_table_id);
> +        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> +                        vms->oem_id, vms->oem_table_id);
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index b977d65564ba..6e349264fd8b 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -29,7 +29,7 @@
>  extern NotifierList acpi_generic_error_notifiers;
>  
>  /*
> - * Values for Hardware Error Notification Type field
> + * ACPI spec values for Hardware Error Notification Type field
>   */
>  enum AcpiGhesNotifyType {
>      /* Polled */
> @@ -60,24 +60,19 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> -/* Those are used as table indexes when building GHES tables */
> -enum {
> -    ACPI_HEST_SRC_ID_SEA = 0,
> -    ACPI_HEST_SRC_ID_GED,
> -    ACPI_HEST_SRC_ID_RESERVED,
> -};
> -
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t ghes_addr_le;
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;
>  
> -void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
> -void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
> +void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +                     BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
> +int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
> +                            uint64_t error_physical_addr);
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               enum AcpiGhesNotifyType notify, Error **errp);
>  


