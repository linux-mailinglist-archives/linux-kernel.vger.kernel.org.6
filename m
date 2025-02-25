Return-Path: <linux-kernel+bounces-531148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B6A43CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9168B1887A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00502686B3;
	Tue, 25 Feb 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CRD/Sx42"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF24267B62
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481328; cv=none; b=bF4TjExOyWVBud9nb+fZDaIa3GRmLXBH3yC5tzFqZlKm/9LL2JGxgRdbKzQNGsyqU/O3NbCU0GuTF6zYipC7IQfrA1cpl54uJTzBNneSEEqHGn1IRDzEXjz19niRuUmqAq+NiH5W1le4yr8R4SBIVyGPJahnmG/QDv880F6s8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481328; c=relaxed/simple;
	bh=pFFzzramd1nCYafjv6ASMELph/8d/Fh5aGXMeUL04mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftwn3Fkcb6W8lYXJzW90Uefsr+AvmhtKSuQkfsd5bv+7WW8LnlajFsRONE92O54hwOUzXShow/eScSV4OjrVxHFg/BTrluSZDgWWA9VjdnKhN2UEWbuMjzmPkvmVvcVUEdclR0NRYrUKE7SgIH67Av+AkLEqF3aWacDy9Spn4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CRD/Sx42; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CB1843301;
	Tue, 25 Feb 2025 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740481324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5sWEpE4uOKT4TprGad6WnC/VIKjHhmFSa2c30FZG1I=;
	b=CRD/Sx42PpoYeWAVMq38b4T0uqevKqvIp4QpEXT3dJ0jAb8x1sTGk0lCJ3TSFB4nky9VLV
	VcdorUZKd4uuPB6JSTr4TWfPOK8un+6P5bk2cGpvrwZqIhLR//og9+EaB2s1b2pTKtK4NJ
	07AFK7NQJbCXvnnBSee1sAW8KBKfbLgj/RozfzbJEUsBS8Ycz7G9jfOawKWm5MeZe/6GM5
	hM2td1+IqVtTu8p3BgOihXl1sWj3dh1xBLb+hjXnuwPd9I5Kj+RJ2s1Vx7DjRrhuWwvp/A
	+7LfWQoPrEneGXdQQhjpTrkWdnw+gb2tQweWaWuuiZoHD7JDXBQU7m/IRYf36g==
Date: Tue, 25 Feb 2025 12:02:02 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] drm/vkms: Allow to configure the plane type via
 configfs
Message-ID: <Z72jKlNJDCisHvfO@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
 <20250218170808.9507-5-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218170808.9507-5-jose.exposito89@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfejveetkedvleetudeuudegfeejheeujeefkefgtdeugfetfeeutdevieekvdeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrgdrshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrs
 hhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/02/25 - 18:07, José Expósito wrote:
> When a plane is created, add a `type` file to allow to set the type:
> 
>  - 0 overlay
>  - 1 primary
>  - 2 cursor
> 
> Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  Documentation/gpu/vkms.rst           |  4 +++
>  drivers/gpu/drm/vkms/vkms_configfs.c | 51 ++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index bf23d0da33fe..d95f228de05b 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -84,6 +84,10 @@ Start by creating one or more planes::
>  
>    sudo mkdir /config/vkms/my-vkms/planes/plane0
>  
> +Planes have 1 configurable attribute:
> +
> +- type: Plane type: 0 overlay, 1 primary, 2 cursor
> +

Maybe we can say:

- type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
  exposed by the "type" property of a plane)

>  Once you are done configuring the VKMS instance, enable it::
>  
>    echo "1" | sudo tee /config/vkms/my-vkms/enabled
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index dd9dfe51eb3a..093735f47858 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -54,6 +54,56 @@ struct vkms_configfs_plane {
>  #define plane_item_to_vkms_configfs_plane(item) \
>  	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
>  
> +static ssize_t plane_type_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +	enum drm_plane_type type;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	mutex_lock(&plane->dev->lock);
> +	type = vkms_config_plane_get_type(plane->config);
> +	mutex_unlock(&plane->dev->lock);

I think we should consider using scoped_gard instead of mutex_lock/unlock. 
This may avoid issues (in many other functions there are early returns, 
where a scoped_guard may help).

I am not against "pure" mutex_lock/unlock (I am not 100% sure that 
scoped_guard really improve the readability), but I think we should be 
consistent: if we want to profit from scoped_guard in some functions, we 
should use it everywhere in this file.

(all my R-by are valid with or without scoped_guard)

> +
> +	return sprintf(page, "%u", type);
> +}
> +
> +static ssize_t plane_type_store(struct config_item *item, const char *page,
> +				size_t count)
> +{
> +	struct vkms_configfs_plane *plane;
> +	enum drm_plane_type type;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	if (kstrtouint(page, 10, &type))
> +		return -EINVAL;
> +
> +	if (type != DRM_PLANE_TYPE_OVERLAY && type != DRM_PLANE_TYPE_PRIMARY &&
> +	    type != DRM_PLANE_TYPE_CURSOR)
> +		return -EINVAL;
> +
> +	mutex_lock(&plane->dev->lock);
> +
> +	if (plane->dev->enabled) {
> +		mutex_unlock(&plane->dev->lock);
> +		return -EPERM;

I just tough about it, but is -EPERM also the return value when you don't
have the right to write on the file? What do you think about -EBUSY? It 
also describe a bit better the situation (Device or resource busy vs 
Operation not permitted).

Thanks,
Louis Chauvet

> +	}
> +
> +	vkms_config_plane_set_type(plane->config, type);
> +
> +	mutex_unlock(&plane->dev->lock);
> +
> +	return (ssize_t)count;
> +}
> +
> +CONFIGFS_ATTR(plane_, type);
> +
> +static struct configfs_attribute *plane_item_attrs[] = {
> +	&plane_attr_type,
> +	NULL,
> +};
> +
>  static void plane_release(struct config_item *item)
>  {
>  	struct vkms_configfs_plane *plane;
> @@ -73,6 +123,7 @@ static struct configfs_item_operations plane_item_operations = {
>  };
>  
>  static const struct config_item_type plane_item_type = {
> +	.ct_attrs	= plane_item_attrs,
>  	.ct_item_ops	= &plane_item_operations,
>  	.ct_owner	= THIS_MODULE,
>  };
> -- 
> 2.48.1
> 

