Return-Path: <linux-kernel+bounces-512099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759BBA33400
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F26188A4B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437FD282F1;
	Thu, 13 Feb 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pztzV6t7"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E71E52D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406748; cv=none; b=tEGw70KS7YB5SrwnMvhwxu5LsQz+pCDYMh9QmlCIDF4F08EpL82Tt8eu0wsIMTaI/shCXOLvDLkFX5K9zma4etcv/e256oxBs1cSNFbj2aUes4iu4J4Bo3o5XKtrqmcEbDar+3BQUphJa30yxuGh3lkKmD+4l9zvyK3oOgp/EYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406748; c=relaxed/simple;
	bh=Kn4zM7b3EPE6Ji1OEBauBV1QiTYJkX+ASHAkrM4NuUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEXu4lJaASmrx3CkWKkidPR8TRQFOaMTbfrxcJ4LsOeqvCY0S5IMM6mEQTh2DJ+1DJCuoGVctB9DCo6xlDvwYs2/dQM6aPJWS7RImrJqpjQDrWt0efzcmKxn4zW+2Pl/Fi+vgdpLOWHnxyZZxmy+SPj+9jp8NfcXCfw3xcrMnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pztzV6t7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-308f53aef4fso3093291fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739406744; x=1740011544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zHhZW0PtiVglVCQQ6HaP/ZxVchC1gguQ+ErerQXn0c=;
        b=pztzV6t7Mzi1p2BPXS+wZrY6SZEdRZC1iheujsx/RyNQr9E+diCfZG3eQPQb9iHByu
         356rvJzd5O0d6UTKslnek5OKsBHfdQ9cMwxobZ4yrXrYSAQtrt4Pbv7Vy06Ct628W5Vs
         IX9FU7g+z7cd7w0gVgt7cBJyL5Igb3rjczoG8cSkycZPKYcE64/i+qrcf3+g4/GpbfC4
         FXT0nsNbhF8fBqe49NMmV1lAHM0C+CAX/YuV0S6Xjz8z7vLh8yKi7w97KIxhic1JOUr0
         W3T0Ppd7pwhZiYPb9uLh1k2hgARBW7p+D3rwbpf+wKSkhsAynXNGeZif6fO5JieB39+t
         Tw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739406744; x=1740011544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zHhZW0PtiVglVCQQ6HaP/ZxVchC1gguQ+ErerQXn0c=;
        b=pfbsayBLtOeyb3aHQcgwMLvtS3dbE/3OavZ9Rjzjq2w7jyOB6f9sGNSo27/OsWq8dn
         5StFRod0uAszxOP9iiVkb92QNVcKRhVCL2ojh/KjOj4FLIYs03+/oetaXYBzbHEiGTeR
         pqlziY+TU/kE78wqUnvNU12xje5P4elhG7GLbHzdeSmskv6NtmC5n7ceQjqaGh4rJ6pX
         LF7GrZNIzDmuqJ1PVfvGEylw4KokF2M7rwPOfJFZDkXRPlJmSJkw5UqmM+zncWUHN9IW
         Rx8r6j7EA/FhL5vR4b6mW+xqrG436E3VX/To1nzKxR9C09G7fCJM5AF6q11Fqho60thU
         Hs3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuXTkBK6KqivxazHJby6MVftPd5c0ez2RJYloJNTavnhsTuwlt58rLc3CtUCdn4ofPaoIwZtLEQA38ctc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZbcuk+7wb6ETAEDWM35glDkVgLUPSabI2mKp/Ut/LbUyucQT
	9+XMpb6iWyg7RmPP6Yq9/wi9HQkbLLIdGVy2Z6rbxKVrYOaroefzgF7uQoCeq8M=
X-Gm-Gg: ASbGncuYQ89hqrFWWGvQW3VjTUs+wtsWLfscyHAOcDUIqoJ14Ojwby4ojEcrpYCCum1
	V3s3+qQK2e7Tf67MXhFt2Zuv2ZefkNteWF7DeuW+zqJj3/4vqOc7adR37iuvLWYdS9G062U2NVF
	BHAyRlliQcucG5Fxce1YEmrpe9VqX06xSqpFew9qNyCQ336GjWeDLws5+LQ3Ep5Nmk88OLGokHF
	dKZ2ry9zesIBeLner2NMK+oESs+KyXR4lDN6rOw7wHWz8oC8HFsMevfgU3cI64d4aejTAjrzqjR
	t56oP3JBedX0Af5+J9S4H8BFSWoLdZE5LP/0lIBEQO40tCSVvHFbqAVqc/QeHqWMEhcN+JQ=
X-Google-Smtp-Source: AGHT+IEArsUcvVPeYrZBwxnDDl7vuZk0nY8nJEpvr5fdwgUL8uWe2QI+7plrNZeEdVTvnOM7l92iSA==
X-Received: by 2002:a05:651c:19a3:b0:302:2cdf:7fbb with SMTP id 38308e7fff4ca-3090362f7e6mr18558401fa.6.1739406744269;
        Wed, 12 Feb 2025 16:32:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091029b34asm369751fa.97.2025.02.12.16.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:32:23 -0800 (PST)
Date: Thu, 13 Feb 2025 02:32:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 drm-dp 6/7] drm/hisilicon/hibmc: Add drm debugfs
 functions
Message-ID: <afi5npgvnrp56oufhc7576auya26lbwgu377dprddode2kp3sb@u5ctx4o22w4v>
References: <20250210144959.100551-1-shiyongbang@huawei.com>
 <20250210144959.100551-7-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210144959.100551-7-shiyongbang@huawei.com>

On Mon, Feb 10, 2025 at 10:49:58PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> We use the previous two patches as our debug functions and
> generate two files. "hibmc-dp" and "color-bar".
> hibmc-dp: read only, print the dp link status and dpcd version

Please define a generic DP attribute for this, handle it in
drm_dp_helper.c. Other drivers then can reuse this debugfs file.
Also note drm_dp_downstream_debug(), it might also be helpful.
Also see msm_dp_debug_show() for inspiration

> color-bar: read/write
>            write: cfg color bar and enable/disable it by your input
>            read: print your current cfg info of color-bar

This really should go into your color-bar patch.

> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>   - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
>   - using debugfs_init() callback, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
>  .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 124 ++++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |   1 +
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   2 +
>  4 files changed, 129 insertions(+), 1 deletion(-)
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
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
> new file mode 100644
> index 000000000000..af2efb70d6ea
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
> @@ -0,0 +1,124 @@
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
> +static int hibmc_dp_show(struct seq_file *m, void *arg)
> +{
> +	struct drm_info_node *node = m->private;
> +	struct drm_device *dev = node->minor->dev;
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> +	int idx;
> +
> +	if (!drm_dev_enter(dev, &idx))
> +		return -ENODEV;
> +
> +	seq_printf(m, "enable lanes: %u\n", hibmc_dp_get_lanes(&priv->dp));
> +	seq_printf(m, "link rate: %d\n", hibmc_dp_get_link_rate(&priv->dp) * 27);
> +	seq_printf(m, "dpcd version: 0x%x\n", hibmc_dp_get_dpcd(&priv->dp));
> +
> +	drm_dev_exit(idx);
> +
> +	return 0;
> +}
> +
> +static ssize_t hibmc_control_write(struct file *file, const char __user *user_buf,
> +				   size_t size, loff_t *ppos)
> +{
> +	struct hibmc_drm_private *priv = file_inode(file)->i_private;
> +	struct hibmc_dp_cbar_cfg *cfg = &priv->dp.cfg;
> +	u32 input = 0;
> +	int ret, idx;
> +	u8 val;
> +
> +	ret = kstrtou32_from_user(user_buf, size, 0, &input);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_GET(GENMASK(13, 10), input);
> +	if (val > 9)
> +		return -EINVAL;
> +	cfg->pattern = val;
> +	cfg->enable = FIELD_GET(BIT(0), input);
> +	cfg->self_timing = FIELD_GET(BIT(1), input);
> +	cfg->dynamic_rate = FIELD_GET(GENMASK(9, 2), input);

Having a binary file format is really a sad idea. Can it be a text file
instead?

> +
> +	ret = drm_dev_enter(&priv->dev, &idx);
> +	if (!ret)
> +		return -ENODEV;
> +
> +	hibmc_dp_set_cbar(&priv->dp, cfg);
> +
> +	drm_dev_exit(idx);
> +
> +	return size;
> +}
> +

-- 
With best wishes
Dmitry

