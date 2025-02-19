Return-Path: <linux-kernel+bounces-521749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA0AA3C1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1347A3D10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79351EB5CF;
	Wed, 19 Feb 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnsiTdTj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1F1E1C1F;
	Wed, 19 Feb 2025 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974416; cv=none; b=GUqCBXJ7P9AdNIYPcWtYjI+YxK+eJ7uc8t+slQ7LleqpCxKiPtdogrSdJa6GKl6MdTa1ku2MzUuY4Ymrp+bBX/ReS+bF1F3zKpTEMBp9i37J43ql1PC31H7OqEKzSvgAy31fQuVptLlik0DOX2HAnGXXrDG6lrpKOoSdTDXYpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974416; c=relaxed/simple;
	bh=jso5qQFQSYU2mgkN6qCTfJjd+ezV54v2ynj9RTPzjc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5tX1mafdtmNLUfDUOu+cuL1tWxkMVICvYojAKDIp1QAdpCSZWTH+Xy1M1OxFPSURDPHeyjnHB0+zK63b5L6pQ+Tq1AHTBtdKOTKsZAuN3mBTm4qVoDwGeHpMoUGCOAEL6aqhFO6QidOur0uvbwCGSIs1W9dpRuqLuVCDQ7dn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnsiTdTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15A0C4CEEC;
	Wed, 19 Feb 2025 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739974415;
	bh=jso5qQFQSYU2mgkN6qCTfJjd+ezV54v2ynj9RTPzjc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FnsiTdTjIta96r2UPsWQppWhDfdDVi33yIdAv7br0buBtK0uCnRlPz0zRE70iN7jh
	 qU5jsaxlcf56OVAeYMyc9UZZcCMR60GxCxst2IolLXGVZ/dvgaC8RZOOj8Re+N/zrA
	 25NjV3xP/6CV/+rhx4njuRt3Wv0qvCfwVw5iHK5l6YA1fngr3GwC+Ota629c+VKEye
	 qVFF9FH0D0rsAHnroytvbw/un7iO2yCsCfutiArUcaWitMcJArqal9WgfQ6dY7HtAi
	 bzGz9inzKseg0RKM85ZLNScRMNjpmwIXJK5dU1ihYmGpvi2DKeeFrYZ/lOeaTOtDtK
	 3yJ424zphsNFA==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso8905041a91.3;
        Wed, 19 Feb 2025 06:13:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9zOrfK3KBHCWBgbxayw+qwmn2/31wCHNjrUQ9yeiZwa6NoXUfCCYHC8MiNSIr96yff7xtuTu7ggIO@vger.kernel.org, AJvYcCWkhhZDxHoBNLF4Yp8z8oZ6Ks83kFpC+EuwAR2+8Zd6PXgvEABvbPOW0049Ng7UKvCn66dQYAcrtvgSA7QF@vger.kernel.org
X-Gm-Message-State: AOJu0YykOUgPE0UQzjTWlL9uDvAWfHhcQMd/I5g0mAX+ansIh/R8M8bt
	4YZFXFpO+JPKdYbn5clHsGOLD/Vf7fnO+8JPwimnHYOHDTtH6Qw+lvEkpLbF4Z0ZK5m1AtebEk/
	ka2qdLfMWJuTsTU40Ul4ep0ppCQ==
X-Google-Smtp-Source: AGHT+IFa8R6i4Eeuldo8axIMgGyezQE2Aih3YKW/uwabG5hR2Fqqcd+qkA666mlQjsQf/SRPn9uJJ5YEmt8CiUS/WUI=
X-Received: by 2002:a17:90b:3912:b0:2fa:229f:d036 with SMTP id
 98e67ed59e1d1-2fcb5abe3cemr5694227a91.30.1739974415205; Wed, 19 Feb 2025
 06:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-17-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-17-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 19 Feb 2025 22:14:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY_99Q5X+PurxQKewJRN4e=cxwMwX-6qzrZztOe5Eu2KuPg@mail.gmail.com>
X-Gm-Features: AWEUYZmtLYXEQSNosRWwGHhpXxbA8tfEaeBMbNB5Y9ryg9Aq3cPAidz3jkYE8sg
Message-ID: <CAAOTY_99Q5X+PurxQKewJRN4e=cxwMwX-6qzrZztOe5Eu2KuPg@mail.gmail.com>
Subject: Re: [PATCH v7 16/43] drm/mediatek: mtk_hdmi: Compress of_device_id
 array entries
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
> Compress the entries found in the of_device_id array to improve
> readability of this file and to make that consistent with other
> kernel drivers.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 1e50b3918069..be71105ba81d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1780,15 +1780,10 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_m=
t8167 =3D {
>  };
>
>  static const struct of_device_id mtk_hdmi_of_ids[] =3D {
> -       { .compatible =3D "mediatek,mt2701-hdmi",
> -         .data =3D &mtk_hdmi_conf_mt2701,
> -       },
> -       { .compatible =3D "mediatek,mt8167-hdmi",
> -         .data =3D &mtk_hdmi_conf_mt8167,
> -       },
> -       { .compatible =3D "mediatek,mt8173-hdmi",
> -       },
> -       {}
> +       { .compatible =3D "mediatek,mt2701-hdmi", .data =3D &mtk_hdmi_con=
f_mt2701 },
> +       { .compatible =3D "mediatek,mt8167-hdmi", .data =3D &mtk_hdmi_con=
f_mt8167 },
> +       { .compatible =3D "mediatek,mt8173-hdmi" },
> +       { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mtk_hdmi_of_ids);
>
> --
> 2.48.1
>

