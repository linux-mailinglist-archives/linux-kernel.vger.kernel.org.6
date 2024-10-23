Return-Path: <linux-kernel+bounces-378138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4859ACBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E91F228EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388341AC885;
	Wed, 23 Oct 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdbkBEO0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830081AD9EE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692244; cv=none; b=ASiGXpZKVASns5HyWE+W6ButgSEHsAKGMk3Z5J8Si7NRwM3qmEj8AcCeC8DnEjuoNeCsxbZvI/TZ1tr3KdSG3eBKeLOIyecdxZJV7o+iJhKTl2VYsyiiDN4yVVLnUorEjlvPp9yYDNFwESv0f8j4mRM0aYVF/oHPE+urphLp8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692244; c=relaxed/simple;
	bh=3MPewIa2RjMP+i+zsFQ9KeXkrzNB/sGLihdu9ZgX1Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVFqT+E0pShHLVSkYDMchGPUQceIBzOPRcrobodIMKdhBeiKcqot4cOSXW+LP1UdQzHsqQBk6NhenCR9u53cDNUQg/9TSXb5ivpY3D9+0DJDQTjH3OkuNSiXPuiNoc5sQkUWVsXCQeC+psYcZmKekcM5b8P2PUxERYUyg9rfRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdbkBEO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB60C4CEEE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729692244;
	bh=3MPewIa2RjMP+i+zsFQ9KeXkrzNB/sGLihdu9ZgX1Xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qdbkBEO03QRVYRTMpVXLWE71cKSwutRohJy5TwoxqVHO0wkbQW0YgPfaX29DAqor+
	 94w70E+QfzZ8tOiLhZfTmGiJXyMfqIA9WandhakNjKEstnVmIpxmGu2JbDDQdDkS/w
	 NWQ5ig4TJSBvkyDfxXkdP1g4/5AMAMuOW+QINcxLUcscOsXdpJ71ovHR+NONEqypC5
	 qgw07B94tMVCL2IjSWYlKY/0RtTHeZ/Be19Cfta+jos4swJIdpy6az0lvXq7d+OIrR
	 7twC2anxpXhsptQC9SoqaW0MPESbGAV3lm1ehUPtatYHeVZzrTS+E2Vi0mR8iuJp36
	 nvIMrFdhieGFQ==
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso4449209a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:04:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKlv75IVPily+uoofhWUgCjUIplK7BNDq2d3ZMS431z8ZfAC4lFIV9t1DXEH6lh/b8welGQhePf5luidU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTu2AOzRaIWMDyRkhkgbesWWIVkmQUzLxDePAZjZpihGwUBpA
	A05Iaj9XuZ2rZ9ALWkTTVWpf/Em4AbeXf4Q97d1Bqx/dMvrEMWUk7j1C2yFMoscf4B6PtZlbByt
	vJqRCocH5w6zHzWJNI6ZAPd2okQ==
X-Google-Smtp-Source: AGHT+IF5Q62FJLxl3oE9wLeYU7rpvkWxnbOMZ2oAU54lobEqlwICxfdK2vspUXn7Guq+K/KROXh3ysDXrXOnjtvP2zM=
X-Received: by 2002:a05:6a21:2d8b:b0:1d9:3957:8c24 with SMTP id
 adf61e73a8af0-1d978b39ee6mr2739553637.21.1729692243502; Wed, 23 Oct 2024
 07:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923132521.22785-1-liankun.yang@mediatek.com>
In-Reply-To: <20240923132521.22785-1-liankun.yang@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 23 Oct 2024 22:04:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY__3PvRUaU0a8E0X82yaTjYe8c5J6Uud5+SzMQhew+srgA@mail.gmail.com>
Message-ID: <CAAOTY__3PvRUaU0a8E0X82yaTjYe8c5J6Uud5+SzMQhew+srgA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] drm/mediatek: Fix get efuse issue for MT8188 DPTX
To: Liankun Yang <liankun.yang@mediatek.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com, 
	shuijing.li@mediatek.com, jitao.shi@mediatek.com, mac.shen@mediatek.com, 
	peng.liu@mediatek.com, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Liankun:

Liankun Yang <liankun.yang@mediatek.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=882=
3=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:25=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Update efuse data for MT8188 displayport.
>
> The DP monitor can not display when DUT connected to USB-c to DP dongle.
> Analysis view is invalid DP efuse data.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 350c3fe907fb ("drm/mediatek: dp: Add support MT8188 dp/edp functio=
n")
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
> ---
> Changes in V5:
> - No change.
> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240905124041.=
3658-1-liankun.yang@mediatek.com/
>
> Changes in V4:
> - Remove excess newlines.
> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240903121028.=
20689-1-liankun.yang@mediatek.com/
>
> Changes in V3
> - Update change log position in commit message.
> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240902133736.=
16461-1-liankun.yang@mediatek.com/
>
> Changes in V2
> - Add Fixes tag.
> - Update the commit title.
> - Update the commit description.
> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240510061716.=
31103-1-liankun.yang@mediatek.com/
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 85 ++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index d8796a904eca..f2bee617f063 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -145,6 +145,89 @@ struct mtk_dp_data {
>         u16 audio_m_div2_bit;
>  };
>
> +static const struct mtk_dp_efuse_fmt mt8188_dp_efuse_fmt[MTK_DP_CAL_MAX]=
 =3D {
> +       [MTK_DP_CAL_GLB_BIAS_TRIM] =3D {
> +               .idx =3D 0,
> +               .shift =3D 10,
> +               .mask =3D 0x1f,
> +               .min_val =3D 1,
> +               .max_val =3D 0x1e,
> +               .default_val =3D 0xf,
> +       },
> +       [MTK_DP_CAL_CLKTX_IMPSE] =3D {
> +               .idx =3D 0,
> +               .shift =3D 15,
> +               .mask =3D 0xf,
> +               .min_val =3D 1,
> +               .max_val =3D 0xe,
> +               .default_val =3D 0x8,
> +       },
> +       [MTK_DP_CAL_LN_TX_IMPSEL_PMOS_0] =3D {
> +               .idx =3D 1,
> +               .shift =3D 0,
> +               .mask =3D 0xf,
> +               .min_val =3D 1,
> +               .max_val =3D 0xe,
> +               .default_val =3D 0x8,
> +       },
> +       [MTK_DP_CAL_LN_TX_IMPSEL_PMOS_1] =3D {
> +               .idx =3D 1,
> +               .shift =3D 8,
> +               .mask =3D 0xf,
> +               .min_val =3D 1,
> +               .max_val =3D 0xe,
> +               .default_val =3D 0x8,
> +       },
> +       [MTK_DP_CAL_LN_TX_IMPSEL_PMOS_2] =3D {
> +               .idx =3D 1,
> +               .shift =3D 16,
> +               .mask =3D 0xf,
> +               .min_val =3D 1,
> +               .max_val =3D 0xe,
> +               .default_val =3D 0x8,
> +       },
> +       [MTK_DP_CAL_LN_TX_IMPSEL_PMOS_3] =3D {
> +               .idx =3D 1,
> +               .shift =3D 24,
> +               .mask =3D 0xf,
> +               .min_val =3D 1,
> +               .max_val =3D 0xe,
> +               .default_val =3D 0x8,
> +       },
> +       [MTK_DP_CAL_LN_TX_IMPSEL_NMOS_0] =3D {
> +               .idx =3D 1,
> +               .shift =3D 4,
> +               .mask =3D 0xf,
> +               .min_val =3D 1,
> +               .max_val =3D 0xe,
> +               .default_val =3D 0x8,
> +       },
> +       [MTK_DP_CAL_LN_TX_IMPSEL_NMOS_1] =3D {
> +               .idx =3D 1,
> +               .shift =3D 12,
> +               .mask =3D 0xf,
> +               .min_val =3D 1,
> +               .max_val =3D 0xe,
> +               .default_val =3D 0x8,
> +       },
> +       [MTK_DP_CAL_LN_TX_IMPSEL_NMOS_2] =3D {
> +               .idx =3D 1,
> +               .shift =3D 20,
> +               .mask =3D 0xf,
> +               .min_val =3D 1,
> +               .max_val =3D 0xe,
> +               .default_val =3D 0x8,
> +       },
> +       [MTK_DP_CAL_LN_TX_IMPSEL_NMOS_3] =3D {
> +               .idx =3D 1,
> +               .shift =3D 28,
> +               .mask =3D 0xf,
> +               .min_val =3D 1,
> +               .max_val =3D 0xe,
> +               .default_val =3D 0x8,
> +       },
> +};
> +
>  static const struct mtk_dp_efuse_fmt mt8195_edp_efuse_fmt[MTK_DP_CAL_MAX=
] =3D {
>         [MTK_DP_CAL_GLB_BIAS_TRIM] =3D {
>                 .idx =3D 3,
> @@ -2771,7 +2854,7 @@ static SIMPLE_DEV_PM_OPS(mtk_dp_pm_ops, mtk_dp_susp=
end, mtk_dp_resume);
>  static const struct mtk_dp_data mt8188_dp_data =3D {
>         .bridge_type =3D DRM_MODE_CONNECTOR_DisplayPort,
>         .smc_cmd =3D MTK_DP_SIP_ATF_VIDEO_UNMUTE,
> -       .efuse_fmt =3D mt8195_dp_efuse_fmt,
> +       .efuse_fmt =3D mt8188_dp_efuse_fmt,
>         .audio_supported =3D true,
>         .audio_pkt_in_hblank_area =3D true,
>         .audio_m_div2_bit =3D MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0=
_DIV_2,
> --
> 2.45.2
>

