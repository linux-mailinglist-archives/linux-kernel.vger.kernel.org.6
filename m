Return-Path: <linux-kernel+bounces-415693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B968E9D39EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679181F2246F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA019F46D;
	Wed, 20 Nov 2024 11:49:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716654EB45
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103393; cv=none; b=jJHPItGmx+40PEYgASqJ0l8P0cJAY6iDZhLj8k/vhDFsyYsnCpljjYqrAU68Gh+WuzFyVHsu2CmxC+0I7gFR9mtA/CtklsqZs28ubeZt+rq98KdC5kZKuh0zdyiDAzKsoa/KWWa8ZiP753CnPHV26yJkVbYJHZebVZLxUc2aiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103393; c=relaxed/simple;
	bh=ucOYVY2QFBswy3PylTzKCq42wtWMLwoefkTGJoQPmHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn5UTiUsYwdfzyXQjCEoC2oALP9sElcwMJLuexkipz+AZi43f83dZnME5j8tT/QyvojQ8JCSjlU6a/nhT+ujX8gwCwInsdObpOKgXfVzIpF3VH/sEmuuYGu88hI8mV7xWJQzvVFsI1cErBPF70j+FInO7iTXQBxyYoVq4HvF9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AA071480
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:50:20 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4BED63F66E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:49:50 -0800 (PST)
Date: Wed, 20 Nov 2024 11:49:40 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Fix compilation failure on panthor_fw.c
Message-ID: <Zz3M1Ji-n1XIi9UX@e110455-lin.cambridge.arm.com>
References: <20241119164455.572771-1-liviu.dudau@arm.com>
 <20241120124125.0bf1b9ac@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120124125.0bf1b9ac@collabora.com>

On Wed, Nov 20, 2024 at 12:41:25PM +0100, Boris Brezillon wrote:
> On Tue, 19 Nov 2024 16:44:55 +0000
> Liviu Dudau <liviu.dudau@arm.com> wrote:
> 
> > Commit 498893bd596e ("drm/panthor: Simplify FW fast reset path") forgot
> > to copy the definition of glb_iface when it move one line of code.
> > 
> > Fixes: Commit 498893bd596e ("drm/panthor: Simplify FW fast reset path")
> > Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Liviu, can you queue this patch to drm-misc if that's not already done?

Thanks, pushed to drm-misc-next, as that's where Karunika's patch landed.

Best regards,
Liviu

> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_fw.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> > index 4bc52b1b1a286..c807b6ce71bd4 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -1133,6 +1133,7 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
> >  		 * This is not needed on a slow reset because FW sections are
> >  		 * re-initialized.
> >  		 */
> > +		struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> >  		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
> >  
> >  		ret = panthor_fw_start(ptdev);
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

