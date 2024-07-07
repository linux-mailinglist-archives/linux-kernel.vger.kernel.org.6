Return-Path: <linux-kernel+bounces-243659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C019298E9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977951C20C94
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342223F8F1;
	Sun,  7 Jul 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FqveiMYT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6052BD1E;
	Sun,  7 Jul 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720370967; cv=none; b=eObI1XzjaLwsGE5Wcfj3w4gdGFlJesbzzk7gDgtE2F/y8EPuIpLcUL59I+aHVxgfj98Ph5HHEjMz1Ns/td5hWCxGLtuVHzkk1Tv8mnN1oQGRPHKCVyzUOzRfo7MpAx25YcDuZwX/xeUCtEXQdG2rr9dDQFFYRH6EYI/yFQRrgUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720370967; c=relaxed/simple;
	bh=innO6ZYCB6vw3mNrRy6IjhQq5ooTatB6z3hgzE8CBKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Can7F0HiUNk0kS7hdYaKeddB6hoF2qJeNqnQREVk6GptUcfgMqOS8Mr1tfrgCZW74YkV63dPPl9aPUGaeaWRznO0DNAZlVRa9QPZ6kPLn429hlQBP3CQUKpl0gosQ6zl4P1HWAI1pQ3ytfeAv1ZPxgf/KoD8ywhSjAk4p+p025M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FqveiMYT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467Drt3G006429;
	Sun, 7 Jul 2024 16:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ptiuYERgwl65UKJBdB9yYQRYeOdFbpA7k6oweic4CkM=; b=FqveiMYTR4/H+ub8
	MGUkha1F7yg1txLf8xO+IjllvjlBy90O1YqubzuiAeV1rp9X6ygnHXhCPKdgfA25
	C0GrECFHTLuNnWyTYj452FlJtzEXhYEleB6waF0fIDAji0kC9MG1C+UV0nRTBt9c
	XlQLNPnHhHZ6bYM+jiNuRtW61aPcd1LmXbpyNCkUHKgCbk4oZwTZKW9LWyeA6bkt
	0EZy8d+fDbgzt4rmdtVj0c0Uph5pWFM6P0AV9TA0GA9IPImjCFaeZr5ubRGjHdmO
	NLu/nNubKWUtBScVNp8MeshTHXArAJlct2KUDdp7IGeyu20scAaa1OC0mMSpxqFR
	nsH8bw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y3h9umh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 16:49:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 467GmxGO007804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Jul 2024 16:48:59 GMT
Received: from [10.110.78.14] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 7 Jul 2024
 09:48:59 -0700
Message-ID: <aac97774-29e2-453a-995e-287b62e3e836@quicinc.com>
Date: Sun, 7 Jul 2024 09:48:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] firmware: arm_scmi: Introduce setup_shmem_iomap
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
 <20240707002055.1835121-2-cristian.marussi@arm.com>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20240707002055.1835121-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 85e2Wu-mwL3cjTLTHF71DvnPV_fO9B2l
X-Proofpoint-GUID: 85e2Wu-mwL3cjTLTHF71DvnPV_fO9B2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070138


On 7/6/2024 5:20 PM, Cristian Marussi wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> To get the address of shmem could be generalized by introducing
> setup_shmem_iomap. Then the duplicated code in mailbox.c, optee.c
> and smc.c could be dropped.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> [ Cristian: make use of the new helper also in smc.c ]
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h  |  2 ++
>  drivers/firmware/arm_scmi/mailbox.c | 27 ++++------------------
>  drivers/firmware/arm_scmi/optee.c   | 35 ++++------------------------
>  drivers/firmware/arm_scmi/shmem.c   | 36 +++++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/smc.c     | 23 +++---------------
>  5 files changed, 49 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 4b8c5250cdb5..b4c217641e3a 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -327,6 +327,8 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
>  		     struct scmi_xfer *xfer);
>  bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
>  bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem);
> +void __iomem *setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev,
> +				bool tx);
>  
>  /* declarations for message passing transports */
>  struct scmi_msg_payld;
> diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
> index 0219a12e3209..b0a579f31905 100644
> --- a/drivers/firmware/arm_scmi/mailbox.c
> +++ b/drivers/firmware/arm_scmi/mailbox.c
> @@ -178,11 +178,8 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	const char *desc = tx ? "Tx" : "Rx";
>  	struct device *cdev = cinfo->dev;
>  	struct scmi_mailbox *smbox;
> -	struct device_node *shmem;
> -	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan, idx = tx ? 0 : 1;
> +	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan;
>  	struct mbox_client *cl;
> -	resource_size_t size;
> -	struct resource res;
>  
>  	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan, &p2a_rx_chan);
>  	if (ret)
> @@ -195,25 +192,9 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	if (!smbox)
>  		return -ENOMEM;
>  
> -	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
> -	if (!of_device_is_compatible(shmem, "arm,scmi-shmem")) {
> -		of_node_put(shmem);
> -		return -ENXIO;
> -	}
> -
> -	ret = of_address_to_resource(shmem, 0, &res);
> -	of_node_put(shmem);
> -	if (ret) {
> -		dev_err(cdev, "failed to get SCMI %s shared memory\n", desc);
> -		return ret;
> -	}
> -
> -	size = resource_size(&res);
> -	smbox->shmem = devm_ioremap(dev, res.start, size);
> -	if (!smbox->shmem) {
> -		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
> -		return -EADDRNOTAVAIL;
> -	}
> +	smbox->shmem = setup_shmem_iomap(cinfo, dev, tx);
> +	if (IS_ERR(smbox->shmem))
> +		return PTR_ERR(smbox->shmem);
>  
>  	cl = &smbox->cl;
>  	cl->dev = cdev;
> diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> index 4e7944b91e38..8abcd668108c 100644
> --- a/drivers/firmware/arm_scmi/optee.c
> +++ b/drivers/firmware/arm_scmi/optee.c
> @@ -368,38 +368,11 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
>  static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
>  			      struct scmi_optee_channel *channel)
>  {
> -	struct device_node *np;
> -	resource_size_t size;
> -	struct resource res;
> -	int ret;
> -
> -	np = of_parse_phandle(cinfo->dev->of_node, "shmem", 0);
> -	if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
> -		ret = -ENXIO;
> -		goto out;
> -	}
> -
> -	ret = of_address_to_resource(np, 0, &res);
> -	if (ret) {
> -		dev_err(dev, "Failed to get SCMI Tx shared memory\n");
> -		goto out;
> -	}
> -
> -	size = resource_size(&res);
> +	channel->req.shmem = setup_shmem_iomap(cinfo, dev, true);
> +	if (IS_ERR(channel->req.shmem))
> +		return PTR_ERR(channel->req.shmem);
>  
> -	channel->req.shmem = devm_ioremap(dev, res.start, size);
> -	if (!channel->req.shmem) {
> -		dev_err(dev, "Failed to ioremap SCMI Tx shared memory\n");
> -		ret = -EADDRNOTAVAIL;
> -		goto out;
> -	}
> -
> -	ret = 0;
> -
> -out:
> -	of_node_put(np);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
> diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
> index b74e5a740f2c..c31f188d74ef 100644
> --- a/drivers/firmware/arm_scmi/shmem.c
> +++ b/drivers/firmware/arm_scmi/shmem.c
> @@ -7,6 +7,8 @@
>  
>  #include <linux/ktime.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/processor.h>
>  #include <linux/types.h>
>  
> @@ -133,3 +135,37 @@ bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
>  {
>  	return ioread32(&shmem->flags) & SCMI_SHMEM_FLAG_INTR_ENABLED;
>  }
> +
> +void *__iomem
> +setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
> +{
> +	const char *desc = tx ? "Tx" : "Rx";
> +	int ret, idx = tx ? 0 : 1;
> +	struct device *cdev = cinfo->dev;
> +	struct device_node *shmem;
> +	resource_size_t size;
> +	struct resource res;
> +	void __iomem *addr;
> +
> +	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
> +	if (!of_device_is_compatible(shmem, "arm,scmi-shmem")) {
> +		of_node_put(shmem);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	ret = of_address_to_resource(shmem, 0, &res);
> +	of_node_put(shmem);
> +	if (ret) {
> +		dev_err(cdev, "failed to get SCMI %s shared memory\n", desc);
> +		return ERR_PTR(ret);
> +	}
> +
> +	size = resource_size(&res);
> +	addr = devm_ioremap(dev, res.start, size);
> +	if (!addr) {
> +		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
> +		return ERR_PTR(-EADDRNOTAVAIL);
> +	}
> +
> +	return addr;
> +}
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 39936e1dd30e..a640a4312472 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -132,7 +132,6 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	struct scmi_smc *scmi_info;
>  	resource_size_t size;
>  	struct resource res;
> -	struct device_node *np;
>  	u32 func_id;
>  	int ret;
>  
> @@ -143,25 +142,9 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	if (!scmi_info)
>  		return -ENOMEM;
>  
> -	np = of_parse_phandle(cdev->of_node, "shmem", 0);
> -	if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
> -		of_node_put(np);
> -		return -ENXIO;
> -	}
> -
> -	ret = of_address_to_resource(np, 0, &res);
> -	of_node_put(np);
> -	if (ret) {
> -		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
> -		return ret;
> -	}
> -
> -	size = resource_size(&res);

Hi Peng/Cristian,

This will break Qualcomm smc transport as we need shmem 'size' to get to
the cap-id. 

Thanks,

-Nikunj

> -	scmi_info->shmem = devm_ioremap(dev, res.start, size);
> -	if (!scmi_info->shmem) {
> -		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
> -		return -EADDRNOTAVAIL;
> -	}
> +	scmi_info->shmem = setup_shmem_iomap(cinfo, dev, tx);
> +	if (IS_ERR(scmi_info->shmem))
> +		return PTR_ERR(scmi_info->shmem);
>  
>  	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
>  	if (ret < 0)

