Return-Path: <linux-kernel+bounces-276399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D448594931C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EF41C23C87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE71BE875;
	Tue,  6 Aug 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYXLdL0h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF841BE23A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954680; cv=none; b=ts9NQ/uZt52i0Ts7zN22BYswKGSYt4sb2zZNYkoAeGNbUNSjmTjG2TZBCIRkLEPahMKfcBsD+vxFe3lQT07IpK2ieDBXKekhZuVU+kwCHaWcJ7vqf9a1Qgl9Dq3Y9CFatCe8/5QD2cvTaKlLFeWxNiBJoOgUCdnAj//0QUyzBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954680; c=relaxed/simple;
	bh=XYMqqZrK4GA7mzMtl+TAohnD8td6UX/kc1Pp1MGV8Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUZ3JUJn3/6v6WSWMUaZzYrEnMr0tEjP1onB7YIYJln+T9063QnmSvK/fBjXXCoTrs4jAXcFOn23ultx2jgxwaK8/rKRyFjHOzPASKfzL1OyhqdLtsbUKkJorzA4Y5kq4aCz3DSzvtqp/NCiDNdqEdTvQngmupVkMmJoAefLYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYXLdL0h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722954678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvF8Xylsgtl9CdwpW85ezra0SLl7EikGkhlaTaeGrqo=;
	b=ZYXLdL0hIIQV67PawJzd4SIEOpdFWABZfmXJrcmrbnafubZmriyw1rMg4kPcrZQr4VtIQ3
	fM/suvpL2p+63nL4tctWGz9H/qUtIUom0ELLQwef4zoc7vj12/2Q2TkU7k6c/CTMMMEN/z
	UhuuneHjs8XLDl52UA1I1vmdQXPTukw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-6d6R4jL4OA6rEjAa3NqWXQ-1; Tue, 06 Aug 2024 10:31:16 -0400
X-MC-Unique: 6d6R4jL4OA6rEjAa3NqWXQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so5189275e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954675; x=1723559475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvF8Xylsgtl9CdwpW85ezra0SLl7EikGkhlaTaeGrqo=;
        b=W3+GtuL+qMae20VTsT+Q6W8oxOGrb0MKBWI+NOZUI3BD77QjX1t6scaX/OOBGJmZET
         IQMcvuRvu+sjO+sNfB9X0f4u3vkG5qFfcB5/m7pPTs9f4Fnb8HqJ2nKv+uHPnYWSGbLI
         mzYO9bWSVOPkRHaRwmptvgsnxVBgCwKJSRwfdM+y1ueIgfm/suB5T0K+10erOwqd0gkH
         VIaoU4SqDOjOrz+qjPVzs91Po5/VH5U0wJkRM33KpDyQjqYXAE2dJ5fUaFw9kV99yjTB
         4FdDR3K7LlsF8XMFR6I4l33d52FSW5SN5u5KjfWQlR47BJrdExHzasWbxM7v53+i0YP3
         bWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3LLvfQ+r4LGd+xuKPRDSP6t3JXxi7xZrGRbX3C0fJodKQUlY0zqOUOP6X4/GjC7x7QEoRad+0oZLRza+E1wBKDhF+AmAe4OWhtSq4
X-Gm-Message-State: AOJu0Yxg3uoi9PRp3TEeT1hAd1+YH0oU9NeSUM2QJ0fEr2mQNLAloITq
	pZ3ke3BQpQCcHXb2p1ggNOFhOSgFv/OLczuqyxZ5goGMucaGXh9L98jNO+2UQYDVvrfp5ArMuXB
	1rIvzDW0IJymi3QDtTtqYh23okjneXv0gzh5JhIvIuxK47zx2/ly9s625ywwPNQ==
X-Received: by 2002:a05:600c:580a:b0:428:f1b4:3473 with SMTP id 5b1f17b1804b1-428f1b4398bmr71197155e9.26.1722954674989;
        Tue, 06 Aug 2024 07:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6CXrSXKowS/TTkQO0vuI6Ltcbfrl8sA8YRQn6TA2/2Si4QscTPGDCiUgWPfAr3SBEngAprA==
X-Received: by 2002:a05:600c:580a:b0:428:f1b4:3473 with SMTP id 5b1f17b1804b1-428f1b4398bmr71196805e9.26.1722954674364;
        Tue, 06 Aug 2024 07:31:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428ebbe18c0sm161469075e9.17.2024.08.06.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:31:13 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:31:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 23:44:01 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Provide a generic interface for error injection via GHESv2.
> 
> This patch is co-authored:
>     - original ghes logic to inject a simple ARM record by Shiju Jose;
>     - generic logic to handle block addresses by Jonathan Cameron;
>     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> 
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
>  hw/acpi/ghes_cper.c    |   2 +-
>  include/hw/acpi/ghes.h |   3 +
>  3 files changed, 152 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index a745dcc7be5e..e125c9475773 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> +static uint64_t ghes_get_state_start_address(void)

ghes_get_hardware_errors_address() might better reflect what address it will return

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
>          start_addr += source_id * sizeof(uint64_t);

above should be a separate patch

>  
> @@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
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
> + * | | read_ack0           |
> + * | +---------------------+ --+--
> + * | | read_ack1           | GHES_ADDRESS_SIZE
> + * | +---------------------+ --+--
> + * | |   .............     |
> + * | +---------------------+
> + * | | read_ackN           |
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

no need to duplicate docs/specs/acpi_hest_ghes.rst,
I'd just reffer to it and maybe add short comment as to why it's mentioned.

> +/* Map from uint32_t notify to entry offset in GHES */
> +static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
> +                                                 0xff, 0xff, 0xff, 1, 0};
> +
> +static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
> +                          uint64_t *read_ack_addr)
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
> +    *read_ack_addr = base +
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

I don't like all this pointer math, which is basically a reverse engineered
QEMU actions on startup + guest provided etc/hardware_errors address.

For once, it assumes error_source_to_index[] matches order in which HEST
error sources were described, which is fragile.

2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
in RAM migrated from older version might not match above assumptions
of target QEMU. 

I see 2 ways to rectify it:
  1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
       in guest RAM, like we do with etc/hardware_errors, see
            build_ghes_error_table()
               ...
               tell firmware to write hardware_errors GPA into
       and then fetch from HEST table in RAM, the guest patched error/ack addresses
       for given source_id

       code-wise: relatively simple once one wraps their own head over
                 how this whole APEI thing works in QEMU
                 workflow  is described in docs/specs/acpi_hest_ghes.rst
                 look to me as sufficient to grasp it.
                 (but my view is very biased given my prior knowledge,
                  aka: docs/comments/examples wrt acpi patching are good enough)
                 (if it's not clear how to do it, ask me for pointers)

  2nd:  sort of hack based on build_ghes_v2() Error Status Address/Read Ack Register
        patching instructions
               bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,                
                   address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),                      
                   ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^
        during build_ghes_v2() also store on a side mapping
             source_id -> error address offset : read ack address

        so when you are injecting error, you'd at least use offsets
        used at start time, to get rid of risk where injection code
        diverge from HEST:etc/hardware_errors layout at start time.

        However to make migration safe, one would need to add a fat
        comment not to change order ghest error sources in HEST _and_
        a dedicated unit test to make sure we catch it when that happens.
        bios_tables_test should be able to catch the change, but it won't
        say what's wrong, hence a test case that explicitly checks order
        and loudly & clear complains when we will break order assumptions.

        downside:
           * we are are limiting ways HEST could be composed/reshuffled in future
           * consumption of extra CI resources
           * and well, it relies on above duct tape holding all pieces together

>  NotifierList generic_error_notifiers =
>      NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
>  
> +void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
> +                             uint32_t notify)
> +{
> +    int read_ack = 0;
       ^^^
[...]
> +    cpu_physical_memory_read(read_ack_addr,
> +                             &read_ack, sizeof(uint64_t));
                                                  ^^^^
it looks like possible stack corruption, isn't it?

> +    /* zero means OSPM does not acknowledge the error */
> +    if (!read_ack) {
> +        error_setg(errp,
> +                   "Last CPER record was not acknowledged yet");
> +        read_ack = 1;
> +        cpu_physical_memory_write(read_ack_addr,
> +                                  &read_ack, sizeof(uint64_t));
                                                        ^^^^^
and then who knows what we are writing back here

> +        return;
> +    }
> +
> +    read_ack = cpu_to_le64(0);
> +    cpu_physical_memory_write(read_ack_addr,
> +                              &read_ack, sizeof(uint64_t));
> +
> +    /* Build CPER record */
> +
> +    /*
> +     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> +     * Table 17-13 Generic Error Data Entry
> +     */
> +    QemuUUID fru_id = {};
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +    data_length = ACPI_GHES_DATA_LENGTH + cper->data_len;
> +
> +    /*
> +        * It should not run out of the preallocated memory if
> +        * adding a new generic error data entry
> +        */
> +    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> +            ACPI_GHES_MAX_RAW_DATA_LENGTH);
it's better to error out gracefully here instead of crash
in case script generated too long record,
not the end of the world, but it's annoying to restart guest
on external mistake.

PS:
looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
and it is the total size of a error block for a error source.

However acpi_hest_ghes.rst (3) says it should be 4K,
am I mistaken? 


> +    /* Build the new generic error status block header */
> +    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> +                                    0, 0, data_length,
> +                                    ACPI_CPER_SEV_RECOVERABLE);
> +
> +    /* Build this new generic error data entry header */
> +    acpi_ghes_generic_error_data(block, cper->guid,
> +                                ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> +                                cper->data_len, fru_id, 0);
> +

not that I mind, but I'd ax above calls with their hardcoded
assumptions and make script generate whole error block,
it's more flexible wrt ACPI_CPER_SEV_RECOVERABLE/ACPI_GEBS_UNCORRECTABLE
and then one can ditch from QAPI interface cper->guid.

basically inject whatever user provided via QAPI without any other assumptions.

> +    /* Add CPER data */
> +    for (i = 0; i < cper->data_len; i++) {
> +        build_append_int_noprefix(block, cper->data[i], 1);
> +    }
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_addr, block->data, block->len);
> +
> +    g_array_free(block, true);
> +
> +    notifier_list_notify(&generic_error_notifiers, NULL);
> +}
> +
>  bool acpi_ghes_present(void)
>  {
>      AcpiGedState *acpi_ged_state;
> diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> index 7aa7e71e90dc..d7ff7debee74 100644
> --- a/hw/acpi/ghes_cper.c
> +++ b/hw/acpi/ghes_cper.c
> @@ -39,7 +39,7 @@ void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
>          return;
>      }
>  
> -    /* TODO: call a function at ghes */
> +    ghes_record_cper_errors(&cper, errp, ACPI_GHES_NOTIFY_GPIO);
>  
>      g_free(cper.data);
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 06a5b8820cd5..ee6f6cd96911 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -85,6 +85,9 @@ typedef struct AcpiGhesCper {
>      size_t data_len;
>  } AcpiGhesCper;
>  
> +void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
> +                             uint32_t notify);

maybe rename it to acpi_ghes_inject_error_block()

> +
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
>   *


