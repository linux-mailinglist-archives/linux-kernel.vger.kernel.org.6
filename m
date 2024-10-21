Return-Path: <linux-kernel+bounces-374598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CADB9A6CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF338B25B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF31FA25D;
	Mon, 21 Oct 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QL9rYIjk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6211F7092
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522347; cv=none; b=DjuAhb8nLFdOy3SQ23jKj0WL41nsIrAT44f9swGwMS90bZGww7s/P7aZjQXNfQKP8sIKladcwlF5M/h2bPDuk/WI+H6wAzf/+TM3eYTr4bpVpjaRrI244pW77GrjrFnswrnkIYO/8Xa0OgJhqeQmwi4akP2+ZBUpxSj41/C8hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522347; c=relaxed/simple;
	bh=wkJxBeWw8cJcPyHRU5C7Lde63N68ha/g+mqE2GPufHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZvIzd4nHY6D0Z3mJeU/Um+0SRZ5AsB7LWGLri4Z04mzYF4QOV4xaWqpOFymauhfQ8PwcLlYcyBmCRpqHBmOtolboGcxNhSRzL3Z3we6cIS4cSAE9NTQW348ByY0pzsNjpoC+aDUD0qbo0Kpwu+RjyEmnxIDV2nmoX4IO+n1rjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QL9rYIjk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729522343;
	bh=wkJxBeWw8cJcPyHRU5C7Lde63N68ha/g+mqE2GPufHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QL9rYIjk/V09JEX+EtdmjjpPaNrMETwIuMD9vxg6VMMP6hauJFT24XJwVjUOeHhV2
	 GAZnZES4a8UNBaNaAKxS7K4Gmr7Iximt4VVCh08+fart7NCz4mY/WdJpyn7OoYd5f3
	 080uqKU2ypQMxGPcvY7jxQeV+yDJrOG9WsAEEbCaJoEbA77La/VAHWLJQTgiDlPeCn
	 RsnYzsFYVYOV/wVAcvLmagVIthT0NVUJGklIpvQaRYO2sl70c/pUttYNR5xH8D0AfF
	 01EytTm5GtJZax5oZB4rKj6ExSfqx/yAA+EVSukbdZYq8pYHkax4PjNBio5EGSoak1
	 Z5j2aWibtlfYg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 25EF817E1543;
	Mon, 21 Oct 2024 16:52:23 +0200 (CEST)
Date: Mon, 21 Oct 2024 16:52:16 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Philipp Zabel
 <p.zabel@pengutronix.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] drm/panfrost: Avoid re-enabling job interrupts in
 the reset path
Message-ID: <20241021165216.388d6643@collabora.com>
In-Reply-To: <20241014233758.994861-6-adrian.larumbe@collabora.com>
References: <20241014233758.994861-1-adrian.larumbe@collabora.com>
	<20241014233758.994861-6-adrian.larumbe@collabora.com>
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

On Tue, 15 Oct 2024 00:31:41 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Rather than remasking interrupts after a device reset in the main reset
> path, allow selecting whether to do this with an additional bool paramete=
r.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c |  6 +++---
>  drivers/gpu/drm/panfrost/panfrost_device.h |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 14 +++++---------
>  drivers/gpu/drm/panfrost/panfrost_job.h    |  2 +-
>  4 files changed, 10 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 4fe29286bbe3..a2a58501cbd9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -395,20 +395,20 @@ bool panfrost_exception_needs_reset(const struct pa=
nfrost_device *pfdev,
>  	return false;
>  }
> =20
> -void panfrost_device_reset(struct panfrost_device *pfdev)
> +void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_jo=
b_int)
>  {
>  	panfrost_gpu_soft_reset(pfdev);
> =20
>  	panfrost_gpu_power_on(pfdev);
>  	panfrost_mmu_reset(pfdev);
> -	panfrost_job_enable_interrupts(pfdev);
> +	panfrost_job_enable_interrupts(pfdev, enable_job_int);
>  }
> =20
>  static int panfrost_device_runtime_resume(struct device *dev)
>  {
>  	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> =20
> -	panfrost_device_reset(pfdev);
> +	panfrost_device_reset(pfdev, true);
>  	panfrost_devfreq_resume(pfdev);
> =20
>  	return 0;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index d9aea2c2cbe5..fc83d5e104a3 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -205,7 +205,7 @@ int panfrost_unstable_ioctl_check(void);
> =20
>  int panfrost_device_init(struct panfrost_device *pfdev);
>  void panfrost_device_fini(struct panfrost_device *pfdev);
> -void panfrost_device_reset(struct panfrost_device *pfdev);
> +void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_jo=
b_int);
> =20
>  extern const struct dev_pm_ops panfrost_pm_ops;
> =20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 52ec9dc2397c..68be555c6c52 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -414,7 +414,7 @@ static struct dma_fence *panfrost_job_run(struct drm_=
sched_job *sched_job)
>  	return fence;
>  }
> =20
> -void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
> +void panfrost_job_enable_interrupts(struct panfrost_device *pfdev, bool =
enable_job_int)
>  {
>  	int j;
>  	u32 irq_mask =3D 0;
> @@ -426,7 +426,8 @@ void panfrost_job_enable_interrupts(struct panfrost_d=
evice *pfdev)
>  	}
> =20
>  	job_write(pfdev, JOB_INT_CLEAR, irq_mask);
> -	job_write(pfdev, JOB_INT_MASK, irq_mask);
> +	if (enable_job_int)
> +		job_write(pfdev, JOB_INT_MASK, irq_mask);
>  }

This makes things utterly confusing. Now you have a function named
panfrost_job_enable_interrupts() with a boolean encoding whether you
want to enable interrupts or not. If we really want to dissociate the
two things done in panfrost_job_enable_interrupts(), I'd rather go for
a reset_interrupts()/enable_interrupts() split, with reset_interrupts
clearing the IRQs, and enable_interrupts() unmasking the interrupts and
clearing the COMP_BIT_JOB bit.

> =20
>  void panfrost_job_suspend_irq(struct panfrost_device *pfdev)
> @@ -718,12 +719,7 @@ panfrost_reset(struct panfrost_device *pfdev,
>  	spin_unlock(&pfdev->js->job_lock);
> =20
>  	/* Proceed with reset now. */
> -	panfrost_device_reset(pfdev);
> -
> -	/* panfrost_device_reset() unmasks job interrupts, but we want to
> -	 * keep them masked a bit longer.
> -	 */
> -	job_write(pfdev, JOB_INT_MASK, 0);
> +	panfrost_device_reset(pfdev, false);
> =20
>  	/* GPU has been reset, we can clear the reset pending bit. */
>  	atomic_set(&pfdev->reset.pending, 0);
> @@ -898,7 +894,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>  		}
>  	}
> =20
> -	panfrost_job_enable_interrupts(pfdev);
> +	panfrost_job_enable_interrupts(pfdev, true);
> =20
>  	return 0;
> =20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/pa=
nfrost/panfrost_job.h
> index ec581b97852b..3b8b712c1722 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> @@ -46,7 +46,7 @@ void panfrost_job_close(struct panfrost_file_priv *panf=
rost_priv);
>  int panfrost_job_get_slot(struct panfrost_job *job);
>  int panfrost_job_push(struct panfrost_job *job);
>  void panfrost_job_put(struct panfrost_job *job);
> -void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
> +void panfrost_job_enable_interrupts(struct panfrost_device *pfdev, bool =
enable_job_int);
>  void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
>  int panfrost_job_is_idle(struct panfrost_device *pfdev);
> =20


