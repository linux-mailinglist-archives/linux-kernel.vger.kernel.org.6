Return-Path: <linux-kernel+bounces-442681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E59EE03F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BFE166A21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2820B7F7;
	Thu, 12 Dec 2024 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kk+9TPQr"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8020B1FF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733988579; cv=none; b=IZRcxJcv+3LoRDrFl0PyeV2P2omil8EsD0ECh6KzHq9kMwpHnsKoJvhM53LIvgwsXhIpuGRGBaN231kdw0tHK6q/5SjlavRuFWswQrxIhGWQjw+29kGrwNsXossRo1eB/ENxPwdMjDQGgVbb4Qzybo1Z6W2r9RlbVPTZlb26bIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733988579; c=relaxed/simple;
	bh=etcohdZi/fyZ2O7SjGaJsa+Y/8oHTZlOiVTv2NEoqhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWlpDf4+OX4lO2NAj66/Qi0a2uk07PB+asEoBvVYkADSEngcS60cy6yHdnWs14O1iurgXX2yuNrA2elHyLGECMMjeEA5GzVkwrOx1A8jYuLjgVVkcl93fj9TI6PhWSC3gAx+SVNi3Mg2Lu5tnBIwHxvujdy4AO/lFC4kpreHRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kk+9TPQr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso1510640e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733988576; x=1734593376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUsFBs9SgSTwKf+euhdAY/mle8iwODWJW4g1nHNMk9c=;
        b=Kk+9TPQr5DB51FJc/RnESwXPCoCOtrlM6KImHsVcmCWiSp2woNMxU/b3/d7wl2f+SC
         KftVP5b7vqGI7FgLH06bhe9Co5FGbKJN2Sb84l12JeHkKOxodZpDi12WqGAjDIab3Wnv
         l/R1VsU7RnMmfLw5axNoVWJqMUPYwRA9fueNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733988576; x=1734593376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUsFBs9SgSTwKf+euhdAY/mle8iwODWJW4g1nHNMk9c=;
        b=Bq5t7execRIv+PAEQbti6Xc1/3N+KKGsEImyev3WsPJJ6UpiVrjVJA5HHUtMeRaOJa
         lipjJXFUwspSRGxb0w5LaOnYVZmFSrQI0hKN9uyRH1lSHVnhRao3svcA8i3B8E7XBvPD
         2bR1h1YVHppIOJYFxFSSXNalWAg0WRHztwT9U04XXfXhyjdF25TvaD51cPPtgf6+aeJR
         qGVIOn0tqXDcYOEqpxqhhpvFt3IR5u5okDTfiD5BXXYouwRJz69iwCd2KgLBS2buuW+k
         JKJUda0x8x42cFm4OUwObGJELliUR6hg6Aw1GV1dCBrTyfy5D1SWuuCN7CfJzSYKTbmW
         oA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoYyj9ZQMnCzDiMn9sEmIxzkt7AewOeK8Kwz2rW0TPSljC9aOCNo1VF9iWs5RfS4PUGAn1GEkBcm+zta4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7xUDpmpKGgMZ3ROaBTp/hCo8rPMpP+NcA5Q6AQ57jskuQsWH
	iguiZfExgEbMaThnJBYddSXURuY27PL7tAtAgagdozksaCwB4BXyGyeVeYNUzJnyCKzw4tTT77T
	udaslNWwnv6LTzhB/g7E0gMjkFUhXOzBOHXXm
X-Gm-Gg: ASbGncuKikpC2IzEhEAC+oa6b/d6tP9URb3DJFjNGJyBLx1gAVwYjjiS9PcGnWKG55N
	KeFmMtxViOItiKuVdoCDMlN81fefyC+hRilE5r8CUaM5wPi/2z4ZAnEKEUhXbp5FUbg==
X-Google-Smtp-Source: AGHT+IGUfV18odEMnZdd40vklSttluOoWFDdHf+m8pFREqeQLEQ0rE9DZYkQWg+goJ0kE03UC7Ud2rvX2aZz+ThhYWA=
X-Received: by 2002:a05:6512:3d8a:b0:540:2add:c1f1 with SMTP id
 2adb3069b0e04-54032d5611dmr89184e87.18.1733988576033; Wed, 11 Dec 2024
 23:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212055110.1862487-1-xji@analogixsemi.com>
In-Reply-To: <20241212055110.1862487-1-xji@analogixsemi.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 12 Dec 2024 15:29:25 +0800
Message-ID: <CAGXv+5FDTqGhE3kZ=b5Mkp4gzuKtMfcdG_63MewDGvJEb-QyaQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at atomic_enable()
To: Xin Ji <xji@analogixsemi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	bliang@analogixsemi.com, qwen@analogixsemi.com, treapking@google.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:51=E2=80=AFPM Xin Ji <xji@analogixsemi.com> wrote=
:
>
> When user enabled HDCP feature, userspace will set HDCP content
> to DRM_MODE_CONTENT_PROTECTION_DESIRED. Next, anx7625 will update
> HDCP content to DRM_MODE_CONTENT_PROTECTION_ENABLED if down stream
> support HDCP feature.
>
> However once HDCP content turn to DRM_MODE_CONTENT_PROTECTION_ENABLED
> userspace will not update the HDCP content to
> DRM_MODE_CONTENT_PROTECTION_UNDESIRED until monitor disconnect.
>
> So, anx7625 driver move hdcp content value checking from bridge
> interface .atomic_check() to .atomic_enable(), then update hdcp content
> according from currently HDCP status. And also disabled HDCP in bridge
> interface .atomic_disable().
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---

No need to resend, but please provide a changelog under the "---" line
so reviewers know what you changed in this new version.

>  drivers/gpu/drm/bridge/analogix/anx7625.c | 74 ++++++++++++++---------
>  1 file changed, 46 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index a2675b121fe4..f96ce5665e8d 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct anx7625_data =
*ctx)
>                                  TX_HDCP_CTRL0, ~HARD_AUTH_EN & 0xFF);
>  }
>
> +static void anx7625_hdcp_disable_and_update_cp(struct anx7625_data *ctx)
> +{
> +       struct device *dev =3D ctx->dev;
> +
> +       if (!ctx->connector)
> +               return;
> +
> +       anx7625_hdcp_disable(ctx);
> +
> +       ctx->hdcp_cp =3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> +       drm_hdcp_update_content_protection(ctx->connector,
> +                                          ctx->hdcp_cp);
> +
> +       dev_dbg(dev, "update CP to UNDESIRE\n");
> +}
> +
>  static int anx7625_hdcp_enable(struct anx7625_data *ctx)
>  {
>         u8 bcap;
> @@ -2149,34 +2165,6 @@ static int anx7625_connector_atomic_check(struct a=
nx7625_data *ctx,
>         if (cp =3D=3D ctx->hdcp_cp)
>                 return 0;
>
> -       if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> -               if (ctx->dp_en) {
> -                       dev_dbg(dev, "enable HDCP\n");
> -                       anx7625_hdcp_enable(ctx);
> -
> -                       queue_delayed_work(ctx->hdcp_workqueue,
> -                                          &ctx->hdcp_work,
> -                                          msecs_to_jiffies(2000));
> -               }
> -       }
> -
> -       if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> -               if (ctx->hdcp_cp !=3D DRM_MODE_CONTENT_PROTECTION_ENABLED=
) {
> -                       dev_err(dev, "current CP is not ENABLED\n");
> -                       return -EINVAL;
> -               }
> -               anx7625_hdcp_disable(ctx);
> -               ctx->hdcp_cp =3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> -               drm_hdcp_update_content_protection(ctx->connector,
> -                                                  ctx->hdcp_cp);
> -               dev_dbg(dev, "update CP to UNDESIRE\n");
> -       }
> -
> -       if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> -               dev_err(dev, "Userspace illegal set to PROTECTION ENABLE\=
n");
> -               return -EINVAL;
> -       }
> -
>         return 0;
>  }
>
> @@ -2425,6 +2413,8 @@ static void anx7625_bridge_atomic_enable(struct drm=
_bridge *bridge,
>         struct anx7625_data *ctx =3D bridge_to_anx7625(bridge);
>         struct device *dev =3D ctx->dev;
>         struct drm_connector *connector;
> +       struct drm_connector_state *conn_state;
> +       int cp;
>
>         dev_dbg(dev, "drm atomic enable\n");
>
> @@ -2439,6 +2429,32 @@ static void anx7625_bridge_atomic_enable(struct dr=
m_bridge *bridge,
>         _anx7625_hpd_polling(ctx, 5000 * 100);
>
>         anx7625_dp_start(ctx);
> +
> +       conn_state =3D drm_atomic_get_new_connector_state(state->base.sta=
te, connector);
> +
> +       if (WARN_ON(!conn_state))
> +               return;
> +
> +       cp =3D conn_state->content_protection;
> +       if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> +               if (ctx->dp_en) {
> +                       dev_dbg(dev, "enable HDCP\n");
> +                       anx7625_hdcp_enable(ctx);
> +
> +                       queue_delayed_work(ctx->hdcp_workqueue,
> +                                          &ctx->hdcp_work,
> +                                          msecs_to_jiffies(2000));
> +               }
> +       }
> +
> +       if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> +               if (ctx->hdcp_cp !=3D DRM_MODE_CONTENT_PROTECTION_ENABLED=
) {
> +                       dev_err(dev, "current CP is not ENABLED\n");
> +                       return;
> +               }
> +
> +               anx7625_hdcp_disable_and_update_cp(ctx);
> +       }
>  }
>
>  static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
> @@ -2449,6 +2465,8 @@ static void anx7625_bridge_atomic_disable(struct dr=
m_bridge *bridge,
>
>         dev_dbg(dev, "drm atomic disable\n");
>
> +       anx7625_hdcp_disable_and_update_cp(ctx);
> +
>         ctx->connector =3D NULL;
>         anx7625_dp_stop(ctx);
>
> --
> 2.25.1
>

