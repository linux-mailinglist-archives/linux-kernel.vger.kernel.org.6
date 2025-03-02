Return-Path: <linux-kernel+bounces-540474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5775A4B115
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9561890020
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E6F1DED7C;
	Sun,  2 Mar 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoACM7+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F7179BC;
	Sun,  2 Mar 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740913642; cv=none; b=k3XfNTg0lcsgpAR0enJ2sMSGqoZAi2UJGYyChurcYVPaTo3BO9Xr+CZiGaCGLmP14dbnYWa7WGKln5pZaBBu0qAPeCS92DUdAdyUIknxNQm5F8LTzmt5ulLpbiX99Df+4cOWRBRQsUH8hPXta+lwSiHWveOJJAfJO6zmXEMikPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740913642; c=relaxed/simple;
	bh=3KC5ipDcjMMPu+IkC8vu+yztuxCxRp2YBcH3qbhnh3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9kQ248wNAWIsYiw7hOo4t91esJaGK713OrFTkpOmY/Mgz00VLTu6VraMqfD0sZ+1RBkUaVHQIH1wCR0u87Kwu2vlLhBPk67KB+cNpbj2dzIA8sULfhtfweENFsQx7kEyoDIRLHhp8LQ6q3mdiUrEijizDg2UcbosgN1Ew674m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoACM7+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6772C4CEE6;
	Sun,  2 Mar 2025 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740913641;
	bh=3KC5ipDcjMMPu+IkC8vu+yztuxCxRp2YBcH3qbhnh3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YoACM7+cmAiLZ8vW4MhKxT1NNR+ivDz4sc4GQ26ENp3s2yJS9Q83KR0yGbGJq8fOW
	 1lli9l7TH7EMQYiqIJpGYFZyM0091KfhwL7Qai4s/T2o/Tb3wEq5/NaP6Fex+WfCr1
	 b5Jj9Zs+mg41ioh3KY+jiURTascd7c4+R3uCKLoKnbQQi9zG5KK1RBTYiJbbA6YJ2C
	 nDhq2LDcA8/Q4iub/HIQfmzhehtws+y0CEemAI5CE0o3QKapmw56qECUr7H3oge9xB
	 m41WoEcTG4LmCybVWKpW1Co3HfQ252L126S1MWfNEs0TeqZYHzTdcs6CU1sNeGn1Xt
	 zqFMXvhjvsa5A==
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so7398116a91.3;
        Sun, 02 Mar 2025 03:07:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjlR7O/dZSK3qKfF82WBz7xgT3TB6X7TfW79l4u/hvwAhd2hpV6/fiy3iEaDnuMOgOhPw29H12J+TD@vger.kernel.org, AJvYcCWoSue1DQu4sJJ5NaiPHcVHaVqStJ5b8wowxtuIFhcmO2Gl9Magu47x3eH+S52uoGN1vxJrcu1UeTD95p0w@vger.kernel.org
X-Gm-Message-State: AOJu0YwojrjCXbrqwivmFJ+nsbkBD14mzNojv5Ohlth52OVnHLnCufqc
	sHmWwcArZDcz6ELeF6P+S48Dz8gyjxffRxHYbc42a3qNLtiYngrooEmOUMPXjU9dHg/bJ3VvNk6
	7X8ZF7elaUV8+Drsb5WORMj01qw==
X-Google-Smtp-Source: AGHT+IH01Pb+Acrlm17K+9SKFrPTyC3svpmtUZZOMamUnprzp62lYR8CKSAPg6EiKdHhDLfl4WwIpNFLts/zm0G5jQ8=
X-Received: by 2002:a17:90b:554f:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2febabf8577mr14667145a91.29.1740913641527; Sun, 02 Mar 2025
 03:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-5-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 2 Mar 2025 19:08:08 +0800
X-Gmail-Original-Message-ID: <CAAOTY__DqCA3+-nsi7+svqHTbjdpTU5+8yDqWwNMnU8V=euQbQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoGUFVsLmWfEOgrfpxwZh3naxz8ITQIPQgo0omrUXo2qHRWobPGb5JPDMg
Message-ID: <CAAOTY__DqCA3+-nsi7+svqHTbjdpTU5+8yDqWwNMnU8V=euQbQ@mail.gmail.com>
Subject: Re: [PATCH v7 04/43] drm/mediatek: mtk_dpi: Move pixel clock setting
 flow to function
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com, 
	jie.qiu@mediatek.com, junzhi.zhao@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	dmitry.baryshkov@linaro.org, lewis.liao@mediatek.com, 
	ives.chenjh@mediatek.com, tommyyl.chen@mediatek.com, 
	jason-jh.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2025=E5=B9=B42=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:=
49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In preparation for adding support for the DPI IP found in MT8195
> and in MT8188 used for HDMI, move the code flow for calculation
> and setting of the DPI pixel clock to a separate function called
> mtk_dpi_set_pixel_clk().
>
> This was done because, on those platforms, the DPI instance that
> is used for HDMI will get its pixel clock from the HDMI clock,
> hence it is not necessary, nor desirable, to calculate or set
> the pixel clock in DPI.

After fix conflicts, applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 43 +++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 41fdc193891a..59c2e4f32a61 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -537,26 +537,17 @@ static unsigned int mtk_dpi_calculate_factor(struct=
 mtk_dpi *dpi, int mode_clk)
>         return dpi_factor[dpi->conf->num_dpi_factor - 1].factor;
>  }
>
> -static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> -                                   struct drm_display_mode *mode)
> +static void mtk_dpi_set_pixel_clk(struct mtk_dpi *dpi, struct videomode =
*vm, int mode_clk)
>  {
> -       struct mtk_dpi_polarities dpi_pol;
> -       struct mtk_dpi_sync_param hsync;
> -       struct mtk_dpi_sync_param vsync_lodd =3D { 0 };
> -       struct mtk_dpi_sync_param vsync_leven =3D { 0 };
> -       struct mtk_dpi_sync_param vsync_rodd =3D { 0 };
> -       struct mtk_dpi_sync_param vsync_reven =3D { 0 };
> -       struct videomode vm =3D { 0 };
>         unsigned long pll_rate;
>         unsigned int factor;
>
>         /* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
>         factor =3D mtk_dpi_calculate_factor(dpi, mode_clk);
> -       drm_display_mode_to_videomode(mode, &vm);
> -       pll_rate =3D vm.pixelclock * factor;
> +       pll_rate =3D vm->pixelclock * factor;
>
>         dev_dbg(dpi->dev, "Want PLL %lu Hz, pixel clock %lu Hz\n",
> -               pll_rate, vm.pixelclock);
> +               pll_rate, vm->pixelclock);
>
>         clk_set_rate(dpi->tvd_clk, pll_rate);
>         pll_rate =3D clk_get_rate(dpi->tvd_clk);
> @@ -566,20 +557,34 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi =
*dpi,
>          * pixels for each iteration: divide the clock by this number and
>          * adjust the display porches accordingly.
>          */
> -       vm.pixelclock =3D pll_rate / factor;
> -       vm.pixelclock /=3D dpi->conf->pixels_per_iter;
> +       vm->pixelclock =3D pll_rate / factor;
> +       vm->pixelclock /=3D dpi->conf->pixels_per_iter;
>
>         if ((dpi->output_fmt =3D=3D MEDIA_BUS_FMT_RGB888_2X12_LE) ||
>             (dpi->output_fmt =3D=3D MEDIA_BUS_FMT_RGB888_2X12_BE))
> -               clk_set_rate(dpi->pixel_clk, vm.pixelclock * 2);
> +               clk_set_rate(dpi->pixel_clk, vm->pixelclock * 2);
>         else
> -               clk_set_rate(dpi->pixel_clk, vm.pixelclock);
> +               clk_set_rate(dpi->pixel_clk, vm->pixelclock);
>
> -
> -       vm.pixelclock =3D clk_get_rate(dpi->pixel_clk);
> +       vm->pixelclock =3D clk_get_rate(dpi->pixel_clk);
>
>         dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
> -               pll_rate, vm.pixelclock);
> +               pll_rate, vm->pixelclock);
> +}
> +
> +static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> +                                   struct drm_display_mode *mode)
> +{
> +       struct mtk_dpi_polarities dpi_pol;
> +       struct mtk_dpi_sync_param hsync;
> +       struct mtk_dpi_sync_param vsync_lodd =3D { 0 };
> +       struct mtk_dpi_sync_param vsync_leven =3D { 0 };
> +       struct mtk_dpi_sync_param vsync_rodd =3D { 0 };
> +       struct mtk_dpi_sync_param vsync_reven =3D { 0 };
> +       struct videomode vm =3D { 0 };
> +
> +       drm_display_mode_to_videomode(mode, &vm);
> +       mtk_dpi_set_pixel_clk(dpi, &vm, mode->clock);
>
>         dpi_pol.ck_pol =3D MTK_DPI_POLARITY_FALLING;
>         dpi_pol.de_pol =3D MTK_DPI_POLARITY_RISING;
> --
> 2.48.1
>

