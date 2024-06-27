Return-Path: <linux-kernel+bounces-232794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DFA91AE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743F71C220F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528B19A28A;
	Thu, 27 Jun 2024 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0QkpHXe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A201C6A7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510154; cv=none; b=MclA3+QqHfpyZsfgFOq6LFF8xJku9ND7Bin3v1PCwoSRzHZ89cDBnJ2fDAYWkSxeHWjTEdZZBLxAMfzsMFvm6B2kRXzXxlhppSCBKzEpzpX4j9aGpvXJ1221fPQTlQiAW4fM6Cp7GAsUa+AyGhlTmN7/nQNFuQK9pqaKnQGs4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510154; c=relaxed/simple;
	bh=YbS9bTV7Wa7Sw8ojDZMeWifV6SyePAyx2+e4doczySo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QUdnmJ4BoHEPIGK2sLrssZTP3qTX16EdIK05ZyxsZ+xwb9BrRkXwB3LqkMUz5+y1YmAfW+dYRJCaaq8FbRw1cYhN9iMPRLMLx6tbyXfTegY3DnF98Md8EkXSeoaE7u5A/TUMAnYaz2QCRvHrV5Rw5v3Sz5A9QOgBbrSanfO/Pnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0QkpHXe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719510151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGSfXbPPJUEKh22ZKmG3sSq8FqJ5we+pYCxi+DTxmLA=;
	b=Z0QkpHXevrEy5lWxCVR388Z4d/UWcTtaqVI09duRdvYBdO34DSapET9IJuPoV09sBCDyAI
	oUWYaSqVj30UTlrCGKJMr9EQFw+X2Fq9YnDXQC55pvsWccn2Um51f8wc/ZOTD3nhEYaLNS
	oaqFx8+IPY1GlR3E3JUnQRQrY/TtKZw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-AwJKIBsBPtiwRsV4XLzTkA-1; Thu, 27 Jun 2024 13:42:30 -0400
X-MC-Unique: AwJKIBsBPtiwRsV4XLzTkA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3670c9e8b7eso1059938f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510149; x=1720114949;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGSfXbPPJUEKh22ZKmG3sSq8FqJ5we+pYCxi+DTxmLA=;
        b=DQGBCb9omYWomFgjXrduD1TaesmCWJRljOa/BGNcvvGtCenG35YhXWxG1xt5g4IBBa
         10n5VX1xSL//C/kQCw01RSZ9q0BlubUnWZX8OSTAe+RneW7QhnaObYYGByXlQgeqA9R6
         LqRvv/JLi9gJauMYlMqdszqrgK9DxmZd/YbUBiMTgcIlvhI8zpNNc/atfaIDuc4mgxyW
         13oyG/hqVzDhh1KdgH0F7HenrrjMCy6b1/8zNNMou8UftIVYDMf8CTtSI2Qr3qArGI2z
         Jp8xZSmrXzKYUu8cs5WiCX8OGzZyjK9huDrsqGzJIoKhchdKFH4qrjbqyBLkNOp6sxTj
         Kh+Q==
X-Gm-Message-State: AOJu0YzXzzVWerLNLVyBjfp38stS2KxX3DRo0EswH4mVFsylanzxhqk8
	R/E98Fh75Lg1fYEPfn7scQutXW6vcPbjkbI/0OKTZ+qdGcvJSMfoETGz4Uwh0u18CN6Vr14T3u9
	oRJQcS2I5Q3z+ng5TaZ1MUbBYrDo8g5gd+6Tno5LrvoK1K4eQLnxvkwsdhPZ1Fg==
X-Received: by 2002:a5d:5904:0:b0:361:e909:60c3 with SMTP id ffacd0b85a97d-36741783c38mr2188525f8f.9.1719510149035;
        Thu, 27 Jun 2024 10:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Y5AubVJoQM/z0xq/mp72IULX27NmhHEyumxH4auepDgA554eX1h1C0ROcXp0rCBXygvrFg==
X-Received: by 2002:a5d:5904:0:b0:361:e909:60c3 with SMTP id ffacd0b85a97d-36741783c38mr2188515f8f.9.1719510148615;
        Thu, 27 Jun 2024 10:42:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357ff03sm2565025f8f.45.2024.06.27.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:42:28 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Huth <thuth@redhat.com>, dri-devel@lists.freedesktop.org, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Geert
 Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH] drm/fbdev-generic: Fix framebuffer on big endian devices
In-Reply-To: <20240627173530.460615-1-thuth@redhat.com>
References: <20240627173530.460615-1-thuth@redhat.com>
Date: Thu, 27 Jun 2024 19:42:26 +0200
Message-ID: <87r0cie0zh.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

Hello Thomas,

> Starting with kernel 6.7, the framebuffer text console is not working
> anymore with the virtio-gpu device on s390x hosts. Such big endian fb
> devices are usinga different pixel ordering than little endian devices,
> e.g. DRM_FORMAT_BGRX8888 instead of DRM_FORMAT_XRGB8888.
>
> This used to work fine as long as drm_client_buffer_addfb() was still
> calling drm_mode_addfb() which called drm_driver_legacy_fb_format()
> internally to get the right format. But drm_client_buffer_addfb() has
> recently been reworked to call drm_mode_addfb2() instead with the
> format value that has been passed to it as a parameter (see commit
> 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()").
>
> That format parameter is determined in drm_fbdev_generic_helper_fb_probe()
> via the drm_mode_legacy_fb_format() function - which only generates
> formats suitable for little endian devices. So to fix this issue
> switch to drm_driver_legacy_fb_format() here instead to take the
> device endianness into consideration.
>
> Fixes: 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()")
> Closes: https://issues.redhat.com/browse/RHEL-45158
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  drivers/gpu/drm/drm_fbdev_generic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
> index 97e579c33d84..1e200d815e1a 100644
> --- a/drivers/gpu/drm/drm_fbdev_generic.c
> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> @@ -84,7 +84,8 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
>  		    sizes->surface_width, sizes->surface_height,
>  		    sizes->surface_bpp);
>  
> -	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
> +	format = drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
> +					     sizes->surface_depth);
>  	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
>  					       sizes->surface_height, format);
>  	if (IS_ERR(buffer))

Indeed. Thanks a lot for the detailed explanation and the patch.
Your fix makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


