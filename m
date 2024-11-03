Return-Path: <linux-kernel+bounces-393768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 977219BA4FF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F48B20849
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E03A15854D;
	Sun,  3 Nov 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+MdWuDL"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8D8614E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730627343; cv=none; b=ZoOR0Yq0xjNXL0DuftPxi7mZoGWaGdorHZ6zBZTSiqV86IeolSd8AgxBWVaDfh136iS29DR9GJmN6VZ+FMMH+rzlc1JK7B03Wt4V15YjzamB0lbs0MSYS0/gGkTAcdX5BP/L9FGXZ+r4UGvJ6ILRZjsx0eDc37rKPGBo8b8acpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730627343; c=relaxed/simple;
	bh=M/uRVqerR+iqtNXYAY9CAImK4cPXzfFrQ1napnQuaP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqcRD7TjmPPMw0UsvPjaMAdHpiXHiskKkiXevFohEfZphVh+vSR/6xvV0IzuyIq3lFMIAK72Rn6sAXTKOpINprEYsv+XS96ceUMK5mGlFmouUsJzqa5Ya5i7M6lo9OTMzfFNtrQbA8TcUDH8aR2DHZtjhCTC/oDFUaE7mRbcKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X+MdWuDL; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb518014b9so26611091fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730627339; x=1731232139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIJE9L6gu42T+79PaSKm3Z5K4ArgGJ9WIqn6MUqVxu0=;
        b=X+MdWuDL7a6UTtzD4SzCy6JNVN58cGVQfVPHCsfO67LcB630MB4UO6iLrl5UDTBiNd
         6KBdNNELosEk9XxHjzfzr4EZfk4GF9sUPJE5ZVjINuz5rtlusti4Oq1WA0HHzRdoRAJo
         DCLI+YQRbV66Hh+0ERH6A5K9TwimSPYDusBl+CxMcK1D/Xkdt84+SF7CU7Ug9+q1LYNG
         zsPuCNfqmh2195lRjC2ih7NKbmGU5eG8PreZ4MCC03oazSuLYIZ15eZFFii1ZrgItAel
         1RMRoqShvjysj5min8nkhbHQAkNlPR8U+viTP3jqBX3chhUBbqv+3KL62jvqFRuSSdov
         J5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730627339; x=1731232139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIJE9L6gu42T+79PaSKm3Z5K4ArgGJ9WIqn6MUqVxu0=;
        b=FMeFPCOExexCdKUMPztYpVSqtvZGsNGlMPBB3SstQxosad6mZympM23wAZphVjjmZN
         gMJCDyGdW8jQPYxt7daBYHXC4QjloL1r4NitUpPKCbmeyI1AUMkYsKue9I/5LVBMq4+g
         13fvPZ0id48MzL1SomIUKJf9tyXUBgHRInXg0X5WD8rBiEX7/KpBFlsAgKfY5tL32li3
         a49xrlmi1V/v/VV+bmRSLcFoGYqpTzDtN6Gel7bCBHgjr6XULCX8PNO2/5XlrhVYqsoi
         hJ5ur43EBNjwMMsCoRbTtmYiTpBJsTKWv+/kRsJ//bmukv12/NkjgmPHbDhbJylDQEez
         +3qA==
X-Forwarded-Encrypted: i=1; AJvYcCXAY4dx4CUB9mR4mZvSVKJozJgYhPATEAoG9kn61Fi/KOebSRr/snMLghzpIVvPuAzXFAl0ke/Otti80Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBk7//VBQbOwjPK9nRKt7PpHLOyGGEtSf6OP2GvU2ImcV4TEML
	zWa9qTJ0xNZKjFoMKBPYMhl8F9jKUM+wLW13GVfP5o8uLfQssEM28ocM96a6ai8=
X-Google-Smtp-Source: AGHT+IFz3iTY3pfntO/DFktbyYy7NFUehgacXTxOuZ6u+J/KbVQB5c0l3TGEpS7n/VxVYHCAfNaBbg==
X-Received: by 2002:a2e:f12:0:b0:2fa:dc24:a346 with SMTP id 38308e7fff4ca-2fcbdfbab66mr105268121fa.21.1730627336888;
        Sun, 03 Nov 2024 01:48:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3bbea1sm12420901fa.24.2024.11.03.01.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:48:55 -0800 (PST)
Date: Sun, 3 Nov 2024 11:48:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 drm-dp 1/4] drm/hisilicon/hibmc: add dp aux in hibmc
Message-ID: <ainzxaeea5bnxogaudypijz2wv6z4ev2wnlmcxniw2a27ab3yt@54cexnmypxab>
References: <20241101105028.2177274-1-shiyongbang@huawei.com>
 <20241101105028.2177274-2-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101105028.2177274-2-shiyongbang@huawei.com>

On Fri, Nov 01, 2024 at 06:50:25PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Add dp aux read/write functions. They are basic functions
> and will be used later.
> 
> Signed-off-by: baihan li <libaihan@huawei.com>
> Signed-off-by: yongbang shi <shiyongbang@huawei.com>

Is this a proper capitalization of your names? Usually the first letter
of each of them is capital.

> ---
> ChangeLog:
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
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   | 162 ++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.h   |  23 +++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  58 +++++++
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  19 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  27 +++
>  6 files changed, 291 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.h
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
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
> index 000000000000..49ecda672109
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2024 Hisilicon Limited.
> +
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/minmax.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_print.h>
> +#include "dp_comm.h"
> +#include "dp_reg.h"
> +#include "dp_aux.h"
> +
> +#define DP_MIN_PULSE_NUM 0x9
> +
> +static void hibmc_dp_aux_reset(const struct dp_dev *dp)
> +{
> +	dp_reg_write_field(dp->base + DP_DPTX_RST_CTRL, DP_CFG_AUX_RST_N, 0x0);
> +	usleep_range(10, 15);
> +	dp_reg_write_field(dp->base + DP_DPTX_RST_CTRL, DP_CFG_AUX_RST_N, 0x1);
> +}
> +
> +static void hibmc_dp_aux_read_data(struct dp_dev *dp, u8 *buf, u8 size)
> +{
> +	u32 reg_num;
> +	u32 value;
> +	u32 num;
> +	u8 i, j;
> +
> +	reg_num = DIV_ROUND_UP(size, BYTES_IN_U32);
> +	for (i = 0; i < reg_num; i++) {
> +		/* number of bytes read from a single register */
> +		num = min(size - i * BYTES_IN_U32, BYTES_IN_U32);
> +		value = readl(dp->base + DP_AUX_RD_DATA0 + i * BYTES_IN_U32);
> +		/* convert the 32-bit value of the register to the buffer. */
> +		for (j = 0; j < num; j++)
> +			buf[i * BYTES_IN_U32 + j] = value >> (j * BITS_IN_U8);

put_unaligned_le32()

> +	}
> +}
> +
> +static void hibmc_dp_aux_write_data(struct dp_dev *dp, u8 *buf, u8 size)
> +{
> +	u32 reg_num;
> +	u32 value;
> +	u8 i, j;
> +	u32 num;
> +
> +	reg_num = DIV_ROUND_UP(size, BYTES_IN_U32);
> +	for (i = 0; i < reg_num; i++) {
> +		/* number of bytes written to a single register */
> +		num = min_t(u8, size - i * BYTES_IN_U32, BYTES_IN_U32);
> +		value = 0;
> +		/* obtain the 32-bit value written to a single register. */
> +		for (j = 0; j < num; j++)
> +			value |= buf[i * BYTES_IN_U32 + j] << (j * BITS_IN_U8);

get_unaligned_le32()

> +		/* writing data to a single register */
> +		writel(value, dp->base + DP_AUX_WR_DATA0 + i * BYTES_IN_U32);
> +	}
> +}
> +
> +static u32 hibmc_dp_aux_build_cmd(const struct drm_dp_aux_msg *msg)
> +{
> +	u32 aux_cmd = msg->request;
> +
> +	if (msg->size)
> +		aux_cmd |= FIELD_PREP(AUX_CMD_REQ_LEN, (msg->size - 1));
> +	else
> +		aux_cmd |= FIELD_PREP(AUX_CMD_I2C_ADDR_ONLY, 1);
> +
> +	aux_cmd |= FIELD_PREP(AUX_CMD_ADDR, msg->address);
> +
> +	return aux_cmd;
> +}
> +
> +/* ret >= 0 ,ret is size; ret < 0, ret is err code */
> +static int hibmc_dp_aux_parse_xfer(struct dp_dev *dp, struct drm_dp_aux_msg *msg)
> +{
> +	u32 buf_data_cnt;
> +	u32 aux_status;
> +	int ret = 0;
> +
> +	aux_status = readl(dp->base + DP_AUX_STATUS);
> +	msg->reply = FIELD_GET(DP_CFG_AUX_STATUS, aux_status);
> +
> +	if (aux_status & DP_CFG_AUX_TIMEOUT)
> +		return -ETIMEDOUT;
> +
> +	/* only address */
> +	if (!msg->size)
> +		return 0;
> +
> +	if (msg->reply != DP_AUX_NATIVE_REPLY_ACK)
> +		return 0;

Should this be an error instead?

> +
> +	buf_data_cnt = FIELD_GET(DP_CFG_AUX_READY_DATA_BYTE, aux_status);
> +
> +	switch (msg->request) {
> +	case DP_AUX_NATIVE_WRITE:
> +		ret = msg->size;
> +		break;
> +	case DP_AUX_I2C_WRITE | DP_AUX_I2C_MOT:
> +		if (buf_data_cnt == AUX_I2C_WRITE_SUCCESS)
> +			ret = msg->size;
> +		else if (buf_data_cnt == AUX_I2C_WRITE_PARTIAL_SUCCESS)
> +			ret = FIELD_GET(DP_CFG_AUX, aux_status);

Replace all ret= with returns. Nothing happens after the switch-case, so
return right away.

> +		break;
> +	case DP_AUX_NATIVE_READ:
> +	case DP_AUX_I2C_READ | DP_AUX_I2C_MOT:
> +		buf_data_cnt--;
> +		/* only the successful part of data is read */

Nit: only a part of data wass read successfully.
move the comment into the underlying `

> +		if (buf_data_cnt != msg->size) {
> +			ret = -EBUSY;
> +		} else { /* all data is successfully read */
> +			hibmc_dp_aux_read_data(dp, msg->buffer, msg->size);
> +			ret = msg->size;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +/* ret >= 0 ,ret is size; ret < 0, ret is err code */
> +static ssize_t hibmc_dp_aux_xfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
> +{
> +	struct dp_dev *dp = container_of(aux, struct dp_dev, aux);
> +	u32 aux_cmd;
> +	int ret;
> +	u32 val; /* val will be assigned at the beginning of readl_poll_timeout function */
> +
> +	writel(0, dp->base + DP_AUX_WR_DATA0);
> +	writel(0, dp->base + DP_AUX_WR_DATA1);
> +	writel(0, dp->base + DP_AUX_WR_DATA2);
> +	writel(0, dp->base + DP_AUX_WR_DATA3);
> +
> +	hibmc_dp_aux_write_data(dp, msg->buffer, msg->size);
> +
> +	aux_cmd = hibmc_dp_aux_build_cmd(msg);
> +	writel(aux_cmd, dp->base + DP_AUX_CMD_ADDR);
> +
> +	/* enable aux transfer */
> +	dp_reg_write_field(dp->base + DP_AUX_REQ, DP_CFG_AUX_REQ, 0x1);
> +	ret = readl_poll_timeout(dp->base + DP_AUX_REQ, val, !(val & DP_CFG_AUX_REQ), 50, 5000);
> +	if (ret) {
> +		hibmc_dp_aux_reset(dp);
> +		return ret;
> +	}
> +
> +	return hibmc_dp_aux_parse_xfer(dp, msg);
> +}
> +
> +void hibmc_dp_aux_init(struct dp_dev *dp)
> +{
> +	dp_reg_write_field(dp->base + DP_AUX_REQ, DP_CFG_AUX_SYNC_LEN_SEL, 0x0);
> +	dp_reg_write_field(dp->base + DP_AUX_REQ, DP_CFG_AUX_TIMER_TIMEOUT, 0x1);
> +	dp_reg_write_field(dp->base + DP_AUX_REQ, DP_CFG_AUX_MIN_PULSE_NUM, DP_MIN_PULSE_NUM);
> +
> +	dp->aux.transfer = hibmc_dp_aux_xfer;
> +	dp->aux.is_remote = 0;
> +	drm_dp_aux_init(&dp->aux);
> +}
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.h
> new file mode 100644
> index 000000000000..794bb0482ea7
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (c) 2024 Hisilicon Limited. */
> +
> +#ifndef DP_AUX_H
> +#define DP_AUX_H
> +
> +#include <linux/bitops.h>
> +#include "dp_comm.h"
> +
> +#define AUX_I2C_WRITE_SUCCESS		0x1

Move to the source file

> +#define AUX_I2C_WRITE_PARTIAL_SUCCESS	0x2

Ditto

> +#define EQ_MAX_RETRY			5

Unused

> +#define BYTES_IN_U32			4


> +#define BITS_IN_U8			8

This one will go away after using foo_unaligned_le32

> +
> +/* aux_cmd_addr register shift */
> +#define AUX_CMD_REQ_LEN			GENMASK(7, 4)
> +#define AUX_CMD_ADDR			GENMASK(27, 8)
> +#define AUX_CMD_I2C_ADDR_ONLY		BIT(28)

These can go to the source file too. Or to dp_reg.h. Don't spawn that
all over the place.

> +
> +void hibmc_dp_aux_init(struct dp_dev *dp);

As the header becomes nearly empty, merge the remnants to a generic
header.

> +
> +#endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> new file mode 100644
> index 000000000000..61a59fd59962
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> @@ -0,0 +1,58 @@
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
> +
> +#include <drm/display/drm_dp_helper.h>
> +
> +#define dp_reg_read_field(addr, mask)				\

These are still using dp_ prefix. Also using static inline functions
might be easier to handle.

> +		FIELD_GET(mask, readl(addr))
> +
> +#define dp_field_modify(reg_value, mask, value) ({		\
> +		(reg_value) &= ~(mask);				\
> +		(reg_value) |= FIELD_PREP(mask, value); })
> +
> +#define dp_reg_write_field(addr, mask, val) ({			\
> +		typeof(addr) _addr = (addr);			\
> +		u32 _value = readl(_addr);			\
> +		dp_field_modify(_value, mask, val);		\
> +		writel(_value, _addr); })

I'm still very unsatisfied here. You have an RMW code with no locking.
If anything writes to the same location at the same time, the driver is
busted.

> +
> +struct link_status {

It is hibmc-specific, so please prefix accordingly.

> +	bool clock_recovered;
> +	bool channel_equalized;
> +	u8 cr_done_lanes;
> +};
> +
> +struct link_cap {
> +	int rx_dpcd_revision;
> +	u8 link_rate;
> +	u8 lanes;
> +	bool is_tps3;
> +	bool is_tps4;
> +};
> +
> +struct hibmc_dp_link {
> +	struct link_status status;
> +	u8 *train_set;
> +	struct link_cap cap;
> +};

Please don't define the structures/fields that are not used by the
patch. Introduce them when required.

> +
> +struct dp_dev {
> +	struct hibmc_dp_link link;
> +	struct drm_dp_aux aux;
> +	struct drm_device *dev;
> +	void __iomem *base;
> +	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> new file mode 100644
> index 000000000000..0b965e6ba7b3
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (c) 2024 Hisilicon Limited. */
> +
> +#ifndef DP_CONFIG_H
> +#define DP_CONFIG_H
> +
> +#define DP_BPP			24
> +#define DP_SYMBOL_PER_FCLK	4
> +#define DP_MSA1			0x20
> +#define DP_MSA2			0x845c00
> +#define DP_OFFSET		0x1e0000
> +#define DP_HDCP			0x2
> +#define DP_INT_RST		0xffff
> +#define DP_DPTX_RST		0x3ff
> +#define DP_CLK_EN		0x7
> +#define DP_SYNC_EN_MASK		0x3
> +#define DP_LINK_RATE_CAL	27
> +
> +#endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> new file mode 100644
> index 000000000000..83cf0cc06ae2
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (c) 2024 Hisilicon Limited. */
> +
> +#ifndef DP_REG_H
> +#define DP_REG_H
> +
> +#define DP_AUX_CMD_ADDR			0x50
> +#define DP_AUX_WR_DATA0			0x54
> +#define DP_AUX_WR_DATA1			0x58
> +#define DP_AUX_WR_DATA2			0x5c
> +#define DP_AUX_WR_DATA3			0x60
> +#define DP_AUX_RD_DATA0			0x64
> +#define DP_AUX_REQ			0x74
> +#define DP_AUX_STATUS			0x78
> +#define DP_DPTX_RST_CTRL		0x700
> +
> +#define DP_CFG_AUX_SYNC_LEN_SEL			BIT(1)
> +#define DP_CFG_AUX_TIMER_TIMEOUT		BIT(2)
> +#define DP_CFG_AUX_MIN_PULSE_NUM		GENMASK(13, 9)
> +#define DP_CFG_AUX_REQ				BIT(0)
> +#define DP_CFG_AUX_RST_N			BIT(4)
> +#define DP_CFG_AUX_TIMEOUT			BIT(0)
> +#define DP_CFG_AUX_READY_DATA_BYTE		GENMASK(16, 12)
> +#define DP_CFG_AUX				GENMASK(24, 17)
> +#define DP_CFG_AUX_STATUS			GENMASK(11, 4)
> +
> +#endif
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

