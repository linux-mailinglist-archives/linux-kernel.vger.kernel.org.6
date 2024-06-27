Return-Path: <linux-kernel+bounces-232416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C799991A88E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024AD1C2198B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E8E1957F0;
	Thu, 27 Jun 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDsWygWP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA12595
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496942; cv=none; b=NfuFdYdAI3oOH+U61eWRajt80mCAn17I7oVQfqbTr9Qw+4ZwPZESQxfMWIsJQXmnMgiE0BBqYX2VE09JTWxR0OZ8JEJTl42efLT9cEB0JRMTXlSnArPow7nSlfrUlk7mmq70T+we7fmgBC00lkiWpj6iygFmF+LvPzTzJNTjZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496942; c=relaxed/simple;
	bh=haqyinA5O0jrPvPaCY+hTYShEe3D4xzEGz+XqJKudOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpDuf3rGH1pffUvZZfhUbNlKzFOpUIyjN3sLOwNON5pCWd9K6KegVldMMuw2UOURTyy5m7tmR1chrmCk0AIrdPOgXOblrcRPunp07NSJSkgXFafN72hwr2xkjx/kdWuoQGuTJNwHA+CDyJwP85PMmuf97yRIsPqfxSBM2Yoy7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDsWygWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622D8C4AF0A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719496942;
	bh=haqyinA5O0jrPvPaCY+hTYShEe3D4xzEGz+XqJKudOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tDsWygWPG1UvEl1yw4KL3p/fKQSq64X/uqzYplsAs9Esq0Mw45Dzza291RqO0N/85
	 GWM6bXdxmjIAoW9nbMVNTJE3+wXTInsHSNsW8su78Tvf1mc1g6wn1Wk6iDDZPJXNVa
	 3i4MHufhu/EpzNi2b6LeOL16/6Mgb3FP5fDCFXKLO8Z2bbPJGiBAe9qSMDqNRuZfHK
	 7i9K3Ha1627W+KrPkqq+PEN+G3vFNHp5rwKLbsL83myrFcYO3l76cF79/Iad4lUva7
	 AHc9Rh559yc09gfr7JEV/jjaqebG2kIBLArT/bQDxpzGfLcsUkn+1YgPji9isbIjon
	 LXh4xJKnrbaqw==
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7187e6b3584so3738162a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:02:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9kjXXlvuKGweIpQB512DOZTFU8NX19NM5+Mctow7YV4mdLyTKu0OznkRqnBV95gGIduVzHuasfdc82wGOcxxVoJzK9rz6Rzpt9qre
X-Gm-Message-State: AOJu0YxTJoOBHbxkmVk/TwAxnMoQwQSd7tQJUKQsF+vlzrCIaU5pMMWV
	r5nHzFKMk5V9PylAZnkOj5vNRsPkaFPbIPd9USMWaRu4XgbKamiTiEcwyujAiPj8qFA62YiQo1k
	GwGZsS44i+a3DBEVVTnh6yai8Nw==
X-Google-Smtp-Source: AGHT+IEjPuF+8KUmWpQykLG9Tjg3oIhhxWtBXJcsgAy4abavUazUPTIucmfl5lTNX0+gcaeiTabgHFx4AqJjfR1buSs=
X-Received: by 2002:a17:90b:1d12:b0:2c8:1e54:4d39 with SMTP id
 98e67ed59e1d1-2c8582dbfa4mr11861140a91.48.1719496941350; Thu, 27 Jun 2024
 07:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611102744.v2.1.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
In-Reply-To: <20240611102744.v2.1.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 27 Jun 2024 22:02:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8pSGOhuRt=swb7o8zm6swnuXqyzPeASRppGCfi032xbQ@mail.gmail.com>
Message-ID: <CAAOTY_8pSGOhuRt=swb7o8zm6swnuXqyzPeASRppGCfi032xbQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Call drm_atomic_helper_shutdown() at
 shutdown time
To: Douglas Anderson <dianders@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Fei Shao <fshao@chromium.org>, Maxime Ripard <mripard@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Douglas

Douglas Anderson <dianders@chromium.org> =E6=96=BC 2024=E5=B9=B46=E6=9C=881=
2=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:28=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
>
> This driver users the component model and shutdown happens in the base
> driver. The "drvdata" for this driver will always be valid if
> shutdown() is called and as of commit 2a073968289d
> ("drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a
> noop") we don't need to confirm that "drm" is non-NULL.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Tested-by: Fei Shao <fshao@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> v1 of this patch was part of a series [1]. It got tested and reviewed
> but never landed. Reposting separately in the hopes that Mediatek DRM
> folks will land it. If, instead, Mediatek DRM folks want to Ack it I'm
> happy to land through drm-misc.
>
> I noticed that this was missing when I failed to add "mediatek" to my
> patch series IDing which DRM modeset drivers did this properly [2].
> Assuming my patch lands, that means that Mediatek devices will start
> getting more warnings printed.
>
> [1] https://lore.kernel.org/r/20230901164111.RFT.5.I2b014f90afc4729b6ecc7=
b5ddd1f6dedcea4625b@changeid
> [2] https://lore.kernel.org/r/20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b2=
9f746b93621749c@changeid
>
> Changes in v2:
> - Removed NULL check since it's not needed since 6.7
> - Rebased on ToT.
>
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index b5f605751b0a..de811e2265da 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -952,6 +952,13 @@ static void mtk_drm_remove(struct platform_device *p=
dev)
>                 of_node_put(private->comp_node[i]);
>  }
>
> +static void mtk_drm_shutdown(struct platform_device *pdev)
> +{
> +       struct mtk_drm_private *private =3D platform_get_drvdata(pdev);
> +
> +       drm_atomic_helper_shutdown(private->drm);
> +}
> +
>  static int mtk_drm_sys_prepare(struct device *dev)
>  {
>         struct mtk_drm_private *private =3D dev_get_drvdata(dev);
> @@ -983,6 +990,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops =3D {
>  static struct platform_driver mtk_drm_platform_driver =3D {
>         .probe  =3D mtk_drm_probe,
>         .remove_new =3D mtk_drm_remove,
> +       .shutdown =3D mtk_drm_shutdown,
>         .driver =3D {
>                 .name   =3D "mediatek-drm",
>                 .pm     =3D &mtk_drm_pm_ops,
> --
> 2.45.2.505.gda0bf45e8d-goog
>

