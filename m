Return-Path: <linux-kernel+bounces-389044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3659B67D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173841C21C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E42141D4;
	Wed, 30 Oct 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RRHed0TK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194B213ED6;
	Wed, 30 Oct 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302102; cv=none; b=ANMOaEIZYxo9zrAysGcNYcVCh9eii3gv84SEuGrSmFYH9w0j/sk5TEb8aGME2yEHapxCZLz1uPl8/K6ZTv8yBPSZYH/22UlJg22CXcQ9Hzv2HPZAbKpy9DHOCeDeT/EaJ0bHSAygYUj1vfUq9aCdV8xpOz8ClSyEQhWFJv3/mGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302102; c=relaxed/simple;
	bh=QDS4abYzVocsLQ2xjdBWlvvUnWTPAtKlT4xBgG2UpMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CapqhmBkYnQGvOZPB+BFsaeYZjSYa2TGOnvwKkKVlIyWc+VvkKVTekRcgvio21kA6AWgxNyPEilUz7pd9AqJA38wAODsUQxYgQhFNPUv+AD6EerRMSleWt35ybwSOQvnks/jNZ/8VzIGjnHMVF7tyNdgK8HRqApRqaCQI8u6WWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RRHed0TK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730302098;
	bh=QDS4abYzVocsLQ2xjdBWlvvUnWTPAtKlT4xBgG2UpMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RRHed0TKwfMV3pcWVbro68R5lFmx9LFgK81VZ4FqUyuhjSPXkt3NMJKn/R1HP4khn
	 dEC5ZCVYR6qbFMBUw9/5XiwcQ9gaf7s5HYiN3PueEnUNYUii71erjCtUrT0a3s3Z3R
	 onX+GSDptcswLVK4MDE0d7VbaTmMstTC108f4A48V+ONsu6IXi4b/4RvLGDNmNb1TL
	 nxiYcuZ/NL1/o/vROnRogH3R2nfZwIXZ9aJipRHxhIURcbcaxLmcD8fvFMun2+q94C
	 b/3uC5k70v9tIX6+5Gj4O9kD3TrkkZgYEhpPjYOSej4Kq06dWcf1St5YTsV0oQ2y6E
	 xV5GiHN4RKcaw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DE41417E363B;
	Wed, 30 Oct 2024 16:28:17 +0100 (CET)
Date: Wed, 30 Oct 2024 16:28:12 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, Steven Price <steven.price@arm.com>,
 kernel@collabora.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/gpu: Fix Panthor documentation build
 warnings
Message-ID: <20241030162812.267750b6@collabora.com>
In-Reply-To: <20241009214346.2308917-1-adrian.larumbe@collabora.com>
References: <20241009214346.2308917-1-adrian.larumbe@collabora.com>
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

On Wed,  9 Oct 2024 22:43:30 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Fix Panthor documentation build errors uncovered by the makedocs target
> when building with extra warnings enabled.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: f25044688b04 ("drm/panthor: add sysfs knob for enabling job profil=
ing")

Queued to drm-misc-next.

BTW, the commit hash was incorrect, please make sure you pick the hash
from the drm-misc tree not from your local branch next time.

> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/gpu/drivers.rst         | 1 +
>  Documentation/gpu/drm-usage-stats.rst | 1 +
>  Documentation/gpu/panthor.rst         | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
> index b899cbc5c2b4..7b1282e2d807 100644
> --- a/Documentation/gpu/drivers.rst
> +++ b/Documentation/gpu/drivers.rst
> @@ -22,6 +22,7 @@ GPU Driver Documentation
>     afbc
>     komeda-kms
>     panfrost
> +   panthor
> =20
>  .. only::  subproject and html
> =20
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/dr=
m-usage-stats.rst
> index a80f95ca1b2f..12ca3193bf15 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -186,4 +186,5 @@ Driver specific implementations
> =20
>  * :ref:`i915-usage-stats`
>  * :ref:`panfrost-usage-stats`
> +* :ref:`panthor-usage-stats`
>  * :ref:`xe-usage-stats`
> diff --git a/Documentation/gpu/panthor.rst b/Documentation/gpu/panthor.rst
> index cbf5c4429a2d..3f8979fa2b86 100644
> --- a/Documentation/gpu/panthor.rst
> +++ b/Documentation/gpu/panthor.rst
> @@ -4,7 +4,7 @@
>   drm/Panthor CSF driver
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =20
> -.. _panfrost-usage-stats:
> +.. _panthor-usage-stats:
> =20
>  Panthor DRM client usage stats implementation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


