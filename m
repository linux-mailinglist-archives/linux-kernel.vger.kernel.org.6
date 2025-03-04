Return-Path: <linux-kernel+bounces-544947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72B2A4E6DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9360616CB1B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49129AB0D;
	Tue,  4 Mar 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7bu+oox"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6CA29AAEB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105445; cv=none; b=ifM6r0vIe40oLdG+Jz7a3emDFIHzl0vZ5g17EodhjXlJ5L1oR320+udmz9Rus9dmjoEt9kEsGiOkhA5xowWKIMp28nBcQcvyfw/U6li/9WRY9QrXLpJ5KEh6mf96fRskt51YAJFx/iMLCIbpZnW1Q//FR7ChcOwMgLYD/2uHIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105445; c=relaxed/simple;
	bh=4KSIt6vBOanDjBpTZgRlj0nkQkwIc/+HLRbwY34EN/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+O6d/o4kYdbNYrNstamJz01oA3Iki9VCr1fQpmbpXgeR9WtzYRc5wiTUFhFxNfNU9dqenYJWtt0qaafmnLCZ0jWq7vT14+sG4F+xzH4e8NRJA2ZJcg3vW11umWqB0uUtNgbI9DJciGTKTRVfd7MwqivBnrETDK52fbB8d1RwtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7bu+oox; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3910e101d0fso1572589f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741105442; x=1741710242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uVbvDZB+IJrQpd/hNp9y18jlS3CDe75NL2VwvVRA+J0=;
        b=G7bu+ooxhZeme6tszKDg+6mg72maBEvaHCJuf35LAWtaoHBjlBkqOSr+8A+oGylAB/
         mjN62kJvYNJVfDCM7LqEdpIuBK2dksZIkoSDgaZkeLWOWXqtw+ezU/r+tONwgPTFJPMM
         lxEmsMzigUUATDj/CXuJl6/3hczs89CBK3xhkzDnv9sYu5RqCotDNAUwNK8H2Hc0ZrEz
         4N4a8VHZpTt8xtTlmNw+my30DQWwTqGlLXqOASewzG4B6Gz/4JY8zWRuIWlw0GKmEker
         x3YbO9z/jUWoo0yx9hxTMMtW0RzSMaDrViurRHGNDJbqpbWtUQT8iKcwOpbEoH+jXt0L
         dpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105442; x=1741710242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVbvDZB+IJrQpd/hNp9y18jlS3CDe75NL2VwvVRA+J0=;
        b=oUi3D4ZlHO0eNk16kFMxy/Xx7m7D2PlFXQN883boo4crJTwnk53qXgY9luP6RHutSz
         Z1WshcMdWG3meuVoEXBOaSrm38aKU5eIe9DcllYA43LKqsm7xHubJGZSo1fBRzSa9JxH
         hmYKm19raKJ0KLTvUEbk3WeR8rJaaT8PwtRs6d++X4WchKDvDLzGOu1+2Days7vPajH3
         zFynsAQDqihNiXwxNY3ipFYOsBKFWrrOAB3kvzojnTWlYIDGcZqGGVd4hs0TgmbH/VQ4
         3YO18QDRsoB2pt5LCfXbmkizOdOKYlb/mz9Ho/mkY7zMFEG3DYdBjov0YC9UagazhzjC
         nzIA==
X-Forwarded-Encrypted: i=1; AJvYcCVSNiL7NM0oK0i1v/jdrSp+MLO0E1p7U5f7bVeRaXpWCyca16pJgAB9ERqO+IpgVCegIDWK5VJ4n+UEBHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5nW/1SkWztHOQk0/vfz6bE1ijTX/ibDKmvMrai+qkU5DxgIa
	G9lN0xF4wXiEk35PfH4iJKriQ91iANozjxZXsqegOZU8urx4nYRDl6eE6gYd
X-Gm-Gg: ASbGnctyVPhHJKg6XUc/3Swp9qbsYP5h7VQWh917AtdkvxUVHVvKa3c8a9LbJ+nCBek
	YlvljvE5Heco6BcG3VyhxGkThU6pWTwYWhkIgtyTJcS4D0mADZWU5Dbrfondk530rasw1OfbGJC
	bZm5wCfsYJEsWqRe0nmbmCNdu/QeWuvs8sEG2vzRvtYoklfTtO3ayWyzUsTsommF7vAiboc7O7E
	J4Dub7pohAFPIRhY74CY8DYdXba6K5vRwnD6fhXrKuUBO2bJz9pPJGbNU30Qe1RY5ji6tRsFg/S
	ccEdKjUo6iMWdPpZd+5x+Y+5sXul41Zcj/QjgWD96h9P
X-Google-Smtp-Source: AGHT+IGMIS2aLhK7uobDdnveYDLx1tS9uqOCKZtLvyb3p283SA+j2mJnpNH2NrYDBSEI26XgLy7RZw==
X-Received: by 2002:a05:6000:178b:b0:390:e5c6:920 with SMTP id ffacd0b85a97d-390ec7ca9c5mr13454926f8f.3.1741105441832;
        Tue, 04 Mar 2025 08:24:01 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7850sm18402130f8f.39.2025.03.04.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:24:01 -0800 (PST)
Date: Tue, 4 Mar 2025 17:23:59 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/16] drm/vkms: Allow to configure multiple planes
 via configfs
Message-ID: <Z8cpH3twrgmR0TxI@fedora>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
 <20250225175936.7223-4-jose.exposito89@gmail.com>
 <52bc3f15-28da-4b40-917f-981f1f10d9b8@bootlin.com>
 <Z8VtPMzuZOYqjraQ@fedora>
 <e813ac5b-298c-4863-b0b6-e9ac7fec1da0@bootlin.com>
 <Z8cUN8Q4L0VE-bVm@fedora>
 <fa4f4d3d-6a3e-4659-8a59-4928c2285d55@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa4f4d3d-6a3e-4659-8a59-4928c2285d55@bootlin.com>

On Tue, Mar 04, 2025 at 04:35:50PM +0100, Louis Chauvet wrote:
> 
> 
> Le 04/03/2025 à 15:54, José Expósito a écrit :
> > Hi Louis,
> > 
> > On Mon, Mar 03, 2025 at 11:34:50AM +0100, Louis Chauvet wrote:
> > > 
> > > 
> > > Le 03/03/2025 à 09:50, José Expósito a écrit :
> > > > Hi Louis,
> > > > 
> > > > On Fri, Feb 28, 2025 at 03:43:25PM +0100, Louis Chauvet wrote:
> > > > > 
> > > > > 
> > > > > Le 25/02/2025 à 18:59, José Expósito a écrit :
> > > > > > Create a default subgroup at /config/vkms/planes to allow to create as
> > > > > > many planes as required.
> > > > > > 
> > > > > > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > > > > > [...]
> > > > > > diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> > > > > > index 92512d52ddae..4f9d3341e6c0 100644
> > > > > > --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> > > > > > +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> > > > > > [...]
> > > > > > +static void plane_release(struct config_item *item)
> > > > > > +{
> > > > > > +	struct vkms_configfs_plane *plane;
> > > > > > +	struct mutex *lock;
> > > > > > +
> > > > > > +	plane = plane_item_to_vkms_configfs_plane(item);
> > > > > > +	lock = &plane->dev->lock;
> > > > > > +
> > > > > > +	guard(mutex)(lock);
> > > > > > +	vkms_config_destroy_plane(plane->config);
> > > > > > +	kfree(plane);
> > > > > > +}
> > > > > 
> > > > > I just found a flaw in our work: there is currently no way to forbid the
> > > > > deletion of item/symlinks...
> > > > > 
> > > > > If you do:
> > > > > 
> > > > > modprobe vkms
> > > > > cd /sys/kernel/config/vkms/
> > > > > mkdir DEV
> > > > > mkdir DEV/connectors/CON
> > > > > mkdir DEV/planes/PLA
> > > > > mkdir DEV/crtcs/CRT
> > > > > mkdir DEV/encoders/ENC
> > > > > ln -s DEV/crtcs/CRT DEV/planes/PLA/possible_crtcs/
> > > > > ln -s DEV/crtcs/CRT DEV/encoders/ENC/possible_crtcs
> > > > > ln -s DEV/encoders/ENC DEV/connectors/CON/possible_encoders
> > > > > echo 1 > DEV/planes/PLA/type
> > > > > tree
> > > > > echo 1 > DEV/enabled
> > > > > modetest -M vkms
> > > > > => everything fine
> > > > > 
> > > > > rm DEV/connectors/CON/possible_encoders/ENC
> > > > > rmdir DEV/connectors/CON
> > > > > modetest -M vkms
> > > > > => BUG: KASAN: slab-use-after-free
> > 
> > I'm trying to reproduce this issue, but those commands don't show any BUG
> > in dmesg. This is my Kasan .config:
> > 
> >      CONFIG_HAVE_ARCH_KASAN=y
> >      CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> >      CONFIG_CC_HAS_KASAN_GENERIC=y
> >      CONFIG_CC_HAS_KASAN_SW_TAGS=y
> >      CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> >      CONFIG_KASAN=y
> >      CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> >      CONFIG_KASAN_GENERIC=y
> >      # CONFIG_KASAN_OUTLINE is not set
> >      CONFIG_KASAN_INLINE=y
> >      CONFIG_KASAN_STACK=y
> >      CONFIG_KASAN_VMALLOC=y
> >      # CONFIG_KASAN_KUNIT_TEST is not set
> >      CONFIG_KASAN_EXTRA_INFO=y
> > 
> > I tryed to delete even more items:
> > 
> >      root@kernel-dev:/sys/kernel/config/vkms# tree
> >      .
> >      └── DEV
> >          ├── connectors
> >          ├── crtcs
> >          ├── enabled
> >          ├── encoders
> >          └── planes
> > 
> >      root@kernel-dev:/sys/kernel/config/vkms# cat DEV/enabled
> >      1
> > 
> > And I still don't see any errors. Is it possible that we are running different
> > branches? Asking because of the failing IGT tests you reported. There seems to
> > be a difference in our code or setup that is creating these differences.
> 
> I just re-applied your last vkms-config version and this series on top of
> drm-misc-next. See [1] for the exact commits.
> 
> Argg sorry, I just noticed something: you need to disable the default vkms
> device (I had this option in my kernel command line...), otherwise modetest
> only use the first vkms gpu...
> 
> I will check again the igt tests, but I don't think this is the same issue
> (it should not use the default device to test)
> 
> So, with [1] and the defconfig below, I have this:
> 
> 
>     1  modprobe vkms create_default_dev=0
>     2  cd /sys/kernel/config/vkms/
>     3  mkdir DEV
>     4  mkdir DEV/connectors/CON
>     5  mkdir DEV/planes/PLA
>     6  mkdir DEV/crtcs/CRT
>     7  mkdir DEV/encoders/ENC
>     8  ln -s DEV/crtcs/CRT DEV/planes/PLA/possible_crtcs/
>     9  ln -s DEV/crtcs/CRT DEV/encoders/ENC/possible_crtcs
>    10  ln -s DEV/encoders/ENC DEV/connectors/CON/possible_encoders
>    11  echo 1 > DEV/planes/PLA/type
>    12  tree
>    13  echo 1 > DEV/enabled
>    14  modetest -M vkms
>    15  rm DEV/connectors/CON/possible_encoders/ENC
>    16  rmdir DEV/connectors/CON
>    17  modetest -M vkms
> KASAN: slab-use-after-free
> 
> 
> [1]:https://github.com/Fomys/linux/tree/20250225175936.7223-1-jose.exposito89%40gmail.com

Aha! Are you testing without a desktop environment running?

    $ sudo systemctl isolate multi-user.target

Running that (^) command before yours gives me this use after free:

    BUG: KASAN: slab-use-after-free in vkms_connector_detect+0x61/0x70 [vkms]

Is the same one you are seeing? 

Looking at the connector_release() function in vkms_configfs.c, I see
that I'm freeing the configuration:

    vkms_config_destroy_connector(connector->config);

And I don't think there is a reason to do it. vkms_config_destroy() in
device_release() will free everything once we are done.

I need to do more testing, but the solution might be that simple.

Good catch, I didn't test like that and I overlooked this issue :D

Jose

> 
> 
> ===== defconfig =====
> 
> CONFIG_SYSVIPC=y
> CONFIG_CGROUPS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_SMP=y
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_VIRTUALIZATION is not set
> CONFIG_JUMP_LABEL=y
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_NET=y
> CONFIG_PACKET=y
> # CONFIG_WIRELESS is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=y
> CONFIG_PCI=y
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_VIRTIO_BLK=y
> # CONFIG_INTEL_MEI is not set
> CONFIG_NETDEVICES=y
> CONFIG_VIRTIO_NET=y
> # CONFIG_ETHERNET is not set
> # CONFIG_WLAN is not set
> CONFIG_INPUT_EVDEV=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_HW_RANDOM_VIRTIO=m
> CONFIG_PTP_1588_CLOCK=y
> # CONFIG_HWMON is not set
> CONFIG_THERMAL_GOV_USER_SPACE=y
> CONFIG_DRM=y
> CONFIG_DRM_KUNIT_TEST=m
> CONFIG_DRM_VKMS=m
> CONFIG_DRM_VKMS_KUNIT_TEST=m
> # CONFIG_USB_SUPPORT is not set
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_INPUT=y
> CONFIG_VIRTIO_MMIO=y
> CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
> # CONFIG_SURFACE_PLATFORMS is not set
> CONFIG_EXT4_FS=y
> CONFIG_FUSE_FS=y
> CONFIG_VIRTIO_FS=y
> CONFIG_OVERLAY_FS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_9P_FS=y
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_DYNAMIC_DEBUG=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_INFO_DWARF5=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_PAGEALLOC=y
> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
> CONFIG_PAGE_POISONING=y
> CONFIG_DEBUG_OBJECTS=y
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> CONFIG_SCHED_STACK_END_CHECK=y
> CONFIG_KASAN=y
> CONFIG_KASAN_VMALLOC=y
> CONFIG_KASAN_EXTRA_INFO=y
> CONFIG_KFENCE=y
> # CONFIG_FTRACE is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> CONFIG_KUNIT=y
> CONFIG_TEST_DYNAMIC_DEBUG=m
> 

