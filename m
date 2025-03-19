Return-Path: <linux-kernel+bounces-568060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77734A68DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD3C18980D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F8E2561D8;
	Wed, 19 Mar 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="hPic6oWl"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B53255250
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390370; cv=pass; b=rIFsZbbfdYsWv41dotm2UTAKBzF/orxljDwOqy64GDddxuIADgjcNc569nzV6YIdc+aGAjMNz2nEcwH4SONGyXUJHWCvm05VBw40KaHCUQub6NBORdEHE74CmtSTQO2pUbMbOdcbj4Z0fo03IEuZlriw3U5EjgXxoiBqekkO3Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390370; c=relaxed/simple;
	bh=keNqvjk1BspEliFLEJG5RiYo633/JQb6/ata1joxIpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOoeIaqjYQWM4zj6cthePpTbZHr9T0GS4t236ZEvGY2O+J2TqZ2zgr0BKQtZQInJipEa7kHKGkZxrVOlPkxzgfK1uhPhiozz7u/7kbP8s7ejpoGjSnaj+H9NX/7KTVaSXz6znnYjCV4bqTo41ewvG4Zlytq95jeOndfXhzMciT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=hPic6oWl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742390344; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AE04bqYdOmd4y/Ti4I8ZrqcXU+iI4qwLGzIAdaalaT5SdgDgy3z0oEgIheHbDqAGgp74WDAY8NS+1zOpcFPPU/eMML+r/52c29VEeVaf26LYt1ICU9SoK8k7sTFsHLzv5LNh3Yela/DdNaKWad2tPetgxn2ky6awSzIQQ1PP21E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742390344; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JBcdHCby/+21EQFZYHa9atx7puWClBYGnUuN2V8HkI0=; 
	b=HBnqTQVLrLJIn+txVEwc2d4dvWqmanSoHd2BTYTnTz76TJ752aJni8VyX0L3W5X/nW7XpxudNg93lF1ax5PGU4z6Hxak9vBLM4Z5o4aZuZxdfCDddTYI80a8BPXVrLA/zQnvk/ewtTAlaRvb27qRVToezEkKZ6BEUbh4aXy9d2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742390344;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=JBcdHCby/+21EQFZYHa9atx7puWClBYGnUuN2V8HkI0=;
	b=hPic6oWlXw08j0lUiMNzumyUMUQ4wEfjJAYqgl+ICvd5jUW2NoA9ACQg2nVjjAIm
	GtAoplo1CbJu8wHC4TzzzWe0kMkGrb+1US+WMbK3tyRR2QMJWsUd0ZivVftKZIf30vr
	lgVOqSQU3M6hCdqNbMCT8bowBWOiirlgvBcJPmiI=
Received: by mx.zohomail.com with SMTPS id 1742390342342323.6404185514773;
	Wed, 19 Mar 2025 06:19:02 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:18:53 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/panthor: Display heap chunk entries in DebugFS
 GEMS file
Message-ID: <hvbohkjfpsahl4kzildhy6nekiz3a4mxp7bwova6z45ibpwl6r@7t7wbwmuw6mc>
References: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
 <20250316215139.3940623-5-adrian.larumbe@collabora.com>
 <20250317093101.1784499d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317093101.1784499d@collabora.com>

On 17.03.2025 09:31, Boris Brezillon wrote:
> On Sun, 16 Mar 2025 21:51:35 +0000
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
>
> > Expand the driver's DebugFS GEMS file to display entries for the heap
> > chunks' GEM objects, both those allocated at heap creation time through an
> > ioctl(), or in response to a tiler OOM event.
> >
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_heap.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> > index db0285ce5812..520d1fcf5c36 100644
> > --- a/drivers/gpu/drm/panthor/panthor_heap.c
> > +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> > @@ -139,6 +139,10 @@ static int panthor_alloc_heap_chunk(struct panthor_device *ptdev,
> >  	struct panthor_heap_chunk *chunk;
> >  	struct panthor_heap_chunk_header *hdr;
> >  	int ret;
> > +#ifdef CONFIG_DEBUG_FS
> > +	struct panthor_gem_object *obj;
> > +	const char *label;
> > +#endif
> >
> >  	chunk = kmalloc(sizeof(*chunk), GFP_KERNEL);
> >  	if (!chunk)
> > @@ -180,6 +184,17 @@ static int panthor_alloc_heap_chunk(struct panthor_device *ptdev,
> >  	heap->chunk_count++;
> >  	mutex_unlock(&heap->lock);
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +	obj = to_panthor_bo(chunk->bo->obj);
> > +
> > +	mutex_lock(&ptdev->gems_lock);
> > +	list_add_tail(&obj->gems_node, &ptdev->gems);
> > +	mutex_unlock(&ptdev->gems_lock);
> > +
> > +	label = kstrdup_const("\"Tiler heap chunk\"", GFP_KERNEL);
>
> Do we really need the extra quotes around 'Tiler heap chunk'?

We want them quoted like this so that the BO name can be told apart from the
the extra tagging information (like modifiers) and any suffix sent down from gl

> > +	panthor_gem_label_bo(chunk->bo->obj, label);
> > +#endif
>
> Let's define a helper to assign a label to a kernel BO instead of
> open-coding it here. BTW, I suspect we'll want to assign labels to
> other kernel BOs too (FW buffers).
>
> > +
> >  	return 0;
> >
> >  err_destroy_bo:


Adrian Larumbe

