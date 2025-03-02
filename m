Return-Path: <linux-kernel+bounces-540543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6DDA4B1FF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C7A16BB63
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188A1E5B6C;
	Sun,  2 Mar 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feia/f3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63CB1DE2D7;
	Sun,  2 Mar 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740924304; cv=none; b=ilkWYZg+x0HW37db0AkqWnCZSTlyAjn4Rbcck5SW7penHqAxt8WNNUUPgQMueDWlAqfR58II7P6bUVpy4qoVzv5J3GBdr/hqgQRE98gqb9PX0ygYMi6il2ZJVAoqzShPhG6b4dS72+HEtPZHq1Qj3RRYqqMJvUepvXXndDVp3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740924304; c=relaxed/simple;
	bh=ACEiqu9VyNmqiDL7jDGjoGE0f92hgXDBZVuSdlhL6c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3UhycMJIHxgsFWl3gcMRut40cxqL3xzQOUmIkL25wHebxA6xW5Sdb6lS6MYpLFyFJmjtfEFe5LoeS+MYBku0UT+JUgczwF+X8/O8WchIlefTPLsDz9P6hcXzhZLi5uxbj1OeguzXTBK2eqTsjjKznoUhd9ItNYwSHwTCYey9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feia/f3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58488C4CED6;
	Sun,  2 Mar 2025 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740924303;
	bh=ACEiqu9VyNmqiDL7jDGjoGE0f92hgXDBZVuSdlhL6c4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=feia/f3NOUJDjs0K1SnCGswU3g3gzbBeIKSDA/ChWT6xKyWlnHs1ayaXRl/uZKfAv
	 wf3u3MtYT+Es8Kmf5uUW5gxsZhrz5HH5MheS4CMuI4943Dk+vhGJg7dAoX3WQRKgWZ
	 pHmCZEgOmgahdTDdMoXMgwHs8uGJgCKF31NlvS52VP7Bcysu+9cElBpMmdccCjtITo
	 xPGo0TWs4hfxm/yXi5Gnt7wTCbMRgsgid/X+PUU+OfBIgeZEtlCOiE8OxvMhD8sEwz
	 3UmxWbsJuH8txJHlOLpFjk9S1oc5cpvU4U4jlLdceGdrCitabASCPgMyHcRWiU+dIF
	 EpUe0sHVWhSpg==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feb9076a1cso5270792a91.0;
        Sun, 02 Mar 2025 06:05:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0ctyRU1oOd9kP9SQ5jFcJQP+XtBDDK2k3mrKHka0taPYhkqCX+fkoJJn94EwDOWnvcPEEbgeHHaVW@vger.kernel.org, AJvYcCVUkazRPvX2j/qbTIdNdvXmIPC3AHNvwmXNDzgcIvDLTpsiipM0L7vdN/th7jnGTqPIXVoKutHepkqLkzYu@vger.kernel.org
X-Gm-Message-State: AOJu0YyiM6VPbWOHYkLkejziHvK/DpHBrlUagX5iTwMVPv/RFEJ1CHha
	g+jn3vEcewS0nmSV+j9Gse0qeE4HBoyARZft3W2XyCPNIpnI57ouPE+uQzF5+ht+J0M+NznYzpN
	BoKPGgo0w8Ph+IyrXhgOw5EaByg==
X-Google-Smtp-Source: AGHT+IG16EEdJJHvm6Oj64x4u72JISQwLPN9kfN5w5LtdjSW9aGHHuRsWNMb8JRAz2CRhaPVGvxVlY/s8nFADdCz3Og=
X-Received: by 2002:a17:90b:4fd0:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-2febab5e11dmr17308029a91.14.1740924302962; Sun, 02 Mar 2025
 06:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-10-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 2 Mar 2025 22:05:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY__zrRM9oyDtuDAzJ+ddOU2as2-vy9FkGs_Wzqjo_==RvA@mail.gmail.com>
X-Gm-Features: AQ5f1JoTySmTRsktldIsbqAg0MJ_QRQyHKP457TZ4jFIH5MH1bn0tYelMK9Vy-I
Message-ID: <CAAOTY__zrRM9oyDtuDAzJ+ddOU2as2-vy9FkGs_Wzqjo_==RvA@mail.gmail.com>
Subject: Re: [PATCH v7 09/43] drm/mediatek: mtk_dpi: Explicitly manage TVD
 clock in power on/off
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
> In preparation for adding support for MT8195's HDMI reserved
> DPI, add calls to clk_prepare_enable() / clk_disable_unprepare()
> for the TVD clock: in this particular case, the aforementioned
> clock is not (and cannot be) parented to neither pixel or engine
> clocks hence it won't get enabled automatically by the clock
> framework.
>
> Please note that on all of the currently supported MediaTek
> platforms, the TVD clock is always a parent of either pixel or
> engine clocks, and this means that the common clock framework
> is already enabling this clock before the children.
> On such platforms, this commit will only increase the refcount
> of the TVD clock without any functional change.

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
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index e12dc73ed79c..ee952785866c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -499,6 +499,7 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
>
>         mtk_dpi_disable(dpi);
>         clk_disable_unprepare(dpi->pixel_clk);
> +       clk_disable_unprepare(dpi->tvd_clk);
>         clk_disable_unprepare(dpi->engine_clk);
>  }
>
> @@ -515,6 +516,12 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>                 goto err_refcount;
>         }
>
> +       ret =3D clk_prepare_enable(dpi->tvd_clk);
> +       if (ret) {
> +               dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
> +               goto err_engine;
> +       }
> +
>         ret =3D clk_prepare_enable(dpi->pixel_clk);
>         if (ret) {
>                 dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", r=
et);
> @@ -524,6 +531,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>         return 0;
>
>  err_pixel:
> +       clk_disable_unprepare(dpi->tvd_clk);
> +err_engine:
>         clk_disable_unprepare(dpi->engine_clk);
>  err_refcount:
>         dpi->refcount--;
> --
> 2.48.1
>

