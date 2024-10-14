Return-Path: <linux-kernel+bounces-363421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A91299C238
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A676281552
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B8154C0B;
	Mon, 14 Oct 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NlAfSGNT"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7714D444
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892512; cv=none; b=LYx4K4IQ1k9647FtzdZ5d8UREB/YHW40gK7k2qpCdl+xwTklf/VdH+rH5xZOSgGBaWqaYqV32BipZ/+GDALYYAJbViuR1+uHqRl5U6Dsi/pa3XJ9Pt6YdTGscTWfQBYYrC+gBkAgxBaIC7n6EUFVHlmwCSa+MU1AvMEIb452B40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892512; c=relaxed/simple;
	bh=/FHlN6HHgoAhJm5fCT39FnjmFin0WXZ+OjosxjWQkWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDqiWkUNLn1EIch7D2bdm/2hB+ejEjFQh5m7QU1lVa8xtUz8xj1sljxCIUKdAiHBp8ycUWHlyudVxbk8MY1CYuyqG5u+WS6kAiZUcAHlWQNCUqQdcPnGkapZ89vxOYb8zKBMxUgIuK6E+tJYkwA7MmtrFyS6AzihgvnKDZ50R1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NlAfSGNT; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fd057a973so892620241.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728892509; x=1729497309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU12UzpgqRbbbtAMZe9QorlWm8OXzhMHZ1TfI8T6l4g=;
        b=NlAfSGNT9dTdKoN/qa21vKrbDStwWC6K8Sc8dsliuZ6tFRK+rcsR8EanzRf/lwOFHc
         pmvsyfwAGt7g/m67hzQNgTNuaphtVWDd1wfOzPfAYP6KXjNmZIGaxOTVouM0fHW99gvM
         PcMyrgTN8Ii9TKp+v4R7r1jwGMt7jRkqBb/Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892509; x=1729497309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QU12UzpgqRbbbtAMZe9QorlWm8OXzhMHZ1TfI8T6l4g=;
        b=HinstJJIDD5gLraI+FjuqdMdsbuObavm1MJVLH5CoemPXTHouTlJQ4InwRI3tb8hB5
         9i9BnE6rlu4NWBrTbfV7T4AmH6vlkZqg2YktY+J2M0f2z322r/HOqs/0yBg7775lnY6c
         HkEWMIKhER2iXbMovd4gD8V0nJq2iNKcIAg49WoXTpWB3itnnRZgDWgN57KW9/u1+T5i
         xQulSIdRdobmAcQiSXEjtmNaFZybo9XFE1cMsnf1aq2t2ALg2Gz8sljUFr75RlHZO5G7
         djHNMBRKfQakjPqb6vNBtHViyIeV8XZKYgaJpQXeqxCLF9QhfKsrna3eOkjp35hZzm38
         e06w==
X-Forwarded-Encrypted: i=1; AJvYcCWGgakKi5m9mwH1mMIpfQMrUmAlEsK6cnCJkJQUNO6Vrw2BUWY/6pQGbwYXmo+7rag9a9xqJ1Y8CePbiYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+9Z2mXF9PLl0QU3SWfEesf5gj1Ucv7rHFdesFZNmEVsOFBEK
	xjXY2cdo930ZvUuaKSNsLfeT1T3GPjkfcUtqibuIVFu+YbSk/3xNv537Sta4GKZbOit+Gcwnjeg
	=
X-Google-Smtp-Source: AGHT+IFl4gZNQMBjw0B16MSpzVeCZu08VhRHU9DjU5QrVUpcoFHlH7GsqB0/IDkalD2XV28FjB/2RA==
X-Received: by 2002:a05:6102:1627:b0:492:abbe:8923 with SMTP id ada2fe7eead31-4a46595e89emr6345700137.6.1728892509306;
        Mon, 14 Oct 2024 00:55:09 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a48ef192bcsm207005137.3.2024.10.14.00.55.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 00:55:07 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a482407e84so337555137.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:55:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZTRzLhMzg8F6LykBLnev5Zylf1SwIVNlMjpYFBL/mwdHa3VjjAFjS2mFobRepL2U8yAdskPCBDPC6rTg=@vger.kernel.org
X-Received: by 2002:a05:6102:6c3:b0:4a3:ddc5:37a4 with SMTP id
 ada2fe7eead31-4a465992f5fmr6744394137.11.1728892506439; Mon, 14 Oct 2024
 00:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923132521.22785-1-liankun.yang@mediatek.com>
In-Reply-To: <20240923132521.22785-1-liankun.yang@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 14 Oct 2024 15:54:29 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhp4DUSCTs84Rukao6=ptawaDNWokbaKXs6uZnW1bX1yQ@mail.gmail.com>
Message-ID: <CAC=S1nhp4DUSCTs84Rukao6=ptawaDNWokbaKXs6uZnW1bX1yQ@mail.gmail.com>
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

On Mon, Sep 23, 2024 at 9:26=E2=80=AFPM Liankun Yang <liankun.yang@mediatek=
.com> wrote:
>
> Update efuse data for MT8188 displayport.
>
> The DP monitor can not display when DUT connected to USB-c to DP dongle.
> Analysis view is invalid DP efuse data.
>
> Fixes: 350c3fe907fb ("drm/mediatek: dp: Add support MT8188 dp/edp functio=
n")
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>

Tested on MT8188-based Lenovo Chromebook Duet 11.

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>


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
>

