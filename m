Return-Path: <linux-kernel+bounces-560091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD97A5FD97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6629A3A4E91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B883189F56;
	Thu, 13 Mar 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brL/9/F+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6B136347;
	Thu, 13 Mar 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886434; cv=none; b=bdgUqCoVoy5SIaGmDV7a6kABfNRC+tfr8ScoiMkEfEgxCtk7TEBGVShLn/XVcfvzSLVxp2+A3h+upQIiYKAoSmHaKk4ZgbIlD/vRaJ0TUQcI+GqgC433UI4xRFKL4RRGvejtkJIYMuoW4p94gHn0E/0qTHyFHvPQK/MRyMtEzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886434; c=relaxed/simple;
	bh=/7BK6Z1rcheCGf59Fx2YSAGnN8TkcYgAYRtEEbdVd3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCdWo4WaNIro0HzEqdUDlnrDg8AwPJGv59CioKj0C05QI5COf6EeeBI6+Hd1ZGEECLFfsFtK2umK+XjY+ARYRas97CxP4I8zwTjJl1MG4E9P1v8Rep739SzPywcOgmgsYB48fc+l88udVfCuhlfhAum5LKT5NYaFj0yOWAeW9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brL/9/F+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso11690675e9.2;
        Thu, 13 Mar 2025 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741886431; x=1742491231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5n5FOrDMxIl7+CKikAilniGBcZDmRdoDO+HttS3RzGI=;
        b=brL/9/F+x55YZjvB4Z4pAUcmF66oN4G1sSeTEYU/Xvt+CWf+Ldmlq0ZdmSB0QxWKze
         7zUfzsTcb5VMf8lhi5RNqdp+cBLZdi4S2BgQuvzOXp/6gY2wl9kNgg54IFcCIb37xbVd
         JGJw3XQpibe/gNHm47jBfDguya5sqZmD1A+DM2bp5WkvBt1ndfx9hQOvVcvSAgF8z/Su
         +3JAqRChpb2bie47zFixWHUB3C1MEPhvL9+SGGAOpK0FXoOqEkPFdeOZgZidBliXrudG
         0tu/NMDS1yhLz12mW19l0Jrh5Uy9ck8XlhHAB76rriMfJ1tPJFwTtqc7qErzaebBrnmm
         7RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886431; x=1742491231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5n5FOrDMxIl7+CKikAilniGBcZDmRdoDO+HttS3RzGI=;
        b=N1LcTRIwFHRnZ5GgODj/fS+8poY8Id7je0ZaO3GSPOaQBdsshSYoXlDaAAKbBV9nRo
         VnhgmoyLtBeVrtZG1l3jlXSUeIzQ2TM8OOtpfzDa17h9YyamL0TuVHX9BIV45QL43a0v
         7xTNS/ZzthmRQgvo9eFttRhMWNIWJz7twO1fhLCgkzra5Oe3o4+QffNEH5RSxLBZl6Pv
         nLh9Bijp4DihDRtFD7u9s73K09b5TSC1UT5chBiSzIlIlbqAJMpsc/8/krSNn2rjfW2O
         nSn3hfR8CCSBEXgzJP3jXq8Hpk9WQZYoZeqVNhoh5GJuYLLSaCAL3sxo0jKkvLL/1OhS
         JjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMeNG4SrRizsdXgIh+ovuDMS7UYBfwbQF8PIEUpQlLDdnrS9TrdhDZ9EsE7ou7NmYorXsWov4xzL0YvPvQjvw=@vger.kernel.org, AJvYcCWINcO96xhSUN35PTSlgsr0d2Rxjlzwp3/44Ax+AcYcyc70f7ICt7KpmNqtuehiqByiN9Sj8DnR9/c7gTI=@vger.kernel.org, AJvYcCX4rJ3V93btRPZMMeZbXzHShjeKWXf2zSCJPacJ88Vo1TUbtMiWu1M0tKn0i2S0BzlMTJPR/MRDxvMF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ICkXeqkie2LUzBr24xzrl0KKAkNV+Twg1R9jDrGR/XpKDjm5
	7/MT9nC0veADhfdZGPzPfejQm2hDrdP0FYbUuj73nc+pB4KYyKfK
X-Gm-Gg: ASbGncts4XbyzJKOgHPOzVs8lHLAjvfPrwVSlY9x8J781UuxSVKGiqSBDFIpm+ijiox
	8nap07pbWuTZP7mKsKywzYqzDKvgehlb4qr7TCxfuuGwDcQ8/1ftMcDDcrm1gAJVtQXb2RCtFKC
	0DOwmHTCwY8BXwoU8SdB4r7ik+3ezNvsMiPHZd7K9D4y23iSBlXZbSg3fkzVafW7TAoDvq3Wftr
	xGXpqSDcpzlmBjEKiFeAwl2rp6g35CXspEbnYFsKDFuUxe2CHqeaCYAv7DB72Qh/gUBC/uZVODS
	h20nRDhCXG0CQzky0T4XRJUFWKNc1oXQTIyrqmQHaQ==
X-Google-Smtp-Source: AGHT+IGY1dnvqu4GFNk7LQUmWmVG9IqWcp0nb9/axOK/G/ANmQOX6qhs7T+74c8yk2G/jRPLATat1g==
X-Received: by 2002:a05:600c:4f01:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-43d1d8b1477mr5823695e9.14.1741886430553;
        Thu, 13 Mar 2025 10:20:30 -0700 (PDT)
Received: from fedora ([94.73.34.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a73127esm61367695e9.8.2025.03.13.10.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:20:30 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:20:27 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jonathan.Cameron@huawei.com,
	airlied@gmail.com, aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com, bhelgaas@google.com,
	broonie@kernel.org, dakr@kernel.org,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, louis.chauvet@bootlin.com,
	lukas@wunner.de, lyude@redhat.com,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, mripard@kernel.org, quic_zijuhu@quicinc.com,
	rafael@kernel.org, robin.murphy@arm.com,
	rust-for-linux@vger.kernel.org, simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re: [PATCH v4 9/9] drm/vkms: convert to use faux_device
Message-ID: <Z9MT23hgX2c21xNA@fedora>
References: <2025022643-scouting-petticoat-492b@gregkh>
 <20250311172054.2903-1-jose.exposito89@gmail.com>
 <2025031218-oxidize-backing-e278@gregkh>
 <Z9LqHcj4n7Dd8A-H@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9LqHcj4n7Dd8A-H@phenom.ffwll.local>

On Thu, Mar 13, 2025 at 03:22:21PM +0100, Simona Vetter wrote:
> On Wed, Mar 12, 2025 at 07:22:07AM +0100, Greg KH wrote:
> > On Tue, Mar 11, 2025 at 06:20:53PM +0100, José Expósito wrote:
> > > Hi everyone,
> > > 
> > > > On Tue, Feb 25, 2025 at 02:51:40PM +0100, Louis Chauvet wrote:
> > > > > 
> > > > > 
> > > > > Le 25/02/2025 à 12:41, Thomas Zimmermann a écrit :
> > > > > > Hi
> > > > > > 
> > > > > > Am 10.02.25 um 15:37 schrieb Louis Chauvet:
> > > > > > > On 10/02/25 - 13:30, Greg Kroah-Hartman wrote:
> > > > > > > > The vkms driver does not need to create a platform device, as there is
> > > > > > > > no real platform resources associated it,  it only did so because it was
> > > > > > > > simple to do that in order to get a device to use for resource
> > > > > > > > management of drm resources.  Change the driver to use the faux device
> > > > > > > > instead as this is NOT a real platform device.
> > > > > > > > 
> > > > > > > > Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > > > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > > > > > Cc: Melissa Wen <melissa.srw@gmail.com>
> > > > > > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > > > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > > > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > > > > Cc: David Airlie <airlied@gmail.com>
> > > > > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > 
> > > > > > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > > 
> > > > > > > Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > > 
> > > > > > > Thanks for the modification, it seems to work.
> > > > > > 
> > > > > > Should this patch be merged through DRM trees? drm-misc-next is at
> > > > > > v6.14-rc4 and has struct faux_device.
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > I was not aware the faux-device was merged, as it is a new feature, I
> > > > > expected it to reach drm-misc-next on 6.15-rc1.
> > > > 
> > > > I added it to Linus's tree just so that DRM could get these changes into
> > > > their tree now :)
> > > > 
> > > > > I plan to merge [1] today/tomorrow (well tested with platform_device), and
> > > > > then I will submit an updated version of this patch (only trivial conflicts,
> > > > > but never tested with multiple VKMS devices).
> > > > > 
> > > > > [1]:https://lore.kernel.org/all/20250218101214.5790-1-jose.exposito89@gmail.com/
> > > > 
> > > > Great, thanks!
> > > > 
> > > > greg k-h
> > > 
> > > Testing this patch again as part of some IGT tests I'm working on,
> > > I noticed that, applying this patch on top of the latest drm-misc-next
> > > triggers a warning at drivers/gpu/drm/drm_gem.c:571, in
> > > drm_gem_get_pages():
> > > 
> > >     if (WARN_ON(!obj->filp))
> > >             return ERR_PTR(-EINVAL);
> > 
> > I don't see how the faux bus change would have anything to do with a
> > filp as that's not related as far as I can tell.  But I don't know the
> > drm layer at all, where does that filp come from?
> 
> Yeah that filp is the shmem file that backs gem bo. That's very far away
> from anything device/driver related datastrctures. If this is a new
> failure due to the aux bux conversion then it would be really surprising.

Agreed, I find it surprising, but reverting the patch removes the warning.

It's most likely an issue on my side, but I decided to double check just
in case someone else is also seeing this warning.

Jose

> -Sima
> 
> -- 
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

