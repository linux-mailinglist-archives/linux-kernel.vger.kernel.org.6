Return-Path: <linux-kernel+bounces-521761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF65BA3C203
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB863A6AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837FA1EDA0B;
	Wed, 19 Feb 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm8Lp1ml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9C286281;
	Wed, 19 Feb 2025 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974956; cv=none; b=nS28O1ZjTyCnBx/sj7lrA2pqfolsXaAaaun+Z0YA0eFAA0EUuivoLZxNMXkdPqih7bVg6QvlKoXpSoQmeqbH7/eHhDcAg5l26eBpow1FBbVJl50Tu+aRPbNELUv+MLLOUNjTWfUIKWLpZE97o3I7hteb3fm5pqExeWeIhUDDpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974956; c=relaxed/simple;
	bh=reh2ru3wGs4xpgkwhP9irvC0VjoDeR95OIEbA777fUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+NO1JjFPCrUytroqKMu71HYIfOy8OMQuCCr6S6Vg6bamyA3abVnwsJHTYGZB1pQuR1eYSmiQ9AbfR/+/aLpAy3ddyf4r4TSXgWAR08VSyxgy4RtXdqFVYjvmrwDc0vNc+i2H49hC6e64QCCPX94WOBp2Vjnbw348LR6g4lCfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm8Lp1ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEECC4AF0B;
	Wed, 19 Feb 2025 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739974956;
	bh=reh2ru3wGs4xpgkwhP9irvC0VjoDeR95OIEbA777fUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rm8Lp1ml+GLe9LpjM4u789wk9VDrcRCHCwOx5d1y1OyHKpQWu1SkSPWkLEj/iHM8K
	 DhtqHwrVw9g5PBRsYAc09f/9PVPYCl78tlWVq7n12KDwO3oQyvj1K8udCXPVo2Xumc
	 WRIok7A9Y6AeZRRgvrlNJLUoawaTA1/5LH7n1EYvbOBZtCPEyVuoampbIn2/R5dtDs
	 /VPI3NwDIqO3E2udYGT8Q9n3e+vb42vS1fle+5mIAwLqbK7Vg3fAxONZsxm2T01Gfn
	 gdIWBWtvVcBDtWRVhKRneSEyttJX26itrB7o/cTI44gZJt94az8kEgvd9i25Bu9C8E
	 ErfCOx1KUGaQg==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa48404207so13620163a91.1;
        Wed, 19 Feb 2025 06:22:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/NEaELVc8/bIIb0YqpIUv4Wu8/Vls7OQUGzH58/LREHNt5ZF9ACd82evlRA2QnFjJqh8R7Mz307c9fIrb@vger.kernel.org, AJvYcCXKUF9nir3iHxbnfMEXGmaaLpN8W3iivkVaWbO7cOdNZ013X48Vwl8xJh5AnqmjYyWDcoByvY6YDLUr@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRS04UwVMP6GNbhirtLvAOPyW66ilumUIPpIj0iGlmpI1QEdQ
	I+5m5reujDZzbZnvh57klMDW0w8afD/sdgMX04BawS5UlYNoHHREXBwfEv+thMH7A/6nWn83Xn6
	qZc6SLwjwEt4FxA29IjaonSNkyg==
X-Google-Smtp-Source: AGHT+IFcqF5yaXmkd1Kkc/nRemVogPJJE5Ke5gvEz4B9RO5EGqWKjgjJjYnTiJJa8/Cdthu+CTDKxzr7KsWY9zI/Ph4=
X-Received: by 2002:a17:90b:39cc:b0:2fa:229f:d03a with SMTP id
 98e67ed59e1d1-2fc4104056emr23304153a91.26.1739974955900; Wed, 19 Feb 2025
 06:22:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-25-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-25-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 19 Feb 2025 22:23:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8qu6QeV=KJypYm=25PSGJD=jaMK6tMa2gWAoEF-mgPGg@mail.gmail.com>
X-Gm-Features: AWEUYZm6NK2d9V3p_Lp0cN8OApA1MPTl0H47EFaINMxZJFCgqd5UGa_xL6LrvNY
Message-ID: <CAAOTY_8qu6QeV=KJypYm=25PSGJD=jaMK6tMa2gWAoEF-mgPGg@mail.gmail.com>
Subject: Re: [PATCH v7 24/43] drm/mediatek: mtk_hdmi: Move vendor/product
 strings to drm_bridge
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
> Move the vendor and product strings to the appropriate entries
> of struct drm_bridge and use that in mtk_hdmi_setup_spd_infoframe
> instead of having the same as function parameters.
>
> While at it, also beautify the strings, setting them to read
> "MediaTek On-Chip HDMI".

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index e9f2f15e98fa..4bf19574463d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -952,15 +952,14 @@ static int mtk_hdmi_setup_avi_infoframe(struct mtk_=
hdmi *hdmi,
>         return 0;
>  }
>
> -static int mtk_hdmi_setup_spd_infoframe(struct mtk_hdmi *hdmi,
> -                                       const char *vendor,
> -                                       const char *product)
> +static int mtk_hdmi_setup_spd_infoframe(struct mtk_hdmi *hdmi)
>  {
> +       struct drm_bridge *bridge =3D &hdmi->bridge;
>         struct hdmi_spd_infoframe frame;
>         u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_SPD_INFOFRAME_SIZE];
>         ssize_t err;
>
> -       err =3D hdmi_spd_infoframe_init(&frame, vendor, product);
> +       err =3D hdmi_spd_infoframe_init(&frame, bridge->vendor, bridge->p=
roduct);
>         if (err < 0) {
>                 dev_err(hdmi->dev, "Failed to initialize SPD infoframe: %=
zd\n",
>                         err);
> @@ -1328,7 +1327,7 @@ static void mtk_hdmi_send_infoframe(struct mtk_hdmi=
 *hdmi,
>  {
>         mtk_hdmi_setup_audio_infoframe(hdmi);
>         mtk_hdmi_setup_avi_infoframe(hdmi, mode);
> -       mtk_hdmi_setup_spd_infoframe(hdmi, "mediatek", "On-chip HDMI");
> +       mtk_hdmi_setup_spd_infoframe(hdmi);
>         if (mode->flags & DRM_MODE_FLAG_3D_MASK)
>                 mtk_hdmi_setup_vendor_specific_infoframe(hdmi, mode);
>  }
> @@ -1707,6 +1706,8 @@ static int mtk_hdmi_probe(struct platform_device *p=
dev)
>         hdmi->bridge.ops =3D DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
>                          | DRM_BRIDGE_OP_HPD;
>         hdmi->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
> +       hdmi->bridge.vendor =3D "MediaTek";
> +       hdmi->bridge.product =3D "On-Chip HDMI";
>         drm_bridge_add(&hdmi->bridge);
>
>         ret =3D mtk_hdmi_clk_enable_audio(hdmi);
> --
> 2.48.1
>

