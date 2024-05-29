Return-Path: <linux-kernel+bounces-194219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1045A8D3891
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AC2B21A90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897701CAB5;
	Wed, 29 May 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioooeFAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D71C6A1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991373; cv=none; b=U85SxR0o7f85oy0wY+99Vs+adlbrn4zoJIFJpjLSKshc9T27Is4FVKqnqm1AFRE4gcH+5p6eyMSutipLcENSu7Sy3cGDmDuXd5s7OChJsY1NjQowhRmyQbsvSHEYZ7ULadDNFiSvLl7+Bl83MrcDW4qHkYNC9XZD+/gBU/qyKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991373; c=relaxed/simple;
	bh=ClKliciffLvAYOJd0zEs/omJQhLpuiCBv2RFdMFaVkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rusXRe45ssDRkSV2YCfeEOdfy7zq3sMbp75ttxtpQDFSaMN+fapWjIoX0TGsixbMUa+LgaOTJgU7fka/rVEStQxjqceiX7+8dGoURKJCp7gFE6q08cAf1ZvknMqG7eed6oROHg+VlCB4Ia9kdqOIpnApgmUEnojain9B+/hsftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioooeFAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69057C2BD10
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716991373;
	bh=ClKliciffLvAYOJd0zEs/omJQhLpuiCBv2RFdMFaVkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ioooeFAHqJUVENw/TxzwW2AKwslsUnB5913QU+BV3I+cHtjiY4574Ez/5pKv2nlor
	 h75rqS+IhFWufHIL/DbPKdvwh2XU+LAbvIY7lhEDeELB/bFpiKdGcpqiJC40gVY3S7
	 U1SklR0qELVmyMoWpx/FTGrWloxKD35OUTxIYiejGk/4KkwxjSialuWmsnRgeGXtw3
	 gjeDfSQimxVUyZ78Pn0FcKT5tWnhdZkHfrKGn/1V8xmMXIIIf8tDfmhoU+hmRHIuqr
	 p6ULJwweJc7LrT3EbkYQaJjSPepzAIJip7BX2bF4UzWpLiJhMLwMu8XKvqP+DbUKDu
	 SHdfThbgsaXyA==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a2424ed00so19646287b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:02:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTAZF68En3m7rzkfSe95LylsVDHDckKclnBnhRPp4OyJEToSlwXXRJeAjYry+Kmn7v8FNi3bR9zGsjO5pzA8oT/VxPQslzf3cJcSRu
X-Gm-Message-State: AOJu0Yx1GilwjOGT9uvkRbk4mVtd3JtIRMWOWlZD/nP9Wh0Q58flDrMy
	p0j/RXoeOroIKQkD81pgYYWi4fgIQlxPbsCEeF9abFM3I89QfGTo8Ues4IwWKLtYADJwYfyOrnL
	FRZkOCKdOMNGD7OqiCJB/wNwKzetZFzlkkiltRQ==
X-Google-Smtp-Source: AGHT+IEQfAx4JIxkU4lwhsuOXXdkyjbqTK/TzbD39b2JjThMlG91WmwmEdm1flu1c5ds/ZRYMrcp6sgaL0vcye4/joQ=
X-Received: by 2002:a81:840c:0:b0:620:255a:a5c5 with SMTP id
 00721157ae682-62a08ea7e3fmr150098277b3.32.1716991372687; Wed, 29 May 2024
 07:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516062455.106266-1-alexander.stein@ew.tq-group.com> <20240516062455.106266-3-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240516062455.106266-3-alexander.stein@ew.tq-group.com>
From: Robert Foss <rfoss@kernel.org>
Date: Wed, 29 May 2024 16:02:41 +0200
X-Gmail-Original-Message-ID: <CAN6tsi6k3Fv5oQaWbDakaq6_=f-gmVY21OsQ5vxAdepUvU5VBQ@mail.gmail.com>
Message-ID: <CAN6tsi6k3Fv5oQaWbDakaq6_=f-gmVY21OsQ5vxAdepUvU5VBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/bridge: tc358767: Only print GPIO debug output
 if they actually occur
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 8:25=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Currently the output the following output is printed upon each interrupt:
>  tc358767 1-000f: GPIO0:
> This spams the kernel log while debugging an IRQ storm from the bridge.
> Only print the debug output if the GPIO hotplug event actually happened.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/t=
c358767.c
> index de62a7e2eafec..8874713bdd4a4 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -2146,11 +2146,11 @@ static irqreturn_t tc_irq_handler(int irq, void *=
arg)
>                 bool h =3D val & INT_GPIO_H(tc->hpd_pin);
>                 bool lc =3D val & INT_GPIO_LC(tc->hpd_pin);
>
> -               dev_dbg(tc->dev, "GPIO%d: %s %s\n", tc->hpd_pin,
> -                       h ? "H" : "", lc ? "LC" : "");
> -
> -               if (h || lc)
> +               if (h || lc) {
> +                       dev_dbg(tc->dev, "GPIO%d: %s %s\n", tc->hpd_pin,
> +                               h ? "H" : "", lc ? "LC" : "");
>                         drm_kms_helper_hotplug_event(tc->bridge.dev);
> +               }
>         }
>
>         regmap_write(tc->regmap, INTSTS_G, val);
> --
> 2.34.1
>
>

Reviewed-by: Robert Foss <rfoss@kernel.org>

