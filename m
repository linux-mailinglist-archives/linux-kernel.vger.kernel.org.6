Return-Path: <linux-kernel+bounces-190045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538A8CF8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CAC1F219AE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9096376E5;
	Mon, 27 May 2024 05:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="My6y2ZSc"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C12E634
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716787720; cv=none; b=rIGso4fG7EREMA0ihF08dQU4LlZFxjH00ku5YCMfYMJNqHKgH0WXCaYVTZs9dlNKGQxrZyAZ+kQPLjMUF7p4+PHiqwX4j8KFOuV5qJ4bOU4S7f279UgvezHOqeyN5S0fZcHB1Vjk8oRvs3NbBfVUDKh+C1+Eqqa0Qm3s4IFZ0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716787720; c=relaxed/simple;
	bh=f0xxC3rKEssxCtI8vmhE0Q6d3WT/58Fo2rj64NjKYD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNd4A/LspljAqvTIa4tQrUAhL08tWXbMW5SsoNj3sYUJkYbANJgk7QxFrmCa39zLaWLs6E8C6QlUfvxx5b2rmVeW4/zohxobFgxoguiH9HkJ22oXtGJsjqBARm/CqhNbr/psjQZMcjVM+wfWlqrY1c6BltFPOw86U8qoFLzb1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=My6y2ZSc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5295eb47b48so2887163e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 22:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716787717; x=1717392517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS/q+5B/lHN3GpC5brMPX120YuCJjay08ll9bVANbnw=;
        b=My6y2ZSchqqp8+92oNHF9yFVjYIFhWyYrov9MB+Ban8hTZkrbQb8T2rBrS6o/CCq5a
         XddLl6IOX2nh/5bY0VZg1jRZmkRvvV+vqqP2KW26LkqaaLoaoHkTXUFkrSgbPL7iwiWp
         u0tdlrnQxNmeX74ZbwlQLsXNDgBua0GQMDZ8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716787717; x=1717392517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS/q+5B/lHN3GpC5brMPX120YuCJjay08ll9bVANbnw=;
        b=IYF1bR5fIzaQpJFN4IGiPjK/qEGXjlFWfPomhqA8zdr2nj+ECG3wtHsdxdH/F5mVMX
         ghDY9FIuPUO6rpwfIg/vGrdSXs1ff9FJOrz2kiSxx9OUv/K07bY9z+guFPlDzDjSlzbk
         N8UQlb/pJnbpetHm6JC6qTkFN9Y3anT/VsmFeR7QpWoDnqYWAIrYDXOmxg2XELxT06IM
         OdCJHZfo1HEK2th40B9tkdmaWcsi6sXJ5pwBRrqp1vrhINyXUEYeZUkVfPEyGojnD2Bd
         3Mr/DSS0EkdF/FP68PeYlXDEc3xk6/kKJ7/kj3cSpjmZDWccIg7s2QwIGjccoAeECeyE
         EA3w==
X-Forwarded-Encrypted: i=1; AJvYcCUDoCX4aQfxdeLr3WjlfliP1+AxykgEilyyV4/7yWbpZmKi2rzyO9j6cHCYrQOnXEgzU02IHF+LzI4nEvbiytrBNgmRYZDkMgC6she3
X-Gm-Message-State: AOJu0YzBBCVMg52lV+dxiTZ5WoouwdO0UsqaBV9ko2jA9RiRrrx4HWyB
	B6ifiepU97UUnlrK2W8sdNU/dq3yif27gH2R2WfwiTgIdb7AHepVGbyE2NhUOHU/uiENHSqgYFb
	c8BaMVg0c9owFn4671ryZAtcFLr1GWQVtTIT5
X-Google-Smtp-Source: AGHT+IEsHSmiiXQvoDBh4HgceuFqJ+anCd8E7q1lvKuF22p0eNxhQ85JLw6yLNL5oKFNhigmMgRwhIFYqARVxyb3t9I=
X-Received: by 2002:a05:6512:21c:b0:529:37be:ffad with SMTP id
 2adb3069b0e04-52966ca6460mr4315742e87.49.1716787716995; Sun, 26 May 2024
 22:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502103848.5845-1-shawn.sung@mediatek.com>
 <20240502103848.5845-6-shawn.sung@mediatek.com> <CAC=S1ngUh-o107YM8zEu-ebaP7+eaO1x6SsZ6OeRxrH5YgFKxw@mail.gmail.com>
 <CAGb2v67TZSoQnEMhUNKhnbkwK2=9yCPcwnLD-iHuRp6=Y2ez2Q@mail.gmail.com> <CAC=S1nhKPo5BUYJ_cHGz3OoPrWNh5eO8rhdyikLimsqSOrZ5Xg@mail.gmail.com>
In-Reply-To: <CAC=S1nhKPo5BUYJ_cHGz3OoPrWNh5eO8rhdyikLimsqSOrZ5Xg@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 27 May 2024 13:28:26 +0800
Message-ID: <CAGXv+5FbJ=LzV25=-tmm8zFGgecSSa2Zib7G-pUuYUK9ytyfsw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] drm/mediatek: Set DRM mode configs accordingly
To: Fei Shao <fshao@chromium.org>
Cc: wens@kernel.org, Shawn Sung <shawn.sung@mediatek.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
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

On Mon, May 27, 2024 at 12:54=E2=80=AFPM Fei Shao <fshao@chromium.org> wrot=
e:
>
> On Mon, May 27, 2024 at 12:38=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> w=
rote:
> >
> > On Mon, May 27, 2024 at 12:34=E2=80=AFPM Fei Shao <fshao@chromium.org> =
wrote:
> > >
> > > Hi Shawn,
> > >
> > > On Thu, May 2, 2024 at 6:39=E2=80=AFPM Shawn Sung <shawn.sung@mediate=
k.com> wrote:
> > > >
> > > > From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> > > >
> > > > Set DRM mode configs limitation according to the hardware capabilit=
ies
> > > > and pass the IGT checks as below:
> > > >
> > > > - The test "graphics.IgtKms.kms_plane" requires a frame buffer with
> > > >   width of 4512 pixels (> 4096).
> > > > - The test "graphics.IgtKms.kms_cursor_crc" checks if the cursor si=
ze is
> > > >   defined, and run the test with cursor size from 1x1 to 512x512.
> > > >
> > > > Please notice that the test conditions may change as IGT is updated=
.
> > > >
> > > > Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 22 ++++++++++++++++++++++
> > > >  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  4 ++++
> > > >  2 files changed, 26 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/d=
rm/mediatek/mtk_drm_drv.c
> > > > index 8e047043202b4..c9cad3a827376 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > > > @@ -294,6 +294,9 @@ static const struct mtk_mmsys_driver_data mt818=
8_vdosys0_driver_data =3D {
> > > >         .conn_routes =3D mt8188_mtk_ddp_main_routes,
> > > >         .num_conn_routes =3D ARRAY_SIZE(mt8188_mtk_ddp_main_routes)=
,
> > > >         .mmsys_dev_num =3D 2,
> > > > +       .max_width =3D 8191,
> > > > +       .min_width =3D 1,
> > > > +       .min_height =3D 1,
> > > >  };
> > > >
> > > >  static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data=
 =3D {
> > > > @@ -308,6 +311,9 @@ static const struct mtk_mmsys_driver_data mt819=
5_vdosys0_driver_data =3D {
> > > >         .main_path =3D mt8195_mtk_ddp_main,
> > > >         .main_len =3D ARRAY_SIZE(mt8195_mtk_ddp_main),
> > > >         .mmsys_dev_num =3D 2,
> > > > +       .max_width =3D 8191,
> > > > +       .min_width =3D 1,
> > > > +       .min_height =3D 1,
> > > >  };
> > > >
> > > >  static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_da=
ta =3D {
> > > > @@ -315,6 +321,9 @@ static const struct mtk_mmsys_driver_data mt819=
5_vdosys1_driver_data =3D {
> > > >         .ext_len =3D ARRAY_SIZE(mt8195_mtk_ddp_ext),
> > > >         .mmsys_id =3D 1,
> > > >         .mmsys_dev_num =3D 2,
> > > > +       .max_width =3D 8191,
> > > > +       .min_width =3D 2, /* 2-pixel align when ethdr is bypassed *=
/
> > > > +       .min_height =3D 1,
> > > >  };
> > > >
> > > >  static const struct of_device_id mtk_drm_of_ids[] =3D {
> > > > @@ -493,6 +502,15 @@ static int mtk_drm_kms_init(struct drm_device =
*drm)
> > > >                 for (j =3D 0; j < private->data->mmsys_dev_num; j++=
) {
> > > >                         priv_n =3D private->all_drm_private[j];
> > > >
> > > > +                       if (priv_n->data->max_width)
> > > > +                               drm->mode_config.max_width =3D priv=
_n->data->max_width;
> > > > +
> > > > +                       if (priv_n->data->min_width)
> > > > +                               drm->mode_config.min_width =3D priv=
_n->data->min_width;
> > > > +
> > > > +                       if (priv_n->data->min_height)
> > > > +                               drm->mode_config.min_height =3D pri=
v_n->data->min_height;
> > > > +
> > > >                         if (i =3D=3D CRTC_MAIN && priv_n->data->mai=
n_len) {
> > > >                                 ret =3D mtk_crtc_create(drm, priv_n=
->data->main_path,
> > > >                                                       priv_n->data-=
>main_len, j,
> > > > @@ -520,6 +538,10 @@ static int mtk_drm_kms_init(struct drm_device =
*drm)
> > > >                 }
> > > >         }
> > > >
> > > > +       /* IGT will check if the cursor size is configured */
> > > > +       drm->mode_config.cursor_width =3D drm->mode_config.max_widt=
h;
> > > > +       drm->mode_config.cursor_height =3D drm->mode_config.max_hei=
ght;
> > >
> > > I think you shouldn't set the cursor size to the maximum plane size.
> > > As you mentioned in the commit message, IGT tests the cursor sizes
> > > from 1x1 to 512x512, so just setting them to 512 (with a macro) shoul=
d
> > > be enough.
> > >
> > > Currently this tells the userspace "the supported cursor plane size i=
s
> > > up to 4096x8191" on MT8195 and MT8188.
> > > That means the userspace may allocate a buffer with 4096*8191*4 ~=3D
> > > 128MB for the cursor plane in the worst case, and most of the buffer
> > > will be wasted.
> > > Note that the default value for DRM_CAP_CURSOR_WIDTH is 64.
> > >
> > > In practice, when applying this on the MT8188 Chromebook, I see the
> > > userspace allocates two 64MB buffers for the cursor plane.
> > > But if I limit the cursor size to 512, the userspace only allocates
> > > two 1MB buffers i.e. 126MB is optimized for the DMA buffer allocation=
.
> >
> > That seems more like an issue of ChromeOS not doing the most optimal
> > thing though?
>
> I agree that we need to fix this on the ChromeOS side too, but I still
> think the driver doesn't need to set the capabilities like this
> because a full-screen size cursor is not practical anyway.
> The default cursor plane size is just 64x64.

Seems like a better solution was merged:

https://patchwork.freedesktop.org/patch/583298/


ChenYu

> Regard,
> Fei
>
>
>
> >
> > > Regards,
> > > Fei
> > >
> > >
> > > >
> > > > +
> > > >         /* Use OVL device for all DMA memory allocations */
> > > >         crtc =3D drm_crtc_from_index(drm, 0);
> > > >         if (crtc)
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/d=
rm/mediatek/mtk_drm_drv.h
> > > > index 78d698ede1bf8..6cfa790e8df5c 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > > > @@ -46,6 +46,10 @@ struct mtk_mmsys_driver_data {
> > > >         bool shadow_register;
> > > >         unsigned int mmsys_id;
> > > >         unsigned int mmsys_dev_num;
> > > > +
> > > > +       int max_width;
> > > > +       int min_width;
> > > > +       int min_height;
> > > >  };
> > > >
> > > >  struct mtk_drm_private {
> > > > --
> > > > 2.18.0
> > > >

