Return-Path: <linux-kernel+bounces-307152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A338D964941
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592031F22DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9482C1B14E1;
	Thu, 29 Aug 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfUr/3gG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA41B1407
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943364; cv=none; b=BtxpO2Px+V6nxQyquNM05sh6YfSjqiBfwIh+PxP4OW8XT0qCLO6pjcUr0ltilSyp/iQ+XiSuv77jNt670C/tTlmTyQSIMWEahoj7iYwrNETwL8+tgUn9mA3pGg+MIyecmqxMci/xNvp/I98DrxY5O5teWCsdXEyoIobSoaOZlEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943364; c=relaxed/simple;
	bh=Wa7GEC+jmKeo4NSPW1Bo0oimfIIbKS9WMiWx2F1YMMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsFUMcUPU3nd0WoEOAVgo4cwFf7GduNlc16807jO6wJ6QXHtsC5tlKHbs44C4ApbvJCZgDdjzfAkDh8IFitc8iSRic1d3np115cmvVrW+uvNC2AC4NeRfy79c6bQ4mxRZu0Z4EX/GUAGCo1tnyZpNaCzjH/Sxz8z63RS2KvhWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfUr/3gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7646FC4CECC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724943364;
	bh=Wa7GEC+jmKeo4NSPW1Bo0oimfIIbKS9WMiWx2F1YMMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UfUr/3gGVA3aySXOeeNVdUpeDbxqN2i9g3FvtooXpWy7a9+AV2Z+AUhvZFTDtW0cj
	 ijUnF16/ekARaheHS783rlUwngZn6F2zbJ88dZobL/0wP03OCCUwgS2FcQpGCvEe/0
	 sRfEI90qWQOHfc3QeoHfbQPY7+b5zdufsBuldxJHjnLQ6EHLjnwKID9TFHo5bx2tka
	 FepC0lHnUF7xk/c810ydVnCXD7Ta9+hmc6brQ8N7JjCY1IsgTlxMyUmp6uh/5vm+es
	 3F3iS5J/aaNHYHnidDhAK7KCWRkJf8jsoLlDcu4fUeLpqNYqI/9hHjvngUCHny5Y3w
	 +eL76R5jhPR1g==
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714262f1bb4so612470b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:56:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHMEq/aHzRbE4dA+yUJ5wCDca+U1enKQeF0qFYYqlAzaQK3tkvDQckpUr1JRV20k8o6cLHwqkYktxfjDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbF83ofbbEqwwTQRpPAzq3PwbYFVY99voyewlD8p97fhN965il
	87kgqucCLfAkPTlXDFvKajD0R97Li9fmSTTvqa6SOsgBrHw+q9EWm8x9kNyI+dBuUUzzf+aqi32
	EodWRQNGBierVulTn83LDcojakg==
X-Google-Smtp-Source: AGHT+IHOHmvJGn9XBz6AncThotzVydHX29A8RmV2+ScX8Y16nl8lRqvlZcttdvPWazADk9wtRFMpp2To9vbVhRKrL9g=
X-Received: by 2002:a05:6a00:21c4:b0:70d:2583:7227 with SMTP id
 d2e1a72fcca58-715dfb6917bmr3828262b3a.6.1724943363419; Thu, 29 Aug 2024
 07:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-drm-fixup-0819-v3-0-4761005211ec@mediatek.com>
In-Reply-To: <20240827-drm-fixup-0819-v3-0-4761005211ec@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 29 Aug 2024 22:56:17 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-LX_aLLJpquJSYMu1uQ4v0nbEToVOBnV7Qr4vwBtoauA@mail.gmail.com>
Message-ID: <CAAOTY_-LX_aLLJpquJSYMu1uQ4v0nbEToVOBnV7Qr4vwBtoauA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix missing configuration flags in mtk_crtc_ddp_config
To: jason-jh.lin@mediatek.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Singo Chang <singo.chang@mediatek.com>, 
	Nancy Lin <nancy.lin@mediatek.com>, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason:

I squash this series into one patch and apply to mediatek-drm-next [1], tha=
nks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

Jason-JH.Lin via B4 Relay
<devnull+jason-jh.lin.mediatek.com@kernel.org> =E6=96=BC 2024=E5=B9=B48=E6=
=9C=8827=E6=97=A5 =E9=80=B1=E4=BA=8C
=E4=B8=8B=E5=8D=8810:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
> Change in v3:
> Change config_lock from spin_lock to spin_lock_irqsave
>
> Change in v2:
> Add spin_lock protection for config_updating flag.
>
> ---
> Jason-JH.Lin (2):
>       drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_confi=
g()
>       drm/mediatek: change config_lock from spin_lock to spin_lock_irqsav=
e
>
>  drivers/gpu/drm/mediatek/mtk_crtc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> ---
> base-commit: 469f1bad3c1c6e268059f78c0eec7e9552b3894c
> change-id: 20240819-drm-fixup-0819-f51e2d37fcd7
>
> Best regards,
> --
> Jason-JH.Lin <jason-jh.lin@mediatek.com>
>
>

