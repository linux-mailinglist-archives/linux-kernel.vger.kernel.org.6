Return-Path: <linux-kernel+bounces-224981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB991298A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949D21F21272
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C69F80605;
	Fri, 21 Jun 2024 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc9/4CZb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD45CDE9;
	Fri, 21 Jun 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983454; cv=none; b=Nskxt5l5cTHrR8Lry2iim39Cuog7sO5t+TlUlf8L0B5M4ssMBn8fbk049ErJgRMDodeJSKIZ4+WNzRKSBLf2SrlFzuJJr7WYyu31ioSbajVG/doZbilO0YDKJUPF5p+wrxnCUlm9OGtoKNkkkvtSMG6PHU+IzB5s5U5naRR6hbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983454; c=relaxed/simple;
	bh=Ff9EA/QpmNbx6stJ+wK7SetR4F+aGIuV8L9De81Il+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSHUAqoEJiFauwxgCglTWtZ+FsdRtZItLompxjaU9l35X2gac2PyMd3GKauR6wUYX6FZq94j5pJUDsBTg8zxazg56RrAsEKPkgAhM1/CnXorrpSdsqzcdWOYbhddpkc07fIWTZP9iQBfNNQlIJx2ejAHqSeiT1T7gwGcpE05I1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc9/4CZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1451EC4AF07;
	Fri, 21 Jun 2024 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718983454;
	bh=Ff9EA/QpmNbx6stJ+wK7SetR4F+aGIuV8L9De81Il+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qc9/4CZbIp5EKUk+F/AKUwoQ0aHLAq+2Pj44DNsskp5QnjGqRURlmL1ze/hDM0a7j
	 iMOp0Vpp+GM5Qh8dkZVv/IW4Ylx4kc3LAoYEYLEeDAlmBBl5hj8F41tgaKvHCtUsu8
	 bfoLgYmQWN9/+IyIrAwn2DUjhnD3OoDXp/Obg5f9VNFIyMfdAuk7sD9q9ZU2ehiv5Y
	 V4RAiz8enzz6rhWcPCnLQuw7I2r6iMy7V4TaW3XutG+sOWkq7n0m1tCk0P0N1S0J5Q
	 mTk9m+HVV60FOicQZNtK0Q3mPlRcDgPM++ilW4XWKorfAGToycanfiZV9qJWw+Komn
	 2em0GAWyG//NQ==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c7b14bb4a5so1574888a91.0;
        Fri, 21 Jun 2024 08:24:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwY+ZM3M3IU3jnTI1T42DqoB6k9u3pk/vXYHVAFMCDC8rnMBT9NPEcuZB7LbH3y/KO5Ov0w8GlUjmZHGPj3C8IqxhAWxQyKS9h1eA0S/6OVhVrbBlKmrAMb3VZjJnjPAXZ1Dg2y5FgOg==
X-Gm-Message-State: AOJu0YzP3AQcCYUI+E1NBOJ+labBu0RHJFs0pHCdA8CubgxkVqL/LdS/
	DgoG3VAGHx5gUexPuHsZHn6Nhutzoohm0M4RyJ2cBB3oGuwPuOzzd++Zzo51U0YcjMKho4oWf6B
	ucR6cWdv90wcDnkXVqo5UD3Wr+w==
X-Google-Smtp-Source: AGHT+IGQ+sY96q+fAXo/8wcMlUkQMzFLEU6NhVSDTBlzTx/VszhL+gr2xWg/am131E2fodn2RmM1MK7LQCnq1VLk1pE=
X-Received: by 2002:a17:90a:2c07:b0:2c7:b392:8f02 with SMTP id
 98e67ed59e1d1-2c83c2dc0fbmr115615a91.23.1718983453637; Fri, 21 Jun 2024
 08:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com> <20231023-display-support-v4-12-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-12-ed82eb168fb1@baylibre.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Fri, 21 Jun 2024 23:24:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY__ZLjuJHnGsVLvGkFK0WhJJ6r=miqewRHsPCJhqO=8qoA@mail.gmail.com>
Message-ID: <CAAOTY__ZLjuJHnGsVLvGkFK0WhJJ6r=miqewRHsPCJhqO=8qoA@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] drm/mediatek: add MT8365 SoC support
To: amergnat@baylibre.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alexandre:

<amergnat@baylibre.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=8823=E6=97=A5 =E9=80=
=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Fabien Parent <fparent@baylibre.com>
>
> Add DRM support for MT8365 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index ce8f3cc6e853..e1c3281651ae 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -318,6 +318,10 @@ static const struct mtk_mmsys_driver_data mt8195_vdo=
sys1_driver_data =3D {
>         .mmsys_dev_num =3D 2,
>  };
>
> +static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data =3D {
> +       .mmsys_dev_num =3D 1,

You do not describe the pipeline information here. I think display
function would not work.

Regards,
Chun-Kuang.

> +};
> +
>  static const struct of_device_id mtk_drm_of_ids[] =3D {
>         { .compatible =3D "mediatek,mt2701-mmsys",
>           .data =3D &mt2701_mmsys_driver_data},
> @@ -345,6 +349,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
 {
>           .data =3D &mt8195_vdosys0_driver_data},
>         { .compatible =3D "mediatek,mt8195-vdosys1",
>           .data =3D &mt8195_vdosys1_driver_data},
> +       { .compatible =3D "mediatek,mt8365-mmsys",
> +         .data =3D &mt8365_mmsys_driver_data},
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
> @@ -732,6 +738,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8195-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
> +       { .compatible =3D "mediatek,mt8365-disp-mutex",
> +         .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8173-disp-od",
>           .data =3D (void *)MTK_DISP_OD },
>         { .compatible =3D "mediatek,mt2701-disp-ovl",
>
> --
> 2.25.1
>

