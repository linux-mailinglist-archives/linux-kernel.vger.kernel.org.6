Return-Path: <linux-kernel+bounces-233879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145CB91BE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E791C211C8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEE158214;
	Fri, 28 Jun 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2K67uGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758AF2E64A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577938; cv=none; b=D2SLZCWqftt300/hE+kmUjkcztgZyoNZ0jvJjSjsQoG93D85RIvnBhxWwS7Es+iBHBqJzP5TQmq4g7DMvsKrnYm3KOtaLxlWwYxGb9VM7+b0Vlda8KK+qN4rgbvpsQ35gHldEeb/m1Xbho+lK/9VrRxsvVmYq4dxHbQ04ZiBKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577938; c=relaxed/simple;
	bh=QS20hUrmVwpirQtGJibxsIuWGE8OeJujhIhKjKkf07U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5lpEBRvXGcG4T0a1KCthiZHIWaHs1Kn55KbPPvPIowerOGg+sTebeRPMBpEx3e/AryKq8F6a7zYRdA7BdJ9R2wh3oEm34TZextPLYjMJ+VPvp2qIoXvESgsXoNWh5G2/ZnMNeK5OqxrB8jgNHdLv4xn5zsokshEm9noip8GaLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2K67uGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088ACC4AF0B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719577938;
	bh=QS20hUrmVwpirQtGJibxsIuWGE8OeJujhIhKjKkf07U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e2K67uGoZuTnFesVk+VXWWROnNKRdtPnTNJhSXEH995/3IjlUUfLNTVgOfO8snKVR
	 GXMaq93B7QzKqt8VuYfj4kICxiAF5btvozj/Hc/Tjq7Klgw2XjuP3EBnA6QpGuCobt
	 lJMhFt3MyEz3EGfhKkJRtgLd4YB7HflWzTrNEAeAIPUvoAvz1DcA/YbMk8qMz6JC82
	 zu5t6YBaUuOEj5fwllPOJy5iyZ7aa5a2+QZp/aFTSvbeyD7v7e2oxQW4+W8xlVy5vn
	 8jR/tDEbC7+Bv9TgClSV0ZP31PLNCTg/ZGvvhiwCosiOVqZzXlowdN9OJWZxXk/Q0k
	 sIhuQ1HiGazCw==
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-710437d0affso345357a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:32:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDUpfvnIV8053F1aVhCPL40A43Yv/uaUjUZWkJa6EoOEMLJZODjgjef0G//KHvGBxesxiR1gckJnmphnXKXdvucj9HNQfPiOMwWczJ
X-Gm-Message-State: AOJu0YzeSolKP809Wing82OO2lK+HD5DI7/RXRAjpsnGBVNhl0HPgTnn
	pnXHdhiTcec7cp9Nb5PfW6VSHaEllSMuhXzkGB/9Fikzo+bRteuHzyGAq45D2tg743+PmtI96VZ
	LNfQbd69wwrqC/mC3qKMgFsanuw==
X-Google-Smtp-Source: AGHT+IHQ/05JNn97WxtnIagHd/uIS+roxfEJNPFeT15eOh7yNWGchsB1UnEjvW48a7x8gKm79Zo4hN4aG5yan43uUBQ=
X-Received: by 2002:a17:90b:110a:b0:2c2:ce08:d0e4 with SMTP id
 98e67ed59e1d1-2c8613db083mr14966731a91.23.1719577937460; Fri, 28 Jun 2024
 05:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606092122.2026313-1-mwalle@kernel.org>
In-Reply-To: <20240606092122.2026313-1-mwalle@kernel.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Fri, 28 Jun 2024 20:32:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY__x_-O2AGuWqZ_HSwORTJXcyb+g4uMFnwpxWr338fPpaA@mail.gmail.com>
Message-ID: <CAAOTY__x_-O2AGuWqZ_HSwORTJXcyb+g4uMFnwpxWr338fPpaA@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] drm/mediatek: dpi/dsi: fix possible_crtcs calculation
To: Michael Walle <mwalle@kernel.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jitao Shi <jitao.shi@mediatek.com>, Stu Hsieh <stu.hsieh@mediatek.com>, 
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>, dri-devel@lists.freedesktop.org, 
	Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Michael:

Michael Walle <mwalle@kernel.org> =E6=96=BC 2024=E5=B9=B46=E6=9C=886=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> mtk_find_possible_crtcs() assumes that the main path will always have
> the CRTC with id 0, the ext id 1 and the third id 2. This is only true
> if the paths are all available. But paths are optional (see also
> comment in mtk_drm_kms_init()), e.g. the main path might not be enabled
> or available at all. Then the CRTC IDs will shift one up, e.g. ext will
> be 0 and the third path will be 1.
>
> To fix that, dynamically calculate the IDs by the presence of the paths.
>
> While at it, make the return code a signed one and return -ENODEV if no
> path is found and handle the error in the callers.
>
> Fixes: 5aa8e7647676 ("drm/mediatek: dpi/dsi: Change the getting possible_=
crtc way")
> Suggested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> You can find v4 at [1]. Unfortunately, it was never applied and in the
> meantime there was a change in mtk_find_possible_crtcs(). So I've
> dropped N=C3=ADcolas Reviewed and Tested-by tags and Angelos Reviewed-by
> tag.
>
> [1] https://lore.kernel.org/r/20230905084922.3908121-2-mwalle@kernel.org/
> ---
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 105 ++++++++++++++++--------
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.h |   2 +-
>  drivers/gpu/drm/mediatek/mtk_dpi.c      |   5 +-
>  drivers/gpu/drm/mediatek/mtk_dsi.c      |   5 +-
>  4 files changed, 78 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/me=
diatek/mtk_ddp_comp.c
> index 17b036411292..9a8c1cace8a0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
> @@ -514,29 +514,42 @@ static bool mtk_ddp_comp_find(struct device *dev,
>         return false;
>  }
>
> -static unsigned int mtk_ddp_comp_find_in_route(struct device *dev,
> -                                              const struct mtk_drm_route=
 *routes,
> -                                              unsigned int num_routes,
> -                                              struct mtk_ddp_comp *ddp_c=
omp)
> +static int mtk_ddp_comp_find_in_route(struct device *dev,
> +                                     const struct mtk_drm_route *routes,
> +                                     unsigned int num_routes,
> +                                     struct mtk_ddp_comp *ddp_comp)
>  {
> -       int ret;
>         unsigned int i;
>
> -       if (!routes) {
> -               ret =3D -EINVAL;
> -               goto err;
> -       }
> +       if (!routes)
> +               return -EINVAL;
>
>         for (i =3D 0; i < num_routes; i++)
>                 if (dev =3D=3D ddp_comp[routes[i].route_ddp].dev)
>                         return BIT(routes[i].crtc_id);
>
> -       ret =3D -ENODEV;
> -err:
> +       return -ENODEV;
> +}
>
> -       DRM_INFO("Failed to find comp in ddp table, ret =3D %d\n", ret);
> +static bool mtk_ddp_path_available(const unsigned int *path,
> +                                  unsigned int path_len,
> +                                  struct device_node **comp_node)
> +{
> +       unsigned int i;
>
> -       return 0;
> +       if (!path || !path_len)
> +               return false;
> +
> +       for (i =3D 0U; i < path_len; i++) {
> +               /* OVL_ADAPTOR doesn't have a device node */
> +               if (path[i] =3D=3D DDP_COMPONENT_DRM_OVL_ADAPTOR)
> +                       continue;
> +
> +               if (!comp_node[path[i]])
> +                       return false;
> +       }
> +
> +       return true;
>  }
>
>  int mtk_ddp_comp_get_id(struct device_node *node,
> @@ -554,32 +567,52 @@ int mtk_ddp_comp_get_id(struct device_node *node,
>         return -EINVAL;
>  }
>
> -unsigned int mtk_find_possible_crtcs(struct drm_device *drm, struct devi=
ce *dev)
> +int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev)
>  {
>         struct mtk_drm_private *private =3D drm->dev_private;
> -       unsigned int ret =3D 0;
> -
> -       if (mtk_ddp_comp_find(dev,
> -                             private->data->main_path,
> -                             private->data->main_len,
> -                             private->ddp_comp))
> -               ret =3D BIT(0);
> -       else if (mtk_ddp_comp_find(dev,
> -                                  private->data->ext_path,
> -                                  private->data->ext_len,
> -                                  private->ddp_comp))
> -               ret =3D BIT(1);
> -       else if (mtk_ddp_comp_find(dev,
> -                                  private->data->third_path,
> -                                  private->data->third_len,
> -                                  private->ddp_comp))
> -               ret =3D BIT(2);
> -       else
> -               ret =3D mtk_ddp_comp_find_in_route(dev,
> -                                                private->data->conn_rout=
es,
> -                                                private->data->num_conn_=
routes,
> -                                                private->ddp_comp);
> +       const struct mtk_mmsys_driver_data *data;
> +       struct mtk_drm_private *priv_n;
> +       int i =3D 0, j;
> +       int ret;
>
> +       for (j =3D 0; j < private->data->mmsys_dev_num; j++) {
> +               priv_n =3D private->all_drm_private[j];
> +               data =3D priv_n->data;
> +
> +               if (mtk_ddp_path_available(data->main_path, data->main_le=
n,
> +                                          priv_n->comp_node)) {
> +                       if (mtk_ddp_comp_find(dev, data->main_path,
> +                                             data->main_len,
> +                                             priv_n->ddp_comp))
> +                               return BIT(i);
> +                       i++;
> +               }
> +
> +               if (mtk_ddp_path_available(data->ext_path, data->ext_len,
> +                                          priv_n->comp_node)) {
> +                       if (mtk_ddp_comp_find(dev, data->ext_path,
> +                                             data->ext_len,
> +                                             priv_n->ddp_comp))
> +                               return BIT(i);
> +                       i++;
> +               }
> +
> +               if (mtk_ddp_path_available(data->third_path, data->third_=
len,
> +                                          priv_n->comp_node)) {
> +                       if (mtk_ddp_comp_find(dev, data->third_path,
> +                                             data->third_len,
> +                                             priv_n->ddp_comp))
> +                               return BIT(i);
> +                       i++;
> +               }
> +       }
> +
> +       ret =3D mtk_ddp_comp_find_in_route(dev,
> +                                        private->data->conn_routes,
> +                                        private->data->num_conn_routes,
> +                                        private->ddp_comp);
> +
> +       DRM_INFO("Failed to find comp in ddp table, ret =3D %d\n", ret);

After checking ret < 0 then print this error message, applied to
mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/me=
diatek/mtk_ddp_comp.h
> index 26236691ce4c..e2ea19d5ddcb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
> @@ -326,7 +326,7 @@ static inline void mtk_ddp_comp_encoder_index_set(str=
uct mtk_ddp_comp *comp)
>
>  int mtk_ddp_comp_get_id(struct device_node *node,
>                         enum mtk_ddp_comp_type comp_type);
> -unsigned int mtk_find_possible_crtcs(struct drm_device *drm, struct devi=
ce *dev);
> +int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev);
>  int mtk_ddp_comp_init(struct device_node *comp_node, struct mtk_ddp_comp=
 *comp,
>                       unsigned int comp_id);
>  enum mtk_ddp_comp_type mtk_ddp_comp_get_type(unsigned int comp_id);
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 5c86aa0b75b2..b894be9f1f53 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -814,7 +814,10 @@ static int mtk_dpi_bind(struct device *dev, struct d=
evice *master, void *data)
>                 return ret;
>         }
>
> -       dpi->encoder.possible_crtcs =3D mtk_find_possible_crtcs(drm_dev, =
dpi->dev);
> +       ret =3D mtk_find_possible_crtcs(drm_dev, dpi->dev);
> +       if (ret < 0)
> +               goto err_cleanup;
> +       dpi->encoder.possible_crtcs =3D ret;
>
>         ret =3D drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL,
>                                 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 2b0ac859a653..b450b7223aa2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -861,7 +861,10 @@ static int mtk_dsi_encoder_init(struct drm_device *d=
rm, struct mtk_dsi *dsi)
>                 return ret;
>         }
>
> -       dsi->encoder.possible_crtcs =3D mtk_find_possible_crtcs(drm, dsi-=
>host.dev);
> +       ret =3D mtk_find_possible_crtcs(drm, dsi->host.dev);
> +       if (ret < 0)
> +               goto err_cleanup_encoder;
> +       dsi->encoder.possible_crtcs =3D ret;
>
>         ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
>                                 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> --
> 2.39.2
>

