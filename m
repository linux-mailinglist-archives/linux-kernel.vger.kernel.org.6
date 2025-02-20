Return-Path: <linux-kernel+bounces-523880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C46A3DC80
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D7E7002A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA331FC0E2;
	Thu, 20 Feb 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmDAx/bL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AE1FC0ED;
	Thu, 20 Feb 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061027; cv=none; b=pO1Te1hRvk1LV09MqxFFClJC2qC5QIRWW+hjkcPIX4GAL6TmPPBXMhwdeAEFwIBtbQqbdD5Rt4qkff4TdN6Po+oynJCnS3KddgAO68DjJcIUQVwd28XO8cRsasSptjbEziGAdFztXHPmepeGeIlPrJsWYq1G+8og5xc6dPA+NdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061027; c=relaxed/simple;
	bh=phtVfpAQP2gqJ9uhxpOiCBTEsxgIpvS5igy/qXNkMDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTON1hq2HVzcUr8I/cAPtuHYWTlRgUQx8NSN05MqzFWBzHo66CxAPhtSSnj3sShIoSZplr+G/4v7I/dJ3xXhV/+YkmOD5UdbxwTN//Uf5S9fqmLOKXMUXXIrkgnIj0l7OaqAfLJ241ZamhEDopkua+u4qH6xgxHW8AYs9y5BGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmDAx/bL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FA0C4CEE3;
	Thu, 20 Feb 2025 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740061026;
	bh=phtVfpAQP2gqJ9uhxpOiCBTEsxgIpvS5igy/qXNkMDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hmDAx/bL+DtKimxCl9L1Ouu9reCfWS9G4jSWwbwFIt62paGHuLWpefNgpk6rEu9mY
	 xZW4LhwkcMuT7rH1d6qZGTSApMyHQYHP/fpyyRhBvV+DjXvOnUH6GOLoTa2xssxUow
	 bUZuyAFc+GmYnNKCa5ACj4s+NdjMC/QflQ6vupSIK5wqLBtCH250twMfbw5duc4ltw
	 nuH3lqb+ocRpyyMo4xPgz18M58FQS6S7PFLwq7rc/+9gl/OkZgzgl28Ex0gxg+7D7r
	 w0AQgd+dHiiP6+vcctnz/+qeAh4+MirPOfxaOcaZqqEt8BYd1ahdBw9+OYkkuOqrJh
	 5EfRZBi4NQS1A==
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so1591541a91.1;
        Thu, 20 Feb 2025 06:17:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUx4KCvEanqRRaAWxFSEr7T3w68Py00xJaX5oD5fiy5yPHVjG6neWEv8/oyM7YDMQLE5Q7JDhbQq6po@vger.kernel.org, AJvYcCWEjalf8P94+EQ26WsxO0RH6RbIyVlKUkMY2UG40+HVXa7TCrw+u1Y/s5fWjLzoD864j2B3VeQ3V7DsWa0t@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3fgPRzH3m1fCHYQEK/wFWuwx2QwD/3lbMtnuxER6UYNHBdoP
	yR6cv89KP37+EpUfzaDh/ckGVQ6/51EkKyFtEcrDPTf3FHFJs9il6ITsC7V1XJRkLByRuKonNDd
	18H23q7RhIZxLyZbO3s3CRagLbQ==
X-Google-Smtp-Source: AGHT+IGyx5QWB4rzHyre9LMXoPdg2qp8oLeofiBp2HooA+47pReCBBVwzDOuk8vQdFLX+87Wzj+OpnchkAQUrEFYbI8=
X-Received: by 2002:a17:90b:2e50:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-2fc40d14ac5mr32787274a91.6.1740061026314; Thu, 20 Feb 2025
 06:17:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-31-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-31-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 20 Feb 2025 22:17:49 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8G36w1KZpfcVPbfZ6RjbAs3=GHdzdnPHZw=4Njnid35A@mail.gmail.com>
X-Gm-Features: AWEUYZn7UqFdQMaggAe3FK4XBZKbvE_M4ZaCHMfj6Eg3FDhoHOMNrpbhRQkeUao
Message-ID: <CAAOTY_8G36w1KZpfcVPbfZ6RjbAs3=GHdzdnPHZw=4Njnid35A@mail.gmail.com>
Subject: Re: [PATCH v7 30/43] drm/mediatek: mtk_hdmi: Remove ifdef for CONFIG_PM_SLEEP
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
50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Since the SIMPLE_DEV_PM_OPS macro and the pm pointer are anyway
> defined when CONFIG_PM_SLEEP is not set, remove the ifdef for it
> and indicate that the mtk_hdmi_{remove,suspend} functions may be
> unused (as they are, in case PM support is not built-in).
>
> While at it, to improve readability, also compress the
> SIMPLE_DEV_PM_OPS declaration as it even fits in less
> than 80 columns.

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
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index f539472307e2..bf8cf7fc8c07 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1694,8 +1694,7 @@ static void mtk_hdmi_remove(struct platform_device =
*pdev)
>         mtk_hdmi_clk_disable_audio(hdmi);
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -static int mtk_hdmi_suspend(struct device *dev)
> +static __maybe_unused int mtk_hdmi_suspend(struct device *dev)
>  {
>         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
>
> @@ -1704,7 +1703,7 @@ static int mtk_hdmi_suspend(struct device *dev)
>         return 0;
>  }
>
> -static int mtk_hdmi_resume(struct device *dev)
> +static __maybe_unused int mtk_hdmi_resume(struct device *dev)
>  {
>         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
>         int ret =3D 0;
> @@ -1717,9 +1716,8 @@ static int mtk_hdmi_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif
> -static SIMPLE_DEV_PM_OPS(mtk_hdmi_pm_ops,
> -                        mtk_hdmi_suspend, mtk_hdmi_resume);
> +
> +static SIMPLE_DEV_PM_OPS(mtk_hdmi_pm_ops, mtk_hdmi_suspend, mtk_hdmi_res=
ume);
>
>  static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 =3D {
>         .tz_disabled =3D true,
> --
> 2.48.1
>

