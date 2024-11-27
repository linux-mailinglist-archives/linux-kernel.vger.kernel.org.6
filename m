Return-Path: <linux-kernel+bounces-423026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BCB9DA18A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E0D168179
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC181AD7;
	Wed, 27 Nov 2024 04:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d6H4XFUU"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672314F90
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732682596; cv=none; b=G0ZDiVmtGBPli8WCAGnqiptuH5YBGF8tAvBv1hRyDH60cENDaiTC1WwAtPekpASdWXn8HI1Qrt6C/xvOpShKBztOnq8UQwstSxwUlm9k+W8yHdxfPVuD7OZJwuAg3Q6SeGxtvPg5xuAPClTM1QeRM8SZoKHsCmfe76CP+twMQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732682596; c=relaxed/simple;
	bh=b0a9mbaAx6zBnaux2dFdVBPuuQxiQ0zP49OgKzFZRRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMStwCSjtI+rnDYQgRuGPNnqd66iuTJiZXXWaW6OwhieE24lL6RFy354OaCyzSLTE+Mu/0Fv6gCWV9E5TLJx6ivnMzJDro96hqWldtCv7sv4wkehFEUqRn9gJ2IulTJpwvK9cov07V7ge+BpVKN1chWSn4LGEBnAt9xrv5Ei47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d6H4XFUU; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f1d1068451so1462413eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 20:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732682593; x=1733287393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buIj9lD4l7EjMTWNqbbtXYSQ2Eo8RWol7XgFHIWEhAQ=;
        b=d6H4XFUUyPoqKF4kCp+wHDF7NA5T6GSzjisgasyCWkJGuPzgN7dOz4z7SzmS6EqjzZ
         EjlUdTAqawJ4NyD4UfmaeNaPAbWHcEC+MCb07RUbjFoSPqjN8YjBmNS7nmnL+3jJanNX
         KCdvz5YBM2bozxeTwl9rSzCCmXOgb7U9n3i+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732682593; x=1733287393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buIj9lD4l7EjMTWNqbbtXYSQ2Eo8RWol7XgFHIWEhAQ=;
        b=VDVHhhIrZNIaRKE1nNt5RnOcdpCHW2o9lgIU9o/+2DYGL7IwZvo4RyRCVhRE5OczW0
         rnnveT8Zi09+YlkX9Fk6JjcTw+hhtAvDBYVmYfP/1ElKFUs8R959Xql+W+UeyUo0re4n
         nKanmlIOyMzW+Pvlp5lKiLwORepYNr1Kx5nUmoZEZLbkfPLVEnuuCtqAHubZ9bMaAkfg
         X2NKFGwDEEiXc9j8kWqajIwMCBy58oskcOkQVB/OplN2/DqN8beK+9Z7xMLv+5T101Xj
         /wd0DyhQommzG8NPgQG9HfgFNYYnk3QgyPxIQ/pbazS/g8pPcG0P9QlAS3OY5GDABS1i
         SiXg==
X-Forwarded-Encrypted: i=1; AJvYcCUGYnA9cY4W53r/2Vi//XJeZw8lboEgDF1gr6l+HV3ggD9jl2jvaAkSqbGvFVwtE5lfcuQRVs1CpF5uCdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKi7C+vmmdBO2Lk1neD/PK1eVjpns3M+RKEVV4PfiB7YTnH1BP
	a4u+ErQZcGrEF1mhkxrVUWadPlt5Rdm288usy+1Wefkpggqa9c19UVkM2plJPUGmwxY/enNXV/a
	njy+3UIxMHFTu0s8wW+xkZYFiBF/MAF/QOyzP
X-Gm-Gg: ASbGncuJaGWuQu1lUUIzg53ks9jIErMHgbuQ3krtATywcjyES4U8yWcxZsFu89ehvR7
	2Jw96Drp1/I4OXEXMJaOnkD4gB6WkC2z7zdu7byaOV6UifVooR20TD8zEOQM=
X-Google-Smtp-Source: AGHT+IHzVwgmp24HNWYR9QgilyN0+vKnYnhsqeCOo3U9Uzr8ko0VEjMW3SCABnxFA+zY3W8ifSeKNUAKmHsycZau8KU=
X-Received: by 2002:a05:6808:3082:b0:3ea:5a0e:941c with SMTP id
 5614622812f47-3ea6dbc8cb9mr1709943b6e.10.1732682592979; Tue, 26 Nov 2024
 20:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127030221.1586352-1-xji@analogixsemi.com>
In-Reply-To: <20241127030221.1586352-1-xji@analogixsemi.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 27 Nov 2024 12:43:02 +0800
Message-ID: <CAEXTbpe=3mN-wCJGRVe7SSbzr5J=zFhWOF30jm5HH4cN_GyK_w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge:anx7625: Update HDCP status at atomic_disable()
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

On Wed, Nov 27, 2024 at 11:02=E2=80=AFAM Xin Ji <xji@analogixsemi.com> wrot=
e:
>
> Update HDCP content_protection to DRM_MODE_CONTENT_PROTECTION_UNDESIRED
> in bridge .atomic_disable().
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>

Tested-by: Pin-yen Lin <treapking@chromium.org>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 25 ++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index a2675b121fe4..a75f519ddcb8 100644
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
> @@ -2165,11 +2181,8 @@ static int anx7625_connector_atomic_check(struct a=
nx7625_data *ctx,
>                         dev_err(dev, "current CP is not ENABLED\n");
>                         return -EINVAL;
>                 }
> -               anx7625_hdcp_disable(ctx);
> -               ctx->hdcp_cp =3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> -               drm_hdcp_update_content_protection(ctx->connector,
> -                                                  ctx->hdcp_cp);
> -               dev_dbg(dev, "update CP to UNDESIRE\n");
> +
> +               anx7625_hdcp_disable_and_update_cp(ctx);
>         }
>
>         if (cp =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> @@ -2449,6 +2462,8 @@ static void anx7625_bridge_atomic_disable(struct dr=
m_bridge *bridge,
>
>         dev_dbg(dev, "drm atomic disable\n");
>
> +       anx7625_hdcp_disable_and_update_cp(ctx);
> +
>         ctx->connector =3D NULL;
>         anx7625_dp_stop(ctx);
>

