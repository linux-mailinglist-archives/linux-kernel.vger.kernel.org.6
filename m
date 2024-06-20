Return-Path: <linux-kernel+bounces-222310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20990FF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F822816FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAC819B3F6;
	Thu, 20 Jun 2024 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZoeORcB"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4F19B3E1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873412; cv=none; b=bvDseFLz6DcQ/5LyeZ5BUjOAZmhamXSU+kx9MpkgAMuUmyuYSAAhyyCjFcdIWjs+7iuseYLnUwl3d1EYZ+eTX20EEWxTNX2Z2LJNKKXIIGHHcaRwdcPwrrRbbS/qxj/lkj3FuSyUPneyvhWZ2B1MwCRepDvqrDPFsKaBL7MZQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873412; c=relaxed/simple;
	bh=QKjfRE/UdgFLDzTlyARsWElVc22hgqS+LVFD8o/b46E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNv39xLPx1OIMaEUA6SUNPsKyfr+0BoPpFs6dl97uwvdrPm/Dbzyp2HhzhU43+jp+EKD8fOOS4tmjIwQ+i4SmOzsot372FPUzxvgTkinetnlJvOR8nES9PbfRKW8byn8webPeqcES78qxuBf7mKxli3WQV1cc9sZpabSwKgw6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VZoeORcB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e724bc466fso6599111fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718873409; x=1719478209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oRTqaQV+LstrjwZixpKFYUALXmKtaF0Ow0RUXHlll0=;
        b=VZoeORcBkOmWasPmbaocQNuKvtQyySfewfFLKuNYG1aZMgvWbGnwUYHWDtv7zqmmma
         ET9ITRfqnyx7l6jEXnY9cgoarQEZH2tonfLY2vsgkB7p1EsenRMgTZ9RSdtdZVyLM9WS
         q2aOkr3XEL0neF3EBi685O+2Yz7HoyheWEXaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873409; x=1719478209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oRTqaQV+LstrjwZixpKFYUALXmKtaF0Ow0RUXHlll0=;
        b=B4JtsC0jyjzAToFP/YNrSfmKzoveoI0ndzrA/uupZVVxCrJ8h54PCcuc/HJam/NlN9
         1LyCddXo76mJAEV5Np18+J4peaO90bHfAfK7OTom7+0oDtsZlWLLR94EyvLfE5mX47up
         EirIl8QNaWcuD1HHGXelom/VIC4kPDVfZXU/J9FCsoTkft3ItfIYlN5KHwxYs7IF0O4i
         X2skm6FcaW2dkL52HshOHxh9AxrEIQkXhznSZpjEpOdob3onm8W+xQcO79yaW22xC5at
         jsNCgMRIlcJXP7Ustd/aHfftvVA+nTWFjYYIePa6uvbRQpCmlGHsMhrBWXP68GkXJ/Uv
         a+Og==
X-Forwarded-Encrypted: i=1; AJvYcCUBtf+/qWauncY7/FkwRNmDIHTcyY9/+ejlsMR0LTBD+J/ieBcy+piM41sZp2yRmz8RiAyryrpwUkfbcvnt+ukM6SyggHxbra1VSrtv
X-Gm-Message-State: AOJu0YyyGF0gG+2t3klm+qNiWLuLTbUEKzCnnh9Bozm/QobbF0z45N+W
	pRZSVb6UZLyVzYQ+W63+zseygUJWzuIH35+iKD2hLeLGw+zyL8cuX92puC4oi1SSIqKDPcy9uIp
	K70o8uQNY2Dc7togs//5uooSbWXlnMti5Oo1p
X-Google-Smtp-Source: AGHT+IHcXpqJLWmBKdXeI91LoMKrVXewns1BNu07e4js70I9FeW6r0+Qp26QuOLQHYvE8hHnxAzWJBo7v4Fc1y9Nr0o=
X-Received: by 2002:a2e:2416:0:b0:2eb:e137:6584 with SMTP id
 38308e7fff4ca-2ec3ce940bamr36303391fa.20.1718873408841; Thu, 20 Jun 2024
 01:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620054708.2230665-1-wenst@chromium.org> <743577a0-ef60-4731-8901-daf1ae4f7f7f@suse.de>
In-Reply-To: <743577a0-ef60-4731-8901-daf1ae4f7f7f@suse.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 20 Jun 2024 16:49:57 +0800
Message-ID: <CAGXv+5G8sC0JAWg_1k-x6+XeqMSMHQDuHfhOJkJYe1OzHkdH-g@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION=y
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:37=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 20.06.24 um 07:47 schrieb Chen-Yu Tsai:
> > With the recent switch from fbdev-generic to fbdev-dma, the driver now
> > requires the DRM GEM DMA helpers. This dependency is missing, and will
> > cause a link failure if fbdev emulation is enabled.
> >
> > Add the missing dependency.
> >
> > Fixes: 0992284b4fe4 ("drm/mediatek: Use fbdev-dma")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Apart from this problem, would it make sense to convert the driver's
> management to GEM's DMA helpers? It appears there's some code
> duplication in mtk_gem.c and these helpers.

It seems at least import_sg_table could be converted. I don't have
the bandwidth to do a more in-depth review though.

Thanks
ChenYu


> Best regards
> Thomas
>
> > ---
> > The commit this patch fixes is in drm-misc-next. Ideally this patch
> > should be applied on top of it directly.
> >
> > CK, could you give your ack for it?
> >
> >   drivers/gpu/drm/mediatek/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediate=
k/Kconfig
> > index 96cbe020f493..d6449ebae838 100644
> > --- a/drivers/gpu/drm/mediatek/Kconfig
> > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > @@ -7,6 +7,7 @@ config DRM_MEDIATEK
> >       depends on HAVE_ARM_SMCCC
> >       depends on OF
> >       depends on MTK_MMSYS
> > +     select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION
> >       select DRM_KMS_HELPER
> >       select DRM_MIPI_DSI
> >       select DRM_PANEL
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>

