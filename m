Return-Path: <linux-kernel+bounces-541780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C5A4C177
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633973A79CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D921170D;
	Mon,  3 Mar 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaLGcteD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985D21148C;
	Mon,  3 Mar 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007703; cv=none; b=HxP30pU4TpD7nyOVql9oSlQESNu0wE7QHcN8MoI60WaA7eJGER+xX0lMXDmQefYxn8OWyXGbp9Shq9JJJYl/wXTGQlDanXDpoRBoNzS9rjkPSk15s4yA8G/55pUx7FloAl8PkbLTIETBczN3N7pl64Ny4KTWCb+W3wbmjtdchW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007703; c=relaxed/simple;
	bh=nwrY5mTBKsH0VrIlw0M+a6qAcq9/UvmEmo3JfFgzxI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNIhWr7755sRv5OrpnmQQ+t3UvUF7DSTt0ZqbkC7K94I9yfPCt3dOWxRnp0+QvKGPgYPP082mVgkV8TyMnOtLg6TBzAnMs35Uu1D4WXQaQRIKJY5uYNzfRsWq8YgYIFKKGsKT1wN64PY/0N4G0hI+VRldNhTX3hf2p/BQSng0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaLGcteD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AF8C4CEF3;
	Mon,  3 Mar 2025 13:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007703;
	bh=nwrY5mTBKsH0VrIlw0M+a6qAcq9/UvmEmo3JfFgzxI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UaLGcteDJsTlv1tvfPaaRzAuATBXcyf0Op8VczsXtYqjpZKx/ayCpioXL8zJt+eW9
	 VLfdJdNXU0w5E4heF9VL5kB//4xXQIUvx2s8lXwVMrUUj8LEzd5hvrQz0qF9FVE3kb
	 2DlLjxFh2Fjpb7MJTj+5Iq+uymFyLH9wx/9B1ZomWEHmzo/yomSrbQOTZUIK5VADxx
	 iSwqNvqWK84eIrLN3LF7e7i1k6gJccX+iIoT9KrncGiglMumS7P7Cev18AmELHB/JC
	 lWyRccVUKxzb/7H4Pt5qTIKT8UyieVTCJZOUFO354XFWNL9KcHxx7HKleSqnjH+dsn
	 uloIVK/eG9H3g==
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso6216381a91.3;
        Mon, 03 Mar 2025 05:15:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWF7rsvklxvbxzz7/XSnly5JDOXTRCMlFRAwfLuje82NyHa5GaQMtBVKmKBN0eilikZ+aQnFNaPPd1kPCNV@vger.kernel.org, AJvYcCXPoEGubTxLcpQpJYnfegkZwu0BOs3FSToDHxjRWJvF4gf3Hg2VBFRoeiiivHOhCK41NFWCcZ4cyZL3@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbCf6+5lr7rI25kpMobSwRAvtinnyA9e7VUsv0Yig5k9BFS0h
	oLTzLIcvBEbAUfBG4efF2w3ODECCXc7p1pDScpTlHd7cHpUv3Hm9A12AmU0l0SnJ67j4WeTwNRx
	Am+Ib+cA0Kb7D6mB0WJiYc4kIMg==
X-Google-Smtp-Source: AGHT+IEdq6TIp16hKhBlDO4xfda53D7O9rz6s7IDZPVAapB9apF5VJ70jX9N1Qnsx75v9OLYhq9X6ox1YKUJZiNS6WQ=
X-Received: by 2002:a17:90b:4ac6:b0:2fe:b9be:216 with SMTP id
 98e67ed59e1d1-2febac10927mr18112467a91.31.1741007702343; Mon, 03 Mar 2025
 05:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023-display-support-v7-0-6703f3e26831@baylibre.com> <20231023-display-support-v7-3-6703f3e26831@baylibre.com>
In-Reply-To: <20231023-display-support-v7-3-6703f3e26831@baylibre.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 3 Mar 2025 21:15:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY__qg1R4JQDssy1bDDJMea8Ud7OsPXjek20cHV8S=jfNbA@mail.gmail.com>
X-Gm-Features: AQ5f1JqYD6WJcU1BIk0mtXtCrxuXqvikkqhcdhVAAsXT4MVrnLil5ua2eCNjEcM
Message-ID: <CAAOTY__qg1R4JQDssy1bDDJMea8Ud7OsPXjek20cHV8S=jfNbA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] drm/mediatek: add MT8365 SoC support
To: amergnat@baylibre.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Amergnat:

<amergnat@baylibre.com> =E6=96=BC 2025=E5=B9=B41=E6=9C=8810=E6=97=A5 =E9=80=
=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Fabien Parent <fparent@baylibre.com>
>
> Add DRM support for MT8365 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 0829ceb9967c..5471ef744cc1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -328,6 +328,10 @@ static const struct mtk_mmsys_driver_data mt8195_vdo=
sys1_driver_data =3D {
>         .min_height =3D 1,
>  };
>
> +static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data =3D {
> +       .mmsys_dev_num =3D 1,
> +};
> +
>  static const struct of_device_id mtk_drm_of_ids[] =3D {
>         { .compatible =3D "mediatek,mt2701-mmsys",
>           .data =3D &mt2701_mmsys_driver_data},
> @@ -355,6 +359,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
 {
>           .data =3D &mt8195_vdosys0_driver_data},
>         { .compatible =3D "mediatek,mt8195-vdosys1",
>           .data =3D &mt8195_vdosys1_driver_data},
> +       { .compatible =3D "mediatek,mt8365-mmsys",
> +         .data =3D &mt8365_mmsys_driver_data},
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
> @@ -751,6 +757,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8195-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
> +       { .compatible =3D "mediatek,mt8365-disp-mutex",
> +         .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8173-disp-od",
>           .data =3D (void *)MTK_DISP_OD },
>         { .compatible =3D "mediatek,mt2701-disp-ovl",
>
> --
> 2.25.1
>

