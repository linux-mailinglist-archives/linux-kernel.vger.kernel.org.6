Return-Path: <linux-kernel+bounces-534338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F775A465EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66B617D299
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39BC21ABBE;
	Wed, 26 Feb 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqJf4RUB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC509219E86
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584939; cv=none; b=WcWmk959Fyz6rYz80QGcsBiH0PKwg6Q0/tiS3sH5nTxPzdmrK+J5UrM3pcCHYLXkUYD5oBEQwokf2t3k4aiDGlYN5aWpap/3E0pdkeoFsMeroYnysqnDviqVu5wtbIyTH/rH7Ipt/P0DbfVM1g0KK3nrmFY9oifZlncpqTB/djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584939; c=relaxed/simple;
	bh=0Togoy1vlu3njHwIcz7v9khSwRmmYkYuEsGDQckdDds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjGXRoq/UpnrYY4w8mlFLL16mofmqn85OwPmz1A1tGixTDKGdSXhBcEKXucLMNB1Qf+z3gZyO6o+ELYpNrZ+e4iSuLBX0nc6fQur2URe5SCy5rN7L2gxzmOdxv5gh/SpI1GOea9ir6p5uruFIOQt/ycJsO8PLe2RXxRlsY3xlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqJf4RUB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740584936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TiNEq2r2jsaEr8moOLNR8H3qcNO6mJXfZrazVGEeCMY=;
	b=IqJf4RUB4AUnBz12+YkBnopQ8jGo/bAIi+X2rDSEXnUAwGsgFPaUwcWB0B2GB5oJee02Zv
	TooUEFBdu0Wvh4FnJos/XL+RMzJEMyKDYH0Sgt3BqaFxmtGAgAw8CEqU9vGCT1s+GZymkj
	Vt24AxUg2+vJ9h2LfTFci9al3FeKtn4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-5ICypPdZOGWmLW487DqKEg-1; Wed, 26 Feb 2025 10:48:55 -0500
X-MC-Unique: 5ICypPdZOGWmLW487DqKEg-1
X-Mimecast-MFC-AGG-ID: 5ICypPdZOGWmLW487DqKEg_1740584934
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-439a5c4dfb2so31861325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584934; x=1741189734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiNEq2r2jsaEr8moOLNR8H3qcNO6mJXfZrazVGEeCMY=;
        b=gdqqXcSQN9cx4n/DRI5Ywi/osmSyMkMROAN78HQEkfayHIqOxFpAulgH9gw9yvCWHi
         D9lrpjFrlPsjjjBTQqQD46Nin2AsRsoKw4pli3iYsiGWhoc6Zwox1XDw8vqfpW0eQWmT
         UDRID9u5AUgriCdAb9qwARH6Y2l6Awyip9qUXNpHEkFiC/UWBDoF/J7UmibGcxS337OD
         pbkRbrcP2Cg17lfQUeDNBiCrHzkcvFpWM+UciYS7enVmXAfqR9PBKxujixG64uIF/zxF
         Q4QPzwzkWxKEb4DMm/usnNW1+nozrMIDERB6CjX2HQZMai9FnUZ75ZHaZHTJRaR8OgM2
         dQdw==
X-Forwarded-Encrypted: i=1; AJvYcCXIuMb5iDpJEGPx4mkjbrCy3D9mJ30NnenxBNx1k8aAy2IEJE7iQ625q3VDwxvYKxEsNEM6lAnQRLBalYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIw0/CFqdLSPiS8bohC05i526Fp4fVBJ52eeXxbbogn/n4QK2
	Wl4PkRON/axfMhJfcbF/Gbnui5f7PNIQ7eyc35WVZJcVhD3asAkmIzybznErd2wisH2Ivf45oq8
	T2+WltCastYFLhKY+S6R2lTj+PatZTae41GXmX071DISg4bMhSPyCcqr2SZwjhw==
X-Gm-Gg: ASbGncuueq0G1jEhR8njTCIEcg6OLFNnNMAKlNzzfeTdrnEUWELbV8pbki3IYcD4pHu
	82stO0erV0JwiNaBqiTwSeRCvcD4aIYv6oaZ+MJPNxnMQH542M/YFfZGnf7BIDbJGtFd1zEV6Ff
	uavrR3qAYns16wriaJD3hBwxcgUO/tB3wC7Tx43e9OqK6TwcGiHI2kznfKH2Z15809E90yw1EaR
	5U4XbWUHOt5RIC+Js7t0fCRNA3CZUc1jAOfCpbpO3NFETYmbvLVIGbjUM3gR/uewk8y7gmsmvvh
	gk/D1NbDX1jcYMr/LKu4DZb1olMjyBV5GufNy/BgrWq+70ATYnEzGFDAfI2SlU8=
X-Received: by 2002:a05:6000:184e:b0:38f:3735:68e with SMTP id ffacd0b85a97d-390d4f9bce6mr3304467f8f.46.1740584933966;
        Wed, 26 Feb 2025 07:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp18JhmWYwbrKX7q30/PycgnHThNyfXu8nXVhQu2qMes1vLvDUMqkQamIhfAumFKn8SRJ2fw==
X-Received: by 2002:a05:6000:184e:b0:38f:3735:68e with SMTP id ffacd0b85a97d-390d4f9bce6mr3304434f8f.46.1740584933542;
        Wed, 26 Feb 2025 07:48:53 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca9csm6009486f8f.22.2025.02.26.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:48:52 -0800 (PST)
Date: Wed, 26 Feb 2025 16:48:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/14] acpi/ghes: don't hard-code the number of
 sources for HEST table
Message-ID: <20250226164851.316aa095@imammedo.users.ipa.redhat.com>
In-Reply-To: <13755cc3680bfee1435fee2e366b621d2a940a1a.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<13755cc3680bfee1435fee2e366b621d2a940a1a.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:35:13 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current code is actually dependent on having just one error
> structure with a single source, as any change there would cause
> migration issues.
> 
> As the number of sources should be arch-dependent, as it will depend on
> what kind of notifications will exist, and how many errors can be
> reported at the same time, change the logic to be more flexible,
> allowing the number of sources to be defined when building the
> HEST table by the caller.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes.c           | 38 +++++++++++++++++++++-----------------
>  hw/arm/virt-acpi-build.c |  8 +++++++-
>  include/hw/acpi/ghes.h   | 17 ++++++++++++-----
>  3 files changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 7efea519f766..4a4ea8f4be90 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -238,17 +238,17 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
>  static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
> -                                   BIOSLinker *linker)
> +                                   BIOSLinker *linker, int num_sources)
>  {
>      int i, error_status_block_offset;
>  
>      /* Build error_block_address */
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < num_sources; i++) {
>          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
>      }
>  
>      /* Build read_ack_register */
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < num_sources; i++) {
>          /*
>           * Initialize the value of read_ack_register to 1, so GHES can be
>           * writable after (re)boot.
> @@ -263,13 +263,13 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
>  
>      /* Reserve space for Error Status Data Block */
>      acpi_data_push(hardware_errors,
> -        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
> +        ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
>  
>      /* Tell guest firmware to place hardware_errors blob into RAM */
>      bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
>                               hardware_errors, sizeof(uint64_t), false);
>  
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < num_sources; i++) {
>          /*
>           * Tell firmware to patch error_block_address entries to point to
>           * corresponding "Generic Error Status Block"
> @@ -295,12 +295,14 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> -static void build_ghes_v2(GArray *table_data,
> -                          BIOSLinker *linker,
> -                          enum AcpiGhesNotifyType notify,
> -                          uint16_t source_id)
> +static void build_ghes_v2_entry(GArray *table_data,
> +                                BIOSLinker *linker,
> +                                const AcpiNotificationSourceId *notif_src,
> +                                uint16_t index, int num_sources)
>  {
>      uint64_t address_offset;
> +    const uint16_t notify = notif_src->notify;
> +    const uint16_t source_id = notif_src->source_id;
>  
>      /*
>       * Type:
> @@ -331,7 +333,7 @@ static void build_ghes_v2(GArray *table_data,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
>                                     ACPI_HW_ERROR_FW_CFG_FILE,
> -                                   source_id * sizeof(uint64_t));
> +                                   index * sizeof(uint64_t));
>  
>      /* Notification Structure */
>      build_ghes_hw_error_notification(table_data, notify);
> @@ -351,8 +353,7 @@ static void build_ghes_v2(GArray *table_data,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
>                                     ACPI_HW_ERROR_FW_CFG_FILE,
> -                                   (ACPI_GHES_ERROR_SOURCE_COUNT + source_id)
> -                                   * sizeof(uint64_t));
> +                                   (num_sources + index) * sizeof(uint64_t));
>  
>      /*
>       * Read Ack Preserve field
> @@ -368,22 +369,26 @@ static void build_ghes_v2(GArray *table_data,
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       GArray *hardware_errors,
>                       BIOSLinker *linker,
> +                     const AcpiNotificationSourceId *notif_source,
> +                     int num_sources,
>                       const char *oem_id, const char *oem_table_id)
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>      uint32_t hest_offset;
> +    int i;
>  
>      hest_offset = table_data->len;
>  
> -    build_ghes_error_table(ags, hardware_errors, linker);
> +    build_ghes_error_table(ags, hardware_errors, linker, num_sources);
>  
>      acpi_table_begin(&table, table_data);
>  
>      /* Error Source Count */
> -    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
> -    build_ghes_v2(table_data, linker,
> -                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
> +    build_append_int_noprefix(table_data, num_sources, 4);
> +    for (i = 0; i < num_sources; i++) {
> +        build_ghes_v2_entry(table_data, linker, &notif_source[i], i, num_sources);
> +    }
>  
>      acpi_table_end(linker, &table);
>  
> @@ -529,7 +534,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
I'd also remove one blank line here


>  
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 8ab8d11b6536..4439252e1a75 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -893,6 +893,10 @@ static void acpi_align_size(GArray *blob, unsigned align)
>      g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
>  }
>  
> +static const AcpiNotificationSourceId hest_ghes_notify[] = {
> +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -956,7 +960,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>              acpi_add_table(table_offsets, tables_blob);
>              acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> -                            tables->linker, vms->oem_id, vms->oem_table_id);
> +                            tables->linker, hest_ghes_notify,
> +                            ARRAY_SIZE(hest_ghes_notify),
> +                            vms->oem_id, vms->oem_table_id);
>          }
>      }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 2f06e433ce04..51c6b6b33327 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -57,13 +57,18 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> -enum {
> -    ACPI_HEST_SRC_ID_SEA = 0,
> -    /* future ids go here */
> -
> -    ACPI_GHES_ERROR_SOURCE_COUNT
> +/*
> + * ID numbers used to fill HEST source ID field
> + */
> +enum AcpiGhesSourceID {
> +    ACPI_HEST_SRC_ID_SYNC,
>  };
>  
> +typedef struct AcpiNotificationSourceId {
> +    enum AcpiGhesSourceID source_id;
> +    enum AcpiGhesNotifyType notify;
> +} AcpiNotificationSourceId;
> +
>  /*
>   * AcpiGhesState stores an offset that will be used to fill HEST entries.
>   *
> @@ -86,6 +91,8 @@ typedef struct AcpiGhesState {
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       GArray *hardware_errors,
>                       BIOSLinker *linker,
> +                     const AcpiNotificationSourceId * const notif_source,
> +                     int num_sources,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);


