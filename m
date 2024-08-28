Return-Path: <linux-kernel+bounces-305371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E20962DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071691C21464
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AAF1A4F0A;
	Wed, 28 Aug 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bg38+5Re"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27518A6DC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862746; cv=none; b=k/751xpT8l2Itb9qE0XBkBSP1SaHReq0V9QA47GaBGYeD26GF+bmsZaQzhX5TBsGly6zcmcYx9T5e4fP97dxVKY0X3qQRPN636499sYsMejqPrSbUm9pJSX6XTBFLS1McY4ojJibr+fDDirouFUaM1wfqvoF+d8PCN4/1suBn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862746; c=relaxed/simple;
	bh=uWvWzOnVOeRY4zcDAIf/+IYnKn3oT37EGDL1EAks1p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbcy8rv+J7/PP/KY13zLtWVf9R0SJTOSE1Av09WOLwm32uqwSP7SHl02GbWBejZhvediAs5Ts9Ww+f7rSmsUJUUvWRWCqcu4saPd2bVhIyoyOQLDcL9NZuFq8xyluKgzkB5oR6r9RC7BObL+aPTFqZWyjzLOy5U0BN6wtvi8xlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bg38+5Re; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c32e1c263aso11541336d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724862741; x=1725467541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBATEptSZDUUWTJwD0sPaxEB2eHiFYhFMYSfyB0C/nI=;
        b=bg38+5RelLC2bQoj2/RVVC/LOpYaCteOhyH6hB2IuW4rFA3mU+Y8wdmIX7iPcfbHuP
         bZyptNTwP1XDMzlg+4m027yxDFn6xf5E6sRIJ/tOmipWWmn2FGTDA45NFD8Q147Qk7Xh
         LLmVWBpAKOoYi94Y83MRzNSsFrH1kCHO32ZeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724862741; x=1725467541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBATEptSZDUUWTJwD0sPaxEB2eHiFYhFMYSfyB0C/nI=;
        b=nwObWdLvFPc0c6MWZWfIbk79k1q8v3kO3vA3bYUCYBXAAbJJRQ1tEY2Y0gUFz9u+qE
         LlRi/Vq5+cOKItQRsWq8i8sIGP5/nANTwKbu4COMRtDc1c4F+EvXZgeQaApJjOaLbWDi
         TE/77tWXYqrGoZcwczQYzViEzR9FRuCVR+XbnEaaEEZMQCW7xXiJBiwlS7ION24wiVyU
         /sj9jGVYoZxB6jJtYXni0bZL3oIGH9P8EletDJSCNqJjNwCuyGL2jXTvjOnm0uVvWBL0
         KVQ5I4no6zNb2GvnNikce3olp76y9tMC85u0PJDsJS97P9BAoc+AyUVDocWyFhfFhxFz
         Ec/g==
X-Forwarded-Encrypted: i=1; AJvYcCV1OQ5UZZS8zCAXI8m9lffbjKhDNQnJqh/Zbt327pmKeU/xlRPo6eZ1S5ohxWI6rC2NX1CQOMOaSQV4woA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8y15bzOS6ft7FAtUaqXluGPM8kzkxVY7uAiDefekuuM5mIwIx
	yqJIpBvQDJW/o+F+DtTtXOQD9M5w6uXNTVeqFsM8wR2PhHbY7VBL5oI5J9DBgwM8Rtbb50delMg
	=
X-Google-Smtp-Source: AGHT+IGN2XjgCJGV8/1tOcW+vkWjLz8aV+6ZX7a22b6I5YGv1amX40XPC0KPfDcXicx51QlpXPipZQ==
X-Received: by 2002:a05:6214:2b9e:b0:6bf:7fe9:b2e with SMTP id 6a1803df08f44-6c33e630b19mr350096d6.11.1724862741473;
        Wed, 28 Aug 2024 09:32:21 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d49e1asm66803136d6.34.2024.08.28.09.32.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 09:32:20 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf89e59ff8so36131476d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:32:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWjDu0jxqz3klN4tlYar5SHn+x8ags3/yjcPNeOMtaNcTWyBZ7sqKNzsqIjrK4fpGyMDL1eMgbYjnafac=@vger.kernel.org
X-Received: by 2002:a05:6214:5b0a:b0:6c1:5544:47a1 with SMTP id
 6a1803df08f44-6c33e630dafmr301836d6.7.1724862739672; Wed, 28 Aug 2024
 09:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-0-0cae20d4c55d@linaro.org>
 <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-1-0cae20d4c55d@linaro.org>
In-Reply-To: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-1-0cae20d4c55d@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Aug 2024 09:32:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wke51vmTy7zZ+RV7oDoCGSeszOarhLGapdDrkByNyi-g@mail.gmail.com>
Message-ID: <CAD=FV=Wke51vmTy7zZ+RV7oDoCGSeszOarhLGapdDrkByNyi-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel: visionox-vtdr6130: switch to mipi_dsi
 wrapped functions
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 28, 2024 at 9:03=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Make usage of the new _multi() mipi_dsi functions instead of the
> deprecated macros, improving error handling and printing.
>
> bloat-o-meter gives a 12% gain on arm64:
> Function                                     old     new   delta
> visionox_vtdr6130_unprepare                  208     204      -4
> visionox_vtdr6130_prepare                   1192     896    -296
> Total: Before=3D2348, After=3D2048, chg -12.78%
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 186 +++++++++++-------=
------
>  1 file changed, 82 insertions(+), 104 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gp=
u/drm/panel/panel-visionox-vtdr6130.c
> index 540099253e1b..ebe92871dbb6 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> @@ -40,120 +40,103 @@ static void visionox_vtdr6130_reset(struct visionox=
_vtdr6130 *ctx)
>  static int visionox_vtdr6130_on(struct visionox_vtdr6130 *ctx)
>  {
>         struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>
>         dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;

This isn't something you introduced in your patch, but I wonder if we
should avoid setting the "MIPI_DSI_MODE_LPM" bit when the function
returns an error?

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

