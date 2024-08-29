Return-Path: <linux-kernel+bounces-307147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88603964924
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB5828231A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7721B1428;
	Thu, 29 Aug 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxvL09kL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593421B1417
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943249; cv=none; b=bdk1ZUSvj1MKVkAOiiWm1HpNQKC6lwSCCW9lZ+lC5574adbyRl2i1ZFGwmL15zEBx/xUwQv5Y2j6GRZcbju/c9/dTsLZAiDwgOYDaXs0Aus3fBkVOTtnL2KGMgooEScMeG+LUGbyCkPxUUzjY+cN8Agmd0jHV8TvU3kmuSrQYTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943249; c=relaxed/simple;
	bh=gGjwRsC3M9/c/KkD/8kJVbZnTVSAPzCfx1ZJsG9gXmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKPkt+Lqu3d/5NLrybWJ3KkEP8N3LxJuYLD7ukpVngylaDiHLhKlxEIRWdGgk0PuBohqBKP4H9LCjjOm96oHmt5IcPfJhgrhwG3EaBj7oVYdQ+1hxJPLqpETmu5llryX6BQ3OWI95Oo7cCSbdUMsi6Xao1KT4svQxWqAC8Wp5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxvL09kL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06B7C4CECE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724943249;
	bh=gGjwRsC3M9/c/KkD/8kJVbZnTVSAPzCfx1ZJsG9gXmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sxvL09kLzbUxLI9MxEXZuSRmQKwYwr0RLNsnEetM3Q6Hhti9iAxt/3c8oDk9MKr+A
	 p2ksOY4Nuzn2Hk6L4mNtPvWBsG91Ph4oBgnNsS7mgRqJVJc6v9VUjCWBMG7gN+CcHy
	 83W+K+/vpIqbrRTsI5KBZr5GnSpEjbvs7EdHcjsCMIXIKusQ6kfpQsoG48J7CcJNAX
	 hmt5Tk2eMXIS/czJa3a5YQvGrQvo8lqQ/PLb04cajH0tVLUftr9okX6S42ex68IogA
	 vN/Z4gputZuXpxZVwui0jHJs0KsNRv02Nb1GQufbuY6Xgi/A4JTZ9rFpOIpIOZtVCK
	 7+P2EULu2Fkig==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-27051f63018so449154fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:54:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWb56tsporeNJAFBgyEO6XTR9IjnYL1s0++7SMEVBszF57l6CwZ5K/VvXj6KiYMmen0ObY32lM4Fc73ek4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGpyfzm1eDDCZwsTp6dDxjuP+ttu+92argDbknIHL87yYBHza
	fCxMM/sXZAuxXNFGOHVVYzSgrM1+bfTN/MJuD7p/ZfZfO/4HSkCp2Xsr5CUL54O4S4FHbCZG6Yk
	f0HyjesYEui8xpUthqiqwhQ7Gww==
X-Google-Smtp-Source: AGHT+IEyygn0DMFYzMyxc8jy6sIuWErx12dvbL0cJxtOdFO//M5/LG3maZP8Ohf/uApEShQBQN09W1UKNHJV+sMS3/Q=
X-Received: by 2002:a05:6358:6f98:b0:1aa:a01a:23dc with SMTP id
 e5c5f4694b2df-1b603c55350mr395137555d.15.1724943248105; Thu, 29 Aug 2024
 07:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826060654.24038-1-shuijing.li@mediatek.com>
In-Reply-To: <20240826060654.24038-1-shuijing.li@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 29 Aug 2024 22:54:22 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8K2BQm5JOBpeP+ZYcctcHAp46JWma7z4vWGFoa1MFbCg@mail.gmail.com>
Message-ID: <CAAOTY_8K2BQm5JOBpeP+ZYcctcHAp46JWma7z4vWGFoa1MFbCg@mail.gmail.com>
Subject: Re: [PATCH v8] drm/mediatek: dsi: Add dsi per-frame lp code for mt8188
To: Shuijing Li <shuijing.li@mediatek.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, jitao.shi@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Shuijing:

Shuijing Li <shuijing.li@mediatek.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:07=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Adding the per-frame lp function of mt8188, which can keep HFP in HS and
> reduce the time required for each line to enter and exit low power.
> Per Frame LP:
>   |<----------One Active Frame-------->|
> --______________________________________----___________________
>   ^HSA+HBP^^RGB^^HFP^^HSA+HBP^^RGB^^HFP^    ^HSA+HBP^^RGB^^HFP^
>
> Per Line LP:
>   |<---------------One Active Frame----------->|
> --______________--______________--______________----______________
>   ^HSA+HBP^^RGB^  ^HSA+HBP^^RGB^  ^HSA+HBP^^RGB^    ^HSA+HBP^^RGB^

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> ---
> Changes in v8:
> Directly write value into DSI_HSTX_CKL_WC without check per suggestion fr=
om previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240819061333.=
26069-1-shuijing.li@mediatek.com/
> Changes in v7:
> Fix code style and simplify the code per suggestion from previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240813022315.=
18502-1-shuijing.li@mediatek.com/
> Changes in v6:
> Simplify the code per suggestion from previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240812070341.=
26053-1-shuijing.li@mediatek.com/
> Changes in v5:
> Fix code style issue and add per-line-lp function to be symmetrical with =
per-frame-lp.
> per suggestion from previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240801081144.=
22372-1-shuijing.li@mediatek.com/
> Changes in v4:
> Drop the code related to bllp_en and bllp_wc, adjust ps_wc to dsi->vm.hac=
tive *
> dsi_buf_bpp.
> Changes in v3:
> Use function in bitfield.h and get value from phy timing, per suggestion
> from previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240424091639.=
22759-1-shuijing.li@mediatek.com/
> Changes in v2:
> Use bitfield macros and add new function for per prame lp and improve
> the format, per suggestion from previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240314094238.=
3315-1-shuijing.li@mediatek.com/
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 106 +++++++++++++++++++++++++----
>  1 file changed, 94 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index b6e3c011a12d..eeec641cab60 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -88,12 +88,15 @@
>  #define DSI_HSA_WC             0x50
>  #define DSI_HBP_WC             0x54
>  #define DSI_HFP_WC             0x58
> +#define HFP_HS_VB_PS_WC                GENMASK(30, 16)
> +#define HFP_HS_EN                      BIT(31)
>
>  #define DSI_CMDQ_SIZE          0x60
>  #define CMDQ_SIZE                      0x3f
>  #define CMDQ_SIZE_SEL          BIT(15)
>
>  #define DSI_HSTX_CKL_WC                0x64
> +#define HSTX_CKL_WC                    GENMASK(15, 2)
>
>  #define DSI_RX_DATA0           0x74
>  #define DSI_RX_DATA1           0x78
> @@ -187,6 +190,7 @@ struct mtk_dsi_driver_data {
>         bool has_shadow_ctl;
>         bool has_size_ctl;
>         bool cmdq_long_packet_ctl;
> +       bool support_per_frame_lp;
>  };
>
>  struct mtk_dsi {
> @@ -426,7 +430,75 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi, =
bool config_vact)
>         writel(ps_val, dsi->regs + DSI_PSCTRL);
>  }
>
> -static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
> +static void mtk_dsi_config_vdo_timing_per_frame_lp(struct mtk_dsi *dsi)
> +{
> +       u32 horizontal_sync_active_byte;
> +       u32 horizontal_backporch_byte;
> +       u32 horizontal_frontporch_byte;
> +       u32 hfp_byte_adjust, v_active_adjust;
> +       u32 cklp_wc_min_adjust, cklp_wc_max_adjust;
> +       u32 dsi_tmp_buf_bpp;
> +       unsigned int da_hs_trail;
> +       unsigned int ps_wc, hs_vb_ps_wc;
> +       u32 v_active_roundup, hstx_cklp_wc;
> +       u32 hstx_cklp_wc_max, hstx_cklp_wc_min;
> +       struct videomode *vm =3D &dsi->vm;
> +
> +       if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)
> +               dsi_tmp_buf_bpp =3D 2;
> +       else
> +               dsi_tmp_buf_bpp =3D 3;
> +
> +       da_hs_trail =3D dsi->phy_timing.da_hs_trail;
> +       ps_wc =3D vm->hactive * dsi_tmp_buf_bpp;
> +
> +       if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) {
> +               horizontal_sync_active_byte =3D
> +                       vm->hsync_len * dsi_tmp_buf_bpp - 10;
> +               horizontal_backporch_byte =3D
> +                       vm->hback_porch * dsi_tmp_buf_bpp - 10;
> +               hfp_byte_adjust =3D 12;
> +               v_active_adjust =3D 32 + horizontal_sync_active_byte;
> +               cklp_wc_min_adjust =3D 12 + 2 + 4 + horizontal_sync_activ=
e_byte;
> +               cklp_wc_max_adjust =3D 20 + 6 + 4 + horizontal_sync_activ=
e_byte;
> +       } else {
> +               horizontal_sync_active_byte =3D vm->hsync_len * dsi_tmp_b=
uf_bpp - 4;
> +               horizontal_backporch_byte =3D (vm->hback_porch + vm->hsyn=
c_len) *
> +                       dsi_tmp_buf_bpp - 10;
> +               cklp_wc_min_adjust =3D 4;
> +               cklp_wc_max_adjust =3D 12 + 4 + 4;
> +               if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> +                       hfp_byte_adjust =3D 18;
> +                       v_active_adjust =3D 28;
> +               } else {
> +                       hfp_byte_adjust =3D 12;
> +                       v_active_adjust =3D 22;
> +               }
> +       }
> +       horizontal_frontporch_byte =3D vm->hfront_porch * dsi_tmp_buf_bpp=
 - hfp_byte_adjust;
> +       v_active_roundup =3D (v_active_adjust + horizontal_backporch_byte=
 + ps_wc +
> +                          horizontal_frontporch_byte) % dsi->lanes;
> +       if (v_active_roundup)
> +               horizontal_backporch_byte +=3D dsi->lanes - v_active_roun=
dup;
> +       hstx_cklp_wc_min =3D (DIV_ROUND_UP(cklp_wc_min_adjust, dsi->lanes=
) + da_hs_trail + 1)
> +                          * dsi->lanes / 6 - 1;
> +       hstx_cklp_wc_max =3D (DIV_ROUND_UP((cklp_wc_max_adjust + horizont=
al_backporch_byte +
> +                          ps_wc), dsi->lanes) + da_hs_trail + 1) * dsi->=
lanes / 6 - 1;
> +
> +       hstx_cklp_wc =3D FIELD_PREP(HSTX_CKL_WC, (hstx_cklp_wc_min + hstx=
_cklp_wc_max) / 2);
> +       writel(hstx_cklp_wc, dsi->regs + DSI_HSTX_CKL_WC);
> +
> +       hs_vb_ps_wc =3D ps_wc - (dsi->phy_timing.lpx + dsi->phy_timing.da=
_hs_exit +
> +                     dsi->phy_timing.da_hs_prepare + dsi->phy_timing.da_=
hs_zero + 2) * dsi->lanes;
> +       horizontal_frontporch_byte |=3D FIELD_PREP(HFP_HS_EN, 1) |
> +                                     FIELD_PREP(HFP_HS_VB_PS_WC, hs_vb_p=
s_wc);
> +
> +       writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
> +       writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
> +       writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
> +}
> +
> +static void mtk_dsi_config_vdo_timing_per_line_lp(struct mtk_dsi *dsi)
>  {
>         u32 horizontal_sync_active_byte;
>         u32 horizontal_backporch_byte;
> @@ -436,7 +508,6 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi =
*dsi)
>         u32 dsi_tmp_buf_bpp, data_phy_cycles;
>         u32 delta;
>         struct mtk_phy_timing *timing =3D &dsi->phy_timing;
> -
>         struct videomode *vm =3D &dsi->vm;
>
>         if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)
> @@ -444,16 +515,6 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi=
 *dsi)
>         else
>                 dsi_tmp_buf_bpp =3D 3;
>
> -       writel(vm->vsync_len, dsi->regs + DSI_VSA_NL);
> -       writel(vm->vback_porch, dsi->regs + DSI_VBP_NL);
> -       writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
> -       writel(vm->vactive, dsi->regs + DSI_VACT_NL);
> -
> -       if (dsi->driver_data->has_size_ctl)
> -               writel(FIELD_PREP(DSI_HEIGHT, vm->vactive) |
> -                      FIELD_PREP(DSI_WIDTH, vm->hactive),
> -                      dsi->regs + DSI_SIZE_CON);
> -
>         horizontal_sync_active_byte =3D (vm->hsync_len * dsi_tmp_buf_bpp =
- 10);
>
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> @@ -499,6 +560,26 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi=
 *dsi)
>         writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>         writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>         writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
> +}
> +
> +static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
> +{
> +       struct videomode *vm =3D &dsi->vm;
> +
> +       writel(vm->vsync_len, dsi->regs + DSI_VSA_NL);
> +       writel(vm->vback_porch, dsi->regs + DSI_VBP_NL);
> +       writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
> +       writel(vm->vactive, dsi->regs + DSI_VACT_NL);
> +
> +       if (dsi->driver_data->has_size_ctl)
> +               writel(FIELD_PREP(DSI_HEIGHT, vm->vactive) |
> +                       FIELD_PREP(DSI_WIDTH, vm->hactive),
> +                       dsi->regs + DSI_SIZE_CON);
> +
> +       if (dsi->driver_data->support_per_frame_lp)
> +               mtk_dsi_config_vdo_timing_per_frame_lp(dsi);
> +       else
> +               mtk_dsi_config_vdo_timing_per_line_lp(dsi);
>
>         mtk_dsi_ps_control(dsi, false);
>  }
> @@ -1197,6 +1278,7 @@ static const struct mtk_dsi_driver_data mt8188_dsi_=
driver_data =3D {
>         .has_shadow_ctl =3D true,
>         .has_size_ctl =3D true,
>         .cmdq_long_packet_ctl =3D true,
> +       .support_per_frame_lp =3D true,
>  };
>
>  static const struct of_device_id mtk_dsi_of_match[] =3D {
> --
> 2.45.2
>

