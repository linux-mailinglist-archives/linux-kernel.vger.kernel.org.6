Return-Path: <linux-kernel+bounces-434073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AECAF9E6142
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F6918857F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A11CDA1A;
	Thu,  5 Dec 2024 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njRqkMXx"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810001CDA14
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441155; cv=none; b=VhyVd+0LNuzm6cqfBcXgVIP3UXI2m1iVIsBQ8FOWIK2auv19UjcdVihi4VGQEVbraQObZm7IVCWTjAUr8EVcJjF1riwn+/M0RMthZ+FP5nB2us6PmBIjn3l5UbxYaBgZRcwsW9Cqkek8WRRFH6OoKIYsuhenWv9bmeaqUkLJvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441155; c=relaxed/simple;
	bh=BnD8a+g9O1wBFgFQ6cYDTV/dHBnmQb5HB5WKHtqp6lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twJT03zpYVPTvHhI3+VxqlNOvuA3Pedif859yZ2OT5L6WCDSsy5p8vW3QbU/O3SIKVx+xfVlUBaJwDefHqSGp3l9SCTqPxIiQbjOaJYj8prbviQPbQUcMbxMMtfIVgGs9FYto7lwZ1du+5v6/Ll08h49i0tZyIP0BEe8FG8fQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=njRqkMXx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffe2700e91so13463701fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 15:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733441151; x=1734045951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FlG7yhfNag0hwET+zB1Fq/KrhhKmeA4urtrBHSuoPE=;
        b=njRqkMXxkKjTGrERmtS7SSL6coSVP5OuclUtj5QruHDt3E5zeDjMEgeDr+0KbMJsN0
         Gf1ESMqmipv8EOM1ZTRs6QudtHSFrvUWYba/Lh58qjUywod4y98GyvdJVW4TxVRnyo9B
         N8aY0vptdS4Fd0NfTyrxclFGQE28m7MFkMUZthveM9/VexSo/UhUKDP/SCPhZv1SFd2f
         vrB6Ae5iC+3Ss+xF5LlGi9mSRFHyl+FBKSyoohIzTST+fbWhXr2pzA6SQwUucPXEnu6L
         ZakmsXJvJkeF52MbvZI2fBAlYVJs/4lPn5RpYoKrsTlSo/qWp0f06u6OYlWjTp2UIQ7r
         +nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733441151; x=1734045951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FlG7yhfNag0hwET+zB1Fq/KrhhKmeA4urtrBHSuoPE=;
        b=stSF6bTj2e4SNqCkRfcpjaQeRbd6y1iPq1kUBtFH9IjBs6yw39RXl7H8NK/tpzp2p8
         ab2Ng17VO7TMS/3SMDumVbOPGHsQmccuL6VskYiItoTjOvXMXPCuT0KqkWg49MrO4BaJ
         eR3hAnBsOgx6gl2c2TuFHpn/rrJiYKEmuoph2fnhAqO4mqdswMQTNVOlflPVTTXGk4ow
         GamImwQbWL2fbPgCEmxVIWyIpN1Qcc7QIEF+BF1CeXd0SZ80HkaWopdF/eZZXJvxSmQV
         SL2kmXA/mam/yk7qAPPJVtVeTVS88yUMwklSrOI4W26avpdlosVcmzYSdN4qMaYMizxp
         UA9A==
X-Forwarded-Encrypted: i=1; AJvYcCWG/TxuqVvXHiEWMcX3R7LOefQIsyM6KJvaCRwGEF4MLtDIrcudYctfjQKwr8+leotoAMxJGEuM8VrAQ5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTq8gbrxlsMUVmYdHn7damTB+AnMLWVAKEbMEef9id36FQ00cK
	UicS5fYMSfOojaN2JLp1uIDBhQcVGdJCekj06DGRlWEk7kCS8Beu2/2xcrDGGks=
X-Gm-Gg: ASbGncueo6K74uzI77XXbKkxHXUE1MGA1+i+m2zMoEZ94MkHKFc5nG+GaspfFP/46PX
	LWIEFydqPIA6piyZHPJtAw/jyX5bGpJyTR+bVWTC/iSguvTwA2QICXrZTDC45aZJThSyhDVH+xh
	fS8mn/7+ovyHiOUgoNN3aJwedtsxCvWC/WPy6zuWbOA+Iba4JZ0vqQXhTIqb5vx1iBrbxltITw8
	0XNI7N7P7k49loRzxparizWpqtw8q5s3MQnTBmQ2pqIUykNsdw6/zgsmse/PICKo19V4b4SdUNv
	o9Nyjbo+KEEJL9d90u+ftx3Hfi4viQ==
X-Google-Smtp-Source: AGHT+IG3QMXw/m+7lHuXqEEDNuL02EQbGHmtd5Y4ORCYfaK/60JwZdmYAuv6er8IN52O8KWaJeqlHQ==
X-Received: by 2002:a05:651c:211a:b0:300:1dbd:b248 with SMTP id 38308e7fff4ca-3002f688966mr2145701fa.4.1733441151391;
        Thu, 05 Dec 2024 15:25:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020da2637sm3142481fa.39.2024.12.05.15.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:25:50 -0800 (PST)
Date: Fri, 6 Dec 2024 01:25:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 drm-dp 2/5] drm/hisilicon/hibmc: add dp link moduel in
 hibmc
Message-ID: <yyunb5oxzlmrrcxlsrub4j7iwwpaptbvubbtxr3omjftietc5b@3tfg2ldxeaoa>
References: <20241202131322.1847078-1-shiyongbang@huawei.com>
 <20241202131322.1847078-3-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202131322.1847078-3-shiyongbang@huawei.com>

On Mon, Dec 02, 2024 at 09:13:19PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Add link training process functions in this moduel.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> Changelog:
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
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  24 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 339 +++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h  |   8 +
>  4 files changed, 372 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> index 8770ec6dfffd..94d77da88bbf 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> -	       dp/dp_aux.o
> +	       dp/dp_aux.o dp/dp_link.o
>  
>  obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> index 7d3cd32393c0..8422999acbf0 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> @@ -13,11 +13,34 @@
>  #include <linux/io.h>
>  #include <drm/display/drm_dp_helper.h>
>  
> +#define HIBMC_DP_LANE_NUM_MAX 2
> +
> +struct hibmc_link_status {
> +	bool clock_recovered;
> +	bool channel_equalized;
> +};
> +
> +struct hibmc_link_cap {
> +	int rx_dpcd_revision;
> +	u8 link_rate;
> +	u8 lanes;
> +	bool is_tps3;
> +	bool is_tps4;

These two fields are set neither in this patch nor in any of the
following patches.

> +};
> +

[...]

> +static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
> +{
> +	u8 buf[2];
> +	int ret;
> +
> +	/* DP 2 lane */
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_PHYIF_CTRL0, HIBMC_DP_CFG_LANE_DATA_EN,
> +				 dp->link.cap.lanes == 0x2 ? 0x3 : 0x1);
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_DPTX_GCTL0, HIBMC_DP_CFG_PHY_LANE_NUM,
> +				 dp->link.cap.lanes == 0x2 ? 0x1 : 0);
> +
> +	/* enhanced frame */
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_CTRL, HIBMC_DP_CFG_STREAM_FRAME_MODE, 0x1);
> +
> +	/* set rate and lane count */
> +	buf[0] = dp->link.cap.link_rate;
> +	buf[1] = DP_LANE_COUNT_ENHANCED_FRAME_EN | dp->link.cap.lanes;
> +	ret = drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, buf, sizeof(buf));
> +	if (ret != sizeof(buf)) {
> +		drm_dbg_dp(dp->dev, "dp aux write link rate and lanes failed, ret: %d\n", ret);
> +		return ret >= 0 ? -EIO : ret;
> +	}
> +
> +	/* set 8b/10b and downspread */
> +	buf[0] = 0x10;

DP_SPREAD_AMP_0_5

> +	buf[1] = 0x1;

DP_SET_ANSI_8B10B

> +	ret = drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, buf, sizeof(buf));
> +	if (ret != sizeof(buf)) {
> +		drm_dbg_dp(dp->dev, "dp aux write 8b/10b and downspread failed, ret: %d\n", ret);
> +		return ret >= 0 ? -EIO : ret;
> +	}
> +
> +	ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
> +	if (ret)
> +		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
> +
> +	return ret;
> +}
> +

-- 
With best wishes
Dmitry

