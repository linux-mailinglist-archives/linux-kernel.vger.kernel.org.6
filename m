Return-Path: <linux-kernel+bounces-256230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B4934B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A751F249CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70EE82D83;
	Thu, 18 Jul 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nnmUgOLg"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546967EEF5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296277; cv=none; b=W53y454AKoqtEukkkog09Yyf6s5iN1CgMA9WjcXhgdj7vhkopvXdE+Z3tqLEV0ctguv1oMlN9GjatYcy4C7LfnVcIiAG7ipYmoB+Ml0cGTlXmpNiza5gstt4hoTiV+RYo6j4QX00RhBH8hrR69yYdqKPbrUvXZQ6upqzqZY5aDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296277; c=relaxed/simple;
	bh=FfEysmryiD4OXybOFEozQuRpA+VqNfPyZXbB6wPtLQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/0d5Wxf7ce4/DafSD0Pa3IYc2wC8Byei5zN2tip6MTd+Nw1a6cWtpHB3ObscHjvcBqLcqA+4vrQ0y/w+I3ilIHxjQOMyYU4zgtxVKT9QgPHTkfVMnA/uk+bOtmiUY/FNOAB018znp9EkYN3YmVBt8AneJSkqnI+gVLfiEZIjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nnmUgOLg; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so147259241.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721296275; x=1721901075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RynWyZj/Mk6W2PWFZ6UdeaZvnGfxuKvGDrjfGdoRyoQ=;
        b=nnmUgOLgnBeGWyurB2oYOGQexcpG1TlNxJ4AFAMW5tWMz1n2yWmHlAcFdkEVYPOMFD
         so9RROKvIN5gOVGF6HHUM8pZkUUhaozrW3pLiMFAZCvcnIinJyhefnB8CeyO0SzPd7sK
         wuSP34dAAAfbvLcZTk/RTK6PNqNqiD3kAoIC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296275; x=1721901075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RynWyZj/Mk6W2PWFZ6UdeaZvnGfxuKvGDrjfGdoRyoQ=;
        b=wY2GyU7twQdQAckiY5vSGCfWXFfuf6PwmZueG+mZT3Nfad2jzHbjwPb72taMMuJhME
         3JiNHZyU1ctp2K6/istwyrTnHIgJubvY6xhRkTw78FnFy7ZnUi1PcJB8CurBCJwKDIIq
         RXHFxYLwi0e/swwZkz4ijRsbx5qwAL98nro5bjVAnW9aY1s58CjO0lC/tMtnlUVQPvdF
         opx0ztkOzezOUu99rNsvUUpuM88vnwx9JHXQeJQUi+JvyDK8sEZBKDeZ+ziLP7Ojc70L
         MwCsEniZCYZ+q7/h3iAigfZ5zSPC+eq0CWnY9l7fqpv12OFJSAKmqUgQDjp7OcRlKCva
         nBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzPlIXPy4SIPRSmC5tabgEj969TUD8iNtChuMOz5sCLPgtF6mmrYToVWTMtkAyYRWZ6nGu0lO/LeT58aKjGlh6yQZRiMwkMsV1TH52
X-Gm-Message-State: AOJu0Yx8WGergQZDSXo7T3Tknro4ZvGzEuCjI1/OM5aIJiF6SOGjySjr
	M+uHVgrZsBP/MI3wi6bom1OEcWcSvdmXE7WLNRdEnQMFKLHaCREJ32TUgQvJQIUkwCxiNiWekQR
	23A==
X-Google-Smtp-Source: AGHT+IGe2rAzyb07068+hyz9w7fS/ApXmiDrB2hQl+cSucZKM4gLkQscXlyolC1bZbspFN4EBG69IQ==
X-Received: by 2002:a05:6102:158b:b0:48f:df86:da4 with SMTP id ada2fe7eead31-491598bf866mr5627827137.20.1721296275055;
        Thu, 18 Jul 2024 02:51:15 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4915617d425sm777554137.27.2024.07.18.02.51.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:51:14 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f2f24f6470so252186e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:51:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtWMF4jhgX+/TdslkJfLG0zas0a4yk2A7q/ut0HICTjl0rv4hjc5bB51GhXJzjNrlNXWQrsISJLXlnFyAR7puMI9AcKE6F7WV5IQUY
X-Received: by 2002:a05:6122:a0b:b0:4f2:ff08:ba3c with SMTP id
 71dfb90a1353d-4f4df688321mr6001081e0c.5.1721296273968; Thu, 18 Jul 2024
 02:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718082507.216764-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240718082507.216764-1-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 18 Jul 2024 17:50:37 +0800
X-Gmail-Original-Message-ID: <CAC=S1njFSULdpTefLpb8biEUARVH4c_dZndUav_S-6D-bstn6w@mail.gmail.com>
Message-ID: <CAC=S1njFSULdpTefLpb8biEUARVH4c_dZndUav_S-6D-bstn6w@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Declare Z Position for all planes
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, matthias.bgg@gmail.com, shawn.sung@mediatek.com, 
	ck.hu@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:25=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
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
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
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
>

