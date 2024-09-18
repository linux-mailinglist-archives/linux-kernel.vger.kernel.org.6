Return-Path: <linux-kernel+bounces-332687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604FE97BD2B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2164D28535B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E4B18A924;
	Wed, 18 Sep 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ifdgk4eC"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1A1EEFC
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666770; cv=none; b=pTzSeyVSx5UT06fn6l5S6iXNeIXAaZJZYderqQIiSfXW34w4Vtkh1E6eknvDaIw1+tcVUX6EU3tlxczsPVdYXU/fxbrljzD6223nkeaDo9I04z3VG8YCvNpOzRuVdDwDVjiHsep7XG6ILuSmpt46oE3giMo184GXvpciZZhV84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666770; c=relaxed/simple;
	bh=KQgIQbiowq8Wbchi38LslMZGiochBH+GJIYPyoA5TE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbrJlWq+vT4OaHDiuuVZ7O9Tj7jTo0ZjMwTJ2YYoNgiFYJ3z93Qko5SB0miNjc4Zp+6q+IzEn9NYJcgGkX3ZzwY1YtBx6lDHjfqNicU9en0aFYk7+wzfgQbzIsNswylDjHElK9jTsrG6StM05/lDmzCQ0JQrbW19EpFK+41BNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ifdgk4eC; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19ED01C000F;
	Wed, 18 Sep 2024 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726666766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVeKnWxaNpVxsIAc9HPLTlzEDqHJ7vPdmZMa8pzgBis=;
	b=ifdgk4eCesLWlfrokNQRvSdunE47acjIsd2ra+9Jsdl3wNjGlgYLrdaDvSF6t/rtKJ+C+v
	vlFYWnW5fGo/ymEKSgYkH4oae/T8A7cXrhRKZMhaTqKDFYuzlZRdTwDl9sbSZ4IiYy2NdE
	wimorRXNCM93+DxNE4jg+WGF4dk8Pl9eRDKDGsAjAscjOdCYJOPlE2FdXISJOBSIetQzWZ
	k9gMf1kbbp1Cl15RW3IaFqRK2M0puu41TlP8EITcDzrDYw+peccPLJ22eZKWwqXgyJ6DSQ
	vdaatoovlsjIisHUJe/uS4skqjsq1UJ4i8KxI2AS75Sdd0C1I/yPQVc5qq0yUQ==
Date: Wed, 18 Sep 2024 15:39:23 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com, thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/vkms: Add missing check for CRTC initialization
Message-ID: <ZurYC1Ez8K0UsJ_Y@localhost.localdomain>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com, thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
References: <20240906-vkms-add-missing-check-v1-1-1afb3bf3d0a6@bootlin.com>
 <20240917160208.2905-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917160208.2905-1-jose.exposito89@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 17/09/24 - 18:02, José Expósito a écrit :
> Hi Louis,
> 
> > CRTC initialization call drm_mode_crtc_set_gamma_size without the proper
> > checks, introduce this check to avoid issues.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> Reviewed-by: José Expósito <jose.exposito89@gmail.com>
> 
> > ---
> >  drivers/gpu/drm/vkms/vkms_crtc.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > 
> > ---
> > base-commit: a6bb1f77a94335de67dba12e7f52651c115b82d2
> > change-id: 20240906-vkms-add-missing-check-e1b6ee8d1b39
> > 
> > Best regards,
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > index 40b4d084e3ce..e4f93dfbd071 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -287,7 +287,12 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> >  
> >  	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
> >  
> > -	drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
> > +	ret = drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
> > +	if (ret) {
> > +		DRM_ERROR("Failed to set gamma size\n");
> 
> This will conflit with "drm/vkms: Switch to dynamic allocation
> for CRTC" [1], where you switched to DRM_DEV_ERROR.

I did not check if my series had conflict between them, so I'm not 
surprised. I will change it to the DEV variant and send a v2, espicially 
since Leo [1] wants to work to clean the logging in VKMS :-)

[1]:https://lore.kernel.org/all/CAHhBtNqB=jQTnY1eu8or=toczr93ehUeuBkAZ7axFPr4ZHPjCQ@mail.gmail.com/

> No proferences about the log function, just a heads up so when
> you rebase one of the patches we keep logging consistent.
> 
> [1] https://patchwork.kernel.org/project/dri-devel/patch/20240912-b4-vkms-allocated-v1-3-29abbaa14af9@bootlin.com/
> 
> > +		return ret;
> > +	}
> > +
> >  	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_LUT_SIZE);
> >  
> >  	spin_lock_init(&vkms_out->lock);
> > 

