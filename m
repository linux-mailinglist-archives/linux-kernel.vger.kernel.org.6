Return-Path: <linux-kernel+bounces-536387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE604A47F10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEFD164590
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EC322FDE6;
	Thu, 27 Feb 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz0Z1wHs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D522171A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662641; cv=none; b=HTsABPrzVabbb1xUQPEzJBJ2Bap95+q5Dg9M55d5xUrW1QqelY0qmmM1imq05qKumVxGETNEZhCIlrTwa3mJKA1a23+V+2UmUT1xEmQiBjKPg4iyN2wKWJ5f8VO2iNCbVn/nP9vjiZm23UIh4NmS6UwNPYZiQ/pyqOT8WSL1duU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662641; c=relaxed/simple;
	bh=MLhpjQ2lwp7rMbrwQeE6/UfsJxnmug88WDCpiImBM28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L54u8SBrDvM48gLHVaGVj4HzlQkNNkrdY4iAlaLOa1HGa99bVm+kokxtqMOHrSaae/RIjC0GLgfIc/ZZ1dgKBZZbbD0x5sNgJMu2p8qtzpGh7mUgcetw4j0JK46fQFV9drfwJ0lTNxTSu1tWZ7ZxCNv/seLe4spghGCwnhxbGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sz0Z1wHs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740662638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+/sVet04sI8XRzD0vhsj+5eFIvMMczIeqA1fuUR4Rw=;
	b=Sz0Z1wHswwyrH1aJRPAICWnDaL9+Rme8Vg6iqO4HvDccn3EIL0Ytc6JN2dQcdN/Fi0IZz1
	xyMYcHNb/+7DVa18FQz5EMae731NNQyUIA3MSI8PYivfcC0NHcKaJPahcVoyvNiy6nj8jB
	Xuau5bPqARCBAvNBGwzWHUrKHphNn/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-fUWnFXvUN_2geeuni-wcNQ-1; Thu, 27 Feb 2025 08:23:57 -0500
X-MC-Unique: fUWnFXvUN_2geeuni-wcNQ-1
X-Mimecast-MFC-AGG-ID: fUWnFXvUN_2geeuni-wcNQ_1740662636
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f455a8e43so351825f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662636; x=1741267436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+/sVet04sI8XRzD0vhsj+5eFIvMMczIeqA1fuUR4Rw=;
        b=Gi5MIpC9hxat+M9kmQiZc00maWPNeadIehfa65Mb1gE1Q06js6eP/CHTY4S/tQt+F0
         xSdG159ch1rS9X1IJ1vgwbHJ4yIm8uFH3OaNX/ah+rUi24V5O3CBm2AnGzGYUBWSq7AK
         Z8K/oacqXvHWQfDU7B+1EgFch5RoOVVivgxdghmhX9otVRXTZM3V+NxbDnIFf2DST/MF
         3PxLQ6FZ69u+7nqrGO8AM8ZhjBX9+PrMbV4T79mbcHY6UIO6F1yMVL2UIOUrqC1xp7E4
         pSyLm7a+0wKmC1lNJukgwLAgG3a/w7IrxOhHbr5+XUSbGyjFOzdS5MAlAm0XcaNFBX74
         QdDg==
X-Forwarded-Encrypted: i=1; AJvYcCWeu50Pm6X7G0/iMPmL0mM6m0bkBloxB+uKi5uIJusaxk/8cQ+8Yv4uY+Tn3nEgH2HhYaVUzYlXzEufpek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzof6yLGIPMulbbiWhueGfhYo+0XHztQaFqWPZGKPGDHILDqWeF
	IoBFUSos5DFmAENI8XI7YgisxoHpoPz92KAOcZKpmyXRoxzFTmT3ipVCk6pYB5LOf0Nh4DcL6ki
	u4uW0df07RGI3NtbPXsGUnxibNulEhq3IFN4IUBL8c7iWto+qWWuTO1RPwswNbQ==
X-Gm-Gg: ASbGnctHXzCFZAqI9BKZAwvvHdQolniEkaz6EZOPvJp66FsZ6688gQTL6fMqjxPaccU
	ivLlc3XZtburFRTJwU3baeBm6UNJX9WVWQZzMf9mPv6Ujv8E1ZbWFnV8cEkRTxXrx29K76i6z6T
	B5nGHdaQw2SQ8Wt8zNgSZLurEdggOUEtCPyosxVHwG53ZusVk6ZBbdzVpqK+2TRjMlWtXxOQ1ll
	6ptYs8e3WKBb/+Bpk7RPSmBh55ukbJTFcpR5op0Gu6a9D+J9YwvYxmZEwnM6mLr2ZLbU5YEFyMP
	VEszSoKMkUMw+utNblhp9i3or0sh62BgD3tkuUw9tbTkGaWU62tcBi266DI2CQ0=
X-Received: by 2002:a05:6000:2b01:b0:390:e9e2:828e with SMTP id ffacd0b85a97d-390e9e28568mr585721f8f.32.1740662636382;
        Thu, 27 Feb 2025 05:23:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQXzOKzEDenCsFiQtIEa/8g0gcGHJegK46j5f/hefRmdAuM29CTrqDy3E7ROmmChOu9kCEsg==
X-Received: by 2002:a05:6000:2b01:b0:390:e9e2:828e with SMTP id ffacd0b85a97d-390e9e28568mr585702f8f.32.1740662635947;
        Thu, 27 Feb 2025 05:23:55 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7b6asm2108584f8f.51.2025.02.27.05.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:23:55 -0800 (PST)
Date: Thu, 27 Feb 2025 14:23:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/21] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20250227142354.711204b1@imammedo.users.ipa.redhat.com>
In-Reply-To: <ce0db0a85f31a58c44e25198f0ef3614c717cb07.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<ce0db0a85f31a58c44e25198f0ef3614c717cb07.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:03:36 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its the start of the table at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes.c         | 20 +++++++++++++++++++-
>  include/hw/acpi/ghes.h |  7 ++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 9243b5ad4acb..8ec423726b3f 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -30,6 +30,7 @@
>  
>  #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
>  #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> @@ -341,6 +342,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> +    uint32_t hest_offset;
> +
> +    hest_offset = table_data->len;
>  
>      build_ghes_error_table(ags, hardware_errors, linker);
>  
> @@ -352,6 +356,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                    ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
>  
>      acpi_table_end(linker, &table);
> +
> +    if (ags->use_hest_addr) {
> +        /*
> +         * Tell firmware to write into GPA the address of HEST via fw_cfg,
> +         * once initialized.
> +         */
> +        bios_linker_loader_write_pointer(linker,
> +                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                         sizeof(uint64_t),
> +                                         ACPI_BUILD_TABLE_FILE, hest_offset);
> +    }
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -361,7 +376,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
> -    if (!ags->use_hest_addr) {
> +    if (ags->use_hest_addr) {
> +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    } else {
>          /* Create a read-write fw_cfg file for Address */
>          fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>              NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 5000891f163f..38abe6e3db52 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -70,9 +70,14 @@ enum {
>   * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
>   * is stored at hw_error_le. This is the default on QEMU 9.x.
>   *
> - * An GPA value equal to zero means that GHES is not present.
> + * When use_hest_addr is true, the stored offset is placed at hest_addr_le,
                                             ^^^^^ it's not offset, it's GPA
please get rid of offset language in this comment.
        
> + * meaning an offset from the HEST table address from etc/acpi/tables firmware.
> + * This is the default for QEMU 10.x and above.
> + *
> + * Whe both GPA values are equal to zero means that GHES is not present.
>   */
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool use_hest_addr;         /* Currently, always false */
>  } AcpiGhesState;


