Return-Path: <linux-kernel+bounces-279661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B912394C02A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4CC1C22C78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED118FC86;
	Thu,  8 Aug 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dj9xXbkP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAD18EFDC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128263; cv=none; b=a1RYVEsajAb3Ptxvby5AqyGt1NWoOeum+KnR67AU7BYBZOvg6yfIMKHxM5Dzx9QSiTyt4P4MYcMlsyO1vpIAZh5+7S8/xe1p+ofgjccfarzTGnyZKyJts819l93yJoMEpSN9YIoxlmTU3XRNtIcD+v1hQ27Iw27yJCMux++lYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128263; c=relaxed/simple;
	bh=PJMk6Uqzz5UNIds09MxiiNBipTUv59eDmu0eBQ7jh18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxQEdmPOSz6of83qL+6Sd4+mbVGD4l8Vi96H2q/Ib++JiiNlJd9AL9Vqk0UMqFY2QHcN8uo0NYBqc8hHYpnJVuAdG7DZHXpwFg8HwxAHSGpC5Ydndmdz3IsNhVvCAKYuQBpAJrWgfVipnihOhSwrmTKMrYThUnAZ5GdqjcA0Qdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dj9xXbkP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723128260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2yHWhOGhXoiaID94xq0Obn8IF6l9bmHYEIpGRlWg4Yk=;
	b=dj9xXbkPPUVgxS3J9df12ZRP4qZLiM+OITIMzWQe0FxQTQXGfWaU4ccrN1rx+pNdXGgTLp
	+geIlBjbnhmx2it2IZ1SFkQ03stbLbgKvm6SJaYHp134Ugfd8gP3qPn13xGLAt/NXzmn5D
	5tCwSZ74HxJRgLSSepo52fZaZMxnta8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-zWl_l8BEN4-VdGbwtCOing-1; Thu, 08 Aug 2024 10:44:19 -0400
X-MC-Unique: zWl_l8BEN4-VdGbwtCOing-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52f00bde210so1278195e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128258; x=1723733058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yHWhOGhXoiaID94xq0Obn8IF6l9bmHYEIpGRlWg4Yk=;
        b=aTPGphWy0DYH+VKoJ3HEmzzNgTCyglqB6vQpzQM5tQKwzKRwYPETTQa9FRN63mU4QB
         xErYPCnwPZEvIGPIfJyPPaUWfhJCnewrv0Y+T8bAHREbB7t+ViELbKZoXTHmC3O2Uj2A
         djJ8dLO8fGlnNLyGig/jeFVCQbIXOnnVapUC2R7lhcZ5FeiMyPQ3ECqo6E2j8DKgxDCa
         jl+7xrZKoG1bzTkOnfiW3IIUr6qY10KdYv576LYT4PZbtGDqNUYozjVsERBmQS5K7x7n
         YYUZmU50K+WX1JICZ4f2JzfMj6rlrE/y7pCYdotvv6XMKcsHi8h8aDa6HQDtka8yOSy9
         VnRA==
X-Forwarded-Encrypted: i=1; AJvYcCW+3f5aP+HD7PQE8QY3vGHSKiwgFhKlB7+bEJLpFPwI7RpJDmE5J/6yWkfK/gq+Y/SgxugHmMVAT1valZvEAsvWa6jmScwW44oJZh/C
X-Gm-Message-State: AOJu0Yz71cZw4V8Fa8hIL2eFxBdWF85w8m8mRjTyLQR8C1jXFHibpd6x
	L9QYQj9kcaHZjTwmmde5yYGPSIW2jmnK1NMiQeMAVONLasVEwNee9tShSpS2B4/Sw+UR4IgQyUt
	srmn5yAL8p7ml/eMvDXksSv2406m+rGx/kT5jYv1g+76L5D4Ju7CKAIGlePV7zA==
X-Received: by 2002:a05:6512:3f2a:b0:52c:deba:7e6e with SMTP id 2adb3069b0e04-530e583dbd1mr1838870e87.29.1723128257877;
        Thu, 08 Aug 2024 07:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyh0BU4hkdxFulosZVyBK7BJraF3bjcMfeyi8ouHjXm8HPCLcpB/V7MWfZ+ttDa5YmHQVeiw==
X-Received: by 2002:a05:6512:3f2a:b0:52c:deba:7e6e with SMTP id 2adb3069b0e04-530e583dbd1mr1838822e87.29.1723128256896;
        Thu, 08 Aug 2024 07:44:16 -0700 (PDT)
Received: from redhat.com ([2.55.34.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e8676fsm742332666b.164.2024.08.08.07.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:44:16 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:43:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] arm/virt: place power button pin number on a define
Message-ID: <20240808104308-mutt-send-email-mst@kernel.org>
References: <ef0e7f5fca6cd94eda415ecee670c3028c671b74.1723121692.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0e7f5fca6cd94eda415ecee670c3028c671b74.1723121692.git.mchehab+huawei@kernel.org>

On Thu, Aug 08, 2024 at 02:54:52PM +0200, Mauro Carvalho Chehab wrote:
> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
> 
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA-PYnZ-32MRX+PgvzhnoAV80zBKMYg61j2f=oHaGfwSsg@mail.gmail.com/
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

ack, but note we do things like that only if something
is repeated.

> ---
>  hw/arm/virt-acpi-build.c | 6 +++---
>  hw/arm/virt.c            | 7 ++++---
>  include/hw/arm/virt.h    | 3 +++
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd73..f76fb117adff 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -154,10 +154,10 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  
>      Aml *aei = aml_resource_template();
> -    /* Pin 3 for power button */
> -    const uint32_t pin_list[1] = {3};
> +
> +    const uint32_t pin = GPIO_PIN_POWER_BUTTON;
>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
>      aml_append(dev, aml_name_decl("_AEI", aei));
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 719e83e6a1e7..687fe0bb8bc9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      if (s->acpi_dev) {
>          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
>      } else {
> -        /* use gpio Pin 3 for power button event */
> +        /* use gpio Pin for power button event */
>          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
>      }
>  }
> @@ -1013,7 +1013,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>                               uint32_t phandle)
>  {
>      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> -                                        qdev_get_gpio_in(pl061_dev, 3));
> +                                        qdev_get_gpio_in(pl061_dev,
> +                                                         GPIO_PIN_POWER_BUTTON));
>  
>      qemu_fdt_add_subnode(fdt, "/gpio-keys");
>      qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
> @@ -1024,7 +1025,7 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>      qemu_fdt_setprop_cell(fdt, "/gpio-keys/poweroff", "linux,code",
>                            KEY_POWER);
>      qemu_fdt_setprop_cells(fdt, "/gpio-keys/poweroff",
> -                           "gpios", phandle, 3, 0);
> +                           "gpios", phandle, GPIO_PIN_POWER_BUTTON, 0);
>  }
>  
>  #define SECURE_GPIO_POWEROFF 0
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index ab961bb6a9b8..a4d937ed45ac 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -47,6 +47,9 @@
>  /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
>  #define PVTIME_SIZE_PER_CPU 64
>  
> +/* GPIO pins */
> +#define GPIO_PIN_POWER_BUTTON  3
> +
>  enum {
>      VIRT_FLASH,
>      VIRT_MEM,
> -- 
> 2.45.2


