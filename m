Return-Path: <linux-kernel+bounces-540479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97570A4B127
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A6F16A99B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E71DD9AD;
	Sun,  2 Mar 2025 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8P+hjlt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66766DCE1;
	Sun,  2 Mar 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740914595; cv=none; b=J5shpzVTVtuJZjDB3TwL3b92nuyPT97VxXbPYKh92XvZJ1Gwu+OxN4JoXH5okYgS4T6msVpp6qmWNLua29FmVPtREYyotDa2Yp/sEARrvS4HR1zdWdyhY2aIi7hy70kQxurx9sTzWqHPg9xZTvtLoGzUxxUoxekRkpPdmBio4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740914595; c=relaxed/simple;
	bh=88iTC3VCTOJkXkwpEcxod0WPhai7pUMfCO6THaRxiz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myvrEsJwKLMR4o+TLNBHY3+KfT9PDhwdl/yqucTqAnMl9CeLDS0oRdAFlaV5sMpU2unhGuwcoJF6S63J3sri5KYGeuIUDFkJzGyuC0hLDsi7/3K9LVanqo+vB2XM4NC+sb/hEBJHZdteuggC8G8mSx5ct+EbBprCoI/9gku76+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8P+hjlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008E2C4CEED;
	Sun,  2 Mar 2025 11:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740914595;
	bh=88iTC3VCTOJkXkwpEcxod0WPhai7pUMfCO6THaRxiz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e8P+hjltOkA3uUaWCeGA+L9nKuJRQEkZkf/iy8iuR6mPo8s/BCWYzoHn2zvNTTv40
	 sb79LxEzwQG3iBHcKFxul6zfX0ruYmCtYUeumswGt4+mG3BM5XgUXl5BazVBnCENha
	 TQI0Sh/zdkYzUQs45W4kLPxN4/kfOWd4OAKqKUGH0xXqzFcy2Be/ZL0X48iyLQus7i
	 cepteP6YWQjvMxy87RwpCczasv9dYAZ3Goh3uSSju4aF6xn0X8MXP3CufkO5LdJcOq
	 oUtOrxSVxpU0AwgMFq6tedRLipvJScf539jOkY3MJim30cTD3pcLY0B4kIuQco3RXh
	 FlFAFCAysIapA==
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223480ea43aso88617055ad.1;
        Sun, 02 Mar 2025 03:23:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNdYhNPs7EiOt9d2bIIWRvAcm5v6Fb2V2J6BtHl6uLI11zL1B8pNqOQ1voYL7IfeQZc9RXf3NwD6IfyhMn@vger.kernel.org, AJvYcCX15teiuvOn5NLkQSKn1DqTqmhLdXia8EAZqUq+noQi77xfm4s1hzvtiRJo6pNQWsWc4FGJsUlTwAGb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6kxxhJ/39ZDAp/JHEOA86NjzgZSwpzocZv239goMyqrUNRmv
	p8KEb08pTAlQNvK/NYgn3dFc7VtNdOGT2xTjUwjQeeC0thpSfvTVRA0l4M2+UIG6f+mAPHbXRy1
	5rulPTlT2qjWiXrGirWOTAS5ehQ==
X-Google-Smtp-Source: AGHT+IFpcs+J1xAyfK06/O6FF1+X82uEcHTSqmEDT4XqGI/sksYkVpLwFKzYZ1+KMrLF9RKJkiWsDGoNBEQOX9vfehk=
X-Received: by 2002:a17:902:dacf:b0:215:a179:14ca with SMTP id
 d9443c01a7336-22368f73284mr153333585ad.2.1740914594460; Sun, 02 Mar 2025
 03:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-8-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 2 Mar 2025 19:24:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8LmRTabeuwXnwDxxodiPRkRD4P9diCO=5CHrwtT4h2QA@mail.gmail.com>
X-Gm-Features: AQ5f1JqaQEl0KFCViPa_ifgKV1VqZysAJMdPHTFuV6fAg_m9uoS6AEjQCuQA1_8
Message-ID: <CAAOTY_8LmRTabeuwXnwDxxodiPRkRD4P9diCO=5CHrwtT4h2QA@mail.gmail.com>
Subject: Re: [PATCH v7 07/43] drm/mediatek: mtk_dpi: Add support for DPI input
 clock from HDMI
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
> On some SoCs, like MT8195 and MT8188, the DPI instance that is
> reserved to the HDMI Transmitter uses a different clock topology.
>
> In this case, the DPI is clocked by the HDMI IP, and this outputs
> its clock to the MM input of dpi_pixel_clk, which is essential to
> enable register access to the DPI IP.
>
> Add a `clocked_by_hdmi` member to struct mtk_dpi_conf, and check
> it to avoid enabling the DPI clocks in the mediatek-drm internal
> .start() callback (and avoid disabing in the .stop() component
> callback): this will make sure that the clock configuration
> sequence is respected during display pipeline setup by following
> the bridge ops between DPI and HDMI, where the HDMI driver is
> expected to enable the clocks in the bridge's pre_enable(), and
> DPI in the enable() cb.

After fix conflicts, applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 9a6c0f75f764..9f83e82437dd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -145,6 +145,8 @@ struct mtk_dpi_factor {
>                       If present, implies that the feature must be enable=
d.
>   * @pixels_per_iter: Quantity of transferred pixels per iteration.
>   * @edge_cfg_in_mmsys: If the edge configuration for DPI's output needs =
to be set in MMSYS.
> + * @clocked_by_hdmi: HDMI IP outputs clock to dpi_pixel_clk input clock,=
 needed
> + *                  for DPI registers access.
>   */
>  struct mtk_dpi_conf {
>         const struct mtk_dpi_factor *dpi_factor;
> @@ -165,6 +167,7 @@ struct mtk_dpi_conf {
>         u32 input_2p_en_bit;
>         u32 pixels_per_iter;
>         bool edge_cfg_in_mmsys;
> +       bool clocked_by_hdmi;
>  };
>
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 m=
ask)
> @@ -585,7 +588,9 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *d=
pi,
>         struct videomode vm =3D { 0 };
>
>         drm_display_mode_to_videomode(mode, &vm);
> -       mtk_dpi_set_pixel_clk(dpi, &vm, mode->clock);
> +
> +       if (!dpi->conf->clocked_by_hdmi)
> +               mtk_dpi_set_pixel_clk(dpi, &vm, mode->clock);
>
>         dpi_pol.ck_pol =3D MTK_DPI_POLARITY_FALLING;
>         dpi_pol.de_pol =3D MTK_DPI_POLARITY_RISING;
> @@ -920,14 +925,16 @@ void mtk_dpi_start(struct device *dev)
>  {
>         struct mtk_dpi *dpi =3D dev_get_drvdata(dev);
>
> -       mtk_dpi_power_on(dpi);
> +       if (!dpi->conf->clocked_by_hdmi)
> +               mtk_dpi_power_on(dpi);
>  }
>
>  void mtk_dpi_stop(struct device *dev)
>  {
>         struct mtk_dpi *dpi =3D dev_get_drvdata(dev);
>
> -       mtk_dpi_power_off(dpi);
> +       if (!dpi->conf->clocked_by_hdmi)
> +               mtk_dpi_power_off(dpi);
>  }
>
>  unsigned int mtk_dpi_encoder_index(struct device *dev)
> --
> 2.48.1
>

