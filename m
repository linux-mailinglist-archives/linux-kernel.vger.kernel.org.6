Return-Path: <linux-kernel+bounces-271760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FFF9452F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4344282526
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32816143897;
	Thu,  1 Aug 2024 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CzxBbPco"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0C1EB489;
	Thu,  1 Aug 2024 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537988; cv=none; b=fck1h1K1CQLQ7mpGEwRxD4mOotrrlXWmfowz3nDSi3XWktMrDZAaoUCZRtWytXtZVWu7PEfz7tyrMI0c3ldT+1Hfg1G9be1gzCEgkiik2HznS0KXCrqDE3MRfo7RPBq+Wzj6fdAqCdokqFVCKtsY+PmKBkkW6hjXTAk16tW95Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537988; c=relaxed/simple;
	bh=h55ZDndrVYZv/NBdtvXMW7U0TnI0qzfGkJYm36DIKVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CyGgwJYdwHGmU7RrTH09SJwHvQxucJhr9UK8NSMtxxXcNQdNooqkJ6P9d1VwfV8wSijtaY+c1gvyD59om6y7ilME1V5D0vyaXornu4VXI67uphPYORL/1VI8NQ2bKsQPXMYe/D5bnCc5NO4CMzLiY6/Mg183youjWI5UCWR/YKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CzxBbPco; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471Daape002870;
	Thu, 1 Aug 2024 18:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tihh+e/49TMpVKOyQ8UzRIYko0sxTzZC6LYMLbQXlNI=; b=CzxBbPco0G/uQ+TK
	lFBWF44Eai10LxDi33r1aVVLm4yji2BbgYnSr/5Obv2LTpFIuY/S7gmvLkAqVdWo
	Ety96fYEibex1fWO4UO6iO1NwVFtP6U0DebbFpfJrAZ69BrJ8pnZ9OldVxQAedbr
	7+hQSNydr4mbWvwEjkKv/VRy5k6B4ubb1aE3VwclyrOG0lCpPnlMDlMTXe+lmWJF
	7MIlOGFMM6eGuYlNDzh8UmMb2TlbRWgwWIniEocfyHE5vINBFcGUEUCzKlbdjkCP
	IOV/fG4y4G22lgbM3K/mTWNz5esDF1BlJ1dcdOmTCgKdBJaqmmrXQLeNY3C24Sej
	BknSXw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms43fxcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 18:46:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 471Ik42N017979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 18:46:04 GMT
Received: from [10.110.73.139] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 11:46:03 -0700
Message-ID: <04d0cf9a-dca8-4952-88fd-f7979a22602f@quicinc.com>
Date: Thu, 1 Aug 2024 11:46:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] firmware: arm_scmi: Make SMC transport a
 standalone driver
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>
CC: <sudeep.holla@arm.com>, <james.quinlan@broadcom.com>,
        <f.fainelli@gmail.com>, <vincent.guittot@linaro.org>,
        <etienne.carriere@st.com>, <peng.fan@oss.nxp.com>,
        <michal.simek@amd.com>, <quic_sibis@quicinc.com>, <ptosi@google.com>,
        <dan.carpenter@linaro.org>, <souvik.chakravarty@arm.com>,
        Peng Fan <peng.fan@nxp.com>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
 <20240730133318.1573765-7-cristian.marussi@arm.com>
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20240730133318.1573765-7-cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yfCj9enVeh-HR22aNmaTXZZc9flUxNaz
X-Proofpoint-ORIG-GUID: yfCj9enVeh-HR22aNmaTXZZc9flUxNaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_17,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010124


On 7/30/2024 6:33 AM, Cristian Marussi wrote:
> Make SCMI SMC transport a standalone driver that can be optionally
> loaded as a module.
>
> CC: Peng Fan <peng.fan@nxp.com>
> CC: Nikunj Kela <quic_nkela@quicinc.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Tested-by: Nikunj Kela <quic_nkela@quicinc.com>

Tested this series on Qualcomm SA8255p(to be upstreamed) platform that
uses Qualcomm SMC transport.

> v2 --> v3
> - fixed spacing in Kconfig and Copyright
> - use new params in DEFINE_SCMI_TRANSPORT_DRIVER
> v1 --> v2
> - make scmi_smc_desc static
> ---
>  drivers/firmware/arm_scmi/Kconfig             |  4 ++-
>  drivers/firmware/arm_scmi/Makefile            |  2 +-
>  drivers/firmware/arm_scmi/common.h            |  3 --
>  drivers/firmware/arm_scmi/driver.c            |  5 ---
>  .../arm_scmi/{smc.c => scmi_transport_smc.c}  | 32 +++++++++++++++----
>  5 files changed, 30 insertions(+), 16 deletions(-)
>  rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (88%)
>
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index f03875169215..f634c5af1912 100644
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
> +	  This driver can also be built as a module. If so, the module
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
> index abaf7ce6fbab..f44763bfec16 100644
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
> index 9d869ab2d003..c4d0195f0fdb 100644
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
> similarity index 88%
> rename from drivers/firmware/arm_scmi/smc.c
> rename to drivers/firmware/arm_scmi/scmi_transport_smc.c
> index 4cb86386c490..1c203a68acd4 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
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
> @@ -141,7 +144,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	if (!scmi_info)
>  		return -ENOMEM;
>  
> -	scmi_info->shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, tx, &res);
> +	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res);
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
> @@ -270,7 +273,7 @@ static const struct scmi_transport_ops scmi_smc_ops = {
>  	.fetch_response = smc_fetch_response,
>  };
>  
> -const struct scmi_desc scmi_smc_desc = {
> +static const struct scmi_desc scmi_smc_desc = {
>  	.ops = &scmi_smc_ops,
>  	.max_rx_timeout_ms = 30,
>  	.max_msg = 20,
> @@ -286,3 +289,20 @@ const struct scmi_desc scmi_smc_desc = {
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
> +DEFINE_SCMI_TRANSPORT_DRIVER(scmi_smc, scmi_smc_driver, scmi_smc_desc,
> +			     scmi_of_match, core);
> +module_platform_driver(scmi_smc_driver);
> +
> +MODULE_ALIAS("scmi-transport-smc");
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_AUTHOR("Nikunj Kela <quic_nkela@quicinc.com>");
> +MODULE_DESCRIPTION("SCMI SMC Transport driver");
> +MODULE_LICENSE("GPL");

