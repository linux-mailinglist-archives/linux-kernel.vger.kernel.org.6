Return-Path: <linux-kernel+bounces-416409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D49D445B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8831F21FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F281B5337;
	Wed, 20 Nov 2024 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a4ud0Eqd"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2A627447
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144706; cv=none; b=g39um9yY+2djfJeStQSdjpvvczw8QI0mVG8b+XufyScxWf3Ru12LLrCmFyrSFilXCHDO2d/pGpsZsu/K3UQPQaAoCLk2Da81TCQtcWDucEiJQHyOJdZVS/dnrm6dg0BhRR6kmOdWfDuEtRYhUzLCpDwDe8MFKmkpl6dfptYSbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144706; c=relaxed/simple;
	bh=DepY0erriSZwBVNkVSrEEuXyb85a2Qm51ZwsZJ0A0+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjD4ox2LpYQGjgIoxLgil6UvnZ4G+vHsOEiK2P/UQk1wH3NVV8E8qHhxQ0OgW7K3HFMn/BcRd1zfAmTM8/xmFthgHl1YEdcVsfqZkirm7nMejzdUIxZLC44vITGFlizXbx9SoNCxspeOrheUziXJp8fjPctF4dQx5cTVU7DlHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a4ud0Eqd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so3268831fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732144701; x=1732749501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk9xg8NxsXbSQYsTpmZ0ltyqprizEJtz7wq8qhfk4DE=;
        b=a4ud0EqdwSbThY2dQTWmVTTMiklKYbZcDcg/f5gYfMUzMWqe6cOrPLJztceYuI+3U8
         lVbUsb/BY16QnFq/O3uyuCCce83msD6xEAjlgHNszQmp77YykWj+rqM7/j7ZfGSrF8XS
         twa2Irp5DoztiTq+srvb2UgL3vRn1vM/dJ9ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144701; x=1732749501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk9xg8NxsXbSQYsTpmZ0ltyqprizEJtz7wq8qhfk4DE=;
        b=H3Svwd/cuE2thD3PPE6pmAgK4+trtvb5onW9cpRkoXpxFluPKpXAR+aSCV7bp9FPZ9
         NhTWjeNek76maD6SOE1n0lz8eXlSk57qf46kIprNSWs+SNgg1FkmuTMckpvPcc0d5baW
         g/EOGFtVU/d53z1xFjFrxUM14Q6W0LZWLega0mWcoAN7nLg3t/OrwXmK7VYSjIrOI0RX
         nMgQb+IXIjrcGogfbdeB5sspuk3lOlW1iEhdv5L/eEH4lrzuml6Z9qpdG3eiggN2HcRD
         Puj2gjqsXW2ra1B9CjHmtFhiXj1Qma8cO6CVCUBQZqbeg9oRkalAaCxokPEIaEreBDVe
         GULg==
X-Forwarded-Encrypted: i=1; AJvYcCUJs7XNFaLqGpNvkz/tDYiiCQZzemhnbSPw5yXihmumtgrDqFOZ8wdQ6Myb8ymdGtdMEfYrVHVxhaDMUaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0/zcR3ojKtb3NVJL+CL9sv+88+kAFeM+t0Yk44j9zCheKc17
	0pGSOtC1icCAX4qgLtDsVA7PbiF2frBGGxBrrJ6VV7WMU9Wgv2MzX/647JXoRzbuJMPuNaLpScT
	2uQ==
X-Gm-Gg: ASbGncvSexFWlMYxYHaWwfxFUG2rXvqeKlR4gAfRrFFjjLgMvFtSEDgO370ubsl2t3r
	S7Qnt1z/p6Dd7pOqRc0+z8tMa0HbGIE1lcRT8IdjrIXl686IRrtlSMLVysZshGFcCMdU1nnkcUi
	koqWzeGxYqGRpZ5loJ/tj754okEznVzkVyN4dL69uxaaA4Ebp8RS7Gn9tNGuojHgVbkTIn+pTgI
	GZBih1bukzfBSS4UL/iqTwgTSWIi3qhZMghqLPv7b7pjXzrOxM3rQhO972g7lcFeClYsBCMH/2M
	ADEPdkMi5opiGA==
X-Google-Smtp-Source: AGHT+IFaaNxj4YiGwONeGRVV7JM1+mKI6bDq08745kcbw1mibO695aGhE2eZzCymJQrO/RaPvfougg==
X-Received: by 2002:a2e:bd0f:0:b0:2ff:5d9b:52e1 with SMTP id 38308e7fff4ca-2ff8dca0b5bmr30497701fa.34.1732144701554;
        Wed, 20 Nov 2024 15:18:21 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69ae80afsm16663041fa.76.2024.11.20.15.18.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:18:20 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e8607c2aso265076e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:18:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWgzgJe9WFKGAHc00XIAajWlcvP7nO1P56MyzP8K1uLU8lAJWa2wvdg30BMxZoUaFoKF3gY1oUq2oGuXw=@vger.kernel.org
X-Received: by 2002:a05:6512:2347:b0:539:edbe:ac86 with SMTP id
 2adb3069b0e04-53dc1326d69mr2039832e87.10.1732144699638; Wed, 20 Nov 2024
 15:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bdba1f49b4b48e22628482b49ce81f8e1f0d97b1.1731445901.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <bdba1f49b4b48e22628482b49ce81f8e1f0d97b1.1731445901.git.christophe.jaillet@wanadoo.fr>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 20 Nov 2024 15:18:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQxLkr3vm7F0KtzKw9Kq6=yf8Q5jg2c3E9ksV+Stv4Ow@mail.gmail.com>
Message-ID: <CAD=FV=UQxLkr3vm7F0KtzKw9Kq6=yf8Q5jg2c3E9ksV+Stv4Ow@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Constify struct i2c_device_id
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 12, 2024 at 1:12=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct i2c_device_id' is not modified in these drivers.
>
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>   15566     987      32   16585    40c9 drivers/gpu/drm/bridge/chipone-ic=
n6211.o
>
> After:
> =3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>   15630     923      32   16585    40c9 drivers/gpu/drm/bridge/chipone-ic=
n6211.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
> ---
>  drivers/gpu/drm/bridge/chipone-icn6211.c   | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9211.c    | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9611.c    | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c      | 2 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c      | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

I figured it didn't hurt if I just pushed this so I did. Now in drm-misc-ne=
xt:

[1/1] drm/bridge: Constify struct i2c_device_id
      commit: dbf7986f8a56ce47465bb6e0f2b2d166b931d707

-Doug

