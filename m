Return-Path: <linux-kernel+bounces-540548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCB4A4B20D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D136189119E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B321E7C25;
	Sun,  2 Mar 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+u5Qdaa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF21DFDA5;
	Sun,  2 Mar 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740924849; cv=none; b=BKKkTXA2OA5GluMEl3PXIb72/IeTjsHPxRKR5FCB2LsEMxg8k9GH5tzz9li8OTc3jS/Z7ZWlt63/HSh5MHKljzhunWLjW8ZqyPNDkyyLJO948DIn7ErK+R7bo2n/F3VWupWd5bS65i22XOHKPFeuc9U4vICLRO6Y1XBjUx8xLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740924849; c=relaxed/simple;
	bh=WdlKpmRexuT7zbkUCRgj1AoIj6QM4UsY/EdnrXW+Z0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE/uofeVgDAF44H2jRFJefzTSh+0OynuO6oQMhrfuCs2zMw5KeypqMINssy2lG9QGXdCe9D5+lO7Z44sJMnzEHnFUIBDRakDq1GUNbIs7whsu+YSMltF0ESsdAU3HdOvUgiVgGEDoLCOzdXQvOBSH83EAKdjkNl8GOOs+J0t/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+u5Qdaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFB8C4CEED;
	Sun,  2 Mar 2025 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740924849;
	bh=WdlKpmRexuT7zbkUCRgj1AoIj6QM4UsY/EdnrXW+Z0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i+u5QdaaJcjF5j/s1z0UDqw3JocXCdgiht9SIOlUr9Z1YILBGlsajNaq9kABdo5vc
	 LBD3mUn3Yv5WsECeXjjVpmxwmZL8VpKSS+ZAK21hXze8ZAcy0mVHopCVkvPUVgAvlx
	 XSW4KXhwLlemsKqRNZkRH7Jnwy5zpEK1392fhE4gZ6WF+NZWbTJAI1yxTu9rOxkwO3
	 TbdIeczqMpNKw1KX9D8QnSU91wNTia1fMKHWM26UHUdhwiZG5oRklU+n8ydRQT9SFp
	 QCAbgENkEaq6Lh7JN31G6dLO3gCKgnZvSEr9i5UNfAjaXmiGRwtfKHk2HdNVIThRFF
	 vUq0Z+iaRS39w==
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f42992f608so5501933a91.0;
        Sun, 02 Mar 2025 06:14:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVq1n4H2GGJOicE/4VOL9QO8mgOCTOHCuk64BqZ7b8dzR/hmjwDAiusnpAoVHAnqcLHn+OGrJ0Afkc7@vger.kernel.org, AJvYcCXDUUcuad16yaY6xZBu9OJQFw+xSDed3jd/MmQq+2UEGvSo9uADDV2LNyRggy1uWzMzy3Vbiq5cBCd7jOmn@vger.kernel.org
X-Gm-Message-State: AOJu0YzEn/45I8bq7+njr07A/1zDYfsAE5uAhrUc1XhL/009jCMszMw+
	NGFGbIWYXuWA81iF4uzM8FaT8SaJKLCPWH8bcnjwd9EWAsLDzgxQj7FD3adTpZcZ66jd+ck/anX
	P8K2j9m8EnN0p+NN8IeY6RYrH7g==
X-Google-Smtp-Source: AGHT+IH+o6hr+P3sa3dBHh740Chan5YgqcTPXM3Ru5+mE8zMm8NmTcfNE+d8G4tit9+DT2LsVyT+KjX9uVxNPTQldM0=
X-Received: by 2002:a17:90b:4acb:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-2febab2ed94mr17009114a91.7.1740924848801; Sun, 02 Mar 2025
 06:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-11-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 2 Mar 2025 22:14:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY__ZZCDDiqhUBscXL-kKkmw87Lv_DmuZT-9cO4BcrmG5Yg@mail.gmail.com>
X-Gm-Features: AQ5f1JoJDOgBq_baFGYqgnx57G6Wswfkq9a6palqCadMv_6q8_1eKi_Eiaca418
Message-ID: <CAAOTY__ZZCDDiqhUBscXL-kKkmw87Lv_DmuZT-9cO4BcrmG5Yg@mail.gmail.com>
Subject: Re: [PATCH v7 10/43] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
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
> Add support for the DPI block found in the MT8195 and MT8188 SoCs.
> Inside of the SoC, this block is directly connected to the HDMI IP.

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
>  drivers/gpu/drm/mediatek/mtk_dpi.c      | 19 +++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  6 ++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  2 ++
>  3 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index ee952785866c..d066fbd6ffb6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -1139,6 +1139,24 @@ static const struct mtk_dpi_conf mt8192_conf =3D {
>         .csc_enable_bit =3D CSC_ENABLE,
>  };
>
> +static const struct mtk_dpi_conf mt8195_conf =3D {
> +       .max_clock_khz =3D 594000,
> +       .output_fmts =3D mt8183_output_fmts,
> +       .num_output_fmts =3D ARRAY_SIZE(mt8183_output_fmts),
> +       .pixels_per_iter =3D 1,
> +       .is_ck_de_pol =3D true,
> +       .swap_input_support =3D true,
> +       .support_direct_pin =3D true,
> +       .dimension_mask =3D HPW_MASK,
> +       .hvsize_mask =3D HSIZE_MASK,
> +       .channel_swap_shift =3D CH_SWAP,
> +       .yuv422_en_bit =3D YUV422_EN,
> +       .csc_enable_bit =3D CSC_ENABLE,
> +       .input_2p_en_bit =3D DPI_INPUT_2P_EN,
> +       .clocked_by_hdmi =3D true,
> +       .output_1pixel =3D true,
> +};
> +
>  static const struct mtk_dpi_conf mt8195_dpintf_conf =3D {
>         .dpi_factor =3D dpi_factor_mt8195_dp_intf,
>         .num_dpi_factor =3D ARRAY_SIZE(dpi_factor_mt8195_dp_intf),
> @@ -1242,6 +1260,7 @@ static const struct of_device_id mtk_dpi_of_ids[] =
=3D {
>         { .compatible =3D "mediatek,mt8188-dp-intf", .data =3D &mt8195_dp=
intf_conf },
>         { .compatible =3D "mediatek,mt8192-dpi", .data =3D &mt8192_conf }=
,
>         { .compatible =3D "mediatek,mt8195-dp-intf", .data =3D &mt8195_dp=
intf_conf },
> +       { .compatible =3D "mediatek,mt8195-dpi", .data =3D &mt8195_conf }=
,
>         { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/me=
diatek/mtk_dpi_regs.h
> index a0b1d18bbbf7..3c24d9e9f241 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> @@ -40,6 +40,12 @@
>  #define FAKE_DE_LEVEN                  BIT(21)
>  #define FAKE_DE_RODD                   BIT(22)
>  #define FAKE_DE_REVEN                  BIT(23)
> +
> +/* DPI_CON: DPI instances */
> +#define DPI_OUTPUT_1T1P_EN             BIT(24)
> +#define DPI_INPUT_2P_EN                        BIT(25)
> +
> +/* DPI_CON: DPINTF instances */
>  #define DPINTF_YUV422_EN               BIT(24)
>  #define DPINTF_CSC_ENABLE              BIT(26)
>  #define DPINTF_INPUT_2P_EN             BIT(29)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index f22ad2882697..772c3d0f5d14 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -810,6 +810,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DPI },
>         { .compatible =3D "mediatek,mt8195-dp-intf",
>           .data =3D (void *)MTK_DP_INTF },
> +       { .compatible =3D "mediatek,mt8195-dpi",
> +         .data =3D (void *)MTK_DPI },
>         { .compatible =3D "mediatek,mt2701-dsi",
>           .data =3D (void *)MTK_DSI },
>         { .compatible =3D "mediatek,mt8173-dsi",
> --
> 2.48.1
>

