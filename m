Return-Path: <linux-kernel+bounces-266929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCA29409E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420BC1C23448
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7D18FDA5;
	Tue, 30 Jul 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQu7pBbL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7915FD08
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324359; cv=none; b=E8QGsdYnE8fNUmR+5F3lEglHX7/OVBCzE5hR9N20DzY5yIKofkjnWzx+v/kUc69TrP8Q5jgC+913wJTusJhknhLjXmPOuPhCP+BaGUXC/lfZpZDyimxW9VwyEzg2eHk55s04iEVK0lQ3nPg3+mGRHL8D72ByLdVKxnaJ/JX/OL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324359; c=relaxed/simple;
	bh=KszZfXemds+tM1XMbpuKFozsX2kZ/r4nuJvmkMsZsR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXwaLrYo5o8S8H1oGVCQfiDCI6aXT0ktC6Dcrq43PqlmT4Gc3eCIsK3gUCtDckxqN2BpnimZGWNE1Z+TqNRaMhbryPibGFRv39uHgY+GS2UtmdoQrFJC7bFe4iUTx7ew82kpiFBxCnc0yNuNlAsQ0z4ox3occxJanIFV5XYJ8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQu7pBbL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722324355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5xEK7R2nb157eewENV4C21/1t6bjW/YfM6JPF2QG74=;
	b=gQu7pBbLGXX2vxwqNi5fL5V73qTLFW2kSyeeXpPY8yCGXw4V2bBxyJ1PKJv8e8dgeyJwvZ
	sB6DhddfgFwZ9MKH4FC019o/bO7Ota5Ktyd5OR/3xoRDsXxqllzro41UH0WIvL80s9OJBY
	Wy5hfVOvm/o7MkckgfOGKFcNl6jkQwA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-trrlKunfMZW1pEDhd_lJIw-1; Tue, 30 Jul 2024 03:25:52 -0400
X-MC-Unique: trrlKunfMZW1pEDhd_lJIw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-427ffa0c9c7so33973505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722324351; x=1722929151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5xEK7R2nb157eewENV4C21/1t6bjW/YfM6JPF2QG74=;
        b=oMLiUSf/l/B47m+HdnTbGHAcfLuAkT4bIp+rh8g6azB1utjxNLjgiZqDyku6+i/LWJ
         bubvIBn7bvyzvJ9sxStn2LSVlMBFzzGymbe+vMlH9+1LwJV6PhhqyQVbz6iUNpRlbxeG
         ap78mVZFSVsax7nNwX4E4cO3CVmlpRZPqsVWlV3ulzyQDH+hWlf7edcbMjlLzN+w4sG4
         /g+eYCxIkniPHLd2AhqzfL1+rO5rOV3NOze1tqtUqTqyHGYU/SPEmqG45rxvm3dLwiZO
         t4jBug/8++zm1VD+vf5vzEwgTAhZa2ejxlllpsatSbokh/gRUJh9twadN80s1a9tkhjI
         /D5w==
X-Forwarded-Encrypted: i=1; AJvYcCWcnKjFR2MatgfrpSwl3U/MAr71/jBHxW/MgUmDXrehZCJ1KHuW3RxfNKTHti0sIljZGsYeWKL8pJRvuEg7uvA2RLPwKFe0qwSV1EUg
X-Gm-Message-State: AOJu0YzQCBGX6bkcRDngkOHu7lu9f3Xpu+sargTr6o/tNHevXkjHkKJ3
	Fi04La9EP8ROvA1e9xUXEhfGmYwuK3q1kUOLJ8kpkqJv+uvZVotPUQiMEvY+uJ0kXqt5+dQeVX8
	CyV1mlG7BlDFMGFzAEC3BjPw2SK1PDCuHoFshQT9DHeXQTaW9z8HWpQ2SzBWLGQ==
X-Received: by 2002:a05:600c:4585:b0:426:61fc:fc1a with SMTP id 5b1f17b1804b1-42811d7792bmr90856465e9.3.1722324351588;
        Tue, 30 Jul 2024 00:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/gDWBFo6htQDYTEcS5D2SAcLjd2SmqORuGhu3ZlxQ75NycjD7PqRFbIHMJtcxRFp9bn/8wQ==
X-Received: by 2002:a05:600c:4585:b0:426:61fc:fc1a with SMTP id 5b1f17b1804b1-42811d7792bmr90856125e9.3.1722324351142;
        Tue, 30 Jul 2024 00:25:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281225141dsm120696385e9.45.2024.07.30.00.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:25:50 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:25:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a
 define
Message-ID: <20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
In-Reply-To: <bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 08:45:53 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
> index b0c68d66a345..c99c8b1713c6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      if (s->acpi_dev) {
>          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
>      } else {
> -        /* use gpio Pin 3 for power button event */
> +        /* use gpio Pin for power button event */
>          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);

/me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
you are passing 3. Is this a bug?

BTW: dropping '3' from comment doesn't make it any better.

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


