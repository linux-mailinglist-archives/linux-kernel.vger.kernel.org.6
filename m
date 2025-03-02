Return-Path: <linux-kernel+bounces-540541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73359A4B1FA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857DB7A5CCA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024E1E570E;
	Sun,  2 Mar 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McIGGuoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5E223F36D;
	Sun,  2 Mar 2025 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740924030; cv=none; b=tqKUTHV5zCL6/SVa64u2vSIztCcoTlgMgJXfgu4locAb1SkhgmJnqQ91YIftGhXsV/7ZwCRjY3M7uEg9Jj7VAAizU/o57XnhBBZejW9+9jGNfUNr1mk3fZkxCe54Es19xnBJhrbLgu/ja+NBb683S5AlSPECYNGtMvQSwr7+xG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740924030; c=relaxed/simple;
	bh=Av/PzBkOyruXRWKNi7XdeiMIEbdI1P2Bm67kdtg1gjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpXqcel3aaImxjoFrXxJd/BloG6NC9ps1eYiQ5zKbmOknu7tvXOZxZujq5eUpfcs/QlePhEk8U5AvRDKFNZacGpo7x9IyU627H9iPPvHEie4gp7+D0cJ9VGQ8QlHrURoNxbUha0tde3aFL/osvMVlw2oxF9vQenOVFzdPO24sPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McIGGuoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A02C4CEEB;
	Sun,  2 Mar 2025 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740924029;
	bh=Av/PzBkOyruXRWKNi7XdeiMIEbdI1P2Bm67kdtg1gjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=McIGGuoZ7gMk2Glgi+BCFR2gGNhEJVNnMtxtb7FuX2X0QS1okoEknf61jVDXoKwNn
	 0nXZNH4n0Hpw4bRx3eyjRFFcF7EgEfBpg4uKzmjNYeB0JZuRxWWmNW0flo+PSESd23
	 ztxe4Hw3qOelY7Gk8DnI5p1dH69WjRuOjVbGpmDty5zBYI/mFQEQzT2/F8qlZeyO+F
	 1ymkoVUztYhkV2Ji7jOVozFBNwTvJilnMIOVRltO/p5JsSVPOXsxop3m5J2AZp+US8
	 U1r5Igo4WtrAV+Nowb+QnB8neIzzYFnkX+l2S1ARK2cnpywKVgWZOf5RH2pGHc7vAs
	 KsWaqJKxxnP3w==
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2238e884f72so11881075ad.3;
        Sun, 02 Mar 2025 06:00:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW77skBb2CT60NrKOovQFwja2n1hojbNS57g8dxO+dm5lENgWXpo4AXLjLNLjN6FYwutaDJCjjqnqHfJLZB@vger.kernel.org, AJvYcCXhtCv6ymNQcdq21xbM7X31EgENYQh6MDbh8wuTSIA4TH1vQJFkZXJ34FvtsJxoRBOOEWAYYfz6DOj9@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWjSb8hFVvInkZkPKn3U5l1zQhBwgjZvcS67vTYLToPFsp9T6
	s0griNk/7HPfScAPlfdMLkb80sA5Psszk7r4KV4BmoSmgJliSba65te1aYa6G9gIdcHlvX1JpCH
	8u2dKKTdmcEYz7Q6FNyHe0cVvXQ==
X-Google-Smtp-Source: AGHT+IG1UW/aTlTM1yyIsxH6m8pGtzQb2LXGDtI6T8t/hEX8x0qb7qhCvRhbTMRAi2KttaGOcJDuH66GaQNNrad3F3Y=
X-Received: by 2002:a17:903:244d:b0:216:6901:d588 with SMTP id
 d9443c01a7336-22368f75980mr127122725ad.15.1740924028832; Sun, 02 Mar 2025
 06:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
 <20250217154836.108895-9-angelogioacchino.delregno@collabora.com> <CAAOTY_8kxxaj+jum6CkJGHKrpjiX_cNt4FT345yET8GWR2QSFA@mail.gmail.com>
In-Reply-To: <CAAOTY_8kxxaj+jum6CkJGHKrpjiX_cNt4FT345yET8GWR2QSFA@mail.gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 2 Mar 2025 22:01:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9tjf8xw8n9euVK1OH7LLopNYwx5qzLJpQyQ+sKfVH6og@mail.gmail.com>
X-Gm-Features: AQ5f1Jo2Tbkh_sgx6kIGT6QdCzyACy__75IjpU71fY-nThmkgmTkCzBPqTB7-MQ
Message-ID: <CAAOTY_9tjf8xw8n9euVK1OH7LLopNYwx5qzLJpQyQ+sKfVH6og@mail.gmail.com>
Subject: Re: [PATCH v7 08/43] drm/mediatek: mtk_dpi: Support AFIFO 1T1P output
 and conversion
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, p.zabel@pengutronix.de, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, ck.hu@mediatek.com, 
	jitao.shi@mediatek.com, jie.qiu@mediatek.com, junzhi.zhao@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	dmitry.baryshkov@linaro.org, lewis.liao@mediatek.com, 
	ives.chenjh@mediatek.com, tommyyl.chen@mediatek.com, 
	jason-jh.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2025=E5=B9=B43=E6=9C=882=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=887:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Angelo:
>
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=
=96=BC
> 2025=E5=B9=B42=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881=
1:49=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On some SoCs, like MT8195 and MT8188, the DPI's FIFO controller
> > (afifo) supports outputting either one or two pixels per round
> > regardless of the input being 1T1P or 1T2P.
> >
> > Add a `output_1pixel` member to struct mtk_dpi_conf which, if
> > set, will enable outputting one pixel per clock.
> >
> > In case the input is two pixel per clock (1T2P), the AFIFO HW
> > will automatically (and internally) convert it to 1T1P.
>
> Applied to mediatek-drm-next [1], thanks.
>
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linu=
x.git/log/?h=3Dmediatek-drm-next

Fix build error then apply. Be care of patch quality.

Regards,
Chun-Kuang.

>
> Regards,
> Chun-Kuang.
>
> >
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/media=
tek/mtk_dpi.c
> > index 9f83e82437dd..e12dc73ed79c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -147,6 +147,8 @@ struct mtk_dpi_factor {
> >   * @edge_cfg_in_mmsys: If the edge configuration for DPI's output need=
s to be set in MMSYS.
> >   * @clocked_by_hdmi: HDMI IP outputs clock to dpi_pixel_clk input cloc=
k, needed
> >   *                  for DPI registers access.
> > + * @output_1pixel: Enable outputting one pixel per round; if the input=
 is two pixel per
> > + *                 round, the DPI hardware will internally transform i=
t to 1T1P.
> >   */
> >  struct mtk_dpi_conf {
> >         const struct mtk_dpi_factor *dpi_factor;
> > @@ -168,6 +170,7 @@ struct mtk_dpi_conf {
> >         u32 pixels_per_iter;
> >         bool edge_cfg_in_mmsys;
> >         bool clocked_by_hdmi;
> > +       bool output_1pixel;
> >  };
> >
> >  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32=
 mask)
> > @@ -653,7 +656,13 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi=
 *dpi,
> >         if (dpi->conf->support_direct_pin) {
> >                 mtk_dpi_config_yc_map(dpi, dpi->yc_map);
> >                 mtk_dpi_config_2n_h_fre(dpi);
> > -               mtk_dpi_dual_edge(dpi);
> > +
> > +               /* DPI can connect to either an external bridge or the =
internal HDMI encoder */
> > +               if (dpi->conf->output_1pixel)
> > +                       mtk_dpi_mask(dpi, DPI_CON, DPI_OUTPUT_1T1P_EN, =
DPI_OUTPUT_1T1P_EN);
> > +               else
> > +                       mtk_dpi_dual_edge(dpi);
> > +
> >                 mtk_dpi_config_disable_edge(dpi);
> >         }
> >         if (dpi->conf->input_2p_en_bit) {
> > --
> > 2.48.1
> >

