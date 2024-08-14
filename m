Return-Path: <linux-kernel+bounces-286036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E39515A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12D81F2420B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367A013BC2F;
	Wed, 14 Aug 2024 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkVQG6EH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BB7F486
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621134; cv=none; b=L+mt9rzJZN6qFbllDxPPKhzYP7YUvB4S5qLtHVPGyWm864BWz9lLJLGTauJuGql7MT//7JaY+axzK4bUJN11XDA1DI7TmSfpU8/Jt3g+G4wPQpzwGW1Hy9AzAlTt2DyHuS6/OqbBjw1heFG0wJF6WPK2a3hsgaUtupHSA9OWNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621134; c=relaxed/simple;
	bh=BuQoxhjnnKWRA0tG104ofbuo5hH2qlxb1EjAS9GDSjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCnsV74ChDtr7nbCV8JEjaJGuNVMIgDM9MzIJU58RgHbLv1SRm72wSKJBXtU10vS+7OKngXb5szHPRlDHqhjAx7QUKB90sUuBkgoGAvrV4qv45hCODv54yQOoD0iZ+0KLFWcSY0hMtFAWVl9JD5GHqYddKzxcI1soJUnBs9Ietk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkVQG6EH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723621131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc3aTjU8HWXyxmTz6UJCCM/6umGObf5/rb0G6OpUxpc=;
	b=YkVQG6EH4q8Eq+kRSJftXxmsgPK+AmlElztPR/qg+Ob40d56CZ9khwk+w2CiuX5noX+UsP
	DV79Kbd/CssUbXLras2AB1RywOdJtz2/+o+MyUe+M5mtsYbGr4gPS64/3ZkLG1fRoAblSC
	USTdO+UrHPQMgsZN150Al70vqJNkzUI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-WRAo7Eg6OqyAFAfWtHzr8g-1; Wed, 14 Aug 2024 03:38:49 -0400
X-MC-Unique: WRAo7Eg6OqyAFAfWtHzr8g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7ab81eea72so509821166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621128; x=1724225928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oc3aTjU8HWXyxmTz6UJCCM/6umGObf5/rb0G6OpUxpc=;
        b=B+nKNqObvrHkr6zFGqwQpzY30yRGFMeUMj3ppyeeWwSQZGNOawyVNwk8g42xDibNG5
         QhmRcZoRehUP6aqQPFTx6rB4/UxQ5LHtcKciS9gccDG5G4T2J8ix/mw+N3oBvfLSMzX5
         AHcVECI40fHXyuKlkQRxmqeEn8lVLBQ88elrrI8GasYW2fEwY6BzrkAo4nbVd9C2oT4l
         mHZ7QOmGeckQdvZkS35mgqGPsvgprCI3OG7/AHLvknV8Ei0qqAii/2FkIP7woNamnQgM
         uXfKQzjxGSgAgH9OYWWvNMb7RHp7W9RFuWz4KudSFh0ydvHueT9hvpF9CY5j+R4g3uY8
         ZtYg==
X-Forwarded-Encrypted: i=1; AJvYcCUV6zTjgn0hk8+ssNIgHV8gWys1P/hpiseDtR3LcSFJR4pbtOo1INl1OPskwp39gENa74XtH3DKLQNUUEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkoJC79T/xIigp6pIkyp7sBq/Eyld9eHeZhGDTmDBkAdfHglGG
	bjXY4obTb4semQNg5nhPr39Z6xT1f1UvBq2+x/wGWPVMwvWaoYHZAcKMAuoQvqzfo9o+ZGAAWu4
	8KAEr4c+KCfWsoNVexg8BS6AepsOF6Iz+Q44kYZ1zS8Qh5d9WCKDJ9SC2LqB/Yw==
X-Received: by 2002:a17:907:3f25:b0:a7d:4dc4:3d8 with SMTP id a640c23a62f3a-a836701bb07mr115513766b.54.1723621128528;
        Wed, 14 Aug 2024 00:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm5GukSx2TiVJhZWRQjxQ16ZMf8mxEx8QfTVbYYaWnyu9LQfARUK6lvCulUuhRsLEWBneSNg==
X-Received: by 2002:a17:907:3f25:b0:a7d:4dc4:3d8 with SMTP id a640c23a62f3a-a836701bb07mr115510566b.54.1723621127668;
        Wed, 14 Aug 2024 00:38:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa13desm137152066b.48.2024.08.14.00.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:38:47 -0700 (PDT)
Date: Wed, 14 Aug 2024 03:38:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v7 01/10] acpi/generic_event_device: add an APEI error
 device
Message-ID: <20240814033158-mutt-send-email-mst@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
 <0be6db8d06b3abab551f24dcc645d46d72d3f668.1723591201.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be6db8d06b3abab551f24dcc645d46d72d3f668.1723591201.git.mchehab+huawei@kernel.org>

On Wed, Aug 14, 2024 at 01:23:23AM +0200, Mauro Carvalho Chehab wrote:
> Adds a generic error device to handle generic hardware error
> events as specified at ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> using HID PNP0C33.
> 
> The PNP0C33 device is used to report hardware errors to
> the guest via ACPI APEI Generic Hardware Error Source (GHES).
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/aml-build.c                    | 10 ++++++++++
>  hw/acpi/generic_event_device.c         |  8 ++++++++
>  include/hw/acpi/acpi_dev_interface.h   |  1 +
>  include/hw/acpi/aml-build.h            |  2 ++
>  include/hw/acpi/generic_event_device.h |  1 +
>  5 files changed, 22 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 6d4517cfbe3d..cb167523859f 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2520,3 +2520,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
>  
>      return var;
>  }
> +
> +/* ACPI 5.0: 18.3.2.6.2 Event Notification For Generic Error Sources */



I could not find Event Notification For Generic Error Sources in ACPI
5.0.



Instead, I see
18.3.2.6.2 SCI Notification For Generic Error Sources

What did I miss?


> +Aml *aml_error_device(void)
> +{
> +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));




> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +

comment on why is this here?

> +    return dev;
> +}
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..1673e9695be3 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
>      ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_ERROR_EVT
>  };
>  
>  /*
> @@ -116,6 +117,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_ERROR_EVT:
> +                aml_append(if_ctx,
> +                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
> +                                      aml_int(0x80)));
> +                break;
>              case ACPI_GED_NVDIMM_HOTPLUG_EVT:
>                  aml_append(if_ctx,
>                             aml_notify(aml_name("\\_SB.NVDR"),
> @@ -295,6 +301,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_MEM_HOTPLUG_EVT;
>      } else if (ev & ACPI_POWER_DOWN_STATUS) {
>          sel = ACPI_GED_PWR_DOWN_EVT;
> +    } else if (ev & ACPI_GENERIC_ERROR) {
> +        sel = ACPI_GED_ERROR_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>      } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 68d9d15f50aa..8294f8f0ccca 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -13,6 +13,7 @@ typedef enum {
>      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>      ACPI_VMGENID_CHANGE_STATUS = 32,
>      ACPI_POWER_DOWN_STATUS = 64,
> +    ACPI_GENERIC_ERROR = 128,
>  } AcpiEventStatusBits;
>  
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index a3784155cb33..44d1a6af0c69 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -252,6 +252,7 @@ struct CrsRangeSet {
>  /* Consumer/Producer */
>  #define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
>  
> +#define ACPI_APEI_ERROR_DEVICE   "GEDD"
>  /**
>   * init_aml_allocator:
>   *
> @@ -382,6 +383,7 @@ Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
>               uint8_t channel);
>  Aml *aml_sleep(uint64_t msec);
>  Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
> +Aml *aml_error_device(void);
>  
>  /* Block AML object primitives */
>  Aml *aml_scope(const char *name_format, ...) G_GNUC_PRINTF(1, 2);
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 40af3550b56d..9ace8fe70328 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -98,6 +98,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> +#define ACPI_GED_ERROR_EVT          0x10
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> -- 
> 2.46.0


