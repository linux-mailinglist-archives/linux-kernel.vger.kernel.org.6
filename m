Return-Path: <linux-kernel+bounces-540468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF8EA4B101
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936A81893641
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8811DC075;
	Sun,  2 Mar 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4V5gwnt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69F208A9;
	Sun,  2 Mar 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740912760; cv=none; b=jrp6Cc7uRuhwWQV7lMrIDMFlkO08lNeRF35jdrf98LKK5c6p1FRl3Ogfg7Mu7LJlvHVY/TmELOPv5hHWg8scQ664V5eCXTlJfUlsdyCQ8TC8WbG7kD1s/2C+cTUkpf2GoQr2RSgMc4hBX76n6oXzYqzICYOy3cN+eI5Wx/2UEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740912760; c=relaxed/simple;
	bh=L6vzNNhxmQqFNHiJKjZnyLTkOupTCwtG+9t7ypvjb0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhUZ98ornJA01zrirKTDVxz+hfpCJ1F9cbLN59q+4EqyQmY1CJBqrN4hDtI3H3Hq6qjktICYc9lTWqiKK2kGRKjmxKJL8djd+qCySArgFk9vEGE0vQgYBdqqVrPL8e7u+hFaeXCCmZQvgtnIMQg25+neNHpMi+yBJ+fWoH683ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4V5gwnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D84C4CEEB;
	Sun,  2 Mar 2025 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740912759;
	bh=L6vzNNhxmQqFNHiJKjZnyLTkOupTCwtG+9t7ypvjb0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r4V5gwnto8CpFK5ArrwDkkKkSTz3mKb0QPswSkQA9AASsw6jc8LyXtnnz0oBzOx6k
	 62t8im88syweB4l8dxVwfm57Fp+SoZSNZSyI47ECufCgVEc0lTh1Yk9zK/fNKUWlEr
	 Q4P3DpGoxV2mhrJ62ytVjzvkiAdKrlpq2v2RHE8JfTCx4LX/2pPq2BYhgoqWieHmks
	 4Wv86ycHkBf5gx0onr/wqI4dkXsChnFVDcvfCjy4ogYkVCNAfLOGg7GUyJGoYXrHvc
	 kvu0R5eK9Nh1eqjJhTO/8c3tvhrp3C5Zvs0HGesByxV5BvLQaEbBBkIw+64NKLoUyf
	 jjdm0b/OK7W+w==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fea8d8c322so6307053a91.2;
        Sun, 02 Mar 2025 02:52:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhGihj6JtgZlzUXnHfl5zhSy5tNxLh1a8kQt/Zev+OfCHufTwYcfCiA55ZHC09kUNGAPzz7X0MwW2Q@vger.kernel.org, AJvYcCXnW9yI3ERqW1sFJ7xc5/XzMZBtdeXbKWGeNgOisHwFAHE/7uzca5XfMZ1h3Hi9DmHQ+eG5uXlQwRF9hDwC@vger.kernel.org
X-Gm-Message-State: AOJu0YwYe8Y9py4U7eQnTCdkJ8Ky2bmHm13p62VRInOHVTgThUCKKbWV
	8ZlajiPNc8cmvumhV9TNmLVeICnycKtPN4VwvjkuofqJZHkCKvvKXx0m8DPaS426GruFGX/h6/z
	VQP7iN4i0NfuH8xXzmy2FyoNMcA==
X-Google-Smtp-Source: AGHT+IFr0JxiHOLXjlsSslQCDKpP7+qH21b5sizYcPxUilNNHlN/637COD/xsyczcRFpKdal6JWqc5TIwge0h2N6mRI=
X-Received: by 2002:a17:90b:4fd0:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-2febab5e11dmr16532631a91.14.1740912759320; Sun, 02 Mar 2025
 02:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-4-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 2 Mar 2025 18:53:26 +0800
X-Gmail-Original-Message-ID: <CAAOTY_97vGqWn93-esp3H-41Z4bHoBXoBOmKRnOFCCOU8LXnqA@mail.gmail.com>
X-Gm-Features: AQ5f1Joi7NG6PI75qSK41aTo_9uAi-C384Ig7I_HASZnBhU-eUquttae1Ga-uVI
Message-ID: <CAAOTY_97vGqWn93-esp3H-41Z4bHoBXoBOmKRnOFCCOU8LXnqA@mail.gmail.com>
Subject: Re: [PATCH v7 03/43] drm/mediatek: mtk_dpi: Use an array for pixclk
 factor calculation
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
> Setting the TVD PLL clock requires to multiply the target pixel
> clock by a specific constant factor to achieve the target PLL
> frequency, and this is done to reduce jitter to acceptable levels.
>
> On all MediaTek SoCs, the factor is not retrieved by any real kind
> of calculation but rather by checking if the target pixel clock
> is less than a specified frequency, hence assigning a function
> pointer for just a bunch of if branches does enlarge the code
> size for little reason.
>
> Remove all SoC-specific functions, add a structure `mtk_dpi_factor`
> that holds a clock frequency and corresponding PLL factor, and
> declare the constraints for each SoC in form of an array of said
> structure.
> Instead of function pointers, this structure (and its size) is then
> assigned to each SoC's platform data.
>
> The "calculation" is then performed with a new static function
> mtk_dpi_calculate_factor(dpi, mode_clk) that iterates through all
> of the entries of the aforementioned array and returns the right
> factor.
>
> If no factor is found, the lowest possible factor is returned,
> mimicking the same flow as all of the old per-SoC calculation
> functions.
>
> This commit brings no functional change.

After fix build error, applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 103 +++++++++++++++--------------
>  1 file changed, 52 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index fc937490feda..41fdc193891a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -118,9 +118,15 @@ struct mtk_dpi_yc_limit {
>         u16 c_bottom;
>  };
>
> +struct mtk_dpi_factor {
> +       u32 clock;
> +       u8 factor;
> +};
> +
>  /**
>   * struct mtk_dpi_conf - Configuration of mediatek dpi.
> - * @cal_factor: Callback function to calculate factor value.
> + * @dpi_factor: SoC-specific pixel clock PLL factor values.
> + * @num_dpi_factor: Number of pixel clock PLL factor values.
>   * @reg_h_fre_con: Register address of frequency control.
>   * @max_clock_khz: Max clock frequency supported for this SoCs in khz un=
its.
>   * @edge_sel_en: Enable of edge selection.
> @@ -141,7 +147,8 @@ struct mtk_dpi_yc_limit {
>   * @edge_cfg_in_mmsys: If the edge configuration for DPI's output needs =
to be set in MMSYS.
>   */
>  struct mtk_dpi_conf {
> -       unsigned int (*cal_factor)(int clock);
> +       const struct mtk_dpi_factor *dpi_factor;
> +       const u8 num_dpi_factor;
>         u32 reg_h_fre_con;
>         u32 max_clock_khz;
>         bool edge_sel_en;
> @@ -516,6 +523,20 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>         return ret;
>  }
>
> +static unsigned int mtk_dpi_calculate_factor(struct mtk_dpi *dpi, int mo=
de_clk)
> +{
> +       const struct mtk_dpi_factor *dpi_factor =3D dpi->conf->dpi_factor=
;
> +       int i;
> +
> +       for (i =3D 0; i < dpi->conf->num_dpi_factor; i++) {
> +               if (mode_clk <=3D dpi_factor[i].clock)
> +                       return dpi_factor[i].factor;
> +       }
> +
> +       /* If no match try the lowest possible factor */
> +       return dpi_factor[dpi->conf->num_dpi_factor - 1].factor;
> +}
> +
>  static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>                                     struct drm_display_mode *mode)
>  {
> @@ -530,7 +551,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *d=
pi,
>         unsigned int factor;
>
>         /* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
> -       factor =3D dpi->conf->cal_factor(mode->clock);
> +       factor =3D mtk_dpi_calculate_factor(dpi, mode_clk);
>         drm_display_mode_to_videomode(mode, &vm);
>         pll_rate =3D vm.pixelclock * factor;
>
> @@ -965,48 +986,6 @@ static const struct component_ops mtk_dpi_component_=
ops =3D {
>         .unbind =3D mtk_dpi_unbind,
>  };
>
> -static unsigned int mt8173_calculate_factor(int clock)
> -{
> -       if (clock <=3D 27000)
> -               return 3 << 4;
> -       else if (clock <=3D 84000)
> -               return 3 << 3;
> -       else if (clock <=3D 167000)
> -               return 3 << 2;
> -       else
> -               return 3 << 1;
> -}
> -
> -static unsigned int mt2701_calculate_factor(int clock)
> -{
> -       if (clock <=3D 64000)
> -               return 4;
> -       else if (clock <=3D 128000)
> -               return 2;
> -       else
> -               return 1;
> -}
> -
> -static unsigned int mt8183_calculate_factor(int clock)
> -{
> -       if (clock <=3D 27000)
> -               return 8;
> -       else if (clock <=3D 167000)
> -               return 4;
> -       else
> -               return 2;
> -}
> -
> -static unsigned int mt8195_dpintf_calculate_factor(int clock)
> -{
> -       if (clock < 70000)
> -               return 4;
> -       else if (clock < 200000)
> -               return 2;
> -       else
> -               return 1;
> -}
> -
>  static const u32 mt8173_output_fmts[] =3D {
>         MEDIA_BUS_FMT_RGB888_1X24,
>  };
> @@ -1021,8 +1000,25 @@ static const u32 mt8195_output_fmts[] =3D {
>         MEDIA_BUS_FMT_YUYV8_1X16,
>  };
>
> +static const struct mtk_dpi_factor dpi_factor_mt2701[] =3D {
> +       { 64000, 4 }, { 128000, 2 }, { U32_MAX, 1 }
> +};
> +
> +static const struct mtk_dpi_factor dpi_factor_mt8173[] =3D {
> +       { 27000, 48 }, { 84000, 24 }, { 167000, 12 }, { U32_MAX, 6 }
> +};
> +
> +static const struct mtk_dpi_factor dpi_factor_mt8183[] =3D {
> +       { 27000, 8 }, { 167000, 4 }, { U32_MAX, 2 }
> +};
> +
> +static const struct mtk_dpi_factor dpi_factor_mt8195_dp_intf[] =3D {
> +       { 70000 - 1, 4 }, { 200000 - 1, 2 }, { U32_MAX, 1 }
> +};
> +
>  static const struct mtk_dpi_conf mt8173_conf =3D {
> -       .cal_factor =3D mt8173_calculate_factor,
> +       .dpi_factor =3D dpi_factor_mt8173,
> +       .num_dpi_factor =3D ARRAY_SIZE(dpi_factor_mt8173),
>         .reg_h_fre_con =3D 0xe0,
>         .max_clock_khz =3D 300000,
>         .output_fmts =3D mt8173_output_fmts,
> @@ -1039,7 +1035,8 @@ static const struct mtk_dpi_conf mt8173_conf =3D {
>  };
>
>  static const struct mtk_dpi_conf mt2701_conf =3D {
> -       .cal_factor =3D mt2701_calculate_factor,
> +       .dpi_factor =3D dpi_factor_mt2701,
> +       .num_dpi_factor =3D ARRAY_SIZE(dpi_factor_mt2701),
>         .reg_h_fre_con =3D 0xb0,
>         .edge_sel_en =3D true,
>         .max_clock_khz =3D 150000,
> @@ -1057,7 +1054,8 @@ static const struct mtk_dpi_conf mt2701_conf =3D {
>  };
>
>  static const struct mtk_dpi_conf mt8183_conf =3D {
> -       .cal_factor =3D mt8183_calculate_factor,
> +       .dpi_factor =3D dpi_factor_mt8183,
> +       .num_dpi_factor =3D ARRAY_SIZE(dpi_factor_mt8183),
>         .reg_h_fre_con =3D 0xe0,
>         .max_clock_khz =3D 100000,
>         .output_fmts =3D mt8183_output_fmts,
> @@ -1074,7 +1072,8 @@ static const struct mtk_dpi_conf mt8183_conf =3D {
>  };
>
>  static const struct mtk_dpi_conf mt8186_conf =3D {
> -       .cal_factor =3D mt8183_calculate_factor,
> +       .dpi_factor =3D dpi_factor_mt8183,
> +       .num_dpi_factor =3D ARRAY_SIZE(dpi_factor_mt8183),
>         .reg_h_fre_con =3D 0xe0,
>         .max_clock_khz =3D 150000,
>         .output_fmts =3D mt8183_output_fmts,
> @@ -1092,7 +1091,8 @@ static const struct mtk_dpi_conf mt8186_conf =3D {
>  };
>
>  static const struct mtk_dpi_conf mt8192_conf =3D {
> -       .cal_factor =3D mt8183_calculate_factor,
> +       .dpi_factor =3D dpi_factor_mt8183,
> +       .num_dpi_factor =3D ARRAY_SIZE(dpi_factor_mt8183),
>         .reg_h_fre_con =3D 0xe0,
>         .max_clock_khz =3D 150000,
>         .output_fmts =3D mt8183_output_fmts,
> @@ -1109,7 +1109,8 @@ static const struct mtk_dpi_conf mt8192_conf =3D {
>  };
>
>  static const struct mtk_dpi_conf mt8195_dpintf_conf =3D {
> -       .cal_factor =3D mt8195_dpintf_calculate_factor,
> +       .dpi_factor =3D dpi_factor_mt8195_dp_intf,
> +       .num_dpi_factor =3D ARRAY_SIZE(dpi_factor_mt8195_dp_intf),
>         .max_clock_khz =3D 600000,
>         .output_fmts =3D mt8195_output_fmts,
>         .num_output_fmts =3D ARRAY_SIZE(mt8195_output_fmts),
> --
> 2.48.1
>

