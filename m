Return-Path: <linux-kernel+bounces-559672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF4A5F7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14AD91776E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EE6267F48;
	Thu, 13 Mar 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NvnPuq0m"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55BA145A11
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875747; cv=none; b=O0LtQ1rNoDLpHM8Oosfvx1TQFaq0XA/2AvBWwqSzCl+rUQDWvxJNGkdW0nGjQgb0zkEX+QSHKQUQFsIa+am1kBglSKpst9OnJhGwfAyrInhVfiu8peEOLGqZPINDv1JRPug3UFJ9Ua+/5v+i4zttRwJJxATYya54TQhoz6FozeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875747; c=relaxed/simple;
	bh=mx+ztSbmRgAFulMzSRVIlYBkkBsbHQC4KCocxQlBjlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBr7jFbqgGO8u7Vh6BCC/Nh5uqrqw3oGwoleCBi4qiOkfHqgd+R5276tCqJ8WUsm5Hsh/Qww24xoxm0VPv9M2pZiMt/4JS0pLSK3smKyfMPRkGYd6CVt6Yb8iMyK/MjPK8PdWmbZAB7AZl04yOd3maVe5Xzdrtc47KjjHdvHaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=NvnPuq0m; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394a823036so9546855e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741875744; x=1742480544; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pM9ItXxbsRlMEhlDKad/ZxzQCO48bgp8mPNSaz0V580=;
        b=NvnPuq0mS6RtKpucmuYXFjgVQUuKh5qb8t5GKowhi5pKt71O8F/2KZAUt/2ihoyvSm
         lg0ML1xP6fE/9v8/B83wSIAveZBslN3fcfo6xtru365/k0iSifAfC2Xt8dNx03Cm4r5K
         l3wb4gIYhMjScaDtPzAGeYoAv8HtWARolOUbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741875744; x=1742480544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pM9ItXxbsRlMEhlDKad/ZxzQCO48bgp8mPNSaz0V580=;
        b=g7ObJYyqVaViSChZn7QHbZGDDGWNsDn+dJz/RJVPNeJMvw3M/om4isOOQioZbhl4WP
         rMUpYWQQ8xTl0gZTJEt1wOKQg2JsYAxKZ4HIjyn0JqOu1FrEHN3p+J4JTlU0FTj7YKQy
         U0r8b3SvWPs7SvowtEtqyuN4i5fVJgNhT8bws5kBwufxZ3W1sPxevAk7EzdY1YW4cUPz
         9Y7LGwDxhJ6ePd+jXlQE0/Ufi+28dLLXQDz1nz6XmCLx9Uo4ybCjRQi84kedsGZ4FHDQ
         a4VwUTKBIQs4UIv2cda3DGLPpIWRMGSGbztqlZ5TP2A8wu93JNQIYI5/pmvW+5cmaiFE
         0/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGSNhcfF4pQW2zbLyNvGliHvryq1Ot6M7xwxlqLOQj0TKw6WQYV953yF1V9z5VuCnVu9VNO/S9ubaOFJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBvJkHJ1bnOWKDS0MGCKdFUl4h9DpdMj0jbH0Ke97e4BWrepY
	DyAMHherIWqRnLU8Rbfpzu7rq62Bwizu0wH582Hx5sCP0/zuShbxkELB1u0Pq3s=
X-Gm-Gg: ASbGncsswiBd1vWreu0ObFxo+LcEt3TSwzh1ehC1ECF5uzjTXGbKYbkev6IfPh8x4iF
	h4mOvFYjThXzb+aarZSaPSI82w2UJ9MAzK2cYgU+xPiQLgwy/9gH6ExJSAckxc6VcZRGNZB5zEP
	6onT0ZovyJVKmwbZpzrGvNrguK7SWFI7eVFwh9PGNw9iKE40ybCuKSP6mJDa8i7tWpo4T+R9nvh
	YAqrzyd6EWkDp9LEQ/62f56kGqWZZoibVHMAA1/lUn78EZhHqPlVLrXc31nhF0ytuuVvRlZhyZQ
	COia/2KTAqPn75I9skKPrrFuLjejg5KNshCk24AnPqGYi1i2yZ/PlAGa
X-Google-Smtp-Source: AGHT+IGjO4FsKbB+Ux6992aYb86YlYMAwm8+sVMZZjUkcAqImTiqnQPTNezrkwgHZ00JdE+45W8X8Q==
X-Received: by 2002:a05:600c:4f14:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43d01be7e4bmr125481115e9.18.1741875743785;
        Thu, 13 Mar 2025 07:22:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df385bsm2245584f8f.4.2025.03.13.07.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:22:23 -0700 (PDT)
Date: Thu, 13 Mar 2025 15:22:21 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Jonathan.Cameron@huawei.com, airlied@gmail.com,
	aleksander.lobakin@intel.com, andriy.shevchenko@linux.intel.com,
	bhelgaas@google.com, broonie@kernel.org, dakr@kernel.org,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, louis.chauvet@bootlin.com,
	lukas@wunner.de, lyude@redhat.com,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, mripard@kernel.org, quic_zijuhu@quicinc.com,
	rafael@kernel.org, robin.murphy@arm.com,
	rust-for-linux@vger.kernel.org, simona.vetter@ffwll.ch,
	simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v4 9/9] drm/vkms: convert to use faux_device
Message-ID: <Z9LqHcj4n7Dd8A-H@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Jonathan.Cameron@huawei.com, airlied@gmail.com,
	aleksander.lobakin@intel.com, andriy.shevchenko@linux.intel.com,
	bhelgaas@google.com, broonie@kernel.org, dakr@kernel.org,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, louis.chauvet@bootlin.com,
	lukas@wunner.de, lyude@redhat.com,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, mripard@kernel.org, quic_zijuhu@quicinc.com,
	rafael@kernel.org, robin.murphy@arm.com,
	rust-for-linux@vger.kernel.org, simona@ffwll.ch,
	tzimmermann@suse.de
References: <2025022643-scouting-petticoat-492b@gregkh>
 <20250311172054.2903-1-jose.exposito89@gmail.com>
 <2025031218-oxidize-backing-e278@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025031218-oxidize-backing-e278@gregkh>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Wed, Mar 12, 2025 at 07:22:07AM +0100, Greg KH wrote:
> On Tue, Mar 11, 2025 at 06:20:53PM +0100, José Expósito wrote:
> > Hi everyone,
> > 
> > > On Tue, Feb 25, 2025 at 02:51:40PM +0100, Louis Chauvet wrote:
> > > > 
> > > > 
> > > > Le 25/02/2025 à 12:41, Thomas Zimmermann a écrit :
> > > > > Hi
> > > > > 
> > > > > Am 10.02.25 um 15:37 schrieb Louis Chauvet:
> > > > > > On 10/02/25 - 13:30, Greg Kroah-Hartman wrote:
> > > > > > > The vkms driver does not need to create a platform device, as there is
> > > > > > > no real platform resources associated it,  it only did so because it was
> > > > > > > simple to do that in order to get a device to use for resource
> > > > > > > management of drm resources.  Change the driver to use the faux device
> > > > > > > instead as this is NOT a real platform device.
> > > > > > > 
> > > > > > > Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > > > > Cc: Melissa Wen <melissa.srw@gmail.com>
> > > > > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > > > Cc: David Airlie <airlied@gmail.com>
> > > > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > 
> > > > > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > 
> > > > > > Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > 
> > > > > > Thanks for the modification, it seems to work.
> > > > > 
> > > > > Should this patch be merged through DRM trees? drm-misc-next is at
> > > > > v6.14-rc4 and has struct faux_device.
> > > > 
> > > > Hi,
> > > > 
> > > > I was not aware the faux-device was merged, as it is a new feature, I
> > > > expected it to reach drm-misc-next on 6.15-rc1.
> > > 
> > > I added it to Linus's tree just so that DRM could get these changes into
> > > their tree now :)
> > > 
> > > > I plan to merge [1] today/tomorrow (well tested with platform_device), and
> > > > then I will submit an updated version of this patch (only trivial conflicts,
> > > > but never tested with multiple VKMS devices).
> > > > 
> > > > [1]:https://lore.kernel.org/all/20250218101214.5790-1-jose.exposito89@gmail.com/
> > > 
> > > Great, thanks!
> > > 
> > > greg k-h
> > 
> > Testing this patch again as part of some IGT tests I'm working on,
> > I noticed that, applying this patch on top of the latest drm-misc-next
> > triggers a warning at drivers/gpu/drm/drm_gem.c:571, in
> > drm_gem_get_pages():
> > 
> >     if (WARN_ON(!obj->filp))
> >             return ERR_PTR(-EINVAL);
> 
> I don't see how the faux bus change would have anything to do with a
> filp as that's not related as far as I can tell.  But I don't know the
> drm layer at all, where does that filp come from?

Yeah that filp is the shmem file that backs gem bo. That's very far away
from anything device/driver related datastrctures. If this is a new
failure due to the aux bux conversion then it would be really surprising.
-Sima

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

