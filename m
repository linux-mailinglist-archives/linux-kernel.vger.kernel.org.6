Return-Path: <linux-kernel+bounces-290631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCE89556A2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35251C20EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA6C146013;
	Sat, 17 Aug 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=boris.brezillon@collabora.com header.b="YHyzc5CT"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF2BA2D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723885843; cv=pass; b=IP9nYeh/7kQvXTuu1Rg/WbykZY2imJb1rpYzCw8yKHPu1FuGLZCFZtIVeKLjYb68xUjdqbYP7IFATV4ttt2L8wCg00nWOJRfohnhhFr/zFSLBA04tO6PQuvazVlphdyXoKhnQoaYVvH47hwpJb0oiWN93UOOTMK3wkFg6LCIAnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723885843; c=relaxed/simple;
	bh=58LBaI1XnGZ/PRSJu6xh27P5FrNNgQmVKRWt1Xm/0Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPt13mGaempuJySw7kXHlDvdyEDKhUZTQSnU/lpJq+VFvTlS/ciMYS6N5R+QovLEQ5BKI5BQEXdLhysMjarRo/K1YpQUZgLuU9R6FZrcnIgfXkjXRHTKcH5nAy6JsEZ2jvSES5dt6IXD9INrn8BEhAH4rQ5zX3zDJM3E83LyIU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=boris.brezillon@collabora.com header.b=YHyzc5CT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: adrian.larumbe@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723885826; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CbrN9dpWmzKfek/bxGD2cjr0qnzrH1R4rJO+Ik3UV5DvOdLg82rMQYGb4t2EsOWPojY8EvNcmminoVtHrIF1234d55qVlqDEWsmxgW7tKNsAJ4z683Cq9Dtmc+KEskb4oqt1LuPhzSIAnc8hCb6pRVgvmvQMN65AkxMcrHXu4fk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723885826; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XoPSY4Cd9si3YzzbvJeVCGbi2dYJUaq/FxmYhusGRcI=; 
	b=Niy4CJdVjbcgB+hshkVaJpbkILohdNL4OXGsMOjWzKk5JchZ3iOXNodGBKy0qdLWLdOr8OJTC503BMpkGxBskXJEiLbIjYM8vXpxHcWbba93zaB42RRod7NUvqlwrATcC4NSkEk9BYrxB5vgs/W+NGOYCH1prYedCsOaHXZyYV0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=boris.brezillon@collabora.com;
	dmarc=pass header.from=<boris.brezillon@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723885826;
	s=zohomail; d=collabora.com; i=boris.brezillon@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XoPSY4Cd9si3YzzbvJeVCGbi2dYJUaq/FxmYhusGRcI=;
	b=YHyzc5CTTRpnd2HLQcqrSK11jqV913fO5ejbPtrisyVPhLJrQWDUP9ZOwol66I8T
	cB471ygbRqBkRCBJsopXCns9ds18lmN5JO9IoyKkYkFbnJD+6XCF5QA+/pJFabMGTFk
	h+IKb7MlYyNjjoNjMTiq+lAhpU6UgsNI6+SBauzo=
Received: by mx.zohomail.com with SMTPS id 1723885825146813.2587767508453;
	Sat, 17 Aug 2024 02:10:25 -0700 (PDT)
Date: Sat, 17 Aug 2024 11:10:17 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: flush FW AS caches in slow reset path
Message-ID: <20240817111017.2a010061@collabora.com>
In-Reply-To: <20240816185250.344080-1-adrian.larumbe@collabora.com>
References: <20240816185250.344080-1-adrian.larumbe@collabora.com>
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
X-ZohoMailClient: External

On Fri, 16 Aug 2024 19:52:49 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> In the off-chance that waiting for the firmware to signal its booted stat=
us
> timed out in the fast reset path, one must flush the cache lines for the
> entire FW VM address space before reloading the regions, otherwise stale
> values eventually lead to a scheduler job timeout.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

We probably want Fixes/Cc-stable tags here.

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c  |  8 +++++++-
>  drivers/gpu/drm/panthor/panthor_mmu.c | 19 ++++++++++++++++---
>  drivers/gpu/drm/panthor/panthor_mmu.h |  1 +
>  3 files changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 857f3f11258a..ef232c0c2049 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1089,6 +1089,12 @@ int panthor_fw_post_reset(struct panthor_device *p=
tdev)
>  		panthor_fw_stop(ptdev);
>  		ptdev->fw->fast_reset =3D false;
>  		drm_err(&ptdev->base, "FW fast reset failed, trying a slow reset");
> +
> +		ret =3D panthor_vm_flush_all(ptdev->fw->vm);
> +		if (ret) {
> +			drm_err(&ptdev->base, "FW slow reset failed (couldn't flush FW's AS l=
2cache)");
> +			return ret;
> +		}
>  	}
> =20
>  	/* Reload all sections, including RO ones. We're not supposed
> @@ -1099,7 +1105,7 @@ int panthor_fw_post_reset(struct panthor_device *pt=
dev)
> =20
>  	ret =3D panthor_fw_start(ptdev);
>  	if (ret) {
> -		drm_err(&ptdev->base, "FW slow reset failed");
> +		drm_err(&ptdev->base, "FW slow reset failed (couldn't start the FW )");
>  		return ret;
>  	}
> =20
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index d47972806d50..a77ee5ce691d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -874,14 +874,27 @@ static int panthor_vm_flush_range(struct panthor_vm=
 *vm, u64 iova, u64 size)
>  	if (!drm_dev_enter(&ptdev->base, &cookie))
>  		return 0;
> =20
> -	/* Flush the PTs only if we're already awake */
> -	if (pm_runtime_active(ptdev->base.dev))
> -		ret =3D mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
> +	/*
> +	 * If we made it this far, that means the device is awake, because
> +	 * upon device suspension, all active VMs are given an AS id of -1
> +	 */
> +	ret =3D mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);

I would normally prefer this change to be in its own commit, but given
this is needed to be able to flush caches in the resume path, I'm fine
keeping it in the same patch. The comment is a bit odd now that you
dropped the pm_runtime_active() call though. I would rather have a
comment in mmu_hw_do_operation_locked(), after the AS ID check
explaining that as.id >=3D 0 guarantees that the HW is up and running,
and that we can proceed with the flush operation without calling
pm_runtime_active().

> =20
>  	drm_dev_exit(cookie);
>  	return ret;
>  }
> =20
> +/**
> + * panthor_vm_flush_all() - Flush L2 caches for the entirety of a VM's AS
> + * @vm: VM whose cache to flush
> + *
> + * Return: 0 on success, a negative error code if flush failed.
> + */
> +int panthor_vm_flush_all(struct panthor_vm *vm)
> +{
> +	return panthor_vm_flush_range(vm, vm->base.mm_start, vm->base.mm_range);
> +}
> +
>  static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 s=
ize)
>  {
>  	struct panthor_device *ptdev =3D vm->ptdev;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/pant=
hor/panthor_mmu.h
> index f3c1ed19f973..6788771071e3 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -31,6 +31,7 @@ panthor_vm_get_bo_for_va(struct panthor_vm *vm, u64 va,=
 u64 *bo_offset);
>  int panthor_vm_active(struct panthor_vm *vm);
>  void panthor_vm_idle(struct panthor_vm *vm);
>  int panthor_vm_as(struct panthor_vm *vm);
> +int panthor_vm_flush_all(struct panthor_vm *vm);
> =20
>  struct panthor_heap_pool *
>  panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create);


