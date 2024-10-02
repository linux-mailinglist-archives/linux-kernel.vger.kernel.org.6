Return-Path: <linux-kernel+bounces-347546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E098D443
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE771C21496
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2D31D0409;
	Wed,  2 Oct 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHhDP1YL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF21D0426
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874907; cv=none; b=bqWEzzFLx30k4Z9vaIMISrZWZlJy2tyDUCibdTow1mqPXqPW0tdp3TJavz6DeGqDi/GsKDR0MjoiUpC1di2e0NOM7gvjtXef+68Qi82MrWRIAnpXzGrBXRcvHB8N6IFAPgYa1Mwj9Bxha0PIQylV1Gp0oGMUZv6w7pbhRCPnXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874907; c=relaxed/simple;
	bh=5VQW1E4z+cNoKay6Lnj7ZvSNIk2tl6HF5nTXe5YXmt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7jFowkuRQ7hg9VB93RrHfmYbpM8S5gZr4wmJsbSeCJkafhHBYxo04IT2Mz6fGRK3b1vdQiGKzOCka1Aj3wuTU4NlnnBYo1DDxTAd8ai5Xdw0o8j3ZfCau4K6rgfB3RHJLXsiSfEzdJcfG9XK1i2s6HGY2/9ATX7pDY58Lws5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHhDP1YL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727874904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvjBB4Z24fOzaO8VMYHdIrBr4Huj0MDAFDPneoWKBqY=;
	b=dHhDP1YLzds1OHSEZ0et3S8wGuzAZUe/H7gebK9Zws165TEUcN0f65fBj8BXzPcciYG968
	Jiu2gLpLwBE9hktbEWwQ3cjMcdBRHmCXOY5xZh2ykHYUiameXhqfk2FsPfqXbQTz0Na0Qy
	R8nD4nb3j6Qrqz2GMxlER4Xz/wo2uo0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-vXrpOXM3O0-SKPYEWRwYrw-1; Wed, 02 Oct 2024 09:15:01 -0400
X-MC-Unique: vXrpOXM3O0-SKPYEWRwYrw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37cdbe8a6e8so2304815f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874900; x=1728479700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvjBB4Z24fOzaO8VMYHdIrBr4Huj0MDAFDPneoWKBqY=;
        b=UleHGDxkUa1mNYvt0eZLBCb+D1D49ySt02G3ycsHx12XNnNA/yXDWYkVbjrqfhoZO6
         u9UBVzAQiAA66nPMz5WsjMZJWK7NhIXVaGlLc9Yw3Ps6u4viyaxyYGc65yuc1gKuuBcG
         x8lbPvl3CBVTEHy7UQhk2I+GAG/BbQpiITlvgv3os2+ZK30hCCQ37F3jB26fRwn4HvCt
         9HXJRWOKctXY99WwTVRY6lKAxF2/dX5nRkbni9hxNAkwj3xr6rNCUd0eFl0XQj6/J8SL
         Hqy8gdworxU2JChSSIfxO75byqYs7MK2CP12uAhzZUKWxd4TDer1CxiDoNOEjJXbnDrI
         28tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYoQDD7vTWM4VRk3CHBhJHbEEHDrbpiM3DU2TYhUaNQ33fjyG1jKpAuS+b5YLpL+FXtNtEAn5KsrOmjTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfVhaO+StF5Wv8VrARhQFuVpvo3ewN4mT1+XG6kzHxZYvSHYK
	7LZ6matna0lAF/v6ZYgjp9KqaWRWGqMY9iX2IE6vAq4J9w09Tz6BN42mUSmel6tMCoUR9I9Pxae
	T9BMBlcjceMNnVYGWowA9LSlq2+0FbFnp1J8tfdJqRHqfjd6e2V9pHYNr6m0P6g==
X-Received: by 2002:adf:a1c2:0:b0:371:c51a:3b2a with SMTP id ffacd0b85a97d-37cfb8b5378mr2031302f8f.4.1727874899718;
        Wed, 02 Oct 2024 06:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkMHxCYjUvECqHmJ9+LIr7wZGQNEWn+AD2XDU2j1KDH6HKGZYaiarIjgfsYO9+B30oElXsAQ==
X-Received: by 2002:adf:a1c2:0:b0:371:c51a:3b2a with SMTP id ffacd0b85a97d-37cfb8b5378mr2031285f8f.4.1727874899275;
        Wed, 02 Oct 2024 06:14:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57450c7sm13828486f8f.101.2024.10.02.06.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:14:57 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:14:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241002151456.1135d663@imammedo.users.ipa.redhat.com>
In-Reply-To: <e3e5f093e97508a1e668f90203d6ef0c496d0dc1.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
	<e3e5f093e97508a1e668f90203d6ef0c496d0dc1.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 09:03:46 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Split the code into separate functions to allow using the
> common CPER filling code by different error sources.
> 
> The generic code was moved to ghes_record_cper_errors(),
> and ghes_gen_err_data_uncorrectable_recoverable() now contains
> only a logic to fill GEGB part of the record.
> 
> The remaining code to generate a memory error now belongs to
> acpi_ghes_record_errors() function.
> 
> A further patch will give it a better name.

checkpatch is not happy with you.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 118 +++++++++++++++++++++++++----------------
>  include/hw/acpi/ghes.h |   3 ++
>  2 files changed, 74 insertions(+), 47 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index f3d0283beb3b..628fa9b22f4b 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -181,51 +181,30 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
>      build_append_int_noprefix(table, 0, 7);
>  }
>  
> -static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> -                                      uint64_t error_physical_addr)
> +static void
> +ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
> +                                            const uint8_t *section_type,
> +                                            int data_length)
>  {
> -    GArray *block;
> -
> -    /* Memory Error Section Type */
> -    const uint8_t uefi_cper_mem_sec[] =
> -          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> -                  0xED, 0x7C, 0x83, 0xB1);
> -
>      /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
>       * Table 17-13 Generic Error Data Entry
>       */
>      QemuUUID fru_id = {};
> -    uint32_t data_length;
>  
> -    block = g_array_new(false, true /* clear */, 1);
> -
> -    /* This is the length if adding a new generic error data entry*/
> -    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
>      /*
> -     * It should not run out of the preallocated memory if adding a new generic
> -     * error data entry
> +     * Calculate the size with this block. No need to check for
> +     * too big CPER, as CPER size is checked at ghes_record_cper_errors()
>       */
> -    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> -            ACPI_GHES_MAX_RAW_DATA_LENGTH);
> +    data_length += ACPI_GHES_GESB_SIZE;
>  
>      /* Build the new generic error status block header */
>      acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
>          0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
>  
>      /* Build this new generic error data entry header */
> -    acpi_ghes_generic_error_data(block, uefi_cper_mem_sec,
> +    acpi_ghes_generic_error_data(block, section_type,
>          ACPI_CPER_SEV_RECOVERABLE, 0, 0,
>          ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
> -
> -    /* Build the memory section CPER for above new generic error data entry */
> -    acpi_ghes_build_append_mem_cper(block, error_physical_addr);
> -
> -    /* Write the generic error data entry into guest memory */
> -    cpu_physical_memory_write(error_block_address, block->data, block->len);
> -
> -    g_array_free(block, true);
> -
> -    return 0;
>  }
>  
>  /*
> @@ -399,14 +378,19 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             uint16_t source_id, Error **errp)
>  {
>      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
>      uint64_t start_addr;
> -    bool ret = -1;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> +    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> +        error_setg(errp, "GHES CPER record is too big: %ld", len);
> +        return;
> +    }
> +
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
>      g_assert(acpi_ged_state);
> @@ -422,6 +406,10 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>                               sizeof(error_block_addr));
>  
>      error_block_addr = le64_to_cpu(error_block_addr);
> +    if (!error_block_addr) {
> +        error_setg(errp, "can not find Generic Error Status Block");
> +        return;
> +    }
>  
>      /*
>       * As the current version supports only one source, the ack offset is


> @@ -434,24 +422,60 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  
>      /* zero means OSPM does not acknowledge the error */
>      if (!read_ack_register) {
> -        error_report("OSPM does not acknowledge previous error,"
> -                     " so can not record CPER for current error anymore");
> -    } else if (error_block_addr) {
> -        read_ack_register = cpu_to_le64(0);
> -        /*
> -         * Clear the Read Ack Register, OSPM will write it to 1 when
> -         * it acknowledges this error.
> -         */
> -        cpu_physical_memory_write(read_ack_register_addr,
> -                                  &read_ack_register, sizeof(uint64_t));
> -
> -        ret = acpi_ghes_record_mem_error(error_block_addr,
> -                                         physical_address);
> -    } else {
> -        error_report("can not find Generic Error Status Block");
> +        error_setg(errp,
> +                   "OSPM does not acknowledge previous error,"
> +                   " so can not record CPER for current error anymore");
> +        return;
>      }
>  
> -    return ret;
> +    read_ack_register = cpu_to_le64(0);
> +    /*
> +        * Clear the Read Ack Register, OSPM will write it to 1 when
> +        * it acknowledges this error.
> +        */
> +    cpu_physical_memory_write(read_ack_register_addr,
> +        &read_ack_register, sizeof(uint64_t));
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_addr, cper, len);
> +
> +    return;
> +}

this hunk is 'reduce indent' mostly, so do that in separate patch 1st.


> +
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +{
> +    /* Memory Error Section Type */
> +    const uint8_t guid[] =
> +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> +                  0xED, 0x7C, 0x83, 0xB1);
> +    Error *errp = NULL;
> +    GArray *block;
> +
> +    if (!physical_address) {
> +        error_report("can not find Generic Error Status Block for source id %d",
> +                     source_id);
> +        return -1;
> +    }
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +
> +    ghes_gen_err_data_uncorrectable_recoverable(block, guid,
> +                                                ACPI_GHES_MAX_RAW_DATA_LENGTH);
> +
> +    /* Build the memory section CPER for above new generic error data entry */
> +    acpi_ghes_build_append_mem_cper(block, physical_address);
> +
> +    /* Report the error */
> +    ghes_record_cper_errors(block->data, block->len, source_id, &errp);
> +
> +    g_array_free(block, true);
> +
> +    if (errp) {
> +        error_report_err(errp);
> +        return -1;
> +    }
> +
> +    return 0;
>  }
>  
>  bool acpi_ghes_present(void)
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index d6e2801d9cd9..1b988ac1e2f2 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,7 @@
>  #define ACPI_GHES_H
>  
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qapi/error.h"
>  
>  /*
>   * Values for Hardware Error Notification Type field
> @@ -80,6 +81,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             uint16_t source_id, Error **errp);
>  int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
>  
>  /**


