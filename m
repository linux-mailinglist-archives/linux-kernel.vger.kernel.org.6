Return-Path: <linux-kernel+bounces-188523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC78CE302
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40501283246
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BC7129E76;
	Fri, 24 May 2024 09:07:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF9129A6D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541655; cv=none; b=iIk1zPA/8CLE7sgksAAm5oHryrLnQC8TafZq0az3iHrrKN/+4MFtxZNhC0ZuV+0hnMgeF/F1eRbubMam5PgSSzEmUo+snwzA3gBaqloq3es7SnaXI5wMjr8/UbYeAYxMI5Ri8ofw/o3dpNHpWYoFudl+YOMUCP9Q/9YF2uV7XEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541655; c=relaxed/simple;
	bh=lv56x/Pwj05wKhgpjo7zZ5okKBcAAnyUyD1nr9gEHLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN0En4LnG/asomzeZ2wdIoUbT14HyRnE4CpdGrHpZHfRUhUAHoU+WHnIXElJEeu18iWV0ZBXxWOKWPfzJcMCJ/aNdmza6CMTDOLKk06+YGB38TWHHIkVP68jpo3qvDMGt2XGsuKtn9f99MU8hFhsHBu/3SK0kVzv4S6tXXKQbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sAQtK-0005MV-Af; Fri, 24 May 2024 11:07:10 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sAQtJ-002m62-E9; Fri, 24 May 2024 11:07:09 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sAQtJ-00Bcd5-11;
	Fri, 24 May 2024 11:07:09 +0200
Date: Fri, 24 May 2024 11:07:09 +0200
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
Message-ID: <ZlBYvc0yZ7g4qnl0@pengutronix.de>
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
> index 000000000000..f072c613dba1
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -0,0 +1,286 @@
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
> +int ele_get_info(struct device *dev, struct ele_dev_info *s_info)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	phys_addr_t get_info_addr = 0;
> +	u32 *get_info_data = NULL;
> +	u32 status;
> +	int ret = 0;
> +
> +	memset(s_info, 0x0, sizeof(*s_info));
> +
> +	if (priv->mem_pool_name)
> +		get_info_data = get_phy_buf_mem_pool(dev,
> +						     priv->mem_pool_name,
> +						     &get_info_addr,
> +						     ELE_GET_INFO_BUFF_SZ);
> +	else
> +		get_info_data = dma_alloc_coherent(dev,
> +						   ELE_GET_INFO_BUFF_SZ,
> +						   &get_info_addr,
> +						   GFP_KERNEL);
> +	if (!get_info_data) {
> +		ret = -ENOMEM;
> +		dev_dbg(dev,
> +			"%s: Failed to allocate get_info_addr.\n",
> +			__func__);
> +		goto exit;
> +	}
> +
> +	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
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
> +	tx_msg->data[1] = lower_32_bits(get_info_addr);
> +	tx_msg->data[2] = sizeof(struct ele_dev_info);
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg, rx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = validate_rsp_hdr(priv,
> +			       &priv->rx_msg->header,
> +			       ELE_GET_INFO_REQ,
> +			       ELE_GET_INFO_RSP_MSG_SZ,
> +			       true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_GET_INFO_REQ, status);
> +		ret = -EPERM;
> +	}
> +
> +	memcpy(s_info, get_info_data, sizeof(struct ele_dev_info));
> +
> +exit:
> +	if (get_info_addr) {
> +		if (priv->mem_pool_name)
> +			free_phybuf_mem_pool(dev, priv->mem_pool_name,
> +					     get_info_data, ELE_GET_INFO_BUFF_SZ);
> +		else
> +			dma_free_coherent(dev,
> +					  ELE_GET_INFO_BUFF_SZ,
> +					  get_info_data,
> +					  get_info_addr);
> +	}
> +
> +	return ret;
> +}
> +
> +int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64 *serial_num)
> +{
> +	struct ele_dev_info s_info = {0};
> +	int err = 0;
> +
> +	err = ele_get_info(dev, &s_info);
> +	if (err < 0) {
> +		dev_err(dev, "Error");
> +		return err;
> +	}
> +
> +	*soc_rev = s_info.d_info.soc_rev;
> +	*serial_num = GET_SERIAL_NUM_FROM_UID(s_info.d_info.uid, MAX_UID_SIZE >> 2);
> +
> +	return err;
> +}
> +
> +int ele_ping(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	u32 status;
> +	int ret = 0;
> +
> +	tx_msg = kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
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
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg, rx_msg);
> +	if (ret)
> +		goto exit;
> +
> +	ret = validate_rsp_hdr(priv,
> +			       &priv->rx_msg->header,
> +			       ELE_PING_REQ,
> +			       ELE_PING_RSP_SZ,
> +			       true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_PING_REQ, status);
> +		ret = -EPERM;
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
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	u32 status;
> +	int ret = 0;
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
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg, rx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = validate_rsp_hdr(priv,
> +			       &priv->rx_msg->header,
> +			       ELE_SERVICE_SWAP_REQ,
> +			       ELE_SERVICE_SWAP_RSP_MSG_SZ,
> +			       true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_SERVICE_SWAP_REQ, status);
> +		ret = -EPERM;
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
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	u32 status;
> +	int ret = 0;
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
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_FW_AUTH_REQ,
> +				    ELE_FW_AUTH_REQ_SZ,
> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = addr;
> +	tx_msg->data[1] = addr >> 32;
> +	tx_msg->data[2] = addr;
> +
> +	ret = imx_ele_msg_send_rcv(priv, tx_msg, rx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = validate_rsp_hdr(priv,
> +			       &priv->rx_msg->header,
> +			       ELE_FW_AUTH_REQ,
> +			       ELE_FW_AUTH_RSP_MSG_SZ,
> +			       true);
> +	if (ret)
> +		goto exit;
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
> +			ELE_FW_AUTH_REQ, status);
> +		ret = -EPERM;
> +	}
> +exit:
> +
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/ele_base_msg.h
> new file mode 100644
> index 000000000000..f00414f9d86d
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + *
> + * Header file for the EdgeLock Enclave Base API(s).
> + */
> +
> +#ifndef ELE_BASE_MSG_H
> +#define ELE_BASE_MSG_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#define WORD_SZ				4

This define is unused

> +#define ELE_NONE_VAL			0x0
> +
> +#define ELE_SUCCESS_IND			0xD6

This define is unused, instead you have hardcoded 0xd6 constants in your
code. Either use this define or drop it.

> +
> +#define ELE_GET_INFO_REQ		0xDA
> +#define ELE_GET_INFO_REQ_MSG_SZ		0x10
> +#define ELE_GET_INFO_RSP_MSG_SZ		0x08
> +
> +#define ELE_GET_INFO_BUFF_SZ		0x100
> +
> +#define DEFAULT_IMX_SOC_VER		0xA000
> +#define SOC_VER_MASK			0xFFFF0000
> +#define SOC_ID_MASK			0x0000FFFF
> +
> +#define MAX_UID_SIZE                     (16)
> +#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
> +#define DEV_GETINFO_FW_SHA_SZ            (32)
> +#define DEV_GETINFO_OEM_SRKH_SZ          (64)
> +#define DEV_GETINFO_MIN_VER_MASK	0xFF
> +#define DEV_GETINFO_MAJ_VER_MASK	0xFF00
> +
> +struct dev_info {
> +	uint8_t  cmd;
> +	uint8_t  ver;
> +	uint16_t length;
> +	uint16_t soc_id;
> +	uint16_t soc_rev;
> +	uint16_t lmda_val;
> +	uint8_t  ssm_state;
> +	uint8_t  dev_atts_api_ver;
> +	uint8_t  uid[MAX_UID_SIZE];
> +	uint8_t  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
> +	uint8_t  sha_fw[DEV_GETINFO_FW_SHA_SZ];
> +};
> +
> +struct dev_addn_info {
> +	uint8_t  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
> +	uint8_t  trng_state;
> +	uint8_t  csal_state;
> +	uint8_t  imem_state;
> +	uint8_t  reserved2;
> +};
> +
> +struct ele_dev_info {
> +	struct dev_info d_info;
> +	struct dev_addn_info d_addn_info;
> +};
> +
> +#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
> +	(((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32 *)(x))[0])
> +
> +#define ELE_PING_REQ			0x01
> +#define ELE_PING_REQ_SZ			0x04
> +#define ELE_PING_RSP_SZ			0x08
> +
> +#define ELE_SERVICE_SWAP_REQ		0xDF
> +#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
> +#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
> +#define ELE_IMEM_SIZE			0x10000
> +#define ELE_IMEM_STATE_OK		0xCA
> +#define ELE_IMEM_STATE_BAD		0xFE
> +#define ELE_IMEM_STATE_WORD		0x27
> +#define ELE_IMEM_STATE_MASK		0x00ff0000
> +#define ELE_IMEM_EXPORT			0x1
> +#define ELE_IMEM_IMPORT			0x2
> +
> +#define ELE_FW_AUTH_REQ			0x02
> +#define ELE_FW_AUTH_REQ_SZ		0x10
> +#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
> +
> +int ele_get_info(struct device *dev, struct ele_dev_info *s_info);
> +int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64 *serial_num);
> +int ele_ping(struct device *dev);
> +int ele_service_swap(struct device *dev,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag);
> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr);
> +#endif
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> new file mode 100644
> index 000000000000..c286c3d84d82
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +u32 plat_add_msg_crc(u32 *msg, u32 msg_len)

Please use a proper function name prefix.

> +{
> +	u32 nb_words = msg_len / (u32)sizeof(u32);
> +	u32 crc = 0;
> +	u32 i;
> +
> +	for (i = 0; i < nb_words - 1; i++)
> +		crc ^= *(msg + i);
> +
> +	return crc;
> +}
> +
> +int imx_ele_msg_rcv(struct se_if_priv *priv)
> +{
> +	u32 wait;
> +	int err = 0;
> +
> +	lockdep_assert_held(&priv->se_if_cmd_lock);
> +
> +	wait = msecs_to_jiffies(1000);
> +	if (!wait_for_completion_timeout(&priv->done, wait)) {
> +		dev_err(priv->dev,
> +				"Error: wait_for_completion timed out.\n");
> +		err = -ETIMEDOUT;
> +	}
> +
> +	return err;
> +}
> +
> +int imx_ele_msg_send(struct se_if_priv *priv, void *tx_msg)
> +{
> +	struct se_msg_hdr *header;
> +	int err;
> +
> +	header = (struct se_msg_hdr *) tx_msg;
> +
> +	if (header->tag == priv->cmd_tag)
> +		lockdep_assert_held(&priv->se_if_cmd_lock);
> +
> +	scoped_guard(mutex, &priv->se_if_lock);
> +
> +	err = mbox_send_message(priv->tx_chan, tx_msg);
> +	if (err < 0) {
> +		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +		return err;
> +	}
> +
> +	return err;
> +}
> +
> +/* API used for send/receive blocking call. */
> +int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg)
> +{
> +	int err;
> +
> +	scoped_guard(mutex, &priv->se_if_cmd_lock);
> +	if (priv->waiting_rsp_dev) {
> +		dev_warn(priv->dev,
> +			"There should be no misc dev-ctx, waiting for resp.\n");
> +		priv->waiting_rsp_dev = NULL;
> +	}
> +	priv->rx_msg = rx_msg;
> +	err = imx_ele_msg_send(priv, tx_msg);
> +	if (err < 0)
> +		goto exit;
> +
> +	err = imx_ele_msg_rcv(priv);
> +
> +exit:
> +	return err;
> +}
> +
> +/*
> + * Callback called by mailbox FW, when data is received.
> + */
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
> +{
> +	struct device *dev = mbox_cl->dev;
> +	struct se_if_priv *priv;
> +	struct se_msg_hdr *header;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	/* The function can be called with NULL msg */
> +	if (!msg) {
> +		dev_err(dev, "Message is invalid\n");
> +		return;
> +	}
> +
> +	header = (struct se_msg_hdr *) msg;
> +
> +	if (header->tag == priv->rsp_tag) {
> +		if (!priv->waiting_rsp_dev) {
> +			/*
> +			 * Reading the EdgeLock Enclave response
> +			 * to the command, sent by other
> +			 * linux kernel services.
> +			 */
> +			spin_lock(&priv->lock);
> +			memcpy(priv->rx_msg, msg, header->size << 2);
> +
> +			complete(&priv->done);
> +			spin_unlock(&priv->lock);
> +			return;
> +		}
> +	} else {
> +		dev_err(dev, "Failed to select a device for message: %.8x\n",
> +				*((u32 *) header));
> +		return;
> +	}
> +}
> +
> +int validate_rsp_hdr(struct se_if_priv *priv,
> +		     struct se_msg_hdr *header,
> +		     uint8_t msg_id,
> +		     uint8_t sz,
> +		     bool is_base_api)
> +{
> +	int ret = -EINVAL;
> +
> +	if (header->tag != priv->rsp_tag) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
> +			msg_id, header->tag, priv->rsp_tag);
> +		return ret;

Just return -EINVAL. Drop the variable 'ret' entirely from this
function.

> +	}
> +
> +	if (header->command != msg_id) {
> +		dev_err(priv->dev,
> +			"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
> +			header->command, msg_id);
> +		return ret;
> +	}
> +
> +	if (header->size != (sz >> 2)) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
> +			msg_id, header->size, (sz >> 2));
> +		return ret;
> +	}
> +
> +	if (is_base_api && (header->ver != priv->base_api_ver)) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
> +			msg_id, header->ver, priv->base_api_ver);
> +		return ret;
> +	} else if (!is_base_api && header->ver != priv->fw_api_ver) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
> +			msg_id, header->ver, priv->fw_api_ver);
> +		return ret;
> +	}
> +
> +	ret = 0;
> +
> +	return ret;
> +}
> +
> +int se_save_imem_state(struct device *dev)

This function is used internally by the driver code. It should take a
struct struct se_if_priv * directly here. Same applies for several
other functions in this patch.

> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* EXPORT command will save encrypted IMEM to given address,
> +	 * so later in resume, IMEM can be restored from the given
> +	 * address.
> +	 *
> +	 * Size must be at least 64 kB.
> +	 */
> +	ret = ele_service_swap(dev,
> +			       priv->imem.phyaddr,
> +			       ELE_IMEM_SIZE,
> +			       ELE_IMEM_EXPORT);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to export IMEM\n");
> +	else
> +		dev_info(dev,
> +			"Exported %d bytes of encrypted IMEM\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +int se_restore_imem_state(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct ele_dev_info s_info;
> +	int ret;
> +
> +	/* get info from ELE */
> +	ret = ele_get_info(dev, &s_info);
> +	if (ret) {
> +		dev_err(dev, "Failed to get info from ELE.\n");
> +		return ret;
> +	}
> +
> +	/* Get IMEM state, if 0xFE then import IMEM */
> +	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD) {
> +		/* IMPORT command will restore IMEM from the given
> +		 * address, here size is the actual size returned by ELE
> +		 * during the export operation
> +		 */
> +		ret = ele_service_swap(dev,
> +				       priv->imem.phyaddr,
> +				       priv->imem.size,
> +				       ELE_IMEM_IMPORT);
> +		if (ret) {
> +			dev_err(dev, "Failed to import IMEM\n");
> +			goto exit;
> +		}
> +	} else
> +		goto exit;
> +
> +	/* After importing IMEM, check if IMEM state is equal to 0xCA
> +	 * to ensure IMEM is fully loaded and
> +	 * ELE functionality can be used.
> +	 */
> +	ret = ele_get_info(dev, &s_info);
> +	if (ret) {
> +		dev_err(dev, "Failed to get info from ELE.\n");
> +		goto exit;
> +	}
> +
> +	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_OK)
> +		dev_info(dev, "Successfully restored IMEM\n");
> +	else
> +		dev_err(dev, "Failed to restore IMEM\n");
> +
> +exit:
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
> new file mode 100644
> index 000000000000..76777ac629d6
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_common.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +
> +#ifndef __ELE_COMMON_H__
> +#define __ELE_COMMON_H__
> +
> +#include "se_ctrl.h"
> +
> +#define IMX_ELE_FW_DIR                 "imx/ele/"
> +
> +uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len);
> +int imx_ele_msg_rcv(struct se_if_priv *priv);
> +int imx_ele_msg_send(struct se_if_priv *priv, void *tx_msg);
> +int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg);
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
> +int validate_rsp_hdr(struct se_if_priv *priv,
> +		     struct se_msg_hdr *header,
> +		     uint8_t msg_id,
> +		     uint8_t sz,
> +		     bool is_base_api);
> +
> +/* Fill a command message header with a given command ID and length in bytes. */
> +static inline int plat_fill_cmd_msg_hdr(struct se_if_priv *priv,
> +					struct se_msg_hdr *hdr,
> +					u8 cmd,
> +					u32 len,
> +					bool is_base_api)
> +{
> +	hdr->tag = priv->cmd_tag;
> +	hdr->ver = (is_base_api) ? priv->base_api_ver : priv->fw_api_ver;
> +	hdr->command = cmd;
> +	hdr->size = len >> 2;
> +
> +	return 0;
> +}
> +
> +int se_save_imem_state(struct device *dev);
> +int se_restore_imem_state(struct device *dev);
> +
> +#endif /*__ELE_COMMON_H__ */
> diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
> new file mode 100644
> index 000000000000..0642d349b3d3
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.c
> @@ -0,0 +1,531 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/firmware.h>
> +#include <linux/firmware/imx/se_api.h>
> +#include <linux/genalloc.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +#include "se_ctrl.h"
> +
> +#define RESERVED_DMA_POOL		BIT(0)
> +
> +struct imx_se_node_info {
> +	u8 se_if_id;
> +	u8 se_if_did;
> +	u8 max_dev_ctx;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +	u8 *se_name;
> +	u8 *mbox_tx_name;
> +	u8 *mbox_rx_name;
> +	u8 *pool_name;
> +	u8 *fw_name_in_rfs;
> +	bool soc_register;
> +	bool reserved_dma_ranges;
> +	bool imem_mgmt;
> +	int (*se_fetch_soc_info)(struct device *dev, u16 *soc_rev, u64 *serial_num);
> +};
> +
> +struct imx_se_node_info_list {
> +	u8 num_mu;
> +	u16 soc_id;
> +	struct imx_se_node_info info[];
> +};
> +
> +static const struct imx_se_node_info_list imx8ulp_info = {
> +	.num_mu = 1,
> +	.soc_id = SOC_ID_OF_IMX8ULP,
> +	.info = {
> +			{
> +				.se_if_id = 2,
> +				.se_if_did = 7,
> +				.max_dev_ctx = 4,
> +				.cmd_tag = 0x17,
> +				.rsp_tag = 0xe1,
> +				.success_tag = 0xd6,
> +				.base_api_ver = MESSAGING_VERSION_6,
> +				.fw_api_ver = MESSAGING_VERSION_7,
> +				.se_name = "hsm1",
> +				.mbox_tx_name = "tx",
> +				.mbox_rx_name = "rx",
> +				.pool_name = "sram",
> +				.fw_name_in_rfs = IMX_ELE_FW_DIR
> +						  "mx8ulpa2ext-ahab-container.img",
> +				.soc_register = true,
> +				.reserved_dma_ranges = true,
> +				.imem_mgmt = true,
> +				.se_fetch_soc_info = ele_fetch_soc_info,
> +			},

Indentation level is one too deep here.

> +	},
> +};
> +
> +static const struct imx_se_node_info_list imx93_info = {
> +	.num_mu = 1,
> +	.soc_id = SOC_ID_OF_IMX93,
> +	.info = {
> +			{
> +				.se_if_id = 2,
> +				.se_if_did = 3,
> +				.max_dev_ctx = 4,
> +				.cmd_tag = 0x17,
> +				.rsp_tag = 0xe1,
> +				.success_tag = 0xd6,
> +				.base_api_ver = MESSAGING_VERSION_6,
> +				.fw_api_ver = MESSAGING_VERSION_7,
> +				.se_name = "hsm1",
> +				.mbox_tx_name = "tx",
> +				.mbox_rx_name = "rx",
> +				.reserved_dma_ranges = true,
> +				.imem_mgmt = true,
> +				.soc_register = true,
> +			},

Drop all fields from this struct that are common to all currently
supported SoCs. You can always re-add them later when actually needed.
This will make your code easier to review.

> +	},
> +};
> +
> +static const struct of_device_id se_match[] = {
> +	{ .compatible = "fsl,imx8ulp-ele", .data = (void *)&imx8ulp_info},
> +	{ .compatible = "fsl,imx93-ele", .data = (void *)&imx93_info},
> +	{},
> +};
> +
> +static struct imx_se_node_info
> +		*get_imx_se_node_info(struct imx_se_node_info_list *info_list,
> +				      const u32 idx)
> +{
> +	if (idx > info_list->num_mu)
> +		return NULL;
> +
> +	return &info_list->info[idx];
> +}
> +
> +void *get_phy_buf_mem_pool(struct device *dev,
> +			   u8 *mem_pool_name,
> +			   dma_addr_t *buf,
> +			   u32 size)
> +{
> +	struct device_node *of_node = dev->of_node;
> +	struct gen_pool *mem_pool;
> +
> +	mem_pool = of_gen_pool_get(of_node, mem_pool_name, 0);
> +	if (!mem_pool) {
> +		dev_err(dev,
> +			"Unable to get sram pool = %s\n",
> +			mem_pool_name);
> +		return 0;
> +	}
> +
> +	return gen_pool_dma_alloc(mem_pool, size, buf);
> +}
> +
> +void free_phybuf_mem_pool(struct device *dev,
> +			  u8 *mem_pool_name,
> +			  u32 *buf,
> +			  u32 size)
> +{
> +	struct device_node *of_node = dev->of_node;
> +	struct gen_pool *mem_pool;
> +
> +	mem_pool = of_gen_pool_get(of_node, mem_pool_name, 0);
> +	if (!mem_pool)
> +		dev_err(dev,
> +			"%s: Failed: Unable to get sram pool.\n",
> +			__func__);
> +
> +	gen_pool_free(mem_pool, (u64)buf, size);
> +}
> +
> +static int imx_fetch_se_soc_info(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct imx_se_node_info_list *info_list;
> +	const struct imx_se_node_info *info;
> +	struct soc_device_attribute *attr;
> +	struct soc_device *sdev;
> +	u64 serial_num;
> +	u16 soc_rev;
> +	int err = 0;
> +
> +	info = priv->info;
> +	info_list = (struct imx_se_node_info_list *)
> +				device_get_match_data(dev);
> +
> +	/* This function should be called once.
> +	 * Check if the soc_rev is zero to continue.
> +	 */
> +	if (priv->soc_rev)
> +		return err;
> +
> +	err = info->se_fetch_soc_info(dev, &soc_rev, &serial_num);
> +	if (err < 0) {
> +		dev_err(dev, "Failed to fetch SoC Info.");
> +		return err;
> +	}
> +
> +	priv->soc_rev = soc_rev;
> +	if (!info->soc_register)
> +		return 0;
> +
> +	attr = devm_kzalloc(dev, sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, soc_rev))
> +		attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%x.%x",
> +						FIELD_GET(DEV_GETINFO_MIN_VER_MASK,
> +							  soc_rev),
> +						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
> +							  soc_rev));
> +	else
> +		attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%x",
> +						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
> +							  soc_rev));
> +
> +	switch (info_list->soc_id) {
> +	case SOC_ID_OF_IMX8ULP:
> +		attr->soc_id = devm_kasprintf(dev, GFP_KERNEL,
> +					      "i.MX8ULP");
> +		break;
> +	case SOC_ID_OF_IMX93:
> +		attr->soc_id = devm_kasprintf(dev, GFP_KERNEL,
> +					      "i.MX93");
> +		break;
> +	}
> +
> +	err = of_property_read_string(of_root, "model",
> +				      &attr->machine);
> +	if (err)
> +		return -EINVAL;
> +
> +	attr->family = devm_kasprintf(dev, GFP_KERNEL, "Freescale i.MX");
> +
> +	attr->serial_number
> +		= devm_kasprintf(dev, GFP_KERNEL, "%016llX", serial_num);
> +
> +	sdev = soc_device_register(attr);
> +	if (IS_ERR(sdev))
> +		return PTR_ERR(sdev);
> +
> +	return 0;
> +}
> +
> +/* interface for managed res to free a mailbox channel */
> +static void if_mbox_free_channel(void *mbox_chan)
> +{
> +	mbox_free_channel(mbox_chan);
> +}
> +
> +static int se_if_request_channel(struct device *dev,
> +				 struct mbox_chan **chan,
> +				 struct mbox_client *cl,
> +				 const char *name)
> +{
> +	struct mbox_chan *t_chan;
> +	int ret = 0;
> +
> +	t_chan = mbox_request_channel_byname(cl, name);
> +	if (IS_ERR(t_chan)) {
> +		ret = PTR_ERR(t_chan);
> +		return dev_err_probe(dev, ret,
> +				     "Failed to request %s channel.", name);
> +	}
> +
> +	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
> +	if (ret) {
> +		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
> +		goto exit;
> +	}
> +
> +	*chan = t_chan;
> +
> +exit:
> +	return ret;
> +}
> +
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

This can't happen. Drop the check and let this function return void.

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
> +		priv->flags &= (~RESERVED_DMA_POOL);
> +	}
> +
> +	return ret;
> +}
> +
> +static void se_load_firmware(const struct firmware *fw, void *context)
> +{
> +	struct se_if_priv *priv = (struct se_if_priv *) context;
> +	const struct imx_se_node_info *info = priv->info;
> +	const u8 *se_fw_name = info->fw_name_in_rfs;
> +	phys_addr_t se_fw_phyaddr;
> +	u8 *se_fw_buf;
> +
> +	if (!fw) {
> +		if (priv->fw_fail > MAX_FW_LOAD_RETRIES)
> +			dev_dbg(priv->dev,
> +				 "External FW not found, using ROM FW.\n");
> +		else {
> +			/*add a bit delay to wait for firmware priv released */
> +			msleep(20);
> +
> +			/* Load firmware one more time if timeout */
> +			request_firmware_nowait(THIS_MODULE,
> +					FW_ACTION_UEVENT, info->fw_name_in_rfs,
> +					priv->dev, GFP_KERNEL, priv,
> +					se_load_firmware);
> +			priv->fw_fail++;
> +			dev_dbg(priv->dev, "Value of retries = 0x%x.\n",
> +				priv->fw_fail);
> +		}

What's the point of retrying this? It won't succeed when it failed once,
no?
Besides, calling request_firmware_nowait() in the completion callback of
that very same function looks strange.

> +
> +		return;
> +	}
> +
> +	/* allocate buffer to store the SE FW */
> +	se_fw_buf = dmam_alloc_coherent(priv->dev, fw->size,
> +					 &se_fw_phyaddr,
> +					 GFP_KERNEL);

Use unmanaged dma_alloc_coherent().


> +	if (!se_fw_buf) {
> +		dev_err(priv->dev, "Failed to alloc SE fw buffer memory\n");
> +		goto exit;

No need to free it when you weren't able to allocate it.

> +	}
> +
> +	memcpy(se_fw_buf, fw->data, fw->size);
> +
> +	if (ele_fw_authenticate(priv->dev, se_fw_phyaddr))
> +		dev_err(priv->dev,
> +			"Failed to authenticate & load SE firmware %s.\n",
> +			se_fw_name);
> +
> +exit:
> +	dmam_free_coherent(priv->dev,
> +			   fw->size,
> +			   se_fw_buf,
> +			   se_fw_phyaddr);
> +
> +	release_firmware(fw);
> +}
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

get_imx_se_node_info() can return NULL. You should catch this here.

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

This comment doesn't provide any useful information.

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

priv->flags is still 0. You just allocated it.

> +			goto exit;
> +		}
> +		priv->flags |= RESERVED_DMA_POOL;
> +	}
> +
> +	if (info->fw_name_in_rfs) {
> +		ret = request_firmware_nowait(THIS_MODULE,
> +					      FW_ACTION_UEVENT,
> +					      info->fw_name_in_rfs,
> +					      dev, GFP_KERNEL, priv,
> +					      se_load_firmware);
> +		if (ret)
> +			dev_warn(dev, "Failed to get firmware [%s].\n",
> +				 info->fw_name_in_rfs);
> +	}
> +
> +	ret = imx_fetch_se_soc_info(dev);
> +	if (ret) {
> +		dev_err(dev,
> +			"failed[%pe] to fetch SoC Info\n", ERR_PTR(ret));
> +		goto exit;
> +	}
> +
> +	if (info->imem_mgmt) {
> +		/* allocate buffer where SE store encrypted IMEM */
> +		priv->imem.buf = dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
> +						     &priv->imem.phyaddr,
> +						     GFP_KERNEL);
> +		if (!priv->imem.buf) {
> +			dev_err(dev,
> +				"dmam-alloc-failed: To store encr-IMEM.\n");
> +			ret = -ENOMEM;
> +			goto exit;
> +		}
> +	}
> +
> +	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
> +		 info->se_name);
> +	return devm_of_platform_populate(dev);

What is this good for?

> +
> +exit:
> +	/* if execution control reaches here, if probe fails.
> +	 * hence doing the cleanup
> +	 */
> +	if (se_probe_if_cleanup(pdev))
> +		dev_err(dev,
> +			"Failed to clean-up the child node probe.\n");
> +
> +	return ret;
> +}
> +
> +static int se_remove(struct platform_device *pdev)
> +{
> +	if (se_probe_if_cleanup(pdev))
> +		dev_err(&pdev->dev,
> +			"i.MX Secure Enclave is not cleanly un-probed.");
> +
> +	return 0;
> +}
> +
> +static int se_suspend(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	const struct imx_se_node_info *info
> +					= priv->info;
> +
> +	if (info && info->imem_mgmt)
> +		priv->imem.size = se_save_imem_state(dev);

imem.size has type u32. se_save_imem_state() might return an error code.
You use imem.size as third argument to ele_service_swap(). This looks
fishy.

> +
> +	return 0;
> +}
> +
> +static int se_resume(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	const struct imx_se_node_info *info
> +					= priv->info;
> +
> +	if (info && info->imem_mgmt)
> +		se_restore_imem_state(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops se_pm = {
> +	RUNTIME_PM_OPS(se_suspend, se_resume, NULL)
> +};
> +
> +static struct platform_driver se_driver = {
> +	.driver = {
> +		.name = "fsl-se-fw",
> +		.of_match_table = se_match,
> +		.pm = &se_pm,
> +	},
> +	.probe = se_if_probe,
> +	.remove = se_remove,
> +};
> +MODULE_DEVICE_TABLE(of, se_match);
> +
> +module_platform_driver(se_driver);
> +
> +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> +MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
> new file mode 100644
> index 000000000000..7d4f439a6158
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef SE_MU_H
> +#define SE_MU_H
> +
> +#include <linux/miscdevice.h>
> +#include <linux/semaphore.h>
> +#include <linux/mailbox_client.h>
> +
> +#define MAX_FW_LOAD_RETRIES		50
> +
> +#define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
> +#define MESSAGING_VERSION_6		0x6
> +#define MESSAGING_VERSION_7		0x7
> +
> +struct se_imem_buf {
> +	u8 *buf;
> +	phys_addr_t phyaddr;
> +	u32 size;
> +};
> +
> +/* Header of the messages exchange with the EdgeLock Enclave */
> +struct se_msg_hdr {
> +	u8 ver;
> +	u8 size;
> +	u8 command;
> +	u8 tag;
> +}  __packed;
> +
> +#define SE_MU_HDR_SZ	4
> +
> +struct se_api_msg {
> +	struct se_msg_hdr header;
> +	u32 data[];
> +};
> +
> +struct se_if_priv {
> +	struct se_if_device_ctx *cmd_receiver_dev;
> +	/* Update to the waiting_rsp_dev, to be protected
> +	 * under se_if_lock.
> +	 */
> +	struct se_if_device_ctx *waiting_rsp_dev;
> +	/*
> +	 * prevent parallel access to the se interface registers
> +	 * e.g. a user trying to send a command while the other one is
> +	 * sending a response.
> +	 */
> +	struct mutex se_if_lock;
> +	/*
> +	 * prevent a command to be sent on the se interface while another one is
> +	 * still processing. (response to a command is allowed)
> +	 */
> +	struct mutex se_if_cmd_lock;
> +	struct device *dev;
> +	u8 *mem_pool_name;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +	u32 fw_fail;
> +	u16 soc_rev;
> +	const void *info;
> +
> +	struct mbox_client se_mb_cl;
> +	struct mbox_chan *tx_chan, *rx_chan;
> +
> +	/* Assignment of the rx_msg buffer to held till the
> +	 * received content as part callback function, is copied.
> +	 */
> +	struct se_api_msg *rx_msg;
> +	struct completion done;
> +	spinlock_t lock;
> +	/*
> +	 * Flag to retain the state of initialization done at
> +	 * the time of se-if probe.
> +	 */
> +	uint32_t flags;
> +	u8 max_dev_ctx;
> +	struct se_if_device_ctx **ctxs;
> +	struct se_imem_buf imem;
> +};
> +
> +void *get_phy_buf_mem_pool(struct device *dev,
> +			   u8 *mem_pool_name,
> +			   dma_addr_t *buf,
> +			   u32 size);
> +phys_addr_t get_phy_buf_mem_pool1(struct device *dev,
> +				 u8 *mem_pool_name,
> +				 u32 **buf,
> +				 u32 size);

This function is never defined.

> +void free_phybuf_mem_pool(struct device *dev,
> +			  u8 *mem_pool_name,
> +			  u32 *buf,
> +			  u32 size);
> +#endif
> diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware/imx/se_api.h
> new file mode 100644
> index 000000000000..c47f84906837
> --- /dev/null
> +++ b/include/linux/firmware/imx/se_api.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __SE_API_H__
> +#define __SE_API_H__
> +
> +#include <linux/types.h>
> +
> +#define SOC_ID_OF_IMX8ULP		0x084D
> +#define SOC_ID_OF_IMX93			0x9300
> +
> +#endif /* __SE_API_H__ */
> 
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

