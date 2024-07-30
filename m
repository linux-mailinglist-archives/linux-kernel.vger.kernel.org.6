Return-Path: <linux-kernel+bounces-267057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6184940BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673F31F24366
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7719412E;
	Tue, 30 Jul 2024 08:39:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8FD192B75
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328784; cv=none; b=thTBqtbgaEscuA//g3f1Dq5FW6yWPd5sXUwOcBWjMS2XKwajmZwnf7ViIpVC0J0I3HGh61Eiips1Mj2R0HoZUMKhMtApvVtq1iFd76fuYSTG51n4orOzO1JWKcnxRNWZfm7wTY50pf2ZLaoFVVNqjUvKA9b+OVAl/Xsvv1q9fY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328784; c=relaxed/simple;
	bh=a7khnMrdM5k51JUpNH1Hgjs1HgLaoAfx9+qa5Spz5aE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgLs3pq0bKMUOv3a0SLTYmppFl8QNBqlmPJRsqF2sTb6mwerHvTOpTHP4nHE9suvV75X+kieoT6MWwT7iaEKZnTm5X/7YIx/5RwDfIlSBRBqjX5V40MfTzwZC0u7d5QiO8lM2hKRuWzwDAHY2KQ1pJsDi6xqvaaHZp92mcmMFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WY7s41Bymz6K8xQ;
	Tue, 30 Jul 2024 16:37:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F3897140516;
	Tue, 30 Jul 2024 16:39:38 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 30 Jul
 2024 09:39:38 +0100
Date: Tue, 30 Jul 2024 09:39:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Ani Sinha
	<anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov
	<imammedo@redhat.com>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
	"Yanan Wang" <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI /
 GHES
Message-ID: <20240730093937.00001baf@Huawei.com>
In-Reply-To: <20240730071330.4835e943@foz.lan>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
	<e994c3944d31775d62bbd017dec3adff50ddf269.1722259246.git.mchehab+huawei@kernel.org>
	<20240729170840.00004763@Huawei.com>
	<20240730071330.4835e943@foz.lan>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Jul 2024 07:13:30 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 29 Jul 2024 17:08:40 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:
> 
> > On Mon, 29 Jul 2024 15:21:06 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Creates a Generic Event Device (GED) as specified at    
> > 
> > I wrote this a while back and wasn't aware of the naming
> > mess around GED in the ACPI spec.  This one is just
> > referred to as 'error device' whereas there is also
> > a Generic Event Device.
> > 
> > Linux solved this clash by going with Hardware Error Device
> > I think we should do the same here.  
> 
> I opted to do it a little bit different to stay closer to ACPI 6.5
> 18.3.2.7.2. - Event Notification For Generic Error Sources.
> 
> There, it is actually talking about a General Purpose Event (GPE).
> Current ACPI spec doesn't mention "GED", so maybe such term was fixed
> on some previous ACPI spec revision.
> 
> Basically, it currently mentions:
> 	- error device
> 	- GPE / General Purpose Event
> 	- Generic Hardware Error Source Structure 
> 
> I guess Linux crafted the term Hardware Error device by mixing
> those.
> 
> As we don't need to really preserve such names here, as this appears
> only at the patch description, I opted to rewrite the patch description
> to:
> 
>     arm/virt: Wire up GPIO error source for ACPI / GHES
>     
>     Creates a hardware event device to support General Purpose
>     Event (GPE) as specified at ACPI 6.5 specification at 18.3.2.7.2:
>     https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
>     using HID PNP0C33.
>     
>     The PNP0C33 device is used to report hardware errors to
>     the bios via ACPI APEI Generic Hardware Error Source (GHES).
>     
>     It is aligned with Linux Kernel patch:
>     https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
>     
>     [mchehab: use a define for the generic event pin number and do some cleanups]
>     Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>     Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Clearly associating "hardware event device" with ACPI GPE. That sounds
> good enough to be stored at the git description associated with such
> change.
All looks good to me.

Thanks,

Jonathan

> 
> > > ACPI 6.5 specification at 18.3.2.7.2:
> > > https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> > > with HID PNP0C33.
> > > 
> > > The PNP0C33 device is used to report hardware errors to
> > > the bios via ACPI APEI Generic Hardware Error Source (GHES).
> > > 
> > > It is aligned with Linux Kernel patch:
> > > https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> > > 
> > > [mchehab: use a define for the generic event pin number and do some cleanups]
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> >   
> > > ---
> > >  hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
> > >  hw/arm/virt.c            | 14 ++++++++++++--
> > >  include/hw/arm/virt.h    |  1 +
> > >  include/hw/boards.h      |  1 +
> > >  4 files changed, 40 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index f76fb117adff..c502ccf40909 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -63,6 +63,7 @@
> > >  
> > >  #define ARM_SPI_BASE 32
> > >  
> > > +#define ACPI_GENERIC_EVENT_DEVICE "GEDD"    
> > 
> > Ah. My mistake. This is the confusing named GENERIC_ERROR_DEVICE
> > or HARDWARE_ERROR_DEVICE (which is what Linux called it because
> > in the ACPI Spec it is just (all lower case) error device).  
> 
> I opted to use a different name there, using just error device,
> together with the name of the PNP device. So:
> 
> 	#define PNP0C33_ERROR_DEVICE "GEDD"
> 
> This is clear enough for people just looking at the driver, and
> even clearer for people familiar with session 18.3.2.7.2 of the
> ACPI spec.
> 
> >   
> > >  #define ACPI_BUILD_TABLE_SIZE             0x20000    
> >   
> > >  /* DSDT */
> > >  static void
> > >  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > > @@ -841,10 +863,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > >                        HOTPLUG_HANDLER(vms->acpi_dev),
> > >                        irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
> > >                        memmap[VIRT_ACPI_GED].base);
> > > -    } else {
> > > -        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> > > -                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
> > >      }
> > > +    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> > > +                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));    
> > 
> > Arguably excess brackets, but obviously this is just a code move
> > so fine to keep it the same.  
> 
> I'll drop the extra brackets.
> 
> > >  
> > >      if (vms->acpi_dev) {
> > >          uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
> > > @@ -858,6 +879,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > >      }
> > >  
> > >      acpi_dsdt_add_power_button(scope);  
> 
> > > +    acpi_dsdt_add_generic_event_device(scope);  
> 
> I'm also renaming this function/function call to run away from GED,
> calling it as:
> 
> 	 acpi_dsdt_add_error_device(scope);
> 
> > >  #ifdef CONFIG_TPM
> > >      acpi_dsdt_add_tpm(scope, vms);
> > >  #endif    
> >   
> 
> Thanks,
> Mauro


