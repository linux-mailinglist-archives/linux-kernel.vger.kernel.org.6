Return-Path: <linux-kernel+bounces-513266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C1A3473E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926F6163AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E015B0EF;
	Thu, 13 Feb 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRS9keBd"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D626B0B4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460421; cv=none; b=WBr9Qbdtq09hO3t3XwlxSccqFFdCHTfM46tKKBilmdKdJNVwPjVOB2h0gb+fzABfAWXjN8M9o2AWziHkEmg+EwnUS1CWXg+IRsrnp6WirllnVb6iwF5oJoOH/5umA0e8rPI9/GtrOZM9pGKSCvW97UFezdRb6KZjMotm7rHQ/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460421; c=relaxed/simple;
	bh=6s3HMVKobwg2gqP5NkxBRBqUWe4aZp/ZMyt7t/7QJyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8JV035shlx2L7GDBn2D+K/Ug5yMuv5a0JKs95S83Y7EowmTK7lTwikHZQo5GnXfJ8WGMWM9e8XlVVMe2PAxwqhMsAs5JEB8NUkTXkb7OI2o1YPrBsPbK6MlNDbNt3xJ6t9KKFQYadXqAYtjiF5fPUYt8an6awcWpiAXEZxi2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRS9keBd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4395561ab71so11736325e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739460418; x=1740065218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wZ8ZpchhsuyR5ZoxAfEGSuPJ2IZfU52CW6+CcKm/nhw=;
        b=WRS9keBdFk9l2/Ojl5Azj64TLM+RXlRQGrBy0/cTqQWxozCZ1Bc2fSgAjZkT+wwYKx
         pjgLbLdMxrH04h9AFZvR3FVrDCgyACCRWAhPLVsLcKpoSK8kPy/F5m1Rp6B5mo5bcnSA
         pqnZdRJ+Y0wvyp4qckyGFXXgMhl7MF2h0aAdb7PDWUobR4O+tKbPNzvaqC8j2+0uO2cX
         CiansP4gkFAYXzCdEKWfPpO6n8GqvZkgDFvi3QOFCIfp7IImH5ZoNaOkJVmsptud74e7
         rCUst4IgJ1rC0IGAkjSoubKbLcYg6DaOa8ep6vxTfIwMwJypAjX1hox6GCFSVoJ55RUa
         t/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460418; x=1740065218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ8ZpchhsuyR5ZoxAfEGSuPJ2IZfU52CW6+CcKm/nhw=;
        b=laNp0jg84mTKDclJLVwnif3e+3p9oYt5U8O5firt6EhtlNiYMOU3qjfPGslntuHMRs
         s9FdCuTjBgpRLWxfKftmeH6PwVOOLurWR49qqbs8ciZfdvF4csjzTTAFA47mPhFoBBTR
         vYhayRp+XJPaeM3ijE+VOX9h3obXqG0isgbroiYRehzLFULmNU2mddiauxN6BXXYtJBH
         T0gbO2zougrPFHYyUQZNm8PkshEXZVN9dcgCk/2xFGj/UdXgJ9O6UEZHFogbSgAqHbsA
         YfpS/+6WtiVifiyB/Oe03zgtJePLXgGjn9/TJQDJ+ehydRPIKuGuthzQEuBPIt9bojwr
         1TuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt1QFI+MFkRXMTf/Lw593w7ApcYVLooi9YKnzVNJLZHKyy2Z+MIaoyd0H1UwPwvJWrvjG5DqMS7PTUr64=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbq3Kh6mK9nSKV2QkTtCWbsGclJADsUNUDv4E81b3ktYbs/K5J
	gN2lPYHe2oZwBHMgmh8NVwNVrweKG9il0Zoo8tDUH0aVwvVOGyXKoxBhwxZn
X-Gm-Gg: ASbGncvZUZSx+sZADJ8f4BivwoiQhw+X2sauYTA0ppN8FnUyqatDfuh2bxmmYpj57t/
	BA1wogj1l5500sueIr6SFQhWLWcplURAfaYaGxdgUGWUvDPiGgP9FyW6KxSRqEpj8RrFESOk2+e
	uVLy3r3EBxcJCSs7GLMNCGGJm0lbIoDg+XgjWLuGeSCIOQrJUWObq9uR4dWyc3gSENfXehAaTlU
	Rrt7i5kDfhpcmAR8rGbDGWN9MO8dnmoEWG5SaBgCDZYystx5VRIbpTx7pqRnTyyuTuhdkagyyXn
	7FdTbLo/nL+j3e8=
X-Google-Smtp-Source: AGHT+IFJN2idfeKviFAXxT0FMTPm4iA4ABO72SDLoUa4IX8M3gdwMQpklCgVqavU1tPGVp+KVL34Dg==
X-Received: by 2002:a05:600c:1d1d:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-439601c5066mr46025755e9.28.1739460417641;
        Thu, 13 Feb 2025 07:26:57 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc48d9dsm44747855e9.0.2025.02.13.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:26:56 -0800 (PST)
Date: Thu, 13 Feb 2025 16:26:54 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] drm/vkms: Allow to configure multiple CRTCs
Message-ID: <Z64PPk5At0JGB4Xp@fedora>
References: <20250129110059.12199-1-jose.exposito89@gmail.com>
 <20250129110059.12199-9-jose.exposito89@gmail.com>
 <Z5uDJFHnn1HzWOz4@louis-chauvet-laptop>
 <Z6sqFdvtwSxHD-FO@fedora>
 <2466f201-2d2b-4626-a359-50f58c873c2c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2466f201-2d2b-4626-a359-50f58c873c2c@bootlin.com>

Hey Louis,

On Wed, Feb 12, 2025 at 03:12:13PM +0100, Louis Chauvet wrote:
> 
> 
> Le 11/02/2025 à 11:44, José Expósito a écrit :
> > On Thu, Jan 30, 2025 at 02:48:20PM +0100, Louis Chauvet wrote:
> > > On 29/01/25 - 12:00, José Expósito wrote:
> > > > Add a list of CRTCs to vkms_config and helper functions to add and
> > > > remove as many CRTCs as wanted.
> > > > 
> > > > For backwards compatibility, add one CRTC to the default configuration.
> > > > 
> > > > A future patch will allow to attach planes and CRTCs, but for the
> > > > moment there are no changes in the way the output is configured.
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
> > > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > > @@ -181,7 +181,8 @@ static int vkms_create(struct vkms_config *config)
> > > >   		goto out_devres;
> > > >   	}
> > > > -	ret = drm_vblank_init(&vkms_device->drm, 1);
> > > > +	ret = drm_vblank_init(&vkms_device->drm,
> > > > +			      vkms_config_get_num_crtcs(config));
> > > 
> > > At this point we only create one crtc, can you move this change in the
> > > commit where you create multiple crtc?
> > 
> > Since the code to add more than one CRTCs is unused but technically present, I
> > think that this is the right patch to use this function.
> 
> I don't totally agree: you can create multiple vkms_config_crtc, but the
> code only creates one drm_crtc.
> 
> For me it is more logical to keep 1 here, as the rest of the code only
> creates one CRTC. With the next patch, the code will create more than one
> CRTC, so it makes sense to use vkms_config_get_num_crtcs.
> 
> It is not a strong blocking point, but if a v3 is needed, could you change
> it?

Fair enough, moved to the next patch in my local branch.

I'll send it in v3.

Jose

> > Anyway, at the moment it'll always return 1, so it is a no-op.
> 
> The current user is only default_config, so yes I agree, it is always 1.
> 
> > I didn't change it in v2, let me know if it works for you.
> > 
> > Thanks,
> > Jose
> > 
> > > >   	if (ret) {
> > > >   		DRM_ERROR("Failed to vblank\n");
> > > >   		goto out_devres;
> > > > -- 
> > > > 2.48.1
> > > > 
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

