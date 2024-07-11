Return-Path: <linux-kernel+bounces-249152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C1E92E7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8331F22727
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661815EFB8;
	Thu, 11 Jul 2024 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhmCCytJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7B15B113
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698899; cv=none; b=Nlju/BaSjBz8uMvm19SsF2BHLWc8FKyvtyfaTLGQlAQ90Z3pGRPnnA9gN6Z+F0v9DWU1s5f5wnvHSTXRlKrRrg7yb+eNz1WEVkFEqBYp7bbjcY327LVc2sWBiq4HFg+iEf7SXYnlQZTqrGx+o+e7bE8l5xGfrUwNYHzwUNvpRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698899; c=relaxed/simple;
	bh=IdjLAHC8Ml0Zk3Ol4hgBt0RReXSyC9D+z0qNStfQcw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrvNNyjNiWkB2NjpZZlHjLlCUmxNNoqep1QKyFr4DBs6wyYuF28+m/ub1kuBAmzxa7JVOBwT1lPTgFY47TUOST+P5FZnnE947ZdQ6V+eOTySVDOKVnODzWdbfgBU328liqji6gZVG507KqW17STikoJ3HMNIoMjVCHdUFrRKexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhmCCytJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720698896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLUrFLCqikNAsPcbf03qUnXoJ46gCuQE0XBBtbkOSEc=;
	b=dhmCCytJbLvmJhYSH5aHbRM6sCnBycoUMuwVUbK2hwFqBD4WPsuyqtRXIvtWmpLHt4bW99
	C4CIGdCfjArjS7wrROIdTc8RMlHaCc8h+mB4zCas2rc0s17N9/Hk9+I7z6JjWBqQQj1lGP
	80OjKrqFsWVzgx1Ej8JZCi5Qj8Hx/cQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-ev1PWeEJOAOGIaBNAU4DiA-1; Thu, 11 Jul 2024 07:54:55 -0400
X-MC-Unique: ev1PWeEJOAOGIaBNAU4DiA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee9308bc8cso6964201fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720698894; x=1721303694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLUrFLCqikNAsPcbf03qUnXoJ46gCuQE0XBBtbkOSEc=;
        b=cEtwqp3Pi1ljO4l/CexCCwjLbb9y7dcd07AoEIS6HC590vsJ1EpLCgRRy4VN5F1KRb
         oGUWnPlbKWqlhmNIupPCMhfXpcnD499WDB7KfmK/Hpw64N1t8za0hg+Oe1YW7llYryfS
         j5KCu5a0iMLggAXEEvqMW2eMOnYJCyrQ3GPogFKKnFSJu+C34hJ5mC9LBkihI377qoct
         mCwoE1Etv8I7Wy6ieGNNBsfxX1OohYbxX6mN9KHGq0095FZAYxy14cBPFy7Fvzby7omY
         i6w0tHgchfyXhI24lh4b0CPuCY8z+Z3kPNWaiPCk1SNHuk0vnK5nIdFTFxkmur5n28oW
         9C+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvStlbM0UYbm1g5ImJc/VqGsQGTl8rVgX5EnJXi58aZ7Q1RK9C4rJFGwxhGfN0nzexbtWp7WbQXkV6a1l95EEQCzeEHeOQardSx0Tg
X-Gm-Message-State: AOJu0Yw/56PApnAaB6o/TdLgE/Gz2VI99gASM5xd9NLFSrBViNRny/Vc
	BfwQuElk4m4oR0dEKcPloA5aBAhi2jmd3hdnAzJsJ17+U0SWpu3sibROg6iBK3zAhLABdkwCfo6
	AAcmpFI6t7NE72xRHfCI3JDPvkxWv9nXp9+X8+NdnRqijpWGNHCWwaX0pf0Zz7g==
X-Received: by 2002:a2e:90cc:0:b0:2ee:7a7e:8ebb with SMTP id 38308e7fff4ca-2eeb3198b20mr51410591fa.52.1720698893669;
        Thu, 11 Jul 2024 04:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdSlbHD+ZgkWTuRRwa17SNwKB4KIBO0IU5PmgF3bItPbAkUonL9qMh9qOg9B0O82tb2+tcog==
X-Received: by 2002:a2e:90cc:0:b0:2ee:7a7e:8ebb with SMTP id 38308e7fff4ca-2eeb3198b20mr51410401fa.52.1720698892904;
        Thu, 11 Jul 2024 04:54:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279accecf4sm17799785e9.39.2024.07.11.04.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:54:52 -0700 (PDT)
Date: Thu, 11 Jul 2024 07:54:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Igor Mammedov <imammedo@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>, linux-edac@kernel.org,
	linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH 1/6] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <20240711075332-mutt-send-email-mst@kernel.org>
References: <cover.1720690278.git.mchehab+huawei@kernel.org>
 <b9cd4a65d3389102def662a8bc09ffaa622265f7.1720690278.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9cd4a65d3389102def662a8bc09ffaa622265f7.1720690278.git.mchehab+huawei@kernel.org>

On Thu, Jul 11, 2024 at 11:52:03AM +0200, Mauro Carvalho Chehab wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Creates a GED - Generic Event Device and set a GPIO to
> be used or error injection.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 29 +++++++++++++++++++++++++----
>  hw/arm/virt.c            | 12 +++++++++++-
>  include/hw/boards.h      |  1 +
>  3 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd73..b6f2e55014a2 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -63,6 +63,7 @@
>  
>  #define ARM_SPI_BASE 32
>  
> +#define ACPI_GENERIC_EVENT_DEVICE "GEDD"
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
>  
>  static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
> @@ -155,9 +156,14 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>  
>      Aml *aei = aml_resource_template();
>      /* Pin 3 for power button */
> -    const uint32_t pin_list[1] = {3};
> +    uint32_t pin = 3;
>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
> +                                 "GPO0", NULL, 0));
> +    pin = 6;
> +    /* Pin 8 for generic error */

For real? Code says 6, comment says 8.

Comments must come before the code they comment, not after it,
then this kind of thing won't happen.


> +    aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
>      aml_append(dev, aml_name_decl("_AEI", aei));
>  
> @@ -166,6 +172,11 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(method, aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>                                    aml_int(0x80)));
>      aml_append(dev, method);
> +    method = aml_method("_E06", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_notify(aml_name(ACPI_GENERIC_EVENT_DEVICE),
> +                                  aml_int(0x80)));
> +    aml_append(dev, method);
> +
>      aml_append(scope, dev);
>  }
>  
> @@ -800,6 +811,15 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
>      build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
>  }
>  
> +static void acpi_dsdt_add_generic_event_device(Aml *scope)
> +{
> +    Aml *dev = aml_device(ACPI_GENERIC_EVENT_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> +    aml_append(scope, dev);
> +}
> +
>  /* DSDT */
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -842,9 +862,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                        irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
>                        memmap[VIRT_ACPI_GED].base);
>      } else {
> -        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> -                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      }
> +    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> +                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>  
>      if (vms->acpi_dev) {
>          uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
> @@ -858,6 +878,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_dsdt_add_power_button(scope);
> +    acpi_dsdt_add_generic_event_device(scope);
>  #ifdef CONFIG_TPM
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b0c68d66a345..874a8612ef2d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -997,6 +997,13 @@ static void create_rtc(const VirtMachineState *vms)
>  }
>  
>  static DeviceState *gpio_key_dev;
> +
> +static DeviceState *gpio_error_dev;
> +static void virt_set_error(void)
> +{
> +    qemu_set_irq(qdev_get_gpio_in(gpio_error_dev, 0), 1);
> +}
> +
>  static void virt_powerdown_req(Notifier *n, void *opaque)
>  {
>      VirtMachineState *s = container_of(n, VirtMachineState, powerdown_notifier);
> @@ -1014,6 +1021,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>  {
>      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
>                                          qdev_get_gpio_in(pl061_dev, 3));
> +    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> +                                          qdev_get_gpio_in(pl061_dev, 6));
>  
>      qemu_fdt_add_subnode(fdt, "/gpio-keys");
>      qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
> @@ -2385,8 +2394,8 @@ static void machvirt_init(MachineState *machine)
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
>      } else {
> -        create_gpio_devices(vms, VIRT_GPIO, sysmem);
>      }
> +    create_gpio_devices(vms, VIRT_GPIO, sysmem);
>  
>      if (vms->secure && !vmc->no_secure_gpio) {
>          create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
> @@ -3100,6 +3109,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->default_ram_id = "mach-virt.ram";
>      mc->default_nic = "virtio-net-pci";
>  
> +    mc->set_error = virt_set_error;
>      object_class_property_add(oc, "acpi", "OnOffAuto",
>          virt_get_acpi, virt_set_acpi,
>          NULL, NULL);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ef6f18f2c1a7..6cf01f3934ae 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -304,6 +304,7 @@ struct MachineClass {
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>      ram_addr_t (*fixup_ram_size)(ram_addr_t size);
> +    void (*set_error)(void);
>  };
>  
>  /**
> -- 
> 2.45.2


