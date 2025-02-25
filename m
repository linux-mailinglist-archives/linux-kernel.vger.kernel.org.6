Return-Path: <linux-kernel+bounces-532136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB2A4491E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CED166ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D6B19C554;
	Tue, 25 Feb 2025 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNcKaNbH"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219119ABC3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506212; cv=none; b=pKu3eqFGdJrgOYsuczTdLN+LLb7vFIQkaPMDkbxhbAuiHY/PuQbqyAXCezL4J9i9kP+LVKSAUBLLD1bmZsqWo8uXZRye30NR0z2fHgAFXotMa/mSRIA7nJ8R1CnjDvIUfug6bxJRCQ/Z5iYtnDvpf9TQz9qNaSlu10pTVuByXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506212; c=relaxed/simple;
	bh=voYBb2r//dRBt6lfBvNnss+/7ly2F5ArI4Tjl5Zq5NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afxnKN/iFQENnnKNPPaqHXUj6dXj+LU5PJ4AoNJz+dxM49z8iBcyo6EkTDcbJMEkd5IY3ehgraQJO/XMLcnc6gEvykm6fUe9ibq7ojyZTq6fmcE3lbNmEo8uWivV8i9IEkDazQOnOD3NuRjaJxBAj9+ifnR809wwjSX2ET7yddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNcKaNbH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so40813995e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506209; x=1741111009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gOCUaU/7gnEaJ3IHdehXrJI4tg+whLlR3VL26FFaPrM=;
        b=VNcKaNbH6G9IyZbF67VjWRQg365aaW0kSo3eUBEDQxMSgvZpNCz0jFyZM2Aey8A3uo
         Cf8xTvrHGjNxkQVFviUPYut7aN5XtipWY5W27HWDnMSsgYk9V+AiKb+cvVF/ecHC1sT6
         mfYITVQQDXRd5hdrbasLUaTG0NCGRE4QTkMh910MCCcR5yHWaUvnoZJlU6KmCcY5ZKte
         zxqKV4Xif/R9tU5RICi1yTiL9bOSiGzA+NTWv14AZnJnAtmWoDhRQG5Lyf1pjvDymaXT
         4EuMfrnIY40iJlSI2+N35sbP0XJsnXGx0mxPFkH6FpKKVTO/R3rbGoCp76djEie7OGyS
         GXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506209; x=1741111009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOCUaU/7gnEaJ3IHdehXrJI4tg+whLlR3VL26FFaPrM=;
        b=LxmvSgm7To7+a/+SuSlggOczmNP4w9l86cda0XLukMYFs83vSdDnxsdoGoOovkcpQG
         9AzhJdzHX/E12wO6beDjlrT1/08LDJMkj6NOuIzNFsnOXsZX0lTzZv6aG0Lwrwq9TGlK
         wA+8dTZHTli89KQ0XrWbaAEMEyZUMocwnqfWS3grGXz6lF7s8EHFgbvPVKEBoHPMY357
         FEGTi5IIIdSzjysCtdDJuAMANVuZuQXjidiE3pNUkl6bffQTWZVRIwPuhidPmyUGKARS
         lDntQLMkNdnSfQqS8MsOlunHLSM59wRoMisJNDUqSPUamxnFgmOc/eQZjVbqFjqV2GZN
         UYAA==
X-Forwarded-Encrypted: i=1; AJvYcCWO8KhWvE8PIH7qC+G9RbgrPwaGSu55Nq1SiAcvH4thT1ax7XznqkO3sgQvPvUk31EgnQDz+ZIBQHgySWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1kEol5bZlBFMgGdSyyVRmkjuhzQ0m4ONfBfwsNKv6q+Sb6JT
	n4OpvRJOp1uEQglDrzNOfQ9H8WFE2fsEZjkdJcxS/k8GTimpwX7m
X-Gm-Gg: ASbGncumxbeH7rJHKo1ALYLxQfUmRsTRe3biJ5nORAJiQjiHBoAkrcnhFnGluOskS3S
	7nHXmUPRw5SYqhPw2oOtClaUQslqzPohzh0BCwzGZdmGMNQt/FOwi4THMXDqYz/2nwGsj7R0re8
	HTLL8XVrDAwXDGNdEBQ87JoyNhHoGh7LCIfFzAcn+T5JmUa0B90PoA4TYphYvsG3MQalnkmTB9I
	wkoGmwx6ANBzBopWsph4vL2Xk4SV3MSYOOuGtyKy6MQnnPRIGuPGh7MbGKizuSTD2ftwwQ+SKbz
	iRDm962LzM733JcF6sGcwDjTXQ==
X-Google-Smtp-Source: AGHT+IExSFlTbctQ0zHvNEtFI4zl9JtgMobqQSi8OH4T7IPG24I3S3Zyhi0/pqqwm+YXvOwqJapctw==
X-Received: by 2002:a05:600c:3c86:b0:439:9d75:9e7d with SMTP id 5b1f17b1804b1-439ae21d1d0mr136975665e9.22.1740506208497;
        Tue, 25 Feb 2025 09:56:48 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b036756csm148728425e9.31.2025.02.25.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:56:47 -0800 (PST)
Date: Tue, 25 Feb 2025 18:56:46 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] drm/vkms: Add configfs support
Message-ID: <Z74EXo_qL1bZ2uNo@fedora>
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
 <Z72jJtFCMypHpW_K@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z72jJtFCMypHpW_K@louis-chauvet-laptop>

Hi Louis,

Thanks a lot for the super fast review, you are the best!

On Tue, Feb 25, 2025 at 12:01:58PM +0100, Louis Chauvet wrote:
> On 18/02/25 - 18:07, José Expósito wrote:
> > Hi everyone,
> > 
> > This series, to be applied on top of [1], allow to configure one or more VKMS
> > instances without having to reload the driver using configfs.
> > 
> > The series is structured in 3 blocks:
> > 
> >   - Patches 1..11: Basic device configuration. For simplicity, I kept the
> >     available options as minimal as possible.
> 
> Thanks for this series, it is really nice!
> 
> I did some review, that can be sumarized in two point:
> - Do we want to use scoped_guard?

Since all mutex locks were unlock at the end of the file, I replaced
mutex_lock/unlock with guard(mutex)(...). The resulting code is now
much cleaner.

Thanks for pointing me to cleanup.h, my Linux kernel books are too
old to include these helpers and I wasn't aware of them.

> - -EPERM, -EINVAL or -EBUSY when attempting to do something while the
>   device is enabled

I replaced all the cases with EBUSY, thanks!

> >   - Patches 12, 13 and 14: Allow to hot-plug and unplug connectors. This is not
> >     part of the minimal set of options, but I included in this series so it can
> >     be used as a template/example of how new configurations can be added.
> > 
> >   - Patches 15 and 16: New option to skip the default device creation and to-do
> >     cleanup.
> 
> For the next iteration, can you move those patch before 12, 13, 14, so
> 1..11 could be merged before 12..14 (I need to think about the connector 
> API to check if it will works with dynamic connector)?

Sure, I moved them to the end in v2.

I experimented with dynamic connectors a little bit and I think that it is
possible to make it backwards compatible:

 - We could add a "enabled" file for connectors
 - At the moment, connectors can only be created while the device is disabled.
   To keep compatibility, if the device is disabled, we need to set
   connector->enabled to 1 by default.
 - If the device is enabled, we'd need to set connector->enabled to 0. This
   would allow the user to configure the connector before it is hot-added.
 - We'd need to store if the connector is static or dynamic to allow hot-remove
   only dynamic connectors.

I believe that, if we implemented it like this, we'd be able to keep compatibility.

> > The process of configuring a VKMS device is documented in "vkms.rst".
> 
> This is a really good documentation!
> 
> > Finally, the code is thoroughly tested by a collection of IGT tests [2].
> 
> I quickly looked on them, it seems nice! Thank you for this huge
> improvment!

If you could comment on that mailing list, I'm sure that a LGTM from the
maintainer will help :)

Thanks a lot for your work Louis.

Sending v2,
Jose

> Louis Chauvet
> 
> > Best wishes,
> > José Expósito
> > 
> > [1] https://lore.kernel.org/all/20250218101214.5790-1-jose.exposito89@gmail.com/
> > [2] It is not in patchwork yet, but it'll appear here eventually:
> >     https://patchwork.freedesktop.org/project/igt/patches/?submitter=19782&state=*&q=&archive=both&delegate=
> > 
> > José Expósito (16):
> >   drm/vkms: Expose device creation and destruction
> >   drm/vkms: Add and remove VKMS instances via configfs
> >   drm/vkms: Allow to configure multiple planes via configfs
> >   drm/vkms: Allow to configure the plane type via configfs
> >   drm/vkms: Allow to configure multiple CRTCs via configfs
> >   drm/vkms: Allow to configure CRTC writeback support via configfs
> >   drm/vkms: Allow to attach planes and CRTCs via configfs
> >   drm/vkms: Allow to configure multiple encoders via configfs
> >   drm/vkms: Allow to attach encoders and CRTCs via configfs
> >   drm/vkms: Allow to configure multiple connectors via configfs
> >   drm/vkms: Allow to attach connectors and encoders via configfs
> >   drm/vkms: Allow to configure connector status
> >   drm/vkms: Allow to update the connector status
> >   drm/vkms: Allow to configure connector status via configfs
> >   drm/vkms: Allow to configure the default device creation
> >   drm/vkms: Remove completed task from the TODO list
> > 
> >  Documentation/gpu/vkms.rst                    |  98 +-
> >  drivers/gpu/drm/vkms/Kconfig                  |   1 +
> >  drivers/gpu/drm/vkms/Makefile                 |   3 +-
> >  drivers/gpu/drm/vkms/tests/vkms_config_test.c |  24 +
> >  drivers/gpu/drm/vkms/vkms_config.c            |   8 +-
> >  drivers/gpu/drm/vkms/vkms_config.h            |  26 +
> >  drivers/gpu/drm/vkms/vkms_configfs.c          | 918 ++++++++++++++++++
> >  drivers/gpu/drm/vkms/vkms_configfs.h          |   8 +
> >  drivers/gpu/drm/vkms/vkms_connector.c         |  26 +-
> >  drivers/gpu/drm/vkms/vkms_connector.h         |  18 +-
> >  drivers/gpu/drm/vkms/vkms_drv.c               |  18 +-
> >  drivers/gpu/drm/vkms/vkms_drv.h               |   4 +
> >  drivers/gpu/drm/vkms/vkms_output.c            |   2 +-
> >  13 files changed, 1138 insertions(+), 16 deletions(-)
> >  create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
> >  create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.h
> > 
> > 
> > base-commit: 9b6c03cb96b9e19bce2c2764d2c6dd4ccbd06c5d
> > prerequisite-patch-id: 1bff7bbc4ef0e29266265ac3dc009011c046f745
> > prerequisite-patch-id: 74a284d40a426a0038a7054068192238f7658187
> > prerequisite-patch-id: c3e34e88ad6a0acf7d9ded0cdb4745a87cf6fd82
> > prerequisite-patch-id: 9cd0dfaf8e21a811edbe5a2da7185b6f9055d42d
> > prerequisite-patch-id: f50c41578b639370a5d610af6f25c2077321a886
> > prerequisite-patch-id: 5a7219a51e42de002b8dbf94ec8af96320043489
> > prerequisite-patch-id: 67ea5d4e21b4ce4acbd6fc3ce83017f55811c49b
> > prerequisite-patch-id: 37a7fab113a32581f053c09f45efb137afd75a1b
> > prerequisite-patch-id: 475bcdc6267f4b02fb1bb2379145529c33684e4f
> > prerequisite-patch-id: d3114f0b3da3d8b5ad64692df761f1cf42fbdf12
> > prerequisite-patch-id: d1d9280fb056130df2050a09b7ea7e7ddde007c5
> > prerequisite-patch-id: 2c370f3de6d227fa8881212207978cce7bbb18ba
> > prerequisite-patch-id: 938b8fe5437e5f7bc22bffc55ae249a27d399d66
> > prerequisite-patch-id: ab0a510994fbe9985dc46a3d35e6d0574ddbb633
> > -- 
> > 2.48.1
> > 

