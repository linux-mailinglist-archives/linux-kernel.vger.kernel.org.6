Return-Path: <linux-kernel+bounces-218118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638F90B980
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ED21C247CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DB198E98;
	Mon, 17 Jun 2024 18:15:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44518A936;
	Mon, 17 Jun 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648100; cv=none; b=FUbyOjgnGa/aELSgHeV5C4nqSJq/fwcvFy9X8A8AhhCVyDbqGNwsfwd8yY2OCGaEjRvmY7gyXqJFOxp8pwGWvDB33PuS8bpR3oqNq1fQ5FXRnhK5G8rPzSSvJgAwNb3Jj961MtRKyAgj3BKcblab9y6EeAmkQu5bMcqs9i4pg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648100; c=relaxed/simple;
	bh=mpmGlclO5ikb0r4SSQjwKdivKLtbIGzilfVMUizDYf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8Gt+EbeZjusndYC0/LJ4EZAfwaGqefpptcCfn6Ba5zhqILVy6LqbVweB+VSH2cihE9n151E8sKjAOAvNzw4CEqwOBgHn3XsroqXW+o1OPFBRb5u4Mp9HAY3nMS+f1hfS1sYtQAoBrk/5ats4sxdVYDHh65IBO92lpc5VWaZHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9829EDA7;
	Mon, 17 Jun 2024 11:15:21 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CFDE3F64C;
	Mon, 17 Jun 2024 11:14:41 -0700 (PDT)
Date: Mon, 17 Jun 2024 19:14:24 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Message-ID: <ZnB9ANdbJ9d9MZHD@pluto>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-4-dc456995d590@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-4-dc456995d590@nxp.com>

On Fri, May 24, 2024 at 04:56:46PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 System Manager(SM) firmware includes a SCMI vendor protocol, SCMI
> MISC protocol which includes controls that are misc settings/actions that
> must be exposed from the SM to agents. They are device specific and are
> usually define to access bit fields in various mix block control modules,
> IOMUX_GPR, and other General Purpose registers, Control Status Registers
> owned by the SM.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/imx/Kconfig       |   9 +
>  drivers/firmware/arm_scmi/imx/Makefile      |   1 +
>  drivers/firmware/arm_scmi/imx/imx-sm-misc.c | 303 ++++++++++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h           |  22 ++
>  4 files changed, 335 insertions(+)
> 

Hi,

> diff --git a/drivers/firmware/arm_scmi/imx/Kconfig b/drivers/firmware/arm_scmi/imx/Kconfig
> index 4b6ac7febe8f..e9d015859eaa 100644
> --- a/drivers/firmware/arm_scmi/imx/Kconfig
> +++ b/drivers/firmware/arm_scmi/imx/Kconfig
> @@ -11,4 +11,13 @@ config IMX_SCMI_BBM_EXT
>  
>  	  This driver can also be built as a module.
>  
> +config IMX_SCMI_MISC_EXT
> +	tristate "i.MX SCMI MISC EXTENSION"
> +	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> +	default y if ARCH_MXC
> +	help
> +	  This enables i.MX System MISC control logic such as gpio expander
> +	  wakeup
> +
> +	  This driver can also be built as a module.
>  endmenu
> diff --git a/drivers/firmware/arm_scmi/imx/Makefile b/drivers/firmware/arm_scmi/imx/Makefile
> index a7dbdd20dbb9..d3ee6d544924 100644
> --- a/drivers/firmware/arm_scmi/imx/Makefile
> +++ b/drivers/firmware/arm_scmi/imx/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
> +obj-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
> diff --git a/drivers/firmware/arm_scmi/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/imx/imx-sm-misc.c
> new file mode 100644
> index 000000000000..9d0063299310
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/imx/imx-sm-misc.c
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System control and Management Interface (SCMI) NXP MISC Protocol
> + *
> + * Copyright 2024 NXP
> + */
> +
> +#define pr_fmt(fmt) "SCMI Notifications MISC - " fmt
> +
> +#include <linux/bits.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/scmi_imx_protocol.h>
> +
> +#include "../protocols.h"
> +#include "../notify.h"
> +
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
> +
> +enum scmi_imx_misc_protocol_cmd {
> +	SCMI_IMX_MISC_CTRL_SET	= 0x3,
> +	SCMI_IMX_MISC_CTRL_GET	= 0x4,
> +	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
> +};
> +
> +struct scmi_imx_misc_info {
> +	u32 version;
> +	u32 nr_dev_ctrl;
> +	u32 nr_brd_ctrl;
> +	u32 nr_reason;
> +};
> +
> +struct scmi_msg_imx_misc_protocol_attributes {
> +	__le32 attributes;
> +};
> +
> +#define GET_BRD_CTRLS_NR(x)	le32_get_bits((x), GENMASK(31, 24))
> +#define GET_REASONS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
> +#define GET_DEV_CTRLS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> +#define BRD_CTRL_START_ID	BIT(15)
> +
> +struct scmi_imx_misc_ctrl_set_in {
> +	__le32 id;
> +	__le32 num;
> +	__le32 value[MISC_MAX_VAL];
> +};
> +
> +struct scmi_imx_misc_ctrl_notify_in {
> +	__le32 ctrl_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_misc_ctrl_notify_payld {
> +	__le32 ctrl_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_misc_ctrl_get_out {
> +	__le32 num;
> +	__le32 val[MISC_MAX_VAL];
> +};
> +
> +static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
> +					struct scmi_imx_misc_info *mi)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_imx_misc_protocol_attributes *attr;
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
> +		mi->nr_dev_ctrl = GET_DEV_CTRLS_NR(attr->attributes);
> +		mi->nr_brd_ctrl = GET_BRD_CTRLS_NR(attr->attributes);
> +		mi->nr_reason = GET_REASONS_NR(attr->attributes);
> +		dev_info(ph->dev, "i.MX MISC NUM DEV CTRL: %d, NUM BRD CTRL: %d,NUM Reason: %d\n",
> +			 mi->nr_dev_ctrl, mi->nr_brd_ctrl, mi->nr_reason);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_misc_ctrl_validate_id(const struct scmi_protocol_handle *ph,
> +					  u32 ctrl_id)
> +{
> +	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
> +
> +	if ((ctrl_id < BRD_CTRL_START_ID) && (ctrl_id > mi->nr_dev_ctrl))
> +		return -EINVAL;
> +	if (ctrl_id >= BRD_CTRL_START_ID + mi->nr_brd_ctrl)
> +		return -EINVAL;

...are these conditions fine ? just checking because they seem a bit
odd...but I am certainly missing something...in case they are ok, is it
possible to add a comment explaining why those conds lead to -EINVAL ?

> +
> +	return 0;
> +}
> +
> +static int scmi_imx_misc_ctrl_notify(const struct scmi_protocol_handle *ph,
> +				     u32 ctrl_id, u32 evt_id, u32 flags)
> +{
> +	struct scmi_imx_misc_ctrl_notify_in *in;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_NOTIFY,
> +				      sizeof(*in), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	in = t->tx.buf;
> +	in->ctrl_id = cpu_to_le32(ctrl_id);
> +	in->flags = cpu_to_le32(flags);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int
> +scmi_imx_misc_ctrl_set_notify_enabled(const struct scmi_protocol_handle *ph,
> +				      u8 evt_id, u32 src_id, bool enable)
> +{
> +	int ret;
> +
> +	/* misc_ctrl_req_notify is for enablement */
> +	if (enable)
> +		return 0;
> +
> +	ret = scmi_imx_misc_ctrl_notify(ph, src_id, evt_id, 0);
> +	if (ret)
> +		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] - ret:%d\n",
> +			evt_id, src_id, ret);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_misc_ctrl_get_num_sources(const struct scmi_protocol_handle *ph)
> +{
> +	return GENMASK(15, 0);
> +}

This is statically defined at compile time..you dont need to provide
this method, which is just for discover number of possible event sources
at runtime....just drop it and use .num_sources in scmi_protocol_events

> +
> +static void *
> +scmi_imx_misc_ctrl_fill_custom_report(const struct scmi_protocol_handle *ph,
> +				      u8 evt_id, ktime_t timestamp,
> +				      const void *payld, size_t payld_sz,
> +				      void *report, u32 *src_id)
> +{
> +	const struct scmi_imx_misc_ctrl_notify_payld *p = payld;
> +	struct scmi_imx_misc_ctrl_notify_report *r = report;
> +
> +	if (sizeof(*p) != payld_sz)
> +		return NULL;
> +
> +	r->timestamp = timestamp;
> +	r->ctrl_id = p->ctrl_id;
> +	r->flags = p->flags;
> +	if (src_id)
> +		*src_id = r->ctrl_id;
> +	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__,
> +		r->ctrl_id, r->flags);
> +
> +	return r;
> +}
> +
> +static const struct scmi_event_ops scmi_imx_misc_event_ops = {
> +	.get_num_sources = scmi_imx_misc_ctrl_get_num_sources,
drop

> +	.set_notify_enabled = scmi_imx_misc_ctrl_set_notify_enabled,
> +	.fill_custom_report = scmi_imx_misc_ctrl_fill_custom_report,
> +};
> +
> +static const struct scmi_event scmi_imx_misc_events[] = {
> +	{
> +		.id = SCMI_EVENT_IMX_MISC_CONTROL,
> +		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
> +	},
> +};
> +
> +static struct scmi_protocol_events scmi_imx_misc_protocol_events = {
> +	.queue_sz = SCMI_PROTO_QUEUE_SZ,
> +	.ops = &scmi_imx_misc_event_ops,
> +	.evts = scmi_imx_misc_events,
> +	.num_events = ARRAY_SIZE(scmi_imx_misc_events),

	.num_sources = MAX_MISC_CTRL_SOURCES,  // GENMASK(15, 0)

> +};
> +
> +static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_misc_info *minfo;
> +	u32 version;
> +	int ret;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	minfo = devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
> +	if (!minfo)
> +		return -ENOMEM;
> +
> +	ret = scmi_imx_misc_attributes_get(ph, minfo);
> +	if (ret)
> +		return ret;
> +
> +	return ph->set_priv(ph, minfo, version);
> +}

Same as previous patch please move the init downb below near the
scmi_protocol struct right after the ops

> +
> +static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handle *ph,
> +				  u32 ctrl_id, u32 *num, u32 *val)
> +{
> +	struct scmi_imx_misc_ctrl_get_out *out;
> +	struct scmi_xfer *t;
> +	int ret, i;
> +
> +	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET, sizeof(u32),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(ctrl_id, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		*num = le32_to_cpu(out->num);

To stay even more safer, by guarding from malformed *num fields and just
bail out upfront with an error

	if (*num >= MISC_MAX_VAL ||
	    *num * sizeof(__le32) > t->rx.len - sizeof(__le32))

and then just

		for (i = 0; i < *num; i++)

> +		for (i = 0; i < *num && i < MISC_MAX_VAL; i++)
> +			val[i] = le32_to_cpu(out->val[i]);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
> +				  u32 ctrl_id, u32 num, u32 *val)
> +{
> +	struct scmi_imx_misc_ctrl_set_in *in;
> +	struct scmi_xfer *t;
> +	int ret, i;
> +
> +	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> +	if (ret)
> +		return ret;
> +
> +	if (num > MISC_MAX_VAL)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET, sizeof(*in),
> +				      0, &t);
> +	if (ret)
> +		return ret;
> +
> +	in = t->tx.buf;
> +	in->id = cpu_to_le32(ctrl_id);
> +	in->num = cpu_to_le32(num);
> +	for (i = 0; i < num; i++)
> +		in->value[i] = cpu_to_le32(val[i]);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
> +	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
> +	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
> +	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
> +};
> +
> +static const struct scmi_protocol scmi_imx_misc = {
> +	.id = SCMI_PROTOCOL_IMX_MISC,
> +	.owner = THIS_MODULE,
> +	.instance_init = &scmi_imx_misc_protocol_init,
> +	.ops = &scmi_imx_misc_proto_ops,
> +	.events = &scmi_imx_misc_protocol_events,
> +	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
> +	.vendor_id = "NXP",
> +	.sub_vendor_id = "i.MX95 EVK",
> +};
> +module_scmi_protocol(scmi_imx_misc);
> diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
> index e59aedaa4aec..e9285abfc191 100644
> --- a/include/linux/scmi_imx_protocol.h
> +++ b/include/linux/scmi_imx_protocol.h
> @@ -13,8 +13,14 @@
>  #include <linux/notifier.h>
>  #include <linux/types.h>
>  
> +#define SCMI_PAYLOAD_LEN	100
> +
> +#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
> +#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
>
You base all of this on this fixed payload length, but the payload
really depends on the configured underlying transport: you can use the
ph->hops->get_max_msg_size to retrieve the configured max payload length
for the platform you are running on....nad maybe bailout if the minimum
size required by your protocol is not available with the currently
configured transport...wouldnt't be more robust and reliable then
builtin fixing some payload ?

Thanks,
Cristian

