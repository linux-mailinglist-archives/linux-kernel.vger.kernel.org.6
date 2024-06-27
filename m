Return-Path: <linux-kernel+bounces-232469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FFB91A940
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E45C1F22184
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84508196446;
	Thu, 27 Jun 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf8T+SCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94101442FE;
	Thu, 27 Jun 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498709; cv=none; b=kVeTXLe6ND/GHozYrDk2U5BQyTnk70oI8oc+eS4l6dB48Ic8185agHOMP8/DItB8qt0S3Nnaa6qT/8rCBSvBOsD7jmvwT8pWEHfUBcrDnJ1q5iiihN0QvMQVKt3dhJBXA3Tv4XjPSRSIVU808fyRV2o5ScLoab+bxcNq6JIyh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498709; c=relaxed/simple;
	bh=je/gF3c5IjwDHUi3yQuh6iBacgL+GUzWMlTEUFbmCos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6+LBmhZyj+R0qpzRcCQx3su8kFYBXQyV9L82NbMXuefz01E2nFeWoap/vR4MeIuTFtPtPmKjdtWTu8lSBbSzxZV6tiQkvq7F6sg2hFXFGTwyk6iRNeveyv5/iA/crEH8Od5+qwRxmcmcQ0fXEwj6fPZZY+eI559CcqhvTviVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf8T+SCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D314C4AF0F;
	Thu, 27 Jun 2024 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719498709;
	bh=je/gF3c5IjwDHUi3yQuh6iBacgL+GUzWMlTEUFbmCos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gf8T+SCHxjuVdwuzAwoq818CHZlsMx63I1NkNIeSMFrAhnI3pdbg0n5v8L4bobAit
	 RecOip5hCy0mZgOo8ukiqQRERRQKu2SELiU2GlD4IQevFvu9rutFwqtcWvPYCSQQtq
	 ARuCV4hCsDcYx+4oCBs7kPE9mVnPtqz8lSWEqgh7Hp1j4Ef9AhxDcgOarImhlNGXGV
	 IuRO4hwoL4dhppvRgA5I3b++obw9IejkqvkG0cgpK5l7uXP+5+20yu3sFaN3+QJrQ/
	 HyMAHxx8FXa0yQOkr2EOyYBmZIzEXqjG99z94tcSy2iHM0xz0t+iPniaSEWOGnO3XW
	 isAZl/n9J0jcA==
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7066c9741fbso5298695b3a.2;
        Thu, 27 Jun 2024 07:31:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsV1myNaoDI1haO3zyFj5sCRGWnMf+fEXXv2LYlLGbJBPmZKETb89mMHeGP/vk3FRnkHvSmDODcDDFFYMJEZ4+gzfwoXpMu5y23KHIBlz3JjEfDUJe8MM+Pq3w7OOWEu3o4EzKoGoBjQ==
X-Gm-Message-State: AOJu0YwJqX5h7v6jm/sFke4J8nbUyQPfE9oOXZNypalzL6sSo9GmAvKJ
	/Wbh1ZXTqxwIBgw/Qj+wBFTsyz6aKjP1s5UoREKrRnZgvl6+XlRlF0TlFr8tG+05hPI06hnD1ZO
	QJE4TUOI5lE/v5dbxlzPTpVOz8g==
X-Google-Smtp-Source: AGHT+IG1LSbB2re1qaPNE2onF1geh2vffld0C/9Blwt0TFmZDtnZln8OhUpXrzl1P1UTbercZENutaEyhnCFpRLApUc=
X-Received: by 2002:a05:6a20:b20:b0:1be:c33e:1357 with SMTP id
 adf61e73a8af0-1bec33e1573mr3624391637.34.1719498708836; Thu, 27 Jun 2024
 07:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com> <20231023-display-support-v4-11-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-11-ed82eb168fb1@baylibre.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 27 Jun 2024 22:31:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-8XzHg_pYkj_u3q_Jgzg29wiJbz5qMkySVRxL=5P69qQ@mail.gmail.com>
Message-ID: <CAAOTY_-8XzHg_pYkj_u3q_Jgzg29wiJbz5qMkySVRxL=5P69qQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] drm/mediatek: dsi: Improves the DSI lane setup robustness
To: Alexandre Mergnat <amergnat@baylibre.com>, Shuijing Li <shuijing.li@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Shuijing:

Please help to review this patch.

Regards,
Chun-Kuang.

Alexandre Mergnat <amergnat@baylibre.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=88=
23=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:49=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Currently, mtk_dsi_lane_ready (which setup the DSI lane) is triggered
> before mtk_dsi_poweron. lanes_ready flag toggle to true during
> mtk_dsi_lane_ready function, and the DSI module is set up during
> mtk_dsi_poweron.
>
> Later, during panel driver init, mtk_dsi_lane_ready is triggered but does
> nothing because lanes are considered ready. Unfortunately, when the panel
> driver try to communicate, the DSI returns a timeout.
>
> The solution found here is to put lanes_ready flag to false after the DSI
> module setup into mtk_dsi_poweron to init the DSI lanes after the power /
> setup of the DSI module.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index e036d9394c23..cb546a9e9419 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -643,6 +643,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>         mtk_dsi_config_vdo_timing(dsi);
>         mtk_dsi_set_interrupt_enable(dsi);
>
> +       dsi->lanes_ready =3D false;
> +
>         return 0;
>  err_disable_engine_clk:
>         clk_disable_unprepare(dsi->engine_clk);
>
> --
> 2.25.1
>

