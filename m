Return-Path: <linux-kernel+bounces-523895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D87A3DC90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866971890FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E941FA164;
	Thu, 20 Feb 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTQJE6OD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D91EEA3B;
	Thu, 20 Feb 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061278; cv=none; b=gr6Jh0XuaeyQ6p3c2fWA/EWZaAO+J9184oYOoIdfMkGmuDvtTW1ThObHf37aunmUPFlkSk1RlDzc1j56nbF0uorebvtqK+CveSAAGiLLRqbiQ9w2fOuTkBx1RfrenBv8qZFpCAHS+ERM0KqIovVZTIBXTxwZS12mXx1iNmeFSyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061278; c=relaxed/simple;
	bh=t1YRfXHSR0r4DzbqO4O5hCHBJK6Wk9U+htitk02MAB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTxETJNUXX17jP+GCFkGSebF+jdaC4aRX+qZ/1ooKSokzNfWFQGx2439maG1vda3b1wxTeiTCyshYiJlH9dLA7dvCGC6KggIn/3jCYSnacYwP/l7Zk9edvUVkdYNIBir3X90ZIlnOhFMN+9CW1zfXE0joyXZ0VQy/RDx/Z/f8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTQJE6OD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B221C4CEDD;
	Thu, 20 Feb 2025 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740061278;
	bh=t1YRfXHSR0r4DzbqO4O5hCHBJK6Wk9U+htitk02MAB8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pTQJE6OD2Wd1RK/TY96gGa7OLrWKjlapSJ9+hEKgspSGa7NMMEswTg4pLgf5PhESR
	 01sOIB5OdAY2Ax5kGfuICyeMuo20X0kiE7bDMJxqsMWGrj3ZL/AWVoUWu2cFWi8hVJ
	 a5XN0lV5TJiAtfsgShNAePZ/esyekVbL+rn/3tsFVIX1JVbfefTa6rKK1Qq1fuWcXJ
	 N9sXWpJfhUWq1b8mc8pFPrdKogm1UTYmVYfJuSyKs6a+nyEg9M4nnpw9MwGappcGH/
	 hXfj3IVJUVXI9OCIY3wo/BkTwBKDJjU44bCQD8iFNEDV8NRpflFHMkT6Dyu2OmVl2e
	 wIaT4/Y4tTJvA==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fcce9bb0ecso1775877a91.3;
        Thu, 20 Feb 2025 06:21:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4v5haYIrc+1FzTvGZXM4B6JTVMVsT0glLLQN75+oW9Xu54p0Fk3TZ35K6e4VS0VLr8CdWIZWWRuy/@vger.kernel.org, AJvYcCXFmKso7vhsrXDJL0uyYe2YJtZfcA+u+7KL9KCOsfVbM4ZMdXEZaopxMsGXOtBf93c8lbs8An9PJRSaLggG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2duVEXeglVhK5JF/sx8gqvJAjW/1Dw0G1TDZnRp/nLz6Ah8wJ
	vN8djYMvTOoZx9/iYkWCZhiPghUMiVofR6Jn3AwXTG3lN3Ec08QZcyHGZCFgn0GIW+RtqvipMoL
	9vdrAkbXujR51L+Qrt4R5RMaxEQ==
X-Google-Smtp-Source: AGHT+IEM7TeLueuZHPQaOMtrQ+jefGLGWiXk9sVHtvUBeiE5X3S4o44Ic7KtorBRdm5c8t14xyWBYmEyM00igBUqouk=
X-Received: by 2002:a17:90b:2250:b0:2fa:b84:b31f with SMTP id
 98e67ed59e1d1-2fc41040fcemr33893917a91.25.1740061277661; Thu, 20 Feb 2025
 06:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-32-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-32-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 20 Feb 2025 22:22:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8JLpoF4isgm-F7Z6W-tSxkdqACSaHvyARgaPo8PNdWsg@mail.gmail.com>
X-Gm-Features: AWEUYZkuEEgZl0b7vlV6l42zcGpmz08ZpO3TrJPmfidMvCivGVZgPuOu7_J_xKI
Message-ID: <CAAOTY_8JLpoF4isgm-F7Z6W-tSxkdqACSaHvyARgaPo8PNdWsg@mail.gmail.com>
Subject: Re: [PATCH v7 31/43] drm/mediatek: mtk_hdmi: Remove goto in mtk_hdmi_clk_enable_audio()
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
> If the clk_prepare_enable() call for the SPDIF clock fails, just
> disable and unprepare the clock in the error check branch and
> return immediately instead of jumping to the end with a goto,
> slightly reducing code size.
>
> This commit brings no functional changes.

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
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index bf8cf7fc8c07..2e98a8ed6cbe 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1095,13 +1095,12 @@ static int mtk_hdmi_clk_enable_audio(struct mtk_h=
dmi *hdmi)
>                 return ret;
>
>         ret =3D clk_prepare_enable(hdmi->clk[MTK_HDMI_CLK_AUD_SPDIF]);
> -       if (ret)
> -               goto err;
> +       if (ret) {
> +               clk_disable_unprepare(hdmi->clk[MTK_HDMI_CLK_AUD_BCLK]);
> +               return ret;
> +       }
>
>         return 0;
> -err:
> -       clk_disable_unprepare(hdmi->clk[MTK_HDMI_CLK_AUD_BCLK]);
> -       return ret;
>  }
>
>  static void mtk_hdmi_clk_disable_audio(struct mtk_hdmi *hdmi)
> --
> 2.48.1
>

