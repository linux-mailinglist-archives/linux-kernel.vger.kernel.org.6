Return-Path: <linux-kernel+bounces-340109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F237F986EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893F0B24B20
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D076B1A4B70;
	Thu, 26 Sep 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A16Ct42E"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612B143C4C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338845; cv=none; b=gNZvwcwuBvGHjkTMDaZe8T23B3f9MoOK35Ls3C/rL8aDTGQU6CHIjozKhl80c+HTyegbz9rfSS3pHV//p5m1wXPa3sF5hMJwB0Tn6P+thX342u2uECuAj0+A92n1YxPkOCW1sF2TUyYQT3/ib3wR/vFceUMYhRQZrMUS0sRCKis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338845; c=relaxed/simple;
	bh=aFb2dDHfktQwpXKURBvhrD7zggJPtDMgX/cnRqDzReI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0aRWLROb/awk9MNK5Pd0vyvJfxyS/MSXvzCbp3RJEnxTBFEw0fE4F1bY2XtXXoY5DueopY+gMJ/Sfmg2fAOQ1DSkVUoQOtW7zb4ag2pAW1XlDQ0Zwi6AvNWR8SNiJobXk/KbUCLPQ6ou0lDq1jeIKo2ALfNTrADge/kPGWXuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A16Ct42E; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so814046e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727338841; x=1727943641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhXb2BMlBPjRPmOBalS7Rdb6ZOjPGN2SYGGnIxSjxAM=;
        b=A16Ct42EqO+xf8bBJQP2bkqrAN1ddh7QhL2kxOzh8RKqHrRnKB14RsqkcBgyGDfJMq
         GO8m7awkM68dSeSWvHDoWRpTI/7eVHMoKmgoieeJgj68vU1zqBbsPcVhJxSJe6qXn6OM
         Ufe/BsVMiB23gaLtEQjkf7XjboMZfcXhbsMSI2PnwMt9ovSwlGGo/vvQc/QZWSV+2R86
         xdfyEfko+feRcEhsMflJ2ELWVIeo2Pwtt9fjygh6Ire4oUkrg6GYAyK05JEUbKXbM6r+
         rXwwC9CMe6Q8JMCr4mGfzAJFhsB2RHtAvsv+iifxBPNfn37x5Wdc59hDgMe38Z5Sva14
         QbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727338841; x=1727943641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhXb2BMlBPjRPmOBalS7Rdb6ZOjPGN2SYGGnIxSjxAM=;
        b=WkS7fW4GGt+J+cr+x+FxHVIfCQ+0VXid3W5PeNThog0zTGDfMM8u1DDc0qkKfS+uY5
         8OHaWkSmpTMqxMskrPOFnV97NQUW2uRhS4AIp7NhoFdRd/aw/QnwR3XyRy9gM9U0Fbwi
         kaLs94JeF0yLAw1JXjBwkz4yBbBM3clDjk1BerXu7QrxcOlFwhvon5fOktj6ct4W+mKA
         sexrwerkI5JhshTHWojpmrQs3zU7ybUMcNyQf6cZgFwoIIxaEMpwF9N4ioQ2R18Y1/zQ
         x4Wtvk3KOOLiPwPNDuL0koZ9CgurSk2HaCBgZOM8rk6iKh9qPno0Mzo6xrCo+x2L4nYc
         kTJA==
X-Forwarded-Encrypted: i=1; AJvYcCXkAiQnXROvrzFDxK2jjtyBPlBfa+D0OybHJzYuSvFb7NddXazKopfevJ9praDDmr992laCkxs/LszPFb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWoqYqkeOtShnl4o7zQlYQ1vSca/4J77ndcV4bhD+BF6OMxhjv
	oHkWNNnmJc3aqyJJrWvU/IElaCH4YL43YRahcL30t80DhNZ0NkRRAO3mB7n3oQ4=
X-Google-Smtp-Source: AGHT+IFK+jXryVzVLW2y3ifKDKgBpOQbwR5ujjugsr97Kro3qvTFnMQn30mFK9B2YZMffWN5e3s75Q==
X-Received: by 2002:a05:6512:234b:b0:52e:be84:225c with SMTP id 2adb3069b0e04-53877532254mr3550333e87.33.1727338841203;
        Thu, 26 Sep 2024 01:20:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e0f89sm739271e87.62.2024.09.26.01.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:20:40 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:20:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Allen Chen <allen.chen@ite.com.tw>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/11] drm/bridge: it6505: fix HDCP CTS ksv wait timer
Message-ID: <7pazkukfrskc6o2zd23h6o4wyt7ougjjgnmogy2effr2lof7di@7opphoswhebf>
References: <20240926075134.22394-1-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926075134.22394-1-Hermes.Wu@ite.com.tw>

On Thu, Sep 26, 2024 at 03:51:33PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When running the HDCP CTS test on UNIGRAF DPR-100.
> HDCP must disabled after waiting KSV for 5s.
> Consider system ksv work schedules. The original timer has a chance to expire.

I can't understand two last sentences, excuse me.

Nit: KSV, not ksv

> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index e75bc1575aa8..22d9bec3faea 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2093,7 +2093,8 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
>  	struct it6505 *it6505 = container_of(work, struct it6505,
>  					     hdcp_wait_ksv_list);
>  	struct device *dev = it6505->dev;
> -	unsigned int timeout = 5000;
> +	/* 1B-04 fail, wait to long to Stop encription(5s->3s). */

encryption, most likely it's also "too long".

> +	unsigned int timeout = 3000;

What is the timeout per the standard?

>  	u8 bstatus = 0;
>  	bool ksv_list_check;
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

