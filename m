Return-Path: <linux-kernel+bounces-541203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8965DA4B9FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABA27A4033
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F81F12EB;
	Mon,  3 Mar 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRFmhJl8"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7481F0E56
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991810; cv=none; b=KRHgz/npNRtkEKSFiqqI4kEqIXeyUnwdgXZSEii9tCxs0iUZVVUO0KIICgwe1ztZbF79p6CIE/5vFIwZUvfjNl0aFlPR3PsFG5tmcpoyH4TqBIef3KW7mIUtpvbYOGlSfQrZc55Ob2AtmdBrZp+b/WkAwRNDK0UdTi3Ip+fbCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991810; c=relaxed/simple;
	bh=rGGB1rMFrgTOm0MYQGwkKc7J7RFG+rDr5TCYXywOskA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL0SAATQCNqTe39XCoatZAutjyG3sHLTMS1x5SUUKtee5hm7a3zDDeqYbtyVFfRrN9FioMC5PdH69idAs/8oV8yEADZuNTM8nITCyeenIxPDmKNEb9iYlxu/hrjA/UkPaX/Z5gadgiNW8i+UkpogvQzcKitAvn1G8CP8McGQUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRFmhJl8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bc30adad5so3131965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740991807; x=1741596607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qZdu6KpTyckEllv7JF1hPQ7bOXBdnXW3T0hcvXgW7pg=;
        b=cRFmhJl88v/1k+q8fkqapCxNiLWOqiht0sWh9hby5K+JD5MxKMuBL8ctg14wdk4xSc
         XBnSTsyBCLUZ/41o1wPs2hP5Ukv70Aeseq+7qDSLF1ajsrpAvco9o+5IZsWdDmTB+ZXt
         JdbFWceXfWShi5X8hFPDYOqxOsgxqYLnUy90Up1i5SKB8K49pvnuZb+6R46i67zFXr/w
         JpbwUWt9d0b4AxgdRwfywVTHsjaN5LwRfGAmgCvo+uXrEycfXZ4tun1XilDqflKJ3Xxo
         iEonncN8qnQIf+1IuUOS3gVlyeJ4EQ8nFRtSvhLdV6gy3/PpT7XagHIn87HLaMhjD6AA
         JEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991807; x=1741596607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZdu6KpTyckEllv7JF1hPQ7bOXBdnXW3T0hcvXgW7pg=;
        b=XemRAUzdMbC+aDrU/Do+YqOi32lPlbPe92l/UM+QDJ8e1nVMc3qXOW6BuxTauPGZTR
         VzHxzRYwtqcm7FnXQ8mivEwv5e8F4+5cqtMtW1V8rc1q1+Rv7jL+Bwpt8p7f15V7qLMz
         pauUmPYj0DnrypnXmxBCgjMw22Rvmwol7WV8QFDoyAspbI6tuoqWb89ZTo7qAGCrOj78
         z2tRcpbRNwybmPtKpuFpPCS4vpb2/ZfCExOsgFBKaufAXJtDQdYVW6/ozSicbPbbHYPM
         8mKaVFTbLCk+qCRIglAXWyVwvegNDKJlLaabdqE2rCKqMsp9WiiH1vxc70hnV/ckDP4E
         AwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuMZKoSel3c1lAHpUgJA1IMrIVd+H5YuSaP0czNNW3a1xUPbyZpVscVdqgIKG757Vy1h34qY1VW+1xVzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmXPIYZAdVEVqmwmEZPfsvcos+m6QyjDcrFF8jOHimlEKu2Qm
	IJFdnC9gz4kNyMwz/Krf6Ss6nneiCj3uhoFKnb9Jb18EOIaEjLa+
X-Gm-Gg: ASbGncuDMR28xphzIdYS4P8PtSnebTSc7UQ2CaQjxD4ehyoA5UbVpsoQXIxAUGKo9PK
	1BcWhjAt6oM/pk99sJGNQqzg0BuOjLMUjON/jhCisL+lr1+5TACBoDhTQRZe7xWZYKko42rLlVE
	JPk7giHyvuaSiSgCupUgSe7JIvEcm9mepPsy3Ve7AxjxSNtOm80zGX0wrCQc2HOCA6y2yM+A/f7
	KfXQQ2mPVbdNHIJE+szXq/Rhor/Q6bYKd/d83pR2hLvESiGrMBcp0xz0yiQ5sHNl40F0oD4ZOwY
	PNWBKqR1+0aNsG++FXp/seD3g6K6Eh42yI8WkfI+RbQS
X-Google-Smtp-Source: AGHT+IFp8zeZFS+eosFaNtDEwWL1ljXKipPC9K2EPzzTWHRdNbSNMhLfBAGYV5aLZ/82bCSmHMJC8A==
X-Received: by 2002:a05:600c:5123:b0:439:9274:81ed with SMTP id 5b1f17b1804b1-43ba66da789mr81399965e9.1.1740991806388;
        Mon, 03 Mar 2025 00:50:06 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5711fcsm187140325e9.28.2025.03.03.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:50:05 -0800 (PST)
Date: Mon, 3 Mar 2025 09:50:04 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/16] drm/vkms: Allow to configure multiple planes
 via configfs
Message-ID: <Z8VtPMzuZOYqjraQ@fedora>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
 <20250225175936.7223-4-jose.exposito89@gmail.com>
 <52bc3f15-28da-4b40-917f-981f1f10d9b8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52bc3f15-28da-4b40-917f-981f1f10d9b8@bootlin.com>

Hi Louis,

On Fri, Feb 28, 2025 at 03:43:25PM +0100, Louis Chauvet wrote:
> 
> 
> Le 25/02/2025 à 18:59, José Expósito a écrit :
> > Create a default subgroup at /config/vkms/planes to allow to create as
> > many planes as required.
> > 
> > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > [...]
> > diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> > index 92512d52ddae..4f9d3341e6c0 100644
> > --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> > +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> > [...]
> > +static void plane_release(struct config_item *item)
> > +{
> > +	struct vkms_configfs_plane *plane;
> > +	struct mutex *lock;
> > +
> > +	plane = plane_item_to_vkms_configfs_plane(item);
> > +	lock = &plane->dev->lock;
> > +
> > +	guard(mutex)(lock);
> > +	vkms_config_destroy_plane(plane->config);
> > +	kfree(plane);
> > +}
> 
> I just found a flaw in our work: there is currently no way to forbid the
> deletion of item/symlinks...
> 
> If you do:
> 
> modprobe vkms
> cd /sys/kernel/config/vkms/
> mkdir DEV
> mkdir DEV/connectors/CON
> mkdir DEV/planes/PLA
> mkdir DEV/crtcs/CRT
> mkdir DEV/encoders/ENC
> ln -s DEV/crtcs/CRT DEV/planes/PLA/possible_crtcs/
> ln -s DEV/crtcs/CRT DEV/encoders/ENC/possible_crtcs
> ln -s DEV/encoders/ENC DEV/connectors/CON/possible_encoders
> echo 1 > DEV/planes/PLA/type
> tree
> echo 1 > DEV/enabled
> modetest -M vkms
> => everything fine
> 
> rm DEV/connectors/CON/possible_encoders/ENC
> rmdir DEV/connectors/CON
> modetest -M vkms
> => BUG: KASAN: slab-use-after-free
> 
> 
> I see two solutions:
> - we don't care and keep as is: if the device is enabled, and you delete
> link/groups, it is your fault. As shown above: it can crash the kernel, so
> it is a no-go.

I was aware of this limitation and, since the configfs is clear about
deleting items: [1]

    Important:
    drop_item() is void, and as such cannot fail. When rmdir(2) is called,
    configfs WILL remove the item from the filesystem tree (assuming that
    it has no children to keep it busy).
    The subsystem is responsible for responding to this. [...]

I decided to follow this approach, i.e., allowing the user to delete the items.

However, that use-after-free is a bug I need to fix. I was wondering how I didn't
catch it with IGT... Turns out, I didn't enable Kasan in my QEMU .config (ops!).

Do you agree on folowing this solution? If so, I'll send v3 fixing the memory
issues.

Best wishes,
Jose

[1] https://docs.kernel.org/filesystems/configfs.html

> - we care and we don't want to touch configfs: we need to implement a kind
> of refcount for all vkms_config elements. Issue: non-trivial work, may allow
> memory leaks/use after free...
> 
> - we care and we want to touch configfs: see my two patches (they apply on
> the v1 of this series). This solution allows adding a check before removing
> configfs item/group/link. I found it cleaner and way easier to understand.
> 
> What do you think about my proposition? Do you have another idea?
> 
> > +static struct configfs_item_operations plane_item_operations = {
> > +	.release	= &plane_release,
> > +};
> > +
> > +static const struct config_item_type plane_item_type = {
> > +	.ct_item_ops	= &plane_item_operations,
> > +	.ct_owner	= THIS_MODULE,
> > +};
> > +
> > +static struct config_group *make_plane_group(struct config_group *group,
> > +					     const char *name)
> > +{
> > +	struct vkms_configfs_device *dev;
> > +	struct vkms_configfs_plane *plane;
> > +
> > +	dev = child_group_to_vkms_configfs_device(group);
> > +
> > +	guard(mutex)(&dev->lock);
> > +
> > +	if (dev->enabled)
> > +		return ERR_PTR(-EBUSY);
> > +
> > +	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
> > +	if (!plane)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	plane->dev = dev;
> > +
> > +	plane->config = vkms_config_create_plane(dev->config);
> > +	if (IS_ERR(plane->config)) {
> > +		kfree(plane);
> > +		return ERR_CAST(plane->config);
> > +	}
> > +
> > +	config_group_init_type_name(&plane->group, name, &plane_item_type);
> > +
> > +	return &plane->group;
> > +}
> > +
> > +static struct configfs_group_operations planes_group_operations = {
> > +	.make_group	= &make_plane_group,
> > +};
> > +
> > +static const struct config_item_type plane_group_type = {
> > +	.ct_group_ops	= &planes_group_operations,
> > +	.ct_owner	= THIS_MODULE,
> > +};
> > +
> >   static ssize_t device_enabled_show(struct config_item *item, char *page)
> >   {
> >   	struct vkms_configfs_device *dev;
> > @@ -125,6 +208,10 @@ static struct config_group *make_device_group(struct config_group *group,
> >   	config_group_init_type_name(&dev->group, name, &device_item_type);
> >   	mutex_init(&dev->lock);
> > +	config_group_init_type_name(&dev->planes_group, "planes",
> > +				    &plane_group_type);
> > +	configfs_add_default_group(&dev->planes_group, &dev->group);
> > +
> >   	return &dev->group;
> >   }
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

