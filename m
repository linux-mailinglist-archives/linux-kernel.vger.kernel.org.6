Return-Path: <linux-kernel+bounces-529774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215BA42ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379397A7023
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DDC26562F;
	Mon, 24 Feb 2025 18:10:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6B1264A89;
	Mon, 24 Feb 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420655; cv=none; b=rs+akvdxfjdzXikQI3MgzmPlHa7+mbobmYyzbA2wHA2+uoGFq3mA6pveX8yPi70fOGdIidTQuH831AIeqp7Q8Tnai8B9KtGli1HISFe1g9IaLZQ0Zk3t0wp509EfBT32Onj2MIgw/mReCKFL+nj4GkJU+thNZ0WXzUCf0VkAZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420655; c=relaxed/simple;
	bh=AgvRmCeiRGHIUxnqNfNH2rvw6T1rPBzqHaSEB9w3A1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZJojTyK2Z6+hxeE/95iyBnd6xdl3uInW6rS58F007JuMp65Q0weWQXKflwfwAiglNRJmV4IBc2ErH84jCfY7KbEBVkXBgBUZs/euAPD3BCDN9BvO8XakzKls6o9GlQtw//TXq0+IoOx/zWAyyDhCFqL8TQ6voMoiLbo/fATZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5A01152B;
	Mon, 24 Feb 2025 10:11:09 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 236753F5A1;
	Mon, 24 Feb 2025 10:10:51 -0800 (PST)
Date: Mon, 24 Feb 2025 18:10:48 +0000
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
Subject: Re: [PATCH v2 4/7] firmware: arm_scmi: imx: Add i.MX95 CPU Protocol
Message-ID: <Z7y2KFYt5gIY19Qz@pluto>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-4-3aee005968c1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-imx-lmm-cpu-v2-4-3aee005968c1@nxp.com>

On Wed, Feb 12, 2025 at 03:40:26PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This protocol allows an agent to start, stop a CPU or set reset vector. It
> is used to manage auxiliary CPUs in an LM (e.g. additional cores in an AP
> cluster).
> 

Hi,

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  11 +
>  drivers/firmware/arm_scmi/vendors/imx/Makefile     |   1 +
>  drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c | 287 +++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h                  |  10 +
>  4 files changed, 309 insertions(+)
> 

[snip]

> +
> +struct scmi_imx_cpu_info_get_out {
> +#define	CPU_RUN_MODE_START	0
> +#define	CPU_RUN_MODE_HOLD	1
> +#define	CPU_RUN_MODE_STOP	2
> +#define	CPU_RUN_MODE_SLEEP	3
> +	__le32 runmode;
> +	__le32 sleepmode;
> +	__le32 resetvectorlow;
> +	__le32 resetvectorhigh;
> +};
> +
> +static int scmi_imx_cpu_validate_cpuid(const struct scmi_protocol_handle *ph,
> +				       u32 cpuid)
> +{
> +	struct scmi_imx_cpu_info *info = ph->get_priv(ph);
> +
> +	if (cpuid >= info->nr_cpu)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int scmi_imx_cpu_start(const struct scmi_protocol_handle *ph, u32 cpuid)
> +{
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_START, sizeof(u32),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(cpuid, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_cpu_stop(const struct scmi_protocol_handle *ph, u32 cpuid)
> +{
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_STOP, sizeof(u32),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(cpuid, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +

Please refactor and unify this 2 seemingly identical start/stop funcs by
defining a common helper...

> +static int scmi_imx_cpu_reset_vector_set(const struct scmi_protocol_handle *ph,
> +					 u32 cpuid, u64 vector, bool start,
> +					 bool boot, bool resume)
> +{
> +	struct scmi_imx_cpu_reset_vector_set_in *in;
> +	struct scmi_xfer *t;
> +	int ret;
> +	u32 flags;
> +
> +	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_RESET_VECTOR_SET, sizeof(*in),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	in = t->tx.buf;
> +	in->cpuid = cpu_to_le32(cpuid);
> +	flags = start ? CPU_VEC_FLAGS_START : 0;
> +	flags |= boot ? CPU_VEC_FLAGS_BOOT : 0;
> +	flags |= resume ? CPU_VEC_FLAGS_RESUME : 0;
> +	in->flags = cpu_to_le32(flags);

...you should just avoid the endianess helper given that is a bitfield (I cannot
exclude that there are other places where we wrongly endianIZE bitfields...) and
I think that the best way to do it without cause smatch to cry would be
to use le32_encode_bits() which should just produce the desired flags
into an __le32

le32_encode_bits and friends are used throughout the code base and added

https://patchwork.ozlabs.org/project/ubuntu-kernel/patch/20190606034255.2192-2-aaron.ma@canonical.com/

which seems to be the best (and only) documentation :P

> +	in->resetvectorlow = cpu_to_le32(lower_32_bits(vector));
> +	in->resetvectorhigh = cpu_to_le32(upper_32_bits(vector));
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_cpu_started(const struct scmi_protocol_handle *ph, u32 cpuid,
> +				bool *started)
> +{
> +	struct scmi_imx_cpu_info_get_out *out;
> +	struct scmi_xfer *t;
> +	u32 mode;
> +	int ret;
> +

maybe overlay paranoid...but

	if (!started)
		return -EINVAL;

...up to you, if you feel paranoid too

> +	*started = false;
> +	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_INFO_GET, sizeof(u32),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(cpuid, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		mode = le32_to_cpu(out->runmode);
> +		if ((mode == CPU_RUN_MODE_START) || (mode == CPU_RUN_MODE_SLEEP))
> +			*started = true;
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static const struct scmi_imx_cpu_proto_ops scmi_imx_cpu_proto_ops = {
> +	.cpu_reset_vector_set = scmi_imx_cpu_reset_vector_set,
> +	.cpu_start = scmi_imx_cpu_start,
> +	.cpu_started = scmi_imx_cpu_started,
> +	.cpu_stop = scmi_imx_cpu_stop,
> +};
> +
> +static int scmi_imx_cpu_protocol_attributes_get(const struct scmi_protocol_handle *ph,
> +						struct scmi_imx_cpu_info *info)
> +{
> +	struct scmi_msg_imx_cpu_protocol_attributes *attr;
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
> +		info->nr_cpu = SCMI_IMX_CPU_PROTO_ATTR_NUM_CPUS(attr->attributes);

	
	le32_get_bits(attr->attributes, GENMASK())

> +		dev_info(ph->dev, "i.MX SM CPU: %d cpus\n",
> +			 info->nr_cpu);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_cpu_attributes_get(const struct scmi_protocol_handle *ph,
> +				       u32 cpuid)
> +{
> +	struct scmi_msg_imx_cpu_attributes_out *out;
> +	char name[SCMI_SHORT_NAME_MAX_SIZE] = {'\0'};
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_ATTRIBUTES, sizeof(u32), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(cpuid, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		strscpy(name, out->name, SCMI_SHORT_NAME_MAX_SIZE);
> +		dev_info(ph->dev, "i.MX CPU: name: %s\n", name);
> +	} else {
> +		dev_err(ph->dev, "i.MX cpu: Failed to get info of cpu(%u)\n", cpuid);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_cpu_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_cpu_info *info;
> +	u32 version;
> +	int ret, i;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(ph->dev, "NXP SM CPU Protocol Version %d.%d\n",
> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	info = devm_kzalloc(ph->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	ret = scmi_imx_cpu_protocol_attributes_get(ph, info);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < info->nr_cpu; i++) {
> +		ret = scmi_imx_cpu_attributes_get(ph, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ph->set_priv(ph, info, version);
> +}
> +
> +static const struct scmi_protocol scmi_imx_cpu = {
> +	.id = SCMI_PROTOCOL_IMX_CPU,
> +	.owner = THIS_MODULE,
> +	.instance_init = &scmi_imx_cpu_protocol_init,
> +	.ops = &scmi_imx_cpu_proto_ops,
> +	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
> +	.vendor_id = SCMI_IMX_VENDOR,
> +	.sub_vendor_id = SCMI_IMX_SUBVENDOR,
> +};
> +module_scmi_protocol(scmi_imx_cpu);

similarly as LMM...

MODULE_ALIAS("scmi-protocol-" __stringify(SCMI_PROTOCOL_IMX_CPU) "-" SCMI_IMX_VENDOR);

Thanks
Cristian


