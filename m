Return-Path: <linux-kernel+bounces-243660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 107629298EC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BF41F21235
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8DA46B9A;
	Sun,  7 Jul 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cekFhC/v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CF45BF1;
	Sun,  7 Jul 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371192; cv=none; b=kWHkBVxJ7Y/YXRfinvhwoOFRNypWevN0mZxBaWAqUt04vSygqtvDvoowvOxke63rmjeGfth/thxjbZjrmbVI9Ay7imfYlVr31tNr7B8si3fU4gTb6FIstTZe2GeCJDYdTydxxH7kY/empU7KVsQIiMRKm9z1fhbyzId0MngNjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371192; c=relaxed/simple;
	bh=2IKyrz3lV/ozGiB/EdqVZn7z1n9P7pUoZICa9cZ4nHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QQXzgitiJ7P637VaKVInj5ZTqnu2piawMkL40/ekHuf0BAxeR93mho+cXiqNw1ikWC/pb2tC3rl3GuHvGzel2gd5T1RCpFPslWx2ElKyrb0TBA+heivrK7PVlr7bimmpxpdsXZ+Ld1x1ld1flc9LQHKxuB3b4S6a9v/ywV7ESNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cekFhC/v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467GT1Kl013865;
	Sun, 7 Jul 2024 16:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e9EaMzpKAxd2c4Ujn4yveoWVf1uCjZl8Yp+uYaXx32I=; b=cekFhC/vSy7Hrruz
	gupNA0M9BjKyFP4JvsxLZz6JXzfbdU7OZXP29CIJNJ4qYGmlVQJZ/FwUm3I2rw3w
	iKfOpTG4qRR7gSeHi+Pxk2EQGjfIR/X91JAAb2cmNLU2aid/yoh8FcUCO5wsWdci
	WWGkydefktSqM9CU70t6O1iwqBK43+6/NEJmXMvFadCWwieVyXZ55gQXxwyU1oq/
	a68ydiuS1trwpkfrp8k6t+YmeDR+teekwdDiszeNbUBHOvEun/nBMSrA1VyH7Nv6
	XejcmoHnsvb3yx+VuSR6Y1x8gxQmZMY21apyWWJHN+WzfQIYo+V80DVUPSQMilHl
	Q6azew==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we8t021-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 16:52:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 467GqnYg021027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Jul 2024 16:52:49 GMT
Received: from [10.110.78.14] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 7 Jul 2024
 09:52:49 -0700
Message-ID: <ffb76411-7119-4024-acaa-3cf40f81ed95@quicinc.com>
Date: Sun, 7 Jul 2024 09:52:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] firmware: arm_scmi: Make SMC transport a standalone
 driver
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>
CC: <sudeep.holla@arm.com>, <james.quinlan@broadcom.com>,
        <f.fainelli@gmail.com>, <vincent.guittot@linaro.org>,
        <etienne.carriere@foss.st.com>, <peng.fan@oss.nxp.com>,
        <michal.simek@amd.com>, <quic_sibis@quicinc.com>, <ptosi@google.com>,
        <dan.carpenter@linaro.org>, <souvik.chakravarty@arm.com>,
        Peng Fan
	<peng.fan@nxp.com>
References: <20240707002055.1835121-1-cristian.marussi@arm.com>
 <20240707002055.1835121-6-cristian.marussi@arm.com>
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20240707002055.1835121-6-cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4tO_GI-ZQ2IhImuEXT5bJKDzlKD3JLq4
X-Proofpoint-ORIG-GUID: 4tO_GI-ZQ2IhImuEXT5bJKDzlKD3JLq4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070138


On 7/6/2024 5:20 PM, Cristian Marussi wrote:
> Make SCMI SMC transport a standalone driver that can be optionally
> loaded as a module.
>
> CC: Peng Fan <peng.fan@nxp.com>
> CC: Nikunj Kela <quic_nkela@quicinc.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/Kconfig             |  4 ++-
>  drivers/firmware/arm_scmi/Makefile            |  2 +-
>  drivers/firmware/arm_scmi/common.h            |  3 --
>  drivers/firmware/arm_scmi/driver.c            |  5 ---
>  .../arm_scmi/{smc.c => scmi_transport_smc.c}  | 31 +++++++++++++++----
>  5 files changed, 29 insertions(+), 16 deletions(-)
>  rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (89%)
>
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index 135e34aefd70..a4d44ef8bf45 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -102,7 +102,7 @@ config ARM_SCMI_TRANSPORT_OPTEE
>  	  transport based on OP-TEE SCMI service, answer Y.
>  
>  config ARM_SCMI_TRANSPORT_SMC
> -	bool "SCMI transport based on SMC"
> +	tristate "SCMI transport based on SMC"
>  	depends on HAVE_ARM_SMCCC_DISCOVERY
>  	select ARM_SCMI_HAVE_TRANSPORT
>  	select ARM_SCMI_HAVE_SHMEM
> @@ -112,6 +112,8 @@ config ARM_SCMI_TRANSPORT_SMC
>  
>  	  If you want the ARM SCMI PROTOCOL stack to include support for a
>  	  transport based on SMC, answer Y.
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called scmi_transport_smc.
>  
>  config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
>  	bool "Enable atomic mode support for SCMI SMC transport"
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index 121612d75f0b..6868a47fa4ab 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -5,7 +5,6 @@ scmi-core-objs := $(scmi-bus-y)
>  scmi-driver-y = driver.o notify.o
>  scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
> -scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
> @@ -13,6 +12,7 @@ scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o vol
>  scmi-protocols-y += pinctrl.o
>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
> +obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += scmi_transport_smc.o
>  obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index c03f30db92e0..b5bd27eccf24 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -286,9 +286,6 @@ int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
>  int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
>  					    struct scmi_xfer *xfer,
>  					    unsigned int timeout_ms);
> -#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
> -extern const struct scmi_desc scmi_smc_desc;
> -#endif
>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>  extern const struct scmi_desc scmi_virtio_desc;
>  #endif
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 96cf8ab4421e..b14c5326930a 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3254,11 +3254,6 @@ static const struct of_device_id scmi_of_match[] = {
>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
>  	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
>  #endif
> -#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
> -	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
> -	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
> -	{ .compatible = "qcom,scmi-smc", .data = &scmi_smc_desc},
> -#endif
>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>  	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
>  #endif
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> similarity index 89%
> rename from drivers/firmware/arm_scmi/smc.c
> rename to drivers/firmware/arm_scmi/scmi_transport_smc.c
> index cb26b8aee01d..44da1a8d5387 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> @@ -3,7 +3,7 @@
>   * System Control and Management Interface (SCMI) Message SMC/HVC
>   * Transport driver
>   *
> - * Copyright 2020 NXP
> + * Copyright 2020-2024 NXP
>   */
>  
>  #include <linux/arm-smccc.h>
> @@ -16,6 +16,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/limits.h>
> +#include <linux/platform_device.h>
>  #include <linux/processor.h>
>  #include <linux/slab.h>
>  
> @@ -69,12 +70,14 @@ struct scmi_smc {
>  	unsigned long cap_id;
>  };
>  
> +static struct scmi_transport_core_operations *core;
> +
>  static irqreturn_t smc_msg_done_isr(int irq, void *data)
>  {
>  	struct scmi_smc *scmi_info = data;
>  
> -	scmi_rx_callback(scmi_info->cinfo,
> -			 scmi_shmem_ops.read_header(scmi_info->shmem), NULL);
> +	core->rx_callback(scmi_info->cinfo,
> +			  core->shmem->read_header(scmi_info->shmem), NULL);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -142,7 +145,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	if (!scmi_info)
>  		return -ENOMEM;
>  
> -	scmi_info->shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, tx);
> +	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx);
>  	if (IS_ERR(scmi_info->shmem))
>  		return PTR_ERR(scmi_info->shmem);
>  
> @@ -226,7 +229,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>  	 */
>  	smc_channel_lock_acquire(scmi_info, xfer);
>  
> -	scmi_shmem_ops.tx_prepare(scmi_info->shmem, xfer, cinfo);
> +	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
>  
>  	if (scmi_info->cap_id != ULONG_MAX)
>  		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
> @@ -250,7 +253,7 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_smc *scmi_info = cinfo->transport_info;
>  
> -	scmi_shmem_ops.fetch_response(scmi_info->shmem, xfer);
> +	core->shmem->fetch_response(scmi_info->shmem, xfer);
>  }
>  
>  static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> @@ -286,3 +289,19 @@ const struct scmi_desc scmi_smc_desc = {
>  	.sync_cmds_completed_on_ret = true,
>  	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
>  };
> +
> +static const struct of_device_id scmi_of_match[] = {
> +	{ .compatible = "arm,scmi-smc" },
> +	{ .compatible = "arm,scmi-smc-param" },
> +	{ .compatible = "qcom,scmi-smc" },
> +	{ /* Sentinel */ },
> +};
> +

Hi Cristian,

Would it make sense to associate scmi descriptor(scmi_smc_desc) with
compatible as driver/platform data so we have flexibility to replicate
it and modify parameters such as max_timeout_ms etc. for our platform?

Thanks,

-Nikunj

> +DEFINE_SCMI_TRANSPORT_DRIVER(scmi_smc, scmi_of_match, &core);
> +module_platform_driver(scmi_smc_driver);
> +
> +MODULE_ALIAS("scmi-transport-smc");
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_AUTHOR("Nikunj Kela <quic_nkela@quicinc.com>");
> +MODULE_DESCRIPTION("SCMI SMC Transport driver");
> +MODULE_LICENSE("GPL");

