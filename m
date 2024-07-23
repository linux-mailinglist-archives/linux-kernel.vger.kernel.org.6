Return-Path: <linux-kernel+bounces-260079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C304D93A2B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC001C22C45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA5154455;
	Tue, 23 Jul 2024 14:28:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406F14A4E7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744920; cv=none; b=n2ya3W/Gzw//tORzhvs0a2eMDykeudaTC2QuunvJ4JXzbrzEcMtZvjlqmxWtGqXWBCYsIy8/t/QRZeKe/kuk2naanz8AX92VXC5W2hUUQ25dHS/g+B35r1Iv0TvlXFasaevCmAjRCTBy+DU2Mddd7bh2LW2m4WZGAyqOZPbOxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744920; c=relaxed/simple;
	bh=6T/L5bxZz2nawLXtFCkHwUzGg9UXP3OG/DekgRv9/6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC0VEGNH76iual2KfauuXM9P7i5HXk8cfcjZB3zf0OOdvlN1PW5q5/yf8NWeW/Shz6KieV5jcXU9zLrFZHmDsJ6bx5jRIloeUH82YpjSvhhR/E7Ipm+bEKfxGBTb983UgjNq2WUmXlqQkb5wBgKsh9SDmFjH55bRyLMlpxyVaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sWGV9-0000Wv-Hs; Tue, 23 Jul 2024 16:28:27 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sWGV8-001dfw-HI; Tue, 23 Jul 2024 16:28:26 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sWGV8-00DU4q-1L;
	Tue, 23 Jul 2024 16:28:26 +0200
Date: Tue, 23 Jul 2024 16:28:26 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
Message-ID: <Zp--Co8teXBO95QO@pengutronix.de>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-4-ee26a87b824a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-imx-se-if-v6-4-ee26a87b824a@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2024 at 10:21:39AM +0530, Pankaj Gupta wrote:
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
>  drivers/firmware/imx/ele_base_msg.c | 274 +++++++++++++++++++
>  drivers/firmware/imx/ele_base_msg.h |  95 +++++++
>  drivers/firmware/imx/ele_common.c   | 264 ++++++++++++++++++
>  drivers/firmware/imx/ele_common.h   |  44 +++
>  drivers/firmware/imx/se_ctrl.c      | 528 ++++++++++++++++++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h      |  87 ++++++
>  include/linux/firmware/imx/se_api.h |  14 +
>  9 files changed, 1320 insertions(+)
> 
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index 183613f82a11..0f6877a24f0b 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -22,3 +22,15 @@ config IMX_SCU
>  
>  	  This driver manages the IPC interface between host CPU and the
>  	  SCU firmware running on M4.
> +
> +config IMX_SEC_ENCLAVE
> +	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
> +	depends on IMX_MBOX && ARCH_MXC && ARM64
> +	default m if ARCH_MXC
> +
> +	help
> +	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
> +	  - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> +	    like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
> +	    Unit. This driver exposes these interfaces via a set of file descriptors
> +	    allowing to configure shared memory, send and receive messages.
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 8f9f04a513a8..aa9033e0e9e3 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
> +sec_enclave-objs		= se_ctrl.o ele_common.o ele_base_msg.o
> +obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
> diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
> new file mode 100644
> index 000000000000..7f16184a8b10
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/types.h>
> +
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/genalloc.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +int ele_get_info(struct device *dev, struct ele_dev_info *s_info)

I still think it's a bad idea to use some arbitrary struct device * as
context pointer here. Users will be confused which device is expected
here and bad things happen in case it's the wrong one.

You should rather implement some ele_get() function which returns some
pointer to be used as a context pointer here.

> +int ele_service_swap(struct device *dev,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int ret = 0;
> +
> +	if (!priv) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +	priv->rx_msg_sz = ELE_SERVICE_SWAP_RSP_MSG_SZ;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				      (struct se_msg_hdr *)&tx_msg->header,
> +				      ELE_SERVICE_SWAP_REQ,
> +				      ELE_SERVICE_SWAP_REQ_MSG_SZ, true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = flag;
> +	tx_msg->data[1] = addr_size;
> +	tx_msg->data[2] = ELE_NONE_VAL;
> +	tx_msg->data[3] = lower_32_bits(addr);

addr could be a 64bit address. Either handle this properly or return an
error when addr doesn't fit into 32bit.

> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int ret = 0;
> +
> +	if (!priv) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +	priv->rx_msg_sz = ELE_FW_AUTH_RSP_MSG_SZ;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				  (struct se_msg_hdr *)&tx_msg->header,
> +				  ELE_FW_AUTH_REQ,
> +				  ELE_FW_AUTH_REQ_SZ,
> +				  true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[1] = upper_32_bits(addr);
> +	tx_msg->data[0] = lower_32_bits(addr);
> +	tx_msg->data[2] = addr;

Same here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

