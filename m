Return-Path: <linux-kernel+bounces-200728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F468FB43C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226B6B295C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E31474BE;
	Tue,  4 Jun 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QO9SgBOZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A82266A7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508417; cv=none; b=ZwuBbvahdzjjH8WLiowo1bugat1RfEAgMPvb8oH/0iV/YtYJl22yx2LOl4h4cB020DjzI6GFlkYgDlqtG6QUjjO1NbSMlgmJV+fJJeSGwtrlqLmMVPQZoVPrV+3kPt9sT6FJuThwll01ERCPTnHc2IRKVWGPWYe9cx/yjU/pvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508417; c=relaxed/simple;
	bh=b8AMxcqWw0P3jOh8p1hb7REjv+Kt3Ihe6OI8G/FSqrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MApXAToCCmF1Mrspg6fZ+WTdjcL8VZ3f4Y0DV8rr+6yLkhNN1eRUqOLS88R7tHOPAatIUg+HhkLGLSSb09rZdCLjd//zVwBqhjqSDSlveHiXoJg1lCr+b9RePJKTfCJzMvqStsxfxJmdjRXJirAe9AYRA0pOxz08jYqb+f1zSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QO9SgBOZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4548lMfs000933;
	Tue, 4 Jun 2024 13:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g3xKDmGEtE5NY3eQm4y/GHC7J2gBGR92nLzdqVWo5F0=; b=QO9SgBOZQWdcRV/2
	GmUNDR60B5JL/RFYPJmrnSZ4nPEq1iUBMaxI9Bq0yKMyflUmfUUyUFWyidBp+h2x
	1CyUul08o9lmPAYSxgMFKaGrcVIZsivPlO5mYS+sgcdOzBtsxn4kduJqPN7pqAsg
	PKndjQPXQx72PiUUpguB7tPOSoTVafAxQeqSKCeGpYm8BlP/+1kJXsCmT+JRt41Y
	F+Vm+hZmgDJRRZBY6qQ3Q40vBf1tVjBl9/wd7kWFxB/vjrx3m8MejoPYPdFTdjy3
	AbMFrt9CKXagNdbVTWMYbLc0Q/NaY8k1L3mYp5za7YUmH4uxb9alg+u3nL1pPRVr
	r+446A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5kq2s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 13:39:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 454DdosV012590
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 13:39:50 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 06:39:49 -0700
Message-ID: <bb8cf06e-4f96-4545-b459-3e70acb50f97@quicinc.com>
Date: Tue, 4 Jun 2024 06:39:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/22] ath10k: Use iommu_paging_domain_alloc()
Content-Language: en-US
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>,
        Daniel
 Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alex
 Williamson <alex.williamson@redhat.com>, <mst@redhat.com>,
        Jason Wang
	<jasowang@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan
 Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>, <iommu@lists.linux.dev>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <ath10k@lists.infradead.org>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-12-baolu.lu@linux.intel.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240604015134.164206-12-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Md4EIe9lNXys9JP7qqj6UgaTb6nNYv_z
X-Proofpoint-ORIG-GUID: Md4EIe9lNXys9JP7qqj6UgaTb6nNYv_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_05,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040109

+ath10k list for viibility

On 6/3/24 18:51, Lu Baolu wrote:
> An iommu domain is allocated in ath10k_fw_init() and is attached to
> ar_snoc->fw.dev in the same function. Use iommu_paging_domain_alloc() to
> make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/net/wireless/ath/ath10k/snoc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 8530550cf5df..0fe47d51013c 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1635,10 +1635,10 @@ static int ath10k_fw_init(struct ath10k *ar)
>   
>   	ar_snoc->fw.dev = &pdev->dev;
>   
> -	iommu_dom = iommu_domain_alloc(&platform_bus_type);
> -	if (!iommu_dom) {
> +	iommu_dom = iommu_paging_domain_alloc(ar_snoc->fw.dev);
> +	if (IS_ERR(iommu_dom)) {
>   		ath10k_err(ar, "failed to allocate iommu domain\n");
> -		ret = -ENOMEM;
> +		ret = PTR_ERR(iommu_dom);
>   		goto err_unregister;
>   	}
>   


