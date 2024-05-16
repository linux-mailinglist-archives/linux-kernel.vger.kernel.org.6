Return-Path: <linux-kernel+bounces-181604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FEF8C7E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3E71C212EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D721586C0;
	Thu, 16 May 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ieQlFZrW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF0157467
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897543; cv=none; b=pflu92X14R5gQGLq4G1E7pMaJ6pQuDX6TB5i7sFA7ymKAwMYXDyJF0mp5hlDmXzlOO5d1nR0N/n32FxcEk4KbnD1i11zkNAOTeRx84RC8d29YTv3AnrnKOJjVeYnJICKmrEhNRZ+g8aE9/QHpytILvWQ+s8c8Y1ns5uqUxiHRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897543; c=relaxed/simple;
	bh=pdo/CEMGnwi61BSt/0rnGMNUGXy5eJpcP16+ckAoQlo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrU3ORKEvkv7KX1o7EkAqAwPdweT6lfULNUbPLbPw99nfNg4dsiokGLPcnhS5uxJIkTDMtOOV49rsQ/NJmMsdpAjtZbAzaICzQtAd9LV/YFBdf3GZN3sdH6YfzCKe9Uetpwx+jirMl7ueG50W57aiYM8fWfbbRNMeXaSPmPV9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ieQlFZrW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715897540;
	bh=pdo/CEMGnwi61BSt/0rnGMNUGXy5eJpcP16+ckAoQlo=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ieQlFZrW0obs4RfZ7e8QzSi6Ql5WJthHqk0tTUKOnAShilT0EBLCZz9mHGaPO0vtn
	 jlBi3ho9qkNzptzP8+1PAfnmX0YSA7KrNn90/Zq9EhIYA0bPQBPe2jFtkkVyFQhU87
	 /2f+l8WozJJZkc5rc5XSY13P5Pi/nHNRmw4gqL1mb7+Pf1/dEB8+JsAvidGPUVK1MY
	 G9T/3/SGfoEN6a9zEeH6EXRe3yvZj0ohf2sCFnlb0Q3AohrJYwEITWqZe3QhJ6/rE9
	 YnTzDFZacV3trk4g1G/Bo3XnDqRdwUNBBlBNXGWmQwu02suhC2jQ8lwOFR+epEpMt/
	 ZRdHegZtLArfg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DBAEE378020D;
	Thu, 16 May 2024 22:12:19 +0000 (UTC)
Date: Thu, 16 May 2024 23:12:19 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v2 1/1] drm: Add ioctl for querying a DRM device's list
 of open client PIDs
Message-ID: <a3hakatontuh535xkvwz3txbaocjx44ajkarmiigt3prekqysc@hp2zayht4hbh>
References: <20240501185047.3126832-1-adrian.larumbe@collabora.com>
 <20240501185047.3126832-2-adrian.larumbe@collabora.com>
 <ZjNKLVZgekRqw5AL@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjNKLVZgekRqw5AL@phenom.ffwll.local>

Hi Daniel,

On 02.05.2024 10:09, Daniel Vetter wrote:
> On Wed, May 01, 2024 at 07:50:43PM +0100, Adrián Larumbe wrote:
> > Up to this day, all fdinfo-based GPU profilers must traverse the entire
> > /proc directory structure to find open DRM clients with fdinfo file
> > descriptors. This is inefficient and time-consuming.
> > 
> > This patch adds a new DRM ioctl that allows users to obtain a list of PIDs
> > for clients who have opened the DRM device. Output from the ioctl isn't
> > human-readable, and it's meant to be retrieved only by GPU profilers like
> > gputop and nvtop.
> > 
> > Cc: Rob Clark <robdclark@gmail.com>
> > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_internal.h |  1 +
> >  drivers/gpu/drm/drm_ioctl.c    | 89 ++++++++++++++++++++++++++++++++++
> >  include/uapi/drm/drm.h         |  7 +++
> >  3 files changed, 97 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> > index 690505a1f7a5..6f78954cae16 100644
> > --- a/drivers/gpu/drm/drm_internal.h
> > +++ b/drivers/gpu/drm/drm_internal.h
> > @@ -243,6 +243,7 @@ static inline void drm_debugfs_encoder_remove(struct drm_encoder *encoder)
> >  drm_ioctl_t drm_version;
> >  drm_ioctl_t drm_getunique;
> >  drm_ioctl_t drm_getclient;
> > +drm_ioctl_t drm_getclients;
> >  
> >  /* drm_syncobj.c */
> >  void drm_syncobj_open(struct drm_file *file_private);
> > diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> > index e368fc084c77..da7057376581 100644
> > --- a/drivers/gpu/drm/drm_ioctl.c
> > +++ b/drivers/gpu/drm/drm_ioctl.c
> > @@ -207,6 +207,93 @@ int drm_getclient(struct drm_device *dev, void *data,
> >  	}
> >  }
> >  
> > +/*
> > + * Get list of client PIDs who have opened a DRM file
> > + *
> > + * \param dev DRM device we are querying
> > + * \param data IOCTL command input.
> > + * \param file_priv DRM file private.
> > + *
> > + * \return zero on success or a negative number on failure.
> > + *
> > + * Traverses list of open clients for the given DRM device, and
> > + * copies them into userpace as an array of PIDs
> > + */
> > +int drm_getclients(struct drm_device *dev, void *data,
> > +		   struct drm_file *file_priv)
> > +
> > +{
> > +	struct drm_get_clients *get_clients = data;
> > +	ssize_t size = get_clients->len;
> > +	char __user *pid_buf;
> > +	ssize_t offset = 0;
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * We do not want to show clients of display only devices so
> > +	 * as to avoid confusing UM GPU profilers
> > +	 */
> > +	if (!dev->render) {
> > +		get_clients->len = 0;
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * An input size of zero means UM wants to know the size of the PID buffer
> > +	 * We round it up to the nearest multiple of the page size so that we can have
> > +	 * some spare headroom in case more clients came in between successive calls
> > +	 * of this ioctl, and also to simplify parsing of the PIDs buffer, because
> > +	 * sizeof(pid_t) will hopefully always divide PAGE_SIZE
> > +	 */
> > +	if (size == 0) {
> > +		get_clients->len =
> > +			roundup(atomic_read(&dev->open_count) * sizeof(pid_t), PAGE_SIZE);
> > +		return 0;
> > +	}
> > +
> > +	pid_buf = (char *)(void *)get_clients->user_data;
> > +
> > +	if (!pid_buf)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&dev->filelist_mutex);
> > +	list_for_each_entry_reverse(file_priv, &dev->filelist, lhead) {
> > +		pid_t pid_num;
> > +
> > +		if ((size - offset) < sizeof(pid_t))
> > +			break;
> > +
> > +		rcu_read_lock();
> > +		pid_num = pid_vnr(rcu_dereference(file_priv->pid));
> > +		rcu_read_unlock();
> > +
> > +		/* We do not want to return the profiler's PID */
> > +		if (pid_vnr(task_tgid(current)) == pid_num)
> > +			continue;
> > +
> > +		ret = copy_to_user(pid_buf + offset, &pid_num, sizeof(pid_t));
> > +		if (ret)
> > +			break;
> > +
> > +		offset += sizeof(pid_t);
> > +	}
> > +	mutex_unlock(&dev->filelist_mutex);
> > +
> > +	if (ret)
> > +		return -EFAULT;
> > +
> > +	if ((size - offset) >= sizeof(pid_t)) {
> > +		pid_t pid_zero = 0;
> > +
> > +		ret = copy_to_user(pid_buf + offset,
> > +				   &pid_zero, sizeof(pid_t));
> > +		if (ret)
> > +			return -EFAULT;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Get statistics information.
> >   *
> > @@ -672,6 +759,8 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
> >  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_LIST_LESSEES, drm_mode_list_lessees_ioctl, DRM_MASTER),
> >  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GET_LEASE, drm_mode_get_lease_ioctl, DRM_MASTER),
> >  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_REVOKE_LEASE, drm_mode_revoke_lease_ioctl, DRM_MASTER),
> > +
> > +	DRM_IOCTL_DEF(DRM_IOCTL_GET_CLIENTS, drm_getclients, DRM_RENDER_ALLOW),
> 
> Uh RENDER_ALLOW sounds like a very bad idea for this, flat out leaks
> information that really paranoid people don't want to have leaked.

I'm curious, how is this ioctl leakier than, let's say, any of the driver
getparam ioctls, like Panfrost's panfrost_ioctl_get_param() ?

I'm asking this because I checked the way access to a drm file is being handled
in drm_ioctl_permit(), and it seems in the case of a render node (which are the
kind we're most interested in retrieving the list of client PIDs for),
DRM_RENDER_ALLOW access is mandatory.

> Natural would be to limit to ptrace ability, but ptrace is for processes
> and fd aren't tied to that. So I'm not sure ...
> 
> I think a separate file (whether in procfs or a special chardev) where you
> can set access rights that suit feels a lot better for this. Plus putting
> it into procfs would also give the natural property that you can only read
> it if you have access to procfs anyway, so imo that feels like the best
> place for this ...
> 
> And yes that means some lkml bikeshedding with procfs folks, but I do
> think that's good here since we're likely not the only ones who need a bit
> faster procfs trawling for some special use-cases. So consistency across
> subsystems would be nice to at least try to aim for.
> -Sima

I think using procfs would make sense if we were displaying process-specific
information, and such is the case of fdinfo directories therein, but this ioctl
(and the device sysfs knob that it replaces from a previous patch series) is
meant to yield all the device's client PIDs. To me that doesn't sound like
something that is tied to a single render client, but to the device as a whole.

> >  };
> >  
> >  #define DRM_CORE_IOCTL_COUNT	ARRAY_SIZE(drm_ioctls)
> > diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > index 16122819edfe..c47aa9de51ab 100644
> > --- a/include/uapi/drm/drm.h
> > +++ b/include/uapi/drm/drm.h
> > @@ -1024,6 +1024,11 @@ struct drm_crtc_queue_sequence {
> >  	__u64 user_data;	/* user data passed to event */
> >  };
> >  
> > +struct drm_get_clients {
> > +	__u64 user_data;
> > +	__kernel_size_t len;
> > +};
> > +
> >  #if defined(__cplusplus)
> >  }
> >  #endif
> > @@ -1236,6 +1241,8 @@ extern "C" {
> >  #define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
> >  #define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
> >  
> > +#define DRM_IOCTL_GET_CLIENTS		DRM_IOWR(0xD1, struct drm_get_clients)
> > +
> >  /**
> >   * DRM_IOCTL_MODE_GETFB2 - Get framebuffer metadata.
> >   *
> > -- 
> > 2.44.0
> > 

Adrian Larumbe

