Return-Path: <linux-kernel+bounces-529506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21051A42722
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C921899A92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C09A2586E8;
	Mon, 24 Feb 2025 15:54:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8A51FCD17;
	Mon, 24 Feb 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412472; cv=none; b=P0YKX5RyH19HGaxdhxmz4ZC3vpQdAb6Ep4hnDzOun34JD0RlMSm1jCYKFPi+Wv3boN3UIPxbwt8+UVSluQ4VPc+kf0aHJeKZkTXe18oXfFcAwPvVTteW96ZzRioR2lh+tySGW9ouKzCOFbJcZVdsn6aHPci48pCK03gLzSBSNjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412472; c=relaxed/simple;
	bh=2BpOpyt+qop7JXHjTgwNxpmbtY4SYv3GAwUtj/i3ZZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzdNGRVsCUQthItbWmaUDgGlQwu43zC/NfTbMZi1w1IM4yL8N5/9nVVMn6+qfVaCRy9X5aFYLp2Zy+63GKwVVnSQzly2LqJ1wz35ddf7TaPbDgIWONqQlrDwKLmuqUROv8o8ZwKv4UJZanvjQ2wLQnXWjs5xBKR9qd70oa3wMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 642531516;
	Mon, 24 Feb 2025 07:54:46 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD0563F6A8;
	Mon, 24 Feb 2025 07:54:27 -0800 (PST)
Date: Mon, 24 Feb 2025 15:54:19 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/7] firmware: arm_scmi: imx: Add i.MX95 LMM protocol
Message-ID: <Z7yWK3E5inW39jeJ@pluto>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-3-3aee005968c1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-imx-lmm-cpu-v2-3-3aee005968c1@nxp.com>

On Wed, Feb 12, 2025 at 03:40:25PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add Logical Machine Management(LMM) protocol which is intended for boot,
> shutdown, and reset of other logical machines (LM). It is usually used to
> allow one LM to manager another used as an offload or accelerator engine.
> 

Hi,

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  11 +
>  drivers/firmware/arm_scmi/vendors/imx/Makefile     |   1 +
>  drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c | 270 +++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h                  |  31 +++
>  4 files changed, 313 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
> index a01bf5e47301d2f93c9bfc7eebc77e083ea4ed75..1a936fc87d2350e2a21bccd45dfbeebfa3b90286 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
> +++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
> @@ -12,6 +12,17 @@ config IMX_SCMI_BBM_EXT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called imx-sm-bbm.
>  
> +config IMX_SCMI_LMM_EXT
> +	tristate "i.MX SCMI LMM EXTENSION"
> +	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> +	default y if ARCH_MXC
> +	help
> +	  This enables i.MX System Logical Machine Protocol to
> +	  manage Logical Machines boot, shutdown and etc.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called imx-sm-lmm.
> +
>  config IMX_SCMI_MISC_EXT
>  	tristate "i.MX SCMI MISC EXTENSION"
>  	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/Makefile b/drivers/firmware/arm_scmi/vendors/imx/Makefile
> index d3ee6d5449244a4f5cdf6abcf1845f312c512325..f39a99ccaf9af757475e8b112d224669444d7ddc 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/Makefile
> +++ b/drivers/firmware/arm_scmi/vendors/imx/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
> +obj-$(CONFIG_IMX_SCMI_LMM_EXT) += imx-sm-lmm.o
>  obj-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4b9211df2329623fae0400039db91cb2b98cded1
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System control and Management Interface (SCMI) NXP LMM Protocol
> + *
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/scmi_imx_protocol.h>
> +
> +#include "../../protocols.h"
> +#include "../../notify.h"
> +
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
> +
> +enum scmi_imx_lmm_protocol_cmd {
> +	SCMI_IMX_LMM_ATTRIBUTES	= 0x3,
> +	SCMI_IMX_LMM_BOOT = 0x4,
> +	SCMI_IMX_LMM_RESET = 0x5,
> +	SCMI_IMX_LMM_SHUTDOWN = 0x6,
> +	SCMI_IMX_LMM_WAKE = 0x7,
> +	SCMI_IMX_LMM_SUSPEND = 0x8,
> +	SCMI_IMX_LMM_NOTIFY = 0x9,
> +	SCMI_IMX_LMM_RESET_REASON = 0xA,
> +	SCMI_IMX_LMM_POWER_ON = 0xB,
> +	SCMI_IMX_LMM_RESET_VECTOR_SET = 0xC,
> +};
> +
> +struct scmi_imx_lmm_priv {
> +	u32 nr_lmm;
> +};
> +
> +#define	SCMI_IMX_LMM_PROTO_ATTR_NUM_LM(x)	(((x) & 0xFFU))
> +struct scmi_msg_imx_lmm_protocol_attributes {
> +	__le32 attributes;
> +};
> +
> +struct scmi_msg_imx_lmm_attributes_out {
> +	__le32 lmid;
> +	__le32 attributes;
> +	__le32 state;
> +	__le32 errstatus;
> +	u8 name[LMM_MAX_NAME];
> +};
> +
> +struct scmi_imx_lmm_reset_vector_set_in {
> +	__le32 lmid;
> +	__le32 cpuid;
> +#define SCMI_LMM_VEC_FLAGS_TABLE	BIT(0)
> +	__le32 flags;
> +	__le32 resetvectorlow;
> +	__le32 resetvectorhigh;
> +};
> +
> +struct scmi_imx_lmm_shutdown_in {
> +	__le32 lmid;
> +	__le32 flags;
> +};
> +
> +static int scmi_imx_lmm_validate_lmid(const struct scmi_protocol_handle *ph, u32 lmid)
> +{
> +	struct scmi_imx_lmm_priv *priv = ph->get_priv(ph);
> +
> +	if (lmid >= priv->nr_lmm)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int scmi_imx_lmm_attributes(const struct scmi_protocol_handle *ph,
> +				   u32 lmid, struct scmi_imx_lmm_info *info)
> +{
> +	struct scmi_msg_imx_lmm_attributes_out *out;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_ATTRIBUTES, sizeof(u32), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(lmid, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		info->lmid = le32_to_cpu(out->lmid);
> +		info->state = le32_to_cpu(out->state);
> +		info->errstatus = le32_to_cpu(out->errstatus);
> +		strscpy(info->name, out->name);
> +		dev_dbg(ph->dev, "i.MX LMM: Logical Machine(%d), name: %s\n",
> +			info->lmid, out->name);
> +	} else {
> +		dev_err(ph->dev, "i.MX LMM: Failed to get info of Logical Machine(%u)\n", lmid);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_lmm_boot(const struct scmi_protocol_handle *ph, u32 lmid)
> +{
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = scmi_imx_lmm_validate_lmid(ph, lmid);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_BOOT, sizeof(u32),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(lmid, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +

..this....

> +static int scmi_imx_lmm_power_on(const struct scmi_protocol_handle *ph, u32 lmid)
> +{
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = scmi_imx_lmm_validate_lmid(ph, lmid);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_POWER_ON, sizeof(u32),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(lmid, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}

...can be refatcored to use one common workhorse fcuntion sued by both
ops...

> +
> +static int scmi_imx_lmm_reset_vector_set(const struct scmi_protocol_handle *ph,
> +					 u32 lmid, u32 cpuid, u32 flags, u64 vector)
> +{
> +	struct scmi_imx_lmm_reset_vector_set_in *in;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_RESET_VECTOR_SET, sizeof(*in),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	in = t->tx.buf;
> +	in->lmid = cpu_to_le32(lmid);
> +	in->cpuid = cpu_to_le32(cpuid);
> +	in->flags = cpu_to_le32(flags);

...bitfields in a flag field must not be enianity converted...only
eventually subfields representing numbers (liek you did above)...

..I feel FIELD_PREP should be fine...or even BIT(0) really given what
these flags represents...

...again check issues with smatch....

> +	in->resetvectorlow = cpu_to_le32(lower_32_bits(vector));
> +	in->resetvectorhigh = cpu_to_le32(upper_32_bits(vector));
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_lmm_shutdown(const struct scmi_protocol_handle *ph, u32 lmid,
> +				 u32 flags)
> +{
> +	struct scmi_imx_lmm_shutdown_in *in;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = scmi_imx_lmm_validate_lmid(ph, lmid);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_SHUTDOWN, sizeof(*in),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	in = t->tx.buf;
> +	in->lmid = cpu_to_le32(lmid);
> +	in->flags = cpu_to_le32(flags);

Same here, smatch would complain if you remove straight away this
cpu_to_le32(), BUT this is a bitfield and does NOT contain any
longer-than-2 number value that needs to be endianess manipulated...you
just have to be able to set the required BIT 0 and 1, whitouth pissing
off smatch :P

> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static const struct scmi_imx_lmm_proto_ops scmi_imx_lmm_proto_ops = {
> +	.lmm_boot = scmi_imx_lmm_boot,
> +	.lmm_info = scmi_imx_lmm_attributes,
> +	.lmm_power_on = scmi_imx_lmm_power_on,
> +	.lmm_reset_vector_set = scmi_imx_lmm_reset_vector_set,
> +	.lmm_shutdown = scmi_imx_lmm_shutdown,
> +};
> +
> +static int scmi_imx_lmm_protocol_attributes_get(const struct scmi_protocol_handle *ph,
> +						struct scmi_imx_lmm_priv *priv)
> +{
> +	struct scmi_msg_imx_lmm_protocol_attributes *attr;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
> +				      sizeof(*attr), &t);
> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		priv->nr_lmm = SCMI_IMX_LMM_PROTO_ATTR_NUM_LM(le32_to_cpu(attr->attributes));

This seems wrong to me...you have an 8bit field to extract from an
attribute field...so I would at first cut the byte out and then convert
to LE, NOT the other way around like you are doing
(i.e.: le32_to_cpu((attr->attributes & 0xFF))).

Even BETTER to use:

	le32_get_bits((x), GENMASK(7, 0))

...the thing is, being a single byte you really SHOULD NOT need to address
any endianity concern (i.e. FIELD_GET(GENMASK(7, 0), (x))), BUT I fear that
if you dont use some of the le32_ accessors smatch/sparse will complain since
the message field is, correctly, declared as __le32.

So le32_get_bits is the way to go (bit check with the static analyzer :P)

> +		dev_info(ph->dev, "i.MX LMM: %d Logical Machines\n",
> +			 priv->nr_lmm);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_lmm_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_lmm_priv *info;
> +	u32 version;
> +	int ret;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(ph->dev, "NXP SM LMM Version %d.%d\n",
> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	info = devm_kzalloc(ph->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	ret = scmi_imx_lmm_protocol_attributes_get(ph, info);
> +	if (ret)
> +		return ret;
> +
> +	return ph->set_priv(ph, info, version);
> +}
> +
> +static const struct scmi_protocol scmi_imx_lmm = {
> +	.id = SCMI_PROTOCOL_IMX_LMM,
> +	.owner = THIS_MODULE,
> +	.instance_init = &scmi_imx_lmm_protocol_init,
> +	.ops = &scmi_imx_lmm_proto_ops,
> +	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
> +	.vendor_id = SCMI_IMX_VENDOR,
> +	.sub_vendor_id = SCMI_IMX_SUBVENDOR,
> +};
> +module_scmi_protocol(scmi_imx_lmm);
> +


Should this also be added:

MODULE_ALIAS("scmi-protocol-" __stringify(SCMI_PROTOCOL_IMX_LMM) "-" SCMI_IMX_VENDOR);

...after this went in:

commit d4cc8912cbff4990940b33cc61a9b09ddaee9704
Author: Cristian Marussi <cristian.marussi@arm.com>
Date:   Mon Dec 9 16:49:56 2024 +0000

    firmware: arm_scmi: Add module aliases to i.MX vendor protocol

...I think is in v6.14-rc already to rebae on...

> +MODULE_DESCRIPTION("i.MX SCMI LMM driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
> index 53b356a26414279f4aaaa8287c32209ed1ad57b4..07779c36ef9a126907e26e304a8feca16fd60ab2 100644
> --- a/include/linux/scmi_imx_protocol.h
> +++ b/include/linux/scmi_imx_protocol.h
> @@ -11,8 +11,10 @@
>  #include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <linux/notifier.h>
> +#include <linux/scmi_protocol.h>
>  #include <linux/types.h>
>  
> +#define SCMI_PROTOCOL_IMX_LMM	0x80
>  #define	SCMI_PROTOCOL_IMX_BBM	0x81
>  #define	SCMI_PROTOCOL_IMX_MISC	0x84
>  
> @@ -57,4 +59,33 @@ struct scmi_imx_misc_proto_ops {
>  	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
>  				    u32 ctrl_id, u32 evt_id, u32 flags);
>  };
> +
> +#define	LMM_ID_DISCOVER	0xFFFFFFFFU

What is this ? Documented anywhere ?

> +#define	LMM_MAX_NAME	16
> +
> +enum scmi_imx_lmm_state {
> +	LMM_STATE_LM_OFF,
> +	LMM_STATE_LM_ON,
> +	LMM_STATE_LM_SUSPEND,
> +	LMM_STATE_LM_POWERED,
> +};
> +
> +struct scmi_imx_lmm_info {
> +	u32 lmid;
> +	enum scmi_imx_lmm_state state;
> +	u32 errstatus;
> +	u8 name[LMM_MAX_NAME];
> +};
> +
> +struct scmi_imx_lmm_proto_ops {
> +	int (*lmm_boot)(const struct scmi_protocol_handle *ph, u32 lmid);
> +	int (*lmm_info)(const struct scmi_protocol_handle *ph, u32 lmid,
> +			struct scmi_imx_lmm_info *info);
> +	int (*lmm_power_on)(const struct scmi_protocol_handle *ph, u32 lmid);
> +	int (*lmm_reset_vector_set)(const struct scmi_protocol_handle *ph,
> +				    u32 lmid, u32 cpuid, u32 flags, u64 vector);
> +	int (*lmm_shutdown)(const struct scmi_protocol_handle *ph, u32 lmid,
> +			    u32 flags);
> +};
> +
>  #endif
> 

Thanks,
Cristian

