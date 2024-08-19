Return-Path: <linux-kernel+bounces-291948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1257095693D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371321C215ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2611662F4;
	Mon, 19 Aug 2024 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxNQQ/pp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7B15D5CA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066526; cv=none; b=E1/Vvc2QxaC5kkdFpGRwIactKH+wTs7dTPtuPqznfGxKe1kKt2WMThPmRW3rKX6Ddg/C2E4C8eLCfiHcbLKzqDAecYaUYg2CZ2Wi6crLBswuJFmyMTXJIlXy/LhoJF4XkonEtFUbqv9CNHfWu6acqxJZUL1e7q+Lg7zP3Vn6R88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066526; c=relaxed/simple;
	bh=ZyAJxGAa1bHwuxFnRT2wec5JAram9eCbEBmqi0GZovo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1SwOWVJ6q64TTH+je3WywzH6B6eu7TqAUEDTZLUfPQyuPnqoGR/UeG6obdgXjP0s9MonNYybUaDLbWrA3lNUOaH0f2Mv+GxXIbDDjJDIW6njS6sDxxb2RGkbXkKHlWMM2koNHS8e6B0nDnTHXhcS7uugZFblW4uLXPlNfl4/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxNQQ/pp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724066523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJLtyghP2fZR1U5V5rCeuD4Jcl2hiUiX6/kehYYUazc=;
	b=AxNQQ/ppXeBizo93Psk2EDcRdLv1TfQPIwnj/2puvYUhnq5r2jX5Ooi7wjSVd/UJPuuQDS
	u/38x/b2NAwp++/gBBmvHctHNajuqJHNAybfYUPMPI5doPu2z1103O9AvwSQOWShKHgype
	OBHek4rL0jkwVVAHZSGEonU+8DxhRBo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-87NgGvHDOtmYtfqps4cggA-1; Mon, 19 Aug 2024 07:22:02 -0400
X-MC-Unique: 87NgGvHDOtmYtfqps4cggA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428076fef5dso35832405e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724066521; x=1724671321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJLtyghP2fZR1U5V5rCeuD4Jcl2hiUiX6/kehYYUazc=;
        b=rJ2tCHgnR3a+JphYq+/UDywvT44YFAsfyBcIZakRsbJG82ztQtGftNpkWIdn2fwBv4
         RhLO0j5jll7TOnojU8aAnd9ClMWL47vDdcEsdgODq6SVQcc1ET5hBV6qzBT4sYGQ1vTJ
         C36Vrw6LZR4rmWpGrHXNH1y2Z0NG7kj0Haki6XbSxJSZER7Jd555YCny7g0aGbk3q4/5
         rpHhKSs4Cic0Li7RbpoceVMfFzNiSOoaYZ1OeNRI+Q+hM+jLUKrH3Y+YEG4/8cN9G0R2
         FQtFwWnGwlRgcFYEB6TgCjmF9jQ7/JlwKuI1+Nf1pg72MtPmaFcGtKMIzYlbxqHu4nm+
         NbCA==
X-Forwarded-Encrypted: i=1; AJvYcCUesbyhCHcub2+6j1Lagha//4BcLjzlKxF+SHVRByDlS/1lyJEeF3tOe6Uw4wwmwrMEXNesSnyvpxWEV5/8TL5OJ0dH2ob9vWd3nuDK
X-Gm-Message-State: AOJu0YwkUJltw63RDhtiNmYjincUv4YZbf7GfK003ySLxA8iQCBTPPI6
	fAtVcd8eX8l+KCAhNO+93zB8GL0QoPJi8y4E8HF81Q573x40wr/7Kkva3UgHJxeDOT6T49GHUI9
	3s9P3gO55sR2OyMIcP4CmzbL8tuFjF0KSpW9k92nE7M2GChwlR1Z+YsaTWuPGAw==
X-Received: by 2002:a05:600c:1d05:b0:426:6138:34b3 with SMTP id 5b1f17b1804b1-429ed78560dmr72892025e9.5.1724066520645;
        Mon, 19 Aug 2024 04:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKNMvykeoizvgX4JNe7oK2n1VSGOLmOKrwQXbUromRSy/EWaBdgeZww9boRqAQsfOqLSBmEQ==
X-Received: by 2002:a05:600c:1d05:b0:426:6138:34b3 with SMTP id 5b1f17b1804b1-429ed78560dmr72891855e9.5.1724066520182;
        Mon, 19 Aug 2024 04:22:00 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189839f51sm10304030f8f.8.2024.08.19.04.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:21:59 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:21:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 01/13] acpi/generic_event_device: add an APEI error
 device
Message-ID: <20240819132156.61e31b72@imammedo.users.ipa.redhat.com>
In-Reply-To: <6ecc07c31f8644cdbc00e35199a1e4ca1a1cebdf.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<6ecc07c31f8644cdbc00e35199a1e4ca1a1cebdf.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 09:37:33 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Adds a generic error device to handle generic hardware error
> events as specified at ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
make it match comment in the code for consistency
(i.e reference to 5.0b spec incl chapter/name)

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

should be ACPI 5.0b

> +Aml *aml_error_device(void)
> +{
> +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    return dev;
> +}
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..b4c83a089a02 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
>      ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_ERROR_EVT,
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


