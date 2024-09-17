Return-Path: <linux-kernel+bounces-331493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F386497AD78
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D221C2083E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A474715B561;
	Tue, 17 Sep 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HICdaKyb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4A150990
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563709; cv=none; b=jfu+gEaz1AVts3mGyQyDTFQILygCa7py5DNUsoFpj9+A3xoj3eSSrVA/INexlYXAQAFkiZTtTL5bRFkoor9NnhgCxSNcF+IbbyNXk7eSyiQZqZEkzD9JUEJYZMQdmL/0vjTWrulSWmgJy6TLCSCSIq//22HsjrV+kI4ZeCiGY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563709; c=relaxed/simple;
	bh=BlDUbT47GIGX4rITfvQv4sM6dQqXkesAfDkv+0oBUc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIRFhFRf8MnED5cMJnaQhjdst7e5CI8zmENyvACdxWRdEafhwGpcKYixc2kY0Fo+/2teOse50t2L7egedFQmAx1TgFpEsANdKkByOvbJvp9atNlU3Z3v2e9VLs2zcvLQ1qIIblWZZu/qIu65bIZ1P+TWUueM6NXrxYSP3gWfcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HICdaKyb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726563706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1ZF6Dnn/S7K1sptevxsBbHlA1Am2fEgJoTIq25gz3I=;
	b=HICdaKybfYbxkh/ZE6F8SWcp8DlcI7GpdqmEncz/w0pjeapgUfAyMo65CRdXsiKa0Vg1hw
	t+JP0HdfpWOFI4SkIWPukEt+jNzIHdAsSewB0/IaEpRiJdTrsS19QMFZN/G3RNQ/X1XJBg
	s7oziopH6RSgZPXf0jE+b+0io7sPKD4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-04fUd655PyyxD5x65flKCg-1; Tue, 17 Sep 2024 05:01:45 -0400
X-MC-Unique: 04fUd655PyyxD5x65flKCg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f7538dc9d7so38266631fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726563704; x=1727168504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1ZF6Dnn/S7K1sptevxsBbHlA1Am2fEgJoTIq25gz3I=;
        b=o4AGfpJOzaedmQ8atPcsXx/M/ZG0bS7wAu1r0WSRbM90JFXyo7jb+O34HFps08cLcW
         gxuuYe/ZRupjWgaGx3BLQwjMtK125hvwzCnR5CThW/RSteIfh5M0NANVCKiMGOZ35jz+
         Lq1v8/0qN6dPj0li8VYS6O8U0+yjfClUh8XdSvXLCyiZX6L+FCFkO6ghBnHHd9D4jhqo
         E9X86ataX8ZODdV4dIk62NAQUqon+UiT98pZBRoobgzSJ31V8/LNV/SdJkGxoTxMqMtk
         isi3+pbxz1mbMuFAuL9BaSh7SZeAa1988RZlKnB53IRC3+qbCqhgxxOhzy0rOeAYlQOP
         gbrA==
X-Forwarded-Encrypted: i=1; AJvYcCVzxSLFWl33uu7IPi4MfrDmMU9AWytdRN1zg2qKPsIJrzfpaeWhlHsCXcM6nkhAEqxzALS/Wg9sF34yJhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uf7QITaXly0KaHAneaD5TMX8TkJ/pRq70/Ftb11pzC+hp3d7
	o8VMC82FeTBVChpywYZrord7cO4NbaOm0NQ+/IydHE4jbArP53LvZR6jsgMkMvK5lxR7P2lEsJa
	9fvkLA8xRRGH4Cvb7N1dc6RZcZ7mLFQ/l2SyNIZZrKmF1qNKhvAClPYeFWIIvwg==
X-Received: by 2002:a05:651c:2211:b0:2ef:21b3:cdef with SMTP id 38308e7fff4ca-2f787edd67dmr102350451fa.25.1726563703727;
        Tue, 17 Sep 2024 02:01:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH+zgU2AscCcZhMM3MfmemH5O9vE0hT20oDGiV0f8CryYMl/xKk4n7Q6GMWErI1uWenNpsNg==
X-Received: by 2002:a05:651c:2211:b0:2ef:21b3:cdef with SMTP id 38308e7fff4ca-2f787edd67dmr102350181fa.25.1726563703080;
        Tue, 17 Sep 2024 02:01:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78054cesm8973686f8f.108.2024.09.17.02.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:01:42 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:01:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 05/21] acpi/ghes: better handle source_id and
 notification
Message-ID: <20240917110141.44362795@imammedo.users.ipa.redhat.com>
In-Reply-To: <409491c21021b3cc0b239bb95ca6cc78e6adda10.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<409491c21021b3cc0b239bb95ca6cc78e6adda10.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 08:13:26 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> GHES has two fields with somewhat meanings:

if 'somewhat' means similar, than it's not.
type is defining a way OSPM is notified about error
while source_id id fw/hw defined arbitrary number that specify
a concrete error reporting source. One can easily have several source ids
with the same notification type.


> - notification type, which is a number defined at the ACPI spec
>   containing several arch-specific synchronous and assynchronous
>   types;
> - source id, which is a HW/FW defined number, used to distinguish
>   between different implemented hardware report mechanisms.

s/mechanisms/sources/

> The current logic is arm-specific, implementing a single source ID,
> for an armv8-specific synchronous report mechanism (SEA).

regardless, above chunk doesn't seem to be relevant to what patch does.

> Cleanup the code to make easier to add other types and make the
> code portable to non-ARM.
> 
> As a collateral effect of such change, build_ghes_error_table()
> function is now an internal function.

all of above doesn't explain why it's good idea,
commit message should be self sufficient for anyone without prior
knowledge if series history to understand what & why of the patch.

The patch does 2 things
 1. hide build_ghes_error_table()
 2. adds notify to  build_ghes_v2()

it's the best to split these and accompany them with commit messages
explaining why it's needed. 
 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> ---
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c           | 31 +++++++++++++++----------------
>  hw/arm/virt-acpi-build.c |  5 ++---
>  include/hw/acpi/ghes.h   |  6 +++---
>  3 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 17b7d9e10f3e..939e89723a2f 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -234,7 +234,7 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
> -void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> +static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  {
>      int i, error_status_block_offset;
>  
> @@ -285,9 +285,13 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> -static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> +static void build_ghes_v2(GArray *table_data,
> +                          BIOSLinker *linker,
> +                          enum AcpiGhesNotifyType notify,
> +                          uint16_t source_id)
>  {
>      uint64_t address_offset;
> +
>      /*
>       * Type:
>       * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> @@ -317,18 +321,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>          address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
>          ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
>  
> -    switch (source_id) {
> -    case ACPI_HEST_SRC_ID_SEA:
> -        /*
> -         * Notification Structure
> -         * Now only enable ARMv8 SEA notification type
> -         */
> -        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
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
> @@ -357,19 +351,24 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
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
>      acpi_table_begin(&table, table_data);
>  
> +    /* Beginning at the HEST Error Source struct count and data */
>      int hest_offset = table_data->len;
>  
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
> -    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, linker,
> +                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
>  
>      acpi_table_end(linker, &table);
>  
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f76fb117adff..bafd9a56c217 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -943,10 +943,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
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
> index 5421ffcbb7fa..c9bbda4740e2 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -69,12 +69,12 @@ typedef struct AcpiGhesState {
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
> +int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present


