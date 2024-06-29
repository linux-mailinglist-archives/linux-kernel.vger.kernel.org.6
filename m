Return-Path: <linux-kernel+bounces-234767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ADA91CAC3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6981C20E46
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37191D52D;
	Sat, 29 Jun 2024 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KOGlMLPt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D021CD16;
	Sat, 29 Jun 2024 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719630204; cv=none; b=KbeJc49zlgXrIAPr27GleUIFkLQsdr5Qz2EQ56ayykacP6IGlRR3zmKzxBhjVj/uiDGELLE6FGLx5BnW6DNAC2R1x0n0ao1NFZn4vR+UFCHUO1T+S49PXnnRNu2I1tTM9tnrAPVJmz2yJyjDktawVq0PBenlA23EhEVBLAoh7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719630204; c=relaxed/simple;
	bh=dD+SOF3f8jyzSd6qs8FvWFsqQsNqkFpWbzzF03BzEp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bmRxY91UEhOj0sJZb89P3AMwDvJ7CaNdSjyLrVhStuzxGRg3kSK5Mk9UkG91yRN4spL47ymxKqyuC7Oir47G0ea1/zw9n3wrKFjEkXiyEwO+DAAzRh+7aKhyw+JAyCokVZaGNbW9TjJCRrEQ+laDxAow174QUWt7YsfVxMqj+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KOGlMLPt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T2qkXO015852;
	Sat, 29 Jun 2024 03:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cxibv8OCb2KNg5lhWVi9oyX4cZYD++9pa7eKMUUSEQ4=; b=KOGlMLPtqKYNZ2CY
	MDiyPkqJnofjc66h9vGqfx4zUT0iq5CQtq+sngcB+KrjK9M75mqCIG7W3sNSUp/g
	gJBpaK2F50feWcQUT8DUq2Aj+5bbU/XjFhc+G5hG1TAkCPAAIx2s6kLK8VZDqrDT
	TZE2YpEBB6Zi07sYGHwi+CkgCB7DQ4E0a7ro/r1L9SwEZN9qMDbpGipKdZ6LrdBe
	XmrjgD7jqkLm5F99C7qFmiQhogkYoYfDwwVVa1SfP3Kk5jMYIZRqmn8+aIIBBMbG
	4IssojCYzorwL89f7EFtukjNeHde4qpy7Nx1VLbc+bJf2D21xR0x1bFjqjIzmSUo
	822gjw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029ux80ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:03:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T33IW0002728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:03:18 GMT
Received: from [10.48.245.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 20:03:18 -0700
Message-ID: <d92678cd-bd4d-4b3d-9faf-0987947adf4e@quicinc.com>
Date: Fri, 28 Jun 2024 20:03:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dca: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240615-dca-md-v2-1-c4062275a3f1@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240615-dca-md-v2-1-c4062275a3f1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pcIn7sb7lxr9pje3BqEDtd-mLMIdOOui
X-Proofpoint-ORIG-GUID: pcIn7sb7lxr9pje3BqEDtd-mLMIdOOui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290022

On 6/15/2024 2:44 PM, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dca/dca.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - Rebased to v6.10-rc3
> - Updated commit text to use a more recent boilerplate
> - Since there are no matching entries in MAINTAINERS, added Andrew & Greg
>   to see if this can go through one of their misc trees
> - Link to v1: https://lore.kernel.org/r/20240510-dca-md-v1-1-d532a0757090@quicinc.com
> ---
>  drivers/dca/dca-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dca/dca-core.c b/drivers/dca/dca-core.c
> index ed3dac546dd6..f5cedf816be1 100644
> --- a/drivers/dca/dca-core.c
> +++ b/drivers/dca/dca-core.c
> @@ -17,6 +17,7 @@
>  #define DCA_VERSION "1.12.1"
>  
>  MODULE_VERSION(DCA_VERSION);
> +MODULE_DESCRIPTION("Intel Direct Cache Access (DCA) service module");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Intel Corporation");
>  
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240510-dca-md-38482869c4d4

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff

