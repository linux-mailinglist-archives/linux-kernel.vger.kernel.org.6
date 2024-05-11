Return-Path: <linux-kernel+bounces-176716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECCD8C339B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E959281D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82182032B;
	Sat, 11 May 2024 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UarpGMWe"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10CE57D
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715457014; cv=none; b=A9ICdLgyMn8Vs2M9QXigCQdDbm1fAmYANgdB5nhCn/rrhaI+IvlSULgeNdDf2Plp5hTflPYYT7syqHcIEeYKMSn5jrm7WDom77hPwOmKeWXJmJElIhaTzsgQlWnADOMopkAT9OT7GEOtA3PvIjD+o5i+b65TqMJv4f9q4o566bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715457014; c=relaxed/simple;
	bh=msAa4ThmS8hfyYYGhv7dJYNyuAiFPDgAPlDKrrH68wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szXu3UnxZbcjOfH1cl76Sr/HL/dOQhsW9woplJQ9oHDOYjYGF7TKCjZoeNFnQ+LUPWHaeuAmcs9N6RAc0GkQeQ22HAk9Sj92jPF7GVPA1HHLByhSI9wVNzm1QDqm9Rn+aWFEv8ERVR78uXAa43CWtUhRr0G3BMqaoZaDTmkKRzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UarpGMWe; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de462f3d992so3280993276.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715457010; x=1716061810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F3s0BYtwV5QP2poIgqh39ZmRBGGeeft/DMBZxm9dZ+c=;
        b=UarpGMWenC64SyI18dVsfmSUsmA6ux3QGhmPJ0gYkbrqnvs5Lbs1Xl70BS6JYamykJ
         +tArF1BPEY66iZiWLWzlh51Ksgu6o0lLyPecNpN23ve59P6KfvHZGA4JjMfAkw8LZFiT
         qv5MJoNmdaYHUV/54L5p2vNsxewoK/NFx41yp9mq3k/funBNqLFsNEag7xIP/FHZ9lvf
         C2wjgjtzl8yMfVEC3HlzLzdesQHRH4ZwhPsCm3bk7Tjseljr58MrRzc0/+C+ZvvmfcCb
         eBN0rZEveVMzDBE0neBq2RUblRvqbnscRqVQmU6UITj1jF1g1Aa8NsjUtfSdVH5cQhCr
         ln5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715457010; x=1716061810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3s0BYtwV5QP2poIgqh39ZmRBGGeeft/DMBZxm9dZ+c=;
        b=wH4CH0BFY5DQmRsHfkWER+ZnpfL6nKaxH/ZD8NBfevay3U63hCB/gZyJzkbY24RZB+
         SVJ6TTPI1MfcdB8lB4cts4i1wB5EvhEP/Rcg9vGAQvuRUWlpUF+3Vvfj/CQuQ5lRY4Ir
         3VRYGWXAEbCCzD8USB4n2UafMLLR0CAgLsBfrGXrhQ6qTIHHwW35arf2X2SBt1VQMCAe
         6LvJknppB868ndW+FBmO/APHYUhIYkCfwYoMMYzF7nfE50C3IYLMuEF19safnBSw0rKm
         KH/jvMemYbHoQu10zfno+c9q+e70IA4xU6Kg7ZAW/hbKenLpbag9pp0xXDSTU7ipSiNj
         mr3w==
X-Forwarded-Encrypted: i=1; AJvYcCWb+YXZ/m0P5iRrgYpTcYydXKADNLTTAftqd2YQL+bAYmzzTpARWLRw+GM1MoP2bo7WJmw/X57k3Q8ByLyMyLTQZa6E45Pweqykitrw
X-Gm-Message-State: AOJu0Yw6QX6zkrQ/p+qABBC/4i17ZB7z7BfTZNpLZIhaTWu/P1flCsc/
	Jn7Gpy0be1gbXGWa2zyq7gFcv0/iII/Mg4cIAM9Gzg/rocSjrCGEsGXQt2eM8onZeIgAfJm2ENm
	XL7tZYB/OVmEL2pudMTUjZvbY4vJ+CLQJRe+k1Q==
X-Google-Smtp-Source: AGHT+IH9oytgieimnJ6EUHW02efq8o7XP9X5e1CpiXtKNoPTUQJ83yI9IK5vGxbcwkH+3Dtqr7EKoZaRHYG6zBFUUaY=
X-Received: by 2002:a25:b1a3:0:b0:dee:5cb6:483c with SMTP id
 3f1490d57ef6-dee5cb64977mr4069754276.49.1715457010482; Sat, 11 May 2024
 12:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511-msm-adreno-memory-region-v1-1-d73970717d42@gmail.com>
In-Reply-To: <20240511-msm-adreno-memory-region-v1-1-d73970717d42@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 11 May 2024 22:49:59 +0300
Message-ID: <CAA8EJprdnzvhx50DVHBRLZGkk4GNuCXaBiXt3wfNv-xm2AWOvg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: request memory region
To: Kiarash Hajian <kiarash8112hajian@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 22:35, Kiarash Hajian
<kiarash8112hajian@gmail.com> wrote:
>
> The driver's memory regions are currently just ioremap()ed, but not
> reserved through a request. That's not a bug, but having the request is
> a little more robust.
>
> Implement the region-request through the corresponding managed
> devres-function.
>
> Signed-off-by: Kiarash Hajian <kiarash8112hajian@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 8bea8ef26f77..aa83cb461a75 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -636,9 +636,9 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>
>  err:
>         if (!IS_ERR_OR_NULL(pdcptr))
> -               iounmap(pdcptr);
> +               devm_iounmap(&pdev->dev,pdcptr);
>         if (!IS_ERR_OR_NULL(seqptr))
> -               iounmap(seqptr);
> +               devm_iounmap(&pdev->dev,seqptr);

Is there any reason to keep devm_iounmap calls? IMO with the devres
management in place, there should be no need to unmap them manually.

>  }
>
>  /*
> @@ -1503,7 +1503,7 @@ static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       ret = ioremap(res->start, resource_size(res));
> +       ret = devm_ioremap_resource(&pdev->dev, res);
>         if (!ret) {
>                 DRM_DEV_ERROR(&pdev->dev, "Unable to map the %s registers\n", name);
>                 return ERR_PTR(-EINVAL);
> @@ -1646,7 +1646,7 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>         dev_pm_domain_detach(gmu->cxpd, false);
>
>  err_mmio:
> -       iounmap(gmu->mmio);
> +       devm_iounmap(gmu->dev ,gmu->mmio);
>
>         /* Drop reference taken in of_find_device_by_node */
>         put_device(gmu->dev);
> @@ -1825,9 +1825,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>         dev_pm_domain_detach(gmu->cxpd, false);
>
>  err_mmio:
> -       iounmap(gmu->mmio);
> +       devm_iounmap(gmu->dev ,gmu->mmio);
>         if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "rscc"))
> -               iounmap(gmu->rscc);
> +               devm_iounmap(gmu->dev ,gmu->rscc);
>         free_irq(gmu->gmu_irq, gmu);
>         free_irq(gmu->hfi_irq, gmu);
>
>
> ---
> base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
> change-id: 20240511-msm-adreno-memory-region-2bcb1c958621
>
> Best regards,
> --
> Kiarash Hajian <kiarash8112hajian@gmail.com>
>


-- 
With best wishes
Dmitry

