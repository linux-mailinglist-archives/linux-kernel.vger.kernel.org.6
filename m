Return-Path: <linux-kernel+bounces-328256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1397811F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2AE1C20B65
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFF1DA63A;
	Fri, 13 Sep 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHaaBHsS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7F1E505
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234031; cv=none; b=irpl6nUTz3gxzhRgmPdSqqWP6RyrxLb1aayV/JctDHWlmx3xLnBP04tsQSUWYE5bhToNWESthy4Oms7raeY/fYkfxZwyzUjjgLo0Y5hLb8nw6PBBCwu9DpyVsuBzPapj2Hi8EQiUUj0HsC9lNmGPNMmFtgpPJzjEZ+va5q3cdI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234031; c=relaxed/simple;
	bh=i/mMkQZ7/4E9WB56LmoOz9gGoXes+Hkp2mO3CQEe+Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IErXiUeyAK41yVREIMU7IznYth9WkdLBKtEhxJ4K6kv5o9O24xqHFWglk6YgvxxzrkSTtXDD2FtFvo+smLPPgecC0UR24v66+zkqtPKLl/sCIGW77dTplhKTPlIwMpN9f87+Ot9LVvSYJGVSjSa3639llsu9dR7RmG4/klPUmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHaaBHsS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726234029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXO6xhJcEZ/xpvunD2vf+i968Lb3apUbBziQrSJQN20=;
	b=dHaaBHsSbJMZQiR7BZAmHwKMlugJJQccz4eKn73uE4bgoxUUibsKFfLcOyzKf5VyKn5NTI
	ldmkH3rvAiB+AUzXTg85CKDn/CGdRffyjgRXj6WIu8cYz1/AVEB0ugvTTWC/a05f4WtSw6
	6477C1vABmPjMXRwLEHKfsvxJj/I1ds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-j-toXUJSPKeRHwWxFFrKrw-1; Fri, 13 Sep 2024 09:27:05 -0400
X-MC-Unique: j-toXUJSPKeRHwWxFFrKrw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb236ad4aso13844145e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726234025; x=1726838825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXO6xhJcEZ/xpvunD2vf+i968Lb3apUbBziQrSJQN20=;
        b=axNNW7CWn5XHVjbd2b7a+yx1Iumq1vdFhoinJQRbGudS80QEdoDBQ7OtdeOTEdkirn
         6Tqjvq68auS/00gDAor2smRjpGnI/pkypIBSRPYcYH50GKkAUmHU37UsrIUDbhCGiouI
         BnGO05QJEzSF/X2F0515mKoxkM76Z+YhA3ge32H2wV90lz3ulv0hIITwApEMZhfD56xq
         E+ib44bpddlyvb2RcmbJi7dX93ZEX2PMil44DMOyYLCYBY3VExJpgserlYxNjv/ILH/T
         FK9/gc4qUaydNa6XTpuMPQZ5dFfwFcGC0Bg0zIjHaxIX6QWVyH2U6p7rKYuCYCfRfR5i
         t3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCW1ua0aLqmApsFogcAv7hui939532x06vtu12nHWabuLayGjYSKexQHflzv853mMrb7C6Tfceb72ikKUxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvDawdd9sQQ3gMUFEx/fZIpgQEfld7t+LakglvLEdl9kOliHR
	3WK8ztbjDvYrmxJGrfWqJz7z39ulEqLDoT7R1qpwlRKHOvMfGk+lwHnSjO4G8DD4lefHWSnLsxq
	qxZLQ5Z1tubdSETfRDI6Dk7gtvCs7JZJVLm9oqe9uQlDTeox5GJ9e5+ls0xShUw==
X-Received: by 2002:a05:600c:548e:b0:42c:a802:a8cd with SMTP id 5b1f17b1804b1-42cdb529fbamr45142125e9.11.1726234024624;
        Fri, 13 Sep 2024 06:27:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFISBORVoOtSf46uEWW7cElplgNkNkD42jImCK1VDBBI8gu9rS4soC9E7zoVJdbOSfEysf3fA==
X-Received: by 2002:a05:600c:548e:b0:42c:a802:a8cd with SMTP id 5b1f17b1804b1-42cdb529fbamr45141835e9.11.1726234023989;
        Fri, 13 Sep 2024 06:27:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9aff579asm27606245e9.0.2024.09.13.06.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:27:03 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:27:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 03/12] acpi/ghes: rename etc/hardware_error file
 macros
Message-ID: <20240913152702.3dc97c88@imammedo.users.ipa.redhat.com>
In-Reply-To: <866a06839420e69fa5a96ea3e0384658abb7e70a.1724556967.git.mchehab+huawei@kernel.org>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<866a06839420e69fa5a96ea3e0384658abb7e70a.1724556967.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Aug 2024 05:45:58 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that we have also have a file to store HEST data location,
> which is part of GHES, better name the file where CPER records
> are stored.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 965fb1b36587..3190eb954de4 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -28,8 +28,8 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "qemu/uuid.h"
>  
> -#define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
> -#define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> +#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> +#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
>  #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
> @@ -255,7 +255,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>          ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
>  
>      /* Tell guest firmware to place hardware_errors blob into RAM */
> -    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
> +    bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
>                               hardware_errors, sizeof(uint64_t), false);
>  
>      for (i = 0; i < num_sources; i++) {
> @@ -264,8 +264,8 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
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
> @@ -273,9 +273,9 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>       * tell firmware to write hardware_errors GPA into
>       * hardware_errors_addr fw_cfg, once the former has been initialized.
>       */
> -    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, 0,
> +    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
>                                       sizeof(uint64_t),
> -                                     ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
> +                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> @@ -315,7 +315,7 @@ static void build_ghes_v2(GArray *table_data,
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
> -                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
> +                                   ACPI_HW_ERROR_FW_CFG_FILE,
>                                     source_id * sizeof(uint64_t));
>  
>      /* Notification Structure */
> @@ -335,7 +335,7 @@ static void build_ghes_v2(GArray *table_data,
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
> -                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
> +                                   ACPI_HW_ERROR_FW_CFG_FILE,
>                                     (num_sources + source_id) *
>                                     sizeof(uint64_t));
>  
> @@ -389,11 +389,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
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
>      fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,


