Return-Path: <linux-kernel+bounces-190030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E018CF891
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA241C21129
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF3EC2C8;
	Mon, 27 May 2024 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b54F31WE"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64630184E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785693; cv=none; b=egghTMXOSQC9rx6IyuVTMKie8KgWXj1wPL2msO00TktELVDGbQKer9CXQy+PKDXxq8SEBEepsykvaazMMVZr5mA0Q5y/B1W7OgGajQooUa09bNAs0CQVhWnoIJxL20nfPM/urtxPJQ2phOPRHP5re4zr3cJrUwTBw1gA6cGIL3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785693; c=relaxed/simple;
	bh=MUxILrUC7xYnveLvtZmDp7yh0a7RHS9bPdK1DGXk7cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2Tuc/TJ0Y16LDTMj0XgTvCprQOcOVGl4kWVtnuaZplhsZCFKaO1ers+T9GbzG4mHKivUTs+JivDPe8+6mOT+x5YwiiCMZWxsrwMT6EXLUwmCUB2TQac2PBapJLVbA3T62VaDIZ//bG2DJ/8gVmMke0eT8t9Mw3uzyeTY+knA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b54F31WE; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48a417fd190so428663137.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716785690; x=1717390490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gJOhzmspBkrZuLKBoP0mmK3YHQ3TyvOptzZlj6zm9s=;
        b=b54F31WEywK9Zwm5ZJbMSm9nWwJxKOPFO8vKSvSyHTGmU2m2MaEevI+4qd2cUgbmU4
         LLlQbCA6nkQOZFe3i+b6nxR17KYY3gLg2gNfLaPz4nswPjM2NnsHKSs6vl8vOxyMR9Y4
         5k71boIG12tD2n79VmXru63aem/XFxARu2Nc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716785690; x=1717390490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gJOhzmspBkrZuLKBoP0mmK3YHQ3TyvOptzZlj6zm9s=;
        b=VyR06r4M8ONmZyxEg0rQ5cOgtFMk9nwfdkJ76RIO3w3soanwbKBEEVyStiKLvV1EIx
         baKg/pkrXqL6Y66GwEKIpcw3Oexxjb1El5KF0lG3z1YOyyyFgGrNJFrNBSKpphJq63aM
         E8htfDePtVXokuiMjkJHzUaNUX7QfsAGy0OJc/PGqnOROa+DyvSCPo/QsM80iXUKMyon
         l2HBi5iYrHbjk0CCU025MhHUuQaWWIhhVGP5QhE0raXOWbw/YUB2ujMv9ENWVreNa4X1
         e08L4C/yKHA86NXOB+UY2PQVcnLeL0H6+BDXrpBYkEP+Ei57MW8B58ZjpmlAGJPztkH8
         sJBA==
X-Forwarded-Encrypted: i=1; AJvYcCVtiw0zn5Id46iAZGn4XiJcEU1FJKlSPHyEJA0ZROgS0TDTl7+RyS4j0P5Uh2cT9MWEiTw9mML0O05IIoZ9Yh3m5lcoDrnR7RiEfMwz
X-Gm-Message-State: AOJu0YxwbqfyqcEGCjc23/fd5nUmUd9MKnVK9M9ZYXMtM8t5vxc4sXrd
	ZXUxLJXhk7paU0xgxBMYqNZAPuTNw82TB2HhRA0lE7nTraQHUPUzr26nfk41AarIETeGJl6R/pd
	BgA==
X-Google-Smtp-Source: AGHT+IHqS4TXTWiTynowHAPgsCJcWapbxdXFBCLm138DQliUQhLVo/MhFP6Wry5Ah11qouFYK5mQGg==
X-Received: by 2002:a05:6102:2242:b0:48a:4f2c:cc94 with SMTP id ada2fe7eead31-48a4f2ccd3cmr3315396137.20.1716785689820;
        Sun, 26 May 2024 21:54:49 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48a3a351746sm262164137.31.2024.05.26.21.54.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 21:54:48 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7fe97255d03so1980713241.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:54:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLmoPFuqtI6g7khLY+ti8adzAfBYtAHOnvaKNcmuUczh8oqZhAbZQEN5vGNcN2219fHjYH2ziStVfmO1XotujAP+RXi6bm/DhEmCes
X-Received: by 2002:a67:f88d:0:b0:48a:33af:3ba with SMTP id
 ada2fe7eead31-48a386b3a53mr7310666137.31.1716785688017; Sun, 26 May 2024
 21:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502103848.5845-1-shawn.sung@mediatek.com>
 <20240502103848.5845-6-shawn.sung@mediatek.com> <CAC=S1ngUh-o107YM8zEu-ebaP7+eaO1x6SsZ6OeRxrH5YgFKxw@mail.gmail.com>
 <CAGb2v67TZSoQnEMhUNKhnbkwK2=9yCPcwnLD-iHuRp6=Y2ez2Q@mail.gmail.com>
In-Reply-To: <CAGb2v67TZSoQnEMhUNKhnbkwK2=9yCPcwnLD-iHuRp6=Y2ez2Q@mail.gmail.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 27 May 2024 12:54:10 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhKPo5BUYJ_cHGz3OoPrWNh5eO8rhdyikLimsqSOrZ5Xg@mail.gmail.com>
Message-ID: <CAC=S1nhKPo5BUYJ_cHGz3OoPrWNh5eO8rhdyikLimsqSOrZ5Xg@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] drm/mediatek: Set DRM mode configs accordingly
To: wens@kernel.org
Cc: Shawn Sung <shawn.sung@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
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

On Mon, May 27, 2024 at 12:38=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wro=
te:
>
> On Mon, May 27, 2024 at 12:34=E2=80=AFPM Fei Shao <fshao@chromium.org> wr=
ote:
> >
> > Hi Shawn,
> >
> > On Thu, May 2, 2024 at 6:39=E2=80=AFPM Shawn Sung <shawn.sung@mediatek.=
com> wrote:
> > >
> > > From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> > >
> > > Set DRM mode configs limitation according to the hardware capabilitie=
s
> > > and pass the IGT checks as below:
> > >
> > > - The test "graphics.IgtKms.kms_plane" requires a frame buffer with
> > >   width of 4512 pixels (> 4096).
> > > - The test "graphics.IgtKms.kms_cursor_crc" checks if the cursor size=
 is
> > >   defined, and run the test with cursor size from 1x1 to 512x512.
> > >
> > > Please notice that the test conditions may change as IGT is updated.
> > >
> > > Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 22 ++++++++++++++++++++++
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  4 ++++
> > >  2 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm=
/mediatek/mtk_drm_drv.c
> > > index 8e047043202b4..c9cad3a827376 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > > @@ -294,6 +294,9 @@ static const struct mtk_mmsys_driver_data mt8188_=
vdosys0_driver_data =3D {
> > >         .conn_routes =3D mt8188_mtk_ddp_main_routes,
> > >         .num_conn_routes =3D ARRAY_SIZE(mt8188_mtk_ddp_main_routes),
> > >         .mmsys_dev_num =3D 2,
> > > +       .max_width =3D 8191,
> > > +       .min_width =3D 1,
> > > +       .min_height =3D 1,
> > >  };
> > >
> > >  static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data =
=3D {
> > > @@ -308,6 +311,9 @@ static const struct mtk_mmsys_driver_data mt8195_=
vdosys0_driver_data =3D {
> > >         .main_path =3D mt8195_mtk_ddp_main,
> > >         .main_len =3D ARRAY_SIZE(mt8195_mtk_ddp_main),
> > >         .mmsys_dev_num =3D 2,
> > > +       .max_width =3D 8191,
> > > +       .min_width =3D 1,
> > > +       .min_height =3D 1,
> > >  };
> > >
> > >  static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data=
 =3D {
> > > @@ -315,6 +321,9 @@ static const struct mtk_mmsys_driver_data mt8195_=
vdosys1_driver_data =3D {
> > >         .ext_len =3D ARRAY_SIZE(mt8195_mtk_ddp_ext),
> > >         .mmsys_id =3D 1,
> > >         .mmsys_dev_num =3D 2,
> > > +       .max_width =3D 8191,
> > > +       .min_width =3D 2, /* 2-pixel align when ethdr is bypassed */
> > > +       .min_height =3D 1,
> > >  };
> > >
> > >  static const struct of_device_id mtk_drm_of_ids[] =3D {
> > > @@ -493,6 +502,15 @@ static int mtk_drm_kms_init(struct drm_device *d=
rm)
> > >                 for (j =3D 0; j < private->data->mmsys_dev_num; j++) =
{
> > >                         priv_n =3D private->all_drm_private[j];
> > >
> > > +                       if (priv_n->data->max_width)
> > > +                               drm->mode_config.max_width =3D priv_n=
->data->max_width;
> > > +
> > > +                       if (priv_n->data->min_width)
> > > +                               drm->mode_config.min_width =3D priv_n=
->data->min_width;
> > > +
> > > +                       if (priv_n->data->min_height)
> > > +                               drm->mode_config.min_height =3D priv_=
n->data->min_height;
> > > +
> > >                         if (i =3D=3D CRTC_MAIN && priv_n->data->main_=
len) {
> > >                                 ret =3D mtk_crtc_create(drm, priv_n->=
data->main_path,
> > >                                                       priv_n->data->m=
ain_len, j,
> > > @@ -520,6 +538,10 @@ static int mtk_drm_kms_init(struct drm_device *d=
rm)
> > >                 }
> > >         }
> > >
> > > +       /* IGT will check if the cursor size is configured */
> > > +       drm->mode_config.cursor_width =3D drm->mode_config.max_width;
> > > +       drm->mode_config.cursor_height =3D drm->mode_config.max_heigh=
t;
> >
> > I think you shouldn't set the cursor size to the maximum plane size.
> > As you mentioned in the commit message, IGT tests the cursor sizes
> > from 1x1 to 512x512, so just setting them to 512 (with a macro) should
> > be enough.
> >
> > Currently this tells the userspace "the supported cursor plane size is
> > up to 4096x8191" on MT8195 and MT8188.
> > That means the userspace may allocate a buffer with 4096*8191*4 ~=3D
> > 128MB for the cursor plane in the worst case, and most of the buffer
> > will be wasted.
> > Note that the default value for DRM_CAP_CURSOR_WIDTH is 64.
> >
> > In practice, when applying this on the MT8188 Chromebook, I see the
> > userspace allocates two 64MB buffers for the cursor plane.
> > But if I limit the cursor size to 512, the userspace only allocates
> > two 1MB buffers i.e. 126MB is optimized for the DMA buffer allocation.
>
> That seems more like an issue of ChromeOS not doing the most optimal
> thing though?

I agree that we need to fix this on the ChromeOS side too, but I still
think the driver doesn't need to set the capabilities like this
because a full-screen size cursor is not practical anyway.
The default cursor plane size is just 64x64.

Regard,
Fei



>
> > Regards,
> > Fei
> >
> >
> > >
> > > +
> > >         /* Use OVL device for all DMA memory allocations */
> > >         crtc =3D drm_crtc_from_index(drm, 0);
> > >         if (crtc)
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm=
/mediatek/mtk_drm_drv.h
> > > index 78d698ede1bf8..6cfa790e8df5c 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > > @@ -46,6 +46,10 @@ struct mtk_mmsys_driver_data {
> > >         bool shadow_register;
> > >         unsigned int mmsys_id;
> > >         unsigned int mmsys_dev_num;
> > > +
> > > +       int max_width;
> > > +       int min_width;
> > > +       int min_height;
> > >  };
> > >
> > >  struct mtk_drm_private {
> > > --
> > > 2.18.0
> > >

