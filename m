Return-Path: <linux-kernel+bounces-434106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAE9E61B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0ECF168D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF43EC2;
	Fri,  6 Dec 2024 00:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wELYwgHI"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859461FDD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443603; cv=none; b=mwpb6T2jT1QQhAnzuavjhC46vSCySgRjBrmCkgxLmO7RehNTIquWiDNQKX2c0Jfmrn8qK5H+2xOlPIjveI7JHUZYCIpAkou4UclCghYZaRRgCs+/SXWOns/1qi4PenqmtwKFePlg5uYEJE8rNOaqc12iFFtdwNMpWO5ssHB0ymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443603; c=relaxed/simple;
	bh=Il1Tlrx+OKzJ/PUrGqPeDzuMUeLEedZh2EDsrz5JTrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7hjmmjMuwCGTZSC+dPTwjNYIUeTN8u4ObzbVsJTwOU8QafGQccQ9z/masBAja+Dc9C3VTD9pEu32MvzfQDciXIQA4MbAfBmSDHej7Gmp9fBD4uVxnC68/KjDUupBx4mB7I8a3W6fWQSPtLBwYB0nxoa15+HnK9/XZejCSbqaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wELYwgHI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e1f673ca8so1658021e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443600; x=1734048400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqZWstnvS5M7KlsauJVlhYbS8zK4ZfCAjPX+o2siRvQ=;
        b=wELYwgHI4qRUqGtPFeTUtv5Dp+Xf3C1VIMY7o2Rq2RGq0UuAV10YXVr3byaTnAte0U
         qNTTOtfKnLEhvcl+1+nOFuBn1HlrI70ZryNJEvdUfy7qimWDhuIu7CZZ/PL4OY8lZHwN
         rK3qwVBsU3L5n+A0Wzmk8EGSGyEDboP63yxCAEOUJPPZz6MWcP5xIrpK6CTB5UPbrFWg
         M2Cd6qpnui0VH3IUiXA/vvdJ+5C+RNW/Bup+Xkb2KR2EYdsHFaKju1s+LfhoaF3zomGQ
         ibqMLlnuh3Dqg8HjmlqyZz54JOvHNb5Mp+uvNSA6SmUPdOuvJqj60O6xg5Bm/AWmo5q/
         ddyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443600; x=1734048400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqZWstnvS5M7KlsauJVlhYbS8zK4ZfCAjPX+o2siRvQ=;
        b=GLebY+8HXEeIlUP5SlIIyV9glBRyVpyJTw8y8o3LILjOuwIUwhU78vhqnVT65LWFQc
         6ersqx4sd3CF/CwodwtCDsnU+92BsRONySMBKpgTwwNefEzKdD+tztpt1eW/sxrR94bT
         9E9egwgYR0NRh2QGDfiyTNwwqtVXioI4Vy971XOrZm7FxpBbiMcwCzjyvNT5Dj0ebQBY
         FyZ95jpaOVwGrB67cZk55QpvySsM3oLzGh3GIpxx2QGt0z9KyR/HrhQp1Xxe6+XX0h3m
         Dw4Ki8bWboQ0qdAZuIKxeWfPotzRSbH7dI2PERH+kdyN0yp0rfTSr3JN17Zl1QGXh02X
         tkvQ==
X-Gm-Message-State: AOJu0YzoeKkAxsirsMXtKgh3aiAUraVFeHl9XCBWJf5vJb2yXMWhxFB9
	7Edf4oG8CSl8O98WRFrEoNkspRkucMoJuqDFjNF3HFN6TxmbrEfTIuKMfcMpiJ2x4D7Hn1hD0H/
	WiUP0h/Cl9UX11S9nOfuqRIc7uK88/qnPT8na
X-Gm-Gg: ASbGncug8TVsW/YJd0N2yChBTb32iKAcWmc9TUh0XPEWUcrNYYuVnBPghh5y71CDedj
	ZK8WYMZxvL7A0S4ku6IBGNRNK1z+hOg==
X-Google-Smtp-Source: AGHT+IFMKCgNjf7EuTIfzy1U+mxlTHH4A6RijBLU54vNTWXHVXJQWJqIB/kHPOOCzpMc5RVjG0prBUt0JknyJqn08+E=
X-Received: by 2002:a05:6512:4024:b0:52f:ca2b:1d33 with SMTP id
 2adb3069b0e04-53e2c2b8f76mr213110e87.20.1733443599437; Thu, 05 Dec 2024
 16:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221726.2247988-1-sashal@kernel.org> <20241204221726.2247988-8-sashal@kernel.org>
In-Reply-To: <20241204221726.2247988-8-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:06:02 -0800
Message-ID: <CAGETcx8bhzGZKge4qfpNR8FaTWqbo0-5J9c7whc3pn-RECJs3Q@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.11 08/15] drm: display: Set fwnode for aux bus devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, elder@kernel.org, ricardo@marliere.net, 
	sumit.garg@linaro.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Saravana Kannan <saravanak@google.com>
>
> [ Upstream commit fe2e59aa5d7077c5c564d55b7e2997e83710c314 ]
>
> fwnode needs to be set for a device for fw_devlink to be able to
> track/enforce its dependencies correctly. Without this, you'll see error
> messages like this when the supplier has probed and tries to make sure
> all its fwnode consumers are linked to it using device links:
>
> mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) wit=
h backlight-lcd0
>
> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@=
notapiano/
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Link: https://lore.kernel.org/r/20241024061347.1771063-2-saravanak@google=
.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

As mentioned in the original cover letter:

PSA: Do not pull any of these patches into stable kernels. fw_devlink
had a lot of changes that landed in the last year. It's hard to ensure
cherry-picks have picked up all the dependencies correctly. If any of
these really need to get cherry-picked into stable kernels, cc me and
wait for my explicit Ack.

Is there a pressing need for this in 4.19?

-Saravana

> ---
>  drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/d=
isplay/drm_dp_aux_bus.c
> index d810529ebfb6e..ec7eac6b595f7 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
>         aux_ep->dev.parent =3D aux->dev;
>         aux_ep->dev.bus =3D &dp_aux_bus_type;
>         aux_ep->dev.type =3D &dp_aux_device_type_type;
> -       aux_ep->dev.of_node =3D of_node_get(np);
> +       device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np)));
>         dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
>
>         ret =3D device_register(&aux_ep->dev);
> --
> 2.43.0
>

