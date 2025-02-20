Return-Path: <linux-kernel+bounces-523844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D0CA3DBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F14188E2FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CF1ADC9B;
	Thu, 20 Feb 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+KTDZMh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3D5258;
	Thu, 20 Feb 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060114; cv=none; b=OYJJ67qlqCGxriWcZAFrbxdP+obFEmvm4XGQ6g0P5oYidHd0cvFre+vnZzdJsshzEsp0fFKpUBItYy7cK6QbT4NuzG+OqXeEd1kWFs+Pomx8UbkpwmT4SldQQnWkq59u/ZWolumGOa2j/SU41eppiu3h8T52kOufFCVqbaUS39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060114; c=relaxed/simple;
	bh=b4AZKnm/4CW7chhpu6yQW9p0aspr3R6qCEzhfg2YT2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWlp6M7enon84rdA6RQswpf8o0DdG+i1CWE9z5qJNx8WfP/Bcrxku4cLyVX3e72RmnpEZd74RFktoCjaS+Bcr34h3f1MXOP+JapWsIcm7Ara7vnY39RxXDVX6yRBi8D8ayqaFcppvNaR+K1g9HMZsWkUEZtWoPMEVQBCY2ejzcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+KTDZMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03174C4CEDD;
	Thu, 20 Feb 2025 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740060114;
	bh=b4AZKnm/4CW7chhpu6yQW9p0aspr3R6qCEzhfg2YT2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q+KTDZMhrGHww4kznoyoJFRb3olr8UODUOwgc0KY/L9KBdW9BoIXyszGXXv4Ynh6Z
	 cO0HdO06VC3E/UqF/Jg8NUdTCasfU7SOTlMugQ16kiTF2vZGHhv7tudwRpKchBJDcY
	 8VcxRDg9kr3ykokUeRV1/TPRR3+pN/SwC5fjv62+HwG3C4tb3DfGpdAHVb+l3BvvIW
	 uo3aq8fCpm2E2YrplY+KvwQMHgVPbrsIVesZTtmr2Ku21/tlm46VDSYvvXMCK1jhVv
	 XBzNMX4ScWWBxkf1CsgRWByYXYhUwiB7AuXrTU5hTSZIWGsL4ttlO1axyFx0nIeMiz
	 Hr+pDlJKgKBOA==
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bfdfb3f4so20268185ad.2;
        Thu, 20 Feb 2025 06:01:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSNrv1zGAcD0mGHsoCJWvPwG/q+qiFTj6J+vuXbm7gqOdHSJkeKGX4vKBPg5GR0lep0hAM4NCguC5GyXbY@vger.kernel.org, AJvYcCXWezI28maPqoN+ITNcrorVmrpWM58U9tEh6yBAXhygNWQkVj+zZZ6usgcB3IHNGQbVNH8jpk9loDh3@vger.kernel.org
X-Gm-Message-State: AOJu0YwMsi1IihV342N5+eQ7DF1rxS8TyWWkrcrcUORtYuUpJaFHw5ZI
	wYAZwe4kbECe1yHgYZo59jK9Ts9zXUMmJwLrN5VVj5sZ24ZiSvGAKiZL9MfJU9GUM3+MHbMlAcV
	8rQxn8CCEssBSL0f1N9fSN/cWag==
X-Google-Smtp-Source: AGHT+IFapzn+NKHW52s4K7DIT+hFK+iRpE1/gZU7kl7MdKEYaDixn7SWx5ZWS9wyFmn3w4NhHQTiw5+aDFJOtqZJANg=
X-Received: by 2002:a17:902:f689:b0:220:bd01:6507 with SMTP id
 d9443c01a7336-22170988a48mr119225175ad.25.1740060113565; Thu, 20 Feb 2025
 06:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-28-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-28-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 20 Feb 2025 22:02:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8xmwncZUdjpfFNZdTc-xVm2tqE7yxFTOHK8=ihPfXL9g@mail.gmail.com>
X-Gm-Features: AWEUYZlmnVy895-w6W37aRIYiIz5B_4hc6yNRSLEcLY9PIsmLv3U1pSvn8yAnCY
Message-ID: <CAAOTY_8xmwncZUdjpfFNZdTc-xVm2tqE7yxFTOHK8=ihPfXL9g@mail.gmail.com>
Subject: Re: [PATCH v7 27/43] drm/mediatek: mtk_hdmi: Remove unused members of
 struct mtk_hdmi
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
> The hdmi_colorspace csp member of struct mtk_hdmi is initialized
> once but then it's never used at all.
> Remove said member and the only assignment to it as a cleanup.
>
> Also remove the ibias, ibias_up, min_clock, max_clock, min_hdisplay
> and max_vdisplay members, as those were really completely unused.
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
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index eb3b1009c305..6e4900f99b51 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -162,16 +162,9 @@ struct mtk_hdmi {
>         struct clk *clk[MTK_HDMI_CLK_COUNT];
>         struct drm_display_mode mode;
>         bool dvi_mode;
> -       u32 min_clock;
> -       u32 max_clock;
> -       u32 max_hdisplay;
> -       u32 max_vdisplay;
> -       u32 ibias;
> -       u32 ibias_up;
>         struct regmap *sys_regmap;
>         unsigned int sys_offset;
>         struct regmap *regs;
> -       enum hdmi_colorspace csp;
>         struct platform_device *audio_pdev;
>         struct hdmi_audio_param aud_param;
>         bool audio_enable;
> @@ -1036,7 +1029,6 @@ static int mtk_hdmi_output_init(struct mtk_hdmi *hd=
mi)
>  {
>         struct hdmi_audio_param *aud_param =3D &hdmi->aud_param;
>
> -       hdmi->csp =3D HDMI_COLORSPACE_RGB;
>         aud_param->aud_codec =3D HDMI_AUDIO_CODING_TYPE_PCM;
>         aud_param->aud_sample_size =3D HDMI_AUDIO_SAMPLE_SIZE_16;
>         aud_param->aud_input_type =3D HDMI_AUD_INPUT_I2S;
> --
> 2.48.1
>

