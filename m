Return-Path: <linux-kernel+bounces-539811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765C1A4A938
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD33B3122
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B110C1BEF6D;
	Sat,  1 Mar 2025 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLQ7eU13"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F723F37C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740809070; cv=none; b=vDtMPzzpX243SyF09jYZrzX/aPLMUz1yPWPodHE7SH/OhJAsbwPREUWGl7yWeDvcz2RCrkRkb0XUbC8GzUMN8hwc/84bFqKd0z5pTmNW+zf4bF8Go+hutST6kesLfRjGrPScsfn5yz2XX3fQ+zMtToFCoiUVCIsgOWC+3xLd+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740809070; c=relaxed/simple;
	bh=c3on3RmOuYQNzLqfDmHQArk971VhgmNpJQD9KcEGlcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSj0nLF7rHz7+A4NOP+E9/tSFiPEYBqTOMA/I3HhJnNRo5mj5Z729k8jDJJcqYNMH/9YgtDPABgidoFSnPgoPRGOkUyml0khSE5Iu2SV0EZ0tq3hBiSwAuf7v1tMFd5XZZRIQVGAiZNr0XyaAxHLy3XH42Xfhre7WbOKAY40gzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLQ7eU13; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740809068; x=1772345068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=c3on3RmOuYQNzLqfDmHQArk971VhgmNpJQD9KcEGlcA=;
  b=PLQ7eU13UELSKQ/PTHal8cF1QaZ1MsY1hIeeJrwBr+n/0sKvEtss1PzG
   QZXnPZUd+jZoftiMp+KL3ZOwTvysVK+CF8XlrV9sWI75Xv7PE6gEDkI4b
   Q2BOXWrUg6pQTfR9DvS5PItTBqJ7y+Yjjm5n43Vst189lQcJYV9gQqt3m
   FU/zBkyLD3tOA6Ie53t7IMFxykW7afh6qh3sHJj3jKQN1AAQMKjOlpD2g
   TK7lrJqFGFgGIFP8FlDYUOHr/1cxWVDbcjhoRKBhpTdAK5nPrWBSTbFz3
   GMkie0O4OinOZYvC8zOAzX+CMdB2Cr4mCqOhDX5QTgLQDRyDp2J/hERk9
   A==;
X-CSE-ConnectionGUID: Fhd+9yd2RNKDDhkZX6u3PA==
X-CSE-MsgGUID: 3o57YK3ITz+G/TzSyXfkGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="59283253"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="59283253"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 22:04:27 -0800
X-CSE-ConnectionGUID: 1l0M562iQ7u6+0aBrCEQxw==
X-CSE-MsgGUID: sQ+TNsB6TRG0lvoNNCBkdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="117308986"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 22:04:24 -0800
Date: Sat, 1 Mar 2025 08:04:21 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	'Christian =?iso-8859-1?Q?K=F6nig'?= <christian.koenig@amd.com>,
	siqueira@igalia.com, airlied@gmail.com, simona@ffwll.ch,
	rodrigo.vivi@intel.com, jani.nikula@linux.intel.com
Subject: Re: [PATCH 2/2] drm/amdgpu: Make use of drm_wedge_app_info
Message-ID: <Z8KjZfLYjH6ehYwy@black.fi.intel.com>
References: <20250228121353.1442591-1-andrealmeid@igalia.com>
 <20250228121353.1442591-3-andrealmeid@igalia.com>
 <Z8HO-s_otb2u44V7@black.fi.intel.com>
 <38b9cc8b-2a55-4815-a19f-f5bdf0f7687c@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38b9cc8b-2a55-4815-a19f-f5bdf0f7687c@igalia.com>

On Fri, Feb 28, 2025 at 06:49:43PM -0300, André Almeida wrote:
> Hi Raag,
> 
> On 2/28/25 11:58, Raag Jadav wrote:
> > On Fri, Feb 28, 2025 at 09:13:53AM -0300, André Almeida wrote:
> > > To notify userspace about which app (if any) made the device get in a
> > > wedge state, make use of drm_wedge_app_info parameter, filling it with
> > > the app PID and name.
> > > 
> > > Signed-off-by: André Almeida <andrealmeid@igalia.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++--
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
> > >   2 files changed, 22 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 00b9b87dafd8..e06adf6f34fd 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -6123,8 +6123,23 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> > >   	atomic_set(&adev->reset_domain->reset_res, r);
> > > -	if (!r)
> > > -		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> > > +	if (!r) {
> > > +		struct drm_wedge_app_info aux, *info = NULL;
> > > +
> > > +		if (job) {
> > > +			struct amdgpu_task_info *ti;
> > > +
> > > +			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
> > > +			if (ti) {
> > > +				aux.pid = ti->pid;
> > > +				aux.comm = ti->process_name;
> > > +				info = &aux;
> > > +				amdgpu_vm_put_task_info(ti);
> > > +			}
> > > +		}
> > Is this guaranteed to be guilty app and not some scheduled worker?
> 
> This is how amdgpu decides which app is the guilty one earlier in the code
> as in the print:
> 
>     ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
> 
>     "Process information: process %s pid %d thread %s pid %d\n"
> 
> So I think it's consistent with what the driver thinks it's the guilty
> process.

Sure, but with something like app_info we're kind of hinting to userspace
that an application was _indeed_ involved with reset. Is that also guaranteed?

Is it possible that an application needlessly suffers from a false positive
scenario (reset due to other factors)?

Raag

