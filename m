Return-Path: <linux-kernel+bounces-417701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497759D581B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C8F1F2397E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122AC70824;
	Fri, 22 Nov 2024 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+nTzj4E"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2910E5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241571; cv=none; b=TvkgpsUumyEpq1RHTMOgqcRYvhbqy+bqNPn0Z7HF04veEO0hPwyvfBteMP16hooKfHu6H2RiBbRtlQS+QHkzCCA26Uc+1fx1I/n9OHbPHirwMgTx6CVaLoGsaiXEShjJnn9ln+vAKGS5SIS5p4V5PNQs3zeRX4f2ZINCUwTCVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241571; c=relaxed/simple;
	bh=/84x71PtDL3f/SDsrlNVHTLfwfZbZ9HeZh5cdahrjlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OitRgW4OxImJGPEk/QfqRxC7GBYtFZYAGkqCwj7EetcmKuUkAS1rwRleaoftCy1RnNEXzaRKOozOzNgDVqOyeqkyy5rFuwK2yUwYfWCvXflKK7hT64VZDbM/i5DKWfK+0/odiYHSZNZbMhtLOnx97J4gin818idY1mIYsYgBtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+nTzj4E; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539ee1acb86so1732731e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732241567; x=1732846367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMI4s7lzBu8TJFiDvywoRCBHF2QfQJqKCfHy3cjwvsY=;
        b=D+nTzj4EjDu2KA7zM6r38A8KQLZWxheObzZGLxLq8wyLzcPBV4AMZGriQn0a2ic4v+
         O9hEz5GWNSVPE7lh0wfdo7yoiXurdlei7rwXe7sOrmMbpw1dZQM5BW8pPR4MIziE0Khw
         cB5G/Opjt+Cci+P5x475/xR5K/wLuFyPFByYZPBTztFCbhkXfPySr6ySX2UJ9zsSGZdZ
         CzE8FGSktdMCZN1yXmYbeJkbDpuky0bepU/lTj8AvfuTC9wRcTC4I79HG8jQjYOwLEOD
         18+i2NwEywuTwqOpnGA4lsO3JwkvKfqI9Bg55HvOnLQQBaS+Ozyoua+M6alJ7Ny6IkqC
         QwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241567; x=1732846367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMI4s7lzBu8TJFiDvywoRCBHF2QfQJqKCfHy3cjwvsY=;
        b=mDzoUOnjKj2el+777uEyyyhmv2AlNO+/0sPzNbSA1sqrUqXlctcoSIZIsBR8nwrzsV
         ixSA5zTJ/NfmJQ+3ufQ3RnUdI62dqUUfmtfishFVEHncbL5Fxzmvo/2AenKZgbx/5Pte
         jxcmFjS47LsjRIixrygG/RM9oNy2OyGn9B9grvxZLBzNy4drWGLmmJhj8jitqG5qdGlC
         gubc2aCrOntgepWqp7Zzoh8gkhgRup1+pD4Bjj4pqehxH8HEULRzdWrSAgCOWtkg1Aqw
         ugzZP6LSfWLMYMXpoeYPowqUTjoLRB7RA4f8agLb1QV3Lc2MhT+XXMXqZNyB18q2M28M
         UNog==
X-Forwarded-Encrypted: i=1; AJvYcCWKm9h4gxJzG3ID+qDJSDxFnJTuRXRQo8C25mxTcR4Fb/tN5esHFvCU3E5ock2TFz8yEr5FiF9e5xUaFS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd01OveXPUEFiqikBqgLjG4pTuXtbvSnEO+v81JY3NVJsEGfCh
	A4z3jtUnuhyF9v8jISWA5c0f/grC1OuJofngeMALHw+hfSefnzi9Hlsj35ax3BU=
X-Gm-Gg: ASbGnct5LlrSERtxNgh8a5vFFbOTjd4Ev/vV0Vtx+URP1Go241xDY7YxvIheFX9+0Qr
	9r5X1A23VNFo9KWN9BRv42I8LdN34IJT6C8AfcLXbTcsltuXlJKDqEUKVUwPupEsHxYAq/PC10Q
	IFZMHzbvy0P2xc8fwKlGyVWcWmeSQE9fMP4dk476enlbHAsj+TOqv56pS67RuwB0lRzsnsFl88o
	Peoz/mfJ7eZuY36kqD76yjxiToPh37MwPMe2ToR/SNWjI9Y0icxepqgxY3jrK0qnwp6q1/9RkIA
	5Ez2vAU6Yy/HQybL2w5agEXOCjHfUA==
X-Google-Smtp-Source: AGHT+IEdbkozKtzZQZRIlVS3sKJ9qwrOxEcPTavI+YkjKiS0bZynMaaIaHnjQe17X9/8rmJlZL6ztg==
X-Received: by 2002:a05:6512:10ce:b0:53d:d0a5:aaa8 with SMTP id 2adb3069b0e04-53dd36a02c4mr432018e87.13.1732241567243;
        Thu, 21 Nov 2024 18:12:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2489d33sm161664e87.194.2024.11.21.18.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 18:12:45 -0800 (PST)
Date: Fri, 22 Nov 2024 04:12:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 drm-dp 2/5] drm/hisilicon/hibmc: add dp link moduel in
 hibmc
Message-ID: <pnzjjdau4nd43u46dxox5ii2cb3rpxjuoaggg7vjb3d6uk6vq6@vblt6diozau6>
References: <20241118142805.3326443-1-shiyongbang@huawei.com>
 <20241118142805.3326443-3-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118142805.3326443-3-shiyongbang@huawei.com>

On Mon, Nov 18, 2024 at 10:28:02PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Add link training process functions in this moduel.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> Changelog:
> v3 -> v4:
>   - optimizing hibmc_dp_link_get_adjust_train() to delete for loop, suggested by Dmitry Baryshkov.
>   - changing ELNRNG to EIO error code, suggested by Dmitry Baryshkov.
>   - deleting meaningless macro, suggested by Dmitry Baryshkov.
>   - fixing build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202411041559.WIfxRN6n-lkp@intel.com/
> v2 -> v3:
>   - using switchcase in dp_link_reduce_lane, suggested by Dmitry Baryshkov.
>   - deleting dp_link_pattern2dpcd function and using macros directly, suggested by Dmitry Baryshkov.
>   - deleting EFAULT error codes, suggested by Dmitry Baryshkov.
> v1 -> v2:
>   - using drm_dp_* functions implement dp link training process, suggested by Jani Nikula.
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410031735.8iRZZR6T-lkp@intel.com/
>   v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile     |   2 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  24 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 339 +++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h  |   8 +
>  4 files changed, 372 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

