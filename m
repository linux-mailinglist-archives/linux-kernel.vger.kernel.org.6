Return-Path: <linux-kernel+bounces-372349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B709A4787
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615CD286A27
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C844205AD0;
	Fri, 18 Oct 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzXnKPLo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF118C345
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281644; cv=none; b=MsVXeomoFTjBmWJfsHH0qr5QW89vRGNeOOzeJwJwDxQkCyA3D+3NSbzMvE9kZyu5Cr937l/5MPkJ+clq6QYGeXJ5AleSQVngPIKwblTZFnYKbiWeFXJJ/NhBhrYmYqwa5irQ8/p9rlXoOgpBFZpyf5SFPJdRAceeDuejwdakV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281644; c=relaxed/simple;
	bh=big/RDgxfpSfVSQtJWLcewNoNAjp6aU5JtWSCscIjdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULGoJ0tlmkRFjxoMGH1USmJ9+9knqVjDSPHbMN8hIFVmP+s+EOk//Gq2qAYCbUYAslOyj/hvAsggRxhdr/Gb0F3lJXTTAyeHGYIaTBSe9+ifRI91iVlrMcRsqdG5S2be6BJl5Z2yBQb05fm8AFpK0drPJ5s2t2q4vcasJ4u5UfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzXnKPLo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IDuk0j029904
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0tGKOhQP9AnanB1aw/7BV3wpUi1rDbiQvMRXCGixeyo=; b=UzXnKPLoshLJjtBC
	YsSRPz+SOjzQjAFYx703qyUPHGm/QO6WBK342i+HQsdU7yzW8XfNAZnNpiGE1bZQ
	prQ+ARrfUOBRhYQj2JSPNkUMtmyWODbi/5Z9bXLHDJx/FSduZsvni4evbbMcAIcu
	3LEPmn+g6J3/izyYl8BNuCO7xXwWqydxAWWkfsTEpgXRdunPjzsPhxxzVyX/4Qcf
	D8RikVfnl+2cXj/pa+aK2PMYYD59ELcqZhVjCYo371YnG47dMKpcZtejjl7cEbi+
	9P0uj6LRBJ6OCytIFmYmuEbc52GCPuInYZReDJVVwlZ4FxU41Ssa3k8jdKO3sKll
	FICuqg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bs0mry9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:00:41 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84fbff85821so76850241.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281640; x=1729886440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tGKOhQP9AnanB1aw/7BV3wpUi1rDbiQvMRXCGixeyo=;
        b=FkJBGfHvsQ49A5E43qxHeriu45S39cDTgvKwo/sBQZC1JtBbEtehCuJCEMZ53/i+hW
         biXTQyV/ykew/nTGkHAYkfOE6/l0NJ/GRN3mxNwAmWSOoKm65hzHdB53Zhqc5irSPwbc
         SJv5yqvqJOPYJNxjxNlwKA2AQb4YDk5JJt2wEimeGZwuSCMQbK6aI44SZO2oYBAt4ZBz
         T/MeFiSUEWD72te7O6F64lGHADtB2ECURCZtKZWMcM1uvru3YVNvwd34Z+Tbf5NF7fhc
         uDhNdqGXp1ZoS4lyQHqV/VAvmHh+ztIXLRs0Zz2eN1lOIRbG6MrM/1gYOH+O4vfJa06b
         8VIw==
X-Forwarded-Encrypted: i=1; AJvYcCVaddIHMofzxAzV/auge+HNgNU9q/IR96ta/0Cl8C/52RcbDP0EDz4+kbhnviOJSQ2/OfDWiOjDZS7+Kf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTOQpxqUgJI5mj+m6O9rdV6yAo1YyIf1GB1O5lFpDVMW4Nv87
	o+Tr5hoi8ToKXt89yQi+w//6ladKgnrGydJ2lulxCiv2pzWw9bZ0hXg/CehNpvbTGwfPzybrkE5
	LhYu5nAlaaTKbTLGV9iz3Sbz2uhwzjLly7F1QjUqeUbKNvpXovUGQiwRmwUd19Vs=
X-Received: by 2002:a05:6102:2ad6:b0:4a4:91e1:9939 with SMTP id ada2fe7eead31-4a5d6bffee7mr1498637137.7.1729281640659;
        Fri, 18 Oct 2024 13:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSpLOvXy2ZJYFYCESLX3QZsA4k17+P+w4yaJ6g1/oZglutsaQiEYVFZTCLMNovcB+2umfTeg==
X-Received: by 2002:a05:6102:2ad6:b0:4a4:91e1:9939 with SMTP id ada2fe7eead31-4a5d6bffee7mr1498582137.7.1729281640242;
        Fri, 18 Oct 2024 13:00:40 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c271c3sm132517066b.193.2024.10.18.13.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 13:00:39 -0700 (PDT)
Message-ID: <4961d425-b660-4dac-8744-36d69993d1e1@oss.qualcomm.com>
Date: Fri, 18 Oct 2024 22:00:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/22] wifi: ath12k: avoid m3 firmware download in AHB
 device IPQ5332
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-10-quic_rajkbhag@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241015182637.955753-10-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SZjkZDCQpkR6yRZXR16ObsTtrt0TfP-3
X-Proofpoint-GUID: SZjkZDCQpkR6yRZXR16ObsTtrt0TfP-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180127

On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Current ath12k devices, QCN9274 and WCN7850, supports m3.bin firmware
> download through ath12k driver. The new ath12k AHB based device
> IPQ5332 supports m3 firmware download through remoteproc driver.
> 
> Hence, add new parameter (m3_fw_support) in ath12k_hw_params to avoid
> m3 firmware download in IPQ5332.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/hw.c  |  8 ++++++++
>  drivers/net/wireless/ath/ath12k/hw.h  |  2 ++
>  drivers/net/wireless/ath/ath12k/qmi.c | 28 ++++++++++++++++-----------
>  3 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
> index e5e2164c27d2..a4e0c21ac4b7 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -1299,6 +1299,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>  		.iova_mask = 0,
>  
>  		.supports_aspm = false,
> +
> +		.m3_fw_support = true,

'support for m3 firmware' is not a fitting term.. maybe "needs_m3_fw"?

Konrad

