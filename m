Return-Path: <linux-kernel+bounces-217966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7FC90B6FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19B0285FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1D21662EF;
	Mon, 17 Jun 2024 16:49:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368D617C8;
	Mon, 17 Jun 2024 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642939; cv=none; b=kG99nCvAwbxBRI9E9bnO7hFJYSaBEpZH3AJ/ela0rBgDK8VKiEM5QM2hNwAF8Ha2P64kg8oY6X2qxVVQoQRBSjFEi6qyNuZ0cVCt9Mf99iuBGTe5eR6+q5zNw8ONxvsXRQh4autscEUEOPOwVX+AH/zDW4KejlKVfmGbo7GRl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642939; c=relaxed/simple;
	bh=Sw4WMbh4MR37Sjul7GaT+1B0IUYI69+si4+4QmM1hIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy3Ebwq1XyWGp5UQMtskIrboKcDHQjiqdaYMPzxULZKaRpu5ENFFv0rEsI2DOSWtQwcJ+ZPHi3OD+76D07U4eiGJYzlxhX5vZI2uKLxDNw/l7NKmvI/aiMUjwG6DGQIC7tZ56yauAHl+DMiEUiGHwT1Q3xoUaqIB5mvUyNFGYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A45ADA7;
	Mon, 17 Jun 2024 09:49:20 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BE663F64C;
	Mon, 17 Jun 2024 09:48:53 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:48:51 +0100
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
Subject: Re: [PATCH v4 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Message-ID: <ZnBo84P1Av0pZ324@pluto>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-3-dc456995d590@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-3-dc456995d590@nxp.com>

On Fri, May 24, 2024 at 04:56:45PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 has a battery-backed module(BBM), which has persistent storage (GPR),
> an RTC, and the ON/OFF button. The System Manager(SM) firmware use SCMI vendor
> protocol(SCMI BBM) to let agent be able to use GPR, RTC and ON/OFF
> button.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/Kconfig          |   2 +
>  drivers/firmware/arm_scmi/Makefile         |   1 +
>  drivers/firmware/arm_scmi/imx/Kconfig      |  14 ++
>  drivers/firmware/arm_scmi/imx/Makefile     |   2 +
>  drivers/firmware/arm_scmi/imx/imx-sm-bbm.c | 380 +++++++++++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h          |  42 ++++
>  6 files changed, 441 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index aa5842be19b2..79846cbaf71b 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -180,4 +180,6 @@ config ARM_SCMI_POWER_CONTROL
>  	  called scmi_power_control. Note this may needed early in boot to catch
>  	  early shutdown/reboot SCMI requests.
>  
> +source "drivers/firmware/arm_scmi/imx/Kconfig"
> +

It could be that we fold all the Vendor drivers under
drivers/firmware/arm_scmi/vendors once it is merged...but we will take
care of this reowrk/refctor...still not sure about this details.

>  endmenu
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index fd59f58ce8a2..fb9407fef60c 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -16,6 +16,7 @@ scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
> +obj-$(CONFIG_ARM_SCMI_PROTOCOL) += imx/
>  
>  obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
>  
> diff --git a/drivers/firmware/arm_scmi/imx/Kconfig b/drivers/firmware/arm_scmi/imx/Kconfig
> new file mode 100644
> index 000000000000..4b6ac7febe8f
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/imx/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "ARM SCMI NXP i.MX Vendor Protocols"
> +
> +config IMX_SCMI_BBM_EXT
> +	tristate "i.MX SCMI BBM EXTENSION"
> +	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> +	default y if ARCH_MXC
> +	help
> +	  This enables i.MX System BBM control logic which supports RTC
> +	  and BUTTON.
> +
> +	  This driver can also be built as a module.
> +
> +endmenu
> diff --git a/drivers/firmware/arm_scmi/imx/Makefile b/drivers/firmware/arm_scmi/imx/Makefile
> new file mode 100644
> index 000000000000..a7dbdd20dbb9
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/imx/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
> diff --git a/drivers/firmware/arm_scmi/imx/imx-sm-bbm.c b/drivers/firmware/arm_scmi/imx/imx-sm-bbm.c
> new file mode 100644
> index 000000000000..3f8321d247ae
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/imx/imx-sm-bbm.c
> @@ -0,0 +1,380 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) NXP BBM Protocol
> + *
> + * Copyright 2024 NXP
> + */
> +
> +#define pr_fmt(fmt) "SCMI Notifications BBM - " fmt
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
> +enum scmi_imx_bbm_protocol_cmd {
> +	IMX_BBM_GPR_SET = 0x3,
> +	IMX_BBM_GPR_GET = 0x4,
> +	IMX_BBM_RTC_ATTRIBUTES = 0x5,
> +	IMX_BBM_RTC_TIME_SET = 0x6,
> +	IMX_BBM_RTC_TIME_GET = 0x7,
> +	IMX_BBM_RTC_ALARM_SET = 0x8,
> +	IMX_BBM_BUTTON_GET = 0x9,
> +	IMX_BBM_RTC_NOTIFY = 0xA,
> +	IMX_BBM_BUTTON_NOTIFY = 0xB,
> +};
> +
> +#define GET_RTCS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
> +#define GET_GPRS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> +
> +#define SCMI_IMX_BBM_NOTIFY_RTC_UPDATED		BIT(2)
> +#define SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER	BIT(1)
> +#define SCMI_IMX_BBM_NOTIFY_RTC_ALARM		BIT(0)
> +
> +#define SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG	BIT(0)
> +
> +#define SCMI_IMX_BBM_NOTIFY_RTC_FLAG	\
> +	(SCMI_IMX_BBM_NOTIFY_RTC_UPDATED | SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER | \
> +	 SCMI_IMX_BBM_NOTIFY_RTC_ALARM)
> +
> +#define SCMI_IMX_BBM_EVENT_RTC_MASK		GENMASK(31, 24)
> +
> +struct scmi_imx_bbm_info {
> +	u32 version;
> +	int nr_rtc;
> +	int nr_gpr;
> +};
> +
> +struct scmi_msg_imx_bbm_protocol_attributes {
> +	__le32 attributes;
> +};
> +
> +struct scmi_imx_bbm_set_time {
> +	__le32 id;
> +	__le32 flags;
> +	__le32 value_low;
> +	__le32 value_high;
> +};
> +
> +struct scmi_imx_bbm_get_time {
> +	__le32 id;
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_bbm_alarm_time {
> +	__le32 id;
> +	__le32 flags;
> +	__le32 value_low;
> +	__le32 value_high;
> +};
> +
> +struct scmi_msg_imx_bbm_rtc_notify {
> +	__le32 rtc_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_msg_imx_bbm_button_notify {
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_bbm_notify_payld {
> +	__le32 flags;
> +};
> +
> +static int scmi_imx_bbm_attributes_get(const struct scmi_protocol_handle *ph,
> +				       struct scmi_imx_bbm_info *pi)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_imx_bbm_protocol_attributes *attr;
> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr), &t);
> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		pi->nr_rtc = GET_RTCS_NR(attr->attributes);
> +		pi->nr_gpr = GET_GPRS_NR(attr->attributes);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_bbm_notify(const struct scmi_protocol_handle *ph,
> +			       u32 src_id, int message_id, bool enable)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +
> +	if (message_id == IMX_BBM_RTC_NOTIFY) {
> +		struct scmi_msg_imx_bbm_rtc_notify *rtc_notify;
> +
> +		ret = ph->xops->xfer_get_init(ph, message_id,
> +					      sizeof(*rtc_notify), 0, &t);
> +		if (ret)
> +			return ret;
> +
> +		rtc_notify = t->tx.buf;
> +		rtc_notify->rtc_id = cpu_to_le32(0);
> +		rtc_notify->flags =
> +			cpu_to_le32(enable ? SCMI_IMX_BBM_NOTIFY_RTC_FLAG : 0);
> +	} else if (message_id == IMX_BBM_BUTTON_NOTIFY) {
> +		struct scmi_msg_imx_bbm_button_notify *button_notify;
> +
> +		ret = ph->xops->xfer_get_init(ph, message_id,
> +					      sizeof(*button_notify), 0, &t);
> +		if (ret)
> +			return ret;
> +
> +		button_notify = t->tx.buf;
> +		button_notify->flags = cpu_to_le32(enable ? 1 : 0);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +static enum scmi_imx_bbm_protocol_cmd evt_2_cmd[] = {
> +	IMX_BBM_RTC_NOTIFY,
> +	IMX_BBM_BUTTON_NOTIFY
> +};
> +
> +static int scmi_imx_bbm_set_notify_enabled(const struct scmi_protocol_handle *ph,
> +					   u8 evt_id, u32 src_id, bool enable)
> +{
> +	int ret, cmd_id;
> +
> +	if (evt_id >= ARRAY_SIZE(evt_2_cmd))
> +		return -EINVAL;
> +
> +	cmd_id = evt_2_cmd[evt_id];
> +	ret = scmi_imx_bbm_notify(ph, src_id, cmd_id, enable);
> +	if (ret)
> +		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
> +			 evt_id, src_id, ret);
> +
> +	return ret;
> +}
> +
> +static void *scmi_imx_bbm_fill_custom_report(const struct scmi_protocol_handle *ph,
> +					     u8 evt_id, ktime_t timestamp,
> +					     const void *payld, size_t payld_sz,
> +					     void *report, u32 *src_id)
> +{
> +	const struct scmi_imx_bbm_notify_payld *p = payld;
> +	struct scmi_imx_bbm_notif_report *r = report;
> +
> +	if (sizeof(*p) != payld_sz)
> +		return NULL;
> +
> +	if (evt_id == SCMI_EVENT_IMX_BBM_RTC) {
> +		r->is_rtc = true;
> +		r->is_button = false;
> +		r->timestamp = timestamp;
> +		r->rtc_id = le32_get_bits(p->flags, SCMI_IMX_BBM_EVENT_RTC_MASK);
> +		r->rtc_evt = le32_get_bits(p->flags, SCMI_IMX_BBM_NOTIFY_RTC_FLAG);
> +		dev_dbg(ph->dev, "RTC: %d evt: %x\n", r->rtc_id, r->rtc_evt);
> +		*src_id = r->rtc_evt;
> +	} else if (evt_id == SCMI_EVENT_IMX_BBM_BUTTON) {
> +		r->is_rtc = false;
> +		r->is_button = true;
> +		r->timestamp = timestamp;
> +		dev_dbg(ph->dev, "BBM Button\n");
> +		*src_id = 0;
> +	} else {
> +		WARN_ON_ONCE(1);
> +		return NULL;
> +	}
> +
> +	return r;
> +}
> +
> +static const struct scmi_event scmi_imx_bbm_events[] = {
> +	{
> +		.id = SCMI_EVENT_IMX_BBM_RTC,
> +		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
> +	},
> +	{
> +		.id = SCMI_EVENT_IMX_BBM_BUTTON,
> +		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
> +	},
> +};
> +
> +static const struct scmi_event_ops scmi_imx_bbm_event_ops = {
> +	.set_notify_enabled = scmi_imx_bbm_set_notify_enabled,
> +	.fill_custom_report = scmi_imx_bbm_fill_custom_report,
> +};
> +
> +static const struct scmi_protocol_events scmi_imx_bbm_protocol_events = {
> +	.queue_sz = SCMI_PROTO_QUEUE_SZ,
> +	.ops = &scmi_imx_bbm_event_ops,
> +	.evts = scmi_imx_bbm_events,
> +	.num_events = ARRAY_SIZE(scmi_imx_bbm_events),
> +	.num_sources = 1,
> +};
> +
> +static int scmi_imx_bbm_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	u32 version;
> +	int ret;
> +	struct scmi_imx_bbm_info *binfo;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(ph->dev, "NXP SM BBM Version %d.%d\n",
> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	binfo = devm_kzalloc(ph->dev, sizeof(*binfo), GFP_KERNEL);
> +	if (!binfo)
> +		return -ENOMEM;
> +
> +	ret = scmi_imx_bbm_attributes_get(ph, binfo);
> +	if (ret)
> +		return ret;
> +
> +	return ph->set_priv(ph, binfo, version);
> +}

I would move this init down below, right before the scmi_imx_bbm and
after the proto_ops definition,  for consistency and readability.

> +
> +static int scmi_imx_bbm_rtc_time_set(const struct scmi_protocol_handle *ph,
> +				     u32 rtc_id, u64 sec)
> +{
> +	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
> +	struct scmi_imx_bbm_set_time *cfg;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	if (rtc_id >= pi->nr_rtc)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_SET, sizeof(*cfg), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	cfg = t->tx.buf;
> +	cfg->id = cpu_to_le32(rtc_id);
> +	cfg->flags = 0;
> +	cfg->value_low = cpu_to_le32(lower_32_bits(sec));
> +	cfg->value_high = cpu_to_le32(upper_32_bits(sec));
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_bbm_rtc_time_get(const struct scmi_protocol_handle *ph,
> +				     u32 rtc_id, u64 *value)
> +{
> +	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
> +	struct scmi_imx_bbm_get_time *cfg;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	if (rtc_id >= pi->nr_rtc)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_TIME_GET, sizeof(*cfg),
> +				      sizeof(u64), &t);
> +	if (ret)
> +		return ret;
> +
> +	cfg = t->tx.buf;
> +	cfg->id = cpu_to_le32(rtc_id);
> +	cfg->flags = 0;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret)
> +		*value = get_unaligned_le64(t->rx.buf);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_bbm_rtc_alarm_set(const struct scmi_protocol_handle *ph,
> +				      u32 rtc_id, u64 sec)
> +{
> +	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
> +	struct scmi_imx_bbm_alarm_time *cfg;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	if (rtc_id >= pi->nr_rtc)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, IMX_BBM_RTC_ALARM_SET, sizeof(*cfg), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	cfg = t->tx.buf;
> +	cfg->id = cpu_to_le32(rtc_id);
> +	cfg->flags = SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG;
> +	cfg->value_low = cpu_to_le32(lower_32_bits(sec));
> +	cfg->value_high = cpu_to_le32(upper_32_bits(sec));
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_bbm_button_get(const struct scmi_protocol_handle *ph, u32 *state)
> +{
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, IMX_BBM_BUTTON_GET, 0, sizeof(u32), &t);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret)
> +		*state = get_unaligned_le32(t->rx.buf);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static const struct scmi_imx_bbm_proto_ops scmi_imx_bbm_proto_ops = {
> +	.rtc_time_get = scmi_imx_bbm_rtc_time_get,
> +	.rtc_time_set = scmi_imx_bbm_rtc_time_set,
> +	.rtc_alarm_set = scmi_imx_bbm_rtc_alarm_set,
> +	.button_get = scmi_imx_bbm_button_get,
> +};
> +

...just here the init

> +static const struct scmi_protocol scmi_imx_bbm = {
> +	.id = SCMI_PROTOCOL_IMX_BBM,
> +	.owner = THIS_MODULE,
> +	.instance_init = &scmi_imx_bbm_protocol_init,
> +	.ops = &scmi_imx_bbm_proto_ops,
> +	.events = &scmi_imx_bbm_protocol_events,
> +	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
> +	.vendor_id = "NXP",
> +	.sub_vendor_id = "i.MX95 EVK",
> +};
> +

Beside this, LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

