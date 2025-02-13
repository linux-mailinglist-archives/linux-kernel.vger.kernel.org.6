Return-Path: <linux-kernel+bounces-513274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE4A347CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63E518859CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188EA1547E3;
	Thu, 13 Feb 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTD3569h"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E414F121
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460781; cv=none; b=b51re9xGhF6FOgmwAoeS1xNRocCK0p8xvHioXCqCiQ3Xr4Etn+R/AbXNWftog9II+XP5kFqpj5NsEjXogUF4GSp06TFXM69dOGnV3zfUE+FECutGoKRvVr5U4lQsd3R1IKuOfXMFM3NRXkUPLE/K0bIYz+koB0hk0w2mvftmLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460781; c=relaxed/simple;
	bh=vbayAeoJDSdwSGxBNk9gnsZeGtsOkumOKXo8+A5ID2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndr0xC5OCxl4d0Y3C2Ti8cb3oM4vgxLFZYyBzYZQo+BdKZx3pfKtaERCSPJ/m4fVMlZl7X+LrujLEv1iqP5M9n+uBSBQzl7BNka9c0/DNa8tI51jQVUqrhsWHWgGG7BQHE7CkLQMadpcciZ+DbFUnXevgi0jOzf/2SAzsEDF+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTD3569h; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso557901f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739460777; x=1740065577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MfLc32cRf3eetQpPP5I7Ug+lhC4HSsOzdCRi3IPd+cY=;
        b=FTD3569hxUuWCSLyNqJZNwLEkC7VMzfjdnbFDpquVzgPZ5rdBr2GiFsluYKiC/XitR
         juwAzAam0bTGChQjPd5bCTirLlRtb4CdDP6CnJmyfAZ8jAafFsjeK0qmJVV3faP16Mk7
         UlQxLWV+UVt5Y/OtDFgjrotA0qtlEZgW2NO1eT55TxgurTmV9CK/cz0sRrRgK7pXpSQd
         1eimEuWKznvOJfs97wUc+PJnBYAjmHy1yx9mV0f/uMyttLdRdBCKr6sQrelZrBE85Vac
         ifna/kfii8e4ZR2Pyk62cMSXdJQUkGmDRRqkbbEb7nIPFnTM30DoqvTqX+F+HQjqKu76
         SXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460777; x=1740065577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfLc32cRf3eetQpPP5I7Ug+lhC4HSsOzdCRi3IPd+cY=;
        b=GvgsBKPdKIq6mYJB90n7DwwyJJE7k7UJfquA+ae621705WlFkoIVlnh6Ni7t7Vgy21
         Sk8dhs/JT9qh61i1N+BbYXk8/dDmWK216czGY+qGftG8HyjS5lZcFhZOuLxJgFwncj5o
         02Yn6W7hGU4MydozjowG19qas0uWNVGmgn0gaSMUI7Ay69tPOKwnG2K+WGLkzGMoKRLF
         gRsYKkeLgjsNfnSWxzf6Z1vEak3HqmSMglJ4DO7r1iQ9pztWsx4oRlBRpkot85Sdhipl
         rEY5u0gSIC17OR9/DG9YjJdq+aCy40cklEi12ga3MizK8uvGzkP40uoK4HxLfkRhXLTG
         kgOw==
X-Forwarded-Encrypted: i=1; AJvYcCXYt2yImA2sRKvDaKGsktAYdj4qPQhF+IRXvRNDhR0vCbQ4q9JR2gMaJ1AkPmn1oIXL7hTdP7CGVFnyZyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyijeb4N8O3JZdvmPI2pfE6JNYp+32aMPkaanNOisx3POS++1Ns
	LNv149s/gLV6uR1VnlUMVx3Aw3jLlDsbLiuFBikm44xC3yRofsJL
X-Gm-Gg: ASbGncuDjAA/k4LOF18iHOPw6Ah4sDd6mEQy3tLIUyTfKNqJC6ZDE77QaYzT19fb1fY
	wX/UQ5fnqwkseNGjOff3vDD8X5zMAIV8b+Udk/NcPDeIBQOlCTKDFh5t5whAlCzPmk0VntGRvBY
	H5VEnHWTZLSiE+CmFv5DnaaJUqxLNV7xfLiMn+h0O6dDZTtZQDY0CVCr5YqvRoWmaSle7yAwdv9
	3+NNaUlQS8iB3im632AooFO2+051Xamc3muxVRETHzpEQ3A7AqHk4LJiwDGvZ1PWExlGe/mB482
	Bd1J/vqC15BizAc=
X-Google-Smtp-Source: AGHT+IFlrVjfyCynKmQHnjJcSFdCu8zrg+P3t2BTmUgSmBdpMC/9LI9CKtj1SkjQ1nL3tla2lBW9fQ==
X-Received: by 2002:a05:6000:402c:b0:38b:d7c3:3768 with SMTP id ffacd0b85a97d-38dea3cfaabmr7191145f8f.12.1739460777196;
        Thu, 13 Feb 2025 07:32:57 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5eeesm2200468f8f.63.2025.02.13.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:32:56 -0800 (PST)
Date: Thu, 13 Feb 2025 16:32:54 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] drm/vkms: Allow to attach planes and CRTCs
Message-ID: <Z64QpktpcVjtelKY@fedora>
References: <20250129110059.12199-1-jose.exposito89@gmail.com>
 <20250129110059.12199-10-jose.exposito89@gmail.com>
 <Z5uDJd4iV9Vnrp9e@louis-chauvet-laptop>
 <Z6sq0h0lKxjmBcxk@fedora>
 <b05831de-c67b-4ba9-8808-f049d97b3654@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b05831de-c67b-4ba9-8808-f049d97b3654@bootlin.com>

On Wed, Feb 12, 2025 at 03:10:49PM +0100, Louis Chauvet wrote:
> 
> 
> Le 11/02/2025 à 11:47, José Expósito a écrit :
> > On Thu, Jan 30, 2025 at 02:48:21PM +0100, Louis Chauvet wrote:
> > > On 29/01/25 - 12:00, José Expósito wrote:
> > > > Add a list of possible CRTCs to the plane configuration and helpers to
> > > > attach, detach and get the primary and cursor planes attached to a CRTC.
> > > > 
> > > > Now that the default configuration has its planes and CRTC correctly
> > > > attached, configure the output following the configuration.
> > > > 
> > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > > 
> > > Co-developped-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > > 
> > > [...]
> > > 
> > > > +int __must_check vkms_config_plane_attach_crtc(struct vkms_config_plane *plane_cfg,
> > > > +					       struct vkms_config_crtc *crtc_cfg)
> > > > +{
> > > > +	struct vkms_config_crtc *possible_crtc;
> > > > +	unsigned long idx = 0;
> > > > +	u32 crtc_idx = 0;
> > > > +
> > > > +	xa_for_each(&plane_cfg->possible_crtcs, idx, possible_crtc) {
> > > > +		if (possible_crtc == crtc_cfg)
> > > > +			return -EINVAL;
> > > 
> > > Is it really an error? After this call, we expect plane and crtc to be
> > > attached, so if the plane is already attached, I don't see any issue.
> > 
> > In my opinion, this could be either handled as an error or not. I think that
> > there are arguments for both approaches but, for our use case, I think that it
> > is better to return an error.
> > 
> > Since the main (and for the moment only) user of this function will be configfs,
> > it is very convenient to return an error to avoid creating 2 links between
> > plane <-> crtc.
> > 
> > If we allow to create multiple links, and the user deletes one of them, the
> > items would be still linked, which is a bit unexpected.
> > 
> > The same applies to the other vkms_config_*_attach_* functions.
> 
> I see your reasoning, I did not think about this issue.
> We can keep the error, but can we use `EEXIST` to reflect better the status?

Very good point, I'll change it to EEXIST in v3.
 
> And I just think about it, maybe we can add here the check "is the crtc part
> of the same config as the plane" (and return EINVAL if not)? It will remove
> the need to do the check in configFS + avoid errors for future users of
> vkms_config.

Another excellent point. Since we can not use the vkms_config_plane.plane and
vkms_config_crtc.crtc pointers to check if they belong to the same device, the
only solution I see is adding a pointer to the parent vkms_config to every
structure (vkms_config_plane, vkms_config_crtc, etc).

In this way we can do something like:

  if (plane_cfg->config != crtc_cfg->config)
          return -EINVAL;

I tried with container_of(), but I don't think it'll work with the current data
structure.

Unless you can think of a better solution, I'll implement this in v3.

Thanks for the great comments,
Jose

> > For these reasons, I didn't change it in v2, let me know your opinion.
> > Jose
> > 
> > > > +	}
> > > > +
> > > > +	return xa_alloc(&plane_cfg->possible_crtcs, &crtc_idx, crtc_cfg,
> > > > +			xa_limit_32b, GFP_KERNEL);
> > > > +}
> > > > +
> > > 
> > > [...]
> > > 
> > > > +struct vkms_config_crtc **vkms_config_plane_get_possible_crtcs(struct vkms_config_plane *plane_cfg,
> > > > +							       size_t *out_length)
> > > > +{
> > > > +	struct vkms_config_crtc **array;
> > > > +	struct vkms_config_crtc *possible_crtc;
> > > > +	unsigned long idx;
> > > > +	size_t length = 0;
> > > > +	int n = 0;
> > > > +
> > > > +	xa_for_each(&plane_cfg->possible_crtcs, idx, possible_crtc)
> > > > +		length++;
> > > > +
> > > > +	if (length == 0) {
> > > > +		*out_length = length;
> > > > +		return NULL;
> > > > +	}
> > > > +
> > > > +	array = kmalloc_array(length, sizeof(*array), GFP_KERNEL);
> > > > +	if (!array)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	xa_for_each(&plane_cfg->possible_crtcs, idx, possible_crtc) {
> > > > +		array[n] = possible_crtc;
> > > > +		n++;
> > > > +	}
> > > > +
> > > > +	*out_length = length;
> > > > +	return array;
> > > > +}
> > > 
> > > Same as before, can we use an iterator?
> > > 
> > > > +static struct vkms_config_plane *vkms_config_crtc_get_plane(const struct vkms_config *config,
> > > > +							    struct vkms_config_crtc *crtc_cfg,
> > > > +							    enum drm_plane_type type)
> > > 
> > > Even if this is a private function, can we add a comment explaning that
> > > the returned value is only one of the available planes of this type?
> > > 
> > > 	/**
> > > 	 * vkms_config_crtc_get_plane() - Get the first attached plane
> > >           * found of a specific type
> > > 	 * @config: configuration containing the crtc and the planes
> > > 	 * @crtc_cfg: Only find planes attached to this CRTC
> > > 	 * @type: Plane type to search
> > > 	 *
> > > 	 * Returns:
> > > 	 * The first plane found attached to @crtc_cfg with the type
> > > 	 * @type.
> > > 	 */
> > > 
> > > > +{
> > > > +	struct vkms_config_plane *plane_cfg;
> > > > +	struct vkms_config_crtc *possible_crtc;
> > > > +	enum drm_plane_type current_type;
> > > > +	unsigned long idx;
> > > > +
> > > > +	list_for_each_entry(plane_cfg, &config->planes, link) {
> > > > +		current_type = vkms_config_plane_get_type(plane_cfg);
> > > > +
> > > > +		xa_for_each(&plane_cfg->possible_crtcs, idx, possible_crtc) {
> > > > +			if (possible_crtc == crtc_cfg && current_type == type)
> > > > +				return plane_cfg;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return NULL;
> > > > +}
> > > 
> > > [...]
> > > 
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> > > 
> > > [...]
> > > 
> > > > +/**
> > > > + * vkms_config_crtc_primary_plane() - Return the primary plane for a CRTC
> > > > + * @config: Configuration containing the CRTC
> > > > + * @crtc_config: Target CRTC
> > > > + *
> > > > + * Returns:
> > > > + * The primary plane or NULL if none is assigned yet.
> > > > + */
> > > 
> > > Same as above, can you speficy that it is one of the primary plane?
> > > 
> > > > +struct vkms_config_plane *vkms_config_crtc_primary_plane(const struct vkms_config *config,
> > > > +							 struct vkms_config_crtc *crtc_cfg);
> > > > +
> > > > +/**
> > > > + * vkms_config_crtc_cursor_plane() - Return the cursor plane for a CRTC
> > > 
> > > Ditto
> > > 
> > > [...]
> > > 
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > > 
> > > [...]
> > > 
> > > > @@ -35,19 +41,54 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> > > >   			ret = PTR_ERR(plane_cfg->plane);
> > > >   			goto err_free;
> > > >   		}
> > > > +	}
> > > > +
> > > > +	for (n = 0; n < n_crtcs; n++) {
> > > > +		struct vkms_config_crtc *crtc_cfg;
> > > > +		struct vkms_config_plane *primary, *cursor;
> > > > +
> > > > +		crtc_cfg = crtc_cfgs[n];
> > > > +		primary = vkms_config_crtc_primary_plane(vkmsdev->config, crtc_cfg);
> > > > +		cursor = vkms_config_crtc_cursor_plane(vkmsdev->config, crtc_cfg);
> > > 
> > > Linked with a previous comment: here we have no garantee that primary is a
> > > valid pointer, can we check it or call vkms_config_is_valid to ensure it?
> > > 
> > > > +		crtc_cfg->crtc = vkms_crtc_init(dev, &primary->plane->base,
> > > > +						cursor ? &cursor->plane->base : NULL);
> > > > +		if (IS_ERR(crtc_cfg->crtc)) {
> > > > +			DRM_ERROR("Failed to allocate CRTC\n");
> > > > +			ret = PTR_ERR(crtc_cfg->crtc);
> > > > +			goto err_free;
> > > > +		}
> > > 
> > > [...]
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

