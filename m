Return-Path: <linux-kernel+bounces-230061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F089177F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDA41F22A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5A4140E34;
	Wed, 26 Jun 2024 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QpVxPWum"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9422089;
	Wed, 26 Jun 2024 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378964; cv=none; b=rj/uHApq2mYe8/7OXpi9N/320uz6g344dCxT4GjwpIvKk7cPQ2pu4a/MgA/RVNHxs771L9x8TcBBanARqCrkLdftz2RYqbCyzmiCtQejkPw6hyiu9Oc6x5MSh+J+voLQi+N1v0kMPt7fwMdbySdr/IV7nPcAllXIG5jEa/oZuWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378964; c=relaxed/simple;
	bh=4AsFFJaLigvJRLisQB4Y8xT/h2Zm9d01tBPjfPxCX2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bAKPexsg81SnwvLhnUrYao0QD83THwWuN0BAjhse7NKqVMFMBNiqIBR/sqaR5lG5UmPENDAYlxBxU14xBNC9xhphnVYoQiq5V5yonXBObkhHwNyPZArZDgiKdwtK9sNgqD6Q7s1qIlvp76MpPmfurGJNu7Q5gWxsiu4wI6E4TAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QpVxPWum; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PHiafG009016;
	Wed, 26 Jun 2024 05:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NwTtCl3iJT3YitwFW8p6dlka2tHgHpGQkCLhbInxWTk=; b=QpVxPWumFllrEba5
	J63sQKI0Ckj8s1X8i5XaPhdYpOTUaN5qE14LOu3v6MNhPSwBZ0njKirkwEd9tib5
	M3kyfkbC1/ZDxvCIG+kaxrGjWDFabLeMJoE1dNEn3EtSpxi8M3Hv/yml0580TELM
	rsH2m7RVEb17ACqKPYtueOK+bkNnXyveuei9KWXYV1bp+M5RkLBM8jmIPXG9a4oF
	t+r/OECUQiGka0AR+dTct6+/4s97mWIYtu0TC9woqvKfLQMsAeMw0t2J5euEvkMG
	oFt4fAtiW/5QrqOcVhc5tErygYUz81WBugVJ8L+nwXrkhwTwRIRj2odaIe0BTVN8
	l5r0lA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqcegjk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 05:15:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q5FN3J014103
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 05:15:23 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 22:15:22 -0700
Message-ID: <4d1276a3-ef4a-4c84-8d09-d1613f311a28@quicinc.com>
Date: Tue, 25 Jun 2024 22:15:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple
	<alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-fsi@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <kernel-janitors@vger.kernel.org>
References: <20240605-md-drivers-fsi-v1-1-fefc82d81b12@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240605-md-drivers-fsi-v1-1-fefc82d81b12@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5tURQ12dorLWZ9yS2q27DoMKcY5u3HyZ
X-Proofpoint-ORIG-GUID: 5tURQ12dorLWZ9yS2q27DoMKcY5u3HyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260039

On 6/5/2024 3:39 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro, and fix the
> copy/paste of the module description comment in fsi-master-ast-cf.c.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/fsi/fsi-core.c          | 1 +
>  drivers/fsi/fsi-master-aspeed.c | 1 +
>  drivers/fsi/fsi-master-ast-cf.c | 3 ++-
>  drivers/fsi/fsi-master-gpio.c   | 1 +
>  drivers/fsi/fsi-master-hub.c    | 1 +
>  drivers/fsi/fsi-scom.c          | 1 +
>  6 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 097d5a780264..716a924269ee 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1444,5 +1444,6 @@ static void fsi_exit(void)
>  }
>  module_exit(fsi_exit);
>  module_param(discard_errors, int, 0664);
> +MODULE_DESCRIPTION("FSI core driver");
>  MODULE_LICENSE("GPL");
>  MODULE_PARM_DESC(discard_errors, "Don't invoke error handling on bus accesses");
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index f0a19cd451a0..b454587790a2 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -672,4 +672,5 @@ static struct platform_driver fsi_master_aspeed_driver = {
>  };
>  
>  module_platform_driver(fsi_master_aspeed_driver);
> +MODULE_DESCRIPTION("FSI master driver for AST2600");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> index 812dfa9a9140..85096559dda3 100644
> --- a/drivers/fsi/fsi-master-ast-cf.c
> +++ b/drivers/fsi/fsi-master-ast-cf.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  // Copyright 2018 IBM Corp
>  /*
> - * A FSI master controller, using a simple GPIO bit-banging interface
> + * A FSI master based on Aspeed ColdFire coprocessor
>   */
>  
>  #include <linux/crc4.h>
> @@ -1440,5 +1440,6 @@ static struct platform_driver fsi_master_acf = {
>  };
>  
>  module_platform_driver(fsi_master_acf);
> +MODULE_DESCRIPTION("A FSI master based on Aspeed ColdFire coprocessor");
>  MODULE_LICENSE("GPL");
>  MODULE_FIRMWARE(FW_FILE_NAME);
> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
> index ed03da4f2447..d32dcc98e85b 100644
> --- a/drivers/fsi/fsi-master-gpio.c
> +++ b/drivers/fsi/fsi-master-gpio.c
> @@ -894,4 +894,5 @@ static struct platform_driver fsi_master_gpio_driver = {
>  };
>  
>  module_platform_driver(fsi_master_gpio_driver);
> +MODULE_DESCRIPTION("A FSI master controller, using a simple GPIO bit-banging interface");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
> index 6d8b6e8854e5..6568fed7db3c 100644
> --- a/drivers/fsi/fsi-master-hub.c
> +++ b/drivers/fsi/fsi-master-hub.c
> @@ -295,4 +295,5 @@ static struct fsi_driver hub_master_driver = {
>  };
>  
>  module_fsi_driver(hub_master_driver);
> +MODULE_DESCRIPTION("FSI hub master driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index 61dbda9dbe2b..411ddc018cd8 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -625,4 +625,5 @@ static void scom_exit(void)
>  
>  module_init(scom_init);
>  module_exit(scom_exit);
> +MODULE_DESCRIPTION("SCOM FSI Client device driver");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
> change-id: 20240605-md-drivers-fsi-0a34d82a85da
> 
Following up to see if anything else is needed from me.
Hoping to see this in linux-next :)

/jeff

