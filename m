Return-Path: <linux-kernel+bounces-240875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A92692740A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFAD1C21B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721061AB91E;
	Thu,  4 Jul 2024 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XSuS5L7S"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DE1AB90F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088813; cv=none; b=rzC+6DRdmKH8piTX9MR66aDqvZzXdWQlLojjge/iRzYvij8N8WbQI7oe9z2p3bzTdUZezBL6n489LpeIAdKFsRLQYQzj1h5av+K5o1NeyiD2nPb8nwlnSjXb82KddAvcIYTO03ootNI5X5OciUw7o1AlH7Mo0PiOc/Yi4qtlV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088813; c=relaxed/simple;
	bh=IypEibvkrkoOtsmmd52r1d6X+uhsajx+iSNQcujP2fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHgrtA4CjicJHc7hkJvBAXovro5kRSax2oq3mOYSStYLyS8pVKphJTMmUQTOinOsaZkdICrwGIKnAdmGbrGxk76+rTmcEiLeOQXvftn84KJ2DEBJ4WREhlHLgPQh86f4YmvRMabn2+BzFSZs7MiK0sRLe2CEB+GQwykiLk7pPfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XSuS5L7S; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 282B7FF802;
	Thu,  4 Jul 2024 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720088804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c8lHuSxIC0xsXfjFa++wNy/K3qw8ReVVWevEHg/8VI=;
	b=XSuS5L7SjBODsSS6KyhRKpPAvcobZlSVf7QHVPCfD2bzMyxtN7pmBchTNFZUnMJGjyHUWm
	c3ngMQgyw8tYk07DMlv748w+UiuQwXpjM0N0aHDxlqZ7WgdC404OzkvQXfFUd51eGAg3IQ
	oNIJybFdNqdwatfZwuU/PtQdAErC9c1Ef3r7a8nehiDwjsg6scr4MimBosBlRYsrSAW83K
	E/Ck378RexxwnBz42RCkvg7Y/STpV3N4nj/HH/GGjYAy3RAeMc0sPk9WwiNGabfITHmCWa
	lfpp+VcZfP3TxtW7A+u53SkfZmfS6OcxnU5ZQlqLM19K+Ruh05yHexEjME5qQA==
Date: Thu, 4 Jul 2024 12:26:41 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vkms: Remove event from vkms_output
Message-ID: <ZoZ44eg5YrZAcApx@louis-chauvet-laptop>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
	dri-devel@lists.freedesktop.org,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240703160458.1303872-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703160458.1303872-1-lyude@redhat.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 03/07/24 - 12:04, Lyude Paul a écrit :
> While working on rvkms, I noticed that there's no code that actually uses
> the drm_pending_vblank_event that's embedded in vkms_output. So, just drop
> the member from the struct.

This seems to be a leftover of the work on the introduction on vblank, if 
you look at the V1 [1] you can see it was used, but not removed on the 
last iteration [2].

It apply properly on drm-misc-next and igt test kms_flip/kms_vblank are 
success.

[1]: https://lore.kernel.org/all/20180625171922.5ofev566kghxxxwu@smtp.gmail.com/
[2]: https://lore.kernel.org/all/5d9ca7b3884c1995bd4a983b1d2ff1b840eb7f1a.1531402095.git.rodrigosiqueiramelo@gmail.com/

Reviewed-By: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-By: Louis Chauvet <louis.chauvet@bootlin.com>

> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 8f5710debb1eb..5e46ea5b96dcc 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -103,7 +103,6 @@ struct vkms_output {
>  	struct drm_writeback_connector wb_connector;
>  	struct hrtimer vblank_hrtimer;
>  	ktime_t period_ns;
> -	struct drm_pending_vblank_event *event;
>  	/* ordered wq for composer_work */
>  	struct workqueue_struct *composer_workq;
>  	/* protects concurrent access to composer */
> -- 
> 2.45.2
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

