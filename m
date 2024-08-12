Return-Path: <linux-kernel+bounces-282998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D172294EBAE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DF01F222E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7F172BD8;
	Mon, 12 Aug 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9xiCcWl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CD43AA1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461638; cv=none; b=FeBKtcO6us4JSQWYwAlAU7cA84FQPPOldVshM0ralRQ9LmHhOuu50qxoDuxCZ+PcpysY/x0Y5zdOhhyJQFbVsl1M6ZhiK+rU5EOiugeInPK0YX08QatYORIWHtSHIHFQhCITzGHsptuCXxL4EL1e8RIDBvkm/gIyYMKpwaiYTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461638; c=relaxed/simple;
	bh=12Dw/LNV+77O1zR/3YjrqBos6PT76GketTRDPdJosB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyeNBC80wernR34qMQp4gpTnylKMzjqmn5o7PhWESeCvzo9CkRvrQgGyHSjML4MPGCBGlUP4rIK01Ra/e6OQtFfcp9lf1QI0yP0PNbz808vGFabsxpq4Wef/LSuuSb1amVkYHO0HZ8HviIMktmS4wdBMK6KnMIvdOXh8uJ6Gbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9xiCcWl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723461635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YK31eZ1U+YHw979zZFpN2xtWNeUWb3G4j6qPN6U37KY=;
	b=f9xiCcWlXLwQ/lvdnk9IqFChTpZWIsAUu3SVGJmLXjc954eY/BFo1Jaggfr9k+1HbCyL/k
	DcRTRpMTgtfyIppFsGWlFEBfxAn7He3BDc39RWGX3W7D5OLmgxERA3MFST9emsZrLSUyya
	ophJUk9mJHkCJJIDGxdU4vzB/i9Be9s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-bsatHcIaNfiLbsQsT3QkGA-1; Mon, 12 Aug 2024 07:20:33 -0400
X-MC-Unique: bsatHcIaNfiLbsQsT3QkGA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280645e3e0so30322345e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723461632; x=1724066432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YK31eZ1U+YHw979zZFpN2xtWNeUWb3G4j6qPN6U37KY=;
        b=FL9da5PgoQy2wXawD1BRv2YpJmlZtNeGLQKfNXzNeb4kYc2o9QoxK5sfojUep0cbEi
         CY124NjF4PhyK88i+8sS6uR6mLqluUGMYxA8be0CzsSQ3/qcQh3kOZUaZcv0rZ7M6trl
         RarepF5yaBksUmh+4dIohLROnQVTJflXzcLBtlJH5qSok8S9tHoApx2ktjr3Tt3tgTbG
         fK4Vbnw7YzSPFniqNnNodGJ+rVhGoRw/3+8D4z0tK1nZnWfljhAVGpgwQcugzc0nb4EY
         +dFa51zhG6awx/yc1kjZwbkXHKtaPAXF+R+AsPtFEIWJEDQwxNmBMvjyLlMudPPpZUAO
         GVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGhJ/l/reGId/7TQFbRra2T8X3nOEjXHpAbgfFDKXFGXoVVIMT1zAb62K81ATteawUp5BX33OkEsW02s1zEyaic5tqhnkmkJWkjVFp
X-Gm-Message-State: AOJu0YwWh5C998kxnxBi1YjbmBcUKmdPi5b9Mcdy4uq1Fl6xcRKm28oG
	/aR67UmtwlgX3gRuYtCBraiO6JNw0aRWAqJVTESUPcqYt3IsoZ3xrk76thMvJZeNEKn5uDCKlVJ
	syFsAtlVZT+/pTLXfUA/zPXNX7Hj15GfnqKX/9dGU7GUpSNp7XhxxBNYfa/UZcw==
X-Received: by 2002:adf:f603:0:b0:362:4ce:2171 with SMTP id ffacd0b85a97d-36d6063ca8amr5406870f8f.52.1723461632357;
        Mon, 12 Aug 2024 04:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiAaIu4Q2H0iXujS6p9cq55HiarpVXpQdxX6kMRsDf4PElItOG62eJZFw+roB1VvCD8SuqxQ==
X-Received: by 2002:adf:f603:0:b0:362:4ce:2171 with SMTP id ffacd0b85a97d-36d6063ca8amr5406849f8f.52.1723461631706;
        Mon, 12 Aug 2024 04:20:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb3csm7201327f8f.69.2024.08.12.04.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:20:31 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:20:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 01/10] acpi/generic_event_device: add an APEI error
 device
Message-ID: <20240812132030.40dfb62d@imammedo.users.ipa.redhat.com>
In-Reply-To: <f43b43fa2e80cbbecf6e47986d768029d531d29f.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
	<f43b43fa2e80cbbecf6e47986d768029d531d29f.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 14:26:27 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


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
> +Aml *aml_error_device(void)
> +{
> +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
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


