Return-Path: <linux-kernel+bounces-177341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B18C3D12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9DE1F20F15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684BB1474AA;
	Mon, 13 May 2024 08:21:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F1146D67
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588509; cv=none; b=W7qsM9n5YCvJzJlQMMVluh8iEYPnhsjZwP6DNWd7+AjQC9zjwmzHAhYqecGFJUh/L+Z0DW6RfSNnQHvvFmuzB/gystS6eZr6I3DBafB0pLPfvHc5GbwHONHQDKDcLuK6BwyDi1lxEHgs9g9d54dT5n9EsSzw1hDFtgr3ryTnThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588509; c=relaxed/simple;
	bh=370Z/4pVqcnUJaFTTi6fEsKjJh8phfzv2AhRGUlrOS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk9zUIJitQpw8d+FXnNbnPND7VobcKG+K7mSI9UyEUaijU7nt/JeBLtKkfe/3U5KkpfvAeL0B/X/K1nu1IGoQbPGOVtU5/C5Z1Nz1Tu5Ghham/vMSinbd3V5Y6410w8fgeXPkBd6bzMwtH59OegVEIjzDLPuzThxQwNaAsSIF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s6Qw8-0004dw-HJ; Mon, 13 May 2024 10:21:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s6Qw7-0018O1-EL; Mon, 13 May 2024 10:21:31 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s6Qw7-009QJp-17;
	Mon, 13 May 2024 10:21:31 +0200
Date: Mon, 13 May 2024 10:21:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock Enclave
Message-ID: <ZkHNixUeasNCBjMn@pengutronix.de>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, May 10, 2024 at 06:57:30PM +0530, Pankaj Gupta wrote:
> NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
> are embedded in the SoC to support the features like HSM, SHE & V2X,
> using message based communication interface.
> 
> The secure enclave FW communicates on a dedicated messaging unit(MU)
> based interface(s) with application core, where kernel is running.
> It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> 
> This patch adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
> both from:
> - User-Space Applications via character driver.
> - Kernel-space, used by kernel management layers like DM-Crypt.
> 
> ABI documentation for the NXP secure-enclave driver.

Several review comments inside, but stopping here. I just found v7 of
this series. Could it be that you have resent an older version of this
series instead of the new one??

Sascha

> 
> User-space library using this driver:
> - i.MX Secure Enclave library:
>   -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
> - i.MX Secure Middle-Ware:
>   -- URL: https://github.com/nxp-imx/imx-smw.git
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  Documentation/ABI/testing/se-cdev   |   42 ++
>  drivers/firmware/imx/Kconfig        |   12 +
>  drivers/firmware/imx/Makefile       |    2 +
>  drivers/firmware/imx/ele_base_msg.c |  287 ++++++++
>  drivers/firmware/imx/ele_base_msg.h |   70 ++
>  drivers/firmware/imx/ele_common.c   |  341 +++++++++
>  drivers/firmware/imx/ele_common.h   |   43 ++
>  drivers/firmware/imx/se_ctrl.c      | 1339 +++++++++++++++++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h      |  151 ++++
>  include/linux/firmware/imx/se_api.h |   14 +
>  include/uapi/linux/se_ioctl.h       |   88 +++
>  11 files changed, 2389 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
> new file mode 100644
> index 000000000000..699525af6b86
> --- /dev/null
> +++ b/Documentation/ABI/testing/se-cdev
> @@ -0,0 +1,42 @@
> +What:		/dev/<se>_mu[0-9]+_ch[0-9]+
> +Date:		May 2024
> +KernelVersion:	6.8
> +Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
> +Description:
> +		NXP offers multiple hardware IP(s) for  secure-enclaves like EdgeLock-
> +		Enclave(ELE), SECO. The character device file-descriptors
> +		/dev/<se>_mu*_ch* are the interface between user-space NXP's secure-
> +		enclave shared-library and the kernel driver.
> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include]<linux/firmware/imx/ele_mu_ioctl.h>
> +		 ioctl(s) are used primarily for:
> +			- shared memory management
> +			- allocation of I/O buffers
> +			- get mu info
> +			- setting a dev-ctx as receiver that is slave to fw
> +			- get SoC info
> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		  Currently the only useful flags are O_RDWR.
> +
> +		read(2)
> +		  Every read() from the opened character device context is waiting on
> +		  wakeup_intruptible, that gets set by the registered mailbox callback
> +		  function; indicating a message received from the firmware on message-
> +		  unit.
> +
> +		write(2)
> +		  Every write() to the opened character device context needs to acquire
> +		  mailbox_lock, before sending message on to the message unit.
> +
> +		close(2)
> +		  Stops and free up the I/O contexts that was associated
> +		  with the file descriptor.
> +
> +Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
> +		https://github.com/nxp-imx/imx-smw.git
> +		crypto/skcipher,
> +		drivers/nvmem/imx-ocotp-ele.c
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index 183613f82a11..56bdca9bd917 100644
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
> +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> +          like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
> +          Unit. This driver exposes these interfaces via a set of file descriptors
> +          allowing to configure shared memory, send and receive messages.
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
> index 000000000000..0463f26d93c7
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/types.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +int ele_get_info(struct device *dev, struct soc_info *s_info)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	phys_addr_t get_info_addr;
> +	u32 *get_info_data;
> +	u32 status;
> +	int ret;
> +
> +	if (!priv || !s_info)
> +		goto exit;

ret and get_info_addr are used uninitialized when jumping to the exit
label from here.

> +
> +	memset(s_info, 0x0, sizeof(*s_info));
> +
> +	if (priv->mem_pool_name)
> +		get_info_data = get_phy_buf_mem_pool(dev,
> +						     priv->mem_pool_name,
> +						     &get_info_addr,
> +						     ELE_GET_INFO_BUFF_SZ);
> +	else
> +		get_info_data = dmam_alloc_coherent(dev,
> +						    ELE_GET_INFO_BUFF_SZ,
> +						    &get_info_addr,
> +						    GFP_KERNEL);
> +	if (!get_info_data) {
> +		ret = -ENOMEM;
> +		dev_err(dev,
> +			"%s: Failed to allocate get_info_addr.\n",
> +			__func__);
> +		goto exit;
> +	}
> +
> +	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_GET_INFO_REQ,
> +				    ELE_GET_INFO_REQ_MSG_SZ,
> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = upper_32_bits(get_info_addr);

How can this work without triggering a NULL pointer exception? struct se_api_msg
is declared as:

struct se_api_msg {
	u32 header; /* u8 Tag; u8 Command; u8 Size; u8 Ver; */
	u32 *data;
};

The memory for tx_msg is kzalloced above, so *data is a NULL pointer.

> +	tx_msg->data[1] = lower_32_bits(get_info_addr);
> +	tx_msg->data[2] = ELE_GET_INFO_READ_SZ;
> +	priv->rx_msg = rx_msg;
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret  = validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_GET_INFO_REQ,
> +				ELE_GET_INFO_RSP_MSG_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_GET_INFO_REQ, status);
> +		ret = -1;

Callers seem to expect an error code. Do you intend to return -EPERM
here?

> +	}
> +
> +	s_info->imem_state = (get_info_data[ELE_IMEM_STATE_WORD]
> +				& ELE_IMEM_STATE_MASK) >> 16;
> +	s_info->major_ver = (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 24;
> +	s_info->minor_ver = ((get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 16) & 0xFF;
> +	s_info->soc_rev = (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 16;
> +	s_info->soc_id = get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_ID_MASK;
> +	s_info->serial_num
> +		= (u64)get_info_data[GET_INFO_SL_NUM_MSB_WORD_OFF] << 32
> +			| get_info_data[GET_INFO_SL_NUM_LSB_WORD_OFF];
> +exit:
> +	if (get_info_addr) {
> +		if (priv->mem_pool_name)
> +			free_phybuf_mem_pool(dev, priv->mem_pool_name,
> +					     get_info_data, ELE_GET_INFO_BUFF_SZ);
> +		else
> +			dmam_free_coherent(dev,
> +					   ELE_GET_INFO_BUFF_SZ,
> +					   get_info_data,
> +					   get_info_addr);
> +	}
> +
> +	return ret;
> +}
> +
> +int ele_ping(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	u32 status;
> +	int ret;
> +
> +	tx_msg = kzalloc(ELE_PING_REQ_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg = kzalloc(ELE_PING_RSP_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_PING_REQ, ELE_PING_REQ_SZ,
> +				    true);
> +	if (ret) {
> +		dev_err(dev, "Error: plat_fill_cmd_msg_hdr failed.\n");
> +		goto exit;
> +	}
> +
> +	priv->rx_msg = rx_msg;
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret)
> +		goto exit;
> +
> +	ret  = validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_PING_REQ,
> +				ELE_PING_RSP_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_PING_REQ, status);
> +		ret = -1;
> +	}
> +exit:
> +	return ret;
> +}
> +
> +int ele_service_swap(struct device *dev,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	u32 status;
> +	int ret;
> +
> +	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_SERVICE_SWAP_REQ,
> +				    ELE_SERVICE_SWAP_REQ_MSG_SZ,
> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = flag;
> +	tx_msg->data[1] = addr_size;
> +	tx_msg->data[2] = ELE_NONE_VAL;
> +	tx_msg->data[3] = lower_32_bits(addr);
> +	tx_msg->data[4] = plat_add_msg_crc((uint32_t *)&tx_msg[0],
> +						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
> +	priv->rx_msg = rx_msg;
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret  = validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_SERVICE_SWAP_REQ,
> +				ELE_SERVICE_SWAP_RSP_MSG_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_SERVICE_SWAP_REQ, status);
> +		ret = -1;
> +	} else {
> +		if (flag == ELE_IMEM_EXPORT)
> +			ret = priv->rx_msg->data[1];
> +		else
> +			ret = 0;
> +	}
> +exit:
> +
> +	return ret;
> +}
> +
> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	u32 status;
> +	int ret;
> +
> +	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_FW_AUTH_REQ,
> +				    ELE_FW_AUTH_REQ_SZ,
> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = addr;
> +	tx_msg->data[1] = 0x0;
> +	tx_msg->data[2] = addr;

Has this been tested? According to the documentation data[0] shall
contain the upper 32bit of the address and data[1] shall contain the
lower 32bit of the address. There is no data[2] for this call.


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

