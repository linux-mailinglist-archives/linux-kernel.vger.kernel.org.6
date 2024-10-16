Return-Path: <linux-kernel+bounces-368124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD69A0B79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3C61C23AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93EA209F29;
	Wed, 16 Oct 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="isCqeXe2"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B6209F5E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085453; cv=none; b=YdK+IBPiCdciBUZPqa4oSpvrAE+JULVfS3KnAPUuofeLV8akjC+zVbJi//wD1I05v3shOjlMbpFnVU5lDg3EOwl/d9sZI4oFNiesLXqOCc3YOBTODBB4unq1pkOE38yvG8gEUYMoE8Nxgj7LvsVzyAr717+RJyjeAnhuo8GDua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085453; c=relaxed/simple;
	bh=k2Xj+uccXMBWDZg2rpwdJcR95APiLOgF635Pq/DpGAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ51SXkkZl6GYph9QHENlLfe72KKfqCB+sZNzREVexdhZ6Nr3QeXfYbfJxYMqFjtYy1nBy0wQkRyy/bCdEY0PXkA4OQvVSs/PBLS15MstYSwqWjYL31FEsGu4r7eCDyHxExEvvtbabudYrid9hK1dpvzKF6gZPsTofq4bgoH6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=isCqeXe2; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fe06fbdc6so1684713241.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729085449; x=1729690249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TREUo1lQfvBhTYNzvxLnSAftCI9jNyXaG87hpbR/7a8=;
        b=isCqeXe2OKpKK8995Zic4wRCS/7mCdfICpu1dOREOjyIFGi+74n9YaKhhLepFIVU4/
         nT0LNP58fOnIL19iJjgG9UdUYOCcrzsjzsuPVOFVnCPa4ByZ3NTepZ7eH12wamqO7f2Z
         iV0h/aRmFB/4E0YPoyKZGmmMT/zlWt1RuWeds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729085449; x=1729690249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TREUo1lQfvBhTYNzvxLnSAftCI9jNyXaG87hpbR/7a8=;
        b=jS+nI4DxF3a7WiE8kx1rc0pDHcmH+I5pOXFxDMGG/7On9bA9hLNPnZZtmh5zBTMf4m
         uo1ch7nd7FVzZ3wg4VNheKgKy65zaPRpyGOfKOMPxuFW6sgbILY74601kNA1CA+JbczZ
         T8aifWuvAPDT6B3a88W9Y+16aEBUQQJvVoPIedTQeXdFLAc2G0MyUqOVPAU8qsN2OvJY
         c3iCSX4LB8ZlSCIaPnhUf9xaZzEE4cg6zzzUgjEi8tBOnnYyDFqVZ4X3wkW5IMNBk75Y
         H/Ch++BKKnIgay48zMWl6ZxDbIXjHWCUPWsLsbo7YzWmiMFYp4yvxAtKDje4Bna2zMKI
         STrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFKyaEUlLrjL2amXZoONE1Fmjm7RV3TM56CrsGiuQ5/E1S6i2+BVtn5SaDWvYsdtINFZ4XlDHJuXENynY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6n4yZyunyD+HZNUb25WAmXXzeAkLR823HJugW9TNBaM5Zwzzg
	G/wcErGIJQbQzGVe+f3apVb2XFvNOcooPwVNY3cjHCfCaohXqwOBzeXEHnLLAH3hN1t7GHvlXiA
	=
X-Google-Smtp-Source: AGHT+IGRgfO5HwLB4LlxqS5/GfSHs69rOMGCQjVU6Kdp2mCynITk2cGiE70we8nFWl2nzXPz9GMn7Q==
X-Received: by 2002:a05:6102:1608:b0:4a4:8b67:4f6b with SMTP id ada2fe7eead31-4a48b6751b9mr10959671137.12.1729085448864;
        Wed, 16 Oct 2024 06:30:48 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a5acc16fe3sm572978137.5.2024.10.16.06.30.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 06:30:48 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50da1fceeacso195887e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:30:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQFNdUPVmHGuXtnVdPmCG+lBh5HRdXIzXNayF97F2DjC43BM32Hpk7rWkFmzPSCwUtUFQlZu6uILWK510=@vger.kernel.org
X-Received: by 2002:a05:6122:469b:b0:50d:5be4:c39d with SMTP id
 71dfb90a1353d-50d5be4c7a8mr9674315e0c.0.1729085447232; Wed, 16 Oct 2024
 06:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-color-v2-1-46db5c78a54f@chromium.org>
In-Reply-To: <20241016-color-v2-1-46db5c78a54f@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 16 Oct 2024 21:30:10 +0800
X-Gmail-Original-Message-ID: <CAC=S1niFFuKiw1hC-pV-dSVP_cd6YiAU+7a7xLYgokLc-DtOcQ@mail.gmail.com>
Message-ID: <CAC=S1niFFuKiw1hC-pV-dSVP_cd6YiAU+7a7xLYgokLc-DtOcQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Fix color format MACROs in OVL
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 7:10=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> In commit 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in
> OVL"), some new color formats are defined in the MACROs to make the
> switch statement more concise. That commit was intended to be a no-op
> cleanup. However, there are typos in these formats MACROs, which cause
> the return value to be incorrect. Fix the typos to ensure the return
> value remains unchanged.
>
> Fixes: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v2:
> - Clarify that the commit get fixed was intended to be a no-op cleanup
> - Fix the typo in tag
> - Link to v1: https://lore.kernel.org/r/20241015-color-v1-1-35b01fa0a826@=
chromium.org
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 89b439dcf3a6af9f5799487fdc0f128a9b5cbe4a..1632ac5c23d87e1cdc41013a9=
cf7864728dcb63b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -65,8 +65,8 @@
>  #define OVL_CON_CLRFMT_RGB     (1 << 12)
>  #define OVL_CON_CLRFMT_ARGB8888        (2 << 12)
>  #define OVL_CON_CLRFMT_RGBA8888        (3 << 12)
> -#define OVL_CON_CLRFMT_ABGR8888        (OVL_CON_CLRFMT_RGBA8888 | OVL_CO=
N_BYTE_SWAP)
> -#define OVL_CON_CLRFMT_BGRA8888        (OVL_CON_CLRFMT_ARGB8888 | OVL_CO=
N_BYTE_SWAP)
> +#define OVL_CON_CLRFMT_ABGR8888        (OVL_CON_CLRFMT_ARGB8888 | OVL_CO=
N_BYTE_SWAP)
> +#define OVL_CON_CLRFMT_BGRA8888        (OVL_CON_CLRFMT_RGBA8888 | OVL_CO=
N_BYTE_SWAP)
>  #define OVL_CON_CLRFMT_UYVY    (4 << 12)
>  #define OVL_CON_CLRFMT_YUYV    (5 << 12)
>  #define OVL_CON_MTX_YUV_TO_RGB (6 << 16)
>
> ---
> base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
> change-id: 20241015-color-e205e75b64aa
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>

You missed Doug's R-b tag in v1:
https://lore.kernel.org/all/CAD=3DFV=3DXrrhUoB9=3DJuPY2erLMA7S-EREqvP5t8NNu=
BuUiA4rZjQ@mail.gmail.com/

Can you resend v3 with both R-b tags this time?

Thanks,
Fei

