Return-Path: <linux-kernel+bounces-336936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948919842CC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F067288822
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F715D5B7;
	Tue, 24 Sep 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dihltmfE"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165941487DC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171932; cv=none; b=ufgfM/sHSmTCuBPjAi68ROgzoWs4PRNGh6aTYVd+SGzJjTuDUCm78cyc7XqBln5KNZUjNB8k4qtJVYhkR7EF/JBTWtPMSiqF3U4nWnDeGUvWKWYedWhvJ+NabyYvdewlAVaCK9hpqYFexZbsVbyXPIekDt/W/hHKh9n7HJ/PsMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171932; c=relaxed/simple;
	bh=tlETOa6+vWMIAxq2Cm1TSBMmx3VjIIaigi8ooiVQInw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SteU34zgzz0s7vWSeof1+UVN5+KVnXeUcgPbcMGFxPDLJeXlyQlyGYkE6cKyx2OO3oya5E89tca0G6kHiCGdNB8p47xHviarli0KYosbTiaUUHduKeCPmC8thI6o/c7mx/8cjrLDJ2o//ryhl+ho+RJ9KhV9y8A2IiFCtc39OO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=dihltmfE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso5907857a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1727171929; x=1727776729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuBTHx/9cOhiI07dj9MDxTsrK6YcRc3R8bANsyntmZU=;
        b=dihltmfE2RZVcKSI2a7wJrW8basTlTju21k95ZwGG8WW69EYvXPZlLJ9Ze3oBXKjfr
         N3rfMxsb2eTpE2XNh2gbA06gZlk2h+ssBo0g1sGOIZVtnnb4fExO5KiVoHT6a638vKB4
         5DpPUS+lyRV6w8+m2sYwngUGlS0q2aQEINmF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727171929; x=1727776729;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuBTHx/9cOhiI07dj9MDxTsrK6YcRc3R8bANsyntmZU=;
        b=YhqoIUOC/a2Vn2GMn0iqV2DGti1GuP9M2A6q47N3qNKDtZzGkkdbBO0eoTwJ52z1Fi
         qNs7xxm1I4K40nNlWVN+w81xMtmQ8yF8+Nxy2mxbXTgbXjlSIL6ptjLdLyK9cbwcZH5c
         a4TxzLclLbVLYrLGr59SnmGXLknMWuccH0PeLdYiCqev6jC/blmsHc16o0NPVf6m4GoA
         ngb30aT1QTO5yaWtFKG1ewI3NBlIolvV1N0fV4kabAV5pyim50HGDCIRCfdyc6ibCyTz
         ntNgy0Vgw/HWly7alxMskpRD6To5udSezSg5u6AmnsKa0I6d56vseInWAkEZOPY1VF5E
         raag==
X-Forwarded-Encrypted: i=1; AJvYcCWaQTz0o8IIOoDuv/G3PIEB1pOTeqJt1qvvX+Z8pmYcf3syLWOhMlG/Man0eRISVxqfxK0hnwsVj0XbRmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5jCtmT0xWtcwd8WKwgnGj/V5flEHByFGCyF58G8H/HiaJQBq
	oNw6brkSU3za6TpRECLras3ydC5eNrKZCCzheTLC+EA/ttzK+ylJWVmIww6kcHE=
X-Google-Smtp-Source: AGHT+IFM64nYYVrUwnbpbJ2SOxxynSNBbuHUUVEvl48F1dF3eRESGEumW9pE32wjRYZgIjjhpvjLHg==
X-Received: by 2002:a05:6402:2788:b0:5c5:cb49:30cd with SMTP id 4fb4d7f45d1cf-5c5cb493109mr2902878a12.9.1727171928949;
        Tue, 24 Sep 2024 02:58:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c437sm587972a12.5.2024.09.24.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:58:48 -0700 (PDT)
Date: Tue, 24 Sep 2024 11:58:46 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: mripard@kernel.org, dave.stevenson@raspberrypi.com,
	kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix atomicity violation in
 vc4_crtc_send_vblank()
Message-ID: <ZvKNVut_V9fiiaaT@phenom.ffwll.local>
Mail-Followup-To: Qiu-ji Chen <chenqiuji666@gmail.com>, mripard@kernel.org,
	dave.stevenson@raspberrypi.com, kernel-list@raspberrypi.com,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	airlied@gmail.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	stable@vger.kernel.org
References: <20240913091053.14220-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913091053.14220-1-chenqiuji666@gmail.com>
X-Operating-System: Linux phenom 6.10.6-amd64 

On Fri, Sep 13, 2024 at 05:10:53PM +0800, Qiu-ji Chen wrote:
> Atomicity violation occurs when the vc4_crtc_send_vblank function is
> executed simultaneously with modifications to crtc->state or
> crtc->state->event. Consider a scenario where both crtc->state and
> crtc->state->event are non-null. They can pass the validity check, but at
> the same time, crtc->state or crtc->state->event could be set to null. In
> this case, the validity check in vc4_crtc_send_vblank might act on the old
> crtc->state and crtc->state->event (before locking), allowing invalid
> values to pass the validity check, leading to null pointer dereference.
> 
> To address this issue, it is recommended to include the validity check of
> crtc->state and crtc->state->event within the locking section of the
> function. This modification ensures that the values of crtc->state->event
> and crtc->state do not change during the validation process, maintaining
> their valid conditions.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations.
> 
> Fixes: 68e4a69aec4d ("drm/vc4: crtc: Create vblank reporting function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 8b5a7e5eb146..98885f519827 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -575,10 +575,12 @@ void vc4_crtc_send_vblank(struct drm_crtc *crtc)
>  	struct drm_device *dev = crtc->dev;
>  	unsigned long flags;
>  
> -	if (!crtc->state || !crtc->state->event)
> +	spin_lock_irqsave(&dev->event_lock, flags);

crtc->state isn't protected by this spinlock, which also points at the
more fundamental bug here: We need to pass the crtc_state from the caller,
because those have it (or well, can look it up with
drm_atomic_get_new_crtc_state). Then we also do not need a spinlock to
protect access to state->event, because in both callers we are the owners
of this struct field.
-Sima

> +	if (!crtc->state || !crtc->state->event) {
> +		spin_unlock_irqrestore(&dev->event_lock, flags);
>  		return;
> +	}
>  
> -	spin_lock_irqsave(&dev->event_lock, flags);
>  	drm_crtc_send_vblank_event(crtc, crtc->state->event);
>  	crtc->state->event = NULL;
>  	spin_unlock_irqrestore(&dev->event_lock, flags);
> -- 
> 2.34.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

