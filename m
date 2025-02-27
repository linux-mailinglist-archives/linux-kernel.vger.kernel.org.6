Return-Path: <linux-kernel+bounces-535833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BABA477DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48951885222
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901C3223715;
	Thu, 27 Feb 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ie/o9m7q"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40613A3F2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645176; cv=none; b=DDMALiGkJZgKDYnOKRcX/A4VcZTsgMZ1nWGw1VJr+w1N5ew4ZOjZMysL2i8PAqQR401q5l45zdgU01FQ0NXC+KR2pM80Xp78nQNx5lC9ETamI1CTx3GdwTnCgkdtRmVjCrtvuOeBgbnAW1wTjgpRR6MVtnerbg1a8TvCVSm0WNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645176; c=relaxed/simple;
	bh=zUkbTcy+OeYJQZxEC3Qi5I+EyNPXyUtugXUZ1t3DquI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6aiSzCBBJmbLcri8nHGxzB9TBS/jb9htn4YZb5NhjvI765Zc57zBiIOoerCHWKaPCHjpu54M9/qNR6Ag44okVJJgdzICTCyp58OHY86Qt8ZHiLkut68dARsWWlW7jWEGt7lZ7LgR/Ae81Mab6gfNAlDoN8XOQ+Gu2bHHaqy+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ie/o9m7q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740645172;
	bh=zUkbTcy+OeYJQZxEC3Qi5I+EyNPXyUtugXUZ1t3DquI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ie/o9m7qM9wSdBM2nAQwZ0bE8/AZ0Q4Qhml/8+XAyjuzslLRQfBU01aPZjG/lBKD8
	 M62dQj6HuhOa+E50irBLe5q4hCL8AZdgJZCTBBSYxczDE7kBbMg8aHe/yzQGK27iEf
	 aQygXfsSW/htdUoHbXaKZt8rOBDTAhRkDheqADyv8pUBBXuiVP2d4Q98xbug85H/Z4
	 4c57BdAkx5IYVs8u0Yhq1Uj+AuTqNwVs+HHxwbCgt84Dc/PmF/PuzqioqFh62XRwEr
	 ugKiQ6bfK9ckP35xFt9qXcQj3PSw3xjBXUbOYs8GnrNkX99dgQvzpG3SBujEZ7uRCy
	 eRiz2ZLbGYQxg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EC10417E0605;
	Thu, 27 Feb 2025 09:32:51 +0100 (CET)
Date: Thu, 27 Feb 2025 09:32:37 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [RFC PATCH 3/4] drm/panfrost: Support ARM_64_LPAE_S1 page table
Message-ID: <20250227093237.33aaf496@collabora.com>
In-Reply-To: <20250227093030.1a45b4b7@collabora.com>
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
	<20250226183043.140773-4-ariel.dalessandro@collabora.com>
	<20250227093030.1a45b4b7@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 09:30:30 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> > Bifrost MMUs support AArch64 4kB granule specification. However,
> > panfrost only enables MMU in legacy mode, despite the presence of the
> > HW_FEATURE_AARCH64_MMU feature flag.
> > 
> > This commit adds support to use page tables according to AArch64 4kB
> > granule specification. This feature is enabled conditionally based on
> > the GPU model's HW_FEATURE_AARCH64_MMU feature flag.
> > 
> > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.h |   1 +
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c    | 118 +++++++++++++++++----
> >  drivers/gpu/drm/panfrost/panfrost_regs.h   |  29 +++++
> >  3 files changed, 128 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> > index cffcb0ac7c11..dea252f43c58 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -153,6 +153,7 @@ struct panfrost_device {
> >  };
> >  
> >  struct panfrost_mmu {
> > +	void (*enable)(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);  
> 
> The enable sequence is the same, it's just the transtab, memattr and
> transcfg values that differ depending on the format, so let's prepare
> them at panfrost_mmu init time, and cache them here.

Just to be clear, I meant replace this ->enable() function pointer by a

	struct {
		u64 transtab;
		u64 memattr;
		u64 transcfg;
	} cfg;

field.

> 
> >  	struct panfrost_device *pfdev;
> >  	struct kref refcount;
> >  	struct io_pgtable_cfg pgtbl_cfg;

