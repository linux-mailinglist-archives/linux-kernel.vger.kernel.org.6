Return-Path: <linux-kernel+bounces-339928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C39986C42
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1D1F21F84
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C1185941;
	Thu, 26 Sep 2024 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rv5tP7bw"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1021AAC4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330781; cv=none; b=J+iaidCV8g95Ib9eO58U2gJlcewXdTccbSxrSqkci1ZsttlcW4Y9wkhpe5LCPLdfgMlUbeksm37SVxrR0LsFd5o3Qp0sEOdvcuZ4Id6t3NYmf8+WAIJgJM20jEbsjurlB2btDGze0u83a/UA+Q0oIrMons+KnTpuJ3T5pRmD0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330781; c=relaxed/simple;
	bh=xPVP7IHJXUPTitCNqYtrSow7uB2WmFHmqDRgN0HR9WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFiuvDfkcZx/sc0aDv3kpbq8G1FG0UhVQkSoFlJwEY21ZwdqAwhxzXE/UVZH8d2UEGCb219Q7LifIWm8qjqcUc+9ljb0NesvGtyfBJh581wIEGI/UcUaITEfQyIyzGImTehuxIWhQvLxtrUqOSKD3UfcctM+jhkXtuL798r+XyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rv5tP7bw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53659867cbdso876699e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727330778; x=1727935578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ejo1TRuFJ2zM9Fu+guQtsRLwGHHMWPxLCk8lrAvCsoI=;
        b=rv5tP7bwJCMlbZEeQh3L7cr9o4NWnXd+RLvDpxdsv6om/3ILSf+GnO4STBwk1hz4S1
         5ea4tgFAP8vXy5WsXoqFQvcBQbmW2TnFqHtfCyrYDyNniDuljrPt3MknItcyN/h8xvU8
         6jB0X7y6SnianydnxG2bD1RFiDub7HIIQmAQpYSipWzsvAYso4kYJxQrjUsAwRNTVvSV
         KQCXsrBknE1gEQyPDWFQJqsN7VRuH1GgdczLO/CA0r/zxaqm3BlF1V1v553KzXLa5tRg
         8LqB7NqGjqv+TVPXWfOBm2gd/PH/MuoRLw/tB3AbMQhMVUA740ERi/dTW/zd2wnf6jCZ
         oiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727330778; x=1727935578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ejo1TRuFJ2zM9Fu+guQtsRLwGHHMWPxLCk8lrAvCsoI=;
        b=E2SAZwLqXU6ytYNKFUjsTAd6J8oraqTJ7Et6S5eW6Bc0LL3Gy16KxzNE5u8IkpjHJ0
         HZvf9awIv5mBDAcjikjVxqIHDQ3KzbuyBdUi9lmLlNV1XfkqeuaEBSOYc9N4PYhKT70O
         Iey8S2vhocmaCVBlewbQLXhGgbhfL4y8fNGyyGtOfU9t2ifVyHtO0BX+zJ1NgX4J77xk
         N6agbioHK6dDB2FDVKh3pmqRB1SC2c3Ku5HplH9rYQM5u/nXtaWbVvFpYxoeVkTPQKo7
         cUXI/U4byil00B7qfCTxMcNqA/KNPQ217GiL356tSJ2Y+8p6TOTeV+s61f8+ah9NJ0yr
         DUWg==
X-Forwarded-Encrypted: i=1; AJvYcCXe50fmDsc8XvC6nQWYYvy/nOlVeuTUHbR2cs//XQwyNF2N6zHtETzBNjwOF5NFTxzA1krK+YZJnXIYDVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHtwC4VItPXC3B6U/rfmbVOO5EGvfONHINu26g4R7YF0VPetQ
	rhk/OtXyJRLkpT3EXWpzCRgnoxXTIj+pFRmF2bCYfN20B97yWtVm8zlouyA5MBA=
X-Google-Smtp-Source: AGHT+IFOV7/5WVFoAHKdj7fBib+/U8cBJf7swI2iHaZNBkQr5Rln2X5XyYoZbmW1ZI+0/YVf2hkDEg==
X-Received: by 2002:a05:6512:31c3:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-5387755cf04mr4552703e87.41.1727330778114;
        Wed, 25 Sep 2024 23:06:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e0642sm708396e87.27.2024.09.25.23.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:06:17 -0700 (PDT)
Date: Thu, 26 Sep 2024 09:06:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm: fsl-dcu: Use dev_err_probe
Message-ID: <unc3udwrwhzjluulpxjqwsgylvoadwmjrabmskglyvof4i55g3@5jmjk4oketo6>
References: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com>

On Thu, Sep 26, 2024 at 07:55:50AM GMT, Alexander Stein wrote:
> fsl_dcu_drm_modeset_init can return -EPROBE_DEFER, so use dev_err_probe
> to remove an invalid error message and add it to deferral description.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * None
> 
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

