Return-Path: <linux-kernel+bounces-525540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9EBA3F0F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E1017B169
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E71EF0B7;
	Fri, 21 Feb 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hp6JzcFW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB61BC09A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131466; cv=none; b=qaeqey0R3wGkOkN/hp/PRQ3GnFEHmsCezrKdrRSpm/z5YnGmL7PZtv6mfFh/aWzVbmVJ2EkrdJQb41r8xJL7hREckHU+ZXL1hLDD7asUTiEXoIjS6yvMg6duStgMWUM06Hj10TEoBjFW+VkskZYnJZrBnw+mh98jQMQ+7awpW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131466; c=relaxed/simple;
	bh=XeVG31wQkHvsqylkZ1/LVx8l4eCL8KFwEM3KPcwZshA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBEk+Kx3POmkBrDwD12SsyCuy+Aal4UwEpYBdfs341Rqfc4ogsooG0ifnIYyiemrJ8aC2/OnuOpzrFZsxZ94trRHC82wxWLlSRqlALS0pq1Svkpq543aTAgRj+1L0FTA1xmErW5nKrLHvYdICcJWSeBfR8krgt35wVKJvS1zLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hp6JzcFW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so1390511f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1740131463; x=1740736263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkBqyj1NJ++IcFdvPYM6tSZ9F5kg9Qwf+D+lXPfSeHQ=;
        b=hp6JzcFWNPGMHU2gOYwmOzrfaDxhhNCUJugpuat9jlzoGLMsZ08GEenTA4NDFIDGL0
         mUIVv8bOiYG3WCj4m+zOy8vLpIv76UrVi3MiXxE4YJW+biGs0NOAsebI5IudIb6DPCzH
         W4q9IRBd0QAAw2ornpJ4w42o1n7o9Gaw6X3NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740131463; x=1740736263;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkBqyj1NJ++IcFdvPYM6tSZ9F5kg9Qwf+D+lXPfSeHQ=;
        b=LzVhSe13+BJcTVrpEiFJ+KdHQfuFA3x72fIOBUz5ByQjykB/8CdM75sbvRbwmD+53h
         9FGQpHZAAouN2zS4Oj4ojDaeL5cb4n9SoZY0D5BI1RfrBfFgkn5VD0w/mjyAKc5hR4W5
         U0S91+ARy6RDUWNypJs36qZT6zSjgo7Xv48bj9t274a39qw06wkh/hFYZXvB7XcR8pMY
         tbMNITnfL2DQ+nC4e3iTuVvvLlCcJvHSFCjer21h1jMZZrMO+UKrz/QlhFXZT/+GY5dH
         6Kq7ZnGZ9i4eI5wJCwvPyTACDr80ik9fqT8BiPqB4sc0fcHCHA4hkB39ppoy+LveXkGP
         tRIA==
X-Forwarded-Encrypted: i=1; AJvYcCXPvTVrR16Vma8JjUUyxXX/PEwV7C7CSynKbmOGLf4KAQL3NROYllU4X7Xt1vOdsbsHBElFhGECorV/yqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLfqxl+DYrG44rD08VzGHGufBxJPO2nS0JP9iZUZkyd7U2aWQ
	58Mf1WRoKKiR3UgMDftfx0hGU87LXUFTFerW3nqz+OzZH7CFKg+4b0dqGHbAU2g=
X-Gm-Gg: ASbGncv4E81CwCHXq0wwjyqAdi31z2H+fZ12uJtC8PIx6pCxQZN4YOkiPFh/HCfg8Q9
	FCYs1nmgTeKfeIONAlXHfgvH0Dx4eNVk9zYkoQ3Egdy4tpem/GCClWbyGFMy58C3rZRuT0vSTVm
	HR56M5tCP/Sf7kbENza8jgsVoxdyOERJIuFywQzEN6UN1DAaXFC1vyiZTjnIwGSaKOFLcsCEDtJ
	K7OrBNUMhNy2cChpOzAzT7AHPUHFCJK9fNPEbwbpxdhLSo+DVRcVzj6uoP1ncwwxtlOxG7JsExJ
	1dhVHF+NNUJL3HOh9tK1JJEEFVXeCukL1UBYwg==
X-Google-Smtp-Source: AGHT+IHmq7b1qRekf8aTazizZx9u6TzOuIpZCimXH5wNq+e74czCrxUFI8LledckRXx1iP2HXeSuuw==
X-Received: by 2002:a5d:6c6d:0:b0:38f:4cdc:5d2a with SMTP id ffacd0b85a97d-38f70783feamr1553394f8f.4.1740131463231;
        Fri, 21 Feb 2025 01:51:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b01346d1sm12342375e9.0.2025.02.21.01.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:51:02 -0800 (PST)
Date: Fri, 21 Feb 2025 10:51:00 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm/atomic-helper: Add a note in
 drm_atomic_helper_reset_crtc() kernel-doc
Message-ID: <Z7hMhEz_hTymarO1@phenom.ffwll.local>
Mail-Followup-To: Herve Codina <herve.codina@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250220140406.593314-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220140406.593314-1-herve.codina@bootlin.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Feb 20, 2025 at 03:04:06PM +0100, Herve Codina wrote:
> As suggested in [0], add a note indicating that
> drm_atomic_helper_reset_crtc() can be a no-op in some cases.
> 
> [0]:https://lore.kernel.org/all/Z7XfnPGDYspwG42y@phenom.ffwll.local/
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

I'm assuming you or someone else at bootling has commit rights? Otherwise
I guess on Maxime to get that sorted.
-Sima

> ---
>  This patch applies on top of the following commit available in drm-misc
>    ab83b7f6a0c1 ("drm/atomic-helper: Introduce drm_atomic_helper_reset_crtc()")
> 
>  drivers/gpu/drm/drm_atomic_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 0a636c398578..1f93b0a855de 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3371,6 +3371,10 @@ EXPORT_SYMBOL(drm_atomic_helper_disable_all);
>   * This implies a reset of all active components available between the CRTC and
>   * connectors.
>   *
> + * NOTE: This relies on resetting &drm_crtc_state.connectors_changed.
> + * For drivers which optimize out unnecessary modesets this will result in
> + * a no-op commit, achieving nothing.
> + *
>   * Returns:
>   * 0 on success or a negative error code on failure.
>   */
> -- 
> 2.48.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

