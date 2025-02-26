Return-Path: <linux-kernel+bounces-534346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8902A4661C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ACE19C34D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B2A2904;
	Wed, 26 Feb 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRk6izB8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B9A59
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585153; cv=none; b=AgrnDqSpQoKT3UGjmzxxb1VvbBFYSQONcjMh8UROe5Rs0UbkLYkyBuRJLaax/F2eYXFKvPs4Vt5hbH266HLG9vsuZBHusReMTHWjnAe67qKaTZ4VcxKsJ5iPuaTvDs38m7+ER7Xuxh7SVc+TZJ48OjyYeCvlzmgEFNsf9Npbeaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585153; c=relaxed/simple;
	bh=qPB663T4kl1k9A98bJqE2oAERM175SEskuCOorlwSaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxdLP63ts0Kd4oa0J3jJpNDu8uCfNwkvJT2sKAAsiu7XM9cSl86GiG8zi7wsNan2vVCyxCc8u+rXcaOfH2e8I7V/b+QdZKmQKVkxuA2D2cPmc5BX7Hw5oxRtfoXzudsH9BqetowYxCCUznanr7PQT5/r1BI2NWT1yrG2uIbedcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRk6izB8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740585150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KGq5La7yk+czEiF+6Xo77Jf5JrsRdt59tbf6s0nbt8=;
	b=eRk6izB8LEH6bnrBWKkcs1xfXmxtM1JJf93mRa5pOmPlrCJSxsl+Pgn79Dqs9XtzgSIfXn
	87HIxlpEEqvrgahelnQVNiEUrNz9m5KkesABGTV+ZSjuB6O+iIWiEYhY4oCShws79leeem
	JgHg103LD5P/s1MYH8n61gifxycS3J8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-1S5yoal6OMq7qvbTo7BhQQ-1; Wed, 26 Feb 2025 10:52:29 -0500
X-MC-Unique: 1S5yoal6OMq7qvbTo7BhQQ-1
X-Mimecast-MFC-AGG-ID: 1S5yoal6OMq7qvbTo7BhQQ_1740585148
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43998ec3733so35526065e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585148; x=1741189948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KGq5La7yk+czEiF+6Xo77Jf5JrsRdt59tbf6s0nbt8=;
        b=MBaF5nDRP0kZHX7Mx05fNOqEUqjw+2s6yup7e9X8wM0Zxz4is3UHQ2aSGepULgSYZJ
         KqezMj6h+rxzXODkozbafDaumqOiJlh0mjLhFpw+hWxwY5HAlBphFYt32Zv0eLoHfYh4
         qz9F2mRMm6ORZ4fvAhd+r0H/zcYRfCa4xvlV+kgmYJkVoeoo6CNAyqZr9HtX4Ts1UNTT
         wglvLBaIyNo4RXehi5/fNflf9j3Yxyksi2EPyonQmhPaAuMAndheGOdJyKNy5ambxaHy
         EtrSXMNd3e9eUIr9FuUXNQfP49FTvgYN0IT7M6ZOgNeL9lovTB/CNyGskjOKU6Whz1fO
         mzpw==
X-Forwarded-Encrypted: i=1; AJvYcCX0SlG1yUn/fQGFBf5fEGmq6IorrNL/QQcB4nbNqIPEdG1BdJrI07xXnTVXvN8vlipIGwf0VTQMbdZ65wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+2A2zsbqDURGU9pXRHlU98bLhGIdUSb7oM6oPINrk/5GremL
	+TRHQKV/mf4LaiCUMRHSvx/95qejs5LfFB3EGECdjndMe8L81T7IVPGVRbQ7ejIgr00eOFLauhx
	yY+G2d0mBykGku4DCvqSEa08lHXZbJX4HLfay9EZFiVuLwTciPffLHt/tWBbZMA==
X-Gm-Gg: ASbGncsLUXYqa62YG7IIgjz/BEaflMGqJiKCcHEqjNk42hWHnIwYn5xlP9+mljuU/iC
	kYdOzxh5jBfPmboHL48iMZN2yseiLIddDGYvdNHPnbdzMTRW4FbgzRfAiQBCL9ilaNIt6mx7PLR
	O9Q6pMMM4AfNzZxcRmN4wENOV3q9HQAgWaQ9W5DwipKiqyrdrhaMY6aBFOatIRxzHub9s21JRgV
	2FKsQDQb7CiR/Fkps6w3e8p5TA0AqznuAUvuaamKLecq7M51RgTogiU/2iQHwKXp7fWpd0wGTvB
	bnczDRdy5bhxMOk2Xiz5MRsMtQBVyrINPGv+J2YykNYAlTWDEKypCmfLVVMoQmE=
X-Received: by 2002:a05:600c:5493:b0:439:9a40:a9ff with SMTP id 5b1f17b1804b1-43ab0f27170mr57873515e9.1.1740585148399;
        Wed, 26 Feb 2025 07:52:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFhPBq1dHswsswtne5Hy7yfVLOgg9RZzruRywauu4DAenatyPVYw3EqKeA58NQ2oZQlV7VJQ==
X-Received: by 2002:a05:600c:5493:b0:439:9a40:a9ff with SMTP id 5b1f17b1804b1-43ab0f27170mr57873335e9.1.1740585147976;
        Wed, 26 Feb 2025 07:52:27 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba571274sm26036365e9.31.2025.02.26.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:52:27 -0800 (PST)
Date: Wed, 26 Feb 2025 16:52:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/14] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250226165226.49b88429@imammedo.users.ipa.redhat.com>
In-Reply-To: <e9e0aafd7cc8613709171ec5d8a6d9d9be62d7c1.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<e9e0aafd7cc8613709171ec5d8a6d9d9be62d7c1.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:35:17 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 10.0 and upper) or via the legacy way via an offset obtained
> from the hardware_errors firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/generic_event_device.c |  1 +
>  hw/arm/virt-acpi-build.c       | 18 ++++++++++++++++--
>  hw/core/machine.c              |  2 ++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 5346cae573b7..14d8513a5440 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),

you below set it for 9.2 to false, so
shouldn't it be set to true by default here?

>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 4439252e1a75..9de51105a513 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -897,6 +897,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
>  };
>  
> +static const AcpiNotificationSourceId hest_ghes_notify_9_2[] = {
> +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -950,7 +954,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> +        static const AcpiNotificationSourceId *notify;
>          AcpiGedState *acpi_ged_state;
> +        unsigned int notify_sz;
>          AcpiGhesState *ags;
>  
>          acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> @@ -959,9 +965,17 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>              ags = &acpi_ged_state->ghes_state;
>  
>              acpi_add_table(table_offsets, tables_blob);
> +
> +            if (!ags->use_hest_addr) {
> +                notify = hest_ghes_notify_9_2;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify_9_2);
> +            } else {
> +                notify = hest_ghes_notify;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify);
> +            }
> +
>              acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> -                            tables->linker, hest_ghes_notify,
> -                            ARRAY_SIZE(hest_ghes_notify),
> +                            tables->linker, notify, notify_sz,
>                              vms->oem_id, vms->oem_table_id);
>          }
>      }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 02cff735b3fb..7a11e0f87b11 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,6 +34,7 @@
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "audio/audio.h"
>  
>  GlobalProperty hw_compat_9_2[] = {
> @@ -43,6 +44,7 @@ GlobalProperty hw_compat_9_2[] = {
>      { "virtio-balloon-pci-non-transitional", "vectors", "0" },
>      { "virtio-mem-pci", "vectors", "0" },
>      { "migration", "multifd-clean-tls-termination", "false" },
> +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
>  };
>  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>  


