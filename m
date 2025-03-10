Return-Path: <linux-kernel+bounces-553825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF6A58F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB92F7A3943
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4E224896;
	Mon, 10 Mar 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnoOy0Gx"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDE2248BA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598408; cv=none; b=JPaiwh2f9NNetM+PvuHmQF4461Of+e3Tyub/WuwCVcu7Y5NkCIfKj3Kz2gjgVKiCh3ZCP2i3w9jl2G1ruhzBaSjRFo+TGMEKV9fwoLjO/CxegSKMPznTma0fwgO5USqBGLRqhM8t4zwW529uPxbEkPVHmCQyZVBwy8IOcVB5dxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598408; c=relaxed/simple;
	bh=3dj4UCzU5cgMBuw4S2090VmT6y3s+cP8+5w6v6zwuDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mz1SYHgJhR4fJhc2Rh8fF+a9Ncn6e+B6yozGlKZqr2afKxbu6U3Fp4tuOfTpPl30dHgZDbQ/6hq2ag6Ser+ELr6pCq7MmcFt0R+NA5fvM6mOfUV2rma4mYmSKHdKPQh/CsYG5oGZPswL+6YvIFReg+xx2kC7syGR3A/cmwx69Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnoOy0Gx; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f9a7cbc8f1so55553b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741598404; x=1742203204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx58Q4P7N7gbyHphpDmZNJaiTyIEMGGfUPF1jF1bXfg=;
        b=YnoOy0Gx7uleQ2w58syAO4qVwtIpkAvSzMdvzj1aXS4kJ1AamZK3cdWIED0byXqT8g
         7JkluQ51ihT08qwEVNczZn/f91v8j3x3aCafr2CJjvKure4i8/PoTkyLf6lqlwqe4TDR
         7f4uMxnA8hkFpSW3UuLR+jBpBY6ukFrtZXNoWaZj/Us6Lf4Oz9neHOFygdwp+kY2BCov
         cjlZ3sTZyr6zoJCX7uayPOHs15JKS7WhLitjTJiv9QWXTGsWCfq0pv/h1XuwjKg/lem9
         ZhUU5YIUMxT5xQQKdVGJD6aWySTKmpi+C53LofuX0CruYPL/gfH58/jF/QJXnNAKSiAQ
         AvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598404; x=1742203204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx58Q4P7N7gbyHphpDmZNJaiTyIEMGGfUPF1jF1bXfg=;
        b=mjlS/PBI6LyeNkwYE6jOD108TSGfyrZgQGTsBnd0DWSakT3xSP3TS2/BdCjdwKD5x/
         ZOsPGtmyyp4QYIM3bvPnakyxWjKp0bmsi46SGMQtOoEsnCJ70CnLt4p8FojxMVO5nF0g
         1BCxQZ9okNihOZIxZMtt8MPxyw6LWCtHl8urXOWlmy7g6S4vA4MzyABSW6DHr8bTMEFy
         4WZ+VTK42X35z0WGHDNkjv/FWdfyzr7HwZuEjJFGJZuJu0lJIrcjBN6eDRRU12JYEaUt
         sjJf1Fdmh0cG8CMlo2DTQn+YBl80DtsywvaXFN3kHU6VvI7MPWYWEyxYSfd6uiMAho+H
         Ig0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVf29L8Fx0i3WJQCFwjsEql48nSm9hJv9l+ijFzS9WzKJkgjfVIUrswvJoeXrXqzpSkg4WgtUM/Bd1atZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5mNTHispJmP5+7VdoN2alSlu7b0ER4ug5Cl5QaU5TZq4kZof
	4JRCJ2MFtX0kR9S4jyaF2Q0/OMSk7V+91tAMysE09WCJ+9/pcDlgLkzgMvSxQTCyDGCErqBuX45
	/EeRmubnqy1D3tuzHqS1/i3xPZlw=
X-Gm-Gg: ASbGncuJYE8lPTqFuHXqUjVccU5P8TU3p9/uBhsUzwzrXMXMMN0bGwxYheeyDo/vYBc
	ZYLYzjB3P0of8A8rcgCVJV95PCLfFsAZ+Okx04a//uK55D16D8LaVFgghh/bNjI35F8/YZTC6T+
	QDe1Hoz/dY/5+tqxnZwe31Xc06
X-Google-Smtp-Source: AGHT+IFHmB/cu7w8l+SlHdsxgg/iICDetyzer8cW/fdk/a10EwAdxJNsooT7jc7tZ/VrIsnPoRFxTlKB2Y5Rk0lHJpY=
X-Received: by 2002:a05:6808:1315:b0:3f6:a9ea:eab3 with SMTP id
 5614622812f47-3f6a9eaecc2mr3340392b6e.5.1741598404388; Mon, 10 Mar 2025
 02:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308234356.255114-1-linux@treblig.org>
In-Reply-To: <20250308234356.255114-1-linux@treblig.org>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 10 Mar 2025 10:19:53 +0100
X-Gm-Features: AQ5f1JqKcgKl52x22Rs8Hce1oSaBk2HDLSNfOMs5GSxFr_gJm67cqX5SgZwvVao
Message-ID: <CAMeQTsbq7Gz=fqnAGPcLobt3P+vFKTYWfY8+gUcPKYqDKx_R=w@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500/psb_intel_modes: Remove unused psb_intel_ddc_probe
To: linux@treblig.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 12:44=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> psb_intel_ddc_probe() was added in 2011 by
> commit 89c78134cc54 ("gma500: Add Poulsbo support")
> but has remained unused (probably because drm_get_edid is used
> instead).
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied to drm-misc-next
Thanks

> ---
>  drivers/gpu/drm/gma500/psb_intel_drv.h   |  1 -
>  drivers/gpu/drm/gma500/psb_intel_modes.c | 31 ------------------------
>  2 files changed, 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma=
500/psb_intel_drv.h
> index 2499fd6a80c9..d80f2d0b712e 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_drv.h
> +++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
> @@ -182,7 +182,6 @@ struct gma_i2c_chan *gma_i2c_create(struct drm_device=
 *dev, const u32 reg,
>  void gma_i2c_destroy(struct gma_i2c_chan *chan);
>  int psb_intel_ddc_get_modes(struct drm_connector *connector,
>                             struct i2c_adapter *adapter);
> -extern bool psb_intel_ddc_probe(struct i2c_adapter *adapter);
>
>  extern void psb_intel_crtc_init(struct drm_device *dev, int pipe,
>                             struct psb_intel_mode_device *mode_dev);
> diff --git a/drivers/gpu/drm/gma500/psb_intel_modes.c b/drivers/gpu/drm/g=
ma500/psb_intel_modes.c
> index 8be0ec340de5..45b10f30a2a9 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_modes.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_modes.c
> @@ -11,37 +11,6 @@
>
>  #include "psb_intel_drv.h"
>
> -/**
> - * psb_intel_ddc_probe
> - * @adapter:   Associated I2C adaptor
> - */
> -bool psb_intel_ddc_probe(struct i2c_adapter *adapter)
> -{
> -       u8 out_buf[] =3D { 0x0, 0x0 };
> -       u8 buf[2];
> -       int ret;
> -       struct i2c_msg msgs[] =3D {
> -               {
> -                .addr =3D 0x50,
> -                .flags =3D 0,
> -                .len =3D 1,
> -                .buf =3D out_buf,
> -                },
> -               {
> -                .addr =3D 0x50,
> -                .flags =3D I2C_M_RD,
> -                .len =3D 1,
> -                .buf =3D buf,
> -                }
> -       };
> -
> -       ret =3D i2c_transfer(adapter, msgs, 2);
> -       if (ret =3D=3D 2)
> -               return true;
> -
> -       return false;
> -}
> -
>  /**
>   * psb_intel_ddc_get_modes - get modelist from monitor
>   * @connector: DRM connector device to use
> --
> 2.48.1
>

