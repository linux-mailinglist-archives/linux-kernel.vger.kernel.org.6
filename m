Return-Path: <linux-kernel+bounces-255519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37409341B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F44D284902
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223D183060;
	Wed, 17 Jul 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eTFLvkvj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0411184F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238642; cv=none; b=Vg+29zjB+BmqOj238+yE+5lcNGvACdi2CmQsAyBwaHQtakujRkxVjNvhk0JfDJoHErWjfYE224ZC1BzxQ7ocCMd8+qmRFjeEJ3cDorh3AHJOGGZ8D3JhgEvEfWYK7yKGhwLaMOsti8jYXHMfKLJBtODOy6wnSXd7JZMtCugVHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238642; c=relaxed/simple;
	bh=C0trh+7PwObtuipUfDOh6Uu1gaixeqfmj0eWa4VKtro=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SWULyiHg+A9sBxmEXx9k7oMZ6dCBFRN5bNAzifjmTzGPP/f/bqg9En4RZd/NZEwiYI59UE3RYhQWfY3eWYFjVyKdiJyNzaRuIaTi4aXX4B2+jiYTtdFVGI4dHZw78Jhe72dPYfNu//dKzCZrO7A48+GgsjMmbIEebGbuWNQuXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eTFLvkvj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFOLwU031885;
	Wed, 17 Jul 2024 17:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wfIMLxJ5MgWBWIgIW7ll70R4YbGXXWDwD9MoyiP+Lrw=; b=eTFLvkvjARiG1dKL
	0ys6Sn/GbYaLyIJmsp4dLCHW9/g4XFVCAg4dfz8kQ9+yKJs04ZV+JxC+094NFZXP
	CF0Nf8E5pYprLM1Ox3MNzNDZNN8mhqEGwF0rfII49gMqfd4TarueyD/lMvgSANaB
	V8s2pPshN4Ew1AVUk89Ft2tNq5/BysFu9VukJoFqN8UoWpJ9iysgrn6sUYrSh+MH
	OLYWMIOB5pURYb67xJZIJfJUhiSxjJ6iw+PI/MLMbsNzsBzjsEAZcQV3umtCHdmb
	DiSu4dKlrj0T/d7XZLl/qc8lKmBb2J1mKvC7E2WWY3drXuwPyUaWTaVEQ73bIgYb
	RN9MUw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs39ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 17:50:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HHoRvN022996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 17:50:27 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 10:50:26 -0700
Message-ID: <9c13b91e-9efe-4a4f-b0bb-ac148d4f1af2@quicinc.com>
Date: Wed, 17 Jul 2024 10:50:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: Kconfig: exclude mrvl-cn10k-dpi compilation for
 32-bit systems
To: Vamsi Attunuru <vattunuru@marvell.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <nathan@kernel.org>
References: <20240717163739.181236-1-vattunuru@marvell.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240717163739.181236-1-vattunuru@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HIRgmlMmE7BmRwLMQvML0z6HSEbEB-DL
X-Proofpoint-GUID: HIRgmlMmE7BmRwLMQvML0z6HSEbEB-DL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170136

On 7/17/24 09:37, Vamsi Attunuru wrote:
> Upon adding CONFIG_ARCH_THUNDER & CONFIG_COMPILE_TEST dependency,
> compilation errors arise on 32-bit ARM with writeq() & readq() calls
> which are used for accessing 64-bit values.
> 
> Since DPI hardware only works with 64-bit register accesses, using
> CONFIG_64BIT dependency to skip compilation on 32-bit systems.
> 
> Fixes: a5e43e2d202d ("misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI")
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/misc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f3bb75384627..41c3d2821a78 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -588,7 +588,7 @@ config NSM
>   config MARVELL_CN10K_DPI
>   	tristate "Octeon CN10K DPI driver"
>   	depends on PCI
> -	depends on ARCH_THUNDER || COMPILE_TEST
> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
>   	help
>   	  Enables Octeon CN10K DMA packet interface (DPI) driver which
>   	  intializes DPI hardware's physical function (PF) device's


BTW it looks like you accidentally submitted Makefile.rej, can you 
submit a patch to remove it?


commit 5f67eef6dff39421215e9134f1eaae51b67a73b7
Author: Vamsi Attunuru <vattunuru@marvell.com>
Date:   Sat Jul 6 08:30:09 2024 -0700

     misc: mrvl-cn10k-dpi: add Octeon CN10K DPI administrative driver

...

diff --git a/drivers/misc/Makefile.rej b/drivers/misc/Makefile.rej
new file mode 100644
index 000000000000..a6aaed13f950
--- /dev/null
+++ b/drivers/misc/Makefile.rej
@@ -0,0 +1,7 @@
+--- drivers/misc/Makefile
++++ drivers/misc/Makefile
+@@ -69,3 +69,4 @@ obj-$(CONFIG_TMR_INJECT)     += xilinx_tmr_inject.o
+ obj-$(CONFIG_TPS6594_ESM)     += tps6594-esm.o
+ obj-$(CONFIG_TPS6594_PFSM)    += tps6594-pfsm.o
+ obj-$(CONFIG_NSM)             += nsm.o
++obj-$(CONFIG_MARVELL_CN10K_DPI)       += mrvl_cn10k_dpi.o



