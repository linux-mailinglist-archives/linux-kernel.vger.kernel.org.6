Return-Path: <linux-kernel+bounces-540473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D883DA4B112
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB1D188D499
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F61DED79;
	Sun,  2 Mar 2025 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2WK9r5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B369179BC;
	Sun,  2 Mar 2025 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740913568; cv=none; b=h+U9eyqd/offfdZ4C4k1LV5s/OOKev130KypJS5xWGbIubfdaLyW9iifw00VGU+QTv+v+hXinXuWbPKf0LnlD6UQW+WaCysFdeCr0XM5i81Upyv8PdKQHlfZTEQ5LQaneG78nJ84kSiiDUdCtHVnCJfa9XEA5dTGsn8nJpSofHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740913568; c=relaxed/simple;
	bh=dFEmSgzocjSvRAOC0rSgdbowwNAjPIkt2fXcO2yivXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y855OVyAfA4BKaiqTGrzxPIwkm/eoSXbDZwa0xxcYBjmH+ZfIW8GUpSv2vRZsKmwrVi69csHZAx6JFmprTv2wCI98A23ET5pOgDf8+6EcMQ8EvM58JalpBGaRPxpUIcPQ7NeJ9TLRj1Jnpn5HUyXl+BLHMd/CxwSWwnpkXrR7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2WK9r5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44670C4CEF0;
	Sun,  2 Mar 2025 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740913567;
	bh=dFEmSgzocjSvRAOC0rSgdbowwNAjPIkt2fXcO2yivXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V2WK9r5MIC7WuwVnLRgml0y0Q5B9sU1d82WnY8JOXecLdaeZjJcm4kmY7yFRKDc3Y
	 kO/Sa4MCO3e90MvlFV6Xn1XLFLWOTkDnuf04RsIaz2xzxu2SdqcViRpOtiLz2EA/gE
	 kKa4NEtHjL9/Herfmms6aXz0lpNtY9xb/gKM4ZKOoYOcE6ttvrHs04lguK3a3zvyV1
	 oy8NNpAx+XqsB0FJ6X8nvbrn2zcIeRMIVjtzmb7W3u+QNroGJt8GaM8Do1jJ+v3ofa
	 vTwyI3iMOhWQviad+e5GxMKcHLHbJvF28lRcWVWOP0/uiFDiRngV8vKLCevKeMOhpn
	 KLb2gCLX26LTw==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so7417093a91.1;
        Sun, 02 Mar 2025 03:06:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJ8/7DDgkq3ABBzj2HTqp0+rgkl42945nVnNfSFKStGCyLiua4A6dQAi4wNC1HeeECVJ+u0+jUSfI6hqkF@vger.kernel.org, AJvYcCVN1MXQseF+IYeuOm8IXgoXADxkyphOFAsM88D0s1tKnn88iaQGloT/JbhLEBsMAXaccGGkJZU3pm8S@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/acO+x1CgxYQoTfPRobfvR2Rp2WAiN3lJMZKavwc4dmqhDrm
	Jisv73DdAgKTfSLCHt4/Mziwsd3p2+/XfsQbJj+38ufou0CGAt/h7w+1GNPPQcEMcEAd/nZuOsW
	WKed+iL4s0V2AXYoqM37zCXYSMw==
X-Google-Smtp-Source: AGHT+IFaakker1RvlwWBHNoAKzwywldrlnkjxsAGufL3nNbLGGTK04VQQJSQKHzYCBPUBZQAE9j/+vDYFuUUpAcGJ2o=
X-Received: by 2002:a17:90b:4b03:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2febabdee31mr14288048a91.28.1740913566738; Sun, 02 Mar 2025
 03:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-6-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 2 Mar 2025 19:06:53 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8BgMwzxa8N-LfwF2E0R0fp390aTc-w320DdeuOrUb=LQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr8JxhruQU5SBFrhJlqRkkYTbn86_r90UvYcimeOPdrDui1RogsSo_EkOY
Message-ID: <CAAOTY_8BgMwzxa8N-LfwF2E0R0fp390aTc-w320DdeuOrUb=LQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/43] drm/mediatek: mtk_dpi: Add checks for
 reg_h_fre_con existence
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
> In preparation for adding support for newer DPI instances which
> do support direct-pin but do not have any H_FRE_CON register,
> like the one found in MT8195 and MT8188, add a branch to check
> if the reg_h_fre_con variable was declared in the mtk_dpi_conf
> structure for the probed SoC DPI version.
>
> As a note, this is useful specifically only for cases in which
> the support_direct_pin variable is true, so mt8195-dpintf is
> not affected by any issue.

Applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 59c2e4f32a61..bb1a17f1384b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -431,12 +431,13 @@ static void mtk_dpi_config_swap_input(struct mtk_dp=
i *dpi, bool enable)
>
>  static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
>  {
> -       mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
> +       if (dpi->conf->reg_h_fre_con)
> +               mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_F=
RE_2N);
>  }
>
>  static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
>  {
> -       if (dpi->conf->edge_sel_en)
> +       if (dpi->conf->edge_sel_en && dpi->conf->reg_h_fre_con)
>                 mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_E=
N);
>  }
>
> --
> 2.48.1
>

