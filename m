Return-Path: <linux-kernel+bounces-380644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B7F9AF40B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C001F2210F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8911F5831;
	Thu, 24 Oct 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7OcwCPE"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0A22B665
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802888; cv=none; b=tGU2k2Z4uSU+hx1QOFoG5d/brOvWhwgdF3HNFc2A8+QsKhYNF9vQUyjl+rD3IRTP2frgRM6bpZ1XK3YqoOURjJNvse0oYe/qx44zKkJAJY4dz2LubwJDuoMtIIp9r4NKV7hBAIzMDn3SLMY6MJ4uTBgOtdCzBWPUOEmtAmO+kRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802888; c=relaxed/simple;
	bh=uscNUaQqzc42Vj7KMQrrjFPhlKfSrJyEtDD2uRa1GNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATIcpp7R4ZyzoRwa0Ygv8KUphmZzejRakN9weaUdWg4LWLwdMYT4JtqXdRrgJFqKFsHbz+l+MKopcs+7btAPxUaB4vOAJda2GjjOMswsuZg8DyGnl5srjXjx2ZcBbf7YzvElPmsXv3UW40iLGNAnp1tUPf/2aAr1cmOpD3gDX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T7OcwCPE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so22322331fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729802884; x=1730407684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MylHOwKXaTo3xQDXg/sSZOBifyCTeLdawXaFYKq87vU=;
        b=T7OcwCPELCO27sPBtmhEJ/rDOxANkHHR4aFr8Rz7GgFJ5eAr2SE3PHmM/kV1cXUE68
         km8mvIN3nZkYC6qDApDGBKrT6RN4wDQIVNFlOU///jjOo1qLrVffU17i8KaFmCaHX29A
         8JUzhB2EwZNXcWhee73Kh+X+hxrVCE9rj4GhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802884; x=1730407684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MylHOwKXaTo3xQDXg/sSZOBifyCTeLdawXaFYKq87vU=;
        b=m6bi5nKS6brOWhqe2MafLfhFUkHxu93a/n0NsP408JlePal1yB9ijCmVdauWHp8+pw
         JRvmc98SMTUGGBQe8RdzToGZpuoAxUaWRPWvi9+6YHnkS/FF6PzQ2Db/Pny7pymXkrFA
         HSCtUmkLBQivh7YozoyjFPGsrALTeQoVeBVA4tSB8N8WVlopufEGkkTVlHHhAv7UPcXc
         H6eFMCy/CqMcilK3fgDsyrYhJXf6I8xG7400qGsnnw/GJjeo4FydQpsHwYiH+Yfyl9zI
         9g0a+sigDALQ+BaXnB/fFM+QAHYGfkaMQ/6YewK2FBLBWfn8Tb9+Hmw/gMqRTdJ7baBM
         FlHw==
X-Forwarded-Encrypted: i=1; AJvYcCVcDmeVo+k96JCYko/Hdg6kTbBxoO6YyanAxRmcgBLOlLWFDBWVt4a8NQca3pUmRqGwA9bEEVvc9bB5/lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLkoky7Hoe+N4zyWC88dUB5VB2Pus0Ze2wYSyOGMl3FFSZ36B
	J+r/AjekNNmUb39f1LjAaavEhhtk1nNjJ0FtYRoYKxwaR+rmV5lvjXyAVPsxscg/VyLa7lXx5Vp
	BXQ==
X-Google-Smtp-Source: AGHT+IGSD19g8XG+17XfIXo/BdqVU9c5AUopIjNfV5079jmAbXCU1GJ2I10qW5/GBg6++kVu65seMQ==
X-Received: by 2002:a05:6512:3ba8:b0:539:ede3:827f with SMTP id 2adb3069b0e04-53b23752284mr1161742e87.24.1729802883669;
        Thu, 24 Oct 2024 13:48:03 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224202e0sm1453486e87.167.2024.10.24.13.48.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 13:48:03 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so22902211fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:48:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8Th/F8wPQDXn43GCyu3meyeZUkSuw98cQ9HFmVHEfh/TS7iKxHIODr54Xyky+tm3lZARCr1A7/dtR3E4=@vger.kernel.org
X-Received: by 2002:a05:6512:3b8e:b0:53b:205c:e9ac with SMTP id
 2adb3069b0e04-53b2374a94fmr1177376e87.20.1729802881828; Thu, 24 Oct 2024
 13:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com> <20240620-igt-v3-8-a9d62d2e2c7e@mediatek.com>
In-Reply-To: <20240620-igt-v3-8-a9d62d2e2c7e@mediatek.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 24 Oct 2024 13:47:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTsPBQ7Qp_oQmBXkNY==KQWZdN7VYbuVPoBTHhMvzjUQ@mail.gmail.com>
Message-ID: <CAD=FV=XTsPBQ7Qp_oQmBXkNY==KQWZdN7VYbuVPoBTHhMvzjUQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation property
To: shawn.sung@mediatek.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	Bibby Hsieh <bibby.hsieh@mediatek.com>, Daniel Kurtz <djkurtz@chromium.org>, 
	Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>, 
	YT Shen <yt.shen@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2024 at 9:39=E2=80=AFAM Hsiao Chien Sung via B4 Relay
<devnull+shawn.sung.mediatek.com@kernel.org> wrote:
>
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
>
> Always add DRM_MODE_ROTATE_0 to rotation property to meet
> IGT's (Intel GPU Tools) requirement.
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.h |  6 +++++-
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 17 +++++------------
>  drivers/gpu/drm/mediatek/mtk_plane.c    |  2 +-
>  3 files changed, 11 insertions(+), 14 deletions(-)

FWIW, this patch got into ChromeOS's 5.15 branch via stable merge and
apparently broke things. As a short term fix we've reverted it there:

https://crrev.com/c/5960799

...apparently the patch is fine on newer kernels so maybe there is a
missing dependency? Hopefully someone on this list can dig into this
and either post the revert to stable 5.15 kernels or suggest
additional backports.


-Doug

