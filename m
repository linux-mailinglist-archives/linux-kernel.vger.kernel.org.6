Return-Path: <linux-kernel+bounces-210191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282349040A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276E81C23D38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D438F82;
	Tue, 11 Jun 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O/14Jjj1"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE0E3BB25
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121494; cv=none; b=ScBir5l68KnxGphFVgBt5WjaCmqeOnAUJi8icjLXjV6YHhRgF821Uph5qoN2WbfOJftGDHTinrVXaD55d2nIJoAFdzAigpqZpVIRqz9LnpeD1j6mZjP2vJFlv74oQbT8RFKGRR/vqiTFsb2vHAZto+9QHOUT2mdsfNz02KMXNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121494; c=relaxed/simple;
	bh=xH4sWcDsNL+1ER5E0F7KclRTgYvfhffv+vy9dW8AOC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIT6Nz7mXhiLi27L2qWzUTF4EWIl08XyDyVrng0X3uHK6a+RNnBNrG3nCDw/ls5PmanEMomgy2EUD9gyUGJ/QFz5EZnoo65yn+JsXtBID2we4WYH7sug8RLGRzOQoaQC6iICXdngqqoiunhELqh76lLVs1OFIFxg45MJMZfIYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O/14Jjj1; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b06446f667so23402846d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718121486; x=1718726286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve/uaqN0JHEkOvnOM0N3RhTwkgm+3t8w6LalScKCEEE=;
        b=O/14Jjj1yP3yutzcpg3oZKgC2GagHowbqyEZdAZz2hhasgVasqewdPYsgwS0+xwAY4
         W/LD71S12t76wCyF70ABPR/GkuW4b0uH4kLILcDibOA7vXkywCnip7AWyelyEALpdZCG
         ziwXYougkZVhikOmuXZB3j8B8xBlPJxfmYqXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121486; x=1718726286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve/uaqN0JHEkOvnOM0N3RhTwkgm+3t8w6LalScKCEEE=;
        b=Z3j0vMSzgeFXNxmnGjsMQxUM7omJ3liX59F/8sRRB3ALZF1WMqVp0BMn7FBXqwoK8d
         9+9FOjE2nX6ji1GsY+zy+QjelJkcm25ReaUnPdfM5NthNdHPTC7OF3m20mP+o5QWta19
         KfI4NYkKnuXkv5PKguIXvIEruWe/oHKViVdK94wV1HDGmwveh8HFVCXR9BfpaOkpo3En
         ZyLiDxoBrravdVxDT7Eafi+gxhWd5YapccqD6BpGrtGvx1/gZSI4BWQu6t7yu24mehyc
         TV6LBhKkPXF+p4FS3kCfU5QLU7rercGy6BLItGX2bTDmx3VzV6ZBgbFu6iLYP6lpMDuX
         KK8A==
X-Forwarded-Encrypted: i=1; AJvYcCV1E1SkmNs8pvPvR4JvlxNpf5vrZvg/uMMferCJPOGhlVuNdiLvedJP6g/6LC0AEVFOcR6V6ntoX8MEMAvPoDTAxdlgmwGRwI9mmhsj
X-Gm-Message-State: AOJu0Yzb7SnVXfCdAGDmGQAsOk1FAeAfnjmX3GQ8m6ZxAPaN5vmpykCA
	Ws2u5/94jVqaM7pXuvNOSExpAMxmTt1oq2tyKM8geKoFwnU4jqugvOgAoZXylqypWiVPP68QYkI
	=
X-Google-Smtp-Source: AGHT+IFzY5TbMIM3+/d5jDOg1wvkDvPFknolWeXMJ0Co9kXNSC3NB+KKkZpuMttdJFSYE+6laziARg==
X-Received: by 2002:a05:6214:3388:b0:6b0:86ab:fe99 with SMTP id 6a1803df08f44-6b086ac0170mr41703806d6.8.1718121486114;
        Tue, 11 Jun 2024 08:58:06 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06ae2266bsm37221216d6.3.2024.06.11.08.58.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 08:58:05 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4400cc0dad1so540141cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:58:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqI0EFdjbhDQw0jUwOt68FY2ZUNCTxdbEn+cdundabHeqLC2OS8uAep3I1zWZbfQz2PlgxYGuCEfNsrMHGXxRBGIHP6f1ftZf3R0Ct
X-Received: by 2002:a05:622a:550d:b0:440:3996:84aa with SMTP id
 d75a77b69052e-44147988903mr3173161cf.15.1718121484095; Tue, 11 Jun 2024
 08:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3288287d-8344-4b37-a333-722cf12fef13@gmail.com>
In-Reply-To: <3288287d-8344-4b37-a333-722cf12fef13@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Jun 2024 08:57:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRuU=eh0HzbDCwFrr5h9s-rOdB5dbANAd-BmMhiHR6Ww@mail.gmail.com>
Message-ID: <CAD=FV=XRuU=eh0HzbDCwFrr5h9s-rOdB5dbANAd-BmMhiHR6Ww@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel : truly-nt35521: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 11, 2024 at 7:44=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introduce
> mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> sony tulip truly nt35521 panel.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>
> Changes in v2:
>     - Fix patch format
>     - Fix code style
>
> v1: https://lore.kernel.org/all/485eef24-ddad-466a-a89f-f9f226801bb7@gmai=
l.com/
>
> ---
>  .../panel/panel-sony-tulip-truly-nt35521.c    | 435 +++++++++---------
>  1 file changed, 209 insertions(+), 226 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c b/dri=
vers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> index 6d44970dccd9..5a050352c207 100644
> --- a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> +++ b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> @@ -44,248 +44,231 @@ static void truly_nt35521_reset(struct truly_nt3552=
1 *ctx)
>  static int truly_nt35521_on(struct truly_nt35521 *ctx)
>  {
>         struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
> +
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };

It's not a huge deal, but normally in the kernel all the variable
declarations are cuddled together. AKA no blank line between the
declaration of "dsi" and the declaration of "dsi_ctx". It would be
awesome if you could send a v3 fixing that. When you send v3, feel
free to add this above your own Signed-off-by:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...with that, the patch will probably sit on the mailing lists for a
week or two and then get applied. Neil may want to apply it, but if
he's busy I can do it too.

I believe you were planning on tackling some more of the panels. Since
you're still getting started sending patches, maybe keep it to a
smaller batch for now and send another 10 or so? Probably best to keep
it as one panel driver per patch.

-Doug

