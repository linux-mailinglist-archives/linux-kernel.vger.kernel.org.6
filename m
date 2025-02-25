Return-Path: <linux-kernel+bounces-531211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D205BA43DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F883A4440
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E822C267731;
	Tue, 25 Feb 2025 11:28:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30919259E;
	Tue, 25 Feb 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482929; cv=none; b=I5xUwoj0+YmVr9YIPJS0iEm/aEXi7Ge26XJ2Qj+oG4zPMgwIGMrSOKRQpMpCQO8bivISo4M+UWn3776RU06wHa9drttpS95iLg5caUpfwaYX73O42NLThNqy8IO57xSuc6AetWp6p6P751+GjKL9o/2z/eFGhuHksFDhQckKx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482929; c=relaxed/simple;
	bh=4N4sE1FmHGRGYMUMbzc2iDZq6cPiV731uxTPKSJWtQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyC0xCTUsOZw02M8rStvWNnoRfp2N6mJtOB1kyIm/8Zicy0+hobo6WaK4sPcbA2SlyY+ygI1xqoUR/nnThctjKbjR3Y9jozTp6/ffmMiP3sTWhqq3od4JTmaaEj7EuNekIyOuEzMuSH+zosgQMa6wrtrSes7xb2QaO7DSX3BW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A19BD1516;
	Tue, 25 Feb 2025 03:29:03 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24A463F673;
	Tue, 25 Feb 2025 03:28:45 -0800 (PST)
Date: Tue, 25 Feb 2025 11:28:42 +0000
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
Subject: Re: [PATCH v2 6/7] firmware: imx: Add i.MX95 SCMI CPU driver
Message-ID: <Z72paopAu67kQCBC@pluto>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-6-3aee005968c1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-imx-lmm-cpu-v2-6-3aee005968c1@nxp.com>

On Wed, Feb 12, 2025 at 03:40:28PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX95 System manager exports SCMI CPU protocol for linux to manage
> cpu cores. The driver is to use the cpu Protocol interface to
> start, stop a cpu cores (eg, M7).
> 

Hi,

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/Kconfig    | 11 +++++
>  drivers/firmware/imx/Makefile   |  1 +
>  drivers/firmware/imx/sm-cpu.c   | 91 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/firmware/imx/sm.h | 29 +++++++++++++
>  4 files changed, 132 insertions(+)
> 
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index c3e344d6ecc645df1f0e3ee8078934c47f347fd7..91c753921dffbe16ced8c10565d44c15b66b2797 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -23,6 +23,17 @@ config IMX_SCU
>  	  This driver manages the IPC interface between host CPU and the
>  	  SCU firmware running on M4.
>  
> +config IMX_SCMI_CPU_DRV
> +	tristate "IMX SCMI CPU Protocol driver"
> +	depends on IMX_SCMI_CPU_EXT || COMPILE_TEST
> +	default y if ARCH_MXC
> +	help
> +	  The System Controller Management Interface firmware (SCMI FW) is
> +	  a low-level system function which runs on a dedicated Cortex-M
> +	  core that could provide cpu management features.
> +
> +	  This driver can also be built as a module.
> +
>  config IMX_SCMI_LMM_DRV
>  	tristate "IMX SCMI LMM Protocol driver"
>  	depends on IMX_SCMI_LMM_EXT || COMPILE_TEST
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 7762855d2a771169d4f1867d27e0d51be7c9ad03..3bbaffa6e3478112638ed031375602389f18ef09 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
> +obj-${CONFIG_IMX_SCMI_CPU_DRV}	+= sm-cpu.o
>  obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
>  obj-${CONFIG_IMX_SCMI_LMM_DRV}	+= sm-lmm.o
> diff --git a/drivers/firmware/imx/sm-cpu.c b/drivers/firmware/imx/sm-cpu.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1ce694a34b22843db5c1697ecb33c0479edb2ed9
> --- /dev/null
> +++ b/drivers/firmware/imx/sm-cpu.c
> @@ -0,0 +1,91 @@
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
> +static const struct scmi_imx_cpu_proto_ops *imx_cpu_ops;
> +static struct scmi_protocol_handle *ph;
> +
> +int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
> +				  bool resume)
> +{
> +	if (!ph)
> +		return -EPROBE_DEFER;
> +
> +	return imx_cpu_ops->cpu_reset_vector_set(ph, cpuid, vector, start,
> +						 boot, resume);
> +}
> +EXPORT_SYMBOL(scmi_imx_cpu_reset_vector_set);
> +
> +int scmi_imx_cpu_start(u32 cpuid)
> +{
> +	if (!ph)
> +		return -EPROBE_DEFER;
> +
> +	return imx_cpu_ops->cpu_start(ph, cpuid);
> +};
> +EXPORT_SYMBOL(scmi_imx_cpu_start);
> +

...same as in LMM...this...

> +int scmi_imx_cpu_started(u32 cpuid, bool *started)
> +{
> +	if (!ph)
> +		return -EPROBE_DEFER;
> +
> +	if (!started)
> +		return -EINVAL;
> +
> +	return imx_cpu_ops->cpu_started(ph, cpuid, started);
> +};
> +EXPORT_SYMBOL(scmi_imx_cpu_started);
> +
> +int scmi_imx_cpu_stop(u32 cpuid)
> +{
> +	if (!ph)
> +		return -EPROBE_DEFER;
> +
> +	return imx_cpu_ops->cpu_stop(ph, cpuid);
> +};
> +EXPORT_SYMBOL(scmi_imx_cpu_stop);
> +

...and this can be just one with ONLY one symbol exported...

> +static int scmi_imx_cpu_probe(struct scmi_device *sdev)
> +{
> +	const struct scmi_handle *handle = sdev->handle;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	if (imx_cpu_ops) {
> +		dev_err(&sdev->dev, "sm cpu already initialized\n");
> +		return -EEXIST;
> +	}
> +
> +	imx_cpu_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_CPU, &ph);
> +	if (IS_ERR(imx_cpu_ops))
> +		return PTR_ERR(imx_cpu_ops);
> +
> +	return 0;
> +}
> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_IMX_CPU, "imx-cpu" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static struct scmi_driver scmi_imx_cpu_driver = {
> +	.name = "scmi-imx-cpu",
> +	.probe = scmi_imx_cpu_probe,
> +	.id_table = scmi_id_table,
> +};
> +module_scmi_driver(scmi_imx_cpu_driver);
> +
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("IMX SM CPU driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
> index e02b7b558afb6f430f6fbeeaf3ee1f59feea3c1b..0eff427e5ba2cb3f93c26f7d055c346a1d1433f0 100644
> --- a/include/linux/firmware/imx/sm.h
> +++ b/include/linux/firmware/imx/sm.h
> @@ -21,6 +21,35 @@
>  int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
>  int scmi_imx_misc_ctrl_set(u32 id, u32 val);
>  

Same kind of heads up here too..

> +#if IS_ENABLED(CONFIG_IMX_SCMI_CPU_DRV) || IS_ENABLED(CONFIG_COMPILE_TEST)
> +int scmi_imx_cpu_start(u32 cpuid);
> +int scmi_imx_cpu_started(u32 cpuid, bool *started);
> +int scmi_imx_cpu_stop(u32 cpuid);
> +int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
> +				  bool resume);
> +#else
> +static inline int scmi_imx_cpu_start(u32 cpuid)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_cpu_started(u32 cpuid, bool *started)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_cpu_stop(u32 cpuid)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector,
> +						bool start, bool boot, bool resume)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>  #if IS_ENABLED(CONFIG_IMX_SCMI_LMM_DRV) || IS_ENABLED(CONFIG_COMPILE_TEST)
>  int scmi_imx_lmm_boot(u32 lmid);
>  int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info);
> 

Other than this:

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

