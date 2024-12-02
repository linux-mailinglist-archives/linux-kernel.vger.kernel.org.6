Return-Path: <linux-kernel+bounces-427412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358A19E009F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1308164750
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F5D1FECA8;
	Mon,  2 Dec 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QJY4JO46"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB420ADD2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138613; cv=none; b=P96rjG7V1DITfKMAac/+ZmatJV5wYYfVtT5hx7IV1YcFfjl/9vuy7j86t4NnTr9fjjsT6dVJCPOWR+m2XiQBw8G33rmto218+q/PGEB1F60G4OnjVY/wtBmFpu/CGfwE0DfZ+jfWbXPX1L5G8QWUJz/3PS8VKZKuaM00HHfh5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138613; c=relaxed/simple;
	bh=3CwUiYzQSS9zQX15Z8WynaPmt4FF3csoPX1C+MgznUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ipvpe0OzLdmBw4TKYNYlajVylsnrHVW0RoQprSSj8iea213KkbSfVnFvgRC8x+L0MmLb8rgp5Em881NHGPFSkzyFLGG7vwJ7LfSJ1yDNlGOyUSK1AjRHWer3juHQrNIinR4QwPvHInwpGBSUMbpfTNdKZwXt04v0WSTjYkO75VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QJY4JO46; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733138609;
	bh=3CwUiYzQSS9zQX15Z8WynaPmt4FF3csoPX1C+MgznUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QJY4JO46MD8RaA3KdmhUPZ9xQ7YVc6mQkbjYEfAhYkhi2SGFwHcGVpbNZ26OKO9VN
	 ycW3Kc52HxivZNn0QoFo144355/t7+3FLJie14iQsyArF+GT8RMCAZ0nejyRuKvOg8
	 FNm68HWcUd7wjcbaEKMWFExOeRzJlcOcKSun21hm1GceDWKPC8jPUWqH3LwdG1DQ0w
	 CpIbH0PogSJ7DPZRmP8lB4rzh9n8mDeZdf1MrRK/CP2fl5gDDpGfR1we9Ahm6bdo0y
	 w9Om0UC/tOOQHl/P+epf+64HIdfkzrOTnfHuunwJQ+4So4uBdb1vuDdua51i1zYGmM
	 w6u75MoQnLjmQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD4B717E3624;
	Mon,  2 Dec 2024 12:23:28 +0100 (CET)
Date: Mon, 2 Dec 2024 12:23:09 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Philipp Zabel
 <p.zabel@pengutronix.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] drm/panfrost: Remove unused device property
Message-ID: <20241202122309.12cf8e25@collabora.com>
In-Reply-To: <20241128211223.1805830-9-adrian.larumbe@collabora.com>
References: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
	<20241128211223.1805830-9-adrian.larumbe@collabora.com>
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

On Thu, 28 Nov 2024 21:06:23 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> The as_in_use_mask device state variable is no longer in use.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
>  drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index fc83d5e104a3..b91957f886ea 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -117,7 +117,6 @@ struct panfrost_device {
>  	DECLARE_BITMAP(is_suspended, PANFROST_COMP_BIT_MAX);
> =20
>  	spinlock_t as_lock;
> -	unsigned long as_in_use_mask;
>  	unsigned long as_alloc_mask;
>  	unsigned long as_faulty_mask;
>  	struct list_head as_lru_list;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 5e30888bea0e..95df39b463d8 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -604,7 +604,6 @@ static void panfrost_mmu_release_ctx(struct kref *kre=
f)
>  		pm_runtime_put_autosuspend(pfdev->base.dev);
> =20
>  		clear_bit(mmu->as, &pfdev->as_alloc_mask);
> -		clear_bit(mmu->as, &pfdev->as_in_use_mask);
>  		list_del(&mmu->list);
>  	}
>  	spin_unlock(&pfdev->as_lock);


