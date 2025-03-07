Return-Path: <linux-kernel+bounces-550914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77767A565B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660E83B17FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E4207653;
	Fri,  7 Mar 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTlJeiCl"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6A502BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344681; cv=none; b=aSSXSjHpDPlpbuoVbwvFL03jihJsXHFvo9uWmZiw37aXBXlKEt4ovHNwviqL3zbZaD7h9nJK/PWFyvpZvh/yvnxENivzWvy0yJuoxbx1drQfxeb/6o4fqH6Zcf4lsh04/AkBtS50ISG8P7lc2mmh7t5BGHCbVb8QIfZazcvxjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344681; c=relaxed/simple;
	bh=mbH+eKDo1AWLls7XpyfZrXtxyYxrVqcJyi31q2Rb2a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bp88vXvl0LgGS0fWa0LgYZbeavxqYF5b3MBrsOOdnHyeFPYrKx9+vbmAYtT7gnWCVR8jdYHNvU0MpAvws3rzFIPFHUsJPBbohV9if/m5VQI4VPsEJ8f9UAN1U6CUm624R4OFEM/9rljLplUC8B9shsa+gvafC+OMIzrA8pl9p00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTlJeiCl; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54957f0c657so1958175e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741344677; x=1741949477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CoJab6aQwdUmHv51fjpmCPB+nAKlS0NjVx82EWhJoYs=;
        b=YTlJeiClQPN380eqwEE78u97GEz5yfjXblxDbYntyNckLoREsj0QbuRx1FuXtokz6B
         Y4xvPoa4PI6jwCgcb6XkBZh729HEWAg4NMbWvR2T3+KCJ5MfHHDrOKpWA0TcWT6eimYU
         UxZctz/XHtkVmh993M6sW4z2EoSSOCax1gPYOonjzcfz8OJjw0XjrH/7PQZjmV2HPSAo
         yEQcXetqTn3Hvr9pjsdhzPcku9/qNFjXFPIl/fPi1Q1VWQX6Cem8N9CWxZQa4gO6EdPv
         hf7BbXp5qoCbC/C8XY3LzsB6qkg8CA6Tao5h9QqmAMV/n6auP1nWqoDeJT+OJlC3R2V0
         oHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741344677; x=1741949477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoJab6aQwdUmHv51fjpmCPB+nAKlS0NjVx82EWhJoYs=;
        b=i/U3uKAnL+Xle3Kzoe4IZAgWWm7y+mHjzPN68TIsk51ZotsXDmU45lLoAQtwzhBsIu
         VKPpZ1cDlhouGPYB7ebxgDu2Pt1XUFEG3s0uiEJvqZ64mBSNOe8E/csUMVE5YAelEKPW
         LfcWtWYmZja2tlUEEXnJfEh5dKHkbRFoWXs4YDqnmqN8LqbhuWXsIGZEaQBr87FpNbWf
         wRUb9tK0LaNbZpfmZsURzZyZIXoucS6iGLVzVsSyJhbVIk84w0eEQ/ErHw70qx6dnCcl
         GiwriC+rzUavIOAKTwgIv0mnI42tFW+XfZIXkOuLXcuQa2fee9P+boPd3doOjxw4L0BC
         e5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWw66qCAdGxc1+sQWOKLmJkr44QOPc9HSv95EXrnU2lT/F2/nrWD1E/ZfMr+MQXgoMoLQ/7Om0y0AUoiC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSIy0Kh9XPgWD+sUanIhyBA3nbsAmow0lKQSp8ESZvHgHgHik
	xNWOtdOWKslDezccTBnbm/EvJCQjlHpr2iFXOJ/9jaDVp1gFOejliXLUER6b20Y=
X-Gm-Gg: ASbGnctMmfa1/KJ09ZVZXq1oMwAAyH5lWNrbNBOu6YENCVArJ7v3h6DJHCmy30E54G9
	XVIZLIirvAQnWov2H+p6gcZWSssESszi2cqd5JIyTeQQClL1rnfOTasTRVTbgLOSKmPH459Jc06
	GQbvKu/dKEf78yKLebuUac3wkNviqCH7bO52u3BRzyzt2PMJWj3soeX3mlzOtu7zOyfy6E8zLO5
	E8opPODh40s7z6euuziQSIHSQSi4z2sQjTMlMHw9+CZRAlnmAoOWnlJxXslgR8qDtr8W/p3UFU1
	0Q0ZaVfY0OSPgKrcMjPf6+nJaekFLTiwjCJk2gWu4q4x1VIUFctRL3g0F9K7RHLwqzOzBBINYfe
	BiyjiHffDxfOM1ZkQTYIpfR3i
X-Google-Smtp-Source: AGHT+IGuTWabfmD5KlWD1Zo2jdScv5WVuOItfBGwPCTPIUUULkXh0GT+oBxIC6TBlHo9j2mbtrr9hA==
X-Received: by 2002:a05:6512:114e:b0:545:5d:a5c7 with SMTP id 2adb3069b0e04-5499043ea30mr1171693e87.21.1741344677083;
        Fri, 07 Mar 2025 02:51:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd069sm450565e87.117.2025.03.07.02.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:51:15 -0800 (PST)
Date: Fri, 7 Mar 2025 12:51:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 drm-dp 2/9] drm/hisilicon/hibmc: Add dp serdes cfg to
 adjust serdes rate, voltage and pre-emphasis
Message-ID: <of75z5hy3pc5wvbd2rzmvpo2wdmap3iraj2vofldg6qeglvl2t@ogiq5nfeh4qe>
References: <20250307101640.4003229-1-shiyongbang@huawei.com>
 <20250307101640.4003229-3-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307101640.4003229-3-shiyongbang@huawei.com>

On Fri, Mar 07, 2025 at 06:16:33PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> This dp controller need features of digital-to-analog conversion and
> high-speed transmission in chip by its extern serdes controller. Our
> serdes cfg is relatively simple, just need two register configurations.
> Don't need too much functions, like: power on/off, initialize, and some
> complex configurations, so I'm not going to use the phy framework.
> This serdes is inited and configured in dp initialization, and also
> integrating them into link training process.
> 
> For rate changing, we can change from 1.62-8.2Gpbs by cfg reg.
> For voltage and pre-emphasis levels changing, we can cfg different
> serdes ffe value.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - fix the serdes cfg in hibmc_dp_serdes_set_tx_cfg(), suggested by Dmitry Baryshkov.
>   - move the dp serdes registers to dp_reg.h, suggested by Dmitry Baryshkov.
>   - 
> v2 -> v3:
>   - add commit log about dp serdes, suggested by Dmitry Baryshkov.
>   - return value in hibmc_dp_serdes_init(), suggested by Dmitry Baryshkov.
>   - add static const in the array of serdes_tx_cfg[], suggested by Dmitry Baryshkov.
>   - change drm_warn to drm_dbg_dp, suggested by Dmitry Baryshkov.
>   - add explanations about dp serdes macros, suggested by Dmitry Baryshkov.
> v1 -> v2:
>   - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
>   - changing all names of dp phy to dp serdes.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |  2 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  5 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   | 23 ++++++
>  .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    | 71 +++++++++++++++++++
>  5 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

