Return-Path: <linux-kernel+bounces-297425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E290F95B820
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996881F22322
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A91E1CBE9A;
	Thu, 22 Aug 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIgbiW8F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50261CB333
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336169; cv=none; b=SyL66k6puFIBk1ucawgzL/7oZVa9UdQiw7jJhHaeQ1lzwY3T9d8Czjqg0lW3S4OvuvZ7RPZJ8T7nMccB+1Hvl2nFJzs9npVxFhtPrkLwVfCsktQFcM5obriFW8kofiO/QYlLxdxqBUYmOC6C1KBo99UiCOiaCsoAy9D2H7n2//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336169; c=relaxed/simple;
	bh=W5kwXF+wJz51bitQriLhe8Uli77pQxLNfl6KnfeRs/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNxwdvgJhN7Pm3pzc/yVdiAxDNzHt60lPkyFN/I9yQ9kPNIJvWYElr8p5tbbCdAW9esYdAaJ1KZ5lBG+bWYzAhUxM8R+W0kNaeFAARDph4KzG6WGIxzJGXAA97bGCLxp3pxCETej03JsuCbJBOjqmQ5Oy3g7conq6r2kI0XwFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIgbiW8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD04C4AF09
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724336169;
	bh=W5kwXF+wJz51bitQriLhe8Uli77pQxLNfl6KnfeRs/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XIgbiW8FQYxrDZR0nMP5Ve6yr+YP7T4Dg3ykcO3Ro7O0JixNowObn9fRCQGWk9WWD
	 z3zm77AxqRUP+r+52AM2h8TY3CKWfdcnPfvyXgMbRAK87J0xhZC+mjH7SEkYxclXYc
	 cP88L+blh8qdgCyuC5/1KBov+tyKMSDcljEoL2fDKAqJmp69Zy3/oUCIiqGfg+F1dh
	 WoKoYm3Z74CQ/4Qp8fNbnxZ8iWyneN8Q+SMAttml/LvhXelKRrbm4/rhQhWYI/otoO
	 yjh6djVUkKDRkyLN6ekbuLboaA42uyQsNKdZyQh33mNBSP6261LESQ0wPInfBpg6Hz
	 ouyJu7Uh325vg==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so614105a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:16:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqE9+RNes7mtxGuK5/SKN51bZLlMuLLAI7wVXe1702vqn6majticMExjaNv6W8kVucTK8AxxYw2417MCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgY+YPFtOlPdQprUoMY1iuvWQzT9XWy1plPeStp65lbJg0XSl/
	LR/YKQU8lUT0ue9MeoG3uPbtmHj5P1WmZsKNuti4NNjfCkSDuGrU3cm8A9WSj4B9vjf/fdgnxf2
	WQk/AMgC7kEO376r5vPq7SzExOg==
X-Google-Smtp-Source: AGHT+IHWa/d6YEshaBG7X/oWKaxeKpPhnMr3wygRupON5CVgJxcR8GfDfn3XtpvG+CdSumjZAvL45/if2dc9g07I6Lc=
X-Received: by 2002:a17:90b:8c:b0:2d3:b748:96dd with SMTP id
 98e67ed59e1d1-2d616b56691mr2332303a91.25.1724336168860; Thu, 22 Aug 2024
 07:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-drm-fixup-0819-v2-1-a03580ece3ec@mediatek.com>
In-Reply-To: <20240819-drm-fixup-0819-v2-1-a03580ece3ec@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 22 Aug 2024 22:16:22 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-XUtAGz26KUiXyceY=2OiqEoGMerLt3BpUOKcD36xH+g@mail.gmail.com>
Message-ID: <CAAOTY_-XUtAGz26KUiXyceY=2OiqEoGMerLt3BpUOKcD36xH+g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_config()
To: jason-jh.lin@mediatek.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Singo Chang <singo.chang@mediatek.com>, 
	Nancy Lin <nancy.lin@mediatek.com>, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason:

Jason-JH.Lin via B4 Relay
<devnull+jason-jh.lin.mediatek.com@kernel.org> =E6=96=BC 2024=E5=B9=B48=E6=
=9C=8819=E6=97=A5 =E9=80=B1=E4=B8=80
=E4=B8=8B=E5=8D=8811:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>
> In mtk_crtc_ddp_config(), mtk_crtc will use some configuration flags to
> generate instructions to cmdq_handle, such as:
>   state->pending_config
>   mtk_crtc->pending_planes
>   plane_state->pending.config
>   mtk_crtc->pending_async_planes
>   plane_state->pending.async_config
>
> These configuration flags may be set to false when a GCE IRQ comes callin=
g
> ddp_cmdq_cb(). This may result in missing prepare instructions,
> especially if mtk_crtc_update_config() with the flase need_vblank (no nee=
d
> to wait for vblank) cases.
>
> Therefore, the mtk_crtc->config_updating flag is set at the beginning of
> mtk_crtc_update_config() to ensure that these configuration flags won't b=
e
> changed when the mtk_crtc_ddp_config() is preparing instructions.
> But somehow the ddp_cmdq_cb() didn't use the mtk_crtc->config_updating
> flag to prevent those pending config flags from being cleared.
>
> To avoid missing the configuration when generating the config instruction=
,
> the config_updating flag should be added into ddp_cmdq_cb() and be
> protected with spin_lock.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet i=
s done")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
> Change in v2:
> Add spin_lock protection for config_updating flag.
> ---
>  drivers/gpu/drm/mediatek/mtk_crtc.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 6f34f573e127..b752c0b46383 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -69,6 +69,8 @@ struct mtk_crtc {
>         /* lock for display hardware access */
>         struct mutex                    hw_lock;
>         bool                            config_updating;
> +       /* lock for config_updating to cmd buffer */
> +       spinlock_t                      config_lock;
>  };
>
>  struct mtk_crtc_state {
> @@ -107,10 +109,13 @@ static void mtk_crtc_finish_page_flip(struct mtk_cr=
tc *mtk_crtc)
>  static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
>  {
>         drm_crtc_handle_vblank(&mtk_crtc->base);
> +
> +       spin_lock(&mtk_crtc->config_lock);
>         if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank)=
 {
>                 mtk_crtc_finish_page_flip(mtk_crtc);
>                 mtk_crtc->pending_needs_vblank =3D false;
>         }
> +       spin_unlock(&mtk_crtc->config_lock);
>  }
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> @@ -314,6 +319,13 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void=
 *mssg)
>
>         state =3D to_mtk_crtc_state(mtk_crtc->base.state);
>
> +       spin_lock(&mtk_crtc->config_lock);
> +
> +       if (mtk_crtc->config_updating) {
> +               spin_unlock(&mtk_crtc->config_lock);
> +               goto ddp_cmdq_cb_out;
> +       }
> +
>         state->pending_config =3D false;
>
>         if (mtk_crtc->pending_planes) {
> @@ -340,6 +352,10 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void=
 *mssg)
>                 mtk_crtc->pending_async_planes =3D false;
>         }
>
> +       spin_unlock(&mtk_crtc->config_lock);
> +
> +ddp_cmdq_cb_out:
> +
>         mtk_crtc->cmdq_vblank_cnt =3D 0;
>         wake_up(&mtk_crtc->cb_blocking_queue);
>  }
> @@ -571,7 +587,11 @@ static void mtk_crtc_update_config(struct mtk_crtc *=
mtk_crtc, bool needs_vblank)
>         int i;
>
>         mutex_lock(&mtk_crtc->hw_lock);
> +
> +       spin_lock(&mtk_crtc->config_lock);
>         mtk_crtc->config_updating =3D true;
> +       spin_unlock(&mtk_crtc->config_lock);
> +
>         if (needs_vblank)
>                 mtk_crtc->pending_needs_vblank =3D true;
>
> @@ -625,7 +645,10 @@ static void mtk_crtc_update_config(struct mtk_crtc *=
mtk_crtc, bool needs_vblank)
>                 mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
>         }
>  #endif
> +       spin_lock(&mtk_crtc->config_lock);
>         mtk_crtc->config_updating =3D false;
> +       spin_unlock(&mtk_crtc->config_lock);
> +
>         mutex_unlock(&mtk_crtc->hw_lock);
>  }
>
> @@ -1068,6 +1091,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, con=
st unsigned int *path,
>                 drm_mode_crtc_set_gamma_size(&mtk_crtc->base, gamma_lut_s=
ize);
>         drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, has_ctm, gamma_lut=
_size);
>         mutex_init(&mtk_crtc->hw_lock);
> +       spin_lock_init(&mtk_crtc->config_lock);
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         i =3D priv->mbox_index++;
>
> ---
> base-commit: 469f1bad3c1c6e268059f78c0eec7e9552b3894c
> change-id: 20240819-drm-fixup-0819-f51e2d37fcd7
>
> Best regards,
> --
> Jason-JH.Lin <jason-jh.lin@mediatek.com>
>
>

