Return-Path: <linux-kernel+bounces-275904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC05948BBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298011F22EBF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98A1BDA99;
	Tue,  6 Aug 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JusZlmu0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6D1BD507
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934499; cv=none; b=fdSWiRy7+49GI1Y4QZ3+LF/WVTnvELJcM3x/Bl/0p0e1yx/3QEMffQw/znkdcdNNzcfKuJTOZk2JbqFBTx0MbXsteGq/lpnwCKXF6ISLjQ2Y8uzi83buODgLfRLQghRTEqlQQgo0bx5i878ec10SXuYpF1bi1b5kwf1yV2rCqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934499; c=relaxed/simple;
	bh=3ca2wU0ArGdIUowK6QU1CQbE0qVxjv31H0P/DAOMYR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLn1KP0OwzFOsH0EXP0YvdApVaYFfCVY07NsQOcF+CfsMwSiVJyB7mXTbwJQuArJenTEX7RB015ldkVuedni03iVx7m2183rSeRICPelSGc+LZguS2CMuq17WSSgRA84tSKaAXipB6FRLPNzjIjAHvCUDiqlo65VoNOJwp4kYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JusZlmu0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722934496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r07E9H1rgLrYPOS17s56ejzb5np4x5ByeVYAOU7MQEk=;
	b=JusZlmu0jEBVUuyrVUuyWhmCqHVGy9761kTFXxZP7TnfYH5q4DkH+v/MQqNz8cwGyraFHt
	G4CX+lviwQQeGQ2pWTjiCoQZqlaCw5AjQZZIIwqXgb7xuy0Xp9WcGk1eTYLSojnP57ko9v
	pAu4OZz8kPq6EC4ypQWSvZOr8lqTfGg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-QtfwJCIXMZ2I-CVvoRATww-1; Tue, 06 Aug 2024 04:54:52 -0400
X-MC-Unique: QtfwJCIXMZ2I-CVvoRATww-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef23ec8dcfso4375281fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 01:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722934491; x=1723539291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r07E9H1rgLrYPOS17s56ejzb5np4x5ByeVYAOU7MQEk=;
        b=S4u7EnN14dum/EiWDyRaPux+WOi2/7gjuYxKPOaxzXqt1HKM4vbbMfcZ/dNrog7NRx
         PW4oG8MkENb7j4koPOjMIxS7TeqLf7gwwITEuex+HA/Xn30RpgxV5y60LWbhAgm8MMlE
         bmnKmv0p0ZxMz32JZSyJPtcPIO8H7azIbkaZnxXm3wXcAUmguUOOrPK5kVcdDBnuSuvM
         +xCKYv4Ft5lgYkgROsfI0tsGW6kX+n7HoudIVBK0nfxo4SXawevclquqyi2Wil5RSn1A
         PMtBV0VCWUx8wX9iGJWyxdisCW9HHtCe290rSY6LaOG+sF0OWMskIynHIcpL55G4Gd0z
         IxoA==
X-Forwarded-Encrypted: i=1; AJvYcCUFPSLLnZ1vcCeFCkfsKpSfjb47WN4rfqW8dr9nJ5PS4j37CPOiWsnx4B4/7kSfxylhMV3BoDiAMmfTsM47qru5v7oqULJrUmPxP5NI
X-Gm-Message-State: AOJu0YxJBq73+fiPinqhSXYbk1eTIRa6ejiQlsG29nmfNNOsnOz55LKg
	E3R79ZWLoaNLEqDedFTFYUykQf2zduVlS8dF9L8J8G8F+EWajdkyEXZlr24yp+iHbVai6Rp39wL
	Bqo3o2Mo36g2EMLFF/So37MVyTPgczusTtAcj9ATxIvNa0UDO+lazLfvAJHLtBg==
X-Received: by 2002:a2e:b70a:0:b0:2ef:2c6a:4929 with SMTP id 38308e7fff4ca-2f15aa87463mr107456991fa.13.1722934491165;
        Tue, 06 Aug 2024 01:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy2PVMQlGk7p+Zenu+n0oxwpTRBTQeY18WuEh0Km+j07OjsfEQvtwu6ez96agLYLXNZ3GN+w==
X-Received: by 2002:a2e:b70a:0:b0:2ef:2c6a:4929 with SMTP id 38308e7fff4ca-2f15aa87463mr107456691fa.13.1722934490586;
        Tue, 06 Aug 2024 01:54:50 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9d234sm169680675e9.46.2024.08.06.01.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:54:50 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:54:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 2/7] acpi/generic_event_device: add an APEI error
 device
Message-ID: <20240806105448.7177f6b1@imammedo.users.ipa.redhat.com>
In-Reply-To: <5dfb5fb31afa249e06e0f849b37a7cb525f81215.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<5dfb5fb31afa249e06e0f849b37a7cb525f81215.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 23:43:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

subj: s/APEI/error/

to match spec

> Adds a Generic Event Device to handle generic hardware error
                 ^^^^^
Did you want to say: Error ?
 
> events, supporting General Purpose Event (GPE) as specified at
even though GPE can be used (for example with non hw-reduced pc/q35 machines),
it's not what you are doing here.
s/General Purpose Event (GPE)/generic event device/

> ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> using HID PNP0C33.
> 
> The PNP0C33 device is used to report hardware errors to
> the bios via ACPI APEI Generic Hardware Error Source (GHES).

event is sent not to 'bios' but to the guest, OSPM in spec language

> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
>  include/hw/acpi/acpi_dev_interface.h   |  1 +
>  include/hw/acpi/generic_event_device.h |  3 +++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..b9ad05e98c05 100644
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
> @@ -153,6 +159,15 @@ void acpi_dsdt_add_power_button(Aml *scope)
>      aml_append(scope, dev);
>  }


put mandatory comment here, in format: earliest spec rev + chapter
> +void acpi_dsdt_add_error_device(Aml *scope)

s/void acpi_dsdt_add_error_device/Aml* aml_error_device()/

> +{
> +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));

> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
not necessary unless you want set it anything else beside 0xF

> +    aml_append(scope, dev);
> +}

and maybe move the function to aml-build.c

>  /* Memory read by the GED _EVT AML dynamic method */
>  static uint64_t ged_evt_read(void *opaque, hwaddr addr, unsigned size)
>  {
> @@ -295,6 +310,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
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
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 40af3550b56d..b8f2f1328e0c 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -66,6 +66,7 @@
>  #include "qom/object.h"
>  
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"

> +#define ACPI_APEI_ERROR_DEVICE   "GEDD"

perhaps aml_build.h would be a better place
(if you consider using it with pc/q35 machines)

>  #define TYPE_ACPI_GED "acpi-ged"
>  OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> @@ -98,6 +99,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> +#define ACPI_GED_ERROR_EVT          0x10
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> @@ -120,5 +122,6 @@ struct AcpiGedState {
>  void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
>                     uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base);
>  void acpi_dsdt_add_power_button(Aml *scope);
> +void acpi_dsdt_add_error_device(Aml *scope);
>  
>  #endif


