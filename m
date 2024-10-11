Return-Path: <linux-kernel+bounces-361152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6090499A44C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B322856DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55F2185AB;
	Fri, 11 Oct 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nULeYxQi"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF820C473
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651713; cv=none; b=OBDS6Vh/EzSv3F7L/N7wDr+FHmmcIYsStAqH+q2u3pdQscSJRo1IBXiVO0R6WrcaIgAp7m1Gv6dKx2WH4E1DfbT6rG8Uw0Eu95Ic3fxaY33uCiYGKfxsqGJZjs9CjlbOVTVdLOpH4oTChOig8PYe4C9nGGEkCae0yRDiviBiK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651713; c=relaxed/simple;
	bh=EzWcZ3EqymE4MbIlgmeXjY2sQ4iuL3nIK3HrtI2cifc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4r9XT49WvemZfd6WkCNjdM6FOzQU+YvL0w/J6H/sosTk95cDuT5jBcfXX9t5riZFFcerIiQp7aiXnLwio0NKO1Aby1ks3dKoColy75A8M6/h+1kk4/+2sHZFyl+etdMmsqyMgyq+/a3F1c3GKqD265rE9uxiDVEIaC9kCu58hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nULeYxQi; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B53DFF80C;
	Fri, 11 Oct 2024 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728651709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oFNLMLv8p4sn8aezkzdZsxU4A7uXahszFE92Xgr7dw=;
	b=nULeYxQiiaHy9xULAwglppGuKTvhOc4Vqi14vrMTrxVfKtgB7ar8NsXa6tszOVWlCUMWs1
	SUnz4uQrPqT5ju49zGJMOAHl+5IoS0pl0dQwxqVXWACcDTY3tPLoF/FtgC7tT52B5RRK1c
	fmXsYoiWoPrjZvgYl8/zJFaJD45V29+sByb5MRGI60rCW5wgg+ZQNdLlCE3VFnTjxF2y+k
	rHYSXlQmd4t7wqi6lIbV/SxiC3bm4nrAfAnsw+LKQZnTBnPuWxxoU8Bg9m0bcnD4+hgOYC
	/r/HuPLC4HmEqeGTv87U7TdUhnPynI0q5XsAImqIH1bBhq5evf6/6R09+SC9+A==
Date: Fri, 11 Oct 2024 15:01:47 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm: logicvc: switch to
 for_each_child_of_node_scoped()
Message-ID: <Zwkhuyq39LQSZCIN@louis-chauvet-laptop>
Mail-Followup-To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
 <20241011-logicvc_layer_of_node_put-v1-2-1ec36bdca74f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-logicvc_layer_of_node_put-v1-2-1ec36bdca74f@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Hi,

I think you can squash this commit with the prvious one, I don't think 
this is needed to add of_node_put and remove it just after.

Thanks,
Louis Chauvet

On 11/10/24 - 01:11, Javier Carrasco wrote:
> Use the scoped variant of the macro to avoid leaking memory upon early
> exits without the required call to of_node_put().
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/gpu/drm/logicvc/logicvc_layer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
> index 52dabacd42ee..34caf5f0f619 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_layer.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
> @@ -581,7 +581,6 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
>  	struct drm_device *drm_dev = &logicvc->drm_dev;
>  	struct device *dev = drm_dev->dev;
>  	struct device_node *of_node = dev->of_node;
> -	struct device_node *layer_node = NULL;
>  	struct device_node *layers_node;
>  	struct logicvc_layer *layer;
>  	struct logicvc_layer *next;
> @@ -594,7 +593,7 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
>  		goto error;
>  	}
>  
> -	for_each_child_of_node(layers_node, layer_node) {
> +	for_each_child_of_node_scoped(layers_node, layer_node) {
>  		u32 index = 0;
>  
>  		if (!logicvc_of_node_is_layer(layer_node))
> @@ -613,7 +612,6 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
>  
>  		ret = logicvc_layer_init(logicvc, layer_node, index);
>  		if (ret) {
> -			of_node_put(layer_node);
>  			of_node_put(layers_node);
>  			goto error;
>  		}
> 
> -- 
> 2.43.0
> 

