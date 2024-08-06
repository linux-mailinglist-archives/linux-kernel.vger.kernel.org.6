Return-Path: <linux-kernel+bounces-275924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A53948C01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C801C234CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D41BDA80;
	Tue,  6 Aug 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UX860yU1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12D1607BD
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935722; cv=none; b=ZrwFk6u5MIRjTsvAkdUUJXOgKhyV3zM7u9NqhYTJRiz5s/HUNGuZLIq7DU1nmHoIh4YBrC3TBCxc4isYlmZbIjKFBdTIobkS3qO/2PsmgkSP8yaA5fpN2jbvLCyStW8N/O+wDUyzsmJO/P+qZtps82d7Mk9/eh49uQMySc94tYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935722; c=relaxed/simple;
	bh=qOjNWZTYfnD2JorrZj+LoPfVSS4w/wPVk7NTfIpDCT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jl4sAfi2FPOWFtjv7ApZKvHui1r6kN6JCIQE7M+gYJo65Y1gBt5l6wXYKQYBYNwxJyUSYAiW8WE5W7jXGpuXIOTC0ZYWMXFD1MT05xnD/S2p/56QSvgx4EKa/7HUQW+jimOAIW8lGTLFNLYGic0uL2C7vNVxJWIc2XqnC+W1M7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UX860yU1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722935719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5XhwKW5c4U1g4cZzHAN5oWzywBtrKv0PzNTnHbR+SW4=;
	b=UX860yU1KInc1UDkqRtmtSmAc7dQbov4kkvYpo7f46s15063wOaeK/lfgxJLFP3vTNxCug
	WW+3AxxQJZgSUhLaVIWt5h9EL3glYeTBkEfIcCZQWa+lA8Hj28w+gmJJcUwuGVJpio5MSI
	izbtv1JnrQsCibvnaT4YkoWlg/JWTxE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Vh2VK8MmNDS2VxFILspmMw-1; Tue, 06 Aug 2024 05:15:17 -0400
X-MC-Unique: Vh2VK8MmNDS2VxFILspmMw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281f8994adso3112955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722935716; x=1723540516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XhwKW5c4U1g4cZzHAN5oWzywBtrKv0PzNTnHbR+SW4=;
        b=OgSih0w58pN/ynESOjTaqEgr/I/Q98g6BiD6F52vdMUojiiO42iX4WC3uTzmgFoyD4
         cTK4nDhOR3cFmMU4fgFBWQeq4zZ/2tYDHZX2hNU123FhPo1/TFjhVt/id481tg7xbBdH
         BfaUGxaxfEMT/jpLBRWnFbyHp5Uyp+hpv8drlMGDB7xn9P8M1Wn/xcl3bbel02lQbBUQ
         y4uk82f3rYTs5j84rWSHeKuDVxSz9WSDNqsF42m5Srdd/M9kUUUWXVy6jR/FhzhF8kro
         T2II41SyV25fh2ZqRZQhKOjpg0Uf3UXlLMEfQHEc9e113GadiQ+YV7VyT0YP5sdl8a/N
         BqcA==
X-Forwarded-Encrypted: i=1; AJvYcCUXK+dADl+/gx9SevzUfIAzo8R69QnSHXqX6CU2ZvK1+D9rf/PrPvLUVUH/4aXhCjttGxyOrvYcp+S5VCQ+kBpATZWl3rjuLIhBUcaa
X-Gm-Message-State: AOJu0YyZereuIuszKtckhi5Nn6g+cOSRkwKlaC6VhMEA2T+LcR3rezXm
	gSO3c8EJK0yqhSprDXxzR1RzO0jCsuPrC6CZeFZaHfREkDutpNs/Gfyk5jmfw67uuxVE5expQXx
	qpEAV0wxzvWnIeFESV2fDnPzgjRit+nveiXW07R3Sdgx8OehulRTyjjt64gZkxw==
X-Received: by 2002:a05:600c:4fcb:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-428e6a5afc3mr120542125e9.0.1722935716171;
        Tue, 06 Aug 2024 02:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfynUbZWqukL1ikowgqaVa3Y8Xs90DfG1xqFxO0dbhDyiUrxVhp7Hd8uSUD1yyMeMOc+VVqw==
X-Received: by 2002:a05:600c:4fcb:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-428e6a5afc3mr120541765e9.0.1722935715567;
        Tue, 06 Aug 2024 02:15:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e03c4csm173915565e9.13.2024.08.06.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 02:15:15 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:15:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 3/7] arm/virt: Wire up GPIO error source for ACPI /
 GHES
Message-ID: <20240806111514.680ba61e@imammedo.users.ipa.redhat.com>
In-Reply-To: <d0607d8f6116ff841b6c6a17d20f6d7077063045.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<d0607d8f6116ff841b6c6a17d20f6d7077063045.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 23:43:58 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

subj: s/GPIO/GED signaled/

> Adds support to ARM virtualization to allow handling
> a General Purpose Event (GPE) via GED error device.
s/General Purpose Event (GPE).../
  generic error ACPI Event via GED & error source device


> It is aligned with Linux Kernel patch:
> https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c           |  3 +++
>  hw/arm/virt-acpi-build.c |  1 +
>  hw/arm/virt.c            | 16 +++++++++++++++-
>  include/hw/acpi/ghes.h   |  3 +++
>  include/hw/arm/virt.h    |  1 +
>  5 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e9511d9b8f71..8d0262e6c1aa 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -444,6 +444,9 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      return ret;
>  }
>  
> +NotifierList generic_error_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);

s/generic_error_notifiers/acpi_generic_error_notifiers/

>  bool acpi_ghes_present(void)
>  {
>      AcpiGedState *acpi_ged_state;
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f76fb117adff..f8bbe3e7a0b8 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -858,6 +858,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_dsdt_add_power_button(scope);
> +    acpi_dsdt_add_error_device(scope);

with suggested change in 2/7, this will look like
aml_append(scope, aml_foo_device());


>  #ifdef CONFIG_TPM
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 687fe0bb8bc9..8b315328154f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -73,6 +73,7 @@
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/ghes.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/internals.h"
>  #include "target/arm/multiprocessing.h"
> @@ -677,7 +678,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>      DeviceState *dev;
>      MachineState *ms = MACHINE(vms);
>      int irq = vms->irqmap[VIRT_ACPI_GED];
> -    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
> +    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;
>  
>      if (ms->ram_slots) {
>          event |= ACPI_GED_MEM_HOTPLUG_EVT;
> @@ -1009,6 +1010,15 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      }
>  }
>  
> +static void virt_generic_error_req(Notifier *n, void *opaque)
> +{
> +    VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
> +
> +    if (s->acpi_dev) {

I'd assert her, and move check to caller so it won't even add
a notifier if acpi_dev is not present

> +        acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
> +    }
> +}
> +
>  static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>                               uint32_t phandle)
>  {
> @@ -2397,6 +2407,10 @@ static void machvirt_init(MachineState *machine)
>       vms->powerdown_notifier.notify = virt_powerdown_req;
>       qemu_register_powerdown_notifier(&vms->powerdown_notifier);
>  
> +     vms->generic_error_notifier.notify = virt_generic_error_req;
> +     notifier_list_add(&generic_error_notifiers,
> +                       &vms->generic_error_notifier);
> +
>      /* Create mmio transports, so the user can create virtio backends
>       * (which will be automatically plugged in to the transports). If
>       * no backend is created the transport will just sit harmlessly idle.
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 674f6958e905..6891eafff5ab 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,9 @@
>  #define ACPI_GHES_H
>  
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qemu/notify.h"
> +
> +extern NotifierList generic_error_notifiers;
>  
>  /*
>   * Values for Hardware Error Notification Type field
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index a4d937ed45ac..ad9f6e94dcc5 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -175,6 +175,7 @@ struct VirtMachineState {
>      DeviceState *gic;
>      DeviceState *acpi_dev;
>      Notifier powerdown_notifier;
> +    Notifier generic_error_notifier;
>      PCIBus *bus;
>      char *oem_id;
>      char *oem_table_id;


