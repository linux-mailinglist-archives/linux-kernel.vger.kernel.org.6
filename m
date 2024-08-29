Return-Path: <linux-kernel+bounces-307307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE476964B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673C628224F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EEE1B5ED1;
	Thu, 29 Aug 2024 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="fTrW7e+N"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5211B4C30
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948486; cv=pass; b=BNMcjqhdNy5BtjfJuc4Sw3jLiJVc7kQ0gXfIMkf5d6PIkRX2SPtlWEo9IXu6ZFQKjA5f0DwT4X8rOJAYWzU9IiIBwg8im5IEGLaRPkF7KMl45diLnmmmQQRz+WioPqWYtscgoYTrL2pLTTjkEVplfOEQbllR1GMS6HaNhZlGMQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948486; c=relaxed/simple;
	bh=0HcdaEdylsCGyRJy2Q38Frq+sDsEr1LQSV/jfzYcQco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju9pTE5wUeA/zJpTqB050zNVfU3yTBYNrRwXn/tvReYJA3nmta8oPFWFYtJdFcCXYcPZfIGs7wOM8QWRiescAcctnC+JulbQOI5bBJEVaW/2VznrMO1EcUE8t/Ln+AWsq5Ztahdwbo9+KDCELQ37OWX8aPBBHBXK5Yd3aAJXKIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=fTrW7e+N; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724948466; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=leG/d0cR2+56+PyJKOdsLHdb8mkE15DZegxKb641DYlutiv/wRzy4PtBg4lWYTNj5BGSL5ZZ8I211hpqE7fScJOxWlnt3v4j3goBGa57Bl4ccD+7M5r6ivOGLFfp6nLyFFSCoo0toUPL8MEOLkHgYX78RPJXBdC5vSzSbBhZFLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724948466; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3eq8FwzxjN39W3vHF7pwhZn8LHFFsJbAnMpv8vr2dmU=; 
	b=DP+KW+2r17rJM5lWP+ymS/fjjCQIlain/EHKZ553sMBlV9dEsc7n7HqrLn0aLJUMwrjgBJU2+IkbeNwfW+bU/HXjReNBEi5MQ2oNbdoYoruxWXNzt8j4J2wkmi6dQ8Z5E9sXqLgmD2Wj+ukcCoGMsebAfDT0wBISrSLe653ZXCA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724948466;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=3eq8FwzxjN39W3vHF7pwhZn8LHFFsJbAnMpv8vr2dmU=;
	b=fTrW7e+Nxz366hxitPPr3zy7AUb5A2mSsY6baKlgXmsv9JHdaZBWPRDQ4iUZkTDB
	dVFZ+ty5Mt4Xmo4/GdfdVepiNi6ubJd5gcxSFDlJuSh2Wh2X7XoZYYZQjTFVPugN8D4
	/4XVARxU0BoBZdVYErbJldC/X/shB7EFTZHHrSo0=
Received: by mx.zohomail.com with SMTPS id 1724948464346650.5979957472007;
	Thu, 29 Aug 2024 09:21:04 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:21:00 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: flush FW AS caches in slow reset path
Message-ID: <lmle5ub5y2tz6vyamqvgvfqrbw6gymgncw3hn4s23zrjf63bmd@rj7aioyqy4uo>
References: <20240816185250.344080-1-adrian.larumbe@collabora.com>
 <20240817111017.2a010061@collabora.com>
 <ZtCMUg-PoOUH98Ub@e110455-lin.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtCMUg-PoOUH98Ub@e110455-lin.cambridge.arm.com>

On 29.08.2024 15:57, Liviu Dudau wrote:
> Hi Adrián,
> 
> On Sat, Aug 17, 2024 at 11:10:17AM +0200, Boris Brezillon wrote:
> > On Fri, 16 Aug 2024 19:52:49 +0100
> > Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> > 
> > > In the off-chance that waiting for the firmware to signal its booted status
> > > timed out in the fast reset path, one must flush the cache lines for the
> > > entire FW VM address space before reloading the regions, otherwise stale
> > > values eventually lead to a scheduler job timeout.
> > > 
> > > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > 
> > We probably want Fixes/Cc-stable tags here.
> > 
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_fw.c  |  8 +++++++-
> > >  drivers/gpu/drm/panthor/panthor_mmu.c | 19 ++++++++++++++++---
> > >  drivers/gpu/drm/panthor/panthor_mmu.h |  1 +
> > >  3 files changed, 24 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> > > index 857f3f11258a..ef232c0c2049 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > > @@ -1089,6 +1089,12 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
> > >  		panthor_fw_stop(ptdev);
> > >  		ptdev->fw->fast_reset = false;
> > >  		drm_err(&ptdev->base, "FW fast reset failed, trying a slow reset");
> > > +
> > > +		ret = panthor_vm_flush_all(ptdev->fw->vm);
> > > +		if (ret) {
> > > +			drm_err(&ptdev->base, "FW slow reset failed (couldn't flush FW's AS l2cache)");
> > > +			return ret;
> > > +		}
> > >  	}
> > >  
> > >  	/* Reload all sections, including RO ones. We're not supposed
> > > @@ -1099,7 +1105,7 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
> > >  
> > >  	ret = panthor_fw_start(ptdev);
> > >  	if (ret) {
> > > -		drm_err(&ptdev->base, "FW slow reset failed");
> > > +		drm_err(&ptdev->base, "FW slow reset failed (couldn't start the FW )");
> > >  		return ret;
> > >  	}
> > >  
> > > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > > index d47972806d50..a77ee5ce691d 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > > @@ -874,14 +874,27 @@ static int panthor_vm_flush_range(struct panthor_vm *vm, u64 iova, u64 size)
> > >  	if (!drm_dev_enter(&ptdev->base, &cookie))
> > >  		return 0;
> > >  
> > > -	/* Flush the PTs only if we're already awake */
> > > -	if (pm_runtime_active(ptdev->base.dev))
> > > -		ret = mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
> > > +	/*
> > > +	 * If we made it this far, that means the device is awake, because
> > > +	 * upon device suspension, all active VMs are given an AS id of -1
> > > +	 */
> > > +	ret = mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
> > 
> > I would normally prefer this change to be in its own commit, but given
> > this is needed to be able to flush caches in the resume path, I'm fine
> > keeping it in the same patch. The comment is a bit odd now that you
> > dropped the pm_runtime_active() call though. I would rather have a
> > comment in mmu_hw_do_operation_locked(), after the AS ID check
> > explaining that as.id >= 0 guarantees that the HW is up and running,
> > and that we can proceed with the flush operation without calling
> > pm_runtime_active().
> 
> Given Boris' comments, are you planning on sending a v2?

Sure, I got caught up in a bunch of higher priority tasks this week, but I'll be
sending a v2 either before the end of this week or early next week.

> Best regards,
> Liviu
> 
> > 
> > >  
> > >  	drm_dev_exit(cookie);
> > >  	return ret;
> > >  }
> > >  
> > > +/**
> > > + * panthor_vm_flush_all() - Flush L2 caches for the entirety of a VM's AS
> > > + * @vm: VM whose cache to flush
> > > + *
> > > + * Return: 0 on success, a negative error code if flush failed.
> > > + */
> > > +int panthor_vm_flush_all(struct panthor_vm *vm)
> > > +{
> > > +	return panthor_vm_flush_range(vm, vm->base.mm_start, vm->base.mm_range);
> > > +}
> > > +
> > >  static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
> > >  {
> > >  	struct panthor_device *ptdev = vm->ptdev;
> > > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> > > index f3c1ed19f973..6788771071e3 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> > > +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> > > @@ -31,6 +31,7 @@ panthor_vm_get_bo_for_va(struct panthor_vm *vm, u64 va, u64 *bo_offset);
> > >  int panthor_vm_active(struct panthor_vm *vm);
> > >  void panthor_vm_idle(struct panthor_vm *vm);
> > >  int panthor_vm_as(struct panthor_vm *vm);
> > > +int panthor_vm_flush_all(struct panthor_vm *vm);
> > >  
> > >  struct panthor_heap_pool *
> > >  panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create);
> > 

Adrian Larumbe

