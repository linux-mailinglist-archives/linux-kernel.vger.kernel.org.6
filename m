Return-Path: <linux-kernel+bounces-217739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7290B399
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4691C21011
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8794315533C;
	Mon, 17 Jun 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LcYCBBMi"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888315572C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634695; cv=none; b=qJMCTiAryBNSxKEZ+rnY1bO/BT+IIBiDb+Ow6GtI3RKDMfvwC5vHFYCeq79+7AqFv1Eo8i1V6f6ATGhsu7wvVl7F3gYiLobNc2N272qCUXMh7oqH2+PiA81m1iN7U8XDwlollKchvrXITETomDUOi3HjitefVL/1qjbP0zF2TYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634695; c=relaxed/simple;
	bh=gh/wgBPva9p6pDObWt2iib+z9II6ABmNY1slVb3/2j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH+stTtKIkB4Z6Wva1Nkr1/djTPasSgxnbWL1QQFm9ZIZIdSNTfe91W5Nd2QmpzqadbRIDS/0UCi7uB+fkGhF65L31NmbUpwoigiZ+SoSMbVJirShA7zRLvHiQlYkJDTL6cBUgYRQM3kzpFwUmY9Vf/lIzEh1Ua0yrzY8FbS+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=LcYCBBMi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35f1edc71e6so394769f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718634692; x=1719239492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFrClsbz0DcKEfzLpYHsnVFFxJbCJ2qPD/ZaJWhUEbE=;
        b=LcYCBBMizsgMC1JKHkz7rHLGE5TIaFQmYPDOZQ/71qLrgfXa6WnTgOqnMQQGRKfViz
         ZVgfC64wQSMoUBLWYvvk2DusebUNQlipiXVUbxL+WUyz0XFlj7tznVEXSIaEGOqkrWD4
         yCXc8BsdVbQTz1UQSLUc7cn+3xv+GOwwWjPJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634692; x=1719239492;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFrClsbz0DcKEfzLpYHsnVFFxJbCJ2qPD/ZaJWhUEbE=;
        b=tRBZDzk78fv6SRXaO4WKOKIBMjKKp85aKUAGxNgTAHAp+hdSbt8/ubnc82/nbljPO+
         SBC0GDfDewxnOk9UdyESaU1cYJhNUvvzkqW2YmjAjTsGwCIjmzcU2sawCUSIxhGaNPZU
         TFLsq9Oea5wOQiUw4PNUUdwLtnp45xEA8fAhXFuFbZxmlbfLj/3bhWVWXQPwohPkrL39
         6eGBMER0K/xB9Z7AMvla22dBvpcrj0rJmm4qol81OIwB+uFdR3Z3wN7YAa2BSE0cPSf6
         1wpH/m71kCyzUM/vDr2XxdCxFFcHHgK7Pevt9FZYLNyqseW3JkbRvy5fpTiiXLUgln0U
         VnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXlT/IS0aSAcNuhCZ354PZYfR9cIL2gf6xpPWDDkhgy+3Kqs8rrecm+UgqdwMkVpzVU75NRW4661etZg8Y6wZopKHx6vP6N1GnQaFi
X-Gm-Message-State: AOJu0Yxo3lqouCnURAGjIP2lXqutWC21M/pW1DZ71Ckxzw26lWST3sNB
	x3f0/ssUMbi0p1lHJKLiRX5aZj00+xd8v6tdNDTxkA2RM80hV9yMcGxyEr2lrjM=
X-Google-Smtp-Source: AGHT+IGXPxMb2tkpyM925AxgZEFgyosdjcu8hU3w7t1pqYzMjv7nzIXUK7ZqskCj9FirEMoANfpt1A==
X-Received: by 2002:a05:6000:4029:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-360872b7ed8mr5475347f8f.0.1718634691731;
        Mon, 17 Jun 2024 07:31:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef70csm200033675e9.3.2024.06.17.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:31:31 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:31:29 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [PATCH v3] drm/fb-helper: Detect when lid is closed during
 initialization
Message-ID: <ZnBIwWtgZ2leqkPC@phenom.ffwll.local>
Mail-Followup-To: Mario Limonciello <mario.limonciello@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>
References: <20240613051700.1112-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613051700.1112-1-mario.limonciello@amd.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Thu, Jun 13, 2024 at 12:17:00AM -0500, Mario Limonciello wrote:
> If the lid on a laptop is closed when eDP connectors are populated
> then it remains enabled when the initial framebuffer configuration
> is built.
> 
> When creating the initial framebuffer configuration detect the
> lid status and if it's closed disable any eDP connectors.
> 
> Also set up a workqueue to monitor for any future lid events.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3349
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

More fundamental question: Do we even want to solve this issues?

This is fbdev we're talking about, if people use this actually in
production, they don't care much about the fallout.

Plus this has the potential to cause regressions, like we might not be
able to enable edp after having enabled and external screen. Which would
be bad.

Imo this needs a lot more justification than "one random user asked for
it". Especially since it's been the behaviour for like well over a decade
for any integrated panel that we just light them always up when using
fbdev/fbcon.

If people want full control over all this, they can use a display manager
(or a userspace console).

Cheers, Sima
> ---
> v2->v3:
>  * Use input device instead of ACPI device
>  * Detect lid open/close events
> ---
>  drivers/gpu/drm/drm_client_modeset.c |  29 ++++++
>  drivers/gpu/drm/drm_fb_helper.c      | 132 +++++++++++++++++++++++++++
>  include/drm/drm_device.h             |   6 ++
>  include/drm/drm_fb_helper.h          |   2 +
>  4 files changed, 169 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 31af5cf37a09..b8adfe87334b 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -257,6 +257,34 @@ static void drm_client_connectors_enabled(struct drm_connector **connectors,
>  		enabled[i] = drm_connector_enabled(connectors[i], false);
>  }
>  
> +static void drm_client_match_edp_lid(struct drm_device *dev,
> +				     struct drm_connector **connectors,
> +				     unsigned int connector_count,
> +				     bool *enabled)
> +{
> +	int i;
> +
> +	for (i = 0; i < connector_count; i++) {
> +		struct drm_connector *connector = connectors[i];
> +
> +		switch (connector->connector_type) {
> +		case DRM_MODE_CONNECTOR_LVDS:
> +		case DRM_MODE_CONNECTOR_eDP:
> +			if (!enabled[i])
> +				continue;
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		if (dev->lid_closed) {
> +			drm_dbg_kms(dev, "[CONNECTOR:%d:%s] lid is closed, disabling\n",
> +				    connector->base.id, connector->name);
> +			enabled[i] = false;
> +		}
> +	}
> +}
> +
>  static bool drm_client_target_cloned(struct drm_device *dev,
>  				     struct drm_connector **connectors,
>  				     unsigned int connector_count,
> @@ -844,6 +872,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>  		memset(crtcs, 0, connector_count * sizeof(*crtcs));
>  		memset(offsets, 0, connector_count * sizeof(*offsets));
>  
> +		drm_client_match_edp_lid(dev, connectors, connector_count, enabled);
>  		if (!drm_client_target_cloned(dev, connectors, connector_count, modes,
>  					      offsets, enabled, width, height) &&
>  		    !drm_client_target_preferred(dev, connectors, connector_count, modes,
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index d612133e2cf7..41dd5887599a 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -30,6 +30,8 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/console.h>
> +#include <linux/input.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/pci.h>
>  #include <linux/sysrq.h>
>  #include <linux/vga_switcheroo.h>
> @@ -413,6 +415,128 @@ static void drm_fb_helper_damage_work(struct work_struct *work)
>  	drm_fb_helper_fb_dirty(helper);
>  }
>  
> +static void drm_fb_helper_lid_event(struct input_handle *handle, unsigned int type,
> +				    unsigned int code, int value)
> +{
> +	if (type == EV_SW && code == SW_LID) {
> +		struct drm_fb_helper *fb_helper = handle->handler->private;
> +
> +		if (value != fb_helper->dev->lid_closed) {
> +			fb_helper->dev->lid_closed = value;
> +			queue_work(fb_helper->input_wq, &fb_helper->lid_work);
> +		}
> +	}
> +}
> +
> +struct drm_fb_lid {
> +	struct input_handle handle;
> +};
> +
> +static int drm_fb_helper_lid_connect(struct input_handler *handler,
> +				     struct input_dev *dev,
> +				     const struct input_device_id *id)
> +{
> +	struct drm_fb_helper *fb_helper = handler->private;
> +	struct drm_fb_lid *lid;
> +	char *name;
> +	int error;
> +
> +	lid = kzalloc(sizeof(*lid), GFP_KERNEL);
> +	if (!lid)
> +		return -ENOMEM;
> +
> +	name = kasprintf(GFP_KERNEL, "drm-fb-helper-lid-%s", dev_name(&dev->dev));
> +	if (!name) {
> +		error = -ENOMEM;
> +		goto err_free_lid;
> +	}
> +
> +	lid->handle.dev = dev;
> +	lid->handle.handler = handler;
> +	lid->handle.name = name;
> +	lid->handle.private = lid;
> +
> +	error = input_register_handle(&lid->handle);
> +	if (error)
> +		goto err_free_name;
> +
> +	error = input_open_device(&lid->handle);
> +	if (error)
> +		goto err_unregister_handle;
> +
> +	fb_helper->dev->lid_closed = dev->sw[SW_LID];
> +	drm_dbg_kms(fb_helper->dev, "initial lid state is set to %d\n", fb_helper->dev->lid_closed);
> +
> +	return 0;
> +
> +err_unregister_handle:
> +	input_unregister_handle(&lid->handle);
> +err_free_name:
> +	kfree(name);
> +err_free_lid:
> +	kfree(lid);
> +	return error;
> +}
> +
> +static void drm_fb_helper_lid_disconnect(struct input_handle *handle)
> +{
> +	struct drm_fb_lid *lid = handle->private;
> +
> +	input_close_device(handle);
> +	input_unregister_handle(handle);
> +
> +	kfree(handle->name);
> +	kfree(lid);
> +}
> +
> +static const struct input_device_id drm_fb_helper_lid_ids[] = {
> +	{
> +		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_SWBIT,
> +		.evbit = { BIT_MASK(EV_SW) },
> +		.swbit = { [BIT_WORD(SW_LID)] = BIT_MASK(SW_LID) },
> +	},
> +	{ },
> +};
> +
> +static struct input_handler drm_fb_helper_lid_handler = {
> +	.event =	drm_fb_helper_lid_event,
> +	.connect =	drm_fb_helper_lid_connect,
> +	.disconnect =	drm_fb_helper_lid_disconnect,
> +	.name =		"drm-fb-helper-lid",
> +	.id_table =	drm_fb_helper_lid_ids,
> +};
> +
> +static void drm_fb_helper_lid_work(struct work_struct *work)
> +{
> +	struct drm_fb_helper *fb_helper = container_of(work, struct drm_fb_helper,
> +						       lid_work);
> +	drm_fb_helper_hotplug_event(fb_helper);
> +}
> +
> +static int drm_fb_helper_create_lid_handler(struct drm_fb_helper *fb_helper)
> +{
> +	int ret = 0;
> +
> +	if (fb_helper->deferred_setup)
> +		return 0;
> +
> +	fb_helper->input_wq = create_singlethread_workqueue("drm-fb-lid");
> +	if (fb_helper->input_wq == NULL)
> +		return -ENOMEM;
> +
> +	drm_fb_helper_lid_handler.private = fb_helper;
> +	ret = input_register_handler(&drm_fb_helper_lid_handler);
> +	if (ret)
> +		goto remove_wq;
> +
> +	return 0;
> +
> +remove_wq:
> +	destroy_workqueue(fb_helper->input_wq);
> +	fb_helper->input_wq = NULL;
> +	return ret;
> +}
> +
>  /**
>   * drm_fb_helper_prepare - setup a drm_fb_helper structure
>   * @dev: DRM device
> @@ -445,6 +569,7 @@ void drm_fb_helper_prepare(struct drm_device *dev, struct drm_fb_helper *helper,
>  	spin_lock_init(&helper->damage_lock);
>  	INIT_WORK(&helper->resume_work, drm_fb_helper_resume_worker);
>  	INIT_WORK(&helper->damage_work, drm_fb_helper_damage_work);
> +	INIT_WORK(&helper->lid_work, drm_fb_helper_lid_work);
>  	helper->damage_clip.x1 = helper->damage_clip.y1 = ~0;
>  	mutex_init(&helper->lock);
>  	helper->funcs = funcs;
> @@ -593,6 +718,9 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
>  	if (!drm_fbdev_emulation)
>  		return;
>  
> +	input_unregister_handler(&drm_fb_helper_lid_handler);
> +	destroy_workqueue(fb_helper->input_wq);
> +
>  	cancel_work_sync(&fb_helper->resume_work);
>  	cancel_work_sync(&fb_helper->damage_work);
>  
> @@ -1842,6 +1970,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper)
>  	width = dev->mode_config.max_width;
>  	height = dev->mode_config.max_height;
>  
> +	ret = drm_fb_helper_create_lid_handler(fb_helper);
> +	if (ret)
> +		return ret;
> +
>  	drm_client_modeset_probe(&fb_helper->client, width, height);
>  	ret = drm_fb_helper_single_fb_probe(fb_helper);
>  	if (ret < 0) {
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index 63767cf24371..619af597784c 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -316,6 +316,12 @@ struct drm_device {
>  	 * Root directory for debugfs files.
>  	 */
>  	struct dentry *debugfs_root;
> +
> +	/**
> +	 * @lid_closed: Flag to tell the lid switch state
> +	 */
> +	bool lid_closed;
> +
>  };
>  
>  #endif
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 375737fd6c36..7fb36c10299d 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -143,6 +143,8 @@ struct drm_fb_helper {
>  	spinlock_t damage_lock;
>  	struct work_struct damage_work;
>  	struct work_struct resume_work;
> +	struct work_struct lid_work;
> +	struct workqueue_struct *input_wq;
>  
>  	/**
>  	 * @lock:
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

