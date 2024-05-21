Return-Path: <linux-kernel+bounces-184890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F78CAD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5801C21738
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C17580B;
	Tue, 21 May 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BfZ23q3n"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF974C09
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291905; cv=none; b=Yzod111cRP+JP9scH0/H50FhEutb+OSSipUaneIGYIxmQs3VFpW//mPQnK0fBDxFukxXK2bXu758wE1vKyl0b0RvAGLdDJFAyW+jwlhvAc8S9CcyCbbp7ZR54YiX03t2bXfMKzyO7IGLk5EQUh3TVqxVZ+HMhafUYDYEvuM6rcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291905; c=relaxed/simple;
	bh=2Gy3xvFckSkNvjNEWhGj/kHspLan6ykQQUl7cs/HI5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmO9hexidKXkKTzm1fkMbpiikdhu4raFFu7+qY/w9RRNa+iiTCzogt6RhoRha4hkrG4nnc5EH8I0bKQ8OOwitAgV4SBZbrWmlHC47j8jDTzbYE2YaSv6qdR3V4RZeXwYsBcX/jdwWsm4ZPj7auV8UyGZ2V6P0L5bJlg1WHqmUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=BfZ23q3n; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-574d96f71efso1615969a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1716291902; x=1716896702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOG87kRKqhGoWjQDtxhtb40Vr6tjKxEiEr57hLDOyAs=;
        b=BfZ23q3nMD1kkd6L5j55kbUxd9Wg3VONWI+oBQgfIzIAIXeyk3kt5+nyXf9Rr1ZQmj
         zNEJALztllfTNxoJD4IdOl9BXQW9UZtW8YK2+C6OVVfw905Fsc/aU0HIhn9TDKYR3I7g
         jSOCiXE1uRUGlhqjmNrgq7hQMTNFHO0M95cuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716291902; x=1716896702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOG87kRKqhGoWjQDtxhtb40Vr6tjKxEiEr57hLDOyAs=;
        b=imSZdI/+CqnVIHax5Abg5+kJUVKIotuYyVubyIeHiZ/Ygb0FznFR2PDeTQvZX17t4F
         +lXHEHinSGf7DThzFFi4tsZIKKEieQD4Gj3hrgn7XIuxLvZqyJYYuzUkKQOB0Hw3lC7a
         SYqqjpXUh62LbbuLBMF4WYurSHK62LluYFoJZzjxZWeyq86PvKke0IaPyLryKcivCZuG
         A3N+7xyvYukWf17T73y6J+wE5MD2mHqVSopeC3lIsqFZAVxyiVnxd++02yiFl/FCgXW2
         iUpc+IXF3OFwggZFMJ62rHvwVgT+JqdNW7wNBk9nklr7vTJmAz1RtFE7FPeE/HXgCqlA
         ds4g==
X-Forwarded-Encrypted: i=1; AJvYcCXCKGjc0t1ihlQR9Zo4I37igynPZXkHIeFI3Et/A3yAgkjYqPm7TiUctUw7jd3Zv9yrOeneNX9XccP8kJ56kf2yBgFzEeezL/rURFt1
X-Gm-Message-State: AOJu0YxzoOn6ZI1NNnraJ/Ew2KooKtiX3RS4HoReE0TyUl9mCv7q6tAv
	fxg7XusQmgvVn39yskmdTYyxj1PuJpQKGU8szxP3vwiXDxg+fcJwRyGJ/d1ad2M=
X-Google-Smtp-Source: AGHT+IHpqPsQEMClqFfPwE8hlGKP0FeodEfBdWinlRo0GJs8wdzebX+3CZQPu/6okkJEhteu1rblhw==
X-Received: by 2002:a05:6402:8d0:b0:572:5c95:50fe with SMTP id 4fb4d7f45d1cf-5734d444320mr21767661a12.0.1716291901588;
        Tue, 21 May 2024 04:45:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574bcad0362sm13110306a12.20.2024.05.21.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 04:45:01 -0700 (PDT)
Date: Tue, 21 May 2024 13:44:59 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Rob Clark <robdclark@gmail.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v2 1/1] drm: Add ioctl for querying a DRM device's list
 of open client PIDs
Message-ID: <ZkyJO01lvuVhFlMG@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Rob Clark <robdclark@gmail.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
References: <20240501185047.3126832-1-adrian.larumbe@collabora.com>
 <20240501185047.3126832-2-adrian.larumbe@collabora.com>
 <ZjNKLVZgekRqw5AL@phenom.ffwll.local>
 <a3hakatontuh535xkvwz3txbaocjx44ajkarmiigt3prekqysc@hp2zayht4hbh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3hakatontuh535xkvwz3txbaocjx44ajkarmiigt3prekqysc@hp2zayht4hbh>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Thu, May 16, 2024 at 11:12:19PM +0100, Adrián Larumbe wrote:
> Hi Daniel,
> 
> On 02.05.2024 10:09, Daniel Vetter wrote:
> > On Wed, May 01, 2024 at 07:50:43PM +0100, Adrián Larumbe wrote:
> > > Up to this day, all fdinfo-based GPU profilers must traverse the entire
> > > /proc directory structure to find open DRM clients with fdinfo file
> > > descriptors. This is inefficient and time-consuming.
> > > 
> > > This patch adds a new DRM ioctl that allows users to obtain a list of PIDs
> > > for clients who have opened the DRM device. Output from the ioctl isn't
> > > human-readable, and it's meant to be retrieved only by GPU profilers like
> > > gputop and nvtop.
> > > 
> > > Cc: Rob Clark <robdclark@gmail.com>
> > > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > > ---
> > >  drivers/gpu/drm/drm_internal.h |  1 +
> > >  drivers/gpu/drm/drm_ioctl.c    | 89 ++++++++++++++++++++++++++++++++++
> > >  include/uapi/drm/drm.h         |  7 +++
> > >  3 files changed, 97 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> > > index 690505a1f7a5..6f78954cae16 100644
> > > --- a/drivers/gpu/drm/drm_internal.h
> > > +++ b/drivers/gpu/drm/drm_internal.h
> > > @@ -243,6 +243,7 @@ static inline void drm_debugfs_encoder_remove(struct drm_encoder *encoder)
> > >  drm_ioctl_t drm_version;
> > >  drm_ioctl_t drm_getunique;
> > >  drm_ioctl_t drm_getclient;
> > > +drm_ioctl_t drm_getclients;
> > >  
> > >  /* drm_syncobj.c */
> > >  void drm_syncobj_open(struct drm_file *file_private);
> > > diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> > > index e368fc084c77..da7057376581 100644
> > > --- a/drivers/gpu/drm/drm_ioctl.c
> > > +++ b/drivers/gpu/drm/drm_ioctl.c
> > > @@ -207,6 +207,93 @@ int drm_getclient(struct drm_device *dev, void *data,
> > >  	}
> > >  }
> > >  
> > > +/*
> > > + * Get list of client PIDs who have opened a DRM file
> > > + *
> > > + * \param dev DRM device we are querying
> > > + * \param data IOCTL command input.
> > > + * \param file_priv DRM file private.
> > > + *
> > > + * \return zero on success or a negative number on failure.
> > > + *
> > > + * Traverses list of open clients for the given DRM device, and
> > > + * copies them into userpace as an array of PIDs
> > > + */
> > > +int drm_getclients(struct drm_device *dev, void *data,
> > > +		   struct drm_file *file_priv)
> > > +
> > > +{
> > > +	struct drm_get_clients *get_clients = data;
> > > +	ssize_t size = get_clients->len;
> > > +	char __user *pid_buf;
> > > +	ssize_t offset = 0;
> > > +	int ret = 0;
> > > +
> > > +	/*
> > > +	 * We do not want to show clients of display only devices so
> > > +	 * as to avoid confusing UM GPU profilers
> > > +	 */
> > > +	if (!dev->render) {
> > > +		get_clients->len = 0;
> > > +		return 0;
> > > +	}
> > > +
> > > +	/*
> > > +	 * An input size of zero means UM wants to know the size of the PID buffer
> > > +	 * We round it up to the nearest multiple of the page size so that we can have
> > > +	 * some spare headroom in case more clients came in between successive calls
> > > +	 * of this ioctl, and also to simplify parsing of the PIDs buffer, because
> > > +	 * sizeof(pid_t) will hopefully always divide PAGE_SIZE
> > > +	 */
> > > +	if (size == 0) {
> > > +		get_clients->len =
> > > +			roundup(atomic_read(&dev->open_count) * sizeof(pid_t), PAGE_SIZE);
> > > +		return 0;
> > > +	}
> > > +
> > > +	pid_buf = (char *)(void *)get_clients->user_data;
> > > +
> > > +	if (!pid_buf)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&dev->filelist_mutex);
> > > +	list_for_each_entry_reverse(file_priv, &dev->filelist, lhead) {
> > > +		pid_t pid_num;
> > > +
> > > +		if ((size - offset) < sizeof(pid_t))
> > > +			break;
> > > +
> > > +		rcu_read_lock();
> > > +		pid_num = pid_vnr(rcu_dereference(file_priv->pid));
> > > +		rcu_read_unlock();
> > > +
> > > +		/* We do not want to return the profiler's PID */
> > > +		if (pid_vnr(task_tgid(current)) == pid_num)
> > > +			continue;
> > > +
> > > +		ret = copy_to_user(pid_buf + offset, &pid_num, sizeof(pid_t));
> > > +		if (ret)
> > > +			break;
> > > +
> > > +		offset += sizeof(pid_t);
> > > +	}
> > > +	mutex_unlock(&dev->filelist_mutex);
> > > +
> > > +	if (ret)
> > > +		return -EFAULT;
> > > +
> > > +	if ((size - offset) >= sizeof(pid_t)) {
> > > +		pid_t pid_zero = 0;
> > > +
> > > +		ret = copy_to_user(pid_buf + offset,
> > > +				   &pid_zero, sizeof(pid_t));
> > > +		if (ret)
> > > +			return -EFAULT;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /*
> > >   * Get statistics information.
> > >   *
> > > @@ -672,6 +759,8 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
> > >  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_LIST_LESSEES, drm_mode_list_lessees_ioctl, DRM_MASTER),
> > >  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GET_LEASE, drm_mode_get_lease_ioctl, DRM_MASTER),
> > >  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_REVOKE_LEASE, drm_mode_revoke_lease_ioctl, DRM_MASTER),
> > > +
> > > +	DRM_IOCTL_DEF(DRM_IOCTL_GET_CLIENTS, drm_getclients, DRM_RENDER_ALLOW),
> > 
> > Uh RENDER_ALLOW sounds like a very bad idea for this, flat out leaks
> > information that really paranoid people don't want to have leaked.
> 
> I'm curious, how is this ioctl leakier than, let's say, any of the driver
> getparam ioctls, like Panfrost's panfrost_ioctl_get_param() ?
> 
> I'm asking this because I checked the way access to a drm file is being handled
> in drm_ioctl_permit(), and it seems in the case of a render node (which are the
> kind we're most interested in retrieving the list of client PIDs for),
> DRM_RENDER_ALLOW access is mandatory.

All the resources are attached to a file, and that's fundamentally what
the ioctls we have operate on. Or invariant stuff from the driver/hw, like
the get_param ioctl you mention.

What your ioctl does is give us information about _other_ files opened of
the same underlying render node, which is entirely new and does break the
full isolation between different open render node files we've hade thus
far.

> > Natural would be to limit to ptrace ability, but ptrace is for processes
> > and fd aren't tied to that. So I'm not sure ...
> > 
> > I think a separate file (whether in procfs or a special chardev) where you
> > can set access rights that suit feels a lot better for this. Plus putting
> > it into procfs would also give the natural property that you can only read
> > it if you have access to procfs anyway, so imo that feels like the best
> > place for this ...
> > 
> > And yes that means some lkml bikeshedding with procfs folks, but I do
> > think that's good here since we're likely not the only ones who need a bit
> > faster procfs trawling for some special use-cases. So consistency across
> > subsystems would be nice to at least try to aim for.
> > -Sima
> 
> I think using procfs would make sense if we were displaying process-specific
> information, and such is the case of fdinfo directories therein, but this ioctl
> (and the device sysfs knob that it replaces from a previous patch series) is
> meant to yield all the device's client PIDs. To me that doesn't sound like
> something that is tied to a single render client, but to the device as a whole.

procfs because it's an algorithmic improvement for an interface that _is_
in procfs. If you don't have access to procfs and it's fdinfo files, then
this "give me the list of all open files" is no use. Also with pid name
spaces we need to make sure that the list we hand out matches the relevant
pid name space, if it's global that's a bug. So it's also relevant to the
specific procfs instance a process has.

So from a security pov, that's where it belongs.
-Sima

> 
> > >  };
> > >  
> > >  #define DRM_CORE_IOCTL_COUNT	ARRAY_SIZE(drm_ioctls)
> > > diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > > index 16122819edfe..c47aa9de51ab 100644
> > > --- a/include/uapi/drm/drm.h
> > > +++ b/include/uapi/drm/drm.h
> > > @@ -1024,6 +1024,11 @@ struct drm_crtc_queue_sequence {
> > >  	__u64 user_data;	/* user data passed to event */
> > >  };
> > >  
> > > +struct drm_get_clients {
> > > +	__u64 user_data;
> > > +	__kernel_size_t len;
> > > +};
> > > +
> > >  #if defined(__cplusplus)
> > >  }
> > >  #endif
> > > @@ -1236,6 +1241,8 @@ extern "C" {
> > >  #define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
> > >  #define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
> > >  
> > > +#define DRM_IOCTL_GET_CLIENTS		DRM_IOWR(0xD1, struct drm_get_clients)
> > > +
> > >  /**
> > >   * DRM_IOCTL_MODE_GETFB2 - Get framebuffer metadata.
> > >   *
> > > -- 
> > > 2.44.0
> > > 
> 
> Adrian Larumbe

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

