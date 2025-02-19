Return-Path: <linux-kernel+bounces-521707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46612A3C13F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B59171941
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C491EDA33;
	Wed, 19 Feb 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi+Bfg1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0D1E1A3B;
	Wed, 19 Feb 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973647; cv=none; b=BxqIxmVdf09HyU5ViNOenZ+oVtl4Q3nYeXqeyeH7f+4H3ioY7eqsD7CBkZ3f9qBw++swt9sQGWPuv57jZ8YSnRhyz0tKmxFIwwPXpUgJkUvF3zzU85ij7kwDWoM8JJZo48O2DhYWOtEQZazpEoFj51u0Jo2JOPBUIURIEIgbnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973647; c=relaxed/simple;
	bh=vEn5X9s0X03RZNsX/FehVn8bFO/GVsoqwmgLAKeThTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRpnoueBq7IdR6e/LWjGZmw/BRnXXvsL9ziYL3cxJC0dQMndyJ32sr4Eyyaw+wxezcHdyYFj+EgsYfqVuzf1bSaSQ+Ha9FvdggqeKpJMMazEQVuICQ8OjyQ35IuZsRhETuiAzDDYjxh8wZkNSkrr4GmrHTcAIHrNVbtGmS33vAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi+Bfg1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4152C4CEEE;
	Wed, 19 Feb 2025 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973646;
	bh=vEn5X9s0X03RZNsX/FehVn8bFO/GVsoqwmgLAKeThTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zi+Bfg1RQd+Lf4yEh810Okdlgu/zmfqteq1iKlGjV9u6OXEOJYhII6NBAn/0gE3Ko
	 Tp+I7eItZ1itdf1igTj06pEtoiaNFTC9GdT7liBCY4EcBlQqGN86HY55MJ8vC4tN4M
	 NxB/NzKIgvkECDBDfxMfrRAi7cmnW27+ZG3qRhWiwtBm0W7wcL6HxQg3E+eQQsbbwh
	 LlFBXQwsdwum316iPRaOS5tvYqQCvlaancOvovw8ETCIOeXpm6CbYF3bo5BhoYcbqk
	 oLAIJn87TSOQKwLfHisNbXuZYeUDcF9jaWTtPO6iIezEpSh5/+hNrisapP0/MshpnS
	 bImhpaceohLZg==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso8876860a91.3;
        Wed, 19 Feb 2025 06:00:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYIcPv91eD44JKETa5IBbLACx5B8YbsDkfs2BMmjam+66L0oEIzc4wQ6XCNlSyzid1pSLkUSh9l0wAMN8i@vger.kernel.org, AJvYcCXgkZg3fVihZE2r1cB4Y/DjAblkx/jeZssRuv65S0ZedivindxcPixWbCOuh5xgML5TXLQCQdQysr2t@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw478e020MfJ3X2wDehJDIJuuxpykhi8NQ+nqfJFYz77WpxGMi
	RsZXHcvWmqct7VvbKug9iS8QQFx9IhZFLatYKFfxIELZRPEIC/vgub46pvqtek7Sp/glEkuwXdo
	wqdXW/cCDCyNcurc17h5j7H/4Tw==
X-Google-Smtp-Source: AGHT+IHRoKXGmXM1paDFNeCBXkKPPbaMW6fIKItj9hAqnwjEMJdKy4fDjEc43FMEaHHNLq0oBSEC7WyHzl/u9EJNtqg=
X-Received: by 2002:a17:90b:1a89:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-2fcb5a9db51mr5836056a91.25.1739973646106; Wed, 19 Feb 2025
 06:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-18-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-18-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 19 Feb 2025 22:01:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY__d2A6BiegTqX+eXAk5LYAtRexnwLvkbje94ax05jOMug@mail.gmail.com>
X-Gm-Features: AWEUYZn3pFp_1IYzIW4DyIvJ63JD27HTlx-6jN1bSkLAtPngd4i98FCr_lIubC4
Message-ID: <CAAOTY__d2A6BiegTqX+eXAk5LYAtRexnwLvkbje94ax05jOMug@mail.gmail.com>
Subject: Re: [PATCH v7 17/43] drm/mediatek: mtk_hdmi: Unregister audio
 platform device on failure
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
> The probe function of this driver may fail after registering the
> audio platform device: in that case, the state is not getting
> cleaned up, leaving this device registered.
>
> Adding up to the mix, should the probe function of this driver
> return a probe deferral for N times, we're registering up to N
> audio platform devices and, again, never freeing them up.
>
> To fix this, add a pointer to the audio platform device in the
> mtk_hdmi structure, and add a devm action to unregister it upon
> driver removal or probe failure.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index be71105ba81d..b9f4f06edde6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -172,6 +172,7 @@ struct mtk_hdmi {
>         unsigned int sys_offset;
>         void __iomem *regs;
>         enum hdmi_colorspace csp;
> +       struct platform_device *audio_pdev;
>         struct hdmi_audio_param aud_param;
>         bool audio_enable;
>         bool powered;
> @@ -1661,6 +1662,11 @@ static const struct hdmi_codec_ops mtk_hdmi_audio_=
codec_ops =3D {
>         .hook_plugged_cb =3D mtk_hdmi_audio_hook_plugged_cb,
>  };
>
> +static void mtk_hdmi_unregister_audio_driver(void *data)
> +{
> +       platform_device_unregister(data);
> +}
> +
>  static int mtk_hdmi_register_audio_driver(struct device *dev)
>  {
>         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
> @@ -1671,13 +1677,20 @@ static int mtk_hdmi_register_audio_driver(struct =
device *dev)
>                 .data =3D hdmi,
>                 .no_capture_mute =3D 1,
>         };
> -       struct platform_device *pdev;
> +       int ret;
>
> -       pdev =3D platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
> -                                            PLATFORM_DEVID_AUTO, &codec_=
data,
> -                                            sizeof(codec_data));
> -       if (IS_ERR(pdev))
> -               return PTR_ERR(pdev);
> +       hdmi->audio_pdev =3D platform_device_register_data(dev,
> +                                                        HDMI_CODEC_DRV_N=
AME,
> +                                                        PLATFORM_DEVID_A=
UTO,
> +                                                        &codec_data,
> +                                                        sizeof(codec_dat=
a));
> +       if (IS_ERR(hdmi->audio_pdev))
> +               return PTR_ERR(hdmi->audio_pdev);
> +
> +       ret =3D devm_add_action_or_reset(dev, mtk_hdmi_unregister_audio_d=
river,
> +                                      hdmi->audio_pdev);
> +       if (ret)
> +               return ret;
>
>         DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
>         return 0;
> --
> 2.48.1
>

