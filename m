Return-Path: <linux-kernel+bounces-363360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDAC99C147
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8C4B2439A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118A5148826;
	Mon, 14 Oct 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LDbI7pvw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079E147C9B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890943; cv=none; b=p6e4b2ruA0E2o5d+/a30mFZD2LFhR0nJVUAZSJX1YZBn0xzqAnNiX8euAbCxAsmjivFYXQBCtiK3Tw1LCx700F401tqTZs2o4pISvrFJOLPUgXzA3v/H3Ic9etnHJjhWxeCYEcQ6nn/IPtosGSK5XdknLP1f57EYmzWDmyyQ8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890943; c=relaxed/simple;
	bh=PluJBjCt8sRWlyCdfJRAdmc/ItMwAA9IVKhhVYczlKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZtQ8iaVjlAASwFFVg5LBzlER/Ka4L6Y4CzvxgKPlDbxea6P94F2em8jAuX+OJbz02KcvuAI0v/ZC7jM0062FBJ91WgKejqYO8LfNV94Ukd/Or7VyAsocvf7ZoyICMRW6SMsfDn6JxdOfKkptuOrH27YREm/ZK4iiz+uQUkrotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LDbI7pvw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728890939;
	bh=PluJBjCt8sRWlyCdfJRAdmc/ItMwAA9IVKhhVYczlKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LDbI7pvwQLh2IrwJa7JQJLtLnKpxHnIJrTtDW8TV4hcNRQFOiIe5JLAt4bl8o4w2g
	 DoMpeRjZXFyWImlH+YgWdT9c7NKdB/4o97IIGNqPcmcTGcHOtQoOhZUnWuiEvgBSJZ
	 zqxEBuqwuUkxViNddVr+ywW6ic5Hf+qU8bpWu9vYqiWFJLlcLtDEAcA09wjFVb42Se
	 26Qv04tX64kneCp4TXneEtrnpG3QGcrTW8WYT775c0wqXhJrzy9YjDGOIBKh290z44
	 S2eNzxGhNlFGnvZHg8wCpMKNjJahwzGdhPHnhzvcNWpddnS+zzdGdc2T3hOg6QCtQI
	 vWIB9SMFJ1qQw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C04B17E10AA;
	Mon, 14 Oct 2024 09:28:59 +0200 (CEST)
Date: Mon, 14 Oct 2024 09:28:55 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/panthor: Retry OPP transition to suspension
 state a few times
Message-ID: <20241014092855.5c761b13@collabora.com>
In-Reply-To: <20241011225906.3789965-2-adrian.larumbe@collabora.com>
References: <20241011225906.3789965-1-adrian.larumbe@collabora.com>
	<20241011225906.3789965-2-adrian.larumbe@collabora.com>
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

On Fri, 11 Oct 2024 23:57:00 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> When the device's runtime PM suspend callback is invoked, the switch to
> a suspension OPP might sometimes fail. Although this is beyond the
> control of the Panthor driver, we can attempt suspending it more than
> once as a defensive strategy.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index cedd3cbcb47d..5430557bd0b8 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -490,6 +490,7 @@ int panthor_device_resume(struct device *dev)
>  int panthor_device_suspend(struct device *dev)
>  {
>  	struct panthor_device *ptdev =3D dev_get_drvdata(dev);
> +	unsigned int susp_retries;
>  	int ret, cookie;
> =20
>  	if (atomic_read(&ptdev->pm.state) !=3D PANTHOR_DEVICE_PM_STATE_ACTIVE)
> @@ -522,7 +523,12 @@ int panthor_device_suspend(struct device *dev)
>  		drm_dev_exit(cookie);
>  	}
> =20
> -	ret =3D panthor_devfreq_suspend(ptdev);
> +	for (susp_retries =3D 0; susp_retries < 5; susp_retries++) {
> +		ret =3D panthor_devfreq_suspend(ptdev);
> +		if (!ret)
> +			break;
> +	}

This retry logic should probably be moved to panthor_devfreq_suspend(),
but as Liviu said, I think we need to better understand why it takes
several attempts for an OPP transition to succeed.

> +
>  	if (ret) {
>  		if (panthor_device_is_initialized(ptdev) &&
>  		    drm_dev_enter(&ptdev->base, &cookie)) {


