Return-Path: <linux-kernel+bounces-234776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DDD91CADB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E941F22941
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76351DA53;
	Sat, 29 Jun 2024 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dIqURR8L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25113C00;
	Sat, 29 Jun 2024 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719631384; cv=none; b=YhzdNEYeEiX6IfTqr+ovc0bF/J0muDcH7W+dA+u7wjj9qFU9TykK0T0fZnG/kJsqqE4gZ0XOO+CjRis+TdrSHQm28SH5T6Vi3Ids2lC1aAz/w4ha0S9vzpOkDY1loiMOHZ8VpnQjgYU49w8R3lfXs2pkQFSkC+dkLLtm6+Qi/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719631384; c=relaxed/simple;
	bh=2BIIZLTztWSUMprDPwnG+ewaMOfAIhw7uFwysotQG+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N8D6mN+o9TPux7KDnEw0GzvLJG6nNlKPcfEtD5vK73dyYx2weoK8Zy/HXZczerAO3wLvTfk9jMlDj90EbhVhAwcCZrDfTRHmG5JY2fdoTy0GX5VANnMEABwNFK5ts4HaVeoA4NtqVo//OZa5kE9aDkvB0HJd0rMDN2gM/x/rKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dIqURR8L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SF4OnO016181;
	Sat, 29 Jun 2024 03:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rdvNTXmLBA4POlwAKlHbcyjwinqAS4kw+r6b8MYe2jY=; b=dIqURR8LrQKUclIs
	E9i6XBgaTbcRuUAcycdrKWB2HqBjfk9CFbsfSoCrhTERim3s/K/btUvbZtnENkFu
	WvnNG74aeevuYqUjzgVVhSz+RV+VBWaqlpsT6ayIoCpDUPrsgsxXDHxx93ocvv5j
	IGCuPCD8Zz5ArVzwSh0WlyDZWnH3cLgR++Tg4gPLTRbstc5Z9Sdn1YFyz/8ZJuJu
	QWP5pxRBRMcFWOcYq18IZ+jL73nyzKopZUbrCuDQI9mMUwla6RM+gpwCxx+/Ijlx
	Jxb05KyHqpCoCy3up44ItxXvhDFASlOpozEP3cyGMvHWdFl/sVfTKo9p9Lo/oN+0
	yqCJdA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400gcmgsew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:22:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T3MwX9024642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:22:58 GMT
Received: from [10.48.245.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 20:22:57 -0700
Message-ID: <b5acb3dd-d7b5-492c-85a9-ee130e0a04c5@quicinc.com>
Date: Fri, 28 Jun 2024 20:22:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsr: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240615-md-powerpc-drivers-char-v1-1-bff22fd778a4@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240615-md-powerpc-drivers-char-v1-1-bff22fd778a4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wziDNxjag4e-tp14Ps1Z4IvIIvTOIhAJ
X-Proofpoint-ORIG-GUID: wziDNxjag4e-tp14Ps1Z4IvIIvTOIhAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290023

On 6/15/2024 2:14 PM, Jeff Johnson wrote:
> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/bsr.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/char/bsr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
> index 70d31aed9011..837109ef6766 100644
> --- a/drivers/char/bsr.c
> +++ b/drivers/char/bsr.c
> @@ -342,5 +342,6 @@ static void __exit  bsr_exit(void)
>  
>  module_init(bsr_init);
>  module_exit(bsr_exit);
> +MODULE_DESCRIPTION("IBM POWER Barrier Synchronization Register Driver");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Sonny Rao <sonnyrao@us.ibm.com>");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240615-md-powerpc-drivers-char-913942e3d586

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff

