Return-Path: <linux-kernel+bounces-530363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3873A43286
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6B27A980A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F323CF58;
	Tue, 25 Feb 2025 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UXvjWldc"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D0101F2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447680; cv=none; b=YLE/AeCdS2r7qURwU1ZXMrWxv0FRu6c9C86DCqm3v1AsgkN98Di1lC1wQ8d45NqZFChsv2GtENnVx9gzQ20ACe95MG6dWzI+pSTrWUDQtfrmWGrVYJTuD+g500biYG49978/zBbCDI6ILgUu+htabBEG+o3jx9uT+OtCiSzXPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447680; c=relaxed/simple;
	bh=OcbScHMevtCpUQLP39MsdU6XISC+ts9KIshL7n45BFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNKKo52AzG8BhybZXGkeC6GJvu6lZzUx6CTUb6q7xWLYeAmughFr1ChxUaLkyOMV59E+9A2QeWZwGxPdvKogUe1qrYMekLDkt8XkFSEIhXLNmA4jGQG6XqFz3UMTviDJB292voCshSz3XxKUXA66gtWbWyoEI7xIhw93XI3EAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UXvjWldc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5454f00fc8dso4717664e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740447673; x=1741052473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4TOCMT9A63jLoOCD33qtnm1uXyI2TNmIj6w6+0Voco=;
        b=UXvjWldcssyUJySa3MBMpe2Yyh0Hwiq822snPrkrWuXpvECr/louHtobqT0c9UMakk
         JyEtR8Ahhb+DC7XXThxZyuoQSNmbcYRK5xBPSgVl4T6AeVs3VKucHTw/aG1oMS4CJ+TB
         z7+9oTg7CKE7H0WWSHkLsWoATvzlHPnhdpaHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740447673; x=1741052473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4TOCMT9A63jLoOCD33qtnm1uXyI2TNmIj6w6+0Voco=;
        b=FjVoeSIbFQdCa0Hel2W4FK60I66uBii5uq/fm/wWIe/1iMUSBH7mBbQuVWHe5X7u4p
         vDsYG+dDyHLCRCJM3ZX0MJADkGJZyn2q9TINDwB7N5K6hRATvhKvV9j2hUJ0wmNQT/w+
         PMk6uk8jj0Hz0oS8XhWeoWyaQw0i7Z9G2aYHG7anWWqhUUDr3AGZLnqA4psvQhe2IjA8
         FDXJQG/SQ8A4C3DAmVkJ89CXQJLiokbockDPHhP4vGz2Q5v8l7YQDJM+LH8ql1UwJtWA
         yYgxM2DgGuuSYBB98PhWaHlnMyp6dAJYlxxIlnywR1UZwuGJPLSj0toqPAf2n6hTjMc2
         D9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGXxagWiMr6+taPFy7KQHpbZF5NO57OyjwUBfMbybAeXmDvua4HK2QIZIxQ3SDsJrEyMuttC8qwiyP9lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv60fnBjioayevIBBm/u87hei9g2Fxv6muNDYkUaHvrYYA1fhC
	QBSE7/LcQamK+U6lzGc0ujFesnR6FKEPsIFAgsKdJqVw/e4/Zll55P1v6HWMptcnor4RJe9y6DA
	5ig==
X-Gm-Gg: ASbGncufVSxfK4+KVhQo4LLYeLK+d3BvC1reK9s4FGpExJLhGSzgj6MOaTK+hb38MCk
	OephgcxGZxGr9j+1Fy3z3Wk0Pyy7jnrxxqo1WA7Z73v7AAmgS3n43kA6mu3D9CkGawxv+aNX1lW
	SFoCpq4532WQIq+e9p4wDpvSB2LNoMBS6mlXe4X1JHIPBEmSk4gHRjEfAxDR87BWyqAAzT0ThF8
	yPRI0Jle8p3Q3fSe/bW8i9rkYqno4FRk/HgbF1nr0NvsXrrZFehugs2srJPXjJ5yB14Sv5sKlyJ
	VMtBcV98EWLCPK1zVGE0sg7vEqoZMtVdTNdq8zw6VwuShxhmUtZTKck/tbcB+zKQdQ==
X-Google-Smtp-Source: AGHT+IHcLvGHRn0CoCYf+f2d47W6C0IZ29gDzyvtzXP3c4nkBXlZbjKvPXN4eLrlf03633iYap7Jrg==
X-Received: by 2002:a05:6512:ac3:b0:545:f69:1d10 with SMTP id 2adb3069b0e04-54838ee1c94mr5432980e87.8.1740447672919;
        Mon, 24 Feb 2025 17:41:12 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f9e69sm46559e87.213.2025.02.24.17.41.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 17:41:07 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5452efeb87aso5087339e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:41:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVacjJQL2Nx3tTw7CzI4vseRFmNA3+SWINXZ2xOhijGr5Ko0pvHigo3km749v8QzJQvTY8DvmHW4G/rGfM=@vger.kernel.org
X-Received: by 2002:a05:6512:ac3:b0:545:f69:1d10 with SMTP id
 2adb3069b0e04-54838ee1c94mr5432801e87.8.1740447662279; Mon, 24 Feb 2025
 17:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081325.96724-1-damon.ding@rock-chips.com> <20250224081325.96724-5-damon.ding@rock-chips.com>
In-Reply-To: <20250224081325.96724-5-damon.ding@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Feb 2025 17:40:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X7iWOyAvdfRDyFA9kdr+utU_aAaJ5F7nAsaHp2fMQgVw@mail.gmail.com>
X-Gm-Features: AWEUYZlbdiIhJLMaGbE9FR34Ygo4r4AydhTgMaLe8qb8EcM7igmYbqK2w54Qn0U
Message-ID: <CAD=FV=X7iWOyAvdfRDyFA9kdr+utU_aAaJ5F7nAsaHp2fMQgVw@mail.gmail.com>
Subject: Re: [PATCH v7 04/15] drm/bridge: analogix_dp: Remove the unnecessary
 calls to clk_disable_unprepare() during probing
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	dmitry.baryshkov@linaro.org, sebastian.reichel@collabora.com, 
	cristian.ciocaltea@collabora.com, boris.brezillon@collabora.com, 
	l.stach@pengutronix.de, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 24, 2025 at 12:14=E2=80=AFAM Damon Ding <damon.ding@rock-chips.=
com> wrote:
>
> With the commit f37952339cc2 ("drm/bridge: analogix_dp: handle clock via
> runtime PM"), the PM operations can help enable/disable the clock. The
> err_disable_clk label and clk_disable_unprepare() operations are no
> longer necessary because the analogix_dp_resume() will not be called
> during probing.
>
> Fixes: f37952339cc2 ("drm/bridge: analogix_dp: handle clock via runtime P=
M")

When possible "Fixes" should be pushed to the start of your series so
it's obvious they have no dependencies when being picked to stable
kernels. That should be possible here.

> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../gpu/drm/bridge/analogix/analogix_dp_core.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index e23af674d91c..d9dafb038e7a 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1608,10 +1608,8 @@ analogix_dp_probe(struct device *dev, struct analo=
gix_dp_plat_data *plat_data)
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
>         dp->reg_base =3D devm_ioremap_resource(&pdev->dev, res);

There is a context conflict when I apply to drm-misc-next because of
commit 43c00fb1a518 ("drm/bridge: analogix_dp: Use
devm_platform_ioremap_resource()"). You probably should rebase and
re-apply.

Aside from the context conflict, this looks great to me:

Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

