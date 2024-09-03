Return-Path: <linux-kernel+bounces-313577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC796A733
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91911F25022
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0215573A;
	Tue,  3 Sep 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BdxrtzOy"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE61D5CC8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391039; cv=none; b=tQZmULHfW6Ec9NNIeAVxWXrBqP9f4Mhziiu6dToYVVmP7Sjy9nRjpBBFZBDwQs7yH8IwQ6kQMGg/HHKP6ySGGvL0bCRR/jhDgvrvIzW0ONFCQjmDQo5/Q4zzlg9ZhhRkpU/Zeq/gFgKJ08JyzGSqVNjCFLan8M9rZxxtXcV8fJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391039; c=relaxed/simple;
	bh=vyQ1QvOwFO3ncQDIBuNDHg7MD0ZofIv8bi+iUSTkRmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hESdP9iiQc8xbIBZdCl75sKue2bw/WL92pj9PpJu6LpA69XV8LJcFYIW8e9MRX8v40zpOzEt1DuScLmJrtoRcLuW+aAoqefeR5D//5FQeb51FBpkjVX6mT83BcsStEiG6q7Qxu/EqNGzDuSu60cpmOAAwDKe/Cjlzedzgzp79CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=BdxrtzOy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374b9761eecso2837460f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1725391036; x=1725995836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6T06AftA0wCiWbApedCP3Ro7VogxMzOphjJxhAWhZw=;
        b=BdxrtzOyaymIJIk/j9oGFuta3w7lbhXyFh6d24jRhkUHUluZNDi4YbfKoPQvk81u2L
         HD7R+TsldBdGyz8hq1Xsku0gF90/EEdZuiEs3p4KS5aNYPNNesJ4rzOKS5uTHwsJc1yv
         kqNK2sypF4klaSMbSSWs3/8jTur4U6mOT20nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725391036; x=1725995836;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6T06AftA0wCiWbApedCP3Ro7VogxMzOphjJxhAWhZw=;
        b=bxfksi+BkP/A3dWjgLbA/PvLqYHtpNKb7OloMSe3nG36SJ5t+b5qCKMnBfcJuujgWF
         +/7ItxPyeCSapHKMVHWpZJ/JGtGEGQg6x0QJd6Q8OvFN2Xvj+MBRu3D8pd/6E5cXYsSp
         /+fGzdvCBVqqB3TeBq5c7qIIcvO+A+U1sEkw8xymQ5GbZwiE8DPxMYzWxBxwXLF1fa5E
         2dJQ2hodrMqP9JWaymN2Pe8JcdUq2as6eSgnauYHfUu+tiPKNOwagqunqlatotyG+8KT
         JduKgqq45DDkvlo4N3KDXYp1pbv4SmX5l/ITCBfLBma17+wL29nNk7/3fGsjvU0m35rL
         1nlQ==
X-Gm-Message-State: AOJu0Yzp9WUsBU9ruUon2JxPDL8jQnBn0qFQ+qRvk1YgIAOOjuO2V1rG
	YKZ3BEMvsteL448+U9pNxaOOXRf5Yvzdp+gy3K5mbrSiOcHLbL8aElGMhN7XkuA=
X-Google-Smtp-Source: AGHT+IEPVItEQiRYwvZ1W4Ri9nvG8UkJy35F6F5lNQFlIfpgGofSxQlP2yheVMZ/924fh+cyMdLjWg==
X-Received: by 2002:a5d:55ca:0:b0:371:a60e:a821 with SMTP id ffacd0b85a97d-374bcfe5e16mr7048146f8f.38.1725391036300;
        Tue, 03 Sep 2024 12:17:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df936dsm179511405e9.28.2024.09.03.12.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:17:15 -0700 (PDT)
Date: Tue, 3 Sep 2024 21:17:13 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Mihail Atanassov <mihail.atanassov@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Ketil Johnsen <ketil.johnsen@arm.com>,
	Akash Goel <akash.goel@arm.com>
Subject: Re: [PATCH 6/8] drm/panthor: Implement XGS queues
Message-ID: <ZtdguY2gELaMWuxk@phenom.ffwll.local>
Mail-Followup-To: Mihail Atanassov <mihail.atanassov@arm.com>,
	linux-kernel@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Ketil Johnsen <ketil.johnsen@arm.com>,
	Akash Goel <akash.goel@arm.com>
References: <20240828172605.19176-1-mihail.atanassov@arm.com>
 <20240828172605.19176-7-mihail.atanassov@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828172605.19176-7-mihail.atanassov@arm.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Wed, Aug 28, 2024 at 06:26:02PM +0100, Mihail Atanassov wrote:
> +int panthor_xgs_queue_create(struct panthor_file *pfile, u32 vm_id,
> +			     int eventfd_sync_update, u32 *handle)
> +{
> +	struct panthor_device *ptdev = pfile->ptdev;
> +	struct panthor_xgs_queue_pool *xgs_queue_pool = pfile->xgs_queues;
> +	struct panthor_xgs_queue *queue;
> +	struct drm_gpu_scheduler *drm_sched;
> +	int ret;
> +	int qid;
> +
> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> +	if (!queue)
> +		return -ENOMEM;
> +
> +	kref_init(&queue->refcount);
> +	INIT_LIST_HEAD(&queue->fence_ctx.in_flight_jobs);
> +	INIT_WORK(&queue->release_work, xgs_queue_release_work);
> +	queue->ptdev = ptdev;
> +
> +	ret = drmm_mutex_init(&ptdev->base, &queue->lock);

This is guaranteed buggy, because you kzalloc queue, with it's own
refcount, but then tie the mutex cleanup to the entirely different
lifetime of the drm_device.

Just spotted this while reading around.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

