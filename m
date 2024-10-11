Return-Path: <linux-kernel+bounces-361159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0CB99A46F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0AE31F23396
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1B218D60;
	Fri, 11 Oct 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JcO8Ow4y"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852920C470
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652011; cv=none; b=MJqjV6/FvGUDFqC4xdWkBJRJMwZb06YPiRaF6Vo2O4rLELll4SiJuStOr938bFlPXBAzDKCDJ4hJbvuwJMAGvKurR2aWlwjZszARDwKxF8+vCXR5z+DuCTSQe4zq4xsaHYTlgY5g8eA3Tg0/3tf60nbsi2baN3eM6l8AQxResAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652011; c=relaxed/simple;
	bh=KUBiqA4WjzRZH9kFIB3CupqXylYT2VQLYbNM1WUAb3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mB4tMZoTIhlqmpClwGkmtvmbfyXGLdIBlrTCbh16J28dLJd7IJv0c7PrtZR7m+e6/3iYXZ4xb9ehWqtCYyJjspcal90vDEDbashSGkyfmFAc5c0SQraCf6IXbvMzkkMh7hbCZkcex4PUufbAoqZfmmAO+JPEtok/IRX69vPiB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JcO8Ow4y; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05D1B24000C;
	Fri, 11 Oct 2024 13:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728652007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=va6exM7TampWufolr0qRhd5kwXqWbjQ0tpvTh3dbHc0=;
	b=JcO8Ow4yyZgcJHxt4LR+QUGDVVyRMKV77Vc7MwfFCiabyB/OTIjHXokQLfNZSQllsrsvfB
	aApcpbl6syJWoGRhsqVsYcagrKCB8IQW7HN8eCx8+zNuhr/5B+GmnTvERQBj1OQHiYhSP1
	62of95LJiaKgUESkVxiWJupOfkNdFq+hC7j4ahdZX/uYUBClve6MiqG3jCjWUMlSyKvP8T
	L22nzwd1A7kicb+yUILIkOGrVXvIY+qsWOworgfwvipMTkLPTra+JZmiF02ItOj/qyosa7
	sBmj/ARjWIVH87W7RXBrHpsFT7FN7GCEsESFW5TKX+bciE+nfE1uDCe38c+VdA==
Date: Fri, 11 Oct 2024 15:06:45 +0200
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
Message-ID: <Zwki5WaFLUBmf3j3@louis-chauvet-laptop>
Mail-Followup-To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
 <20241011-logicvc_layer_of_node_put-v1-2-1ec36bdca74f@gmail.com>
 <Zwkhuyq39LQSZCIN@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwkhuyq39LQSZCIN@louis-chauvet-laptop>
X-GND-Sasl: louis.chauvet@bootlin.com

On 11/10/24 - 15:01, Louis Chauvet wrote:
> Hi,
> 
> I think you can squash this commit with the prvious one, I don't think 
> this is needed to add of_node_put and remove it just after.

Forget this, I missed the Fixes in the first commit, sorry for the noise.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> Thanks,
> Louis Chauvet
> 
> On 11/10/24 - 01:11, Javier Carrasco wrote:
> > Use the scoped variant of the macro to avoid leaking memory upon early
> > exits without the required call to of_node_put().
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> >  drivers/gpu/drm/logicvc/logicvc_layer.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
> > index 52dabacd42ee..34caf5f0f619 100644
> > --- a/drivers/gpu/drm/logicvc/logicvc_layer.c
> > +++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
> > @@ -581,7 +581,6 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
> >  	struct drm_device *drm_dev = &logicvc->drm_dev;
> >  	struct device *dev = drm_dev->dev;
> >  	struct device_node *of_node = dev->of_node;
> > -	struct device_node *layer_node = NULL;
> >  	struct device_node *layers_node;
> >  	struct logicvc_layer *layer;
> >  	struct logicvc_layer *next;
> > @@ -594,7 +593,7 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
> >  		goto error;
> >  	}
> >  
> > -	for_each_child_of_node(layers_node, layer_node) {
> > +	for_each_child_of_node_scoped(layers_node, layer_node) {
> >  		u32 index = 0;
> >  
> >  		if (!logicvc_of_node_is_layer(layer_node))
> > @@ -613,7 +612,6 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
> >  
> >  		ret = logicvc_layer_init(logicvc, layer_node, index);
> >  		if (ret) {
> > -			of_node_put(layer_node);
> >  			of_node_put(layers_node);
> >  			goto error;
> >  		}
> > 
> > -- 
> > 2.43.0
> > 

