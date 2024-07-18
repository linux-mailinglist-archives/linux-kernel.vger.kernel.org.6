Return-Path: <linux-kernel+bounces-256267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA2934BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14811F22E10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802A12C470;
	Thu, 18 Jul 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yr4I5Tki"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52601EA80
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298836; cv=none; b=dWWD9Lmotrzf9689PFnpUSilZf5gcejZR54fSpURTFIPfRzWJR2Jmlfp5A5XYzV6qrcCaYDLhckFO8q5NfmEldFoJpVcB7jAxYXYqL4M6i4L8sVRZoX28ewIzwMhiG4PxebkYTSmGrXk8T15/2S9h+dDijhxCmzjaKnbjFaMbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298836; c=relaxed/simple;
	bh=4XgBzjycGWSBBrQwFMCRtpnaaVgDS1KX0nv7LgzbKqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE3v6BhOAE3uj87SOTbrUihNsx6wRgBcepmE49Ln3ZCBQ7BdgQ1szu5bSIKANwnOyf7CfpZvZfDkGLg9xevGGLwugGbryly34FzGDRpips+/R3RQTsahd1NRFBT/LJVm2FS9xoFIxWb4nvQzNvkkFTIDPW3+JjhU7+xGAGLFMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yr4I5Tki; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eedebccfa4so7269981fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721298833; x=1721903633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v+h287ifj6s+K3J0t30yGCIPmpGY1Q1ZLm5gQl9XjRo=;
        b=Yr4I5TkinrXX/Hut4mSzNrJvxak9uKjNRmi1CVMb8InWhvDPJ3XL17292sVQ4k089N
         DsdUwxemexwob5+/3BmbeAl1oqWAStOfRIvINWNncy2QOqDbO+KqXbhDCyBL5Ig30kaK
         1pO4HAkgSKl6YiN3t3g7moYApvpIHxN6q2x2BExwqz0SzS5Ieu0nsKOkEbld/m6ETClL
         PCB+EvclNvLKieAV/8NermPQO2hiDIcRM08+57fbYBzXNhVIUy0DEBnEojxR+8WdKI3P
         D8RiuFmX2jhqiZGAr3kIhE/SHydZrmdsRrcdyFx36iblcjNNVkIH8k9BlV2s34nEO+x1
         MPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721298833; x=1721903633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+h287ifj6s+K3J0t30yGCIPmpGY1Q1ZLm5gQl9XjRo=;
        b=ke8OcS7A6my2LZheVxAbI4deU7KHcmvfIVeRCFRCk5aIX/DsrxyT27vnE41vel5Hju
         dY5i7MleKUZ0enzq0efaehxr7PByvUimtmw4X7vpnjia2UUEpnYpstfq5RAE55XlM5KR
         1V0hNbFzCJzkDu6qnLd9sco2+8+Au+6fh6jHQHiiKtbJ7L97W4silQap4P34iNRsWurw
         mJv8v5qlPVUsxopn4Q9Ww9axbZL4F52lsidDxWPgu5XFmnfMCIQa9yDHrsMo77aYl6gL
         6ULuCGjWLbfrP4NrqaK6H3lTwaFgMFKk3bEp+kS2R+tKz2Q6x1i7ix8U4jRPoVdChXvb
         drEA==
X-Forwarded-Encrypted: i=1; AJvYcCVcfHOKKzBrJ3BHJBlruIQICV1Jk5N+xAils84sICTfmEBtDBbb38rO5aY2FQLsXm7uVmsJqPzomy7QnDbtJG9nOUEE4vrVvdsMvY4t
X-Gm-Message-State: AOJu0YzD4e6btkA6p6whDR3fbW2gY7hK/n27fWNY7nJEXfDqb3tLONQ+
	vWUEab3Ax6+g2cYA306CS3fjGktFVjedeYTCphcIaCakRLPBLF9Is1vvCfHmD+9CNFbRS95zvQl
	SRvynke3Qz/v4EEqmL2u2xQSJPQowC3mYORIbsA==
X-Google-Smtp-Source: AGHT+IHCjC0UyjUkZCeVis2EOTvX9qYFjKU5SpT21H7Ab/b/Ox6naC1A81DsrfWBE21P3cP8fJ0p+oI4yF0oTIumuXw=
X-Received: by 2002:a2e:3c1a:0:b0:2ee:8adb:6190 with SMTP id
 38308e7fff4ca-2ef05d2c4e7mr16006871fa.35.1721298832782; Thu, 18 Jul 2024
 03:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720789921.git.mchehab+huawei@kernel.org> <88fcd8947095ec6dff8ea709c8ceffa72b16f686.1720789921.git.mchehab+huawei@kernel.org>
In-Reply-To: <88fcd8947095ec6dff8ea709c8ceffa72b16f686.1720789921.git.mchehab+huawei@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 11:33:41 +0100
Message-ID: <CAFEAcA_4ioaV2Rg8dFFUeAU=tBBq=_TRVpCAUftMeDxu9=gDTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] arm/virt: place power button pin number on a define
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Shiju Jose <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>, 
	Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, 
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 14:15, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 6 +++---
>  hw/arm/virt.c            | 3 ++-
>  include/hw/arm/virt.h    | 3 +++
>  3 files changed, 8 insertions(+), 4 deletions(-)

Thanks for writing this refactoring patch; I have a couple
of nits below but otherwise it looks good.

> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd73..ad0a0bcec310 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -154,10 +154,10 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(dev, aml_name_decl("_CRS", crs));
>
>      Aml *aei = aml_resource_template();
> -    /* Pin 3 for power button */
> -    const uint32_t pin_list[1] = {3};
> +    /* Pin for power button */
> +    const uint32_t pin = GPIO_PIN_POWER_BUTTON;

I would say that with the constant name we could now drop that
comment entirely.

>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
>      aml_append(dev, aml_name_decl("_AEI", aei));
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b0c68d66a345..7b886f3477b6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
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

You've missed one instance of the hardcoded 3, where we write the
FDT information about it
further down in this function:

    qemu_fdt_setprop_cells(fdt, "/gpio-keys/poweroff",
                           "gpios", phandle, 3, 0);

This also can now be GPIO_PIN_POWER_BUTTON.

thanks
-- PMM

