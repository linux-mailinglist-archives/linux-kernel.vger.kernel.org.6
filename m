Return-Path: <linux-kernel+bounces-443918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4B9EFD83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC6188F7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45AB1AC891;
	Thu, 12 Dec 2024 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtoNMoUa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B6189B91
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035560; cv=none; b=KyxWYCLhCnKXnM4okW5KhMczekbk5IhL0KGdj8d5jyGnXQPAzHvscjYL80lDNw5XCNzTEUeWn2QSrU7vxU84UTgDDWY06UkSm++yNDilliIBdPyIztAaP6psjBZKXcLDs6t1gd7U89iVKwwj7dmGtLDcODJZrSlww87OOy/ryiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035560; c=relaxed/simple;
	bh=zmKqzO7vG03D6QzsbdumPnCLN49gq8PRJKyrZFDsyO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLZeG7VnyeSEAMPndNhr9CHYVmgKtYq+wyHTzTds+P6FMdhcQbJwCdbmPnwLDNzKy8Mp86F2GJeGslOJ3x89HDcxXNt7PVmzipX7C94nbqiYnzzmONCAowVu7/zK84cjHSfKDSE28M3pr2y2mGMl7GwhYDCeUAgT9924Ad8Ik2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtoNMoUa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC9kZxi030094
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MhBLGRTjN+wy+d9lgDLUbymMJJz+nFkVV7ekVI51mL4=; b=jtoNMoUaiNjMXr+8
	JAx1x8nP8xlfzgrz7BDhzouCHivEXGVA+dhjtaWRPAqVlo4qL1Gozj7JYrvtr9qM
	MkCb3X0t1gkQXIIIix64LY8mD4s5Y4hh4uzq2GeTJ3ySuaw8RWyPUUBX58rdtvCS
	z6gP6jUkeJUFMvMv3Qe+fo8HlZt3dl618ypqUucl6/epwG/MpQxzpeeYa8YFdhrM
	99mbvSvdf9bJE9V/t6IIF/R9RYZptYta5iXmbC5ZZ9xOASghHJ1h0Hb3fy0Z0pxi
	2hIMQW1h0oad+Q4y2X3ihhtj9QwF7uiIu4bn4VLYPziGLFhqWnJRlPIqH8pUK4v7
	AAouSA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fwgehp15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:32:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6f134dac1so8461385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035556; x=1734640356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhBLGRTjN+wy+d9lgDLUbymMJJz+nFkVV7ekVI51mL4=;
        b=DwqdMIz8kLiPP4YjDkRbh7rPQWfQytGVX7LSneACeE23zGKHCiVShNp8j/enTQS00S
         CE/K821+RlIfwDAdnkp9QTUdviOedXH2+IPepJqxe8oHzjzL/+L4VsAKuy62TUl7+2jN
         LngQtvinmea3Ciky5e9O5b1dMHWYKCinMj6D2rKh3KZUo4CGNPl16ozwSQlciSpNldRb
         OzFFdV3kT7laRvzl9uObcwQfMG9odP85qFlt6H3wd3I7a/CjZeAxRjS3ead9xWRGFy/X
         o9ZVA6hzDNEMxfggWjGkjuBJ5xWxB3QLvMRnMnxbFtLw1WJZUlM01cqXWEvs7f5r4BPY
         v7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXwXu5jA3a1LLkpshWllkJI7Xu8PWedWvYRXxL/psuROGz8KZoC0iZUn7bfwHADCOMmPae14LC9+4RnkUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbOed4i6kojbNHGsgqhVDiNcjSpE+0jfs4xLGJht/poEcpEFq
	pnj31YX/Y8C/Pm+kbZvTvlRCSREY1U/4+dNB7Cyq97HqppZGkWrdaEGtY7gfdEkHh6xNtKfhb81
	XCdM2IHB0142hjNRkXBwzlCZ8qCfuK6vog1EAohAJvFQQv5xMDsehE4gQMS3qWDo=
X-Gm-Gg: ASbGncsrny3gbAhQ3SiL7D80c519lFQJ+xIWReMx+rKZ38mELtRk41NuPX73GXXQYDy
	NJ4Ml2zlHUmlZI7cZIMU7TUcymQsUH9KUZBR+gQLQNYiU2fTJJ3otT9retdFd1uVEa3A4tnilK/
	KvRNRXwGN8YmnsfQt1iZkRfDoe8BabKHw9jeTPhMoFK2mBr8OVNt5EQ3aj4tu9ugdZyv+HiMgw7
	p74MOe6f6j1BaF+3WxFdRb9w4diyfky89YXlqjI4pTueeJ/+MEzN1nRO07EJh5lipMWpwl3dsj8
	DDHD04AGZzhyRtcRtQej+BRrocoqqZpa4FukhQ==
X-Received: by 2002:a05:620a:3905:b0:7a9:bc9b:b27 with SMTP id af79cd13be357-7b6f890562emr83307485a.6.1734035556565;
        Thu, 12 Dec 2024 12:32:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZopsOLk6/XkFBqZnV98IPFq5LepZFprenEt5dRRro0F9YUmKjZgKugYy/6AwCP6/weI3sBA==
X-Received: by 2002:a05:620a:3905:b0:7a9:bc9b:b27 with SMTP id af79cd13be357-7b6f890562emr83304785a.6.1734035556157;
        Thu, 12 Dec 2024 12:32:36 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c798fc7sm10620346a12.62.2024.12.12.12.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:32:34 -0800 (PST)
Message-ID: <31264e68-2cdc-41b2-8d84-459dc257f0f5@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 21:32:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] drm/msm: adreno: enable GMU bandwidth for A740 and
 A750
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
 <20241211-topic-sm8x50-gpu-bw-vote-v5-5-6112f9f785ec@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-topic-sm8x50-gpu-bw-vote-v5-5-6112f9f785ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uSaIKHKCUI5Ek90Ri6O2We_lt9iVD1n7
X-Proofpoint-ORIG-GUID: uSaIKHKCUI5Ek90Ri6O2We_lt9iVD1n7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120149

On 11.12.2024 9:29 AM, Neil Armstrong wrote:
> Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
> is in place, declare the Bus Control Modules (BCMs) and the
> corresponding parameters in the GPU info struct.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..edffb7737a97b268bb2986d557969e651988a344 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1388,6 +1388,17 @@ static const struct adreno_info a7xx_gpus[] = {
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
>  			.gmu_chipid = 0x7020100,
>  			.gmu_cgc_mode = 0x00020202,
> +			.bcms = (const struct a6xx_bcm[]) {
> +				{ .name = "SH0", .buswidth = 16 },

All a7xx targets use the same BCMs with the only difference being
the ACV voting mask. You may want to make these non-anonymous structs.

> +				{ .name = "MC0", .buswidth = 4 },
> +				{
> +					.name = "ACV",
> +					.fixed = true,
> +					.perfmode = BIT(3),
> +					.perfmode_bw = 16500000,

I think perfmode is simply supposed to be set when bw == max_bw

Konrad

