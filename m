Return-Path: <linux-kernel+bounces-335843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606297EB69
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BF2280C97
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516791974FA;
	Mon, 23 Sep 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlQw9uVF"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D422940B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093795; cv=none; b=W7VzWoDgrdPZy3gmo5wXq+nmrnbxmf2TF6JBRiEL5o1IUyrtPPMzZudSRIYLpOl0iUXImofEkuYV22sq7Ml+Ski1Fh3uyTOKliNp47e6P8Q2pF25exHjTgaW8IcY18PUrG2Yya5Z+MVDK7jvZ3zTCZI9Q3TqLkotG/ddAczNoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093795; c=relaxed/simple;
	bh=lscf0WTrlrrHxoUNYjQumrmRY63/obN/O+elZ/klL8g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJUtLDBLU600xAAfI0lGydfRrZtG7f9RW6Q1a1Ua1+zuKn67vPcoTBIFxwitayloOQmblkNfcmnktdXzIxiLU8vFZXnyPS78Jm/+KpicAqjDFj+WY6GpGpk/y9jnArV+eYF0FuhKBQ5W9xJ0S+zUbVLcMvna3wlFBa3yI9iV9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PlQw9uVF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365aa568ceso4813143e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727093791; x=1727698591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsNBpuLZI/6vBi0+2mpLKJCoxD+TiNDtjW2xHsUYLc8=;
        b=PlQw9uVFnhBPPU7dWcYwR7IdO0iolaIstmDFXdgxNsUQdDIGQJQJhxgugXMbQDqINz
         61QiH05a38vswMStsYEFlNSSgjO5+Wpo+nphcO7lIXvcA9yU4jUb2JMyC1GKcBFkCLfz
         H3GktuzOrzPWnIKH8e3sxNqZthD+N0xiWWKYRLjT/w0wLoR9NwRojqXsCo2o1/KAzOAB
         AOldpX79+7948nLh3vRdshaQaheLuV3fjzj/tnBP6EcIfJe6+xY+wLkhxw/EsoVxyjIZ
         OzK7jc/h7r/Y7rYhP3IP2tabX4aOifXR9zZLncRp+FkeyYODFBZReb0ResN7BKPfVJR9
         VqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093791; x=1727698591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsNBpuLZI/6vBi0+2mpLKJCoxD+TiNDtjW2xHsUYLc8=;
        b=pwLVVqrPb9LBSXrzqHdOwALFzgEeAIfqNXcQm2D5eySnIDciqa5g+rZip+GFXNGbLt
         TJzaJn1HONnY0t7coXOKytXf74KKRYuqg/Ugie5YzUFd5yVjWJMDK+n8o9SNawMkLIXe
         MIDoGZIqcgx5f5WMYTffCu6tdNGl20yedbKceEK0R/k4NT+GFaoeXEtYNWXuvAV2YgGA
         MxCsjWCHEeSjOfjKJ871iEL3XlvnhbUH8ogtJU/yJoLJkMiqGyW9HvRlY/QxXgwPFtrJ
         cv+zN1FRrL7bJLYrJNejQcZxVReVjLpFOlzS5eUe/L1LpUll1BxQxyo4aUAsk7rlAX6h
         3TQg==
X-Forwarded-Encrypted: i=1; AJvYcCV23eodt7B9LxkoIYscaVJ8Op5/yGliGmYFCNyKEEclgGQWMkIhUwvHaklGyOjHrmppKQX5e6PJ5Bnoqjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAByLLwt8ZQp6eZczPm7MloqMNru/OBgAy4zzGkhghRnsdOsC
	NTRIMIgDTsnQ4iOW7NSjFLGg1rQPppK33ZdLqX4Fzypn5OytyMZmoA9WuDZ7E38=
X-Google-Smtp-Source: AGHT+IEll20m0+xUonHMNXt2UPq8NyfIxK3UGL/wK3GxwtrfstaIDlQYm8uP3dzRZ3/adfrLdF/6UQ==
X-Received: by 2002:a05:6512:3d0e:b0:535:6baa:8c5d with SMTP id 2adb3069b0e04-536ac2e5a42mr7093911e87.20.1727093790835;
        Mon, 23 Sep 2024 05:16:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704660esm3269744e87.15.2024.09.23.05.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:16:29 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:16:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, jani.nikula@linux.intel.com, 
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: writeback: Introduce drm managed helpers
Message-ID: <5sufhgtqempg56b57ocg45ah4ip5ykhaz6thphctcupk5lortz@fmkxzzzdwd3i>
References: <20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com>
 <rz3xk3kwwsfstjrqffp4vfkm7mvn5sdviwjzb5dodmsnb5v2fz@vuamquxmvt4r>
 <ZvE68e95dwLqjVuW@2a02-8440-b157-69df-aafc-5046-a3b3-4ce9.rev.sfr.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvE68e95dwLqjVuW@2a02-8440-b157-69df-aafc-5046-a3b3-4ce9.rev.sfr.net>

On Mon, Sep 23, 2024 at 11:54:57AM GMT, Louis Chauvet wrote:
> Le 22/09/24 - 18:31, Dmitry Baryshkov a écrit :
> > On Fri, Sep 06, 2024 at 07:28:17PM GMT, Louis Chauvet wrote:
> > > Currently drm_writeback_connector are created by
> > > drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
> > > Both of the function uses drm_connector_init and drm_encoder_init, but
> > > there is no way to properly clean those structure from outside. By using
> > > drm managed variants, we can ensure that the writeback connector is
> > > properly cleaned.
> > > 
> > > This patch introduce drmm_writeback_connector_init, an helper to initialize
> > > a writeback connector using drm managed helpers. This function allows the
> > > caller to use its own encoder.
> > 
> > Also it introduces drm_writeback_connector_cleanup(). Ideally that
> > should be a separate commit with a proper description.
> 
> Will do for the v2.
> 
> > You should also
> > document that existing users should call that function (and maybe add a
> > WARN_ON that can check if the function wasn't called).
> 
> It was my initial implementation [2] (usage in [3]), but Maxime suggested 
> switching to drmm. If I make it non-static, this will be a new API with no 
> user.
> 
> I don't know how to add a warning if this function is not called. Do you 
> have an example somewhere where a warning is emitted after everything has 
> been cleaned up?

Add boolean wariable to drm_connector, make
drm_writeback_connector_cleanup set it, WARN_ON(!set &&
connector->connctor_type == DRM_MODE_CONNECTOR_WRITEBACK).

Or maybe even better, make this function being called from
drm_connector_cleanup() if it is a writeback connector.

> 
> > Last, but not least, please don't add API without a user. Please switch
> > at least one driver into using this API.
> 
> The user will be VKMS, see [1].

Usage should come with the API in the same patchset. Otherwise it's
impossible to judge whether the pieces fit together or not.

> 
> [1]:https://lore.kernel.org/all/20240912-google-vkms-managed-v3-4-7708d6ad262d@bootlin.com/
> [2]:https://lore.kernel.org/all/20240814-google-remove-crtc-index-from-parameter-v1-11-6e179abf9fd4@bootlin.com/
> [3]:https://lore.kernel.org/all/20240814-google-remove-crtc-index-from-parameter-v1-12-6e179abf9fd4@bootlin.com/
> 
> Thanks,
> Louis Chauvet
> 
> > > 
> > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > ---
> > > Hi Maxime, Jani,
> > > 
> > > I tried with this commit to implement the drm-managed version of writeback 
> > > connector initialization. I tested with the current vkms driver, and it 
> > > seems to works (at least no crash/warns).
> > > 
> > > As suggested by Jani, I only created one function, which takes a 
> > > NULL-able pointer for encoder/encoder functions/possible_crtc. What do you 
> > > think about it?
> > > 
> > > Regarding the documentation, I think I repeated too much, can I simply add 
> > > comments like "see documentation of @... for the details / requirements"?
> > > 
> > > Good weekend,
> > > Louis Chauvet
> > > ---
> > >  drivers/gpu/drm/drm_writeback.c | 224 ++++++++++++++++++++++++++++++++++------
> > >  include/drm/drm_writeback.h     |   7 ++
> > >  2 files changed, 201 insertions(+), 30 deletions(-)
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

