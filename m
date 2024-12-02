Return-Path: <linux-kernel+bounces-427404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779359E0092
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBB4285E79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DCB207A20;
	Mon,  2 Dec 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E5okRQAI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4D1FA244
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138486; cv=none; b=Aw6M1H2Py0rx8CdJR7m28Gv1vRodBV8rQj3PXjxpR3i0kyIgH5fY4MtHQCb3aTlu+AedS+QoMNOErUjQ4zCqsyZpA1slpBNb04zOUzSHIwO3b1okdtRKwQF9+LNj2kRlgFpHVfgmKOBv3tqNyP6LVdquONZYEzUkx5ILunhastI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138486; c=relaxed/simple;
	bh=4YRBu0iEfYpeNdGAKABSBxrKy76YlMDsHW9tAWoOGpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5uso6ILyUR6aPoefL/Sd3uGzMD7sv0tiyLpgu5IQlwbfot5flpnKLpHH6uG05ReKmFvuiy+mdwnomn1HBn9yw42c8Mu0smvJyqqUi/IzlO8uzxUzd/tyJJAhoOw04qd4moa8xgOYD8pn8+o7Gnusf+iOcUqZbBDtRztcqYBLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E5okRQAI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733138482;
	bh=4YRBu0iEfYpeNdGAKABSBxrKy76YlMDsHW9tAWoOGpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E5okRQAIuz39qaPWXdxM7gGyomfsmUr6f06ewruH1iFPWulJPgC25tyWxycK41+us
	 txuYN3oBJ0GuYWb63RXcauXSMs19xGxHURpRtoPf7IL6D8CiQy2qYOt1X+G2t44qNV
	 cFLRAehcKMtax+EJjW2hFVBe7JPiMejLyddHxyJ5CXfRmHXkxam+vTRkX0iZOKE1ZI
	 BwtBWdArf2qqXvkHiTl+M4cK4e6uGDQZtZdoyjDep5WAxQjJjd8Lf+XkUz2n1yTShP
	 +Mv4Rd0AjR4WoAfoptifAbwWXPdRX6j6jMphXMgpsZJ6Oa1Nn7PCBqKII9Z3xlFM81
	 AFtsOmCdLe6Zg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 517E117E3624;
	Mon,  2 Dec 2024 12:21:22 +0100 (CET)
Date: Mon, 2 Dec 2024 12:21:14 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Philipp Zabel
 <p.zabel@pengutronix.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] drm/panfrost: Add forward declaration and types
 header
Message-ID: <20241202122114.61a4c2a9@collabora.com>
In-Reply-To: <20241128211223.1805830-8-adrian.larumbe@collabora.com>
References: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
	<20241128211223.1805830-8-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Nov 2024 21:06:22 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> This is to make LLVM syntactic analysers happy.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.h
> index e6e6966a0cca..27c3c65ed074 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> @@ -4,6 +4,7 @@
>  #ifndef __PANFROST_MMU_H__
>  #define __PANFROST_MMU_H__
> =20
> +struct panfrost_device;
>  struct panfrost_gem_mapping;
>  struct panfrost_file_priv;
>  struct panfrost_mmu;


