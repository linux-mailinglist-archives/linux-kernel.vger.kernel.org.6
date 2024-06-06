Return-Path: <linux-kernel+bounces-204276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C48FE69B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDA81C2568E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93583195996;
	Thu,  6 Jun 2024 12:36:04 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96FF13B28A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677364; cv=none; b=ZHKVuWVysR2elt7CAF8LVSWBB7rYgLYkISPUmRa6vm0VE0pEGN5pa3Tcg5AYK/Tmbe1yv2BWBZpDppzcTLh4Zcuom5zF/o+l/TIcnz3ay4tL9jny5ySp1XOPGHuXahU7FkMtzHY07LkniP5neIW7ODTnskZD8F7+vR3tBqj0tJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677364; c=relaxed/simple;
	bh=WbPrg5wz0w2DNRmDzbrQRrcnHj0atwhyfnmSCS3TDHk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVKTM4kQo2vHp+I1f0tBh9iDrMDkPe2initWCM9KlWVFyLYHpLIp8FHvCadMZkmvjINxJuctq3imxyW54gS9C78xbsXXQKf+WxVkD7ynTGLukv5+UhfI0aR8dwTMXjDF7il+rfSTqtv3cyWIdV2vSY1gUC7oUDpBmntphlkt9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw3gN4y7Vz6K9Hc;
	Thu,  6 Jun 2024 20:34:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FE3C1408F9;
	Thu,  6 Jun 2024 20:35:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 13:35:52 +0100
Date: Thu, 6 Jun 2024 13:35:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<kernel@collabora.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/mediatek: Don't print error if EDEFER_PROBE
 returned on component_add
Message-ID: <20240606133551.00007d14@Huawei.com>
In-Reply-To: <20240605-mtk-disp-rdma-dev-err-probe-v1-1-91259e1d3a93@collabora.com>
References: <20240605-mtk-disp-rdma-dev-err-probe-v1-1-91259e1d3a93@collabora.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 05 Jun 2024 12:50:25 -0400
N=EDcolas F. R. A. Prado <nfraprado@collabora.com> wrote:

> Use dev_err_probe() in the component_add() error path to prevent
> printing an error when the probe is deferred. This was observed on
> mt8195 with the disp-rdma driver:
>=20
>   mediatek-disp-rdma 1c002000.rdma: Failed to add component: -517
>=20
> But the same pattern is used across many other drivers, so update them
> all.
>=20
> Signed-off-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_aal.c         | 2 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c       | 2 +-
>  drivers/gpu/drm/mediatek/mtk_disp_color.c       | 2 +-
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c       | 2 +-
>  drivers/gpu/drm/mediatek/mtk_disp_merge.c       | 2 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c         | 2 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 2 +-
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c        | 2 +-
>  drivers/gpu/drm/mediatek/mtk_ethdr.c            | 2 +-
>  drivers/gpu/drm/mediatek/mtk_mdp_rdma.c         | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/me=
diatek/mtk_disp_aal.c
> index 3ce8f32b06d5..892dc40458fb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> @@ -197,7 +197,7 @@ static int mtk_disp_aal_probe(struct platform_device =
*pdev)
> =20
>  	ret =3D component_add(dev, &mtk_disp_aal_component_ops);
>  	if (ret)
> -		dev_err(dev, "Failed to add component: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to add component\n");
Perhaps
		return dev_err_probe(...)

	return 0;

Whilst I can see you are focused on this one problem case, it
might be better to use dev_err_probe() for all the similar
cases earlier in these functions.

Then that return dev_err_probe() pattern will make more sense
as it will be consistent with all the other calls.

