Return-Path: <linux-kernel+bounces-387571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A002C9B530E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC84B21A98
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595720721D;
	Tue, 29 Oct 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="redasTKJ"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60A1940B3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232397; cv=none; b=LBNXvaS97DDs0Kh/vef/AwKayAjkiPRUJvOoJnsMUTpFYNgwXeJC5K+vTVryHM6tzUhL8TEx9CIScv9JS9D+0Sa7FRu9FwspbvvCuaHd6Ih05UYrk+JrTD4xhUkA6UckgUogEfYDIWYVMJEZfO7cUfowrYbbADdHa5CG/1ivvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232397; c=relaxed/simple;
	bh=LxpRy52hsHxICThIzpgu8DP8/m7n7T9gRZNpb9bvNfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fi/uPXKBJnEkM4GPpF0EuWu8WOQ7CqaD7spQbASHHm50/0luNXdTlg0ChT9Q2HuV4hlzKMEy2CgK+hVo6aYoJ6S4xNhjzeQlY5JNRwoJfgPGwjdU4ZhCdUwSAyO5nsKiWKo3S08IrgeToz3RA1WZJtmMr5QXkaXrEINDDy9H6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=redasTKJ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e290e857d56so5498309276.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730232394; x=1730837194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3NttoA5WxBHMHxzBK9jMzti32CvvOP6K0PZcY+FhbE=;
        b=redasTKJvYX0T8ILNYUJ/to6msxFmt4U+5juZZ8eTn3rP7wAbgWZLt257Atjr+qInC
         cc+HvCi03EIqhD44Nr21oVJiMJtjs3Jk4Ng4fC5w5XWW1r6EFvV1vLDbRV2XxSNsgq9c
         2Ue6KQhCZ18/BxyhgG9y4fGD8HNhxvJvT2ra6oftdSdC6l9u4pK4ROYVYZkITsijCAXq
         A6AY9ue+KcEK3FkeU+QDUDA2Pz9rZWgRlc7ddrg6au2XpJCISFpZPe78Hd/mRYSln0dB
         qRjhRCH6EDXHTeAbQYFj0qQJxndU01H6hP8vSmI/pz84GW++r+VPBHbzAgzlL3lvxMD/
         nkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730232394; x=1730837194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3NttoA5WxBHMHxzBK9jMzti32CvvOP6K0PZcY+FhbE=;
        b=o2yG6lHFp3aVn+MkrKe8bKbLtClEo3EzLEAnKG4ctns27fVR2d+r2f2uwMO8DPQNwG
         wIu+cG5uGCL1NxOVHS4e4nU49W30Sr9Fkp2N22sREBkgc6Kkn28HDo+2Uqk12BeS7idF
         9TaamhvMik5mYPcIqqb4508maOv/ign4CP+gV4rrRI47Su2Iw2JK2Y3kkTzvVsDaQZ6Q
         bz1oA/yoRqIr7ybqlTkjZpvVnxhbops3nJTda1O17L4fLmjNstXqa6ofM39x9TLynv85
         Haq7VchR2IjdZZafwT0MU4ICpEt3+bCxh6nuhaNGKVyes6GaPaHc5n2lIdy7bnrJs0D6
         ZXbA==
X-Forwarded-Encrypted: i=1; AJvYcCUwBjYRgLKohE4u/AHhcyv+28JJ7vKdjeVxzva/OmMWkT+EZJ+lVLZ4MAQyYce6yOzh4zY8tZFI1QDjP/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9N80IaHUR6go/aG8AdkRpO2bATOdZrMnZrnogysNnUKinQ52j
	aOHrlx5WJPB2FpmY+weWQyNH0Ix+KuKsv7eBLe+47QERFgyTVPvSBPk8zpsoSBzCbUxFZPFaBRB
	HsHhkanCXFuANbfHhkGrW3UaIFpIepFTAtZVX/Q==
X-Google-Smtp-Source: AGHT+IHJIZjJm0+Hsxf3gPKdK8yBtqrSRKRjmh10LGyKq5VrJEw8ofGWS0qIV7jYqKH4wMYRbrhheBmDRAEt5XkqPpk=
X-Received: by 2002:a05:6902:1109:b0:e30:6dea:3ab4 with SMTP id
 3f1490d57ef6-e3087a6060fmr12587842276.23.1730232393985; Tue, 29 Oct 2024
 13:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029192107.2344279-1-peter.griffin@linaro.org>
In-Reply-To: <20241029192107.2344279-1-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 29 Oct 2024 15:06:23 -0500
Message-ID: <CAPLW+4k7wd4Wix8xEB8+Aeb10_D9XU9jbxhCZ_OMn1fW5OOAtg@mail.gmail.com>
Subject: Re: [PATCH] phy: samsung-ufs: switch back to syscon_regmap_lookup_by_phandle()
To: Peter Griffin <peter.griffin@linaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 2:21=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> Now exynos-pmu can register its custom regmap for gs101 via
> of_syscon_register_regmap() we can switch back to the standard
> syscon_regmap_lookup_by_phandle() api for obtaining the regmap.
>
> Additionally add a Kconfig dependency for MFD_SYSCON.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/phy/samsung/Kconfig           | 1 +
>  drivers/phy/samsung/phy-samsung-ufs.c | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
> index f10afa3d7ff5..e2330b0894d6 100644
> --- a/drivers/phy/samsung/Kconfig
> +++ b/drivers/phy/samsung/Kconfig
> @@ -33,6 +33,7 @@ config PHY_SAMSUNG_UFS
>         tristate "Exynos SoC series UFS PHY driver"
>         depends on OF && (ARCH_EXYNOS || COMPILE_TEST)
>         select GENERIC_PHY
> +       select MFD_SYSCON
>         help
>           Enable this to support the Samsung Exynos SoC UFS PHY driver fo=
r
>           Samsung Exynos SoCs. This driver provides the interface for UFS=
 host
> diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/=
phy-samsung-ufs.c
> index 6c5d41552649..8e9ccd39f97e 100644
> --- a/drivers/phy/samsung/phy-samsung-ufs.c
> +++ b/drivers/phy/samsung/phy-samsung-ufs.c
> @@ -13,11 +13,11 @@
>  #include <linux/of.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> -#include <linux/soc/samsung/exynos-pmu.h>
>
>  #include "phy-samsung-ufs.h"
>
> @@ -268,8 +268,8 @@ static int samsung_ufs_phy_probe(struct platform_devi=
ce *pdev)
>                 goto out;
>         }
>
> -       phy->reg_pmu =3D exynos_get_pmu_regmap_by_phandle(dev->of_node,
> -                                                       "samsung,pmu-sysc=
on");
> +       phy->reg_pmu =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> +                                                      "samsung,pmu-sysco=
n");
>         if (IS_ERR(phy->reg_pmu)) {
>                 err =3D PTR_ERR(phy->reg_pmu);
>                 dev_err(dev, "failed syscon remap for pmu\n");
> --
> 2.47.0.163.g1226f6d8fa-goog
>
>

