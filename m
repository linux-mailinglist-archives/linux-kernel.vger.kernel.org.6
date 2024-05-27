Return-Path: <linux-kernel+bounces-190017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA58CF866
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B569B227A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B73C121;
	Mon, 27 May 2024 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2pmGkCu"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1542F4A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784467; cv=none; b=OXI8B02bcsJy20F/53mtziZ7VsUXfvY16rOd3si5K23NJgAVpFa5Y7UTTm6Qi1jKf2/bAXw6kGptd2G/HMA98p678jPjlOO3IySTE90gyDIRgC1gM8pcSD12jlIfkwFutmbeimI8i0BrrRg1pSyXg0X7GuuQe1lqQ+64bXEBQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784467; c=relaxed/simple;
	bh=/71wvczwBRg2OGYvzlzFRT3IShdTDIv5OXhG0h80XZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/+RA7zb8mZ3GhNY3QLlSAcYoRleFoe7FEoxIFGvs5hNcxLLPMDM37G8UfOMiaaFTae3cTmT7QrO2DC75lLfHTkEw4Rilqx/+5Bt3qhAJy1u+Rcq4kVWQYFdxc8aCT8JBOYZYCpntvTjKr0Gr8uQkcpevS1zIoPdJlPQ62hoWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e2pmGkCu; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4e4f004bd17so833829e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716784464; x=1717389264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDSR6I/z63VDajsQQN7lrfz6LEymcq9DFpREoQqrhJs=;
        b=e2pmGkCuk+7ZiFjvxfVGrNQlO49/Z9I5suhuRBOoYS79joItFJSBQu1tY+J0RjBlZ2
         0frQLdWI9zow5FVyMab4y/aATu9JDe93ARC6OC0H8riddQ6tUixmLlvcDIK7tVCUTRGi
         ghvdoVRoUmBmrrft3Jq3IvK06lOKjOZ8KfZJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716784464; x=1717389264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDSR6I/z63VDajsQQN7lrfz6LEymcq9DFpREoQqrhJs=;
        b=uZBkCiXoF78nroSJtrymKBqSortdwJ2SGOpbeBAgrjEB+qnqzdXfwR95JK6EBGi8sV
         4tOq9S3w7f+KlBGQl4ucD+NdtaFb2+/AKCyxOWQ99GY5DGRvwVj/pF2esf8YHnmgSHOV
         GvLB/QvIcCqxIyM5yaV/9dKAPGzxwrZcJQc7TllWP5BTTj/TEIsuBddOnk5Glx/Z2dG+
         9MNLWxlAxBQPf6/Cap4KJYSsCToJcpNxBRTKPx3Myg2qGYWh7CHXd/ZS7N8+d3xwfHDa
         VSYv99I8HoEkFGszJfMEiv7RA+bgnqALqGZM4t8iLWki1Dxowk1rb1dIUZPCp+tzdM16
         EZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWZYXErz0WLT3bdEho5c+s4q4La1u+QwbDcC21XX+tdBDtpYjkvoxi7tAy7RyfvgHhvb/PT3xgjiPt5eKoqSpSBYZwqrEsA7jt61AZ
X-Gm-Message-State: AOJu0YyK4Id8ko7O7+s9IDPZ/XTvDWVVPiGo0B9DDRBmSMrAg0bH/w/n
	v2KGu6q1oADPcAtH8QAaSRa9gewp+taoZEqTOQKvbSmINplBPRcb14/qIu/RSfS7IwC2fwHbBCf
	j7Q==
X-Google-Smtp-Source: AGHT+IEncPnEc4g7n8jAHHfIBCEtjWZCQQipV4TheBPqOX7ekWbRYhr8O1OvF0efSx6JX3tnVbzqkA==
X-Received: by 2002:a05:6122:36a5:b0:4d4:2fbc:e61f with SMTP id 71dfb90a1353d-4e4f02e6422mr8375701e0c.14.1716784464081;
        Sun, 26 May 2024 21:34:24 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4e4f072afe4sm1081505e0c.9.2024.05.26.21.34.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 21:34:23 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-804f7814a40so335165241.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:34:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEwqOJBrvoAZg7U+fe+y46rjNsjCp8tEXpbpyYnylDORlEgG96eOvoGqOJ0OoO1Mmqnyk+6IdGL84ZGApmYSqJCxwBHnhiKu4uqdUq
X-Received: by 2002:a05:6102:c09:b0:48a:5a8d:ef7b with SMTP id
 ada2fe7eead31-48a5a8df099mr2798098137.5.1716784462303; Sun, 26 May 2024
 21:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502103848.5845-1-shawn.sung@mediatek.com> <20240502103848.5845-6-shawn.sung@mediatek.com>
In-Reply-To: <20240502103848.5845-6-shawn.sung@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 27 May 2024 12:33:46 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngUh-o107YM8zEu-ebaP7+eaO1x6SsZ6OeRxrH5YgFKxw@mail.gmail.com>
Message-ID: <CAC=S1ngUh-o107YM8zEu-ebaP7+eaO1x6SsZ6OeRxrH5YgFKxw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] drm/mediatek: Set DRM mode configs accordingly
To: Shawn Sung <shawn.sung@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	"Nancy . Lin" <nancy.lin@mediatek.com>, Sean Paul <sean@poorly.run>, 
	Jason Chen <jason-ch.chen@mediatek.corp-partner.google.com>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Thu, May 2, 2024 at 6:39=E2=80=AFPM Shawn Sung <shawn.sung@mediatek.com>=
 wrote:
>
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
>
> Set DRM mode configs limitation according to the hardware capabilities
> and pass the IGT checks as below:
>
> - The test "graphics.IgtKms.kms_plane" requires a frame buffer with
>   width of 4512 pixels (> 4096).
> - The test "graphics.IgtKms.kms_cursor_crc" checks if the cursor size is
>   defined, and run the test with cursor size from 1x1 to 512x512.
>
> Please notice that the test conditions may change as IGT is updated.
>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  4 ++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 8e047043202b4..c9cad3a827376 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -294,6 +294,9 @@ static const struct mtk_mmsys_driver_data mt8188_vdos=
ys0_driver_data =3D {
>         .conn_routes =3D mt8188_mtk_ddp_main_routes,
>         .num_conn_routes =3D ARRAY_SIZE(mt8188_mtk_ddp_main_routes),
>         .mmsys_dev_num =3D 2,
> +       .max_width =3D 8191,
> +       .min_width =3D 1,
> +       .min_height =3D 1,
>  };
>
>  static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data =3D {
> @@ -308,6 +311,9 @@ static const struct mtk_mmsys_driver_data mt8195_vdos=
ys0_driver_data =3D {
>         .main_path =3D mt8195_mtk_ddp_main,
>         .main_len =3D ARRAY_SIZE(mt8195_mtk_ddp_main),
>         .mmsys_dev_num =3D 2,
> +       .max_width =3D 8191,
> +       .min_width =3D 1,
> +       .min_height =3D 1,
>  };
>
>  static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data =3D=
 {
> @@ -315,6 +321,9 @@ static const struct mtk_mmsys_driver_data mt8195_vdos=
ys1_driver_data =3D {
>         .ext_len =3D ARRAY_SIZE(mt8195_mtk_ddp_ext),
>         .mmsys_id =3D 1,
>         .mmsys_dev_num =3D 2,
> +       .max_width =3D 8191,
> +       .min_width =3D 2, /* 2-pixel align when ethdr is bypassed */
> +       .min_height =3D 1,
>  };
>
>  static const struct of_device_id mtk_drm_of_ids[] =3D {
> @@ -493,6 +502,15 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>                 for (j =3D 0; j < private->data->mmsys_dev_num; j++) {
>                         priv_n =3D private->all_drm_private[j];
>
> +                       if (priv_n->data->max_width)
> +                               drm->mode_config.max_width =3D priv_n->da=
ta->max_width;
> +
> +                       if (priv_n->data->min_width)
> +                               drm->mode_config.min_width =3D priv_n->da=
ta->min_width;
> +
> +                       if (priv_n->data->min_height)
> +                               drm->mode_config.min_height =3D priv_n->d=
ata->min_height;
> +
>                         if (i =3D=3D CRTC_MAIN && priv_n->data->main_len)=
 {
>                                 ret =3D mtk_crtc_create(drm, priv_n->data=
->main_path,
>                                                       priv_n->data->main_=
len, j,
> @@ -520,6 +538,10 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>                 }
>         }
>
> +       /* IGT will check if the cursor size is configured */
> +       drm->mode_config.cursor_width =3D drm->mode_config.max_width;
> +       drm->mode_config.cursor_height =3D drm->mode_config.max_height;

I think you shouldn't set the cursor size to the maximum plane size.
As you mentioned in the commit message, IGT tests the cursor sizes
from 1x1 to 512x512, so just setting them to 512 (with a macro) should
be enough.

Currently this tells the userspace "the supported cursor plane size is
up to 4096x8191" on MT8195 and MT8188.
That means the userspace may allocate a buffer with 4096*8191*4 ~=3D
128MB for the cursor plane in the worst case, and most of the buffer
will be wasted.
Note that the default value for DRM_CAP_CURSOR_WIDTH is 64.

In practice, when applying this on the MT8188 Chromebook, I see the
userspace allocates two 64MB buffers for the cursor plane.
But if I limit the cursor size to 512, the userspace only allocates
two 1MB buffers i.e. 126MB is optimized for the DMA buffer allocation.

Regards,
Fei


>
> +
>         /* Use OVL device for all DMA memory allocations */
>         crtc =3D drm_crtc_from_index(drm, 0);
>         if (crtc)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.h
> index 78d698ede1bf8..6cfa790e8df5c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -46,6 +46,10 @@ struct mtk_mmsys_driver_data {
>         bool shadow_register;
>         unsigned int mmsys_id;
>         unsigned int mmsys_dev_num;
> +
> +       int max_width;
> +       int min_width;
> +       int min_height;
>  };
>
>  struct mtk_drm_private {
> --
> 2.18.0
>

