Return-Path: <linux-kernel+bounces-255044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA8933AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAAE1F21F34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6E417E8E6;
	Wed, 17 Jul 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+j8HAU3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD23BBCB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210993; cv=none; b=n/8A1lHg5WqywnBHEigShawPmuBJGhHDmd1ZnBM7tx0IxvUMLJnJ9g5OVz61h8O2A5Pqvyk99WWFjpgA2qzKsQrW33JHjvukJD14IQ71OfhAmXGSvecb7UvexrWK5GN3yqPPNugGY2LV6+TzPT8sJwcbhrmA2CYykLy57AwIgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210993; c=relaxed/simple;
	bh=YzP3L1MpD9GNj1M3MDVMM9AG5cWfXEtMJxVSBk0hXRE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bXHocMGe3pCxsQ8eHygxGB/F38q0PDyB+VGP+DYvDyygdzWKCSML/q8kQ2dv4G2KaWQ3qIQJUQ36FWotpELjhcQ1YQduQnbitQmM0VR0TSBArwMh646m+8Vd9bOuQ4a6h5QtS8YiQGaPIDmczKYtkhudbbJHfeeYyL855YEhyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+j8HAU3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721210990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fgHkqvfngesDByFlySmzTO1my6KcXoQjEWiFHxkIfE=;
	b=A+j8HAU32xEtw+RN7Ps01VmMBIO4HlLR4PPFGnYG55I2foHTYe/WBWVAiEn4SLl2nyxisw
	1/O6czDtjEjBeIFe6kSv/0KPs1aWCPZwHp/8laUVMeMpt0bODMeLP4Hzt1HfXlTH0z9ogc
	3rHxxK5CjHcLJjs+drijHSvZhcC6DPE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-xeh8w63WPuyD7ZGS0hzytg-1; Wed, 17 Jul 2024 06:09:49 -0400
X-MC-Unique: xeh8w63WPuyD7ZGS0hzytg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367f1dc92e3so3955778f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210988; x=1721815788;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fgHkqvfngesDByFlySmzTO1my6KcXoQjEWiFHxkIfE=;
        b=tnd/GKsCK1q/d6ZuzNPmUHSUVz89wSWGHx8cjWoLXQFUwJY4N/hKPvZx60w4Z1+xKR
         ljYLPgNIKZywgsLwR5lyYK0ewRuRKntACSPF5Qzr5D8vjE4LQShQAVdJ3VTTLlRkA5n5
         DdUOsPzYtCUvH4x6S/7ueoCffcxzFxzVkmhkD/7iUBJ641uMhjQ1AmgnVm1H4GHwcUOt
         UEWweOxNEsar0o/Vz82WGXS/Q05RnOqMFH17qN4XhBW6s79HK4MGjUGENfhjRW8Ka9An
         gOAEGYcIl+9+1Bo4lX6iZFTk287WUBBhAYnB7cyqBTjTG3Q8p4q7dbvCjhfWP2PDegcR
         NxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwGtMfrXj7KLWKD+9pvqnhD3FL4IXX6H6MekfFqnT+q0Sbxry0Ozx6Tr8bL+A/P1KSG2dMZykvxuIiV0rCSca6HOvXw3tVOfKQpscF
X-Gm-Message-State: AOJu0YxRDzla97toOiVuoLfupNc+O8882s/k/n7vhmsOXrj6smtsSMFi
	d2geTAbK2UNtFbArMIb8YiLA+iK4FUTFoopcctfLR5GNhXiDz3eP1sTqO0K7nyD0hgii0EzZgm5
	J21rhqoKWZLRHFj7s4urw54VQ9OCbG1HewAxqL0NcI9GPsuY1gAxo7ajKhMiwwg==
X-Received: by 2002:a05:6000:1e92:b0:367:98e6:362b with SMTP id ffacd0b85a97d-368316f85cdmr754688f8f.42.1721210987912;
        Wed, 17 Jul 2024 03:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Lz0mGct43oO7Dy78Pu2M8nlnZoQ28GtDeNJR5prCRw0WEetXSwvYy2HHKS7mxHnPOm5GIg==
X-Received: by 2002:a05:6000:1e92:b0:367:98e6:362b with SMTP id ffacd0b85a97d-368316f85cdmr754664f8f.42.1721210987514;
        Wed, 17 Jul 2024 03:09:47 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db038f4sm11142783f8f.94.2024.07.17.03.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:09:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>, "Jiri Slaby
 (SUSE)" <jirislaby@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panic: Remove build time dependency with
 FRAMEBUFFER_CONSOLE
In-Reply-To: <20240717090102.968152-4-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-4-jfalempe@redhat.com>
Date: Wed, 17 Jul 2024 12:09:46 +0200
Message-ID: <87wmlk49ed.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> Now that fbcon has the skip_panic option, there is no more conflicts
> between drm_panic and fbcon.
> Remove the build time dependency, so they can be both enabled.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 6dd0016fc9cd..a22cab218004 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -107,7 +107,7 @@ config DRM_KMS_HELPER
>  
>  config DRM_PANIC
>  	bool "Display a user-friendly message when a kernel panic occurs"
> -	depends on DRM && !(FRAMEBUFFER_CONSOLE && VT_CONSOLE)
> +	depends on DRM

This is great. Thanks for finding an alternative approach! I don't see any
issues this time, because there is no locking involved. But let's see what
others think about it.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


