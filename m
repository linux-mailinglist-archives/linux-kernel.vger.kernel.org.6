Return-Path: <linux-kernel+bounces-181611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803868C7E90
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29A6283728
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C0B1DA2F;
	Thu, 16 May 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cAJw7pGS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04051799B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898824; cv=none; b=BiUWC5xGswpQ0rV5HO1fYPcHT3aDgC40L51lcrYKTR+izU9u1N9tWIorG9F95q+HekQC91hToOgMl7AoTQX/+4J9UpFbsCgUcjCR53/9V+RvUXBG9tgziDy4O/kzQybj37S75eLp0a1d1+igYdShADXSiMkEO/BQ0KttZ/MBEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898824; c=relaxed/simple;
	bh=fEbX+7ylWqAIZwkFyJWk3fwrpqNblL72bxWRqduXUxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwxE1B7erqm9WjKmonMP61VIk9+NwRm1MOFu2OJFxJCVezI4rBqgokmbH3A25WOyicICdVLwaDCAdQHJkGMNtvdU0OLb6Q6oMNNz/NnecwRJZP1bCnhCCYwy0mP8ROW9X1DVGhrRpxygzA9EhiV/TGijUzGeF0cp1ptYGbsRw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cAJw7pGS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715898821;
	bh=fEbX+7ylWqAIZwkFyJWk3fwrpqNblL72bxWRqduXUxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAJw7pGS7pPdPtQ50YTVb2xcfEYvPH0HyhvbVrebtFFvf/w0Fr09nLNoqO8IXQMmt
	 b2fKlNn2efiah8db6Cum4qrnugXup+HiOspxIFEG8sT8WPjzlOR72rN7n24M0SNC43
	 /VeyhULkNtguIsx5ABXOIpmPeTZQRLxW2347+dO0xmSVd43NtOydfMJCkudFXKyc3l
	 iSth3ioiebD0lP3zVbVItwi5aj65F3s8F0SZZdBD0+baPxwj710PABw39IzNvlHanp
	 qTDCONsNpIoh0vJBrN8JlAoi3j9DrcbykWA0FIedN8UETTWK1Edbo5blucsXfaM1N5
	 uowUlW4DhiDmw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BD8183782190;
	Thu, 16 May 2024 22:33:40 +0000 (UTC)
Date: Thu, 16 May 2024 23:33:40 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/panthor: Enable fdinfo for memory stats
Message-ID: <sbti5hnhux35e334yxencz3nyt64l5ruvtcpjyim55mkm4r65h@qojfe6vldsqp>
References: <20240423213240.91412-1-adrian.larumbe@collabora.com>
 <20240423213240.91412-4-adrian.larumbe@collabora.com>
 <ZilCqPlJiTLfNQcG@e110455-lin.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZilCqPlJiTLfNQcG@e110455-lin.cambridge.arm.com>

On 24.04.2024 18:34, Liviu Dudau wrote:
> Hello,
> 
> On Tue, Apr 23, 2024 at 10:32:36PM +0100, Adrián Larumbe wrote:
> > When vm-binding an already-created BO, the entirety of its virtual size is
> > then backed by system memory, so its RSS is always the same as its virtual
> > size.
> 
> How is that relevant to this patch? Or to put it differently: how are your
> words describing your code change here?

I think I wrote this as a throw-back to the time when we handled RSS calculations for
Panfrost objects, because heap BO's would be mapped on demand at every page fault.

I understand that without mention of this the remark seems out of context, so
depending on your taste I can either expand the message to underline this, or perhaps
drop it altogether.

I think I'd rather go for the latter, since the fact that panthor_gem_funcs includes
no binding for drm_gem_object_funcs::rss() should be enough of a hint at this.  

> > 
> > Also, we consider a PRIME imported BO to be resident if its matching
> > dma_buf has an open attachment, which means its backing storage had already
> > been allocated.
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Best regards,
> Liviu
> 
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_gem.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> > index d6483266d0c2..386c0dfeeb5f 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gem.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> > @@ -143,6 +143,17 @@ panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
> >  	return drm_gem_prime_export(obj, flags);
> >  }
> >  
> > +static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
> > +{
> > +	struct panthor_gem_object *bo = to_panthor_bo(obj);
> > +	enum drm_gem_object_status res = 0;
> > +
> > +	if (bo->base.base.import_attach || bo->base.pages)
> > +		res |= DRM_GEM_OBJECT_RESIDENT;
> > +
> > +	return res;
> > +}
> > +
> >  static const struct drm_gem_object_funcs panthor_gem_funcs = {
> >  	.free = panthor_gem_free_object,
> >  	.print_info = drm_gem_shmem_object_print_info,
> > @@ -152,6 +163,7 @@ static const struct drm_gem_object_funcs panthor_gem_funcs = {
> >  	.vmap = drm_gem_shmem_object_vmap,
> >  	.vunmap = drm_gem_shmem_object_vunmap,
> >  	.mmap = panthor_gem_mmap,
> > +	.status = panthor_gem_status,
> >  	.export = panthor_gem_prime_export,
> >  	.vm_ops = &drm_gem_shmem_vm_ops,
> >  };
> > -- 
> > 2.44.0
> > 

Adrian Larumbe

