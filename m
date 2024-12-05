Return-Path: <linux-kernel+bounces-432845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7539E50EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B4828D6AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D421D5ABF;
	Thu,  5 Dec 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9+7uZVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED117B506;
	Thu,  5 Dec 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390005; cv=none; b=JNUyGCDhqiwjRw7fZvNuIpfdygv/P9GKsWoKFDIAYS1M5SWteSnFekZwwUfm/+6p8u31mMb8LDEaYJC5gZ6uDX4CUUyRqFLQwgrLeWVEDqvZfr5oCaRBLCx/pvz4NcgtiqMje/lUJ7gVUeTPvKkGU1pl0V6rCozx3rqLa11coRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390005; c=relaxed/simple;
	bh=WdE5eABK3Hylwe7OyPJbjDEBKRm6U7V5R4jpDJGusNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9hSgkKYaB2C3LKWrIUxpFjvaBYV1WRapU8ok0GIOoQL4iBwMsaZlHS6GBsPIFIwDDWXt/rpWzNG4gS9W/tSWCNOD4wycW7pAdSHeW99u3LHR+EK8KDvK8KyuQsWw1n7tPv/0xkNszAxsBlI8pEE/7D20ZijzdLb/Lk2f1naLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9+7uZVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70D9C4CED1;
	Thu,  5 Dec 2024 09:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390004;
	bh=WdE5eABK3Hylwe7OyPJbjDEBKRm6U7V5R4jpDJGusNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9+7uZVh5dgH9FYmH7bgSszkuEHSIVBDZ9NlGpSi8Sha2xcXtg6mkBUYRXXjC3Cz8
	 5oR5lLSkmULtNLbkGUlwKtQwJImNTJCAMgz7IpGTOeVy5DHhabkG6d5xYKsKXio5Zu
	 0BWJuP+Z7UbLJUAhGDMZUn1vqwA8Rhq+A06ykRAgL2lSM9NLczUNh5t5Y6meZpdruV
	 pUVWhQjttHLZotZ5y6z0nRawLFX6swKOwBeTjQeteww9zdBh95wFAVyo0ywFIOkE1L
	 Dyhh9vYS7nlbei151FxV4DRRIAq3hbznUEKRs71ASc4D0UWIzUsyBoXg8mcmUDGjdt
	 8T8vqaCwbfr1Q==
Date: Thu, 5 Dec 2024 10:13:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
	pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, V.Sethi@nxp.com, 
	meenakshi.aggarwal@nxp.com, Franck LENORMAND <franck.lenormand@nxp.com>
Subject: Re: [PATCH v4 4/4] firmware: imx: secvio: Add support for SNVS
 secvio and tamper via SCFW
Message-ID: <fihqc5qtocjauc52e6ri34v5nqzaz3vbk4usafpwkoaslc32qn@kjkpwsm6fqur>
References: <20241205-secvio-v4-0-5c37cdc39573@nxp.com>
 <20241205-secvio-v4-4-5c37cdc39573@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205-secvio-v4-4-5c37cdc39573@nxp.com>

On Thu, Dec 05, 2024 at 05:56:35AM +0100, Vabhav Sharma wrote:
> +
> +int imx_secvio_sc_debugfs(struct device *dev)
> +{
> +	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
> +	struct dentry *dir;
> +	int ret = 0;
> +
> +	/* Create a folder */
> +	dir = debugfs_create_dir(dev_name(dev), NULL);
> +	if (IS_ERR(dir)) {
> +		dev_err(dev, "Failed to create dfs dir\n");

Drop

> +		ret = PTR_ERR(dir);
> +		goto exit;

Drop all this.

> +	}
> +	data->dfs = dir;
> +
> +	ret = devm_add_action(dev, if_debugfs_remove_recursive, data->dfs);
> +	if (ret) {
> +		dev_err(dev, "Failed to add managed action to disable IRQ\n");

Drop

> +		goto remove_fs;
> +	}
> +
> +	/* Create the file to read info and write to reg */
> +	dir = debugfs_create_file("info", 0x666, data->dfs, dev,
> +				  &imx_secvio_sc_info_ops);
> +	if (IS_ERR(dir)) {
> +		dev_err(dev, "Failed to add info to debugfs\n");

There is *never such code*. You never print error messages and fail the
probe on debugfs. Drop.


> +		ret = PTR_ERR(dir);
> +		goto exit;

Drop

This has several trivial issues. I suggest doing extensive
internal review before asking the community to look at this.

> +	}
> +
> +exit:
> +	return ret;
> +
> +remove_fs:
> +	debugfs_remove_recursive(data->dfs);
> +	goto exit;
> +}
> diff --git a/drivers/firmware/imx/imx-scu-secvio.c b/drivers/firmware/imx/imx-scu-secvio.c
> new file mode 100644
> index 000000000000..30eb9e4bf7b8
> --- /dev/null
> +++ b/drivers/firmware/imx/imx-scu-secvio.c
> @@ -0,0 +1,619 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019, 2024 NXP
> + *
> + */
> +
> +/*
> + * The i.MX8QXP SoC contains the Secure Non-Volatile Storage (SNVS) block. This
> + * block can detect specific hardware attacks.This block can only be accessible
> + * using the SCFW API.
> + *
> + * This module interact with the SCU which relay request to/from the SNVS block
> + * to detect if security violation occurred.
> + *
> + * The module exports an API to add processing when a SV is detected:
> + *  - register_imx_secvio_sc_notifier
> + *  - unregister_imx_secvio_sc_notifier
> + *  - imx_secvio_sc_check_state
> + *  - imx_secvio_sc_clear_state
> + *  - imx_secvio_sc_enable_irq
> + *  - imx_secvio_sc_disable_irq
> + */
> +
> +#include <dt-bindings/firmware/imx/rsrc.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +
> +#include <linux/uaccess.h>
> +
> +#include <linux/firmware/imx/ipc.h>
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/firmware/imx/svc/seco.h>
> +#include <linux/firmware/imx/svc/rm.h>
> +#include <linux/firmware/imx/svc/imx-secvio-sc.h>
> +
> +/* Reference on the driver_device */
> +static struct device *imx_secvio_sc_dev;
> +
> +/* Register IDs for sc_seco_secvio_config API */
> +#define HPSVS_ID 0x18
> +#define LPS_ID 0x4c
> +#define LPTDS_ID 0xa4
> +#define HPVIDR_ID 0xf8
> +
> +#define SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER 0x53
> +#define SECO_VERSION_MINOR_MASK GENMASK(15, 0)
> +
> +static struct platform_driver imx_secvio_sc_driver;

Drop, not used... or you messed up cleaning processes.

> +static struct platform_device *pdev;

Singletons are really poor coding approach. Fix your driver architecture
so this will be properly instantiated only once, not multiple times.

> +static struct device *scdev;

Drop, not needed. Fix your driver.

> +
> +/* Notifier list for new CB */
> +static BLOCKING_NOTIFIER_HEAD(imx_secvio_sc_notifier_chain);
> +
> +int register_imx_secvio_sc_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&imx_secvio_sc_notifier_chain,
> +						nb);
> +}
> +EXPORT_SYMBOL(register_imx_secvio_sc_notifier);

NAK

> +
> +int unregister_imx_secvio_sc_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&imx_secvio_sc_notifier_chain,
> +						  nb);
> +}
> +EXPORT_SYMBOL(unregister_imx_secvio_sc_notifier);

1. You mix up exports with statics. This driver is poorly organized.
Really it is a mess here.
2. Why do you need to export these? These are not used, so you cannot
have them.

That's a strong NAK. Stop bringing here some stuff for yourodownstream.


> +
> +static void if_imx_scu_irq_register_notifier(void *nb)
> +{
> +	imx_scu_irq_register_notifier(nb);
> +}
> +
> +static void if_unregister_imx_secvio_sc_notifier(void *nb)
> +{
> +	unregister_imx_secvio_sc_notifier(nb);
> +}
> +
> +static
> +int imx_secvio_sc_notifier_call_chain(struct secvio_sc_notifier_info *info)
> +{
> +	return blocking_notifier_call_chain(&imx_secvio_sc_notifier_chain, 0,
> +					    (void *)info);
> +}
> +
> +int imx_secvio_sc_get_state(struct device *dev,
> +			    struct secvio_sc_notifier_info *info)
> +{
> +	int ret, err = 0;
> +	struct imx_secvio_sc_data *data;
> +
> +	dev = imx_secvio_sc_dev;
> +	if (!dev)
> +		return -EINVAL;
> +
> +	data = dev_get_drvdata(dev);
> +
> +	/* Read secvio status */
> +	ret = imx_sc_seco_secvio_config(data->ipc_handle, HPSVS_ID, SECVIO_CONFIG_READ,
> +					&info->hpsvs, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		err = ret;
> +		dev_err(dev, "Fail read secvio config status %d\n", ret);
> +	}
> +	info->hpsvs &= HPSVS_ALL_SV_MASK;
> +
> +	/* Read tampers status */
> +	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPS_ID, SECVIO_CONFIG_READ,
> +					&info->lps, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		err = ret;
> +		dev_err(dev, "Fail read tamper 1 status: %d\n", ret);
> +	}
> +	info->lps &= LPS_ALL_TP_MASK;
> +
> +	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPTDS_ID, SECVIO_CONFIG_READ,
> +					&info->lptds, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		err = ret;
> +		dev_err(dev, "Fail read  tamper 2 status: %d\n", ret);
> +	}
> +	info->lptds &= LPTDS_ALL_TP_MASK;
> +
> +	dev_dbg(dev, "Status: %.8x, %.8x, %.8x\n", info->hpsvs,
> +		info->lps, info->lptds);

No, don't print internal values.

> +
> +	return err;
> +}
> +EXPORT_SYMBOL(imx_secvio_sc_get_state);

NAK, no users.

> +
> +int imx_secvio_sc_check_state(struct device *dev)
> +{
> +	struct secvio_sc_notifier_info info;
> +	int ret;
> +
> +	dev = imx_secvio_sc_dev;
> +
> +	ret = imx_secvio_sc_get_state(dev, &info);
> +	if (ret) {
> +		dev_err(dev, "Failed to get secvio state\n");
> +		return ret;
> +	}
> +
> +	/* Call chain of CB registered to this module if status detected */
> +	if (info.hpsvs || info.lps || info.lptds)
> +		if (imx_secvio_sc_notifier_call_chain(&info))
> +			dev_warn(dev,
> +				 "Issues when calling the notifier chain\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(imx_secvio_sc_check_state);
> +

NAK, no users.

> +static int imx_secvio_sc_disable_irq(struct device *dev)
> +{
> +	int ret;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	/* Disable the IRQ */
> +	ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECVIO,
> +				       false);
> +	if (ret) {
> +		dev_err(dev, "Cannot disable SCU IRQ: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx_secvio_sc_enable_irq(struct device *dev)
> +{
> +	int ret = 0, err;
> +	u32 irq_status;
> +	struct imx_secvio_sc_data *data;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	data = dev_get_drvdata(dev);
> +
> +	/* Enable the IRQ */
> +	ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECVIO,
> +				       true);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SCU IRQ: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	/* Enable interrupt */
> +	ret = imx_sc_seco_secvio_enable(data->ipc_handle);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SNVS irq: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	/* Unmask interrupt */
> +	ret = imx_scu_irq_get_status(IMX_SC_IRQ_GROUP_WAKE, &irq_status);
> +	if (ret) {
> +		dev_err(dev, "Cannot unmask irq: %d\n", ret);
> +		goto exit;
> +	}
> +
> +exit:
> +	if (ret) {
> +		err = imx_secvio_sc_disable_irq(dev);
> +		if (err)
> +			dev_warn(dev, "Failed to disable the IRQ\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx_secvio_sc_notify(struct notifier_block *nb,
> +				unsigned long event, void *group)
> +{
> +	struct imx_secvio_sc_data *data =
> +				container_of(nb, struct imx_secvio_sc_data,
> +					     irq_nb);
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	/* Filter event for us */
> +	if (!((event & IMX_SC_IRQ_SECVIO) &&
> +	      (*(u8 *)group == IMX_SC_IRQ_GROUP_WAKE)))
> +		return 0;
> +
> +	dev_warn(dev, "secvio security violation detected\n");
> +
> +	ret = imx_secvio_sc_check_state(dev);
> +
> +	/* Re-enable interrupt */
> +	ret = imx_secvio_sc_enable_irq(dev);
> +	if (ret)
> +		dev_err(dev, "Failed to enable IRQ\n");
> +
> +	return ret;
> +}
> +
> +int imx_secvio_sc_clear_state(struct device *dev, u32 hpsvs, u32 lps, u32 lptds)
> +{
> +	int ret;
> +	struct imx_secvio_sc_data *data;
> +
> +	dev = imx_secvio_sc_dev;
> +	if (!dev)
> +		return -EINVAL;
> +
> +	data = dev_get_drvdata(dev);
> +
> +	ret = imx_sc_seco_secvio_config(data->ipc_handle, HPSVS_ID, SECVIO_CONFIG_WRITE,
> +					&hpsvs, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		dev_err(dev, "Fail to clear secvio status: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPS_ID, SECVIO_CONFIG_WRITE,
> +					&lps, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		dev_err(dev, "Fail to clear tamper 1 status: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPTDS_ID, SECVIO_CONFIG_WRITE,
> +					&lptds, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		dev_err(dev, "Fail to clear tamper 2 status: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(imx_secvio_sc_clear_state);

So again export appears after several static functions? Organize your
driver in readable style.

However that's anyway a NAK, no users.

> +
> +static int report_to_user_notify(struct notifier_block *nb,
> +				 unsigned long status, void *notif_info)
> +{
> +	struct secvio_sc_notifier_info *info = notif_info;
> +	struct imx_secvio_sc_data *data =
> +				container_of(nb, struct imx_secvio_sc_data,
> +					     report_nb);
> +	struct device *dev = data->dev;
> +
> +	/* Information about the security violation */
> +	if (info->hpsvs & HPSVS_LP_SEC_VIO_MASK)
> +		dev_info(dev, "SNVS secvio: LPSV\n");
> +	if (info->hpsvs & HPSVS_SW_LPSV_MASK)
> +		dev_info(dev, "SNVS secvio: SW LPSV\n");
> +	if (info->hpsvs & HPSVS_SW_FSV_MASK)
> +		dev_info(dev, "SNVS secvio: SW FSV\n");
> +	if (info->hpsvs & HPSVS_SW_SV_MASK)
> +		dev_info(dev, "SNVS secvio: SW SV\n");
> +	if (info->hpsvs & HPSVS_SV5_MASK)
> +		dev_info(dev, "SNVS secvio: SV 5\n");
> +	if (info->hpsvs & HPSVS_SV4_MASK)
> +		dev_info(dev, "SNVS secvio: SV 4\n");
> +	if (info->hpsvs & HPSVS_SV3_MASK)
> +		dev_info(dev, "SNVS secvio: SV 3\n");
> +	if (info->hpsvs & HPSVS_SV2_MASK)
> +		dev_info(dev, "SNVS secvio: SV 2\n");
> +	if (info->hpsvs & HPSVS_SV1_MASK)
> +		dev_info(dev, "SNVS secvio: SV 1\n");
> +	if (info->hpsvs & HPSVS_SV0_MASK)
> +		dev_info(dev, "SNVS secvio: SV 0\n");
> +
> +	/* Information about the tampers */
> +	if (info->lps & LPS_ESVD_MASK)
> +		dev_info(dev, "SNVS tamper: External SV\n");
> +	if (info->lps & LPS_ET2D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 2\n");
> +	if (info->lps & LPS_ET1D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 1\n");
> +	if (info->lps & LPS_WMT2D_MASK)
> +		dev_info(dev, "SNVS tamper: Wire Mesh 2\n");
> +	if (info->lps & LPS_WMT1D_MASK)
> +		dev_info(dev, "SNVS tamper: Wire Mesh 1\n");
> +	if (info->lps & LPS_VTD_MASK)
> +		dev_info(dev, "SNVS tamper: Voltage\n");
> +	if (info->lps & LPS_TTD_MASK)
> +		dev_info(dev, "SNVS tamper: Temperature\n");
> +	if (info->lps & LPS_CTD_MASK)
> +		dev_info(dev, "SNVS tamper: Clock\n");
> +	if (info->lps & LPS_PGD_MASK)
> +		dev_info(dev, "SNVS tamper: Power Glitch\n");
> +	if (info->lps & LPS_MCR_MASK)
> +		dev_info(dev, "SNVS tamper: Monotonic Counter rollover\n");
> +	if (info->lps & LPS_SRTCR_MASK)
> +		dev_info(dev, "SNVS tamper: Secure RTC rollover\n");
> +	if (info->lps & LPS_LPTA_MASK)
> +		dev_info(dev, "SNVS tamper: Time alarm\n");
> +
> +	if (info->lptds & LPTDS_ET10D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 10\n");
> +	if (info->lptds & LPTDS_ET9D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 9\n");
> +	if (info->lptds & LPTDS_ET8D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 8\n");
> +	if (info->lptds & LPTDS_ET7D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 7\n");
> +	if (info->lptds & LPTDS_ET6D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 6\n");
> +	if (info->lptds & LPTDS_ET5D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 5\n");
> +	if (info->lptds & LPTDS_ET4D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 4\n");
> +	if (info->lptds & LPTDS_ET3D_MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 3\n");
> +
> +	return 0;
> +}
> +
> +static void if_imx_secvio_sc_disable_irq(void *dev)
> +{
> +	imx_secvio_sc_disable_irq(dev);
> +}
> +
> +static int imx_secvio_sc_open(struct inode *node, struct file *filp)
> +{
> +	filp->private_data = node->i_private;
> +
> +	return 0;
> +}
> +
> +static long imx_secvio_sc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct device *dev = file->private_data;
> +	struct secvio_sc_notifier_info info;
> +	int ret;
> +
> +	switch (cmd) {
> +	case IMX_SECVIO_SC_GET_STATE:
> +		ret = imx_secvio_sc_get_state(dev, &info);
> +		if (ret)
> +			return ret;
> +
> +		ret = copy_to_user((void __user *)arg, &info, sizeof(info));
> +		if (ret) {
> +			dev_err(dev, "Fail to copy info to user\n");
> +			return -EFAULT;
> +		}
> +		break;
> +	case IMX_SECVIO_SC_CHECK_STATE:
> +		ret = imx_secvio_sc_check_state(dev);
> +		if (ret)
> +			return ret;
> +		break;
> +	case IMX_SECVIO_SC_CLEAR_STATE:
> +		ret = copy_from_user(&info, (void __user *)arg, sizeof(info));
> +		if (ret) {
> +			dev_err(dev, "Fail to copy info from user\n");
> +			return -EFAULT;
> +		}
> +
> +		ret = imx_secvio_sc_clear_state(dev, info.hpsvs, info.lps,
> +						    info.lptds);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		ret = -ENOIOCTLCMD;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations imx_secvio_sc_fops = {
> +	.owner = THIS_MODULE,
> +	.open = imx_secvio_sc_open,
> +	.unlocked_ioctl = imx_secvio_sc_ioctl,
> +};
> +
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
> +int imx_scu_secvio_init(struct device *np)
> +{
> +	int ret;
> +
> +	scdev = np;
> +
> +	pdev = platform_device_alloc("imx-secvio-sc", -1);
> +	if (!pdev) {
> +		pr_err("%s: secvio: Failed to allocate secvio device\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	ret = platform_device_add(pdev);
> +	if (ret != 0) {
> +		pr_err("%s: secvio: Failed to add secvio device\n", __func__);
> +		platform_device_put(pdev);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&imx_secvio_sc_driver);
> +	if (ret != 0) {
> +		pr_err("%s: secvio: Failed to register secvio driver\n", __func__);
> +		platform_device_unregister(pdev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(imx_scu_secvio_init);

1. GPL
2. Init is always at the end which avoids your forward declarations

> +
> +static int imx_secvio_sc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx_secvio_sc_data *data;
> +	u32 seco_version = 0;
> +	bool own_secvio;
> +	u32 irq_status;
> +	int ret;
> +
> +	/* Allocate private data */
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	data->dev = dev;
> +
> +	dev_set_drvdata(dev, data);
> +
> +	data->nvmem = devm_nvmem_device_get(scdev, NULL);
> +	if (IS_ERR(data->nvmem)) {
> +		ret = PTR_ERR(data->nvmem);
> +
> +		if (ret != -EPROBE_DEFER)
> +			dev_err_probe(dev, ret, "Failed to retrieve nvmem\n");

Do not open-code dev_err_probe. Syntax is:
ret = dev_err_probe()


> +
> +		goto clean;
> +	}
> +
> +	/* Get a handle */
> +	ret = imx_scu_get_handle(&data->ipc_handle);
> +	if (ret) {
> +		dev_err(dev, "cannot get handle to scu: %d\n", ret);

dev_err_probe. Open the function and analyze whether it can defer
(although one would argue that even if it cannot defer you are supposed
to use dev_err_probe()).

> +		goto clean;
> +	}
> +
> +	/* Check the version of the SECO */
> +	ret = imx_sc_seco_build_info(data->ipc_handle, &seco_version, NULL);
> +	if (ret) {
> +		dev_err(dev, "Failed to get seco version\n");
> +		goto clean;
> +	}
> +
> +	if ((seco_version & SECO_VERSION_MINOR_MASK) <
> +	     SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER) {
> +		dev_err(dev, "SECO version %.8x doesn't support all secvio\n",
> +			seco_version);
> +		ret = -EOPNOTSUPP;
> +		goto clean;
> +	}
> +
> +	/* Init debug FS */
> +	ret = imx_secvio_sc_debugfs(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set debugfs\n");

debugfs errors are never a probe failure.

> +		goto clean;
> +	}
> +
> +	/* Check we own the SECVIO */
> +	ret = imx_sc_rm_is_resource_owned(data->ipc_handle, IMX_SC_R_SECVIO);
> +	if (ret < 0) {

This is not posible. Read the doc: 0 or 1.

> +		dev_err(dev, "Failed to retrieve secvio ownership\n");
> +		goto clean;
> +	}
> +
> +	own_secvio = ret > 0;
> +	if (!own_secvio) {
> +		dev_err(dev, "Secvio resource is not owned\n");
> +		ret = -EPERM;
> +		goto clean;
> +	}

Best regards,
Krzysztof


