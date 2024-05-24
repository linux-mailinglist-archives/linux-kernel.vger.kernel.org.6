Return-Path: <linux-kernel+bounces-188611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19BA8CE44F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624A51F221B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14F85956;
	Fri, 24 May 2024 10:34:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95985940
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546888; cv=none; b=Buae1LmBBCPScrATkPZt0adqCJWnsC2mr7BYa1H7TzRklq8HTGQ/MViOkXqcHLOmzUznusIQ5oiS2+XORXQ4IMLB2jIWKLP/VNww82LeGQoL78juA7loxpNPtqeDm+IiAH9/1+tzxEDQPEdbJbCWRYNDgGHnjA+/tm1p2YSKKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546888; c=relaxed/simple;
	bh=qg+hQa3sjCvK1rsMinmlMmvRSQldE+iztqZn3l16GXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3vPPjpNerpyfbn+02NFeWPEu7tmS6wPApVRgPaCMrYNf3a3JLec1wPJSdTP8RU7gcQBJIoR2PDGfKKt+km1xLZFP+swKSD+2NoUBuXb0HxjiKVU2cR5yH0tJ9ezh1IXtFOf5uiwMp12QMp4S6E//w4z6zn+r6jGwDyNvkUsoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sASFq-0008L1-7k; Fri, 24 May 2024 12:34:30 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sASFp-002mYJ-9k; Fri, 24 May 2024 12:34:29 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sASFp-00Bdvd-0d;
	Fri, 24 May 2024 12:34:29 +0200
Date: Fri, 24 May 2024 12:34:29 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
Message-ID: <ZlBtNSeh2VyZsVxq@pengutronix.de>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-4-5a6fd189a539@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-imx-se-if-v2-4-5a6fd189a539@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, May 23, 2024 at 04:19:35PM +0530, Pankaj Gupta wrote:
> NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
> are embedded in the SoC to support the features like HSM, SHE & V2X,
> using message based communication interface.
> 
> The secure enclave FW communicates on a dedicated messaging unit(MU)
> based interface(s) with application core, where kernel is running.
> It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> 
> This patch adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
> Enclave (ELE) from Kernel-space, used by kernel management layers like
> - DM-Crypt.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  drivers/firmware/imx/Kconfig        |  12 +
>  drivers/firmware/imx/Makefile       |   2 +
>  drivers/firmware/imx/ele_base_msg.c | 286 +++++++++++++++++++
>  drivers/firmware/imx/ele_base_msg.h |  92 +++++++
>  drivers/firmware/imx/ele_common.c   | 239 ++++++++++++++++
>  drivers/firmware/imx/ele_common.h   |  43 +++
>  drivers/firmware/imx/se_ctrl.c      | 531 ++++++++++++++++++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
>  include/linux/firmware/imx/se_api.h |  14 +
>  9 files changed, 1318 insertions(+)
> 

> +static int se_probe_if_cleanup(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct se_if_priv *priv;
> +	int ret = 0;
> +
> +	priv = dev_get_drvdata(dev);
> +	if (!priv) {
> +		ret = 0;
> +		dev_dbg(dev, "SE-MU Priv data is NULL;");
> +		return ret;
> +	}
> +
> +	if (priv->tx_chan)
> +		mbox_free_channel(priv->tx_chan);
> +	if (priv->rx_chan)
> +		mbox_free_channel(priv->rx_chan);
> +
> +	/* free the buffer in se remove, previously allocated
> +	 * in se probe to store encrypted IMEM
> +	 */
> +	if (priv->imem.buf) {
> +		dmam_free_coherent(dev,
> +				   ELE_IMEM_SIZE,
> +				   priv->imem.buf,
> +				   priv->imem.phyaddr);
> +		priv->imem.buf = NULL;
> +	}
> +
> +	if (priv->flags & RESERVED_DMA_POOL) {
> +		of_reserved_mem_device_release(dev);

You can call this unconditionally, no need to keep track if you called
of_reserved_mem_device_init() successfully.

> +
> +static int se_if_probe(struct platform_device *pdev)
> +{
> +	struct imx_se_node_info_list *info_list;
> +	struct device *dev = &pdev->dev;
> +	struct imx_se_node_info *info;
> +	struct se_if_priv *priv;
> +	u32 idx;
> +	int ret;
> +
> +	if (of_property_read_u32(dev->of_node, "reg", &idx)) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	info_list = (struct imx_se_node_info_list *)
> +			device_get_match_data(dev);
> +	info = get_imx_se_node_info(info_list, idx);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	/* Mailbox client configuration */
> +	priv->se_mb_cl.dev		= dev;
> +	priv->se_mb_cl.tx_block		= false;
> +	priv->se_mb_cl.knows_txdone	= true;
> +	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
> +
> +	ret = se_if_request_channel(dev, &priv->tx_chan,
> +			&priv->se_mb_cl, info->mbox_tx_name);
> +	if (ret)
> +		goto exit;
> +
> +	ret = se_if_request_channel(dev, &priv->rx_chan,
> +			&priv->se_mb_cl, info->mbox_rx_name);
> +	if (ret)
> +		goto exit;
> +
> +	priv->dev = dev;
> +	priv->info = info;
> +
> +	/* Initialize the mutex. */
> +	mutex_init(&priv->se_if_lock);
> +	mutex_init(&priv->se_if_cmd_lock);
> +
> +	priv->cmd_receiver_dev = NULL;
> +	priv->waiting_rsp_dev = NULL;
> +	priv->max_dev_ctx = info->max_dev_ctx;
> +	priv->cmd_tag = info->cmd_tag;
> +	priv->rsp_tag = info->rsp_tag;
> +	priv->mem_pool_name = info->pool_name;
> +	priv->success_tag = info->success_tag;
> +	priv->base_api_ver = info->base_api_ver;
> +	priv->fw_api_ver = info->fw_api_ver;
> +
> +	init_completion(&priv->done);
> +	spin_lock_init(&priv->lock);
> +
> +	if (info->reserved_dma_ranges) {
> +		ret = of_reserved_mem_device_init(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed to init reserved memory region %d\n",
> +				ret);
> +			priv->flags &= (~RESERVED_DMA_POOL);
> +			goto exit;
> +		}
> +		priv->flags |= RESERVED_DMA_POOL;
> +	}

Can't this be optional? Why do you need to reserve memory in the device
tree for it?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

