Return-Path: <linux-kernel+bounces-438663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6895D9EA413
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78E1287B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72831EB5B;
	Tue, 10 Dec 2024 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAR+fJct"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514072B9BC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792592; cv=none; b=pvJuaAjpBEYghGxUOXqauImI9m/TyMInghG4NoMCFo/BkEcEdrYUyhqWym51pVVHa5lCalTsR/RH1Fzaq3ocJpFQ1ZOxqv+ds+Rnft7bRr2DO3smoouamUUQjpn78LnJ1mnuWNxMc5l979pX1KK9OJ2q+38UQy6OLTgLvnwNH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792592; c=relaxed/simple;
	bh=4EBLrNo7slfh5LLt28VP+LF0vIoQ0iAaq0SmWJdsc8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah9y+qnTV1xLkWg17pqF4EqNRoZwAy9qhil4dbNeRZmDDv2BNDxMV30Oo8+Xn3leLpOOOxmKjE92NDfL4Amgzp5qhXrPSO+q1zFJLkRaPQPP3hGd9utSqhNNyi+hP55MTm3ESVPkOxF2O1z5JF2CF4cJ/Ee19ZOLC01/XCVyrRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAR+fJct; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso2546970e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 17:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733792588; x=1734397388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wuMOGX85l5nyRxt+UxCQ7JHkxB5r1qM4UgPGN4w1SHo=;
        b=FAR+fJctbZObM190tDQAf0kqzrdKd+/Ikr/Hp1KbyfnSBraTqEcvKmkn3bL3PZiBXA
         HIHtxrfqtdqrSNVWuuXNcTF6xbYXi19X6ZiGiNt9tkibUeb/kZ5C4XJ4lT81kH4SB531
         vXod2FBWM3fUWJwobmvsPuu6lZP9LkJOztJH6MIwXGYRIoiKcUu5agraMV1LMwtt0OOi
         rKEU37SpUuuUynIDCpzCav2uWbNBGaFSMwLlD3zAy/IChFxzm5BbeI9rafrTzFDtmNN/
         SlRzDc+Hm9WY/TJDhIvZQJrX7DIi5vFn0E/quxb98ePLv4BpktDyhSsKZgBbnPmyvGsW
         etOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733792588; x=1734397388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuMOGX85l5nyRxt+UxCQ7JHkxB5r1qM4UgPGN4w1SHo=;
        b=JRX8Fm4WpVKIBuf7KoFctmW9FiK09VCDOkxokyBPz5gXqL4UgjXi2sWMMJUQHd8MMn
         W5yD9ElTGhIOFWjbOqQ4G4XIxwsTcz8hh2ymxl/MhRvkxWvKQP8COP+S9yFWI7tJkpsq
         WrhgM1y+gmDpkf32sU6Spw+/AoMWYdFT0WHfxt6bNLI51/yMaLrk1SLnAAcw4UivAF4Q
         NGXBks+WQ11GhGdOWk5iuDeT/FHypeTO/9jNLOIcDyszUwe6yxfVLLxZZZFzDS0Bz72S
         ESa7VWlBDkGEpSx3QNsJ2WHIJ9RO+bqT+nQsNh4NdgP8m1wsVrYeV5qov4CJWmG4TOmO
         JHPw==
X-Forwarded-Encrypted: i=1; AJvYcCVVOB2dElpRRhaEnXgGlWExPfsbFB6XIOSpxqJKswOJPIgBgsSIY6zTRV3puNLh8IduzjwNr/9wg/A1W2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjdeRB+wuY3dkY3uR5eF5/5ZdrXfuAYyW/yGfbDNREsXC/cS24
	yE52NJ7lATC9fRlq8eHf8YEGvp5MLeyrezJrluPi2OD+rEkMgKvP+mBlKWgcSCk=
X-Gm-Gg: ASbGnctxBfnTBCfMEXUkuBStdRV9uRzCZHxwf3EH0Wm66o0a660vaCx1DSysShVoX2p
	0XsnF1CvTVBxzfZTDCsizDT80SgMSNRCfW9C19+Cg+nQuxmyZl5seHby20ZL49koki2pxKB0Lg0
	WIvfnJm3T938431ATjSULW7AxWgbMn8TNBhRQ7iX6mjPRKJpFQ2KHtLCPbvMUQ+zHzWs4nx4WMF
	CO24fVSxSrFIjrTAB3KUiTyv0RhkTHdt0Dt3GtmxWixpTnuA/+eQZ8sv9oA3hcWahTZo3OOwUJE
	SwVScZvTeVUQwDJipK4Uy3JikzxJSkg3YA==
X-Google-Smtp-Source: AGHT+IE8VzIRsoOMMK5ni+Jq+hPyqKRMlOBk8PtNU6SADe1Jqc+MHdxWquf3NeGRrAWy95PtMn2ddA==
X-Received: by 2002:a05:6512:4005:b0:53e:39ba:fb3b with SMTP id 2adb3069b0e04-540252183cdmr348409e87.21.1733792588450;
        Mon, 09 Dec 2024 17:03:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e34916befsm1143550e87.120.2024.12.09.17.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:03:07 -0800 (PST)
Date: Tue, 10 Dec 2024 03:03:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 drm-dp 2/5] drm/hisilicon/hibmc: add dp link moduel in
 hibmc
Message-ID: <aj6yh5jgxmscmmdt7djbmr6h3bwhelvisoyvkfwfniahwididi@4l2krysjdg7l>
References: <20241209144840.1933265-1-shiyongbang@huawei.com>
 <20241209144840.1933265-3-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209144840.1933265-3-shiyongbang@huawei.com>

On Mon, Dec 09, 2024 at 10:48:37PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Add link training process functions in this moduel.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> Changelog:
> v6 -> v7:
>   - deleteing unset fields in struct hibmc_link_cap, suggested by Dmitry Baryshkov.
>   - using macro instead of constants in hibmc_dp_link_training_configure(), suggested by Dmitry Baryshkov.
> v5 -> v6:
>   - using drm_dbg_dp() to print debug info instead of drm_info(), suggested by Dmitry Baryshkov.
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
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  21 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 329 +++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h  |   8 +
>  4 files changed, 359 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

