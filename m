Return-Path: <linux-kernel+bounces-231171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63305918718
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943341C21DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8418EFF0;
	Wed, 26 Jun 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H91h3+A6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8EA6E611;
	Wed, 26 Jun 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418546; cv=none; b=qRFvbfS4Ybf74rBAQHaWrurIYWV3bghYZMHLoisSegrFM7VoYLOO+sV6K1hiX7B1Lavx1PSaduV1RIa1sZXu5ezbFVAv14h6kehX/54XvfZfF6aGG8KkDUtthLacAF5Y5QRdLSPSzqw57B+G9nh2B4aQFHwlWB0Iv851KbVHIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418546; c=relaxed/simple;
	bh=DKxdDSfcP/Jw+UVMViix1inQgHj9ZmEoS+7gB+JkIj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bkD266A2bWHQDQF0X2GayE4nndbB1eF0PEXOWJXh5vVoEaKp83iKXPLv1CqH5nwBqFbzsLDwbQBP30S7iKax4Ts0bjKVtAnfpeDcIKk28BDu4bRlglXzWdHInHLuTRFiK0ab15oMFzoWIr4mTwXtm20tW4EGjiUU40K1RVQF2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H91h3+A6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfU36018120;
	Wed, 26 Jun 2024 16:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DUOeyAeujF2d7nlGIlBzso5zHd1i88E1meCDjrpN1e4=; b=H91h3+A6rfiBrKHm
	f52pENo06gWoOFo6ViORvT2mnv2hsYsn+umv7Vggmj0phQniOP3rHV5cY2jJmt0v
	uTXtxpNzFGdqqPNuMOnziA3Oc3hbxa7ND3yLCF2SCnBn31r6iN5DrJCKhbz60pxM
	aUF808hsV029x9r0xXpj++xsbpcJxOtFJZDsOZj0JJ4FMf010MkNhAhW+EIxTCXq
	O5/I52eZaizrxOVEBnrK7DfS+87/CboX3scb/c948F/BW6kkUVAwsBkgtKNfZNdD
	+ryrUPJet/oFfLjRQIWJk504ZB1G1jqETszqkW+MsJFE/HlaAD6RhELfHrhXcaBR
	FLEJKQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv9tu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:15:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QGFeDn027360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:15:40 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 09:15:40 -0700
Message-ID: <88ab18bd-0700-46c6-9d74-5bd79a1f0fc1@quicinc.com>
Date: Wed, 26 Jun 2024 09:15:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spmi: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd
	<sboyd@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XG5Nx2HVEwG0KAjIYBY2CovVXTFprXBr
X-Proofpoint-ORIG-GUID: XG5Nx2HVEwG0KAjIYBY2CovVXTFprXBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260119

On 6/9/2024 5:40 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-controller.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/spmi-pmic-arb.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/spmi/hisi-spmi-controller.c | 1 +
>  drivers/spmi/spmi-pmic-arb.c        | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
> index fa068b34b040..3cafdf22c909 100644
> --- a/drivers/spmi/hisi-spmi-controller.c
> +++ b/drivers/spmi/hisi-spmi-controller.c
> @@ -344,6 +344,7 @@ static void __exit spmi_controller_exit(void)
>  }
>  module_exit(spmi_controller_exit);
>  
> +MODULE_DESCRIPTION("Hisilicon 3670 SPMI Controller driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_VERSION("1.0");
>  MODULE_ALIAS("platform:spmi_controller");
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 791cdc160c51..f240fcc5a4e1 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -1891,5 +1891,6 @@ static struct platform_driver spmi_pmic_arb_driver = {
>  };
>  module_platform_driver(spmi_pmic_arb_driver);
>  
> +MODULE_DESCRIPTION("Qualcomm MSM SPMI Controller (PMIC Arbiter) driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:spmi_pmic_arb");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240609-md-drivers-spmi-51a13baa2301

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff


