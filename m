Return-Path: <linux-kernel+bounces-347572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF9E98D56B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710851F22A7B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40FD1D0486;
	Wed,  2 Oct 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUaPz1uR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1D1D0426
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875808; cv=none; b=CimDXazFqFqFLcE9kb4bpdU5aWeROVSVM8VI6vwqrgqk0CcbyM1PP+KQ4QPsSQ99ej+YF/KfU9EvVpf0Yzwj8oWGSsatMOvdDcLFUBzwP64BAQCByEMUBuGkSwOthJ3jpJw/PW3fs8cWSkj+hCuizUyEiyp5twbBouDRDWUkqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875808; c=relaxed/simple;
	bh=j5H/4bYxE6DNqb6bN1+bweInbVl1Ie3LBevskRF2SK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEex6tXjKYBFfZ1y68s4CWVi9dM6exmqiN2DRqTpZl3El7YExEhAeO9/qJJ5ppfzJjJuGVdL0c6VMt+1g8mXiCugkqhqL438jRu4Ew6I9/sodaqooxooNcRFkExtdMiozBqaGHl6wG5Al17dGMNYGYFC0A0mGcoYYVFVK7uke2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUaPz1uR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727875805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVaj7/BQi23v89JkJG2qnGOSUZwrNzEyBz6Xmffq5Xs=;
	b=OUaPz1uRfQeE/q10sczlErXfQ16rRj4WU3t+xGOCnMtoVXxpBFGSQNWfi85NVtGxv0n2tG
	AhddzYV3pKGN/rQqfgJxvZhZEMtDN99f1BjsVULJaYIyEaXmeK0teSf+zTElh0Wf4AqqOE
	Z1OmCJEqBqy2911kPZB06OCNcC3tgyY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-z2P_YGLMO6Gi_oHXRISBbA-1; Wed, 02 Oct 2024 09:30:04 -0400
X-MC-Unique: z2P_YGLMO6Gi_oHXRISBbA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb2c5d634so44072705e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875803; x=1728480603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVaj7/BQi23v89JkJG2qnGOSUZwrNzEyBz6Xmffq5Xs=;
        b=tsjZYjKeNaxMv72/9laTYq3tSMTZMYDR2dYQok3pKevYEAERoPgP7Jla4owFIj6W8f
         iQDZqWlVXwSRlte3fb3adwTnvzHfivvjsXrnc+nRxrwg8J2RDICxnl58HqtIJE+tjdcO
         heqWoS5XWd9k3S7W5GH2aACJuKJBROKJ4+h7JnTQyxmOm44s4sxKo4npXPXAycYWLFK5
         oDnOh+uCQCl2qJGQ2UK+N4VZQDEasRqVqeXj2oUpZw6hcIoJlg03xp9p8iyEjzOvxUc8
         7jgS1bLx0EZXRqzm0GUabbiEr7C4o0xBdVYS2sLcRXcow4pqxM54PpwJRYeCbDTHoNqF
         Khqw==
X-Forwarded-Encrypted: i=1; AJvYcCVYLxtiHRrhcAzt7xaY+D2glwfy0XmxPNFqpPlvFJBvs8cStwaUKxdvKqkBrx6Cp4RWLpFdMQ7BdYQNtls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaD9macPdnhtaCXLazh33dP8yfNR7ufZpgmjMs/iaCqOkotPoi
	6WqmgpaA1pzYa8MhDN6T8XK0zABI/e5OiuEKiNRbE9nZK2SR+Qv/MinN4Q5JssnN00PEQp3iz4q
	O9iBgm2BKJbF2H/unR84pejHOSHbcG+rylfvze8jUplwaqBOyaEq//X5Jbysl3w==
X-Received: by 2002:a05:600c:3507:b0:42c:b63e:fe8f with SMTP id 5b1f17b1804b1-42f777bf969mr20412235e9.13.1727875802934;
        Wed, 02 Oct 2024 06:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7qHvz/rSdIDBwP4B+E2wVG8l63Y1Nawa+BWx5diV1g7GxH260FdI/ZjjdSjFXVctxqrqVtg==
X-Received: by 2002:a05:600c:3507:b0:42c:b63e:fe8f with SMTP id 5b1f17b1804b1-42f777bf969mr20412055e9.13.1727875802489;
        Wed, 02 Oct 2024 06:30:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01f4fasm18587105e9.38.2024.10.02.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:30:01 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:30:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 03/15] acpi/ghes: simplify the per-arch caller to
 build HEST table
Message-ID: <20241002153001.22324ae1@imammedo.users.ipa.redhat.com>
In-Reply-To: <a106318a134a2aa9d75aa07f906bad959cb0600a.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
	<a106318a134a2aa9d75aa07f906bad959cb0600a.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 09:03:40 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES driver requires not only a HEST table, but also a
> separate firmware file to store Error Structure records.
> It can't do one without the other.
> 
> Simplify the caller logic for it to require one function.

> This prepares for further changes where the HEST table
> generation will become more generic.

I'd drop this

> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> Changes from v10:
> - Removed the logic which associates notification and source
>   ID. This will be placed on a separate patch.
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c           | 7 +++++--
>  hw/arm/virt-acpi-build.c | 5 ++---
>  include/hw/acpi/ghes.h   | 4 ++--
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e66f3be1502b..4a6c45bcb4be 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -233,7 +233,7 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
> -void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> +static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  {
>      int i, error_status_block_offset;
>  
> @@ -356,12 +356,15 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
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
>      /* Error Source Count */
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
> index 59e3b8fb24b9..20016c226d1f 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -68,8 +68,8 @@ typedef struct AcpiGhesState {
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


