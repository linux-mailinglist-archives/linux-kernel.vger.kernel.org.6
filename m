Return-Path: <linux-kernel+bounces-418477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822889D6213
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF30160EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125781DF75B;
	Fri, 22 Nov 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpQq4v1i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772121DF26F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292393; cv=none; b=ZQU8nAWV7cH3uo9ixPfXG7g0y0HCUJ/fKVbBRwvA46srNaVGAhGuL46XRMWt250zocSIYaG/uGkBj4R+ZkYdDLKGYOuYscYJUHscO+WLxtxNY88g6NLPLRdsH8kWPyk+ZLc3JSNMZpg8Po1FEoJnGKTgHDZUj1F00AItzEykEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292393; c=relaxed/simple;
	bh=YHrtYeGkPSX56+UC0fq7YdfB6TT+23Sf7FpGauSgvRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpspaeyI9HhQZQ2/IUo3ZutClPWFfGWMHQWZgGoxYLqF8wRLjEv/+leh7kz1QujLWVqKJYgkod2m6RsqknBSJBrdjkS2XYrsE9rR0VkFBZmLamev7kXcDkUnD5BGiztL1PkogaL/LC2ITNa66sHlB7wKXhkkBgZU7gnXPDTsx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpQq4v1i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732292389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCg2yuM5W+19EEUOO4BPnlKZkKEAq+aS7UcMcDWPQ+8=;
	b=MpQq4v1i3vLj4yamTVlyFSJGLeQZNnCZuG1/jy5hATGGFlN/Hu7NG0Jw0FQO33XRBRmcXz
	Ejz2XM971XcCyBS3HFIQPqoWBLFHGrfHg00Ebj6C4S61QJs+uHP/MoXB462RaK5ScqNLeE
	ViyofnS2YS9OCwbtqT1cxiKQT2X9XI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-WIJSH5kvPGGrByrgrD37bA-1; Fri, 22 Nov 2024 11:19:48 -0500
X-MC-Unique: WIJSH5kvPGGrByrgrD37bA-1
X-Mimecast-MFC-AGG-ID: WIJSH5kvPGGrByrgrD37bA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4317391101aso17074325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292387; x=1732897187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCg2yuM5W+19EEUOO4BPnlKZkKEAq+aS7UcMcDWPQ+8=;
        b=GEYA0HnJ1z+5yNMKSEp8/8yyAVz9Ljaflwab/MvoG1Wx5n/Vp6VV9lAJGJVNXdB1IY
         spuMvmdf4MArDEYk9NldP8jovBGn4ks6bsOBH0bS3pERUoXwsm2KYedHWGsEgnhWVTuH
         BezDqMNk3g7SZUDsohJEYrFmGgz2+T+eWGcpeLR4w1sA4PxrRIJFjJc2hL9Rm4EjwI+B
         W3hoxELo5VvM5yy/HFxxfIgSJbdNmBVZvxHgWQARA65yxk88a/RdRzSTET4i1dS59qiQ
         S80juobwAcFFS695NyrIISyyvsA7wdABuocPEjuHqPk/7HR9P+x+eXL7dyPI2c9blP2z
         EKsg==
X-Forwarded-Encrypted: i=1; AJvYcCURv/b/EqLaY7h5PpE3sTJh4R4D2o2hopGxaaVIvFq7MUsDJKJOswihOgfK1ZpqDOPhW+oOecWWkPkKFkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WFI8d7JgyiUGX8z7hvIbIYjCJaeElqHX1lxu6Shc1xnlpbam
	01DlC9WKdwB2U1oHvck2Ucc+oWAcEMlO9C0Sdzc0FmaAscfGbAlxho+XO2pBqCekry2B5DQ1ktT
	U0kHIQ8f+uuUflrpm4j5G8NnEU+vvx5YbLQIlO4o/QYMTHEa9q2sR/uXStMH0ig==
X-Gm-Gg: ASbGncvyoMJkmw10Unf7vgBUlRsVxZS0P6T7bfz5S9jR3YPAUlrAdCnvWf5B259U159
	cFkjIl4QV6YMNiTTTKVN12Dtd3ZiqBEeQAs+dfG9t2z6yPmvxRlzMmMw4jdlSdQc3BIG259Jy3L
	vud5WaFeRVVfOghAuTXkftsVAgyrU0Ny8i0nlJWzrBHT3fGt9DtmHt2rUcxIlxQYtdHPvvukg79
	Ha9toPaUK5mFPxFoxkFriCXOQyPxSiGlz8tDfJto47QZJPwQTnmd5m2hquIZcS3SbzT54C0Q25H
	c4ZFu9tomDz9ub4kONOLFA==
X-Received: by 2002:a05:600c:5249:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-433ce430fecmr35261955e9.16.1732292386745;
        Fri, 22 Nov 2024 08:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ5F4SS+K5lU7ZFW505v8/HgGCRPl1DEiwl8bnpjDtVFsBv5hAy2w/QGKtkgermsR+QX+Mtg==
X-Received: by 2002:a05:600c:5249:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-433ce430fecmr35261725e9.16.1732292386365;
        Fri, 22 Nov 2024 08:19:46 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fd04ec7sm2780626f8f.110.2024.11.22.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:19:45 -0800 (PST)
Date: Fri, 22 Nov 2024 17:19:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241122171944.4b5ac367@imammedo.users.ipa.redhat.com>
In-Reply-To: <b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 10:11:25 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Split the code into separate functions to allow using the
> common CPER filling code by different error sources.
> 
> The generic code was moved to ghes_record_cper_errors(),
> and ghes_gen_err_data_uncorrectable_recoverable() now contains
> only a logic to fill the Generic Error Data part of the record,
> as described at:
> 
> 	ACPI 6.2: 18.3.2.7.1 Generic Error Data
> 
> The remaining code to generate a memory error now belongs to
> acpi_ghes_record_errors() function.
> 
> A further patch will give it a better name.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 131 ++++++++++++++++++++++++-----------------
>  include/hw/acpi/ghes.h |   3 +
>  2 files changed, 79 insertions(+), 55 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index edc74c38bf8a..a96856d5110b 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -181,51 +181,24 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
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
> -
> -    block = g_array_new(false, true /* clear */, 1);
> -
> -    /* This is the length if adding a new generic error data entry*/
> -    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> -    /*
> -     * It should not run out of the preallocated memory if adding a new generic
> -     * error data entry
> -     */
> -    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> -            ACPI_GHES_MAX_RAW_DATA_LENGTH);
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
> @@ -383,15 +356,18 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
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
> -    assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
> +    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> +        error_setg(errp, "GHES CPER record is too big: %ld", len);
> +        return;
> +    }
>  
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
> @@ -400,16 +376,16 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
> -    if (!physical_address) {
> -        return -1;
> -    }
> -
>      start_addr += source_id * sizeof(uint64_t);
>  
>      cpu_physical_memory_read(start_addr, &error_block_addr,
>                               sizeof(error_block_addr));
>  
>      error_block_addr = le64_to_cpu(error_block_addr);
> +    if (!error_block_addr) {
> +        error_setg(errp, "can not find Generic Error Status Block");
> +        return;
> +    }
>  
>      read_ack_register_addr = start_addr +
>                               ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> @@ -419,24 +395,69 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
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
> +     * Clear the Read Ack Register, OSPM will write it to 1 when
> +     * it acknowledges this error.
> +     */
> +    cpu_physical_memory_write(read_ack_register_addr,
> +        &read_ack_register, sizeof(uint64_t));
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_addr, cper, len);
> +
> +    return;
> +}
> +
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +{
> +    /* Memory Error Section Type */
> +    const uint8_t guid[] =
> +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> +                  0xED, 0x7C, 0x83, 0xB1);
> +    Error *errp = NULL;
> +    int data_length;
> +    GArray *block;
> +
> +    if (!physical_address) {
> +        error_report("can not find Generic Error Status Block for source id %d",
> +                     source_id);

isn't it a copy paste error from somewhere, perhaps it's mixed up with something else?
Granted, the check was there before patches but error message seems bogus.

Also 'physical_address' is a faulty page here, and 0 is as valid as any other value.
I'd say we should drop the check, and if from ARM/KVM pov 0 addr shouldn't exist
then it should be up to caller to filter it out and not call  acpi_ghes_record_errors()
in the 1st place.


> +        return -1;
> +    }
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +
> +    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> +    /*
> +     * It should not run out of the preallocated memory if adding a new generic
> +     * error data entry
> +     */
> +    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> +            ACPI_GHES_MAX_RAW_DATA_LENGTH);
> +
> +    ghes_gen_err_data_uncorrectable_recoverable(block, guid,
> +                                                data_length);
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
> index 9295e46be25e..8859346af51a 100644
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
> @@ -73,6 +74,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             uint16_t source_id, Error **errp);
>  int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
>  
>  /**


