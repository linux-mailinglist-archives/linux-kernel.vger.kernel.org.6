Return-Path: <linux-kernel+bounces-387573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA59B5313
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9405C1C22A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC9B20721D;
	Tue, 29 Oct 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOv5ykXX"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65822076BF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232457; cv=none; b=QVeY0qnXA6Myuugnle+PkxEww9ivcJfwI+twSyYyyVMZMaNIcj7itubWj/lsvo+GmE9OjRaMnTmoHqkSsGRj/ddMc7kz8gLajgtINjzPjINpElQq0Vkb/y6he3zoMbltoHl94mrcitmdVW2afxRWJPHH+/rD7j/1w8uwIiQn8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232457; c=relaxed/simple;
	bh=Lj1XuZ6x9ZfE2p1notsLVNoSBLlatTqF/B6j/Kn7spw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdrck0mklGvZQYt5xaK5kcS7py7kDki3E8FqZVdHXU7yQqoKPw76acyGTxym1PFXKYiN9Gq4azSJ/Ymojq26iKbvWbvXS/3hlt6Sut+kYk3B5nKlOPQ/w2w0ISuoEMcFBNY2McWiUTMx91vXcLJRh9QvxTLtM/P60+2weV0j1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOv5ykXX; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so6119855276.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730232454; x=1730837254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02fVgYCHwHYWz9XJLOuShixyFS6jMl+g475mqm/khNw=;
        b=xOv5ykXXazUYxxNGQOHx0raUwqJD2CA+ZWDrpB+CJang3fNIgQZJWi21RLLP4O7CwL
         ooaH8QwLe4/nutWWRvJ0aq5GJRstVUv9H6yUK4OIEDxFvhl/eLlxkaqDNrnrqV5AoIN6
         wlsxcGXLsRfhYmaUU2R85GV1gOutoDFBzdqCJEDTZYZ2OcWFa8IobYPusSUAAujeExvg
         TZDRxnS++PdZ3JRbSIFM+9odxV8NIInVPNDlbLuMn9Wd0fsqkr2PWSCvOugDIrHN6eWm
         rLr3C8b9JskVxJCDxH4mEDIW4KbmxvQp0Qo/nEYCNIlwwuQhk4KMz3W0HRMITdUOUeM9
         apHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730232454; x=1730837254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02fVgYCHwHYWz9XJLOuShixyFS6jMl+g475mqm/khNw=;
        b=OanP04johJBYMsmS3uDnqwpJcOga8GhzhdqT32bfRpa/Sb8P9JpnIqhzDsCJQ2XlwE
         Onug6r/9cbWHxrW4XrF029fJMUjbi5HAEQFkmQ2WkYArgD+6mhAaSnublAcYnS5ASkJs
         XQu6S3Qduw87RwO0dDAErBTF0LRwmClXx3lDILiGvVpWcY3s0v8Cr9d/XemmtO5fyP8i
         IR4YHF4IS5IRG8bEOxyCQL/4UqEWJP56ucmY0ylyjQEhiiSRgN658UXNgY1C5uchi/7F
         vlFPW3qXVqFG7KED+e1xkVF5R67QOzUMaS5sVTlgg67CQVthqrttOtJxbHBpUVGobGSE
         TLpg==
X-Forwarded-Encrypted: i=1; AJvYcCUFlN3w1C1Xk/YNAYguz6/P30YCO0plPNXYp3NmfKDS6/EskrDV2M8EOcZbbUS5V24NXInysHXY9DdY/AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWlCmdW8LueaqgkLOEdbtOpwZNJYVMAYUza48+FPKAZMviiP7I
	dzcSDa8vmQ0LFu6P+0zSXWtUzI/LISGBD+Kp7oyQ4QnwVjNaXnQ+bSAr3TNCZfzmYq2oodEhIa1
	O8do3rGxpmR/MJ9cu1+YjDzJhsoY3JsOeK3YuIg==
X-Google-Smtp-Source: AGHT+IE6yjevMKWWK5dEWcL+udZz549JMdzzGNgSsO5RyF7/i8ZbdZi84RS0NDlaugK3ZRmt6j5woCgLHpdcq7icNZM=
X-Received: by 2002:a05:6902:161d:b0:e29:c45:9272 with SMTP id
 3f1490d57ef6-e3087a4ca3fmr11835983276.9.1730232453728; Tue, 29 Oct 2024
 13:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029191131.2329414-1-peter.griffin@linaro.org>
In-Reply-To: <20241029191131.2329414-1-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 29 Oct 2024 15:07:23 -0500
Message-ID: <CAPLW+4=jK63MFCRuhDkT2RH-J6dYsd0qHf_f1EeWTdrGqGLn=A@mail.gmail.com>
Subject: Re: [PATCH] Revert "watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle()
 for PMU regs"
To: Peter Griffin <peter.griffin@linaro.org>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, krzk@kernel.org, 
	alim.akhtar@samsung.com, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 2:11=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> This reverts commit 746f0770f916e6c48e422d6a34e67eae16707f0e.
>
> Now that we can register a SoC specific regmap with syscon using
> of_syscon_register_regmap() api we can switch back to using
> syscon_regmap_lookup_by_phandle() in the client drivers.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/watchdog/Kconfig       | 1 +
>  drivers/watchdog/s3c2410_wdt.c | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 684b9fe84fff..f3cd402e5795 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -549,6 +549,7 @@ config S3C2410_WATCHDOG
>         tristate "S3C6410/S5Pv210/Exynos Watchdog"
>         depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE=
_TEST
>         select WATCHDOG_CORE
> +       select MFD_SYSCON if ARCH_EXYNOS
>         help
>           Watchdog timer block in the Samsung S3C64xx, S5Pv210 and Exynos
>           SoCs. This will reboot the system when the timer expires with
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 686cf544d0ae..349d30462c8c 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -24,9 +24,9 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  #include <linux/delay.h>
> -#include <linux/soc/samsung/exynos-pmu.h>
>
>  #define S3C2410_WTCON          0x00
>  #define S3C2410_WTDAT          0x04
> @@ -699,11 +699,11 @@ static int s3c2410wdt_probe(struct platform_device =
*pdev)
>                 return ret;
>
>         if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> -               wdt->pmureg =3D exynos_get_pmu_regmap_by_phandle(dev->of_=
node,
> -                                                "samsung,syscon-phandle"=
);
> +               wdt->pmureg =3D syscon_regmap_lookup_by_phandle(dev->of_n=
ode,
> +                                               "samsung,syscon-phandle")=
;
>                 if (IS_ERR(wdt->pmureg))
>                         return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
> -                                            "PMU regmap lookup failed.\n=
");
> +                                            "syscon regmap lookup failed=
.\n");
>         }
>
>         wdt_irq =3D platform_get_irq(pdev, 0);
> --
> 2.47.0.163.g1226f6d8fa-goog
>
>

