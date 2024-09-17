Return-Path: <linux-kernel+bounces-331674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951497AFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5551C22567
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770AE1662E8;
	Tue, 17 Sep 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTrK+auw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383391EB35
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574383; cv=none; b=htSS7lFE0mfDD/CDFCGx6pXftRohGAnvGxqt2XtUanR3S6buXnF06fbmPYWSyDWoOwj/auAJ8ldATLcbNsBB2uLmaFSaSuJ8bPDs3cQKLqEOQ4OVbmoeMrtzqatLoBnlXs0/KShcXRpSjy/v0ZyidF2mqmhPm8QQXYu+TrizmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574383; c=relaxed/simple;
	bh=jV7fAjlGkXI4mLOzdNJdKxajzqDXIOCJq5HRGmq8z/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyfkGG27ocJNRWAxEMTUHmj0PfDTkKWP6mKoif9sm7DtY+fMztuh1N3uVBe8ujOan8N9oEuNz08YFY0GsDX4BsboA9XFVSltN7vWMy8FkKxsnTjvrEGTMVApMotx2G9pJSgqzh7yNIDTuF50nSMo7WOwszyaxLaPV9hyTt16TEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTrK+auw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726574380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0PJ7PkwEzbZGxWHx3WAu3PZd7aveOxf5Ybsvqj+2Y8=;
	b=aTrK+auwiQ5+R7CCX0JHufuPas63sn3+e4S24a1rSrAfrraR47qTPFWIdDEfQ8ZIGQd/yo
	sIG96C11BTTfWzXmLJMyePZGUT4pesigOGoSVV9qpijp/cwgHqxwOu7cBxhBsDI7cQ9bB8
	KMD0YorRCFCL1ZdCzcAz2u3oZea3F+0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-hxTpZIDVM2WppUkcEAQSeA-1; Tue, 17 Sep 2024 07:59:38 -0400
X-MC-Unique: hxTpZIDVM2WppUkcEAQSeA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374baf9f142so3135930f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726574377; x=1727179177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0PJ7PkwEzbZGxWHx3WAu3PZd7aveOxf5Ybsvqj+2Y8=;
        b=aUa3nGPGRbzcPn8HHGe/I+FlmPnuvA6D7n5e9JeYt5KsChZgXAkEjluPo5wSeCugNH
         6sYIJswfHkWV6eZS68U6auXjg9eOj8OmcmlQk8ibGoOU3kI3ZBEwBj+DZTgbeQ3l8fuM
         UU6A5WyS2zx5MOgqJKX8KWrhMTkUiQQLvjZ/P49we3iDQU51ArgpwCWwnb4moYmIETv1
         LKt/PlSO3EL8P7LBeM+NLCwZLpgXCOyZpjr6/wHjuMwhbZEbpf+/MveMr8lG3hltdWca
         /bNf7ZpKdWJIwAtCjqPu62fVqzlIPZk9uMMOEI7JOKNS7MBtt2BLWVPFN+M5hH3dMbwd
         KUeA==
X-Forwarded-Encrypted: i=1; AJvYcCWj+OaZ1L6g33yEOYRy/b+bk4Q/VeJYnMCHi8zDgBXCnmZIDm4/nl14LGkfRMWH9D4ksgXOXQvY5gVwdy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9TFa8beXXh2OWYHSvVBy4lmHYgJAy3NOOtTaCk0MAh8gx2J7
	YeNF7rqCeJ+R21+FCVfi+0N9G16qWnwm2XAu6uGHbA+ZFnQvW74rcSxaUtNjkKPeiiycHFFlBdJ
	JCiUfi1aLNgU4EgwYwOZ+y0nAmgwvIPA53zlGOeGub1kQCZWCorcCLwf0cO3pjQ==
X-Received: by 2002:a5d:4811:0:b0:374:c6ad:a7c6 with SMTP id ffacd0b85a97d-378c2d065c0mr9143148f8f.20.1726574377526;
        Tue, 17 Sep 2024 04:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjC41MYJffw19rKEKQL46pxo/mJddKgbcEKKYmVKZJhDrHTTgKw4LwBKde+I7JXBcisF/wAw==
X-Received: by 2002:a5d:4811:0:b0:374:c6ad:a7c6 with SMTP id ffacd0b85a97d-378c2d065c0mr9143133f8f.20.1726574376947;
        Tue, 17 Sep 2024 04:59:36 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780015dsm9361963f8f.69.2024.09.17.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 04:59:36 -0700 (PDT)
Date: Tue, 17 Sep 2024 13:59:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 07/21] acpi/ghes: rework the logic to handle HEST
 source ID
Message-ID: <20240917135934.38579213@imammedo.users.ipa.redhat.com>
In-Reply-To: <0dd7081717b23b4c1536bc86abfa926388cf2139.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<0dd7081717b23b4c1536bc86abfa926388cf2139.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 08:13:28 +0200
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

so this patch switches to using HEST to lookup error status block
by source id, though nothing in commit message mentions that.
Perhaps it's time to rewrite commit message to be more
specific/clear on what it's doing.  

now, I'd split this on several patches that should also take care of
wiring needed to preserve old lookup to keep migration with 9.1 machines
working:

 1. extract error status block read_ack addresses calculation/lookup
    into a separate function (just current code, without HEST lookup).
 2. since old lookup code handles only 1 source and won't ever see multiple
    error sources, simplify that as much as possible to keep old way simple
    (and mention that in commit message).
    it basically should take 1st error status block/read ack addresses from
    hardware_errors

 3. add to AcpiGedState a callback to with signature of #1 lookup func.
    (which will be used to switch between old/new code), by default set to
    old lookup func

 4. add to GED a bool property x-has-hardware_errors_addr = 1
    and use it in acpi_ged_realize() to set callback

          if x-has-hardware_errors_addr == 1
               callback = old_lookup

 5. add new HEST lookup func (not used yet with mentioning that follow up patch
    will use it)

 6. cleanup fwcfg based on x-has-hardware_errors_addr,
       i.e. for 'true':
          ask for write pointer to hardware_errors like it's done in current code
          and don't register hest_addr write pointer
       while for 'false'
          do opposite of above.


 7. flip x-has-hardware_errors_addr default to 0 and add to hw/core/machine.c
      hw_compat_9_1[] = {
          {ged type,  'x-has-hardware_errors_addr', 'true'},
      }
    this will make 9.1 and older machine types to use old lookup callback
    while newer machines will use default new lookup

that should take care of switching between new and old ABI,
i.e. which code qemu and guest will use/see.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> ---
> 
> Changes from v9:
> - patch split on multiple patches to avoid multiple changes
>   at the same patch.
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 95 ++++++++++++++++++++++++++++++------------
>  include/hw/acpi/ghes.h |  6 ++-
>  2 files changed, 73 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 36fe5f68782f..6e5f0e8cf0c9 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -61,6 +61,23 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * Offsets with regards to the start of the HEST table stored at
> + * ags->hest_addr_le, according with the memory layout map at
> + * docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_TABLE_SIZE  92
> +#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)
> +
> +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
> + * Table 18-380: 'Error Status Address' field
> + */
> +#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET)
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -401,11 +418,13 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>  
>  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>  {
> -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> -    uint64_t start_addr;
> -    bool ret = -1;
> +    uint64_t hest_read_ack_start_addr, read_ack_start_addr;
> +    uint64_t hest_addr, cper_addr, err_source_struct;
> +    uint64_t hest_err_block_addr, error_block_addr;
> +    uint32_t i, ret;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> +    uint64_t read_ack;
>  
>      assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
>  
> @@ -414,44 +433,66 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      g_assert(acpi_ged_state);
>      ags = &acpi_ged_state->ghes_state;
>  
> -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> +    hest_addr = le64_to_cpu(ags->hest_addr_le);
>  
>      if (!physical_address) {
>          return -1;
>      }
>  
> -    start_addr += source_id * sizeof(uint64_t);
> +    err_source_struct = hest_addr + ACPI_GHES_ERROR_SOURCE_COUNT;
>  
> -    cpu_physical_memory_read(start_addr, &error_block_addr,
> -                                sizeof(error_block_addr));
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */
> +    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +        uint64_t addr = err_source_struct;
> +        uint16_t type, src_id;
>  
> -    error_block_addr = le64_to_cpu(error_block_addr);
> +        cpu_physical_memory_read(addr, &type, sizeof(type));
>  
> -    read_ack_register_addr = start_addr +
> -        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +        /* For now, we only know the size of GHESv2 table */
> +        assert(type == ACPI_GHES_SOURCE_GENERIC_ERROR_V2);
>  
> -    cpu_physical_memory_read(read_ack_register_addr,
> -                                &read_ack_register, sizeof(read_ack_register));
> +        /* It is GHES. Compare CPER source address */
> +        addr += sizeof(type);
> +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
>  
> -    /* zero means OSPM does not acknowledge the error */
> -    if (!read_ack_register) {
> -        error_report("OSPM does not acknowledge previous error,"
> -            " so can not record CPER for current error anymore");
> -    } else if (error_block_addr) {
> -        read_ack_register = cpu_to_le64(0);
> -        /*
> -         * Clear the Read Ack Register, OSPM will write it to 1 when
> -         * it acknowledges this error.
> -         */
> -        cpu_physical_memory_write(read_ack_register_addr,
> -            &read_ack_register, sizeof(uint64_t));
> +        if (src_id == source_id) {
> +            break;
> +        }
>  
> -        ret = acpi_ghes_record_mem_error(error_block_addr,
> -                                            physical_address);
> -    } else {
> +        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
> +    }
> +    if (i == ACPI_GHES_ERROR_SOURCE_COUNT) {
>          error_report("can not find Generic Error Status Block");
> +
> +        return -1;
>      }
>  
> +    /* Navigate though table address pointers */
> +
> +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> +    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;
> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(error_block_addr, &cper_addr,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(hest_read_ack_start_addr, &read_ack_start_addr,
> +                             sizeof(read_ack_start_addr));
> +
> +    /* Update ACK offset to notify about a new error */
> +
> +    cpu_physical_memory_read(read_ack_start_addr,
> +                             &read_ack, sizeof(read_ack));
> +
> +    read_ack = cpu_to_le64(0);
> +    cpu_physical_memory_write(read_ack_start_addr,
> +                              &read_ack, sizeof(read_ack));
> +
> +    ret = acpi_ghes_record_mem_error(error_block_addr, physical_address);
>      return ret;
>  }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index c9bbda4740e2..7485f54c28f2 100644
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
> @@ -74,7 +75,10 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
> +int acpi_ghes_record_errors(uint8_t source_id,
> +                            uint64_t error_physical_addr);
> +void ghes_record_cper_errors(const void *cper, size_t len,
> +                             uint16_t source_id, Error **errp);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present


