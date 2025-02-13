Return-Path: <linux-kernel+bounces-513480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1578BA34A76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAFF77A63D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD0201025;
	Thu, 13 Feb 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmdTI8FV"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA34245AE0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464874; cv=none; b=asg/KMn4suii5/+7pXwWEYOxaF/4YH7PaUmEWd1GziSSGq+tP+nexUKf0HyhzNRrL3lM2ghbbMYDDPNGp0BaS0VHJBIdJAC3TJjXAPfJ1g6X789Bs2dIkHqnikLc90DCBzbVb7dNpwnncYmtuFPTYyp3O3SqI3I5M/C7UjlJeGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464874; c=relaxed/simple;
	bh=k3kbdV0TQp8/+hSOjgudLnPHkQz6EMg423QGqHoHAHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF6ltw3uKWcJmPs+83w7ZLntjHnz69UMXnUQ8VA50nURJbK45AqRxKtFDZDuYYU4g52U+OCCEH6QjkYqeVKBMFnU9Pqb+sCMch4y0XmN+6u0nEVJqog6lmI99CQiV4ogP5ujlOK/NOvYqYsaXUajNmO9QgY5rp8YHJa9Hs1Lp10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pmdTI8FV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-308eebd4938so10871941fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464871; x=1740069671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XgRxj9qVKDzrBjb5+1yaq8snXvKlW2QBQrFF0S3vrs=;
        b=pmdTI8FVBaxNKC/oZRH8SvEmDqPSDvPsgiOFzgknTv79vKL7ORCixmyFObLt2Pz05A
         06wrw/9uMXzeJMs5VT8UVsKyCNK39IESWGjYGS+gYO0cRFwNXCgT/mD/iM7mYlupB6ZR
         +fgt7j2xNBe0RVZHgXz9FMwKm66xT0mm2fY9FlEj7UbZPniMf82QVcuVnar8D/8n1bgG
         w9nWa03m6lzwwib7O2zvRzgVYWmCbP36uh5/22w6DbKFvoMzdTdYPmZLHDYrAP7xNwcU
         oXvEkL4sHlYA5vgqDciSBzny7eb49XePJaBNdz77+jW+ItF0uisurhxQEx+bs3x5qtDw
         Z6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464871; x=1740069671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XgRxj9qVKDzrBjb5+1yaq8snXvKlW2QBQrFF0S3vrs=;
        b=rw1i6RtqweMzsyilHHRFG9TEau0mEyya+MYpnfa4OGVYAUrGNKwLXLyQ9O8fLnZBFq
         U6+CgTitpRq4IWb44iM8Fy/7wVuRkIcSTjIh42xe4Y5clL8BFYgEB2kh1umQKBLmlm5X
         /kRmXEfxWVJItYQTKVvaVtgc1iuo1kxjNSgO+1eeZcs/iGXHQc5pgr0Z5UyzKVKph9SA
         PB+sRv88GAIst9O2qPGVeo2SOi38qf9Y8+eyFFeZm7lmCggsLpVJk0+SleXJDLQCleO4
         Ro/PruEErvQHXf1rnRzUuhpaOTsymvVzwHAwLL9rNxoHzGyMsRAJ8nVkik5dpd9sybe/
         ZGiw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1SS6uXfn1K7H8oO0lYCJb684sbR3S7UnKilNc7xZBPdE6GkNmqqkQMgTrFHEiSIz3FnFXbqRxuag76k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKMVhH8ka3ow7rs+sXBqtOff0WC6xbqVnne/vTnYUMfA2WEFi
	u11BlvBohuet/cVteJ2C9+c33aXfOw59IHQBZOKVvx1Qw0eE5IUP+iUqQU5uzw8=
X-Gm-Gg: ASbGnctFqD/T/UFSeT4KmpNbnzeH1/2zbyq+QLH/oKPZfitTxh1ckVJCj1Z54+X/ltP
	51hZ9nKDAM7zIpo39o1rfPfwPeN5BEpb984vrpuyvU+V1d8pv9uyvIR8DjsdFPIE/NOjuX5cT82
	0eOSLnr7xDq6j7QDVtbnrEijfdk3TCs1FeXAslf60ThadnxRXhAyjqBEMkx85a9B9b9o99FIcZI
	3FD9GRWGlN6njumMO+ht3Whf0H1kGatary9xYXZ07D2s0TgjRA0m61XCJOOZvqVDkw/U9DTSPGK
	y2NtuOOhjD3KoWeZeAdiltkRQI0p25lX8qFpqA6xeOKgVY0gRAq6j/HApkVfMIjcfmtOLks=
X-Google-Smtp-Source: AGHT+IEFKcWZd8azl8/EBFVoIp/CitzTV0bjXABcH3VDl5luhrQKR0QHCreRzY8bYvxXYajgaW0KbQ==
X-Received: by 2002:a2e:ab1b:0:b0:307:e185:342d with SMTP id 38308e7fff4ca-309038e58d9mr30083431fa.22.1739464871508;
        Thu, 13 Feb 2025 08:41:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30910276839sm2455201fa.87.2025.02.13.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:41:11 -0800 (PST)
Date: Thu, 13 Feb 2025 18:41:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 25/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_commit_cleanup_done()
Message-ID: <wd3ubsg5tkox6pr3vsajfsnuxfzueiq3rwfyoau6355ghswofi@g2cgmtwkq6kz>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-25-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-25-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:44PM +0100, Maxime Ripard wrote:
> drm_atomic_helper_wait_for_dependencies() is the final part of a commit
> and signals it completion. It takes the drm_atomic_state being committed
> as a parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

