Return-Path: <linux-kernel+bounces-447756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35759F36B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608DB161E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8A52066FE;
	Mon, 16 Dec 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oXu1PLji"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7620457E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367815; cv=none; b=NCAPmhVpxnV1/QJheBQo3PGXQsmHmjktHVNhm4+/9hctmtlC9HT2clfxqdHGaA2sFZClK8hmMn5qiI090azQ7j2vGCADLyQSzQ9gO2O8hseemXtReeOsVVjhLTG9PCScn9w8mk14BINltYKJfniWWKFH6rQftDmLAHjHX2wQu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367815; c=relaxed/simple;
	bh=KDTe9le6iCMn4xg/inbeBbCO4zVU+eag/IvFNgrGKZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2wd3VkxugaP7Y8o0eGjDG9gMWbFxHLZEjspHN06FROvS4K/Ba2ohddakwagHToDfi9xYiGrRDI5RilVne+95VVJm1rfcU0+aGuTAWm3Gh4AjHZnzItN7f1m2j5aD9slqnosnh22KKrpYvfYsURJpUbso8+oVrvpgY4Gg75cftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oXu1PLji; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B311240010;
	Mon, 16 Dec 2024 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734367811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zfMhMkW/a+1TMO5UzQynBO30fRRDOQ5DSRCkSiAREG8=;
	b=oXu1PLji4PEH9RI5YEBdZPvs76V8Q3qtfuFXuUwWd3Hrg6Y1r+0LbWIbBzkSjz+elekQQr
	/sJp9iysS8NR+xqElZwYThooqECUYPyAyFtU/s/zD73gLly6/1opnt8Eo6RlAbBYqnsYBp
	L7SMXQ+nr+JEVIaseGPYw8dVVZU8MvyDHxKM4EuruwwCTPGbh2jTkDRN7fhiyN/IYrfXil
	0puHd74/TcmhAEVQ0jPtet9IZOQfCaEzT5nujUnQXe0RCyhBrjQmWQ6TtOzM29TSIzOSTX
	nQD9PX11/m/QECDKnCh3B0FJ3KEfje3G6zWSwSYTTktA0OYHIaTn4FUD+KYxwQ==
Date: Mon, 16 Dec 2024 17:50:08 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/4] drm/drm_mode_object: fix typo in kerneldoc
Message-ID: <Z2BaQLufuadQuLyi@louis-chauvet-laptop>
Mail-Followup-To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
 <20241216-drm-small-improvements-v3-1-78bbc95ac776@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-drm-small-improvements-v3-1-78bbc95ac776@bootlin.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 16/12/24 - 17:40, Luca Ceresoli wrote:
> Remove unintended extra word.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Acked-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>  include/drm/drm_mode_object.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
> index 08d7a7f0188fea79e2d8ad5ee6cc5044300f1a26..c68edbd126d04d51221f50aa2b4166475543b59f 100644
> --- a/include/drm/drm_mode_object.h
> +++ b/include/drm/drm_mode_object.h
> @@ -35,7 +35,7 @@ struct drm_file;
>   * @id: userspace visible identifier
>   * @type: type of the object, one of DRM_MODE_OBJECT\_\*
>   * @properties: properties attached to this object, including values
> - * @refcount: reference count for objects which with dynamic lifetime
> + * @refcount: reference count for objects with dynamic lifetime
>   * @free_cb: free function callback, only set for objects with dynamic lifetime
>   *
>   * Base structure for modeset objects visible to userspace. Objects can be
> 
> -- 
> 2.34.1
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

