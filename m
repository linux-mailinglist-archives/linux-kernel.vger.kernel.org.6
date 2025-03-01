Return-Path: <linux-kernel+bounces-539809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A966DA4A933
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670A8189BFE8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938EA1BE86E;
	Sat,  1 Mar 2025 05:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzXI0Yr8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9D442C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740808395; cv=none; b=uBrxZrNZxWREgyzd1lUFEKd119whKhxeRD50Iq3VjtJBfD5TRVFIwDDVkOjVTK4m8909K/6EZaqCRK2gJJcDHvl/7vC12Qs0U4Cst9aBOVbO4M8x8PSuoXSJ36006E0rwVgHc/J1/a6fEQ22eVVeKaN67KIx0hWkObXBA8tYFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740808395; c=relaxed/simple;
	bh=SOKX+bxG8+nhQMIjkrqXwpSaA/qreBbJ3mAB/IkyMSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm2uscxxNz+TVDei2ywQjK332TqgBybIln9i4/oKyNLYDj5lc3Qspn/s9PDpq5H9850Z8rN+LhOZlHx2cRyfo5MOwF+xEeedoDI22pQgFbtbosEnEauk0Seak3xqFOylzXJ3Ai02XWT0j7E1xQ5Z3Wi/T3SDKjyAM86yBL+i6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzXI0Yr8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740808394; x=1772344394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SOKX+bxG8+nhQMIjkrqXwpSaA/qreBbJ3mAB/IkyMSo=;
  b=FzXI0Yr8lMeVc9DPhgSFTfTHNtXvFUJPQ/rfjjzygxNIcwqSmvAcCse6
   WeKaMP5WCUpBPRfIW6LzxG3DXuiVKLLkGVj0HkEdQf9ahqPDWgUwdEy88
   Gsqv91pAN94jZYZu0rA93AlyHRtjDS8+CKL5ewGMooFHfROJUKQpUDSuM
   b/5+Qx8QzcEoh/OS+n+TEgcvU4FxD8QQLuteq2wSBnzYncuOGGpzv5ucM
   SlrPPpel3ixUsE/9taOwJpgIyRkoOQYAD1RBVKJfDPAYpQZxKRdPeQZU7
   Ldq8q/QDuzAf4QAI/Ty89qAh3FnbP5BJGK4NU0Db1MopLTRVF7xCfCG+T
   Q==;
X-CSE-ConnectionGUID: BPNUg2lFSfGMaoEJRC+uaQ==
X-CSE-MsgGUID: i9gFfdtOTD6dKfDbAoXfuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45394247"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="45394247"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 21:53:13 -0800
X-CSE-ConnectionGUID: 1GMxVJ97S22CtsYmBWheHA==
X-CSE-MsgGUID: nUaMSS53Tr6jbFoeUT9Mew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="117279593"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 21:53:10 -0800
Date: Sat, 1 Mar 2025 07:53:06 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	'Christian =?iso-8859-1?Q?K=F6nig'?= <christian.koenig@amd.com>,
	siqueira@igalia.com, airlied@gmail.com, simona@ffwll.ch,
	rodrigo.vivi@intel.com, jani.nikula@linux.intel.com,
	lucas.demarchi@intel.com
Subject: Re: [PATCH 1/2] drm: Create an app info option for wedge events
Message-ID: <Z8KgwswQQyGxhsR1@black.fi.intel.com>
References: <20250228121353.1442591-1-andrealmeid@igalia.com>
 <20250228121353.1442591-2-andrealmeid@igalia.com>
 <Z8HGFRGOYvyCCWWu@black.fi.intel.com>
 <58763d8e-46a1-4753-9401-987fb3dac50b@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58763d8e-46a1-4753-9401-987fb3dac50b@igalia.com>

On Fri, Feb 28, 2025 at 06:54:12PM -0300, André Almeida wrote:
> Hi Raag,
> 
> On 2/28/25 11:20, Raag Jadav wrote:
> > Cc: Lucas
> > 
> > On Fri, Feb 28, 2025 at 09:13:52AM -0300, André Almeida wrote:
> > > When a device get wedged, it might be caused by a guilty application.
> > > For userspace, knowing which app was the cause can be useful for some
> > > situations, like for implementing a policy, logs or for giving a chance
> > > for the compositor to let the user know what app caused the problem.
> > > This is an optional argument, when `PID=-1` there's no information about
> > > the app caused the problem, or if any app was involved during the hang.
> > > 
> > > Sometimes just the PID isn't enough giving that the app might be already
> > > dead by the time userspace will try to check what was this PID's name,
> > > so to make the life easier also notify what's the app's name in the user
> > > event.
> > > 
> > > Signed-off-by: André Almeida <andrealmeid@igalia.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
> > >   drivers/gpu/drm/drm_drv.c                  | 16 +++++++++++++---
> > >   drivers/gpu/drm/i915/gt/intel_reset.c      |  3 ++-
> > >   drivers/gpu/drm/xe/xe_device.c             |  3 ++-
> > >   include/drm/drm_device.h                   |  8 ++++++++
> > >   include/drm/drm_drv.h                      |  3 ++-
> > >   7 files changed, 29 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 24ba52d76045..00b9b87dafd8 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -6124,7 +6124,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> > >   	atomic_set(&adev->reset_domain->reset_res, r);
> > >   	if (!r)
> > > -		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
> > > +		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> > >   	return r;
> > >   }
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > index ef1b77f1e88f..3ed9cbcab1ad 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > @@ -150,7 +150,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
> > >   			amdgpu_fence_driver_force_completion(ring);
> > >   			if (amdgpu_ring_sched_ready(ring))
> > >   				drm_sched_start(&ring->sched, 0);
> > > -			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
> > > +			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> > >   			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
> > >   			goto exit;
> > >   		}
> > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > > index 17fc5dc708f4..48faafd82a99 100644
> > > --- a/drivers/gpu/drm/drm_drv.c
> > > +++ b/drivers/gpu/drm/drm_drv.c
> > > @@ -522,6 +522,7 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
> > >    * drm_dev_wedged_event - generate a device wedged uevent
> > >    * @dev: DRM device
> > >    * @method: method(s) to be used for recovery
> > > + * @info: optional information about the guilty app
> > >    *
> > >    * This generates a device wedged uevent for the DRM device specified by @dev.
> > >    * Recovery @method\(s) of choice will be sent in the uevent environment as
> > > @@ -534,13 +535,14 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
> > >    *
> > >    * Returns: 0 on success, negative error code otherwise.
> > >    */
> > > -int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
> > > +int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
> > > +			 struct drm_wedge_app_info *info)
> > >   {
> > >   	const char *recovery = NULL;
> > >   	unsigned int len, opt;
> > >   	/* Event string length up to 28+ characters with available methods */
> > > -	char event_string[32];
> > > -	char *envp[] = { event_string, NULL };
> > > +	char event_string[32], pid_string[15], comm_string[TASK_COMM_LEN];
> > > +	char *envp[] = { event_string, pid_string, comm_string, NULL };
> > >   	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
> > > @@ -562,6 +564,14 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
> > >   	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
> > >   		 "but recovered through reset" : "needs recovery");
> > > +	if (info) {
> > > +		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
> > > +		snprintf(comm_string, sizeof(comm_string), "APP=%s", info->comm);
> > > +	} else {
> > > +		snprintf(pid_string, sizeof(pid_string), "%s", "PID=-1");
> > > +		snprintf(comm_string, sizeof(comm_string), "%s", "APP=none");
> > > +	}
> > This is not much use for wedge cases that needs recovery, since at that point
> > the userspace will need to clean house anyway.
> > 
> > Which leaves us with only 'none' case and perhaps the need for standardization
> > of "optional telemetry collection".
> > 
> > Thoughts?
> 
> I had the feeling that 'none' was already meant to be used for that. Do you
> think we should move to another naming? Given that we didn't reach the merge
> window yet we could potentially change that name without much damage.

No, I meant thoughts on possible telemetry data that the drivers might
think is useful for userspace (along with PID) and can be presented in
a vendor agnostic manner (just like wedged event).

Raag

