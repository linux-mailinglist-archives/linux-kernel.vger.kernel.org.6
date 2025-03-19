Return-Path: <linux-kernel+bounces-568421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80910A69525
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE59F19C74B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833E1DEFD8;
	Wed, 19 Mar 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UZjhrxqV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37847170A11
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402354; cv=none; b=VdhPQBHBp7bJxvnAekVCVh2Yh+M/zlHKA8ARJ9bkCTuflZIoJq3xzk8no6AHc2uoim67a12pz1StkZIz3mQ5IprY0M7eqP6DZ7DgFM0RakcN50CAjalTYeorHAl5hcFVRNCb3ov3CNT8nvptA78LKaeEeTxZGkzIJ+ByGSvwPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402354; c=relaxed/simple;
	bh=q51YU4uzrikIxbNXlsT0rklgixPcNJfbNrnKOjwB43w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsfJzdTpmBu/of4Cywlndc/sWPlwFnRcSYz1bOrPcczRDrGLtDJ25EIHS4/05Gy4fXq3HuaJ6pxux+ekKgG9p2llfcRigSJcj4uQaV+sIwn13kimkRGFHhJT+80XlFwe9aUAdH45VhqgGqwWw4GguDjqFpcfN9VM3gS8zg3ZmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UZjhrxqV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742402349;
	bh=q51YU4uzrikIxbNXlsT0rklgixPcNJfbNrnKOjwB43w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UZjhrxqVSOOhdwXR6hmtoOKupl+ft2FnTAFOmbguWV8alJ6SfGmIGQ1eL/YcqSVT2
	 zGUGvZMteSF4aPFiggL/tZTSwFYjJAtTJYXgyt/yqysbSMHd5V9/ugDkat4W78cJnD
	 hpjyaU803kIZgIhr6M9erWHCCYQSI+yEgcreD5u/bTDH1PACRglqTlEes0v/b7TwHq
	 hKvMUVyvLcVkmyoDN2G9HqGOfFa/W9CawOYsPSKuCn259sGlobVeWRRhjQVuluVzO6
	 Dfuz/m/CqEx+dG8Nr3VovL1iUeJNw6DTGHE4XSnqv14sa36/0Q4htBixMmU462DUgH
	 EO9L89jIxB5qQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C6BD017E0B12;
	Wed, 19 Mar 2025 17:39:08 +0100 (CET)
Date: Wed, 19 Mar 2025 17:39:03 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/panthor: Display heap chunk entries in DebugFS
 GEMS file
Message-ID: <20250319173903.5e8a9479@collabora.com>
In-Reply-To: <hvbohkjfpsahl4kzildhy6nekiz3a4mxp7bwova6z45ibpwl6r@7t7wbwmuw6mc>
References: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
	<20250316215139.3940623-5-adrian.larumbe@collabora.com>
	<20250317093101.1784499d@collabora.com>
	<hvbohkjfpsahl4kzildhy6nekiz3a4mxp7bwova6z45ibpwl6r@7t7wbwmuw6mc>
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

On Wed, 19 Mar 2025 13:18:53 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 17.03.2025 09:31, Boris Brezillon wrote:
> > On Sun, 16 Mar 2025 21:51:35 +0000
> > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> > =20
> > > Expand the driver's DebugFS GEMS file to display entries for the heap
> > > chunks' GEM objects, both those allocated at heap creation time throu=
gh an
> > > ioctl(), or in response to a tiler OOM event.
> > >
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_heap.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm=
/panthor/panthor_heap.c
> > > index db0285ce5812..520d1fcf5c36 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_heap.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> > > @@ -139,6 +139,10 @@ static int panthor_alloc_heap_chunk(struct panth=
or_device *ptdev,
> > >  	struct panthor_heap_chunk *chunk;
> > >  	struct panthor_heap_chunk_header *hdr;
> > >  	int ret;
> > > +#ifdef CONFIG_DEBUG_FS
> > > +	struct panthor_gem_object *obj;
> > > +	const char *label;
> > > +#endif
> > >
> > >  	chunk =3D kmalloc(sizeof(*chunk), GFP_KERNEL);
> > >  	if (!chunk)
> > > @@ -180,6 +184,17 @@ static int panthor_alloc_heap_chunk(struct panth=
or_device *ptdev,
> > >  	heap->chunk_count++;
> > >  	mutex_unlock(&heap->lock);
> > >
> > > +#ifdef CONFIG_DEBUG_FS
> > > +	obj =3D to_panthor_bo(chunk->bo->obj);
> > > +
> > > +	mutex_lock(&ptdev->gems_lock);
> > > +	list_add_tail(&obj->gems_node, &ptdev->gems);
> > > +	mutex_unlock(&ptdev->gems_lock);
> > > +
> > > +	label =3D kstrdup_const("\"Tiler heap chunk\"", GFP_KERNEL); =20
> >
> > Do we really need the extra quotes around 'Tiler heap chunk'? =20
>=20
> We want them quoted like this so that the BO name can be told apart from =
the
> the extra tagging information (like modifiers) and any suffix sent down f=
rom gl

Feels like you want the kernel to use a format that's used by mesa but
not really standardized. What happens if we decide to change the
formatting there? Suddenly, kernel BOs become the outliers again, and
you're back to the inconsistency you were trying to avoid. My
recommendation would be to keep kernel BO labels simple (just a regular
string, no quoting, no extra props) and let the debugfs printer
segregate kernel BOs from user BOs to make the distinction clear.

