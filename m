Return-Path: <linux-kernel+bounces-573357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB51A6D633
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBD3188C2A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008EC25D1F4;
	Mon, 24 Mar 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n+mLmWs2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4B2D7BF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805204; cv=none; b=uyR+lqkWuBDoAk4fzimdBoDqh3azcihfLXDHOchoyQ9XcdMCkod4irm4Z0NHeMcteJ7477an7XKo9MLyd7mQPi4wDo6f2rjwZjHdC03+a3vHF46UGmhzqOe0YhB1803SAe2lxRnRqOQXPRGTglO/ZLdWIWypTgBROMMDRTlTYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805204; c=relaxed/simple;
	bh=J0914xrTvYhlZXj1qFNUIPm6eY20IWJ16iyHPhSNL0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OSuZ5mjHVAovmrJ85tDIGkeO1ns3wG7kU/tDLedTcKBzL8YvFwpd5D5Mewzp8Bob3IVuuBJv99jj8F6rpTKsoxNGQtYd2kCd6TydTsWz+sZwnwK2AIWsiAxTIDgSLpmWVFqF0MUv9z2XHVTQ5NeuX5yOQ+qA4URsge/vDSAufSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n+mLmWs2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O8Nj4C026040;
	Mon, 24 Mar 2025 08:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	03RkiECeKuSK/c4fl3HO/2FpG3Hf6ANNqQpuPdb8wIM=; b=n+mLmWs2Kyoq7lzv
	/tUN6EcHjC6Cq0uNoPdEobE3rrOtGZlaArgpwMNvQV/GKPj11WSO1W4k8RYFuUJd
	OPvTPe/sJrW6irXUO8QQPbGvlTbHqkNrU/7hr+Bhg9UcH02uitRhepEIgSmmCIsr
	fnv3jD/x6HrUnh+0giczEIOjb7CmS8bDcktNZap2Cb33HiOqw6Sa1f04EMZu7+ZU
	JI/LBt+KXnt7m/TGl/8+tU9/4ASwA8K7Ay0+LuRlZbASqVDWRi/z05Grbntyf+c+
	+kRZAeHS2dDoa5X3P79+/HQ6zCkuxoQ+7g+mJ4JmHsghXAmWkm969jgh4epENGwV
	XCR05A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjwhksw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 08:33:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52O8XHEm015114
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 08:33:17 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Mar
 2025 01:33:16 -0700
Message-ID: <0e2060ec-f0ed-41dc-8325-0ec839a59dd5@quicinc.com>
Date: Mon, 24 Mar 2025 16:33:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: extend dma mask to 36 bits
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Stephan Gerhold <stephan.gerhold@linaro.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20250321162331.19507-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250321162331.19507-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=H+jbw/Yi c=1 sm=1 tr=0 ts=67e118ce cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=iWmvWweA6ERdS6TH5IQA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: q-Xaf01VWEQjKjs6s5u-OagJKtpT2SLD
X-Proofpoint-ORIG-GUID: q-Xaf01VWEQjKjs6s5u-OagJKtpT2SLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240061



On 3/22/2025 12:23 AM, Johan Hovold wrote:
> Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
> without an iommu (under OS control) similar to what was done for ath11k
> in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
> DMA").
> 
> This specifically avoids using bounce buffers on Qualcomm Snapdragon X
> Elite machines like the Lenovo ThinkPad T14s when running at EL1.
> 
> Note that the mask could possibly be extended further but unresolved DMA
> issues with 64 GiB X Elite machines currently prevents that from being
> tested.
> 
> Also note that the driver is limited to 32 bits for coherent
> allocations and that there is no need to check for errors when setting
> masks larger than 32 bits.
> 
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath12k/mhi.c |  2 +-
>  drivers/net/wireless/ath/ath12k/pci.c | 12 ++++--------
>  drivers/net/wireless/ath/ath12k/pci.h |  1 +
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
> index 2f6d14382ed7..9c929c4ad8a8 100644
> --- a/drivers/net/wireless/ath/ath12k/mhi.c
> +++ b/drivers/net/wireless/ath/ath12k/mhi.c
> @@ -379,7 +379,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
>  		mhi_ctrl->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
>  
>  	mhi_ctrl->iova_start = 0;
> -	mhi_ctrl->iova_stop = 0xffffffff;
> +	mhi_ctrl->iova_stop = ab_pci->dma_mask;
>  	mhi_ctrl->sbl_size = SZ_512K;
>  	mhi_ctrl->seg_len = SZ_512K;
>  	mhi_ctrl->fbc_download = true;
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 06cff3849ab8..e77c50fc48ca 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -17,7 +17,7 @@
>  #include "debug.h"
>  
>  #define ATH12K_PCI_BAR_NUM		0
> -#define ATH12K_PCI_DMA_MASK		32
> +#define ATH12K_PCI_DMA_MASK		36
>  
>  #define ATH12K_PCI_IRQ_CE0_OFFSET		3
>  
> @@ -874,13 +874,9 @@ static int ath12k_pci_claim(struct ath12k_pci *ab_pci, struct pci_dev *pdev)
>  		goto disable_device;
>  	}
>  
> -	ret = dma_set_mask_and_coherent(&pdev->dev,
> -					DMA_BIT_MASK(ATH12K_PCI_DMA_MASK));
> -	if (ret) {
> -		ath12k_err(ab, "failed to set pci dma mask to %d: %d\n",
> -			   ATH12K_PCI_DMA_MASK, ret);
> -		goto release_region;
> -	}
> +	ab_pci->dma_mask = DMA_BIT_MASK(ATH12K_PCI_DMA_MASK);
> +	dma_set_mask(&pdev->dev, ab_pci->dma_mask);
> +	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>  
>  	pci_set_master(pdev);
>  
> diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
> index 31584a7ad80e..9e89b64b3545 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.h
> +++ b/drivers/net/wireless/ath/ath12k/pci.h
> @@ -116,6 +116,7 @@ struct ath12k_pci {
>  	unsigned long irq_flags;
>  	const struct ath12k_pci_ops *pci_ops;
>  	u32 qmi_instance;
> +	u64 dma_mask;
>  };
>  
>  static inline struct ath12k_pci *ath12k_pci_priv(struct ath12k_base *ab)

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>

With WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3 this is working, so:

Tested-by: Baochen Qiang <quic_bqiang@quicinc.com>



