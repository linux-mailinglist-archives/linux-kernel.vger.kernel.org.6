Return-Path: <linux-kernel+bounces-231220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB49187D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694C81C20C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509B718FDA7;
	Wed, 26 Jun 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rtl7T5vH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9218FC8B;
	Wed, 26 Jun 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420357; cv=none; b=XDesUNgXEEHMGX8D2CkJRWZNkuto/AqEXWEP+yjPN4/uXiAdJ26sLy8sLTN1CUZ8EesGF7dRVj3I2WsROccN34aiU3+JjJ0eNaJj27MDsxb31lYuAtVujY2q+rE4xyn6fY4qgUKPR6VAdMbEyEH8tGZZPS40b9QQhbGxS8wNqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420357; c=relaxed/simple;
	bh=Bs9vJpXDcIIrDVNNhhluvol44x76LKbhRs7LW1G5KdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T1MveaTqkP/rsbHHeQjMKIwGUTUqmpU0EK1zFGlhtC7ELrn3FEwAVcaxTcHaO31aXh0ZoO7syZpZXm11cW3CWyQroGmRmFlXJx46tW0r6mDjmYGsVkTmIA0ehb351+LZTgR9RTIMJYsCh/U4n3sz6MVmwF6lH3n5C2pyNmvk39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rtl7T5vH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfP7b015339;
	Wed, 26 Jun 2024 16:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nXT+VIQRF66ya1CgSTFCuI8yOpJzFj18D5aSjmsocEs=; b=Rtl7T5vHlY+rAr+8
	1D/3RkDBxCw3agjiZDsrY9C3QuvRWQnHqJNyiqZphjH1yUonsHwADFq6hQy30kfh
	jMMJxZdeDnkiygLPgCIwvNPWFHyTHmAGaPoQRoDexHJqcQwu93AWAnXM5ehej1F1
	NuOTsmXxu12hbiEot8vGVQrqaS2ebhA+9OkPM5/TE3v2mMb/1VQgtbhc/5DRq1IE
	jAZ8Y7/pkLu46teORcsWUpvWJpn5g9+6pl3ygMzlif+fpXQSOf+HHhWRSNmQPgdy
	2SJbsa/Plue5PPcQkhvurZItDmh6rExtuqsoJQJ8PFim4u3WXn58y/Rvxk66/ELn
	P8zNbg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400gcm93q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:45:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QGjhUU004980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:45:43 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 09:45:42 -0700
Message-ID: <b1868e2d-7181-4713-8db9-b4d8a29e3fe6@quicinc.com>
Date: Wed, 26 Jun 2024 09:45:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vDPA: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Zhu Lingshan <lingshan.zhu@intel.com>,
        "Michael S. Tsirkin"
	<mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240611-md-drivers-vdpa-v1-1-efaf2de15152@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240611-md-drivers-vdpa-v1-1-efaf2de15152@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jIQF7VIgf1vsRVBFcLziamNaYZDNV3Xr
X-Proofpoint-ORIG-GUID: jIQF7VIgf1vsRVBFcLziamNaYZDNV3Xr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260122

On 6/11/2024 12:22 PM, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/vdpa.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/ifcvf/ifcvf.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 1 +
>  drivers/vdpa/vdpa.c             | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 80d0a0460885..ccf64d7bbfaa 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -894,4 +894,5 @@ static struct pci_driver ifcvf_driver = {
>  
>  module_pci_driver(ifcvf_driver);
>  
> +MODULE_DESCRIPTION("Intel IFC VF NIC driver for virtio dataplane offloading");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8d391947eb8d..1ca445e31acb 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1538,4 +1538,5 @@ core_initcall(vdpa_init);
>  module_exit(vdpa_exit);
>  
>  MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
> +MODULE_DESCRIPTION("vDPA bus");
>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240611-md-drivers-vdpa-391206d17ec3
> 
Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff

