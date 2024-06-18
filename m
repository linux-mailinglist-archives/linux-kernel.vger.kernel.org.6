Return-Path: <linux-kernel+bounces-218994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BC790C88F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49A9B20E48
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7D1AD3E0;
	Tue, 18 Jun 2024 09:54:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B4208294;
	Tue, 18 Jun 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704442; cv=none; b=avd+pBc1+7VcrQHr22ZHrdkmwhTBFc6dfBQXBC67zRkWrU3AVB4NTDJ7Pfq3cVxvYqd/dz7zuHYX99M+DY7VAfYcLnCiPLQaHZJ/zmtk+Uwna1W+XKPfP2/S/eQk/erWCC9/2f6auYj6/0oSnknQ1+HYMxshQ9mzdCnyYIa213s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704442; c=relaxed/simple;
	bh=jka7+eNs+LtSTtXvT+c1nT2l7D0Zs0hCaA+x3srTmYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc9lgYNI520SuC21g8RG8jKlO47/elCqnv2uC68M1782ke9bYQb3xEvDWBlMe3vg76dCUHoxdfYUCMXnNxljC2MZYTnex/vhVsV9pn8ryZYvvY2YKtKYCG0Zqqqu9+AF7BdALfUmJ+Jdy/f/OaaEkyCOtoEQwqCmRbDio/Z/G0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55C55DA7;
	Tue, 18 Jun 2024 02:54:23 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 942BF3F6A8;
	Tue, 18 Jun 2024 02:53:56 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:53:54 +0100
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
Subject: Re: [PATCH v4 5/6] firmware: imx: support i.MX95 BBM module
Message-ID: <ZnFZMt5Xao1u7Ve-@pluto>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-5-dc456995d590@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-5-dc456995d590@nxp.com>

On Fri, May 24, 2024 at 04:56:47PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The BBM module provides RTC and BUTTON feature. To i.MX95, this module
> is managed by System Manager. Linux could use i.MX SCMI BBM Extension
> protocol to use RTC and BUTTON feature.
> 
> This driver is to use SCMI interface to get/set RTC, enable pwrkey.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/Makefile |   1 +
>  drivers/firmware/imx/sm-bbm.c | 314 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 315 insertions(+)
> 
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 8f9f04a513a8..fb20e22074e1 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
> +obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o
> diff --git a/drivers/firmware/imx/sm-bbm.c b/drivers/firmware/imx/sm-bbm.c
> new file mode 100644
> index 000000000000..5e7083bf8fd3
> --- /dev/null
> +++ b/drivers/firmware/imx/sm-bbm.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/scmi_imx_protocol.h>
> +#include <linux/suspend.h>
> +
> +#define DEBOUNCE_TIME		30
> +#define REPEAT_INTERVAL		60
> +
> +struct scmi_imx_bbm {
> +	struct rtc_device *rtc_dev;
> +	struct scmi_protocol_handle *ph;
> +	const struct scmi_imx_bbm_proto_ops *ops;
> +	struct notifier_block nb;
> +	int keycode;
> +	int keystate;  /* 1:pressed */
> +	bool suspended;
> +	struct delayed_work check_work;
> +	struct input_dev *input;
> +};

You could pull out the *ops in a global like

static const struct scmi_imx_bbm_proto_ops *bbm_ops;

since the protocol ops handle are always the same you will end up
overwriting it with the same value if this driver is probed multiple
times (which is harmless)...you will get anyway a different *ph handle
to operate on that you are already storing...

..up to you really

> +
> +static int scmi_imx_bbm_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +	struct scmi_protocol_handle *ph = bbnsm->ph;
> +	u64 val;
> +	int ret;
> +
> +	ret = bbnsm->ops->rtc_time_get(ph, 0, &val);
> +	if (ret)
> +		dev_err(dev, "%s: %d\n", __func__, ret);
> +

..so if you fail to get the time via SCMI you just carry on without caring ?

> +	rtc_time64_to_tm(val, tm);

... converting some random val from the stack into tm ?

> +
> +	return 0;
> +}
> +
> +static int scmi_imx_bbm_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +	struct scmi_protocol_handle *ph = bbnsm->ph;
> +	u64 val;
> +	int ret;
> +
> +	val = rtc_tm_to_time64(tm);
> +
> +	ret = bbnsm->ops->rtc_time_set(ph, 0, val);
> +	if (ret)
> +		dev_err(dev, "%s: %d\n", __func__, ret);
> +

same here why you dont report any error ?

> +	return 0;
> +}
> +
> +static int scmi_imx_bbm_alarm_irq_enable(struct device *dev, unsigned int enable)
> +{
> +	return 0;
> +}
> +
> +static int scmi_imx_bbm_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +	struct scmi_protocol_handle *ph = bbnsm->ph;
> +	struct rtc_time *alrm_tm = &alrm->time;
> +	u64 val;
> +	int ret;
> +
> +	val = rtc_tm_to_time64(alrm_tm);
> +
> +	ret = bbnsm->ops->rtc_alarm_set(ph, 0, val);
> +	if (ret)
> +		dev_err(dev, "%s: %d\n", __func__, ret);
> +

same ... 

....mmm... hang on ... this reminds me of something...

https://lore.kernel.org/linux-arm-kernel/ZdjgSxFx9YRP107y@pluto/

...I did exactly the same comments on V1 around these 2 BBM/MISC SCMI
drivers....but you never replied, addressed or disputed those issues.

You DID address other review/comments in protocols and DT in later
versions so I suppose you just forget these latter drivers reviewes
and just rebased on.

So, this review stops here for now, please address or reply to my V1
concerns on these last 2 BBM/MISC drivers.

Thanks,
Cristian

