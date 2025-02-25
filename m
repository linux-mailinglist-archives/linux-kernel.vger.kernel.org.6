Return-Path: <linux-kernel+bounces-531208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E7AA43D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D47F3B0316
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75924267734;
	Tue, 25 Feb 2025 11:25:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F792676F6;
	Tue, 25 Feb 2025 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482720; cv=none; b=ldMYNeq4eVyNcpnzofzf9I7+SM/GTpzr3TYO3eIL+1StTg1wiU3DRnjCqPzLnNZvAbR984llnktUVH1ma6DXbxWO06I/xr7OWsD+aVai5o4Z1QJ/2/8ekcxYYfXbWakxTofmZ1sZ+MpbkC8ljAASpFKLhfHNszN20C/fCMWzEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482720; c=relaxed/simple;
	bh=JElWj9omZOIOVZlAA3KWEGXWH56+yW8/E4mjL6NYtoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAgxOOhPNzVu5S8jITjly5PomqENLduC21Y9imqeHwi8PW1XqPOI8wFo2m8P9sWBO/oi1exznzsk5DaloHq4L/d6oWJcxpkKRUJq/4GjOTlS7YwKFwnjShS4s2j8b8WO1iWhP6eNxW51VuLUQ+qOZR123l+naCHXhbJoWYTtV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B651516;
	Tue, 25 Feb 2025 03:25:34 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04FA53F673;
	Tue, 25 Feb 2025 03:25:15 -0800 (PST)
Date: Tue, 25 Feb 2025 11:25:06 +0000
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
Subject: Re: [PATCH v2 5/7] firmware: imx: Add i.MX95 SCMI LMM driver
Message-ID: <Z72okilByCKhSsA3@pluto>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-5-3aee005968c1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-imx-lmm-cpu-v2-5-3aee005968c1@nxp.com>

On Wed, Feb 12, 2025 at 03:40:27PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX95 System manager exports SCMI LMM protocol for linux to manage
> Logical Machines. The driver is to use the LMM Protocol interface to
> boot, shutdown a LM.
> 

Hi,

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/Kconfig    | 11 +++++
>  drivers/firmware/imx/Makefile   |  1 +
>  drivers/firmware/imx/sm-lmm.c   | 98 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/firmware/imx/sm.h | 33 ++++++++++++++
>  4 files changed, 143 insertions(+)
> 
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index 907cd149c40a8b5f1b14c53e1c315ff4a28f32ac..c3e344d6ecc645df1f0e3ee8078934c47f347fd7 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -23,6 +23,17 @@ config IMX_SCU
>  	  This driver manages the IPC interface between host CPU and the
>  	  SCU firmware running on M4.
>  
> +config IMX_SCMI_LMM_DRV
> +	tristate "IMX SCMI LMM Protocol driver"
> +	depends on IMX_SCMI_LMM_EXT || COMPILE_TEST
> +	default y if ARCH_MXC
> +	help
> +	  The System Controller Management Interface firmware (SCMI FW) is
> +	  a low-level system function which runs on a dedicated Cortex-M
> +	  core that could provide Logical Machine management features.
> +
> +	  This driver can also be built as a module.
> +
>  config IMX_SCMI_MISC_DRV
>  	tristate "IMX SCMI MISC Protocol driver"
>  	default y if ARCH_MXC
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 8d046c341be878bb6dd1e6277992ff66ae90e292..7762855d2a771169d4f1867d27e0d51be7c9ad03 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
>  obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
> +obj-${CONFIG_IMX_SCMI_LMM_DRV}	+= sm-lmm.o
> diff --git a/drivers/firmware/imx/sm-lmm.c b/drivers/firmware/imx/sm-lmm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ed9650a8cb7ca878874e8609f0a5c83b5e46204a
> --- /dev/null
> +++ b/drivers/firmware/imx/sm-lmm.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/firmware/imx/sm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/scmi_imx_protocol.h>
> +
> +static const struct scmi_imx_lmm_proto_ops *imx_lmm_ops;
> +static struct scmi_protocol_handle *ph;
> +
> +int scmi_imx_lmm_boot(u32 lmid)
> +{
> +	if (!ph)
> +		return -EPROBE_DEFER;
> +
> +	return imx_lmm_ops->lmm_boot(ph, lmid);
> +};
> +EXPORT_SYMBOL(scmi_imx_lmm_boot);


...cant you unify this...

> +
> +int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info)
> +{
> +	if (!ph)
> +		return -EPROBE_DEFER;
> +
> +	if (!info)
> +		return -EINVAL;
> +
> +	return imx_lmm_ops->lmm_info(ph, lmid, info);
> +};
> +EXPORT_SYMBOL(scmi_imx_lmm_info);
> +
> +int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector)
> +{
> +	if (!ph)
> +		return -EPROBE_DEFER;
> +
> +	return imx_lmm_ops->lmm_reset_vector_set(ph, lmid, cpuid, flags, vector);
> +}
> +EXPORT_SYMBOL(scmi_imx_lmm_reset_vector_set);
> +
> +int scmi_imx_lmm_power_on(u32 lmid)
> +{
> +	if (!ph)
> +		return -EPROBE_DEFER;
> +
> +	return imx_lmm_ops->lmm_power_on(ph, lmid);
> +};
> +EXPORT_SYMBOL(scmi_imx_lmm_power_on);

...this...

> +
> +int scmi_imx_lmm_shutdown(u32 lmid, u32 flags)
> +{
> +	if (!ph)
> +		return -EPROBE_DEFER;
> +
> +	return imx_lmm_ops->lmm_shutdown(ph, lmid, flags);
> +};
> +EXPORT_SYMBOL(scmi_imx_lmm_shutdown);
> +

...and this into some common operation that accepts parameters to
specifiy what to do...like (just making up name)

	scmi_imx_operation(lmid, flags, <OP>)

...so exporting only ONE symbol ?

> +static int scmi_imx_lmm_probe(struct scmi_device *sdev)
> +{
> +	const struct scmi_handle *handle = sdev->handle;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	if (imx_lmm_ops) {
> +		dev_err(&sdev->dev, "lmm already initialized\n");
> +		return -EEXIST;
> +	}
> +
> +	imx_lmm_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_LMM, &ph);
> +	if (IS_ERR(imx_lmm_ops))
> +		return PTR_ERR(imx_lmm_ops);
> +
> +	return 0;
> +}
> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_IMX_LMM, "imx-lmm" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static struct scmi_driver scmi_imx_lmm_driver = {
> +	.name = "scmi-imx-lmm",
> +	.probe = scmi_imx_lmm_probe,
> +	.id_table = scmi_id_table,
> +};
> +module_scmi_driver(scmi_imx_lmm_driver);
> +
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("IMX SM LMM driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
> index 9b85a3f028d1b0a5287b453eb3ad8412a363fe6c..e02b7b558afb6f430f6fbeeaf3ee1f59feea3c1b 100644
> --- a/include/linux/firmware/imx/sm.h
> +++ b/include/linux/firmware/imx/sm.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/errno.h>
> +#include <linux/scmi_imx_protocol.h>
>  #include <linux/types.h>
>  
>  #define SCMI_IMX_CTRL_PDM_CLK_SEL	0	/* AON PDM clock sel */
> @@ -20,4 +21,36 @@
>  int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
>  int scmi_imx_misc_ctrl_set(u32 id, u32 val);
>

This down below seems fine to me (maybe simoplfied as stated above) and
I guess we should see if we dont hit some weird Kconfig combination that
breaks some builds on some combination of modules/builtin: in the
past I vaguely remember Arnd posting the build error...and in fact the
above scmi_imx_misc_ctrl_set/get have NO ifdeffery and aer handeld in
that reversed way in which the protocol depends on the driver

config IMX_SCMI_MISC_EXT                                                         
        tristate "i.MX SCMI MISC EXTENSION"                                      
        depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)                     
        depends on IMX_SCMI_MISC_DRV                                             
        default y if ARCH_MXC                         

...which weird but was needed by the build bots combinations....(I
think)...so just a heads up that you could have to deal with that
again...

> +#if IS_ENABLED(CONFIG_IMX_SCMI_LMM_DRV) || IS_ENABLED(CONFIG_COMPILE_TEST)
> +int scmi_imx_lmm_boot(u32 lmid);
> +int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info);
> +int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector);
> +int scmi_imx_lmm_power_on(u32 lmid);
> +int scmi_imx_lmm_shutdown(u32 lmid, u32 flags);
> +#else
> +static inline int scmi_imx_lmm_boot(u32 lmid)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_lmm_power_on(u32 lmid)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_lmm_shutdown(u32 lmid, u32 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>  #endif
> 

Other thean the above unification:

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

