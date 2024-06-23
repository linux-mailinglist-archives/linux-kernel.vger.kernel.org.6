Return-Path: <linux-kernel+bounces-226344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC931913D4D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9251D1F21012
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF341836CB;
	Sun, 23 Jun 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g76QPeSx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1F2F4A;
	Sun, 23 Jun 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719164093; cv=none; b=VHMxKsWYN1CyfjOjWh5tu1aD1XZECfr4P7y+ErXpONhVZD7lkQObxvTylczxYOJ6q5HZFHYubp4FBLWNmV1RoZgXJ9kButZgGvksvzKbEQDG8SmrE5VzL7J4ArqKKSqpJFU1f6URqr++IREFRGJ4Xsvws/VuNlH7Ns8OJp3lsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719164093; c=relaxed/simple;
	bh=daiWmQHmva4abPaxrUPfp4JwvhbCwiI3qiWRpeHba/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JjzUaqu/TbhxzHKYGVS6yrvXYP9P4gByNZdpuSJuJiYTfnzD3SZ+w6jVQudf097PPQBu+FalDMG1QvtzyY+tmNfrOHmPi8/JJyvVkn4RuocaPynIKg1kNS6kj1zjGlWVZPcbmOHSQCROiqqlJUfgiOSXacMSsFSkmOfy5Vj4CBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g76QPeSx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NGkBHg015427;
	Sun, 23 Jun 2024 17:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zKU9ywoNcxpBMhaAX+xKekSuYP1hqoq3T9d9ts7RhQI=; b=g76QPeSxhTDmsfyE
	HCvLDMhX4L1Ll4mnGlUoTL2SplxPd8kp0UQj5sP51hfkUBOKci2KNnaOAcRqNmKe
	N5qwQy7Xhwa5LuV2O33SRGRGQ5CCUEQemhk5wQLJF6XooIJJrXtEossRaApdSaj1
	JR86OwEf27bJMuCeX922uLjZm7e1M2PYOUUwEqv24TLeIsUl5h7ckA+NdK5tkyZz
	HWXI6nm5ygrRcTJoY5GaaJ+nmH9hIpN+OXv1iuW5iCNbdW3oTgd2H5aWk/E+8kN5
	EniwQk+VKeHUsPk3gb0SIEHebZnMrDSfn27u+/XX0Hd03xHjzIwUekO803XGwbDl
	qVVu3Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaet5ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 17:34:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45NHYSSE015212
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 17:34:28 GMT
Received: from [10.48.244.142] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 23 Jun
 2024 10:34:27 -0700
Message-ID: <f9badb23-dd3e-4cce-be42-5816616ccff7@quicinc.com>
Date: Sun, 23 Jun 2024 10:34:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: imx: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael
 Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix
 Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
CC: <linux-clk@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240602-md-clk-imx-v1-1-5c6d240f6fab@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240602-md-clk-imx-v1-1-5c6d240f6fab@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MQcsZrYUHb6JXdrVVHA38wPPsAH-kbYS
X-Proofpoint-GUID: MQcsZrYUHb6JXdrVVHA38wPPsAH-kbYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-23_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406230140

On 6/2/2024 8:59 AM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/mxc-clk.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/clk-imxrt1050.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/clk/imx/clk-imxrt1050.c | 1 +
>  drivers/clk/imx/clk.c           | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index 08d155feb035..efd1ac9d8eeb 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -176,6 +176,7 @@ static struct platform_driver imxrt1050_clk_driver = {
>  };
>  module_platform_driver(imxrt1050_clk_driver);
>  
> +MODULE_DESCRIPTION("NXP i.MX RT1050 clock driver");
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Jesse Taube <Mr.Bossman075@gmail.com>");
>  MODULE_AUTHOR("Giulio Benetti <giulio.benetti@benettiengineering.com>");
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index e35496af5ceb..df83bd939492 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -226,4 +226,5 @@ static int __init imx_clk_disable_uart(void)
>  late_initcall_sync(imx_clk_disable_uart);
>  #endif
>  
> +MODULE_DESCRIPTION("Common clock support for NXP i.MX SoC family");
>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
> change-id: 20240602-md-clk-imx-370fc1d85ab5
> 

Following up to see if anything else is needed from me.
Hoping to see this in linux-next :)

