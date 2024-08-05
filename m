Return-Path: <linux-kernel+bounces-275022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70F947FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74D5283924
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44015CD4E;
	Mon,  5 Aug 2024 16:54:08 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6B15B984
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876847; cv=none; b=WZ4BTBcuRPDIC0sYIHRolSKaafq89QKELeileD9qmpWTpJY0hKhO9RN+s8nENcx1w5VilEBEhG+tvlKvb5BP8FR3hefjZIrC3PE35xsDguDYeMLcSB5EaPqviIxyx3tF5Ls8wqDUZzYf0nSYMos2djfznxwwED6i5xcZ9rLSes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876847; c=relaxed/simple;
	bh=iXksU/Y0eL6+DvXM8ynNFWUseH4fzb5VaDn/DPkCzN8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5GcZ90ZeOBATxfiPeWWY68sEFe5yulYang9V/Z78gQR50E14vlc6JhBI6K+fvaFM8GTuCsMHiXWAL0REuJDiO0babXd5LYAAfiiP5+c9DM6xFZpct0bNhe4X5bdJmOPh0PsIWmEHSADe1hdcQ2UvFGMHz+e+al04qzk68IsC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wd2Wk0HfGz67Q9H;
	Tue,  6 Aug 2024 00:51:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 11A5C140B3C;
	Tue,  6 Aug 2024 00:54:02 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 5 Aug
 2024 17:54:01 +0100
Date: Mon, 5 Aug 2024 17:54:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor
 Mammedov <imammedo@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 3/7] arm/virt: Wire up GPIO error source for ACPI /
 GHES
Message-ID: <20240805175400.000028ad@Huawei.com>
In-Reply-To: <d0607d8f6116ff841b6c6a17d20f6d7077063045.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<d0607d8f6116ff841b6c6a17d20f6d7077063045.1722634602.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri,  2 Aug 2024 23:43:58 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

Do we need to rename this now there is a GED involved?
Is it even technically a GPIO any more?
Spec says in 18.3.2.7 
HW-reduced ACPI platforms signal the error using a GPIO
interrupt or another interrupt declared under
a generic event device (Interrupt-signaled ACPI events)
and goes on to say that a _CRS entry is used to
list the interrupt.

Give the Generic Event Device has a _CRS
with aml_interrupt() as the type I think we should
even have the hest entry say it's an interrupt (external?)
rather than a gpio.


> Adds support to ARM virtualization to allow handling
> a General Purpose Event (GPE) via GED error device.
> 
> It is aligned with Linux Kernel patch:
> https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Again, more or less fine with this
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
to go with that co-auth

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
> +
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


