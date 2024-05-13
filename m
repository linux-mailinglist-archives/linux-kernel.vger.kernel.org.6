Return-Path: <linux-kernel+bounces-177477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B0C8C3F54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F0EB239C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64914AD0C;
	Mon, 13 May 2024 10:54:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185EB14A63D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597694; cv=none; b=k1OS/xU/FLOgMAB7I+0G5LvQKPFdpasXeWLO2gymWV+pnq02iRJ7maVkBVZtQIHQBIl0ZalnGLX3FjjJcTr5DPM0gNOTEBqbr3GLFVNI0jmMOJajhNi+ZJcggGuUEd3dQWAKBN753AOUR0wcsW6goub/U01a/JGb0+ujSxYX9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597694; c=relaxed/simple;
	bh=/2nlH6F8/VYhu2kHmoLWzhhsMhic92yJDwKhn1LBE48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXX31VE+liHgN+jnEgAa3I+8FOTzBkWFvB+bAKM8RBwWpWLAddjGH3aLwiSh4nkh4zHOe30iOdG0f/GUWhq8nCUg7EifMlBesGExHh3YA5W9AuAxH/jNRjM/7IIxtn4AabH44hanYS6b/Q2IKmVTzsmYm/oHgzTc0bM6hMZ8yRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s6TJv-0006fG-1l; Mon, 13 May 2024 12:54:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s6TJu-0019WG-2o; Mon, 13 May 2024 12:54:14 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 95EB62D071E;
	Mon, 13 May 2024 10:54:13 +0000 (UTC)
Date: Mon, 13 May 2024 12:54:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock Enclave
Message-ID: <20240513-pretty-quartz-lemming-14d9ea-mkl@pengutronix.de>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="syriwlvtoupopku6"
Content-Disposition: inline
In-Reply-To: <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--syriwlvtoupopku6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.05.2024 18:57:30, Pankaj Gupta wrote:
> NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
> are embedded in the SoC to support the features like HSM, SHE & V2X,
> using message based communication interface.
>=20
> The secure enclave FW communicates on a dedicated messaging unit(MU)
> based interface(s) with application core, where kernel is running.
> It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
>=20
> This patch adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock En=
clave,
> both from:
> - User-Space Applications via character driver.
> - Kernel-space, used by kernel management layers like DM-Crypt.
>=20
> ABI documentation for the NXP secure-enclave driver.

Can you add the user space misc dev in a different patch?

>=20
> User-space library using this driver:
> - i.MX Secure Enclave library:
>   -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
> - i.MX Secure Middle-Ware:
>   -- URL: https://github.com/nxp-imx/imx-smw.git
>=20
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  Documentation/ABI/testing/se-cdev   |   42 ++
>  drivers/firmware/imx/Kconfig        |   12 +
>  drivers/firmware/imx/Makefile       |    2 +
>  drivers/firmware/imx/ele_base_msg.c |  287 ++++++++
>  drivers/firmware/imx/ele_base_msg.h |   70 ++
>  drivers/firmware/imx/ele_common.c   |  341 +++++++++
>  drivers/firmware/imx/ele_common.h   |   43 ++
>  drivers/firmware/imx/se_ctrl.c      | 1339 +++++++++++++++++++++++++++++=
++++++
>  drivers/firmware/imx/se_ctrl.h      |  151 ++++
>  include/linux/firmware/imx/se_api.h |   14 +
>  include/uapi/linux/se_ioctl.h       |   88 +++
>  11 files changed, 2389 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testin=
g/se-cdev
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
> =20
>  	  This driver manages the IPC interface between host CPU and the
>  	  SCU firmware running on M4.
> +
> +config IMX_SEC_ENCLAVE
> +	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driv=
er."
> +	depends on IMX_MBOX && ARCH_MXC && ARM64
> +	default m if ARCH_MXC
> +
> +	help
> +	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP ca=
lled:
> +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> +          like base, HSM, V2X & SHE using the SAB protocol via the share=
d Messaging
> +          Unit. This driver exposes these interfaces via a set of file d=
escriptors
> +          allowing to configure shared memory, send and receive messages.
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 8f9f04a513a8..aa9033e0e9e3 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IMX_DSP)		+=3D imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+=3D imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-=
soc.o
> +sec_enclave-objs		=3D se_ctrl.o ele_common.o ele_base_msg.o
> +obj-${CONFIG_IMX_SEC_ENCLAVE}	+=3D sec_enclave.o
> diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/e=
le_base_msg.c
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
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	phys_addr_t get_info_addr;
> +	u32 *get_info_data;
> +	u32 status;
> +	int ret;
> +
> +	if (!priv || !s_info)
> +		goto exit;

You should code properly, so that this doesn't happen, your cleanup is
broken, it will work on uninitialized data, as Sascha already mentioned.

> +
> +	memset(s_info, 0x0, sizeof(*s_info));
> +
> +	if (priv->mem_pool_name)
> +		get_info_data =3D get_phy_buf_mem_pool(dev,
> +						     priv->mem_pool_name,
> +						     &get_info_addr,
> +						     ELE_GET_INFO_BUFF_SZ);
> +	else
> +		get_info_data =3D dmam_alloc_coherent(dev,
> +						    ELE_GET_INFO_BUFF_SZ,
> +						    &get_info_addr,
> +						    GFP_KERNEL);

It's better style to move the init of the dma memory into the probe
function.

> +	if (!get_info_data) {
> +		ret =3D -ENOMEM;
> +		dev_err(dev,
> +			"%s: Failed to allocate get_info_addr.\n",
> +			__func__);
> +		goto exit;
> +	}
> +
> +	tx_msg =3D kzalloc(ELE_GET_INFO_REQ_MSG_SZ << 2, GFP_KERNEL);
                         ^^^^^^^^^^^^^^^^^^^^^^^

Is ELE_GET_INFO_REQ_MSG_SZ is in multiple of u32?

> +	if (!tx_msg) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg =3D kzalloc(ELE_GET_INFO_RSP_MSG_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret =3D plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_GET_INFO_REQ,
> +				    ELE_GET_INFO_REQ_MSG_SZ,

Here you feed in ELE_GET_INFO_REQ_MSG_SZ and in plat_fill_cmd_msg_hdr()
you use "len >> 2". This look quite strange to me. Better use length in
bytes everywhere.

> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] =3D upper_32_bits(get_info_addr);
> +	tx_msg->data[1] =3D lower_32_bits(get_info_addr);
> +	tx_msg->data[2] =3D ELE_GET_INFO_READ_SZ;

Can you use a proper struct for this. Sascha has already commented on
the null pointer here.

> +	priv->rx_msg =3D rx_msg;
> +	ret =3D imx_ele_msg_send_rcv(priv, tx_msg);

This API looks strange, why put the tx_msg as a parameter the rx_msg
into the private struct?

> +	if (ret < 0)
> +		goto exit;
> +
> +	ret  =3D validate_rsp_hdr(priv,
           ^^
single space
> +				priv->rx_msg->header,
> +				ELE_GET_INFO_REQ,
> +				ELE_GET_INFO_RSP_MSG_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status =3D RES_STATUS(priv->rx_msg->data[0]);

use FIELD_GET()

> +	if (status !=3D priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> +			ELE_GET_INFO_REQ, status);
> +		ret =3D -1;
> +	}
> +
> +	s_info->imem_state =3D (get_info_data[ELE_IMEM_STATE_WORD]
> +				& ELE_IMEM_STATE_MASK) >> 16;

can you use a struct for get_info_data and use FIELD_GET() (if needed)

> +	s_info->major_ver =3D (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 24;
> +	s_info->minor_ver =3D ((get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 16) & 0xFF;
> +	s_info->soc_rev =3D (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 16;
> +	s_info->soc_id =3D get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_ID_MASK;
> +	s_info->serial_num
> +		=3D (u64)get_info_data[GET_INFO_SL_NUM_MSB_WORD_OFF] << 32
> +			| get_info_data[GET_INFO_SL_NUM_LSB_WORD_OFF];

The "|" goes to the end of the previous line.

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
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	u32 status;
> +	int ret;
> +
> +	tx_msg =3D kzalloc(ELE_PING_REQ_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg =3D kzalloc(ELE_PING_RSP_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret =3D plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_PING_REQ, ELE_PING_REQ_SZ,
> +				    true);
> +	if (ret) {
> +		dev_err(dev, "Error: plat_fill_cmd_msg_hdr failed.\n");
> +		goto exit;
> +	}
> +
> +	priv->rx_msg =3D rx_msg;
> +	ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret)
> +		goto exit;
> +
> +	ret  =3D validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_PING_REQ,
> +				ELE_PING_RSP_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status =3D RES_STATUS(priv->rx_msg->data[0]);
> +	if (status !=3D priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> +			ELE_PING_REQ, status);
> +		ret =3D -1;
> +	}
> +exit:
> +	return ret;
> +}
> +
> +int ele_service_swap(struct device *dev,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag)
> +{
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	u32 status;
> +	int ret;
> +
> +	tx_msg =3D kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg =3D kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}
> +
> +	ret =3D plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_SERVICE_SWAP_REQ,
> +				    ELE_SERVICE_SWAP_REQ_MSG_SZ,
> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] =3D flag;
> +	tx_msg->data[1] =3D addr_size;
> +	tx_msg->data[2] =3D ELE_NONE_VAL;
> +	tx_msg->data[3] =3D lower_32_bits(addr);
> +	tx_msg->data[4] =3D plat_add_msg_crc((uint32_t *)&tx_msg[0],
> +						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
> +	priv->rx_msg =3D rx_msg;
> +	ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret  =3D validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_SERVICE_SWAP_REQ,
> +				ELE_SERVICE_SWAP_RSP_MSG_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status =3D RES_STATUS(priv->rx_msg->data[0]);
> +	if (status !=3D priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> +			ELE_SERVICE_SWAP_REQ, status);
> +		ret =3D -1;
> +	} else {
> +		if (flag =3D=3D ELE_IMEM_EXPORT)
> +			ret =3D priv->rx_msg->data[1];
> +		else
> +			ret =3D 0;
> +	}
> +exit:
> +
> +	return ret;
> +}
> +
> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr)
> +{
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_api_msg *rx_msg __free(kfree);
> +	u32 status;
> +	int ret;
> +
> +	tx_msg =3D kzalloc(ELE_FW_AUTH_REQ_SZ << 2, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}
> +
> +	rx_msg =3D kzalloc(ELE_FW_AUTH_RSP_MSG_SZ << 2, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}
> +	ret =3D plat_fill_cmd_msg_hdr(priv,
> +				    (struct se_msg_hdr *)&tx_msg->header,
> +				    ELE_FW_AUTH_REQ,
> +				    ELE_FW_AUTH_REQ_SZ,
> +				    true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] =3D addr;
> +	tx_msg->data[1] =3D 0x0;
> +	tx_msg->data[2] =3D addr;
> +
> +	priv->rx_msg =3D rx_msg;
> +	ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret  =3D validate_rsp_hdr(priv,
> +				priv->rx_msg->header,
> +				ELE_FW_AUTH_REQ,
> +				ELE_FW_AUTH_RSP_MSG_SZ,
> +				true);
> +	if (ret)
> +		goto exit;
> +
> +	status =3D RES_STATUS(priv->rx_msg->data[0]);
> +	if (status !=3D priv->success_tag) {
> +		dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> +			ELE_FW_AUTH_REQ, status);
> +		ret =3D -1;
> +	}
> +exit:
> +
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/e=
le_base_msg.h
> new file mode 100644
> index 000000000000..3b3d2bf04a84
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.h
> @@ -0,0 +1,70 @@
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
> +#define ELE_NONE_VAL			0x0
> +
> +#define ELE_SUCCESS_IND			0xD6
> +
> +#define ELE_GET_INFO_REQ		0xDA
> +#define ELE_GET_INFO_REQ_MSG_SZ		0x10
> +#define ELE_GET_INFO_RSP_MSG_SZ		0x08
> +
> +#define ELE_GET_INFO_BUFF_SZ		0x100
> +#define ELE_GET_INFO_READ_SZ		0xA0
> +
> +#define DEFAULT_IMX_SOC_VER		0xA0
> +#define SOC_VER_MASK			0xFFFF0000
> +#define SOC_ID_MASK			0x0000FFFF
> +struct soc_info {
> +	u32 imem_state;
> +	u8 major_ver;
> +	u8 minor_ver;
> +	u16 soc_id;
> +	u16 soc_rev;
> +	u64 serial_num;
> +};
> +
> +#define GET_INFO_SOC_INFO_WORD_OFFSET	1
> +#define GET_INFO_UUID_WORD_OFFSET	3
> +#define GET_INFO_SL_NUM_MSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 3)
> +#define GET_INFO_SL_NUM_LSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 0)
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
> +int ele_get_info(struct device *dev, struct soc_info *s_info);
> +int ele_ping(struct device *dev);
> +int ele_service_swap(struct device *dev,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag);
> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr);
> +#endif
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele=
_common.c
> new file mode 100644
> index 000000000000..dcf7f9034653
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -0,0 +1,341 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +u32 plat_add_msg_crc(u32 *msg, u32 msg_len)
> +{
> +	u32 nb_words =3D msg_len / (u32)sizeof(u32);
> +	u32 crc =3D 0;
> +	u32 i;
> +
> +	for (i =3D 0; i < nb_words - 1; i++)
> +		crc ^=3D *(msg + i);
> +
> +	return crc;
> +}
> +
> +int imx_ele_msg_rcv(struct se_if_priv *priv)
> +{
> +	u32 wait;
> +	int err;
> +
> +	wait =3D msecs_to_jiffies(1000);
> +	if (!wait_for_completion_timeout(&priv->done, wait)) {
> +		dev_err(priv->dev,
> +				"Error: wait_for_completion timed out.\n");
> +		err =3D -ETIMEDOUT;
> +	}
> +
> +	mutex_unlock(&priv->se_if_cmd_lock);
> +	priv->no_dev_ctx_used =3D false;
> +
> +	return err;
> +}
> +
> +int imx_ele_msg_send(struct se_if_priv *priv, void *mssg)
> +{
> +	bool is_cmd_lock_tobe_taken =3D false;
> +	int err;
> +
> +	if (!priv->waiting_rsp_dev || priv->no_dev_ctx_used) {
> +		is_cmd_lock_tobe_taken =3D true;
> +		mutex_lock(&priv->se_if_cmd_lock);
> +	}
> +	scoped_guard(mutex, &priv->se_if_lock);
> +
> +	err =3D mbox_send_message(priv->tx_chan, mssg);
> +	if (err < 0) {
> +		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +		if (is_cmd_lock_tobe_taken)
> +			mutex_unlock(&priv->se_if_cmd_lock);

Only dropping the lock in case of failure doesn't look right to me. It
seems you should better move the lock to the callers of this function.

> +		return err;
> +	}
> +	err =3D 0;
> +
> +	return err;
> +}
> +
> +int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *mssg)
> +{
> +	int err;
> +
> +	priv->no_dev_ctx_used =3D true;
> +	err =3D imx_ele_msg_send(priv, mssg);
> +	if (err)
> +		goto exit;
> +
> +	err =3D imx_ele_msg_rcv(priv);
> +
> +exit:
> +	return err;
> +}
> +
> +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_msg_hdr header =3D {0};
> +	int err;
> +
> +	err =3D wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr !=3D=
 0);
> +	if (err)
> +		dev_err(dev_ctx->dev,
> +			"%s: Err[0x%x]:Interrupted by signal.\n",
> +			dev_ctx->miscdev.name, err);
> +
> +	header =3D *((struct se_msg_hdr *) (&dev_ctx->temp_resp[0]));
> +
> +	if (header.tag =3D=3D dev_ctx->priv->rsp_tag)
> +		mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
> +
> +	return err;
> +}
> +
> +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> +			     void *tx_msg, int tx_msg_sz)
> +{
> +	struct se_if_priv *priv =3D dev_ctx->priv;
> +	struct se_msg_hdr header =3D {0};
> +	int err;
> +
> +	header =3D *((struct se_msg_hdr *) tx_msg);
> +
> +	/*
> +	 * Check that the size passed as argument matches the size
> +	 * carried in the message.
> +	 */
> +	err =3D header.size << 2;
> +
> +	if (err !=3D tx_msg_sz) {
> +		err =3D -EINVAL;
> +		dev_err(priv->dev,
> +			"%s: User buffer too small\n",
> +				dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +	/* Check the message is valid according to tags */
> +	if (header.tag =3D=3D priv->cmd_tag)
> +		priv->waiting_rsp_dev =3D dev_ctx;
> +	else if (header.tag =3D=3D priv->rsp_tag) {
> +		/* Check the device context can send the command */
> +		if (dev_ctx !=3D priv->cmd_receiver_dev) {
> +			dev_err(priv->dev,
> +				"%s: Channel not configured to send resp to FW.",
> +				dev_ctx->miscdev.name);
> +			err =3D -EPERM;
> +			goto exit;
> +		}
> +	} else {
> +		dev_err(priv->dev,
> +			"%s: The message does not have a valid TAG\n",
> +				dev_ctx->miscdev.name);
> +		err =3D -EINVAL;
> +		goto exit;
> +	}
> +	err =3D imx_ele_msg_send(priv, tx_msg);
> +exit:
> +	return err;
> +}
> +
> +/*
> + * Callback called by mailbox FW, when data is received.
> + */
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
> +{
> +	struct device *dev =3D mbox_cl->dev;
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_api_msg *rx_msg;
> +	bool is_response =3D false;
> +	struct se_if_priv *priv;
> +	struct se_msg_hdr header;
> +
> +	priv =3D dev_get_drvdata(dev);
> +	if (!priv) {
> +		dev_err(dev, "SE-MU Priv data is NULL;");
> +		return;
> +	}

If you code you probe and cleanup functions correctly, this should not
happen.

> +
> +	/* The function can be called with NULL msg */
> +	if (!msg) {
> +		dev_err(dev, "Message is invalid\n");
> +		return;
> +	}
> +
> +	header.tag =3D ((u8 *)msg)[TAG_OFFSET];
> +	header.command =3D ((u8 *)msg)[CMD_OFFSET];
> +	header.size =3D ((u8 *)msg)[SZ_OFFSET];
> +	header.ver =3D ((u8 *)msg)[VER_OFFSET];

Use a proper struct and FIELD_GET() if needed

> +
> +	/* Incoming command: wake up the receiver if any. */
> +	if (header.tag =3D=3D priv->cmd_tag) {
> +		dev_dbg(dev, "Selecting cmd receiver\n");
> +		dev_ctx =3D priv->cmd_receiver_dev;
> +	} else if (header.tag =3D=3D priv->rsp_tag) {
> +		if (priv->waiting_rsp_dev) {
> +			dev_dbg(dev, "Selecting rsp waiter\n");
> +			dev_ctx =3D priv->waiting_rsp_dev;
> +			is_response =3D true;
> +		} else {
> +			/*
> +			 * Reading the EdgeLock Enclave response
> +			 * to the command, sent by other
> +			 * linux kernel services.
> +			 */
> +			spin_lock(&priv->lock);
> +			memcpy(&priv->rx_msg, msg, header.size << 2);
> +
> +			complete(&priv->done);
> +			spin_unlock(&priv->lock);
> +			return;
> +		}
> +	} else {
> +		dev_err(dev, "Failed to select a device for message: %.8x\n",
> +				*((u32 *) &header));
> +		return;
> +	}
> +	/* Init reception */
> +	rx_msg =3D kzalloc(header.size << 2, GFP_KERNEL);
> +	if (rx_msg)
> +		memcpy(rx_msg, msg, header.size << 2);
> +
> +	dev_ctx->temp_resp =3D (u32 *)rx_msg;
> +	dev_ctx->temp_resp_size =3D header.size;
> +
> +	/* Allow user to read */
> +	dev_ctx->pending_hdr =3D 1;
> +	wake_up_interruptible(&dev_ctx->wq);
> +
> +	if (is_response)
> +		priv->waiting_rsp_dev =3D NULL;

This looks racy to me.

> +}
> +
> +int validate_rsp_hdr(struct se_if_priv *priv, u32 header,
> +		     uint8_t msg_id, uint8_t sz, bool is_base_api)
> +{
> +	int ret =3D -EINVAL;
> +	u32 size;
> +	u32 cmd;
> +	u32 tag;
> +	u32 ver;
> +
> +	tag =3D MSG_TAG(header);
> +	cmd =3D MSG_COMMAND(header);
> +	size =3D MSG_SIZE(header);
> +	ver =3D MSG_VER(header);
> +
> +	do {

using a do-while loop is uncommong coding style, Why not use return
instead?

> +		if (tag !=3D priv->rsp_tag) {
> +			dev_err(priv->dev,
> +				"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x !=3D 0x%x)",
> +				msg_id, tag, priv->rsp_tag);
> +			break;
> +		}
> +
> +		if (cmd !=3D msg_id) {
> +			dev_err(priv->dev,
> +				"MSG Header: Cmd id mismatch. (0x%x !=3D 0x%x)",
> +				cmd, msg_id);
> +			break;
> +		}
> +
> +		if (size !=3D (sz >> 2)) {
> +			dev_err(priv->dev,
> +				"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x !=3D 0x%x)",
> +				msg_id, size, (sz >> 2));
> +			break;
> +		}
> +
> +		if (is_base_api && (ver !=3D priv->base_api_ver)) {
> +			dev_err(priv->dev,
> +				"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x !=3D 0x%x)",
> +				msg_id, ver, priv->base_api_ver);
> +			break;
> +		} else if (!is_base_api && ver !=3D priv->fw_api_ver) {
> +			dev_err(priv->dev,
> +				"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x !=3D 0x%x)",
> +				msg_id, ver, priv->fw_api_ver);
> +			break;
> +		}
> +
> +		ret =3D 0;
> +
> +	} while (false);
> +
> +	return ret;
> +}
> +
> +int se_save_imem_state(struct device *dev)
> +{
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* EXPORT command will save encrypted IMEM to given address,
> +	 * so later in resume, IMEM can be restored from the given
> +	 * address.
> +	 *
> +	 * Size must be at least 64 kB.
> +	 */
> +	ret =3D ele_service_swap(dev,
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
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> +	struct soc_info s_info;
> +	int ret;
> +
> +	/* get info from ELE */
> +	ret =3D ele_get_info(dev, &s_info);
> +	if (ret) {
> +		dev_err(dev, "Failed to get info from ELE.\n");
> +		return ret;
> +	}
> +
> +	/* Get IMEM state, if 0xFE then import IMEM */
> +	if (s_info.imem_state =3D=3D ELE_IMEM_STATE_BAD) {
> +		/* IMPORT command will restore IMEM from the given
> +		 * address, here size is the actual size returned by ELE
> +		 * during the export operation
> +		 */
> +		ret =3D ele_service_swap(dev,
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
> +	ret =3D ele_get_info(dev, &s_info);
> +	if (ret) {
> +		dev_err(dev, "Failed to get info from ELE.\n");
> +		goto exit;
> +	}
> +
> +	if (s_info.imem_state =3D=3D ELE_IMEM_STATE_OK)
> +		dev_info(dev, "Successfully restored IMEM\n");
> +	else
> +		dev_err(dev, "Failed to restore IMEM\n");
> +
> +exit:
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele=
_common.h
> new file mode 100644
> index 000000000000..6e3a2114bb56
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
> +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *priv);
> +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> +			     void *tx_msg, int tx_msg_sz);
> +int imx_ele_msg_rcv(struct se_if_priv *priv);
> +int imx_ele_msg_send(struct se_if_priv *priv, void *mssg);
> +int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *mssg);
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
> +int validate_rsp_hdr(struct se_if_priv *priv, unsigned int header,
> +		     u8 msg_id, u8 sz, bool is_base_api);
> +
> +/* Fill a command message header with a given command ID and length in b=
ytes. */
> +static inline int plat_fill_cmd_msg_hdr(struct se_if_priv *priv,
> +					struct se_msg_hdr *hdr,
> +					u8 cmd,
> +					u32 len,
> +					bool is_base_api)
> +{
> +	hdr->tag =3D priv->cmd_tag;
> +	hdr->ver =3D (is_base_api) ? priv->base_api_ver : priv->fw_api_ver;
> +	hdr->command =3D cmd;
> +	hdr->size =3D len >> 2;
> +
> +	return 0;
> +}
> +
> +int se_save_imem_state(struct device *dev);
> +int se_restore_imem_state(struct device *dev);
> +
> +#endif /*__ELE_COMMON_H__ */
> diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctr=
l.c
> new file mode 100644
> index 000000000000..11c5eaa7353f
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.c
> @@ -0,0 +1,1339 @@
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
> +#include <uapi/linux/se_ioctl.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +#include "se_ctrl.h"
> +
> +#define RESERVED_DMA_POOL		BIT(1)

BIT(0)?

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
> +};
> +
> +struct imx_se_node_info_list {
> +	u8 num_mu;
> +	u16 soc_id;
> +	u16 soc_rev;
> +	struct imx_se_node_info info[];
> +};
> +
> +static const struct imx_se_node_info_list imx8ulp_info =3D {
> +	.num_mu =3D 1,
> +	.soc_id =3D SOC_ID_OF_IMX8ULP,
> +	.info =3D {
> +			{
> +				.se_if_id =3D 2,
> +				.se_if_did =3D 7,
> +				.max_dev_ctx =3D 4,
> +				.cmd_tag =3D 0x17,
> +				.rsp_tag =3D 0xe1,
> +				.success_tag =3D 0xd6,
> +				.base_api_ver =3D MESSAGING_VERSION_6,
> +				.fw_api_ver =3D MESSAGING_VERSION_7,
> +				.se_name =3D "hsm1",
> +				.mbox_tx_name =3D "tx",
> +				.mbox_rx_name =3D "rx",
> +				.pool_name =3D "sram",
> +				.fw_name_in_rfs =3D IMX_ELE_FW_DIR\
                                                                ^
                                                           not needed
> +						  "mx8ulpa2ext-ahab-container.img",
> +				.soc_register =3D true,
> +				.reserved_dma_ranges =3D true,
> +				.imem_mgmt =3D true,
> +			},
> +	},
> +};
> +
> +static const struct imx_se_node_info_list imx93_info =3D {
> +	.num_mu =3D 1,
> +	.soc_id =3D SOC_ID_OF_IMX93,
> +	.info =3D {
> +			{
> +				.se_if_id =3D 2,
> +				.se_if_did =3D 3,
> +				.max_dev_ctx =3D 4,
> +				.cmd_tag =3D 0x17,
> +				.rsp_tag =3D 0xe1,
> +				.success_tag =3D 0xd6,
> +				.base_api_ver =3D MESSAGING_VERSION_6,
> +				.fw_api_ver =3D MESSAGING_VERSION_7,
> +				.se_name =3D "hsm1",
> +				.mbox_tx_name =3D "tx",
> +				.mbox_rx_name =3D "rx",
> +				.reserved_dma_ranges =3D true,
> +				.imem_mgmt =3D true,
> +				.soc_register =3D true,
> +			},
> +	},


Some (most?) members of these structs are the same. Why do you have this
abstraction if it's not needed right now?

> +};
> +
> +static const struct of_device_id se_match[] =3D {
> +	{ .compatible =3D "fsl,imx8ulp-ele", .data =3D (void *)&imx8ulp_info},
                                                   ^^^^^^^^ cast not needed
> +	{ .compatible =3D "fsl,imx93-ele", .data =3D (void *)&imx93_info},
> +	{},
> +};
> +
> +static struct imx_se_node_info
> +		*get_imx_se_node_info(struct imx_se_node_info_list *info_list,
> +				      const u32 idx)
> +{
> +	if (idx < 0 || idx > info_list->num_mu)

u32 cannot be < 0

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
> +	struct device_node *of_node =3D dev->of_node;
> +	struct gen_pool *mem_pool;
> +
> +	mem_pool =3D of_gen_pool_get(of_node, mem_pool_name, 0);
> +	if (!mem_pool) {
> +		dev_err(dev,
> +			"Unable to get sram pool =3D %s\n",
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
> +	struct device_node *of_node =3D dev->of_node;
> +	struct gen_pool *mem_pool;
> +
> +	mem_pool =3D of_gen_pool_get(of_node, mem_pool_name, 0);
> +	if (!mem_pool)
> +		dev_err(dev,
> +			"%s: Failed: Unable to get sram pool.\n",
> +			__func__);
> +
> +	gen_pool_free(mem_pool, (u64)buf, size);
> +}
> +
> +static int imx_fetch_soc_info(struct device *dev)
> +{
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> +	struct imx_se_node_info_list *info_list;
> +	const struct imx_se_node_info *info;
> +	struct soc_device_attribute *attr;
> +	struct soc_device *sdev;
> +	struct soc_info s_info;
> +	int err =3D 0;
> +
> +	info =3D priv->info;
> +	info_list =3D (struct imx_se_node_info_list *)
> +				device_get_match_data(dev->parent);

I think cast is not needed.

> +	if (info_list->soc_rev)
> +		return err;

What does this check do? You'll only get data you put in the info_list
in the first place.

> +
> +	err =3D ele_get_info(dev, &s_info);
> +	if (err)
> +		s_info.major_ver =3D DEFAULT_IMX_SOC_VER;

Why continue here in case of error?

> +
> +	info_list->soc_rev =3D s_info.soc_rev;
> +
> +	if (!info->soc_register)
> +		return 0;
> +
> +	attr =3D devm_kzalloc(dev, sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	if (s_info.minor_ver)
> +		attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x.%x",
> +					   s_info.major_ver,
> +					   s_info.minor_ver);
> +	else
> +		attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x",
> +					   s_info.major_ver);
> +
> +	switch (s_info.soc_id) {
> +	case SOC_ID_OF_IMX8ULP:
> +		attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> +					      "i.MX8ULP");
> +		break;
> +	case SOC_ID_OF_IMX93:
> +		attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> +					      "i.MX93");
> +		break;
> +	}
> +
> +	err =3D of_property_read_string(of_root, "model",
> +				      &attr->machine);
> +	if (err) {
> +		devm_kfree(dev, attr);

Why do you do a manual cleanup of devm managed resources? Same applies
to the other devm managed resources, too.

> +		return -EINVAL;
> +	}
> +	attr->family =3D devm_kasprintf(dev, GFP_KERNEL, "Freescale i.MX");
> +
> +	attr->serial_number
> +		=3D devm_kasprintf(dev, GFP_KERNEL, "%016llX", s_info.serial_num);
> +
> +	sdev =3D soc_device_register(attr);
> +	if (IS_ERR(sdev)) {
> +		devm_kfree(dev, attr->soc_id);
> +		devm_kfree(dev, attr->serial_number);
> +		devm_kfree(dev, attr->revision);
> +		devm_kfree(dev, attr->family);
> +		devm_kfree(dev, attr->machine);
> +		devm_kfree(dev, attr);
> +		return PTR_ERR(sdev);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * File operations for user-space
> + */
> +
> +/* Write a message to the MU. */
> +static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
> +				size_t size, loff_t *ppos)
> +{
> +	struct se_api_msg *tx_msg __free(kfree);
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_if_priv *priv;
> +	int err;
> +
> +	dev_ctx =3D container_of(fp->private_data,
> +			       struct se_if_device_ctx,
> +			       miscdev);
> +	priv =3D dev_ctx->priv;
> +	dev_dbg(priv->dev,
> +		"%s: write from buf (%p)%zu, ppos=3D%lld\n",
> +			dev_ctx->miscdev.name,
> +			buf, size, ((ppos) ? *ppos : 0));
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status !=3D MU_OPENED) {
> +		err =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (size < SE_MU_HDR_SZ) {
> +		dev_err(priv->dev,
> +			"%s: User buffer too small(%zu < %d)\n",
> +				dev_ctx->miscdev.name,
> +				size, SE_MU_HDR_SZ);
> +		err =3D -ENOSPC;
> +		goto exit;
> +	}
> +
> +	tx_msg =3D memdup_user((void __user *)ppos, size);
> +	if (!tx_msg) {
> +		err =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* Copy data to buffer */
> +	if (copy_from_user(tx_msg, buf, size)) {
> +		err =3D -EFAULT;
> +		dev_err(priv->dev,
> +			"%s: Fail copy message from user\n",
> +				dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +
> +	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     tx_msg, size, false);
> +
> +	err =3D imx_ele_miscdev_msg_send(dev_ctx, tx_msg, size);
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/*
> + * Read a message from the MU.
> + * Blocking until a message is available.
> + */
> +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> +			       size_t size, loff_t *ppos)
> +{
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_buf_desc *b_desc;
> +	struct se_if_priv *priv;
> +	u32 size_to_copy;
> +	int err;
> +
> +	dev_ctx =3D container_of(fp->private_data,
> +			       struct se_if_device_ctx,
> +			       miscdev);
> +	priv =3D dev_ctx->priv;
> +	dev_dbg(priv->dev,
> +		"%s: read to buf %p(%zu), ppos=3D%lld\n",
> +			dev_ctx->miscdev.name,
> +			buf, size, ((ppos) ? *ppos : 0));
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status !=3D MU_OPENED) {
> +		err =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	err =3D imx_ele_miscdev_msg_rcv(dev_ctx);
> +	if (err)
> +		goto exit;
> +
> +	/* Buffer containing the message from FW, is
> +	 * allocated in callback function.
> +	 * Check if buffer allocation failed.
> +	 */
> +	if (!dev_ctx->temp_resp) {
> +		err =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_dbg(priv->dev,
> +			"%s: %s %s\n",
> +			dev_ctx->miscdev.name,
> +			__func__,
> +			"message received, start transmit to user");
> +
> +	/*
> +	 * Check that the size passed as argument is larger than
> +	 * the one carried in the message.
> +	 */
> +	size_to_copy =3D dev_ctx->temp_resp_size << 2;
> +	if (size_to_copy > size) {
> +		dev_dbg(priv->dev,
> +			"%s: User buffer too small (%zu < %d)\n",
> +				dev_ctx->miscdev.name,
> +				size, size_to_copy);
> +		size_to_copy =3D size;
> +	}
> +
> +	/*
> +	 * We may need to copy the output data to user before
> +	 * delivering the completion message.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_out)) {
> +		b_desc =3D list_first_entry_or_null(&dev_ctx->pending_out,
> +						  struct se_buf_desc,
> +						  link);
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
> +
> +			dev_dbg(priv->dev,
> +				"%s: Copy output data to user\n",
> +				dev_ctx->miscdev.name);
> +			if (copy_to_user(b_desc->usr_buf_ptr,
> +					 b_desc->shared_buf_ptr,
> +					 b_desc->size)) {
> +				dev_err(priv->dev,
> +					"%s: Failure copying output data to user.",
> +					dev_ctx->miscdev.name);
> +				err =3D -EFAULT;
> +				goto exit;
> +			}
> +		}
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	/* Copy data from the buffer */
> +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     dev_ctx->temp_resp, size_to_copy, false);
> +	if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy to user\n",
> +				dev_ctx->miscdev.name);
> +		err =3D -EFAULT;
> +		goto exit;
> +	}
> +
> +	err =3D size_to_copy;
> +	kfree(dev_ctx->temp_resp);
> +
> +	/* free memory allocated on the shared buffers. */
> +	dev_ctx->secure_mem.pos =3D 0;
> +	dev_ctx->non_secure_mem.pos =3D 0;
> +
> +	dev_ctx->pending_hdr =3D 0;
> +
> +exit:
> +	/*
> +	 * Clean the used Shared Memory space,
> +	 * whether its Input Data copied from user buffers, or
> +	 * Data received from FW.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc =3D list_first_entry_or_null(&dev_ctx->pending_in,
> +							  struct se_buf_desc,
> +							  link);
> +		else
> +			b_desc =3D list_first_entry_or_null(&dev_ctx->pending_out,
> +							  struct se_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Give access to EdgeLock Enclave, to the memory we want to share */
> +static int se_if_setup_se_mem_access(struct se_if_device_ctx *dev_ctx,
> +				     u64 addr, u32 len)
> +{
> +	/* Assuming EdgeLock Enclave has access to all the memory regions */
> +	int ret =3D 0;
> +
> +	if (ret) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Fail find memreg\n", dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +
> +	if (ret) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Fail set permission for resource\n",
> +				dev_ctx->miscdev.name);
> +		goto exit;
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> +				u64 arg)
> +{
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> +	struct imx_se_node_info *if_node_info;
> +	struct se_ioctl_get_if_info info;
> +	int err =3D 0;
> +
> +	if_node_info =3D (struct imx_se_node_info *)priv->info;
> +
> +	info.se_if_id =3D if_node_info->se_if_id;
> +	info.interrupt_idx =3D 0;
> +	info.tz =3D 0;
> +	info.did =3D if_node_info->se_if_did;
> +	info.cmd_tag =3D if_node_info->cmd_tag;
> +	info.rsp_tag =3D if_node_info->rsp_tag;
> +	info.success_tag =3D if_node_info->success_tag;
> +	info.base_api_ver =3D if_node_info->base_api_ver;
> +	info.fw_api_ver =3D if_node_info->fw_api_ver;
> +
> +	dev_dbg(priv->dev,
> +		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
> +			dev_ctx->miscdev.name,
> +			info.se_if_id, info.interrupt_idx, info.tz, info.did);
> +
> +	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy mu info to user\n",
> +				dev_ctx->miscdev.name);
> +		err =3D -EFAULT;
> +		goto exit;
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/*
> + * Copy a buffer of data to/from the user and return the address to use =
in
> + * messages
> + */
> +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
> +					    u64 arg)
> +{
> +	struct se_ioctl_setup_iobuf io =3D {0};
> +	struct se_shared_mem *shared_mem;
> +	struct se_buf_desc *b_desc;
> +	int err =3D 0;
> +	u32 pos;
> +
> +	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed copy iobuf config from user\n",
> +				dev_ctx->miscdev.name);
> +		err =3D -EFAULT;
> +		goto exit;
> +	}
> +
> +	dev_dbg(dev_ctx->priv->dev,
> +			"%s: io [buf: %p(%d) flag: %x]\n",
> +			dev_ctx->miscdev.name,
> +			io.user_buf, io.length, io.flags);
> +
> +	if (io.length =3D=3D 0 || !io.user_buf) {
> +		/*
> +		 * Accept NULL pointers since some buffers are optional
> +		 * in FW commands. In this case we should return 0 as
> +		 * pointer to be embedded into the message.
> +		 * Skip all data copy part of code below.
> +		 */
> +		io.ele_addr =3D 0;
> +		goto copy;
> +	}
> +
> +	/* Select the shared memory to be used for this buffer. */
> +	if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
> +		/* App requires to use secure memory for this buffer.*/
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed allocate SEC MEM memory\n",
> +				dev_ctx->miscdev.name);
> +		err =3D -EFAULT;
> +		goto exit;
> +	} else {
> +		/* No specific requirement for this buffer. */
> +		shared_mem =3D &dev_ctx->non_secure_mem;
> +	}
> +
> +	/* Check there is enough space in the shared memory. */
> +	if (shared_mem->size < shared_mem->pos
> +			|| io.length >=3D shared_mem->size - shared_mem->pos) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Not enough space in shared memory\n",
> +				dev_ctx->miscdev.name);
> +		err =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* Allocate space in shared memory. 8 bytes aligned. */
> +	pos =3D shared_mem->pos;
> +	shared_mem->pos +=3D round_up(io.length, 8u);
> +	io.ele_addr =3D (u64)shared_mem->dma_addr + pos;
> +
> +	if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
> +	    !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
> +		/*Add base address to get full address.*/
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed allocate SEC MEM memory\n",
> +				dev_ctx->miscdev.name);
> +		err =3D -EFAULT;
> +		goto exit;
> +	}
> +
> +	memset(shared_mem->ptr + pos, 0, io.length);
> +	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> +	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> +		/*
> +		 * buffer is input:
> +		 * copy data from user space to this allocated buffer.
> +		 */
> +		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> +				   io.length)) {
> +			dev_err(dev_ctx->priv->dev,
> +				"%s: Failed copy data to shared memory\n",
> +				dev_ctx->miscdev.name);
> +			err =3D -EFAULT;
> +			goto exit;
> +		}
> +	}
> +
> +	b_desc =3D kzalloc(sizeof(*b_desc), GFP_KERNEL);
> +	if (!b_desc) {
> +		err =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +copy:
> +	/* Provide the EdgeLock Enclave address to user space only if success.*/
> +	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy iobuff setup to user\n",
> +				dev_ctx->miscdev.name);
> +		kfree(b_desc);
> +		err =3D -EFAULT;
> +		goto exit;
> +	}
> +
> +	if (b_desc) {
> +		b_desc->shared_buf_ptr =3D shared_mem->ptr + pos;
> +		b_desc->usr_buf_ptr =3D io.user_buf;
> +		b_desc->size =3D io.length;
> +
> +		if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> +			/*
> +			 * buffer is input:
> +			 * add an entry in the "pending input buffers" list so
> +			 * that copied data can be cleaned from shared memory
> +			 * later.
> +			 */
> +			list_add_tail(&b_desc->link, &dev_ctx->pending_in);
> +		} else {
> +			/*
> +			 * buffer is output:
> +			 * add an entry in the "pending out buffers" list so data
> +			 * can be copied to user space when receiving Secure-Enclave
> +			 * response.
> +			 */
> +			list_add_tail(&b_desc->link, &dev_ctx->pending_out);
> +		}
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/* IOCTL to provide SoC information */
> +static int se_ioctl_get_soc_info_handler(struct se_if_device_ctx *dev_ct=
x,
> +					     u64 arg)
> +{
> +	struct imx_se_node_info_list *info_list;
> +	struct se_ioctl_get_soc_info soc_info;
> +	int err =3D -EINVAL;
> +
> +	info_list =3D (struct imx_se_node_info_list *)
> +			device_get_match_data(dev_ctx->priv->dev->parent);
> +	if (!info_list)
> +		goto exit;
> +
> +	soc_info.soc_id =3D info_list->soc_id;
> +	soc_info.soc_rev =3D info_list->soc_rev;
> +
> +	err =3D (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(soc_info=
));
> +	if (err) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy soc info to user\n",
> +			dev_ctx->miscdev.name);
> +		err =3D -EFAULT;
> +		goto exit;
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/* Open a character device. */
> +static int se_if_fops_open(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	int err;
> +
> +	/* Avoid race if opened at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* Authorize only 1 instance. */
> +	if (dev_ctx->status !=3D MU_FREE) {
> +		err =3D -EBUSY;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Allocate some memory for data exchanges with S40x.
> +	 * This will be used for data not requiring secure memory.
> +	 */
> +	dev_ctx->non_secure_mem.ptr =3D dmam_alloc_coherent(dev_ctx->dev,
> +					MAX_DATA_SIZE_PER_USER,
> +					&dev_ctx->non_secure_mem.dma_addr,
> +					GFP_KERNEL);
> +	if (!dev_ctx->non_secure_mem.ptr) {
> +		err =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	err =3D se_if_setup_se_mem_access(dev_ctx,
> +					  dev_ctx->non_secure_mem.dma_addr,
> +					  MAX_DATA_SIZE_PER_USER);
> +	if (err) {
> +		err =3D -EPERM;
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to share access to shared memory\n",
> +			   dev_ctx->miscdev.name);
> +		goto free_coherent;
> +	}
> +
> +	dev_ctx->non_secure_mem.size =3D MAX_DATA_SIZE_PER_USER;
> +	dev_ctx->non_secure_mem.pos =3D 0;
> +	dev_ctx->status =3D MU_OPENED;
> +
> +	dev_ctx->pending_hdr =3D 0;
> +
> +	goto exit;
> +
> +free_coherent:
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Close a character device. */
> +static int se_if_fops_close(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	struct se_if_priv *priv =3D dev_ctx->priv;
> +	struct se_buf_desc *b_desc;
> +
> +	/* Avoid race if closed at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* The device context has not been opened */
> +	if (dev_ctx->status !=3D MU_OPENED)
> +		goto exit;
> +
> +	/* check if this device was registered as command receiver. */
> +	if (priv->cmd_receiver_dev =3D=3D dev_ctx)
> +		priv->cmd_receiver_dev =3D NULL;
> +
> +	/* check if this device was registered as waiting response. */
> +	if (priv->waiting_rsp_dev =3D=3D dev_ctx) {
> +		priv->waiting_rsp_dev =3D NULL;
> +		mutex_unlock(&priv->se_if_cmd_lock);
> +	}
> +
> +	/* Unmap secure memory shared buffer. */
> +	if (dev_ctx->secure_mem.ptr)
> +		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
> +
> +	dev_ctx->secure_mem.ptr =3D NULL;
> +	dev_ctx->secure_mem.dma_addr =3D 0;
> +	dev_ctx->secure_mem.size =3D 0;
> +	dev_ctx->secure_mem.pos =3D 0;
> +
> +	/* Free non-secure shared buffer. */
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +	dev_ctx->non_secure_mem.ptr =3D NULL;
> +	dev_ctx->non_secure_mem.dma_addr =3D 0;
> +	dev_ctx->non_secure_mem.size =3D 0;
> +	dev_ctx->non_secure_mem.pos =3D 0;
> +
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc =3D list_first_entry_or_null(&dev_ctx->pending_in,
> +							  struct se_buf_desc,
> +							  link);
> +		else
> +			b_desc =3D list_first_entry_or_null(&dev_ctx->pending_out,
> +							  struct se_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		devm_kfree(dev_ctx->dev, b_desc);
> +	}
> +
> +	dev_ctx->status =3D MU_FREE;
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return 0;
> +}
> +
> +/* IOCTL entry point of a character device */
> +static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long ar=
g)
> +//static long se_ioctl(struct file *fp, u32 cmd, u64 arg)
> +{
> +	struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_data,
> +							struct se_if_device_ctx,
> +							miscdev);
> +	struct se_if_priv *se_if_priv =3D dev_ctx->priv;
> +	int err =3D -EINVAL;
> +
> +	/* Prevent race during change of device context */
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	switch (cmd) {
> +	case SE_IOCTL_ENABLE_CMD_RCV:
> +		if (!se_if_priv->cmd_receiver_dev) {
> +			se_if_priv->cmd_receiver_dev =3D dev_ctx;
> +			err =3D 0;
> +		}
> +		break;
> +	case SE_IOCTL_GET_MU_INFO:
> +		err =3D se_ioctl_get_mu_info(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_SETUP_IOBUF:
> +		err =3D se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_GET_SOC_INFO:
> +		err =3D se_ioctl_get_soc_info_handler(dev_ctx, arg);
> +		break;
> +
> +	default:
> +		err =3D -EINVAL;
> +		dev_dbg(se_if_priv->dev,
> +			"%s: IOCTL %.8x not supported\n",
> +				dev_ctx->miscdev.name,
> +				cmd);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return (long)err;
> +}
> +
> +/* Char driver setup */
> +static const struct file_operations se_if_fops =3D {
> +	.open		=3D se_if_fops_open,
> +	.owner		=3D THIS_MODULE,
> +	.release	=3D se_if_fops_close,
> +	.unlocked_ioctl =3D se_ioctl,
> +	.read		=3D se_if_fops_read,
> +	.write		=3D se_if_fops_write,
> +};
> +
> +/* interface for managed res to free a mailbox channel */
> +static void if_mbox_free_channel(void *mbox_chan)
> +{
> +	mbox_free_channel(mbox_chan);
> +}
> +
> +/* interface for managed res to unregister a character device */
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
> +static int se_if_request_channel(struct device *dev,
> +				 struct mbox_chan **chan,
> +				 struct mbox_client *cl,
> +				 const u8 *name)
                                       ^^

mbox_request_channel_byname() uses a "char" for the name not a u8.

> +{
> +	struct mbox_chan *t_chan;
> +	int ret =3D 0;
> +
> +	t_chan =3D mbox_request_channel_byname(cl, name);
> +	if (IS_ERR(t_chan)) {
> +		ret =3D PTR_ERR(t_chan);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev,
> +				"Failed to request chan %s ret %d\n", name,
> +				ret);
> +		goto exit;
> +	}
> +
> +	ret =3D devm_add_action(dev, if_mbox_free_channel, t_chan);
> +	if (ret) {
> +		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
> +		goto exit;
> +	}
> +
> +	*chan =3D t_chan;
> +
> +exit:
> +	return ret;
> +}
> +
> +static int se_probe_if_cleanup(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct se_if_priv *priv;
> +	int ret =3D 0;
> +	int i;
> +
> +	priv =3D dev_get_drvdata(dev);
> +	if (!priv) {
> +		ret =3D 0;
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
> +		priv->imem.buf =3D NULL;
> +	}

Why cleanup devm managed resources?

> +
> +	if (priv->ctxs) {
> +		for (i =3D 0; i < priv->max_dev_ctx; i++) {
> +			if (priv->ctxs[i]) {
> +				devm_remove_action(dev,
> +						   if_misc_deregister,
> +						   &priv->ctxs[i]->miscdev);
> +				misc_deregister(&priv->ctxs[i]->miscdev);
> +				devm_kfree(dev, priv->ctxs[i]);
> +			}
> +		}
> +		devm_kfree(dev, priv->ctxs);
> +	}
> +
> +	if (priv->flags & RESERVED_DMA_POOL) {
> +		of_reserved_mem_device_release(dev);
> +		priv->flags &=3D (~RESERVED_DMA_POOL);
> +	}
> +
> +	devm_kfree(dev, priv);
> +	of_node_put(dev->of_node);
> +	of_platform_device_destroy(dev, NULL);
> +
> +	return ret;
> +}
> +
> +static int se_probe_cleanup(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *if_dn;
> +
> +	/* Enumerate se-interface device nodes. */
> +	for_each_child_of_node(dev->of_node, if_dn) {
> +		struct platform_device *if_pdev
> +					=3D of_find_device_by_node(if_dn);
> +		if (se_probe_if_cleanup(if_pdev))
> +			dev_err(dev,
> +				"Failed to clean-up child node probe.\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int init_device_context(struct device *dev)
> +{
> +	const struct imx_se_node_info *info;
> +	struct se_if_device_ctx *dev_ctx;
> +	struct se_if_priv *priv;
> +	u8 *devname;
> +	int ret =3D 0;
> +	int i;
> +
> +	priv =3D dev_get_drvdata(dev);
> +
> +	if (!priv) {
> +		ret =3D -EINVAL;
> +		dev_err(dev, "Invalid SE-MU Priv data");
> +		return ret;
> +	}
> +	info =3D priv->info;
> +
> +	priv->ctxs =3D devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_ctx,
> +				  GFP_KERNEL);
> +
> +	if (!priv->ctxs) {
> +		ret =3D -ENOMEM;
> +		return ret;
> +	}
> +
> +	/* Create users */
> +	for (i =3D 0; i < priv->max_dev_ctx; i++) {
> +		dev_ctx =3D devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNEL);
> +		if (!dev_ctx) {
> +			ret =3D -ENOMEM;
> +			return ret;
> +		}
> +
> +		dev_ctx->dev =3D dev;
> +		dev_ctx->status =3D MU_FREE;
> +		dev_ctx->priv =3D priv;
> +
> +		priv->ctxs[i] =3D dev_ctx;
> +
> +		/* Default value invalid for an header. */
> +		init_waitqueue_head(&dev_ctx->wq);
> +
> +		INIT_LIST_HEAD(&dev_ctx->pending_out);
> +		INIT_LIST_HEAD(&dev_ctx->pending_in);
> +		sema_init(&dev_ctx->fops_lock, 1);
> +
> +		devname =3D devm_kasprintf(dev, GFP_KERNEL, "%s_ch%d",
> +					 info->se_name, i);
> +		if (!devname) {
> +			ret =3D -ENOMEM;
> +			return ret;
> +		}
> +
> +		dev_ctx->miscdev.name =3D devname;
> +		dev_ctx->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> +		dev_ctx->miscdev.fops =3D &se_if_fops;
> +		dev_ctx->miscdev.parent =3D dev;
> +		ret =3D misc_register(&dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev, "failed to register misc device %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		ret =3D devm_add_action(dev, if_misc_deregister,
> +				      &dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to add action to the misc-dev\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void se_load_firmware(const struct firmware *fw, void *context)
> +{
> +	struct se_if_priv *priv =3D (struct se_if_priv *) context;
> +	const struct imx_se_node_info *info =3D priv->info;
> +	const u8 *se_fw_name =3D info->fw_name_in_rfs;
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
> +			dev_dbg(priv->dev, "Value of retries =3D 0x%x.\n",
> +				priv->fw_fail);
> +		}
> +
> +		return;
> +	}
> +
> +	/* allocate buffer to store the SE FW */
> +	se_fw_buf =3D dmam_alloc_coherent(priv->dev, fw->size,
> +					 &se_fw_phyaddr,
> +					 GFP_KERNEL);
> +	if (!se_fw_buf) {
> +		dev_err(priv->dev, "Failed to alloc SE fw buffer memory\n");
> +		goto exit;
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
> +	struct device *dev =3D &pdev->dev;
> +	struct imx_se_node_info *info;
> +	struct se_if_priv *priv;
> +	u32 idx;
> +	int ret;
> +
> +	if (of_property_read_u32(dev->of_node, "reg", &idx)) {
> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	info_list =3D (struct imx_se_node_info_list *)
> +			device_get_match_data(dev->parent);
> +	info =3D get_imx_se_node_info(info_list, idx);
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	/* Mailbox client configuration */
> +	priv->se_mb_cl.dev		=3D dev;
> +	priv->se_mb_cl.tx_block		=3D false;
> +	priv->se_mb_cl.knows_txdone	=3D true;
> +	priv->se_mb_cl.rx_callback	=3D se_if_rx_callback;
> +
> +	ret =3D se_if_request_channel(dev, &priv->tx_chan,
> +			&priv->se_mb_cl, info->mbox_tx_name);
> +	if (ret) {
> +		if (ret =3D=3D -EPROBE_DEFER)

Don't test for -EPROBE_DEFER, use dev_err_probe().

> +			dev_err(dev, "Mailbox tx channel, is not ready.\n");
> +		else
> +			dev_err(dev, "Failed to request tx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	ret =3D se_if_request_channel(dev, &priv->rx_chan,
> +			&priv->se_mb_cl, info->mbox_rx_name);
> +	if (ret) {
> +		if (ret =3D=3D -EPROBE_DEFER)
> +			dev_err(dev, "Mailbox rx channel, is not ready.\n");
> +		else
> +			dev_dbg(dev, "Failed to request rx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	priv->dev =3D dev;
> +	priv->info =3D info;
> +
> +	/* Initialize the mutex. */
> +	mutex_init(&priv->se_if_lock);
> +	mutex_init(&priv->se_if_cmd_lock);
> +
> +	priv->cmd_receiver_dev =3D NULL;
> +	priv->waiting_rsp_dev =3D NULL;
> +	priv->max_dev_ctx =3D info->max_dev_ctx;
> +	priv->cmd_tag =3D info->cmd_tag;
> +	priv->rsp_tag =3D info->rsp_tag;
> +	priv->mem_pool_name =3D info->pool_name;
> +	priv->success_tag =3D info->success_tag;
> +	priv->base_api_ver =3D info->base_api_ver;
> +	priv->fw_api_ver =3D info->fw_api_ver;
> +
> +	init_completion(&priv->done);
> +	spin_lock_init(&priv->lock);
> +
> +	if (info->reserved_dma_ranges) {
> +		ret =3D of_reserved_mem_device_init(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed to init reserved memory region %d\n",
> +				ret);
> +			priv->flags &=3D (~RESERVED_DMA_POOL);
> +			goto exit;
> +		}
> +		priv->flags |=3D RESERVED_DMA_POOL;
> +	}
> +
> +	if (info->fw_name_in_rfs) {
> +		ret =3D request_firmware_nowait(THIS_MODULE,
> +					      FW_ACTION_UEVENT,
> +					      info->fw_name_in_rfs,
> +					      dev, GFP_KERNEL, priv,
> +					      se_load_firmware);
> +		if (ret)
> +			dev_warn(dev, "Failed to get firmware [%s].\n",
> +				 info->fw_name_in_rfs);
> +	}
> +
> +	ret =3D imx_fetch_soc_info(dev);
> +	if (ret) {
> +		dev_err(dev,
> +			"failed[%d] to fetch SoC Info\n", ret);

Use %pe to print error values

> +		goto exit;
> +	}
> +
> +	if (info->imem_mgmt) {
> +		/* allocate buffer where SE store encrypted IMEM */
> +		priv->imem.buf =3D dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
> +						     &priv->imem.phyaddr,
> +						     GFP_KERNEL);
> +		if (!priv->imem.buf) {
> +			dev_err(dev,
> +				"dmam-alloc-failed: To store encr-IMEM.\n");
> +			ret =3D -ENOMEM;
> +			goto exit;
> +		}
> +	}
> +
> +	if (info->max_dev_ctx) {
> +		ret =3D init_device_context(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed[0x%x] to create device contexts.\n",
> +				ret);
> +			goto exit;
> +		}
> +	}
> +
> +	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configure=
d.\n",
> +		 info->se_name);
> +	return devm_of_platform_populate(dev);
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
> +static int se_probe(struct platform_device *pdev)
> +{
> +	struct device_node *enum_dev_node;
> +	struct device *dev =3D &pdev->dev;
> +	int enum_count;
> +	int ret;
> +
> +	enum_count =3D of_get_child_count(dev->of_node);
> +	if (!enum_count) {
> +		ret =3D -EINVAL;
> +		dev_err(dev, "Zero Tx/Rx path MU nodes.\n");
> +		return ret;
> +	}
> +
> +	for_each_child_of_node(dev->of_node, enum_dev_node) {
> +		struct platform_device *enum_plat_dev __maybe_unused;

Why is this __maybe_unused?

> +
> +		if (!of_device_is_available(enum_dev_node))
> +			continue;
> +
> +		enum_plat_dev =3D of_platform_device_create(enum_dev_node,
> +							  NULL,
> +							  dev);
> +		if (!enum_plat_dev) {
> +			ret =3D -EINVAL;
> +			of_node_put(enum_dev_node);
> +			dev_err(dev,
> +				"Failed to create enumerated platform device.");
> +			break;
> +		}
> +
> +		ret =3D se_if_probe(enum_plat_dev);
> +	}
> +	return ret;
> +}
> +
> +static int se_remove(struct platform_device *pdev)
> +{
> +	if (se_probe_cleanup(pdev))
> +		dev_err(&pdev->dev,
> +			"i.MX Secure Enclave is not cleanly un-probed.");
> +
> +	return 0;
> +}
> +
> +static int se_suspend(struct device *dev)
> +{
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> +	const struct imx_se_node_info *info
> +					=3D priv->info;
> +
> +	if (info && info->imem_mgmt)
> +		priv->imem.size =3D se_save_imem_state(dev);
> +
> +	return 0;
> +}
> +
> +static int se_resume(struct device *dev)
> +{
> +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> +	const struct imx_se_node_info *info
> +					=3D priv->info;
> +	int i;
> +
> +	for (i =3D 0; i < priv->max_dev_ctx; i++)
> +		wake_up_interruptible(&priv->ctxs[i]->wq);
> +
> +	if (info && info->imem_mgmt)
> +		se_restore_imem_state(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops se_pm =3D {
> +	RUNTIME_PM_OPS(se_suspend, se_resume, NULL)
> +};
> +
> +static struct platform_driver se_driver =3D {
> +	.driver =3D {
> +		.name =3D "fsl-se-fw",
> +		.of_match_table =3D se_match,
> +		.pm =3D &se_pm,
> +	},
> +	.probe =3D se_probe,
> +	.remove =3D se_remove,
> +};
> +MODULE_DEVICE_TABLE(of, se_match);
> +
> +module_platform_driver(se_driver);
> +
> +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> +MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctr=
l.h
> new file mode 100644
> index 000000000000..76e1ce77c52f
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.h
> @@ -0,0 +1,151 @@
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
> +#define MSG_TAG(x)			(((x) & 0xff000000) >> 24)
> +#define MSG_COMMAND(x)			(((x) & 0x00ff0000) >> 16)
> +#define MSG_SIZE(x)			(((x) & 0x0000ff00) >> 8)
> +#define MSG_VER(x)			((x) & 0x000000ff)
> +#define RES_STATUS(x)			((x) & 0x000000ff)

please use FIELD_GET(), FIELD_PREP() for these

> +#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
> +#define S4_DEFAULT_MUAP_INDEX		(2)
> +#define S4_MUAP_DEFAULT_MAX_USERS	(4)
> +#define MESSAGING_VERSION_6		0x6
> +#define MESSAGING_VERSION_7		0x7
> +
> +#define DEFAULT_MESSAGING_TAG_COMMAND           (0x17u)
> +#define DEFAULT_MESSAGING_TAG_RESPONSE          (0xe1u)
> +
> +#define SE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
> +#define SE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
> +
> +struct se_imem_buf {
> +	u8 *buf;
> +	phys_addr_t phyaddr;
> +	u32 size;
> +};
> +
> +struct se_buf_desc {
> +	u8 *shared_buf_ptr;
> +	u8 *usr_buf_ptr;
> +	u32 size;
> +	struct list_head link;
> +};
> +
> +/* Status of a char device */
> +enum se_if_dev_ctx_status_t {
> +	MU_FREE,
> +	MU_OPENED
> +};
> +
> +struct se_shared_mem {
> +	dma_addr_t dma_addr;
> +	u32 size;
> +	u32 pos;
> +	u8 *ptr;
> +};
> +
> +/* Private struct for each char device instance. */
> +struct se_if_device_ctx {
> +	struct device *dev;
> +	struct se_if_priv *priv;
> +	struct miscdevice miscdev;
> +
> +	enum se_if_dev_ctx_status_t status;
> +	wait_queue_head_t wq;
> +	struct semaphore fops_lock;
> +
> +	u32 pending_hdr;
> +	struct list_head pending_in;
> +	struct list_head pending_out;
> +
> +	struct se_shared_mem secure_mem;
> +	struct se_shared_mem non_secure_mem;
> +
> +	u32 *temp_resp;
> +	u32 temp_resp_size;
> +	struct notifier_block se_notify;
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
> +#define TAG_OFFSET	(SE_MU_HDR_SZ - 1)
> +#define CMD_OFFSET	(SE_MU_HDR_SZ - 2)
> +#define SZ_OFFSET	(SE_MU_HDR_SZ - 3)
> +#define VER_OFFSET	(SE_MU_HDR_SZ - 4)
> +
> +struct se_api_msg {
> +	u32 header; /* u8 Tag; u8 Command; u8 Size; u8 Ver; */
> +	u32 *data;
> +};
> +
> +struct se_if_priv {
> +	struct se_if_device_ctx *cmd_receiver_dev;
> +	struct se_if_device_ctx *waiting_rsp_dev;
> +	bool no_dev_ctx_used;

What does no_dev_ctx_used do?

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

Please explain why you need 2 mutexes here?

> +	struct device *dev;
> +	u8 *mem_pool_name;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +	u32 fw_fail;
> +	const void *info;
> +
> +	struct mbox_client se_mb_cl;
> +	struct mbox_chan *tx_chan, *rx_chan;
> +	struct se_api_msg *rx_msg;
> +	struct completion done;
> +	spinlock_t lock;
> +	/*
> +	 * Flag to retain the state of initialization done at
> +	 * the time of se-mu probe.
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
> +void free_phybuf_mem_pool(struct device *dev,
> +			  u8 *mem_pool_name,
> +			  u32 *buf,
> +			  u32 size);
> +#endif
> diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware=
/imx/se_api.h
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
> diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
> new file mode 100644
> index 000000000000..f68a36e9da2c
> --- /dev/null
> +++ b/include/uapi/linux/se_ioctl.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-C=
lause*/
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef SE_IOCTL_H
> +#define SE_IOCTL_H
> +
> +/* IOCTL definitions. */
> +
> +struct se_ioctl_setup_iobuf {
> +	u8 *user_buf;
> +	u32 length;
> +	u32 flags;
> +	u64 ele_addr;
> +};
> +
> +struct se_ioctl_shared_mem_cfg {
> +	u32 base_offset;
> +	u32 size;
> +};
> +
> +struct se_ioctl_get_if_info {
> +	u8 se_if_id;
> +	u8 interrupt_idx;
> +	u8 tz;
> +	u8 did;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +};
> +
> +struct se_ioctl_signed_message {
> +	u8 *message;
> +	u32 msg_size;
> +	u32 error_code;
> +};
> +
> +struct se_ioctl_get_soc_info {
> +	u16 soc_id;
> +	u16 soc_rev;
> +};
> +
> +/* IO Buffer Flags */
> +#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
> +#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
> +#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
> +#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
> +#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
> +
> +/* IOCTLS */
> +#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
> +
> +/*
> + * ioctl to designated the current fd as logical-reciever.
> + * This is ioctl is send when the nvm-daemon, a slave to the
> + * firmware is started by the user.
> + */
> +#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
> +
> +/*
> + * ioctl to get the buffer allocated from the memory, which is shared
> + * between kernel and FW.
> + * Post allocation, the kernel tagged the allocated memory with:
> + *  Output
> + *  Input
> + *  Input-Output
> + *  Short address
> + *  Secure-memory
> + */
> +#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
> +					struct se_ioctl_setup_iobuf)
> +
> +/*
> + * ioctl to get the mu information, that is used to exchange message
> + * with FW, from user-spaced.
> + */
> +#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
> +					struct se_ioctl_get_if_info)
> +/*
> + * ioctl to get SoC Info from user-space.
> + */
> +#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
> +					struct se_ioctl_get_soc_info)
> +
> +#endif
>=20
> --=20
> 2.34.1
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--syriwlvtoupopku6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZB8VEACgkQKDiiPnot
vG8klAf+IDIwevUHkr50vxyz33bsk2ZZ1eFqU5FH70JwSyIlycvRoDdRg4boLJTt
4ofSMCNfzmVyYn2hsQaqs6MlnpksS2IIfNK6a+1CkAxzojHhrYFSGZ5r31ALuNZh
GgydDvN116EblNBgiOvUZtfngx/V6Au6QXYFRbKtJ7ez2Wzvmfp6AsPrxf2YrgsV
ASOHWWpQDIWRJa+cEECxm38Bbj1jfxbUwYfmBMb2I0gN9UAohNutrJx9m8id+8fV
sueC2N+IwS07z9/EicbhhsL3nXNhtJgTxXLQ7t5ML1UHiMb3Cz5ZlUtb3z92fVJB
ULUd2RrjHmZU294STEHz6YeVXdkI8A==
=a4Ua
-----END PGP SIGNATURE-----

--syriwlvtoupopku6--

