Return-Path: <linux-kernel+bounces-526961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05E6A405B4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FA97ACB5F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF661E7C19;
	Sat, 22 Feb 2025 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnvLlNF6"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E473D17C2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740203408; cv=none; b=CiIxnlWgL166XpPnohZ2Sbp5UKijjoYFqlpyRWPIWsFIHD6iPjaL/CzSg1MHkeVziQv0gXkIjKYeFvnJyQ6nFcXp4NIz3JI75qcDmz27vIaHsUgiErzH0MnqZj51A3hGYa+2RpU7XBvN0xjiz/2iikQyETkCcIBa6pMYhqAb+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740203408; c=relaxed/simple;
	bh=4vE0/sJq//WlIQEoTq9Br7hCms3vpdgp8wxY7RbTnv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE4Vcd+cKveZ7sueGIvNTObiFVGPlg2+xSgQCyKWI6Go1+cnoqRvSueNny7F+V8b6CqYZn9Q27GoZXDc4OUCyiZFyjvCnceAGDN5+iS5t0CCfwtUu7Il3vC45VaRANOQ8wZ1BfLXvCbgr5A8ZPq5JxDyuFIVnuUZ0uUxGBbbO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RnvLlNF6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5452e6f2999so2928533e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740203404; x=1740808204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6yjKnuMHO8ChnHY5F1Gex/5DI4n/mo3dCm3ku50czc=;
        b=RnvLlNF6WHwJaDPkMK4/XS/d7wQJSK8T2bEkWU7jWWBxXaZ/o13VA1pPY6B1V0ICRr
         5klu3vTpb/6QdBz+Qgw6WXBmBvRAYi8PFwzneFgHw4I/+FJRNxEU71YQij+gZze2onO6
         wSiyIZaDVKD5KOt5WlFhfAKU3EYGIGaHHal2zGspK0fKbhMaNw5vZSQaaI/YCqTO1wJW
         T1ckKIc+9qeTVdx/408zCM0OBUgu3fMTXzJRBbNh6INa9TP1wjoGuG11MUnXj3qrrwDK
         PVxju4mmVMFi1rWQfPtTFx/X3MNnHiUgUi9x9EDM/Z2CoRGu45NzJlR3V94bknI9uO3G
         xsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740203404; x=1740808204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6yjKnuMHO8ChnHY5F1Gex/5DI4n/mo3dCm3ku50czc=;
        b=WB+wECr5Z0a8SfVp1RSejfC5QlZhVRrO7KUZgDgloSkDYhYiYFvr5Z+NxO61y9+BlE
         j43soCB90yHHibbWeKvCMTyY+3LQVkRpPIKpFhZAcvp6dcKM/3hyVaETbH7rFpEfPGB5
         QL/G/5svgZ95uFrRbQvPlrFd6WnKBVDSwMyU6ISO6BvcmlKsIvJjBSERFjLIdXHSjxlp
         CS9vYV91js+PD9wu8ToSt9Jt3XFfYkIBbLJzuTsIsJk6ZTvszcjD4Vg+7ix4cliXOQq6
         ZjJG18OFOBNqdrpnpK2xaH2DXDxWwyNkDIZ5dSqQ54aMVNzPCzQ6MwaWLMEF4pvhV64x
         NGeg==
X-Forwarded-Encrypted: i=1; AJvYcCVsZIh0gWO4xzwfqpd8v3798iIqI6zECCi83OWbwMpj1fVDP2CgMqb57suamiD0ZjjqGI53cYY6fSvcEMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6O+1QU8Y692enNyN+SUVO94DOyw33Ama+CQirXQA+JDaW8b2c
	LcrKi11BAbCF6/G1/Ua4+pkWcVMb38lA9eHLJfETFcRVdFzwV1o2saQ/SvjIe38=
X-Gm-Gg: ASbGncsmVfmtMZI2z1EMLyde5MyLNe7tbH/laJH/O+DjfrjlIhcqKZY5esbezpk3Hux
	K3WixNXFnFWH6zugCevkuB2R5PI2k+LwCKE1s6UQvkttuG2aMG47Ifvxzds0JgZgWmXfWVZfHe0
	K8bQR2zH596C9pmw3lSQk7+LI1DTMJ4X9ch6KyDGLMlqgY2TTxXgGa7Qgp8dZbGtqaZaxSu9s5+
	wMnVZCYwU7eR7QbsRT0x6WuHIslQ2kjE49rF/ZxZqdym0zhY1yxnqy+m8SpmJjENKhSp4pnONWQ
	fpi4zxbsAGDO79zvGJR4mHiCh2QyNyQuFEd7ECQcbontUQAnhZGb4zniElAJX/03KYDSbw44NFp
	sxEgmpA==
X-Google-Smtp-Source: AGHT+IFLoVmdWp4L7h5Vs5xxs8pnPvBvxE7+vokTIcIe8KPIF71cYF/paQJ3+EXWPHlqvX+BiYU4mg==
X-Received: by 2002:a05:6512:33d1:b0:545:2271:3108 with SMTP id 2adb3069b0e04-54838f4e823mr1999580e87.38.1740203403901;
        Fri, 21 Feb 2025 21:50:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462f19acbcsm968950e87.30.2025.02.21.21.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:50:02 -0800 (PST)
Date: Sat, 22 Feb 2025 07:50:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 6/8] drm/hisilicon/hibmc: Add colorbar-cfg
 feature and its debugfs file
Message-ID: <gv62rn7uqxplvpe6dqmfg7bypykmekdgv3abwngjcntmb7onhi@bgyfpwzx5kae>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-7-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222025102.1519798-7-shiyongbang@huawei.com>

On Sat, Feb 22, 2025 at 10:50:59AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> DP controller can support generating a color bar signal over the
> DisplayPort interface. This can be useful to check for possible DDR
> or GPU problems, as the signal generator resides completely in the DP
> block. Add debugfs file that controls colorbar generator.
> 
> echo: config the color bar register to display
> cat: print the color bar configuration
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - rewrite the commit log, suggested by Dmitry Baryshkov.
>   - move colorbar debugfs entry to this patch, suggested by Dmitry Baryshkov.
>   - change binary format to integer format, suggested by Dmitry Baryshkov.
> v1 -> v2:
>   - add colorbar introduction in commit, suggested by Dmitry Baryshkov.
>   - splittting colorbar and debugfs in different patches, suggested by Dmitry Baryshkov.
>   - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
>   - using debugfs_init() callback, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  43 ++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  29 +++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |   3 +
>  .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 100 ++++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |   1 +
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   2 +
>  7 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> index 43de077d6769..1f65c683282f 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> -	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o dp/dp_serdes.o hibmc_drm_dp.o
> +	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o dp/dp_serdes.o hibmc_drm_dp.o \
> +	       hibmc_drm_debugfs.o
>  
>  obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index 9d673f431a0e..a921b98dbf50 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -227,3 +227,46 @@ int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode)
>  
>  	return 0;
>  }
> +
> +static const struct hibmc_dp_color_raw g_rgb_raw[] = {
> +	{CBAR_COLOR_BAR, 0x000, 0x000, 0x000},
> +	{CBAR_WHITE,     0xfff, 0xfff, 0xfff},
> +	{CBAR_RED,       0xfff, 0x000, 0x000},
> +	{CBAR_ORANGE,    0xfff, 0x800, 0x000},
> +	{CBAR_YELLOW,    0xfff, 0xfff, 0x000},
> +	{CBAR_GREEN,     0x000, 0xfff, 0x000},
> +	{CBAR_CYAN,      0x000, 0x800, 0x800},
> +	{CBAR_BLUE,      0x000, 0x000, 0xfff},
> +	{CBAR_PURPLE,    0x800, 0x000, 0x800},
> +	{CBAR_BLACK,     0x000, 0x000, 0x000},
> +};
> +
> +void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
> +{
> +	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> +	struct hibmc_dp_color_raw raw_data;
> +
> +	if (cfg->enable) {
> +		hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(9),
> +					 cfg->self_timing);
> +		hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, GENMASK(8, 1),
> +					 cfg->dynamic_rate);
> +		if (cfg->pattern == CBAR_COLOR_BAR) {
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(10), 0);
> +		} else {
> +			raw_data = g_rgb_raw[cfg->pattern];
> +			drm_dbg_dp(dp->drm_dev, "r:%x g:%x b:%x\n", raw_data.r_value,
> +				   raw_data.g_value, raw_data.b_value);
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(10), 1);
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, GENMASK(23, 12),
> +						 raw_data.r_value);
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL1, GENMASK(23, 12),
> +						 raw_data.g_value);
> +			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL1, GENMASK(11, 0),
> +						 raw_data.b_value);
> +		}
> +	}
> +
> +	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(0), cfg->enable);
> +	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
> +}
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 53b6d0beecea..83a53dae8012 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -14,6 +14,33 @@
>  
>  struct hibmc_dp_dev;
>  
> +enum hibmc_dp_cbar_pattern {
> +	CBAR_COLOR_BAR,
> +	CBAR_WHITE,
> +	CBAR_RED,
> +	CBAR_ORANGE,
> +	CBAR_YELLOW,
> +	CBAR_GREEN,
> +	CBAR_CYAN,
> +	CBAR_BLUE,
> +	CBAR_PURPLE,
> +	CBAR_BLACK,
> +};
> +
> +struct hibmc_dp_color_raw {
> +	enum hibmc_dp_cbar_pattern pattern;
> +	u32 r_value;
> +	u32 g_value;
> +	u32 b_value;
> +};
> +
> +struct hibmc_dp_cbar_cfg {
> +	u8 enable;
> +	u8 self_timing;
> +	u8 dynamic_rate; /* 0:static, 1-255(frame):dynamic */
> +	enum hibmc_dp_cbar_pattern pattern;
> +};
> +
>  struct hibmc_dp {
>  	struct hibmc_dp_dev *dp_dev;
>  	struct drm_device *drm_dev;
> @@ -21,10 +48,12 @@ struct hibmc_dp {
>  	struct drm_connector connector;
>  	void __iomem *mmio;
>  	struct drm_dp_aux aux;
> +	struct hibmc_dp_cbar_cfg cfg;
>  };
>  
>  int hibmc_dp_hw_init(struct hibmc_dp *dp);
>  int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode);
>  void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);
> +void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg);
>  
>  #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> index b75ac13a5ead..4c388f633081 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> @@ -67,6 +67,9 @@
>  #define HIBMC_DP_CFG_STREAM_HTOTAL_SIZE		GENMASK(31, 16)
>  #define HIBMC_DP_CFG_STREAM_HBLANK_SIZE		GENMASK(15, 0)
>  
> +#define HIBMC_DP_COLOR_BAR_CTRL			0x260
> +#define HIBMC_DP_COLOR_BAR_CTRL1		0x264
> +
>  #define HIBMC_DP_TIMING_GEN_CONFIG0		0x26c
>  #define HIBMC_DP_CFG_TIMING_GEN0_HACTIVE	GENMASK(31, 16)
>  #define HIBMC_DP_CFG_TIMING_GEN0_HBLANK		GENMASK(15, 0)
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
> new file mode 100644
> index 000000000000..8d050a36946e
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2024 Hisilicon Limited.
> +
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/seq_file.h>
> +#include <linux/pci.h>
> +
> +#include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_debugfs.h>
> +#include <drm/drm_edid.h>
> +
> +#include "hibmc_drm_drv.h"
> +
> +#define MAX_BUF_SIZE 12
> +
> +static ssize_t hibmc_control_write(struct file *file, const char __user *user_buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct hibmc_drm_private *priv = file_inode(file)->i_private;
> +	struct hibmc_dp_cbar_cfg *cfg = &priv->dp.cfg;
> +	int ret, idx;
> +	u8 buf[MAX_BUF_SIZE];
> +
> +	if (count >= MAX_BUF_SIZE)
> +		return -EINVAL;
> +
> +	if (copy_from_user(buf, user_buf, count))
> +		return -EFAULT;
> +
> +	buf[count] = '\0';
> +

There should be at least some documentation on the written values.

> +	if (sscanf(buf, "%hhu %hhu %hhu %u", &cfg->enable, &cfg->self_timing,
> +		   &cfg->dynamic_rate, &cfg->pattern) != 4) {
> +		return -EINVAL;
> +	}
> +
> +	if (cfg->pattern > 9 || cfg->enable > 1 || cfg->self_timing > 1)
> +		return -EINVAL;
> +
> +	ret = drm_dev_enter(&priv->dev, &idx);
> +	if (!ret)
> +		return -ENODEV;
> +
> +	hibmc_dp_set_cbar(&priv->dp, cfg);
> +
> +	drm_dev_exit(idx);
> +
> +	return count;
> +}

-- 
With best wishes
Dmitry

