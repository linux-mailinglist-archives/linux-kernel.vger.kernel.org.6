Return-Path: <linux-kernel+bounces-516099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6BA36CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7941896F78
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EF519E97C;
	Sat, 15 Feb 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YYpbbd6b"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCC19DFA5
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739611696; cv=none; b=d1NVRkHMpxQng6KL5r7oOOs8dOSaDnsdYO6DxG0i+0JaX9NBYgF0v9BDq9MDufpvH2vTTXCcm54mkkaqtSxSbevWcmjL/W+AvhDnEwpYDYdI/2PpTtqyMTk4jCoTvgkDHFNv7dbws1lHridAbmwIrtsx+E8afb9pHqiENqqWm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739611696; c=relaxed/simple;
	bh=QQjpX9+xUBD8RzBv+J9lE4D/BHtPWo4D4U8SL3B1WUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6sf8T6N8JrYXLTPOnwrn7I+fQjGHlpiyXGrPdH1mpEGPJWxK6N/hTI7/udqbsAbEf0BWzclGSuzIe8UIREinJefF0pES//ZDikKmzayuFmjwwHw/9IOl64bVE0GFYbcLd2yBfXcSBm1iWv7ro+XqtnZHgKC9LvmTYsjQhKXmVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YYpbbd6b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739611692;
	bh=QQjpX9+xUBD8RzBv+J9lE4D/BHtPWo4D4U8SL3B1WUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YYpbbd6bVioKUx+jdEIEHKG2/pqedC6pc8dAI1ibk0/aiqRuRXMZt5OWqr5H1O5FH
	 7mq+55uDiBl2KRSVka2ppRWu5U58/p14rPbcevbABW9wOvI0/5l/VeoxBhCu1bL9vK
	 kmwTwau8B1ucAguF/sBuluzmyPLKkmc5TUv0IYK1uuP3RizFmV5yumkXHBp8nCPNtI
	 hPivHIQXtkRKgHZIIlvvD0bW9kJ6tzu7hmNtO8Y7dwIVjSpPJvCny5yZMARiWPQKTi
	 Nf9uPBvyr/I467IE7szIWvK6OYsr8jCqlKaeVMGnOASLMB7gqYWJOG/5df2MI4VXEG
	 XCbTiQjbegelw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 38ECA17E0657;
	Sat, 15 Feb 2025 10:28:12 +0100 (CET)
Date: Sat, 15 Feb 2025 10:28:07 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/panthor: Replace sleep locks with spinlocks
 in fdinfo path
Message-ID: <20250215102807.7502e7ba@collabora.com>
In-Reply-To: <20250214210009.1994543-1-adrian.larumbe@collabora.com>
References: <20250214210009.1994543-1-adrian.larumbe@collabora.com>
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

On Fri, 14 Feb 2025 20:55:20 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Commit 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdin=
fo
> group samples") introduced an xarray lock to deal with potential
> use-after-free errors when accessing groups fdinfo figures. However, this
> toggles the kernel's atomic context status, so the next nested mutex lock
> will raise a warning when the kernel is compiled with mutex debug options:
>=20
> CONFIG_DEBUG_RT_MUTEXES=3Dy
> CONFIG_DEBUG_MUTEXES=3Dy
>=20
> Replace Panthor's group fdinfo data mutex with a guarded spinlock.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo grou=
p samples")

My previous

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

stands.

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 26 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 1a276db095ff..4d31d1967716 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -9,6 +9,7 @@
>  #include <drm/panthor_drm.h>
> =20
>  #include <linux/build_bug.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> @@ -631,10 +632,10 @@ struct panthor_group {
>  		struct panthor_gpu_usage data;
> =20
>  		/**
> -		 * @lock: Mutex to govern concurrent access from drm file's fdinfo cal=
lback
> -		 * and job post-completion processing function
> +		 * @fdinfo.lock: Spinlock to govern concurrent access from drm file's =
fdinfo
> +		 * callback and job post-completion processing function
>  		 */
> -		struct mutex lock;
> +		spinlock_t lock;
> =20
>  		/** @fdinfo.kbo_sizes: Aggregate size of private kernel BO's held by t=
he group. */
>  		size_t kbo_sizes;
> @@ -910,8 +911,6 @@ static void group_release_work(struct work_struct *wo=
rk)
>  						   release_work);
>  	u32 i;
> =20
> -	mutex_destroy(&group->fdinfo.lock);
> -
>  	for (i =3D 0; i < group->queue_count; i++)
>  		group_free_queue(group, group->queues[i]);
> =20
> @@ -2861,12 +2860,12 @@ static void update_fdinfo_stats(struct panthor_jo=
b *job)
>  	struct panthor_job_profiling_data *slots =3D queue->profiling.slots->km=
ap;
>  	struct panthor_job_profiling_data *data =3D &slots[job->profiling.slot];
> =20
> -	mutex_lock(&group->fdinfo.lock);
> -	if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
> -		fdinfo->cycles +=3D data->cycles.after - data->cycles.before;
> -	if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
> -		fdinfo->time +=3D data->time.after - data->time.before;
> -	mutex_unlock(&group->fdinfo.lock);
> +	scoped_guard(spinlock, &group->fdinfo.lock) {
> +		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
> +			fdinfo->cycles +=3D data->cycles.after - data->cycles.before;
> +		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
> +			fdinfo->time +=3D data->time.after - data->time.before;
> +	}
>  }
> =20
>  void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
> @@ -2880,12 +2879,11 @@ void panthor_fdinfo_gather_group_samples(struct p=
anthor_file *pfile)
> =20
>  	xa_lock(&gpool->xa);
>  	xa_for_each(&gpool->xa, i, group) {
> -		mutex_lock(&group->fdinfo.lock);
> +		guard(spinlock)(&group->fdinfo.lock);
>  		pfile->stats.cycles +=3D group->fdinfo.data.cycles;
>  		pfile->stats.time +=3D group->fdinfo.data.time;
>  		group->fdinfo.data.cycles =3D 0;
>  		group->fdinfo.data.time =3D 0;
> -		mutex_unlock(&group->fdinfo.lock);
>  	}
>  	xa_unlock(&gpool->xa);
>  }
> @@ -3537,7 +3535,7 @@ int panthor_group_create(struct panthor_file *pfile,
>  	mutex_unlock(&sched->reset.lock);
> =20
>  	add_group_kbo_sizes(group->ptdev, group);
> -	mutex_init(&group->fdinfo.lock);
> +	spin_lock_init(&group->fdinfo.lock);
> =20
>  	return gid;
> =20


