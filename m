Return-Path: <linux-kernel+bounces-417661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05DD9D5782
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6BB282F88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79B11BD9DF;
	Fri, 22 Nov 2024 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYqbijaQ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF715CD60
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239737; cv=none; b=S05+supUht5TlHGxDbHYHS3Y1+BWbgTC0PMyg6EZOf2f7DcDG/7lQHktJ0IyNsY5bQttDBJJPm+lag35RsOf2oGAMavGjphtNxItD3gOyu/069FfWgBB3Fj6SWkYybX53tpnSWV01ygVKCil6Iad3Een+i0/J3h5obmdISsuHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239737; c=relaxed/simple;
	bh=T5tCzRJarXh/ghPPl08EEXYi8t76OZicYI6vaQs3AdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsfbTtrfY7lNJTiS7JBIlbyZb6ydlqvxFytm+KyCyuRbVGC7ulPIN5LvYtIATZ6pXtyl/hqQowAyBC0O/cHtLInMWTHN/ZE8ELr1DmKhGuCD/G0BNs6IQhlp1/0I5iTuDAJ9Gcsxu7IJ6fl6lPTmbU3TDyb3DL26nTCA3+Lfa/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYqbijaQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53d9ff92edaso1755636e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732239733; x=1732844533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVsCrs+2Zy1Cw9Biz6G59m8BJmA0z0mEYpX+dAlvRnk=;
        b=pYqbijaQZVUgj0hn5P1ZN18yBpp86I5pWQ+ev7Ze/w8CuYS9ercTjHPizeX5p3CwZv
         fJbN8as9BPx8z1mt1uT6/4VWXFAIAb+7O+BvVbt+0ztr/BzIi9sMv839rEpdr6PssUbH
         0U1ZzSrOkF8mwbOr9tE/ukZ7gzdM9jxQR+TS+0Am1U17OTgLVzKIYmqxW5bRilk3ssZL
         MqzINX+WW+5Yz5F1RkYIzqAMZCBP9Px6MsouOi9Y7NoGwX3ikR0HwIVaVj1Hoq0IQ37X
         cbgOCgJFVaGMrx1Wz8KbGtOjgekm2Ser0L8eP8sDMZ/eK2AZ9mzEymr/Ln6ltR/wD855
         69gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732239733; x=1732844533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVsCrs+2Zy1Cw9Biz6G59m8BJmA0z0mEYpX+dAlvRnk=;
        b=kLLEe9SmR7LoZTv3ps+agESnUJ45Xo9/6bpSyNz5rdQYbcKkF85Sgsq9yAzifVat5S
         u0QON/FLG3kSFLO9iQGawVm9otnoOHIt0/jaBiJGtJGfeYbkukYyd5cyzHOt5o45fPH+
         EU8LBOpFKO81WmoYJF9Zf1gnrCRQWBIvV3PgzU/Nu0ZpIOvWqsDmT9DcO+n0viZbk4Mq
         9IHxT0CYkiXmxBZAgHPRVxThm4rLEv4z+coKswGVvMYBFCmibBfAs5qBFmzWmazq9hqr
         fxSGs8WRGFF5HbMO373/VbBu0yxblRAtTVYAhZHKXcshpL6KWW+Oz3Jy0m2u1lXLP7v+
         t9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCW+LW5xVoEABvd4ildpEzyhFPRvAKALedqnlzCE0VLhgEY3SYy+fekK42XaxHIlZuElY0e8y00WuaLqUIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8DACJ+6Pc6zdYwnaB0dg1s+5gFputYrdkQbJLnfj3yvUs9XX
	WqSq2QWs3/Wi7nnvdQc3jWy9ZGmCWqS6q41Jcj8hS7+9mkJpgaoUBD5JefsAXrI=
X-Gm-Gg: ASbGncthVDeJmMfLh2K8jXFZvQ0QkoWqKY0NMsUrWKc6lalj0eCerqYsIXkRgzVjnfF
	PqsiU4t+a3J0F6qkNY6m+LbYkDblezlqL/wpzpeiqCFj9AjKgHkBPu0irv20n9JFe9UtIFEMRMS
	ryhCgq4VpsEwBFpTuyVY7Zag0G1mzo9S5cjNm1bX74OaUodFgg5D4/48DwIAUFm6BN0CnUgg9Z1
	+5skAv3NJYQrJ0wZ3hlArHrJue1FRlxMuOkLU3vVlAKRXGy3MYVFTwN1HqXZtPGwoBGnYUGYmUn
	MAkB/3gKfmQAOuDCtaZrMrQmLPS6jg==
X-Google-Smtp-Source: AGHT+IHpfDtdPrVUJ86s9RzE+gzLjX2pCHQyP8l5PBeNQbVWR7A9L0or9Vj6WEDx5TVLxd5lYm/wtQ==
X-Received: by 2002:a05:6512:1303:b0:53d:cb7e:225a with SMTP id 2adb3069b0e04-53dd36aa62cmr423873e87.24.1732239733327;
        Thu, 21 Nov 2024 17:42:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2450a7dsm154141e87.59.2024.11.21.17.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 17:42:11 -0800 (PST)
Date: Fri, 22 Nov 2024 03:42:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 drm-dp 1/5] drm/hisilicon/hibmc: add dp aux in hibmc
Message-ID: <augqwu7iv42ges4x53ysulbfv43x6hadku7rgwjlscelsx5iwk@xmpeutszvjev>
References: <20241118142805.3326443-1-shiyongbang@huawei.com>
 <20241118142805.3326443-2-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118142805.3326443-2-shiyongbang@huawei.com>

On Mon, Nov 18, 2024 at 10:28:01PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Add dp aux read/write functions. They are basic functions
> and will be used later.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v4 -> v5:
>   - fixing build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202411131438.RZWYrWTE-lkp@intel.com/
> v3 -> v4:
>   - retun error codes in  result incorrect branch, suggested by Dmitry Baryshkov.
>   - replacing all ret= with returns, suggested by Dmitry Baryshkov.
>   - moving the comment below the judgment statement, suggested by Dmitry Baryshkov.
>   - moving definations to the source file and clearing headers, suggested by Dmitry Baryshkov.
>   - reanaming dp_prefix to hibmc_dp_prefix, suggested by Dmitry Baryshkov.
>   - changing hibmc_dp_reg_write_field to static inline and lock, suggested by Dmitry Baryshkov.
>   - moving some structs to later patch, suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - put the macro definations in latter patch where they are actually used, suggested by Dmitry Baryshkov.
>   - rename some macro definations to make them sensible, suggested by Dmitry Baryshkov.
>   - using FIELD_PREP and FIELD_GET, suggested by Dmitry Baryshkov.
>   - using DP_DPCD_REV_foo, suggested by Dmitry Baryshkov.
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410250305.UHKDhtxy-lkp@intel.com/
> v1 -> v2:
>   - using drm_dp_aux frame implement dp aux read and write functions, suggested by Jani Nikula.
>   - using drm dp header files' dp macros instead, suggested by Andy Yan.
>   v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile     |   3 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c  | 164 +++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  38 +++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h  |  27 +++
>  4 files changed, 231 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> index d25c75e60d3d..8770ec6dfffd 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o
> +hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> +	       dp/dp_aux.o
>  
>  obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
> new file mode 100644
> index 000000000000..16bdfefbf255
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0-or-laterHIBMC_BYTES_IN_U32
> +// Copyright (c) 2024 Hisilicon Limited.
> +
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/minmax.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_print.h>
> +#include "dp_comm.h"
> +#include "dp_reg.h"
> +
> +#define HIBMC_AUX_CMD_REQ_LEN		GENMASK(7, 4)
> +#define HIBMC_AUX_CMD_ADDR		GENMASK(27, 8)
> +#define HIBMC_AUX_CMD_I2C_ADDR_ONLY	BIT(28)
> +#define HIBMC_BYTES_IN_U32		4
> +#define HIBMC_AUX_I2C_WRITE_SUCCESS	0x1
> +#define HIBMC_DP_MIN_PULSE_NUM		0x9
> +#define BITS_IN_U8			8
> +
> +static inline void hibmc_dp_aux_reset(struct hibmc_dp_dev *dp)
> +{
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_DPTX_RST_CTRL, HIBMC_DP_CFG_AUX_RST_N, 0x0);
> +	usleep_range(10, 15);
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_DPTX_RST_CTRL, HIBMC_DP_CFG_AUX_RST_N, 0x1);
> +}
> +
> +static void hibmc_dp_aux_read_data(struct hibmc_dp_dev *dp, u8 *buf, u8 size)
> +{
> +	u32 reg_num;
> +	u32 value;
> +	u32 num;
> +	u8 i, j;
> +
> +	reg_num = DIV_ROUND_UP(size, HIBMC_BYTES_IN_U32);
> +	for (i = 0; i < reg_num; i++) {
> +		/* number of bytes read from a single register */
> +		num = min(size - i * HIBMC_BYTES_IN_U32, HIBMC_BYTES_IN_U32);
> +		value = readl(dp->base + HIBMC_DP_AUX_RD_DATA0 + i * HIBMC_BYTES_IN_U32);
> +		/* convert the 32-bit value of the register to the buffer. */
> +		for (j = 0; j < num; j++)
> +			buf[i * HIBMC_BYTES_IN_U32 + j] = value >> (j * BITS_IN_U8);
> +	}
> +}
> +
> +static void hibmc_dp_aux_write_data(struct hibmc_dp_dev *dp, u8 *buf, u8 size)
> +{
> +	u32 reg_num;
> +	u32 value;
> +	u32 num;
> +	u8 i, j;
> +
> +	reg_num = DIV_ROUND_UP(size, HIBMC_BYTES_IN_U32);
> +	for (i = 0; i < reg_num; i++) {
> +		/* number of bytes written to a single register */
> +		num = min_t(u8, size - i * HIBMC_BYTES_IN_U32, HIBMC_BYTES_IN_U32);
> +		value = 0;
> +		/* obtain the 32-bit value written to a single register. */
> +		for (j = 0; j < num; j++)
> +			value |= buf[i * HIBMC_BYTES_IN_U32 + j] << (j * BITS_IN_U8);
> +		/* writing data to a single register */
> +		writel(value, dp->base + HIBMC_DP_AUX_WR_DATA0 + i * HIBMC_BYTES_IN_U32);
> +	}
> +}
> +
> +static u32 hibmc_dp_aux_build_cmd(const struct drm_dp_aux_msg *msg)
> +{
> +	u32 aux_cmd = msg->request;
> +
> +	if (msg->size)
> +		aux_cmd |= FIELD_PREP(HIBMC_AUX_CMD_REQ_LEN, (msg->size - 1));
> +	else
> +		aux_cmd |= FIELD_PREP(HIBMC_AUX_CMD_I2C_ADDR_ONLY, 1);
> +
> +	aux_cmd |= FIELD_PREP(HIBMC_AUX_CMD_ADDR, msg->address);
> +
> +	return aux_cmd;
> +}
> +
> +/* ret >= 0, ret is size; ret < 0, ret is err code */
> +static int hibmc_dp_aux_parse_xfer(struct hibmc_dp_dev *dp, struct drm_dp_aux_msg *msg)
> +{
> +	u32 buf_data_cnt;
> +	u32 aux_status;
> +
> +	aux_status = readl(dp->base + HIBMC_DP_AUX_STATUS);
> +	msg->reply = FIELD_GET(HIBMC_DP_CFG_AUX_STATUS, aux_status);
> +
> +	if (aux_status & HIBMC_DP_CFG_AUX_TIMEOUT)
> +		return -ETIMEDOUT;
> +
> +	/* only address */
> +	if (!msg->size)
> +		return 0;
> +
> +	if (msg->reply != DP_AUX_NATIVE_REPLY_ACK)
> +		return -EIO;
> +
> +	buf_data_cnt = FIELD_GET(HIBMC_DP_CFG_AUX_READY_DATA_BYTE, aux_status);
> +
> +	switch (msg->request) {
> +	case DP_AUX_NATIVE_WRITE:
> +		return msg->size;
> +	case DP_AUX_I2C_WRITE | DP_AUX_I2C_MOT:
> +		if (buf_data_cnt == HIBMC_AUX_I2C_WRITE_SUCCESS)
> +			return msg->size;
> +		else
> +			return FIELD_GET(HIBMC_DP_CFG_AUX, aux_status);
> +	case DP_AUX_NATIVE_READ:
> +	case DP_AUX_I2C_READ | DP_AUX_I2C_MOT:
> +		buf_data_cnt--;
> +		if (buf_data_cnt != msg->size) {
> +			/* only the successful part of data is read */
> +			return -EBUSY;
> +		}
> +
> +		/* all data is successfully read */
> +		hibmc_dp_aux_read_data(dp, msg->buffer, msg->size);
> +		return msg->size;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/* ret >= 0 ,ret is size; ret < 0, ret is err code */
> +static ssize_t hibmc_dp_aux_xfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
> +{
> +	struct hibmc_dp_dev *dp = container_of(aux, struct hibmc_dp_dev, aux);
> +	u32 aux_cmd;
> +	int ret;
> +	u32 val; /* val will be assigned at the beginning of readl_poll_timeout function */
> +
> +	writel(0, dp->base + HIBMC_DP_AUX_WR_DATA0);
> +	writel(0, dp->base + HIBMC_DP_AUX_WR_DATA1);
> +	writel(0, dp->base + HIBMC_DP_AUX_WR_DATA2);
> +	writel(0, dp->base + HIBMC_DP_AUX_WR_DATA3);
> +
> +	hibmc_dp_aux_write_data(dp, msg->buffer, msg->size);
> +
> +	aux_cmd = hibmc_dp_aux_build_cmd(msg);
> +	writel(aux_cmd, dp->base + HIBMC_DP_AUX_CMD_ADDR);
> +
> +	/* enable aux transfer */
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_REQ, 0x1);
> +	ret = readl_poll_timeout(dp->base + HIBMC_DP_AUX_REQ, val,
> +				 !(val & HIBMC_DP_CFG_AUX_REQ), 50, 5000);
> +	if (ret) {
> +		hibmc_dp_aux_reset(dp);
> +		return ret;
> +	}
> +
> +	return hibmc_dp_aux_parse_xfer(dp, msg);
> +}
> +
> +void hibmc_dp_aux_init(struct hibmc_dp_dev *dp)
> +{
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_SYNC_LEN_SEL, 0x0);
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_TIMER_TIMEOUT, 0x1);
> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_MIN_PULSE_NUM,
> +				 HIBMC_DP_MIN_PULSE_NUM);
> +
> +	dp->aux.transfer = hibmc_dp_aux_xfer;
> +	dp->aux.is_remote = 0;
> +	drm_dp_aux_init(&dp->aux);
> +}
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> new file mode 100644
> index 000000000000..ce3b6fa4ea9e
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (c) 2024 Hisilicon Limited. */
> +
> +#ifndef DP_COMM_H
> +#define DP_COMM_H
> +
> +#include <linux/types.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/kernel.h>
> +#include <linux/bitfield.h>
> +#include <linux/io.h>
> +#include <drm/display/drm_dp_helper.h>
> +
> +struct hibmc_dp_dev {
> +	struct drm_dp_aux aux;
> +	struct drm_device *dev;
> +	void __iomem *base;
> +	struct mutex lock; /* protects concurrent RW in hibmc_dp_reg_write_field() */
> +};
> +
> +#define dp_field_modify(reg_value, mask, val) ({		\
> +	(reg_value) &= ~(mask);					\
> +	(reg_value) |= FIELD_PREP(mask, val); })

do { ... } while (0) or static inline. Or just inline into the calling
function, if there is just one place where it is used.

> +
> +#define hibmc_dp_reg_write_field(dp, offset, mask, val) ({	\
> +	typeof(dp) _dp = dp;					\
> +	typeof(_dp->base) addr = (_dp->base + (offset));	\
> +	mutex_lock(&_dp->lock);					\
> +	u32 reg_value = readl(addr);				\
> +	dp_field_modify(reg_value, mask, val);			\
> +	writel(reg_value, addr);				\
> +	mutex_unlock(&_dp->lock); })

I'd prefer a static inline function. Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +
> +void hibmc_dp_aux_init(struct hibmc_dp_dev *dp);
> +
> +#endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> new file mode 100644
> index 000000000000..f3e6781e111a
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (c) 2024 Hisilicon Limited. */
> +
> +#ifndef DP_REG_H
> +#define DP_REG_H
> +
> +#define HIBMC_DP_AUX_CMD_ADDR			0x50
> +#define HIBMC_DP_AUX_WR_DATA0			0x54
> +#define HIBMC_DP_AUX_WR_DATA1			0x58
> +#define HIBMC_DP_AUX_WR_DATA2			0x5c
> +#define HIBMC_DP_AUX_WR_DATA3			0x60
> +#define HIBMC_DP_AUX_RD_DATA0			0x64
> +#define HIBMC_DP_AUX_REQ			0x74
> +#define HIBMC_DP_AUX_STATUS			0x78
> +#define HIBMC_DP_DPTX_RST_CTRL			0x700
> +
> +#define HIBMC_DP_CFG_AUX_SYNC_LEN_SEL		BIT(1)
> +#define HIBMC_DP_CFG_AUX_TIMER_TIMEOUT		BIT(2)
> +#define HIBMC_DP_CFG_AUX_MIN_PULSE_NUM		GENMASK(13, 9)
> +#define HIBMC_DP_CFG_AUX_REQ			BIT(0)
> +#define HIBMC_DP_CFG_AUX_RST_N			BIT(4)
> +#define HIBMC_DP_CFG_AUX_TIMEOUT		BIT(0)
> +#define HIBMC_DP_CFG_AUX_READY_DATA_BYTE	GENMASK(16, 12)
> +#define HIBMC_DP_CFG_AUX			GENMASK(24, 17)
> +#define HIBMC_DP_CFG_AUX_STATUS			GENMASK(11, 4)
> +
> +#endif
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

