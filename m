Return-Path: <linux-kernel+bounces-515249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7F7A36251
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1F516AE95
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59905266F19;
	Fri, 14 Feb 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND/wpHyU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC73267383
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548397; cv=none; b=D6m1V8MRAJAwXWuHT9Sg9M+UY61bpFCGApBEmEPFov12Qe0xyQtwmcbOzQ+7y0849DN1KH6u4e4R1RxyP1zZdn65u5pcsRh3xxjWTCOA6CPZHKb9/X9R4+S8YjFfUtQ+sNTKIgCIJ++8T/Fzp4uykliZ01i6g1Eb17ykzCLBaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548397; c=relaxed/simple;
	bh=FYKDIQSkb4oNo/IEZYGwWMmXMD9FjCP7BaaZKOqokoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlaqrhaoiuEgz2EEex/AJQTbak9RWmSeK32S50kYx/LHcD3ygjnbt+XIHpPe6ESoc9GrrqkmGC0YiVkmFPz0I4iIrHxGYiDDAK5J+mRpKjGOk+A9pVvg8PiFdIjd0jeOetNfQhtUAsCBJPnn3EbhBo91duWY7ugJhoBXk9VUpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ND/wpHyU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4395b367329so14599585e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739548394; x=1740153194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LUeXql4TWDHCjVh3ewbV3baFX6FxknoLfQ1URmQIH8w=;
        b=ND/wpHyU+83LLhgBU83AJM/e8lolzq06KKHVy8ufp/DOklPQL5FM96ew1gck4+sYj/
         rQu4VIFnxBmSbdRrGsdogG428DYSb/0K+s1v3s4YLGY9vbYGq0v0s2vMcENQQIe4HTbe
         JFVwt9+eO+d3s6HY9tL6xXNeeTK5EDokV2ETPPSbGSiHbS85IhLc2V1xM+cfpxw8eYec
         hk6HbGX8uAsVu2kwGu779fB8HBi8Bif8VC2fKOVMrl/vTe6HFJkFKZB9UNBoosc8RSLD
         pluXqGxwxVsEhpkyFGcABPynu9bPI2aTPk06kEaiRL+sF3R/40zBYq3r7gMOAxtsJaJs
         9+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548394; x=1740153194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUeXql4TWDHCjVh3ewbV3baFX6FxknoLfQ1URmQIH8w=;
        b=jZrI4bSic499asXSVE/e0Do+FELd8Y9hqPjvZLuCW2PzqDH1TGUTegoaQhm+pg7l6y
         aONPEUyg/VK5p+RF9xKal0hpPL6MpcAa/HcUbQRpFD/PIDlEn/lfzum780QDUorfBEQn
         1VN7FQDgoLrwGzKf/FQ3TRqv3JdsxVVhgoMLprvjw6gdKapUCOWmv+qmkb7Lhc6oGVEU
         Xn1ZM7VEYWZjP6AbE3oxlw2qth0xVhtA9eu0Jj4TbAiDj4hoe/2onxWxFdoQn6zsZ+mx
         iZbzVKfdorj3vLc+pzQIL0BhFXvTGEFiTXKJwpZsxP560ekRPkMpy4nPX7ROl7ZOLWUu
         nD6A==
X-Forwarded-Encrypted: i=1; AJvYcCWaBIqyr9PadQ/UZQstVyJBTm1rLQUI1UkOGbNq2fKLlsO9IMWOFvHtKb8t/kPFXMnE3XIZ+H10yRhcyro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfF2qZNJTeclK0tvG5F1kFMmM8z/jYBiJjTl+RnAjhUgcI2dDp
	0H22o2fCVFNAKG9Y+HLBD+q534Cnc8NZK5WOexC3kAjFyG+B29IK
X-Gm-Gg: ASbGncsCRhjoFpuwibUvWJqjq87RYE7IbiiawsOvD6GrOwKTWdfDNh7L3Uh5+NOvSmw
	lFag4KOYrCWMRxj9RR97BIE9hY1+JecfLW7SGR69el09RW9Jb9OLIvGno4gVfHkg7F7QjDxJXs1
	wuPqUbM0sYiVHICoAKg9VmA+QAIdyxFgfPxlKoOspGUTE48C2RFkxsalzR92ObF6ZjD4/OYm4Cl
	zgWumEZuR11op1wTgAsIWRhCwQJXHzw3/9v9ac8aDDzGtX7fFNWANVpVwXo4CQWgerHavQqgyn+
	yR0DB546vwvGdCo=
X-Google-Smtp-Source: AGHT+IG0lJQY6xjpwwK0gCbW2yA9JBNFByk5LNr2enf7zbh05eh9v7dpT+s+DVjyajrRMWDBxnwtyQ==
X-Received: by 2002:a05:600c:501f:b0:439:5560:c9a3 with SMTP id 5b1f17b1804b1-43960169713mr107862715e9.6.1739548393929;
        Fri, 14 Feb 2025 07:53:13 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06c95bsm77848905e9.17.2025.02.14.07.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:53:13 -0800 (PST)
Date: Fri, 14 Feb 2025 16:53:11 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] drm/vkms: Add a validation function for VKMS
 configuration
Message-ID: <Z69m50L8NzcYt45j@fedora>
References: <20250211110912.15409-1-jose.exposito89@gmail.com>
 <20250211110912.15409-9-jose.exposito89@gmail.com>
 <Z6362KrzjLUL6Mj6@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6362KrzjLUL6Mj6@louis-chauvet-laptop>

On Thu, Feb 13, 2025 at 02:59:52PM +0100, Louis Chauvet wrote:
> On 11/02/25 - 12:09, José Expósito wrote:
> > From: Louis Chauvet <louis.chauvet@bootlin.com>
> > 
> > As the configuration will be used by userspace, add a validator to avoid
> > creating a broken DRM device.
> > 
> > For the moment, the function always returns true, but rules will be
> > added in future patches.
> > 
> > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Co-developed-by: José Expósito <jose.exposito89@gmail.com>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> The compilation is broken when building as module:
> 
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index b9267aef4804..82335006c94a 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -55,6 +55,7 @@ bool vkms_config_is_valid(struct vkms_config *config)
>  {
>         return true;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);

Fixed the issue in all patches, thanks!
 
> > [...]
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> > index fcaa909fb2e0..0376dceaf6be 100644
> > --- a/drivers/gpu/drm/vkms/vkms_config.h
> > +++ b/drivers/gpu/drm/vkms/vkms_config.h
> > @@ -67,6 +67,16 @@ vkms_config_get_device_name(struct vkms_config *config)
> >  	return config->dev_name;
> >  }
> >  
> > +/**
> > + * vkms_config_is_valid() - Validate a configuration
> > + * @config: Configuration to validate
> > + *
> > + * Returns:
> > + * Whether the configuration is valid or not.
> > + * For example, a configuration without primary planes is not valid.
> > + */
> > +bool vkms_config_is_valid(struct vkms_config *config);
> > +
> 
> I think here we can take a const pointer.
> 
> >  /**
> >   * vkms_config_register_debugfs() - Register a debugfs file to show the device's
> >   * configuration
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index a74a7fc3a056..95afc39ce985 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -204,7 +204,7 @@ struct vkms_config;
> >  struct vkms_device {
> >  	struct drm_device drm;
> >  	struct platform_device *platform;
> > -	const struct vkms_config *config;
> > +	struct vkms_config *config;
> 
> So we can keep a const pointer here (for me the device should never modify 
> vkms_config)

I tryed keeping the const pointer, but, since list_count_nodes() is used in
several valid_* functions and it takes a non-const pointer, it causes
warnings.

We can fix them with a cast:

  n_planes = list_count_nodes((struct list_head *)&config->planes);

But I feel that keeping the "const" creates more issues than it solves.

Anyway, if you prefer this pointer to be const, I will change it in v3.

Jose
 
> >  };
> >  
> >  /*
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > index 068a7f87ecec..414cc933af41 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -16,6 +16,9 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> >  	int writeback;
> >  	unsigned int n;
> >  
> > +	if (!vkms_config_is_valid(vkmsdev->config))
> > +		return -EINVAL;
> > +
> >  	/*
> >  	 * Initialize used plane. One primary plane is required to perform the composition.
> >  	 *
> > -- 
> > 2.48.1
> > 

