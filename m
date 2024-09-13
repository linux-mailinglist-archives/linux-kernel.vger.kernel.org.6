Return-Path: <linux-kernel+bounces-327772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA81977AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48AEBB22F20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74ED1D67B9;
	Fri, 13 Sep 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="he5n67dJ"
Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF641BDA95
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216159; cv=none; b=o4KXA/waFSWlemqOo3lO5HZ4kGr+LkBEJdiZSdyyx+K5qKYaVwzfNw4cF8y5aQyER2bJPCVud/ZDhrHAcZRHAGJ7sjsMyjRNQmykNmDtDT/Ao/zXmWOAIO21ahKT1x0tlqpV/afLVczCCUSxA0FpxMPNWw+OnJ6+zJDjhxnJvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216159; c=relaxed/simple;
	bh=cn67KHzfkvQEli5oqG/VanaBEZRol7pKN6R5WL3KCLU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 References; b=a89615OZJsuVWj7usztQ8rQh3iwbeMIY+3NP6kpCZKbpHZEf/JlwK0zu2UtNzUWrcqHPizaETQzAa7Ya5CDS0c5qPbTXJFlxUfjchTHB4uZylP3wKya2Mq90UHUXNb1TXSB9ENISxLNnqMKhKAYBVRPk5eD9V/6uG0W3cNAHfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=he5n67dJ; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=References:Cc:To:Subject:Message-ID:From:
	Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RejbSR+sEfgVeb6AxVMsFCRZ9Y1/9FAzbN9AZI0gceI=; b=he5n67dJ1C3eyxGz+Th+FX1tif
	awEg20wPgtEHJqxWL1LH0VisTU0lVYCuCLP38KuJKGqCFGbCsnSndjUR7NwScig22sQSKyFqvnHT/
	/rWmy1SsPGmY5iPT+nN0pruHg+YqyZ4zxeCkPmDQbLVk6+Em5zlWN1vnZLjw24x37tHOq9cCcQsB0
	ZStozLfUGDulN53UQt0hswF15PWUljbEBfZja1GXr0g8j3+qN0g2SvvwodukXq5cYfzy4WfnGRL7t
	XEoowi+V3kyF0Hwo0hrV2eoGq//vNXrBgk1nhDcpZRQB5uZlDGmcxvZU6WFbxTGfTvKWJxrLyez6D
	Dn/bGCVQ==;
Received: from webng-gw.kapsi.fi ([91.232.154.200] helo=rainloop.kapsi.fi)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jyri.sarha@iki.fi>)
	id 1sp0yQ-001qCg-0Z;
	Fri, 13 Sep 2024 10:44:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Sep 2024 07:44:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: jyri.sarha@iki.fi
Message-ID: <cf35cba8d508383040266a1a8d2cdbef8f8db682@iki.fi>
Subject: Re: [PATCH] drm/tidss: Add MIT license along with GPL-2.0
To: "Devarsh Thakkar" <devarsht@ti.com>, jyri.sarha@iki.fi,
 tomi.valkeinen@ideasonboard.com, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: praneeth@ti.com, nm@ti.com, vigneshr@ti.com, r-ravikumar@ti.com,
 j-choudhary@ti.com, grandmaster@al2klimov.de, caihuoqing@baidu.com,
 ahalaney@redhat.com, cai.huoqing@linux.dev, colin.i.king@gmail.com,
 javierm@redhat.com, dmitry.baryshkov@linaro.org, geert+renesas@glider.be,
 laurent.pinchart@ideasonboard.com, dakr@redhat.com,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, sam@ravnborg.org,
 simona.vetter@ffwll.ch, ville.syrjala@linux.intel.com,
 wangxiaojun11@huawei.com, yuanjilin@cdjrlc.com, yuehaibing@huawei.com
References: undefined
X-SA-Exim-Connect-IP: 91.232.154.200
X-SA-Exim-Mail-From: jyri.sarha@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

September 12, 2024 at 8:11 PM, "Devarsh Thakkar" <devarsht@ti.com mailto:=
devarsht@ti.com?to=3D%22Devarsh%20Thakkar%22%20%3Cdevarsht%40ti.com%3E > =
wrote:

>=20
>=20Modify license to include dual licensing as GPL-2.0-only OR MIT licen=
se for
> tidss display driver. This allows other operating system ecosystems suc=
h as
> Zephyr and also the commercial firmwares to refer and derive code from =
this
> display driver in a more permissive manner.
>=20
>=20Signed-off-by: Devarsh Thakkar <devarsht@ti.com>

Acked-by: Jyri Sarha <jyri.sarha@iki.fi>

I guess tehnically my ack would not be needed as TI owns the code I've wr=
iten for tidss, but here it goes anyway.

Best regards,
Jyri

> ---
> drivers/gpu/drm/tidss/Makefile | 2 +-
> drivers/gpu/drm/tidss/tidss_crtc.c | 2 +-
> drivers/gpu/drm/tidss/tidss_crtc.h | 2 +-
> drivers/gpu/drm/tidss/tidss_dispc.c | 2 +-
> drivers/gpu/drm/tidss/tidss_dispc.h | 2 +-
> drivers/gpu/drm/tidss/tidss_dispc_regs.h | 2 +-
> drivers/gpu/drm/tidss/tidss_drv.c | 2 +-
> drivers/gpu/drm/tidss/tidss_drv.h | 2 +-
> drivers/gpu/drm/tidss/tidss_encoder.c | 2 +-
> drivers/gpu/drm/tidss/tidss_encoder.h | 2 +-
> drivers/gpu/drm/tidss/tidss_irq.c | 2 +-
> drivers/gpu/drm/tidss/tidss_irq.h | 2 +-
> drivers/gpu/drm/tidss/tidss_kms.c | 2 +-
> drivers/gpu/drm/tidss/tidss_kms.h | 2 +-
> drivers/gpu/drm/tidss/tidss_plane.c | 2 +-
> drivers/gpu/drm/tidss/tidss_plane.h | 2 +-
> drivers/gpu/drm/tidss/tidss_scale_coefs.c | 2 +-
> drivers/gpu/drm/tidss/tidss_scale_coefs.h | 2 +-
> 18 files changed, 18 insertions(+), 18 deletions(-)
>=20
>=20diff --git a/drivers/gpu/drm/tidss/Makefile b/drivers/gpu/drm/tidss/M=
akefile
> index 312645271014..c67ff32d02e1 100644
> --- a/drivers/gpu/drm/tidss/Makefile
> +++ b/drivers/gpu/drm/tidss/Makefile
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: GPL-2.0 OR MIT
>=20
>=20tidss-y :=3D tidss_crtc.o \
>  tidss_drv.o \
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss=
/tidss_crtc.c
> index 94f8e3178df5..43dfbead9fa9 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.h b/drivers/gpu/drm/tidss=
/tidss_crtc.h
> index 040d1205496b..da03873e2ef0 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.h
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tids=
s/tidss_dispc.c
> index 1ad711f8d2a8..3321a1c731b1 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> /*
> * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.=
ti.com/
> * Author: Jyri Sarha <jsarha@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tids=
s/tidss_dispc.h
> index 086327d51a90..e6e4396a0d63 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm=
/tidss/tidss_dispc_regs.h
> index 13feedfe5d6d..6e27b6d444ab 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> /*
> * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.=
ti.com/
> * Author: Jyri Sarha <jsarha@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/=
tidss_drv.c
> index d15f836dca95..b060e420ddec 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/=
tidss_drv.h
> index d7f27b0b0315..d4209234f59c 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.h
> +++ b/drivers/gpu/drm/tidss/tidss_drv.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/ti=
dss/tidss_encoder.c
> index 17a86bed8054..9749fbc0e056 100644
> --- a/drivers/gpu/drm/tidss/tidss_encoder.c
> +++ b/drivers/gpu/drm/tidss/tidss_encoder.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_encoder.h b/drivers/gpu/drm/ti=
dss/tidss_encoder.h
> index 3e561d6b1e83..85db3835a335 100644
> --- a/drivers/gpu/drm/tidss/tidss_encoder.h
> +++ b/drivers/gpu/drm/tidss/tidss_encoder.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/=
tidss_irq.c
> index 604334ef526a..51939744695a 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.c
> +++ b/drivers/gpu/drm/tidss/tidss_irq.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.h b/drivers/gpu/drm/tidss/=
tidss_irq.h
> index b512614d5863..cbfd684ecd26 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.h
> +++ b/drivers/gpu/drm/tidss/tidss_irq.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/=
tidss_kms.c
> index f371518f8697..05afd57b9128 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_kms.h b/drivers/gpu/drm/tidss/=
tidss_kms.h
> index 632d79f5983f..69b6bca14550 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.h
> +++ b/drivers/gpu/drm/tidss/tidss_kms.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tids=
s/tidss_plane.c
> index a5d86822c9e3..37ffaea15c73 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.h b/drivers/gpu/drm/tids=
s/tidss_plane.h
> index e933e158b617..3e00bc853813 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.h
> +++ b/drivers/gpu/drm/tidss/tidss_plane.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_scale_coefs.c b/drivers/gpu/dr=
m/tidss/tidss_scale_coefs.c
> index c2b84fea89a5..686ea63e0f45 100644
> --- a/drivers/gpu/drm/tidss/tidss_scale_coefs.c
> +++ b/drivers/gpu/drm/tidss/tidss_scale_coefs.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Jyri Sarha <jsarha@ti.com>
> diff --git a/drivers/gpu/drm/tidss/tidss_scale_coefs.h b/drivers/gpu/dr=
m/tidss/tidss_scale_coefs.h
> index 9c560d0fdac0..4689109fe560 100644
> --- a/drivers/gpu/drm/tidss/tidss_scale_coefs.h
> +++ b/drivers/gpu/drm/tidss/tidss_scale_coefs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> /*
> * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.co=
m/
> * Author: Jyri Sarha <jsarha@ti.com>
> --=20
>=202.39.1
>

