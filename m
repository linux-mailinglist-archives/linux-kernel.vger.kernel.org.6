Return-Path: <linux-kernel+bounces-297427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08E95B829
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E617B227E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44CD1CB31B;
	Thu, 22 Aug 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cez+LBE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A31EB5B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336337; cv=none; b=S0mE76qYKgsmwxPds1vmvxAIOrHe5r90y82TYZ7KcpXTJ98PaZqFxTJNsY9nW2645Gs7ZZZ6nmnPetshWi820QI6gFkHNdPm5M+ls8DZErCr7rwLMf82eRUGhYuFwaGjJG1TpTLmPxhdji9xsDDpAh0jR1UtEjV8fHnHEtl+xII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336337; c=relaxed/simple;
	bh=3GWoh+NIjDuNmYprHwkg92rITwy5ncJNiKWjfdVr/H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1wa97Lf3AmKSgHC1WgGu38NaTVy0wuy6XRV4WQka+OLNZJXoxARFBpCGr/o8vpdkT04dBmtZP/e2jgebars6tW3BQz8UkkpZ5DTAn0Nckt9zoYAQAferlopesX4llZzRjifst4JgrgSXPclYA+MJVxAyDCNk3KvLk0CNqDgCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cez+LBE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA710C4AF0C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724336336;
	bh=3GWoh+NIjDuNmYprHwkg92rITwy5ncJNiKWjfdVr/H4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cez+LBE5FuMS7MOuHzeoYBffg2OYo1A1RyFMJ/z79CGDpNOsWywgyVicagMQgj0NM
	 sfCp2JtPcQ5B3UXfPgs3+3+93AiK0waUnFda2tVjN0f/hVpA9nKYiAt+ulQCk3v92L
	 yH32mEnAl1waFO2F0T8RspWgx/Q3Zv5ic/Q5DXZ+Pw/zQTMD2SxWgVS0G+1eEDDthF
	 bphNP85mBw/WitrkkW8AvMsJk7Nhr1uKGGVHNPELmtbU2eeCxq4e4UXMqQXoHOUWcC
	 aHKPvbBqNMqIy6FKlP16n390fURpxF47NUdVXnzyfhF2fpFbUE39ZWrVIj9N7QlUh0
	 RadDMhJ/f36gw==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso640491a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:18:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUI8aSHjDZLSk6yrBnGnvV38//b1vV5EygXKVlQAYNIe4EomY8xIEYa3PEmgRth5Kt0O2HTxkhOnirC6xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrXZbwcJO8deXZjZ9hU1rfcQYrA4jb5JbpqeTK7Hfj0eUAHKir
	oaafu04GpR182tyhtx7bZMOPrz+dniXjCOs3hbG+pP00EikimAH4PRbOwEA6afBqwy4Lkg1NV1B
	Ltxuiq4/z0x1GjYe8y+evbcHmNA==
X-Google-Smtp-Source: AGHT+IGhC5P6/hthqUI5LUfSSQTgN84GTtxPfVyWb1+65zBVxRuWL4kVlMrBRKN/1zwtX32x5+MJ14DekdwVil/rPYY=
X-Received: by 2002:a17:90b:204:b0:2d3:cd22:e67b with SMTP id
 98e67ed59e1d1-2d5e9a0581emr6419698a91.6.1724336336253; Thu, 22 Aug 2024
 07:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718082507.216764-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240718082507.216764-1-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 22 Aug 2024 22:19:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8VkkxsC3yOcFSLcToVaueUtAjsdhkhAN+Zw_POO=fHtw@mail.gmail.com>
Message-ID: <CAAOTY_8VkkxsC3yOcFSLcToVaueUtAjsdhkhAN+Zw_POO=fHtw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Declare Z Position for all planes
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, matthias.bgg@gmail.com, shawn.sung@mediatek.com, 
	ck.hu@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2024=E5=B9=B47=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:2=
5=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MediaTek SoCs support multiple planes, one of which is the primary
> and all the others are overlays (and CURSOR is the last overlay).
>
> In all currently supported SoCs, the Z order of the overlays can't
> be changed with any fast muxing action, and can only be changed by
> swapping the contents of the entire register set of one overlay
> with the other to internally reorder the layer properties, which
> is indeed feasible, but probably more expensive than desired.
>
> Declare the Z position for all planes with an immutable property
> at least for now, so that the userspace can take its decisions
> accordingly.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_crtc.c  |  2 +-
>  drivers/gpu/drm/mediatek/mtk_plane.c | 18 +++++++++++++++++-
>  drivers/gpu/drm/mediatek/mtk_plane.h |  3 +--
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 072b2fdae87b..327214721b4d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -874,7 +874,7 @@ static int mtk_crtc_init_comp_planes(struct drm_devic=
e *drm_dev,
>                                 mtk_crtc_plane_type(mtk_crtc->layer_nr, n=
um_planes),
>                                 mtk_ddp_comp_supported_rotations(comp),
>                                 mtk_ddp_comp_get_formats(comp),
> -                               mtk_ddp_comp_get_num_formats(comp));
> +                               mtk_ddp_comp_get_num_formats(comp), i);
>                 if (ret)
>                         return ret;
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/media=
tek/mtk_plane.c
> index 5bf757a3ef20..7d2cb4e0fafa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_plane.c
> @@ -321,7 +321,7 @@ static const struct drm_plane_helper_funcs mtk_plane_=
helper_funcs =3D {
>  int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
>                    unsigned long possible_crtcs, enum drm_plane_type type=
,
>                    unsigned int supported_rotations, const u32 *formats,
> -                  size_t num_formats)
> +                  size_t num_formats, unsigned int plane_idx)
>  {
>         int err;
>
> @@ -338,6 +338,22 @@ int mtk_plane_init(struct drm_device *dev, struct dr=
m_plane *plane,
>                 return err;
>         }
>
> +       /*
> +        * The hardware does not support repositioning planes by muxing: =
their
> +        * Z-position is infact fixed and the only way to change the actu=
al
> +        * order is to swap the contents of the entire register set of on=
e
> +        * overlay with another, which may be more expensive than desired=
.
> +        *
> +        * With no repositioning, the caller of this function guarantees =
that
> +        * the plane_idx is correct. This means that, for example, the PR=
IMARY
> +        * plane fed to this function will always have plane_idx zero.
> +        */
> +       err =3D drm_plane_create_zpos_immutable_property(plane, plane_idx=
);
> +       if (err) {
> +               DRM_ERROR("Failed to create zpos property for plane %u\n"=
, plane_idx);
> +               return err;
> +       }
> +
>         if (supported_rotations) {
>                 err =3D drm_plane_create_rotation_property(plane,
>                                                          DRM_MODE_ROTATE_=
0,
> diff --git a/drivers/gpu/drm/mediatek/mtk_plane.h b/drivers/gpu/drm/media=
tek/mtk_plane.h
> index 231bb7aac947..5b177eac67b7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_plane.h
> +++ b/drivers/gpu/drm/mediatek/mtk_plane.h
> @@ -49,6 +49,5 @@ to_mtk_plane_state(struct drm_plane_state *state)
>  int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
>                    unsigned long possible_crtcs, enum drm_plane_type type=
,
>                    unsigned int supported_rotations, const u32 *formats,
> -                  size_t num_formats);
> -
> +                  size_t num_formats, unsigned int plane_idx);
>  #endif
> --
> 2.45.2
>

