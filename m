Return-Path: <linux-kernel+bounces-363334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681DF99C0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D7D1C23672
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2C814601C;
	Mon, 14 Oct 2024 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fYeF85C/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6B145B3F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889965; cv=none; b=p4LFrI/WyMLpRGfeFYShYv4H7nozs4DUxw+6PTw/4pwwZOS/RFKvPwG0sNjPX5c6Xzz5omt+5nJm8F7kELQQJHH8zzbWVEymngotZTqLP90wXNTb7MIzRTmep5if2F1/ATuNl28ewCC2c1c+TlhsVczTPlpYgWaEPlNDgNFtJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889965; c=relaxed/simple;
	bh=C74Mdj4gQ89VsdmBHwEE5LBB/xqa6ebzMXhMOh/hajc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUnD5qbuAKG61/4Dyk/uKxzL1zdm4Nx6csVYO2czy0JEdjAtl85mals8Pw1f4ooWWkY5c4iyO1vj1Qz/c0dE9TBstfX7vcT9Zq2tBsa4SLPmMwQxadWqP6JkBYk1HiIBrTjM4moaT1irwRPs+2DdjGvH53/0Vy4P+qj/VZ6t9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fYeF85C/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728889955;
	bh=C74Mdj4gQ89VsdmBHwEE5LBB/xqa6ebzMXhMOh/hajc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fYeF85C/oyPmSZHlLG2fT0p6ozN7QvHPq83L8fQ3419NdqNH4Y9kd/TDXR+YFc41X
	 sDmcw4AUySr1zYxylky8/jeW/unu7nw+z83IBw7hOkbJyGQ2ag5XgAA7QLWD2EyvZc
	 pQvZRaCpoYPt3VaFjd+9aNWqI9ngULudRCpfRMTRS/4tOC2EFG6+yyjkrFL2eNGhum
	 WfYT0g/T7JeMIu3YLjLR6B9v5TBEGwtS0uDZcB5e+/928gWYXs1GyEnmg8CdwtJz9e
	 2/bZ9E0PZy4Zgy68F6oKsrk3ONjRaSsznn1cOrDMIuggCJt6jpDip4sokTQcAZCPWx
	 tgnasNyvrn64A==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E9EA17E1088;
	Mon, 14 Oct 2024 09:12:35 +0200 (CEST)
Date: Mon, 14 Oct 2024 09:12:29 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panthor: Fix runtime suspend sequence after OPP
 transition error
Message-ID: <20241014091229.5b3425c7@collabora.com>
In-Reply-To: <20241011225906.3789965-1-adrian.larumbe@collabora.com>
References: <20241011225906.3789965-1-adrian.larumbe@collabora.com>
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

On Fri, 11 Oct 2024 23:56:59 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> In case an OPP transition to a suspension state fails during the runtime
> PM suspend call, if the driver's subsystems were successfully resumed,
> we should return -EAGAIN so that the device's runtime PM status remains
> 'active'.
>=20
> If FW reload failed, then we should fall through, so that the PM core
> can flag the device as having suffered a runtime error.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index 4082c8f2951d..cedd3cbcb47d 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -528,8 +528,13 @@ int panthor_device_suspend(struct device *dev)
>  		    drm_dev_enter(&ptdev->base, &cookie)) {
>  			panthor_gpu_resume(ptdev);
>  			panthor_mmu_resume(ptdev);
> -			drm_WARN_ON(&ptdev->base, panthor_fw_resume(ptdev));
> -			panthor_sched_resume(ptdev);
> +			ret =3D panthor_fw_resume(ptdev);
> +			if (!ret) {
> +				panthor_sched_resume(ptdev);
> +				ret =3D -EAGAIN;
> +			} else {
> +				drm_err(&ptdev->base, "FW resume failed at runtime suspend: %d\n", r=
et);
> +			}

Hm, I'm not convinced resuming when devfreq_suspend() fails was the
right thing to do anyway. Can't we just assume the suspend succeeded in
that case, and force the devfreq OOP transition in the resume path, or
ignore it?

>  			drm_dev_exit(cookie);
>  		}
> =20


