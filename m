Return-Path: <linux-kernel+bounces-548702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00FA54861
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE333A55A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417812040BD;
	Thu,  6 Mar 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivyaBach"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418C53BE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258182; cv=none; b=HX88dqHop8vy4BR7iwVD5cJenNiz9dxA1SxLwlu7rBoihcBsXSFiD2eLu4z/hlNQ0vOLM7ztGfAcFdcGtBi7Q1DE110TeZKvp91AFJJ5LvvimZp16nfk3WymetioUlXXZLxFGojJ8CvpH1V/+g6ELNuauIJubfC0pF5wrMgK2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258182; c=relaxed/simple;
	bh=C5IkZKBEQFtWnHaDR6RgLVRlBS1QiHXM2vpHawf2k5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgCgRoP3SNoD4YG4WdeDUorR9ajOEjrbJO3sJ+xualebmrNUsvmpHYDGJmRxrEzVCb+XLjLDXgtn9wrKDnT+vKpZpWHCai4b/CsbUKgEaTE5YcNuwQ2jGSVLbcA8klaklQCnw7F3UUKKashHM/Lwe42E2GvX96g+jvZdGnm0N8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivyaBach; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso3002945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741258178; x=1741862978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPq6CfuM/9epSJQ5qan4iieYXluNdh1lWPLg0zDe+dk=;
        b=ivyaBachEYBkuqVQJVrJorPjAHRdAVpJGfqullZ2HSv/A4E3tYBgUDzaTMkM5Ch+YQ
         5siOp6pee071IeFzi2ZqzVFP4w3QlmhfkVV/2VEav2MJFwOFZBcMSx7vjuWggrpKpci8
         5nVvh4Hy3SM5tN24lQSWvYIxhoiLU7Fn0lszndy6KQ9USRUSgMXLtGWOOSbD2tZnkCXc
         rZ1B2zBeymmpalUHELLOwUv7C3FhE0J9pgDgLafSwHlgwFSDBHsqFLNo7RDaOBFmfW+b
         xqJvA5CWUzb0RnjrHfFgmwtNaYLp7qjvy0jsQcDAAL08xFyG8z0oRyiXmmkJhXmvEQI3
         QyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258178; x=1741862978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPq6CfuM/9epSJQ5qan4iieYXluNdh1lWPLg0zDe+dk=;
        b=qx4BngYwjqMp8BsoCtdJaDtcyBd3/3x7DFrmvzzlhqKHJ50wj2lc2D2QukvzOApHzi
         Z0juCJhW4gc3alckRJV89VZhT+xSsnzyC4+igp/XwSROLpkq6rG2jPA7p2g9vOPfaHOS
         iU/sFJwOOazMzvxGFNoi2T3QbvLZMK+MLKKYbppBIPeul+gzG2WUFzqlmfAnEQ4VIk7S
         jyZVUhCn8KVcxlRs+NU7HoFOCZTwsYFrc1yptxaTDSnMP14jCp9HjkcGFV8L3DWExL+J
         s1xm9UMfliEkzrni7SMMAC9RgPNLa+edlmX62NOWFaz98Nxel01PTs1R1u07PbtPsHu4
         NTaA==
X-Forwarded-Encrypted: i=1; AJvYcCXoz81MYUAzqeYBYB8wqYBVi7TD8g6/41+nV1F1f+4rg6OM6fxGos/3URfFqQtgs2XlCW9i+ufVzhPsEKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgzqWxxxVIhF3VZ+2tj066eM+nyCx8m9/EHj6brKjhEwzSmLFV
	qR6+/sj7g55KmAszPvvFcCDk7ibeLtVrz4v+7ebnZIcS6Sd24Odkibp09VIi
X-Gm-Gg: ASbGncvFKU80JZCUps+SnH+BkHtLFpKB3MWLVcD+p7n1vmyx30IDKjEjwaWVVr4uSmT
	85qEZXK9FgUJhOY6mLgjL78UsPVobQimWImbm6x91tLdedXkVXu1DWis7itP2+6yzfu4G1sQWZO
	RcRjutUaLQ4WAyEzgG0jw86Iw0Nc9J5u7Bn2+23PddqIIbMybEAStfPGtLR80ywg3plO5URh6FY
	Ck8nXthCVAtCHrSbTE2K0HpoegXzZNLIe6VeHi6PE0PzUXZnjaygWoCe8TtECujXfxRbtrGOo+B
	qBFBoOofwJ5efkMTRaww/wcmpejj/JP7wYAiYnftE2k7
X-Google-Smtp-Source: AGHT+IHnX6SiWzMoCGL6P5TJkV77SJo6sxHfxSWyJ8LddfFC/TkuF415sAvFNV27LZ2CQvLukHXELQ==
X-Received: by 2002:a05:600c:4ed2:b0:43b:c3b0:56af with SMTP id 5b1f17b1804b1-43bd29a30d4mr57386285e9.14.1741258177773;
        Thu, 06 Mar 2025 02:49:37 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd93cac5sm15995605e9.27.2025.03.06.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:49:37 -0800 (PST)
Date: Thu, 6 Mar 2025 11:49:35 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/16] drm/vkms: Allow to configure multiple planes
 via configfs
Message-ID: <Z8l9v0xJppuxG0Cd@fedora>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
 <20250225175936.7223-4-jose.exposito89@gmail.com>
 <52bc3f15-28da-4b40-917f-981f1f10d9b8@bootlin.com>
 <Z8VtPMzuZOYqjraQ@fedora>
 <e813ac5b-298c-4863-b0b6-e9ac7fec1da0@bootlin.com>
 <Z8cUN8Q4L0VE-bVm@fedora>
 <fa4f4d3d-6a3e-4659-8a59-4928c2285d55@bootlin.com>
 <Z8cpH3twrgmR0TxI@fedora>
 <fd63f9c0-d5da-438c-b307-5b9a9f97f1d2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd63f9c0-d5da-438c-b307-5b9a9f97f1d2@bootlin.com>

Hi Louis,

On Tue, Mar 04, 2025 at 07:17:53PM +0100, Louis Chauvet wrote:
> 
> 
> Le 04/03/2025 à 17:23, José Expósito a écrit :
> > On Tue, Mar 04, 2025 at 04:35:50PM +0100, Louis Chauvet wrote:
> > > 
> > > 
> > > Le 04/03/2025 à 15:54, José Expósito a écrit :
> > > > Hi Louis,
> > > > 
> > > > On Mon, Mar 03, 2025 at 11:34:50AM +0100, Louis Chauvet wrote:
> > > > > 
> > > > > 
> > > > > Le 03/03/2025 à 09:50, José Expósito a écrit :
> > > > > > Hi Louis,
> > > > > > 
> > > > > > On Fri, Feb 28, 2025 at 03:43:25PM +0100, Louis Chauvet wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > Le 25/02/2025 à 18:59, José Expósito a écrit :
> > > > > > > > Create a default subgroup at /config/vkms/planes to allow to create as
> > > > > > > > many planes as required.
> > > > > > > > 
> > > > > > > > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > > > Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > > > > > > > [...]
> > > > > > > > diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> > > > > > > > index 92512d52ddae..4f9d3341e6c0 100644
> > > > > > > > --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> > > > > > > > +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> > > > > > > > [...]
> > > > > > > > +static void plane_release(struct config_item *item)
> > > > > > > > +{
> > > > > > > > +	struct vkms_configfs_plane *plane;
> > > > > > > > +	struct mutex *lock;
> > > > > > > > +
> > > > > > > > +	plane = plane_item_to_vkms_configfs_plane(item);
> > > > > > > > +	lock = &plane->dev->lock;
> > > > > > > > +
> > > > > > > > +	guard(mutex)(lock);
> > > > > > > > +	vkms_config_destroy_plane(plane->config);
> > > > > > > > +	kfree(plane);
> > > > > > > > +}
> > > > > > > 
> > > > > > > I just found a flaw in our work: there is currently no way to forbid the
> > > > > > > deletion of item/symlinks...
> > > > > > > 
> > > > > > > If you do:
> > > > > > > 
> > > > > > > modprobe vkms
> > > > > > > cd /sys/kernel/config/vkms/
> > > > > > > mkdir DEV
> > > > > > > mkdir DEV/connectors/CON
> > > > > > > mkdir DEV/planes/PLA
> > > > > > > mkdir DEV/crtcs/CRT
> > > > > > > mkdir DEV/encoders/ENC
> > > > > > > ln -s DEV/crtcs/CRT DEV/planes/PLA/possible_crtcs/
> > > > > > > ln -s DEV/crtcs/CRT DEV/encoders/ENC/possible_crtcs
> > > > > > > ln -s DEV/encoders/ENC DEV/connectors/CON/possible_encoders
> > > > > > > echo 1 > DEV/planes/PLA/type
> > > > > > > tree
> > > > > > > echo 1 > DEV/enabled
> > > > > > > modetest -M vkms
> > > > > > > => everything fine
> > > > > > > 
> > > > > > > rm DEV/connectors/CON/possible_encoders/ENC
> > > > > > > rmdir DEV/connectors/CON
> > > > > > > modetest -M vkms
> > > > > > > => BUG: KASAN: slab-use-after-free
> > > > 
> > > > I'm trying to reproduce this issue, but those commands don't show any BUG
> > > > in dmesg. This is my Kasan .config:
> > > > 
> > > >       CONFIG_HAVE_ARCH_KASAN=y
> > > >       CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> > > >       CONFIG_CC_HAS_KASAN_GENERIC=y
> > > >       CONFIG_CC_HAS_KASAN_SW_TAGS=y
> > > >       CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> > > >       CONFIG_KASAN=y
> > > >       CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> > > >       CONFIG_KASAN_GENERIC=y
> > > >       # CONFIG_KASAN_OUTLINE is not set
> > > >       CONFIG_KASAN_INLINE=y
> > > >       CONFIG_KASAN_STACK=y
> > > >       CONFIG_KASAN_VMALLOC=y
> > > >       # CONFIG_KASAN_KUNIT_TEST is not set
> > > >       CONFIG_KASAN_EXTRA_INFO=y
> > > > 
> > > > I tryed to delete even more items:
> > > > 
> > > >       root@kernel-dev:/sys/kernel/config/vkms# tree
> > > >       .
> > > >       └── DEV
> > > >           ├── connectors
> > > >           ├── crtcs
> > > >           ├── enabled
> > > >           ├── encoders
> > > >           └── planes
> > > > 
> > > >       root@kernel-dev:/sys/kernel/config/vkms# cat DEV/enabled
> > > >       1
> > > > 
> > > > And I still don't see any errors. Is it possible that we are running different
> > > > branches? Asking because of the failing IGT tests you reported. There seems to
> > > > be a difference in our code or setup that is creating these differences.
> > > 
> > > I just re-applied your last vkms-config version and this series on top of
> > > drm-misc-next. See [1] for the exact commits.
> > > 
> > > Argg sorry, I just noticed something: you need to disable the default vkms
> > > device (I had this option in my kernel command line...), otherwise modetest
> > > only use the first vkms gpu...
> > > 
> > > I will check again the igt tests, but I don't think this is the same issue
> > > (it should not use the default device to test)
> > > 
> > > So, with [1] and the defconfig below, I have this:
> > > 
> > > 
> > >      1  modprobe vkms create_default_dev=0
> > >      2  cd /sys/kernel/config/vkms/
> > >      3  mkdir DEV
> > >      4  mkdir DEV/connectors/CON
> > >      5  mkdir DEV/planes/PLA
> > >      6  mkdir DEV/crtcs/CRT
> > >      7  mkdir DEV/encoders/ENC
> > >      8  ln -s DEV/crtcs/CRT DEV/planes/PLA/possible_crtcs/
> > >      9  ln -s DEV/crtcs/CRT DEV/encoders/ENC/possible_crtcs
> > >     10  ln -s DEV/encoders/ENC DEV/connectors/CON/possible_encoders
> > >     11  echo 1 > DEV/planes/PLA/type
> > >     12  tree
> > >     13  echo 1 > DEV/enabled
> > >     14  modetest -M vkms
> > >     15  rm DEV/connectors/CON/possible_encoders/ENC
> > >     16  rmdir DEV/connectors/CON
> > >     17  modetest -M vkms
> > > KASAN: slab-use-after-free
> > > 
> > > 
> > > [1]:https://github.com/Fomys/linux/tree/20250225175936.7223-1-jose.exposito89%40gmail.com
> > 
> > Aha! Are you testing without a desktop environment running?
> 
> Yes! I run a minimal VM (virtme-ng), so no services are started.
> > 
> >      $ sudo systemctl isolate multi-user.target
> > 
> > Running that (^) command before yours gives me this use after free:
> > 
> >      BUG: KASAN: slab-use-after-free in vkms_connector_detect+0x61/0x70 [vkms]
> > 
> > Is the same one you are seeing?
> 
> Yes!
> 
> > Looking at the connector_release() function in vkms_configfs.c, I see
> > that I'm freeing the configuration:
> > 
> >      vkms_config_destroy_connector(connector->config);
> > 
> > And I don't think there is a reason to do it. vkms_config_destroy() in
> > device_release() will free everything once we are done.
> 
> Yes, but if you don't free it will always remain in the config, which means
> that:

Busy week, but I finally have a couple of hours to sit and look into this
with detail.

The problem is in my patch to implement connector hot-plug ("drm/vkms: Allow
to update the connector status").

I was storing a pointer to the connector configuration in vkms_connector (OK)
and using it to get the connector status (wrong).
The configuration is mean to be used during device initialization, but after
that, it can change at any point responding to configfs changes.

I even documented that accessing vkms_config_connector->connector is not
safe... Just to access it a few patches later (sigh).
In my opinion, the solution is to avoid this behavior. This is how the fix
looks like [1]. The code is even simpler than the  previous version.

[1] https://github.com/JoseExposito/linux/commit/da116085590d644575e9d78fb5c3a665aa7848f5
 
> modprobe vkms create_default_dev=0
> cd /sys/kernel/config/vkms/
> mkdir DEV
> mkdir DEV/connectors/CON
> mkdir DEV/crtcs/CRT
> mkdir DEV/planes/PLA
> mkdir DEV/encoders/ENC
> ln -s DEV/crtcs/CRT DEV/planes/PLA/possible_crtcs/
> ln -s DEV/crtcs/CRT DEV/encoders/ENC/possible_crtcs
> ln -s DEV/encoders/ENC DEV/connectors/CON/possible_encoders
> echo 1 > DEV/planes/PLA/type
> echo 1 > DEV/enabled
> echo 0 > DEV/enabled
> rm DEV/connectors/CON/possible_encoders/ENC
> rmdir DEV/connectors/CON
> echo 1 > DEV/enabled
> 
> Expected (and current) result:
> 
> (NULL device *): [drm] The number of connectors must be between 1 and 31
> 
> Result with the diff:
> - vkms_config_destroy_connector(connector->config);
> + //vkms_config_destroy_connector(connector->config);
> 
> (NULL device *): [drm] All connectors must have at least one possible
> encoder
> 
> This is because the connector list in vkms_config contains the deleted CON
> connector. If you also remove the connector from the list, it will be a
> memory leak.
> 
> The solution I proposed with get/put should solve this: once the device is
> disabled, all the release functions (and the corresponding
> vkms_config_destroy) will be called, so no issue there.
> 
> I attempted to do it, but it looks a bit more complex than I expected:
> - config_item_get works as expected, if you get all the items in
> device_enabled_store they are not released, even if the directory is
> deleted;
> - but as the directory is deleted, you can't use cg_children to put your
> last reference on it.
> 
> I think a solution could be to add refcounting in vkms_config, it seems to
> work, and it is even better, the refcounting is done in the vkms driver, not
> in configfs (I did it only for connector, see below). It seems to work as
> expected and doesn't increase the complexity of the code.
> 
> Do you think this is sufficient/clear enough?


This would also work. But, is it worth to include this complexity now?
I think that the configuration is handled correctly as it is now, we just
need to make sure that we don't rely on invalid pointers (as documented).

Enjoy your day,
Jose
 
> Have a nice day,
> Louis Chauvet
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c
> b/drivers/gpu/drm/vkms/vkms_config.c
> index f8394a063ecf..4dc65ab15517 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
> 
> +#include <linux/kref.h>
>  #include <linux/slab.h>
> 
>  #include <drm/drm_print.h>
> @@ -123,7 +124,7 @@ void vkms_config_destroy(struct vkms_config *config)
>  		vkms_config_destroy_encoder(config, encoder_cfg);
> 
>  	list_for_each_entry_safe(connector_cfg, connector_tmp,
> &config->connectors, link)
> -		vkms_config_destroy_connector(connector_cfg);
> +		vkms_config_connector_put(connector_cfg);
> 
>  	kfree_const(config->dev_name);
>  	kfree(config);
> @@ -596,17 +597,32 @@ struct vkms_config_connector
> *vkms_config_create_connector(struct vkms_config *c
> 
>  	list_add_tail(&connector_cfg->link, &config->connectors);
> 
> +	kref_init(&connector_cfg->ref);
>  	return connector_cfg;
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
> 
> -void vkms_config_destroy_connector(struct vkms_config_connector
> *connector_cfg)
> +static void vkms_config_destroy_connector(struct vkms_config_connector
> *connector_cfg)
>  {
>  	xa_destroy(&connector_cfg->possible_encoders);
>  	list_del(&connector_cfg->link);
>  	kfree(connector_cfg);
>  }
> -EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_connector);
> +// EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_connector);
> +
> +static void vkms_config_destroy_connector_kref(struct kref *kref)
> +{
> +	struct vkms_config_connector *connector = container_of(kref, struct
> vkms_config_connector, ref);
> +
> +	vkms_config_destroy_connector(connector);
> +}
> +
> +void vkms_config_connector_get(struct vkms_config_connector *connector) {
> +	kref_get(&connector->ref);
> +}
> +void vkms_config_connector_put(struct vkms_config_connector *connector) {
> +	kref_put(&connector->ref, vkms_config_destroy_connector_kref);
> +}
> 
>  int __must_check vkms_config_connector_attach_encoder(struct
> vkms_config_connector *connector_cfg,
>  						      struct vkms_config_encoder *encoder_cfg)
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h
> b/drivers/gpu/drm/vkms/vkms_config.h
> index e202b5a84ddd..30e6c6bf34f4 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -3,6 +3,7 @@
>  #ifndef _VKMS_CONFIG_H_
>  #define _VKMS_CONFIG_H_
> 
> +#include <linux/kref.h>
>  #include <linux/list.h>
>  #include <linux/types.h>
>  #include <linux/xarray.h>
> @@ -109,6 +110,7 @@ struct vkms_config_encoder {
>   *             configuration and must be managed by other means.
>   */
>  struct vkms_config_connector {
> +	struct kref ref;
>  	struct list_head link;
>  	struct vkms_config *config;
> 
> @@ -416,11 +418,8 @@ void vkms_config_encoder_detach_crtc(struct
> vkms_config_encoder *encoder_cfg,
>   */
>  struct vkms_config_connector *vkms_config_create_connector(struct
> vkms_config *config);
> 
> -/**
> - * vkms_config_destroy_connector() - Remove and free a connector
> configuration
> - * @connector_cfg: Connector configuration to destroy
> - */
> -void vkms_config_destroy_connector(struct vkms_config_connector
> *connector_cfg);
> +void vkms_config_connector_get(struct vkms_config_connector *connector);
> +void vkms_config_connector_put(struct vkms_config_connector *connector);
> 
>  /**
>   * vkms_config_connector_attach_encoder - Attach a connector to an encoder
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c
> b/drivers/gpu/drm/vkms/vkms_configfs.c
> index 76afb0245388..ae929a084feb 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -550,7 +550,7 @@ static void connector_release(struct config_item *item)
>  	lock = &connector->dev->lock;
> 
>  	guard(mutex)(lock);
> -	vkms_config_destroy_connector(connector->config);
> +	vkms_config_connector_put(connector->config);
>  	kfree(connector);
>  }
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c
> b/drivers/gpu/drm/vkms/vkms_connector.c
> index ed99270c590f..c15451b50440 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -20,6 +20,15 @@ static enum drm_connector_status
> vkms_connector_detect(struct drm_connector *con
>  	return status;
>  }
> 
> +static void vkms_connector_destroy(struct drm_device *dev, void *raw)
> +{
> +	struct vkms_connector *vkms_connector = raw;
> +
> +	vkms_config_connector_put(vkms_connector->connector_cfg);
> +
> +	return;
> +}
> +
>  static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.detect = vkms_connector_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
> @@ -65,8 +74,13 @@ struct vkms_connector *vkms_connector_init(struct
> vkms_device *vkmsdev,
>  	if (!connector)
>  		return ERR_PTR(-ENOMEM);
> 
> +	vkms_config_connector_get(connector->connector_cfg);
>  	connector->connector_cfg = connector_cfg;
> 
> +	ret = drmm_add_action_or_reset(dev, &vkms_connector_destroy, connector);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	ret = drmm_connector_init(dev, &connector->base, &vkms_connector_funcs,
>  				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
>  	if (ret)
> 
> 

