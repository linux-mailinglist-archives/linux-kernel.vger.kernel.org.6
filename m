Return-Path: <linux-kernel+bounces-230149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A8917918
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46915283CED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE9155C8D;
	Wed, 26 Jun 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V9wqZ/em"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562215381B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383857; cv=none; b=P6u6jpKxuFpKnChdSyXyw5MHZPHGKP9arDlvR1o+XBzyMyxsN7sPDBRZ82UOji5Qsnyx4MNHfHNjTyHvFdn6x4nLDozj9tT1vNqQh+xIiSk7TPAEpGPAEefcOgkNCg00coaSIKb82UInbVVp1xEis56GNewizoP1pqoXiLfV3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383857; c=relaxed/simple;
	bh=3m8X5lO7yi/DuByYDZYlJ+FTin1mHRWK1NmeV0ahpVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SY2DRdIcl6KKDYFyAy9Qnvs/A/zLGmGsnLSTnlXXMVSyep28Nj0gmrjf+F7U1NgJ6+UYUOilbCSqpfuEeLTN7v55SUmzWtcGiwx1o+MzYeNFnhk8198KNiDKpjfgY4ZYhJ/lybIuO8W0vjkUj+dKCiqVtg3mBcXVL2KRFxYJjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V9wqZ/em; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso5515093e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 23:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719383854; x=1719988654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCHdJxQ4oC2ts4y76NGgpAIUHQqpky7E3Iqo+x2BgZM=;
        b=V9wqZ/emjfrBHcqjor/9DaIwAypuZq00iNgdNOIDwABRnkMKxQm7JTdzQp5/pQaNzr
         r/Zf09iS7sFUtT159z7d5c+4Ra4BM7mYeKBNxXqI5xRG+c4+JoKe1f7yTlNd/Hd2NGPf
         Q0WO9JjMuddD0YDvBenvjr3MSV0eFBst+6qNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719383854; x=1719988654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCHdJxQ4oC2ts4y76NGgpAIUHQqpky7E3Iqo+x2BgZM=;
        b=HP2JQo9RhrkvfT+xHNksna04ZmUP/k7GYwx1NSQEwe0GhHWi3uQ9y3NhqGYJIUWVz0
         YHYhgjkG1tcnxq1q/kc7RqTVrTe2iXmnq0S6lBm+isOrYl8x5Hsc5X6gtE89LVXirdU9
         dq1inxWXI1dctE8OvAu+NOnz62R5fMTshzv+SCAueXdxQvTYZ2WI41qqbYsSLUp00nXj
         cDuft9vn3h6AtPaTB44aWmglkqianeUvWvtJPcRoZg5mof8Cr/OuQP20rpRiXezc0Ebr
         yGl/IaCjmvbWw1UAMDpJSUYEyvHYKhspmThXnmNI1pbKabGa+IKr1HY0uuOIkjajCo3l
         T0nA==
X-Forwarded-Encrypted: i=1; AJvYcCV1r77A1vAJIkV6hd7v9mCWO7O6lZNwlHqStbPcMZR+R8pMmJ3W/3UDyAWuO/JOCPcUuqsRSwn1w7YoFiSFhxZ5j6r8pu+HB+M3Qpgv
X-Gm-Message-State: AOJu0YyqOOnF8iWI2M0YsNsn6Hc9HdMndZ0YD4vCQIHHUkI6ntInq100
	d4Umaj2Dz2Ela2F4Q0VTp/+lLG4igPF+2WD+0TFaRoEodbJJJOaeuNrvZ3g5UrIMTYsp9R6QsWQ
	QwfPzULQrgHkb0nKWzjpZSsmrvp86P6rasFqz
X-Google-Smtp-Source: AGHT+IGXqfaK3Lp76aXfYjIzKpRey4MNxVqRhxxMs8nwcgXn/YAU0hTJQfa4vETDGz2L4s7B3bv6pwtt1mZk4jfCHBU=
X-Received: by 2002:a05:6512:39c8:b0:52c:e4cf:4f31 with SMTP id
 2adb3069b0e04-52ce4cf502dmr7041057e87.49.1719383853555; Tue, 25 Jun 2024
 23:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620054708.2230665-1-wenst@chromium.org> <CAAOTY_9tLUAcw+C5D78SNwrV6kHds7JhtAoFYFmxxfAH9vtkDQ@mail.gmail.com>
In-Reply-To: <CAAOTY_9tLUAcw+C5D78SNwrV6kHds7JhtAoFYFmxxfAH9vtkDQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 26 Jun 2024 14:37:22 +0800
Message-ID: <CAGXv+5FQaJFuouB4feS4KEK+KqSZaJ=en8d9700gkqpQLOBr5g@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION=y
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Thu, Jun 20, 2024 at 10:20=E2=80=AFPM Chun-Kuang Hu <chunkuang.hu@kernel=
.org> wrote:
>
> Hi, Chen-Yu:
>
> Chen-Yu Tsai <wenst@chromium.org> =E6=96=BC 2024=E5=B9=B46=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:47=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > With the recent switch from fbdev-generic to fbdev-dma, the driver now
> > requires the DRM GEM DMA helpers. This dependency is missing, and will
> > cause a link failure if fbdev emulation is enabled.
> >
> > Add the missing dependency.
>
> Acked-by: Chun-Kuang Hu <chunkuang.hu@mediatek.com>

Could you help merge this?

Thanks
ChenYu

> >
> > Fixes: 0992284b4fe4 ("drm/mediatek: Use fbdev-dma")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > The commit this patch fixes is in drm-misc-next. Ideally this patch
> > should be applied on top of it directly.
> >
> > CK, could you give your ack for it?
> >
> >  drivers/gpu/drm/mediatek/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediate=
k/Kconfig
> > index 96cbe020f493..d6449ebae838 100644
> > --- a/drivers/gpu/drm/mediatek/Kconfig
> > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > @@ -7,6 +7,7 @@ config DRM_MEDIATEK
> >         depends on HAVE_ARM_SMCCC
> >         depends on OF
> >         depends on MTK_MMSYS
> > +       select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION
> >         select DRM_KMS_HELPER
> >         select DRM_MIPI_DSI
> >         select DRM_PANEL
> > --
> > 2.45.2.741.gdbec12cfda-goog
> >

