Return-Path: <linux-kernel+bounces-244531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED292A595
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195D41F216C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBC143749;
	Mon,  8 Jul 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xjw2E8Hd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A10613D2BB;
	Mon,  8 Jul 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452262; cv=none; b=rdEp+pMsN6q1iwPBjd/AGQtz/OMf4YWfyy6oeLuA0mEUnXCKMZc7Hg33MRX4STtTuB8/Ib03VICoCyWL6Elojl9W/JTJctibVPiJH0G00PN0O7vfgloUYNdjdI7QjxhVZ6YDxLjhn0ROPA3L0oBWlQpRby1HzBX7gHH3303xIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452262; c=relaxed/simple;
	bh=aTxdyphXWHVxaMy7/0qLS0bEkp9iE49l7hwDyJGReA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qUFZeg/fRBvVKZydj1VLem81ffZmhD3CzgYiTaUdRBnCvXAMTR54MOVEOHJHKvt3WGaEUJN8kn0brmShI0zIes1zAoR20VXOySt/399yo/nlarGIgfRVaPVh5DJiOHmYSFBcA32ewkSv4T4PRvTIQDCa6DapMsnQioBBa1ZZw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xjw2E8Hd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468BP6Zq029503;
	Mon, 8 Jul 2024 15:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jLDYIekIAq2lAwMjxe8BS5aDe2iDs7AXdQbUmzkv0FA=; b=Xjw2E8HdNrWpYuua
	Jce0VYD+6Pz/9kpey0tUhOOJE86i6BfCznI5CdTERac3eOb7aiHNrcBsgDmoiv2O
	FLX1nWFqMnXy854TqViIpDevdsmMN40Pkfnb3GjIVy+OAwYEaxpiEfoxKvtoge9U
	Zr6VKd47ww78TakJYzC27YYntT/LjNkRR9oKH5CS0Gwcm6E+ZY6nnQN51Gjeqo8o
	ZUlb6AvKOHbZ6hxFV9kVXRyhLoQn9hGuZ5t2JZMmygEDuS7837SW5wXkPIFZ1gzn
	zX2r1yIWdWpXOjWSl4r4/9ux9RTMuoMEcuF0pdADxmKeGhGTcHQwXansoH7/viXD
	pSjNlg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wg3v38q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 15:23:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468FNvBK026650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 15:23:57 GMT
Received: from [10.110.78.14] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 08:23:56 -0700
Message-ID: <273d23f5-c354-43cf-8903-d07f42778c3a@quicinc.com>
Date: Mon, 8 Jul 2024 08:23:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] firmware: arm_scmi: Make SMC transport a standalone
 driver
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>, <sudeep.holla@arm.com>,
        <james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
        <vincent.guittot@linaro.org>, <etienne.carriere@foss.st.com>,
        <peng.fan@oss.nxp.com>, <michal.simek@amd.com>,
        <quic_sibis@quicinc.com>, <ptosi@google.com>,
        <dan.carpenter@linaro.org>, <souvik.chakravarty@arm.com>,
        Peng Fan <peng.fan@nxp.com>
References: <20240707002055.1835121-1-cristian.marussi@arm.com>
 <20240707002055.1835121-6-cristian.marussi@arm.com>
 <ffb76411-7119-4024-acaa-3cf40f81ed95@quicinc.com> <Zov3VppLHotmIO3l@pluto>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <Zov3VppLHotmIO3l@pluto>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ApNGGp31EAlny-4HnxjhblGLycA74ZPx
X-Proofpoint-GUID: ApNGGp31EAlny-4HnxjhblGLycA74ZPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080114


On 7/8/2024 7:27 AM, Cristian Marussi wrote:
> On Sun, Jul 07, 2024 at 09:52:49AM -0700, Nikunj Kela wrote:
>> On 7/6/2024 5:20 PM, Cristian Marussi wrote:
>>> Make SCMI SMC transport a standalone driver that can be optionally
>>> loaded as a module.
>>>
>>> CC: Peng Fan <peng.fan@nxp.com>
>>> CC: Nikunj Kela <quic_nkela@quicinc.com>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>>>  drivers/firmware/arm_scmi/Kconfig             |  4 ++-
>>>  drivers/firmware/arm_scmi/Makefile            |  2 +-
>>>  drivers/firmware/arm_scmi/common.h            |  3 --
>>>  drivers/firmware/arm_scmi/driver.c            |  5 ---
>>>  .../arm_scmi/{smc.c => scmi_transport_smc.c}  | 31 +++++++++++++++----
>>>  5 files changed, 29 insertions(+), 16 deletions(-)
>>>  rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (89%)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
>>> index 135e34aefd70..a4d44ef8bf45 100644
>>> --- a/drivers/firmware/arm_scmi/Kconfig
>>> +++ b/drivers/firmware/arm_scmi/Kconfig
>>> @@ -102,7 +102,7 @@ config ARM_SCMI_TRANSPORT_OPTEE
>>>  	  transport based on OP-TEE SCMI service, answer Y.
>>>  
>>>  config ARM_SCMI_TRANSPORT_SMC
>>> -	bool "SCMI transport based on SMC"
>>> +	tristate "SCMI transport based on SMC"
>>>  	depends on HAVE_ARM_SMCCC_DISCOVERY
>>>  	select ARM_SCMI_HAVE_TRANSPORT
>>>  	select ARM_SCMI_HAVE_SHMEM
>>> @@ -112,6 +112,8 @@ config ARM_SCMI_TRANSPORT_SMC
>>>  
>>>  	  If you want the ARM SCMI PROTOCOL stack to include support for a
>>>  	  transport based on SMC, answer Y.
>>> +	  This driver can also be built as a module.  If so, the module
>>> +	  will be called scmi_transport_smc.
>>>  
>>>  config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
>>>  	bool "Enable atomic mode support for SCMI SMC transport"
>>> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
>>> index 121612d75f0b..6868a47fa4ab 100644
>>> --- a/drivers/firmware/arm_scmi/Makefile
>>> +++ b/drivers/firmware/arm_scmi/Makefile
>>> @@ -5,7 +5,6 @@ scmi-core-objs := $(scmi-bus-y)
>>>  scmi-driver-y = driver.o notify.o
>>>  scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
>>>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>>> -scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
>>>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>>>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>>>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
>>> @@ -13,6 +12,7 @@ scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o vol
>>>  scmi-protocols-y += pinctrl.o
>>>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>>>  
>>> +obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += scmi_transport_smc.o
>>>  obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
>>>  
>>>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
>>> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
>>> index c03f30db92e0..b5bd27eccf24 100644
>>> --- a/drivers/firmware/arm_scmi/common.h
>>> +++ b/drivers/firmware/arm_scmi/common.h
>>> @@ -286,9 +286,6 @@ int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
>>>  int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
>>>  					    struct scmi_xfer *xfer,
>>>  					    unsigned int timeout_ms);
>>> -#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
>>> -extern const struct scmi_desc scmi_smc_desc;
>>> -#endif
>>>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>>>  extern const struct scmi_desc scmi_virtio_desc;
>>>  #endif
>>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>>> index 96cf8ab4421e..b14c5326930a 100644
>>> --- a/drivers/firmware/arm_scmi/driver.c
>>> +++ b/drivers/firmware/arm_scmi/driver.c
>>> @@ -3254,11 +3254,6 @@ static const struct of_device_id scmi_of_match[] = {
>>>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
>>>  	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
>>>  #endif
>>> -#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
>>> -	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
>>> -	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
>>> -	{ .compatible = "qcom,scmi-smc", .data = &scmi_smc_desc},
>>> -#endif
>>>  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>>>  	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
>>>  #endif
>>> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
>>> similarity index 89%
>>> rename from drivers/firmware/arm_scmi/smc.c
>>> rename to drivers/firmware/arm_scmi/scmi_transport_smc.c
>>> index cb26b8aee01d..44da1a8d5387 100644
>>> --- a/drivers/firmware/arm_scmi/smc.c
>>> +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
>>> @@ -3,7 +3,7 @@
>>>   * System Control and Management Interface (SCMI) Message SMC/HVC
>>>   * Transport driver
>>>   *
>>> - * Copyright 2020 NXP
>>> + * Copyright 2020-2024 NXP
>>>   */
>>>  
>>>  #include <linux/arm-smccc.h>
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/of_address.h>
>>>  #include <linux/of_irq.h>
>>>  #include <linux/limits.h>
>>> +#include <linux/platform_device.h>
>>>  #include <linux/processor.h>
>>>  #include <linux/slab.h>
>>>  
>>> @@ -69,12 +70,14 @@ struct scmi_smc {
>>>  	unsigned long cap_id;
>>>  };
>>>  
>>> +static struct scmi_transport_core_operations *core;
>>> +
>>>  static irqreturn_t smc_msg_done_isr(int irq, void *data)
>>>  {
>>>  	struct scmi_smc *scmi_info = data;
>>>  
>>> -	scmi_rx_callback(scmi_info->cinfo,
>>> -			 scmi_shmem_ops.read_header(scmi_info->shmem), NULL);
>>> +	core->rx_callback(scmi_info->cinfo,
>>> +			  core->shmem->read_header(scmi_info->shmem), NULL);
>>>  
>>>  	return IRQ_HANDLED;
>>>  }
>>> @@ -142,7 +145,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>>>  	if (!scmi_info)
>>>  		return -ENOMEM;
>>>  
>>> -	scmi_info->shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, tx);
>>> +	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx);
>>>  	if (IS_ERR(scmi_info->shmem))
>>>  		return PTR_ERR(scmi_info->shmem);
>>>  
>>> @@ -226,7 +229,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>>>  	 */
>>>  	smc_channel_lock_acquire(scmi_info, xfer);
>>>  
>>> -	scmi_shmem_ops.tx_prepare(scmi_info->shmem, xfer, cinfo);
>>> +	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
>>>  
>>>  	if (scmi_info->cap_id != ULONG_MAX)
>>>  		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
>>> @@ -250,7 +253,7 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
>>>  {
>>>  	struct scmi_smc *scmi_info = cinfo->transport_info;
>>>  
>>> -	scmi_shmem_ops.fetch_response(scmi_info->shmem, xfer);
>>> +	core->shmem->fetch_response(scmi_info->shmem, xfer);
>>>  }
>>>  
>>>  static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
>>> @@ -286,3 +289,19 @@ const struct scmi_desc scmi_smc_desc = {
>>>  	.sync_cmds_completed_on_ret = true,
>>>  	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
>>>  };
>>> +
>>> +static const struct of_device_id scmi_of_match[] = {
>>> +	{ .compatible = "arm,scmi-smc" },
>>> +	{ .compatible = "arm,scmi-smc-param" },
>>> +	{ .compatible = "qcom,scmi-smc" },
>>> +	{ /* Sentinel */ },
>>> +};
>>> +
>> Hi Cristian,
>>
> Hi Nikunj,
>
> thanks for having a look first of all !
>
>> Would it make sense to associate scmi descriptor(scmi_smc_desc) with
>> compatible as driver/platform data so we have flexibility to replicate
>> it and modify parameters such as max_timeout_ms etc. for our platform?
>>
> Mmmm...not sure to have understood, because the scmi_smc_desc is
> effecetively passed from this driver to the core via a bit of
> (questionable) magic in the mega-macro
>
> DEFINE_SCMI_TRANSPORT_DRIVER(scmi_smc, scmi_of_match, &core);
>
> ...and it will end-up being set into the dev.platform_data and then
> retrieved by the core SCMI stack driver in scmi_probe...
>
> ...OR...do you mean being able to somehow define 3 different
> scmi_smc_desc* and then associate them to the different compatibles
> and then, depending on which compatible is matched by this isame driver
> at probe time, passing the related platform-specific desc to the core...
>
> ...in this latter case I suppose I can do it by playing with the macros
> defs but maybe it is also the case to start thinking about splitting out
> configuration stuff from the transport descriptor...
>
> I'll give it a go at passing the data around, and see how it plays out
> if you confirm that this is what you meant...

Hi Cristian,

I wanted to send a patch for review(with older driver code) that will
allow us to override transport parameters(e.g. max_timeout_ms,
max_msg_size etc.) on Qualcomm platform. There could be multiple
approaches- 1) add callbacks (similar to get_msg_size) in transport_ops
and override the default or 2) replicate the descriptors for different
compatible and change those values as needed. I was going with the
second option but then I saw your patch and thought of throwing this at
you ;) I don't want you to hold your patch series for this but if you
have a better way to achieve or a preferred way between the two
mentioned before, please let me know. If you do want to add this feature
in this patch series, that would be great!

Thanks,

-Nikunj

>
> Thanks,
> Cristian

