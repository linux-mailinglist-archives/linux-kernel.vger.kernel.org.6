Return-Path: <linux-kernel+bounces-275908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20779948BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B62283D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62341BD508;
	Tue,  6 Aug 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGk+WyTn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45160165EE2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934682; cv=none; b=IN9mYwDNN/g88uih4JxN/2vriWPRQk+uk+6Geo/38SxLVFXxGTqdvg54z+ddIxdBNRpt3na1+OJAGlICmaYYhzOt1iXUCDkO/xn3M48VvfDpVUSP6QISUpYFwasKtae9EeV1SgV8K8bZ6kWp01CPtsv09qPY55vfs1wHxHzxj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934682; c=relaxed/simple;
	bh=VWgW6McWjP04QJIvC8yYz3BMAx3Oktpg/ItbyagpJ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDJ9WWr/rcIWAXBfe+uFeuZKboEe8C9PXS1Mkbc1lH4ceXd6U29Q3soKLNcS0BzqyrtvjjeLbSL8Id3IBVxCIo7FgClSQJiyueMB1+8AcRcdwZp9NYtfx5zCCJSOK2OtSgjdheb8A+JhQmUwidefotkw5HI43ncPxNXwOdvBiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGk+WyTn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722934679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBJPewKe6BU0COfu0bKneZLn3oPmWdR4THfVKVsrupU=;
	b=jGk+WyTn895JBgKxLUJZVANzLy28binITY0LVktcdGWOltw9SuMJ30/6PlT8F7ATFXQtWB
	ZXFpJDZatLXvU9CBPVFY9Bo671xtoTTDjNSYWUSvsNnNYFeoPo/JEcXZ304HiAWsEkIK0K
	cGa6IpKidsiNyWZH5qZX2DIpvoXTcIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-SUzAZmTZPiWK4vbOOMMaGA-1; Tue, 06 Aug 2024 04:57:57 -0400
X-MC-Unique: SUzAZmTZPiWK4vbOOMMaGA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so2755685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 01:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722934676; x=1723539476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBJPewKe6BU0COfu0bKneZLn3oPmWdR4THfVKVsrupU=;
        b=qcJCyRcKeJhtk9NTEdWSPN6kG3WtQjgFP1GWUNwCdcSIhmj/gbzu4RB5d156PId8Tu
         d8VsOU2p9xJV9qxJsy2spkajGz9N4nziEL8d7smle6GG4aoNsi3Y8Vswf/TgqN9KEXre
         kBh6PZDwUHa2Zejl4Aq78CCCyE+1VRI9OENefZz3vcQ+w9qsUFtQuf4ZEmiW1ZssVjDn
         qUu6k+wJ3PhSIiApzp79+MfAiiQq+S9L8i+B/pncVsaYyjqS/2bCUTfqG5R3Qr4UGNsK
         Kny8Qoxkf2YnzMaIuFnwFENmDlsVyOQdCTZt9p0YBpH0YVZyDBiyUmaYTEUrk4QIgnwr
         JMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2DIyTSA1+Y+YdlNbQy4vtfjGlExOXXhCphrbLZ2/k6OwhDbjvqq/84cGYKe6UVg1EtKGp/d1YmbfpXHCe41FQG4GsSCyzJkWUI3ts
X-Gm-Message-State: AOJu0YxU2cK2G6uolGv9Q7U9SP4+TvctXyHYeBlD7SYgMYaPvge6XBBZ
	Uf/letfjs1eSpo4+xLiHm75n/MZcKM0X15VqNcd3Oms3lFCwzK/VBm3pf6htfKezda9rTmZwdGC
	PRYhXKIsHEyiiQDihgmT8U39lZ5L8DRKjzzrnQZk87txckmRUhWfPmKqHD83Pkg==
X-Received: by 2002:a05:600c:3153:b0:428:1846:4f0 with SMTP id 5b1f17b1804b1-428e6b026b1mr88241955e9.16.1722934675720;
        Tue, 06 Aug 2024 01:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhy0J15b8IGtupJPtFKwPmRtb6BzvUMcj8sRdt0nXX8aZb/IrgFx/JYW7qKURbakSBHt5GJg==
X-Received: by 2002:a05:600c:3153:b0:428:1846:4f0 with SMTP id 5b1f17b1804b1-428e6b026b1mr88241715e9.16.1722934675135;
        Tue, 06 Aug 2024 01:57:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e03c4csm173264425e9.13.2024.08.06.01.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:57:54 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:57:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/7] arm/virt: place power button pin number on a
 define
Message-ID: <20240806105752.00c81877@imammedo.users.ipa.redhat.com>
In-Reply-To: <e5afbbaf2836ebe22b48c455285eccef86db966b.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<e5afbbaf2836ebe22b48c455285eccef86db966b.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 23:43:56 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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


