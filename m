Return-Path: <linux-kernel+bounces-361151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DA99A44B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B73285547
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC9C2178E5;
	Fri, 11 Oct 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UvRmCfMt"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177E216A05
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651712; cv=none; b=MVGOors/UjPcLlzFLX07T68s7CikFhmd089VoPF+z/sBHAZq/lJqeVMcelHEluk5mr6snShRs0/f6olOQmCZFuBwcyZxxAXR1v2RPjyfNXZttIJinL6RGYpkp+2PtkVuX7BqapRNkj8TPvP1qnkHiXI2WGgtHaBvja43TcbnBr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651712; c=relaxed/simple;
	bh=hyGXwd8umVb+UA4ZoFVKXAWJ0fEdDDwxgCHHuxgyIjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQaBbJfd2lYGtFtSRbaPVls4Uw/UhEjLqHnDtaBFotXAyQe620P35te3rVZMBaXZiuQTUiCjZHLZJC0Eu9qwMOt5kKn8mQjC6vOR3QossIl2wmQiNuQfEIaaGGjooeE8u/MWLlZtxAUjVJE1sZIKLOrxBJ4EXSGKPMuBarc9h/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UvRmCfMt; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A69A1C000B;
	Fri, 11 Oct 2024 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728651708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/9V1S9K1PNb5siPRfIuOMpQ1j/WvSIQ1rht6+3lqOlc=;
	b=UvRmCfMtz06kHn/XwG2cZswRr1EuhfMkVW/aAl0f4c6vX/ILdQHSgHBowHGrW8fvEg6lJ1
	m/kPekUvXJCB1/98Rmp+2+EkquQoW3jf62zO4OxjmJVKxymZYZkKU6lzBmbWBvgsv9LNXi
	q2eWwokNrxi2DHK3EgB/qpdlBKZykeb9sJ0ozvtOreWSNHd6VAAp/7QhY/fewF8SblaQyn
	yLA2/qfV584qXja9291pfhkURDRY0Mw4E4SZ75chPWKWmX3NQnOPK1wI3q01w+XiRGIL1U
	Djn9mgpqLidl27n+O+VERh6jEpdFyCQhKXJyuMLi2vF1clmlGy1jkiEcWPQvdA==
Date: Fri, 11 Oct 2024 15:01:46 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm: logicvc: use automatic cleanup facility for
 layers_node
Message-ID: <ZwkhuixQ8sM5pNs7@louis-chauvet-laptop>
Mail-Followup-To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
 <20241011-logicvc_layer_of_node_put-v1-3-1ec36bdca74f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-logicvc_layer_of_node_put-v1-3-1ec36bdca74f@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 11/10/24 - 01:11, Javier Carrasco wrote:
> Use the more robust approach provided by the __free() macro to
> automatically call of_node_put() when the device node goes out of scope.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>  drivers/gpu/drm/logicvc/logicvc_layer.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
> index 34caf5f0f619..9d7d1b58b002 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_layer.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
> @@ -581,12 +581,12 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
>  	struct drm_device *drm_dev = &logicvc->drm_dev;
>  	struct device *dev = drm_dev->dev;
>  	struct device_node *of_node = dev->of_node;
> -	struct device_node *layers_node;
> +	struct device_node *layers_node __free(device_node) =
> +		of_get_child_by_name(of_node, "layers");
>  	struct logicvc_layer *layer;
>  	struct logicvc_layer *next;
>  	int ret = 0;
>  
> -	layers_node = of_get_child_by_name(of_node, "layers");
>  	if (!layers_node) {
>  		drm_err(drm_dev, "No layers node found in the description\n");
>  		ret = -ENODEV;
> @@ -611,14 +611,10 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
>  		}
>  
>  		ret = logicvc_layer_init(logicvc, layer_node, index);
> -		if (ret) {
> -			of_node_put(layers_node);
> +		if (ret)
>  			goto error;
> -		}
>  	}
>  
> -	of_node_put(layers_node);
> -
>  	return 0;
>  
>  error:
> 
> -- 
> 2.43.0
> 

