Return-Path: <linux-kernel+bounces-534374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4CA465F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFA03B9A38
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEBE221567;
	Wed, 26 Feb 2025 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="id88J2lj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4E21D3EF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585512; cv=none; b=ak6Z64T9x4SL2t5gAm/J9on7oxxfQ0+6SkObxIZrSXJovUDA4QarZnQorabepNlNB7SKKpMEP/czkSOI/wuOnji/XBqTXddIpz/b/mdXXTZAsJ5uHHCE43gfDIrfUzuw+McMoknjqzZFdAzggc+XGrI7TANV+oYMt0r9LguRTZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585512; c=relaxed/simple;
	bh=lbiAkyqaFcuQNILxSXoShqmV6KLMhq6UtGoT4OrJhoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWj60v1T2Aczf2JgDBZnOT6i55aY/KhbdesaxBcBryhqY6ckKR/3YE92dI4sJeZ8aug2A3Eix+a5OZThTYM2jl1SgGDlbgN1y0zTRp28B91JUs9qGAYcwmszIYgtY8y7y1CmoEix5frKIEnVcdbw0clZ56Nj/XeOccKMp2uoDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=id88J2lj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740585509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6q+MfJiIaN0i87TpsuTV4ud4MXgYfN/GlXWJvHggK/I=;
	b=id88J2ljcAb9y4m2NBN9jw2NBwXu2Pn9yoB4sgN4bUREBQzqILCw4Ik6pJqtJHK/s7Akie
	LBVNlZ8TQe4/aTNmAmfuof3IS7bi+IBgf4uqIo6ITOfhibEgpYkjW2BBMo2Qu+hr4RddQL
	LA7lnTbIL9EpcVMkw42viiZirHDfKI0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-JXX6Nj3EMEOhruYlPV3oVA-1; Wed, 26 Feb 2025 10:58:25 -0500
X-MC-Unique: JXX6Nj3EMEOhruYlPV3oVA-1
X-Mimecast-MFC-AGG-ID: JXX6Nj3EMEOhruYlPV3oVA_1740585505
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f51a3a833so2765286f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585505; x=1741190305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q+MfJiIaN0i87TpsuTV4ud4MXgYfN/GlXWJvHggK/I=;
        b=Pj5gIer+7goSav4w3LHpxj5PbmiR6fm2P6dbKvzy3CD+JB9ua4OhXBB3+k6/dDlH2n
         omtMbPCPKASHh4LTWAWjS6GqJeAcVvJYOXA8vWY4IRC+2y5E31lGyAZuQoukPWEDOwfs
         DLoJ6W4NKScj6X4d3XD2jYYSFSn/FnYJEggF783wuB4b0bAFD9HPyB1gBrQUpWUki2Ay
         IJB+eLs4veoIuh2VXQzHlRZi9CV2iOsRwFby/zmpZibOY5sJO74yEPxhHfSZfZ/2CFKT
         efnNFoy3Ry1EoKN0b/itq6q865+BDU3nwmJoR5PjKUam/RYuvpqQDOCrk1H+LQcxMQF6
         k6LA==
X-Forwarded-Encrypted: i=1; AJvYcCUSh/q+h5dwiBDBtaVJWI/cSAASIem0wxFaHDb9GKEA1EM0e8Rrlh3G4VCwDeG0fehDscSTS2oOKpQKAaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GvgFKDPaotlnuwBijddcsLBwIMpk4GncdU6IZU1dWX9Gcq61
	ATNY9YCGdhQqFRmHREjptJScJxNSkkJ8s1189TZPMJPsYlUGL/2FK6VaRnr6or1b7rNnzQkOlsS
	Oz2UyCtxCQOI8FS0wrK90aSnxsYt76O31MH7ZVHiSWAZJTVPOz2LtAwYq9PJ/bg==
X-Gm-Gg: ASbGncuGhWklI6jRclTLNLvPqZiqH97mWXNYh7qQuwjXmIwypg5Xo3lUQPxIcPH1ZkD
	YKqJK1TfaJhKqm7NMYw3oHueWTxp0Gjw0p9lWzeh2wMMozMNg+GQ8phW5KbreYPnhTfUOJTINQk
	Hgey3dLaXx94k60oKn0nxIqDZIznSb4iZtXmHUedgEUhMB0/2NN97gUovkcyHY93RxVg303kBqd
	PmSc6GnVoY6XhEA4w40Y9pORg7xGCOi+G+MNl6RjQMckd4yXXAiHZ3LT4u6LaIw5alsASlzdL48
	45uWMRR9mfWZXDAqZInygmZr4p44JH4ff5Y91Vs57Ar9zXe8uNDMPDt9z8BaupA=
X-Received: by 2002:a05:6000:18a9:b0:38f:28a1:503f with SMTP id ffacd0b85a97d-38f707728e5mr18043411f8f.11.1740585504674;
        Wed, 26 Feb 2025 07:58:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXHC8a93KgRIlFJAiZUxxPTJisHxJGeiPx1mpGo848eB+LMy6//uk7tw0WyQYrknxhTmMs+Q==
X-Received: by 2002:a05:6000:18a9:b0:38f:28a1:503f with SMTP id ffacd0b85a97d-38f707728e5mr18043389f8f.11.1740585504271;
        Wed, 26 Feb 2025 07:58:24 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca9csm6036028f8f.22.2025.02.26.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:58:23 -0800 (PST)
Date: Wed, 26 Feb 2025 16:58:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/14] arm/virt: Wire up a GED error device for ACPI
 / GHES
Message-ID: <20250226165823.14f08232@imammedo.users.ipa.redhat.com>
In-Reply-To: <87cb9cc850fb728f11d88a83c05b288baca556df.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<87cb9cc850fb728f11d88a83c05b288baca556df.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:35:20 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Adds support to ARM virtualization to allow handling
> generic error ACPI Event via GED & error source device.
> 
> It is aligned with Linux Kernel patch:
> https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> 
> ---
> 
> Changes from v8:
> 
> - Added a call to the function that produces GHES generic
>   records, as this is now added earlier in this series.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c |  2 +-
>  hw/arm/virt-acpi-build.c       |  1 +
>  hw/arm/virt.c                  | 12 +++++++++++-
>  include/hw/arm/virt.h          |  1 +
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 180eebbce1cd..f5e899155d34 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -331,7 +331,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> -    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, true),
irrelevant to this patch, see comment in 8/14

>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9de51105a513..4f174795ed60 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -861,6 +861,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_dsdt_add_power_button(scope);
> +    aml_append(scope, aml_error_device());
>  #ifdef CONFIG_TPM
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4a5a9666e916..3faf32f900b5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -678,7 +678,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>      DeviceState *dev;
>      MachineState *ms = MACHINE(vms);
>      int irq = vms->irqmap[VIRT_ACPI_GED];
> -    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
> +    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;
>  
>      if (ms->ram_slots) {
>          event |= ACPI_GED_MEM_HOTPLUG_EVT;
> @@ -1010,6 +1010,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      }
>  }
>  
> +static void virt_generic_error_req(Notifier *n, void *opaque)
> +{
> +    VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
> +
> +    acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
> +}
> +
>  static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>                               uint32_t phandle)
>  {
> @@ -2404,6 +2411,9 @@ static void machvirt_init(MachineState *machine)
>  
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
> +        vms->generic_error_notifier.notify = virt_generic_error_req;
> +        notifier_list_add(&acpi_generic_error_notifiers,
> +                          &vms->generic_error_notifier);
>      } else {
>          create_gpio_devices(vms, VIRT_GPIO, sysmem);
>      }
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c8e94e6aedc9..f3cf28436770 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -176,6 +176,7 @@ struct VirtMachineState {
>      DeviceState *gic;
>      DeviceState *acpi_dev;
>      Notifier powerdown_notifier;
> +    Notifier generic_error_notifier;
>      PCIBus *bus;
>      char *oem_id;
>      char *oem_table_id;


