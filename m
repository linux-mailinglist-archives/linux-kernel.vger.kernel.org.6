Return-Path: <linux-kernel+bounces-391191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC1C9B83AA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B608C1F22664
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710491A2562;
	Thu, 31 Oct 2024 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceXztaCJ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7328E8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404314; cv=none; b=gL/lxwA427f4xcHZCTsfpf+HC81C8gvqgu5vuuJ5ehsB/8vKSrfuSUR7ZNuThHf2bicuIy8L/JU+N0D6E8oEEgE050yxbUwwDFHmr45QDRdRiMuTzjnsQ3P4KbWreLxrcxaqUe2lAlmG139aCHO1AgvRWjqLAhHu01x/aqDiJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404314; c=relaxed/simple;
	bh=KnO2bYfuy2uUejQ7C5vjVtiwW3mbOreEOmZMcOXs60s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHF72CbFUzrpxHToWfECJ3OLdcm7DDwtY6ciqOy/q53eyCqZAHf0UvX0PhfCuzECUVWTNeh5bcrG5rixURycIvJqQSZ8fKRMlpZKlPYcRq4fWvsuuAYDVjO9hb7YWqrqwM4Rn5iZ+95jLrUJUj7M6LCHh/8lI7SbgfmqHMmv5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ceXztaCJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1339186e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730404309; x=1731009109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCNx5SWiMhDfIKH3tg1AN/AN9mri+8q+ByDcJD6vDiY=;
        b=ceXztaCJDG/DYhfIJ6q4TdISSBQXuUIYzlXhHHiKhrmnREMVRMXn1mByDZP+WFlSOk
         32bH7gqL57wFHaNkW2VBZpyfH3hWBCunVM71iUDz+lYjGC7+dRstvy+aJ/O+fkpsuOSh
         slsovIjqxfwt/ytGpHeromEiiiGsFwWsZzqepcE87XA40CwTS5gU2M8CwuG9LXfMQDjR
         spWpZYEKOWXp/CRD6OKBMRSNXZ1KNRTaohraBOS6rJGam1KpVIZdazngRisVy52kEkMK
         /XCq5PicngZYBlfhYIRJz2dVp+qgXdNhyyO+iVO8rYC/y+1A0Pz3xNjMwai6sjic0LiL
         L0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404309; x=1731009109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCNx5SWiMhDfIKH3tg1AN/AN9mri+8q+ByDcJD6vDiY=;
        b=TqGhwNnCvEucNukSGm0FYIj1edyWYi/6naCHIfUgiP26VCK1vX7mVtPsXOpbtzNhW2
         VooDl3up4kxuyCsUbygEEdmL4fgYiWZUB8C1UOvh2shBNzJFtvlLLxRWCSRePc+gR4Ms
         /BrkKRIu3pfT2Jj9vHJR41Dyo+l0rNwq4f+3mQPTZaCLiCvBvcDY0tSQzRU5I8xg8Fyq
         efyjzbxCiT004sGTh89dtkGhppiHGfdjmjvyIT/RsIYh66MgrcxWyLyWbJivTcFR4u9E
         nSqRPwGyEhYEN9Rqy3V5aAOzY8h1QRyHbT1hO5SdSEtqAKFjqcURHwAt7AbAEdk8uTDT
         CEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzTAh+IbBHJQGb3oimg31QTfp8M8P5z3vJmrhv3HlsQ0q4WfwtDaK5fm8jwxnbNjPS1uVTr/yGagGR6AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOZLL5CFQSFsI5VO7oJ+AruCovR93lNVFJCO/f3nWAW4mkRsS
	KcYifUZnZ3Q1JquNl2LRGUgjAGaJqWilAkkoTQ6dg4ILFDs/XamkEnM6jFtsiss=
X-Google-Smtp-Source: AGHT+IEEgY7F5uzF4hI0U2w97PBObBX1oM6l43lOxL41hlmg2ee+jW5k6ynm0t2JiTbir/TN4GM3Jg==
X-Received: by 2002:a05:6512:3e26:b0:53b:2114:92a7 with SMTP id 2adb3069b0e04-53b34c8e61fmr12732597e87.52.1730404308684;
        Thu, 31 Oct 2024 12:51:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce69esm306167e87.157.2024.10.31.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:51:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 21:51:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, mripard@kernel.org, 
	kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v18 1/8] drm: bridge: Cadence: Create MHDP helper driver
Message-ID: <txezouzqnw6hzn7c6bmp3mgp6b3vjnsuf2txcbeotklekipl7w@m45grnhct2sj>
References: <cover.1730172244.git.Sandor.yu@nxp.com>
 <9fe153c4f0b8616782fba1f7c8c2223c4f0c1d78.1730172244.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fe153c4f0b8616782fba1f7c8c2223c4f0c1d78.1730172244.git.Sandor.yu@nxp.com>

On Tue, Oct 29, 2024 at 02:02:09PM +0800, Sandor Yu wrote:
> Mailbox access functions in MHDP8546 will be share to other MHDP driver
> and Cadence HDP-TX HDMI/DP PHY drivers.
> 
> Create a new MHDP helper driver and move all mailbox access functions into.
> According the mailbox access sequence and type of security.
> Six mailbox access API functions are introduced.
> Three APIs for non-secure mailbox access:
>  - cdns_mhdp_mailbox_send()
>  - cdns_mhdp_mailbox_send_recv()
>  - cdns_mhdp_mailbox_send_recv_multi()
> The other three APIs for secure mailbox access:
>  - cdns_mhdp_secure_mailbox_send()
>  - cdns_mhdp_secure_mailbox_send_recv()
>  - cdns_mhdp_secure_mailbox_send_recv_multi()
> 
> All MHDP commands that need to be passed through the mailbox
> have been rewritten using those new API functions.
> 
> The register read/write and DP DPCD read/write command functions
> are also included in this new helper driver.
> 
> Function cdns_mhdp_reg_write() is renamed to cdns_mhdp_dp_reg_write(),
> because it use the DPTX command ID DPTX_WRITE_REGISTER.
> New cdns_mhdp_reg_write() is added with the general command ID
> GENERAL_REGISTER_WRITE.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
> v17->v18:
> - Create three ordinary mailbox access APIs
>     cdns_mhdp_mailbox_send
>     cdns_mhdp_mailbox_send_recv
>     cdns_mhdp_mailbox_send_recv_multi
> - Create three secure mailbox access APIs
>     cdns_mhdp_secure_mailbox_send
>     cdns_mhdp_secure_mailbox_send_recv
>     cdns_mhdp_secure_mailbox_send_recv_multi
> - MHDP8546 DP and HDCP commands that need access mailbox are rewrited
>   with above 6 API functions.
> 
> v16->v17:
> - Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mutex
> 
> v12->v16:
>  *No change.
> 
>  drivers/gpu/drm/bridge/cadence/Kconfig        |   4 +
>  drivers/gpu/drm/bridge/cadence/Makefile       |   1 +
>  .../gpu/drm/bridge/cadence/cdns-mhdp-helper.c | 414 +++++++++++++++
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 487 +++---------------
>  .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  47 +-
>  .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   | 236 +--------
>  .../drm/bridge/cadence/cdns-mhdp8546-hdcp.h   |  18 +-
>  include/drm/bridge/cdns-mhdp-helper.h         | 130 +++++
>  8 files changed, 658 insertions(+), 679 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c
>  create mode 100644 include/drm/bridge/cdns-mhdp-helper.h
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
> index cced81633ddcd..e0973339e9e33 100644
> --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> @@ -21,6 +21,9 @@ config DRM_CDNS_DSI_J721E
>  	  the routing of the DSS DPI signal to the Cadence DSI.
>  endif
>  
> +config CDNS_MHDP_HELPER
> +	tristate
> +

I'm not sure if the placement for the helper is suitable. Especially if
you want to reuse the helper by some other subsystem. As far as I don't
like it, maybe drivers/soc is a better option.

>  config DRM_CDNS_MHDP8546
>  	tristate "Cadence DPI/DP bridge"
>  	select DRM_DISPLAY_DP_HELPER
> @@ -28,6 +31,7 @@ config DRM_CDNS_MHDP8546
>  	select DRM_DISPLAY_HELPER
>  	select DRM_KMS_HELPER
>  	select DRM_PANEL_BRIDGE
> +	select CDNS_MHDP_HELPER
>  	depends on OF
>  	help
>  	  Support Cadence DPI to DP bridge. This is an internal
> diff --git a/drivers/gpu/drm/bridge/cadence/Makefile b/drivers/gpu/drm/bridge/cadence/Makefile
> index c95fd5b81d137..087dc074820d7 100644
> --- a/drivers/gpu/drm/bridge/cadence/Makefile
> +++ b/drivers/gpu/drm/bridge/cadence/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
>  cdns-dsi-y := cdns-dsi-core.o
>  cdns-dsi-$(CONFIG_DRM_CDNS_DSI_J721E) += cdns-dsi-j721e.o
> +obj-$(CONFIG_CDNS_MHDP_HELPER) += cdns-mhdp-helper.o
>  obj-$(CONFIG_DRM_CDNS_MHDP8546) += cdns-mhdp8546.o
>  cdns-mhdp8546-y := cdns-mhdp8546-core.o cdns-mhdp8546-hdcp.o
>  cdns-mhdp8546-$(CONFIG_DRM_CDNS_MHDP8546_J721E) += cdns-mhdp8546-j721e.o
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c
> new file mode 100644
> index 0000000000000..f39228a78c7cb
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c
> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023, 2024 NXP Semiconductor, Inc.
> + *
> + */
> +#include <drm/bridge/cdns-mhdp-helper.h>
> +#include <linux/dev_printk.h>
> +#include <linux/module.h>
> +
> +/* Protects mailbox communications with the firmware */
> +static DEFINE_MUTEX(mhdp_mailbox_mutex);
> +
> +/* Mailbox helper functions */
> +static int mhdp_mailbox_read(void __iomem *regs)
> +{
> +	int ret, empty;
> +
> +	WARN_ON(!mutex_is_locked(&mhdp_mailbox_mutex));
> +
> +	ret = readx_poll_timeout(readl, regs + CDNS_MAILBOX_EMPTY,
> +				 empty, !empty, MAILBOX_RETRY_US,
> +				 MAILBOX_TIMEOUT_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	return readl(regs + CDNS_MAILBOX_RX_DATA) & 0xff;
> +}
> +
> +static int mhdp_mailbox_write(void __iomem *regs, u8 val)
> +{
> +	int ret, full;
> +
> +	WARN_ON(!mutex_is_locked(&mhdp_mailbox_mutex));
> +
> +	ret = readx_poll_timeout(readl, regs + CDNS_MAILBOX_FULL,
> +				 full, !full, MAILBOX_RETRY_US,
> +				 MAILBOX_TIMEOUT_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(val, regs + CDNS_MAILBOX_TX_DATA);
> +
> +	return 0;
> +}
> +
> +static int mhdp_mailbox_recv_header(void __iomem *regs,
> +				    u8 module_id, u8 opcode,
> +				    u16 req_size)
> +{
> +	u32 mbox_size, i;
> +	u8 header[4];
> +	int ret;
> +
> +	/* read the header of the message */
> +	for (i = 0; i < sizeof(header); i++) {
> +		ret = mhdp_mailbox_read(regs);
> +		if (ret < 0)
> +			return ret;
> +
> +		header[i] = ret;
> +	}
> +
> +	mbox_size = get_unaligned_be16(header + 2);
> +
> +	if (opcode != header[0] || module_id != header[1] ||
> +	   (opcode != HDCP_TRAN_IS_REC_ID_VALID && req_size != mbox_size)) {

Could you please explain the second clause?

> +		/*
> +		 * If the message in mailbox is not what we want, we need to
> +		 * clear the mailbox by reading its contents.
> +		 */
> +		for (i = 0; i < mbox_size; i++)
> +			if (mhdp_mailbox_read(regs) < 0)
> +				break;
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mhdp_mailbox_recv_data(void __iomem *regs,
> +				  u8 *buff, u16 buff_size)
> +{
> +	u32 i;
> +	int ret;
> +
> +	for (i = 0; i < buff_size; i++) {
> +		ret = mhdp_mailbox_read(regs);
> +		if (ret < 0)
> +			return ret;
> +
> +		buff[i] = ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mhdp_mailbox_send(void __iomem *regs, u8 module_id,
> +			     u8 opcode, u16 size, u8 *message)
> +{
> +	u8 header[4];
> +	int ret, i;
> +
> +	header[0] = opcode;
> +	header[1] = module_id;
> +	put_unaligned_be16(size, header + 2);
> +
> +	for (i = 0; i < sizeof(header); i++) {
> +		ret = mhdp_mailbox_write(regs, header[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < size; i++) {
> +		ret = mhdp_mailbox_write(regs, message[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +

Please add kerneldocs for all new API. It's obvious for the simple ones,
but not for the more complex functions.

> +int cdns_mhdp_mailbox_send(struct cdns_mhdp_base *base, u8 module_id,
> +			   u8 opcode, u16 size, u8 *message)
> +{
> +	int ret;
> +
> +	mutex_lock(&mhdp_mailbox_mutex);

guard(mutex)(&mhdp_mailbox_mutex);

return mhdp_mailbox_send(...);

Similar changes can be applied further on.

> +
> +	ret = mhdp_mailbox_send(base->regs, module_id, opcode, size, message);
> +
> +	mutex_unlock(&mhdp_mailbox_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_mailbox_send);
> +
> +int cdns_mhdp_mailbox_send_recv(struct cdns_mhdp_base *base,
> +				u8 module_id, u8 opcode,
> +				u16 msg_size, u8 *msg,
> +				u16 resp_size, u8 *resp)
> +{
> +	int ret;
> +
> +	mutex_lock(&mhdp_mailbox_mutex);
> +
> +	ret = mhdp_mailbox_send(base->regs, module_id,
> +				opcode, msg_size, msg);
> +	if (ret)
> +		goto out;
> +
> +	ret = mhdp_mailbox_recv_header(base->regs, module_id,
> +				       opcode, resp_size);
> +	if (ret)
> +		goto out;
> +
> +	ret = mhdp_mailbox_recv_data(base->regs, resp, resp_size);
> +out:
> +	mutex_unlock(&mhdp_mailbox_mutex);
> +
> +	if (ret)
> +		dev_err(base->dev, "ModuleID=%d, CMD=%d failed: %d\n",
> +			module_id, opcode, ret);

Using guard() would allow you to use precise messages, e.g. failed to
send, failed to received header, failed to receive data.

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_mailbox_send_recv);
> +

Like what is _multi? Why do you need to fetch into two separate buffers?
Can you fetch into one and then parse it accordingly? Please don't make
the API more complicated than necessary.

> +int cdns_mhdp_mailbox_send_recv_multi(struct cdns_mhdp_base *base,
> +				      u8 module_id, u8 opcode,
> +				      u16 msg_size, u8 *msg,
> +				      u8 opcode_resp,
> +				      u16 resp1_size, u8 *resp1,
> +				      u16 resp2_size, u8 *resp2)
> +{
> +	int ret;
> +
> +	mutex_lock(&mhdp_mailbox_mutex);
> +
> +	ret = mhdp_mailbox_send(base->regs, module_id,
> +				opcode, msg_size, msg);
> +	if (ret)
> +		goto out;
> +
> +	ret = mhdp_mailbox_recv_header(base->regs, module_id, opcode_resp,
> +				       resp1_size + resp2_size);
> +	if (ret)
> +		goto out;
> +
> +	ret = mhdp_mailbox_recv_data(base->regs, resp1, resp1_size);
> +	if (ret)
> +		goto out;
> +
> +	ret = mhdp_mailbox_recv_data(base->regs, resp2, resp2_size);
> +out:
> +	mutex_unlock(&mhdp_mailbox_mutex);
> +
> +	if (ret)
> +		dev_err(base->dev, "ModuleID=%d, MSG_CMD=%d Resp_CMD=%d failed: %d\n",
> +			module_id, opcode, opcode_resp, ret);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_mailbox_send_recv_multi);
> +
> +/*
> + * Secure mailbox access functions:
> + * These functions handle secure mailbox communication, which differs
> + * from non-secure mailbox access. They use the secure address.
> + */
> +int cdns_mhdp_secure_mailbox_send(struct cdns_mhdp_base *base, u8 module_id,
> +				  u8 opcode, u16 size, u8 *message)
> +{
> +	int ret;
> +
> +	mutex_lock(&mhdp_mailbox_mutex);
> +
> +	ret = mhdp_mailbox_send(base->sapb_regs, module_id, opcode, size, message);
> +
> +	mutex_unlock(&mhdp_mailbox_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_secure_mailbox_send);
> +
> +int cdns_mhdp_secure_mailbox_send_recv(struct cdns_mhdp_base *base,
> +				       u8 module_id, u8 opcode,
> +				       u16 msg_size, u8 *msg,
> +				       u16 resp_size, u8 *resp)
> +{
> +	int ret;
> +
> +	mutex_lock(&mhdp_mailbox_mutex);
> +
> +	ret = mhdp_mailbox_send(base->sapb_regs, module_id,
> +				opcode, msg_size, msg);
> +	if (ret)
> +		goto out;
> +
> +	ret = mhdp_mailbox_recv_header(base->sapb_regs, module_id,
> +				       opcode, resp_size);
> +	if (ret)
> +		goto out;
> +
> +	ret = mhdp_mailbox_recv_data(base->sapb_regs, resp, resp_size);
> +out:
> +	mutex_unlock(&mhdp_mailbox_mutex);
> +
> +	if (ret)
> +		dev_err(base->dev, "ModuleID=%d, CMD=%d failed: %d\n",
> +			module_id, opcode, ret);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_secure_mailbox_send_recv);
> +
> +int cdns_mhdp_secure_mailbox_send_recv_multi(struct cdns_mhdp_base *base,
> +					     u8 module_id, u8 opcode,
> +					     u16 msg_size, u8 *msg,
> +					     u8 opcode_resp,
> +					     u16 resp1_size, u8 *resp1,
> +					     u16 resp2_size, u8 *resp2)
> +{
> +	int ret;
> +
> +	mutex_lock(&mhdp_mailbox_mutex);
> +
> +	ret = mhdp_mailbox_send(base->sapb_regs, module_id,
> +				opcode, msg_size, msg);
> +	if (ret)
> +		goto out;
> +
> +	ret = mhdp_mailbox_recv_header(base->sapb_regs, module_id,
> +				       opcode_resp,
> +				       resp1_size + resp2_size);
> +	if (ret)
> +		goto out;
> +
> +	ret = mhdp_mailbox_recv_data(base->sapb_regs, resp1, resp1_size);
> +	if (ret)
> +		goto out;
> +
> +	if (module_id == MB_MODULE_ID_HDCP_TX &&
> +	    opcode == HDCP_TRAN_IS_REC_ID_VALID)

comment, please.

> +		ret = mhdp_mailbox_recv_data(base->sapb_regs, resp2, 5 * resp1[0]);
> +	else
> +		ret = mhdp_mailbox_recv_data(base->sapb_regs, resp2, resp2_size);
> +out:
> +	mutex_unlock(&mhdp_mailbox_mutex);
> +
> +	if (ret)
> +		dev_err(base->dev, "ModuleID=%d, CMD=%d failed: %d\n",
> +			module_id, opcode, ret);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_secure_mailbox_send_recv_multi);
> +
> +/* General read/write helper functions */
> +int cdns_mhdp_reg_read(struct cdns_mhdp_base *base, u32 addr, u32 *value)
> +{
> +	u8 msg[4], resp[8];
> +	int ret;
> +
> +	put_unaligned_be32(addr, msg);
> +
> +	ret = cdns_mhdp_mailbox_send_recv(base, MB_MODULE_ID_GENERAL,
> +					  GENERAL_REGISTER_READ,
> +					  sizeof(msg), msg, sizeof(resp), resp);
> +	if (ret)
> +		goto out;
> +
> +	/* Returned address value should be the same as requested */
> +	if (memcmp(msg, resp, sizeof(msg))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	*value = get_unaligned_be32(resp + 4);
> +out:
> +	if (ret) {
> +		dev_err(base->dev, "Failed to read register\n");
> +		*value = 0;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_reg_read);
> +
> +int cdns_mhdp_reg_write(struct cdns_mhdp_base *base, u32 addr, u32 val)
> +{
> +	u8 msg[8];
> +
> +	put_unaligned_be32(addr, msg);
> +	put_unaligned_be32(val, msg + 4);
> +
> +	return cdns_mhdp_mailbox_send(base, MB_MODULE_ID_GENERAL,
> +				     GENERAL_REGISTER_WRITE,
> +				     sizeof(msg), msg);
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_reg_write);
> +
> +/* DPTX helper functions */
> +int cdns_mhdp_dp_reg_write(struct cdns_mhdp_base *base, u16 addr, u32 val)
> +{
> +	u8 msg[6];
> +
> +	put_unaligned_be16(addr, msg);
> +	put_unaligned_be32(val, msg + 2);
> +
> +	return cdns_mhdp_mailbox_send(base, MB_MODULE_ID_DP_TX,
> +				      DPTX_WRITE_REGISTER, sizeof(msg), msg);
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_dp_reg_write);

Please don't add API without a user. If the function is required in the
following patch, add it there.

> +
> +int cdns_mhdp_dp_reg_write_bit(struct cdns_mhdp_base *base, u16 addr,
> +			       u8 start_bit, u8 bits_no, u32 val)
> +{
> +	u8 field[8];
> +
> +	put_unaligned_be16(addr, field);
> +	field[2] = start_bit;
> +	field[3] = bits_no;
> +	put_unaligned_be32(val, field + 4);
> +
> +	return cdns_mhdp_mailbox_send(base, MB_MODULE_ID_DP_TX,
> +				      DPTX_WRITE_FIELD, sizeof(field), field);
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_dp_reg_write_bit);
> +
> +int cdns_mhdp_dpcd_read(struct cdns_mhdp_base *base,
> +			u32 addr, u8 *data, u16 len)
> +{
> +	u8 msg[5], reg[5];
> +
> +	put_unaligned_be16(len, msg);
> +	put_unaligned_be24(addr, msg + 2);
> +
> +	return cdns_mhdp_mailbox_send_recv_multi(base,
> +						 MB_MODULE_ID_DP_TX,
> +						 DPTX_READ_DPCD,
> +						 sizeof(msg), msg,
> +						 DPTX_READ_DPCD,
> +						 sizeof(reg), reg,
> +						 len, data);
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_dpcd_read);
> +
> +int cdns_mhdp_dpcd_write(struct cdns_mhdp_base *base, u32 addr, u8 value)
> +{
> +	u8 msg[6], reg[5];
> +	int ret;
> +
> +	put_unaligned_be16(1, msg);
> +	put_unaligned_be24(addr, msg + 2);
> +	msg[5] = value;
> +
> +	ret = cdns_mhdp_mailbox_send_recv(base, MB_MODULE_ID_DP_TX,
> +					  DPTX_WRITE_DPCD,
> +					  sizeof(msg), msg, sizeof(reg), reg);
> +	if (ret) {
> +		dev_err(base->dev, "dpcd write failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (addr != get_unaligned_be24(reg + 2)) {
> +		dev_err(base->dev, "Invalid response: expected address 0x%06x, got 0x%06x\n",
> +			addr, get_unaligned_be24(reg + 2));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cdns_mhdp_dpcd_write);
> +
> +MODULE_DESCRIPTION("Cadence MHDP Helper driver");
> +MODULE_AUTHOR("Sandor Yu <Sandor.yu@nxp.com>");
> +MODULE_LICENSE("GPL");

-- 
With best wishes
Dmitry

